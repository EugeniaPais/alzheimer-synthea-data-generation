
FROM eclipse-temurin:20-jdk

# add --insecure for a quick fix if your network requires certificates
# -L means follow redirects
RUN curl -L -O https://github.com/synthetichealth/synthea/releases/download/master-branch-latest/synthea-with-dependencies.jar
 
RUN printf '{\n\
  "name": "Generated Keep Module", \n\
  "states": { \n\
    "Initial": { \n\
      "type": "Initial", \n\
      "name": "Initial", \n\
      "conditional_transition": [ \n\
        { \n\
          "transition": "Keep", \n\
          "condition": { \n\
            "condition_type": "And", \n\
            "conditions": [ \n\
              { \n\
                "condition_type": "Active Condition", \n\
                "codes": [ \n\
                  { \n\
                    "system": "SNOMED-CT", \n\
                    "code": "26929004", \n\
                    "display": "Alzheimer'"'"'s disease (disorder)" \n\
                  } \n\
                ] \n\
              } \n\
            ] \n\
          } \n\
        }, \n\
        { \n\
          "transition": "Terminal" \n\
        } \n\
      ] \n\
    }, \n\
    "Terminal": { \n\
      "type": "Terminal", \n\
      "name": "Terminal" \n\
    }, \n\
    "Keep": { \n\
      "type": "Terminal", \n\
      "name": "Keep" \n\
    } \n\
  }, \n\
  "gmf_version": 2 \n\
} \n\
 ' > keep.json

CMD java -jar synthea-with-dependencies.jar -p 1000 -a 0-139 -k keep.json --exporter.csv.export=true
