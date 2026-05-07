Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A038CD343F
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 May 2026 12:30:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 100C1402AB;
	Thu,  7 May 2026 14:30:05 +0200 (CEST)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com
 [209.85.208.52]) by mails.dpdk.org (Postfix) with ESMTP id 830FD40265
 for <dev@dpdk.org>; Thu,  7 May 2026 14:30:03 +0200 (CEST)
Received: by mail-ed1-f52.google.com with SMTP id
 4fb4d7f45d1cf-678a16429c6so1175844a12.1
 for <dev@dpdk.org>; Thu, 07 May 2026 05:30:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778157003; cv=none;
 d=google.com; s=arc-20240605;
 b=QmoQX7PVKM2CJon1sYBROB8JwKrFcXxt/DvfkyL2BYUlK8TPZihrFMC7EjXNVLqOg0
 qaIZQOTR/e0iasrNgQSK2HHJBFYUvP20ebvSOhV3ug80u1renp8o3TGHsX2AXIJxiIGm
 X9pvucGK9Wl3KeNZsaufwPJJyJU/x8v0kokC9FV16jH3r1UngJSjxTDo5zXNMLDAQqqf
 DkeMzeuS6rJZ8uWD0S+nsczqhIac4C/i/yliuQpfNFotbhMzBosEX3p2dFyrnqyYYYhN
 oyhb+lz7AYI5ivgIgfmF38O3etU1+mwqpraO19e4HPG4JG0tkRPgZJMS5rSeQz0nLsf7
 2+3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=uB0iJzqOC9ZzokvlUD3gejNwyuHX/+vGjhitxXkZKa8=;
 fh=hfUboOT+ZLk1+ccfjjD6cy99VtixxJkLCS/+3vL/3Lk=;
 b=dJykMRWBrOCcS7Iw3YQGnJLF6PDDt73FUWNhkeS/DPa+caCdQ+V+xArIU13omsZhCL
 123HTDdBKrzt7Kzqi9XQDLvXoAn7Xuy9L2JgLorxpvmOZq0H2OD4ucnk0DCotagBE63O
 BSM8IGaaXSl2kG+Y8tn5Q5OIS2OFQ0nknPksckbGpmlZySH1Ob508qKpgjiz4kWkIN4Z
 dm3bwG2e6eylyNi0V6rKI7NmxK4iTE3iCldzKbOHPy/By9psn+tqAPyYFlya5pigntku
 xgFgYo1jyWN8dV9/cUszSS+XWVA2kyVsxXd0OlBpY3w0MLTD7Xlbv0O27UyVg0axGWU5
 CgSQ==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dyna-nic.com; s=google; t=1778157003; x=1778761803; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uB0iJzqOC9ZzokvlUD3gejNwyuHX/+vGjhitxXkZKa8=;
 b=pHp63iyvLIkHb0iO1iv9RRi8CPYjnWUfEK7fm6ysSXEWmXL5c4lFkbcFFa4W/G0m/L
 sV5CpXUGiqQdh4y5KF5lLldmmQ855oTjw3NKtLjXrH9MDDIk5MRJvy400S27ZFGmmM0+
 kt6zeH4ZEHLqEMocI7bjP+Sh3rZNaysdnwRQ8qaRwdyLBztSq7M/DNJCansG+blApUfo
 j7mPcFmTz5gxOD0mMcZXO7dxNFWNXGjxI3f8ZPeW7VSlr7JIQQPtbEowLdz/mzUNQ7hf
 pOr/HEq4pK3zDxsBEZDnXcCMw09O1CFd8iQeyqwLMzOqIQAjeq73GKx3NTfsFG6Ev9hn
 wWqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778157003; x=1778761803;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uB0iJzqOC9ZzokvlUD3gejNwyuHX/+vGjhitxXkZKa8=;
 b=AKqTymFX5i3a4l16FaRhJhONkOBECn3e92YSct7BK43ZOrBhI+ZG9vxptIHVp6M63w
 vnj0mjZ0t6I0mio5EKX7q9y/XXs5YVE7QVOwZUF/JtWlBPFJPNaSiuwybfAcjped9ZNH
 F2rmaLH4Xwyce1UZgJm9cgdAIlVJSBY2vQXoZ2JWZRpEIciMq1dOZuEJ59fZY84RVlzD
 5IkBMWO1yjVeUSVrjxhiFiCQuiOYq/iq5PQ2mMogh61E/NFy51MwgJ6tjxbH6FUT6xXg
 rSZAD09Z/+bDJ8cacgrDQkI7/nrOOVmYL+KeSq/vbX26sRlUDRlLEACNx9lcBWwjMRIB
 f4sA==
X-Gm-Message-State: AOJu0Yw2vfEhD8DRa5oX/KCekti5EbnI5Ck8MLWQ/C0+K6ugp7Rm2K/n
 XySuhVLeaW+TJnucHyhzz5WcpsErSmWsPywqmfktnbUbT5bSyQx/Jz+r4ElTjp/JIevAFw52xcs
 xZtCUnxKogQr8AyY/yVmE4bUPIh299VFIcMbvfJ9kyYsfR+8pH8juXi8=
X-Gm-Gg: AeBDievCwLvTIzur5BRoHGWcVN5FME5TQOZl1SPDWqvT87/i6KnZBNlMrsVZBw4ZjEh
 ZqtJz1bkCoOSH4fo4Logiqx+Nol1SjB6JWYms5IKdvJvSuCFdWmOhAgOnY0AQS8DGcLT5gdYKEo
 GyjTBxnwiXb4/xovI6rsLyVMmKlbWi3jQL+FTH4SpXoFUwieNY8DRZb+ye/LBZi8ecBpS2K/pTg
 AkkxdPTAvF4M2L4kG9ZBvEAKm1+ZaChYor6LQ+3OqIcA/1ue+ajTAx798uTWe3VlklLeB6kGq9l
 qbH01tkx6+096/X95+RoKhYI1Q==
X-Received: by 2002:a05:6402:4506:b0:676:5872:c686 with SMTP id
 4fb4d7f45d1cf-67e0dbfa7cfmr1327886a12.2.1778157002831; Thu, 07 May 2026
 05:30:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260505183917.370281-1-sismis@dyna-nic.com>
 <20260505145957.73f12027@stephen-xps.local>
In-Reply-To: <20260505145957.73f12027@stephen-xps.local>
From: =?UTF-8?B?THVrw6HFoSDFoGnFoW1pxaE=?= <sismis@dyna-nic.com>
Date: Thu, 7 May 2026 14:29:51 +0200
X-Gm-Features: AVHnY4LcEGYozwrzJZor0jNOCitCLFX5t24I3kMCsX3vptv2Ihf0lJKtMETW0lg
Message-ID: <CAPQRu6HQ7zJ8xKE+irTmJE7dRTADashxKgtOCop5c_odKvVxTA@mail.gmail.com>
Subject: Re: [PATCH v12 0/6] flow_parser: add shared parser library
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, orika@nvidia.com, thomas@monjalon.net
Content-Type: multipart/alternative; boundary="0000000000008249bc065139706d"
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

--0000000000008249bc065139706d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

st 6. 5. 2026 v 0:00 odes=C3=ADlatel Stephen Hemminger <
stephen@networkplumber.org> napsal:

> On Tue,  5 May 2026 20:39:07 +0200
> Lukas Sismis <sismis@dyna-nic.com> wrote:
>
> > This series extracts the testpmd flow CLI parser into a reusable librar=
y,
> > enabling external applications to parse rte_flow rules using testpmd
> syntax.
> >
> > Motivation
> > ----------
> > External applications like Suricata IDS [1] need to express hardware
> filtering
> > rules in a consistent, human-readable format. Rather than inventing
> custom
> > syntax, reusing testpmd's well-tested flow grammar provides immediate
> > compatibility with existing documentation and user knowledge.
> >
> > Note: This library provides only one way to create rte_flow structures.
> > Applications can also construct rte_flow_attr, rte_flow_item[], and
> > rte_flow_action[] directly in C code.
> >
> > Design
> > ------
> > The library (librte_flow_parser) exposes the following APIs:
> > - rte_flow_parser_parse_attr_str(): Parse attributes only
> > - rte_flow_parser_parse_pattern_str(): Parse patterns only
> > - rte_flow_parser_parse_actions_str(): Parse actions only
> >
> > Testpmd is updated to use the library, ensuring a single
> > maintained parser implementation.
>
> I wish it was not just a port of testpmd code to a library but had
> been done as a clean implementation; that said the current version is
> much better.
>
> AI had lots of feedback. The part that matters to me is the new dependenc=
y
> chain; and also having a syntax that looks too much like testpmd.
>
> Would prefer that only the flow part of the string was passed.
>
>
Thanks for the feedback.

Clean implementation would be best, but it is also worth noting that it
would encompass great engineering effort to get there. Porting/extracting
testpmd's flow parser to a separate library was the original intention, to
test the waters and see if it would be used by the community and work well
in the DPDK environment. More specifically, the very first original
intention was to reuse the simple network pattern language to define
rte_flow rule structures (eth / ipv4 / ...). Since carving out just the
network layer pattern parser seemed not feasible (the pattern section
contains extra network-independent information, e.g.,
port_id/conntrack/represented ports/encaps), the scope extended to the full
"flow create" command of the testpmd. That then included an even larger
scope of features to consider in the library.

To comment on the dependency problem, I would like to mention that if this
were a separate library, there would be no changes in dependencies in the
core libraries.

---

I don't quite understand your wish of "only the flow part of the string was
passed". If you mean to e.g. pass only the pattern string to get pattern
structures returned, then the simple API is for that purpose, e.g.:

/**
 * Parse a flow pattern from a CLI snippet.
 *
 * Parses pattern strings as used inside a flow command, such as
 * "eth / ipv4 src is 192.168.1.1 / tcp dst is 80 / end".
 *
 */
