Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C41C61DE2
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Aug 2026 02:41:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E1A7D40A6D;
	Mon, 31 Aug 2026 04:41:36 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id 6D98E40A70;
 Mon, 31 Aug 2026 04:41:34 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowAC3vTvc6ZRqfNGjBg--.44296S2;
 Mon, 31 Aug 2026 10:41:33 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>,
	stable@dpdk.org
Subject: [PATCH v7 05/47] net/sxe2: restore PF and port index caps assignment
Date: Mon, 31 Aug 2026 10:41:32 +0800
Message-ID: <20260831024132.3230526-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260828074056.2250222-1-liujie5@linkdatatechnology.com>
References: <20260828074056.2250222-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowAC3vTvc6ZRqfNGjBg--.44296S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr18Ww4ftrWxCrykuF48JFb_yoW8Wr1rpF
 48WF15AF9YqF1Dtw48Ja1xuFyjgr4Fq340kFyrt34fCFyDuryUAF9xt34Yq3Z5Cw1xX3Wv
 yrZrX34vg3ySvF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

sxe2_func_caps_get() never assigns adapter->pf_idx from the device
capabilities, leaving it at its zero-initialized value. Switchdev
requests and representor setup that use pf_idx then report the wrong
PF index on multi-PF configurations.

Restore the pf_idx and port_idx assignments in sxe2_func_caps_get()
and drop the now-redundant port_idx assignment from
sxe2_drv_dev_caps_set().

Fixes: d8e4e075acb4 ("net/sxe2: add probing skeleton")
Cc: stable@dpdk.org
Cc: stephen@networkplumber.org
Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe2/sxe2_ethdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/sxe2/sxe2_ethdev.c b/drivers/net/sxe2/sxe2_ethdev.c
index 5d8cfca6cf..2e14c372f8 100644
--- a/drivers/net/sxe2/sxe2_ethdev.c
+++ b/drivers/net/sxe2/sxe2_ethdev.c
@@ -1284,8 +1284,6 @@ void sxe2_eth_uinit(struct rte_eth_dev *dev __rte_unused)
 static void sxe2_drv_dev_caps_set(struct sxe2_adapter *adapter,
 			struct sxe2_drv_dev_caps_resp *dev_caps)
 {
-	adapter->port_idx = dev_caps->port_idx;
-
 	adapter->cap_flags = 0;
 
 	if (dev_caps->cap_flags & SXE2_DEV_CAPS_OFFLOAD_L2)
@@ -1344,6 +1342,8 @@ static int32_t sxe2_func_caps_get(struct sxe2_adapter *adapter)
 		goto l_end;
 
 	adapter->dev_type = dev_caps.dev_type;
+	adapter->port_idx = dev_caps.port_idx;
+	adapter->pf_idx = dev_caps.pf_idx;
 
 	sxe2_drv_dev_caps_set(adapter,  &dev_caps);
 
-- 
2.52.0

