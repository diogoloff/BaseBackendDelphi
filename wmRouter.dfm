object Router: TRouter
  OnCreate = WebModuleCreate
  Actions = <
    item
      Default = True
      Name = 'DefaultHandler'
      PathInfo = '/'
      OnAction = WebModule1DefaultHandlerAction
    end>
  BeforeDispatch = WebModuleBeforeDispatch
  Height = 333
  Width = 414
  object DSRESTWebDispatcher1: TDSRESTWebDispatcher
    WebDispatch.PathInfo = 'datasnap*'
    Left = 96
    Top = 75
  end
end
