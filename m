Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 357F4CD3427
	for <dpdk-dev@archiver.kernel.org>; Tue,  5 May 2026 22:00:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 17FB94064F;
	Wed,  6 May 2026 00:00:06 +0200 (CEST)
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com
 [209.85.167.176])
 by mails.dpdk.org (Postfix) with ESMTP id DB22740609
 for <dev@dpdk.org>; Wed,  6 May 2026 00:00:03 +0200 (CEST)
Received: by mail-oi1-f176.google.com with SMTP id
 5614622812f47-47c35be02fdso2239357b6e.3
 for <dev@dpdk.org>; Tue, 05 May 2026 15:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1778018402;
 x=1778623202; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XshXxEHDsCq6zb4HN6vk62HYoAVz4kzzHspZP8LhtZg=;
 b=w9lBnXypaY+UgyDMtSgnI1UPlceFghSbeM+ueO4CsyqTysc//wjslD4yOzNuIEaUbe
 8xDfbGqFc5aFoxLF1zAG0MUaG7niWfAXHF0S0c1Cbj6R3SPS3nTvorYwmTHjyCm5KCNn
 tpkTF6tImKWclDHd/Tcw/Vug+gy7p7c9ZSFHQDwJnTzJC0R488gDJzO1RvQZVSRHCf4K
 sW7i9J7D5AiRQtrEWkxTCdKgHPAku5mIVIZMSXsw5RgDAOW/aFw6bo0Lqu1X+H90nl6k
 hUdn0IlV+cPLDOR1bqtQL/3C/G1EmZ/Q1UNWQ0opC5sH/gdS/ZRVJmhTQBnfKQjoobOv
 lkcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778018402; x=1778623202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XshXxEHDsCq6zb4HN6vk62HYoAVz4kzzHspZP8LhtZg=;
 b=j5kIp2sZvxczysA3cDAHhboUAP47d1n2P/qZmGld9pLg4xkcDR2lYNMc0LdocXT9Or
 8D00kPkw6RTIyoc7NzO+tKLbZmLEbr9/h/GZXYJ/kGa7wRRq5XaHUukWgjO0RFnMG8OW
 kD8GF1mJJlJdZDaDxBRQnGPt9zgUDyDazToP6oBl4lkwZ43G5aPXds1Nh/Pu2F3AWvoO
 X4FbW/BzDcr36djhtQm0XNJP/DdlnGBeHrGYxgRMlyzUSvIe0cO1zvknBimkrxEmS5+I
 v0wGM6Y+ArLFTpYVhaZ8iLmvgp3wCDNBra2UoKsUgJXjSgvWO5fhAnEI7+NwZcvWvVKX
 KYmw==
X-Gm-Message-State: AOJu0YxvMlwjsVN52dL4lD10xqJ2iWATz9QBshenuH6tEzE0iYJmHutH
 3SCMXrwj4ahhsgT14wimP2v/PUot4rlk0L9rkl1z04GqORoRYGVk1gtkdJATeVCCWBkneRc74VX
 kWAo6
X-Gm-Gg: AeBDievzY0Wu+dc9MvjX2q0mTwQ0hxEhoTxh7M/p6Z/SS1EOv6U4tDKOmiAyyHEkWQK
 aVufF5983oQTX7GdBajluiUulEs2+bS3wTAfZUiFKoV3VFHGV8Ra4dUh5vVy4C0lN/2CX26yEiG
 26fpGIKimQKG0HwSnm/U7r2jalnhWsSd3Lypq1PMXRc6noF0yqhRC69WLPnjccWzQcfVAnqP6z4
 bwD7su/BhYTfWbN8KL7JOCuauGBo1GYjGbMxLYHm3P8A/seL7JNJhrTAJQyybKfZ95eJ3/kLt1o
 H6RMoCmw7K2f4n3Noa2ETvcbZQkq1uWJ9uBdvnRtC+4fHfB0eCM5qtDVW9OBLMGxclcsy+3E0Cw
 WLwMes0TV0NWl83dtjc02c0ItCT81k4jbU6luHXIq8W+xT3BmaR1+IoWSLfPEX/WhyohS6bBjTv
 Q0GGW9+tYhaUMfLaEOvlVDPiAOgXGWGJeXMPooX8dkHp9SJKgRX/Y=
