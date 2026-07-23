Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F84C531D0
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Jul 2026 19:35:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E887C402EA;
	Thu, 23 Jul 2026 21:35:25 +0200 (CEST)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com
 [209.85.215.169])
 by mails.dpdk.org (Postfix) with ESMTP id F12B340280
 for <dev@dpdk.org>; Thu, 23 Jul 2026 21:35:23 +0200 (CEST)
Received: by mail-pg1-f169.google.com with SMTP id
 41be03b00d2f7-c9b373d5af0so781053a12.2
 for <dev@dpdk.org>; Thu, 23 Jul 2026 12:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1784835323;
 x=1785440123; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OYujeVaA5VK758aopJfjNG0RIjCU36J4Qukgkusnq0g=;
 b=c/crTj9AajaXQMxAl/CK/JGvAhUCS1ClT1NtnDvId6Ew1JMudP0Da2kYGDnsSmJsVA
 HxGKa/Q0Qh6CZ3mPXD8K6yySLWiQA+DUBYLm2acMk6cxUJGEAND9ap4+4jSvDqJRaySu
 dhOYIKSjrCbWVLHe4JVAWXYuXce101p1G4SV70JqYkX+mYFlvJV3YKdvH53v8QqWe1ht
 eY8crTgNEm18d46NxB8q/pgNOndU25Ws47L1SNU1PqO9zzOx7L45lMWHKUDAzK2uLS4w
 VHl5K6UmCNlNxSR7px/+5wFP7gAZjtmYRP1K+i5LJiIoQH73cac2lPMkXZ/ABR7X47JF
 cTuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784835323; x=1785440123;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OYujeVaA5VK758aopJfjNG0RIjCU36J4Qukgkusnq0g=;
 b=RekbStqCffmb+82K/hQxlcSYq4Q3sjj8xCZcSQpaQFvX2ojTAetTWHX8XlBvN1LRgZ
 NKNfiO7WJGjmMBrUT8wPq6J0WDbG1sQhr2IDHtu1Rw2z/exhEy74gwLcQMmDOFXwhCT4
 65w2lmfNynnE+k21PvUg5cejGrPNzAsLrsplSj+4GddYRr9ARXiF0TUHzFRBvyjA0sNs
 0+FmWcggfrEkUWTe6txoKOaIpRT5gU3VCApwgyp8oDCNPGzYReCxE/PE2NgcptOjBaQo
 QqGUzZCzBdjR8owMoMqGk/TH6rVJD1I+3fgIG7GpW4YuWZus7SlprDCXNUksOzgz9KOs
 XXww==
X-Gm-Message-State: AOJu0YznS1KzmAG3MItD23i78mf2q4Rx1BJCtOZNKTiLoTZNoQsn+1xT
 P6Ld/V6y56fNhpFY/P7pYyR8Wu/yApxjgM6AQEUExxKKXjj8z1KXE0QQw5cyFgzWFhCaWJXPKtB
 2D91p
X-Gm-Gg: AR+sD10szLiLl0edeoNts5ykYzIpRHRL/82NBxreMqT/Nfo+MT4Sds8lFrikJcSGYzZ
 s3VnTiW/WSKV0YnJf+zeTWZ1LsE7R19xDg7GLmCw+3gs7HxEtJp3XZ13V6azX69rTJmiItwDmma
 7AeEfCEMxgPzzJ/FsBr3X73rfI42PqLaNC1pjOzh7yd/bAZTUDg1RDkWkGz+jPorCdG886lnNMx
 XHmYU0OQsd+TvDvdyNOW5ybBn4NskJIUgtC2CeEz+1BW9LGFtIwAgT5CFxnR14rFRAbpLT/EUhz
 DiXIzDMbhK3sgjLUjWk79Y3H2VFSATjCZgO6+DKdnPUA9zy+Mmst5HKGaoD9yTLo/nMsldeBmpZ
 YPW04rfXTfyuvpaviJKHGYvInwQ23jzEfKrKX156zDH/3EDlzBgnKO+h4CCPVda+IhNGLZT9w1B
 +075a6WN36Fp/jur/YNIKI6ZbWQbNurDiBhEKX1KA+QZII/BRYqDTCyw==
