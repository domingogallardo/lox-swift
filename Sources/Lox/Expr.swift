protocol ExprVisitor {
    associatedtype ExprVisitorReturn

    func visitBinaryExpr(_ expr: Expr.Binary) -> ExprVisitorReturn
    func visitGroupingExpr(_ expr: Expr.Grouping) -> ExprVisitorReturn
    func visitLiteralExpr(_ expr: Expr.Literal) -> ExprVisitorReturn
    func visitUnaryExpr(_ expr: Expr.Unary) -> ExprVisitorReturn
}

class Expr {
    func accept<V: ExprVisitor, R>(visitor: V) -> R where R == V.ExprVisitorReturn {
        fatalError()
    }

    class Binary: Expr {
        let left: Expr
        let op: Token
        let right: Expr

        init(left: Expr, op: Token, right: Expr) {
            self.left = left
            self.op = op
            self.right = right
        }

        override func accept<V: ExprVisitor, R>(visitor: V) -> R where R == V.ExprVisitorReturn {
            return visitor.visitBinaryExpr(self)
        }
    }

    class Grouping: Expr {
        let expression: Expr

        init(expression: Expr) {
            self.expression = expression
        }

        override func accept<V, R>(visitor: V) -> R where V : ExprVisitor, R == V.ExprVisitorReturn {
            return visitor.visitGroupingExpr(self)
        }
    }

    class Literal: Expr {
        let value: Any?

        init(value: Any?) {
            self.value = value
        }

        override func accept<V, R>(visitor: V) -> R where V : ExprVisitor, R == V.ExprVisitorReturn {
            return visitor.visitLiteralExpr(self)
        }
    }

    class Unary: Expr {
        let op: Token
        let right: Expr

        init(op: Token, right: Expr) {
            self.op = op
            self.right = right
        }

        override func accept<V, R>(visitor: V) -> R where V : ExprVisitor, R == V.ExprVisitorReturn {
            return visitor.visitUnaryExpr(self)
        }
    }
}