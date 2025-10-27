Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C445CCF9EA
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Oct 2025 10:17:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 758D040395;
	Mon, 27 Oct 2025 11:17:09 +0100 (CET)
Received: from out28-73.mail.aliyun.com (out28-73.mail.aliyun.com
 [115.124.28.73]) by mails.dpdk.org (Postfix) with ESMTP id 0DB114026F
 for <dev@dpdk.org>; Mon, 27 Oct 2025 11:17:04 +0100 (CET)
Received: from ubuntu.localdomain(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.f8MxqNC_1761560221 cluster:ay29) by smtp.aliyun-inc.com;
 Mon, 27 Oct 2025 18:17:01 +0800
From: Dimon Zhao <dimon.zhao@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	dev@dpdk.org
Cc: Kyo Liu <kyo.liu@nebula-matrix.com>, Leon Yu <leon.yu@nebula-matrix.com>,
 Sam Chen <sam.chen@nebula-matrix.com>
Subject: [PATCH v1 2/9] net/nbl: address nbl channel integer handling issues
 490943
Date: Mon, 27 Oct 2025 03:16:41 -0700
Message-Id: <20251027101649.3337618-3-dimon.zhao@nebula-matrix.com>
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

Coverity issue: 490943

Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>
---
 drivers/net/nbl/nbl_hw/nbl_channel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/nbl/nbl_hw/nbl_channel.c b/drivers/net/nbl/nbl_hw/nbl_channel.c
index 17d9231dfe..876032781c 100644
--- a/drivers/net/nbl/nbl_hw/nbl_channel.c
+++ b/drivers/net/nbl/nbl_hw/nbl_channel.c
@@ -163,7 +163,7 @@ static int nbl_chan_prepare_rx_bufs(struct nbl_channel_mgt *chan_mgt,
 	desc = rxq->desc;
 	for (i = 0; i < chan_info->mailbox.num_rxq_entries - 1; i++) {
 		desc[i].flags = NBL_CHAN_RX_DESC_AVAIL;
-		desc[i].buf_addr = rxq->buf_mem.pa + i * chan_info->mailbox.rxq_buf_size;
+		desc[i].buf_addr = rxq->buf_mem.pa + (u64)i * (u64)chan_info->mailbox.rxq_buf_size;
 		desc[i].buf_len = chan_info->mailbox.rxq_buf_size;
 	}
 
-- 
2.34.1

