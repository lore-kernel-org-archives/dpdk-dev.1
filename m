Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C58CD3439
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 May 2026 00:15:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5BF5A4064F;
	Thu,  7 May 2026 02:15:10 +0200 (CEST)
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
 by mails.dpdk.org (Postfix) with ESMTP id 3C6ED402AB
 for <dev@dpdk.org>; Thu,  7 May 2026 02:15:08 +0200 (CEST)
Received: by mail-dl1-f52.google.com with SMTP id
 a92af1059eb24-12c19d23b19so599157c88.0
 for <dev@dpdk.org>; Wed, 06 May 2026 17:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1778112907;
 x=1778717707; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1HSs+08vc3xjyDGF3oNWYYDloMIiDx8suKevjypgTDY=;
 b=lzooIAvz6Najq08dLryvXb25J7m9eVkAPOf/mW+TdvQxPhaV/QzW9wp8MfVCuRgi7u
 docapMQitIbo6LbFnp1JAvMjmSdNARe+vB9TLDYf4kgSE2yi1wW92lShoF2J+70w4ytK
 fKaggslprov+feLQ8SUTG/tk6uAZN//YwKTwjTeuBZ4KGzzDknSq0c+K/6LVegikvaW2
 YZU9JbKqY8VBAiR8E4F1P1Ua3FPts/6UxoUO6C0JGLMB2VjKnK9hWp/l2YK3+PhVZdCi
 dQU6FOy7+31ZU0kenfQS8+eOq5jjZPDtsEQ3qCFcdq2TtJm6ruWYoOzAFbuKprM5quTX
 A9uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778112907; x=1778717707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1HSs+08vc3xjyDGF3oNWYYDloMIiDx8suKevjypgTDY=;
 b=AkgbpwXVhD2n4kw6V61StCSSjXhZ+YopBSVuMlkrD9GoYS8PSQWvArD/N3a4zN9qcq
 h3Hrt0F3WLdE2SUsKpF51McIzfjFdP82WYdgsiGP1CN2/kcGgAwXDIqzxv1cb39d09A7
 GEoMLad9gt9btAu7dVFkgeMd7RaFw4es9QW7fHhf81N8OEfCDvKnOqa9iOi2BN2i+w8/
 AXiLF7JfK7kmmIcLi9wrPS++Lq7O4D21c4J2he074skcGC4T3/gMEi/9piWoyCx6tgaJ
 z1B+5b3MrR7zUvViVbk3j842t2cq8x5MVYfSHk4S/uW5EIy9bpBRUG6y66ok716utY/R
 nD/A==
X-Gm-Message-State: AOJu0YxeBwhxpACpSGUXsfQk0DJeHzotPshm3yoD31gZQRrgzF1gbIMt
 PZUu7SHr4oUdep6j2kKTvpxRam5KGpC08YunbKExkQNDCXblTPZ9DPOEImJ6xD6kreO3oYbco5F
 OZKMl
X-Gm-Gg: AeBDiev+idVELLWC5vUlPiJZNMUD3H/3aoUNU/fqCCjfWwZjp2GhzJ0WdWflVd/kWDo
 VMKzuYv/MF7ZSkHHX/+lqaWGq+418RapbEUKJnj5PGM4TirZQ1TgSr9oiu/iPHyAxsXLbmiTs4Z
 RqIUj1+hevlaBVJLNS7luz3qmaBioDzU/kL8k6vqTD1ibOkHbRZ3TLx8Q2SSBk4dF2XOBTu6e1l
 /zXXlc09UM9evcMs3yIn0qSFxQv1xu0KLUK/rqoVBq6PILYQcfRA7KWMtHQHZYeKa+FSzX/kdSW
 drlhxFeo2EjGNT30STapCJ3As5JhnVHk6rnW30EfnHImkDi5AX8muVXlhJgYvz6DHBWWTYhHg7r
 314rubwR1MEeN1sSyd+J3hOJieoUy501n9/hx0G84RbHuWV5sfVMFVb97xZpWOR8BZWVjSg21oA
 XuJSh+/PR47+BLz8CSDCg5MacTQOBCLYKBH1/hyFN83t4=
X-Received: by 2002:a05:7022:7a6:b0:130:a4aa:e4d1 with SMTP id
 a92af1059eb24-131a69ee70bmr3055689c88.34.1778112906524; 
 Wed, 06 May 2026 17:15:06 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f57057bd00sm5159080eec.30.2026.05.06.17.15.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 17:15:06 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC v2 2/4] flow_compile: introduce textual flow rule compiler
Date: Wed,  6 May 2026 17:06:49 -0700
Message-ID: <20260507001501.608724-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260507001501.608724-1-stephen@networkplumber.org>
References: <20260505183917.370281-1-sismis@dyna-nic.com>
 <20260507001501.608724-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

Currently the only way to compile a flow rule from text is to link
against testpmd's cmdline_flow.c, which is tightly coupled to
librte_cmdline and the testpmd command framework.  Recent attempts
to extract it as a library have produced ad-hoc copies rather than
a clean separation.

Add librte_flow_compile, modelled on libpcap's pcap_compile(): a
textual rule goes in, an opaque compiled object comes out, and
diagnostics of the form "line:col: message" go in a caller-supplied
buffer.  Accessors return the rte_flow_attr/item/action arrays
ready for rte_flow_create(); convenience entry points validate the
rule against a port (rte_flow_compile_validate) or install it
directly (rte_flow_compile_create).

The grammar is a small bison LALR parser (flow_compile.y) fed by
a reentrant flex lexer (flow_compile.l).  The grammar itself is
generic -- it knows only about attributes, items, fields, actions
and parameters, with no per-type productions.  All per-type
knowledge lives in descriptor tables (flow_compile_tables.c) that
map item and action names to their rte_flow structures and the
field offsets within them, so adding a new item or action type is
purely a table edit.  The descriptor mechanism currently handles
fixed-shape fields only.

Runtime dependencies are limited to rte_ethdev and rte_net; in
particular there is no dependency on librte_cmdline.  Flex and
bison are required at build time only; if either is missing the
library is silently skipped via meson's has_flex_bison check.
The grammar follows testpmd's syntax so familiar rules carry over,
and is documented in the programmer's guide.

Initial coverage spans the common items (eth, vlan, ipv4, ipv6,
tcp, udp, vxlan, port_id, port_representor, represented_port)
and actions (drop, passthru, queue, mark, jump, count, port_id
and representor variants, of_pop_vlan, vxlan_decap).  Items
and actions with variable-length conf (RSS, RAW) need a future
extension to the descriptor mechanism and are deferred.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/flow_compile/flow_compile.l         | 227 +++++++++++
 lib/flow_compile/flow_compile.y         | 311 ++++++++++++++
 lib/flow_compile/flow_compile_priv.h    | 127 ++++++
 lib/flow_compile/flow_compile_setters.c | 516 ++++++++++++++++++++++++
 lib/flow_compile/flow_compile_tables.c  | 243 +++++++++++
 lib/flow_compile/meson.build            |  22 +
 lib/flow_compile/rte_flow_compile.h     | 158 ++++++++
 lib/flow_compile/rte_flow_compile_api.c | 160 ++++++++
 lib/meson.build                         |   1 +
 9 files changed, 1765 insertions(+)
 create mode 100644 lib/flow_compile/flow_compile.l
 create mode 100644 lib/flow_compile/flow_compile.y
 create mode 100644 lib/flow_compile/flow_compile_priv.h
 create mode 100644 lib/flow_compile/flow_compile_setters.c
 create mode 100644 lib/flow_compile/flow_compile_tables.c
 create mode 100644 lib/flow_compile/meson.build
 create mode 100644 lib/flow_compile/rte_flow_compile.h
 create mode 100644 lib/flow_compile/rte_flow_compile_api.c

