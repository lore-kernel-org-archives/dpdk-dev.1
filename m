Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA795C61DD6
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Sep 2026 02:04:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5AF0440ED6;
	Wed,  2 Sep 2026 04:04:12 +0200 (CEST)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by mails.dpdk.org (Postfix) with ESMTP id 7688340E1B;
 Wed,  2 Sep 2026 04:04:09 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-01 (Coremail) with SMTP id qwCowABnO+_+g5dqE50HBw--.39883S2;
 Wed, 02 Sep 2026 10:03:52 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>,
	stable@dpdk.org
Subject: [PATCH v9 34/48] net/sxe2: restore PF-only guard in UDP tunnel port
 add
Date: Wed,  2 Sep 2026 10:03:38 +0800
Message-ID: <20260902020338.78007-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260901031006.3686638-1-liujie5@linkdatatechnology.com>
References: <20260901031006.3686638-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowABnO+_+g5dqE50HBw--.39883S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr18Aw1xKF1DWr48trW8JFb_yoW8uw4UpF
 4jgrWYvFyaqFsIvw4FvF4kWF1jgr9YqayDC39xWw1rZ3WDZ347Aay5tF1Yv3W8CFWfJF1F
 yayagr1fWr4DZ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkC14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
 JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
 1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
 7VC0I7IYx2IY67AKxVWrXVW3AwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r
 1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwAKzVCY07xG64k0
 F24l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
 WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI
 7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
 4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4U
 MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjTRKLvNUU
 UUU
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

sxe2_udp_tunnel_port_add_common() lost the check that restricts
UDP tunnel port configuration to PF devices (not VF or
representor), so VF/representor devices can now attempt to add
UDP tunnel ports, which the hardware does not support.

Restore the PF-only guard returning -ENOTSUP, matching the V3
implementation.

Fixes: fff24885f70a ("net/sxe2: support custom UDP tunnel ports")
Cc: stable@dpdk.org
Cc: stephen@networkplumber.org
Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe2/sxe2_ethdev.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/sxe2/sxe2_ethdev.c b/drivers/net/sxe2/sxe2_ethdev.c
index ea589c7eaa..82ad6e660a 100644
--- a/drivers/net/sxe2/sxe2_ethdev.c
+++ b/drivers/net/sxe2/sxe2_ethdev.c
@@ -630,6 +630,10 @@ int32_t sxe2_udp_tunnel_port_add_common(struct sxe2_adapter *ad,
 	struct sxe2_udp_tunnel_cfg *tunnel_config;
 	int32_t ret = -1;
 
+	if (ad->dev_type != SXE2_DEV_T_PF || ad->is_dev_repr) {
+		ret = -ENOTSUP;
+		goto l_end;
+	}
 	rte_spinlock_lock(&ad->udp_tunnel_ctx.lock);
 
 	tunnel_config = &ad->udp_tunnel_ctx.tunnel_conf[tunnel_proto];
@@ -659,6 +663,7 @@ int32_t sxe2_udp_tunnel_port_add_common(struct sxe2_adapter *ad,
 
 l_unlock_end:
 	rte_spinlock_unlock(&ad->udp_tunnel_ctx.lock);
+l_end:
 	return ret;
 }
 
@@ -669,6 +674,9 @@ int32_t sxe2_udp_tunnel_port_del_common(struct sxe2_adapter *ad,
 	struct sxe2_udp_tunnel_cfg *tunnel_config;
 	int32_t ret = -1;
 
+	if (ad->dev_type != SXE2_DEV_T_PF || ad->is_dev_repr)
+		return -ENOTSUP;
+
 	rte_spinlock_lock(&ad->udp_tunnel_ctx.lock);
 	tunnel_config = &ad->udp_tunnel_ctx.tunnel_conf[tunnel_proto];
 
@@ -703,6 +711,9 @@ static int32_t sxe2_udp_tunnel_port_clear(struct rte_eth_dev *dev)
 	int32_t ret = 0;
 	uint16_t tunnel_proto = 0;
 
+	if (ad->dev_type != SXE2_DEV_T_PF || ad->is_dev_repr)
+		return -ENOTSUP;
+
 	rte_spinlock_lock(&ad->udp_tunnel_ctx.lock);
 
 	for (tunnel_proto = 0; tunnel_proto < SXE2_UDP_TUNNEL_MAX; tunnel_proto++) {
-- 
2.52.0

