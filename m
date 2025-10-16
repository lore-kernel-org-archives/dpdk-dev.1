Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8530FCCD183
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 15:29:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9C1E540EDF;
	Thu, 16 Oct 2025 17:29:56 +0200 (CEST)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by mails.dpdk.org (Postfix) with ESMTP id 9D3174026D
 for <dev@dpdk.org>; Thu, 16 Oct 2025 17:29:55 +0200 (CEST)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-782e93932ffso853090b3a.3
 for <dev@dpdk.org>; Thu, 16 Oct 2025 08:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1760628595;
 x=1761233395; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nNhXSKV5OVVDxrVqSX4nlw4FfYl1i9Zp6YnK07Zm4fM=;
 b=2YoeVhRd/TvYDaxGW+NKAFENko9J6GG6EQGQqPr8x2mR5AhRq/TnbaRZmOTBFsv6Dj
 0XSBi5D2rxYEgsVgv332nYb+yoo0pi3qCU8Hlzwryhrc1KBqCcumoj5bweTCEO7hYg8V
 bzOWjUWyD2MfsYukE3TAFRzcxyzROp97ju4AFX3MpufYuqzzqfwVC/Dvi2/wLd+8ioe7
 I9kiX+17Lb+uyUlWBIEPK5nrvjF3bCN6/0guc2wTkgjtiJULHuKJ5rjVOPLqkpZzH7sD
 ZQ67ivFGElxVx458Ct0En5zDulLpRj4ERV7sy88jy60MuR91qLunngZDMmeGyLiebnzi
 Lp6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760628595; x=1761233395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nNhXSKV5OVVDxrVqSX4nlw4FfYl1i9Zp6YnK07Zm4fM=;
 b=daMr9di3xnOjT1N1HwUR+5F8tlzdDnEBFE14BrJO3BwISn+h92yVt0qJIScCMWZIRO
 2On9DC4g3lwiXKg562N3qAXTMP+yRPbSdB+AsVLy/sMl5KJNXFE4xSOjllBctdpJvN3I
 FY/y9W2advxXEPWXULYagWL+1tc5hjPOxVMmo1U/wNRhoplybUA50VGaBaOC3PZFlg3t
 jWFIHSQpLsqiZGq2573KzjaoBZguIfQLwSuJmzXJYtxcoznPYtjgTOBCy18K8rGyRZKN
 +/Xwbw0+NMyx5iiFWcYKyIVEQCW9hGmetMPefTcbUEbXoUSkXuu76sn6BjAm7VFdOetC
 WtoA==
X-Gm-Message-State: AOJu0YzDSd+OdnYvMXme6ZhC6ZLevxiwDj1odkaKKapqKNetSQq9EqU6
 St199FbPxz0v7LGH489cqevcw1zMsIbwafjmgKFucccU5x8CJ4S+HUptjY2vuSRyJYY2yMrsnRP
 TZB+QkzU=
X-Gm-Gg: ASbGncvPVdhK1n6N5ugBTR0vbrgnB7oOXsA8FjBl9BIHUGxtqHl7Ua9BZnFPoh++VbG
 wguAzKupp5RLx1aOfHVZTxMNYbarc5hFDatVe2glTZEfTxl7M/4YVj2oE2g/x/yDS5L8JkfAWOw
 G/qG+01Ww+YDRPqFh0n/GFaykO8ZYPjRwzqKZWgKodmw2v5bFjfbEjFEfVrMsciw0CYd3h9tiSx
 XX6SCnFYCrFdVrlsLNLIGqCTLbHbnH3Sz3AKPMvCPpIkVYLT5PCXf3I2nffQvZS6yK+pK39mJtP
 No+JIhI/PSH9ApJ3ilIbq7KVlyVU5SgPi67qpa1dhUW/qMCOYlJEzrhGT5QcJGOFkA+GZq7zpy2
 4dpRH9pxwgw79PDLU6BEfZxfN8ifKiSC+RaS1T0Os/xPVTMv+XOO921CQxAjlXQn4DXp05pGO5R
 nFzflRGmzLSA2nLE4Oh566P9FpIfU9OgBjQ9RyjhXJg+fHo32TLvLP756wBATz
