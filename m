Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08906F54ADA
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 16:51:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 670AC402D6;
	Tue, 24 Mar 2026 17:51:04 +0100 (CET)
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
 by mails.dpdk.org (Postfix) with ESMTP id 252EA402BE
 for <dev@dpdk.org>; Tue, 24 Mar 2026 17:51:03 +0100 (CET)
Received: from localhost.localdomain (unknown [213.36.7.12])
 (Authenticated sender: vjardin@free.fr)
 by smtp5-g21.free.fr (Postfix) with ESMTPSA id 903D75FFC0;
 Tue, 24 Mar 2026 17:50:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1774371063;
 bh=POeH+vuTsXZxKn/NxzJsPRpGlpoJKpxoaUHKn1YXtnY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=UkneOitQdiBS9KDVhHZSxni7FSMqWDVhUm9Zl3vYVJ66QwxzKApbssYkeqvDU5l19
 gmC0ZwE8RbxyOoff7lBlejUymvtt2m+wWXZ1/FIt4lCy7yf1MYoaBJVIQaRJWmBL//
 zVOAgm3hCreJ1NGUDex73z64JWlCd3G+C7Bej6hvWDWGOhH01XLT2Q5NkIRJwhWOZX
 NCYgE59DrWc8LYHLNbzwsY0v4dR2+2KUSuoqWJVpD8HejJf9qzDgT65dq25mmUIhjL
 Nw/cDGkwcDM2vDVD8rhyqo2w1eYTp6F2pj3J6/zeXTpUV10htH53K2sTMQ0nU43XrR
 4xISHTAQnJ/DQ==
From: Vincent Jardin <vjardin@free.fr>
To: dev@dpdk.org
Cc: rasland@nvidia.com, thomas@monjalon.net, andrew.rybchenko@oktetlabs.ru,
 dsosnowski@nvidia.com, viacheslavo@nvidia.com, bingz@nvidia.com,
 orika@nvidia.com, suanmingm@nvidia.com, matan@nvidia.com,
 stephen@networkplumber.org, aman.deep.singh@intel.com,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v5 00/10] net/mlx5: per-queue Tx rate limiting via packet
 pacing
Date: Tue, 24 Mar 2026 17:50:37 +0100
Message-ID: <20260324165047.391137-1-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260322134629.94633-1-vjardin@free.fr>
References: <20260322134629.94633-1-vjardin@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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


This series adds per-queue Tx data-rate limiting to the mlx5 PMD using
hardware packet pacing (PP), and a symmetric rte_eth_get_queue_rate_limit()
ethdev API to read back the configured rate.

Each Tx queue can be assigned an individual rate (in Mbps) at runtime via
rte_eth_set_queue_rate_limit(). The mlx5 implementation allocates a PP
context per queue from the HW rate table, programs the PP index into the
SQ via modify_sq, and relies on the kernel to share identical rates
across PP contexts to conserve table entries. A PMD-specific API exposes
per-queue PP diagnostics and rate table capacity.

Patch breakdown:

  01/10 doc/nics/mlx5: fix stale packet pacing documentation
  02/10 common/mlx5: query packet pacing rate table capabilities
  03/10 common/mlx5: extend SQ modify to support rate limit update
  04/10 net/mlx5: add per-queue packet pacing infrastructure
  05/10 net/mlx5: support per-queue rate limiting
  06/10 net/mlx5: add burst pacing devargs
  07/10 net/mlx5: add testpmd command to query per-queue rate limit
  08/10 ethdev: add getter for per-queue Tx rate limit
  09/10 net/mlx5: implement per-queue Tx rate limit getter
  10/10 net/mlx5: add rate table capacity query API

Release notes for the new ethdev API and mlx5 per-queue rate
limiting can be added to a release_26_07.rst once the file is
created at the start of the 26.07 development cycle.

