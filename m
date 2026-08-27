Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104E9C61DBD
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Aug 2026 02:38:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9D57340A80;
	Thu, 27 Aug 2026 04:38:15 +0200 (CEST)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by mails.dpdk.org (Postfix) with ESMTP id F0CC840698
 for <dev@dpdk.org>; Thu, 27 Aug 2026 04:38:13 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-01 (Coremail) with SMTP id qwCowADnvfETo49qt5CjBg--.24953S2;
 Thu, 27 Aug 2026 10:38:11 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org
Subject: [PATCH v4 19/44] net/sxe2: guard PCI BAR unmap when not initialized
Date: Thu, 27 Aug 2026 10:38:11 +0800
Message-ID: <20260827023811.1430904-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260826085836.993490-1-liujie5@linkdatatechnology.com>
References: <20260826085836.993490-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowADnvfETo49qt5CjBg--.24953S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr18uw45WF13Cw15uFW3Wrg_yoW8uFyUpF
 WrZa4UJF1SqFsa9rZIq3yfZr17Krs5J3yjkanIqw13Ca4kAry293ykta4kKr1jkr4xZrnY
 yrsxta1fZry8AFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkYb7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4
 A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
 64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVW8JVWxJw
 Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lw4CEc2x0rVAKj4xxMxAIw28I
 cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
 IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI
 42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42
 IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280
 aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8iSdDUUUUU==
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
index 7646f6b309..05a57548e7 100644
--- a/drivers/net/sxe2/sxe2_ethdev.c
+++ b/drivers/net/sxe2/sxe2_ethdev.c
@@ -1777,14 +1777,13 @@ void sxe2_dev_pci_map_uinit(struct rte_eth_dev *dev)
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
@@ -1795,7 +1794,6 @@ void sxe2_dev_pci_map_uinit(struct rte_eth_dev *dev)
 		rte_free(map_ctxt->bar_info);
 		map_ctxt->bar_info = NULL;
 	}
-
 	adapter->dev_info.dev_data = NULL;
 }
 
-- 
2.52.0

