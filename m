Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD517C624D6
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Sep 2026 01:58:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D8A2642C24;
	Thu,  3 Sep 2026 03:57:53 +0200 (CEST)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by mails.dpdk.org (Postfix) with ESMTP id 1AE34427E3;
 Thu,  3 Sep 2026 03:57:51 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-05 (Coremail) with SMTP id zQCowAA3oz0U1JhqcRxABw--.24482S2;
 Thu, 03 Sep 2026 09:57:40 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>,
	stable@dpdk.org
Subject: [PATCH v10 39/48] net/sxe2: restore Rx queue buffer split fill support
Date: Thu,  3 Sep 2026 09:57:40 +0800
Message-ID: <20260903015740.162350-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260902021650.83354-1-liujie5@linkdatatechnology.com>
References: <20260902021650.83354-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowAA3oz0U1JhqcRxABw--.24482S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJw1ftw4fuF1DZFWDuFyDZFb_yoWrXFyfpF
 1xuF13KaykJrWxK3Z8JFnYgr98Kry8WrW3C393t3WrKFyDKF90qF4DKr18tr4kCa17AFy8
 tasxWF45Gw15AwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

The V4 branch dropped sxe2_rxq_buf_split_fill() and the buffer split
handling in sxe2_rxq_ctxt_cfg_fill(), so the Rx buffer split offload
(RTE_ETH_RX_OFFLOAD_BUFFER_SPLIT) is advertised in device info but
the per-queue context never configures split_en/split_type_mask/
hdr_len, and buffer split packets are not handled correctly.

Restore the sxe2_rxq_buf_split_fill() helper and the buffer split
branch in sxe2_rxq_ctxt_cfg_fill(), matching the V3 implementation.

Fixes: d8e4e075acb4 ("net/sxe2: add probing skeleton")
Cc: stable@dpdk.org
Cc: stephen@networkplumber.org
Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe2/sxe2_cmd_chnl.c | 88 ++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/drivers/net/sxe2/sxe2_cmd_chnl.c b/drivers/net/sxe2/sxe2_cmd_chnl.c
index 85098ac664..7b27cf2e8d 100644
--- a/drivers/net/sxe2/sxe2_cmd_chnl.c
+++ b/drivers/net/sxe2/sxe2_cmd_chnl.c
@@ -195,6 +195,84 @@ int32_t sxe2_drv_vsi_del(struct sxe2_adapter *adapter, struct sxe2_vsi *vsi)
 #define SXE2_RXQ_CTXT_CFG_BUF_LEN_ALIGN  (1 << 7)
 #define SXE2_RX_HDR_SIZE 256
 
+static int32_t sxe2_rxq_buf_split_fill(struct sxe2_rx_queue *rxq,
+				   struct sxe2_drv_rxq_ctxt *ctxt)
+{
+	uint32_t proto_hdr;
+
+	proto_hdr = rxq->rx_seg[0].proto_hdr;
+	if (proto_hdr == RTE_PTYPE_UNKNOWN) {
+		PMD_LOG_ERR(RX, "Buffer split protocol must be configured");
+		return -EINVAL;
+	}
+
+	switch (proto_hdr & RTE_PTYPE_L4_MASK) {
+	case RTE_PTYPE_L4_TCP:
+		ctxt->split_type_mask = SXE2_PTYPE_L4_TCP;
+		goto l_end;
+	case RTE_PTYPE_L4_UDP:
+		ctxt->split_type_mask = SXE2_PTYPE_L4_UDP;
+		goto l_end;
+	case RTE_PTYPE_L4_SCTP:
+		ctxt->split_type_mask = SXE2_PTYPE_L4_SCTP;
+		goto l_end;
+	}
+
+	switch (proto_hdr & RTE_PTYPE_L3_MASK) {
+	case RTE_PTYPE_L3_IPV4_EXT_UNKNOWN:
+		ctxt->split_type_mask = SXE2_PTYPE_L3_IPV4;
+		goto l_end;
+	case RTE_PTYPE_L3_IPV6_EXT_UNKNOWN:
+		ctxt->split_type_mask = SXE2_PTYPE_L3_IPV6;
+		goto l_end;
+	}
+
+	switch (proto_hdr & RTE_PTYPE_L2_MASK) {
+	case RTE_PTYPE_L2_ETHER:
+		ctxt->split_type_mask = SXE2_PTYPE_L2_ETHER;
+		goto l_end;
+	}
+
+	switch (proto_hdr & RTE_PTYPE_INNER_L4_MASK) {
+	case RTE_PTYPE_INNER_L4_TCP:
+		ctxt->split_type_mask = SXE2_PTYPE_INNER_L4_TCP;
+		goto l_end;
+	case RTE_PTYPE_INNER_L4_UDP:
+		ctxt->split_type_mask = SXE2_PTYPE_INNER_L4_UDP;
+		goto l_end;
+	case RTE_PTYPE_INNER_L4_SCTP:
+		ctxt->split_type_mask = SXE2_PTYPE_INNER_L4_SCTP;
+		goto l_end;
+	}
+
+	switch (proto_hdr & RTE_PTYPE_INNER_L3_MASK) {
+	case RTE_PTYPE_INNER_L3_IPV4_EXT_UNKNOWN:
+		ctxt->split_type_mask = SXE2_PTYPE_INNER_L3_IPV4;
+		goto l_end;
+	case RTE_PTYPE_INNER_L3_IPV6_EXT_UNKNOWN:
+		ctxt->split_type_mask = SXE2_PTYPE_INNER_L3_IPV6;
+		goto l_end;
+	}
+
+	switch (proto_hdr & RTE_PTYPE_INNER_L2_MASK) {
+	case RTE_PTYPE_INNER_L2_ETHER:
+		ctxt->split_type_mask = SXE2_PTYPE_INNER_L2_ETHER;
+		goto l_end;
+	}
+
+	switch (proto_hdr & RTE_PTYPE_TUNNEL_MASK) {
+	case RTE_PTYPE_TUNNEL_GRENAT:
+		ctxt->split_type_mask = SXE2_PTYPE_TUNNEL_GRENAT;
+		goto l_end;
+	}
+
+	PMD_LOG_ERR(RX, "Buffer split protocol is not supported");
+	return -ENOTSUP;
+l_end:
+	ctxt->hdr_len = SXE2_RX_HDR_SIZE;
+	return 0;
+}
+
 static int32_t sxe2_rxq_ctxt_cfg_fill(struct sxe2_rx_queue *rxq,
 		struct sxe2_drv_rxq_cfg_req *req, uint16_t rxq_cnt)
 {
@@ -228,7 +306,17 @@ static int32_t sxe2_rxq_ctxt_cfg_fill(struct sxe2_rx_queue *rxq,
 	else
 		ctxt->keep_crc_en = 0;
 
+	if (rxq->offloads & RTE_ETH_RX_OFFLOAD_BUFFER_SPLIT) {
+		ret = sxe2_rxq_buf_split_fill(rxq, ctxt);
+		if (ret)
+			goto l_end;
+		ctxt->split_en = 1;
+	} else {
+		ctxt->split_en = 0;
+	}
+
 	ctxt->desc_size = sizeof(union sxe2_rx_desc);
+l_end:
 	return ret;
 }
 
-- 
2.52.0

