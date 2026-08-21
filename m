Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 113C3C5DF94
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Aug 2026 15:27:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CF6594028C;
	Fri, 21 Aug 2026 17:27:25 +0200 (CEST)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by mails.dpdk.org (Postfix) with ESMTP id 27ED74027B
 for <dev@dpdk.org>; Fri, 21 Aug 2026 17:27:24 +0200 (CEST)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-c9eefcf9175so1155421a12.3
 for <dev@dpdk.org>; Fri, 21 Aug 2026 08:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787326043;
 x=1787930843; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QJWBLDOzOPBC/6Jd1ksWYezaI/5Dp0O154BXbmyU9iI=;
 b=JcUgDMAvxc68UJ9fI/W91Lz3mTXanQpwssTMmzN0SoJxEEaCpu+Pyv9EBoUqarJ1A2
 NiddVleI8X66JWVBLlIPxbAdRsoBQhI7uQRSVXrM81HZHYa4ACUVedHSDi09uAVeBQdm
 oLwfu3VLBjuFwoK/2AJmBpwNM1v6TjDIU0s3XZcpjhCHF5dWIqZQ5MPD5Lsp5Oay1gUR
 Ok2tkifbvryKkFMm6z0ChFOsZnpXQl0Ds3fLaL4ajf+M1lcZyugwSo2fNaZujkD1AKIV
 QiKoHdVjrnlpAn7bFtFRS+5/CWQUu7mCW3Ot9ejwrWWDjKF88gbFx5+7HeJiKapSdlIJ
 slQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787326043; x=1787930843;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QJWBLDOzOPBC/6Jd1ksWYezaI/5Dp0O154BXbmyU9iI=;
 b=ntm/hNCzNr5jUcSzYbPB7wTU2vfAcl8wPnIhQl1qTskrKXfrSLuBzf1YDYLr/sONj2
 sVr7a3c1niNhYcSzQ20lXpzWP/B6Clvw49/6Qnu1toGrbGUT0u+++4g82Sufh/+S9RZT
 AZsOWE/SAivMRT6NGPNXfOTrxZpJTlP5CjnqHEdIhW/7YuLOrIgZmGXGbqDX4aGe2NsG
 aeYLoAH+UZkXVbTJNicfbvgzDn5uU9a2QkHYvuejRG2QQtHVmhaJ0zgKv1KZiI4kxND5
 8nZ2GlsTU5/x/D5sh/7fxhWnb5ldSZ5TzZOllWcpQMpTFpKF9aqYI+RdXX/q27A5mkgg
 Zj9g==
X-Gm-Message-State: AFuF++nzs3VSNkrdJJ7mFWv1Or4uo4BTlOKerxzfHRn2INbfYv1eMN5c
 Q8A2f+z3r/vVuGeNc9mgZrG88A0m/kTII8jBv90pJJfOYH16WJ840WHMbROY/UsUbTI=
X-Gm-Gg: AR+sD117hQdNWZYx+wr/c86lK7aI34TN8gXrfzkd7+qE4x3hfiHbKNqxKUAB+DMtVy4
 P5zKjExzcKGWIz4GUxDlxoU5z0kvRq4Xogx+FW/KjeOhCsXXxl06XZQxqNSbg0sY9heuvgISu3a
 tUGUagDwvv2/vJZBLk+2+/UvEeOoFrJ+cwC9UbXxmv+QqWLvLwHo5H7CprfXXVTt0QM/5jjfajD
 OBviAhx2ktaD40Cb258xFJVG7fe2dzkbIkfR0/rywr2hSie0ro9DZbew9e4v/57oCNOORSk9kmf
 hhJlYfnClZlvwlGHuktcsEHZX2DJyWDl2Mezp7mdsyeYWxNKhDp6JgHx0OU1vy+foE5lnP3K572
 Gd8ePGxlrRNUkfXWuRCB2m8hGwQLJsct2L88qtxkBFODsVvSngowYhOfCMpTeVw9V8aPLCUno42
 BUt85X0mmSkuPn0jrSspVQOohkt9G8m4e4X7JbQfKBDU6d6cNti+ghNOXbNrfK0rvBoim4PuLun
 UQ/DAbRmkRzfy4IM4LEvatG4OTKIW4=
