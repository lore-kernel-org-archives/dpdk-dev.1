Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F17EC61DB9
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Aug 2026 03:23:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B7D4C402BB;
	Fri, 28 Aug 2026 05:23:39 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id A5A714003C
 for <dev@dpdk.org>; Fri, 28 Aug 2026 05:23:37 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowABHUD43_5Bqjx5wBg--.7936S2;
 Fri, 28 Aug 2026 11:23:35 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org
Subject: [PATCH v5 05/45] net/sxe2: restore pf and port index caps assignment
Date: Fri, 28 Aug 2026 11:23:35 +0800
Message-ID: <20260828032335.2104876-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260827024035.1432256-1-liujie5@linkdatatechnology.com>
References: <20260827024035.1432256-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowABHUD43_5Bqjx5wBg--.7936S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr18Ww4ftrWxCrykuF48JFb_yoW8Wr1rpF
 48WF15AF9YqF1Dtw48Ja1xuFyjgr4Fq340kFyrt34fCFyDuryUAF9xt34Yq3Z5Cw1xX3Wv
 yrZrX34vg3ySvF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkFb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I
 8E87Iv6xkF7I0E14v26r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
 0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Jr0_Gr
 1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4kE6xkIj40Ew7xC0wCF04k2
 0xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI
 8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41l
 IxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIx
 AIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
 jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jOsqXUUUUU=
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

