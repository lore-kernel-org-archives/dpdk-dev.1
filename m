Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A5DCA601C
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 Oct 2026 10:59:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 81244402E0;
	Fri,  9 Oct 2026 12:59:26 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id C9D0A40279
 for <dev@dpdk.org>; Fri,  9 Oct 2026 12:59:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791543565; x=1823079565;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=pEpOqn/hQn6jvTRJxU2fUNgwGY7anuP8hnELjo3zejY=;
 b=kECbatc/J1hiLb7a1GFxqKminhWbcEENQ9X89/pOz85WCS8L7p4C4cQ2
 T7GbK4HcJp9ljPrSO1fs8R3HzgST/vEFEsfYLCULfrgm+Y/XLAZ40kX1d
 nKuM/zj6Vw4+Zmxw6XcNZtegiOi2uF8kS5ZDIxVB4Zs0Ths+LRKFmKgVO
 kc/FhvM/2AtR5u28RnyNmDB3CW49Ybe12yYIX6pxU0I/x7NfSuQ/y8MFJ
 WVwTyHPzkhovhbD8dNmVX4m2jl0eDcs1mX0ZhFJPXWR2kAsMlbOavhnN1
 rF3pzVeAOlJ7evpSCXnWxAJoZzmoJ1MkzKsm8GJ82+Mzt6DF+yMy5oDR6 g==;
X-CSE-ConnectionGUID: umaCaeUrT6KyA4sF0r5KNQ==
X-CSE-MsgGUID: gNqNBgl6Q1eobJkttrt6OA==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="241380"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="241380"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2026 03:59:25 -0700
X-CSE-ConnectionGUID: AmrmqP5mTrGim9TjMOvpNg==
X-CSE-MsgGUID: kEtrjLEZTEygNYNXSqC2Kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="2088243"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa012.fm.intel.com with ESMTP; 09 Oct 2026 03:59:23 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v6 00/25] Building a better rte_flow parser
Date: Fri,  9 Oct 2026 11:58:50 +0100
Message-ID: <cover.1791543153.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1787233986.git.anatoly.burakov@intel.com>
References: <cover.1787233986.git.anatoly.burakov@intel.com>
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

Most rte_flow parsers in DPDK suffer from huge implementation complexity because
even though 99% of what people use rte_flow parsers for is parsing protocol
graphs, no parser is written explicitly as a graph. This patchset attempts to
suggest a viable model to build rte_flow parsers as graphs, by offering a
library to build rte_flow parser graphs without too much boilerplate and
complexity.

Most of the patchset is about Intel drivers, but they are meant as
reimplementations as well as examples for the rest of the community to assess
how to build parsers using this new infrastructure. I expect the first three
patches will be of most interest to non-Intel reviewers, as they deal with
building two reusable parser architecture pieces.

The first piece is a new flow graph helper in ethdev. Its purpose is
deliberately narrow: it targets the protocol-graph part of rte_flow pattern
parsing, where drivers walk packet headers and validate legal item sequences and
parameters. That does not cover all possible rte_flow features, especially more
exotic flow items, but it does cover a large and widely shared part of what
existing drivers need to do. Or, to put it in other words, the only flow items
this infrastructure *doesn't* cover is things that do not lend themselves well
to be parsed as a graph of protocol headers (e.g. conntrack items). Everything
else should be covered or cover-able. In practice, just about all drivers will
benefit from graph parsing as all but one of them implement only the protocol
stack parts, which are the ones targeted by the graph helper.

The second piece is a reusable flow engine framework for Intel Ethernet drivers.
This is kept Intel-local because I do not feel it is even appropriate to define
such a framework for all drivers to use in the first place. Even so, the intent
is to establish a cleaner parser architecture with a defined interaction model,
explicit memory ownership rules, locking, initialization sequence,
implementations of rte_flow API entry points, flow replay and memory cleanup,
and engine definitions that do not block secondary-process-safe usage. It is my
hope that this would serve as a model for other drivers to follow, expand on,
rework, and improve, so that maybe down the line we *might* have a common
rte_flow infrastructure for drivers to use.

