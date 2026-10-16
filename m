Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5266CCC6B38
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 11:00:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 686DA402DA;
	Fri, 16 Oct 2026 13:00:05 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 7BCA3400D5
 for <dev@dpdk.org>; Fri, 16 Oct 2026 13:00:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792148404; x=1823684404;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=6SedJoiNe6X7S50kNNv+yjgamBKgF/bsskA9Egy3Gq0=;
 b=RC5suNUA+a6wHiKTOWJFx6x6nX60/sbAA53xOLe0eHCbm1bTNPGGORCk
 SiNSsM0SvtKIneuLcuVup2oAVxro2yY/ByUx9EIUCrZYWdiWiztjIWT7r
 +In498adthC5vqokSDUu70x+fCYK2w+wI8N2IC/revv3w8Ms+4IOlBtYt
 IEeG4uuxyYjK6uP1fLGPJazmt7aW4kVy7/mpVKgbjQI1XUZWuyBD2+yJj
 w8xEFkMOsnIX713S9DytSzc02ruMA3CphWZ/ypD/6MwSkS1hJLYOWWmmB
 xqSJUjsY09UYf3OVMY6vR38TuNRcQCxlRvyPtCRQx0B/0cwZMW95H66Jf w==;
X-CSE-ConnectionGUID: ImJiVuaHT7m3lN0xg630LQ==
X-CSE-MsgGUID: UQhpj81YQqyKuHDNr4TC2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="944128"
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="944128"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2026 04:00:03 -0700
X-CSE-ConnectionGUID: D0FEHAGhRG65/9XwcBt/sw==
X-CSE-MsgGUID: upOE+fL0RxutX3OobmBIIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="3759354"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa011.fm.intel.com with ESMTP; 16 Oct 2026 04:00:02 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH 00/12] Add config-time dependency tracking
Date: Fri, 16 Oct 2026 11:59:38 +0100
Message-ID: <20261016105950.273068-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
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

Add configuration time dependency tracking for libs and drivers in DPDK,
so that when a user requests a driver, all dependent drivers also get
enabled. Similarly with libraries. What is not enabled in this RFC is
support for enabling libraries based on driver requests, or enabling
either libs or drivers based on the enable-apps config option. I've
omitted the former for now, because it would involve moving more logic
out of the lib/meson.build file and drivers/meson.build files into the
top-level one, something I'm a little hesitant to do for now. The
addition of apps only adds value once the cross-type dependency tracking
is enabled, since no app depends on any others.

The first 5 patches in this series are cleanups and bug fixes. The
following patches then implement the dependency tracking. While I
investigated having meson parse each components meson.build file
initially, without actually building it, this failed to work due to
logic other than variable assignments in many drivers.

Instead, python scripts are used to manage the dependency list. For
easier debug, and future introspection this dependency management is
split between two scripts - the first generates a dependency table file
which it writes to the build folder, allowing us to analyse this
post-build if so desired. The second script uses this file to actually
compute the necessary per-component dependencies.

The final patch of the series is a major reduction in the number of
required components for doing DPDK builds. We completely remove the list
of required libraries, and assume that a minimal build should only
require enough libraries to build EAL. However, EAL does assume that we
have a few additional buses, for example, EAL args are present for pci
and vdev. Also, in order for mempools to work, we always need to have
the default mempool ring driver build. That means that our de-facto
minimal build target set is the set of components needed to build
"bus/pci,bus/vdev,mempool/ring" (which would include EAL in the output,
which is why we can remove any hard-coded library lists)

