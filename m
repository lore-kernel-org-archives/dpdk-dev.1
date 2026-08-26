Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95ACC61DC4
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Aug 2026 08:55:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 92419406BB;
	Wed, 26 Aug 2026 10:55:26 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id 19B07406BB
 for <dev@dpdk.org>; Wed, 26 Aug 2026 10:55:23 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowADX2zn2qY5qHd9MBg--.43285S2;
 Wed, 26 Aug 2026 16:55:18 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org
Subject: [PATCH v3 17/51] net/sxe2: move PCI register read macro to common
 header
Date: Wed, 26 Aug 2026 16:55:18 +0800
Message-ID: <20260826085518.990938-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260818021518.2922515-14-liujie5@linkdatatechnology.com>
References: <20260818021518.2922515-14-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowADX2zn2qY5qHd9MBg--.43285S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr18Cw1DXr4rCFWftw13urg_yoW8WryUpF
 W8ZryYvF1YqF4UKw1kGa1xZFn0g3WDXryDCa9Y93ySvF1DJr18Zrs0gF1rKw1rAr48XF4F
 vry7Zr1Uuan8Zw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkIb7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
 C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
 Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVW8JV
 WxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lw4CEc2x0rVAKj4xxMxAI
 w28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr
 4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxG
 rwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJw
 CI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2
 z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8iSdDUUUUU==
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

Move SXE2_PCI_REG_READ to sxe2_ethdev.h so the PCI register access
macros are kept together in the common header, matching
SXE2_PCI_REG_WRITE.

Fixes: d8e4e075ac ("net/sxe2: add probing skeleton")
Cc: stable@dpdk.org
Cc: stephen@networkplumber.org
Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe2/sxe2_ethdev.h | 1 +
 drivers/net/sxe2/sxe2_queue.h  | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/sxe2/sxe2_ethdev.h b/drivers/net/sxe2/sxe2_ethdev.h
index cf1104144c..f2557b28c3 100644
--- a/drivers/net/sxe2/sxe2_ethdev.h
+++ b/drivers/net/sxe2/sxe2_ethdev.h
@@ -356,6 +356,7 @@ struct sxe2_adapter {
 	((struct sxe2_adapter *)(dev)->data->dev_private)
 
 #define SXE2_PCI_REG_WRITE(reg, value) rte_write32((rte_cpu_to_le_32(value)), (reg))
+#define SXE2_PCI_REG_READ(reg)         rte_read32(reg)
 
 void *sxe2_pci_map_addr_get(struct sxe2_adapter *adapter,
 			    enum sxe2_pci_map_resource res_type,
diff --git a/drivers/net/sxe2/sxe2_queue.h b/drivers/net/sxe2/sxe2_queue.h
index a300b66771..10bdaf5b8d 100644
--- a/drivers/net/sxe2/sxe2_queue.h
+++ b/drivers/net/sxe2/sxe2_queue.h
@@ -12,8 +12,6 @@
 #include "sxe2_drv_cmd.h"
 #include "sxe2_txrx_common.h"
 
-#define SXE2_PCI_REG_READ(reg)			\
-		rte_read32(reg)
 #define SXE2_PCI_REG_WRITE_WC(reg, value)			\
 		rte_write32_wc((rte_cpu_to_le_32(value)), reg)
 #define SXE2_PCI_REG_WRITE_WC_RELAXED(reg, value)		\
-- 
2.52.0