__rte_experimental
int rte_flow_parser_parse_pattern_str(const char *src,
     const struct rte_flow_item **pattern,
     uint32_t *pattern_n);

If you meant to say you want to pass the full "flow create ... " command to
output attribute + patterns + actions structures in one call *only*, then
it is possible. But while iterating on this, I came to the conclusion that
"flow create" is truly a control directive of the testpmd application and
should not be dragged to the rte_flow parser library. So I don't think it
is a good idea. I envision that custom applications could define their own
rule-specification syntax, whether it would be the usual "flow create X",
YAML-structure, or something else.

---

On the related note, to comment on your concern about "having a syntax that
looks too much like testpmd". Having testpmd syntax is exactly the intent
of this work: to have a single parser for both the testpmd and the rte_flow
parser library itself. With all this work, I thought about dailing back and
e.g. reducing the scope of the patch to only introduce a string parser for
the limited set of network-layer patterns (withot the tokenizer). But this
would lead to code duplication (which I wanted to avoid with all this
work), as I didn't find a straightforward way to have part of the testpmd
parser internally and the other in the library.

Perhaps, this can be a good point to decide if a port of testpmd rte_flow
parser would be a welcome contribution by DPDK maintainers, especially at
this early stage of the library creation. I would greatly appreciate "a
clean library rewrite," but at this moment, I estimate the complexity to be
higher than the capacity that I have currently.







