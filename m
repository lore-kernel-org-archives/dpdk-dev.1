Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC32BC61DBE
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Aug 2026 02:38:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8538B40B8D;
	Thu, 27 Aug 2026 04:38:27 +0200 (CEST)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by mails.dpdk.org (Postfix) with ESMTP id E67F340A8B
 for <dev@dpdk.org>; Thu, 27 Aug 2026 04:38:25 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-01 (Coremail) with SMTP id qwCowAAn+u0eo49qR5GjBg--.25169S2;
 Thu, 27 Aug 2026 10:38:23 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org
Subject: [PATCH v4 21/44] net/sxe2: fix duplicated cleanup in dev close
Date: Thu, 27 Aug 2026 10:38:22 +0800
Message-ID: <20260827023822.1431015-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260826085836.993490-1-liujie5@linkdatatechnology.com>
References: <20260826085836.993490-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAAn+u0eo49qR5GjBg--.25169S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr15CrW8WrWDAF1UGw1kAFb_yoW8XF47pF
 WfX3WrAF1FvFs7XwnxJayIgFyUK3WfJ3yDKr4Yv34fGa18Cw1akryktFyYkw1vv39xZF1F
 yFy7Ar1UJw4kZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkFb7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I
 8E87Iv6xkF7I0E14v26r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
 0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr0_Cr
 1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4kE6xkIj40Ew7xC0wCF04k2
 0xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI
 8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41l
 IxAIcVC0I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIx
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

sxe2_dev_close() calls sxe2_switchdev_uninit() and
sxe2_dev_pci_map_uinit() twice, and releases resources in an order
that does not match the initialization sequence.

Remove the duplicated calls and align the teardown order with the
device init order.

Fixes: 8cebf80f1eda ("net/sxe2: support Rx interrupt")
Cc: stable@dpdk.org
Cc: stephen@networkplumber.org
Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe2/sxe2_ethdev.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/sxe2/sxe2_ethdev.c b/drivers/net/sxe2/sxe2_ethdev.c
index 6222a319af..1ffaf9cb9f 100644
--- a/drivers/net/sxe2/sxe2_ethdev.c
+++ b/drivers/net/sxe2/sxe2_ethdev.c
@@ -2045,17 +2045,15 @@ static int32_t sxe2_dev_close(struct rte_eth_dev *dev)
 	(void)sxe2_queues_release(dev);
 	sxe2_mp_uninit(dev);
 	(void)sxe2_sched_uinit(dev);
-	(void)sxe2_rss_disable(dev);
 	(void)sxe2_flow_uninit(dev);
+	(void)sxe2_rss_disable(dev);
 	(void)sxe2_udp_tunnel_port_clear(dev);
-	sxe2_vsi_uninit(dev);
 	sxe2_security_uinit(dev);
 	sxe2_intr_uninit(dev);
 	(void)sxe2_switchdev_uninit(dev);
 	sxe2_sw_uninit(dev);
-	(void)sxe2_switchdev_uninit(dev);
-	sxe2_dev_pci_map_uinit(dev);
 	sxe2_eth_uinit(dev);
+	sxe2_vsi_uninit(dev);
 	sxe2_dev_pci_map_uinit(dev);
 	sxe2_free_repr_info(dev);
 	sxe2_fc_state_uinit(dev);
-- 
2.52.0

