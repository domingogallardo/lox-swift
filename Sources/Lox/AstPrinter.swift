class AstPrinter: ExprVisitor {
    func print(expr: Expr) -> String {
        return expr.accept(visitor: self)
    }

    func visitBinaryExpr(_ expr: Expr.Binary) -> String {
        return parenthesize(name: expr.op.lexeme, exprs: expr.left, expr.right)
    }

    func visitGroupingExpr(_ expr: Expr.Grouping) -> String {
        return parenthesize(name: "group", exprs: expr.expression)
    }

    func visitLiteralExpr(_ expr: Expr.Literal) -> String {
        guard let value = expr.value else {
            return "nil"
        }
        return String(describing: value)
    }

    func visitUnaryExpr(_ expr: Expr.Unary) -> String {
        return parenthesize(name: expr.op.lexeme, exprs: expr.right)
    }

    private func parenthesize(name: String, exprs: Expr...) -> String {
        var output = ""

        output.append("(\(name)")
        
        for expr in exprs {
            output.append(" ")
            output.append(expr.accept(visitor: self))
        }

        output.append(")")

        return output
    }
}