X-Received: by 2002:a05:6a20:72a2:b0:3bf:c49d:9183 with SMTP id
 adf61e73a8af0-3c44b21d79fmr4622914637.50.1784835322886; 
 Thu, 23 Jul 2026 12:35:22 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147df09ac0sm19924549eec.16.2026.07.23.12.35.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 12:35:22 -0700 (PDT)
Date: Thu, 23 Jul 2026 12:35:19 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org
Subject: Re: [RFC PATCH v1 00/21] Building a better rte_flow parser
Message-ID: <20260723123519.2a21167c@phoenix.local>
In-Reply-To: <cover.1773681363.git.anatoly.burakov@intel.com>
References: <cover.1773681363.git.anatoly.burakov@intel.com>
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

On Mon, 16 Mar 2026 17:27:28 +0000
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
> else should be covered or cover-able.
> 
> The second piece is a reusable flow engine framework for Intel Ethernet drivers.
> This is kept Intel-local for now because I do not feel it is generic enough to
> be presented as an ethdev-wide engine model. Even so, the intent is to establish
> a cleaner parser architecture with a defined interaction model, explicit memory
> ownership rules, and engine definitions that do not block secondary-process-safe
> usage. It is my hope that we could also promote something like this into ethdev
> proper and remove the necessity for drivers to build so much boilerplate around
> rte_flow parsing (and more often than not doing it in a way that is more complex
> than it needs to be).
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
> Series depends on previously submitted patchsets:
> 
> - IAVF global buffer fix [1]
> - Common attr parsing stuff [2]
> 
> [1] https://patches.dpdk.org/project/dpdk/list/?series=37585&state=*
> [2] https://patches.dpdk.org/project/dpdk/list/?series=37663&state=*
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
>  drivers/net/intel/common/flow_engine.h        | 1003 ++++
>  drivers/net/intel/common/flow_util.h          |  165 +
>  drivers/net/intel/i40e/i40e_ethdev.c          |   56 +-
>  drivers/net/intel/i40e/i40e_ethdev.h          |   49 +-
>  drivers/net/intel/i40e/i40e_fdir.c            |   47 -
>  drivers/net/intel/i40e/i40e_flow.c            | 4092 +----------------
>  drivers/net/intel/i40e/i40e_flow.h            |   44 +
>  drivers/net/intel/i40e/i40e_flow_ethertype.c  |  258 ++
>  drivers/net/intel/i40e/i40e_flow_fdir.c       | 1806 ++++++++
>  drivers/net/intel/i40e/i40e_flow_hash.c       | 1289 ++++++
>  drivers/net/intel/i40e/i40e_flow_tunnel.c     | 1510 ++++++
>  drivers/net/intel/i40e/i40e_hash.c            |  980 +---
>  drivers/net/intel/i40e/i40e_hash.h            |    8 +-
>  drivers/net/intel/i40e/meson.build            |    4 +
>  drivers/net/intel/ixgbe/ixgbe_ethdev.c        |   40 +-
>  drivers/net/intel/ixgbe/ixgbe_ethdev.h        |   13 +-
>  drivers/net/intel/ixgbe/ixgbe_fdir.c          |   13 +-
>  drivers/net/intel/ixgbe/ixgbe_flow.c          | 3130 +------------
>  drivers/net/intel/ixgbe/ixgbe_flow.h          |   38 +
>  .../net/intel/ixgbe/ixgbe_flow_ethertype.c    |  240 +
>  drivers/net/intel/ixgbe/ixgbe_flow_fdir.c     | 1510 ++++++
>  drivers/net/intel/ixgbe/ixgbe_flow_hash.c     |  182 +
>  drivers/net/intel/ixgbe/ixgbe_flow_l2tun.c    |  228 +
>  drivers/net/intel/ixgbe/ixgbe_flow_ntuple.c   |  483 ++
>  drivers/net/intel/ixgbe/ixgbe_flow_security.c |  297 ++
>  drivers/net/intel/ixgbe/ixgbe_flow_syn.c      |  280 ++
>  drivers/net/intel/ixgbe/meson.build           |    7 +
>  lib/ethdev/meson.build                        |    1 +
>  lib/ethdev/rte_flow_graph.h                   |  414 ++
>  29 files changed, 9867 insertions(+), 8320 deletions(-)
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