Most of the rest of the series is parser reimplementation, but that is mainly
the vehicle for demonstrating and validating those two pieces. ixgbe and i40e
are wired into the new common parsing path, and their existing parsers are
migrated incrementally to the graph-based model. Besides reducing ad hoc parser
code, this also makes validation more explicit and more consistent. In a few
places that means invalid inputs that were previously ignored, deferred, or
interpreted loosely are now rejected earlier and more strictly, without any
increase in code complexity (in fact, with marked *decrease* of it!).

v5 -> v6:
- Renamed all underscored functions in flow graph
- Reclassified cleanup/replay as engine conf operations
- Added better logging to flow graph parse function

v4 -> v5:
- Fixed ixgbe ntuple parsing of L4 protocol flows
- Rebased on top of latest ixgbe changes
- Revised ixgbe FDIR refactoring to have less duplication

v3 -> v4:
- Added a "get default mask" flow API
- Simplified graph constraints implementation
- Made flow graph a compiled unit instead of header-only library
- Reworked all graph engines to use default flow mask if user didn't provide one
- Split out ixgbe ethertype refactor into a separate patch
- Split out SYN and ntuple priority fixes as separate patches
- Refactored ixgbe RSS configuration structure
- Address Vladimir's feedback for specific engines
- Address Stephen's comments
- Reduced the number of comments in code

v2 -> v3:
- Rebase on top of latest next-net-intel
- Cleanup pass on naming of engines and hash tables
- Added more logging to flow engine initializations
- Introduced a lightweight refcount to initialize shared resources
- Some small refactors in how ixgbe flow director engine keeps its state
- Fixed typos in documentation

v1 -> v2:
- Renamed `rte_flow_graph` to `flow_graph`
- Addressed some comments from Stephen's AI review
- Removed the rte_flow_conv hack on account of Stephen's upcoming patches making
  the API stable
- Split up "flow_install" into register and install steps, which enabled two new
  use cases: cleanup of memory without HW deregistration, and flow configuration
  replay after `dev_start`
- More aggressive refactoring of all engines on account of new pieces of
  infrastructure, which allows for reduced complexity of implementation
- Combined i40e tunnel engine patches into one patch
- Added i40e flow director refactoring to cleanly support the new API as well as
  the legacy PMD-specific API

RFC -> v1:
- Fixed a lot of bugs, concurrency issues, and init/uninit sequence problems in
  Intel common flow engine implementation
- Fixed a few copypaste errors in various engines
- Improved comment documentation and flow engine docs

