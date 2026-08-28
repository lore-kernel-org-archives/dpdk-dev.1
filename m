Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF30C61DC4
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Aug 2026 03:25:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4F95940DCE;
	Fri, 28 Aug 2026 05:25:50 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id E345D40A7A
 for <dev@dpdk.org>; Fri, 28 Aug 2026 05:25:24 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowACnc0Gj_5Bq2yVwBg--.60831S2;
 Fri, 28 Aug 2026 11:25:23 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org
Subject: [PATCH v5 23/45] net/sxe2: simplify switchdev representor matching
Date: Fri, 28 Aug 2026 11:25:22 +0800
Message-ID: <20260828032522.2107370-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260827024035.1432256-1-liujie5@linkdatatechnology.com>
References: <20260827024035.1432256-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowACnc0Gj_5Bq2yVwBg--.60831S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCrW5ZryDJrW7Cr45tw1rXrb_yoWrZF1kpF
 48Ja43AFW5JF42g39xCan5uFyYkr4xK348Kr9Iv3WfCayUAr98AFWUK34Fvrn8C3WxXryf
 twsrZF1Uua4kWa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkIb7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwV
 C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
 Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVW8JV
 WxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lw4CEc2x0rVAKj4xxMxAI
 w28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr
 4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxG
 rwCI42IY6xIIjxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJw
 CI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2
 z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0wa93UUUUU==
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

sxe2_switchdev_repr_match() encodes the kernel representor ID and
compares it against each requested port, which is fragile. Match the
PF number and VF ID directly against the switchdev representor info
instead, and drop the sxe2_switchdev_repr_id_encode_get() helper.

Fixes: 635084db5d57 ("net/sxe2: support VF representors")
Cc: stable@dpdk.org
Cc: stephen@networkplumber.org
Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe2/sxe2_ethdev.c | 72 +++++++++++++++++-----------------
 drivers/net/sxe2/sxe2_ethdev.h |  3 --
 2 files changed, 37 insertions(+), 38 deletions(-)

diff --git a/drivers/net/sxe2/sxe2_ethdev.c b/drivers/net/sxe2/sxe2_ethdev.c
index 5bce710b29..08986e384f 100644
--- a/drivers/net/sxe2/sxe2_ethdev.c
+++ b/drivers/net/sxe2/sxe2_ethdev.c
@@ -2149,42 +2149,25 @@ static int32_t sxe2_fw_version_string_get(struct rte_eth_dev *dev, char *fw_vers
 	return ret;
 }
 
-static uint16_t sxe2_switchdev_repr_id_encode_get(struct sxe2_switchdev_info *switchdev_info)
-{
-	enum rte_eth_representor_type type;
-	uint16_t repr = switchdev_info->vf_num;
-	uint32_t pf = switchdev_info->pf_num;
-
-	switch (switchdev_info->port_name_type) {
-	case SXE2_PHYS_PORT_NAME_TYPE_UPLINK:
-		if (!switchdev_info->representor)
-			return UINT16_MAX;
-		type = RTE_ETH_REPRESENTOR_PF;
-		pf = switchdev_info->mpesw_owner;
-		break;
-	case SXE2_PHYS_PORT_NAME_TYPE_PFVF:
-	default:
-		type = RTE_ETH_REPRESENTOR_VF;
-		break;
-	}
-
-	return SXE2_REPRESENTOR_ID(pf, type, repr);
-}
-
 static bool sxe2_switchdev_repr_match(struct sxe2_adapter *adapter,
 				   struct rte_eth_devargs *req_eth_da)
 {
-	uint32_t port_idx = 0;
-	uint32_t repr_idx;
-	uint16_t kernel_repr_id = sxe2_switchdev_repr_id_encode_get(&adapter->switchdev_info);
-	uint16_t repr_id;
+	uint16_t port_idx;
+	uint16_t repr_idx;
+	uint16_t vf_id;
+	uint16_t i;
 
 	switch (req_eth_da->type) {
 	case RTE_ETH_REPRESENTOR_PF:
+		if (adapter->switchdev_info.port_name_type !=
+			SXE2_PHYS_PORT_NAME_TYPE_UPLINK) {
+			rte_errno = EBUSY;
+			return false;
+		}
 		break;
 	case RTE_ETH_REPRESENTOR_VF:
 		if (adapter->switchdev_info.port_name_type !=
-		SXE2_PHYS_PORT_NAME_TYPE_PFVF) {
+			SXE2_PHYS_PORT_NAME_TYPE_PFVF) {
 			rte_errno = EBUSY;
 			return false;
 		}
@@ -2197,15 +2180,34 @@ static bool sxe2_switchdev_repr_match(struct sxe2_adapter *adapter,
 		return false;
 	}
 
+	if (req_eth_da->nb_ports > 0) {
+		for (port_idx = 0; port_idx < req_eth_da->nb_ports; ++port_idx) {
+			if (adapter->switchdev_info.pf_num == req_eth_da->ports[port_idx])
+				break;
+		}
+		if (port_idx == req_eth_da->nb_ports) {
+			PMD_DEV_LOG_DEBUG(adapter, DRV, "switchdev pf %u not match req pf",
+				adapter->switchdev_info.pf_num);
+			rte_errno = EBUSY;
+			return false;
+		}
+	}
+
 	for (repr_idx = 0; repr_idx < req_eth_da->nb_representor_ports; ++repr_idx) {
-		repr_id = SXE2_REPRESENTOR_ID(req_eth_da->ports[port_idx],
-					      req_eth_da->type,
-					      req_eth_da->representor_ports[repr_idx]);
-		if (repr_id == kernel_repr_id)
-			return true;
-	}
-	rte_errno = EBUSY;
-	return false;
+		for (i = 0; i < adapter->repr_ctxt.nb_vf; ++i) {
+			vf_id = rte_le_to_cpu_16(adapter->repr_ctxt.repr_vf_id[i].func_id);
+			if (vf_id == req_eth_da->representor_ports[repr_idx])
+				break;
+		}
+		if (i == adapter->repr_ctxt.nb_vf) {
+			PMD_DEV_LOG_DEBUG(adapter, DRV, "switchdev vf %u not match req vf(cnt:%u)",
+				req_eth_da->representor_ports[repr_idx], adapter->repr_ctxt.nb_vf);
+			rte_errno = EBUSY;
+			return false;
+		}
+	}
+
+	return true;
 }
 
 static int32_t sxe2_eth_pmd_probe_pf(struct sxe2_common_device *cdev,
diff --git a/drivers/net/sxe2/sxe2_ethdev.h b/drivers/net/sxe2/sxe2_ethdev.h
index f2557b28c3..e818578319 100644
--- a/drivers/net/sxe2/sxe2_ethdev.h
+++ b/drivers/net/sxe2/sxe2_ethdev.h
@@ -65,9 +65,6 @@ enum sxe2_fnav_tunnel_flag_type {
 #define upper_32_bits(n) ((uint32_t)(((n) >> 16) >> 16))
 #define lower_32_bits(n) ((uint32_t)((n) & 0xffffffff))
 
-#define SXE2_REPRESENTOR_ID(pf, type, repr) \
-		(((pf) << 14) + ((type) << 12) + ((repr) & 0xfff))
-
 #define SXE2_I2C_EEPROM_DEV_ADDR	0xA0
 #define SXE2_I2C_EEPROM_DEV_ADDR2	0xA2
 #define SXE2_MODULE_TYPE_SFP		0x03
-- 
2.52.0

