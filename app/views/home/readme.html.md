MyGov Discovery API
===================

The MyGov Discovery API provides a service to discover related government content. Each page is assigned tags, which are used to find similarly tagged pages.

Pages
-----

### Retrieve a page by url:

`GET /pages/lookup.json?url=http://foo.gov`

Result:

```
{
   "id":9,
   "url":"http://foo.gov",
   "domain":{
      "hostname":"foo.gov",
      "hostname_hash":"421aa90e079fa326b6494f812ad13e79",
      "id":6
   },
   "path":"/",
   "tags":[
      {
         "id":23,
         "name":"web"
      },
      {
         "id":108,
         "name":"server"
      }
   ],
   "tag_list":"web, server",
   "title":"An example page",
   "related":[
      {
         "id":2,
         "url":"http://www.usa.gov/",
         "domain":{
            "hostname":"www.usa.gov",
            "hostname_hash":"ae77be06046330003e995de10534d79f",
            "id":2
         },
         "path":"/",
         "title":"USA.gov: The U.S. Government's Official Web Portal"
      },
      {
         "id":19,
         "url":"http://www.usa.gov/index.shtml",
         "domain":{
            "hostname":"www.usa.gov",
            "hostname_hash":"ae77be06046330003e995de10534d79f",
            "id":2
         },
         "path":"/index.shtml",
         "title":"USA.gov: The U.S. Government's Official Web Portal"
      }
   ]
}

```

### Retrieve a page by ID


`GET /pages/9.json`

```
{
   "id":9,
   "url":"http://foo.gov",
   "domain":{
      "hostname":"foo.gov",
      "hostname_hash":"421aa90e079fa326b6494f812ad13e79",
      "id":6
   },
   "path":"/",
   "tags":[
      {
         "id":23,
         "name":"web"
      },
      {
         "id":108,
         "name":"server"
      }
   ],
   "tag_list":"web, server",
   "title":"An example page",
   "related":[
      {
         "id":2,
         "url":"http://www.usa.gov/",
         "domain":{
            "hostname":"www.usa.gov",
            "hostname_hash":"ae77be06046330003e995de10534d79f",
            "id":2
         },
         "path":"/",
         "title":"USA.gov: The U.S. Government's Official Web Portal"
      },
      {
         "id":19,
         "url":"http://www.usa.gov/index.shtml",
         "domain":{
            "hostname":"www.usa.gov",
            "hostname_hash":"ae77be06046330003e995de10534d79f",
            "id":2
         },
         "path":"/index.shtml",
         "title":"USA.gov: The U.S. Government's Official Web Portal"
      }
   ]
}
```

### Update a page

`POST /pages/9.json`

Tags
----

Pages can also be retrieved by tags.

### Retrieve a page by tag name

`GET /tags/foo.json`

Response:

```
TODO
```
