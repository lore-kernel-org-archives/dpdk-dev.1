Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FA2CCF9EA
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Oct 2025 10:17:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A99EC40654;
	Mon, 27 Oct 2025 11:17:14 +0100 (CET)
Received: from out28-122.mail.aliyun.com (out28-122.mail.aliyun.com
 [115.124.28.122])
 by mails.dpdk.org (Postfix) with ESMTP id 888C1402F1
 for <dev@dpdk.org>; Mon, 27 Oct 2025 11:17:08 +0100 (CET)
Received: from ubuntu.localdomain(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.f8MxqU5_1761560226 cluster:ay29) by smtp.aliyun-inc.com;
 Mon, 27 Oct 2025 18:17:06 +0800
From: Dimon Zhao <dimon.zhao@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	dev@dpdk.org
Cc: Kyo Liu <kyo.liu@nebula-matrix.com>, Leon Yu <leon.yu@nebula-matrix.com>,
 Sam Chen <sam.chen@nebula-matrix.com>
Subject: [PATCH v1 8/9] net/nbl: address nbl channel integer handling issues
 490954
Date: Mon, 27 Oct 2025 03:16:47 -0700
Message-Id: <20251027101649.3337618-9-dimon.zhao@nebula-matrix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251027101649.3337618-1-dimon.zhao@nebula-matrix.com>
References: <20250627014022.4019625-1-dimon.zhao@nebula-matrix.com>
 <20251027101649.3337618-1-dimon.zhao@nebula-matrix.com>
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

Coverity issue: 490954

Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>
---
 drivers/net/nbl/nbl_hw/nbl_channel.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/nbl/nbl_hw/nbl_channel.c b/drivers/net/nbl/nbl_hw/nbl_channel.c
index a8f53ec497..654e56f200 100644
--- a/drivers/net/nbl/nbl_hw/nbl_channel.c
+++ b/drivers/net/nbl/nbl_hw/nbl_channel.c
@@ -324,7 +324,8 @@ static void nbl_chan_advance_rx_ring(struct nbl_channel_mgt *chan_mgt,
 	rx_desc = NBL_CHAN_RX_DESC(rxq, next_to_use);
 
 	rx_desc->flags = NBL_CHAN_RX_DESC_AVAIL;
-	rx_desc->buf_addr = rxq->buf_mem.pa + chan_info->mailbox.rxq_buf_size * next_to_use;
+	rx_desc->buf_addr = rxq->buf_mem.pa +
+				(u64)chan_info->mailbox.rxq_buf_size * (u64)next_to_use;
 	rx_desc->buf_len = chan_info->mailbox.rxq_buf_size;
 
 	rte_wmb();
-- 
2.34.1

