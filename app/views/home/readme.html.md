MyGov Discovery API
===================

The MyGov Discovery API provides a service to discover related government content. Each page is assigned tags, which are used to find similarly tagged pages.

For more information including a live API query sandbox, see [apidocs.presidentialinnovationfellows.org/mygov-discovery](http://apidocs.presidentialinnovationfellows.org/mygov-discovery)

Pages
-----

### Retrieve a page by url:

`GET /pages?url=http://foo.gov`

Result:

```
{
   "id":9,
   "url":"http://foo.gov",
   "domain":{
      "hostname":"foo.gov",
      "hostname_hash":"d698d23550e89505e47299871d4e5f1d",
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

*Note: the number of related pages returned can be limited by passing `?related=N` where N is a number between 0 and 25. Defaults to 2.*

### Update a page

`POST /pages/9.json`

Tags
----

Pages can also be retrieved by tags.

### Retrieve pages by tag name

`GET /tags/foo.json`

Response:

```
[
   {
      "id":1,
      "url":"http://foo.gov/",
      "domain":{
         "hostname":"foo.gov",
         "hostname_hash":"d698d23550e89505e47299871d4e5f1d",
         "id":1
      },
      "path":"/",
      "tags":[
         {
            "id":1,
            "name":"foo"
         },
         {
            "id":2,
            "name":"bar"
         }
      ],
      "tag_list":"foo, bar",
      "title":null
   }
]
```

### Retrieve tags by query string

`GET /tags?q=fo`

Response:

```
[
   {
      "id":1,
      "url":"http://foo.gov/",
      "domain":{
         "hostname":"foo.gov",
         "hostname_hash":"d698d23550e89505e47299871d4e5f1d",
         "id":1
      },
      "path":"/",
      "tags":[
         {
            "id":1,
            "name":"foo"
         },
         {
            "id":2,
            "name":"bar"
         }
      ],
      "tag_list":"foo, bar",
      "title":null
   }
]
```

Domains
-------

### Retrieve domain by ID

`GET /domains/1`

Response:

```
{
    "hostname": "www.usa.gov",
    "hostname_hash": "ae77be06046330003e995de10534d79f",
    "id": 2,
    "pages": [
        {
            "id": 2,
            "url": "http://www.usa.gov/",
            "domain": {
                "hostname": "www.usa.gov",
                "hostname_hash": "ae77be06046330003e995de10534d79f",
                "id": 2
            },
            "path": "/",
            "title": "USA.gov: The U.S. Government's Official Web Portal",
            "avg_rating": "3.6",
            "num_rating": 5
        },
        {
            "id": 205,
            "url": "http://www.usa.gov/Contact.shtml",
            "domain": {
                "hostname": "www.usa.gov",
                "hostname_hash": "ae77be06046330003e995de10534d79f",
                "id": 2
            },
            "path": "/Contact.shtml",
            "title": "Contact Your Government | USA.gov",
            "avg_rating": null,
            "num_rating": 0
        }
        ...
    ]
}
```

### Lookup domains by reverse domain name

`GET /domains?q=gov.whitehouse.`


Response:

```
[
    {
        "hostname": "www.whitehouse.gov",
        "hostname_hash": "2bbabfeb3e5af2bd5f8fcd6f494e5482",
        "id": 3,
        "pages": [
            {
                "id": 3,
                "url": "http://www.whitehouse.gov/",
                "domain": {
                    "hostname": "www.whitehouse.gov",
                    "hostname_hash": "2bbabfeb3e5af2bd5f8fcd6f494e5482",
                    "id": 3
                },
                "path": "/",
                "title": "The White House - President Barack Obama",
                "avg_rating": "3.5",
                "num_rating": 4
            },
            {
                "id": 98,
                "url": "http://www.whitehouse.gov/live/president-obama-speaks-fiscal-cliff-0",
                "domain": {
                    "hostname": "www.whitehouse.gov",
                    "hostname_hash": "2bbabfeb3e5af2bd5f8fcd6f494e5482",
                    "id": 3
                },
                "path": "/live/president-obama-speaks-fiscal-cliff-0",
                "title": "Featured Videos",
                "avg_rating": null,
                "num_rating": 0
            },
            {
                "id": 101,
                "url": "http://www.whitehouse.gov/about/inside-white-house/west-wing-tour",
                "domain": {
                    "hostname": "www.whitehouse.gov",
                    "hostname_hash": "2bbabfeb3e5af2bd5f8fcd6f494e5482",
                    "id": 3
                },
                "path": "/about/inside-white-house/west-wing-tour",
                "title": "West Wing Tour",
                "avg_rating": null,
                "num_rating": 0
            }
            ...
        ]
    },
    {
        "hostname": "whitehouse.gov",
        "hostname_hash": "6e18908ffd4924525ee5e2a4ceb32803",
        "id": 96,
        "pages": [
            {
                "id": 210,
                "url": "http://whitehouse.gov/",
                "domain": {
                    "hostname": "whitehouse.gov",
                    "hostname_hash": "6e18908ffd4924525ee5e2a4ceb32803",
                    "id": 96
                },
                "path": "/",
                "title": "The White House - President Barack Obama",
                "avg_rating": null,
                "num_rating": 0
            }
        ]
    }
]
```

Format
------

All responses returned as JSON, with JSONP Support. Simply pass `?callback=foo` where `foo` is your desired callback.