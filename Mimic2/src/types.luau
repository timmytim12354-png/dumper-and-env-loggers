export type State = {
	output: {string},
	registry: {[any]: string},
	typeHints: {[any]: string},
	indent: number,
	counter: number,
	addLine: (self: State, line: string) -> (),
	pad: (self: State) -> string,
	push: (self: State) -> (),
	pop: (self: State) -> (),
	freshVar: (self: State, prefix: string) -> string,
	register: (self: State, proxy: any, name: string, typeHint: string?) -> (),
	lookup: (self: State, proxy: any) -> string?,
	getTypeHint: (self: State, proxy: any) -> string?,
	getOutput: (self: State) -> string,
	reset: (self: State) -> (),
}

export type Codegen = {
	emitLine: (self: Codegen, line: string) -> (),
	declareLocal: (self: Codegen, name: string, expr: string) -> string,
	methodCall: (self: Codegen, parent: string, method: string, argStrs: {string}) -> string,
	funcCall: (self: Codegen, name: string, argStrs: {string}) -> string,
	assign: (self: Codegen, path: string, value: string) -> string,
	openBlock: (self: Codegen, header: string) -> (),
	closeBlock: (self: Codegen, footer: string?) -> (),
	comment: (self: Codegen, text: string) -> string,
	emitDeclareCall: (self: Codegen, prefix: string, parent: string, method: string, argStrs: {string}) -> string,
	emitBareCall: (self: Codegen, parent: string, method: string, argStrs: {string}) -> (),
}

export type Serialize = (value: any) -> string

export type CreateProxy = (name: string, isRoot: boolean?, typeHint: string?) -> any

export type Dispatch = (parent: string, method: string, rawArgs: {any}, argStrs: {string}) -> any

export type Handler = (parent: string, rawArgs: {any}, argStrs: {string}) -> any

export type HandlerMap = {[string]: Handler}

export type Context = {
	state: State,
	codegen: Codegen,
	serialize: Serialize,
	createProxy: CreateProxy,
}

return nil