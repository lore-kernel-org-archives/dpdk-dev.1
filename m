Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51A8C61DCD
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Aug 2026 07:40:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C18F40A6E;
	Fri, 28 Aug 2026 09:40:02 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id B26E640DD0
 for <dev@dpdk.org>; Fri, 28 Aug 2026 09:39:51 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowADn6jhDO5FqHdRzBg--.60958S2;
 Fri, 28 Aug 2026 15:39:47 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org
Subject: [PATCH v6 33/45] net/sxe2: restore PF-only guard in udp tunnel port
 add
Date: Fri, 28 Aug 2026 15:39:47 +0800
Message-ID: <20260828073947.2249505-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260828032731.2109423-1-liujie5@linkdatatechnology.com>
References: <20260828032731.2109423-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowADn6jhDO5FqHdRzBg--.60958S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr18Aw1xKF1DWr48trW8JFb_yoW8uw4UpF
 4jgrWYvFyaqFsI9w4FvF4kWF1jgr9YgayDC39xWw1rZa4DZ347Aay5tF1Yv3W8CFWfJF1F
 yayagr1fWr4UZ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkmb7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4
 vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
 FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWrXVW3AwAv7VC2z280aVAFwI0_Cr
 0_Gr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwAKzVCY07xG64k0F24l
 42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
 WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAK
 I48JMIIF0xvE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r
 4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF
 0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUsrgAUUUUU
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