X-Received: by 2002:a05:6808:c3ec:b0:44d:bcb0:1409 with SMTP id
 5614622812f47-4804245bcaamr589835b6e.22.1778018402215; 
 Tue, 05 May 2026 15:00:02 -0700 (PDT)
Received: from stephen-xps.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-47c763b2ef3sm9494718b6e.2.2026.05.05.15.00.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 15:00:01 -0700 (PDT)
Date: Tue, 5 May 2026 14:59:57 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Lukas Sismis <sismis@dyna-nic.com>
Cc: dev@dpdk.org, orika@nvidia.com, thomas@monjalon.net
Subject: Re: [PATCH v12 0/6] flow_parser: add shared parser library
Message-ID: <20260505145957.73f12027@stephen-xps.local>
In-Reply-To: <20260505183917.370281-1-sismis@dyna-nic.com>
References: <20260505183917.370281-1-sismis@dyna-nic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Tue,  5 May 2026 20:39:07 +0200
Lukas Sismis <sismis@dyna-nic.com> wrote:

> This series extracts the testpmd flow CLI parser into a reusable library,
> enabling external applications to parse rte_flow rules using testpmd syntax.
> 
> Motivation
> ----------
> External applications like Suricata IDS [1] need to express hardware filtering
> rules in a consistent, human-readable format. Rather than inventing custom
> syntax, reusing testpmd's well-tested flow grammar provides immediate
> compatibility with existing documentation and user knowledge.
> 
> Note: This library provides only one way to create rte_flow structures.
> Applications can also construct rte_flow_attr, rte_flow_item[], and
> rte_flow_action[] directly in C code.
> 
> Design
> ------
> The library (librte_flow_parser) exposes the following APIs:
> - rte_flow_parser_parse_attr_str(): Parse attributes only
> - rte_flow_parser_parse_pattern_str(): Parse patterns only
> - rte_flow_parser_parse_actions_str(): Parse actions only
> 
> Testpmd is updated to use the library, ensuring a single
> maintained parser implementation.

I wish it was not just a port of testpmd code to a library but had
been done as a clean implementation; that said the current version is
much better.

AI had lots of feedback. The part that matters to me is the new dependency
chain; and also having a syntax that looks too much like testpmd.

Would prefer that only the flow part of the string was passed.

---

I have enough material for a comprehensive architectural review. Let me write it up.

---

Below is my deep-dive review of the v12 series. Architecturally, this is a major step beyond earlier versions in terms of polish (header split, doc page, real example, real tests), but the underlying structure is still essentially the testpmd `cmdline_flow.c` lifted wholesale into `lib/ethdev`, with a thin "simple API" wrapper that synthesizes fake testpmd commands. Several of the deeper structural problems remain, plus there are concrete bugs.

