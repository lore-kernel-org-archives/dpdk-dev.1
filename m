Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35FC1CAC5B8
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Sep 2025 18:10:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C4CF40277;
	Fri, 26 Sep 2025 20:10:22 +0200 (CEST)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com
 [209.85.222.180])
 by mails.dpdk.org (Postfix) with ESMTP id 8ABCC40262
 for <dev@dpdk.org>; Fri, 26 Sep 2025 20:10:21 +0200 (CEST)
Received: by mail-qk1-f180.google.com with SMTP id
 af79cd13be357-85e76e886a0so137683885a.1
 for <dev@dpdk.org>; Fri, 26 Sep 2025 11:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1758910221;
 x=1759515021; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Dbqa0JXcQrZe7FI66xxyt3RwDgDnRnfuLSmK9wyIBeM=;
 b=Bn9JIHX0Fi3Ejzu0oUeOINx4MkiaZicBcmdtK4Xs5K8Oh2U2F1kzv/Wj0Z4hbT7sNm
 qN92f5jtocmkYROA4BcE/WV+MRzrx/Yyz69j8E+TSFossXZGZ7S73TKbT9tGeTMMnmWm
 r6nwp80HyI6OwzCmj3aZIO41y7BHtmcfIg/c3pGuPPoHZ393toKdcAKpBLMWPtOZWtNQ
 bMIOU6xOVmS1BwxmmcZKqkS+o05Yx5VLukBapHjE1KAeA9aKWJpn53g0OgrEcWd6kChk
 1jiEVax8VS0aDvLqj1TbBlo9CXQyRqXTXc2pXI+Qb3pssl2UBKcSYTfBJEDHioa+a6Xq
 8UKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758910221; x=1759515021;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Dbqa0JXcQrZe7FI66xxyt3RwDgDnRnfuLSmK9wyIBeM=;
 b=JP05NSJSsbAuV98eMF+HGr20ofvb4woDfAF+avtCywhCcUcRaET1QctdRO/UH6k9Qg
 h2AUYQ4gVU/hTzRmM5ngqbc9Q1yrUGz1MgnQWpPJ1I5oKrjwCTWcewBGR/E639Qmphdi
 XP88ToMZUoLgMH1g2L50e/R7nF/5JnHu30y5P7dq97Se0Qhy817DscWyx5hVjJZg2PPK
 IQnRuNZu6/9QwvUCc1kK1rw+ltTFxDyQp6zPKpcL2tiWun8NVnwNoe/h2x1ZBo6xdnxZ
 eZ+kS1YASBRVNCU96kLUUKloVaGwme559qg2K4pjuZDzP2n3QqgnUZB6Asiwjv8F+vpJ
 iPww==
X-Gm-Message-State: AOJu0YxSnc8FGONsIx8NDg5nbEZ5U8c0RrN4eCaIV++i7asbG955T8qD
 Ki0MuNGCgPjZZcLbMdttjJeGTovv39rYGw67Zo0DgIAMfZZ8P68l+InouZjlTZ0PeHTcrQVyg6w
 NOKKjU2E=
X-Gm-Gg: ASbGncv6qbDh8r1oRc9jmfhWWTbenTSEN7slRIEh7mV8xxMu9nAmuOx4EACQfngBcWN
 vlTV2H/wMkJUlek8gS8bgKe9uObwmqpweF6LPUSjRrUQ2of9nAWzGXho77Sn45C3ovBNZswNYN9
 tTtoivuiggU4woZiangXvNEQqzCEmjuNWC691yo5oduk33LuYN+jYDGO79DIJXyW4MvuRkvV7SK
 vqs5milmxpSYJj5Kg89mO61RM68+Jj0huP94UmKqHY4cI9LajWfhCEsWV3lZ6Oy0UnIj+d7rqcK
 q81ajj1Mj7HalsxIXEe9WRe6f4MlegbDfef9QQAGtPst8pKqdxj+CTgE9o2bA7dYWO2kmGFl+xr
 ULTGbcJgnY9pEtByX/inKBKqgGcH3N5xkT4dcToBNNQPzk3oNM9ZE1gB2dXp3wTf7TzkMkobu3w
 qEbah93GU=
X-Google-Smtp-Source: AGHT+IHtYYugU/3miPX59pFXTf6B45tu1gttWPPfrBN7aAavzPPz560ZfqMZ4lzq/+soOveXvgNN+w==
X-Received: by 2002:a05:620a:a081:b0:85d:aabb:47eb with SMTP id
 af79cd13be357-85daabb4f6bmr652449585a.1.1758910220837; 
 Fri, 26 Sep 2025 11:10:20 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-85c2737847dsm317224585a.13.2025.09.26.11.10.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 11:10:20 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Junlong Wang <wang.junlong1@zte.com.cn>, Lijie Shan <shan.lijie@zte.com.cn>
