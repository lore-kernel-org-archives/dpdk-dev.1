Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5ABDC624D6
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Sep 2026 01:56:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AC9F6427AF;
	Thu,  3 Sep 2026 03:55:53 +0200 (CEST)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by mails.dpdk.org (Postfix) with ESMTP id 54818427A8;
 Thu,  3 Sep 2026 03:55:51 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-05 (Coremail) with SMTP id zQCowACH7zmk05hqJBZABw--.57366S2;
 Thu, 03 Sep 2026 09:55:49 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>,
	stable@dpdk.org
Subject: [PATCH v10 20/48] net/sxe2: fix duplicated cleanup in dev close
Date: Thu,  3 Sep 2026 09:55:48 +0800
Message-ID: <20260903015548.162062-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260902021650.83354-1-liujie5@linkdatatechnology.com>
References: <20260902021650.83354-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowACH7zmk05hqJBZABw--.57366S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr15CrW8WrWDAF1UGw1kAFb_yoW8XF47pF
 WfX3WrAFyFvFs7XwsxXayIgFyUKF1fJ34DKr4Yy34fuay8C34akryktFyYkw1vv39xZF1F
 yry7Ar1UJw4kZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkv14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
 6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8JV
 W8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
 2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
 W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lw4CEc2x0rVAKj4xx
 MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
 0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0E
 wIxGrwCI42IY6xIIjxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJV
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
index fdff4ae10f..fab7dcf44c 100644
--- a/drivers/net/sxe2/sxe2_ethdev.c
+++ b/drivers/net/sxe2/sxe2_ethdev.c
@@ -2041,17 +2041,15 @@ static int32_t sxe2_dev_close(struct rte_eth_dev *dev)
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

