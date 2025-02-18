Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8572C02198
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Feb 2025 11:15:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D0FD9402C4;
	Tue, 18 Feb 2025 12:15:43 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id B0BD6402A0
 for <dev@dpdk.org>; Tue, 18 Feb 2025 12:15:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739877343; x=1771413343;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=IybUTPI+zqPPLaV9VK01Dl+pmbsxNnCqYKVVHQdkVj8=;
 b=SHXj/69IDrBdtCFOL9J3MqIpli2OlJKh0IXAdusxN7keIFEluCaatj/f
 sGODQJNiGuiNzb61qbLZ2pNwKUZ5yIZ/Sehd9hTgA7t4NLyamHWKTDK67
 75lgQMUxqiDRwFjw4rH30JS7gcUP1HdwiGCvDFeO1YPAVWywac76fe+hM
 K/Z4051H4DG3A8o1KrEOoZONPWHjt/YOyjdYqq2sjtqSpDCtOcT1/fctf
 4Hg0zLoB7sj2QH7QK1YSKmEuU0K+rt3r1RMJ53Epqaw9yi0N4r5O8BCi/
 Ywo6oRiaX8GAbv3PyH9Pw/30xEkwNx7kYCn0tWdhf96XV/KTdfvwjObyx Q==;
X-CSE-ConnectionGUID: dVhVjWftRfGAQAU7vi/m1Q==
X-CSE-MsgGUID: lVXeHqtOTNmChgz4qFmVEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="50780800"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; d="scan'208";a="50780800"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 03:15:41 -0800
X-CSE-ConnectionGUID: p7qSgGSjRa+jscrQCyKt8g==
X-CSE-MsgGUID: IU5M5Ip4RS+QBHJhJ/NEig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; d="scan'208";a="119466234"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa004.fm.intel.com with ESMTP; 18 Feb 2025 03:15:39 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v6 0/8] Record and rework component dependencies
Date: Tue, 18 Feb 2025 11:15:26 +0000
Message-ID: <cover.1739877265.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1725462264.git.anatoly.burakov@intel.com>
References: <cover.1725462264.git.anatoly.burakov@intel.com>
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

As part of the meson build, we can record the dependencies for each
component as we process it, logging them to a file. This file can be
used as input to a number of other scripts and tools, for example, to
graph the dependencies, or to allow higher-level build-config tools to
automatically enable component requirements, etc.

The first patch of this set separates dependencies inside meson into
optional or mandatory. The second patch of this set generates the basic
dependency tree. The third patch does some processing of that dependency
tree to identify cases where dependencies are being unnecessarily
specified. Reducing these makes it easier to have readable dependency
graphs in future, without affecting the build.

The following 4 patches are based on the output of the second patch, and
greatly cut down the number of direct dependency links between
components. Even with the cut-down dependencies, the full dependency
graph is nigh-unreadable, so the final patch adds a new script to
generate dependency tree subgraphs, creating dot files for e.g. the
dependencies of a particular component, or a component class such as
mempool drivers.

v6:
- Fix build for common/qat
- Rebase
- Rename some patch headings to avoid check git log warnings

v4 -> v5:
- Improve optional dependency handling by making it (mostly) automatic
- Fix CI issue from accidentally changing testpmd binary filename
- Explicitly encode display name vs binary name information in the graph
- Reduce some more dependencies
- Update all scripts to handle new graph output format

v3 -> v4:
- Update to latest main

v2 -> v3:
- Split dependencies into optional and mandatory
- Fixup graph scripts to read and generate graphs that encode optional
  dependencies into the graph
- Python version fixes to avoid using features not available in minimum
  supported Python version
- Formatting with Ruff, and PEP-484 compliance

Anatoly Burakov (1):
  build: introduce optional internal dependencies

