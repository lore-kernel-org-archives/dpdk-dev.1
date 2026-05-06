Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C12BCD3427
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 May 2026 03:33:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B5CD8402D1;
	Wed,  6 May 2026 05:33:46 +0200 (CEST)
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
 by mails.dpdk.org (Postfix) with ESMTP id ABAD44060A
 for <dev@dpdk.org>; Wed,  6 May 2026 05:33:44 +0200 (CEST)
Received: by mail-dl1-f46.google.com with SMTP id
 a92af1059eb24-12c88e5f4aeso383372c88.0
 for <dev@dpdk.org>; Tue, 05 May 2026 20:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1778038424;
 x=1778643224; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aPwQn7DvMD2UbzArLI3AEsM97xnKNa6lYBsyMPqMRKg=;
 b=o1yrACl7HuD1QlcYa/X3iJAeGk0ASvA5WNRg4FJ0HrEGsvCt9VRjVAADdRbq3nb6o4
 4rkzRgfY2fkwG5m2l2GuEN4aNQJznuFFKw093SJR0jT05OqPWptdTIK/Pt7swQ3+pVPh
 f3I8EBAPrthwCAPYtfOr4pd/63MWZ/08LNOEfnl7FzHCJjJleG8cUyZvlp38coX56Zcw
 aoSUyAtLwMI0ZJ7gAJdahAvagIzC5WcTmJIwvq7aPhPow5ENODC5TKk9hPAJOwhmHRrp
 RHBBWp17QBYJSma57jmSw/VHzI5KveJ98Ys3UeooheB4el1/35khMD9yeAiugSQ7h5Yn
 9hDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778038424; x=1778643224;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aPwQn7DvMD2UbzArLI3AEsM97xnKNa6lYBsyMPqMRKg=;
 b=JBvNBSOwJLgRgzW5iOxX4+Nrc12SPCo9drOZmmZ8zeDda29KoeVSVCNa9SlQVaaEvX
 NjKWNDZWR2jWly6L3YKw4HLWD/HCZnsuKrLBQgtGRldOdo0t2PSNHvWZXnu2FoDdEpP9
 xbb+8xHC+9Tj5ytTOr+5a5CEh49lX4GDzWaM6w9e6paBFTHVmWEJ4TXnh+RDAFzYjd0e
 /M4YHS4iWqzau3Yd0JWf9gsim+Fd7nJxqjUwJRD4ROTCfhTaSPqJpFXo02YtToNt6cuO
 50Qc0uGmG9VzChAHR5qGhOvjfb4x5n7Aahj59kpUgpXmnhQJlMGF4fT7DRCTkYJjo16w
 Pibg==
X-Gm-Message-State: AOJu0YyJ4axyoqqbcDKCeB/jGf/nZmTgF/XKwLDsOtxiVbqV90f05Myk
 E5aMlRbOHRh9u1PCM+7jKuug5iex4zjN34Rb5h+gYCb+TGporcyYOv/EVYZWgoPsWyLRM3HRUlk
 +wx3O
X-Gm-Gg: AeBDieuHluDV21VLG4hWBsJgLRlruzCBMffHoyH3P5wPRXc/f9UjsR2eQcrr9ueSPPc
 4mtsT0pmM7LkgSJKlnuOuolrzW4Nn9zcBbCKT2v+uz4HRMTjit1MGk6wmvXCuzlH4cCDbZekYOi
 XD7Ly6NGRg1AIvkJfUTFIQTeWEzGbHWoucbbKy9qHTGwH71Bbf7FTIOviUOyOdo7+MxA1Q8DEFo
 C9B5GrZGtxzNfd4uj1L5b5AhLpXRMu6oEFMjVaoe9QrSQwXCW11RGfyT6WpxFXxCvmKazL28MFe
 8AVL+Eak9tYQs/SqsofTD85fq5ku3yqAggHKzPtwuVMsQer7BmequTZgE6IlTrm5cLyzV8/TTKg
 BOXeUMWvgf/A4J/U4J0fu5O7QM3u2f0TMKH0uFrDlLUmvNGiLWbGb2msvcSV7jUVmelaUCGD1UH
 zeevoBLpplzg8E3NJoMtpSzDAGm5XUfC5T56vBUjjoYqI=
X-Received: by 2002:a05:7022:45a2:b0:130:8ed9:204c with SMTP id
 a92af1059eb24-130a98f8e5emr3023764c88.10.1778038423416; 
 Tue, 05 May 2026 20:33:43 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-131f9679dc4sm1829479c88.3.2026.05.05.20.33.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 20:33:42 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [RFC 2/3] doc: add programmer's guide for flow rule compiler
