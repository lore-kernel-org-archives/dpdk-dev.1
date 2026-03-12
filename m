Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 517B5106ACEE
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Mar 2026 22:01:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5408440285;
	Thu, 12 Mar 2026 23:01:41 +0100 (CET)
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
 by mails.dpdk.org (Postfix) with ESMTP id 9B2CC40275
 for <dev@dpdk.org>; Thu, 12 Mar 2026 23:01:40 +0100 (CET)
Received: from localhost.localdomain (unknown [82.65.104.223])
 (Authenticated sender: vjardin@free.fr)
 by smtp6-g21.free.fr (Postfix) with ESMTPSA id 9AAA2780375;
 Thu, 12 Mar 2026 23:01:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1773352900;
 bh=ztFYjm1h7Bmu7qkE85L1MpaAhX+4/ldP1YRMkk7Wq0c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=L3xwZUSaMer71AA45fxbsMqTSysFo6ZCoIcRe/tWaSJkC9YQ84RguYfKMZegTM/R5
 pxX0JHlo39I678QSdWbFY7GINk6CEtKSVH7ui4sDibQOhPzAgbIszmFlH5deuVieQO
 Kjzqs+iTQFzrQIMy2D0XcE5hT31YYXJa2YheesyHuFnXjROx0fMk/1jpUJ/CIImaC6
 z+lS+AgK8iOsWoqvEtG8F7Myjn7l20GTaKBUQ3J39i7AsTmLzF9QBl5c7G2bHsaWhe
 8ndaXDAV6SYFgzyCb+WlCtfOzkjAusR8Ncgt1hJHcZDwMNqzszJY8cZ6M8rSt6sbf9
 Wk/4ftpcUK0WQ==
From: Vincent Jardin <vjardin@free.fr>
To: dev@dpdk.org
Cc: rasland@nvidia.com, thomas@monjalon.net, andrew.rybchenko@oktetlabs.ru,
 dsosnowski@nvidia.com, viacheslavo@nvidia.com, bingz@nvidia.com,
 orika@nvidia.com, suanmingm@nvidia.com, matan@nvidia.com,
 stephen@networkplumber.org, Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v3 00/9] net/mlx5: per-queue Tx rate limiting via packet pacing
Date: Thu, 12 Mar 2026 23:01:11 +0100
Message-ID: <20260312220120.3256755-1-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260310092014.2762894-1-vjardin@free.fr>
References: <20260310092014.2762894-1-vjardin@free.fr>
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
rte_eth_set_queue_rate_limit(). The mlx5 implementation allocates a
dedicated PP index per rate from the HW rate table, programs it into the
SQ via modify_sq, and shares identical rates across queues to conserve
table entries. A PMD-specific API exposes per-queue PP diagnostics and
rate table capacity.

Patch breakdown:

  1. doc/nics/mlx5: fix stale packet pacing documentation
  2-3. common/mlx5: query PP capabilities and extend SQ modify
  4-6. net/mlx5: per-queue PP infrastructure, rate_limit callback,
       burst pacing devargs (tx_burst_bound, tx_typical_pkt_sz)
  7. net/mlx5: testpmd command to query per-queue rate state
  8. ethdev: add rte_eth_get_queue_rate_limit() symmetric getter
       + testpmd "show port <id> queue <id> rate" command
  9. net/mlx5: rate table capacity query API

Usage with testpmd:
  set port 0 queue 0 rate 1000
  set port 0 queue 1 rate 5000
  set port 0 queue 0 rate 0      # disable
  show port 0 queue 0 rate       # generic ethdev query
  mlx5 port 0 txq 0 rate show    # mlx5 PMD-specific query

Changes since v2:

Patch 4 (per-queue packet pacing infrastructure):
  - Folded "share pacing rate table entries across queues" into
    this patch (was a separate patch in v2)

Patch 5 (support per-queue rate limiting):
  - Remove redundant queue_idx >= nb_tx_queues check (ethdev
    layer already validates before calling the PMD callback)