X-Google-Smtp-Source: AGHT+IGR6z1Szuw00WVo4g5Ci9+qIIDes+R0CvUDditk5jvoUakj8RQabTSPewQibuUofTOj4aRGAQ==
X-Received: by 2002:a05:6a20:2443:b0:301:daeb:5898 with SMTP id
 adf61e73a8af0-334a864ab42mr441086637.58.1760628594577; 
 Thu, 16 Oct 2025 08:29:54 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b6a22ba7693sm3263262a12.31.2025.10.16.08.29.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Oct 2025 08:29:54 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Junlong Wang <wang.junlong1@zte.com.cn>, Lijie Shan <shan.lijie@zte.com.cn>
Subject: [PATCH v2] net/zxdh: replace use of rte_memcpy with memcpy in flow
 setup
Date: Thu, 16 Oct 2025 08:29:21 -0700
Message-ID: <20251016152941.6592-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250926181017.470585-1-stephen@networkplumber.org>
References: <20250926181017.470585-1-stephen@networkplumber.org>
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

The regular library memcpy has more error checking and is as
fast or faster for small fixed sizes. Use struct assignment
for even more type checking.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
v2 - rebase

 drivers/net/zxdh/zxdh_flow.c | 54 ++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 30 deletions(-)

diff --git a/drivers/net/zxdh/zxdh_flow.c b/drivers/net/zxdh/zxdh_flow.c
index 7a2e20ac39..605eef4a01 100644
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
@@ -1328,14 +1328,12 @@ static int fd_flow_parse_pattern(struct rte_eth_dev *dev, const struct rte_flow_
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
+				memcpy((uint32_t *)key->src_ip + 3, &ipv4_spec->hdr.src_addr, 4);
+				memcpy((uint32_t *)key->dst_ip + 3, &ipv4_spec->hdr.dst_addr, 4);
+				memcpy((uint32_t *)key_mask->src_ip + 3,
+				       &ipv4_mask->hdr.src_addr, 4);
+				memcpy((uint32_t *)key_mask->dst_ip + 3,
+				       &ipv4_mask->hdr.dst_addr, 4);
 			}
 			break;
 		case RTE_FLOW_ITEM_TYPE_IPV6:
@@ -1364,14 +1362,10 @@ static int fd_flow_parse_pattern(struct rte_eth_dev *dev, const struct rte_flow_
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
+				memcpy(key->src_ip, &ipv6_spec->hdr.src_addr, 16);
+				memcpy(key->dst_ip, &ipv6_spec->hdr.dst_addr, 16);
+				memcpy(key_mask->src_ip, &ipv6_mask->hdr.src_addr, 16);
+				memcpy(key_mask->dst_ip, &ipv6_mask->hdr.dst_addr, 16);
 			}
 			break;
 		case RTE_FLOW_ITEM_TYPE_TCP:
@@ -1477,8 +1471,8 @@ static int fd_flow_parse_pattern(struct rte_eth_dev *dev, const struct rte_flow_
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
@@ -1573,10 +1567,10 @@ fd_flow_parse_vxlan_encap(struct rte_eth_dev *dev __rte_unused,
 		switch (items->type) {
 		case RTE_FLOW_ITEM_TYPE_ETH:
 			item_eth = items->spec;
-			rte_memcpy(&dh_flow->encap0.dst_mac1, item_eth->dst.addr_bytes, 2);
-			rte_memcpy(&dh_flow->encap1.src_mac1, item_eth->src.addr_bytes, 2);
-			rte_memcpy(&dh_flow->encap0.dst_mac2, &item_eth->dst.addr_bytes[2], 4);
-			rte_memcpy(&dh_flow->encap1.src_mac2, &item_eth->src.addr_bytes[2], 4);
+			memcpy(&dh_flow->encap0.dst_mac1, item_eth->dst.addr_bytes, 2);
+			memcpy(&dh_flow->encap1.src_mac1, item_eth->src.addr_bytes, 2);
+			memcpy(&dh_flow->encap0.dst_mac2, &item_eth->dst.addr_bytes[2], 4);
+			memcpy(&dh_flow->encap1.src_mac2, &item_eth->src.addr_bytes[2], 4);
 			dh_flow->encap0.dst_mac1 = rte_bswap16(dh_flow->encap0.dst_mac1);
 			dh_flow->encap1.src_mac1 = rte_bswap16(dh_flow->encap1.src_mac1);
 			dh_flow->encap0.dst_mac2 = rte_bswap32(dh_flow->encap0.dst_mac2);
@@ -1592,9 +1586,9 @@ fd_flow_parse_vxlan_encap(struct rte_eth_dev *dev __rte_unused,
 			dh_flow->encap0.tos = item_ipv4->hdr.type_of_service;
 			dh_flow->encap0.ttl = item_ipv4->hdr.time_to_live;
 			addr = rte_bswap32(item_ipv4->hdr.src_addr);
-			rte_memcpy((uint32_t *)dh_flow->encap1.sip.ip_addr + 3, &addr, 4);
+			memcpy((uint32_t *)dh_flow->encap1.sip.ip_addr + 3, &addr, 4);
 			addr = rte_bswap32(item_ipv4->hdr.dst_addr);
-			rte_memcpy((uint32_t *)dh_flow->encap0.dip.ip_addr + 3, &addr, 4);
+			memcpy((uint32_t *)dh_flow->encap0.dip.ip_addr + 3, &addr, 4);
 			break;
 		case RTE_FLOW_ITEM_TYPE_IPV6:
 			item_ipv6 = items->spec;
@@ -1603,7 +1597,7 @@ fd_flow_parse_vxlan_encap(struct rte_eth_dev *dev __rte_unused,
 					(item_ipv6->hdr.vtc_flow & RTE_IPV6_HDR_TC_MASK) >>
 						RTE_IPV6_HDR_TC_SHIFT;
 			dh_flow->encap0.ttl = item_ipv6->hdr.hop_limits;
-			rte_memcpy(dh_flow->encap1.sip.ip_addr, &item_ipv6->hdr.src_addr, 16);
+			memcpy(dh_flow->encap1.sip.ip_addr, &item_ipv6->hdr.src_addr, 16);
 			dh_flow->encap1.sip.ip_addr[0] =
 				rte_bswap32(dh_flow->encap1.sip.ip_addr[0]);
 			dh_flow->encap1.sip.ip_addr[1] =
@@ -1612,7 +1606,7 @@ fd_flow_parse_vxlan_encap(struct rte_eth_dev *dev __rte_unused,
 				rte_bswap32(dh_flow->encap1.sip.ip_addr[2]);
 			dh_flow->encap1.sip.ip_addr[3] =
 				rte_bswap32(dh_flow->encap1.sip.ip_addr[3]);
-			rte_memcpy(dh_flow->encap0.dip.ip_addr, &item_ipv6->hdr.dst_addr, 16);
+			memcpy(dh_flow->encap0.dip.ip_addr, &item_ipv6->hdr.dst_addr, 16);
 			dh_flow->encap0.dip.ip_addr[0] =
 					rte_bswap32(dh_flow->encap0.dip.ip_addr[0]);
 			dh_flow->encap0.dip.ip_addr[1] =
@@ -1884,7 +1878,7 @@ vf_flow_msg_process(enum zxdh_msg_type msg_type, struct rte_eth_dev *dev,
 	struct zxdh_flow_op_rsp *flow_rsp = (struct zxdh_flow_op_rsp *)flow_op_rsp;
 
 	dh_flow->hash_search_index = hw->hash_search_index;
-	rte_memcpy(&flow_msg->dh_flow, dh_flow, sizeof(struct zxdh_flow));
+	flow_msg->dh_flow = *dh_flow;
 
 	zxdh_msg_head_build(hw, msg_type, &msg_info);
 	ret = zxdh_vf_send_msg_to_pf(dev, &msg_info, sizeof(struct zxdh_msg_info),
@@ -1909,7 +1903,7 @@ vf_flow_msg_process(enum zxdh_msg_type msg_type, struct rte_eth_dev *dev,
 	if (msg_type == ZXDH_FLOW_HW_ADD)
 		dh_flow->flowentry.hw_idx = flow_rsp->dh_flow.flowentry.hw_idx;
 	if (count)
-		rte_memcpy((void *)count, &flow_rsp->count, sizeof(flow_rsp->count));
+		memcpy((void *)count, &flow_rsp->count, sizeof(flow_rsp->count));
 
 	return ret;
 }
-- 
2.47.3