```
Series-level architectural review
=================================

Context
-------

The series moves the ~14,400-line app/test-pmd/cmdline_flow.c into a
new lib/ethdev/rte_flow_parser.c, exposes a "simple" string-to-rte_flow
API in lib/ethdev/rte_flow_parser.h, exposes a fuller cmdline-aware API
in lib/ethdev/rte_flow_parser_config.h, and adds cmdline glue in
lib/cmdline/rte_flow_parser_cmdline.[ch]. testpmd (patch 4) is then
ported to consume the library via a dispatch callback that maps
RTE_FLOW_PARSER_CMD_* enum values back onto its existing port_flow_*
functions.

The main functional change versus past versions is that the simple API
(parse_attr_str / parse_pattern_str / parse_actions_str /
parse_flow_rule) now exists separately from the full command grammar.
Internally however the simple API is still implemented by string-
synthesizing a fake "flow validate 0 ..." command, running it through
the full parser, and harvesting one output field. So the architectural
center of gravity is unchanged: this is the testpmd grammar exposed as
a library.

Errors
======

Patch 3/6 -- ethdev: add flow parser library
---------------------------------------------

A1. lib/cmdline now depends on lib/ethdev (layer inversion).

  lib/cmdline/meson.build:
    -deps += ['net']
    +deps += ['net', 'ethdev']

  lib/cmdline is a foundational utility used by examples, internal
  tools, and tests that have nothing to do with networking. Pulling
  ethdev into it just so rte_flow_parser_cmdline.c can call into
  rte_flow_parser_* exports inverts the layering. Every consumer of
  libcmdline now links libethdev.

  The cmdline/flow-parser glue belongs in either lib/ethdev (and the
  header in lib/ethdev too, with ethdev depending on cmdline -- the
  natural direction) or in a new top-level lib/flow_parser that
  depends on both. It does not belong inside lib/cmdline.

A2. The "simple API" returns aliased pointers into a single 4096-byte
    static buffer, with no way for a caller to retain a result.

  lib/ethdev/rte_flow_parser.c:
    #define FLOW_PARSER_SIMPLE_BUF_SIZE 4096
    static uint8_t flow_parser_simple_parse_buf[FLOW_PARSER_SIMPLE_BUF_SIZE];
    ...
    static int parser_simple_parse(const char *cmd, ... **out) {
        memset(flow_parser_simple_parse_buf, 0, sizeof(...));
        ret = rte_flow_parser_parse(cmd,
                (struct rte_flow_parser_output *)flow_parser_simple_parse_buf,
                sizeof(flow_parser_simple_parse_buf));
        ...
        *out = (struct rte_flow_parser_output *)flow_parser_simple_parse_buf;
    }

  Then rte_flow_parser_parse_pattern_str() does:
        *pattern = out->args.vc.pattern;     /* points into buf */
        *pattern_n = out->args.vc.pattern_n;

  Three resulting problems:

  (a) Two consecutive calls alias. Any caller that wants to hold two
      parsed patterns simultaneously (e.g. parse two flows and call
      rte_flow_create() on each) cannot, without writing their own
      deep-copy via rte_flow_conv(). This is a pervasive footgun and
      is only loosely documented as "Points to internal storage valid
      until the next parse call."

  (b) The 4096-byte cap silently rejects any flow rule whose
      serialized output exceeds the buffer (returns -ENOBUFS), with
      no way for the caller to predict what fits.

  (c) The simple API itself uses parse_pattern_str inside a setter
      example flow in the example program:

        ret = rte_flow_parser_parse_pattern_str(..., &items, &items_n);
        if (ret == 0)
            ret = rte_flow_parser_raw_encap_conf_set(0, items, items_n);

      This particular sequence is safe today because raw_encap_conf_set
      doesn't re-enter the parser, but nothing in the API contract
      prevents a future parser call between (A) and (B), and the
      example pattern teaches users a fragile idiom.

  Suggested direction: provide a caller-supplied output mode -- e.g.
  rte_flow_parser_parse_pattern_str(src, items, items_cap, &items_n)
  where the caller provides storage. Or return an opaque handle owning
  the storage (rte_flow_parser_pattern_new / _free), modeled on
  rte_flow_conv().

A3. All cmdline tab-completion hooks for dynamic IDs are stubbed out
    to return zero candidates, with no override mechanism.

  lib/ethdev/rte_flow_parser.c:
    static inline int
    parser_port_id_is_invalid(uint16_t port_id)
    {
        (void)port_id;
        return 0;            /* always "valid" */
    }
    static inline uint16_t
    parser_flow_rule_count(uint16_t port_id) { return 0; }
    static inline int
    parser_flow_rule_id_get(...) { return -ENOENT; }
    /* same pattern for pattern/actions templates, tables, queues,
     * RSS queues, indirect actions */

  These are the routines comp_rule_id, comp_pattern_template_id,
  comp_actions_template_id, comp_table_id, comp_queue_id, etc. all
  call into when cmdline asks for tab-completion candidates. With
  these stubs in place, the library version of testpmd interactive
  mode can never tab-complete a rule ID, template ID, table ID,
  queue ID, or indirect action ID -- a regression versus the
  current testpmd cmdline_flow.c which queries port_flow_list,
  port_flow_template_list, etc. directly.

  patch 4 (testpmd integration) does not register or override these
  stubs anywhere. There is no callback registration interface for
  the application to provide "give me rule IDs for port N" / "give
  me table IDs for port N" / etc.

  A complete library extraction needs an introspection ops struct
  that the application registers alongside rte_flow_parser_config,
  e.g.:

    struct rte_flow_parser_introspect_ops {
        uint16_t (*flow_rule_count)(uint16_t port_id);
        int      (*flow_rule_id_get)(uint16_t port_id, unsigned idx,
                                     uint64_t *rule_id);
        /* templates, tables, queues, indirect actions, ... */
    };
    int rte_flow_parser_introspect_register(
            const struct rte_flow_parser_introspect_ops *ops);

A4. testpmd dispatch repurposes rte_flow_attr.reserved as a side
    channel for relaxed_matching.

  app/test-pmd/flow_parser.c (patch 4):
    case RTE_FLOW_PARSER_CMD_PATTERN_TEMPLATE_CREATE:
        port_flow_pattern_template_create(in->port,
            in->args.vc.pat_templ_id,
            &((const struct rte_flow_pattern_template_attr) {
                .relaxed_matching = in->args.vc.attr.reserved,
                .ingress  = in->args.vc.attr.ingress,
                .egress   = in->args.vc.attr.egress,
                .transfer = in->args.vc.attr.transfer,
            }),
            in->args.vc.pattern);

  rte_flow_attr.reserved is documented in lib/ethdev/rte_flow.h as
  reserved and required to be zero. Smuggling
  pattern_template_attr.relaxed_matching through that field couples
  the library output to a hack and breaks the moment anyone sets
  rte_flow_attr.reserved for any other purpose, or starts validating
  it. The output struct already has a vc.{pat_templ,act_templ,table}
  arm -- relaxed_matching belongs there, not overlaid on attr.reserved.

A5. Public preprocessor macros in rte_flow_parser_config.h are
    unprefixed and one of them collides with a generic name.

  lib/ethdev/rte_flow_parser_config.h:
    #define ACTION_RAW_ENCAP_MAX_DATA   512
    #define RAW_ENCAP_CONFS_MAX_NUM     8
    #define ACTION_RSS_QUEUE_NUM        128
    #define ACTION_VXLAN_ENCAP_ITEMS_NUM 6
    #define ACTION_NVGRE_ENCAP_ITEMS_NUM 5
    #define ACTION_IPV6_EXT_PUSH_MAX_DATA 512
    #define IPV6_EXT_PUSH_CONFS_MAX_NUM 8
    #define ACTION_SAMPLE_ACTIONS_NUM   10
    #define RAW_SAMPLE_CONFS_MAX_NUM    8
    #ifndef RSS_HASH_KEY_LENGTH
    #define RSS_HASH_KEY_LENGTH         64
    #endif

  Every one of these is now exported by an installed public header
  with no RTE_FLOW_PARSER_ prefix. RSS_HASH_KEY_LENGTH in particular
  is a generic name almost guaranteed to collide -- any application
  that defined its own RSS_HASH_KEY_LENGTH=40 (matching its hardware)
  before including this header would silently get 40 inside flow
  parser slots, with the parser's slot layout corrupted by mismatched
  array sizes.

  All of these need an RTE_FLOW_PARSER_ prefix and the #ifndef guard
  on RSS_HASH_KEY_LENGTH should be removed -- it is an invitation to
  define-mismatch bugs.

A6. Doc/header inconsistency: parser_parse() declared in config.h
    but documented as living in cmdline.h.

  doc/guides/prog_guide/flow_parser_lib.rst:
    "rte_flow_parser_parse() from rte_flow_parser_cmdline.h parses
    complete flow CLI commands ..."

  but the declaration is in lib/ethdev/rte_flow_parser_config.h
  (line 15342 of the diff). The doc is also internally inconsistent:
  the same .rst earlier says "Additional functions for full command
  parsing and cmdline integration are available in
  rte_flow_parser_cmdline.h. These include rte_flow_parser_parse()
  ..." -- which is wrong twice.

A7. local_cmd_flow->help_str = ... mutates the cmdline instruction.

  lib/cmdline/rte_flow_parser_cmdline.c:
    if (local_cmd_flow != NULL)
        local_cmd_flow->help_str = help ? help : name;

  This mutates the cmdline_parse_inst_t passed to
  rte_flow_parser_cmdline_register(). Idiomatic cmdline usage in DPDK
  declares cmdline_parse_inst_t variables as static const aggregates
  (see lib/cmdline/cmdline_parse.h examples and the rest of testpmd).
  Passing such an instance here writes to read-only memory and
  segfaults. The .rst note ("The library writes to inst->help_str
  dynamically ... must remain valid for the lifetime of the cmdline
  session") flags the lifetime question but does not flag the
  mutability requirement, which is the actually fatal one.

  The fix is to keep help_str storage internal to the library and
  return it via a side channel (e.g. an out-pointer in the get_help
  callback) rather than mutating the caller's instruction.

Patch 4/6 -- app/testpmd: use flow parser from ethdev
------------------------------------------------------

A8. Tab completion regression for dynamic IDs.

  As described in A3, removing app/test-pmd/cmdline_flow.c and
  replacing it with the library means testpmd's interactive flow
  command-line loses tab completion on rule IDs, pattern/actions
  template IDs, table IDs, queue IDs, RSS queue IDs, and indirect
  action IDs. Today's cmdline_flow.c calls port_flow_list,
  port_flow_template_list, port_flow_template_table_list, etc. The
  replacement library calls parser_flow_rule_count, etc., which
  return 0.

  Until the introspection callback (A3) is in place, this patch
  needs at minimum a release note entry explicitly calling out the
  loss of tab completion. As written, the change description in the
  patch does not mention it.

Warnings
========

Patch 2/6 -- ethdev: add RSS type helper APIs
----------------------------------------------

W1. The "all" entry hardcodes the OR of every RTE_ETH_RSS_* protocol
    bit and will silently go stale.

  lib/ethdev/rte_ethdev.c:
    { "all", RTE_ETH_RSS_ETH | RTE_ETH_RSS_VLAN | RTE_ETH_RSS_IP |
            RTE_ETH_RSS_TCP | RTE_ETH_RSS_UDP | RTE_ETH_RSS_SCTP |
            RTE_ETH_RSS_L2_PAYLOAD | RTE_ETH_RSS_L2TPV3 |
            RTE_ETH_RSS_ESP | RTE_ETH_RSS_AH | RTE_ETH_RSS_PFCP |
            RTE_ETH_RSS_GTPU | RTE_ETH_RSS_ECPRI | RTE_ETH_RSS_MPLS |
            RTE_ETH_RSS_L2TPV2 | RTE_ETH_RSS_IB_BTH },

  Whenever a new RTE_ETH_RSS_* protocol bit is added, this list will
  drift unless the contributor remembers this table. There is an
  existing convention RTE_ETH_RSS_PROTO_MASK in rte_ethdev.h that
  collects these; consider using it (or extending it) so the table
  tracks the canonical mask automatically.

W2. rte_eth_rss_type_to_str(0) returns "none" but
    rte_eth_rss_type_to_str(RTE_ETH_RSS_IPV4 | RTE_ETH_RSS_IPV6)
    returns NULL.

  The "to_str" function uses == on the table, so it succeeds only
  for values exactly present as a table entry. The Doxygen says
  "RSS type value (RTE_ETH_RSS_*)" which a caller will reasonably
  read as accepting any combination of RTE_ETH_RSS_* bits. The
  doc should explicitly state that only single-entry table values
  round-trip; arbitrary OR combinations return NULL.

Patch 3/6 -- ethdev: add flow parser library
---------------------------------------------

W3. enum rte_flow_parser_command + enum parser_token + token-to-cmd
    switch is a three-way invariant.

  Adding a new flow command requires:
    - new entry in enum parser_token         (private)
    - new entry in enum rte_flow_parser_command (public)
    - new case in parser_token_to_command()
  with the comment in flow parser .c file flagging this explicitly.

  This is a maintenance burden and an ABI risk -- forgetting the
  third step silently maps the new command to
  RTE_FLOW_PARSER_CMD_UNKNOWN. Consider whether the public enum
  could be derived from the private one (table-driven) so there is
  a single source of truth.

W4. rte_flow_parser_parse_attr_str() synthesizes a full validate
    command including pattern and actions just to harvest the attr.

  lib/ethdev/rte_flow_parser.c:
    ret = parser_format_cmd(&cmd, "flow validate 0 ",
                src, " pattern eth / end actions drop / end");

  This wraps the user input with a hardcoded port id 0 and a
  default pattern/actions that the simple API immediately throws
  away. If the testpmd grammar ever cross-validates attr against
  pattern/actions (e.g. "drop" not allowed on egress + transfer),
  the simple API breaks for combinations that should be valid in
  isolation. This is the architectural fragility of the synthesize-
  and-strip approach in concrete form.

W5. parser_format_cmd uses libc malloc on every simple-API call.

  lib/ethdev/rte_flow_parser.c:
    static int parser_format_cmd(char **dst, ...) {
        len = strlen(prefix) + strlen(body) + strlen(suffix) + 1;
        *dst = malloc(len);
        ...
        snprintf(*dst, len, "%s%s%s", prefix, body, suffix);

  Plain malloc, not rte_malloc, is appropriate here since the simple
  API claims to work without rte_eal_init. But the cost is a malloc/
  free pair per parse call. For an API that may be used to bulk-load
  flow rules from a config file or remote control plane, this is
  pessimal. Consider a stack-or-VLA-based formatter, since the input
  string length is already known.

W6. parser_str_strip_trailing_end heuristic strips at most one
    "/ end".

  lib/ethdev/rte_flow_parser.c:
    /* parser_str_strip_trailing_end ... */
    if (strncmp(p - 3, "end", 3) != 0)
        return strlen(src);

  Inputs like "drop / end / end" or "drop / end\t/end " strip only
  the outermost. The function's comment claims tolerance for any
  whitespace placement; it does not flag that only one trailing
  "/ end" is stripped. This is fine in practice for human input but
  surprising for programmatically generated input.

W7. No rte_flow_parser_config_unregister().

  rte_flow_parser_config_register replaces the previous registration
  and frees indirect action list configurations created by prior
  parsing sessions, but there is no unregister entry point. A test
  harness that wants a clean shutdown -- or a long-lived process
  that wants to release the SLIST of indlst_conf entries -- has to
  re-register a zeroed config to flush. Add an unregister API and
  call it from indlst_conf_cleanup at the same time.

W8. struct rte_flow_parser_vxlan_encap_conf and friends mix bit-
    fields and uint8_t arrays in a public header.

  struct rte_flow_parser_vxlan_encap_conf {
      uint32_t select_ipv4:1;
      uint32_t select_vlan:1;
      uint32_t select_tos_ttl:1;
      uint8_t  vni[3];
      ...
  };

  C bit-field layout is implementation-defined (order, alignment,
  signedness of unnamed bit-fields). For a public ABI this is
  tolerable on DPDK's supported toolchains but fragile across them.
  At minimum, reserve the remaining 29 bits explicitly:
      uint32_t reserved:29;
  to lock in the layout. A more conservative choice is plain
  uint8_t flags; with named bits.

W9. char type[16] in struct rte_flow_parser_tunnel_ops and char
    file[128]/filename[128] in rte_flow_parser_output use unnamed
    magic constants.

  struct rte_flow_parser_tunnel_ops {
      uint32_t id;
      char     type[16];
      ...
  };
  ... struct { char file[128]; ... } dump;
  ... struct { ... char filename[128]; } flex;

  These bake fixed maxima into the ABI. Define and document
  RTE_FLOW_PARSER_TUNNEL_TYPE_LEN, RTE_FLOW_PARSER_DUMP_FILE_LEN,
  etc. so contributors don't have to grep to see "is 16 enough for
  any future tunnel name?".

W10. The output struct's union arm vc has multiple raw pointer
     fields whose ownership is undocumented.

  struct rte_flow_parser_output {
      ...
      union {
          struct {
              ...
              struct rte_flow_item   *pattern;
              struct rte_flow_action *actions;
              struct rte_flow_action *masks;
              uint8_t                *data;
              ...
          } vc;
          struct {
              uint64_t *rule;
              uint64_t  rule_n;
              ...
          } destroy;
          ...
      } args;
  };

  All these pointers point either into the caller-supplied output
  buffer (rte_flow_parser_parse) or into the static simple-API
  buffer (parser_simple_parse). None of this is documented per
  field. Add a per-field comment ("points into the result_size
  buffer; valid until the next call") so a caller can see the
  contract without reading the implementation.

W11. parser_token_to_command() default branch logs ERR with no rate
     limit.

  static enum rte_flow_parser_command
  parser_token_to_command(enum parser_token token) {
      switch (token) {
      ...
      default:
          RTE_LOG_LINE(ERR, ETHDEV, "unknown parser token %u",
                  (unsigned int)token);
          return RTE_FLOW_PARSER_CMD_UNKNOWN;
      }
  }

  An attacker-controlled or fuzzed input that lands a parse on an
  unmapped token can flood the log. Use RTE_LOG_LINE_DP or downgrade
  to DEBUG.

W12. parser_ctx_set_raw_common uses 0x06 / 0x11 instead of
     IPPROTO_TCP / IPPROTO_UDP.

  case RTE_FLOW_ITEM_TYPE_UDP:
      size = sizeof(struct rte_udp_hdr);
      proto = 0x11;
      break;
  case RTE_FLOW_ITEM_TYPE_TCP:
      size = sizeof(struct rte_tcp_hdr);
      proto = 0x06;
      break;

  Other branches in the same function correctly use named constants
  (RTE_ETHER_TYPE_IPV4, IPPROTO_ROUTING). Use IPPROTO_TCP /
  IPPROTO_UDP for consistency.

Patch 4/6 -- app/test-pmd: use flow parser from ethdev
-------------------------------------------------------

W13. testpmd_flow_dispatch() (app/test-pmd/flow_parser.c) is missing
     a release note for the dropped 14k-line app/test-pmd/cmdline_flow.c.

  The release_notes for 26.07 mention the new flow parser library
  but should also note the testpmd-internal restructuring, since
  third-party patches against cmdline_flow.c will need rebasing.

Info
====

I1. Patch 1 ordering. The cmdline-stddef.h patch (patch 1/6) is
    independent of the rest of the series. It would land cleanly on
    its own and shorten this series's review surface.

I2. Series cover letter is missing from the bundle (no [PATCH v12 0/6]
    visible). For a 14k+ line series, a v12 cover letter summarizing
    what changed since v11 helps reviewers focus.

I3. Test coverage. test_flow_parser.c and test_flow_parser_simple.c
    exercise the parse path well, but I do not see a test that
    deliberately triggers the -ENOBUFS path on the simple API
    (large pattern overflowing the 4096-byte static buffer) or the
    aliasing pattern in A2(a). A negative test confirming that two
    consecutive simple-API calls invalidate the first result would
    document the contract concretely.

I4. enum rte_flow_parser_command places
    RTE_FLOW_PARSER_CMD_INDIRECT_ACTION_FLOW_CONF_CREATE alone at
    the end after the meter-policy block, breaking the per-section
    grouping established earlier. Move it into the indirect-action
    block.

I5. struct rte_flow_parser_action_vxlan_encap_data uses an anonymous
    union for ipv4/ipv6 items. This is the right size optimization
    but readers have to know to spell .item_ipv4 / .item_ipv6
    without a containing union name. Either name the union or add
    a comment.

Summary
=======

The split into rte_flow_parser.h (simple) and rte_flow_parser_config.h
(full) is the right direction and a real improvement over earlier
versions. The remaining structural issues are:

  - cmdline -> ethdev layer inversion (A1)
  - aliased pointer return semantics with a 4KB static buffer (A2)
  - tab-completion stubs with no override hook (A3, A8)
  - hack repurposing of rte_flow_attr.reserved in testpmd glue (A4)
  - unprefixed/colliding public macro names (A5)
  - mutated cmdline instruction (A7)

A2 and A3 are the two that most directly justify the "cut/paste"
critique: they reflect that the parser was extracted from testpmd
without designing a context-handle ownership model or a callback
seam for application-side state. Resolving them likely needs the
parser to take a context handle (alloc/free) and an introspection
ops struct in addition to the existing config registration.
```

A few notes on findings I considered but did not include:

- I did not flag the `RTE_LOG_LINE` calls in `indirect_action_flow_conf_create` for stale severity since they are correct uses.
- The `for (i = n - 1; i >= 0; --i)` loop with `int i` and `uint32_t n` is safe for the realistic input range so I did not flag it as integer truncation.
- The `select_ipv4:1`-style bit-fields are also present in existing public DPDK structs (`rte_flow_attr`), so I downgraded that to a Warning rather than an Error.
- Skipped patches 1/6 (trivial stddef.h include), 5/6 (example) and 6/6 (tests) since I had no findings beyond I3 and the test framework usage looked correct (`REGISTER_FAST_TEST` with `NOHUGE_OK, ASAN_OK`).

No `Reviewed-by` is given since the series has multiple Errors and Warnings outstanding.
