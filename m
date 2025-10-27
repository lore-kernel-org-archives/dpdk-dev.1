Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5481FCCF9EA
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Oct 2025 10:17:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 880ED402E3;
	Mon, 27 Oct 2025 11:17:07 +0100 (CET)
Received: from out28-4.mail.aliyun.com (out28-4.mail.aliyun.com [115.124.28.4])
 by mails.dpdk.org (Postfix) with ESMTP id 1F2074028B
 for <dev@dpdk.org>; Mon, 27 Oct 2025 11:17:03 +0100 (CET)
Received: from ubuntu.localdomain(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.f8MxqMC_1761560220 cluster:ay29) by smtp.aliyun-inc.com;
 Mon, 27 Oct 2025 18:17:01 +0800
From: Dimon Zhao <dimon.zhao@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	dev@dpdk.org
Cc: Kyo Liu <kyo.liu@nebula-matrix.com>, Leon Yu <leon.yu@nebula-matrix.com>,
 Sam Chen <sam.chen@nebula-matrix.com>
Subject: [PATCH v1 1/9] net/nbl: address nbl channel integer handling issues
 490942
Date: Mon, 27 Oct 2025 03:16:40 -0700
Message-Id: <20251027101649.3337618-2-dimon.zhao@nebula-matrix.com>
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

Coverity issue: 490942

Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>
---
 drivers/net/nbl/nbl_hw/nbl_channel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/nbl/nbl_hw/nbl_channel.c b/drivers/net/nbl/nbl_hw/nbl_channel.c
index 7cc214df01..17d9231dfe 100644
--- a/drivers/net/nbl/nbl_hw/nbl_channel.c
+++ b/drivers/net/nbl/nbl_hw/nbl_channel.c
@@ -376,8 +376,8 @@ static uint16_t nbl_chan_update_txqueue(union nbl_chan_info *chan_info,
 
 	txq = &chan_info->mailbox.txq;
 	next_to_use = txq->next_to_use;
-	va = (u8 *)txq->buf + next_to_use * chan_info->mailbox.txq_buf_size;
-	pa = txq->buf_mem.pa + next_to_use * chan_info->mailbox.txq_buf_size;
+	va = (u8 *)txq->buf + (u64)next_to_use * (u64)chan_info->mailbox.txq_buf_size;
+	pa = txq->buf_mem.pa + (u64)next_to_use * (u64)chan_info->mailbox.txq_buf_size;
 	tx_desc = NBL_CHAN_TX_DESC(txq, next_to_use);
 
 	tx_desc->dstid = dstid;
-- 
2.34.1

