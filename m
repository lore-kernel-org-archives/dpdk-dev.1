Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5FF5C61DC2
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Aug 2026 08:57:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B733040A81;
	Wed, 26 Aug 2026 10:57:38 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id 10C0B40A81
 for <dev@dpdk.org>; Wed, 26 Aug 2026 10:57:36 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowAB3fjx9qo5qsOZMBg--.39426S2;
 Wed, 26 Aug 2026 16:57:33 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org
Subject: [PATCH v3 40/51] net/sxe2: restore Rx queue buffer split fill support
Date: Wed, 26 Aug 2026 16:57:32 +0800
Message-ID: <20260826085732.992380-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260818021518.2922515-14-liujie5@linkdatatechnology.com>
References: <20260818021518.2922515-14-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowAB3fjx9qo5qsOZMBg--.39426S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJF1DAw13Zw4kXFWrKF1rJFb_yoWrur4fpF
 13ur13Kas7JrWxK3W5JanYq3s0krW8Wry2k393trn8KF1ktF90qF4qyr1xtr4kCa1UAry0
 qasxWFs0kw13AwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkSb7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4
 vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
 FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWrXVW3AwAv7VC2z280aVAFwI0_Gr
 0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4kE6xkIj40Ew7xC0wCF
 04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
 18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vI
 r41lIxAIcVC0I7IYx2IY67AKxVW7JVWDJwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr
 1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY
 6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU3NB_UUUUU
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

Cc: stable@dpdk.org
Cc: stephen@networkplumber.org
Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe2/sxe2_cmd_chnl.c | 106 +++++++++++++++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/drivers/net/sxe2/sxe2_cmd_chnl.c b/drivers/net/sxe2/sxe2_cmd_chnl.c
index b17d80d917..5102890107 100644
--- a/drivers/net/sxe2/sxe2_cmd_chnl.c
+++ b/drivers/net/sxe2/sxe2_cmd_chnl.c
@@ -194,6 +194,102 @@ int32_t sxe2_drv_vsi_del(struct sxe2_adapter *adapter, struct sxe2_vsi *vsi)
 #define SXE2_RXQ_CTXT_CFG_BUF_LEN_ALIGN  (1 << 7)
 #define SXE2_RX_HDR_SIZE 256
 
+static int32_t sxe2_rxq_buf_split_fill(struct sxe2_rx_queue *rxq,
+				   struct sxe2_drv_rxq_ctxt *ctxt)
+{
+	int32_t ret = 0;
+	uint32_t proto_hdr;
+
+	if (rxq->offloads & RTE_ETH_RX_OFFLOAD_BUFFER_SPLIT) {
+		proto_hdr = rxq->rx_seg[0].proto_hdr;
+		if (proto_hdr == RTE_PTYPE_UNKNOWN) {
+			PMD_LOG_ERR(RX, "Buffer split protocol must be configured");
+			ret = -1;
+			goto l_end;
+		}
+
+		switch (proto_hdr & RTE_PTYPE_L4_MASK) {
+		case RTE_PTYPE_L4_TCP:
+			ctxt->split_type_mask = SXE2_PTYPE_L4_TCP;
+			ctxt->hdr_len = SXE2_RX_HDR_SIZE;
+			goto l_end;
+		case RTE_PTYPE_L4_UDP:
+			ctxt->split_type_mask = SXE2_PTYPE_L4_UDP;
+			ctxt->hdr_len = SXE2_RX_HDR_SIZE;
+			goto l_end;
+		case RTE_PTYPE_L4_SCTP:
+			ctxt->split_type_mask = SXE2_PTYPE_L4_SCTP;
+			ctxt->hdr_len = SXE2_RX_HDR_SIZE;
+			goto l_end;
+		}
+
+		switch (proto_hdr & RTE_PTYPE_L3_MASK) {
+		case RTE_PTYPE_L3_IPV4_EXT_UNKNOWN:
+			ctxt->split_type_mask = SXE2_PTYPE_L3_IPV4;
+			ctxt->hdr_len = SXE2_RX_HDR_SIZE;
+			goto l_end;
+		case RTE_PTYPE_L3_IPV6_EXT_UNKNOWN:
+			ctxt->split_type_mask = SXE2_PTYPE_L3_IPV6;
+			ctxt->hdr_len = SXE2_RX_HDR_SIZE;
+			goto l_end;
+		}
+
+		switch (proto_hdr & RTE_PTYPE_L2_MASK) {
+		case RTE_PTYPE_L2_ETHER:
+			ctxt->split_type_mask = SXE2_PTYPE_L2_ETHER;
+			ctxt->hdr_len = SXE2_RX_HDR_SIZE;
+			goto l_end;
+		}
+
+		switch (proto_hdr & RTE_PTYPE_INNER_L4_MASK) {
+		case RTE_PTYPE_INNER_L4_TCP:
+			ctxt->split_type_mask = SXE2_PTYPE_INNER_L4_TCP;
+			ctxt->hdr_len = SXE2_RX_HDR_SIZE;
+			goto l_end;
+		case RTE_PTYPE_INNER_L4_UDP:
+			ctxt->split_type_mask = SXE2_PTYPE_INNER_L4_UDP;
+			ctxt->hdr_len = SXE2_RX_HDR_SIZE;
+			goto l_end;
+		case RTE_PTYPE_INNER_L4_SCTP:
+			ctxt->split_type_mask = SXE2_PTYPE_INNER_L4_SCTP;
+			ctxt->hdr_len = SXE2_RX_HDR_SIZE;
+			goto l_end;
+		}
+
+		switch (proto_hdr & RTE_PTYPE_INNER_L3_MASK) {
+		case RTE_PTYPE_INNER_L3_IPV4_EXT_UNKNOWN:
+			ctxt->split_type_mask = SXE2_PTYPE_INNER_L3_IPV4;
+			ctxt->hdr_len = SXE2_RX_HDR_SIZE;
+			goto l_end;
+		case RTE_PTYPE_INNER_L3_IPV6_EXT_UNKNOWN:
+			ctxt->split_type_mask = SXE2_PTYPE_INNER_L3_IPV6;
+			ctxt->hdr_len = SXE2_RX_HDR_SIZE;
+			goto l_end;
+		}
+
+		switch (proto_hdr & RTE_PTYPE_INNER_L2_MASK) {
+		case RTE_PTYPE_INNER_L2_ETHER:
+			ctxt->split_type_mask = SXE2_PTYPE_INNER_L2_ETHER;
+			ctxt->hdr_len = SXE2_RX_HDR_SIZE;
+			goto l_end;
+		}
+
+		switch (proto_hdr & RTE_PTYPE_TUNNEL_MASK) {
+		case RTE_PTYPE_TUNNEL_GRENAT:
+			ctxt->split_type_mask = SXE2_PTYPE_TUNNEL_GRENAT;
+			ctxt->hdr_len = SXE2_RX_HDR_SIZE;
+			goto l_end;
+		}
+		PMD_LOG_ERR(RX, "Buffer split protocol is not supported");
+		ret = -1;
+	} else {
+		ctxt->hdr_len = 0;
+		ctxt->split_type_mask = 0;
+	}
+l_end:
+	return ret;
+}
+
 static int32_t sxe2_rxq_ctxt_cfg_fill(struct sxe2_rx_queue *rxq,
 		struct sxe2_drv_rxq_cfg_req *req, uint16_t rxq_cnt)
 {
@@ -227,7 +323,17 @@ static int32_t sxe2_rxq_ctxt_cfg_fill(struct sxe2_rx_queue *rxq,
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

