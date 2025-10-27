Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD95ECCF9EA
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Oct 2025 10:17:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 71A1C40615;
	Mon, 27 Oct 2025 11:17:12 +0100 (CET)
Received: from out28-221.mail.aliyun.com (out28-221.mail.aliyun.com
 [115.124.28.221])
 by mails.dpdk.org (Postfix) with ESMTP id 0EEB3402E9
 for <dev@dpdk.org>; Mon, 27 Oct 2025 11:17:07 +0100 (CET)
Received: from ubuntu.localdomain(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.f8MxqSw_1761560225 cluster:ay29) by smtp.aliyun-inc.com;
 Mon, 27 Oct 2025 18:17:05 +0800
From: Dimon Zhao <dimon.zhao@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	dev@dpdk.org
Cc: Kyo Liu <kyo.liu@nebula-matrix.com>, Leon Yu <leon.yu@nebula-matrix.com>,
 Sam Chen <sam.chen@nebula-matrix.com>
Subject: [PATCH v1 7/9] net/nbl: address nbl channel integer handling issues
 490952
Date: Mon, 27 Oct 2025 03:16:46 -0700
Message-Id: <20251027101649.3337618-8-dimon.zhao@nebula-matrix.com>
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

Coverity issue: 490952

Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>
---
 drivers/net/nbl/nbl_hw/nbl_channel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/nbl/nbl_hw/nbl_channel.c b/drivers/net/nbl/nbl_hw/nbl_channel.c
index c4cca8eeb5..a8f53ec497 100644
--- a/drivers/net/nbl/nbl_hw/nbl_channel.c
+++ b/drivers/net/nbl/nbl_hw/nbl_channel.c
@@ -36,7 +36,7 @@ static int nbl_chan_init_tx_queue(union nbl_chan_info *chan_info)
 		goto req_wait_queue_failed;
 	}
 
-	size = chan_info->mailbox.num_txq_entries * chan_info->mailbox.txq_buf_size;
+	size = (u64)chan_info->mailbox.num_txq_entries * (u64)chan_info->mailbox.txq_buf_size;
 	txq->buf = nbl_alloc_dma_mem(&txq->buf_mem, size);
 	if (!txq->buf) {
 		NBL_LOG(ERR, "Allocate memory for chan tx buffer arrays failed");
-- 
2.34.1