X-Received: by 2002:a17:90b:3c84:b0:390:b41a:b92b with SMTP id
 98e67ed59e1d1-395c3542369mr14178213a91.4.1787326042516; 
 Fri, 21 Aug 2026 08:27:22 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c4b82e5csm3744668a91.16.2026.08.21.08.27.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 08:27:22 -0700 (PDT)
Date: Fri, 21 Aug 2026 08:27:11 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v1 00/21] Building a better rte_flow parser
Message-ID: <20260821082711.6a37838d@phoenix.local>
In-Reply-To: <cover.1787233986.git.anatoly.burakov@intel.com>
References: <cover.1787233986.git.anatoly.burakov@intel.com>
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

On Thu, 20 Aug 2026 15:00:45 +0100
Anatoly Burakov <anatoly.burakov@intel.com> wrote:

> Most rte_flow parsers in DPDK suffer from huge implementation complexity because
> even though 99% of what people use rte_flow parsers for is parsing protocol
> graphs, no parser is written explicitly as a graph. This patchset attempts to
> suggest a viable model to build rte_flow parsers as graphs, by offering a
> lightweight header only library to build rte_flow parsering graphs without too
> much boilerplate and complexity.
> 
> Most of the patchset is about Intel drivers, but they are meant as
> reimplementations as well as examples for the rest of the community to assess
> how to build parsers using this new infrastructure. I expect the first two
> patches will be of most interest to non-Intel reviewers, as they deal with
> building two reusable parser architecture pieces.
> 
> The first piece is a new flow graph helper in ethdev. Its purpose is
> deliberately narrow: it targets the protocol-graph part of rte_flow pattern
> parsing, where drivers walk packet headers and validate legal item sequences and
> parameters. That does not cover all possible rte_flow features, especially more
> exotic flow items, but it does cover a large and widely shared part of what
> existing drivers need to do. Or, to put it in other words, the only flow items
> this infrastructure *doesn't* cover is things that do not lend themselves well
> to be parsed as a graph of protocol headers (e.g. conntrack items). Everything
> else should be covered or cover-able. In practice, just about all drivers will
> benefit from graph parsing as all but one of them implement only the protocol
> stack parts, which are the ones targeted by the graph helper.
> 
> The second piece is a reusable flow engine framework for Intel Ethernet drivers.
> This is kept Intel-local because I do not feel it is even appropriate to define
> such a framework for all drivers to use in the first place. Even so, the intent
> is to establish a cleaner parser architecture with a defined interaction model,
> explicit memory ownership rules, and engine definitions that do not block
> secondary-process-safe usage. It is my hope that this would serve as a model for
> other drivers to follow, expand on, rework, and improve, so that maybe down the
> line we *might* have a common rte_flow infrastructure for drivers to use.
> 
> Most of the rest of the series is parser reimplementation, but that is mainly
> the vehicle for demonstrating and validating those two pieces. ixgbe and i40e
> are wired into the new common parsing path, and their existing parsers are
> migrated incrementally to the graph-based model. Besides reducing ad hoc parser
> code, this also makes validation more explicit and more consistent with the
> actual install path. In a few places that means invalid inputs that were
> previously ignored, deferred, or interpreted loosely are now rejected earlier
> and more strictly, without any increase in code complexity (in fact, with marked
> *decrease* of it!).
> 
> For now, there is a hack in
> 
> RFC -> v1:
> - Fixed a lot of bugs, concurrency issues, and init/uninit sequence problems in
>   Intel common flow engine implementation
> - Fixed a few copypaste errors in various engines
> - Improved comment documentation and flow engine docs
> 
> Anatoly Burakov (21):
>   ethdev: add flow graph API
>   net/intel/common: add flow engines infrastructure
>   net/intel/common: add utility functions
>   net/ixgbe: add support for common flow parsing
>   net/ixgbe: reimplement ethertype parser
>   net/ixgbe: reimplement syn parser
>   net/ixgbe: reimplement L2 tunnel parser
>   net/ixgbe: reimplement ntuple parser
>   net/ixgbe: reimplement security parser
>   net/ixgbe: reimplement FDIR parser
>   net/ixgbe: reimplement hash parser
>   net/i40e: add support for common flow parsing
>   net/i40e: reimplement ethertype parser
>   net/i40e: reimplement FDIR parser
>   net/i40e: reimplement tunnel QinQ parser
>   net/i40e: reimplement VXLAN parser
>   net/i40e: reimplement NVGRE parser
>   net/i40e: reimplement MPLS parser
>   net/i40e: reimplement gtp parser
>   net/i40e: reimplement L4 cloud parser
>   net/i40e: reimplement hash parser
> 
>  doc/guides/prog_guide/ethdev/flow_graph.rst   |  748 +++
>  doc/guides/prog_guide/ethdev/index.rst        |    1 +
>  doc/guides/rel_notes/release_26_11.rst        |    7 +
>  drivers/net/intel/common/flow_engine.h        | 1373 ++++++
>  drivers/net/intel/common/flow_util.h          |  183 +
>  drivers/net/intel/i40e/i40e_ethdev.c          |   69 +-
>  drivers/net/intel/i40e/i40e_ethdev.h          |   66 +-
>  drivers/net/intel/i40e/i40e_fdir.c            |   78 +-
>  drivers/net/intel/i40e/i40e_flow.c            | 4181 +----------------
>  drivers/net/intel/i40e/i40e_flow.h            |   30 +
>  drivers/net/intel/i40e/i40e_flow_ethertype.c  |  250 +
>  drivers/net/intel/i40e/i40e_flow_fdir.c       | 1834 ++++++++
>  drivers/net/intel/i40e/i40e_flow_hash.c       | 1298 +++++
>  drivers/net/intel/i40e/i40e_flow_tunnel.c     | 1504 ++++++
>  drivers/net/intel/i40e/i40e_hash.c            | 1037 +---
>  drivers/net/intel/i40e/i40e_hash.h            |    9 +-
>  drivers/net/intel/i40e/meson.build            |    4 +
>  drivers/net/intel/i40e/rte_pmd_i40e.c         |    3 +-
>  drivers/net/intel/ixgbe/ixgbe_ethdev.c        |   43 +-
>  drivers/net/intel/ixgbe/ixgbe_ethdev.h        |   17 +-
>  drivers/net/intel/ixgbe/ixgbe_fdir.c          |    1 -
>  drivers/net/intel/ixgbe/ixgbe_flow.c          | 3208 +------------
>  drivers/net/intel/ixgbe/ixgbe_flow.h          |   27 +
>  .../net/intel/ixgbe/ixgbe_flow_ethertype.c    |  245 +
>  drivers/net/intel/ixgbe/ixgbe_flow_fdir.c     | 1553 ++++++
>  drivers/net/intel/ixgbe/ixgbe_flow_hash.c     |  178 +
>  drivers/net/intel/ixgbe/ixgbe_flow_l2tun.c    |  230 +
>  drivers/net/intel/ixgbe/ixgbe_flow_ntuple.c   |  493 ++
>  drivers/net/intel/ixgbe/ixgbe_flow_security.c |  320 ++
>  drivers/net/intel/ixgbe/ixgbe_flow_syn.c      |  283 ++
>  drivers/net/intel/ixgbe/ixgbe_ipsec.c         |   54 +-
>  drivers/net/intel/ixgbe/ixgbe_ipsec.h         |    4 +-
>  drivers/net/intel/ixgbe/meson.build           |    7 +
>  lib/ethdev/meson.build                        |    1 +
>  lib/ethdev/rte_flow_graph.h                   |  532 +++
>  35 files changed, 11289 insertions(+), 8582 deletions(-)
>  create mode 100644 doc/guides/prog_guide/ethdev/flow_graph.rst
>  create mode 100644 drivers/net/intel/common/flow_engine.h
>  create mode 100644 drivers/net/intel/common/flow_util.h
>  create mode 100644 drivers/net/intel/i40e/i40e_flow.h
>  create mode 100644 drivers/net/intel/i40e/i40e_flow_ethertype.c
>  create mode 100644 drivers/net/intel/i40e/i40e_flow_fdir.c
>  create mode 100644 drivers/net/intel/i40e/i40e_flow_hash.c
>  create mode 100644 drivers/net/intel/i40e/i40e_flow_tunnel.c
>  create mode 100644 drivers/net/intel/ixgbe/ixgbe_flow.h
>  create mode 100644 drivers/net/intel/ixgbe/ixgbe_flow_ethertype.c
>  create mode 100644 drivers/net/intel/ixgbe/ixgbe_flow_fdir.c
>  create mode 100644 drivers/net/intel/ixgbe/ixgbe_flow_hash.c
>  create mode 100644 drivers/net/intel/ixgbe/ixgbe_flow_l2tun.c
>  create mode 100644 drivers/net/intel/ixgbe/ixgbe_flow_ntuple.c
>  create mode 100644 drivers/net/intel/ixgbe/ixgbe_flow_security.c
>  create mode 100644 drivers/net/intel/ixgbe/ixgbe_flow_syn.c
>  create mode 100644 lib/ethdev/rte_flow_graph.h
> 