Changes since v4:

  Addressed review feedback from Stephen Hemminger and added
  Acked-by from Viacheslav Ovsiienko on patches 03-10.

  Patch 05/10 (set rate):
  - Add rate_kbps > UINT32_MAX bounds check before truncating to
    the PRM rate_limit field, preventing silent overflow when HW
    reports no maximum rate

  Patch 07/10 (testpmd + PMD query):
  - Add NULL check on (*priv->txqs)[queue_id] before container_of()
    in rte_pmd_mlx5_txq_rate_limit_query(), matching the pattern
    in the setter

  Patches 03-10:
  - Added Acked-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>

Changes since v3:

  Addressed review feedback from Stephen and Slava (nvidia/Mellanox).

  Patch 02/10 (query caps):
  - Added Acked-by: Viacheslav Ovsiienko

  Patch 03/10 (SQ modify):
  - Define MLX5_MODIFY_SQ_IN_MODIFY_BITMASK_PACKET_PACING_RATE_LIMIT_INDEX
    enum in mlx5_prm.h, following the MLX5_MODIFY_RQ_IN_MODIFY_xxx pattern
  - Use read-modify-write for modify_bitmask (MLX5_GET64 | OR | MLX5_SET64)
    instead of direct overwrite, for forward compatibility

  Patch 04/10 (PP infrastructure):
  - Rename struct member and parameters from "rl" to "rate_limit"
    for consistency with codebase naming style
  - Replace MLX5_ASSERT(rate_mbps > 0) with runtime check returning
    -EINVAL in non-debug builds
  - Move mlx5_txq_free_pp_rate_limit() to after txq_obj_release() in
    mlx5_txq_release() — destroy the SQ before freeing the PP index
    it references
  - Clarify commit message: distinct PP handle per queue (for cleanup)
    but kernel shares the same pp_id for identical rate parameters

  Patch 05/10 (set rate):
  - Fix obj->sq vs obj->sq_obj.sq: use obj->sq_obj.sq from the start
    for non-hairpin queues (was introduced in patch 07 in v3, breaking
    git bisect)
  - Move all variable declarations to block top (sq_devx,
    new_rate_limit)
  - Add queue state check: reject set_queue_rate_limit if queue is not
    STARTED (SQ not in RDY state)
  - Update mlx5 feature matrix: Rate limitation = Y
  - Add Per-Queue Tx Rate Limiting documentation section in mlx5.rst
    covering DevX requirement, hardware support, rate table sharing,
    and testpmd usage

  Patch 06/10 (burst devargs):
  - Remove burst_upper_bound/typical_packet_size from Clock Queue
    path (mlx5_txpp_alloc_pp_index) — Clock Queue uses WQE rate
    pacing and does not need these parameters
  - Update commit message and documentation accordingly

  Patch 07/10 (testpmd + PMD query):
  - sq_obj.sq accessor change moved to patch 05 (see above)
  - sq_devx declaration moved to block top

  Patch 08/10 (ethdev getter) — split from v3 patch 08:
  - Split into ethdev API (this patch) and mlx5 driver (patch 09)
  - Add rte_eth_trace_get_queue_rate_limit() trace point matching
    the existing setter pattern

  Patch 09/10 — NEW (was part of v3 patch 08):
  - mlx5 driver implementation of get_queue_rate_limit callback,
    split out per Slava's request

  Patch 10/10 (rate table query):
  - Rename struct field "used" to "port_used" to clarify per-port
    scope
  - Strengthen Doxygen: rate table is a global shared HW resource
    (firmware, kernel, other DPDK instances may consume entries);
    port_used is a lower bound
  - Document PP sharing behavior with flags=0
  - Note that applications should aggregate across ports for
    device-wide visibility

