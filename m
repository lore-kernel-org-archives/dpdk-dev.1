Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE8BC61DB9
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Aug 2026 07:38:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8E2FA40B8D;
	Fri, 28 Aug 2026 09:38:34 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id DEDE140395
 for <dev@dpdk.org>; Fri, 28 Aug 2026 09:38:32 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowADn7DryOpFqBc5zBg--.58230S2;
 Fri, 28 Aug 2026 15:38:27 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org
Subject: [PATCH v6 19/45] net/sxe2: guard PCI BAR unmap when not initialized
Date: Fri, 28 Aug 2026 15:38:26 +0800
Message-ID: <20260828073826.2248703-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260828032731.2109423-1-liujie5@linkdatatechnology.com>
References: <20260828032731.2109423-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowADn7DryOpFqBc5zBg--.58230S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr18uw45WF13Cw15uFW3Wrg_yoW8uFyUpF
 WrZ34UJF1SqFsa9rZIq3yfZr17KFs5t3yjkanIqw13Ca4kAr1293ykta4kKr1jkr4xZrnY
 yrsxta1fZry8AFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkqb7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
 C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
 Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVWxJV
 W8Jr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4kE6xkIj40Ew7xC0wCF
 04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
 18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vI
 r41lIxAIcVC0I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr
 1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26F4j6r4UJwCI42IY
 6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU8c_-PUUUUU==
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

sxe2_dev_pci_map_uinit() calls sxe2_dev_pci_seg_unmap() and walks
bar_info unconditionally. Only perform the unmap and free when
bar_info has been allocated, so an uninitialized map context is
handled cleanly.

Fixes: 66a10eb60ebe ("net/sxe2: add PCI BAR mapping")
Cc: stable@dpdk.org
Cc: stephen@networkplumber.org
Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe2/sxe2_ethdev.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/net/sxe2/sxe2_ethdev.c b/drivers/net/sxe2/sxe2_ethdev.c
index 9ef93b8076..fdff4ae10f 100644
--- a/drivers/net/sxe2/sxe2_ethdev.c
+++ b/drivers/net/sxe2/sxe2_ethdev.c
@@ -1773,14 +1773,13 @@ void sxe2_dev_pci_map_uinit(struct rte_eth_dev *dev)
 	uint8_t i = 0;
 
 	PMD_INIT_FUNC_TRACE();
+	if (map_ctxt->bar_info != NULL) {
+		(void)sxe2_dev_pci_seg_unmap(adapter, SXE2_PCI_MAP_RES_DOORBELL_RX_TAIL);
+		(void)sxe2_dev_pci_seg_unmap(adapter, SXE2_PCI_MAP_RES_DOORBELL_TX);
+		(void)sxe2_dev_pci_seg_unmap(adapter, SXE2_PCI_MAP_RES_IRQ_DYN);
+		(void)sxe2_dev_pci_seg_unmap(adapter, SXE2_PCI_MAP_RES_IRQ_ITR);
+		(void)sxe2_dev_pci_seg_unmap(adapter, SXE2_PCI_MAP_RES_IRQ_MSIX);
 
-	(void)sxe2_dev_pci_seg_unmap(adapter, SXE2_PCI_MAP_RES_DOORBELL_RX_TAIL);
-	(void)sxe2_dev_pci_seg_unmap(adapter, SXE2_PCI_MAP_RES_DOORBELL_TX);
-	(void)sxe2_dev_pci_seg_unmap(adapter, SXE2_PCI_MAP_RES_IRQ_DYN);
-	(void)sxe2_dev_pci_seg_unmap(adapter, SXE2_PCI_MAP_RES_IRQ_ITR);
-	(void)sxe2_dev_pci_seg_unmap(adapter, SXE2_PCI_MAP_RES_IRQ_MSIX);
-
-	if (map_ctxt != NULL && map_ctxt->bar_info != NULL) {
 		for (i = 0; i < map_ctxt->bar_cnt; i++) {
 			bar_info = &map_ctxt->bar_info[i];
 			if (bar_info != NULL && bar_info->seg_info != NULL) {
@@ -1791,7 +1790,6 @@ void sxe2_dev_pci_map_uinit(struct rte_eth_dev *dev)
 		rte_free(map_ctxt->bar_info);
 		map_ctxt->bar_info = NULL;
 	}
-
 	adapter->dev_info.dev_data = NULL;
 }
 
-- 
2.52.0

