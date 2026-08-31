Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91CF5C61DE2
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Aug 2026 02:41:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B5BA640689;
	Mon, 31 Aug 2026 04:41:33 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id 37E2D40659;
 Mon, 31 Aug 2026 04:41:31 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowADn7DrW6ZRqSdGjBg--.28037S2;
 Mon, 31 Aug 2026 10:41:27 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>,
	stable@dpdk.org
Subject: [PATCH v7 04/47] net/sxe2: fix MSIX register width in PF map table
Date: Mon, 31 Aug 2026 10:41:26 +0800
Message-ID: <20260831024126.3230507-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260828074056.2250222-1-liujie5@linkdatatechnology.com>
References: <20260828074056.2250222-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowADn7DrW6ZRqSdGjBg--.28037S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr15Ww1fur4fZw1fKryUZFb_yoW8GryDpF
 WfWry2qF1FqFn8KF4rGa18Zr9Fka1UJryj9FsrW34akF98JrW8ZryDGay5Ka42yrW8XF1F
 yF42kw1Yga15tw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkm14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
 6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
 0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
 6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
 0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4kE6xkIj40Ew7xC
 0wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
 1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij
 64vIr41lIxAIcVC0I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr
 0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI
 42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU538nUUUUU
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