Date: Tue,  5 May 2026 20:29:56 -0700
Message-ID: <20260506033338.480610-3-stephen@networkplumber.org>
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

Add a chapter to the programmer's guide describing the new
rte_flow_compile library: API summary, BNF grammar, field
qualifier semantics (is/spec/last/mask/prefix), diagnostic
format, and the table-driven extension model for adding
items and actions.

Documents the limitations of the initial implementation
(item/action coverage, missing RSS and RAW handling) and
the textual MAC and IPv6 forms accepted.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 MAINTAINERS                                |   6 +
 doc/guides/prog_guide/flow_compile_lib.rst | 272 +++++++++++++++++++++
 doc/guides/prog_guide/index.rst            |   1 +
 doc/guides/rel_notes/release_26_07.rst     |   6 +
 4 files changed, 285 insertions(+)
 create mode 100644 doc/guides/prog_guide/flow_compile_lib.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index 0f5539f851..4923e126df 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -448,6 +448,12 @@ F: app/test-pmd/cmdline_flow.c
 F: doc/guides/prog_guide/ethdev/flow_offload.rst
 F: lib/ethdev/rte_flow*
 
+Flow Compiler API
+M: Stephen Hemminger <stephen@networkplumber.org>
+T: git://dpdk.org/next/dpdk-next-net
+F: lib/flow_compile/
+F: doc/guides/prog_guide/flow_compile_lib.rst
+
 Traffic Management API
 M: Cristian Dumitrescu <cristian.dumitrescu@intel.com>
 T: git://dpdk.org/next/dpdk-next-net