Anatoly Burakov (25):
  ethdev: add default mask query to flow
  ethdev: add flow graph API
  net/intel/common: add flow engines infrastructure
  net/intel/common: add utility functions
  net/ixgbe: add support for common flow parsing
  net/ixgbe: make ethertype filter table dynamic
  net/ixgbe: reimplement ethertype parser
  net/ixgbe: fix syn filter priority
  net/ixgbe: reimplement syn parser
  net/ixgbe: reimplement L2 tunnel parser
  net/ixgbe: fix ntuple filter priority
  net/ixgbe: fix protocol-only ntuple parsing
  net/ixgbe: reimplement ntuple parser
  net/ixgbe: reimplement security parser
  net/ixgbe: reimplement FDIR parser
  net/ixgbe: don't embed RSS conf in filter structs
  net/ixgbe: reimplement hash parser
  net/ixgbe: advertise flow keep capability
  net/i40e: add support for common flow parsing
  net/i40e: reimplement ethertype parser
  net/i40e: refactor FDIR engine infrastructure
  net/i40e: reimplement FDIR parser
  net/i40e: reimplement tunnel parsers
  net/i40e: reimplement hash parser
  net/i40e: advertise flow keep capability

 doc/guides/prog_guide/ethdev/flow_graph.rst   |  750 +++
 doc/guides/prog_guide/ethdev/index.rst        |    1 +
 doc/guides/rel_notes/release_26_11.rst        |   22 +-
 drivers/net/intel/common/flow_engine.h        | 1423 ++++++
 drivers/net/intel/common/flow_util.h          |  263 ++
 drivers/net/intel/i40e/i40e_ethdev.c          | 1523 +-----
 drivers/net/intel/i40e/i40e_ethdev.h          |  322 +-
 drivers/net/intel/i40e/i40e_fdir.c            | 1126 +++--
 drivers/net/intel/i40e/i40e_flow.c            | 4185 +----------------
 drivers/net/intel/i40e/i40e_flow.h            |   30 +
 drivers/net/intel/i40e/i40e_flow_ethertype.c  |  351 ++
 drivers/net/intel/i40e/i40e_flow_fdir.c       | 2154 +++++++++
 drivers/net/intel/i40e/i40e_flow_hash.c       | 1454 ++++++
 drivers/net/intel/i40e/i40e_flow_tunnel.c     | 1958 ++++++++
 drivers/net/intel/i40e/i40e_hash.c            | 1212 +----
 drivers/net/intel/i40e/i40e_hash.h            |   19 +-
 drivers/net/intel/i40e/meson.build            |    4 +
 drivers/net/intel/i40e/rte_pmd_i40e.c         |   12 +-
 drivers/net/intel/ixgbe/ixgbe_ethdev.c        | 1014 +---
 drivers/net/intel/ixgbe/ixgbe_ethdev.h        |  285 +-
 drivers/net/intel/ixgbe/ixgbe_fdir.c          |  610 +--
 drivers/net/intel/ixgbe/ixgbe_flow.c          | 3243 +------------
 drivers/net/intel/ixgbe/ixgbe_flow.h          |   27 +
 .../net/intel/ixgbe/ixgbe_flow_ethertype.c    |  299 ++
 drivers/net/intel/ixgbe/ixgbe_flow_fdir.c     | 1602 +++++++
 drivers/net/intel/ixgbe/ixgbe_flow_hash.c     |  216 +
 drivers/net/intel/ixgbe/ixgbe_flow_l2tun.c    |  322 ++
 drivers/net/intel/ixgbe/ixgbe_flow_ntuple.c   |  694 +++
 drivers/net/intel/ixgbe/ixgbe_flow_security.c |  586 +++
 drivers/net/intel/ixgbe/ixgbe_flow_syn.c      |  312 ++
 drivers/net/intel/ixgbe/ixgbe_ipsec.c         |  361 +-
 drivers/net/intel/ixgbe/ixgbe_ipsec.h         |   50 +-
 drivers/net/intel/ixgbe/ixgbe_pf.c            |   49 +-
 drivers/net/intel/ixgbe/ixgbe_rxtx.c          |   80 +-
 .../net/intel/ixgbe/ixgbe_rxtx_vec_common.c   |    4 +-
 drivers/net/intel/ixgbe/meson.build           |    7 +
 lib/ethdev/flow_graph.c                       |  273 ++
 lib/ethdev/flow_graph.h                       |  149 +
 lib/ethdev/meson.build                        |    2 +
 lib/ethdev/rte_flow.c                         |  207 +-
 lib/ethdev/rte_flow.h                         |   15 +
 41 files changed, 14853 insertions(+), 12363 deletions(-)
 create mode 100644 doc/guides/prog_guide/ethdev/flow_graph.rst
 create mode 100644 drivers/net/intel/common/flow_engine.h
 create mode 100644 drivers/net/intel/common/flow_util.h
 create mode 100644 drivers/net/intel/i40e/i40e_flow.h
 create mode 100644 drivers/net/intel/i40e/i40e_flow_ethertype.c
 create mode 100644 drivers/net/intel/i40e/i40e_flow_fdir.c
 create mode 100644 drivers/net/intel/i40e/i40e_flow_hash.c
 create mode 100644 drivers/net/intel/i40e/i40e_flow_tunnel.c
 create mode 100644 drivers/net/intel/ixgbe/ixgbe_flow.h
 create mode 100644 drivers/net/intel/ixgbe/ixgbe_flow_ethertype.c
 create mode 100644 drivers/net/intel/ixgbe/ixgbe_flow_fdir.c
 create mode 100644 drivers/net/intel/ixgbe/ixgbe_flow_hash.c
 create mode 100644 drivers/net/intel/ixgbe/ixgbe_flow_l2tun.c
 create mode 100644 drivers/net/intel/ixgbe/ixgbe_flow_ntuple.c
 create mode 100644 drivers/net/intel/ixgbe/ixgbe_flow_security.c
 create mode 100644 drivers/net/intel/ixgbe/ixgbe_flow_syn.c
 create mode 100644 lib/ethdev/flow_graph.c
 create mode 100644 lib/ethdev/flow_graph.h

-- 
2.52.0

