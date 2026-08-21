Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33BD6C5DF8C
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Aug 2026 19:32:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7507D40678;
	Fri, 21 Aug 2026 21:31:04 +0200 (CEST)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by mails.dpdk.org (Postfix) with ESMTP id 5D27740678
 for <dev@dpdk.org>; Fri, 21 Aug 2026 21:31:01 +0200 (CEST)
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-cb5b8572b70so1760812a12.2
 for <dev@dpdk.org>; Fri, 21 Aug 2026 12:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787340660;
 x=1787945460; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iUChV9PIUa8sC61LErQA3Vri3Yst4Hzf46OD5/LkuVg=;
 b=j6AJ5C4KvPhdrfY1Is1+AOey/9bJVnlbjLGxA7mxMTDQSimtxAAzHUFlOD8Ju4xM8h
 Jm73i5pogoPFIFEyRyvF1J/Mn4rBeoqlD+Uc1025WbYw0PpiRKexTRtpBEbDyVvl2/1n
 bvR5Qc47VF44ajMSN9dssHZBQ/k79ADfY450k+Ya167v5vlY/KBIimBTZJhIQsvuph18
 IBwV4EW7eI++/jBGgiqKUeYZq2NGLdyvmASVP+BAbvqvJw2KcmIdb7vDj29JA1PVVBrV
 d7Bv4Ajcq4gECbu4OhkogIS5GbewGaMn8Sb3CUm8KGkg+S8yYApu6DLVnk8oorCBLN4H
 O4dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787340660; x=1787945460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=iUChV9PIUa8sC61LErQA3Vri3Yst4Hzf46OD5/LkuVg=;
 b=QAhCQgPGRvDD6cKYmr0JMBVMYTTnueQ2hrl2LTKCwzopFvXAlVPWRup3q9kW+uU2px
 O/L/Tmc3YM+Tf6PcPxfBLBvUzVGf3IyJE2UKg750r0y0aH2QzP2GpG+9yxBh/0g9nnfm
 gdk1hYJ6UD2T3z4zYRX5qbJwW2OXOU5+WqT2/aouFrKPBwvDYHF8MlOcMPWVUOtPfNOy
 7X7BM36rw9e1HS2l+XOXtTGVjqRTIq45z8gf7vUME6WmivZ2AqJkNhVslxyUPfAehFrx
 e+RCDEPC4rjajkGPr97UsTg0ohIG9jkkU0xc69oGyDOe9ZZ/nQzKavouzGpmHkj224r0
 b/mw==
X-Gm-Message-State: AFuF++l/YhK3+MBZduvcx91iXj2ZV0g9gJV9q4H637iBtc3IOw36bKDP
 mlVqBZT5XLJfLnReuxV0Gj/N0tV7mbPXDDdcyQunDpeMA7v/lRrfdXvoUTKkzXnOSOGjw2beRVR
 Nv1U7eis=
X-Gm-Gg: AR+sD11ZsqGHN7BPqghdBXD9G7Q6xykIfBjQ5eTTD/+cSWVISCRUFGqWWFQRiWmkQ9Q
 dRO9HzpwhJpcF6bjUEIoLtDgKu+cbO8M5F0UtwfJK9rRKtVTpEXSkFUxSeBxSSVkt/giPiatuwV
 UfauoS1V6csSDOhfa3lnzPWCYKPZEm10golKyD/HMfStphrWuRGQg+F/CBCFqW+rJfB2uQOmfpK
 lDiWRSRADdd6DRu9NTRkpIjMH8InJSYDghgPWWIHJYL0QZKwvtVn+ieR0kni+Semr5US1vQfJ0J
 bduDki0Gjfgh84s3E5J3QVYtYOdQGDyImPymSM+swShlgZGwtKmhG3gPPMwNcA9WZ2hmHiT83M+
 4pIToi/CDSDvliqUX3Ci97mWRep7M/fiv4yg+5bEP434jaAEzH8fo/AQP2f9CMnB4tjbMXugmmT
 baOCsCXvmqI2iTqGHgLgAYEe51DXjKwCc56bzgFDMpKVzFoo0AXoqgjNG+ZPbHF8UflU24xBpSk
 Ll2E6EkCg4U3BCGrJT/ESWxZKk=
