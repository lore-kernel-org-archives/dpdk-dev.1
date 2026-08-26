Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C76B7C5DF97
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Aug 2026 08:59:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B8ECC40E27;
	Wed, 26 Aug 2026 10:58:42 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id B389B40E01
 for <dev@dpdk.org>; Wed, 26 Aug 2026 10:58:38 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowADn8T+8qo5qbupMBg--.4714S2;
 Wed, 26 Aug 2026 16:58:36 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org
Subject: [PATCH v3 51/51] net/sxe2: simplify Rx queue buffer split fill helper
Date: Wed, 26 Aug 2026 16:58:36 +0800
Message-ID: <20260826085836.993490-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260818021518.2922515-14-liujie5@linkdatatechnology.com>
References: <20260818021518.2922515-14-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowADn8T+8qo5qbupMBg--.4714S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtrWDJFy7uw4xKr47WFWDXFb_yoW7tFW3pr
 y7uF9xGasrJr4xtFn8JFnYg34DKrW8WrW3C393tF15KryUKr15tFWqyr18tr4kGa15ArW0
 qasxWFs0kwn8AwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkGb7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjc
 xK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
 64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Wrv_ZF1lYx0Ex4A2jsIE14v26F
 4j6r4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lw4CEc2x0rVAKj4xx
 MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
 0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0E
 wIxGrwCI42IY6xIIjxv20xvE14v26F1j6w1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr
 0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWxJVW8Jr1l
 IxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07j3Xo7UUU
 UU=
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

sxe2_rxq_buf_split_fill() re-tests the RTE_ETH_RX_OFFLOAD_BUFFER_SPLIT
offload flag even though the caller already guarantees it, leaving the
else branch dead. It also returns -1 on failure instead of a standard
errno.

Drop the redundant flag test and dead else branch, set hdr_len once
after the switch chain, and return -EINVAL for an unconfigured split
protocol and -ENOTSUP for an unsupported one.

Cc: stable@dpdk.org
Cc: stephen@networkplumber.org
Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe2/sxe2_cmd_chnl.c | 142 ++++++++++++++-----------------
 1 file changed, 62 insertions(+), 80 deletions(-)