Subject: [PATCH] net/zxdh: avoid use of rte_memcpy
Date: Fri, 26 Sep 2025 11:10:17 -0700
Message-ID: <20250926181017.470585-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.3
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
 drivers/net/zxdh/zxdh_flow.c | 53 ++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 30 deletions(-)

diff --git a/drivers/net/zxdh/zxdh_flow.c b/drivers/net/zxdh/zxdh_flow.c
index 7a2e20ac39..1167f53641 100644
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
@@ -1328,14 +1328,11 @@ static int fd_flow_parse_pattern(struct rte_eth_dev *dev, const struct rte_flow_
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
+
+				memcpy((uint32_t *)key->src_ip + 3, &ipv4_spec->hdr.src_addr, 4);
+				memcpy((uint32_t *)key->dst_ip + 3, &ipv4_spec->hdr.dst_addr, 4);
+				memcpy((uint32_t *)key_mask->src_ip + 3, &ipv4_mask->hdr.src_addr, 4);
+				memcpy((uint32_t *)key_mask->dst_ip + 3, &ipv4_mask->hdr.dst_addr, 4);
 			}
 			break;
 		case RTE_FLOW_ITEM_TYPE_IPV6:
@@ -1364,14 +1361,10 @@ static int fd_flow_parse_pattern(struct rte_eth_dev *dev, const struct rte_flow_
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
@@ -1477,8 +1470,8 @@ static int fd_flow_parse_pattern(struct rte_eth_dev *dev, const struct rte_flow_
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
@@ -1573,10 +1566,10 @@ fd_flow_parse_vxlan_encap(struct rte_eth_dev *dev __rte_unused,
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
@@ -1592,9 +1585,9 @@ fd_flow_parse_vxlan_encap(struct rte_eth_dev *dev __rte_unused,
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
@@ -1603,7 +1596,7 @@ fd_flow_parse_vxlan_encap(struct rte_eth_dev *dev __rte_unused,
 					(item_ipv6->hdr.vtc_flow & RTE_IPV6_HDR_TC_MASK) >>
 						RTE_IPV6_HDR_TC_SHIFT;
 			dh_flow->encap0.ttl = item_ipv6->hdr.hop_limits;
-			rte_memcpy(dh_flow->encap1.sip.ip_addr, &item_ipv6->hdr.src_addr, 16);
+			memcpy(dh_flow->encap1.sip.ip_addr, &item_ipv6->hdr.src_addr, 16);
 			dh_flow->encap1.sip.ip_addr[0] =
 				rte_bswap32(dh_flow->encap1.sip.ip_addr[0]);
 			dh_flow->encap1.sip.ip_addr[1] =
@@ -1612,7 +1605,7 @@ fd_flow_parse_vxlan_encap(struct rte_eth_dev *dev __rte_unused,
 				rte_bswap32(dh_flow->encap1.sip.ip_addr[2]);
 			dh_flow->encap1.sip.ip_addr[3] =
 				rte_bswap32(dh_flow->encap1.sip.ip_addr[3]);
-			rte_memcpy(dh_flow->encap0.dip.ip_addr, &item_ipv6->hdr.dst_addr, 16);
+			memcpy(dh_flow->encap0.dip.ip_addr, &item_ipv6->hdr.dst_addr, 16);
 			dh_flow->encap0.dip.ip_addr[0] =
 					rte_bswap32(dh_flow->encap0.dip.ip_addr[0]);
 			dh_flow->encap0.dip.ip_addr[1] =
@@ -1884,7 +1877,7 @@ vf_flow_msg_process(enum zxdh_msg_type msg_type, struct rte_eth_dev *dev,
 	struct zxdh_flow_op_rsp *flow_rsp = (struct zxdh_flow_op_rsp *)flow_op_rsp;
 
 	dh_flow->hash_search_index = hw->hash_search_index;
-	rte_memcpy(&flow_msg->dh_flow, dh_flow, sizeof(struct zxdh_flow));
+	flow_msg->dh_flow = *dh_flow;
 
 	zxdh_msg_head_build(hw, msg_type, &msg_info);
 	ret = zxdh_vf_send_msg_to_pf(dev, &msg_info, sizeof(struct zxdh_msg_info),
@@ -1909,7 +1902,7 @@ vf_flow_msg_process(enum zxdh_msg_type msg_type, struct rte_eth_dev *dev,
 	if (msg_type == ZXDH_FLOW_HW_ADD)
 		dh_flow->flowentry.hw_idx = flow_rsp->dh_flow.flowentry.hw_idx;
 	if (count)
-		rte_memcpy((void *)count, &flow_rsp->count, sizeof(flow_rsp->count));
+		memcpy((void *)count, &flow_rsp->count, sizeof(flow_rsp->count));
 
 	return ret;
 }
-- 
2.47.3