diff --git a/doc/guides/prog_guide/flow_compile_lib.rst b/doc/guides/prog_guide/flow_compile_lib.rst
new file mode 100644
index 0000000000..8af374b33b
--- /dev/null
+++ b/doc/guides/prog_guide/flow_compile_lib.rst
@@ -0,0 +1,272 @@
+..  SPDX-License-Identifier: BSD-3-Clause
+    Copyright (c) 2026 Stephen Hemminger <stephen@networkplumber.org>
+
+Flow Rule Compiler
+==================
+
+The flow rule compiler (``rte_flow_compile``) turns a textual
+description of an ``rte_flow`` rule into the
+``struct rte_flow_attr`` / ``struct rte_flow_item`` /
+``struct rte_flow_action`` arrays accepted by ``rte_flow_create()``.
+
+It is modelled on ``pcap_compile()`` from libpcap: a single string in,
+an opaque compiled object out, with human readable diagnostics
+written to a caller supplied buffer.
+
+The compiler depends only on the EAL and the existing
+``rte_ethdev`` (``rte_flow.h``) library.  In particular it does not
+pull in ``rte_cmdline``, so it is suitable for use from libraries,
+control planes and unit tests.
+
+
+Example
+-------
+
+.. code-block:: c
+
+   char errbuf[RTE_FLOW_COMPILE_ERRBUF_SIZE];
+   const char *src =
+       "ingress group 0 priority 1 "
+       "pattern eth / ipv4 src is 10.0.0.1 / udp dst is 4789 / end "
+       "actions queue index 3 / count / end";
+
+   struct rte_flow_compile *fc = rte_flow_compile(src, errbuf);
+   if (fc == NULL) {
+           fprintf(stderr, "%s\n", errbuf);
+           return -1;
+   }
+
+   struct rte_flow_error err;
+   struct rte_flow *f = rte_flow_compile_create(port_id, fc, &err);
+
+   /* fc may be reused on multiple ports or freed now. */
+   rte_flow_compile_free(fc);
+
+
+API summary
+-----------
+
+.. code-block:: c
+
+   struct rte_flow_compile *
+   rte_flow_compile(const char *str,
+                    char errbuf[RTE_FLOW_COMPILE_ERRBUF_SIZE]);
+
+   void
+   rte_flow_compile_free(struct rte_flow_compile *fc);
+
+   const struct rte_flow_attr   *rte_flow_compile_attr(...);
+   const struct rte_flow_item   *rte_flow_compile_pattern(..., unsigned int *n);
+   const struct rte_flow_action *rte_flow_compile_actions(..., unsigned int *n);
+
+   int             rte_flow_compile_validate(uint16_t port_id, ..., struct rte_flow_error *);
+   struct rte_flow *rte_flow_compile_create  (uint16_t port_id, ..., struct rte_flow_error *);
+
+The compiled object owns every buffer it returns: attributes,
+patterns, actions and all underlying spec/mask/last/conf payloads.
+Pointers are valid until ``rte_flow_compile_free()`` is called.
+A single compiled rule may be installed on many ports and validated
+or created concurrently from multiple threads; the parser itself
+holds no static mutable state.
+
+
+Grammar
+-------
+
+The grammar is pure ASCII; ``#`` starts an end-of-line comment.
+Whitespace is insignificant.
+
+.. code-block:: bnf
+
+   rule         ::= attribute* "pattern" item-list "actions" action-list
+   attribute    ::= "ingress" | "egress" | "transfer"
+                  | "group"    UINT
+                  | "priority" UINT
+   item-list    ::= ( item "/" )* "end"
+   item         ::= IDENT field-spec*
+   field-spec   ::= IDENT qualifier value
+   qualifier    ::= "is" | "spec" | "last" | "mask" | "prefix"
+   action-list  ::= ( action "/" )* "end"
+   action       ::= IDENT param*
+   param        ::= IDENT value
+   value        ::= UINT | IPV4 | IPV6 | MAC | HEXSTR | STRING
+
+Both lists may be empty; ``pattern end`` is a wildcard match and is
+useful as a catch-all rule.  An empty action list is accepted by the
+compiler but typically rejected by the underlying PMD.
+
+Lexical tokens:
+
+.. code-block:: bnf
+
+   IDENT        ::= [A-Za-z_][A-Za-z0-9_]*
+   UINT         ::= [0-9]+ | "0x" [0-9A-Fa-f]+         ; up to 16 hex digits
+   IPV4         ::= UINT "." UINT "." UINT "." UINT    ; each 0..255
+   IPV6         ::= RFC 4291 / 5952 textual form (no embedded IPv4)
+   MAC          ::= XX ":" XX ":" XX ":" XX ":" XX ":" XX
+   HEXSTR       ::= "0x" [0-9A-Fa-f]{2*N}              ; > 16 hex digits
+   STRING       ::= '"' character* '"'
+
+The grammar follows ``testpmd`` closely so that flow rules already
+familiar to users carry over; the lexer and parser are independent
+implementations and do not depend on testpmd, ``rte_cmdline`` or
+``cmdline_parse_*``.
+
+
+Field qualifier semantics
+-------------------------
+
+For each parsed ``field qualifier value`` triple the compiler writes
+into one or more of the spec/mask/last buffers.  Semantics match
+``testpmd``:
+
+.. list-table::
+   :header-rows: 1
+   :widths: 10 30 30 20
+
+   * - Qualifier
+     - spec
+     - mask
+     - last
+   * - ``is``
+     - value
+     - all-ones over the field
+     - --
+   * - ``spec``
+     - value
+     - --
+     - --
+   * - ``mask``
+     - --
+     - value
+     - --
+   * - ``last``
+     - --
+     - --
+     - value
+   * - ``prefix``
+     - --
+     - high N bits set (CIDR style); IPv4/IPv6 only
+     - --
+
+Last write wins.  ``ipv4 src spec 10.0.0.0 src prefix 16`` therefore
+matches the entire ``10.0.0.0/16`` range with mask ``255.255.0.0``;
+``src is 10.0.0.0`` would have set the mask to all-ones, which is
+exact match.
+
+
+Diagnostics
+-----------
+
+Errors are reported as ``LINE:COL: message`` in the caller-supplied
+``errbuf`` of at least ``RTE_FLOW_COMPILE_ERRBUF_SIZE`` (256) bytes.
+The first error wins; subsequent errors are suppressed so that the
+user sees the original cause rather than a cascade.
+
+On failure ``rte_errno`` is set to ``EINVAL`` for parse errors and
+``ENOMEM`` for allocation failures.
+
+
+Extending the compiler
+----------------------
+
+The parser is entirely table driven.  Adding a new flow item type
+requires no parser changes:
+
+#. In ``flow_compile_tables.c``, define a static
+   ``struct field_desc`` array describing the parsable fields of the
+   item's spec struct.
+#. Add an ``ITEM(...)`` entry to ``flow_items[]``.
+
+Each ``field_desc`` lists the field's offset, byte width and a
+``field_kind`` (``FK_U32``, ``FK_BE16``, ``FK_MAC``, ``FK_IPV4``,
+``FK_IPV6``, ``FK_BYTES``, ...).  Default setters honor every kind
+and produce the correct byte order automatically.
+
+For fields whose layout cannot be expressed as a plain byte range
+(C bitfields, indirect arrays, RSS keys, ...) populate the ``set``
+function pointer.  The custom setter receives the destination
+buffer, an optional mask buffer (non-NULL when the user wrote
+``is``) and the parsed value token.
+
+Adding a new action type follows the same pattern with
+``flow_actions[]`` and ``ACTION(...)``.
+
+
+Source layout
+-------------
+
+The library sits in ``lib/flow_compile`` and is split for clarity:
+
+================================  ==================================
+File                              Contents
+================================  ==================================
+``rte_flow_compile.h``            Public API.
+``flow_compile_priv.h``           Internal types: tokens, descriptors,
+                                  parser state.
+``flow_compile_lex.c``            Hand-rolled lexer with
+                                  source-position tracking for
+                                  diagnostics.
+``flow_compile_parse.c``          Recursive-descent parser plus the
+                                  default field setters used by the
+                                  table-driven body parser.
+``flow_compile_tables.c``         Per-item and per-action descriptor
+                                  tables.  All extension work
+                                  happens here.
+``rte_flow_compile_api.c``        Public entry points: compile,
+                                  free, accessors, validate, create.
+================================  ==================================
+
+
+Implementation notes
+--------------------
+
+Locale independence
+   Every character classification uses inline ASCII-only predicates
+   rather than ``<ctype.h>``; hex parsing uses an inline nibble
+   helper rather than ``strtoul()``.  The grammar is pure ASCII, so
+   the active locale cannot affect parsing.
+
+Endianness
+   All multibyte writes go through ``rte_cpu_to_be_{16,32,64}`` or
+   raw byte copies from already network-order tokens
+   (``TK_IPV4``, ``TK_MAC``, ``TK_IPV6``).
+
+Alignment
+   Spec and mask buffers may contain unaligned multibyte fields
+   inside packed-ish header structs.  All writes go through
+   ``memcpy`` to handle this portably.
+
+Memory
+   All allocations go through ``rte_zmalloc`` and ``rte_free``.  Each
+   spec, mask, last and conf payload is its own allocation; the
+   pattern and action arrays are separate ``rte_calloc`` allocations
+   that grow by doubling.  ``rte_flow_compile_free()`` walks the
+   pattern and action arrays and frees every non-NULL slot before
+   freeing the arrays themselves, so a partially compiled rule on
+   a parse-error path is cleaned up uniformly.
+
+Reentrancy
+   The parser holds no static mutable state.  Multiple threads may
+   compile rules in parallel and a single compiled rule may be
+   installed concurrently on multiple ports.
+
+
+Limitations
+-----------
+
+The initial implementation covers the most common items
+(``eth``, ``vlan``, ``ipv4``, ``ipv6``, ``tcp``, ``udp``, ``vxlan``,
+``port_id``, ``port_representor``, ``represented_port``) and actions
+(``drop``, ``passthru``, ``queue``, ``mark``, ``jump``, ``count``,
+``port_id``, ``port_representor``, ``represented_port``,
+``of_pop_vlan``, ``vxlan_decap``).  Adding more is purely a matter
+of extending the descriptor tables.
+
+Items and actions whose conf has a variable-length payload
+(``RSS``, ``RAW``, the various ``RAW_ENCAP``/``RAW_DECAP`` actions)
+are not yet wired up; they require custom setters via the
+``field_desc.set`` hook.
+
+The IPv6 tokeniser does not accept the embedded-IPv4 dotted-quad
+form (``::ffff:10.0.0.1``); use the all-hex form instead.
diff --git a/doc/guides/prog_guide/index.rst b/doc/guides/prog_guide/index.rst
index e6f24945b0..3476dfecfd 100644
--- a/doc/guides/prog_guide/index.rst
+++ b/doc/guides/prog_guide/index.rst
@@ -121,6 +121,7 @@ Utility Libraries
 
     argparse_lib
     cmdline
+    flow_compile_lib
     ptr_compress_lib
     timer_lib
     rcu_lib
diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index f012d47a4b..addb9ff94b 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -64,6 +64,12 @@ New Features
   * ``--auto-probing`` enables the initial bus probing, which is the current default behavior.
 
 
+* **Added library to compile flow definitions.**
+
+  New library that works like libpcap ``pcap_compile`` function to compile
+  a text string into flow rules.
+
+
 Removed Items
 -------------
 
-- 
2.53.0

