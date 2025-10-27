Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06EB3CCF9E9
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Oct 2025 03:17:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6CFAA40A6C;
	Mon, 27 Oct 2025 04:16:28 +0100 (CET)
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
 by mails.dpdk.org (Postfix) with ESMTP id 7BBC0406BC;
 Mon, 27 Oct 2025 04:16:21 +0100 (CET)
X-QQ-mid: esmtpsz16t1761534978t95ba9590
X-QQ-Originating-IP: IQs6zFJ2UrmjJ57+n8bLlXPXdYG/74mpdSOQLQm8aJ8=
Received: from lap-jiawenwu.trustnetic.com ( [36.20.107.118])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 27 Oct 2025 11:16:17 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14130782444694741358
EX-QQ-RecipientCnt: 4
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: dev@dpdk.org
Cc: zaiyuwang@trustnetic.com, Jiawen Wu <jiawenwu@trustnetic.com>,
 stable@dpdk.org
Subject: [PATCH 15/19] net/txgbe: fix FDIR input mask
Date: Mon, 27 Oct 2025 11:15:38 +0800
Message-Id: <20251027031542.10512-16-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20251027031542.10512-1-jiawenwu@trustnetic.com>
References: <20251027031542.10512-1-jiawenwu@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MYcyYH/A/+tCCy0wYplyp+hm+EpRrI5yfATfO6fVbKQzSVO/KwBjEMSP
 /D/FkAdNKgUWkbY7fcwCKzD0HGrwzWQb4pAdMJqXt+cVpDgzikky8G/ujIB2Xnd+DdjzJbj
 SvtyVDOoyNvp/fB/ZnXuCjimFB2fpa6RTjmPbthcmRY8mP/htNuCFlkwejaBtoauinf4n99
 p2WntVXIlmjc+z6fuUMk+zzXqwZqJsY9fQoaSd2k12ffw0EwIN40RrqdhsnFmTmmaaTL7PL
 ogEejyPMTIbwgFxixqEZ1QJIIRLgrHYW3gSXIq+Jc9nTRwFiPdj+0smSYwSI3gXehq6Fr8P
 jMfCZzOiV5vbKfvN7ld9G0l/w9EkuCOJGjfBvBX0lSE8c4TulWQ0MiiGnQggk5J3xlm/KTk
 CBQcs5C4nJ7j89yBk3lZaaxPBPMMexttVqUgXDLruqDVLq49ETyFdGyq2vEW7xIVB0+bNbq
 aFbiMlUik+sr8ybCUXy2RDsdYSGjuupSIRGnPrnneR3AprZy9qiXx26gp1um87PDvGU7Xbp
 LaDxeFhr59LU6ONNKCkGiPx9RsuSKSWvUTpiM4MVVQGi97dzG8DF88f1YMQYcecVu+e4MQc
 StrEzXdH3o1/Xn6yUwZms51vAyANNzFKZ+nFY0Rk8nJWITHjyPlaj7xquldW6C0+bSNCaPQ
 TReW3ool2vNsKk8vzq9OdtVuvIEuEDSqG9RrtanFxknksnz96CVLQebA4ldSSlEw2ftK2R2
 YVi5jtL1Q5zq0kZIfHjbg1GC9VOZE74plK+Hszqs64e0ytXnp3JN54uQ+X7RlHm+TMWWGuZ
 pmX1L7prk0XDvQebxM1MAh73z6tPUMmPi/5NGf8uRQ+rxzrUYVqkWPNIL/C/gGRoLggseQm
 FIjXfyk3GN+3efUGzS8M2fQP6iVswUhag/uu5Oyr6Vj9evh/9EQ8+ws5NfidkxZKdytHEHr
 eCJlvHvXPjILlwdgdAVNFRTQ2EOa53CnWwJTgnsiTIEcm/CmoopEK0AiMdvJ4wsZLd1kECr
 +DcZNZJHbb2uHnkCS80Yc5KxCCm91u2LYfdB5XgzwwWxUfR3FO
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0
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