It doesn't build:

Best taken up in next-net-intel tree.

AI had some insights.

Review of "[PATCH v1 00/21] Intel flow parser rework" (bundle 2069)
Anatoly Burakov <anatoly.burakov@intel.com>

Applied on top of DPDK main (c1a46b9).  Patches 01-08 and 12-20 apply
cleanly; 09, 10, 11 and 21 need the prerequisite series noted in the
"Depends-on: series-39013 (I40E refactors)" tag, so those four were
reviewed from the diffs only.

Patch 01: ethdev: add flow graph API
-----------------------------------

Error: RTE_FLOW_GRAPH_LOG assumes a logtype variable that is not a
DPDK-wide convention.

  +#ifdef RTE_COMPONENT_NAME
  +extern int RTE_CONCAT(RTE_COMPONENT_NAME, _logtype_driver);

RTE_COMPONENT_NAME is defined by both drivers/meson.build (line 278)
and lib/meson.build (line 241), so in an in-tree build the #ifdef
branch is always taken and the #else branch (rte_eth_dev_logtype) is
dead.  That means every component that includes this header must
happen to define <name>_logtype_driver or it fails to link.  That
holds for the Intel PMDs but is not a project-wide guarantee -- only
67 of the net drivers define such a symbol -- and it is certainly not
true for lib/ethdev itself.

