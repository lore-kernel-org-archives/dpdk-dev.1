Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89412CD3427
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 May 2026 03:33:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D5EA440669;
	Wed,  6 May 2026 05:33:44 +0200 (CEST)
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
 by mails.dpdk.org (Postfix) with ESMTP id 973EC4026D
 for <dev@dpdk.org>; Wed,  6 May 2026 05:33:43 +0200 (CEST)
Received: by mail-dl1-f46.google.com with SMTP id
 a92af1059eb24-12c8f9846c8so8220816c88.0
 for <dev@dpdk.org>; Tue, 05 May 2026 20:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1778038423;
 x=1778643223; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KKKFoIZ3aTkFbdQwGSBrCywEFWriCHD/EseT6p9J4Ro=;
 b=y2W5iMxacAccGjndUHwVy1yAc9PQvBeL4we2w1WrbFcXS2I5BRpq4O7gOBSnA6TOoZ
 KCdVoTtNRC1QbC9vMYGCWm+rv7lzsrwhfNzufNvKJgxN7a76WK07KSoms9vSHrd1Qodr
 mrkCH8U96Bx1X32L65XSBtbaiCAHaNcVWlZeBCk4K51/5OlixpbR8Q2y8Gx+/UXXr9Kp
 XTz1aaq6aoiHobmvnK/zD2eEjax+ui0GPwCygJxkWfpgyhzAPG5ccLEznhzkATWPND5z
 iYDvLaTvoud6xUaNvGPR6OVVhQsfADfNnMdWHTQnE+V1Qx6GhBsi2VzdijJjCUpat5TC
 kOew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778038423; x=1778643223;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KKKFoIZ3aTkFbdQwGSBrCywEFWriCHD/EseT6p9J4Ro=;
 b=Nz8t+j3UjoWbPsUkWV4tioQS/40pkQ90DpOIoeRrebs0nOpCLoQJuor6uLgk9rzMqU
 mOiNAlExenvFYWInVy2eGUJpajwkf7CWOFxXk1AtW1EhvMnRYKLpn2t9J5OKLzjKBG62
 CbL4eQItl0GhsdjALSuSxRmIlR6ujP6YckfsGT3Podu28T7X6tEEuhqDrCMjPiC9Nwp1
 V1LOvTOV/wZaHsgW75wM5Eo6QW/zOPFlh8Wz9S8i6twxu3cN+LVGAJ5vYMNX/BYu7T4c
 h8dL59t2L2rdlSKmS4XYnLlGTsdq67zZN25Pwf43OB2BRsGmhPzNZ+rh5g5Kpq+X0YAY
 Rg4Q==
X-Gm-Message-State: AOJu0Yz1TEkM5Z1PztQSR9p6gnKSLWU+9y16nA8aBT2qmQQaVyIZaAep
 9WA1gEe6AKbzECyObg6ufsptAcSYvl029lMXB+JAXn/z5zyvnjHAd5LHrq74cnk8jZgN+zFcyJl
 Di2SH
X-Gm-Gg: AeBDies8ybO74ogrzYH00NPvYJn1d21vZ4zKuyUy3QKlBqCm80H0HtykxZc7dR/dDzY
 vCTx3Mi2/n/GbBjKkRI53hE+Cn/e79t/S8/2n2aDRDrcfZb0MUNCO5EnVunKjg8GHstQf2RJ5nJ
 iJSgS1FffCctsyz+E1kb3JYKQXmaVtScUHQF5kp/m5wUSiJGkOl1CadjcosDnO0DN94kKpkC9ga
 L4riVrstlF7/pup4Cs4AJ7gJkkGxWQc1wtQ7DDxwBgnXMztzC0I3xdF5yw06fj1s9t50p3gLDBZ
 gr+/7eBqbsOSwX8fDwcPGC62YtxffJWUfGjUxOKeUGdtywkrdU8TcuU09XxlL5hvIBiZQwOmKHH
 VfFzoX+6otbET4YQRVCxhjTKIThf1j7p8lF62rhQkMjsUpOHWqRaGfroBmHsGtok2pZ5Felpi/m
 WiN/rVk0oNWSb22AVQC2m31bsPx49EnK52SpdMsiqQsbo=
X-Received: by 2002:a05:7022:4186:b0:12d:de3f:f3d9 with SMTP id
 a92af1059eb24-1318eb537a8mr718433c88.35.1778038422152; 
 Tue, 05 May 2026 20:33:42 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-131f9679dc4sm1829479c88.3.2026.05.05.20.33.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 20:33:41 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC 1/3] flow_compile: introduce textual flow rule compiler
Date: Tue,  5 May 2026 20:29:55 -0700
Message-ID: <20260506033338.480610-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506033338.480610-1-stephen@networkplumber.org>
References: <20260505183917.370281-1-sismis@dyna-nic.com>
 <20260506033338.480610-1-stephen@networkplumber.org>
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
ready for rte_flow_create(); a convenience entry point installs
the rule directly on a port.

The parser is recursive descent driven by descriptor tables of
items and actions, so adding a new item type is purely a table
edit -- the parser has no per-type knowledge.  A custom-setter
hook handles fields whose layout cannot be expressed as a plain
byte range (bitfields, indirect arrays).

Dependencies are limited to rte_ethdev and rte_net; no
librte_cmdline, no flex/bison, no platform-specific headers.
The grammar follows testpmd's syntax so familiar rules carry
over and is documented in the programmer's guide.

Initial coverage spans the common items (eth, vlan, ipv4, ipv6,
tcp, udp, vxlan, port_id, port_representor, represented_port)
and actions (drop, passthru, queue, mark, jump, count, port_id
and representor variants, of_pop_vlan, vxlan_decap).  Items
and actions with variable-length conf (RSS, RAW) require a
custom setter and are deferred to a follow-up.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/flow_compile/flow_compile_lex.c     | 510 +++++++++++++++++++
 lib/flow_compile/flow_compile_parse.c   | 634 ++++++++++++++++++++++++
 lib/flow_compile/flow_compile_priv.h    | 181 +++++++
 lib/flow_compile/flow_compile_tables.c  | 245 +++++++++
 lib/flow_compile/meson.build            |  15 +
 lib/flow_compile/rte_flow_compile.h     | 158 ++++++
 lib/flow_compile/rte_flow_compile_api.c | 132 +++++
 lib/meson.build                         |   1 +
 8 files changed, 1876 insertions(+)
 create mode 100644 lib/flow_compile/flow_compile_lex.c
 create mode 100644 lib/flow_compile/flow_compile_parse.c
 create mode 100644 lib/flow_compile/flow_compile_priv.h
 create mode 100644 lib/flow_compile/flow_compile_tables.c
 create mode 100644 lib/flow_compile/meson.build
 create mode 100644 lib/flow_compile/rte_flow_compile.h
 create mode 100644 lib/flow_compile/rte_flow_compile_api.c

