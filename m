Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B52CCF9E0
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Oct 2025 10:17:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AE12B40652;
	Mon, 27 Oct 2025 11:17:15 +0100 (CET)
Received: from out28-50.mail.aliyun.com (out28-50.mail.aliyun.com
 [115.124.28.50]) by mails.dpdk.org (Postfix) with ESMTP id D0BAF40430
 for <dev@dpdk.org>; Mon, 27 Oct 2025 11:17:09 +0100 (CET)
Received: from ubuntu.localdomain(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.f8MxqVJ_1761560227 cluster:ay29) by smtp.aliyun-inc.com;
 Mon, 27 Oct 2025 18:17:07 +0800
From: Dimon Zhao <dimon.zhao@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	dev@dpdk.org
Cc: Kyo Liu <kyo.liu@nebula-matrix.com>, Leon Yu <leon.yu@nebula-matrix.com>,
 Sam Chen <sam.chen@nebula-matrix.com>
Subject: [PATCH v1 9/9] net/nbl: address channel Incorrect expression issues
 490958
Date: Mon, 27 Oct 2025 03:16:48 -0700
Message-Id: <20251027101649.3337618-10-dimon.zhao@nebula-matrix.com>
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

Coverity issue: 490958

Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>
---
 drivers/net/nbl/nbl_hw/nbl_channel.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/nbl/nbl_hw/nbl_channel.c b/drivers/net/nbl/nbl_hw/nbl_channel.c
index 654e56f200..acbceecc46 100644
--- a/drivers/net/nbl/nbl_hw/nbl_channel.c
+++ b/drivers/net/nbl/nbl_hw/nbl_channel.c
@@ -856,9 +856,12 @@ static void nbl_chan_remove_state_bitmap(void *priv)
 {
 	struct nbl_channel_mgt *chan_mgt = (struct nbl_channel_mgt *)priv;
 	union nbl_chan_info *chan_info = NBL_CHAN_MGT_TO_CHAN_INFO(chan_mgt);
+	int ret = 0;
 
 	if (chan_info->mailbox.state_bmp) {
-		rte_bitmap_free(chan_info->mailbox.state_bmp);
+		ret = rte_bitmap_free(chan_info->mailbox.state_bmp);
+		if (ret)
+			NBL_LOG(ERR, "mailbox state bitmap free failed, ret:%d", ret);
 		chan_info->mailbox.state_bmp = NULL;
 	}
 	if (chan_info->mailbox.state_bmp_mem) {
-- 
2.34.1

