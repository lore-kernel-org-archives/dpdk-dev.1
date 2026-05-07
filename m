Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D88CD342C
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 May 2026 00:15:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 39177402E8;
	Thu,  7 May 2026 02:15:11 +0200 (CEST)
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172]) by mails.dpdk.org (Postfix) with ESMTP id 2CEDF40649
 for <dev@dpdk.org>; Thu,  7 May 2026 02:15:09 +0200 (CEST)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-2b4520f6b32so534486eec.0
 for <dev@dpdk.org>; Wed, 06 May 2026 17:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1778112908;
 x=1778717708; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vNcdAGqxC0bsOJ0UKAI69WCxq4vPgxg/EjAljby8JgE=;
 b=C/GfhIGFV4gVL2GgCZ4sqe/i+EGSuZmhcJVfqz+JzghCjw2CzLxcc2pw13ew6+0I1s
 x22Qq+sDSFLYSqB0Fz5SBz3cX61T3tzF4ZlYeUuwu7mNhcLVlXvtp9THONzHo6P96bbi
 fZzg062IRtr6roZ+tHkHXK2oS97+D97ZJuGENPGZ0AO+IS4M1v2XkBkuzSwQ2zUxXxAX
 37r+qMe7P5Lx+NlIy5xmUIqwDyvWU+17E7kdMEBbsK+kygLNzOqSJZvrJboS1Me0geCt
 QlsUCfzf8xm4Y2DZAWubJ5pqT04q9iOCOQOrDCIO6vCeR8Ne+V6nWl9g8tsFQUtSCOVW
 o6GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778112908; x=1778717708;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vNcdAGqxC0bsOJ0UKAI69WCxq4vPgxg/EjAljby8JgE=;
 b=ouFs4phg3I7rPwr5d+nQlUEVow11Th4jbDamitCzla4l9tBKjRIiSZ1qcUnKJjjXqF
 0wc5IOld3FxW9MXDGJWw1PNhflOVBJ+xVsGSFFgTOVKz1GVhpoAKC+0sU78fNLkqV9HF
 9HiaPnxheqjifkPyfVIfZpBg2E16phLB90yn0K3vVz1/gC+v6sWgm1zsU4Fl4ycTAgPY
 VtiQVYqMxVFN8/Zi+2NVsr9rKaFSFowVh9jT7EIQQ0hzFdwGFikyG/nssdNFbZmlV1G5
 2KLfrdvNHXr0PxSYlOnwfjEEAdVknV9+Ula2oupHnCXiAnfm80SZiUDUb2c7yZ/E/sOa
 cHcg==
X-Gm-Message-State: AOJu0Yws0ulOTDOJGUYTjVd/5Vv7VBI85lxnpIL5A2OzSWM5hkA6G8Q5
 0cROanuiQrLdnT4wV8+1Si2fZ1chxgC6pZh+F8VTjgfPCbLM0si+8ki6fHSSvlT6FFM94pwfHKD
 b9ic8
X-Gm-Gg: AeBDies6jOm5qcyG64FRGVrCYHkY2ONsXH3GGB97kDvS8IEtWm6c9Fzf4Pk/jMTA/Iw
 qemp8Mt1pQgQbv4OMdJhYAXrrBhVM4KSWWnNJT0Xklqq3MbumafTvG4anSKJewyokAxq1oLSP8C
 3j7ybi0w497nVhYkk5TiWiA7Gt+EJGq8DNVJke7lypdKUgql5sxAqWbvapHAYaWFQo/6a5h5Sn3
 Kh/3jH8SElWp4vMSDtu4en0U+6gwIhP8xFYJvqm76DZ2I0Sphqx+PIzrDjf2PbRK2DQRy0Pk0l8
 +/twE/RpqgmvsxvG72L80INFV1IUHTC8DEoAcroVIQz34LtRC7RFuqx6aUGG86OzhS3PBsjja4c
 UFUEOlCdCoFhRnpr+V5O83WQzV/bNNIWCv7erxck0iicaOsQ48BUwPJs0hGKaGf+5ZM+ZPTVA9C
 QQ6ToChsBbTOWC+yEY8eQIDgnbBtwjnB6dU7qbQ7M68xU=
X-Received: by 2002:a05:7300:6ca8:b0:2d2:96e8:1bf5 with SMTP id
 5a478bee46e88-2f54d696b08mr3265133eec.3.1778112907695; 
 Wed, 06 May 2026 17:15:07 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f57057bd00sm5159080eec.30.2026.05.06.17.15.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 17:15:07 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [RFC v2 3/4] doc: add programmer's guide for flow rule compiler
Date: Wed,  6 May 2026 17:06:50 -0700
Message-ID: <20260507001501.608724-4-stephen@networkplumber.org>
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

Add a chapter to the programmer's guide describing the new
rte_flow_compile library: API summary, BNF grammar, field
qualifier semantics (is/spec/last/mask/prefix), diagnostic
format, and the table-driven extension model for adding
items and actions.

