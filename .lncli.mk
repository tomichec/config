LNCLI-alice=lncli --rpcserver=localhost:10001 --no-macaroons
LNCLI-bob=lncli --rpcserver=localhost:10002 --no-macaroons
LNCLI-charlie=lncli --rpcserver=localhost:10003 --no-macaroons

%:
	-$(LNCLI-alice) $*
	-$(LNCLI-bob) $*
	-$(LNCLI-charlie) $*
