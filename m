Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 606EDC61DB9
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Aug 2026 03:23:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B674540653;
	Fri, 28 Aug 2026 05:23:48 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id 42D284003C
 for <dev@dpdk.org>; Fri, 28 Aug 2026 05:23:47 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowACnrjw9_5Bq8R5wBg--.11627S2;
 Fri, 28 Aug 2026 11:23:41 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org
Subject: [PATCH v5 06/45] net/sxe2: fix VSI lifecycle management
Date: Fri, 28 Aug 2026 11:23:40 +0800
Message-ID: <20260828032340.2104930-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260827024035.1432256-1-liujie5@linkdatatechnology.com>
References: <20260827024035.1432256-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowACnrjw9_5Bq8R5wBg--.11627S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr1rXF18tF1xAFy8Kw4UArb_yoW8tw4Upr
 s3Zr1FqF40qFn0k3y7Jw1rZF15KFWrtry093WF9w1fJasrJ345Cas5Xr1rG3WxCw4kXwn3
 Aan7W34UJrn5CFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkFb7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I
 8E87Iv6xkF7I0E14v26r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
 0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Jr0_Gr
 1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4kE6xkIj40Ew7xC0wCF04k2
 0xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI
 8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41l
 IxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIx
 AIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
 jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jrPEfUUUUU=
X-Originating-IP: [118.112.177.181]
X-CM-SenderInfo: xolxyxrhv6zxpqngt3pdwhux5qro0w31of0z/
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

From: Jie Liu <liujie5@linkdatatechnology.com>

Fix several VSI create/destroy issues introduced by VF representor
support:

- Initialize other_vsi_list with TAILQ_INIT in sxe2_vsi_init before
  any VSI is inserted into it.
- Treat -EPERM as a non-fatal error when destroying VSIs, since the
  kernel may have already removed the VSI.
- Set main_vsi to NULL after destroy/free to avoid a dangling pointer
  if the VSI is destroyed again.

Fixes: 635084db5d57 ("net/sxe2: support VF representors")
Cc: stable@dpdk.org
Cc: stephen@networkplumber.org
Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe2/sxe2_vsi.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/sxe2/sxe2_vsi.c b/drivers/net/sxe2/sxe2_vsi.c
index d29480b931..dea3f58997 100644
--- a/drivers/net/sxe2/sxe2_vsi.c
+++ b/drivers/net/sxe2/sxe2_vsi.c
@@ -131,6 +131,8 @@ static int32_t sxe2_vsi_destroy(struct sxe2_adapter *adapter, struct sxe2_vsi *v
 	}
 
 l_free:
+	if (vsi->vsi_type == SXE2_VSI_T_DPDK_ESW)
+		TAILQ_REMOVE(&adapter->vsi_ctxt.other_vsi_list, vsi, next);
 	rte_free(vsi);
 	vsi = NULL;
 
@@ -230,7 +232,7 @@ int32_t sxe2_vsi_init(struct rte_eth_dev *dev)
 	uint16_t srcvsi_cnt;
 
 	PMD_INIT_FUNC_TRACE();
-
+	TAILQ_INIT(&adapter->vsi_ctxt.other_vsi_list);
 	ret = sxe2_main_vsi_create(adapter);
 	if (ret) {
 		PMD_LOG_ERR(DRV, "Failed to create main VSI, ret=%d", ret);
@@ -283,13 +285,14 @@ void sxe2_vsi_uninit(struct rte_eth_dev *dev)
 
 l_free:
 	ret = sxe2_vsi_destroy(adapter, adapter->vsi_ctxt.main_vsi);
-	if (ret) {
+	if (ret && ret != -EPERM) {
 		PMD_LOG_ERR(DRV, "Failed to del vsi from fw, ret=%d", ret);
 		goto l_end;
 	}
+	adapter->vsi_ctxt.main_vsi = NULL;
 	RTE_TAILQ_FOREACH_SAFE(var, &adapter->vsi_ctxt.other_vsi_list, next, tvar) {
 		ret = sxe2_vsi_destroy(adapter, var);
-		if (ret) {
+		if (ret && ret != -EPERM) {
 			PMD_LOG_ERR(DRV, "Failed to del vsi from fw, ret=%d", ret);
 			break;
 		}
@@ -357,4 +360,5 @@ void sxe2_vsi_repr_main_vsi_destroy(struct rte_eth_dev *dev)
 	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
 
 	sxe2_vsi_node_free(adapter->vsi_ctxt.main_vsi);
+	adapter->vsi_ctxt.main_vsi = NULL;
 }
-- 
2.52.0

