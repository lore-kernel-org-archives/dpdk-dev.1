Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B52C61DE4
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Aug 2026 02:44:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B35744064F;
	Mon, 31 Aug 2026 04:44:27 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id 732AD4025A;
 Mon, 31 Aug 2026 04:44:25 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowACXmzmF6pRqNtmjBg--.23054S2;
 Mon, 31 Aug 2026 10:44:21 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>,
	stable@dpdk.org
Subject: [PATCH v7 34/47] net/sxe2: restore PF-only guard in UDP tunnel port
 add
Date: Mon, 31 Aug 2026 10:44:21 +0800
Message-ID: <20260831024421.3231187-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260828074056.2250222-1-liujie5@linkdatatechnology.com>
References: <20260828074056.2250222-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowACXmzmF6pRqNtmjBg--.23054S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr18Aw1xKF1DWr48trW8JFb_yoW8uw4UpF
 4jgrWYvFyaqFsI9w4FvF4kWF1jgr9YgayDC39xWw1rZa4DZ347Aay5tF1Yv3W8CFWfJF1F
 yayagr1fWr4UZ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkE14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
 JVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
 4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
 Yx0E2Ix0cI8IcVAFwI0_Wrv_ZF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbV
 WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lw4CEc2x0rVAK
 j4xxMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
 0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
 0x0EwIxGrwCI42IY6xIIjxv20xvE14v26F1j6w1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
 W8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWxJVW8
 Jr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0pR9NV
 PUUUUU=
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
index 77a31eb8a1..8c60c9cfde 100644
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

