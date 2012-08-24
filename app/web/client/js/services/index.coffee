
define ["app/server"], (server) ->
  (_, index) ->
 
    github = ({call, opts}, next) ->
      api = 
        url: "https://api.github.com/" + call
        data: opts
        dataType: 'jsonp'
      $.ajax(api).done ({data, meta}) -> next data

    index '#main'

    $ ->

      ## grab repos from github
      github
        call: 'orgs/wearefractal/repos'
        opts: { per_page: 100 }  
      , (repos) ->   
        async.map repos, (repo, next) ->
          github
            call: "repos/wearefractal/#{repo.name}/commits"
            opts: { per_page: 100 }
          , (commits) ->
            last = new Date( commits[commits.length-1]?.commit.committer.date ).getTime().toString()
            next null,
              name: repo.name
              size: commits?.length
              last: last
        , (err, repoGraph) ->
          console.log err if err?
          if repoGraph.length < 1 then console.log "err- empty repo result"
          console.log repoGraph.length

          ## graphing

          # Returns a flattened hierarchy containing all leaf nodes under the root.
          classes = (root) ->
            recurse = (name, node) ->
              if node.children
                node.children.forEach (child) ->
                  recurse node.name, child
              else
                classes.push
                  packageName: name
                  className: node.name
                  value: node.size

            classes = []
            recurse null, root
            children: classes

          r = 960
          format = d3.format(",d")
          fill = d3.scale.category20b()
          bubble = d3.layout.pack().sort(null).size([r, r]).padding(1.5)
          vis = d3.select("#chart").append("svg").attr("width", r).attr("height", r).attr("class", "bubble")      
          json = 
            name: 'fractal oss'
            children: [
              { name: '1', children: [] },
              { name: '2', children: [] },
              { name: '3', children: [] },
              { name: '4', children: [] },
              { name: '5', children: [] },
              { name: '6', children: [] },
              { name: '7', children: [] } ]

          for repo, x in repoGraph
            era = repo.last.charAt 3
            if json.children[era]?
              idx = era 
            else
              idx = 5
            json.children[idx]?.children.push repo

          #console.log json
          node = vis.selectAll("g.node").data(bubble.nodes(classes(json)).filter((d) ->
            not d.children
          )).enter().append("g").attr("class", "node").attr("transform", (d) ->
            "translate(" + d.x + "," + d.y + ")")
          
          node.append("title").text (d) ->
            d.className + ": " + format(d.value)
          node.append("circle").attr("r", (d) ->
            d.r
          ).style "fill", (d) ->
            fill d.packageName
          node.append("text").attr("text-anchor", "middle").attr("dy", ".3em").text (d) ->
            d.className.substring 0, d.r / 3
      