X-Received: by 2002:a05:6a00:7497:b0:851:fb36:a701 with SMTP id
 d2e1a72fcca58-851fb36a99cmr12163563b3a.7.1787340660409; 
 Fri, 21 Aug 2026 12:31:00 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc16c6dd2f4sm1860304a12.17.2026.08.21.12.30.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 12:30:59 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Junlong Wang <wang.junlong1@zte.com.cn>, Ming Ran <ran.ming@zte.com.cn>
Subject: [PATCH v2 52/68] net/zxdh: replace use of rte_memcpy
Date: Fri, 21 Aug 2026 12:24:47 -0700
Message-ID: <20260821192646.146382-53-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821192646.146382-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <20260821192646.146382-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The uses of rte_memcpy() in the control path of the zxdh driver
have no performance benefit over regular memcpy(), and regular
memcpy() gets more compile time checking of the arguments.

The only remaining rte_memcpy() is in zxdh_xmit_fill_net_hdr()
which is on the transmit fast path.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/zxdh/zxdh_common.c |  7 ++--
 drivers/net/zxdh/zxdh_flow.c   | 67 +++++++++++++++++++---------------
 drivers/net/zxdh/zxdh_msg.c    | 15 ++++----
 drivers/net/zxdh/zxdh_mtr.c    | 10 ++---
 drivers/net/zxdh/zxdh_np.c     |  1 -
 drivers/net/zxdh/zxdh_queue.c  |  8 ++--
 drivers/net/zxdh/zxdh_tables.c | 21 ++++++-----
 7 files changed, 70 insertions(+), 59 deletions(-)

diff --git a/drivers/net/zxdh/zxdh_common.c b/drivers/net/zxdh/zxdh_common.c
index 2b821b1dc8..1dff77aee8 100644
--- a/drivers/net/zxdh/zxdh_common.c
+++ b/drivers/net/zxdh/zxdh_common.c
@@ -7,7 +7,6 @@
 
 #include <ethdev_driver.h>
 #include <rte_malloc.h>
-#include <rte_memcpy.h>
 
 #include "zxdh_ethdev.h"
 #include "zxdh_logs.h"
@@ -79,7 +78,7 @@ zxdh_fill_common_msg(struct zxdh_hw *hw, struct zxdh_pci_bar_msg *desc,
 	msg_data->pcie_id = hw->pcie_id;
 	msg_data->slen = buff_size;
 	if (buff_size != 0)
-		rte_memcpy(msg_data + 1, buff, buff_size);
+		memcpy(msg_data + 1, buff, buff_size);
 
 	return 0;
 }
@@ -123,7 +122,7 @@ zxdh_common_rsp_check(struct zxdh_msg_recviver_mem *msg_rsp,
 		return -1;
 	}
 	if (len != 0)
-		rte_memcpy(buff, rsp_hdr + 1, len);
+		memcpy(buff, rsp_hdr + 1, len);
 
 	return 0;
 }
@@ -228,7 +227,7 @@ zxdh_get_res_info(struct zxdh_res_para *dev, uint8_t field, uint8_t *res, uint16
 		return ret;
 	}
 	*len = tbl_reps->len;