Detailed AI review found some issues here.

Review: [RFC PATCH v1 00/21] Intel flow parser rework (flow graph + engine framework)

No Reviewed-by: a functional bug remains (see patch 02).

Patch 02/21 - net/intel/common: add flow engines (flow_engine.h)

Error: created flows are never tracked; destroy corrupts memory, flush/reset leak.
  ci_flow_create() allocates, parses, installs, and returns a flow but never links
  it into engine_conf->flows. The series has TAILQ_INIT + 3x TAILQ_REMOVE + 2x
  FOREACH over that list, but no TAILQ_INSERT into it anywhere. Once an engine is
  registered:
    - ci_flow_destroy() runs TAILQ_REMOVE on a node never inserted. ci_flow_alloc()
      zeroes the ci_flow header, so node.tqe_prev == NULL, and TAILQ_REMOVE's
      "*(elm)->field.tqe_prev = ..." is a NULL-pointer write -> crash/corruption on
      first rule destroy.
    - ci_flow_flush() and ci_flow_engine_conf_reset() iterate an always-empty list,
      so created rules are never uninstalled from HW and are leaked (incl. at close).
  Fix: on the success path in ci_flow_create(), before goto unlock:
      TAILQ_INSERT_TAIL(&engine_conf->flows, flow, node);

Info: ci_flow_engine_conf_reset() calls ci_flow_free(engine, flow) without the
  "if (engine == NULL) continue;" guard that ci_flow_flush() has; ci_flow_free()
  dereferences engine->ops. Unreachable today (list always empty) but inconsistent.

Patch 01/21 - ethdev: add flow graph API (rte_flow_graph.h)

Warning: __rte_internal is applied to six static inline functions. That macro is a
  symbol-visibility attribute for exported (non-inline) symbols; on static inline it
  is meaningless and, without ALLOW_INTERNAL_API, expands to
  __attribute__((error("Symbol is not public ABI"))). Verified against current main:
  a TU including the header and calling rte_flow_graph_parse() fails at -O0 without
  ALLOW_INTERNAL_API ("Symbol is not public ABI", x8); clean with it. In-tree drivers
  set the flag so CI passes, but the header ships in driver_sdk_headers and the
  section(".text.internal") placement is still wrong. Also applied inconsistently
  (the two constraint helpers omit it). Recommend dropping __rte_internal from the
  inlines.

Warning: doc references nonexistent macro. struct rte_flow_graph_edge comment and the
  next field comment say "terminated by RTE_FLOW_EDGE_END"; the defined sentinel is
  RTE_FLOW_NODE_EDGE_END.

Info: rte_flow_graph_parse() visits node[0] with item == NULL. If a driver gives
  node[0] constraints or a validate/process callback, __flow_graph_node_is_expected()
  dereferences item->spec (NULL) or passes NULL to the callback. Default empty graph
  is safe; the "node[0] is a bare start node" contract is implicit - document/guard.

Design (RFC-level): both the graph (per-node validate/process fn-pointers) and
  ci_flow_engine_ops (13 callbacks) are callback-table frameworks. The header aims to
  avoid a "driver-within-a-driver framework" - worth confirming the callback surface
  is minimal (e.g. optional ctx_validate, separate flow_alloc/flow_free) before the
  non-RFC spin.
