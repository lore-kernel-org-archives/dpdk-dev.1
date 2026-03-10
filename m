Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA3CFCC9DB
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 09:20:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E62C402B8;
	Tue, 10 Mar 2026 10:20:43 +0100 (CET)
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
 by mails.dpdk.org (Postfix) with ESMTP id A3B9D4014F
 for <dev@dpdk.org>; Tue, 10 Mar 2026 10:20:42 +0100 (CET)
Received: from localhost.localdomain (unknown [82.65.104.223])
 (Authenticated sender: vjardin@free.fr)
 by smtp6-g21.free.fr (Postfix) with ESMTPSA id AAEF3780372;
 Tue, 10 Mar 2026 10:20:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1773134442;
 bh=3qTVcPWpcMjShgc4YqX4v5OZ2ETEARj51mpb5UaDXZw=;
 h=From:To:Cc:Subject:Date:From;
 b=ZyIWqra2mDAGiYbj/uKOp/yGkSLUljyXYpmfOV6yNNCes12zkhn9Ix5Weh5NuyK0d
 lrdxdf1bT9Vl7tZYmim+bm6JotWuwMi/UDpqvQINgs5TMkaEgI00iWRks28zA+9B1h
 HOJh3X+Q676A3sEA5a6+UbwCkG8UN/p+EXYiBbYLXTQeuRTwBfVxs6CuLUBjXIG0dC
 mdRppeWNyF9jnDOGBX0VsII3bE52NSwE4Zehfuxwcl/W4qRwalDEWjuL3ney35oOwS
 I2nS6He+QduUBMma/1Z8yGx8WXn9ZZ+Jrky8xSKHuKUdb7+m+P/9Ml802gPK+2mlq/
 GGLjoECAHUxqg==
From: Vincent Jardin <vjardin@free.fr>
To: dev@dpdk.org
Cc: rasland@nvidia.com, thomas@monjalon.net, andrew.rybchenko@oktetlabs.ru,
 dsosnowski@nvidia.com, viacheslavo@nvidia.com, bingz@nvidia.com,
 orika@nvidia.com, suanmingm@nvidia.com, matan@nvidia.com,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v1 00/10] net/mlx5: per-queue Tx rate limiting via packet
 pacing
Date: Tue, 10 Mar 2026 10:20:04 +0100
Message-ID: <20260310092014.2762894-1-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
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

This series adds per-queue Tx rate limiting to the mlx5 PMD using
the HW packet pacing (PP) rate table.

The ConnectX-6 Dx and later NICs expose a per-SQ
packet_pacing_rate_limit_index that can be changed on a live SQ
via modify_bitmask without queue teardown. The kernel mlx5 driver
refcounts PP contexts internally, so queues configured at the same
rate share a single HW rate table entry.

The series is structured as follows:

  1. Doc fix for stale packet pacing documentation
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

Tested on ConnectX-6 Dx only.

Vincent Jardin (11):
  doc/nics/mlx5: fix stale packet pacing documentation
  common/mlx5: query packet pacing rate table capabilities
  common/mlx5: extend SQ modify to support rate limit update
  net/mlx5: add per-queue packet pacing infrastructure
  net/mlx5: support per-queue rate limiting
  net/mlx5: add burst pacing devargs
  net/mlx5: add testpmd command to query per-queue rate limit
  ethdev: add getter for per-queue Tx rate limit
  mailmap: update Vincent Jardin email address
  net/mlx5: share pacing rate table entries across queues
  net/mlx5: add rate table capacity query API

 .mailmap                             |   3 +-
 doc/guides/nics/mlx5.rst             | 125 +++++++++++++++++------
 drivers/common/mlx5/mlx5_devx_cmds.c |  20 ++++
 drivers/common/mlx5/mlx5_devx_cmds.h |  14 ++-
 drivers/net/mlx5/mlx5.c              |  46 +++++++++
 drivers/net/mlx5/mlx5.h              |  13 +++
 drivers/net/mlx5/mlx5_testpmd.c      |  93 +++++++++++++++++
 drivers/net/mlx5/mlx5_tx.c           |  89 +++++++++++++++++
 drivers/net/mlx5/mlx5_tx.h           |   5 +
 drivers/net/mlx5/mlx5_txpp.c         |  75 ++++++++++++++
 drivers/net/mlx5/mlx5_txq.c          | 144 +++++++++++++++++++++++++++
 drivers/net/mlx5/rte_pmd_mlx5.h      |  57 +++++++++++
 lib/ethdev/ethdev_driver.h           |   7 ++
 lib/ethdev/rte_ethdev.c              |  28 ++++++
 lib/ethdev/rte_ethdev.h              |  24 +++++
 15 files changed, 710 insertions(+), 33 deletions(-)

-- 
2.43.0