This pattern was borrowed from drivers/net/intel/common/log.h, where
it is reasonable because the header is documented as Intel-driver-only.
A lib/ethdev driver-SDK header should not carry that assumption.
Suggest either always using rte_eth_dev_logtype (rte_ethdev.h is
already pulled in via rte_flow.h, so the symbol is visible), or
passing a logtype into rte_flow_graph_parse().

Error: reserved identifiers.  The internal helpers are named
__flow_graph_node_check_constraint, __flow_graph_node_is_expected,
__flow_graph_node_is_ignored, __flow_graph_get_node_index,
__flow_graph_node_is_valid, __flow_graph_find_next_node and
__flow_graph_visit_node.  Identifiers beginning with two underscores
are reserved to the implementation in all scopes (C11 7.1.3).  These
are static inline in an installed header, so they are injected into
every driver translation unit.  Use a single leading underscore-free
prefix instead, e.g. rte_flow_graph_node_check_constraint(), or drop
them behind a naming scheme the project already uses.

Warning: the ALLOW_EXPERIMENTAL_API conditional makes the header
behave differently depending on build flags.

  +#ifdef ALLOW_EXPERIMENTAL_API
  +	ret = rte_flow_conv(RTE_FLOW_CONV_OP_ITEM_NAME_PTR, ...

The 20-line comment above it already concedes this is a workaround
("a hack of monumental proportions", "hopefully we'll come up with a
proper solution in one of the next versions of this patchset").  As
written, item names silently become "UNKNOWN" in one of the three
configurations chkincs builds, so the debug messages this whole
function exists to produce are configuration-dependent.  Either fix
chkincs to skip experimental-disabled builds for driver_sdk headers,
or drop the name lookup and log the numeric item type, which needs no
experimental API at all.

Warning: RTE_FLOW_NODE_EDGE_END is defined as ((size_t)~0U), which is
0xFFFFFFFF on LP64, not SIZE_MAX.  It works because producers and
consumers both use the macro, but it reads like a bug and will trip
anyone who writes SIZE_MAX in a driver edge table.  Use
((size_t)-1) or SIZE_MAX.

Info: struct rte_flow_graph holds non-const pointers:

  +struct rte_flow_graph {
  +	struct rte_flow_graph_node *nodes;
  +	struct rte_flow_graph_edge *edges;

Everything in the traversal path treats the graph as read-only, and
the design notes in patch 02 explicitly require engine definitions to
live in read-only memory.  Making both members const would let
drivers declare the tables const without casting.

Info: struct rte_flow_graph_node declares two members const
(type, constraints) and two non-const.  A struct with const members
cannot be assigned or memcpy'd as a whole; the mix is arbitrary.
Either const the whole struct at the point of definition or none of
the members.

Info: the guide is added under doc/guides/prog_guide/ethdev/, which is
the application programmer's guide, but the header's own @file block
says "This is an internal API for PMD drivers only.  Applications must
not use it."  Consider placing it where the other driver-facing
material lives.

Info: doc/guides/prog_guide/ethdev/flow_graph.rst says "It is not
recommended to create loops in the graph, as these loops will be
unbounded."  Traversal is driven by the pattern array, not by the
graph, so a cycle in the edge tables is bounded by pattern length.
The statement is misleading as written.

Patch 02: net/intel/common: add flow engines infrastructure
-----------------------------------------------------------

Error: ci_flow_alloc() converts an engine's "out of capacity" signal
into a successful generic allocation.

  +	if (engine->ops->flow_alloc != NULL)
  +		flow = engine->ops->flow_alloc(engine, engine_conf->dev_data, priv);
  +	if (flow == NULL) {
  +		flow = (struct ci_flow *)rte_zmalloc(NULL, engine->flow_size, 0);
  +		if (flow != NULL && engine->ops->flow_alloc != NULL)
  +			fallback = true;

The only engine in the series with a custom allocator is i40e fdir
(patch 14), whose flow_alloc() returns NULL for two distinct reasons:
the hardware table is full (fdir_actual_cnt >= fdir_space_size) and
the flow pool bitmap is exhausted.  Both are capacity limits, and both
are silently overridden here: the framework hands back a heap flow,
ci_flow_create() proceeds to flow_install(), and ci_flow_free() then
takes the rte_free() path so the engine never learns the flow existed.
The pool index accounting in i40e_fdir_flow_free() is bypassed
entirely.

A NULL from flow_alloc() should be treated as "this engine cannot take
this flow" and move on to the next engine, or be an outright failure.
If a fallback is genuinely wanted, the engine needs a way to
distinguish "allocation failed, try the generic path" from "no
capacity".

Warning: ci_flow_validate() frees the trial flow with plain free()
after running the full parse chain including ctx_to_flow():

  +		flow = (struct ci_flow *)calloc(1, engine_ref.engine->flow_size);
  ...
  +		ret = ci_flow_parse(engine_conf, engine_ref.engine, attr, pattern,
  +				actions, flow, error);
  +		free(flow);

The header's own design notes say "Engines may still allocate
auxiliary data (for per-engine private state or pointers stored inside
flows) ... [which] should follow engine_init/engine_uninit or flow
lifetime as appropriate."  Any engine that honours that contract by
allocating in ctx_to_flow() will leak on every rte_flow_validate()
call.  No engine in this series does so yet, so this is latent, but
the framework contract and the framework implementation disagree.
Either document that ctx_to_flow() must not allocate, or give the
validate path a teardown hook.

Warning: ci_flow_flush() frees flows whose uninstall failed.

  +		/* ignore failures */
  +		ci_flow_uninstall(engine_ref, flow, error);
  +
  +		TAILQ_REMOVE(&engine_conf->flows, flow, node);
  +		ci_flow_free(engine_ref, flow);

If flow_uninstall() fails the rule is still programmed in hardware,
but the software object is destroyed and removed from the list, so
there is no longer any way to retry or to account for it.  Worth at
least logging the failure and returning non-zero from ci_flow_flush()
rather than unconditionally returning 0.  The same &error is also
reused across iterations, so only the last failure survives.

Warning: ci_flow_engine_conf_reset() takes the write lock and is
documented "thread-safe", but ci_flow_engine_conf_init() calls
rte_rwlock_init() on the same lock without holding it, and is
documented "thread-unsafe".  The pairing is confusing.  Since both are
primary-process-only setup/teardown per the design notes, dropping the
lock from reset() and documenting both as serialised by the caller
would be clearer than the current asymmetry.

Info: ci_flow_alloc() uses rte_zmalloc(NULL, ...) for the flow object.
Flows are stored in the shared per-device flow list and the whole
design goal is secondary-process compatibility, so
rte_zmalloc_socket() with the device's socket_id would keep the
allocation NUMA-local to the port.  Same for the priv_size allocation
in ci_flow_engine_init() and the pool/bitmap allocations in i40e fdir
engine_init.

Info: struct ci_flow_engine_list is a fixed 64-entry array
(CI_FLOW_ENGINE_MAX), so every driver pays 512 bytes for what is
currently four or five engines.  A pointer plus count would be no
harder to use with the FOREACH macro and would drop the NULL-
termination requirement.

Patch 03: net/intel/common: add utility functions
--------------------------------------------------

Info: header guard comment does not match the guard.

  +#ifndef _COMMON_INTEL_FLOW_UTIL_H_
  ...
  +#endif /* _INTEL_COMMON_FLOW_UTIL_H_ */

Patch 04: net/ixgbe: add support for common flow parsing
---------------------------------------------------------

Warning: ixgbe_flow_destroy() misreports a failed uninstall as
"Flow not found".

  +	ret = ci_flow_destroy(&adapter->flow_engine_conf, flow, error);
  +	if (ret == 0)
  +		return 0;
  +
  +	/* fall back to legacy engines */

ci_flow_destroy() returns non-zero for two unrelated cases: the handle
does not belong to the new engine (correct: fall through to legacy),
and the handle does belong to it but flow_uninstall() failed.  In the
second case control falls into the legacy path, the ownership scan
over adapter->flow_list does not find the handle, and the caller gets
EINVAL "Flow not found for this port" while the rule is still
programmed and still on the engine's flow list.  ci_flow_destroy()
needs to distinguish "not mine" from "mine, and it failed" -- e.g.
return -ENOENT for the former -- so the driver can propagate the real
error.

Warning: the same function reads through the handle before ownership
is established:

  +	struct rte_flow *pmd_flow = flow;
  +	enum rte_filter_type filter_type = pmd_flow->filter_type;

struct rte_flow embeds struct ci_flow as its first member, so a legacy
flow is a valid ci_flow, but the reverse does not hold: a flow created
by the new engine is sized by engine->flow_size and the bytes at that
offset are engine-private state.  The value is unused when
ci_flow_destroy() succeeds, so this is not currently exploitable, but
it is a type-punned read on every destroy.  Move the initialisation
below the ci_flow_destroy() early return.

Info: ixgbe_flow_create() falls through to the legacy engines even
when ci_flow_create() failed for a non-recoverable reason (ENOMEM from
ci_flow_alloc(), which does "goto unlock" precisely because "this is a
serious error so don't continue").  Distinguishing ENOTSUP from ENOMEM
at the driver boundary would preserve that intent.  The stale
rte_flow_error left behind by the failed ci_flow_create() call is also
overwritten only if the legacy path itself sets one.

Patch 14: net/i40e: reimplement FDIR parser
--------------------------------------------

Error: i40e_fdir_flow_uninstall() marks its error parameter
__rte_unused and then uses it.

  +i40e_fdir_flow_uninstall(struct ci_flow *flow, struct rte_flow_error *error __rte_unused)
  ...
  +		return rte_flow_error_set(error, ENOTSUP,
  +				RTE_FLOW_ERROR_TYPE_HANDLE,
  +				NULL, "Failed to delete fdir filter.");

__rte_unused is __attribute__((unused)), which suppresses the warning
rather than forbidding use, so this compiles -- but the annotation is
wrong and will mislead the next reader.  Drop it.

Info: i40e_fdir_flow_engine_uninit() does rte_free(priv->bmp), which
relies on rte_bitmap_init() returning its mem argument unchanged.
That is true today but it is an implementation detail of
rte_bitmap.h.  Storing bmp_mem alongside bmp in
struct i40e_fdir_engine_priv, and freeing that, would not depend on it.

General notes
-------------

The cover letter's "Depends-on: series-39013" is on patch 01 only.
Since 09/10/11 and 21 are the patches that actually fail to apply
without it, it would help to repeat the tag on the cover letter so it
shows up in patchwork for the whole series.


Overlap with the testpmd flow-parser rework
--------------------------------------------

No overlap.  The two efforts sit on opposite sides of the rte_flow
API:

  - The testpmd work is about app/test-pmd/cmdline_flow.c, the CLI
    grammar that turns "flow create 0 ingress pattern eth / ipv4 /
    end actions queue index 3 / end" into arrays of struct
    rte_flow_item and struct rte_flow_action.  That is a text parser,
    which is why lex/yacc is a natural fit.

  - This series is about what a PMD does with those arrays once
    rte_flow_create() hands them over.  rte_flow_graph_parse() walks
    an already-constructed rte_flow_item array against a driver's
    protocol graph and extracts hardware register fields.  There is
    no text anywhere in it.

Concretely, no patch in the series touches app/ at all -- the 21
patches are confined to lib/ethdev, doc/, and drivers/net/intel.
The only shared surface is rte_flow_conv(RTE_FLOW_CONV_OP_ITEM_NAME_PTR),
which patch 01 uses for debug strings and cmdline_flow.c uses for
token names; if the yacc/lex rework changes rte_flow_conv semantics
both would need to follow, but that is a soft coupling, not a
conflict.  A merge conflict between the two is not possible on the
current file sets.


Tree routing
------------

Mostly agreed, with one caveat.

Patches 02-21 are entirely under drivers/net/intel (common, ixgbe,
i40e) and belong in dpdk-next-net-intel.  The Depends-on series is
also i40e, which reinforces that.

Patch 01 is the exception: it adds lib/ethdev/rte_flow_graph.h,
lib/ethdev/meson.build, a prog_guide chapter and a release note.
MAINTAINERS covers it under "F: lib/ethdev/rte_flow*", i.e. the Flow
API section, so it wants an ack from the flow API and ethdev
maintainers before it moves, even if it ultimately travels with the
rest of the series through next-net-intel to keep the series
bisectable.  Given that patch 01 is the one with the design questions
above (logtype coupling, reserved identifiers, the
ALLOW_EXPERIMENTAL_API workaround), it is probably worth asking for it
to be settled on-list before the driver patches are queued.
