{

  Action(id, params):: {
    WFWorkflowActionIdentifier: id,
    WFWorkflowActionParameters: params + {
      UUID: std.native("UUIDv5")()
    },
  },

  Param()

}