Bruce Richardson (7):
  build: output a dependency log in build directory
  devtools: add script to flag unneeded dependencies
  drivers: remove kvargs from class dependencies
  lib: reduce library dependencies
  drivers: reduce driver dependencies
  app: reduce app dependencies
  devtools: add script to generate DPDK dependency graphs

 app/dumpcap/meson.build                    |   2 +-
 app/graph/meson.build                      |   2 +-
 app/meson.build                            |  31 ++-
 app/pdump/meson.build                      |   2 +-
 app/proc-info/meson.build                  |   6 +-
 app/test-bbdev/meson.build                 |  18 +-
 app/test-crypto-perf/meson.build           |   6 +-
 app/test-fib/meson.build                   |   2 +-
 app/test-pmd/meson.build                   |  56 ++----
 app/test-sad/meson.build                   |   2 +-
 app/test/meson.build                       |  14 +-
 buildtools/log-deps.py                     |  94 +++++++++
 buildtools/meson.build                     |   2 +
 devtools/draw-dependency-graphs.py         | 223 +++++++++++++++++++++
 devtools/find-duplicate-deps.py            |  62 ++++++
 drivers/baseband/fpga_5gnr_fec/meson.build |   2 +-
 drivers/baseband/fpga_lte_fec/meson.build  |   2 +-
 drivers/baseband/la12xx/meson.build        |   2 +-
 drivers/baseband/null/meson.build          |   2 +-
 drivers/baseband/turbo_sw/meson.build      |   2 +-
 drivers/bus/auxiliary/meson.build          |   2 -
 drivers/bus/dpaa/meson.build               |   2 +-
 drivers/bus/fslmc/meson.build              |   2 +-
 drivers/bus/ifpga/meson.build              |   2 +-
 drivers/bus/pci/meson.build                |   4 +-
 drivers/bus/platform/meson.build           |   1 -
 drivers/bus/uacce/meson.build              |   2 -
 drivers/bus/vdev/meson.build               |   2 -
 drivers/common/cnxk/meson.build            |   4 +-
 drivers/common/cpt/meson.build             |   2 +-
 drivers/common/mlx5/meson.build            |   2 +-
 drivers/common/zsda/meson.build            |   2 +-
 drivers/compress/mlx5/meson.build          |   2 +-
 drivers/compress/nitrox/meson.build        |   2 +-
 drivers/compress/octeontx/meson.build      |   2 +-
 drivers/crypto/bcmfs/meson.build           |   2 +-
 drivers/crypto/cnxk/meson.build            |   2 +-
 drivers/crypto/dpaa_sec/meson.build        |   2 +-
 drivers/crypto/ipsec_mb/meson.build        |   2 +-
 drivers/crypto/mlx5/meson.build            |   2 +-
 drivers/crypto/nitrox/meson.build          |   2 +-
 drivers/dma/cnxk/meson.build               |   2 +-
 drivers/dma/dpaa/meson.build               |   2 +-
 drivers/dma/dpaa2/meson.build              |   2 +-
 drivers/dma/odm/meson.build                |   2 +-
 drivers/dma/skeleton/meson.build           |   2 +-
 drivers/event/cnxk/meson.build             |   2 +-
 drivers/event/dlb2/meson.build             |   2 +-
 drivers/event/dpaa2/meson.build            |   2 +-
 drivers/event/meson.build                  |   2 +-
 drivers/event/octeontx/meson.build         |   3 +-
 drivers/event/sw/meson.build               |   2 +-
 drivers/mempool/cnxk/meson.build           |   2 +-
 drivers/mempool/dpaa/meson.build           |   2 +-
 drivers/mempool/dpaa2/meson.build          |   2 +-
 drivers/mempool/octeontx/meson.build       |   2 +-
 drivers/meson.build                        |  27 ++-
 drivers/ml/cnxk/meson.build                |   2 +-
 drivers/net/cnxk/meson.build               |   4 +-
 drivers/net/intel/iavf/meson.build         |   2 +-
 drivers/net/intel/ice/meson.build          |   2 +-
 drivers/net/mana/meson.build               |   2 +-
 drivers/net/meson.build                    |   2 +-
 drivers/net/mlx5/meson.build               |   2 +-
 drivers/net/sfc/meson.build                |   2 +-
 drivers/net/softnic/meson.build            |   2 +-
 drivers/net/virtio/meson.build             |   2 +-
 drivers/raw/cnxk_bphy/meson.build          |   2 +-
 drivers/raw/cnxk_gpio/meson.build          |   2 +-
 drivers/raw/gdtc/meson.build               |   2 +-
 drivers/raw/ntb/meson.build                |   2 +-
 drivers/raw/skeleton/meson.build           |   2 +-
 drivers/regex/cn9k/meson.build             |   2 +-
 drivers/regex/meson.build                  |   2 +-
 drivers/regex/mlx5/meson.build             |   2 +-
 drivers/vdpa/ifc/meson.build               |   2 +-
 drivers/vdpa/meson.build                   |   3 +-
 drivers/vdpa/mlx5/meson.build              |   2 +-
 drivers/vdpa/sfc/meson.build               |   2 +-
 examples/ethtool/meson.build               |   4 +-
 examples/l2fwd-crypto/meson.build          |   4 +-
 examples/l3fwd/meson.build                 |   4 +-
 examples/meson.build                       |  31 ++-
 examples/vm_power_manager/meson.build      |  16 +-
 lib/argparse/meson.build                   |   2 +-
 lib/bbdev/meson.build                      |   2 +-
 lib/bitratestats/meson.build               |   2 +-
 lib/bpf/meson.build                        |   2 +-
 lib/cmdline/meson.build                    |   2 +-
 lib/compressdev/meson.build                |   2 +-
 lib/cryptodev/meson.build                  |   2 +-
 lib/dispatcher/meson.build                 |   2 +-
 lib/distributor/meson.build                |   2 +-
 lib/dmadev/meson.build                     |   2 -
 lib/eal/meson.build                        |   5 +-
 lib/efd/meson.build                        |   2 +-
 lib/ethdev/meson.build                     |   2 +-
 lib/eventdev/meson.build                   |   3 +-
 lib/fib/meson.build                        |   4 +-
 lib/gpudev/meson.build                     |   2 +-
 lib/graph/meson.build                      |   2 +-
 lib/gro/meson.build                        |   2 +-
 lib/gso/meson.build                        |   2 +-
 lib/hash/meson.build                       |   4 +-
 lib/ip_frag/meson.build                    |   2 +-
 lib/ipsec/meson.build                      |   2 +-
 lib/kvargs/meson.build                     |   2 +-
 lib/latencystats/meson.build               |   2 +-
 lib/lpm/meson.build                        |   4 +-
 lib/mbuf/meson.build                       |   2 +-
 lib/member/meson.build                     |   2 +-
 lib/mempool/meson.build                    |   2 +-
 lib/meson.build                            |  27 ++-
 lib/metrics/meson.build                    |   2 +-
 lib/mldev/meson.build                      |   2 +-
 lib/net/meson.build                        |   2 +-
 lib/node/meson.build                       |   2 +-
 lib/pcapng/meson.build                     |   2 +-
 lib/pdcp/meson.build                       |   2 +-
 lib/pdump/meson.build                      |   2 +-
 lib/pipeline/meson.build                   |   2 +-
 lib/port/meson.build                       |   2 +-
 lib/power/meson.build                      |   3 +-
 lib/rawdev/meson.build                     |   2 -
 lib/rcu/meson.build                        |   2 +-
 lib/regexdev/meson.build                   |   2 +-
 lib/reorder/meson.build                    |   2 +-
 lib/rib/meson.build                        |   2 +-
 lib/ring/meson.build                       |   1 -
 lib/sched/meson.build                      |   2 +-
 lib/security/meson.build                   |   2 +-
 lib/table/meson.build                      |   2 +-
 lib/telemetry/meson.build                  |   2 +-
 lib/vhost/meson.build                      |   2 +-
 134 files changed, 645 insertions(+), 231 deletions(-)
 create mode 100644 buildtools/log-deps.py
 create mode 100755 devtools/draw-dependency-graphs.py
 create mode 100755 devtools/find-duplicate-deps.py

-- 
2.43.5

