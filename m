Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC341E937EA
	for <dpdk-dev@archiver.kernel.org>; Sun, 12 Apr 2026 16:42:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9217F4025A;
	Sun, 12 Apr 2026 18:42:27 +0200 (CEST)
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
 by mails.dpdk.org (Postfix) with ESMTP id D71B740150
 for <dev@dpdk.org>; Sun, 12 Apr 2026 18:42:25 +0200 (CEST)
Received: by mail-dl1-f52.google.com with SMTP id
 a92af1059eb24-12732165d1eso13203744c88.1
 for <dev@dpdk.org>; Sun, 12 Apr 2026 09:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776012145;
 x=1776616945; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=njIX3TQ8zefxVLFVtZ0VbBvUJOtXAYPstKhXzzJh1fI=;
 b=gYjQ1VAmn4sRvnaQPl5jhfkbSjXkpWq6o/ktdxt9eKFVJboE4aeZr+6JbUGV61Khy0
 jV5tlhX0sGJbyb7bCGGbnw6I3jaA5FU+O0+97HPm/lxYcyTxPFW3CADX8k2vVMbKorAl
 7mHbx3H7XFvbE+gHFNB5qdv5qRR1qiBolDMYYMUebV8/Ry5yA10pRdFOnKkb9ETGBhEB
 t+jR0zgDrVhrdUm1X9H1B1sjcRa5PxjSrUi6+oo6MPyO9wtMFGA4H4du4vvEXmfVtxTJ
 TlSBjdwHsMbfGn0fpRx78AzR9U35o6xKl2GnrR2aUq9PBB84BL7tBFuWsXU4sKfaeECx
 RVcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776012145; x=1776616945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=njIX3TQ8zefxVLFVtZ0VbBvUJOtXAYPstKhXzzJh1fI=;
 b=clyDBq+BfFCd8khu1L0X1WenwA3H2zab1F5wnBL2nWVHDZCo9Z9V5z+YfRZFELA3/D
 qxrATXPgPfDTMsPnQpGHxnOglCqY0P8J8UlmtUmSb9F9FuJeQsaKFwh9DIXteVcE+kUE
 vuQk6cORbTAtFk4w7CGS4h0ztle1XPOcF1918VhOBlfWEpNpUbypTASIvzg2bCLvoY+S
 IndYPLa2zu9ckAdEMNpZHcE04AQZPUJmOFtZDR+DvnzfWFssAdWzXNJL3RxkjcIzwffo
 QM6eipvHTsnZEIS6tlsKl4J58tttCX2wMINIHLvmnDx+v39qpkYn/mc7gh9veWX11b+E
 UleQ==
X-Gm-Message-State: AOJu0YzBjfTiIboS/P7ZutnaLNwoooqk7HIr+Ka6xuB7hYpgJDINdMXP
 U/81tTZNZBRPNRoU+gLnw52ATqMSMG0mcpVNV35/ZJLCfG4hmxHFd7syzrlmsYyY9XI=
X-Gm-Gg: AeBDievO5Mp930QuQ6gIGUFYtQC6LEbfp/XtAq3fO8X+yzeBapPkijqeRIIHW+4Wyt/
 nmA1NCiANTLI5Y59JxD7zgIb97TIkU1P9L3i9AAFdPmG1GZf8LZZN1x7santHkkFE4T7s48IiJy
 o2QJWxmDns9vT6YTQXN8XdQgwownHQDq4RLpdhE/yWFm86FnQSgh2RzaLLmDzpFaFFZHCrZ/ZXU
 plByRLEmo978wSATHvVEDaXVu7S5T4e99DECe1cNju3AHF1wtuW5CRs5B8U9NGjOcGfJgz588iX
 E1sVvahO5Vnq8IhtZZXBhDEVpzzFwsOv7InbwEGt+LG73x2f8R48kwPZjpvTYjXUFUCn/4ZoRKC
 Lrvqsju4I+tBVmVnfvSOJ1TXUI4i9Mdc5xksS3vftNNT7sNrUG4TId1VIVAsjDxAMLSzMgD7kyF
 LQmn0OROCIY6nbZgE94BoIb+JK0wHS2B4cPx4=