Changes since v2:

  Addressed review feedback from Stephen Hemminger:

  Patch 04: cleaned redundant cast parentheses on (struct mlx5dv_pp *)
  Patch 04: consolidated dv_alloc_pp call onto one line
  Patch 05+08: removed redundant queue_idx bounds checks from driver
    callbacks — ethdev layer is the single validation point
  Patch 07: added generic testpmd command: show port <id> queue <id> rate
  Patch 08+10: removed release notes from release_26_03.rst (targets 26.07)
  Patch 10: use MLX5_MEM_SYS | MLX5_MEM_ZERO for heap allocation
  Patch 10: consolidated packet_pacing_rate_table_size onto one line

Changes since v1:

  Patch 01: Acked-by Viacheslav Ovsiienko
  Patch 04: rate bounds validation, uint64_t overflow fix, remove
    early PP free
  Patch 05: PP leak fix (temp struct pattern), rte_errno in error paths
  Patch 07: inverted rte_eth_tx_queue_is_valid() check
  Patch 10: stack array replaced with heap, per-port scope documented

Testing:

  - Build: GCC, no warnings
  - Hardware: ConnectX-6 Dx
  - DevX path (default): set/get/disable rate limiting verified
  - Verbs path (dv_flow_en=0): returns -EINVAL cleanly (SQ DevX
    object not available), no crash

Vincent Jardin (10):
  doc/nics/mlx5: fix stale packet pacing documentation
  common/mlx5: query packet pacing rate table capabilities
  common/mlx5: extend SQ modify to support rate limit update
  net/mlx5: add per-queue packet pacing infrastructure
  net/mlx5: support per-queue rate limiting
  net/mlx5: add burst pacing devargs
  net/mlx5: add testpmd command to query per-queue rate limit
  ethdev: add getter for per-queue Tx rate limit
  net/mlx5: implement per-queue Tx rate limit getter
  net/mlx5: add rate table capacity query API

Vincent Jardin (10):
  doc/nics/mlx5: fix stale packet pacing documentation
  common/mlx5: query packet pacing rate table capabilities
  common/mlx5: extend SQ modify to support rate limit update
  net/mlx5: add per-queue packet pacing infrastructure
  net/mlx5: support per-queue rate limiting
  net/mlx5: add burst pacing devargs
  net/mlx5: add testpmd command to query per-queue rate limit
  ethdev: add getter for per-queue Tx rate limit
  net/mlx5: implement per-queue Tx rate limit getter
  net/mlx5: add rate table capacity query API

 app/test-pmd/cmdline.c               |  69 ++++++++++
 doc/guides/nics/features/mlx5.ini    |   1 +
 doc/guides/nics/mlx5.rst             | 180 ++++++++++++++++++++++-----
 drivers/common/mlx5/mlx5_devx_cmds.c |  23 ++++
 drivers/common/mlx5/mlx5_devx_cmds.h |  14 ++-
 drivers/common/mlx5/mlx5_prm.h       |   7 ++
 drivers/net/mlx5/mlx5.c              |  46 +++++++
 drivers/net/mlx5/mlx5.h              |  13 ++
 drivers/net/mlx5/mlx5_testpmd.c      |  93 ++++++++++++++
 drivers/net/mlx5/mlx5_tx.c           | 106 +++++++++++++++-
 drivers/net/mlx5/mlx5_tx.h           |   5 +
 drivers/net/mlx5/mlx5_txpp.c         |  90 ++++++++++++++
 drivers/net/mlx5/mlx5_txq.c          | 149 ++++++++++++++++++++++
 drivers/net/mlx5/rte_pmd_mlx5.h      |  74 +++++++++++
 lib/ethdev/ethdev_driver.h           |   7 ++
 lib/ethdev/ethdev_trace.h            |   9 ++
 lib/ethdev/ethdev_trace_points.c     |   3 +
 lib/ethdev/rte_ethdev.c              |  35 ++++++
 lib/ethdev/rte_ethdev.h              |  24 ++++
 19 files changed, 914 insertions(+), 33 deletions(-)

-- 
2.43.0