Fix FDIR mask settings to comply with the hardware configuration. And
mask out the spec field instead of manually setting it to 0.

There are some requirements of mask in hardware:
1) IPv4 mask should be little-endian.
2) Ipv6 source address mask has only 16 bits, one bit of mask
   corresponds to one byte of spec.
3) IPv6 dest address is only supported to perfect match the low 8 bits,
   so it is not taken into account for support in the driver.

Fixes: ea230dda16ad ("net/txgbe: configure flow director filter")
Cc: stable@dpdk.org
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/txgbe/txgbe_fdir.c | 49 +++++++++++++++++++++++++++++-----
 drivers/net/txgbe/txgbe_flow.c |  8 ++----
 2 files changed, 45 insertions(+), 12 deletions(-)

diff --git a/drivers/net/txgbe/txgbe_fdir.c b/drivers/net/txgbe/txgbe_fdir.c
index 8d181db33f..6b83a7379d 100644
--- a/drivers/net/txgbe/txgbe_fdir.c
+++ b/drivers/net/txgbe/txgbe_fdir.c
@@ -165,6 +165,15 @@ configure_fdir_flags(const struct rte_eth_fdir_conf *conf,
 	return 0;
 }
 
+static inline uint16_t
+txgbe_reverse_fdir_bitmasks(uint16_t mask)
+{
+	mask = ((mask & 0x5555) << 1) | ((mask & 0xAAAA) >> 1);
+	mask = ((mask & 0x3333) << 2) | ((mask & 0xCCCC) >> 2);
+	mask = ((mask & 0x0F0F) << 4) | ((mask & 0xF0F0) >> 4);
+	return ((mask & 0x00FF) << 8) | ((mask & 0xFF00) >> 8);
+}
+
 int
 txgbe_fdir_set_input_mask(struct rte_eth_dev *dev)
 {
@@ -206,15 +215,15 @@ txgbe_fdir_set_input_mask(struct rte_eth_dev *dev)
 	wr32(hw, TXGBE_FDIRUDPMSK, ~fdirtcpm);
 	wr32(hw, TXGBE_FDIRSCTPMSK, ~fdirtcpm);
 
-	/* Store source and destination IPv4 masks (big-endian) */
-	wr32(hw, TXGBE_FDIRSIP4MSK, ~info->mask.src_ipv4_mask);
-	wr32(hw, TXGBE_FDIRDIP4MSK, ~info->mask.dst_ipv4_mask);
+	/* Store source and destination IPv4 masks (little-endian) */
+	wr32(hw, TXGBE_FDIRSIP4MSK, rte_be_to_cpu_32(~info->mask.src_ipv4_mask));
+	wr32(hw, TXGBE_FDIRDIP4MSK, rte_be_to_cpu_32(~info->mask.dst_ipv4_mask));
 
 	/*
 	 * Store source and destination IPv6 masks (bit reversed)
 	 */
-	fdiripv6m = TXGBE_FDIRIP6MSK_DST(info->mask.dst_ipv6_mask) |
-		    TXGBE_FDIRIP6MSK_SRC(info->mask.src_ipv6_mask);
+	fdiripv6m = txgbe_reverse_fdir_bitmasks(info->mask.dst_ipv6_mask) << 16;
+	fdiripv6m |= txgbe_reverse_fdir_bitmasks(info->mask.src_ipv6_mask);
 	wr32(hw, TXGBE_FDIRIP6MSK, ~fdiripv6m);
 
 	return 0;
@@ -636,8 +645,14 @@ fdir_write_perfect_filter(struct txgbe_hw *hw,
 	fdircmd |= TXGBE_FDIRPICMD_QP(queue);
 	fdircmd |= TXGBE_FDIRPICMD_POOL(input->vm_pool);
 
-	if (input->flow_type & TXGBE_ATR_L3TYPE_IPV6)
+	if (input->flow_type & TXGBE_ATR_L3TYPE_IPV6) {
+		/* use SIP4 to store LS Dword of the Source iPv6 address */
+		wr32(hw, TXGBE_FDIRPISIP4, be_to_le32(input->src_ip[3]));
+		wr32(hw, TXGBE_FDIRPISIP6(0), be_to_le32(input->src_ip[2]));
+		wr32(hw, TXGBE_FDIRPISIP6(1), be_to_le32(input->src_ip[1]));
+		wr32(hw, TXGBE_FDIRPISIP6(2), be_to_le32(input->src_ip[0]));
 		fdircmd |= TXGBE_FDIRPICMD_IP6;
+	}
 	wr32(hw, TXGBE_FDIRPICMD, fdircmd);
 
 	PMD_DRV_LOG(DEBUG, "Rx Queue=%x hash=%x", queue, fdirhash);
@@ -783,6 +798,26 @@ txgbe_remove_fdir_filter(struct txgbe_hw_fdir_info *fdir_info,
 	return 0;
 }
 
+static void
+txgbe_fdir_mask_input(struct txgbe_hw_fdir_mask *mask,
+		      struct txgbe_atr_input *input)
+{
+	int i;
+
+	if (input->flow_type & TXGBE_ATR_L3TYPE_IPV6) {
+		for (i = 0; i < 16; i++) {
+			if (!(mask->src_ipv6_mask & (1 << i)))
+				input->src_ip[i / 4] &= ~(0xFF << ((i % 4) * 8));
+		}
+	} else {
+		input->src_ip[0] &= mask->src_ipv4_mask;
+		input->dst_ip[0] &= mask->dst_ipv4_mask;
+	}
+
+	input->src_port &= mask->src_port_mask;
+	input->dst_port &= mask->dst_port_mask;
+}
+
 int
 txgbe_fdir_filter_program(struct rte_eth_dev *dev,
 			  struct txgbe_fdir_rule *rule,
@@ -805,6 +840,8 @@ txgbe_fdir_filter_program(struct rte_eth_dev *dev,
 	if (fdir_mode >= RTE_FDIR_MODE_PERFECT)
 		is_perfect = TRUE;
 
+	txgbe_fdir_mask_input(&info->mask, &rule->input);
+
 	if (is_perfect) {
 		fdirhash = atr_compute_perfect_hash(&rule->input,
 				TXGBE_DEV_FDIR_CONF(dev)->pballoc);
diff --git a/drivers/net/txgbe/txgbe_flow.c b/drivers/net/txgbe/txgbe_flow.c
index 095c84823f..d3113b6fc8 100644
--- a/drivers/net/txgbe/txgbe_flow.c
+++ b/drivers/net/txgbe/txgbe_flow.c
@@ -1849,9 +1849,7 @@ txgbe_parse_fdir_filter_normal(struct rte_eth_dev *dev __rte_unused,
 
 			/* check dst addr mask */
 			for (j = 0; j < 16; j++) {
-				if (ipv6_mask->hdr.dst_addr.a[j] == UINT8_MAX) {
-					rule->mask.dst_ipv6_mask |= 1 << j;
-				} else if (ipv6_mask->hdr.dst_addr.a[j] != 0) {
+				if (ipv6_mask->hdr.dst_addr.a[j] != 0) {
 					memset(rule, 0, sizeof(struct txgbe_fdir_rule));
 					rte_flow_error_set(error, EINVAL,
 						RTE_FLOW_ERROR_TYPE_ITEM,
@@ -2612,9 +2610,7 @@ txgbe_parse_fdir_filter_tunnel(const struct rte_flow_attr *attr,
 
 			/* check dst addr mask */
 			for (j = 0; j < 16; j++) {
-				if (ipv6_mask->hdr.dst_addr.a[j] == UINT8_MAX) {
-					rule->mask.dst_ipv6_mask |= 1 << j;
-				} else if (ipv6_mask->hdr.dst_addr.a[j] != 0) {
+				if (ipv6_mask->hdr.dst_addr.a[j] != 0) {
 					memset(rule, 0, sizeof(struct txgbe_fdir_rule));
 					rte_flow_error_set(error, EINVAL,
 							   RTE_FLOW_ERROR_TYPE_ITEM,
-- 
2.48.1