X-Received: by 2002:a05:7022:327:b0:119:e56b:98a4 with SMTP id
 a92af1059eb24-12c34e6069bmr5818576c88.11.1776012144573; 
 Sun, 12 Apr 2026 09:42:24 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c4acc7d6fsm2888147c88.5.2026.04.12.09.42.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2026 09:42:24 -0700 (PDT)
Date: Sun, 12 Apr 2026 09:42:21 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org
Subject: Re: [RFC PATCH v1 00/21] Building a better rte_flow parser
Message-ID: <20260412094221.4defa766@phoenix.local>
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

Good to see common code, but this patchset is complex.
AI review found a couple issues that need addressing.

=== Review: [PATCH v3 00/29] Intel PMD common flow handling ===

Review of series from Anatoly Burakov <anatoly.burakov@intel.com>


This series refactors flow attribute and action validation across Intel
PMDs (ixgbe, i40e, iavf, ice) into common code in flow_check.h, while
also converting ixgbe flow-related functions from rte_eth_dev to
ixgbe_adapter parameters for multiprocess safety.

Patches 1/29, 2/29, 3/29, 6/29, 7/29, 8/29, 9/29, 10/29, 11/29,
13/29, 14/29, 15/29, 16/29, 17/29, 18/29, 19/29, 20/29, 21/29,
22/29, 23/29, 24/29, 25/29, 26/29, 27/29, 28/29, 29/29: no issues.

----------------------------------------------------------------------
Patch 4/29: net/ixgbe: use adapter in flow-related calls
----------------------------------------------------------------------

Error: In ixgbe_clear_all_l2_tn_filter(), the macro is called with
the wrong argument:

  struct ixgbe_adapter *adapter = IXGBE_DEV_PRIVATE_TO_ADAPTER(dev);

This casts the rte_eth_dev pointer directly to ixgbe_adapter, which
is a type confusion. Every other call site in this patch passes
dev->data->dev_private. Should be:

  struct ixgbe_adapter *adapter = IXGBE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);

----------------------------------------------------------------------
Patch 5/29: net/intel/common: add common flow action parsing
----------------------------------------------------------------------

Error: In __flow_action_check_rss(), the queue/queue_num consistency
check has inverted logic:

  if ((q_num == 0) == (rss->queue == NULL)) {
      return rte_flow_error_set(error, ...);
  }

This errors when q_num and queue are both absent or both present (the
valid cases), and accepts when they are mismatched (the invalid cases).
When q_num > 0 and queue == NULL passes this check, the subsequent
contiguity loop dereferences rss->queue, which is a NULL pointer
dereference.

The key_len/key check immediately below correctly uses != for the same
pattern. Fix:

  if ((q_num == 0) != (rss->queue == NULL)) {

Warning: ci_flow_check_actions() returns -EINVAL at the end when
parsed_actions->count is zero (all VOID actions), but does not call
rte_flow_error_set(). Every other error path in that function sets
the flow error. Callers may report a confusing empty error to the
application.

----------------------------------------------------------------------
Patch 12/29: net/ixgbe: use common checks in FDIR filters
----------------------------------------------------------------------

Warning: ixgbe_fdir_actions_check() rejects DROP+MARK via the check:

  if (drop_action != NULL && action != NULL) {
      return rte_flow_error_set(..., "Conflicting actions");
  }

The old ixgbe_parse_fdir_act_attr() allowed DROP+MARK (set fdirflags
and soft_id together). The new parse functions still contain code to
handle DROP+MARK (setting rule->soft_id from aux_action), but it is
now dead code because the check function rejects the combination
before parsing.

If DROP+MARK was intentionally disallowed, the dead aux_action
handling should be removed from ixgbe_parse_fdir_filter_normal() and
ixgbe_parse_fdir_filter_tunnel(). If it should still be allowed, the
check needs to permit a MARK alongside DROP.

Also, this block in ixgbe_fdir_actions_check() is dead code:

  if (drop_action == NULL && action != NULL &&
      action->type == RTE_FLOW_ACTION_TYPE_DROP) {
      drop_action = action;
  }

DROP is in fwd_actions[], so a DROP as the second action is already
rejected by the preceding "must not be a forwarding action" check.
