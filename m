Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA3DF53D80
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 17:28:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 19EDE4025E;
	Mon, 16 Mar 2026 18:28:01 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id BC3B5400D5
 for <dev@dpdk.org>; Mon, 16 Mar 2026 18:27:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773682080; x=1805218080;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=EoKhPTnbGupaA47bIMv45wj6Eox3phdixjo5mc+GHgY=;
 b=ZKBoW9Eyp4C4Xo/6x2bMr0MaTFlU0GYSIEefSLlEhz+fBa29YW2nRs51
 Uz9w55pKCSpvZjyUmv7Ek6kq5kQMB9xyvwZcxNCMtUvkA9UHhu3WFH34W
 P5iSHmRKtZUh0x4ribpdlWcQLwd7Zn3yY2Iz8rXka5NBwmxy6rkA0ukqa
 NbeyLRR7UGenp2IRK+6Om6/ywmVG1rRTwIQM/8LgiatObYnmw2KqloKWv
 sF6j0CZzC+5F6vcTtlJ9XUInB+htzeDxXggd1D16phbGzfAE4zV5YXtu3
 Zf1X52hHG3D0qtoZd6UXCPYVsASiLN8uYOwavmrGDDEFXxPQf6jJNcZdg w==;
X-CSE-ConnectionGUID: //HCTioRRDqFp/BMQWEH4g==
X-CSE-MsgGUID: yaMVucPESU2x8A2ov/ZXoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="86059604"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="86059604"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 10:27:58 -0700
X-CSE-ConnectionGUID: RFpbAwFDQbO7z6ztkX1s+A==
X-CSE-MsgGUID: FirheUtHT6ObGCvUKCgz4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="221228126"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa010.jf.intel.com with ESMTP; 16 Mar 2026 10:27:57 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [RFC PATCH v1 00/21] Building a better rte_flow parser
Date: Mon, 16 Mar 2026 17:27:28 +0000
Message-ID: <cover.1773681363.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
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
else should be covered or cover-able.

The second piece is a reusable flow engine framework for Intel Ethernet drivers.
This is kept Intel-local for now because I do not feel it is generic enough to
be presented as an ethdev-wide engine model. Even so, the intent is to establish
a cleaner parser architecture with a defined interaction model, explicit memory
ownership rules, and engine definitions that do not block secondary-process-safe
usage. It is my hope that we could also promote something like this into ethdev
proper and remove the necessity for drivers to build so much boilerplate around
rte_flow parsing (and more often than not doing it in a way that is more complex
than it needs to be).

Most of the rest of the series is parser reimplementation, but that is mainly
the vehicle for demonstrating and validating those two pieces. ixgbe and i40e
are wired into the new common parsing path, and their existing parsers are
migrated incrementally to the graph-based model. Besides reducing ad hoc parser
code, this also makes validation more explicit and more consistent with the
actual install path. In a few places that means invalid inputs that were
previously ignored, deferred, or interpreted loosely are now rejected earlier
and more strictly, without any increase in code complexity (in fact, with marked
*decrease* of it!).

Series depends on previously submitted patchsets:

- IAVF global buffer fix [1]
- Common attr parsing stuff [2]

[1] https://patches.dpdk.org/project/dpdk/list/?series=37585&state=*
[2] https://patches.dpdk.org/project/dpdk/list/?series=37663&state=*

Anatoly Burakov (21):
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
  net/i40e: add support for common flow parsing
  net/i40e: reimplement ethertype parser
  net/i40e: reimplement FDIR parser
  net/i40e: reimplement tunnel QinQ parser
  net/i40e: reimplement VXLAN parser
  net/i40e: reimplement NVGRE parser
  net/i40e: reimplement MPLS parser
  net/i40e: reimplement gtp parser
  net/i40e: reimplement L4 cloud parser
  net/i40e: reimplement hash parser

 drivers/net/intel/common/flow_engine.h        | 1003 ++++
 drivers/net/intel/common/flow_util.h          |  165 +
 drivers/net/intel/i40e/i40e_ethdev.c          |   56 +-
 drivers/net/intel/i40e/i40e_ethdev.h          |   49 +-
 drivers/net/intel/i40e/i40e_fdir.c            |   47 -
 drivers/net/intel/i40e/i40e_flow.c            | 4092 +----------------
 drivers/net/intel/i40e/i40e_flow.h            |   44 +
 drivers/net/intel/i40e/i40e_flow_ethertype.c  |  258 ++
 drivers/net/intel/i40e/i40e_flow_fdir.c       | 1806 ++++++++
 drivers/net/intel/i40e/i40e_flow_hash.c       | 1289 ++++++
 drivers/net/intel/i40e/i40e_flow_tunnel.c     | 1510 ++++++
 drivers/net/intel/i40e/i40e_hash.c            |  980 +---
 drivers/net/intel/i40e/i40e_hash.h            |    8 +-
 drivers/net/intel/i40e/meson.build            |    4 +
 drivers/net/intel/ixgbe/ixgbe_ethdev.c        |   40 +-
 drivers/net/intel/ixgbe/ixgbe_ethdev.h        |   13 +-
 drivers/net/intel/ixgbe/ixgbe_fdir.c          |   13 +-
 drivers/net/intel/ixgbe/ixgbe_flow.c          | 3130 +------------
 drivers/net/intel/ixgbe/ixgbe_flow.h          |   38 +
 .../net/intel/ixgbe/ixgbe_flow_ethertype.c    |  240 +
 drivers/net/intel/ixgbe/ixgbe_flow_fdir.c     | 1510 ++++++
 drivers/net/intel/ixgbe/ixgbe_flow_hash.c     |  182 +
 drivers/net/intel/ixgbe/ixgbe_flow_l2tun.c    |  228 +
 drivers/net/intel/ixgbe/ixgbe_flow_ntuple.c   |  483 ++
 drivers/net/intel/ixgbe/ixgbe_flow_security.c |  297 ++
 drivers/net/intel/ixgbe/ixgbe_flow_syn.c      |  280 ++
 drivers/net/intel/ixgbe/meson.build           |    7 +
 lib/ethdev/meson.build                        |    1 +
 lib/ethdev/rte_flow_graph.h                   |  414 ++
 29 files changed, 9867 insertions(+), 8320 deletions(-)
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
 create mode 100644 lib/ethdev/rte_flow_graph.h

-- 
2.47.3