> ---
>
> I have enough material for a comprehensive architectural review. Let me
> write it up.
>
> ---
>
> Below is my deep-dive review of the v12 series. Architecturally, this is =
a
> major step beyond earlier versions in terms of polish (header split, doc
> page, real example, real tests), but the underlying structure is still
> essentially the testpmd `cmdline_flow.c` lifted wholesale into
> `lib/ethdev`, with a thin "simple API" wrapper that synthesizes fake
> testpmd commands. Several of the deeper structural problems remain, plus
> there are concrete bugs.
>
> ```
> Series-level architectural review
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Context
> -------
>
> The series moves the ~14,400-line app/test-pmd/cmdline_flow.c into a
> new lib/ethdev/rte_flow_parser.c, exposes a "simple" string-to-rte_flow
> API in lib/ethdev/rte_flow_parser.h, exposes a fuller cmdline-aware API
> in lib/ethdev/rte_flow_parser_config.h, and adds cmdline glue in
> lib/cmdline/rte_flow_parser_cmdline.[ch]. testpmd (patch 4) is then
> ported to consume the library via a dispatch callback that maps
> RTE_FLOW_PARSER_CMD_* enum values back onto its existing port_flow_*
> functions.
>
> The main functional change versus past versions is that the simple API
> (parse_attr_str / parse_pattern_str / parse_actions_str /
> parse_flow_rule) now exists separately from the full command grammar.
> Internally however the simple API is still implemented by string-
> synthesizing a fake "flow validate 0 ..." command, running it through
> the full parser, and harvesting one output field. So the architectural
> center of gravity is unchanged: this is the testpmd grammar exposed as
> a library.
>
> Errors
> =3D=3D=3D=3D=3D=3D
>
> Patch 3/6 -- ethdev: add flow parser library
> ---------------------------------------------
>
> A1. lib/cmdline now depends on lib/ethdev (layer inversion).
>
>   lib/cmdline/meson.build:
>     -deps +=3D ['net']
>     +deps +=3D ['net', 'ethdev']
>
>   lib/cmdline is a foundational utility used by examples, internal
>   tools, and tests that have nothing to do with networking. Pulling
>   ethdev into it just so rte_flow_parser_cmdline.c can call into
>   rte_flow_parser_* exports inverts the layering. Every consumer of
>   libcmdline now links libethdev.
>
>   The cmdline/flow-parser glue belongs in either lib/ethdev (and the
>   header in lib/ethdev too, with ethdev depending on cmdline -- the
>   natural direction) or in a new top-level lib/flow_parser that
>   depends on both. It does not belong inside lib/cmdline.
>
> A2. The "simple API" returns aliased pointers into a single 4096-byte
>     static buffer, with no way for a caller to retain a result.
>
>   lib/ethdev/rte_flow_parser.c:
>     #define FLOW_PARSER_SIMPLE_BUF_SIZE 4096
>     static uint8_t
> flow_parser_simple_parse_buf[FLOW_PARSER_SIMPLE_BUF_SIZE];
>     ...
>     static int parser_simple_parse(const char *cmd, ... **out) {
>         memset(flow_parser_simple_parse_buf, 0, sizeof(...));
>         ret =3D rte_flow_parser_parse(cmd,
>                 (struct rte_flow_parser_output
> *)flow_parser_simple_parse_buf,
>                 sizeof(flow_parser_simple_parse_buf));
>         ...
>         *out =3D (struct rte_flow_parser_output
> *)flow_parser_simple_parse_buf;
>     }
>
>   Then rte_flow_parser_parse_pattern_str() does:
>         *pattern =3D out->args.vc.pattern;     /* points into buf */
>         *pattern_n =3D out->args.vc.pattern_n;
>
>   Three resulting problems:
>
>   (a) Two consecutive calls alias. Any caller that wants to hold two
>       parsed patterns simultaneously (e.g. parse two flows and call
>       rte_flow_create() on each) cannot, without writing their own
>       deep-copy via rte_flow_conv(). This is a pervasive footgun and
>       is only loosely documented as "Points to internal storage valid
>       until the next parse call."
>
>   (b) The 4096-byte cap silently rejects any flow rule whose
>       serialized output exceeds the buffer (returns -ENOBUFS), with
>       no way for the caller to predict what fits.
>
>   (c) The simple API itself uses parse_pattern_str inside a setter
>       example flow in the example program:
>
>         ret =3D rte_flow_parser_parse_pattern_str(..., &items, &items_n);
>         if (ret =3D=3D 0)
>             ret =3D rte_flow_parser_raw_encap_conf_set(0, items, items_n)=
;
>
>       This particular sequence is safe today because raw_encap_conf_set
>       doesn't re-enter the parser, but nothing in the API contract
>       prevents a future parser call between (A) and (B), and the
>       example pattern teaches users a fragile idiom.
>
>   Suggested direction: provide a caller-supplied output mode -- e.g.
>   rte_flow_parser_parse_pattern_str(src, items, items_cap, &items_n)
>   where the caller provides storage. Or return an opaque handle owning
>   the storage (rte_flow_parser_pattern_new / _free), modeled on
>   rte_flow_conv().
>
> A3. All cmdline tab-completion hooks for dynamic IDs are stubbed out
>     to return zero candidates, with no override mechanism.
>
>   lib/ethdev/rte_flow_parser.c:
>     static inline int
>     parser_port_id_is_invalid(uint16_t port_id)
>     {
>         (void)port_id;
>         return 0;            /* always "valid" */
>     }
>     static inline uint16_t
>     parser_flow_rule_count(uint16_t port_id) { return 0; }
>     static inline int
>     parser_flow_rule_id_get(...) { return -ENOENT; }
>     /* same pattern for pattern/actions templates, tables, queues,
>      * RSS queues, indirect actions */
>
>   These are the routines comp_rule_id, comp_pattern_template_id,
>   comp_actions_template_id, comp_table_id, comp_queue_id, etc. all
>   call into when cmdline asks for tab-completion candidates. With
>   these stubs in place, the library version of testpmd interactive
>   mode can never tab-complete a rule ID, template ID, table ID,
>   queue ID, or indirect action ID -- a regression versus the
>   current testpmd cmdline_flow.c which queries port_flow_list,
>   port_flow_template_list, etc. directly.
>
>   patch 4 (testpmd integration) does not register or override these
>   stubs anywhere. There is no callback registration interface for
>   the application to provide "give me rule IDs for port N" / "give
>   me table IDs for port N" / etc.
>
>   A complete library extraction needs an introspection ops struct
>   that the application registers alongside rte_flow_parser_config,
>   e.g.:
>
>     struct rte_flow_parser_introspect_ops {
>         uint16_t (*flow_rule_count)(uint16_t port_id);
>         int      (*flow_rule_id_get)(uint16_t port_id, unsigned idx,
>                                      uint64_t *rule_id);
>         /* templates, tables, queues, indirect actions, ... */
>     };
>     int rte_flow_parser_introspect_register(
>             const struct rte_flow_parser_introspect_ops *ops);
>
> A4. testpmd dispatch repurposes rte_flow_attr.reserved as a side
>     channel for relaxed_matching.
>
>   app/test-pmd/flow_parser.c (patch 4):
>     case RTE_FLOW_PARSER_CMD_PATTERN_TEMPLATE_CREATE:
>         port_flow_pattern_template_create(in->port,
>             in->args.vc.pat_templ_id,
>             &((const struct rte_flow_pattern_template_attr) {
>                 .relaxed_matching =3D in->args.vc.attr.reserved,
>                 .ingress  =3D in->args.vc.attr.ingress,
>                 .egress   =3D in->args.vc.attr.egress,
>                 .transfer =3D in->args.vc.attr.transfer,
>             }),
>             in->args.vc.pattern);
>
>   rte_flow_attr.reserved is documented in lib/ethdev/rte_flow.h as
>   reserved and required to be zero. Smuggling
>   pattern_template_attr.relaxed_matching through that field couples
>   the library output to a hack and breaks the moment anyone sets
>   rte_flow_attr.reserved for any other purpose, or starts validating
>   it. The output struct already has a vc.{pat_templ,act_templ,table}
>   arm -- relaxed_matching belongs there, not overlaid on attr.reserved.
>
> A5. Public preprocessor macros in rte_flow_parser_config.h are
>     unprefixed and one of them collides with a generic name.
>
>   lib/ethdev/rte_flow_parser_config.h:
>     #define ACTION_RAW_ENCAP_MAX_DATA   512
>     #define RAW_ENCAP_CONFS_MAX_NUM     8
>     #define ACTION_RSS_QUEUE_NUM        128
>     #define ACTION_VXLAN_ENCAP_ITEMS_NUM 6
>     #define ACTION_NVGRE_ENCAP_ITEMS_NUM 5
>     #define ACTION_IPV6_EXT_PUSH_MAX_DATA 512
>     #define IPV6_EXT_PUSH_CONFS_MAX_NUM 8
>     #define ACTION_SAMPLE_ACTIONS_NUM   10
>     #define RAW_SAMPLE_CONFS_MAX_NUM    8
>     #ifndef RSS_HASH_KEY_LENGTH
>     #define RSS_HASH_KEY_LENGTH         64
>     #endif
>
>   Every one of these is now exported by an installed public header
>   with no RTE_FLOW_PARSER_ prefix. RSS_HASH_KEY_LENGTH in particular
>   is a generic name almost guaranteed to collide -- any application
>   that defined its own RSS_HASH_KEY_LENGTH=3D40 (matching its hardware)
>   before including this header would silently get 40 inside flow
>   parser slots, with the parser's slot layout corrupted by mismatched
>   array sizes.
>
>   All of these need an RTE_FLOW_PARSER_ prefix and the #ifndef guard
>   on RSS_HASH_KEY_LENGTH should be removed -- it is an invitation to
>   define-mismatch bugs.
>
> A6. Doc/header inconsistency: parser_parse() declared in config.h
>     but documented as living in cmdline.h.
>
>   doc/guides/prog_guide/flow_parser_lib.rst:
>     "rte_flow_parser_parse() from rte_flow_parser_cmdline.h parses
>     complete flow CLI commands ..."
>
>   but the declaration is in lib/ethdev/rte_flow_parser_config.h
>   (line 15342 of the diff). The doc is also internally inconsistent:
>   the same .rst earlier says "Additional functions for full command
>   parsing and cmdline integration are available in
>   rte_flow_parser_cmdline.h. These include rte_flow_parser_parse()
>   ..." -- which is wrong twice.
>
> A7. local_cmd_flow->help_str =3D ... mutates the cmdline instruction.
>
>   lib/cmdline/rte_flow_parser_cmdline.c:
>     if (local_cmd_flow !=3D NULL)
>         local_cmd_flow->help_str =3D help ? help : name;
>
>   This mutates the cmdline_parse_inst_t passed to
>   rte_flow_parser_cmdline_register(). Idiomatic cmdline usage in DPDK
>   declares cmdline_parse_inst_t variables as static const aggregates
>   (see lib/cmdline/cmdline_parse.h examples and the rest of testpmd).
>   Passing such an instance here writes to read-only memory and
>   segfaults. The .rst note ("The library writes to inst->help_str
>   dynamically ... must remain valid for the lifetime of the cmdline
>   session") flags the lifetime question but does not flag the
>   mutability requirement, which is the actually fatal one.
>
>   The fix is to keep help_str storage internal to the library and
>   return it via a side channel (e.g. an out-pointer in the get_help
>   callback) rather than mutating the caller's instruction.
>
> Patch 4/6 -- app/testpmd: use flow parser from ethdev
> ------------------------------------------------------
>
> A8. Tab completion regression for dynamic IDs.
>
>   As described in A3, removing app/test-pmd/cmdline_flow.c and
>   replacing it with the library means testpmd's interactive flow
>   command-line loses tab completion on rule IDs, pattern/actions
>   template IDs, table IDs, queue IDs, RSS queue IDs, and indirect
>   action IDs. Today's cmdline_flow.c calls port_flow_list,
>   port_flow_template_list, port_flow_template_table_list, etc. The
>   replacement library calls parser_flow_rule_count, etc., which
>   return 0.
>
>   Until the introspection callback (A3) is in place, this patch
>   needs at minimum a release note entry explicitly calling out the
>   loss of tab completion. As written, the change description in the
>   patch does not mention it.
>
> Warnings
> =3D=3D=3D=3D=3D=3D=3D=3D
>
> Patch 2/6 -- ethdev: add RSS type helper APIs
> ----------------------------------------------
>
> W1. The "all" entry hardcodes the OR of every RTE_ETH_RSS_* protocol
>     bit and will silently go stale.
>
>   lib/ethdev/rte_ethdev.c:
>     { "all", RTE_ETH_RSS_ETH | RTE_ETH_RSS_VLAN | RTE_ETH_RSS_IP |
>             RTE_ETH_RSS_TCP | RTE_ETH_RSS_UDP | RTE_ETH_RSS_SCTP |
>             RTE_ETH_RSS_L2_PAYLOAD | RTE_ETH_RSS_L2TPV3 |
>             RTE_ETH_RSS_ESP | RTE_ETH_RSS_AH | RTE_ETH_RSS_PFCP |
>             RTE_ETH_RSS_GTPU | RTE_ETH_RSS_ECPRI | RTE_ETH_RSS_MPLS |
>             RTE_ETH_RSS_L2TPV2 | RTE_ETH_RSS_IB_BTH },
>
>   Whenever a new RTE_ETH_RSS_* protocol bit is added, this list will
>   drift unless the contributor remembers this table. There is an
>   existing convention RTE_ETH_RSS_PROTO_MASK in rte_ethdev.h that
>   collects these; consider using it (or extending it) so the table
>   tracks the canonical mask automatically.
>
> W2. rte_eth_rss_type_to_str(0) returns "none" but
>     rte_eth_rss_type_to_str(RTE_ETH_RSS_IPV4 | RTE_ETH_RSS_IPV6)
>     returns NULL.
>
>   The "to_str" function uses =3D=3D on the table, so it succeeds only
>   for values exactly present as a table entry. The Doxygen says
>   "RSS type value (RTE_ETH_RSS_*)" which a caller will reasonably
>   read as accepting any combination of RTE_ETH_RSS_* bits. The
>   doc should explicitly state that only single-entry table values
>   round-trip; arbitrary OR combinations return NULL.
>
> Patch 3/6 -- ethdev: add flow parser library
> ---------------------------------------------
>
> W3. enum rte_flow_parser_command + enum parser_token + token-to-cmd
>     switch is a three-way invariant.
>
>   Adding a new flow command requires:
>     - new entry in enum parser_token         (private)
>     - new entry in enum rte_flow_parser_command (public)
>     - new case in parser_token_to_command()
>   with the comment in flow parser .c file flagging this explicitly.
>
>   This is a maintenance burden and an ABI risk -- forgetting the
>   third step silently maps the new command to
>   RTE_FLOW_PARSER_CMD_UNKNOWN. Consider whether the public enum
>   could be derived from the private one (table-driven) so there is
>   a single source of truth.
>
> W4. rte_flow_parser_parse_attr_str() synthesizes a full validate
>     command including pattern and actions just to harvest the attr.
>
>   lib/ethdev/rte_flow_parser.c:
>     ret =3D parser_format_cmd(&cmd, "flow validate 0 ",
>                 src, " pattern eth / end actions drop / end");
>
>   This wraps the user input with a hardcoded port id 0 and a
>   default pattern/actions that the simple API immediately throws
>   away. If the testpmd grammar ever cross-validates attr against
>   pattern/actions (e.g. "drop" not allowed on egress + transfer),
>   the simple API breaks for combinations that should be valid in
>   isolation. This is the architectural fragility of the synthesize-
>   and-strip approach in concrete form.
>
> W5. parser_format_cmd uses libc malloc on every simple-API call.
>
>   lib/ethdev/rte_flow_parser.c:
>     static int parser_format_cmd(char **dst, ...) {
>         len =3D strlen(prefix) + strlen(body) + strlen(suffix) + 1;
>         *dst =3D malloc(len);
>         ...
>         snprintf(*dst, len, "%s%s%s", prefix, body, suffix);
>
>   Plain malloc, not rte_malloc, is appropriate here since the simple
>   API claims to work without rte_eal_init. But the cost is a malloc/
>   free pair per parse call. For an API that may be used to bulk-load
>   flow rules from a config file or remote control plane, this is
>   pessimal. Consider a stack-or-VLA-based formatter, since the input
>   string length is already known.
>
> W6. parser_str_strip_trailing_end heuristic strips at most one
>     "/ end".
>
>   lib/ethdev/rte_flow_parser.c:
>     /* parser_str_strip_trailing_end ... */
>     if (strncmp(p - 3, "end", 3) !=3D 0)
>         return strlen(src);
>
>   Inputs like "drop / end / end" or "drop / end\t/end " strip only
>   the outermost. The function's comment claims tolerance for any
>   whitespace placement; it does not flag that only one trailing
>   "/ end" is stripped. This is fine in practice for human input but
>   surprising for programmatically generated input.
>
> W7. No rte_flow_parser_config_unregister().
>
>   rte_flow_parser_config_register replaces the previous registration
>   and frees indirect action list configurations created by prior
>   parsing sessions, but there is no unregister entry point. A test
>   harness that wants a clean shutdown -- or a long-lived process
>   that wants to release the SLIST of indlst_conf entries -- has to
>   re-register a zeroed config to flush. Add an unregister API and
>   call it from indlst_conf_cleanup at the same time.
>
> W8. struct rte_flow_parser_vxlan_encap_conf and friends mix bit-
>     fields and uint8_t arrays in a public header.
>
>   struct rte_flow_parser_vxlan_encap_conf {
>       uint32_t select_ipv4:1;
>       uint32_t select_vlan:1;
>       uint32_t select_tos_ttl:1;
>       uint8_t  vni[3];
>       ...
>   };
>
>   C bit-field layout is implementation-defined (order, alignment,
>   signedness of unnamed bit-fields). For a public ABI this is
>   tolerable on DPDK's supported toolchains but fragile across them.
>   At minimum, reserve the remaining 29 bits explicitly:
>       uint32_t reserved:29;
>   to lock in the layout. A more conservative choice is plain
>   uint8_t flags; with named bits.
>
> W9. char type[16] in struct rte_flow_parser_tunnel_ops and char
>     file[128]/filename[128] in rte_flow_parser_output use unnamed
>     magic constants.
>
>   struct rte_flow_parser_tunnel_ops {
>       uint32_t id;
>       char     type[16];
>       ...
>   };
>   ... struct { char file[128]; ... } dump;
>   ... struct { ... char filename[128]; } flex;
>
>   These bake fixed maxima into the ABI. Define and document
>   RTE_FLOW_PARSER_TUNNEL_TYPE_LEN, RTE_FLOW_PARSER_DUMP_FILE_LEN,
>   etc. so contributors don't have to grep to see "is 16 enough for
>   any future tunnel name?".
>
> W10. The output struct's union arm vc has multiple raw pointer
>      fields whose ownership is undocumented.
>
>   struct rte_flow_parser_output {
>       ...
>       union {
>           struct {
>               ...
>               struct rte_flow_item   *pattern;
>               struct rte_flow_action *actions;
>               struct rte_flow_action *masks;
>               uint8_t                *data;
>               ...
>           } vc;
>           struct {
>               uint64_t *rule;
>               uint64_t  rule_n;
>               ...
>           } destroy;
>           ...
>       } args;
>   };
>
>   All these pointers point either into the caller-supplied output
>   buffer (rte_flow_parser_parse) or into the static simple-API
>   buffer (parser_simple_parse). None of this is documented per
>   field. Add a per-field comment ("points into the result_size
>   buffer; valid until the next call") so a caller can see the
>   contract without reading the implementation.
>
> W11. parser_token_to_command() default branch logs ERR with no rate
>      limit.
>
>   static enum rte_flow_parser_command
>   parser_token_to_command(enum parser_token token) {
>       switch (token) {
>       ...
>       default:
>           RTE_LOG_LINE(ERR, ETHDEV, "unknown parser token %u",
>                   (unsigned int)token);
>           return RTE_FLOW_PARSER_CMD_UNKNOWN;
>       }
>   }
>
>   An attacker-controlled or fuzzed input that lands a parse on an
>   unmapped token can flood the log. Use RTE_LOG_LINE_DP or downgrade
>   to DEBUG.
>
> W12. parser_ctx_set_raw_common uses 0x06 / 0x11 instead of
>      IPPROTO_TCP / IPPROTO_UDP.
>
>   case RTE_FLOW_ITEM_TYPE_UDP:
>       size =3D sizeof(struct rte_udp_hdr);
>       proto =3D 0x11;
>       break;
>   case RTE_FLOW_ITEM_TYPE_TCP:
>       size =3D sizeof(struct rte_tcp_hdr);
>       proto =3D 0x06;
>       break;
>
>   Other branches in the same function correctly use named constants
>   (RTE_ETHER_TYPE_IPV4, IPPROTO_ROUTING). Use IPPROTO_TCP /
>   IPPROTO_UDP for consistency.
>
> Patch 4/6 -- app/test-pmd: use flow parser from ethdev
> -------------------------------------------------------
>
> W13. testpmd_flow_dispatch() (app/test-pmd/flow_parser.c) is missing
>      a release note for the dropped 14k-line app/test-pmd/cmdline_flow.c.
>
>   The release_notes for 26.07 mention the new flow parser library
>   but should also note the testpmd-internal restructuring, since
>   third-party patches against cmdline_flow.c will need rebasing.
>
> Info
> =3D=3D=3D=3D
>
> I1. Patch 1 ordering. The cmdline-stddef.h patch (patch 1/6) is
>     independent of the rest of the series. It would land cleanly on
>     its own and shorten this series's review surface.
>
> I2. Series cover letter is missing from the bundle (no [PATCH v12 0/6]
>     visible). For a 14k+ line series, a v12 cover letter summarizing
>     what changed since v11 helps reviewers focus.
>
> I3. Test coverage. test_flow_parser.c and test_flow_parser_simple.c
>     exercise the parse path well, but I do not see a test that
>     deliberately triggers the -ENOBUFS path on the simple API
>     (large pattern overflowing the 4096-byte static buffer) or the
>     aliasing pattern in A2(a). A negative test confirming that two
>     consecutive simple-API calls invalidate the first result would
>     document the contract concretely.
>
> I4. enum rte_flow_parser_command places
>     RTE_FLOW_PARSER_CMD_INDIRECT_ACTION_FLOW_CONF_CREATE alone at
>     the end after the meter-policy block, breaking the per-section
>     grouping established earlier. Move it into the indirect-action
>     block.
>
> I5. struct rte_flow_parser_action_vxlan_encap_data uses an anonymous
>     union for ipv4/ipv6 items. This is the right size optimization
>     but readers have to know to spell .item_ipv4 / .item_ipv6
>     without a containing union name. Either name the union or add
>     a comment.
>
> Summary
> =3D=3D=3D=3D=3D=3D=3D
>
> The split into rte_flow_parser.h (simple) and rte_flow_parser_config.h
> (full) is the right direction and a real improvement over earlier
> versions. The remaining structural issues are:
>
>   - cmdline -> ethdev layer inversion (A1)
>   - aliased pointer return semantics with a 4KB static buffer (A2)
>   - tab-completion stubs with no override hook (A3, A8)
>   - hack repurposing of rte_flow_attr.reserved in testpmd glue (A4)
>   - unprefixed/colliding public macro names (A5)
>   - mutated cmdline instruction (A7)
>
> A2 and A3 are the two that most directly justify the "cut/paste"
> critique: they reflect that the parser was extracted from testpmd
> without designing a context-handle ownership model or a callback
> seam for application-side state. Resolving them likely needs the
> parser to take a context handle (alloc/free) and an introspection
> ops struct in addition to the existing config registration.
> ```
>
> A few notes on findings I considered but did not include:
>
> - I did not flag the `RTE_LOG_LINE` calls in
> `indirect_action_flow_conf_create` for stale severity since they are
> correct uses.
> - The `for (i =3D n - 1; i >=3D 0; --i)` loop with `int i` and `uint32_t =
n` is
> safe for the realistic input range so I did not flag it as integer
> truncation.
> - The `select_ipv4:1`-style bit-fields are also present in existing publi=
c
> DPDK structs (`rte_flow_attr`), so I downgraded that to a Warning rather
> than an Error.
> - Skipped patches 1/6 (trivial stddef.h include), 5/6 (example) and 6/6
> (tests) since I had no findings beyond I3 and the test framework usage
> looked correct (`REGISTER_FAST_TEST` with `NOHUGE_OK, ASAN_OK`).
>
> No `Reviewed-by` is given since the series has multiple Errors and
> Warnings outstanding.
>