diff --git a/drivers/net/sxe2/sxe2_cmd_chnl.c b/drivers/net/sxe2/sxe2_cmd_chnl.c
index b4f8b337b5..9bd6e3355f 100644
--- a/drivers/net/sxe2/sxe2_cmd_chnl.c
+++ b/drivers/net/sxe2/sxe2_cmd_chnl.c
@@ -197,97 +197,79 @@ int32_t sxe2_drv_vsi_del(struct sxe2_adapter *adapter, struct sxe2_vsi *vsi)
 static int32_t sxe2_rxq_buf_split_fill(struct sxe2_rx_queue *rxq,
 				   struct sxe2_drv_rxq_ctxt *ctxt)
 {
-	int32_t ret = 0;
 	uint32_t proto_hdr;
 
-	if (rxq->offloads & RTE_ETH_RX_OFFLOAD_BUFFER_SPLIT) {
-		proto_hdr = rxq->rx_seg[0].proto_hdr;
-		if (proto_hdr == RTE_PTYPE_UNKNOWN) {
-			PMD_LOG_ERR(RX, "Buffer split protocol must be configured");
-			ret = -1;
-			goto l_end;
-		}
+	proto_hdr = rxq->rx_seg[0].proto_hdr;
+	if (proto_hdr == RTE_PTYPE_UNKNOWN) {
+		PMD_LOG_ERR(RX, "Buffer split protocol must be configured");
+		return -EINVAL;
+	}
 
-		switch (proto_hdr & RTE_PTYPE_L4_MASK) {
-		case RTE_PTYPE_L4_TCP:
-			ctxt->split_type_mask = SXE2_PTYPE_L4_TCP;
-			ctxt->hdr_len = SXE2_RX_HDR_SIZE;
-			goto l_end;
-		case RTE_PTYPE_L4_UDP:
-			ctxt->split_type_mask = SXE2_PTYPE_L4_UDP;
-			ctxt->hdr_len = SXE2_RX_HDR_SIZE;
-			goto l_end;
-		case RTE_PTYPE_L4_SCTP:
-			ctxt->split_type_mask = SXE2_PTYPE_L4_SCTP;
-			ctxt->hdr_len = SXE2_RX_HDR_SIZE;
-			goto l_end;
-		}
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
 
-		switch (proto_hdr & RTE_PTYPE_L3_MASK) {
-		case RTE_PTYPE_L3_IPV4_EXT_UNKNOWN:
-			ctxt->split_type_mask = SXE2_PTYPE_L3_IPV4;
-			ctxt->hdr_len = SXE2_RX_HDR_SIZE;
-			goto l_end;
-		case RTE_PTYPE_L3_IPV6_EXT_UNKNOWN:
-			ctxt->split_type_mask = SXE2_PTYPE_L3_IPV6;
-			ctxt->hdr_len = SXE2_RX_HDR_SIZE;
-			goto l_end;
-		}
+	switch (proto_hdr & RTE_PTYPE_L3_MASK) {
+	case RTE_PTYPE_L3_IPV4_EXT_UNKNOWN:
+		ctxt->split_type_mask = SXE2_PTYPE_L3_IPV4;
+		goto l_end;
+	case RTE_PTYPE_L3_IPV6_EXT_UNKNOWN:
+		ctxt->split_type_mask = SXE2_PTYPE_L3_IPV6;
+		goto l_end;
+	}
 
-		switch (proto_hdr & RTE_PTYPE_L2_MASK) {
-		case RTE_PTYPE_L2_ETHER:
-			ctxt->split_type_mask = SXE2_PTYPE_L2_ETHER;
-			ctxt->hdr_len = SXE2_RX_HDR_SIZE;
-			goto l_end;
-		}
+	switch (proto_hdr & RTE_PTYPE_L2_MASK) {
+	case RTE_PTYPE_L2_ETHER:
+		ctxt->split_type_mask = SXE2_PTYPE_L2_ETHER;
+		goto l_end;
+	}
 
-		switch (proto_hdr & RTE_PTYPE_INNER_L4_MASK) {
-		case RTE_PTYPE_INNER_L4_TCP:
-			ctxt->split_type_mask = SXE2_PTYPE_INNER_L4_TCP;
-			ctxt->hdr_len = SXE2_RX_HDR_SIZE;
-			goto l_end;
-		case RTE_PTYPE_INNER_L4_UDP:
-			ctxt->split_type_mask = SXE2_PTYPE_INNER_L4_UDP;
-			ctxt->hdr_len = SXE2_RX_HDR_SIZE;
-			goto l_end;
-		case RTE_PTYPE_INNER_L4_SCTP:
-			ctxt->split_type_mask = SXE2_PTYPE_INNER_L4_SCTP;
-			ctxt->hdr_len = SXE2_RX_HDR_SIZE;
-			goto l_end;
-		}
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
 
-		switch (proto_hdr & RTE_PTYPE_INNER_L3_MASK) {
-		case RTE_PTYPE_INNER_L3_IPV4_EXT_UNKNOWN:
-			ctxt->split_type_mask = SXE2_PTYPE_INNER_L3_IPV4;
-			ctxt->hdr_len = SXE2_RX_HDR_SIZE;
-			goto l_end;
-		case RTE_PTYPE_INNER_L3_IPV6_EXT_UNKNOWN:
-			ctxt->split_type_mask = SXE2_PTYPE_INNER_L3_IPV6;
-			ctxt->hdr_len = SXE2_RX_HDR_SIZE;
-			goto l_end;
-		}
+	switch (proto_hdr & RTE_PTYPE_INNER_L3_MASK) {
+	case RTE_PTYPE_INNER_L3_IPV4_EXT_UNKNOWN:
+		ctxt->split_type_mask = SXE2_PTYPE_INNER_L3_IPV4;
+		goto l_end;
+	case RTE_PTYPE_INNER_L3_IPV6_EXT_UNKNOWN:
+		ctxt->split_type_mask = SXE2_PTYPE_INNER_L3_IPV6;
+		goto l_end;
+	}
 
-		switch (proto_hdr & RTE_PTYPE_INNER_L2_MASK) {
-		case RTE_PTYPE_INNER_L2_ETHER:
-			ctxt->split_type_mask = SXE2_PTYPE_INNER_L2_ETHER;
-			ctxt->hdr_len = SXE2_RX_HDR_SIZE;
-			goto l_end;
-		}
+	switch (proto_hdr & RTE_PTYPE_INNER_L2_MASK) {
+	case RTE_PTYPE_INNER_L2_ETHER:
+		ctxt->split_type_mask = SXE2_PTYPE_INNER_L2_ETHER;
+		goto l_end;
+	}
 
-		switch (proto_hdr & RTE_PTYPE_TUNNEL_MASK) {
-		case RTE_PTYPE_TUNNEL_GRENAT:
-			ctxt->split_type_mask = SXE2_PTYPE_TUNNEL_GRENAT;
-			ctxt->hdr_len = SXE2_RX_HDR_SIZE;
-			goto l_end;
-		}
-		PMD_LOG_ERR(RX, "Buffer split protocol is not supported");
-		ret = -1;
-	} else {
-		ctxt->hdr_len = 0;
-		ctxt->split_type_mask = 0;
+	switch (proto_hdr & RTE_PTYPE_TUNNEL_MASK) {
+	case RTE_PTYPE_TUNNEL_GRENAT:
+		ctxt->split_type_mask = SXE2_PTYPE_TUNNEL_GRENAT;
+		goto l_end;
 	}
+
+	PMD_LOG_ERR(RX, "Buffer split protocol is not supported");
+	return -ENOTSUP;
 l_end:
-	return ret;
+	ctxt->hdr_len = SXE2_RX_HDR_SIZE;
+	return 0;
 }
 
 static int32_t sxe2_rxq_ctxt_cfg_fill(struct sxe2_rx_queue *rxq,
-- 
2.52.0