Patch 8 (ethdev getter):
  - Add testpmd "show port <id> queue <id> rate" command
    in app/test-pmd/cmdline.c using rte_eth_get_queue_rate_limit()
  - Drop release notes (targeting 26.07, not 26.03)
  - Remove redundant queue_idx bounds check from mlx5 getter

Patch 9 (rate table capacity query):
  - Use MLX5_MEM_SYS flag in mlx5_malloc() for system memory
  - Minor code style cleanups (line wrapping, cast formatting)

Changes since v1:

Addressed review feedback from Stephen Hemminger's AI:

Patch 4 (per-queue packet pacing infrastructure):
  - Validate rate_mbps against HCA packet_pacing_min_rate and
    packet_pacing_max_rate bounds; return -ERANGE on out-of-range
  - Widen rate_kbps from uint32_t to uint64_t to prevent
    overflow on rate_mbps * 1000
  - Remove early mlx5_txq_free_pp_rate_limit() call from the
    allocator (moved to caller, see patch 5)

Patch 5 (support per-queue rate limiting):
  - Fix PP index leak on modify_sq failure: allocate new PP into a
    temporary struct mlx5_txq_rate_limit; only swap into txq_ctrl->rl
    after modify_sq succeeds. On failure the old PP context stays intact.
  - Set rte_errno = -ret before returning errors from both the
    disable (tx_rate=0) and enable paths

Patch 7 (testpmd command to query per-queue rate limit):
  - Fix inverted rte_eth_tx_queue_is_valid() return value check:
    was "if (rte_eth_tx_queue_is_valid(...))" (accepts invalid queues),
    changed to "if (rte_eth_tx_queue_is_valid(...) != 0)"

Patch 9 (rate table capacity query, was patch 10 in v1):
  - Replace uint16_t seen[RTE_MAX_QUEUES_PER_PORT] (2 KB stack array)
    with heap-allocated mlx5_malloc(priv->txqs_n, ...) + mlx5_free()
  - Add early return when txqs == NULL || txqs_n == 0
  - Document in the API Doxygen that "used" reflects only the queried
    port's queues; other ports on the same device may also consume
    rate table entries
  - Add -ENOMEM to documented return values

Hardware tested:
  - ConnectX-6 Dx (packet pacing with MLX5_DATA_RATE)

Vincent Jardin (9):
  doc/nics/mlx5: fix stale packet pacing documentation
  common/mlx5: query packet pacing rate table capabilities
  common/mlx5: extend SQ modify to support rate limit update
  net/mlx5: add per-queue packet pacing infrastructure
  net/mlx5: support per-queue rate limiting
  net/mlx5: add burst pacing devargs
  net/mlx5: add testpmd command to query per-queue rate limit
  ethdev: add getter for per-queue Tx rate limit
  net/mlx5: add rate table capacity query API

 app/test-pmd/cmdline.c               |  69 +++++++++++++
 doc/guides/nics/mlx5.rst             | 125 ++++++++++++++++++------
 drivers/common/mlx5/mlx5_devx_cmds.c |  20 ++++
 drivers/common/mlx5/mlx5_devx_cmds.h |  14 ++-
 drivers/net/mlx5/mlx5.c              |  46 +++++++++
 drivers/net/mlx5/mlx5.h              |  13 +++
 drivers/net/mlx5/mlx5_testpmd.c      |  93 ++++++++++++++++++
 drivers/net/mlx5/mlx5_tx.c           | 104 +++++++++++++++++++-
 drivers/net/mlx5/mlx5_tx.h           |   5 +
 drivers/net/mlx5/mlx5_txpp.c         |  85 ++++++++++++++++
 drivers/net/mlx5/mlx5_txq.c          | 141 +++++++++++++++++++++++++++
 drivers/net/mlx5/rte_pmd_mlx5.h      |  62 ++++++++++++
 lib/ethdev/ethdev_driver.h           |   7 ++
 lib/ethdev/rte_ethdev.c              |  28 ++++++
 lib/ethdev/rte_ethdev.h              |  24 +++++
 15 files changed, 802 insertions(+), 33 deletions(-)

-- 
2.43.0