--0000000000008249bc065139706d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">st 6. 5. 2026 v=C2=
=A00:00 odes=C3=ADlatel Stephen Hemminger &lt;<a href=3D"mailto:stephen@net=
workplumber.org" target=3D"_blank">stephen@networkplumber.org</a>&gt; napsa=
l:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Tue,=C2=A0=
 5 May 2026 20:39:07 +0200<br>
Lukas Sismis &lt;<a href=3D"mailto:sismis@dyna-nic.com" target=3D"_blank">s=
ismis@dyna-nic.com</a>&gt; wrote:<br>
<br>
&gt; This series extracts the testpmd flow CLI parser into a reusable libra=
ry,<br>
&gt; enabling external applications to parse rte_flow rules using testpmd s=
yntax.<br>
&gt; <br>
&gt; Motivation<br>
&gt; ----------<br>
&gt; External applications like Suricata IDS [1] need to express hardware f=
iltering<br>
&gt; rules in a consistent, human-readable format. Rather than inventing cu=
stom<br>
&gt; syntax, reusing testpmd&#39;s well-tested flow grammar provides immedi=
ate<br>
&gt; compatibility with existing documentation and user knowledge.<br>
&gt; <br>
&gt; Note: This library provides only one way to create rte_flow structures=
.<br>
&gt; Applications can also construct rte_flow_attr, rte_flow_item[], and<br=
>
&gt; rte_flow_action[] directly in C code.<br>
&gt; <br>
&gt; Design<br>
&gt; ------<br>
&gt; The library (librte_flow_parser) exposes the following APIs:<br>
&gt; - rte_flow_parser_parse_attr_str(): Parse attributes only<br>
&gt; - rte_flow_parser_parse_pattern_str(): Parse patterns only<br>
&gt; - rte_flow_parser_parse_actions_str(): Parse actions only<br>
&gt; <br>
&gt; Testpmd is updated to use the library, ensuring a single<br>
&gt; maintained parser implementation.<br>
<br>
I wish it was not just a port of testpmd code to a library but had<br>
been done as a clean implementation; that said the current version is<br>
much better.<br>
<br>
AI had lots of feedback. The part that matters to me is the new dependency<=
br>
chain; and also having a syntax that looks too much like testpmd.<br>
<br>
Would prefer that only the flow part of the string was passed.<br>
<br></blockquote><div><div><br></div><div>Thanks for the feedback.</div><di=
v><br></div><div>Clean implementation would be best, but it is also worth n=
oting that it would encompass great engineering effort to get there. Portin=
g/extracting testpmd&#39;s flow parser to a separate library was the origin=
al intention, to test the waters and see if it would be used by the communi=
ty and work well in the DPDK environment. More specifically, the very first=
 original intention was to reuse the simple network pattern language to def=