diff --git a/lib/flow_compile/flow_compile.l b/lib/flow_compile/flow_compile.l
new file mode 100644
index 0000000000..4b47c0a7e9
--- /dev/null
+++ b/lib/flow_compile/flow_compile.l
@@ -0,0 +1,227 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (c) 2026 Stephen Hemminger <stephen@networkplumber.org>
+ *
+ * Lexer for the flow rule compiler.  Reentrant, bison-bridge mode:
+ * token values go through *yylval, source position through *yylloc.
+ * Generated by flex(1) at build time; not committed to the tree.
+ */
+
+%option reentrant bison-bridge bison-locations
+%option noyywrap nounput noinput
+%option prefix="flow_compile_yy"
+%option never-interactive
+%option warn nodefault
+%option extra-type="struct flow_compile_ctx *"
+
+%top{
+#include <errno.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include <arpa/inet.h>
+#include <sys/socket.h>
+
+#include <rte_byteorder.h>
+#include <rte_errno.h>
+#include <rte_ether.h>
+
+#include "flow_compile_priv.h"
+}
+
+%{
+/*
+ * The bison-generated header must be visible BEFORE flex emits its
+ * own YYSTYPE *yylval_r / YYLTYPE *yylloc_r declarations.  flex
+ * places %{ %} content between its forward declarations and the
+ * generated lexer body, so this is the right home for it; %top{}
+ * lands too early.
+ */
+#include "flow_compile.tab.h"
+
+/*
+ * %define api.prefix {flow_compile_yy} renames bison's YYSTYPE
+ * and YYLTYPE to FLOW_COMPILE_YYSTYPE / FLOW_COMPILE_YYLTYPE, but
+ * flex still emits references to the unprefixed names.  Bridge
+ * with typedefs so flex's generated code compiles.
+ */
+typedef FLOW_COMPILE_YYSTYPE YYSTYPE;
+typedef FLOW_COMPILE_YYLTYPE YYLTYPE;
+/*
+ * YY_USER_ACTION runs before every rule action.  Updates yylloc
+ * to span the matched lexeme and advances the running line/column
+ * tracked in the ctx so flow_compile_errf() has a position when
+ * called outside a successful match.
+ *
+ * Bare brace block (not do/while) because flex emits this followed
+ * directly by the rule action with no intervening semicolon.
+ */
+#define YY_USER_ACTION							\
+	{								\
+		struct flow_compile_ctx *_cc = yyextra;			\
+		yylloc->first_line   = _cc->line;			\
+		yylloc->first_column = _cc->col;			\
+		for (int _i = 0; _i < yyleng; _i++) {			\
+			if (yytext[_i] == '\n') {			\
+				_cc->line++;				\
+				_cc->col = 1;				\
+			} else {					\
+				_cc->col++;				\
+			}						\
+		}							\
+		yylloc->last_line   = _cc->line;			\
+		yylloc->last_column = _cc->col;				\
+	}
+
+#define FAIL(...)							\
+	do {								\
+		flow_compile_errf(yyextra, __VA_ARGS__);		\
+		/* Returning 0 (EOF) terminates the parse.  We've	\
+		 * already populated errbuf via flow_compile_errf,	\
+		 * and that wins over any subsequent message bison	\
+		 * would generate via yyerror -- first-error-wins.	\
+		 */							\
+		return 0;						\
+	} while (0)
+
+/* Copy yytext into a NUL-terminated buffer for libc parsers. */
+static inline char *
+nul_terminate(char *buf, size_t buflen, const char *src, size_t srclen)
+{
+	if (srclen >= buflen)
+		return NULL;
+	memcpy(buf, src, srclen);
+	buf[srclen] = '\0';
+	return buf;
+}
+
+#define NULTERM(_buf)							\
+	nul_terminate((_buf), sizeof(_buf), yytext, (size_t)yyleng)
+%}
+
+DEC      [0-9]+
+HEX_PFX  0[xX][0-9A-Fa-f]+
+DEC_OCT  ([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])
+HEXG     [0-9A-Fa-f]{1,4}
+
+IPV4     {DEC_OCT}\.{DEC_OCT}\.{DEC_OCT}\.{DEC_OCT}
+
+IPV6     ({HEXG}(:{HEXG}){7})|(({HEXG}(:{HEXG})*)?::({HEXG}(:{HEXG})*)?)|({HEXG}(:{HEXG})*::({HEXG}(:{HEXG})*)?\.[0-9.]+)|::ffff:[0-9.]+
+
+MAC_COL  [0-9A-Fa-f]{2}(:[0-9A-Fa-f]{2}){5}
+MAC_HYP  [0-9A-Fa-f]{2}(-[0-9A-Fa-f]{2}){5}
+MAC_DOT  [0-9A-Fa-f]{4}\.[0-9A-Fa-f]{4}\.[0-9A-Fa-f]{4}
+MAC      ({MAC_COL}|{MAC_HYP}|{MAC_DOT})
+
+IDENT    [A-Za-z_][A-Za-z0-9_]*
+
+%%
+
+ /* whitespace and comments */
+"#"[^\n]*       ;
+[ \t\r\n\v\f]+  ;
+
+ /* punctuation */
+"/"     return '/';
+","     return ',';
+"{"     return '{';
+"}"     return '}';
+
+ /* keywords -- promoted to first-class tokens so the grammar can
+  * enforce position (e.g. "ingress" cannot appear where a field
+  * name is expected).
+  */
+"pattern"   return TK_PATTERN;
+"actions"   return TK_ACTIONS;
+"end"       return TK_END;
+"ingress"   return TK_INGRESS;
+"egress"    return TK_EGRESS;
+"transfer"  return TK_TRANSFER;
+"group"     return TK_GROUP;
+"priority"  return TK_PRIORITY;
+"is"        return TK_IS;
+"spec"      return TK_SPEC;
+"last"      return TK_LAST;
+"mask"      return TK_MASK;
+"prefix"    return TK_PREFIX;
+
+ /*
+  * Structured value tokens.  Order matters: rigid shapes first
+  * (MAC, IPV4) before more permissive forms.  Long hex strings
+  * before plain integers so they don't get truncated.
+  */
+
+{MAC} {
+	char buf[18];
+	struct rte_ether_addr ea;
+
+	if (NULTERM(buf) == NULL ||
+	    rte_ether_unformat_addr(buf, &ea) != 0)
+		FAIL("bad MAC address '%s'", yytext);
+	memcpy(yylval->mac, ea.addr_bytes, RTE_ETHER_ADDR_LEN);
+	return TK_MAC;
+}
+
+{IPV4} {
+	char buf[INET_ADDRSTRLEN];
+
+	if (NULTERM(buf) == NULL ||
+	    inet_pton(AF_INET, buf, yylval->ipv4) != 1)
+		FAIL("bad IPv4 address '%s'", yytext);
+	return TK_IPV4;
+}
+
+0[xX][0-9A-Fa-f]{17,} {
+	/* Long hex -> opaque byte sequence routed via TK_HEXSTR.
+	 * Stash the lexeme; the FK_BYTES setter in setters.c does
+	 * the byte conversion when the destination size is known.
+	 */
+	yylval->ident.text = yytext;
+	yylval->ident.len  = (uint16_t)yyleng;
+	return TK_HEXSTR;
+}
+
+{HEX_PFX}|{DEC} {
+	char buf[32];
+	char *end;
+
+	if (NULTERM(buf) == NULL)
+		FAIL("integer '%s' out of range", yytext);
+	errno = 0;
+	yylval->u = strtoull(buf, &end, 0);
+	if (errno != 0 || *end != '\0')
+		FAIL("integer '%s' out of range", yytext);
+	return TK_UINT;
+}
+
+{IPV6} {
+	char buf[INET6_ADDRSTRLEN];
+
+	if (NULTERM(buf) == NULL ||
+	    inet_pton(AF_INET6, buf, yylval->ipv6) != 1)
+		FAIL("bad IPv6 address '%s'", yytext);
+	return TK_IPV6;
+}
+
+ /* string literals */
+\"([^\\\"]|\\.)*\" {
+	yylval->ident.text = yytext + 1;
+	yylval->ident.len  = (uint16_t)(yyleng - 2);
+	return TK_STRING;
+}
+
+\"      FAIL("unterminated string");
+
+ /* identifiers (item names, action names, field names, action params) */
+{IDENT} {
+	yylval->ident.text = yytext;
+	yylval->ident.len  = (uint16_t)yyleng;
+	return TK_IDENT;
+}
+
+<<EOF>>     return 0;
+
+ /* catch-all */
+.       FAIL("unexpected character '%c'", (unsigned char)yytext[0]);
+
+%%
diff --git a/lib/flow_compile/flow_compile.y b/lib/flow_compile/flow_compile.y
new file mode 100644
index 0000000000..84ba38a9dd
--- /dev/null
+++ b/lib/flow_compile/flow_compile.y
@@ -0,0 +1,311 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (c) 2026 Stephen Hemminger <stephen@networkplumber.org>
+ *
+ * Bison grammar for the flow rule compiler.  Generated by bison(1)
+ * at build time; not committed to the tree.
+ *
+ * Pure (re-entrant) parser; state lives in struct flow_compile_ctx
+ * passed via %parse-param.  The lexer (flow_compile.l) is also
+ * pure and shares cc via yyextra; the scanner pointer is plumbed
+ * through %lex-param.
+ *
+ * All diagnostics route through flow_compile_errf() so lex, parse,
+ * and semantic-action errors share one "line:col: message" format
+ * and the first-error-wins capture rule.
+ */
+
+%define api.pure full
+%define api.prefix {flow_compile_yy}
+%define parse.error verbose
+%locations
+
+%lex-param   { void *scanner }
+%parse-param { struct flow_compile_ctx *cc } { void *scanner }
+
+%code requires {
+#include <stdint.h>
+
+#include "flow_compile_priv.h"
+
+/* Identifiers and string literals reference into the source buffer.
+ * The source outlives the parse so the references stay valid through
+ * every semantic action.
+ */
+struct ident_value {
+	const char *text;
+	uint16_t    len;
+};
+
+/* Generic value carrier for the value_token nonterminal.  A single
+ * helper signature (flow_compile_set_field, flow_compile_set_action_param)
+ * handles every TK_* kind by inspecting flow_value.kind.
+ */
+struct flow_value {
+	enum flow_value_kind {
+		FV_UINT, FV_IPV4, FV_IPV6, FV_MAC, FV_HEXSTR,
+	} kind;
+	union {
+		uint64_t   u;
+		uint8_t    ipv4[4];
+		uint8_t    ipv6[16];
+		uint8_t    mac[6];
+		struct ident_value hex;	/* points at "0x...." in source */
+	} v;
+	uint16_t line;
+	uint16_t col;
+};
+}
+
+%union {
+	uint64_t            u;
+	struct ident_value  ident;
+	uint8_t             ipv4[4];
+	uint8_t             ipv6[16];
+	uint8_t             mac[6];
+	struct flow_value   value;
+}
+
+%code provides {
+int flow_compile_yyparse(struct flow_compile_ctx *cc, void *scanner);
+
+/* Setter helpers, defined in flow_compile_setters.c.  Each returns
+ * 0 on success, -1 with cc->errbuf populated on failure.
+ */
+int flow_compile_apply_attr_uint(struct flow_compile_ctx *cc,
+				 const char *which, uint64_t v);
+int flow_compile_begin_item(struct flow_compile_ctx *cc,
+			    const struct ident_value *name);
+int flow_compile_end_item(struct flow_compile_ctx *cc);
+int flow_compile_set_field(struct flow_compile_ctx *cc,
+			   const struct ident_value *field,
+			   const struct ident_value *qualifier,
+			   const struct flow_value *value);
+int flow_compile_begin_action(struct flow_compile_ctx *cc,
+			      const struct ident_value *name);
+int flow_compile_end_action(struct flow_compile_ctx *cc);
+int flow_compile_set_action_param(struct flow_compile_ctx *cc,
+				  const struct ident_value *name,
+				  const struct flow_value *value);
+int flow_compile_finalize(struct flow_compile_ctx *cc);
+}
+
+%code {
+#include <string.h>
+
+#include <rte_common.h>
+#include <rte_flow.h>
+
+/* Bison-bridge prototype.  Bison emits the call site (yylex(&yylval,
+ * &yylloc, scanner)) but does not declare it; flex defines it in the
+ * generated lexer C file.  YYSTYPE / YYLTYPE are in scope here
+ * because %code is emitted into the .tab.c after both are defined.
+ */
+int flow_compile_yylex(YYSTYPE *yylval, YYLTYPE *yylloc, void *scanner);
+
+/* Bison's diagnostic path; route through the shared error helper. */
+static void
+flow_compile_yyerror(YYLTYPE *yylloc,
+		     struct flow_compile_ctx *cc,
+		     void *scanner __rte_unused,
+		     const char *msg)
+{
+	flow_compile_errf_at(cc,
+			     (uint16_t)yylloc->first_line,
+			     (uint16_t)yylloc->first_column,
+			     "%s", msg);
+}
+}
+
+/* ---- token declarations ---- */
+%token TK_PATTERN TK_ACTIONS TK_END
+%token TK_INGRESS TK_EGRESS TK_TRANSFER
+%token TK_GROUP TK_PRIORITY
+%token TK_IS TK_SPEC TK_LAST TK_MASK TK_PREFIX
+
+%token <ident> TK_IDENT
+%token <u>     TK_UINT
+%token <ipv4>  TK_IPV4
+%token <ipv6>  TK_IPV6
+%token <mac>   TK_MAC
+%token <ident> TK_HEXSTR	/* lexer leaves text/len; setter parses */
+%token <ident> TK_STRING
+
+%type <ident>    qualifier
+%type <value>    value_token
+
+%%
+
+rule
+	: attr_list TK_PATTERN item_list TK_ACTIONS action_list
+		{ if (flow_compile_finalize(cc) < 0) YYABORT; }
+	;
+
+/* ---- attributes ---- */
+
+attr_list
+	: /* empty */
+	| attr_list attr
+	;
+
+attr
+	: TK_INGRESS                  { cc->out->attr.ingress  = 1; }
+	| TK_EGRESS                   { cc->out->attr.egress   = 1; }
+	| TK_TRANSFER                 { cc->out->attr.transfer = 1; }
+	| TK_GROUP    TK_UINT
+		{
+			if (flow_compile_apply_attr_uint(cc,
+							 "group",
+							 $2) < 0)
+				YYABORT;
+		}
+	| TK_PRIORITY TK_UINT
+		{
+			if (flow_compile_apply_attr_uint(cc,
+							 "priority",
+							 $2) < 0)
+				YYABORT;
+		}
+	;
+
+/* ---- pattern ---- */
+
+item_list
+	: item_seq TK_END
+	;
+
+item_seq
+	: item '/'
+	| item_seq item '/'
+	;
+
+/*
+ * The in-progress item lives in cc->cur_item between begin_item and
+ * end_item.  field_spec dereferences it via cc rather than via a
+ * value-stack reach-back ($<item_p>0), which is fragile across the
+ * field_list reduction.
+ */
+item
+	: TK_IDENT
+		{
+			if (flow_compile_begin_item(cc, &$1) < 0)
+				YYABORT;
+		}
+	  field_list
+		{
+			if (flow_compile_end_item(cc) < 0)
+				YYABORT;
+		}
+	;
+
+field_list
+	: /* empty */
+	| field_list field_spec
+	;
+
+field_spec
+	: TK_IDENT qualifier value_token
+		{
+			if (flow_compile_set_field(cc, &$1, &$2, &$3) < 0)
+				YYABORT;
+		}
+	;
+
+qualifier
+	: TK_IS     { $$ = (struct ident_value){ "is",     2 }; }
+	| TK_SPEC   { $$ = (struct ident_value){ "spec",   4 }; }
+	| TK_LAST   { $$ = (struct ident_value){ "last",   4 }; }
+	| TK_MASK   { $$ = (struct ident_value){ "mask",   4 }; }
+	| TK_PREFIX { $$ = (struct ident_value){ "prefix", 6 }; }
+	;
+
+/* ---- actions ---- */
+
+action_list
+	: action_seq TK_END
+	;
+
+action_seq
+	: action '/'
+	| action_seq action '/'
+	;
+
+action
+	: TK_IDENT
+		{
+			if (flow_compile_begin_action(cc, &$1) < 0)
+				YYABORT;
+		}
+	  param_list
+		{
+			if (flow_compile_end_action(cc) < 0)
+				YYABORT;
+		}
+	;
+
+param_list
+	: /* empty */
+	| param_list param
+	;
+
+param
+	: TK_IDENT value_token
+		{
+			if (flow_compile_set_action_param(cc, &$1, &$2) < 0)
+				YYABORT;
+		}
+	;
+
+/* ---- value carrier ----
+ *
+ * One nonterminal per concrete value token, packing into a single
+ * flow_value carrier.  The setter inspects ``kind`` to dispatch.
+ */
+value_token
+	: TK_UINT
+		{
+			$$ = (struct flow_value){
+				.kind = FV_UINT,
+				.v.u  = $1,
+				.line = (uint16_t)@1.first_line,
+				.col  = (uint16_t)@1.first_column,
+			};
+		}
+	| TK_IPV4
+		{
+			$$ = (struct flow_value){
+				.kind = FV_IPV4,
+				.line = (uint16_t)@1.first_line,
+				.col  = (uint16_t)@1.first_column,
+			};
+			memcpy($$.v.ipv4, $1, sizeof($$.v.ipv4));
+		}
+	| TK_IPV6
+		{
+			$$ = (struct flow_value){
+				.kind = FV_IPV6,
+				.line = (uint16_t)@1.first_line,
+				.col  = (uint16_t)@1.first_column,
+			};
+			memcpy($$.v.ipv6, $1, sizeof($$.v.ipv6));
+		}
+	| TK_MAC
+		{
+			$$ = (struct flow_value){
+				.kind = FV_MAC,
+				.line = (uint16_t)@1.first_line,
+				.col  = (uint16_t)@1.first_column,
+			};
+			memcpy($$.v.mac, $1, sizeof($$.v.mac));
+		}
+	| TK_HEXSTR
+		{
+			$$ = (struct flow_value){
+				.kind   = FV_HEXSTR,
+				.v.hex  = $1,
+				.line   = (uint16_t)@1.first_line,
+				.col    = (uint16_t)@1.first_column,
+			};
+		}
+	;
+
+%%
diff --git a/lib/flow_compile/flow_compile_priv.h b/lib/flow_compile/flow_compile_priv.h
new file mode 100644
index 0000000000..92a61f1777
--- /dev/null
+++ b/lib/flow_compile/flow_compile_priv.h
@@ -0,0 +1,127 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (c) 2026 Stephen Hemminger <stephen@networkplumber.org>
+ */
+
+#ifndef FLOW_COMPILE_PRIV_H_
+#define FLOW_COMPILE_PRIV_H_
+
+#include <stdbool.h>
+#include <stddef.h>
+#include <stdint.h>
+
+#include <rte_compat.h>
+#include <rte_flow.h>
+
+#include "rte_flow_compile.h"
+
+/*
+ * Storage for one compiled rule.  Each spec/mask/last/conf payload
+ * is its own rte_zmalloc; rte_flow_compile_free() walks the pattern
+ * and action arrays and frees each non-NULL slot before freeing the
+ * arrays themselves.
+ */
+struct rte_flow_compile {
+	struct rte_flow_attr    attr;
+	struct rte_flow_item   *pattern;
+	unsigned int            npattern;
+	unsigned int            pattern_cap;
+	struct rte_flow_action *actions;
+	unsigned int            nactions;
+	unsigned int            actions_cap;
+};
+
+/*
+ * Compile context.  Lives only for the duration of one compile call.
+ * Bison/flex carry their own state via yyextra and the scanner
+ * pointer; what's here is the shared state setters and the error
+ * helper need.
+ */
+struct flow_compile_ctx {
+	char                    *errbuf;	/* caller-owned */
+	struct rte_flow_compile *out;
+
+	/* Position used by flow_compile_errf() when no token-derived
+	 * position is available.  Updated by the lexer's YY_USER_ACTION;
+	 * bison's %locations gives semantic actions the precise per-
+	 * token position via yylloc.
+	 */
+	uint16_t                 line;
+	uint16_t                 col;
+
+	/* Per-item / per-action tracking of which sub-buffers the
+	 * grammar touched.  Reset by begin_item / begin_action; read
+	 * by end_item / end_action which free untouched buffers so
+	 * the PMD's default-mask logic engages.
+	 */
+	bool spec_used;
+	bool mask_used;
+	bool last_used;
+	bool conf_used;
+
+	/* Cached descriptors and array slots for the in-progress item
+	 * and action.  set_field / set_action_param dereference these
+	 * rather than chasing pointers via bison's $<item_p>0 reach-
+	 * back (which is fragile in the field_list / param_list
+	 * reduction shape used here).
+	 */
+	const struct flow_item_desc   *cur_item_desc;
+	struct rte_flow_item          *cur_item;
+	const struct flow_action_desc *cur_action_desc;
+	struct rte_flow_action        *cur_action;
+};
+
+enum field_kind {
+	FK_U8,
+	FK_U16,		/* host order */
+	FK_U32,		/* host order */
+	FK_U64,		/* host order */
+	FK_BE16,	/* network order (rte_be16_t) */
+	FK_BE32,	/* network order */
+	FK_BE64,	/* network order */
+	FK_MAC,		/* 6 byte MAC address */
+	FK_IPV4,	/* 4 byte IPv4 address (network order) */
+	FK_IPV6,	/* 16 byte IPv6 address */
+	FK_BYTES,	/* fixed length byte array, accepts hex string */
+};
+
+struct field_desc {
+	const char *name;
+	uint16_t offset;
+	uint16_t size;
+	enum field_kind kind;
+};
+
+struct flow_item_desc {
+	const char *name;
+	enum rte_flow_item_type type;
+	uint16_t spec_size;
+	const struct field_desc *fields;
+	uint16_t nfields;
+};
+
+struct flow_action_desc {
+	const char *name;
+	enum rte_flow_action_type type;
+	uint16_t conf_size;
+	const struct field_desc *fields;
+	uint16_t nfields;
+};
+
+const struct flow_item_desc   *flow_compile_item_lookup(const char *name, size_t len);
+const struct flow_action_desc *flow_compile_action_lookup(const char *name, size_t len);
+const struct field_desc *flow_compile_field_lookup(const struct field_desc *tbl,
+						   uint16_t n,
+						   const char *name, size_t len);
+
+/*
+ * Diagnostic helper.  Always sets rte_errno = EINVAL and returns -1.
+ * Pass line=0, col=0 to use the ctx running position.
+ */
+int flow_compile_errf_at(struct flow_compile_ctx *cc,
+			 uint16_t line, uint16_t col,
+			 const char *fmt, ...) __rte_format_printf(4, 5);
+
+#define flow_compile_errf(cc, fmt, ...) \
+	flow_compile_errf_at((cc), 0, 0, (fmt), ##__VA_ARGS__)
+
+#endif /* FLOW_COMPILE_PRIV_H_ */
diff --git a/lib/flow_compile/flow_compile_setters.c b/lib/flow_compile/flow_compile_setters.c
new file mode 100644
index 0000000000..c8cf58ddf7
--- /dev/null
+++ b/lib/flow_compile/flow_compile_setters.c
@@ -0,0 +1,516 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (c) 2026 Stephen Hemminger <stephen@networkplumber.org>
+ *
+ * Helpers invoked from the bison semantic actions in flow_compile.y.
+ * The grammar drives the high-level structure (item-list, action-list);
+ * this file does the table lookup and per-field byte conversion.
+ */
+
+#include <errno.h>
+#include <inttypes.h>
+#include <stdarg.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <string.h>
+
+#include <rte_byteorder.h>
+#include <rte_errno.h>
+#include <rte_malloc.h>
+
+#include "flow_compile_priv.h"
+#include "flow_compile.tab.h"		/* struct ident_value, struct flow_value */
+
+/* ------------------------------------------------------------------ */
+/* Diagnostics. */
+
+int
+flow_compile_errf_at(struct flow_compile_ctx *cc,
+		     uint16_t line, uint16_t col,
+		     const char *fmt, ...)
+{
+	if (cc->errbuf[0] != '\0')
+		return -1;	/* keep the first error */
+
+	if (line == 0 && col == 0) {
+		line = cc->line;
+		col  = cc->col;
+	}
+
+	int n = snprintf(cc->errbuf, RTE_FLOW_COMPILE_ERRBUF_SIZE,
+			 "%u:%u: ", (unsigned int)line, (unsigned int)col);
+	if (n < 0)
+		n = 0;
+	if (n >= (int)RTE_FLOW_COMPILE_ERRBUF_SIZE)
+		n = (int)RTE_FLOW_COMPILE_ERRBUF_SIZE - 1;
+
+	va_list ap;
+	va_start(ap, fmt);
+	vsnprintf(cc->errbuf + n,
+		  (size_t)RTE_FLOW_COMPILE_ERRBUF_SIZE - (size_t)n,
+		  fmt, ap);
+	va_end(ap);
+
+	rte_errno = EINVAL;
+	return -1;
+}
+
+/* ------------------------------------------------------------------ */
+
+static inline unsigned int
+hex_nibble(int c)
+{
+	if (c <= '9')
+		return (unsigned int)(c - '0');
+	if (c <= 'F')
+		return (unsigned int)(c - 'A' + 10);
+	return (unsigned int)(c - 'a' + 10);
+}
+
+/* ------------------------------------------------------------------ */
+/* Default field setters. */
+
+static int
+write_uint(struct flow_compile_ctx *cc,
+	   void *spec, void *mask,
+	   const struct field_desc *fd,
+	   uint64_t v, uint64_t maxv,
+	   const struct flow_value *value)
+{
+	if (v > maxv)
+		return flow_compile_errf_at(cc, value->line, value->col,
+			"value %" PRIu64 " out of range for field '%s'",
+			v, fd->name);
+
+	uint8_t *sp = (uint8_t *)spec + fd->offset;
+	switch (fd->kind) {
+	case FK_U8:
+		*sp = (uint8_t)v;
+		break;
+	case FK_U16: {
+		uint16_t x = (uint16_t)v;
+		memcpy(sp, &x, sizeof(x));
+		break;
+	}
+	case FK_U32: {
+		uint32_t x = (uint32_t)v;
+		memcpy(sp, &x, sizeof(x));
+		break;
+	}
+	case FK_U64:
+		memcpy(sp, &v, sizeof(v));
+		break;
+	case FK_BE16: {
+		rte_be16_t x = rte_cpu_to_be_16((uint16_t)v);
+		memcpy(sp, &x, sizeof(x));
+		break;
+	}
+	case FK_BE32: {
+		rte_be32_t x = rte_cpu_to_be_32((uint32_t)v);
+		memcpy(sp, &x, sizeof(x));
+		break;
+	}
+	case FK_BE64: {
+		rte_be64_t x = rte_cpu_to_be_64(v);
+		memcpy(sp, &x, sizeof(x));
+		break;
+	}
+	default:
+		return flow_compile_errf_at(cc, value->line, value->col,
+			"field '%s' does not accept an integer", fd->name);
+	}
+
+	if (mask != NULL)
+		memset((uint8_t *)mask + fd->offset, 0xff, fd->size);
+	return 0;
+}
+
+static int
+write_bytes(struct flow_compile_ctx *cc,
+	    void *spec, void *mask,
+	    const struct field_desc *fd,
+	    const struct flow_value *value)
+{
+	uint8_t *sp = (uint8_t *)spec + fd->offset;
+
+	if (value->kind == FV_HEXSTR) {
+		const struct ident_value *h = &value->v.hex;
+		size_t body = (size_t)h->len - 2;
+		if (body != (size_t)fd->size * 2)
+			return flow_compile_errf_at(cc, value->line, value->col,
+				"hex string for '%s' must be %u bytes",
+				fd->name, (unsigned int)fd->size);
+		const char *p = h->text + 2;
+		for (uint16_t i = 0; i < fd->size; i++) {
+			unsigned int b =
+				(hex_nibble((unsigned char)p[i * 2]) << 4)
+			      |  hex_nibble((unsigned char)p[i * 2 + 1]);
+			sp[i] = (uint8_t)b;
+		}
+	} else if (value->kind == FV_UINT) {
+		uint64_t v = value->v.u;
+		for (int i = (int)fd->size - 1; i >= 0; i--) {
+			sp[i] = (uint8_t)(v & 0xffu);
+			v >>= 8;
+		}
+		if (v != 0)
+			return flow_compile_errf_at(cc, value->line, value->col,
+				"value too large for %u byte field '%s'",
+				(unsigned int)fd->size, fd->name);
+	} else {
+		return flow_compile_errf_at(cc, value->line, value->col,
+			"field '%s' expects an integer or hex string",
+			fd->name);
+	}
+
+	if (mask != NULL)
+		memset((uint8_t *)mask + fd->offset, 0xff, fd->size);
+	return 0;
+}
+
+static int
+default_field_set(struct flow_compile_ctx *cc,
+		  void *spec, void *mask,
+		  const struct field_desc *fd,
+		  const struct flow_value *value)
+{
+	uint8_t *sp = (uint8_t *)spec + fd->offset;
+
+	switch (fd->kind) {
+	case FK_U8:
+		if (value->kind != FV_UINT)
+			return flow_compile_errf_at(cc, value->line, value->col,
+				"field '%s' expects an integer", fd->name);
+		return write_uint(cc, spec, mask, fd, value->v.u, UINT8_MAX, value);
+	case FK_U16:
+	case FK_BE16:
+		if (value->kind != FV_UINT)
+			return flow_compile_errf_at(cc, value->line, value->col,
+				"field '%s' expects an integer", fd->name);
+		return write_uint(cc, spec, mask, fd, value->v.u, UINT16_MAX, value);
+	case FK_U32:
+		if (value->kind != FV_UINT)
+			return flow_compile_errf_at(cc, value->line, value->col,
+				"field '%s' expects an integer", fd->name);
+		return write_uint(cc, spec, mask, fd, value->v.u, UINT32_MAX, value);
+	case FK_U64:
+	case FK_BE64:
+		if (value->kind != FV_UINT)
+			return flow_compile_errf_at(cc, value->line, value->col,
+				"field '%s' expects an integer", fd->name);
+		return write_uint(cc, spec, mask, fd, value->v.u, UINT64_MAX, value);
+	case FK_BE32:
+		if (value->kind == FV_IPV4) {
+			memcpy(sp, value->v.ipv4, 4);
+			if (mask != NULL)
+				memset((uint8_t *)mask + fd->offset, 0xff, 4);
+			return 0;
+		}
+		if (value->kind == FV_UINT)
+			return write_uint(cc, spec, mask, fd, value->v.u,
+					  UINT32_MAX, value);
+		return flow_compile_errf_at(cc, value->line, value->col,
+			"field '%s' expects an integer or IPv4 address",
+			fd->name);
+	case FK_MAC:
+		if (value->kind != FV_MAC)
+			return flow_compile_errf_at(cc, value->line, value->col,
+				"field '%s' expects a MAC address", fd->name);
+		memcpy(sp, value->v.mac, 6);
+		if (mask != NULL)
+			memset((uint8_t *)mask + fd->offset, 0xff, 6);
+		return 0;
+	case FK_IPV4:
+		if (value->kind != FV_IPV4)
+			return flow_compile_errf_at(cc, value->line, value->col,
+				"field '%s' expects an IPv4 address", fd->name);
+		memcpy(sp, value->v.ipv4, 4);
+		if (mask != NULL)
+			memset((uint8_t *)mask + fd->offset, 0xff, 4);
+		return 0;
+	case FK_IPV6:
+		if (value->kind != FV_IPV6)
+			return flow_compile_errf_at(cc, value->line, value->col,
+				"field '%s' expects an IPv6 address", fd->name);
+		memcpy(sp, value->v.ipv6, 16);
+		if (mask != NULL)
+			memset((uint8_t *)mask + fd->offset, 0xff, 16);
+		return 0;
+	case FK_BYTES:
+		return write_bytes(cc, spec, mask, fd, value);
+	}
+	return flow_compile_errf_at(cc, value->line, value->col,
+		"internal error: unknown field kind for '%s'", fd->name);
+}
+
+static int
+apply_prefix(struct flow_compile_ctx *cc, void *mask,
+	     const struct field_desc *fd, const struct flow_value *value)
+{
+	if (value->kind != FV_UINT)
+		return flow_compile_errf_at(cc, value->line, value->col,
+			"prefix expects an integer");
+
+	uint32_t bits = (uint32_t)value->v.u;
+	uint32_t total = fd->size * 8u;
+	if (bits > total)
+		return flow_compile_errf_at(cc, value->line, value->col,
+			"prefix %u exceeds %u bits for '%s'",
+			bits, total, fd->name);
+
+	if (fd->kind != FK_IPV4 && fd->kind != FK_IPV6 &&
+	    fd->kind != FK_BE32)
+		return flow_compile_errf_at(cc, value->line, value->col,
+			"prefix not supported for field '%s'", fd->name);
+
+	uint8_t *m = (uint8_t *)mask + fd->offset;
+	memset(m, 0, fd->size);
+	for (uint32_t i = 0; i < bits; i++)
+		m[i / 8u] |= (uint8_t)(1u << (7u - (i & 7u)));
+	return 0;
+}
+
+/* ------------------------------------------------------------------ */
+/* Attribute application. */
+
+int
+flow_compile_apply_attr_uint(struct flow_compile_ctx *cc,
+			     const char *which, uint64_t v)
+{
+	if (v > UINT32_MAX)
+		return flow_compile_errf(cc,
+			"%s expects uint32, got %" PRIu64, which, v);
+
+	if (strcmp(which, "group") == 0)
+		cc->out->attr.group = (uint32_t)v;
+	else if (strcmp(which, "priority") == 0)
+		cc->out->attr.priority = (uint32_t)v;
+	else
+		return flow_compile_errf(cc,
+			"internal error: unknown attribute '%s'", which);
+	return 0;
+}
+
+/* ------------------------------------------------------------------ */
+/* Item lifecycle. */
+
+int
+flow_compile_begin_item(struct flow_compile_ctx *cc,
+			const struct ident_value *name)
+{
+	const struct flow_item_desc *desc =
+		flow_compile_item_lookup(name->text, name->len);
+	if (desc == NULL)
+		return flow_compile_errf(cc,
+			"unknown flow item '%.*s'",
+			(int)name->len, name->text);
+
+	if (cc->out->npattern + 1 >= cc->out->pattern_cap) {
+		unsigned int cap = cc->out->pattern_cap == 0 ? 8 :
+				   cc->out->pattern_cap * 2;
+		struct rte_flow_item *p = rte_realloc(cc->out->pattern,
+				cap * sizeof(*p), 0);
+		if (p == NULL) {
+			rte_errno = ENOMEM;
+			return -1;
+		}
+		cc->out->pattern = p;
+		cc->out->pattern_cap = cap;
+	}
+
+	struct rte_flow_item *item = &cc->out->pattern[cc->out->npattern];
+	memset(item, 0, sizeof(*item));
+	item->type = desc->type;
+	cc->out->npattern++;	/* publish so cleanup walker sees it */
+
+	if (desc->spec_size > 0) {
+		item->spec = rte_zmalloc("flow_compile", desc->spec_size, 0);
+		item->mask = rte_zmalloc("flow_compile", desc->spec_size, 0);
+		item->last = rte_zmalloc("flow_compile", desc->spec_size, 0);
+		if (item->spec == NULL || item->mask == NULL ||
+		    item->last == NULL) {
+			rte_errno = ENOMEM;
+			return -1;
+		}
+	}
+
+	cc->cur_item_desc = desc;
+	cc->cur_item      = item;
+	cc->spec_used = false;
+	cc->mask_used = false;
+	cc->last_used = false;
+	return 0;
+}
+
+int
+flow_compile_end_item(struct flow_compile_ctx *cc)
+{
+	struct rte_flow_item *item = cc->cur_item;
+
+	if (!cc->spec_used) {
+		rte_free((void *)(uintptr_t)item->spec);
+		item->spec = NULL;
+	}
+	if (!cc->mask_used) {
+		rte_free((void *)(uintptr_t)item->mask);
+		item->mask = NULL;
+	}
+	if (!cc->last_used) {
+		rte_free((void *)(uintptr_t)item->last);
+		item->last = NULL;
+	}
+	cc->cur_item_desc = NULL;
+	cc->cur_item      = NULL;
+	return 0;
+}
+
+int
+flow_compile_set_field(struct flow_compile_ctx *cc,
+		       const struct ident_value *field,
+		       const struct ident_value *qualifier,
+		       const struct flow_value *value)
+{
+	const struct flow_item_desc *desc = cc->cur_item_desc;
+	struct rte_flow_item *item = cc->cur_item;
+	if (desc == NULL || item == NULL)
+		return flow_compile_errf(cc,
+			"internal error: lost item descriptor");
+
+	const struct field_desc *fd =
+		flow_compile_field_lookup(desc->fields, desc->nfields,
+					  field->text, field->len);
+	if (fd == NULL)
+		return flow_compile_errf(cc,
+			"unknown field '%.*s' for item '%s'",
+			(int)field->len, field->text, desc->name);
+
+	void *spec = (void *)(uintptr_t)item->spec;
+	void *mask = (void *)(uintptr_t)item->mask;
+	void *last = (void *)(uintptr_t)item->last;
+
+	if (qualifier->len == 2 && memcmp(qualifier->text, "is", 2) == 0) {
+		cc->spec_used = cc->mask_used = true;
+		return default_field_set(cc, spec, mask, fd, value);
+	}
+	if (qualifier->len == 4 && memcmp(qualifier->text, "spec", 4) == 0) {
+		cc->spec_used = true;
+		return default_field_set(cc, spec, NULL, fd, value);
+	}
+	if (qualifier->len == 4 && memcmp(qualifier->text, "last", 4) == 0) {
+		cc->last_used = true;
+		return default_field_set(cc, last, NULL, fd, value);
+	}
+	if (qualifier->len == 4 && memcmp(qualifier->text, "mask", 4) == 0) {
+		cc->mask_used = true;
+		return default_field_set(cc, mask, NULL, fd, value);
+	}
+	if (qualifier->len == 6 && memcmp(qualifier->text, "prefix", 6) == 0) {
+		cc->mask_used = true;
+		return apply_prefix(cc, mask, fd, value);
+	}
+
+	return flow_compile_errf(cc,
+		"internal error: unknown qualifier '%.*s'",
+		(int)qualifier->len, qualifier->text);
+}
+
+/* ------------------------------------------------------------------ */
+/* Action lifecycle. */
+
+int
+flow_compile_begin_action(struct flow_compile_ctx *cc,
+			  const struct ident_value *name)
+{
+	const struct flow_action_desc *desc =
+		flow_compile_action_lookup(name->text, name->len);
+	if (desc == NULL)
+		return flow_compile_errf(cc,
+			"unknown flow action '%.*s'",
+			(int)name->len, name->text);
+
+	if (cc->out->nactions + 1 >= cc->out->actions_cap) {
+		unsigned int cap = cc->out->actions_cap == 0 ? 8 :
+				   cc->out->actions_cap * 2;
+		struct rte_flow_action *p = rte_realloc(cc->out->actions,
+				cap * sizeof(*p), 0);
+		if (p == NULL) {
+			rte_errno = ENOMEM;
+			return -1;
+		}
+		cc->out->actions = p;
+		cc->out->actions_cap = cap;
+	}
+
+	struct rte_flow_action *act = &cc->out->actions[cc->out->nactions];
+	memset(act, 0, sizeof(*act));
+	act->type = desc->type;
+	cc->out->nactions++;
+
+	if (desc->conf_size > 0) {
+		act->conf = rte_zmalloc("flow_compile", desc->conf_size, 0);
+		if (act->conf == NULL) {
+			rte_errno = ENOMEM;
+			return -1;
+		}
+	}
+
+	cc->cur_action_desc = desc;
+	cc->cur_action      = act;
+	cc->conf_used = false;
+	return 0;
+}
+
+int
+flow_compile_end_action(struct flow_compile_ctx *cc)
+{
+	struct rte_flow_action *act = cc->cur_action;
+
+	if (!cc->conf_used) {
+		rte_free((void *)(uintptr_t)act->conf);
+		act->conf = NULL;
+	}
+	cc->cur_action_desc = NULL;
+	cc->cur_action      = NULL;
+	return 0;
+}
+
+int
+flow_compile_set_action_param(struct flow_compile_ctx *cc,
+			      const struct ident_value *name,
+			      const struct flow_value *value)
+{
+	const struct flow_action_desc *desc = cc->cur_action_desc;
+	struct rte_flow_action *act = cc->cur_action;
+	if (desc == NULL || act == NULL)
+		return flow_compile_errf(cc,
+			"internal error: lost action descriptor");
+
+	const struct field_desc *fd =
+		flow_compile_field_lookup(desc->fields, desc->nfields,
+					  name->text, name->len);
+	if (fd == NULL)
+		return flow_compile_errf(cc,
+			"unknown parameter '%.*s' for action '%s'",
+			(int)name->len, name->text, desc->name);
+
+	cc->conf_used = true;
+	return default_field_set(cc, (void *)(uintptr_t)act->conf,
+				 NULL, fd, value);
+}
+
+/* ------------------------------------------------------------------ */
+/* Append END sentinels at the end of a successful parse.  Both
+ * arrays were sized with +1 headroom in begin_item / begin_action,
+ * so this never reallocates.
+ */
+int
+flow_compile_finalize(struct flow_compile_ctx *cc)
+{
+	struct rte_flow_item *iend = &cc->out->pattern[cc->out->npattern];
+	memset(iend, 0, sizeof(*iend));
+	cc->out->npattern++;
+
+	struct rte_flow_action *aend = &cc->out->actions[cc->out->nactions];
+	memset(aend, 0, sizeof(*aend));
+	cc->out->nactions++;
+	return 0;
+}
diff --git a/lib/flow_compile/flow_compile_tables.c b/lib/flow_compile/flow_compile_tables.c
new file mode 100644
index 0000000000..f9a20f7f55
--- /dev/null
+++ b/lib/flow_compile/flow_compile_tables.c
@@ -0,0 +1,243 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (c) 2026 Stephen Hemminger <stephen@networkplumber.org>
+ */
+
+/*
+ * Tables that describe each flow item and flow action recognized by
+ * the compiler.
+ *
+ * To add a new item type:
+ *
+ *   1. Add a static array of ``struct field_desc`` for each parsable
+ *      field in the item's spec struct.
+ *   2. Add an entry to ``flow_items[]``.
+ *
+ * The parser is entirely table-driven; no parser code needs to change.
+ */
+
+#include <stddef.h>
+#include <string.h>
+
+#include <rte_ether.h>
+#include <rte_ip.h>
+#include <rte_tcp.h>
+#include <rte_udp.h>
+#include <rte_flow.h>
+
+#include "flow_compile_priv.h"
+
+/*
+ * Helper macros.
+ *
+ * FIELD:        a fixed-width field reachable by offsetof(spec, member).
+ * FIELD_BYTES:  a byte array of declared length (for opaque/raw fields).
+ */
+#define FIELD(_n, _s, _m, _k)						\
+	{ .name = (_n), .offset = offsetof(_s, _m),			\
+	  .size = sizeof(((_s *)0)->_m), .kind = (_k) }
+
+#define FIELD_BYTES(_n, _s, _m)						\
+	{ .name = (_n), .offset = offsetof(_s, _m),			\
+	  .size = sizeof(((_s *)0)->_m), .kind = FK_BYTES }
+
+/* ------------------------------------------------------------------ */
+/* eth */
+
+static const struct field_desc eth_fields[] = {
+	FIELD("dst",	struct rte_flow_item_eth, hdr.dst_addr,    FK_MAC),
+	FIELD("src",	struct rte_flow_item_eth, hdr.src_addr,    FK_MAC),
+	FIELD("type",	struct rte_flow_item_eth, hdr.ether_type,  FK_BE16),
+};
+
+/* ------------------------------------------------------------------ */
+/* vlan */
+
+static const struct field_desc vlan_fields[] = {
+	FIELD("tci",		struct rte_flow_item_vlan, hdr.vlan_tci,        FK_BE16),
+	FIELD("inner_type",	struct rte_flow_item_vlan, hdr.eth_proto,       FK_BE16),
+};
+
+/* ------------------------------------------------------------------ */
+/* ipv4 */
+
+static const struct field_desc ipv4_fields[] = {
+	FIELD("tos",			struct rte_flow_item_ipv4, hdr.type_of_service,	FK_U8),
+	FIELD("ttl",			struct rte_flow_item_ipv4, hdr.time_to_live,	FK_U8),
+	FIELD("proto",			struct rte_flow_item_ipv4, hdr.next_proto_id,	FK_U8),
+	FIELD("src",			struct rte_flow_item_ipv4, hdr.src_addr,	FK_IPV4),
+	FIELD("dst",			struct rte_flow_item_ipv4, hdr.dst_addr,	FK_IPV4),
+	FIELD("fragment_offset",	struct rte_flow_item_ipv4, hdr.fragment_offset,	FK_BE16),
+	FIELD("packet_id",		struct rte_flow_item_ipv4, hdr.packet_id,	FK_BE16),
+	FIELD("total_length",		struct rte_flow_item_ipv4, hdr.total_length,	FK_BE16),
+};
+
+/* ------------------------------------------------------------------ */
+/* ipv6 */
+
+static const struct field_desc ipv6_fields[] = {
+	FIELD("src",		struct rte_flow_item_ipv6, hdr.src_addr,	FK_IPV6),
+	FIELD("dst",		struct rte_flow_item_ipv6, hdr.dst_addr,	FK_IPV6),
+	FIELD("proto",		struct rte_flow_item_ipv6, hdr.proto,		FK_U8),
+	FIELD("hop_limits",	struct rte_flow_item_ipv6, hdr.hop_limits,	FK_U8),
+	FIELD("vtc_flow",	struct rte_flow_item_ipv6, hdr.vtc_flow,	FK_BE32),
+	FIELD("payload_len",	struct rte_flow_item_ipv6, hdr.payload_len,	FK_BE16),
+};
+
+/* ------------------------------------------------------------------ */
+/* tcp / udp */
+
+static const struct field_desc tcp_fields[] = {
+	FIELD("src",		struct rte_flow_item_tcp, hdr.src_port,		FK_BE16),
+	FIELD("dst",		struct rte_flow_item_tcp, hdr.dst_port,		FK_BE16),
+	FIELD("flags",		struct rte_flow_item_tcp, hdr.tcp_flags,	FK_U8),
+};
+
+static const struct field_desc udp_fields[] = {
+	FIELD("src",		struct rte_flow_item_udp, hdr.src_port,	FK_BE16),
+	FIELD("dst",		struct rte_flow_item_udp, hdr.dst_port,	FK_BE16),
+};
+
+/* ------------------------------------------------------------------ */
+/* vxlan -- the VNI is a 24-bit value stored in hdr.vni as 3 raw
+ * bytes.  Exposed via FIELD_BYTES so the user can supply it either
+ * as a uint up to 0xFFFFFF (write_bytes errors on overflow) or as
+ * a 6-digit hex string.
+ */
+static const struct field_desc vxlan_fields[] = {
+	FIELD("flags",	struct rte_flow_item_vxlan, hdr.flags,	FK_U8),
+	FIELD_BYTES("vni",	struct rte_flow_item_vxlan, hdr.vni),
+};
+
+/* ------------------------------------------------------------------ */
+/* port_id / port_representor */
+
+static const struct field_desc port_id_fields[] = {
+	FIELD("id",		struct rte_flow_item_port_id, id,	FK_U32),
+};
+
+static const struct field_desc port_repr_fields[] = {
+	FIELD("port_id",	struct rte_flow_item_ethdev, port_id,	FK_U16),
+};
+
+/* ------------------------------------------------------------------ */
+/* The item table.  Order is irrelevant; lookup is by exact name match. */
+
+#define ITEM(_n, _t, _s, _f) {						\
+	.name = (_n), .type = (_t), .spec_size = sizeof(_s),		\
+	.fields = (_f), .nfields = RTE_DIM(_f) }
+
+#define ITEM_VOID(_n, _t) {						\
+	.name = (_n), .type = (_t), .spec_size = 0,			\
+	.fields = NULL, .nfields = 0 }
+
+static const struct flow_item_desc flow_items[] = {
+	ITEM_VOID("void",	RTE_FLOW_ITEM_TYPE_VOID),
+	ITEM_VOID("any",	RTE_FLOW_ITEM_TYPE_ANY),
+	ITEM("eth",		RTE_FLOW_ITEM_TYPE_ETH,		struct rte_flow_item_eth,	eth_fields),
+	ITEM("vlan",		RTE_FLOW_ITEM_TYPE_VLAN,	struct rte_flow_item_vlan,	vlan_fields),
+	ITEM("ipv4",		RTE_FLOW_ITEM_TYPE_IPV4,	struct rte_flow_item_ipv4,	ipv4_fields),
+	ITEM("ipv6",		RTE_FLOW_ITEM_TYPE_IPV6,	struct rte_flow_item_ipv6,	ipv6_fields),
+	ITEM("tcp",		RTE_FLOW_ITEM_TYPE_TCP,		struct rte_flow_item_tcp,	tcp_fields),
+	ITEM("udp",		RTE_FLOW_ITEM_TYPE_UDP,		struct rte_flow_item_udp,	udp_fields),
+	ITEM("vxlan",		RTE_FLOW_ITEM_TYPE_VXLAN,	struct rte_flow_item_vxlan,	vxlan_fields),
+	ITEM("port_id",		RTE_FLOW_ITEM_TYPE_PORT_ID,	struct rte_flow_item_port_id,	port_id_fields),
+	ITEM("port_representor", RTE_FLOW_ITEM_TYPE_PORT_REPRESENTOR,
+				struct rte_flow_item_ethdev,	port_repr_fields),
+	ITEM("represented_port", RTE_FLOW_ITEM_TYPE_REPRESENTED_PORT,
+				struct rte_flow_item_ethdev,	port_repr_fields),
+};
+
+/* ------------------------------------------------------------------ */
+/* Action descriptor tables. */
+
+static const struct field_desc act_queue_fields[] = {
+	FIELD("index",	struct rte_flow_action_queue, index,	FK_U16),
+};
+
+static const struct field_desc act_mark_fields[] = {
+	FIELD("id",	struct rte_flow_action_mark, id,	FK_U32),
+};
+
+static const struct field_desc act_jump_fields[] = {
+	FIELD("group",	struct rte_flow_action_jump, group,	FK_U32),
+};
+
+static const struct field_desc act_count_fields[] = {
+	FIELD("id",	struct rte_flow_action_count, id,	FK_U32),
+};
+
+static const struct field_desc act_port_id_fields[] = {
+	FIELD("id",	struct rte_flow_action_port_id, id,	FK_U32),
+};
+
+static const struct field_desc act_port_repr_fields[] = {
+	FIELD("port_id", struct rte_flow_action_ethdev, port_id, FK_U16),
+};
+
+#define ACTION(_n, _t, _s, _f) {					\
+	.name = (_n), .type = (_t), .conf_size = sizeof(_s),		\
+	.fields = (_f), .nfields = RTE_DIM(_f) }
+
+#define ACTION_VOID(_n, _t) {						\
+	.name = (_n), .type = (_t), .conf_size = 0,			\
+	.fields = NULL, .nfields = 0 }
+
+static const struct flow_action_desc flow_actions[] = {
+	ACTION_VOID("void",		RTE_FLOW_ACTION_TYPE_VOID),
+	ACTION_VOID("drop",		RTE_FLOW_ACTION_TYPE_DROP),
+	ACTION_VOID("passthru",		RTE_FLOW_ACTION_TYPE_PASSTHRU),
+	ACTION_VOID("of_pop_vlan",	RTE_FLOW_ACTION_TYPE_OF_POP_VLAN),
+	ACTION_VOID("vxlan_decap",	RTE_FLOW_ACTION_TYPE_VXLAN_DECAP),
+
+	ACTION("queue",		RTE_FLOW_ACTION_TYPE_QUEUE,
+	       struct rte_flow_action_queue,		act_queue_fields),
+	ACTION("mark",		RTE_FLOW_ACTION_TYPE_MARK,
+	       struct rte_flow_action_mark,		act_mark_fields),
+	ACTION("jump",		RTE_FLOW_ACTION_TYPE_JUMP,
+	       struct rte_flow_action_jump,		act_jump_fields),
+	ACTION("count",		RTE_FLOW_ACTION_TYPE_COUNT,
+	       struct rte_flow_action_count,		act_count_fields),
+	ACTION("port_id",	RTE_FLOW_ACTION_TYPE_PORT_ID,
+	       struct rte_flow_action_port_id,		act_port_id_fields),
+	ACTION("port_representor", RTE_FLOW_ACTION_TYPE_PORT_REPRESENTOR,
+	       struct rte_flow_action_ethdev,		act_port_repr_fields),
+	ACTION("represented_port", RTE_FLOW_ACTION_TYPE_REPRESENTED_PORT,
+	       struct rte_flow_action_ethdev,		act_port_repr_fields),
+};
+
+/* ------------------------------------------------------------------ */
+/* Public lookup helpers. */
+
+static bool
+name_eq(const char *a, const char *b, size_t bn)
+{
+	return strncmp(a, b, bn) == 0 && a[bn] == '\0';
+}
+
+const struct flow_item_desc *
+flow_compile_item_lookup(const char *name, size_t len)
+{
+	for (size_t i = 0; i < RTE_DIM(flow_items); i++)
+		if (name_eq(flow_items[i].name, name, len))
+			return &flow_items[i];
+	return NULL;
+}
+
+const struct flow_action_desc *
+flow_compile_action_lookup(const char *name, size_t len)
+{
+	for (size_t i = 0; i < RTE_DIM(flow_actions); i++)
+		if (name_eq(flow_actions[i].name, name, len))
+			return &flow_actions[i];
+	return NULL;
+}
+
+const struct field_desc *
+flow_compile_field_lookup(const struct field_desc *tbl, uint16_t n,
+			  const char *name, size_t len)
+{
+	for (uint16_t i = 0; i < n; i++)
+		if (tbl[i].name != NULL && name_eq(tbl[i].name, name, len))
+			return &tbl[i];
+	return NULL;
+}
diff --git a/lib/flow_compile/meson.build b/lib/flow_compile/meson.build
new file mode 100644
index 0000000000..833c280130
--- /dev/null
+++ b/lib/flow_compile/meson.build
@@ -0,0 +1,22 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2026 Stephen Hemminger
+
+if not has_flex_bison
+    build = false
+    reason = 'missing dependency, "flex" and/or "bison"'
+    subdir_done()
+endif
+
+sources += files(
+        'flow_compile_setters.c',
+        'flow_compile_tables.c',
+        'rte_flow_compile_api.c',
+)
+sources += flex_gen.process('flow_compile.l')
+sources += bison_gen.process('flow_compile.y')
+
+headers += files(
+        'rte_flow_compile.h',
+)
+
+deps += ['ethdev', 'net']
diff --git a/lib/flow_compile/rte_flow_compile.h b/lib/flow_compile/rte_flow_compile.h
new file mode 100644
index 0000000000..9bb733a129
--- /dev/null
+++ b/lib/flow_compile/rte_flow_compile.h
@@ -0,0 +1,158 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (c) 2026 Stephen Hemminger <stephen@networkplumber.org>
+ */
+
+#ifndef RTE_FLOW_COMPILE_H_
+#define RTE_FLOW_COMPILE_H_
+
+/**
+ * @file
+ *
+ * Compile a textual flow rule description into the array of
+ * ``struct rte_flow_item`` and ``struct rte_flow_action`` accepted by
+ * ``rte_flow_create()``.
+ *
+ * Modeled on ``pcap_compile()`` from libpcap: a single string in,
+ * an opaque compiled object out, with human readable errors written
+ * to a caller supplied buffer.
+ *
+ * The grammar is documented in the DPDK Programmer's Guide chapter
+ * "Flow rule compiler".  In summary::
+ *
+ *   rule        ::= attribute* "pattern" item-list "actions" action-list
+ *   item-list   ::= item ("/" item)* "/" "end"
+ *   action-list ::= action ("/" action)* "/" "end"
+ *
+ * Example::
+ *
+ *   ingress group 0 priority 1
+ *   pattern eth / ipv4 src is 10.0.0.1 dst is 10.0.0.2 / udp dst is 4789 / end
+ *   actions queue index 3 / count / end
+ *
+ * The compiler depends only on rte_ethdev (rte_flow.h) and the
+ * libc; in particular it does not pull in librte_cmdline.
+ */
+
+#include <stddef.h>
+#include <stdint.h>
+
+#include <rte_compat.h>
+#include <rte_flow.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/** Maximum size, in bytes, of the error buffer passed to
+ *  ``rte_flow_compile()``.  Modeled on ``PCAP_ERRBUF_SIZE``.
+ */
+#define RTE_FLOW_COMPILE_ERRBUF_SIZE 256
+
+/** Opaque handle returned by ``rte_flow_compile()``. */
+struct rte_flow_compile;
+
+/**
+ * Compile a flow rule string.
+ *
+ * @param str
+ *   Null terminated source text of the flow rule.
+ * @param errbuf
+ *   Buffer of at least ``RTE_FLOW_COMPILE_ERRBUF_SIZE`` bytes.
+ *   On failure a human readable diagnostic of the form
+ *   ``"<line>:<column>: <message>"`` is written here.
+ *   Must not be NULL.
+ *
+ * @return
+ *   On success, a newly allocated compiled rule.  The caller owns
+ *   the returned pointer and must release it with
+ *   ``rte_flow_compile_free()``.
+ *   On failure, NULL with ``errbuf`` populated and ``rte_errno`` set
+ *   to ``EINVAL`` (parse error) or ``ENOMEM``.
+ */
+__rte_experimental
+struct rte_flow_compile *
+rte_flow_compile(const char *str, char *errbuf);
+
+/**
+ * Free a compiled flow rule.
+ *
+ * Releases the rule and every buffer it transitively owns
+ * (specs, masks, last values, RSS key/queue arrays, etc.).
+ *
+ * @param fc
+ *   Compiled rule, or NULL.
+ */
+__rte_experimental
+void
+rte_flow_compile_free(struct rte_flow_compile *fc);
+
+/**
+ * Get the parsed attributes (group, priority, direction, ...).
+ */
+__rte_experimental
+const struct rte_flow_attr *
+rte_flow_compile_attr(const struct rte_flow_compile *fc);
+
+/**
+ * Get the pattern array.
+ *
+ * @param fc
+ *   Compiled rule.
+ * @param[out] nitems
+ *   If not NULL, receives the number of items including the
+ *   trailing ``RTE_FLOW_ITEM_TYPE_END``.
+ *
+ * @return
+ *   Pointer to an array of ``rte_flow_item``s suitable for passing
+ *   directly to ``rte_flow_create()``.  The array is owned by ``fc``
+ *   and is valid until ``rte_flow_compile_free()`` is called.
+ */
+__rte_experimental
+const struct rte_flow_item *
+rte_flow_compile_pattern(const struct rte_flow_compile *fc,
+			 unsigned int *nitems);
+
+/**
+ * Get the action array.
+ *
+ * Same ownership rules as ``rte_flow_compile_pattern()``.
+ */
+__rte_experimental
+const struct rte_flow_action *
+rte_flow_compile_actions(const struct rte_flow_compile *fc,
+			 unsigned int *nactions);
+
+/**
+ * Convenience: validate the compiled rule against a port.
+ *
+ * Equivalent to calling ``rte_flow_validate()`` with the compiled
+ * attributes, pattern and actions.
+ */
+__rte_experimental
+int
+rte_flow_compile_validate(uint16_t port_id,
+			  const struct rte_flow_compile *fc,
+			  struct rte_flow_error *error);
+
+/**
+ * Convenience: install the compiled rule on a port.
+ *
+ * Equivalent to calling ``rte_flow_create()`` with the compiled
+ * attributes, pattern and actions.
+ *
+ * @return
+ *   The created flow handle, or NULL with ``error`` populated.
+ *   The compiled rule itself is not consumed and may be reused
+ *   to install the same rule on multiple ports.
+ */
+__rte_experimental
+struct rte_flow *
+rte_flow_compile_create(uint16_t port_id,
+			const struct rte_flow_compile *fc,
+			struct rte_flow_error *error);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* RTE_FLOW_COMPILE_H_ */
diff --git a/lib/flow_compile/rte_flow_compile_api.c b/lib/flow_compile/rte_flow_compile_api.c
new file mode 100644
index 0000000000..3d439b2fd5
--- /dev/null
+++ b/lib/flow_compile/rte_flow_compile_api.c
@@ -0,0 +1,160 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (c) 2026 Stephen Hemminger <stephen@networkplumber.org>
+ */
+
+#include <errno.h>
+#include <stdio.h>
+
+#include <eal_export.h>
+#include <rte_errno.h>
+#include <rte_flow.h>
+#include <rte_malloc.h>
+
+#include "flow_compile_priv.h"
+#include "rte_flow_compile.h"
+#include "flow_compile.tab.h"
+
+/* Forward declarations of the flex scanner entry points.  The
+ * generated header is not in the include path, but the prototypes
+ * are stable.
+ */
+typedef void *yyscan_t;
+int   flow_compile_yylex_init_extra(struct flow_compile_ctx *cc,
+				    yyscan_t *scanner);
+int   flow_compile_yylex_destroy(yyscan_t scanner);
+struct yy_buffer_state *flow_compile_yy_scan_string(const char *str,
+						    yyscan_t scanner);
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_compile, 26.07)
+struct rte_flow_compile *
+rte_flow_compile(const char *str, char *errbuf)
+{
+	if (str == NULL || errbuf == NULL) {
+		rte_errno = EINVAL;
+		return NULL;
+	}
+	errbuf[0] = '\0';
+
+	struct rte_flow_compile *out =
+		rte_zmalloc("rte_flow_compile", sizeof(*out), 0);
+	if (out == NULL) {
+		snprintf(errbuf, RTE_FLOW_COMPILE_ERRBUF_SIZE,
+			 "0:0: out of memory");
+		rte_errno = ENOMEM;
+		return NULL;
+	}
+
+	struct flow_compile_ctx cc = {
+		.errbuf = errbuf,
+		.out    = out,
+		.line   = 1,
+		.col    = 1,
+	};
+
+	yyscan_t scanner;
+	if (flow_compile_yylex_init_extra(&cc, &scanner) != 0) {
+		snprintf(errbuf, RTE_FLOW_COMPILE_ERRBUF_SIZE,
+			 "0:0: out of memory");
+		rte_errno = ENOMEM;
+		rte_flow_compile_free(out);
+		return NULL;
+	}
+
+	if (flow_compile_yy_scan_string(str, scanner) == NULL) {
+		flow_compile_yylex_destroy(scanner);
+		snprintf(errbuf, RTE_FLOW_COMPILE_ERRBUF_SIZE,
+			 "0:0: out of memory");
+		rte_errno = ENOMEM;
+		rte_flow_compile_free(out);
+		return NULL;
+	}
+
+	int rc = flow_compile_yyparse(&cc, scanner);
+	flow_compile_yylex_destroy(scanner);
+
+	if (rc != 0) {
+		/* yyerror has populated errbuf via flow_compile_errf. */
+		rte_flow_compile_free(out);
+		return NULL;
+	}
+	return out;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_compile_free, 26.07)
+void
+rte_flow_compile_free(struct rte_flow_compile *fc)
+{
+	if (fc == NULL)
+		return;
+	if (fc->pattern != NULL) {
+		for (unsigned int i = 0; i < fc->npattern; i++) {
+			rte_free((void *)(uintptr_t)fc->pattern[i].spec);
+			rte_free((void *)(uintptr_t)fc->pattern[i].mask);
+			rte_free((void *)(uintptr_t)fc->pattern[i].last);
+		}
+		rte_free(fc->pattern);
+	}
+	if (fc->actions != NULL) {
+		for (unsigned int i = 0; i < fc->nactions; i++)
+			rte_free((void *)(uintptr_t)fc->actions[i].conf);
+		rte_free(fc->actions);
+	}
+	rte_free(fc);
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_compile_attr, 26.07)
+const struct rte_flow_attr *
+rte_flow_compile_attr(const struct rte_flow_compile *fc)
+{
+	return fc != NULL ? &fc->attr : NULL;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_compile_pattern, 26.07)
+const struct rte_flow_item *
+rte_flow_compile_pattern(const struct rte_flow_compile *fc, unsigned int *n)
+{
+	if (fc == NULL)
+		return NULL;
+	if (n != NULL)
+		*n = fc->npattern;
+	return fc->pattern;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_compile_actions, 26.07)
+const struct rte_flow_action *
+rte_flow_compile_actions(const struct rte_flow_compile *fc, unsigned int *n)
+{
+	if (fc == NULL)
+		return NULL;
+	if (n != NULL)
+		*n = fc->nactions;
+	return fc->actions;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_compile_validate, 26.07)
+int
+rte_flow_compile_validate(uint16_t port_id, const struct rte_flow_compile *fc,
+			  struct rte_flow_error *error)
+{
+	if (fc == NULL)
+		return rte_flow_error_set(error, EINVAL,
+			RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+			"compiled rule is NULL");
+	return rte_flow_validate(port_id, &fc->attr, fc->pattern, fc->actions,
+				 error);
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_compile_create, 26.07)
+struct rte_flow *
+rte_flow_compile_create(uint16_t port_id, const struct rte_flow_compile *fc,
+			struct rte_flow_error *error)
+{
+	if (fc == NULL) {
+		rte_flow_error_set(error, EINVAL,
+			RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+			"compiled rule is NULL");
+		return NULL;
+	}
+	return rte_flow_create(port_id, &fc->attr, fc->pattern, fc->actions,
+			       error);
+}
diff --git a/lib/meson.build b/lib/meson.build
index 8f5cfd28a5..aa1e8ce541 100644
--- a/lib/meson.build
+++ b/lib/meson.build
@@ -40,6 +40,7 @@ libraries = [
         'efd',
         'eventdev',
         'dispatcher', # dispatcher depends on eventdev
+        'flow_compile',
         'gpudev',
         'gro',
         'gso',
-- 
2.53.0