Notes that the grammar is a strict subset of testpmd's, and
documents the limitations of the initial implementation
(item/action coverage, missing RSS and RAW handling).

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 MAINTAINERS                                |   6 +
 doc/guides/prog_guide/flow_compile_lib.rst | 302 +++++++++++++++++++++
 doc/guides/prog_guide/index.rst            |   1 +
 doc/guides/rel_notes/release_26_07.rst     |   6 +
 4 files changed, 315 insertions(+)
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
index 0000000000..2c38c3d2d6
--- /dev/null
+++ b/doc/guides/prog_guide/flow_compile_lib.rst
@@ -0,0 +1,302 @@
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
+Runtime dependencies are limited to ``rte_flow`` (currently part of
+``rte_ethdev``) and ``rte_net`` (for MAC address parsing).  In
+particular the compiler does not pull in ``rte_cmdline``, so it is
+suitable for use from libraries, control planes and unit tests.
+
+Flex and bison are required at build time to regenerate the lexer
+and parser sources; if either tool is missing the library is
+silently skipped via meson's ``has_flex_bison`` check.
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
+   item-list    ::= ( item "/" )+ "end"
+   item         ::= IDENT field-spec*
+   field-spec   ::= IDENT qualifier value
+   qualifier    ::= "is" | "spec" | "last" | "mask" | "prefix"
+   action-list  ::= ( action "/" )+ "end"
+   action       ::= IDENT param*
+   param        ::= IDENT value
+   value        ::= UINT | IPV4 | IPV6 | MAC | HEXSTR
+
+Both the pattern list and the action list must contain at least one
+entry before the trailing ``end``: ``pattern end`` and
+``actions end`` are parse errors.  A truly catch-all rule must list
+at least one item (typically ``eth``) and at least one action
+(typically ``passthru`` or a queue assignment).
+
+The ``STRING`` token is recognised by the lexer for use by future
+custom setters but is not currently accepted by any production.
+
+Lexical tokens:
+
+.. code-block:: bnf
+
+   IDENT        ::= [A-Za-z_][A-Za-z0-9_]*
+   UINT         ::= [0-9]+ | "0x" [0-9A-Fa-f]+         ; up to 16 hex digits
+   IPV4         ::= UINT "." UINT "." UINT "." UINT    ; each 0..255
+   IPV6         ::= RFC 4291 / 5952 textual form, including the
+                    embedded-IPv4 form ``::ffff:a.b.c.d``
+   MAC          ::= XX ":" XX ":" XX ":" XX ":" XX ":" XX
+                  | XX "-" XX "-" XX "-" XX "-" XX "-" XX
+                  | XXXX "." XXXX "." XXXX
+   HEXSTR       ::= "0x" [0-9A-Fa-f]+                  ; > 16 hex digits
+   STRING       ::= '"' character* '"'                 ; \\ escapes recognised
+
+The grammar follows ``testpmd`` closely so that flow rules already
+familiar to users carry over.  The lexer is generated by flex from
+``flow_compile.l`` and the parser by bison from ``flow_compile.y``;
+both are reentrant (``%option reentrant``, ``%define api.pure``)
+and share state through a per-compile context, so multiple
+compilations may run concurrently.  Neither depends on testpmd,
+``rte_cmdline`` or ``cmdline_parse_*``.
+
+.. note::
+
+   This library implements a strict subset of testpmd's flow rule
+   syntax.  Some forms accepted by testpmd are rejected here -- for
+   example, empty pattern or action lists, and quoted-string values
+   in contexts that have no custom setter wired up.  Rules written
+   for testpmd should parse, but rules written for this library may
+   not be exercise-equivalent in testpmd if they rely on a
+   construct testpmd treats more permissively.
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
+The grammar itself is generic: it knows about attributes, items,
+fields, actions and parameters, but has no per-type productions.
+All per-type knowledge lives in descriptor tables.  Adding a new
+flow item type therefore requires no changes to ``flow_compile.l``
+or ``flow_compile.y``:
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
+Fields whose layout cannot be expressed as a plain byte range
+(C bitfields, indirect arrays, RSS keys, ...) are not currently
+supported; the descriptor mechanism handles fixed-shape fields
+only.
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
+``flow_compile_priv.h``           Internal types: descriptors,
+                                  parser context, error helpers.
+``flow_compile.l``                Flex lexer.  Reentrant, with
+                                  source-position tracking via
+                                  ``YY_USER_ACTION`` for diagnostics.
+``flow_compile.y``                Bison grammar.  Pure parser; all
+                                  semantic actions delegate to the
+                                  setter helpers below.
+``flow_compile_setters.c``        Default field setters for every
+                                  ``field_kind`` and the begin/end
+                                  helpers called from the grammar.
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
+   The flex regular expressions use byte-literal character classes
+   (``[0-9A-Fa-f]``, ``[A-Za-z_]``) rather than locale-aware
+   classifications, and address parsing goes through
+   ``inet_pton()`` and ``rte_ether_unformat_addr()`` which are
+   themselves locale-independent.  The active locale therefore
+   cannot affect tokenisation.
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
+   pattern and action arrays are grown with ``rte_realloc``,
+   doubling from an initial capacity of 8.
+   ``rte_flow_compile_free()`` walks the pattern and action arrays
+   and frees every non-NULL slot before freeing the arrays
+   themselves, so a partially compiled rule on a parse-error path
+   is cleaned up uniformly.
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
+are not yet supported.  Adding them will require extending the
+descriptor mechanism beyond fixed-shape fields.
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

