Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7822EC88E77
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Sep 2026 12:18:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5CD05427BA;
	Wed, 16 Sep 2026 14:18:36 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 83EA9402B0
 for <dev@dpdk.org>; Wed, 16 Sep 2026 14:18:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789561115; x=1821097115;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=ja44p2ShV2/TM0FpijgCphHAOxURCvLanpqKSq5QfL8=;
 b=gtiTYQRK2D+4z5f7BOIfBEu4PSZ3jcnC7SLEMaR9CJeGAhVpo9qz2eug
 xVLCsFzCcb58TM/hNmWQJDDXFN+9vPadZ0t8oohKJJKeFGsvhv/PpxMki
 p9V/R94VR2g5BEiWInX1Cbht6tGBboBtZ+il1rYubeD41FTLdCC/FgAHO
 dtHJMOo6X/gX6fxMxaxOyAWvvIhBXQB2GAhwof+tY0xh5Lmcp9sbx582W
 hXX572kaclttDTksqL5XIdny8s8zK/ytLhyPEUKZ+zVR8JL6/lqVDQChE
 7gQrlJ53P4XuiAh2UF++rx1JrLllKtRb+EQo7iwYYBJdewzhyh5YiGVFm g==;
X-CSE-ConnectionGUID: 5wJ0K4cZRaqY3F9tte3HwQ==
X-CSE-MsgGUID: 3ECSNwyzS5uk4BcfN3mqzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="112702926"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="112702926"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 05:18:34 -0700
X-CSE-ConnectionGUID: GK2ZSB3hQu+PhHiYgxznIQ==
X-CSE-MsgGUID: +4Nt9lGvTh207p3zuY0S2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="272850217"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa008.jf.intel.com with ESMTP; 16 Sep 2026 05:18:33 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v3 00/19] Building a better rte_flow parser
Date: Wed, 16 Sep 2026 13:18:06 +0100
Message-ID: <cover.1789560943.git.anatoly.burakov@intel.com>
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
lightweight header only library to build rte_flow parsering graphs without too
much boilerplate and complexity.

Most of the patchset is about Intel drivers, but they are meant as
reimplementations as well as examples for the rest of the community to assess
how to build parsers using this new infrastructure. I expect the first two
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

Anatoly Burakov (19):
  ethdev: add flow graph API
  net/intel/common: add flow engines infrastructure
  net/intel/common: add utility functions
  net/ixgbe: add support for common flow parsing
  net/ixgbe: reimplement ethertype parser
  net/ixgbe: reimplement syn parser
  net/ixgbe: reimplement L2 tunnel parser
  net/ixgbe: reimplement ntuple parser
  net/ixgbe: reimplement security parser
  net/ixgbe: reimplement FDIR parser
  net/ixgbe: reimplement hash parser
  net/ixgbe: advertise flow keep capability
  net/i40e: add support for common flow parsing
  net/i40e: reimplement ethertype parser
  net/i40e: refactor FDIR engine infrastructure
  net/i40e: reimplement FDIR parser
  net/i40e: reimplement tunnel parsers
  net/i40e: reimplement hash parser
  net/i40e: advertise flow keep capability

 doc/guides/prog_guide/ethdev/flow_graph.rst   |  749 +++
 doc/guides/prog_guide/ethdev/index.rst        |    1 +
 doc/guides/rel_notes/release_26_11.rst        |    5 +
 drivers/net/intel/common/flow_engine.h        | 1620 +++++++
 drivers/net/intel/common/flow_util.h          |  228 +
 drivers/net/intel/i40e/i40e_ethdev.c          | 1000 +---
 drivers/net/intel/i40e/i40e_ethdev.h          |  262 +-
 drivers/net/intel/i40e/i40e_fdir.c            |  983 ++--
 drivers/net/intel/i40e/i40e_flow.c            | 4185 +----------------
 drivers/net/intel/i40e/i40e_flow.h            |   30 +
 drivers/net/intel/i40e/i40e_flow_ethertype.c  |  351 ++
 drivers/net/intel/i40e/i40e_flow_fdir.c       | 2056 ++++++++
 drivers/net/intel/i40e/i40e_flow_hash.c       | 1441 ++++++
 drivers/net/intel/i40e/i40e_flow_tunnel.c     | 1590 +++++++
 drivers/net/intel/i40e/i40e_hash.c            | 1208 +----
 drivers/net/intel/i40e/i40e_hash.h            |   19 +-
 drivers/net/intel/i40e/meson.build            |    4 +
 drivers/net/intel/i40e/rte_pmd_i40e.c         |    4 +-
 drivers/net/intel/ixgbe/ixgbe_ethdev.c        |  993 +---
 drivers/net/intel/ixgbe/ixgbe_ethdev.h        |  235 +-
 drivers/net/intel/ixgbe/ixgbe_fdir.c          |  304 +-
 drivers/net/intel/ixgbe/ixgbe_flow.c          | 3217 +------------
 drivers/net/intel/ixgbe/ixgbe_flow.h          |   27 +
 .../net/intel/ixgbe/ixgbe_flow_ethertype.c    |  295 ++
 drivers/net/intel/ixgbe/ixgbe_flow_fdir.c     | 1704 +++++++
 drivers/net/intel/ixgbe/ixgbe_flow_hash.c     |  212 +
 drivers/net/intel/ixgbe/ixgbe_flow_l2tun.c    |  317 ++
 drivers/net/intel/ixgbe/ixgbe_flow_ntuple.c   |  597 +++
 drivers/net/intel/ixgbe/ixgbe_flow_security.c |  536 +++
 drivers/net/intel/ixgbe/ixgbe_flow_syn.c      |  312 ++
 drivers/net/intel/ixgbe/ixgbe_ipsec.c         |  359 +-
 drivers/net/intel/ixgbe/ixgbe_ipsec.h         |   50 +-
 drivers/net/intel/ixgbe/ixgbe_pf.c            |   49 +-
 drivers/net/intel/ixgbe/ixgbe_rxtx.c          |   48 +-
 drivers/net/intel/ixgbe/meson.build           |    7 +
 lib/ethdev/flow_graph.h                       |  507 ++
 lib/ethdev/meson.build                        |    1 +
 37 files changed, 14143 insertions(+), 11363 deletions(-)
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
 create mode 100644 lib/ethdev/flow_graph.h

-- 
2.52.0

