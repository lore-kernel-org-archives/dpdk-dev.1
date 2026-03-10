Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A6EFFD88CF
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 23:27:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 24A03402AC;
	Wed, 11 Mar 2026 00:27:34 +0100 (CET)
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
 by mails.dpdk.org (Postfix) with ESMTP id 6C5B040275
 for <dev@dpdk.org>; Wed, 11 Mar 2026 00:27:33 +0100 (CET)
Received: from localhost.localdomain (unknown [82.65.104.223])
 (Authenticated sender: vjardin@free.fr)
 by smtp6-g21.free.fr (Postfix) with ESMTPSA id 29398780371;
 Wed, 11 Mar 2026 00:27:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1773185253;
 bh=IAU6JnZNDzelEQN+5l1ddrn41VhrzoVUdgrYqR1c4JQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=j0KpMEZWbFjW8aW1vrciWFD/vS9hvagZcm/46YV0qKeMpmrBAJklOELVPg5CvZRkW
 38rBhcF/WnH319SQUHJveNf9eERgh+GjNoqU4K9OSkQ4l/qEkdtuLN4rhYd4bzy1fA
 3QrMhfYr4Yf2pYoeIKvXAbc2I5OLpGus1Z36xTu4HHMVxGEG/QGRTlbkatfh1j/mvx
 6IToLWMl4vmGnFNGnBMSXnZ5JtjslizbG4qlHPXQbRPk4CK1B1whpQ9cI+ZLgOIFC6
 p5ebEVpfi1jrR1pL95ITtZfNJQeoIc9BvXm+eJSxfEUaLGr5I6B0F4aOPzjpQ60s90
 1JaV+hlpUOSvQ==
From: Vincent Jardin <vjardin@free.fr>
To: dev@dpdk.org
Cc: rasland@nvidia.com, thomas@monjalon.net, andrew.rybchenko@oktetlabs.ru,
 dsosnowski@nvidia.com, viacheslavo@nvidia.com, bingz@nvidia.com,
 orika@nvidia.com, suanmingm@nvidia.com, matan@nvidia.com,
 stephen@networkplumber.org, Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v2 00/10] net/mlx5: per-queue Tx rate limiting via packet
 pacing
Date: Wed, 11 Mar 2026 00:26:43 +0100
Message-ID: <20260310232653.2935764-1-vjardin@free.fr>
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
  9. net/mlx5: share PP rate table entries across queues
  10. net/mlx5: rate table capacity query API

Usage with testpmd:
  set port 0 queue 0 rate 1000
  set port 0 queue 1 rate 5000
  set port 0 queue 0 rate 0      # disable
  mlx5 port 0 txq 0 rate show    # query

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

Patch 8 (ethdev getter):
  - Add release note for rte_eth_get_queue_rate_limit() in
    doc/guides/rel_notes/release_26_03.rst

Patch 10 (rate table capacity query):
  - Replace uint16_t seen[RTE_MAX_QUEUES_PER_PORT] (2 KB stack array)
    with heap-allocated mlx5_malloc(priv->txqs_n, ...) + mlx5_free()
  - Add early return when txqs == NULL || txqs_n == 0
  - Document in the API Doxygen that "used" reflects only the queried
    port's queues; other ports on the same device may also consume
    rate table entries
  - Add -ENOMEM to documented return values
  - Add release note for mlx5 per-queue rate limiting

Not addressed in v2 (requires discussion):

  - Patch 8: ethdev API breadth: rte_eth_get_queue_rate_limit()
    is currently only implemented by mlx5. Other PMDs (ixgbe, i40e, ice)
    would need implementations for full consistency. Feedbacks are
    welcomed.

Testing:
  - Build: GCC, no warnings
  - devtools/check-git-log.sh -n 11: 11/11 valid
  - devtools/checkpatches.sh -n 11: 10/11 valid (pre-existing
    stdout warning in testpmd command, not introduced by this series)
  - devtools/check-doc-vs-code.sh: clean
  - devtools/check-meson.py: clean

Hardware tested:
  - ConnectX-6 Dx (packet pacing with MLX5_DATA_RATE)

Vincent Jardin (10):
  doc/nics/mlx5: fix stale packet pacing documentation
  common/mlx5: query packet pacing rate table capabilities
  common/mlx5: extend SQ modify to support rate limit update
  net/mlx5: add per-queue packet pacing infrastructure
  net/mlx5: support per-queue rate limiting
  net/mlx5: add burst pacing devargs
  net/mlx5: add testpmd command to query per-queue rate limit
  ethdev: add getter for per-queue Tx rate limit
  net/mlx5: share pacing rate table entries across queues
  net/mlx5: add rate table capacity query API

 doc/guides/nics/mlx5.rst               | 125 +++++++++++++++-----
 doc/guides/rel_notes/release_26_03.rst |  10 ++
 drivers/common/mlx5/mlx5_devx_cmds.c   |  20 ++++
 drivers/common/mlx5/mlx5_devx_cmds.h   |  14 ++-
 drivers/net/mlx5/mlx5.c                |  46 ++++++++
 drivers/net/mlx5/mlx5.h                |  13 +++
 drivers/net/mlx5/mlx5_testpmd.c        |  93 +++++++++++++++
 drivers/net/mlx5/mlx5_tx.c             | 105 ++++++++++++++++-
 drivers/net/mlx5/mlx5_tx.h             |   5 +
 drivers/net/mlx5/mlx5_txpp.c           |  86 ++++++++++++++
 drivers/net/mlx5/mlx5_txq.c            | 151 +++++++++++++++++++++++++
 drivers/net/mlx5/rte_pmd_mlx5.h        |  62 ++++++++++
 lib/ethdev/ethdev_driver.h             |   7 ++
 lib/ethdev/rte_ethdev.c                |  28 +++++
 lib/ethdev/rte_ethdev.h                |  24 ++++
 15 files changed, 755 insertions(+), 33 deletions(-)

-- 
2.43.0