ine rte_flow rule structures (eth / ipv4 / ...). Since carving out just the=
 network layer pattern parser seemed not feasible (the pattern section cont=
ains extra network-independent information, e.g., port_id/conntrack/represe=
nted ports/encaps), the scope extended to the full &quot;flow create&quot; =
command of the testpmd. That then included an even larger scope of features=
 to=C2=A0consider in the library.</div><div><br></div><div>To comment on th=
e dependency problem, I would like to mention that if this were a separate =
library, there would be no changes in dependencies in the core libraries.=
=C2=A0</div><div><br></div><div>---</div><div><br></div><div>I don&#39;t qu=
ite understand your wish of &quot;only the flow part of the string was pass=
ed&quot;. If you mean to e.g. pass only the pattern string to get pattern s=
tructures returned, then the simple API is for that purpose, e.g.:</div><di=
v><br></div><div>/**<br>=C2=A0* Parse a flow pattern from a CLI snippet.<br=
>=C2=A0*<br>=C2=A0* Parses pattern strings as used inside a flow command, s=
uch as<br>=C2=A0* &quot;eth / ipv4 src is 192.168.1.1 / tcp dst is 80 / end=
&quot;.<br>=C2=A0*<br>=C2=A0*/<br>__rte_experimental<br>int rte_flow_parser=
_parse_pattern_str(const char *src,<br>				 =C2=A0 =C2=A0 =C2=A0const struc=
t rte_flow_item **pattern,<br>				 =C2=A0 =C2=A0 =C2=A0uint32_t *pattern_n)=
;</div><div><br></div><div>If you meant to say you want to pass the full &q=
uot;flow create ... &quot; command to output attribute + patterns + actions=
 structures in one call=C2=A0<b>only</b>, then it is possible. But while it=
erating on this, I came to the conclusion that &quot;flow create&quot; is t=
ruly a control directive of the testpmd application and should not be dragg=
ed to the rte_flow parser library. So I don&#39;t think it is a good idea. =
I envision that custom applications could define their own rule-specificati=
on syntax, whether it would be the usual &quot;flow create X&quot;, YAML-st=
ructure, or something else.=C2=A0</div><div><br></div><div>---</div><div><b=
r></div><div>On the related note, to comment on your concern about &quot;ha=
ving a syntax that looks too much like testpmd&quot;. Having testpmd syntax=
 is exactly the intent of this work:=C2=A0to have a single parser for both =
the testpmd and the rte_flow parser library itself. With all this work, I t=
hought about dailing back and e.g. reducing the scope of the patch to only =
introduce a string parser for the limited set of network-layer patterns (wi=
thot the tokenizer). But this would lead to code duplication (which I wante=
d to avoid with all this work), as I didn&#39;t find a straightforward=C2=
=A0way to have part of the testpmd parser internally and the other in the l=
ibrary.</div><div><br></div><div>Perhaps, this can be a good point to decid=
e if a port of testpmd rte_flow parser would be a welcome contribution by D=
PDK maintainers, especially at this early stage of the library creation. I =
would greatly appreciate &quot;a clean library rewrite,&quot; but at this m=
oment, I estimate the complexity to be higher than the capacity that I have=
 currently.</div><div><br></div><div><br></div><div><br></div><div><br></di=
v><div><br></div><div>=C2=A0</div></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">
---<br>
<br>
I have enough material for a comprehensive architectural review. Let me wri=
te it up.<br>
<br>
---<br>
<br>
Below is my deep-dive review of the v12 series. Architecturally, this is a =
major step beyond earlier versions in terms of polish (header split, doc pa=
ge, real example, real tests), but the underlying structure is still essent=
ially the testpmd `cmdline_flow.c` lifted wholesale into `lib/ethdev`, with=
 a thin &quot;simple API&quot; wrapper that synthesizes fake testpmd comman=