Bruce Richardson (12):
  build: fix name of base library object
  build: fix ignoring requested driver when class is disabled
  build: prevent overlap of enable and disable lists
  build: add direct support for optional dependencies
  net/bond: rename directory for consistency
  build: add script to generate dependencies list
  build: use recursive addition for enabled libraries option
  build: use recursive addition for enabled drivers option
  build: improve error reporting for unbuildable components
  build: add EAL common directory to global include list
  build: make EAL an explicit dependency
  build: simplify mandatory library lists

 MAINTAINERS                                   |   2 +-
 app/meson.build                               |  15 +-
 app/proc-info/meson.build                     |   4 +-
 app/test-bbdev/meson.build                    |  18 +-
 app/test-crypto-perf/meson.build              |   4 +-
 app/test-pmd/meson.build                      |  50 ++---
 app/test/meson.build                          |   6 -
 buildtools/get-deps.py                        | 203 ++++++++++++++++++
 buildtools/meson.build                        |   2 +
 buildtools/resolve-deps.py                    |  80 +++++++
 devtools/test-meson-builds.sh                 |   3 +-
 doc/api/doxy-api.conf.in                      |   2 +-
 .../link_bonding_poll_mode_drv_lib.rst        |   2 +-
 doc/guides/testpmd_app_ug/testpmd_funcs.rst   |   2 +-
 drivers/common/mlx5/linux/meson.build         |   1 -
 drivers/meson.build                           |  85 ++++++--
 .../net/{bonding => bond}/bonding_testpmd.c   |   0
 .../eth_bond_8023ad_private.h                 |   0
 .../net/{bonding => bond}/eth_bond_private.h  |   0
 drivers/net/{bonding => bond}/meson.build     |   1 -
 drivers/net/{bonding => bond}/rte_eth_bond.h  |   0
 .../{bonding => bond}/rte_eth_bond_8023ad.c   |   0
 .../{bonding => bond}/rte_eth_bond_8023ad.h   |   0
 .../net/{bonding => bond}/rte_eth_bond_alb.c  |   0
 .../net/{bonding => bond}/rte_eth_bond_alb.h  |   0
 .../net/{bonding => bond}/rte_eth_bond_api.c  |   0
 .../net/{bonding => bond}/rte_eth_bond_args.c |   0
 .../net/{bonding => bond}/rte_eth_bond_flow.c |   0
 .../net/{bonding => bond}/rte_eth_bond_pmd.c  |   0
 drivers/net/intel/ice/meson.build             |   7 +-
 drivers/net/meson.build                       |   2 +-
 lib/acl/meson.build                           |   1 +
 lib/cfgfile/meson.build                       |   1 +
 lib/cryptodev/meson.build                     |   2 +-
 lib/dmadev/meson.build                        |   2 +-
 lib/eal/meson.build                           |   6 +-
 lib/ethdev/meson.build                        |   2 +-
 lib/eventdev/meson.build                      |   1 -
 lib/ipsec/meson.build                         |   2 +-
 lib/jobstats/meson.build                      |   1 +
 lib/log/meson.build                           |   1 -
 lib/mempool/meson.build                       |   2 +-
 lib/meson.build                               |  76 +++----
 lib/meter/meson.build                         |   1 +
 lib/metrics/meson.build                       |   2 +-
 lib/pci/meson.build                           |   1 +
 lib/ptr_compress/meson.build                  |   1 +
 lib/rawdev/meson.build                        |   2 +-
 lib/ring/meson.build                          |   2 +-
 lib/stack/meson.build                         |   1 +
 lib/timer/meson.build                         |   1 +
 meson.build                                   |  21 ++
 52 files changed, 478 insertions(+), 140 deletions(-)
 create mode 100644 buildtools/get-deps.py
 create mode 100644 buildtools/resolve-deps.py
 rename drivers/net/{bonding => bond}/bonding_testpmd.c (100%)
 rename drivers/net/{bonding => bond}/eth_bond_8023ad_private.h (100%)
 rename drivers/net/{bonding => bond}/eth_bond_private.h (100%)
 rename drivers/net/{bonding => bond}/meson.build (95%)
 rename drivers/net/{bonding => bond}/rte_eth_bond.h (100%)
 rename drivers/net/{bonding => bond}/rte_eth_bond_8023ad.c (100%)
 rename drivers/net/{bonding => bond}/rte_eth_bond_8023ad.h (100%)
 rename drivers/net/{bonding => bond}/rte_eth_bond_alb.c (100%)
 rename drivers/net/{bonding => bond}/rte_eth_bond_alb.h (100%)
 rename drivers/net/{bonding => bond}/rte_eth_bond_api.c (100%)
 rename drivers/net/{bonding => bond}/rte_eth_bond_args.c (100%)
 rename drivers/net/{bonding => bond}/rte_eth_bond_flow.c (100%)
 rename drivers/net/{bonding => bond}/rte_eth_bond_pmd.c (100%)

--
2.53.0

