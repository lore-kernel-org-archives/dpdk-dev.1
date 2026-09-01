Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47BCFC624CE
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Sep 2026 03:06:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 54B1B40695;
	Tue,  1 Sep 2026 05:06:02 +0200 (CEST)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by mails.dpdk.org (Postfix) with ESMTP id 32C1A4068E;
 Tue,  1 Sep 2026 05:05:58 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-05 (Coremail) with SMTP id zQCowADH9kAOQZZqIPMhBw--.58235S2;
 Tue, 01 Sep 2026 11:05:50 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>,
	stable@dpdk.org
Subject: [PATCH v8 06/49] net/sxe2: fix VSI lifecycle management
Date: Tue,  1 Sep 2026 11:05:50 +0800
Message-ID: <20260901030550.3683721-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260831024549.3231744-1-liujie5@linkdatatechnology.com>
References: <20260831024549.3231744-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowADH9kAOQZZqIPMhBw--.58235S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXr4kAFWrKrWxGF1xuw47CFg_yoW5uw1DpF
 s3AF1YqF40qFn09FW7Jr4rZF15KrWrtry09a1F9w1fJ3WDAry5AF95Xr1Fka4fC3ykWwn3
 Aan7Ww18Jr1DGFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkS14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
 6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
 4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
 I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
 4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwAKzVCY07xG64k0F24l
 42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
 WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAK
 I48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F
 4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY
 6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU538nUUUUU
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
 drivers/net/sxe2/sxe2_vsi.c | 31 ++++++++++---------------------
 1 file changed, 10 insertions(+), 21 deletions(-)

diff --git a/drivers/net/sxe2/sxe2_vsi.c b/drivers/net/sxe2/sxe2_vsi.c
index d29480b931..e1a26fda6a 100644
--- a/drivers/net/sxe2/sxe2_vsi.c
+++ b/drivers/net/sxe2/sxe2_vsi.c
@@ -96,21 +96,6 @@ static struct sxe2_vsi *sxe2_vsi_node_create(struct sxe2_adapter *adapter,
 	return vsi;
 }
 
-static void sxe2_vsi_node_free(struct sxe2_vsi *vsi)
-{
-	struct sxe2_adapter *adapter;
-
-	if (!vsi)
-		return;
-
-	adapter = vsi->adapter;
-	if (vsi->vsi_type == SXE2_VSI_T_ESW)
-		TAILQ_REMOVE(&adapter->vsi_ctxt.other_vsi_list, vsi, next);
-
-	rte_free(vsi);
-	vsi = NULL;
-}
-
 static int32_t sxe2_vsi_destroy(struct sxe2_adapter *adapter, struct sxe2_vsi *vsi)
 {
 	int32_t ret = 0;
@@ -131,6 +116,8 @@ static int32_t sxe2_vsi_destroy(struct sxe2_adapter *adapter, struct sxe2_vsi *v
 	}
 
 l_free:
+	if (vsi->vsi_type == SXE2_VSI_T_DPDK_ESW)
+		TAILQ_REMOVE(&adapter->vsi_ctxt.other_vsi_list, vsi, next);
 	rte_free(vsi);
 	vsi = NULL;
 
@@ -174,7 +161,7 @@ static int32_t sxe2_main_vsi_create(struct sxe2_adapter *adapter)
 	goto l_end;
 
 l_free_vsi:
-	sxe2_vsi_node_free(adapter->vsi_ctxt.main_vsi);
+	rte_free(adapter->vsi_ctxt.main_vsi);
 	adapter->vsi_ctxt.main_vsi = NULL;
 l_end:
 	return ret;
@@ -217,7 +204,7 @@ int32_t sxe2_other_vsi_create(struct sxe2_adapter *adapter, uint16_t cnt_vf)
 	goto l_end;
 
 l_free_vsi:
-	sxe2_vsi_node_free(other_vsi);
+	rte_free(other_vsi);
 l_end:
 	return ret;
 }
@@ -230,7 +217,7 @@ int32_t sxe2_vsi_init(struct rte_eth_dev *dev)
 	uint16_t srcvsi_cnt;
 
 	PMD_INIT_FUNC_TRACE();
-
+	TAILQ_INIT(&adapter->vsi_ctxt.other_vsi_list);
 	ret = sxe2_main_vsi_create(adapter);
 	if (ret) {
 		PMD_LOG_ERR(DRV, "Failed to create main VSI, ret=%d", ret);
@@ -283,13 +270,14 @@ void sxe2_vsi_uninit(struct rte_eth_dev *dev)
 
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
@@ -356,5 +344,6 @@ void sxe2_vsi_repr_main_vsi_destroy(struct rte_eth_dev *dev)
 {
 	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
 
-	sxe2_vsi_node_free(adapter->vsi_ctxt.main_vsi);
+	rte_free(adapter->vsi_ctxt.main_vsi);
+	adapter->vsi_ctxt.main_vsi = NULL;
 }
-- 
2.52.0