ds. Several of the deeper structural problems remain, plus there are concre=
te bugs.<br>
<br>
```<br>
Series-level architectural review<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D<br>
<br>
Context<br>
-------<br>
<br>
The series moves the ~14,400-line app/test-pmd/cmdline_flow.c into a<br>
new lib/ethdev/rte_flow_parser.c, exposes a &quot;simple&quot; string-to-rt=
e_flow<br>
API in lib/ethdev/rte_flow_parser.h, exposes a fuller cmdline-aware API<br>
in lib/ethdev/rte_flow_parser_config.h, and adds cmdline glue in<br>
lib/cmdline/rte_flow_parser_cmdline.[ch]. testpmd (patch 4) is then<br>
ported to consume the library via a dispatch callback that maps<br>
RTE_FLOW_PARSER_CMD_* enum values back onto its existing port_flow_*<br>
functions.<br>
<br>
The main functional change versus past versions is that the simple API<br>
(parse_attr_str / parse_pattern_str / parse_actions_str /<br>
parse_flow_rule) now exists separately from the full command grammar.<br>
Internally however the simple API is still implemented by string-<br>
synthesizing a fake &quot;flow validate 0 ...&quot; command, running it thr=
ough<br>
the full parser, and harvesting one output field. So the architectural<br>
center of gravity is unchanged: this is the testpmd grammar exposed as<br>
a library.<br>
<br>
Errors<br>
=3D=3D=3D=3D=3D=3D<br>
<br>
Patch 3/6 -- ethdev: add flow parser library<br>
---------------------------------------------<br>
<br>
A1. lib/cmdline now depends on lib/ethdev (layer inversion).<br>
<br>
=C2=A0 lib/cmdline/meson.build:<br>
=C2=A0 =C2=A0 -deps +=3D [&#39;net&#39;]<br>
=C2=A0 =C2=A0 +deps +=3D [&#39;net&#39;, &#39;ethdev&#39;]<br>
<br>
=C2=A0 lib/cmdline is a foundational utility used by examples, internal<br>
=C2=A0 tools, and tests that have nothing to do with networking. Pulling<br=
>
=C2=A0 ethdev into it just so rte_flow_parser_cmdline.c can call into<br>
=C2=A0 rte_flow_parser_* exports inverts the layering. Every consumer of<br=
>
=C2=A0 libcmdline now links libethdev.<br>
<br>
=C2=A0 The cmdline/flow-parser glue belongs in either lib/ethdev (and the<b=
r>
=C2=A0 header in lib/ethdev too, with ethdev depending on cmdline -- the<br=
>
=C2=A0 natural direction) or in a new top-level lib/flow_parser that<br>
=C2=A0 depends on both. It does not belong inside lib/cmdline.<br>
<br>
A2. The &quot;simple API&quot; returns aliased pointers into a single 4096-=
byte<br>
=C2=A0 =C2=A0 static buffer, with no way for a caller to retain a result.<b=
r>
<br>
=C2=A0 lib/ethdev/rte_flow_parser.c:<br>
=C2=A0 =C2=A0 #define FLOW_PARSER_SIMPLE_BUF_SIZE 4096<br>
=C2=A0 =C2=A0 static uint8_t flow_parser_simple_parse_buf[FLOW_PARSER_SIMPL=
E_BUF_SIZE];<br>
=C2=A0 =C2=A0 ...<br>
=C2=A0 =C2=A0 static int parser_simple_parse(const char *cmd, ... **out) {<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 memset(flow_parser_simple_parse_buf, 0, sizeof(=
...));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D rte_flow_parser_parse(cmd,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (struct rte_flow_pa=
rser_output *)flow_parser_simple_parse_buf,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(flow_parser_=
simple_parse_buf));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ...<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 *out =3D (struct rte_flow_parser_output *)flow_=
parser_simple_parse_buf;<br>
=C2=A0 =C2=A0 }<br>
<br>
=C2=A0 Then rte_flow_parser_parse_pattern_str() does:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 *pattern =3D out-&gt;args.vc.pattern;=C2=A0 =C2=
=A0 =C2=A0/* points into buf */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 *pattern_n =3D out-&gt;args.vc.pattern_n;<br>
<br>
=C2=A0 Three resulting problems:<br>
<br>
=C2=A0 (a) Two consecutive calls alias. Any caller that wants to hold two<b=
r>
=C2=A0 =C2=A0 =C2=A0 parsed patterns simultaneously (e.g. parse two flows a=
nd call<br>
=C2=A0 =C2=A0 =C2=A0 rte_flow_create() on each) cannot, without writing the=
ir own<br>
=C2=A0 =C2=A0 =C2=A0 deep-copy via rte_flow_conv(). This is a pervasive foo=
tgun and<br>
=C2=A0 =C2=A0 =C2=A0 is only loosely documented as &quot;Points to internal=
 storage valid<br>
=C2=A0 =C2=A0 =C2=A0 until the next parse call.&quot;<br>
<br>
=C2=A0 (b) The 4096-byte cap silently rejects any flow rule whose<br>
=C2=A0 =C2=A0 =C2=A0 serialized output exceeds the buffer (returns -ENOBUFS=
), with<br>
=C2=A0 =C2=A0 =C2=A0 no way for the caller to predict what fits.<br>
<br>
=C2=A0 (c) The simple API itself uses parse_pattern_str inside a setter<br>
=C2=A0 =C2=A0 =C2=A0 example flow in the example program:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D rte_flow_parser_parse_pattern_str(..., =
&amp;items, &amp;items_n);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret =3D=3D 0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D rte_flow_parser_raw_encap=
_conf_set(0, items, items_n);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 This particular sequence is safe today because raw_enc=
ap_conf_set<br>
=C2=A0 =C2=A0 =C2=A0 doesn&#39;t re-enter the parser, but nothing in the AP=
I contract<br>
=C2=A0 =C2=A0 =C2=A0 prevents a future parser call between (A) and (B), and=
 the<br>
=C2=A0 =C2=A0 =C2=A0 example pattern teaches users a fragile idiom.<br>
<br>
=C2=A0 Suggested direction: provide a caller-supplied output mode -- e.g.<b=
r>
=C2=A0 rte_flow_parser_parse_pattern_str(src, items, items_cap, &amp;items_=
n)<br>
=C2=A0 where the caller provides storage. Or return an opaque handle owning=
<br>
=C2=A0 the storage (rte_flow_parser_pattern_new / _free), modeled on<br>
=C2=A0 rte_flow_conv().<br>
<br>
A3. All cmdline tab-completion hooks for dynamic IDs are stubbed out<br>
=C2=A0 =C2=A0 to return zero candidates, with no override mechanism.<br>
<br>
=C2=A0 lib/ethdev/rte_flow_parser.c:<br>
=C2=A0 =C2=A0 static inline int<br>
=C2=A0 =C2=A0 parser_port_id_is_invalid(uint16_t port_id)<br>
=C2=A0 =C2=A0 {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 (void)port_id;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 /* always &quot;valid&quot; */<br>
=C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 static inline uint16_t<br>
=C2=A0 =C2=A0 parser_flow_rule_count(uint16_t port_id) { return 0; }<br>
=C2=A0 =C2=A0 static inline int<br>
=C2=A0 =C2=A0 parser_flow_rule_id_get(...) { return -ENOENT; }<br>
=C2=A0 =C2=A0 /* same pattern for pattern/actions templates, tables, queues=
,<br>
=C2=A0 =C2=A0 =C2=A0* RSS queues, indirect actions */<br>
<br>
=C2=A0 These are the routines comp_rule_id, comp_pattern_template_id,<br>
=C2=A0 comp_actions_template_id, comp_table_id, comp_queue_id, etc. all<br>
=C2=A0 call into when cmdline asks for tab-completion candidates. With<br>
=C2=A0 these stubs in place, the library version of testpmd interactive<br>
=C2=A0 mode can never tab-complete a rule ID, template ID, table ID,<br>
=C2=A0 queue ID, or indirect action ID -- a regression versus the<br>
=C2=A0 current testpmd cmdline_flow.c which queries port_flow_list,<br>
=C2=A0 port_flow_template_list, etc. directly.<br>
<br>
=C2=A0 patch 4 (testpmd integration) does not register or override these<br=
>
=C2=A0 stubs anywhere. There is no callback registration interface for<br>
=C2=A0 the application to provide &quot;give me rule IDs for port N&quot; /=
 &quot;give<br>
=C2=A0 me table IDs for port N&quot; / etc.<br>
<br>
=C2=A0 A complete library extraction needs an introspection ops struct<br>
=C2=A0 that the application registers alongside rte_flow_parser_config,<br>
=C2=A0 e.g.:<br>
<br>
=C2=A0 =C2=A0 struct rte_flow_parser_introspect_ops {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint16_t (*flow_rule_count)(uint16_t port_id);<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int=C2=A0 =C2=A0 =C2=A0 (*flow_rule_id_get)(uin=
t16_t port_id, unsigned idx,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t *rule_i=
d);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* templates, tables, queues, indirect actions,=
 ... */<br>
=C2=A0 =C2=A0 };<br>
=C2=A0 =C2=A0 int rte_flow_parser_introspect_register(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const struct rte_flow_parser_intr=
ospect_ops *ops);<br>
<br>
A4. testpmd dispatch repurposes rte_flow_attr.reserved as a side<br>
=C2=A0 =C2=A0 channel for relaxed_matching.<br>
<br>
=C2=A0 app/test-pmd/flow_parser.c (patch 4):<br>
=C2=A0 =C2=A0 case RTE_FLOW_PARSER_CMD_PATTERN_TEMPLATE_CREATE:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 port_flow_pattern_template_create(in-&gt;port,<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 in-&gt;args.vc.pat_templ_id,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;((const struct rte_flow_patt=
ern_template_attr) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .relaxed_matching =
=3D in-&gt;args.vc.attr.reserved,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .ingress=C2=A0 =3D =
in-&gt;args.vc.attr.ingress,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .egress=C2=A0 =C2=
=A0=3D in-&gt;args.vc.attr.egress,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .transfer =3D in-&g=
t;args.vc.attr.transfer,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 in-&gt;args.vc.pattern);<br>
<br>
=C2=A0 rte_flow_attr.reserved is documented in lib/ethdev/rte_flow.h as<br>
=C2=A0 reserved and required to be zero. Smuggling<br>
=C2=A0 pattern_template_attr.relaxed_matching through that field couples<br=
>
=C2=A0 the library output to a hack and breaks the moment anyone sets<br>
=C2=A0 rte_flow_attr.reserved for any other purpose, or starts validating<b=
r>
=C2=A0 it. The output struct already has a vc.{pat_templ,act_templ,table}<b=
r>
=C2=A0 arm -- relaxed_matching belongs there, not overlaid on attr.reserved=
.<br>
<br>
A5. Public preprocessor macros in rte_flow_parser_config.h are<br>
=C2=A0 =C2=A0 unprefixed and one of them collides with a generic name.<br>
<br>
=C2=A0 lib/ethdev/rte_flow_parser_config.h:<br>
=C2=A0 =C2=A0 #define ACTION_RAW_ENCAP_MAX_DATA=C2=A0 =C2=A0512<br>
=C2=A0 =C2=A0 #define RAW_ENCAP_CONFS_MAX_NUM=C2=A0 =C2=A0 =C2=A08<br>
=C2=A0 =C2=A0 #define ACTION_RSS_QUEUE_NUM=C2=A0 =C2=A0 =C2=A0 =C2=A0 128<b=
r>
=C2=A0 =C2=A0 #define ACTION_VXLAN_ENCAP_ITEMS_NUM 6<br>
=C2=A0 =C2=A0 #define ACTION_NVGRE_ENCAP_ITEMS_NUM 5<br>
=C2=A0 =C2=A0 #define ACTION_IPV6_EXT_PUSH_MAX_DATA 512<br>
=C2=A0 =C2=A0 #define IPV6_EXT_PUSH_CONFS_MAX_NUM 8<br>
=C2=A0 =C2=A0 #define ACTION_SAMPLE_ACTIONS_NUM=C2=A0 =C2=A010<br>
=C2=A0 =C2=A0 #define RAW_SAMPLE_CONFS_MAX_NUM=C2=A0 =C2=A0 8<br>
=C2=A0 =C2=A0 #ifndef RSS_HASH_KEY_LENGTH<br>
=C2=A0 =C2=A0 #define RSS_HASH_KEY_LENGTH=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
64<br>
=C2=A0 =C2=A0 #endif<br>
<br>
=C2=A0 Every one of these is now exported by an installed public header<br>
=C2=A0 with no RTE_FLOW_PARSER_ prefix. RSS_HASH_KEY_LENGTH in particular<b=
r>
=C2=A0 is a generic name almost guaranteed to collide -- any application<br=
>
=C2=A0 that defined its own RSS_HASH_KEY_LENGTH=3D40 (matching its hardware=
)<br>
=C2=A0 before including this header would silently get 40 inside flow<br>
=C2=A0 parser slots, with the parser&#39;s slot layout corrupted by mismatc=
hed<br>
=C2=A0 array sizes.<br>
<br>
=C2=A0 All of these need an RTE_FLOW_PARSER_ prefix and the #ifndef guard<b=
r>
=C2=A0 on RSS_HASH_KEY_LENGTH should be removed -- it is an invitation to<b=
r>
=C2=A0 define-mismatch bugs.<br>
<br>
A6. Doc/header inconsistency: parser_parse() declared in config.h<br>
=C2=A0 =C2=A0 but documented as living in cmdline.h.<br>
<br>
=C2=A0 doc/guides/prog_guide/flow_parser_lib.rst:<br>
=C2=A0 =C2=A0 &quot;rte_flow_parser_parse() from rte_flow_parser_cmdline.h =
parses<br>
=C2=A0 =C2=A0 complete flow CLI commands ...&quot;<br>
<br>
=C2=A0 but the declaration is in lib/ethdev/rte_flow_parser_config.h<br>
=C2=A0 (line 15342 of the diff). The doc is also internally inconsistent:<b=
r>
=C2=A0 the same .rst earlier says &quot;Additional functions for full comma=
nd<br>
=C2=A0 parsing and cmdline integration are available in<br>
=C2=A0 rte_flow_parser_cmdline.h. These include rte_flow_parser_parse()<br>
=C2=A0 ...&quot; -- which is wrong twice.<br>
<br>
A7. local_cmd_flow-&gt;help_str =3D ... mutates the cmdline instruction.<br=
>
<br>
=C2=A0 lib/cmdline/rte_flow_parser_cmdline.c:<br>
=C2=A0 =C2=A0 if (local_cmd_flow !=3D NULL)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 local_cmd_flow-&gt;help_str =3D help ? help : n=
ame;<br>
<br>
=C2=A0 This mutates the cmdline_parse_inst_t passed to<br>
=C2=A0 rte_flow_parser_cmdline_register(). Idiomatic cmdline usage in DPDK<=
br>
=C2=A0 declares cmdline_parse_inst_t variables as static const aggregates<b=
r>
=C2=A0 (see lib/cmdline/cmdline_parse.h examples and the rest of testpmd).<=
br>
=C2=A0 Passing such an instance here writes to read-only memory and<br>
=C2=A0 segfaults. The .rst note (&quot;The library writes to inst-&gt;help_=
str<br>
=C2=A0 dynamically ... must remain valid for the lifetime of the cmdline<br=
>
=C2=A0 session&quot;) flags the lifetime question but does not flag the<br>
=C2=A0 mutability requirement, which is the actually fatal one.<br>
<br>
=C2=A0 The fix is to keep help_str storage internal to the library and<br>
=C2=A0 return it via a side channel (e.g. an out-pointer in the get_help<br=
>
=C2=A0 callback) rather than mutating the caller&#39;s instruction.<br>
<br>
Patch 4/6 -- app/testpmd: use flow parser from ethdev<br>
------------------------------------------------------<br>
<br>
A8. Tab completion regression for dynamic IDs.<br>
<br>
=C2=A0 As described in A3, removing app/test-pmd/cmdline_flow.c and<br>
=C2=A0 replacing it with the library means testpmd&#39;s interactive flow<b=
r>
=C2=A0 command-line loses tab completion on rule IDs, pattern/actions<br>
=C2=A0 template IDs, table IDs, queue IDs, RSS queue IDs, and indirect<br>
=C2=A0 action IDs. Today&#39;s cmdline_flow.c calls port_flow_list,<br>
=C2=A0 port_flow_template_list, port_flow_template_table_list, etc. The<br>
=C2=A0 replacement library calls parser_flow_rule_count, etc., which<br>
=C2=A0 return 0.<br>
<br>
=C2=A0 Until the introspection callback (A3) is in place, this patch<br>
=C2=A0 needs at minimum a release note entry explicitly calling out the<br>
=C2=A0 loss of tab completion. As written, the change description in the<br=
>
=C2=A0 patch does not mention it.<br>
<br>
Warnings<br>
=3D=3D=3D=3D=3D=3D=3D=3D<br>
<br>
Patch 2/6 -- ethdev: add RSS type helper APIs<br>
----------------------------------------------<br>
<br>
W1. The &quot;all&quot; entry hardcodes the OR of every RTE_ETH_RSS_* proto=
col<br>
=C2=A0 =C2=A0 bit and will silently go stale.<br>
<br>
=C2=A0 lib/ethdev/rte_ethdev.c:<br>
=C2=A0 =C2=A0 { &quot;all&quot;, RTE_ETH_RSS_ETH | RTE_ETH_RSS_VLAN | RTE_E=
TH_RSS_IP |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RTE_ETH_RSS_TCP | RTE_ETH_RSS_UDP=
 | RTE_ETH_RSS_SCTP |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RTE_ETH_RSS_L2_PAYLOAD | RTE_ETH_=
RSS_L2TPV3 |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RTE_ETH_RSS_ESP | RTE_ETH_RSS_AH =
| RTE_ETH_RSS_PFCP |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RTE_ETH_RSS_GTPU | RTE_ETH_RSS_EC=
PRI | RTE_ETH_RSS_MPLS |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RTE_ETH_RSS_L2TPV2 | RTE_ETH_RSS_=
IB_BTH },<br>
<br>
=C2=A0 Whenever a new RTE_ETH_RSS_* protocol bit is added, this list will<b=
r>
=C2=A0 drift unless the contributor remembers this table. There is an<br>
=C2=A0 existing convention RTE_ETH_RSS_PROTO_MASK in rte_ethdev.h that<br>
=C2=A0 collects these; consider using it (or extending it) so the table<br>
=C2=A0 tracks the canonical mask automatically.<br>
<br>
W2. rte_eth_rss_type_to_str(0) returns &quot;none&quot; but<br>
=C2=A0 =C2=A0 rte_eth_rss_type_to_str(RTE_ETH_RSS_IPV4 | RTE_ETH_RSS_IPV6)<=
br>
=C2=A0 =C2=A0 returns NULL.<br>
<br>
=C2=A0 The &quot;to_str&quot; function uses =3D=3D on the table, so it succ=
eeds only<br>
=C2=A0 for values exactly present as a table entry. The Doxygen says<br>
=C2=A0 &quot;RSS type value (RTE_ETH_RSS_*)&quot; which a caller will reaso=
nably<br>
=C2=A0 read as accepting any combination of RTE_ETH_RSS_* bits. The<br>
=C2=A0 doc should explicitly state that only single-entry table values<br>
=C2=A0 round-trip; arbitrary OR combinations return NULL.<br>
<br>
Patch 3/6 -- ethdev: add flow parser library<br>
---------------------------------------------<br>
<br>
W3. enum rte_flow_parser_command + enum parser_token + token-to-cmd<br>
=C2=A0 =C2=A0 switch is a three-way invariant.<br>
<br>
=C2=A0 Adding a new flow command requires:<br>
=C2=A0 =C2=A0 - new entry in enum parser_token=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(private)<br>
=C2=A0 =C2=A0 - new entry in enum rte_flow_parser_command (public)<br>
=C2=A0 =C2=A0 - new case in parser_token_to_command()<br>
=C2=A0 with the comment in flow parser .c file flagging this explicitly.<br=
>
<br>
=C2=A0 This is a maintenance burden and an ABI risk -- forgetting the<br>
=C2=A0 third step silently maps the new command to<br>
=C2=A0 RTE_FLOW_PARSER_CMD_UNKNOWN. Consider whether the public enum<br>
=C2=A0 could be derived from the private one (table-driven) so there is<br>
=C2=A0 a single source of truth.<br>
<br>
W4. rte_flow_parser_parse_attr_str() synthesizes a full validate<br>
=C2=A0 =C2=A0 command including pattern and actions just to harvest the att=
r.<br>
<br>
=C2=A0 lib/ethdev/rte_flow_parser.c:<br>
=C2=A0 =C2=A0 ret =3D parser_format_cmd(&amp;cmd, &quot;flow validate 0 &qu=
ot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 src, &quot; pattern=
 eth / end actions drop / end&quot;);<br>
<br>
=C2=A0 This wraps the user input with a hardcoded port id 0 and a<br>
=C2=A0 default pattern/actions that the simple API immediately throws<br>
=C2=A0 away. If the testpmd grammar ever cross-validates attr against<br>
=C2=A0 pattern/actions (e.g. &quot;drop&quot; not allowed on egress + trans=
fer),<br>
=C2=A0 the simple API breaks for combinations that should be valid in<br>
=C2=A0 isolation. This is the architectural fragility of the synthesize-<br=
>
=C2=A0 and-strip approach in concrete form.<br>
<br>
W5. parser_format_cmd uses libc malloc on every simple-API call.<br>
<br>
=C2=A0 lib/ethdev/rte_flow_parser.c:<br>
=C2=A0 =C2=A0 static int parser_format_cmd(char **dst, ...) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 len =3D strlen(prefix) + strlen(body) + strlen(=
suffix) + 1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 *dst =3D malloc(len);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ...<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 snprintf(*dst, len, &quot;%s%s%s&quot;, prefix,=
 body, suffix);<br>
<br>
=C2=A0 Plain malloc, not rte_malloc, is appropriate here since the simple<b=
r>
=C2=A0 API claims to work without rte_eal_init. But the cost is a malloc/<b=
r>
=C2=A0 free pair per parse call. For an API that may be used to bulk-load<b=
r>
=C2=A0 flow rules from a config file or remote control plane, this is<br>
=C2=A0 pessimal. Consider a stack-or-VLA-based formatter, since the input<b=
r>
=C2=A0 string length is already known.<br>
<br>
W6. parser_str_strip_trailing_end heuristic strips at most one<br>
=C2=A0 =C2=A0 &quot;/ end&quot;.<br>
<br>
=C2=A0 lib/ethdev/rte_flow_parser.c:<br>
=C2=A0 =C2=A0 /* parser_str_strip_trailing_end ... */<br>
=C2=A0 =C2=A0 if (strncmp(p - 3, &quot;end&quot;, 3) !=3D 0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return strlen(src);<br>
<br>
=C2=A0 Inputs like &quot;drop / end / end&quot; or &quot;drop / end\t/end &=
quot; strip only<br>
=C2=A0 the outermost. The function&#39;s comment claims tolerance for any<b=
r>
=C2=A0 whitespace placement; it does not flag that only one trailing<br>
=C2=A0 &quot;/ end&quot; is stripped. This is fine in practice for human in=
put but<br>
=C2=A0 surprising for programmatically generated input.<br>
<br>
W7. No rte_flow_parser_config_unregister().<br>
<br>
=C2=A0 rte_flow_parser_config_register replaces the previous registration<b=
r>
=C2=A0 and frees indirect action list configurations created by prior<br>
=C2=A0 parsing sessions, but there is no unregister entry point. A test<br>
=C2=A0 harness that wants a clean shutdown -- or a long-lived process<br>
=C2=A0 that wants to release the SLIST of indlst_conf entries -- has to<br>
=C2=A0 re-register a zeroed config to flush. Add an unregister API and<br>
=C2=A0 call it from indlst_conf_cleanup at the same time.<br>
<br>
W8. struct rte_flow_parser_vxlan_encap_conf and friends mix bit-<br>
=C2=A0 =C2=A0 fields and uint8_t arrays in a public header.<br>
<br>
=C2=A0 struct rte_flow_parser_vxlan_encap_conf {<br>
=C2=A0 =C2=A0 =C2=A0 uint32_t select_ipv4:1;<br>
=C2=A0 =C2=A0 =C2=A0 uint32_t select_vlan:1;<br>
=C2=A0 =C2=A0 =C2=A0 uint32_t select_tos_ttl:1;<br>
=C2=A0 =C2=A0 =C2=A0 uint8_t=C2=A0 vni[3];<br>
=C2=A0 =C2=A0 =C2=A0 ...<br>
=C2=A0 };<br>
<br>
=C2=A0 C bit-field layout is implementation-defined (order, alignment,<br>
=C2=A0 signedness of unnamed bit-fields). For a public ABI this is<br>
=C2=A0 tolerable on DPDK&#39;s supported toolchains but fragile across them=
.<br>
=C2=A0 At minimum, reserve the remaining 29 bits explicitly:<br>
=C2=A0 =C2=A0 =C2=A0 uint32_t reserved:29;<br>
=C2=A0 to lock in the layout. A more conservative choice is plain<br>
=C2=A0 uint8_t flags; with named bits.<br>
<br>
W9. char type[16] in struct rte_flow_parser_tunnel_ops and char<br>
=C2=A0 =C2=A0 file[128]/filename[128] in rte_flow_parser_output use unnamed=
<br>
=C2=A0 =C2=A0 magic constants.<br>
<br>
=C2=A0 struct rte_flow_parser_tunnel_ops {<br>
=C2=A0 =C2=A0 =C2=A0 uint32_t id;<br>
=C2=A0 =C2=A0 =C2=A0 char=C2=A0 =C2=A0 =C2=A0type[16];<br>
=C2=A0 =C2=A0 =C2=A0 ...<br>
=C2=A0 };<br>
=C2=A0 ... struct { char file[128]; ... } dump;<br>
=C2=A0 ... struct { ... char filename[128]; } flex;<br>
<br>
=C2=A0 These bake fixed maxima into the ABI. Define and document<br>
=C2=A0 RTE_FLOW_PARSER_TUNNEL_TYPE_LEN, RTE_FLOW_PARSER_DUMP_FILE_LEN,<br>
=C2=A0 etc. so contributors don&#39;t have to grep to see &quot;is 16 enoug=
h for<br>
=C2=A0 any future tunnel name?&quot;.<br>
<br>
W10. The output struct&#39;s union arm vc has multiple raw pointer<br>
=C2=A0 =C2=A0 =C2=A0fields whose ownership is undocumented.<br>
<br>
=C2=A0 struct rte_flow_parser_output {<br>
=C2=A0 =C2=A0 =C2=A0 ...<br>
=C2=A0 =C2=A0 =C2=A0 union {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ...<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct rte_flow_item=C2=A0=
 =C2=A0*pattern;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct rte_flow_action *ac=
tions;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct rte_flow_action *ma=
sks;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *data;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ...<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } vc;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t *rule;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t=C2=A0 rule_n;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ...<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } destroy;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ...<br>
=C2=A0 =C2=A0 =C2=A0 } args;<br>
=C2=A0 };<br>
<br>
=C2=A0 All these pointers point either into the caller-supplied output<br>
=C2=A0 buffer (rte_flow_parser_parse) or into the static simple-API<br>
=C2=A0 buffer (parser_simple_parse). None of this is documented per<br>
=C2=A0 field. Add a per-field comment (&quot;points into the result_size<br=
>
=C2=A0 buffer; valid until the next call&quot;) so a caller can see the<br>
=C2=A0 contract without reading the implementation.<br>
<br>
W11. parser_token_to_command() default branch logs ERR with no rate<br>
=C2=A0 =C2=A0 =C2=A0limit.<br>
<br>
=C2=A0 static enum rte_flow_parser_command<br>
=C2=A0 parser_token_to_command(enum parser_token token) {<br>
=C2=A0 =C2=A0 =C2=A0 switch (token) {<br>
=C2=A0 =C2=A0 =C2=A0 ...<br>
=C2=A0 =C2=A0 =C2=A0 default:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RTE_LOG_LINE(ERR, ETHDEV, &quot;unknown =
parser token %u&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (unsigned in=
t)token);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return RTE_FLOW_PARSER_CMD_UNKNOWN;<br>
=C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 }<br>
<br>
=C2=A0 An attacker-controlled or fuzzed input that lands a parse on an<br>
=C2=A0 unmapped token can flood the log. Use RTE_LOG_LINE_DP or downgrade<b=
r>
=C2=A0 to DEBUG.<br>
<br>
W12. parser_ctx_set_raw_common uses 0x06 / 0x11 instead of<br>
=C2=A0 =C2=A0 =C2=A0IPPROTO_TCP / IPPROTO_UDP.<br>
<br>
=C2=A0 case RTE_FLOW_ITEM_TYPE_UDP:<br>
=C2=A0 =C2=A0 =C2=A0 size =3D sizeof(struct rte_udp_hdr);<br>
=C2=A0 =C2=A0 =C2=A0 proto =3D 0x11;<br>
=C2=A0 =C2=A0 =C2=A0 break;<br>
=C2=A0 case RTE_FLOW_ITEM_TYPE_TCP:<br>
=C2=A0 =C2=A0 =C2=A0 size =3D sizeof(struct rte_tcp_hdr);<br>
=C2=A0 =C2=A0 =C2=A0 proto =3D 0x06;<br>
=C2=A0 =C2=A0 =C2=A0 break;<br>
<br>
=C2=A0 Other branches in the same function correctly use named constants<br=
>
=C2=A0 (RTE_ETHER_TYPE_IPV4, IPPROTO_ROUTING). Use IPPROTO_TCP /<br>
=C2=A0 IPPROTO_UDP for consistency.<br>
<br>
Patch 4/6 -- app/test-pmd: use flow parser from ethdev<br>
-------------------------------------------------------<br>
<br>
W13. testpmd_flow_dispatch() (app/test-pmd/flow_parser.c) is missing<br>
=C2=A0 =C2=A0 =C2=A0a release note for the dropped 14k-line app/test-pmd/cm=
dline_flow.c.<br>
<br>
=C2=A0 The release_notes for 26.07 mention the new flow parser library<br>
=C2=A0 but should also note the testpmd-internal restructuring, since<br>
=C2=A0 third-party patches against cmdline_flow.c will need rebasing.<br>
<br>
Info<br>
=3D=3D=3D=3D<br>
<br>
I1. Patch 1 ordering. The cmdline-stddef.h patch (patch 1/6) is<br>
=C2=A0 =C2=A0 independent of the rest of the series. It would land cleanly =
on<br>
=C2=A0 =C2=A0 its own and shorten this series&#39;s review surface.<br>
<br>
I2. Series cover letter is missing from the bundle (no [PATCH v12 0/6]<br>
=C2=A0 =C2=A0 visible). For a 14k+ line series, a v12 cover letter summariz=
ing<br>
=C2=A0 =C2=A0 what changed since v11 helps reviewers focus.<br>
<br>
I3. Test coverage. test_flow_parser.c and test_flow_parser_simple.c<br>
=C2=A0 =C2=A0 exercise the parse path well, but I do not see a test that<br=
>
=C2=A0 =C2=A0 deliberately triggers the -ENOBUFS path on the simple API<br>
=C2=A0 =C2=A0 (large pattern overflowing the 4096-byte static buffer) or th=
e<br>
=C2=A0 =C2=A0 aliasing pattern in A2(a). A negative test confirming that tw=
o<br>
=C2=A0 =C2=A0 consecutive simple-API calls invalidate the first result woul=
d<br>
=C2=A0 =C2=A0 document the contract concretely.<br>
<br>
I4. enum rte_flow_parser_command places<br>
=C2=A0 =C2=A0 RTE_FLOW_PARSER_CMD_INDIRECT_ACTION_FLOW_CONF_CREATE alone at=
<br>
=C2=A0 =C2=A0 the end after the meter-policy block, breaking the per-sectio=
n<br>
=C2=A0 =C2=A0 grouping established earlier. Move it into the indirect-actio=
n<br>
=C2=A0 =C2=A0 block.<br>
<br>
I5. struct rte_flow_parser_action_vxlan_encap_data uses an anonymous<br>
=C2=A0 =C2=A0 union for ipv4/ipv6 items. This is the right size optimizatio=
n<br>
=C2=A0 =C2=A0 but readers have to know to spell .item_ipv4 / .item_ipv6<br>
=C2=A0 =C2=A0 without a containing union name. Either name the union or add=
<br>
=C2=A0 =C2=A0 a comment.<br>
<br>
Summary<br>
=3D=3D=3D=3D=3D=3D=3D<br>
<br>
The split into rte_flow_parser.h (simple) and rte_flow_parser_config.h<br>
(full) is the right direction and a real improvement over earlier<br>
versions. The remaining structural issues are:<br>
<br>
=C2=A0 - cmdline -&gt; ethdev layer inversion (A1)<br>
=C2=A0 - aliased pointer return semantics with a 4KB static buffer (A2)<br>
=C2=A0 - tab-completion stubs with no override hook (A3, A8)<br>
=C2=A0 - hack repurposing of rte_flow_attr.reserved in testpmd glue (A4)<br=
>
=C2=A0 - unprefixed/colliding public macro names (A5)<br>
=C2=A0 - mutated cmdline instruction (A7)<br>
<br>
A2 and A3 are the two that most directly justify the &quot;cut/paste&quot;<=
br>
critique: they reflect that the parser was extracted from testpmd<br>
without designing a context-handle ownership model or a callback<br>
seam for application-side state. Resolving them likely needs the<br>
parser to take a context handle (alloc/free) and an introspection<br>
ops struct in addition to the existing config registration.<br>
```<br>
<br>
A few notes on findings I considered but did not include:<br>
<br>
- I did not flag the `RTE_LOG_LINE` calls in `indirect_action_flow_conf_cre=
ate` for stale severity since they are correct uses.<br>
- The `for (i =3D n - 1; i &gt;=3D 0; --i)` loop with `int i` and `uint32_t=
 n` is safe for the realistic input range so I did not flag it as integer t=
runcation.<br>
- The `select_ipv4:1`-style bit-fields are also present in existing public =
DPDK structs (`rte_flow_attr`), so I downgraded that to a Warning rather th=
an an Error.<br>
- Skipped patches 1/6 (trivial stddef.h include), 5/6 (example) and 6/6 (te=
sts) since I had no findings beyond I3 and the test framework usage looked =
correct (`REGISTER_FAST_TEST` with `NOHUGE_OK, ASAN_OK`).<br>
<br>
No `Reviewed-by` is given since the series has multiple Errors and Warnings=
 outstanding.<br>
</blockquote></div></div>
</div>

--0000000000008249bc065139706d--