-	rte_memcpy(res, (recv_buf + ZXDH_REPS_HEADER_OFFSET +
+	memcpy(res, (recv_buf + ZXDH_REPS_HEADER_OFFSET +
 		sizeof(struct zxdh_tbl_msg_reps_header)), *len);
 	return ret;
 }
diff --git a/drivers/net/zxdh/zxdh_flow.c b/drivers/net/zxdh/zxdh_flow.c
index 56ac34c6e3..ee6275c337 100644
--- a/drivers/net/zxdh/zxdh_flow.c
+++ b/drivers/net/zxdh/zxdh_flow.c
@@ -94,9 +94,9 @@ static void
 zxdh_adjust_flow_op_rsp_memory_layout(void *old_data,
 		size_t old_size, void *new_data)
 {
-	rte_memcpy(new_data, old_data, sizeof(struct zxdh_flow));
+	memcpy(new_data, old_data, sizeof(struct zxdh_flow));
 	memset((char *)new_data + sizeof(struct zxdh_flow), 0, 4);
-	rte_memcpy((char *)new_data + sizeof(struct zxdh_flow) + 4,
+	memcpy((char *)new_data + sizeof(struct zxdh_flow) + 4,
 		(char *)old_data + sizeof(struct zxdh_flow),
 		old_size - sizeof(struct zxdh_flow));
 }
@@ -1328,14 +1328,14 @@ static int fd_flow_parse_pattern(struct rte_eth_dev *dev, const struct rte_flow_
 						ipv4_mask->hdr.type_of_service;
 				key->frag_flag = (ipv4_spec->hdr.fragment_offset != 0) ? 1 : 0;
 				key_mask->frag_flag = (ipv4_mask->hdr.fragment_offset != 0) ? 1 : 0;
-				rte_memcpy((uint32_t *)key->src_ip + 3,
-							 &ipv4_spec->hdr.src_addr, 4);
-				rte_memcpy((uint32_t *)key->dst_ip + 3,
-							 &ipv4_spec->hdr.dst_addr, 4);
-				rte_memcpy((uint32_t *)key_mask->src_ip + 3,
-							 &ipv4_mask->hdr.src_addr, 4);
-				rte_memcpy((uint32_t *)key_mask->dst_ip + 3,
-							 &ipv4_mask->hdr.dst_addr, 4);
+				memcpy((uint32_t *)key->src_ip + 3,
+				       &ipv4_spec->hdr.src_addr, 4);
+				memcpy((uint32_t *)key->dst_ip + 3,
+				       &ipv4_spec->hdr.dst_addr, 4);
+				memcpy((uint32_t *)key_mask->src_ip + 3,
+				       &ipv4_mask->hdr.src_addr, 4);
+				memcpy((uint32_t *)key_mask->dst_ip + 3,
+				       &ipv4_mask->hdr.dst_addr, 4);
 			}
 			break;
 		case RTE_FLOW_ITEM_TYPE_IPV6:
@@ -1364,14 +1364,14 @@ static int fd_flow_parse_pattern(struct rte_eth_dev *dev, const struct rte_flow_
 				key->nw_proto = ipv6_spec->hdr.proto;
 				key_mask->nw_proto = ipv6_mask->hdr.proto;
 
-				rte_memcpy(key->src_ip,
-							 &ipv6_spec->hdr.src_addr, 16);
-				rte_memcpy(key->dst_ip,
-							 &ipv6_spec->hdr.dst_addr, 16);
-				rte_memcpy(key_mask->src_ip,
-							 &ipv6_mask->hdr.src_addr, 16);
-				rte_memcpy(key_mask->dst_ip,
-							 &ipv6_mask->hdr.dst_addr, 16);
+				memcpy(key->src_ip, &ipv6_spec->hdr.src_addr,
+				       16);
+				memcpy(key->dst_ip, &ipv6_spec->hdr.dst_addr,
+				       16);
+				memcpy(key_mask->src_ip,
+				       &ipv6_mask->hdr.src_addr, 16);
+				memcpy(key_mask->dst_ip,
+				       &ipv6_mask->hdr.dst_addr, 16);
 			}
 			break;
 		case RTE_FLOW_ITEM_TYPE_TCP:
@@ -1477,8 +1477,8 @@ static int fd_flow_parse_pattern(struct rte_eth_dev *dev, const struct rte_flow_
 								 "Invalid vxlan mask");
 					return -rte_errno;
 			}
-			rte_memcpy(key->vni, vxlan_spec->vni, 3);
-			rte_memcpy(key_mask->vni, vxlan_mask->vni, 3);
+			memcpy(key->vni, vxlan_spec->vni, 3);
+			memcpy(key_mask->vni, vxlan_mask->vni, 3);
 			break;
 		}
 		case RTE_FLOW_ACTION_TYPE_VOID:
