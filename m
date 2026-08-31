Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2644C61DE2
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Aug 2026 02:35:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D88BA4069F;
	Mon, 31 Aug 2026 04:35:17 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id 5F84E40374;
 Mon, 31 Aug 2026 04:35:08 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowABnckBX6JRq27+jBg--.24645S6;
 Mon, 31 Aug 2026 10:35:05 +0800 (CST)
From: Jie Liu <liujie5@linkdatatechnology.com>
To: dev@dpdk.org
Cc: Jie Liu <liujie5@linkdatatechnology.com>, stable@dpdk.org,
 stephen@networkplumber.org
Subject: [PATCH v7 04/47] net/sxe2: fix MSIX register width in PF map table
Date: Mon, 31 Aug 2026 10:34:17 +0800
Message-ID: <20260831023500.3229289-5-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260831023500.3229289-1-liujie5@linkdatatechnology.com>
References: <20260828074056.2250222-1-liujie5@linkdatatechnology.com>
 <20260831023500.3229289-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowABnckBX6JRq27+jBg--.24645S6
X-Coremail-Antispam: 1UD129KBjvJXoW7tr48Kw4kGFWUJF4DXry5Jwb_yoW8Jw1xpF
 WS9ryaqF1FqFn5KF4rua18ZF92ka1UXryj9FsrW34FkF98JrW8Zr98Gayaka4ayrW8XF1F
 yF42kw1rWa1Yyw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9G14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
 kIc2x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
 z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr
 1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1U
 M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
 v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
 F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMx
 C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
 wI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
 vE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v2
 0xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxV
 W8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjjXdUUUUUU==
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

The MSIX entry in sxe2_net_map_addr_info_pf sets a register width
of 10 (decimal), but each PCIe MSIX table entry is 16 bytes (0x10).
The VF map table already uses 0x10.

Since reg_width is used as the stride between MSIX entries in
sxe2_dev_pci_seg_map(), the wrong value makes the mapped region too
short and places the entries at incorrect offsets.

Change .reg_width from 10 to 0x10 for the SXE2_PCI_MAP_RES_IRQ_MSIX
entry to match the VF table.

Fixes: 66a10eb60ebe ("net/sxe2: add PCI BAR mapping")
Cc: stable@dpdk.org
Cc: stephen@networkplumber.org
Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe2/sxe2_ethdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/sxe2/sxe2_ethdev.c b/drivers/net/sxe2/sxe2_ethdev.c
index ec376b76dc..5d8cfca6cf 100644
--- a/drivers/net/sxe2/sxe2_ethdev.c
+++ b/drivers/net/sxe2/sxe2_ethdev.c
@@ -94,7 +94,7 @@ static struct sxe2_pci_map_addr_info sxe2_net_map_addr_info_pf[SXE2_PCI_MAP_RES_
 				      .reg_width = 4},
 	[SXE2_PCI_MAP_RES_IRQ_MSIX] = {.addr_base = SXE2_BAR4_MSIX_CTL(0),
 				      .bar_idx = 4,
-				      .reg_width = 10},
+				      .reg_width = 0x10},
 };
 
 static struct sxe2_pci_map_addr_info sxe2_net_map_addr_info_vf[SXE2_PCI_MAP_RES_MAX_COUNT] = {
-- 
2.52.0

