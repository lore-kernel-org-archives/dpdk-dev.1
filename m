Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6FBAC61DBE
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Aug 2026 02:37:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 45F6A40685;
	Thu, 27 Aug 2026 04:37:04 +0200 (CEST)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by mails.dpdk.org (Postfix) with ESMTP id 46A3F4064A
 for <dev@dpdk.org>; Thu, 27 Aug 2026 04:36:59 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-01 (Coremail) with SMTP id qwCowACXau7Ioo9qTI2jBg--.25306S2;
 Thu, 27 Aug 2026 10:36:57 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org
Subject: [PATCH v4 06/44] net/sxe2: fix VSI lifecycle management
Date: Thu, 27 Aug 2026 10:36:56 +0800
Message-ID: <20260827023656.1430168-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260826085836.993490-1-liujie5@linkdatatechnology.com>
References: <20260826085836.993490-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowACXau7Ioo9qTI2jBg--.25306S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr1rXF18tF1xAFy8Kw4UArb_yoW8ZFWUpr
 s3Zr1FqF4FqF1Yk3y7G3WrZFy5KFWrtry093WF9w1fJa47Jry5Gas5XF1rJ3WxCw4kXwn3
 Aw4xX345Jrn5CFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkYb7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4
 A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
 64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWUJVW8Jw
 Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lw4CEc2x0rVAKj4xxMxAIw28I
 cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
 IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI
 42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42
 IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280
 aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8gBMtUUUUU==
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
 drivers/net/sxe2/sxe2_vsi.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/sxe2/sxe2_vsi.c b/drivers/net/sxe2/sxe2_vsi.c
index d29480b931..ba4cc7414e 100644
--- a/drivers/net/sxe2/sxe2_vsi.c
+++ b/drivers/net/sxe2/sxe2_vsi.c
@@ -230,7 +230,7 @@ int32_t sxe2_vsi_init(struct rte_eth_dev *dev)
 	uint16_t srcvsi_cnt;
 
 	PMD_INIT_FUNC_TRACE();
-
+	TAILQ_INIT(&adapter->vsi_ctxt.other_vsi_list);
 	ret = sxe2_main_vsi_create(adapter);
 	if (ret) {
 		PMD_LOG_ERR(DRV, "Failed to create main VSI, ret=%d", ret);
@@ -283,13 +283,14 @@ void sxe2_vsi_uninit(struct rte_eth_dev *dev)
 
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
@@ -357,4 +358,5 @@ void sxe2_vsi_repr_main_vsi_destroy(struct rte_eth_dev *dev)
 	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
 
 	sxe2_vsi_node_free(adapter->vsi_ctxt.main_vsi);
+	adapter->vsi_ctxt.main_vsi = NULL;
 }
-- 
2.52.0

