Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7740C61DD6
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Sep 2026 01:55:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2C86842798;
	Thu,  3 Sep 2026 03:55:39 +0200 (CEST)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by mails.dpdk.org (Postfix) with ESMTP id 8AFE5410F6
 for <dev@dpdk.org>; Thu,  3 Sep 2026 03:55:37 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-05 (Coremail) with SMTP id zQCowACX_zmT05hq5BRABw--.23796S2;
 Thu, 03 Sep 2026 09:55:31 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v10 17/48] net/sxe2: move PCI register read macro to common
 header
Date: Thu,  3 Sep 2026 09:55:31 +0800
Message-ID: <20260903015531.162010-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260902021650.83354-1-liujie5@linkdatatechnology.com>
References: <20260902021650.83354-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowACX_zmT05hq5BRABw--.23796S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr18Cw1DXr4rCFWDGFW3Jrb_yoW8XF4xpF
 W8ZFyYvF1YqF4DKw1kGa1xZFnIg3ZrXryDCa9Y93ySvF1DJr18Zrs0gFyrKw4rCr48XF4F
 vr17Zr1Uuan8Xw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkv14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
 6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8JV
 W8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
 2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
 W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lw4CEc2x0rVAKj4xx
 MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
 0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0E
 wIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJV
 W8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF
 0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU4v38UUUUU=
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