@@ -1573,10 +1573,14 @@ fd_flow_parse_vxlan_encap(struct rte_eth_dev *dev __rte_unused,
 		switch (items->type) {
 		case RTE_FLOW_ITEM_TYPE_ETH:
 			item_eth = items->spec;
-			rte_memcpy(&dh_flow->encap0.dst_mac1, item_eth->dst.addr_bytes, 2);
-			rte_memcpy(&dh_flow->encap1.src_mac1, item_eth->src.addr_bytes, 2);
-			rte_memcpy(&dh_flow->encap0.dst_mac2, &item_eth->dst.addr_bytes[2], 4);
-			rte_memcpy(&dh_flow->encap1.src_mac2, &item_eth->src.addr_bytes[2], 4);
+			memcpy(&dh_flow->encap0.dst_mac1,
+			       item_eth->dst.addr_bytes, 2);
+			memcpy(&dh_flow->encap1.src_mac1,
+			       item_eth->src.addr_bytes, 2);
+			memcpy(&dh_flow->encap0.dst_mac2,
+			       &item_eth->dst.addr_bytes[2], 4);
+			memcpy(&dh_flow->encap1.src_mac2,
+			       &item_eth->src.addr_bytes[2], 4);
 			dh_flow->encap0.dst_mac1 = rte_bswap16(dh_flow->encap0.dst_mac1);
 			dh_flow->encap1.src_mac1 = rte_bswap16(dh_flow->encap1.src_mac1);
 			dh_flow->encap0.dst_mac2 = rte_bswap32(dh_flow->encap0.dst_mac2);
@@ -1592,9 +1596,11 @@ fd_flow_parse_vxlan_encap(struct rte_eth_dev *dev __rte_unused,
 			dh_flow->encap0.tos = item_ipv4->hdr.type_of_service;
 			dh_flow->encap0.ttl = item_ipv4->hdr.time_to_live;
 			addr = rte_bswap32(item_ipv4->hdr.src_addr);
-			rte_memcpy((uint32_t *)dh_flow->encap1.sip.ip_addr + 3, &addr, 4);
+			memcpy((uint32_t *)dh_flow->encap1.sip.ip_addr + 3,
+			       &addr, 4);
 			addr = rte_bswap32(item_ipv4->hdr.dst_addr);
-			rte_memcpy((uint32_t *)dh_flow->encap0.dip.ip_addr + 3, &addr, 4);
+			memcpy((uint32_t *)dh_flow->encap0.dip.ip_addr + 3,
+			       &addr, 4);
 			break;
 		case RTE_FLOW_ITEM_TYPE_IPV6:
 			item_ipv6 = items->spec;
@@ -1603,7 +1609,8 @@ fd_flow_parse_vxlan_encap(struct rte_eth_dev *dev __rte_unused,
 					(item_ipv6->hdr.vtc_flow & RTE_IPV6_HDR_TC_MASK) >>
 						RTE_IPV6_HDR_TC_SHIFT;
 			dh_flow->encap0.ttl = item_ipv6->hdr.hop_limits;
-			rte_memcpy(dh_flow->encap1.sip.ip_addr, &item_ipv6->hdr.src_addr, 16);
+			memcpy(dh_flow->encap1.sip.ip_addr,
+			       &item_ipv6->hdr.src_addr, 16);
 			dh_flow->encap1.sip.ip_addr[0] =
 				rte_bswap32(dh_flow->encap1.sip.ip_addr[0]);
 			dh_flow->encap1.sip.ip_addr[1] =
@@ -1612,7 +1619,8 @@ fd_flow_parse_vxlan_encap(struct rte_eth_dev *dev __rte_unused,
 				rte_bswap32(dh_flow->encap1.sip.ip_addr[2]);
 			dh_flow->encap1.sip.ip_addr[3] =
 				rte_bswap32(dh_flow->encap1.sip.ip_addr[3]);
-			rte_memcpy(dh_flow->encap0.dip.ip_addr, &item_ipv6->hdr.dst_addr, 16);
+			memcpy(dh_flow->encap0.dip.ip_addr,
+			       &item_ipv6->hdr.dst_addr, 16);
 			dh_flow->encap0.dip.ip_addr[0] =
 					rte_bswap32(dh_flow->encap0.dip.ip_addr[0]);
 			dh_flow->encap0.dip.ip_addr[1] =
@@ -1909,7 +1917,8 @@ vf_flow_msg_process(enum zxdh_msg_type msg_type, struct rte_eth_dev *dev,
 	if (msg_type == ZXDH_FLOW_HW_ADD)
 		dh_flow->flowentry.hw_idx = flow_rsp->dh_flow.flowentry.hw_idx;
 	if (count)
-		rte_memcpy((void *)count, &flow_rsp->count, sizeof(flow_rsp->count));
+		memcpy((void *)count, &flow_rsp->count,
+		       sizeof(flow_rsp->count));
 
 	return ret;
 }
diff --git a/drivers/net/zxdh/zxdh_msg.c b/drivers/net/zxdh/zxdh_msg.c
index 4b01daf37a..64aa0ac5f9 100644
--- a/drivers/net/zxdh/zxdh_msg.c
+++ b/drivers/net/zxdh/zxdh_msg.c
@@ -3,9 +3,9 @@
  */
 
 #include <stdbool.h>
+#include <string.h>
 
 #include <rte_common.h>
-#include <rte_memcpy.h>
 #include <rte_spinlock.h>
 #include <rte_cycles.h>
 #include <inttypes.h>
@@ -899,7 +899,7 @@ zxdh_bar_msg_ack_async_msg_proc(struct zxdh_bar_msg_header *msg_header,
 	}
 	uint8_t *reps_buffer = (uint8_t *)reps_info->reps_addr;
 
-	rte_memcpy(reps_buffer + 4, receiver_buff, msg_header->len);
+	memcpy(reps_buffer + 4, receiver_buff, msg_header->len);
 	*(uint16_t *)(reps_buffer + 1) = msg_header->len;
 	*(uint8_t *)(reps_info->reps_addr) = ZXDH_REPS_HEADER_REPLYED;
 
@@ -1406,13 +1406,13 @@ zxdh_vf_port_uninit(struct zxdh_hw *pf_hw, uint16_t vport,
 	}
 
 	*res_len += strlen(str);
-	rte_memcpy(reply_data_addr, str, strlen(str) + 1);
+	memcpy(reply_data_addr, str, strlen(str) + 1);
 	ZXDH_SET(msg_reply_body, res_info, flag, ZXDH_REPS_SUCC);
 	return ret;
 
 proc_end:
 	*res_len += strlen(str);
-	rte_memcpy(reply_data_addr, str, strlen(str) + 1);
+	memcpy(reply_data_addr, str, strlen(str) + 1);
 	ZXDH_SET(msg_reply_body, res_info, flag, ZXDH_REPS_FAIL);
 	return ret;
 }
@@ -1458,7 +1458,7 @@ zxdh_add_vf_mac_table(struct zxdh_hw *hw, uint16_t vport,
 success:
 	sprintf(str, " vport 0x%x set mac ret 0x%x\n", port.vport, ret);
 	*reply_len =  strlen(str) + ZXDH_MSG_REPLYBODY_HEAD;
-	rte_memcpy(reply_data_addr, str, strlen(str) + 1);
+	memcpy(reply_data_addr, str, strlen(str) + 1);
 	ZXDH_SET(msg_reply_body, reply_body, flag, ZXDH_REPS_SUCC);
 	PMD_DRV_LOG(DEBUG, " reply len %d", *reply_len);
 	return ret;
@@ -1499,7 +1499,7 @@ zxdh_del_vf_mac_table(struct zxdh_hw *hw, uint16_t vport,
 
 	sprintf(str, "vport 0x%x del mac ret 0x%x\n", port.vport, ret);
 	*res_len =  strlen(str) + ZXDH_MSG_REPLYBODY_HEAD;
-	rte_memcpy(reply_data_addr, str, strlen(str) + 1);
+	memcpy(reply_data_addr, str, strlen(str) + 1);
 	ZXDH_SET(msg_reply_body, res_info, flag, ZXDH_REPS_SUCC);
 	return ret;
 
@@ -2331,7 +2331,8 @@ zxdh_vf_flow_hw_get(struct zxdh_hw *pf_hw, uint16_t vport,
 	}
 	PMD_DRV_LOG(INFO, " res len :%d", *res_len);
 	dh_flow = flow_rsp_addr;
-	rte_memcpy(&dh_flow->flowentry, &flow_entry->dh_flow.flowentry, sizeof(dh_flow->flowentry));
+	memcpy(&dh_flow->flowentry, &flow_entry->dh_flow.flowentry,
+	       sizeof(dh_flow->flowentry));
 	ZXDH_SET(msg_reply_body, res_info, flag, ZXDH_REPS_SUCC);
 	return 0;
 }
diff --git a/drivers/net/zxdh/zxdh_mtr.c b/drivers/net/zxdh/zxdh_mtr.c
index b23f6535a8..48318a6941 100644
--- a/drivers/net/zxdh/zxdh_mtr.c
+++ b/drivers/net/zxdh/zxdh_mtr.c
@@ -590,9 +590,8 @@ static int zxdh_hw_profile_config(struct rte_eth_dev *dev, uint16_t hw_profile_i
 		zxdh_plcr_profile_cfg->car_type = CAR_A;
 		zxdh_plcr_profile_cfg->packet_mode = mp->profile.packet_mode;
 		zxdh_plcr_profile_cfg->hw_profile_id = hw_profile_id;
-		rte_memcpy(&zxdh_plcr_profile_cfg->plcr_param,
-			&mp->plcr_param,
-			sizeof(zxdh_plcr_profile_cfg->plcr_param));
+		memcpy(&zxdh_plcr_profile_cfg->plcr_param, &mp->plcr_param,
+		       sizeof(zxdh_plcr_profile_cfg->plcr_param));
 
 		zxdh_msg_head_build(hw, ZXDH_PLCR_CAR_PROFILE_CFG_SET, &msg_info);
 		ret = zxdh_vf_send_msg_to_pf(dev,
@@ -685,7 +684,7 @@ zxdh_meter_profile_add(struct rte_eth_dev *dev,
 	mp->meter_profile_id = meter_profile_id;
 	mp->dpdk_port_id = dev->data->port_id;
 	mp->hw_profile_id = UINT16_MAX;
-	rte_memcpy(&mp->profile, profile, sizeof(struct rte_mtr_meter_profile));
+	memcpy(&mp->profile, profile, sizeof(struct rte_mtr_meter_profile));
 
 	ret = zxdh_mtr_profile_offload(dev, mp, profile, error);
 	if (ret) {
@@ -772,7 +771,8 @@ zxdh_meter_policy_add(struct rte_eth_dev *dev,
 	memset(mtr_policy, 0, sizeof(struct zxdh_meter_policy));
 	mtr_policy->policy_id = policy_id;
 	mtr_policy->dpdk_port_id = dev->data->port_id;
-	rte_memcpy(&mtr_policy->policy, policy, sizeof(struct rte_mtr_meter_policy_params));
+	memcpy(&mtr_policy->policy, policy,
+	       sizeof(struct rte_mtr_meter_policy_params));
 	/* Add to list. */
 	TAILQ_INSERT_TAIL(&zxdh_shared_data->mtr_policy_list, mtr_policy, next);
 	mtr_policy->ref_cnt++;
diff --git a/drivers/net/zxdh/zxdh_np.c b/drivers/net/zxdh/zxdh_np.c
index b078ec5b6c..41542a89d8 100644
--- a/drivers/net/zxdh/zxdh_np.c
+++ b/drivers/net/zxdh/zxdh_np.c
@@ -9,7 +9,6 @@
 #include <rte_log.h>
 #include <rte_debug.h>
 #include <rte_malloc.h>
-#include <rte_memcpy.h>
 
 #include "zxdh_np.h"
 #include "zxdh_logs.h"
diff --git a/drivers/net/zxdh/zxdh_queue.c b/drivers/net/zxdh/zxdh_queue.c
index 7162593b16..c47bc44710 100644
--- a/drivers/net/zxdh/zxdh_queue.c
+++ b/drivers/net/zxdh/zxdh_queue.c
@@ -244,8 +244,8 @@ zxdh_dev_rx_queue_setup(struct rte_eth_dev *dev,
 		hw->queue_conf->queue_changed = 1;
 	}
 
-	rte_memcpy(&hw->queue_conf->conf[queue_idx].zxdh_rx_conf,
-		rx_conf, sizeof(struct rte_eth_rxconf));
+	memcpy(&hw->queue_conf->conf[queue_idx].zxdh_rx_conf, rx_conf,
+	       sizeof(struct rte_eth_rxconf));
 	hw->queue_conf->conf[queue_idx].rx_nb_desc = valid_nb_desc;
 	hw->queue_conf->conf[queue_idx].queue_mp = mp;
 
@@ -336,8 +336,8 @@ zxdh_dev_tx_queue_setup(struct rte_eth_dev *dev,
 		hw->queue_conf->queue_changed = 1;
 	}
 
-	rte_memcpy(&hw->queue_conf->conf[queue_idx].zxdh_tx_conf,
-		tx_conf, sizeof(struct rte_eth_txconf));
+	memcpy(&hw->queue_conf->conf[queue_idx].zxdh_tx_conf, tx_conf,
+	       sizeof(struct rte_eth_txconf));
 	hw->queue_conf->conf[queue_idx].tx_nb_desc = valid_nb_desc;
 
 	return 0;
diff --git a/drivers/net/zxdh/zxdh_tables.c b/drivers/net/zxdh/zxdh_tables.c
index 233d53a7e8..5ee1a7dea8 100644
--- a/drivers/net/zxdh/zxdh_tables.c
+++ b/drivers/net/zxdh/zxdh_tables.c
@@ -248,7 +248,8 @@ zxdh_add_mac_table(struct zxdh_hw *hw, uint16_t vport, struct rte_ether_addr *ad
 	int32_t ret;
 
 	if (rte_is_unicast_ether_addr(addr)) {
-		rte_memcpy(unicast_table.key.dmac_addr, addr, sizeof(struct rte_ether_addr));
+		memcpy(unicast_table.key.dmac_addr, addr,
+		       sizeof(struct rte_ether_addr));
 		unicast_table.key.sriov_vlan_tpid = srv_tpid;
 		unicast_table.key.sriov_vlan_id = srv_vlanid;
 
@@ -286,8 +287,8 @@ zxdh_add_mac_table(struct zxdh_hw *hw, uint16_t vport, struct rte_ether_addr *ad
 	} else {
 		for (group_id = 0; group_id < 4; group_id++) {
 			multicast_table.key.vf_group_id = group_id;
-			rte_memcpy(multicast_table.key.mac_addr,
-					addr, sizeof(struct rte_ether_addr));
+			memcpy(multicast_table.key.mac_addr, addr,
+			       sizeof(struct rte_ether_addr));
 			ZXDH_DTB_HASH_ENTRY_INFO_T dtb_hash_entry = {
 				.p_actu_key = (uint8_t *)&multicast_table.key,
 				.p_rst = (uint8_t *)&multicast_table.entry
@@ -353,7 +354,8 @@ zxdh_del_mac_table(struct zxdh_hw *hw, uint16_t vport, struct rte_ether_addr *ad
 	int32_t ret = 0;
 
 	if (rte_is_unicast_ether_addr(addr)) {
-		rte_memcpy(unicast_table.key.dmac_addr, addr, sizeof(struct rte_ether_addr));
+		memcpy(unicast_table.key.dmac_addr, addr,
+		       sizeof(struct rte_ether_addr));
 		unicast_table.key.sriov_vlan_id = srv_vlanid;
 		unicast_table.key.sriov_vlan_tpid = srv_tpid;
 		unicast_table.entry.hit_flag = 0;
@@ -385,7 +387,8 @@ zxdh_del_mac_table(struct zxdh_hw *hw, uint16_t vport, struct rte_ether_addr *ad
 		}
 	} else {
 		multicast_table.key.vf_group_id = vport_num.vfid / 64;
-		rte_memcpy(multicast_table.key.mac_addr, addr, sizeof(struct rte_ether_addr));
+		memcpy(multicast_table.key.mac_addr, addr,
+		       sizeof(struct rte_ether_addr));
 
 		ZXDH_DTB_HASH_ENTRY_INFO_T dtb_hash_entry = {
 			.p_actu_key = (uint8_t *)&multicast_table.key,
@@ -416,8 +419,8 @@ zxdh_del_mac_table(struct zxdh_hw *hw, uint16_t vport, struct rte_ether_addr *ad
 
 		for (group_id = 0; group_id < ZXDH_MC_GROUP_NUM; group_id++) {
 			multicast_table.key.vf_group_id = group_id;
-			rte_memcpy(multicast_table.key.mac_addr, addr,
-				sizeof(struct rte_ether_addr));
+			memcpy(multicast_table.key.mac_addr, addr,
+			       sizeof(struct rte_ether_addr));
 			ZXDH_DTB_HASH_ENTRY_INFO_T dtb_hash_entry = {
 				.p_actu_key = (uint8_t *)&multicast_table.key,
 				.p_rst = (uint8_t *)&multicast_table.entry
@@ -441,8 +444,8 @@ zxdh_del_mac_table(struct zxdh_hw *hw, uint16_t vport, struct rte_ether_addr *ad
 		if (del_flag) {
 			for (group_id = 0; group_id < ZXDH_MC_GROUP_NUM; group_id++) {
 				multicast_table.key.vf_group_id = group_id;
-				rte_memcpy(multicast_table.key.mac_addr, addr,
-					sizeof(struct rte_ether_addr));
+				memcpy(multicast_table.key.mac_addr, addr,
+				       sizeof(struct rte_ether_addr));
 				ZXDH_DTB_HASH_ENTRY_INFO_T dtb_hash_entry = {
 					.p_actu_key  = (uint8_t *)&multicast_table.key,
 					.p_rst = (uint8_t *)&multicast_table.entry
-- 
2.53.0

