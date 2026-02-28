Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E141F1048925
	for <dpdk-dev@archiver.kernel.org>; Sat, 28 Feb 2026 02:12:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BE0244025F;
	Sat, 28 Feb 2026 03:12:28 +0100 (CET)
Received: from out28-147.mail.aliyun.com (out28-147.mail.aliyun.com
 [115.124.28.147])
 by mails.dpdk.org (Postfix) with ESMTP id 246C54013F
 for <dev@dpdk.org>; Sat, 28 Feb 2026 03:12:26 +0100 (CET)
Received: from ubuntu.localdomain(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.gguIgJr_1772244741 cluster:ay29) by smtp.aliyun-inc.com;
 Sat, 28 Feb 2026 10:12:24 +0800
From: Dimon Zhao <dimon.zhao@nebula-matrix.com>
To: dev@dpdk.org
Cc: Dimon Zhao <dimon.zhao@nebula-matrix.com>
Subject: [PATCH v1 0/1] NBL fix queue count issue on port restart
Date: Fri, 27 Feb 2026 18:12:10 -0800
Message-Id: <20260228021211.71166-1-dimon.zhao@nebula-matrix.com>
X-Mailer: git-send-email 2.34.1
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

Remove tx_ring_num and rx_ring_num from struct nbl_txrx_mgt to fix
an issue where these counts keep increasing during port stop/start cycles.

The counts were incremented in tx_queue_setup/rx_queue_setup, but never
decremented. This causes incorrect queue counts after multiple port
restarts. Since the actual queue counts are already available via
eth_dev->data->nb_tx_queues and nb_rx_queues, use those instead.

Update nbl_res_txrx_get_xstats() to use eth_dev->data->nb_rx_queues.

Dimon Zhao (1):
  net/nbl: fix queue count issue on port restart

 drivers/net/nbl/nbl_hw/nbl_resource.h | 2 --
 drivers/net/nbl/nbl_hw/nbl_txrx.c     | 6 ++----
 2 files changed, 2 insertions(+), 6 deletions(-)

-- 
2.34.1

