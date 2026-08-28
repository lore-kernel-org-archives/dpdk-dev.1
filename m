Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 346A4C61DB9
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Aug 2026 03:24:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 577AB40B97;
	Fri, 28 Aug 2026 05:24:53 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id 1C90740A7A
 for <dev@dpdk.org>; Fri, 28 Aug 2026 05:24:50 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowAAHDDp__5BqXCNwBg--.11488S2;
 Fri, 28 Aug 2026 11:24:47 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org
Subject: [PATCH v5 17/45] net/sxe2: move PCI register read macro to common
 header
Date: Fri, 28 Aug 2026 11:24:46 +0800
Message-ID: <20260828032446.2106356-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260827024035.1432256-1-liujie5@linkdatatechnology.com>
References: <20260827024035.1432256-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowAAHDDp__5BqXCNwBg--.11488S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr18Cw1DXr4rCFWDGFW3Jrb_yoW8XF4xpF
 W8ZFyYvF1YqF4DKw1kGa1xZFnIg3ZrXryDCa9Y93ySvF1DJr18Zrs0gFyrKw4rCr48XF4F
 vr17Zr1Uuan8Xw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkFb7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I
 8E87Iv6xkF7I0E14v26r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
 0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr0_Cr
 1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4kE6xkIj40Ew7xC0wCF04k2
 0xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI
 8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41l
 IxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIx
 AIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2
 jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jzBT5UUUUU=
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