diff --git a/lib/flow_compile/flow_compile_lex.c b/lib/flow_compile/flow_compile_lex.c
new file mode 100644
index 0000000000..f58de29415
--- /dev/null
+++ b/lib/flow_compile/flow_compile_lex.c
@@ -0,0 +1,510 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (c) 2026 Stephen Hemminger <stephen@networkplumber.org>
+ */
+
+#include <errno.h>
+#include <stdarg.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <string.h>
+
+#include <rte_errno.h>
+#include <rte_ether.h>
+
+#include "flow_compile_priv.h"
+
+/*
+ * Diagnostics.
+ *
+ * On the first error we capture, all subsequent calls become no-ops
+ * so that the user sees the *first* problem (which is usually the
+ * cause) rather than a cascade.
+ */
+int
+flow_compile_errf(struct flow_compile_ctx *cc, const struct token *at,
+		  const char *fmt, ...)
+{
+	if (cc->errbuf[0] != '\0')
+		return -1;	/* keep the first error */
+
+	uint16_t line = at != NULL ? at->line : cc->line;
+	uint16_t col  = at != NULL ? at->col  : cc->col;
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
+	vsnprintf(cc->errbuf + n, (size_t)RTE_FLOW_COMPILE_ERRBUF_SIZE - (size_t)n,
+		  fmt, ap);
+	va_end(ap);
+
+	rte_errno = EINVAL;
+	return -1;
+}
+
+/* ------------------------------------------------------------------ */
+/* Character classes.
+ *
+ * The grammar is pure ASCII; using <ctype.h> would tie behavior to
+ * the active locale.  Inline predicates compile down to a single
+ * range comparison.
+ */
+
+static inline bool
+is_ascii_alpha(int c)
+{
+	return (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z');
+}
+
+static inline bool
+is_ascii_alnum(int c)
+{
+	return is_ascii_alpha(c) || (c >= '0' && c <= '9');
+}
+
+static inline bool
+is_ascii_space(int c)
+{
+	return c == ' ' || c == '\t' || c == '\n' ||
+	       c == '\r' || c == '\v' || c == '\f';
+}
+
+static inline bool
+is_word_start(int c)
+{
+	return is_ascii_alpha(c) || c == '_';
+}
+
+/*
+ * Characters that can appear inside an unquoted value lexeme.
+ * The lexer reads a run of these and then classifies the run.
+ *
+ * '_' is intentionally absent: identifiers (which are the only
+ * tokens that legitimately contain '_') are taken by the
+ * alpha-start branch in flow_compile_lex(), so '_' inside a
+ * digit-started run can never produce a useful token.
+ *
+ * '-' is included so that the IEEE 802 / Windows hyphen-separated
+ * MAC form (XX-XX-XX-XX-XX-XX) reaches match_mac(), which delegates
+ * to rte_ether_unformat_addr() and accepts it.
+ */
+static inline bool
+is_value_cont(int c)
+{
+	return is_ascii_alnum(c) || c == '.' || c == ':' || c == '-';
+}
+
+/* ------------------------------------------------------------------ */
+/* Source navigation.  All movement goes through advance() so that
+ * line/column tracking is trivially correct, including across CRLF.
+ */
+
+static void
+advance(struct flow_compile_ctx *cc, size_t n)
+{
+	for (size_t i = 0; i < n && *cc->cur != '\0'; i++) {
+		if (*cc->cur == '\n') {
+			cc->line++;
+			cc->col = 1;
+		} else {
+			cc->col++;
+		}
+		cc->cur++;
+	}
+}
+
+static void
+skip_ws_and_comments(struct flow_compile_ctx *cc)
+{
+	for (;;) {
+		while (*cc->cur != '\0' && is_ascii_space((unsigned char)*cc->cur))
+			advance(cc, 1);
+		if (*cc->cur == '#') {
+			while (*cc->cur != '\0' && *cc->cur != '\n')
+				advance(cc, 1);
+			continue;
+		}
+		break;
+	}
+}
+
+/* ------------------------------------------------------------------ */
+/* Classifiers for the value-lexeme run.
+ *
+ * These never read past ``end``; ``s`` is not required to be NUL
+ * terminated within the run.
+ */
+
+static inline bool
+is_dec_digit(int c)
+{
+	return c >= '0' && c <= '9';
+}
+
+static inline bool
+is_hex_digit(int c)
+{
+	return (c >= '0' && c <= '9') ||
+	       (c >= 'a' && c <= 'f') ||
+	       (c >= 'A' && c <= 'F');
+}
+
+static bool
+all_decimal(const char *s, size_t n)
+{
+	if (n == 0)
+		return false;
+	for (size_t i = 0; i < n; i++)
+		if (!is_dec_digit((unsigned char)s[i]))
+			return false;
+	return true;
+}
+
+static bool
+hex_prefixed(const char *s, size_t n, size_t *body_len)
+{
+	if (n < 3 || s[0] != '0' || (s[1] != 'x' && s[1] != 'X'))
+		return false;
+	for (size_t i = 2; i < n; i++)
+		if (!is_hex_digit((unsigned char)s[i]))
+			return false;
+	*body_len = n - 2;
+	return true;
+}
+
+static int
+parse_uint(const char *s, size_t n, uint64_t *out)
+{
+	uint64_t v = 0;
+	size_t i = 0;
+	int base = 10;
+
+	if (n >= 2 && s[0] == '0' && (s[1] == 'x' || s[1] == 'X')) {
+		base = 16;
+		i = 2;
+		if (i == n)
+			return -1;
+	}
+	for (; i < n; i++) {
+		uint64_t d;
+		int c = (unsigned char)s[i];
+		if (c >= '0' && c <= '9')
+			d = (uint64_t)(c - '0');
+		else if (base == 16 && c >= 'a' && c <= 'f')
+			d = (uint64_t)(c - 'a' + 10);
+		else if (base == 16 && c >= 'A' && c <= 'F')
+			d = (uint64_t)(c - 'A' + 10);
+		else
+			return -1;
+		/* overflow check */
+		if (v > (UINT64_MAX - d) / (uint64_t)base)
+			return -1;
+		v = v * (uint64_t)base + d;
+	}
+	*out = v;
+	return 0;
+}
+
+/*
+ * Hex-only integer parser.  Used by the MAC and IPv6 matchers, where
+ * the leading "0x" of the general parse_uint() is implied by context.
+ * Caller guarantees n in [1, 16].
+ */
+static int
+parse_hex(const char *s, size_t n, uint64_t *out)
+{
+	uint64_t v = 0;
+	for (size_t i = 0; i < n; i++) {
+		int c = (unsigned char)s[i];
+		uint64_t d;
+		if (c >= '0' && c <= '9')
+			d = (uint64_t)(c - '0');
+		else if (c >= 'a' && c <= 'f')
+			d = (uint64_t)(c - 'a' + 10);
+		else if (c >= 'A' && c <= 'F')
+			d = (uint64_t)(c - 'A' + 10);
+		else
+			return -1;
+		v = (v << 4) | d;
+	}
+	*out = v;
+	return 0;
+}
+
+static bool
+match_ipv4(const char *s, size_t n, uint8_t out[4])
+{
+	int parts = 0;
+	uint32_t v = 0;
+	size_t i = 0;
+	bool in_part = false;
+
+	while (i < n) {
+		int c = (unsigned char)s[i];
+		if (is_dec_digit(c)) {
+			v = v * 10u + (uint32_t)(c - '0');
+			if (v > 255u)
+				return false;
+			in_part = true;
+			i++;
+		} else if (c == '.') {
+			if (!in_part)
+				return false;
+			out[parts++] = (uint8_t)v;
+			if (parts == 4)
+				return false;
+			v = 0;
+			in_part = false;
+			i++;
+		} else {
+			return false;
+		}
+	}
+	if (!in_part || parts != 3)
+		return false;
+	out[parts] = (uint8_t)v;
+	return true;
+}
+
+/*
+ * Recognize a MAC address in any form ``rte_ether_unformat_addr()``
+ * accepts (colon-separated ``xx:xx:xx:xx:xx:xx`` and Cisco dotted
+ * ``xxxx.xxxx.xxxx``).  Delegates the actual parsing so behavior
+ * stays in lockstep with the rest of DPDK.
+ */
+static bool
+match_mac(const char *s, size_t n, uint8_t out[6])
+{
+	/* The longest accepted form is the 17-byte colon notation;
+	 * Cisco notation is 14 bytes.  Cap at 18 to leave room for the
+	 * NUL that rte_ether_unformat_addr() requires.
+	 */
+	char buf[18];
+	if (n >= sizeof(buf))
+		return false;
+	memcpy(buf, s, n);
+	buf[n] = '\0';
+
+	struct rte_ether_addr ea;
+	if (rte_ether_unformat_addr(buf, &ea) != 0)
+		return false;
+	memcpy(out, ea.addr_bytes, RTE_ETHER_ADDR_LEN);
+	return true;
+}
+
+/*
+ * IPv6 textual form per RFC 4291 / RFC 5952.
+ *
+ * Accepts:
+ *   - 8 groups of 1-4 hex digits separated by ':'
+ *   - "::" once, replacing one or more zero groups
+ *   - mixed form is *not* accepted (no embedded IPv4 dotted-quad).
+ *     This matches what the rest of DPDK uses internally.
+ */
+static bool
+match_ipv6(const char *s, size_t n, uint8_t out[16])
+{
+	uint16_t head[8] = {0};
+	uint16_t tail[8] = {0};
+	int nh = 0, nt = 0;
+	bool seen_dcolon = false;
+	size_t i = 0;
+
+	if (n >= 2 && s[0] == ':' && s[1] == ':') {
+		seen_dcolon = true;
+		i = 2;
+	}
+
+	while (i < n) {
+		/* read one hex group */
+		size_t g0 = i;
+		while (i < n && is_hex_digit((unsigned char)s[i]))
+			i++;
+		size_t glen = i - g0;
+		if (glen == 0 || glen > 4)
+			return false;
+		uint64_t v;
+		if (parse_hex(s + g0, glen, &v) < 0 || v > 0xffffu)
+			return false;
+		uint16_t *dst = seen_dcolon ? tail : head;
+		int *cnt = seen_dcolon ? &nt : &nh;
+		if (*cnt == 8)
+			return false;
+		dst[(*cnt)++] = (uint16_t)v;
+
+		if (i == n)
+			break;
+		if (s[i] != ':')
+			return false;
+		i++;
+		if (i < n && s[i] == ':') {
+			if (seen_dcolon)
+				return false;
+			seen_dcolon = true;
+			i++;
+			if (i == n)
+				break;
+		}
+	}
+
+	int total = nh + nt;
+	if (seen_dcolon) {
+		if (total >= 8)
+			return false;
+	} else {
+		if (total != 8)
+			return false;
+	}
+
+	int gap = 8 - total;
+	int p = 0;
+	for (int j = 0; j < nh; j++, p++) {
+		out[p * 2]     = (uint8_t)(head[j] >> 8);
+		out[p * 2 + 1] = (uint8_t)head[j];
+	}
+	for (int j = 0; j < gap; j++, p++) {
+		out[p * 2] = 0;
+		out[p * 2 + 1] = 0;
+	}
+	for (int j = 0; j < nt; j++, p++) {
+		out[p * 2]     = (uint8_t)(tail[j] >> 8);
+		out[p * 2 + 1] = (uint8_t)tail[j];
+	}
+	return true;
+}
+
+/* ------------------------------------------------------------------ */
+/* Quoted string handling.  We support only simple double quoted
+ * strings with backslash escaping for backslash and quote.
+ */
+
+static int
+scan_string(struct flow_compile_ctx *cc, struct token *tk)
+{
+	tk->kind = TK_STRING;
+	tk->line = cc->line;
+	tk->col  = cc->col;
+	advance(cc, 1);		/* eat opening quote */
+	tk->text = cc->cur;
+
+	while (*cc->cur != '\0' && *cc->cur != '"') {
+		if (*cc->cur == '\\' && cc->cur[1] != '\0')
+			advance(cc, 1);
+		advance(cc, 1);
+	}
+	if (*cc->cur != '"')
+		return flow_compile_errf(cc, tk, "unterminated string");
+	tk->len = (uint16_t)(cc->cur - tk->text);
+	advance(cc, 1);		/* eat closing quote */
+	return 0;
+}
+
+/* ------------------------------------------------------------------ */
+/* Top-level scan. */
+
+int
+flow_compile_lex(struct flow_compile_ctx *cc)
+{
+	skip_ws_and_comments(cc);
+
+	struct token *tk = &cc->tok;
+	memset(tk, 0, sizeof(*tk));
+	tk->line = cc->line;
+	tk->col  = cc->col;
+	tk->text = cc->cur;
+
+	int c = (unsigned char)*cc->cur;
+
+	/* Single-character tokens and EOF. */
+	switch (c) {
+	case '\0':
+		tk->kind = TK_EOF;
+		return 0;
+	case '/':
+		tk->kind = TK_SLASH;
+		tk->len = 1;
+		advance(cc, 1);
+		return 0;
+	case ',':
+		tk->kind = TK_COMMA;
+		tk->len = 1;
+		advance(cc, 1);
+		return 0;
+	case '{':
+		tk->kind = TK_LBRACE;
+		tk->len = 1;
+		advance(cc, 1);
+		return 0;
+	case '}':
+		tk->kind = TK_RBRACE;
+		tk->len = 1;
+		advance(cc, 1);
+		return 0;
+	case '"':
+		return scan_string(cc, tk);
+	default:
+		break;
+	}
+
+	/* Identifier (alpha/_ start, no dots/colons). */
+	if (is_word_start(c)) {
+		size_t len = 0;
+		while (is_ascii_alnum((unsigned char)cc->cur[len]) ||
+		       cc->cur[len] == '_')
+			len++;
+		tk->kind = TK_IDENT;
+		tk->len  = (uint16_t)len;
+		advance(cc, len);
+		return 0;
+	}
+
+	/* A value run.  We accept :: as start (IPv6) and digit start
+	 * for everything else.
+	 */
+	if (is_dec_digit(c) || c == ':') {
+		size_t len = 0;
+		while (is_value_cont((unsigned char)cc->cur[len]))
+			len++;
+		if (len == 0)
+			return flow_compile_errf(cc, NULL,
+				"unexpected character '%c'", c);
+
+		/* Classify in order: MAC (rigid shape), IPv4, hex string,
+		 * decimal, IPv6.  IPv6 is tried last because a bare hex
+		 * group like "1234" is also a valid uint.
+		 */
+		if (match_mac(cc->cur, len, tk->v.mac)) {
+			tk->kind = TK_MAC;
+		} else if (match_ipv4(cc->cur, len, tk->v.ipv4)) {
+			tk->kind = TK_IPV4;
+		} else {
+			size_t hex_body;
+			if (hex_prefixed(cc->cur, len, &hex_body) &&
+			    hex_body > 16) {
+				tk->kind = TK_HEXSTR;
+			} else if (hex_prefixed(cc->cur, len, &hex_body) ||
+				   all_decimal(cc->cur, len)) {
+				if (parse_uint(cc->cur, len, &tk->v.u) < 0)
+					return flow_compile_errf(cc, NULL,
+						"integer out of range");
+				tk->kind = TK_UINT;
+			} else if (match_ipv6(cc->cur, len, tk->v.ipv6)) {
+				tk->kind = TK_IPV6;
+			} else {
+				return flow_compile_errf(cc, NULL,
+					"unrecognized token '%.*s'",
+					(int)len, cc->cur);
+			}
+		}
+		tk->len = (uint16_t)len;
+		advance(cc, len);
+		return 0;
+	}
+
+	return flow_compile_errf(cc, NULL, "unexpected character '%c'", c);
+}
diff --git a/lib/flow_compile/flow_compile_parse.c b/lib/flow_compile/flow_compile_parse.c
new file mode 100644
index 0000000000..d39b7ef5a5
--- /dev/null
+++ b/lib/flow_compile/flow_compile_parse.c
@@ -0,0 +1,634 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (c) 2026 Stephen Hemminger <stephen@networkplumber.org>
+ */
+
+#include <errno.h>
+#include <inttypes.h>
+#include <stdint.h>
+#include <string.h>
+
+#include <rte_byteorder.h>
+#include <rte_errno.h>
+#include <rte_malloc.h>
+
+#include "flow_compile_priv.h"
+
+/* ------------------------------------------------------------------ */
+/* Token utilities. */
+
+static bool
+tok_is_ident(const struct token *t, const char *s)
+{
+	size_t n = strlen(s);
+	return t->kind == TK_IDENT && t->len == n &&
+	       memcmp(t->text, s, n) == 0;
+}
+
+/* ------------------------------------------------------------------ */
+/* Default field setters.
+ *
+ * Each setter writes the spec buffer.  If ``mask_or_null`` is non-NULL
+ * (which it will be when the user wrote ``is`` or ``mask`` or
+ * ``prefix``), the same field is written there as well.
+ */
+
+static int
+write_uint(struct flow_compile_ctx *cc, void *spec, void *mask_or_null,
+	   const struct field_desc *fd, uint64_t v, uint64_t maxv,
+	   const struct token *at)
+{
+	if (v > maxv)
+		return flow_compile_errf(cc, at,
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
+		return flow_compile_errf(cc, at,
+			"field '%s' does not accept an integer", fd->name);
+	}
+
+	if (mask_or_null != NULL)
+		memset((uint8_t *)mask_or_null + fd->offset, 0xff, fd->size);
+	return 0;
+}
+
+/* Decode a single ASCII hex digit.  The token has already been
+ * validated by the lexer so we don't need to re-check.
+ */
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
+static int
+write_bytes_token(struct flow_compile_ctx *cc, void *spec, void *mask_or_null,
+		  const struct field_desc *fd, const struct token *t)
+{
+	uint8_t *sp = (uint8_t *)spec + fd->offset;
+
+	if (t->kind == TK_HEXSTR) {
+		/* token text starts with "0x"; body length must be 2*size */
+		size_t body = (size_t)t->len - 2;
+		if (body != (size_t)fd->size * 2)
+			return flow_compile_errf(cc, t,
+				"hex string for '%s' must be %u bytes",
+				fd->name, (unsigned int)fd->size);
+		const char *p = t->text + 2;
+		for (uint16_t i = 0; i < fd->size; i++) {
+			unsigned int b = (hex_nibble((unsigned char)p[i * 2]) << 4)
+				       |  hex_nibble((unsigned char)p[i * 2 + 1]);
+			sp[i] = (uint8_t)b;
+		}
+	} else if (t->kind == TK_UINT) {
+		/* right-aligned big-endian fill */
+		uint64_t v = t->v.u;
+		for (int i = (int)fd->size - 1; i >= 0; i--) {
+			sp[i] = (uint8_t)(v & 0xffu);
+			v >>= 8;
+		}
+		if (v != 0)
+			return flow_compile_errf(cc, t,
+				"value too large for %u byte field '%s'",
+				(unsigned int)fd->size, fd->name);
+	} else {
+		return flow_compile_errf(cc, t,
+			"field '%s' expects an integer or hex string",
+			fd->name);
+	}
+
+	if (mask_or_null != NULL)
+		memset((uint8_t *)mask_or_null + fd->offset, 0xff, fd->size);
+	return 0;
+}
+
+static int
+default_field_set(struct flow_compile_ctx *cc,
+		  void *spec, void *mask_or_null,
+		  const struct field_desc *fd,
+		  const struct token *value)
+{
+	if (fd->set != NULL)
+		return fd->set(cc, spec, mask_or_null, fd, value);
+
+	uint8_t *sp = (uint8_t *)spec + fd->offset;
+
+	switch (fd->kind) {
+	case FK_U8:
+		if (value->kind != TK_UINT)
+			return flow_compile_errf(cc, value,
+				"field '%s' expects an integer", fd->name);
+		return write_uint(cc, spec, mask_or_null, fd, value->v.u,
+				  UINT8_MAX, value);
+	case FK_U16:
+	case FK_BE16:
+		if (value->kind != TK_UINT)
+			return flow_compile_errf(cc, value,
+				"field '%s' expects an integer", fd->name);
+		return write_uint(cc, spec, mask_or_null, fd, value->v.u,
+				  UINT16_MAX, value);
+	case FK_U32:
+		if (value->kind != TK_UINT)
+			return flow_compile_errf(cc, value,
+				"field '%s' expects an integer", fd->name);
+		return write_uint(cc, spec, mask_or_null, fd, value->v.u,
+				  UINT32_MAX, value);
+	case FK_U64:
+	case FK_BE64:
+		if (value->kind != TK_UINT)
+			return flow_compile_errf(cc, value,
+				"field '%s' expects an integer", fd->name);
+		return write_uint(cc, spec, mask_or_null, fd, value->v.u,
+				  UINT64_MAX, value);
+	case FK_BE32:
+		if (value->kind == TK_IPV4) {
+			memcpy(sp, value->v.ipv4, 4);
+			if (mask_or_null != NULL)
+				memset((uint8_t *)mask_or_null + fd->offset,
+				       0xff, 4);
+			return 0;
+		}
+		if (value->kind == TK_UINT)
+			return write_uint(cc, spec, mask_or_null, fd,
+					  value->v.u, UINT32_MAX, value);
+		return flow_compile_errf(cc, value,
+			"field '%s' expects an integer or IPv4 address",
+			fd->name);
+	case FK_MAC:
+		if (value->kind != TK_MAC)
+			return flow_compile_errf(cc, value,
+				"field '%s' expects a MAC address", fd->name);
+		memcpy(sp, value->v.mac, 6);
+		if (mask_or_null != NULL)
+			memset((uint8_t *)mask_or_null + fd->offset, 0xff, 6);
+		return 0;
+	case FK_IPV4:
+		if (value->kind != TK_IPV4)
+			return flow_compile_errf(cc, value,
+				"field '%s' expects an IPv4 address",
+				fd->name);
+		memcpy(sp, value->v.ipv4, 4);
+		if (mask_or_null != NULL)
+			memset((uint8_t *)mask_or_null + fd->offset, 0xff, 4);
+		return 0;
+	case FK_IPV6:
+		if (value->kind != TK_IPV6)
+			return flow_compile_errf(cc, value,
+				"field '%s' expects an IPv6 address",
+				fd->name);
+		memcpy(sp, value->v.ipv6, 16);
+		if (mask_or_null != NULL)
+			memset((uint8_t *)mask_or_null + fd->offset, 0xff, 16);
+		return 0;
+	case FK_BYTES:
+		return write_bytes_token(cc, spec, mask_or_null, fd, value);
+	}
+	return flow_compile_errf(cc, value,
+		"internal error: unknown field kind for '%s'", fd->name);
+}
+
+/*
+ * Apply ``prefix N`` (CIDR-style mask helper) to an IPv4 or IPv6 field.
+ * Spec is left untouched; only mask is written.  No mask bits are
+ * cleared from previously written ones -- last write wins, identical
+ * to testpmd.
+ */
+static int
+apply_prefix(struct flow_compile_ctx *cc, void *mask,
+	     const struct field_desc *fd, const struct token *value)
+{
+	if (value->kind != TK_UINT)
+		return flow_compile_errf(cc, value,
+			"prefix expects an integer");
+
+	uint32_t bits = (uint32_t)value->v.u;
+	uint32_t total = fd->size * 8u;
+	if (bits > total)
+		return flow_compile_errf(cc, value,
+			"prefix %u exceeds %u bits for '%s'",
+			bits, total, fd->name);
+
+	if (fd->kind != FK_IPV4 && fd->kind != FK_IPV6 &&
+	    fd->kind != FK_BE32)
+		return flow_compile_errf(cc, value,
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
+/* Attribute parsing. */
+
+static int
+parse_attrs(struct flow_compile_ctx *cc, struct rte_flow_attr *attr)
+{
+	for (;;) {
+		if (cc->tok.kind != TK_IDENT)
+			return 0;
+
+		if (tok_is_ident(&cc->tok, "ingress")) {
+			attr->ingress = 1;
+		} else if (tok_is_ident(&cc->tok, "egress")) {
+			attr->egress = 1;
+		} else if (tok_is_ident(&cc->tok, "transfer")) {
+			attr->transfer = 1;
+		} else if (tok_is_ident(&cc->tok, "group")) {
+			if (flow_compile_lex(cc) < 0)
+				return -1;
+			if (cc->tok.kind != TK_UINT ||
+			    cc->tok.v.u > UINT32_MAX)
+				return flow_compile_errf(cc, &cc->tok,
+					"group expects uint32");
+			attr->group = (uint32_t)cc->tok.v.u;
+		} else if (tok_is_ident(&cc->tok, "priority")) {
+			if (flow_compile_lex(cc) < 0)
+				return -1;
+			if (cc->tok.kind != TK_UINT ||
+			    cc->tok.v.u > UINT32_MAX)
+				return flow_compile_errf(cc, &cc->tok,
+					"priority expects uint32");
+			attr->priority = (uint32_t)cc->tok.v.u;
+		} else {
+			/* not an attribute -- next clause */
+			return 0;
+		}
+
+		if (flow_compile_lex(cc) < 0)
+			return -1;
+	}
+}
+
+/* ------------------------------------------------------------------ */
+/* Item body.  Returns 0 on the trailing slash, -1 on error. */
+
+/*
+ * Parse the field list of one item.  Allocates spec/mask/last
+ * directly into ``item->spec/mask/last`` so that on failure the
+ * partial state is reachable from rte_flow_compile_free() through
+ * the caller's pattern array, which performs the cleanup.
+ *
+ * Buffers that turn out not to be referenced (e.g. only ``spec`` is
+ * given, no ``mask`` or ``last``) are freed and the corresponding
+ * slot zeroed before successful return so that the PMD's
+ * default-mask logic kicks in.
+ */
+static int
+parse_item_fields(struct flow_compile_ctx *cc,
+		  const struct flow_item_desc *desc,
+		  struct rte_flow_item *item)
+{
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
+	bool spec_used = false, mask_used = false, last_used = false;
+
+	/* These cast away const for write access; the public API
+	 * presents them as const but the parser owns them until
+	 * compile completes.
+	 */
+	void *spec = (void *)(uintptr_t)item->spec;
+	void *mask = (void *)(uintptr_t)item->mask;
+	void *last = (void *)(uintptr_t)item->last;
+
+	while (cc->tok.kind == TK_IDENT) {
+		struct token name = cc->tok;
+		const struct field_desc *fd =
+			flow_compile_field_lookup(desc->fields, desc->nfields,
+						  name.text, name.len);
+		if (fd == NULL)
+			return flow_compile_errf(cc, &name,
+				"unknown field '%.*s' for item '%s'",
+				(int)name.len, name.text, desc->name);
+
+		if (flow_compile_lex(cc) < 0)
+			return -1;
+		if (cc->tok.kind != TK_IDENT)
+			return flow_compile_errf(cc, &cc->tok,
+				"expected is/spec/last/mask/prefix after '%s'",
+				fd->name);
+
+		struct token suffix = cc->tok;
+		if (flow_compile_lex(cc) < 0)
+			return -1;
+		struct token value = cc->tok;
+
+		if (tok_is_ident(&suffix, "is")) {
+			if (default_field_set(cc, spec, mask, fd, &value) < 0)
+				return -1;
+			spec_used = mask_used = true;
+		} else if (tok_is_ident(&suffix, "spec")) {
+			if (default_field_set(cc, spec, NULL, fd, &value) < 0)
+				return -1;
+			spec_used = true;
+		} else if (tok_is_ident(&suffix, "last")) {
+			if (default_field_set(cc, last, NULL, fd, &value) < 0)
+				return -1;
+			last_used = true;
+		} else if (tok_is_ident(&suffix, "mask")) {
+			if (default_field_set(cc, mask, NULL, fd, &value) < 0)
+				return -1;
+			mask_used = true;
+		} else if (tok_is_ident(&suffix, "prefix")) {
+			if (apply_prefix(cc, mask, fd, &value) < 0)
+				return -1;
+			mask_used = true;
+		} else {
+			return flow_compile_errf(cc, &suffix,
+				"unknown qualifier '%.*s'",
+				(int)suffix.len, suffix.text);
+		}
+
+		if (flow_compile_lex(cc) < 0)
+			return -1;
+	}
+
+	/* Drop unused buffers; the PMD treats NULL as default. */
+	if (!spec_used) {
+		rte_free(spec);
+		item->spec = NULL;
+	}
+	if (!mask_used) {
+		rte_free(mask);
+		item->mask = NULL;
+	}
+	if (!last_used) {
+		rte_free(last);
+		item->last = NULL;
+	}
+	return 0;
+}
+
+static int
+parse_pattern(struct flow_compile_ctx *cc, struct rte_flow_compile *out)
+{
+	if (!tok_is_ident(&cc->tok, "pattern"))
+		return flow_compile_errf(cc, &cc->tok, "expected 'pattern'");
+	if (flow_compile_lex(cc) < 0)
+		return -1;
+
+	size_t cap = 8;
+	out->pattern = rte_calloc("flow_compile_pattern", cap,
+				  sizeof(*out->pattern), 0);
+	if (out->pattern == NULL) {
+		rte_errno = ENOMEM;
+		return -1;
+	}
+	/* From here on, out->pattern is reachable from
+	 * rte_flow_compile_free(), which walks [0, out->npattern) and
+	 * frees each non-NULL spec/mask/last before freeing the array.
+	 * Increment out->npattern only after a slot is fully owned.
+	 */
+
+	for (;;) {
+		if (cc->tok.kind != TK_IDENT)
+			return flow_compile_errf(cc, &cc->tok,
+				"expected item name");
+
+		if (tok_is_ident(&cc->tok, "end"))
+			break;
+
+		struct token name = cc->tok;
+		const struct flow_item_desc *desc =
+			flow_compile_item_lookup(name.text, name.len);
+		if (desc == NULL)
+			return flow_compile_errf(cc, &name,
+				"unknown flow item '%.*s'",
+				(int)name.len, name.text);
+
+		if (flow_compile_lex(cc) < 0)
+			return -1;
+
+		/* Reserve a slot, growing the array if needed.  ``+1``
+		 * leaves room for the trailing END sentinel.
+		 */
+		if (out->npattern + 1 >= cap) {
+			cap *= 2;
+			struct rte_flow_item *p =
+				rte_realloc(out->pattern,
+					    cap * sizeof(*p), 0);
+			if (p == NULL) {
+				rte_errno = ENOMEM;
+				return -1;
+			}
+			out->pattern = p;
+		}
+
+		/* Zero the slot before parse_item_fields() touches it
+		 * so partial allocations are visible to the cleanup
+		 * walker without ever observing garbage in the freshly
+		 * grown realloc tail.  Then publish via npattern++.
+		 */
+		struct rte_flow_item *item = &out->pattern[out->npattern];
+		memset(item, 0, sizeof(*item));
+		item->type = desc->type;
+		out->npattern++;
+
+		if (parse_item_fields(cc, desc, item) < 0)
+			return -1;
+
+		if (cc->tok.kind != TK_SLASH)
+			return flow_compile_errf(cc, &cc->tok,
+				"expected '/' after item '%s'", desc->name);
+		if (flow_compile_lex(cc) < 0)
+			return -1;
+	}
+
+	/* Trailing END.  The reserved capacity always has room
+	 * because the loop's growth check leaves +1 spare.
+	 */
+	struct rte_flow_item *end = &out->pattern[out->npattern];
+	memset(end, 0, sizeof(*end));	/* type = END = 0, no buffers */
+	out->npattern++;
+
+	if (flow_compile_lex(cc) < 0)
+		return -1;	/* consume 'end' */
+	return 0;
+}
+
+/* ------------------------------------------------------------------ */
+/* Action body. */
+
+static int
+parse_action_fields(struct flow_compile_ctx *cc,
+		    const struct flow_action_desc *desc,
+		    struct rte_flow_action *act)
+{
+	if (desc->conf_size > 0) {
+		act->conf = rte_zmalloc("flow_compile", desc->conf_size, 0);
+		if (act->conf == NULL) {
+			rte_errno = ENOMEM;
+			return -1;
+		}
+	}
+	bool conf_used = false;
+	void *conf = (void *)(uintptr_t)act->conf;
+
+	while (cc->tok.kind == TK_IDENT &&
+	       !tok_is_ident(&cc->tok, "end")) {
+		struct token name = cc->tok;
+		const struct field_desc *fd =
+			flow_compile_field_lookup(desc->fields, desc->nfields,
+						  name.text, name.len);
+		if (fd == NULL)
+			return flow_compile_errf(cc, &name,
+				"unknown parameter '%.*s' for action '%s'",
+				(int)name.len, name.text, desc->name);
+
+		if (flow_compile_lex(cc) < 0)
+			return -1;
+		struct token value = cc->tok;
+		if (default_field_set(cc, conf, NULL, fd, &value) < 0)
+			return -1;
+		conf_used = true;
+
+		if (flow_compile_lex(cc) < 0)
+			return -1;
+	}
+
+	if (!conf_used) {
+		rte_free(conf);
+		act->conf = NULL;
+	}
+	return 0;
+}
+
+static int
+parse_actions(struct flow_compile_ctx *cc, struct rte_flow_compile *out)
+{
+	if (!tok_is_ident(&cc->tok, "actions"))
+		return flow_compile_errf(cc, &cc->tok, "expected 'actions'");
+	if (flow_compile_lex(cc) < 0)
+		return -1;
+
+	size_t cap = 8;
+	out->actions = rte_calloc("flow_compile_actions", cap,
+				  sizeof(*out->actions), 0);
+	if (out->actions == NULL) {
+		rte_errno = ENOMEM;
+		return -1;
+	}
+
+	for (;;) {
+		if (cc->tok.kind != TK_IDENT)
+			return flow_compile_errf(cc, &cc->tok,
+				"expected action name");
+
+		if (tok_is_ident(&cc->tok, "end"))
+			break;
+
+		struct token name = cc->tok;
+		const struct flow_action_desc *desc =
+			flow_compile_action_lookup(name.text, name.len);
+		if (desc == NULL)
+			return flow_compile_errf(cc, &name,
+				"unknown flow action '%.*s'",
+				(int)name.len, name.text);
+
+		if (flow_compile_lex(cc) < 0)
+			return -1;
+
+		if (out->nactions + 1 >= cap) {
+			cap *= 2;
+			struct rte_flow_action *p =
+				rte_realloc(out->actions,
+					    cap * sizeof(*p), 0);
+			if (p == NULL) {
+				rte_errno = ENOMEM;
+				return -1;
+			}
+			out->actions = p;
+		}
+
+		struct rte_flow_action *act = &out->actions[out->nactions];
+		memset(act, 0, sizeof(*act));
+		act->type = desc->type;
+		out->nactions++;
+
+		if (parse_action_fields(cc, desc, act) < 0)
+			return -1;
+
+		if (cc->tok.kind != TK_SLASH)
+			return flow_compile_errf(cc, &cc->tok,
+				"expected '/' after action '%s'", desc->name);
+		if (flow_compile_lex(cc) < 0)
+			return -1;
+	}
+
+	struct rte_flow_action *end = &out->actions[out->nactions];
+	memset(end, 0, sizeof(*end));	/* type = END = 0, no conf */
+	out->nactions++;
+
+	if (flow_compile_lex(cc) < 0)
+		return -1;	/* consume 'end' */
+	return 0;
+}
+
+/* ------------------------------------------------------------------ */
+/* Top level. */
+
+int
+flow_compile_parse(struct flow_compile_ctx *cc, struct rte_flow_compile *out)
+{
+	if (flow_compile_lex(cc) < 0)
+		return -1;
+
+	if (parse_attrs(cc, &out->attr) < 0)
+		return -1;
+	if (parse_pattern(cc, out) < 0)
+		return -1;
+	if (parse_actions(cc, out) < 0)
+		return -1;
+
+	if (cc->tok.kind != TK_EOF)
+		return flow_compile_errf(cc, &cc->tok,
+			"unexpected token after rule");
+	return 0;
+}
diff --git a/lib/flow_compile/flow_compile_priv.h b/lib/flow_compile/flow_compile_priv.h
new file mode 100644
index 0000000000..557f488392
--- /dev/null
+++ b/lib/flow_compile/flow_compile_priv.h
@@ -0,0 +1,181 @@
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
+#include <rte_flow.h>
+
+#include "rte_flow_compile.h"
+
+/*
+ * The lexer recognizes a small set of token classes.  All of the
+ * non-trivial classes carry their value in ``union token_value``.
+ * Source position is recorded for diagnostics.
+ */
+enum token_kind {
+	TK_EOF = 0,
+	TK_SLASH,	/* '/'  */
+	TK_COMMA,	/* ','  */
+	TK_LBRACE,	/* '{'  */
+	TK_RBRACE,	/* '}'  */
+	TK_IDENT,	/* keyword or identifier  */
+	TK_UINT,	/* decimal or hex integer  */
+	TK_IPV4,	/* a.b.c.d  */
+	TK_IPV6,	/* xxxx:yyyy:...  */
+	TK_MAC,		/* xx:xx:xx:xx:xx:xx  */
+	TK_HEXSTR,	/* 0x..., even number of hex digits  */
+	TK_STRING,	/* "...."  */
+};
+
+/*
+ * Tokens own no heap memory; identifiers/strings/hex point into
+ * the source text.  Length is explicit so we never rely on NUL
+ * termination during scanning.
+ */
+struct token {
+	enum token_kind kind;
+	uint16_t line;
+	uint16_t col;
+	const char *text;	/* start in source string  */
+	uint16_t len;		/* length in bytes  */
+	union {
+		uint64_t u;
+		uint8_t  ipv4[4];
+		uint8_t  ipv6[16];
+		uint8_t  mac[6];
+	} v;
+};
+
+/*
+ * Descriptor for a single field within a flow item or action spec.
+ *
+ * The default setter handles the common kinds below.  ``set`` may be
+ * non-NULL for fields whose layout cannot be expressed as a plain
+ * byte range (bitfields, indirect arrays, etc.).
+ */
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
+struct flow_compile_ctx;	/* forward */
+
+/*
+ * Storage for one compiled rule.  Each spec/mask/last/conf payload
+ * is its own rte_zmalloc; ``rte_flow_compile_free()`` walks the
+ * pattern and action arrays and frees each non-NULL slot before
+ * freeing the arrays themselves.
+ */
+struct rte_flow_compile {
+	struct rte_flow_attr  attr;
+	struct rte_flow_item *pattern;
+	unsigned int          npattern;
+	struct rte_flow_action *actions;
+	unsigned int          nactions;
+};
+
+struct field_desc {
+	const char *name;
+	uint16_t offset;	/* offset inside spec/mask/last struct */
+	uint16_t size;		/* size in bytes (used by FK_BYTES) */
+	enum field_kind kind;
+
+	/*
+	 * Optional custom setter.  When non-NULL the framework calls
+	 * this instead of doing its default copy.
+	 *
+	 * @param dst      Buffer to write the value into (spec, mask
+	 *                 or last, depending on which qualifier the
+	 *                 user wrote).
+	 * @param mask_dst If non-NULL, the function should additionally
+	 *                 set the corresponding mask bits to all-ones,
+	 *                 i.e. realize ``is`` semantics.  When NULL,
+	 *                 the function writes only ``dst``.
+	 * @param value    The token holding the parsed literal.
+	 *
+	 * @return 0 on success, -1 with cc->errbuf set on failure.
+	 */
+	int (*set)(struct flow_compile_ctx *cc,
+		   void *dst, void *mask_dst,
+		   const struct field_desc *fd,
+		   const struct token *value);
+};
+
+/* One entry per RTE_FLOW_ITEM_TYPE_* we recognize. */
+struct flow_item_desc {
+	const char *name;
+	enum rte_flow_item_type type;
+	uint16_t spec_size;	/* sizeof(struct rte_flow_item_<type>); 0 if void */
+	const struct field_desc *fields;
+	uint16_t nfields;
+};
+
+/* One entry per RTE_FLOW_ACTION_TYPE_* we recognize. */
+struct flow_action_desc {
+	const char *name;
+	enum rte_flow_action_type type;
+	uint16_t conf_size;	/* sizeof(struct rte_flow_action_<type>); 0 if void */
+	const struct field_desc *fields;
+	uint16_t nfields;
+};
+
+/* Lookup helpers (defined in flow_compile_tables.c). */
+const struct flow_item_desc   *flow_compile_item_lookup(const char *name, size_t len);
+const struct flow_action_desc *flow_compile_action_lookup(const char *name, size_t len);
+const struct field_desc *flow_compile_field_lookup(const struct field_desc *tbl,
+						   uint16_t n,
+						   const char *name, size_t len);
+
+/*
+ * Compile context shared by the lexer, parser and table-driven
+ * field setters.  Lives only for the duration of one compile call.
+ *
+ * The parser is straight-line recursive descent against the current
+ * token; there is no token pushback.
+ */
+struct flow_compile_ctx {
+	/* source */
+	const char *src;
+	const char *cur;
+	uint16_t line;
+	uint16_t col;
+
+	/* current token (set by flow_compile_lex) */
+	struct token tok;
+
+	/* output (errbuf is owned by caller) */
+	char *errbuf;
+
+	/* destination compile object */
+	struct rte_flow_compile *out;
+};
+
+/* Lexer: scan next token into cc->tok.  Returns 0 on success, -1 on
+ * lex error (errbuf populated).
+ */
+int flow_compile_lex(struct flow_compile_ctx *cc);
+
+/* Parser entry point. */
+int flow_compile_parse(struct flow_compile_ctx *cc,
+		       struct rte_flow_compile *out);
+
+/* Diagnostic helper.  Always sets rte_errno = EINVAL and returns -1. */
+int flow_compile_errf(struct flow_compile_ctx *cc, const struct token *at,
+		      const char *fmt, ...) __rte_format_printf(3, 4);
+
+#endif /* FLOW_COMPILE_PRIV_H_ */
diff --git a/lib/flow_compile/flow_compile_tables.c b/lib/flow_compile/flow_compile_tables.c
new file mode 100644
index 0000000000..20db7f155e
--- /dev/null
+++ b/lib/flow_compile/flow_compile_tables.c
@@ -0,0 +1,245 @@
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
+ * FIELD_CUSTOM: an alias whose semantics need a custom setter.
+ */
+#define FIELD(_n, _s, _m, _k)						\
+	{ .name = (_n), .offset = offsetof(_s, _m),			\
+	  .size = sizeof(((_s *)0)->_m), .kind = (_k), .set = NULL }
+
+#define FIELD_BYTES(_n, _s, _m)						\
+	{ .name = (_n), .offset = offsetof(_s, _m),			\
+	  .size = sizeof(((_s *)0)->_m), .kind = FK_BYTES, .set = NULL }
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
+	FIELD("tos",		 struct rte_flow_item_ipv4, hdr.type_of_service, FK_U8),
+	FIELD("ttl",		 struct rte_flow_item_ipv4, hdr.time_to_live,	 FK_U8),
+	FIELD("proto",		 struct rte_flow_item_ipv4, hdr.next_proto_id,	 FK_U8),
+	FIELD("src",		 struct rte_flow_item_ipv4, hdr.src_addr,	 FK_IPV4),
+	FIELD("dst",		 struct rte_flow_item_ipv4, hdr.dst_addr,	 FK_IPV4),
+	FIELD("fragment_offset", struct rte_flow_item_ipv4, hdr.fragment_offset, FK_BE16),
+	FIELD("packet_id",	 struct rte_flow_item_ipv4, hdr.packet_id,	 FK_BE16),
+	FIELD("total_length",	 struct rte_flow_item_ipv4, hdr.total_length,	 FK_BE16),
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
+	FIELD("src",		struct rte_flow_item_tcp, hdr.src_port,	 FK_BE16),
+	FIELD("dst",		struct rte_flow_item_tcp, hdr.dst_port,	 FK_BE16),
+	FIELD("flags",		struct rte_flow_item_tcp, hdr.tcp_flags, FK_U8),
+};
+
+static const struct field_desc udp_fields[] = {
+	FIELD("src",		struct rte_flow_item_udp, hdr.src_port,	FK_BE16),
+	FIELD("dst",		struct rte_flow_item_udp, hdr.dst_port,	FK_BE16),
+};
+
+/* ------------------------------------------------------------------ */
+/* vxlan -- the vni field is 24 bits stored as 3 raw bytes.  We expose
+ * it as a 4-byte BE value where the low 24 bits are user supplied;
+ * the table-driven setter handles the truncation.  A purist would add
+ * a custom setter; the result here is identical and avoids the noise.
+ */
+
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
index 0000000000..c8b088af3d
--- /dev/null
+++ b/lib/flow_compile/meson.build
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2026 Stephen Hemminger
+
+sources += files(
+        'flow_compile_lex.c',
+        'flow_compile_parse.c',
+        'flow_compile_tables.c',
+        'rte_flow_compile_api.c',
+)
+
+headers += files(
+        'rte_flow_compile.h',
+)
+
+deps += ['ethdev']
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
index 0000000000..92a80d4a24
--- /dev/null
+++ b/lib/flow_compile/rte_flow_compile_api.c
@@ -0,0 +1,132 @@
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
+		.src = str,
+		.cur = str,
+		.line = 1,
+		.col  = 1,
+		.errbuf = errbuf,
+		.out = out,
+	};
+
+	if (flow_compile_parse(&cc, out) < 0) {
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
+			/* Cast through uintptr_t to drop the API's
+			 * const without -Wcast-qual; the parser owns
+			 * these allocations.
+			 */
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

