Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB7BE92717
	for <dpdk-dev@archiver.kernel.org>; Sat, 27 Dec 2025 17:42:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D36AB402B7;
	Sat, 27 Dec 2025 18:42:55 +0100 (CET)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by mails.dpdk.org (Postfix) with ESMTP id 6420740297
 for <dev@dpdk.org>; Sat, 27 Dec 2025 18:42:54 +0100 (CET)
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-7b8eff36e3bso12683921b3a.2
 for <dev@dpdk.org>; Sat, 27 Dec 2025 09:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766857373; x=1767462173; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sDxUJxqGYS8+rrcHmqNoKehnLVPieRjphyvB2l4tJuM=;
 b=JNtw72ipwZUA607yJJyjTitJzhblVm2gFOuuft74NH+XS7FmOGx7L5phyDHqLuHOkS
 4B/7lk5sH5rb3fpz20YrLsE32MGJw8JWyNxIfXGtJ55KToIFtuet8tyBVpw6cX3giPm6
 /xNBT/GIse0noRF++9U89UuVNIaLUNfEP9lmMpO/tLmWXb1ai9JW6qHXQ37oPEGn2JDd
 /kP9V10wytOt8RXq57x0Rj+HGpOslztwG0MNk5OsbVtCcaq7Y9VQG+0vh1q7LL7saHFD
 WjKocOUNa1jHcGk2S93pXlKZZKt27fGltGCGIFp03vtYHHm+uSkl7ME2E6lSk3VgAYKa
 UuaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766857373; x=1767462173;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sDxUJxqGYS8+rrcHmqNoKehnLVPieRjphyvB2l4tJuM=;
 b=W2Og6m9VMzwoHGIliOMx06lMRH57TG9oX0rSF/z7Z4KS+zHtw3VDkBvqLPGok6gZFT
 tdqGBgcLMBGyw/mNyxdF8+ts2cFnPDhxipy0QosQS40AM7l0P8uRErcdilCnF7YmcYZc
 hZb+qs/abGONl0XpOGAckXbbfNSE66aVpAaDcM1zeparzcQ364GDhFyp/pg+ytkGN/bA
 ac2TWqVDWXrHp9eRQvOCr4BdZ+0jdgQR1dqNGQEbqHKoKe+nKz+67FJ9hjfVPky+mroW
 k57pe+RC4Oi8md93Wj/D3TJGuenIg36Y09xuCdqQ0o+Tr8AZiXgOuMWqi1B4p5rGrEsh
 8Z+A==
X-Gm-Message-State: AOJu0YzIv6PB8WNyjapekqvxQoRvKJwGsDXpEfQQSwmYZrn929TGhN58
 KFJKVZlKorEAgJiGGpaMW0rwi3+Sq1hLCKvxFCydzP3IvObzCgoK8sb1Qh1bYk+t
X-Gm-Gg: AY/fxX6NNd/7XcUPZRR+6MbA/goyboJQWJOf56TRPXOZ2IiRCDwMg62pwUrIzvB+eKc
 WJAo6aHYmN7yihSE2MGfRB+sOQqz1p4EMJ6eRx5wnVrmkzF9eu3GMdVYr2kMwqaGf14nv6VbvEy
 N2z0qqrunY/9UIq/Udq7jASaLghpaldlauwkU259vXuLwM2KgsyTx9fB48Sc7ho/j4CufHFq+Va
 MjABSm3l9XKTyDttp9U79GJr+QRCY2i50T1lmIODe+92alSsvW6xxab7a3vkcWHmX5QpZL4rLJl
 Y5eCTEFOovJPYdc1psYJMiPgk96JwUrO8ZZy40Pu9IR3OVADM6oQVu9jVSwondtMyibmRfB3yyw
 KqjkMVdyJ6atpYJvpJ8Zf3kRcxUy2h8wSyBX/e8s1ctPCMis/c5qP0kpK4cyIi30dXlCAL7G/TH
 hOy6THj2sW5AcY0T8w+JNbFQ8dTYETjX0YXPqvnC3sXBVsT0qD
X-Google-Smtp-Source: AGHT+IH4RI7Epe2uhglXdSjT/dBEZha/1wM2sMVZGRQhf71b2hbK5bMZEXHyTta37FdqLPXFi9QE5A==
X-Received: by 2002:aa7:9906:0:b0:7ff:da9b:bd82 with SMTP id
 d2e1a72fcca58-7ffda9bbf79mr16968135b3a.40.1766857372585; 
 Sat, 27 Dec 2025 09:42:52 -0800 (PST)
Received: from Param-Desktop.localdomain ([106.51.222.111])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-80c255162d5sm1639954b3a.1.2025.12.27.09.42.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 09:42:51 -0800 (PST)
From: Kumara Parameshwaran <kumaraparamesh92@gmail.com>
To: dev@dpdk.org
Cc: Kumara Parameshwaran <kumaraparamesh92@gmail.com>
Subject: [PATCH v3] gro : improve GRO performance based on hash table
Date: Sat, 27 Dec 2025 23:12:21 +0530
Message-Id: <20251227174221.277640-1-kumaraparamesh92@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251116060634.262352-1-kumaraparamesh92@gmail.com>
References: <20251116060634.262352-1-kumaraparamesh92@gmail.com>
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

Use cuckoo hash library in GRO for flow flookup

Signed-off-by: Kumara Parameshwaran <kumaraparamesh92@gmail.com>
---

v3 - address review comments for the test file

 app/test/test_gro.c | 795 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 630 insertions(+), 165 deletions(-)

diff --git a/app/test/test_gro.c b/app/test/test_gro.c
index 3bd0035e68..7ce0c4563a 100644
--- a/app/test/test_gro.c
+++ b/app/test/test_gro.c
@@ -2,6 +2,9 @@
  * Copyright(c) 2018 Intel Corporation
  */
 
+#include <time.h>
+#include <string.h>
+
 #include "test.h"
 
 #include <rte_net.h>
@@ -10,81 +13,615 @@
 #define NUM_MBUFS 128
 #define BURST 32
 
-/*
- * Sample TCP/IPv4 packets from Iperf run
- * Each packet is 132 bytes long and TCP segment is 66 bytes long
- *
- * 10.1.0.4:52362=>10.1.0.5:5201 Seq = 4251552885 Ack = 428268870
- */
-unsigned char pkts[][132] = {
-	{
-		0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc, 0x7c, 0xed, 0x8d, 0xc0,
-		0xc1, 0xf5, 0x8, 0x0, 0x45, 0x0, 0x0, 0x76, 0xa4, 0xfb, 0x40,
-		0x0, 0x40, 0x6, 0x81, 0x7c, 0xa, 0x1, 0x0, 0x4, 0xa, 0x1, 0x0,
-		0x5, 0xcc, 0x8a, 0x14, 0x51, 0xfd, 0x69, 0x8c, 0x75, 0x19, 0x86,
-		0xdd, 0x46, 0x80, 0x10, 0x2, 0x0, 0x14, 0x73, 0x0, 0x0, 0x1, 0x1,
-		0x8, 0xa, 0x3c, 0x2, 0xd1, 0xa5, 0x36, 0xb6, 0x9e, 0xda, 0x7d, 0xe9,
-		0x63, 0xf1, 0x67, 0xeb, 0xc4, 0x93, 0xcf, 0x74, 0xcd, 0xab, 0x93,
-		0x86, 0xe8, 0xb0, 0x1c, 0x92, 0xc8, 0x82, 0xef, 0x72, 0x34, 0xe7, 0x86,
-		0x6d, 0xd2, 0x96, 0x8, 0x70, 0xae, 0xda, 0x60, 0xe4, 0x25, 0x39, 0xd2,
-		0x73, 0xe7, 0xef, 0xf5, 0xf6, 0x7f, 0xbf, 0x7f, 0x5, 0x5a, 0x40, 0x6,
-		0x65, 0x13, 0x8f, 0xa4, 0x7, 0x73, 0x41, 0xcb, 0x56, 0x3, 0x15, 0x85,
-		0x99, 0x8c, 0xa9, 0xc8, 0x14
-	},
-	{
-		0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc, 0x7c, 0xed, 0x8d, 0xc0, 0xc1,
-		0xf5, 0x8, 0x0, 0x45, 0x0, 0x0, 0x76, 0xa4, 0xfc, 0x40, 0x0, 0x40,
-		0x6, 0x81, 0x7b, 0xa, 0x1, 0x0, 0x4, 0xa, 0x1, 0x0, 0x5, 0xcc, 0x8a,
-		0x14, 0x51, 0xfd, 0x69, 0x8c, 0xb7, 0x19, 0x86, 0xdd, 0x46, 0x80, 0x10,
-		0x2, 0x0, 0x14, 0x73, 0x0, 0x0, 0x1, 0x1, 0x8, 0xa, 0x3c, 0x2, 0xd1, 0xa5,
-		0x36, 0xb6, 0x9e, 0xda, 0x2a, 0x6a, 0x4e, 0xf9, 0x94, 0x6, 0xaf, 0x2f, 0xeb,
-		0xfb, 0xef, 0xa4, 0xaa, 0xe8, 0xd6, 0xc0, 0x34, 0xab, 0x8b, 0xfc, 0x14, 0xb9,
-		0x89, 0xcb, 0xb6, 0x15, 0x58, 0xe5, 0x2a, 0x72, 0xcd, 0x1c, 0x71, 0x3, 0xf4,
-		0xf9, 0x32, 0x7e, 0x58, 0xec, 0xe6, 0x52, 0x5a, 0x88, 0x8c, 0x24, 0x53, 0xd7,
-		0x39, 0x80, 0xb6, 0x66, 0x9b, 0xe5, 0x45, 0xbe, 0x9, 0xf8, 0xac, 0xef, 0xc2,
-		0x51, 0x31, 0x87, 0x9c, 0x56
-	},
-	{
-		0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc, 0x7c, 0xed, 0x8d, 0xc0, 0xc1, 0xf5, 0x8,
-		0x0, 0x45, 0x0, 0x0, 0x76, 0xa4, 0xfd, 0x40, 0x0, 0x40, 0x6, 0x81, 0x7a, 0xa,
-		0x1, 0x0, 0x4, 0xa, 0x1, 0x0, 0x5, 0xcc, 0x8a, 0x14, 0x51, 0xfd, 0x69, 0x8c,
-		0xf9, 0x19, 0x86, 0xdd, 0x46, 0x80, 0x10, 0x2, 0x0, 0x14, 0x73, 0x0, 0x0, 0x1,
-		0x1, 0x8, 0xa, 0x3c, 0x2, 0xd1, 0xa5, 0x36, 0xb6, 0x9e, 0xda, 0x68, 0x93, 0xec,
-		0x8a, 0x35, 0xba, 0xe8, 0x24, 0x9e, 0x78, 0x6c, 0xb8, 0x65, 0xe1, 0x23, 0xc1, 0x48,
-		0x5, 0xca, 0xea, 0x6b, 0x5, 0xe7, 0x71, 0x1a, 0x97, 0x5a, 0x23, 0xd2, 0x81, 0xc9,
-		0x9a, 0xad, 0x1e, 0x77, 0xb1, 0x9c, 0x43, 0xf, 0xbf, 0x6c, 0xb6, 0x36, 0x46,
-		0x99, 0xcc, 0x4, 0xf4, 0xc2, 0x87, 0x41, 0xec, 0xc6, 0xc5, 0xd9, 0x48, 0xcf,
-		0x9b, 0xec, 0xb7, 0x2f, 0x91, 0x5f, 0x83, 0x9f, 0xd
-	},
-	{
-		0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc, 0x7c, 0xed, 0x8d, 0xc0, 0xc1, 0xf5, 0x8, 0x0,
-		0x45, 0x0, 0x0, 0x76, 0xa4, 0xfe, 0x40, 0x0, 0x40, 0x6, 0x81, 0x79, 0xa, 0x1, 0x0,
-		0x4, 0xa, 0x1, 0x0, 0x5, 0xcc, 0x8a, 0x14, 0x51, 0xfd, 0x69, 0x8d, 0x3b, 0x19, 0x86,
-		0xdd, 0x46, 0x80, 0x10, 0x2, 0x0, 0x14, 0x73, 0x0, 0x0, 0x1, 0x1, 0x8, 0xa, 0x3c,
-		0x2, 0xd1, 0xa5, 0x36, 0xb6, 0x9e, 0xda, 0xdd, 0x72, 0x54, 0xdc, 0x5, 0x51, 0xb6,
-		0x4b, 0xdd, 0x10, 0xfb, 0x1c, 0xe8, 0x5d, 0x84, 0x75, 0xd7, 0x20, 0xd3, 0xc, 0xbd,
-		0xba, 0x77, 0x1a, 0x14, 0x41, 0x15, 0xd0, 0x34, 0x64, 0x8d, 0x6, 0x32, 0x8f, 0x83,
-		0x3e, 0xd6, 0xf, 0xaa, 0xe1, 0x7e, 0xdc, 0xbe, 0x33, 0x43, 0xc6, 0x38, 0xcf, 0x9b,
-		0x6f, 0xf2, 0x1e, 0x50, 0x6f, 0xf3, 0x3b, 0x8f, 0xbf, 0x18, 0x60, 0xd5, 0x43, 0xac,
-		0xd2, 0xbb, 0x49
-	},
-	{
-		0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc, 0x7c, 0xed, 0x8d, 0xc0, 0xc1, 0xf5, 0x8, 0x0,
-		0x45, 0x0, 0x0, 0x76, 0xa4, 0xff, 0x40, 0x0, 0x40, 0x6, 0x81, 0x78, 0xa, 0x1, 0x0,
-		0x4, 0xa, 0x1, 0x0, 0x5, 0xcc, 0x8a, 0x14, 0x51, 0xfd, 0x69, 0x8d, 0x7d, 0x19, 0x86,
-		0xdd, 0x46, 0x80, 0x18, 0x2, 0x0, 0x14, 0x73, 0x0, 0x0, 0x1, 0x1, 0x8, 0xa, 0x3c,
-		0x2, 0xd1, 0xa5, 0x36, 0xb6, 0x9e, 0xda, 0x5a, 0x95, 0x20, 0xf2, 0x20, 0x9b, 0xd,
-		0xc1, 0x9, 0xe5, 0x3, 0x68, 0x52, 0x14, 0x2c, 0x7c, 0x98, 0x44, 0x63, 0x6c, 0xc6,
-		0xe6, 0xba, 0x8a, 0x0, 0x10, 0x66, 0x45, 0xb1, 0xfd, 0x7b, 0x77, 0xf1, 0xf9, 0x95,
-		0xcd, 0x7f, 0x61, 0x12, 0xeb, 0xa5, 0x23, 0xa0, 0x2, 0xe5, 0x31, 0xd8, 0x1f, 0x36,
-		0x55, 0x59, 0x46, 0xce, 0x9f, 0xd2, 0x74, 0x6b, 0xf9, 0x63, 0xbe, 0xa1, 0xed, 0xc5,
-		0x59, 0x22, 0x8c
-	}
-};
-
 void *gro_tcp4_ctx;
 static struct rte_mempool *pkt_pool;
 
+struct flow_params {
+	uint32_t src_ip;
+	uint32_t dst_ip;
+	uint16_t src_port;
+	uint16_t dst_port;
+	uint32_t seq;
+};
+
+static void build_ether_hdr(struct rte_ether_hdr *eth, struct rte_ether_addr *src,
+	struct rte_ether_addr *dst)
+{
+	rte_ether_addr_copy(src, &eth->src_addr);
+	rte_ether_addr_copy(dst, &eth->dst_addr);
+	eth->ether_type = rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV4);
+}
+
+static void build_ipv4_hdr(struct rte_ipv4_hdr *ip, uint32_t src_ip, uint32_t dst_ip,
+	uint16_t payload_len, uint16_t id)
+{
+	ip->version_ihl = RTE_IPV4_VHL_DEF;
+	ip->type_of_service = 0;
+	ip->total_length = rte_cpu_to_be_16(sizeof(struct rte_ipv4_hdr) +
+							sizeof(struct rte_tcp_hdr) + payload_len);
+	ip->packet_id = rte_cpu_to_be_16(id);
+	ip->fragment_offset = 0;
+	ip->time_to_live = 64;
+	ip->next_proto_id = IPPROTO_TCP;
+	ip->src_addr = rte_cpu_to_be_32(src_ip);
+	ip->dst_addr = rte_cpu_to_be_32(dst_ip);
+	ip->hdr_checksum = 0;
+}
+
+static void build_tcp_hdr(struct rte_tcp_hdr *tcp, uint16_t src_port, uint16_t dst_port,
+	uint32_t seq, uint32_t ack, uint8_t tcp_flags)
+{
+	tcp->src_port = rte_cpu_to_be_16(src_port);
+	tcp->dst_port = rte_cpu_to_be_16(dst_port);
+	tcp->sent_seq = rte_cpu_to_be_32(seq);
+	tcp->recv_ack = rte_cpu_to_be_32(ack);
+	tcp->data_off = (sizeof(struct rte_tcp_hdr) / 4) << 4;
+	tcp->tcp_flags = tcp_flags;
+	tcp->rx_win = rte_cpu_to_be_16(65535);
+	tcp->cksum = 0;
+	tcp->tcp_urp = 0;
+}
+
+static void fill_payload(char *payload, size_t len, uint8_t *ref)
+{
+	for (size_t i = 0; i < len; i++) {
+		uint8_t val = rand() % 256;
+		payload[i] = val;
+		if (ref)
+			ref[i] = val;
+	}
+}
+
+static int validate_merged_payload(struct rte_mbuf *mbuf, uint8_t *ref_payload,
+	uint16_t ref_payload_len, uint num_segments)
+{
+	struct rte_tcp_hdr *tcp = rte_pktmbuf_mtod_offset(mbuf, struct rte_tcp_hdr *,
+		sizeof(struct rte_ether_hdr) + sizeof(struct rte_ipv4_hdr));
+	uint8_t *merged_payload = (uint8_t *)tcp + sizeof(struct rte_tcp_hdr);
+	int mbuf_segments = mbuf->nb_segs;
+
+	TEST_ASSERT(num_segments == mbuf->nb_segs, "Number of segments mismatch");
+
+	for (int i = 0; i < mbuf_segments; i++) {
+		if (memcmp(merged_payload, ref_payload, ref_payload_len) != 0) {
+			TEST_ASSERT(false, "Merged payload validation failed %d", num_segments);
+			return TEST_FAILED;
+		}
+		num_segments--;
+		ref_payload += ref_payload_len;
+		mbuf = mbuf->next;
+		if (mbuf)
+			merged_payload = rte_pktmbuf_mtod_offset(mbuf, uint8_t *, 0);
+	}
+	TEST_ASSERT(num_segments == 0, "Not all segments validated");
+
+	return TEST_SUCCESS;
+}
+
+static int validate_packet_headers(struct rte_mbuf *mbuf,
+	struct rte_ether_addr *exp_src_mac, struct rte_ether_addr *exp_dst_mac,
+	uint32_t exp_src_ip, uint32_t exp_dst_ip,
+	uint16_t exp_src_port, uint16_t exp_dst_port,
+	uint32_t exp_seq, uint32_t exp_ack, uint8_t exp_tcp_flags)
+{
+	struct rte_ether_hdr *eth = rte_pktmbuf_mtod(mbuf, struct rte_ether_hdr *);
+	struct rte_ipv4_hdr *ip = rte_pktmbuf_mtod_offset(mbuf, struct rte_ipv4_hdr *,
+		sizeof(struct rte_ether_hdr));
+	struct rte_tcp_hdr *tcp = rte_pktmbuf_mtod_offset(mbuf, struct rte_tcp_hdr *,
+		sizeof(struct rte_ether_hdr) + sizeof(struct rte_ipv4_hdr));
+
+	if (exp_src_mac)
+		TEST_ASSERT_BUFFERS_ARE_EQUAL(eth->src_addr.addr_bytes, exp_src_mac->addr_bytes,
+			RTE_ETHER_ADDR_LEN, "SRC MAC mismatch");
+	if (exp_dst_mac)
+		TEST_ASSERT_BUFFERS_ARE_EQUAL(eth->dst_addr.addr_bytes, exp_dst_mac->addr_bytes,
+			RTE_ETHER_ADDR_LEN, "DST MAC mismatch");
+
+	if (exp_src_ip)
+		TEST_ASSERT(rte_be_to_cpu_32(ip->src_addr) == exp_src_ip, "IPv4 SRC mismatch");
+	if (exp_dst_ip)
+		TEST_ASSERT(rte_be_to_cpu_32(ip->dst_addr) == exp_dst_ip, "IPv4 DST mismatch");
+
+	if (exp_src_port)
+		TEST_ASSERT(rte_be_to_cpu_16(tcp->src_port) == exp_src_port, "TCP SRC port mismatch");
+	if (exp_dst_port)
+		TEST_ASSERT(rte_be_to_cpu_16(tcp->dst_port) == exp_dst_port, "TCP DST port mismatch");
+	if (exp_seq)
+		TEST_ASSERT(rte_be_to_cpu_32(tcp->sent_seq) == exp_seq, "TCP SEQ mismatch");
+
+	TEST_ASSERT(rte_be_to_cpu_32(tcp->recv_ack) == exp_ack, "TCP ACK mismatch");
+
+	if (exp_tcp_flags)
+		TEST_ASSERT(tcp->tcp_flags == exp_tcp_flags, "TCP FLAGS mismatch");
+
+	return TEST_SUCCESS;
+}
+
+/* Test single flow with multiple TCP segments with only ACK flag set */
+static int32_t test_tcp4_single_flow_multi_segment(void)
+{
+	struct rte_mbuf *pkts_mb[5];
+	struct rte_mbuf *gro_pkts[5];
+	int nb_pkts, nb_gro_pkts;
+	uint32_t seq = 1000;
+	uint16_t src_port = 12345, dst_port = 80;
+	uint32_t src_ip = RTE_IPV4(192, 168, 0, 1), dst_ip = RTE_IPV4(192, 168, 0, 2);
+	struct rte_ether_addr src_mac = {.addr_bytes = {0x00, 0x11, 0x22, 0x33, 0x44, 0x55} };
+	struct rte_ether_addr dst_mac = {.addr_bytes = {0x66, 0x77, 0x88, 0x99, 0xaa, 0xbb} };
+	uint8_t ref_payload[5][1400];
+	struct rte_ether_hdr *eth;
+	struct rte_ipv4_hdr *ip;
+	struct rte_tcp_hdr *tcp;
+	char *data;
+
+	srand(time(NULL));
+
+	/* Create 5 segments of 1400 bytes each */
+	for (int i = 0; i < 5; i++) {
+		pkts_mb[i] = rte_pktmbuf_alloc(pkt_pool);
+		if (!pkts_mb[i])
+			return TEST_FAILED;
+		eth = (struct rte_ether_hdr *)rte_pktmbuf_append(pkts_mb[i],
+					sizeof(struct rte_ether_hdr));
+		if (!eth)
+			return TEST_FAILED;
+		build_ether_hdr(eth, &src_mac, &dst_mac);
+		ip = (struct rte_ipv4_hdr *)rte_pktmbuf_append(pkts_mb[i],
+				sizeof(struct rte_ipv4_hdr));
+		if (!ip)
+			return TEST_FAILED;
+		build_ipv4_hdr(ip, src_ip, dst_ip, 1400, i);
+		tcp = (struct rte_tcp_hdr *)rte_pktmbuf_append(pkts_mb[i],
+				sizeof(struct rte_tcp_hdr));
+		if (!tcp)
+			return TEST_FAILED;
+		build_tcp_hdr(tcp, src_port, dst_port, seq + i * 1400, 0, RTE_TCP_ACK_FLAG);
+		data = rte_pktmbuf_append(pkts_mb[i], 1400);
+		if (!data)
+			return TEST_FAILED;
+		fill_payload(data, 1400, ref_payload[i]);
+		pkts_mb[i]->packet_type = RTE_PTYPE_L2_ETHER | RTE_PTYPE_L3_IPV4 | RTE_PTYPE_L4_TCP;
+		pkts_mb[i]->l2_len = sizeof(struct rte_ether_hdr);
+		pkts_mb[i]->l3_len = sizeof(struct rte_ipv4_hdr);
+		pkts_mb[i]->l4_len = sizeof(struct rte_tcp_hdr);
+	}
+
+	/* GRO reassembly and all packets should be merged */
+	nb_pkts = rte_gro_reassemble(pkts_mb, 5, gro_tcp4_ctx);
+	TEST_ASSERT(nb_pkts == 0, "Expected 0 packets after GRO reassemble");
+	TEST_ASSERT(rte_gro_get_pkt_count(gro_tcp4_ctx) == 1, "GRO pkt count should be 1");
+
+	/* Perform GRO timeout flush */
+	nb_gro_pkts = rte_gro_timeout_flush(gro_tcp4_ctx, 0, RTE_GRO_TCP_IPV4, gro_pkts, 5);
+	TEST_ASSERT(nb_gro_pkts == 1, "GRO timeout flush should return 1 packet");
+	TEST_ASSERT(rte_gro_get_pkt_count(gro_tcp4_ctx) == 0, "GRO pkt count after flush should be 0");
+	TEST_ASSERT(gro_pkts[0]->pkt_len == 5 * 1400 +
+				sizeof(struct rte_ether_hdr) + sizeof(struct rte_ipv4_hdr) +
+				sizeof(struct rte_tcp_hdr), "GRO merged pkt length mismatch");
+
+	/* Validate headers */
+	TEST_ASSERT(validate_packet_headers(gro_pkts[0], &src_mac, &dst_mac, src_ip, dst_ip,
+		src_port, dst_port, seq, 0, RTE_TCP_ACK_FLAG) == TEST_SUCCESS, "Header validation failed");
+
+	/* Validate merged payload */
+	TEST_ASSERT(validate_merged_payload(gro_pkts[0],
+			(uint8_t *)ref_payload, 1400, 5) == TEST_SUCCESS, "Merged payload validation failed");
+
+	return TEST_SUCCESS;
+}
+
+/* Test single flow with multiple TCP segments with PSH flag set on the last segment */
+static int32_t test_tcp4_with_psh_flag(void)
+{
+	struct rte_mbuf *pkts_mb[4];
+	struct rte_mbuf *gro_pkts[4];
+	int nb_pkts, nb_gro_pkts;
+	uint32_t seq = 2000;
+	uint16_t src_port = 54321, dst_port = 8080;
+	uint32_t src_ip = RTE_IPV4(10, 0, 0, 1), dst_ip = RTE_IPV4(10, 0, 0, 2);
+	struct rte_ether_addr src_mac = {.addr_bytes = {0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff} };
+	struct rte_ether_addr dst_mac = {.addr_bytes = {0x11, 0x22, 0x33, 0x44, 0x55, 0x66} };
+	uint8_t ref_payload[4][1400];
+	struct rte_ether_hdr *eth;
+	struct rte_ipv4_hdr *ip;
+	struct rte_tcp_hdr *tcp;
+	char *data;
+
+	srand(time(NULL));
+
+	for (int i = 0; i < 4; i++) {
+		pkts_mb[i] = rte_pktmbuf_alloc(pkt_pool);
+		if (!pkts_mb[i])
+			return TEST_FAILED;
+		eth = (struct rte_ether_hdr *)rte_pktmbuf_append(pkts_mb[i],
+				sizeof(struct rte_ether_hdr));
+		if (!eth)
+			return TEST_FAILED;
+		build_ether_hdr(eth, &src_mac, &dst_mac);
+		ip = (struct rte_ipv4_hdr *)rte_pktmbuf_append(pkts_mb[i],
+				sizeof(struct rte_ipv4_hdr));
+		if (!ip)
+			return TEST_FAILED;
+		build_ipv4_hdr(ip, src_ip, dst_ip, 1400, i);
+		tcp = (struct rte_tcp_hdr *)rte_pktmbuf_append(pkts_mb[i],
+				sizeof(struct rte_tcp_hdr));
+		if (!tcp)
+			return TEST_FAILED;
+		/* First 3 segments: ACK flag only, last segment: ACK + PSH flags */
+		uint8_t tcp_flags = (i == 3) ? (RTE_TCP_ACK_FLAG | RTE_TCP_PSH_FLAG)
+							: RTE_TCP_ACK_FLAG;
+		build_tcp_hdr(tcp, src_port, dst_port, seq + i * 1400, 0, tcp_flags);
+		data = rte_pktmbuf_append(pkts_mb[i], 1400);
+		if (!data)
+			return TEST_FAILED;
+		fill_payload(data, 1400, ref_payload[i]);
+
+		pkts_mb[i]->packet_type = RTE_PTYPE_L2_ETHER | RTE_PTYPE_L3_IPV4 | RTE_PTYPE_L4_TCP;
+		pkts_mb[i]->l2_len = sizeof(struct rte_ether_hdr);
+		pkts_mb[i]->l3_len = sizeof(struct rte_ipv4_hdr);
+		pkts_mb[i]->l4_len = sizeof(struct rte_tcp_hdr);
+	}
+
+	/* GRO reassemble and all packets should be merged */
+	nb_pkts = rte_gro_reassemble(pkts_mb, 4, gro_tcp4_ctx);
+	TEST_ASSERT(nb_pkts == 0, "Expected 0 packets after GRO reassemble");
+	TEST_ASSERT(rte_gro_get_pkt_count(gro_tcp4_ctx) == 1, "GRO pkt count should be 1");
+
+	/* Perform GRO timeout flush */
+	nb_gro_pkts = rte_gro_timeout_flush(gro_tcp4_ctx, 0, RTE_GRO_TCP_IPV4, gro_pkts, 4);
+	TEST_ASSERT(nb_gro_pkts == 1, "GRO timeout flush should return 1 packet");
+	TEST_ASSERT(rte_gro_get_pkt_count(gro_tcp4_ctx) == 0, "GRO pkt count after flush should be 0");
+	TEST_ASSERT(gro_pkts[0]->pkt_len == 4 * 1400 +
+					sizeof(struct rte_ether_hdr) + sizeof(struct rte_ipv4_hdr) +
+					sizeof(struct rte_tcp_hdr), "GRO merged pkt length mismatch");
+
+	/* Validate headers */
+	TEST_ASSERT(validate_packet_headers(gro_pkts[0], &src_mac, &dst_mac, src_ip, dst_ip,
+					src_port, dst_port, seq, 0,
+					RTE_TCP_ACK_FLAG | RTE_TCP_PSH_FLAG) ==
+					TEST_SUCCESS, "Header validation failed");
+
+	/* Validate merged payload */
+	TEST_ASSERT(validate_merged_payload(gro_pkts[0],
+		(uint8_t *)ref_payload, 1400, 4) == TEST_SUCCESS, "Merged payload validation failed");
+
+	return TEST_SUCCESS;
+}
+
+/*	Test multiple flows with multiple TCP segments each */
+static int32_t test_tcp4_multiple_flows(void)
+{
+	#define NUM_FLOWS 8
+	#define SEGS_PER_FLOW 4
+	#define TOTAL_PKTS (NUM_FLOWS * SEGS_PER_FLOW)
+
+	struct rte_mbuf *pkts_mb[TOTAL_PKTS];
+	struct rte_mbuf *gro_pkts[TOTAL_PKTS];
+	int nb_pkts, nb_gro_pkts;
+	uint8_t ref_payload[NUM_FLOWS][SEGS_PER_FLOW][1400];
+	struct rte_ether_addr src_mac = {.addr_bytes = {0x00, 0x11, 0x22, 0x33, 0x44, 0x55} };
+	struct rte_ether_addr dst_mac = {.addr_bytes = {0x66, 0x77, 0x88, 0x99, 0xaa, 0xbb} };
+	struct rte_ether_hdr *eth;
+	struct rte_ipv4_hdr *ip;
+	struct rte_tcp_hdr *tcp;
+	char *data;
+	/* Define 8 different flows with different src/dst IPs and ports */
+	struct flow_params flows[NUM_FLOWS] = {
+		{RTE_IPV4(192, 168, 1, 10), RTE_IPV4(192, 168, 1, 20), 50000, 80, 1000},
+		{RTE_IPV4(192, 168, 1, 11), RTE_IPV4(192, 168, 1, 21), 50001, 80, 2000},
+		{RTE_IPV4(192, 168, 1, 12), RTE_IPV4(192, 168, 1, 22), 50002, 80, 3000},
+		{RTE_IPV4(192, 168, 1, 13), RTE_IPV4(192, 168, 1, 23), 50003, 80, 4000},
+		{RTE_IPV4(192, 168, 1, 14), RTE_IPV4(192, 168, 1, 24), 50004, 80, 5000},
+		{RTE_IPV4(192, 168, 1, 15), RTE_IPV4(192, 168, 1, 25), 50005, 80, 6000},
+		{RTE_IPV4(192, 168, 1, 16), RTE_IPV4(192, 168, 1, 26), 50006, 80, 7000},
+		{RTE_IPV4(192, 168, 1, 17), RTE_IPV4(192, 168, 1, 27), 50007, 80, 8000},
+	};
+
+	srand(time(NULL));
+
+	for (int flow = 0; flow < NUM_FLOWS; flow++) {
+		for (int seg = 0; seg < SEGS_PER_FLOW; seg++) {
+			int pkt_idx = (flow * SEGS_PER_FLOW) + seg;
+			pkts_mb[pkt_idx] = rte_pktmbuf_alloc(pkt_pool);
+			if (!pkts_mb[pkt_idx])
+				return TEST_FAILED;
+			eth = (struct rte_ether_hdr *)rte_pktmbuf_append(pkts_mb[pkt_idx],
+					sizeof(struct rte_ether_hdr));
+			if (!eth)
+				return TEST_FAILED;
+			build_ether_hdr(eth, &src_mac, &dst_mac);
+			ip = (struct rte_ipv4_hdr *)rte_pktmbuf_append(pkts_mb[pkt_idx],
+					sizeof(struct rte_ipv4_hdr));
+			if (!ip)
+				return TEST_FAILED;
+			build_ipv4_hdr(ip, flows[flow].src_ip, flows[flow].dst_ip, 1400, pkt_idx);
+			tcp = (struct rte_tcp_hdr *)rte_pktmbuf_append(pkts_mb[pkt_idx],
+					sizeof(struct rte_tcp_hdr));
+			if (!tcp)
+				return TEST_FAILED;
+			build_tcp_hdr(tcp, flows[flow].src_port, flows[flow].dst_port,
+				flows[flow].seq + seg * 1400, 0, RTE_TCP_ACK_FLAG);
+			data = rte_pktmbuf_append(pkts_mb[pkt_idx], 1400);
+			if (!data)
+				return TEST_FAILED;
+			fill_payload(data, 1400, ref_payload[flow][seg]);
+			pkts_mb[pkt_idx]->packet_type = RTE_PTYPE_L2_ETHER
+					| RTE_PTYPE_L3_IPV4 | RTE_PTYPE_L4_TCP;
+			pkts_mb[pkt_idx]->l2_len = sizeof(struct rte_ether_hdr);
+			pkts_mb[pkt_idx]->l3_len = sizeof(struct rte_ipv4_hdr);
+			pkts_mb[pkt_idx]->l4_len = sizeof(struct rte_tcp_hdr);
+		}
+	}
+
+	/* GRO reassemble all packets */
+	nb_pkts = rte_gro_reassemble(pkts_mb, TOTAL_PKTS, gro_tcp4_ctx);
+	TEST_ASSERT(nb_pkts == 0, "Expected 0 packets after GRO reassemble");
+	TEST_ASSERT(rte_gro_get_pkt_count(gro_tcp4_ctx) == NUM_FLOWS,
+		"GRO pkt count should be %d (one per flow)", NUM_FLOWS);
+
+	/* GRO timeout flush */
+	nb_gro_pkts = rte_gro_timeout_flush(gro_tcp4_ctx, 0, RTE_GRO_TCP_IPV4,
+						gro_pkts, TOTAL_PKTS);
+	TEST_ASSERT(nb_gro_pkts == NUM_FLOWS, "GRO timeout flush should return %d packets",
+				NUM_FLOWS);
+	TEST_ASSERT(rte_gro_get_pkt_count(gro_tcp4_ctx) == 0,
+				"GRO pkt count after flush should be 0");
+
+	/* Validate each merged flow */
+	for (int flow = 0; flow < NUM_FLOWS; flow++) {
+		struct rte_mbuf *merged_pkt = NULL;
+
+		/* Find the merged packet for this flow by checking IP addresses */
+		for (int i = 0; i < nb_gro_pkts; i++) {
+			struct rte_ipv4_hdr *ip = rte_pktmbuf_mtod_offset(gro_pkts[i],
+				struct rte_ipv4_hdr *, sizeof(struct rte_ether_hdr));
+			if (rte_be_to_cpu_32(ip->src_addr) == flows[flow].src_ip &&
+				rte_be_to_cpu_32(ip->dst_addr) == flows[flow].dst_ip) {
+				merged_pkt = gro_pkts[i];
+				break;
+			}
+		}
+
+		TEST_ASSERT(merged_pkt != NULL, "Could not find merged packet for flow %d", flow);
+
+		uint32_t expected_len = SEGS_PER_FLOW * 1400 + sizeof(struct rte_ether_hdr) +
+			sizeof(struct rte_ipv4_hdr) + sizeof(struct rte_tcp_hdr);
+		TEST_ASSERT(merged_pkt->pkt_len == expected_len,
+			"Flow %d: GRO merged pkt length mismatch (expected %u, got %u)",
+			flow, expected_len, merged_pkt->pkt_len);
+
+		/* Validate headers */
+		TEST_ASSERT(validate_packet_headers(merged_pkt, &src_mac, &dst_mac,
+			flows[flow].src_ip, flows[flow].dst_ip,
+			flows[flow].src_port, flows[flow].dst_port,
+			flows[flow].seq, 0, RTE_TCP_ACK_FLAG) == TEST_SUCCESS,
+			"Flow %d: Header validation failed", flow);
+
+		/* Validate merged payload */
+		TEST_ASSERT(validate_merged_payload(merged_pkt, (uint8_t *)ref_payload[flow],
+					1400, SEGS_PER_FLOW) == TEST_SUCCESS,
+			"Flow %d: Merged payload validation failed", flow);
+	}
+
+	return TEST_SUCCESS;
+}
+
+/* Test multiple flows with mixed TCP flags */
+static int32_t test_tcp4_mixed_flags(void)
+{
+	#define NUM_FLOWS 8
+	#define SEGS_PER_FLOW 4
+	#define TOTAL_PKTS (NUM_FLOWS * SEGS_PER_FLOW)
+
+	struct rte_mbuf *pkts_mb[TOTAL_PKTS];
+	struct rte_mbuf *gro_pkts[TOTAL_PKTS];
+	int nb_pkts, nb_gro_pkts;
+	uint8_t ref_payload[NUM_FLOWS][SEGS_PER_FLOW][1400];
+	struct rte_ether_addr src_mac = {.addr_bytes = {0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff} };
+	struct rte_ether_addr dst_mac = {.addr_bytes = {0x11, 0x22, 0x33, 0x44, 0x55, 0x66} };
+	struct rte_ether_hdr *eth;
+	struct rte_ipv4_hdr *ip;
+	struct rte_tcp_hdr *tcp;
+	char *data;
+	int payload_idx;
+	int seq;
+	int pkt_idx;
+
+	/* Define 8 different flows with different src/dst IPs, ports */
+	struct flow_params  flows[NUM_FLOWS] = {
+		{RTE_IPV4(10, 0, 1, 10), RTE_IPV4(10, 0, 1, 20), 60000, 80, 1000},
+		{RTE_IPV4(10, 0, 1, 11), RTE_IPV4(10, 0, 1, 21), 60001, 80, 2000},
+		{RTE_IPV4(10, 0, 1, 12), RTE_IPV4(10, 0, 1, 22), 60002, 80, 3000},
+		{RTE_IPV4(10, 0, 1, 13), RTE_IPV4(10, 0, 1, 23), 60003, 80, 4000},
+		{RTE_IPV4(10, 0, 1, 14), RTE_IPV4(10, 0, 1, 24), 60004, 80, 5000},
+		{RTE_IPV4(10, 0, 1, 15), RTE_IPV4(10, 0, 1, 25), 60005, 80, 6000},
+		{RTE_IPV4(10, 0, 1, 16), RTE_IPV4(10, 0, 1, 26), 60006, 80, 7000},
+		{RTE_IPV4(10, 0, 1, 17), RTE_IPV4(10, 0, 1, 27), 60007, 80, 8000}
+	};
+	uint8_t flag_options[SEGS_PER_FLOW] = {
+		RTE_TCP_SYN_FLAG,
+		RTE_TCP_ACK_FLAG,
+		RTE_TCP_ACK_FLAG,
+		RTE_TCP_ACK_FLAG | RTE_TCP_FIN_FLAG
+	};
+
+	srand(time(NULL));
+
+	for (int flow = 0; flow < NUM_FLOWS; flow++) {
+		seq = flows[flow].seq;
+		payload_idx = 0;
+		for (int seg = 0; seg < SEGS_PER_FLOW; seg++) {
+			pkt_idx = (flow * SEGS_PER_FLOW) + seg;
+			pkts_mb[pkt_idx] = rte_pktmbuf_alloc(pkt_pool);
+			if (!pkts_mb[pkt_idx])
+				return TEST_FAILED;
+
+			eth = (struct rte_ether_hdr *)rte_pktmbuf_append(pkts_mb[pkt_idx],
+					sizeof(struct rte_ether_hdr));
+			if (!eth)
+				return TEST_FAILED;
+			build_ether_hdr(eth, &src_mac, &dst_mac);
+
+			ip = (struct rte_ipv4_hdr *)rte_pktmbuf_append(pkts_mb[pkt_idx],
+					sizeof(struct rte_ipv4_hdr));
+			if (!ip)
+				return TEST_FAILED;
+			build_ipv4_hdr(ip, flows[flow].src_ip, flows[flow].dst_ip, 1400, pkt_idx);
+
+			tcp = (struct rte_tcp_hdr *)rte_pktmbuf_append(pkts_mb[pkt_idx],
+					sizeof(struct rte_tcp_hdr));
+			if (!tcp)
+				return TEST_FAILED;
+			build_tcp_hdr(tcp, flows[flow].src_port, flows[flow].dst_port,
+				seq, 0, flag_options[seg]);
+
+			if (flag_options[seg] & RTE_TCP_SYN_FLAG)
+				goto skip_payload;
+			data = rte_pktmbuf_append(pkts_mb[pkt_idx], 1400);
+			if (!data)
+				return TEST_FAILED;
+			fill_payload(data, 1400, ref_payload[flow][payload_idx++]);
+			seq += 1400;
+skip_payload:
+			pkts_mb[pkt_idx]->packet_type = RTE_PTYPE_L2_ETHER |
+						RTE_PTYPE_L3_IPV4 | RTE_PTYPE_L4_TCP;
+			pkts_mb[pkt_idx]->l2_len = sizeof(struct rte_ether_hdr);
+			pkts_mb[pkt_idx]->l3_len = sizeof(struct rte_ipv4_hdr);
+			pkts_mb[pkt_idx]->l4_len = sizeof(struct rte_tcp_hdr);
+		}
+	}
+
+	/* GRO reassemble all packets */
+	nb_pkts = rte_gro_reassemble(pkts_mb, TOTAL_PKTS, gro_tcp4_ctx);
+	RTE_LOG(DEBUG, EAL, "GRO reassemble returned %d packets\n", nb_pkts);
+	/* SYN of each flow will be returned */
+	TEST_ASSERT(nb_pkts  == 8, "GRO reassemble failed");
+
+	/* GRO timeout flush */
+	nb_gro_pkts = rte_gro_timeout_flush(gro_tcp4_ctx, 0,
+					RTE_GRO_TCP_IPV4, gro_pkts, TOTAL_PKTS);
+	RTE_LOG(DEBUG, EAL, "GRO timeout flush returned %d packets\n", nb_gro_pkts);
+
+	/* A single chain is returned for each flow after GRO */
+	TEST_ASSERT(nb_gro_pkts == 8, "GRO timeout flush should return at least 1 packet");
+	TEST_ASSERT(rte_gro_get_pkt_count(gro_tcp4_ctx) == 0, "GRO pkt count after flush should be 0");
+
+	for (int flow = 0; flow < NUM_FLOWS; flow++) {
+		struct rte_mbuf *merged_pkt = NULL;
+
+		/* Find the merged packet for this flow by checking IP addresses */
+		for (int i = 0; i < nb_gro_pkts; i++) {
+			struct rte_ipv4_hdr *pkt_ip = rte_pktmbuf_mtod_offset(gro_pkts[i],
+				struct rte_ipv4_hdr *, sizeof(struct rte_ether_hdr));
+			if (rte_be_to_cpu_32(pkt_ip->src_addr) == flows[flow].src_ip &&
+				rte_be_to_cpu_32(pkt_ip->dst_addr) == flows[flow].dst_ip) {
+				merged_pkt = gro_pkts[i];
+				break;
+			}
+		}
+
+		TEST_ASSERT(merged_pkt != NULL,
+			"Could not find merged packet for flow %d", flow);
+
+		/*
+		 * Validate basic headers since each flow contains a FIN packet at the last segment
+		 * the tcp flags will include FIN
+		 */
+		TEST_ASSERT(validate_packet_headers(merged_pkt, &src_mac, &dst_mac,
+			flows[flow].src_ip, flows[flow].dst_ip,
+			flows[flow].src_port, flows[flow].dst_port,
+			flows[flow].seq, 0, RTE_TCP_ACK_FLAG | RTE_TCP_FIN_FLAG) == TEST_SUCCESS,
+			"Flow %d: Header validation failed", flow);
+
+		TEST_ASSERT(validate_merged_payload(merged_pkt, (uint8_t *)ref_payload[flow],
+					1400, SEGS_PER_FLOW-1) == TEST_SUCCESS,
+			"Flow %d: Merged payload validation failed", flow);
+
+	}
+
+	return TEST_SUCCESS;
+}
+
+/* Test maximum number of flows that can be handled by the GRO context */
+static int32_t test_tcp4_max_flows(void)
+{
+	#define NUM_FLOWS_MAX 33
+
+	struct rte_mbuf *pkts_mb[NUM_FLOWS_MAX];
+	struct rte_mbuf *gro_pkts[NUM_FLOWS_MAX];
+	int nb_pkts, nb_gro_pkts;
+	struct rte_ether_addr src_mac = {.addr_bytes = {0xde, 0xad, 0xbe, 0xef, 0x00, 0x01} };
+	struct rte_ether_addr dst_mac = {.addr_bytes = {0xca, 0xfe, 0xba, 0xbe, 0x00, 0x02} };
+	struct rte_ether_hdr *eth;
+	struct rte_ipv4_hdr *ip;
+	struct rte_tcp_hdr *tcp;
+	uint8_t ref_payload[NUM_FLOWS_MAX][64];
+	char *data;
+	struct flow_params flows[NUM_FLOWS_MAX];
+
+	for (int i = 0; i < NUM_FLOWS_MAX; i++) {
+		flows[i].src_ip = RTE_IPV4(10, 1, (i >> 4) & 0xFF, (i & 0x0F) + 10);
+		flows[i].dst_ip = RTE_IPV4(10, 2, (i >> 4) & 0xFF, (i & 0x0F) + 20);
+		flows[i].src_port = 40000 + i;
+		flows[i].dst_port = 50000 + i;
+		flows[i].seq = 1000 * (i + 1);
+	}
+
+	for (int flow = 0; flow < NUM_FLOWS_MAX; flow++) {
+		pkts_mb[flow] = rte_pktmbuf_alloc(pkt_pool);
+		if (!pkts_mb[flow])
+			return TEST_FAILED;
+		eth = (struct rte_ether_hdr *)rte_pktmbuf_append(pkts_mb[flow],
+				sizeof(struct rte_ether_hdr));
+		if (!eth)
+			return TEST_FAILED;
+		build_ether_hdr(eth, &src_mac, &dst_mac);
+
+		ip = (struct rte_ipv4_hdr *)rte_pktmbuf_append(pkts_mb[flow],
+				sizeof(struct rte_ipv4_hdr));
+		if (!ip)
+			return TEST_FAILED;
+		build_ipv4_hdr(ip, flows[flow].src_ip, flows[flow].dst_ip, 64, flow);
+
+		tcp = (struct rte_tcp_hdr *)rte_pktmbuf_append(pkts_mb[flow],
+				sizeof(struct rte_tcp_hdr));
+		if (!tcp)
+			return TEST_FAILED;
+		build_tcp_hdr(tcp, flows[flow].src_port, flows[flow].dst_port,
+			flows[flow].seq, 0, RTE_TCP_ACK_FLAG);
+		data = rte_pktmbuf_append(pkts_mb[flow], 64);
+		if (!data)
+			return TEST_FAILED;
+		fill_payload((char *)data, 64, ref_payload[flow]);
+		pkts_mb[flow]->packet_type = RTE_PTYPE_L2_ETHER |
+					RTE_PTYPE_L3_IPV4 | RTE_PTYPE_L4_TCP;
+		pkts_mb[flow]->l2_len = sizeof(struct rte_ether_hdr);
+		pkts_mb[flow]->l3_len = sizeof(struct rte_ipv4_hdr);
+		pkts_mb[flow]->l4_len = sizeof(struct rte_tcp_hdr);
+	}
+
+	nb_pkts = rte_gro_reassemble(pkts_mb, NUM_FLOWS_MAX, gro_tcp4_ctx);
+	/* Only 32 flows can be handled. 33rd flow will result in failure */
+	TEST_ASSERT(nb_pkts == 1, "GRO reassemble failed, expected 1 packet, got %d", nb_pkts);
+
+	nb_gro_pkts = rte_gro_timeout_flush(gro_tcp4_ctx, 0,
+					RTE_GRO_TCP_IPV4, gro_pkts, NUM_FLOWS_MAX);
+	TEST_ASSERT(nb_gro_pkts == NUM_FLOWS_MAX-1,
+				"GRO timeout flush should return %d packets returned %d",
+				NUM_FLOWS_MAX, nb_gro_pkts);
+
+	for (int flow = 0; flow < NUM_FLOWS_MAX-1; flow++) {
+		TEST_ASSERT(pkts_mb[flow] != NULL, "Packet %d should not be NULL", flow);
+		TEST_ASSERT(validate_packet_headers(gro_pkts[flow], &src_mac, &dst_mac,
+					flows[flow].src_ip, flows[flow].dst_ip,
+					flows[flow].src_port, flows[flow].dst_port,
+					flows[flow].seq, 0, RTE_TCP_ACK_FLAG) == TEST_SUCCESS,
+					"Flow %d: Header validation failed", flow);
+	}
+
+	return TEST_SUCCESS;
+}
+
 static int test_gro_tcp4_setup(void)
 {
 	pkt_pool = rte_pktmbuf_pool_create("GRO_MBUF_POOL",
@@ -97,10 +634,15 @@ static int test_gro_tcp4_setup(void)
 	}
 
 	gro_tcp4_ctx = rte_gro_ctx_create(&(struct rte_gro_param) {
-					.max_flow_num = 1024,
-					.max_item_per_flow = 32,
-					.gro_types = RTE_GRO_TCP_IPV4,
-			});
+						/*
+						 *
+						 * This can handle best case 1 flow with 32 items
+						 * or worst case 32 flows with 1 item each.
+						 */
+						.max_flow_num = 32,
+						.max_item_per_flow = 1,
+						.gro_types = RTE_GRO_TCP_IPV4,
+					});
 	if (gro_tcp4_ctx == NULL)
 		goto failed;
 
@@ -128,99 +670,22 @@ static void test_gro_tcp4_teardown(void)
 	gro_tcp4_ctx = NULL;
 }
 
-static int testsuite_setup(void)
-{
-	return TEST_SUCCESS;
-}
-
-static void testsuite_teardown(void)
-{
-}
-
-static int32_t
-test_gro_tcp4(void)
-{
-	struct rte_mbuf *pkts_mb[5];
-	struct rte_mbuf *gro_pkts[5];
-	int nb_pkts;
-	int nb_gro_pkts;
-	struct rte_net_hdr_lens hdr_lens = {0};
-	struct rte_ether_hdr *eth_hdr;
-	struct rte_ipv4_hdr *ipv4_hdr;
-	struct rte_tcp_hdr *tcp_hdr;
-	struct rte_ether_addr src_addr = {
-		.addr_bytes = {0x7c, 0xed, 0x8d, 0xc0, 0xc1, 0xf5}
-	};
-	struct rte_ether_addr dst_addr = {
-		.addr_bytes = {0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc}
-	};
-
-	for (int i = 0; i < 5; i++) {
-		pkts_mb[i] = rte_pktmbuf_alloc(pkt_pool);
-		if (pkts_mb[i] == NULL)
-			goto failed;
-		rte_memcpy(rte_pktmbuf_mtod(pkts_mb[i], void *), pkts[i], 132);
-		pkts_mb[i]->data_len = 132;
-		pkts_mb[i]->pkt_len = 132;
-		pkts_mb[i]->packet_type = rte_net_get_ptype(pkts_mb[i], &hdr_lens,
-										RTE_PTYPE_ALL_MASK);
-		pkts_mb[i]->l2_len = hdr_lens.l2_len;
-		pkts_mb[i]->l3_len = hdr_lens.l3_len;
-		pkts_mb[i]->l4_len = hdr_lens.l4_len;
-	}
-
-	/* GRO reassemble */
-	nb_pkts = rte_gro_reassemble(&pkts_mb[0], 5, gro_tcp4_ctx);
-	TEST_ASSERT(nb_pkts == 0, "Not expected packets after GRO");
-	TEST_ASSERT(rte_gro_get_pkt_count(gro_tcp4_ctx) == 1, "GRO pkt count mismatch");
-
-	/* GRO timeout flush */
-	nb_gro_pkts = rte_gro_timeout_flush(gro_tcp4_ctx, 0, RTE_GRO_TCP_IPV4, gro_pkts, 5);
-	TEST_ASSERT(nb_gro_pkts == 1, "GRO timeout flush pkt count mismatch");
-	TEST_ASSERT(rte_gro_get_pkt_count(gro_tcp4_ctx) == 0, "GRO pkt count after flush mismatch");
-	TEST_ASSERT(gro_pkts[0]->pkt_len == 396, "GRO merged pkt len mismatch");
-
-	eth_hdr = rte_pktmbuf_mtod(gro_pkts[0], struct rte_ether_hdr *);
-	ipv4_hdr = (struct rte_ipv4_hdr *)(rte_pktmbuf_mtod(
-					gro_pkts[0], char *) + sizeof(struct rte_ether_hdr));
-	tcp_hdr = (struct rte_tcp_hdr *)((char *)ipv4_hdr + sizeof(struct rte_ipv4_hdr));
-
-	TEST_ASSERT_BUFFERS_ARE_EQUAL(eth_hdr->src_addr.addr_bytes,
-		src_addr.addr_bytes, RTE_ETHER_ADDR_LEN, "GRO merged pkt Ethernet SRC MAC mismatch");
-	 TEST_ASSERT_BUFFERS_ARE_EQUAL(eth_hdr->dst_addr.addr_bytes,
-		dst_addr.addr_bytes, RTE_ETHER_ADDR_LEN, "GRO merged pkt Ethernet DST MAC mismatch");
-
-	TEST_ASSERT(rte_be_to_cpu_32(ipv4_hdr->src_addr) == 0x0a010004,
-		"GRO merged pkt IP src addr mismatch");
-	TEST_ASSERT(rte_be_to_cpu_32(ipv4_hdr->dst_addr) == 0x0a010005,
-		"GRO merged pkt IP dst addr mismatch");
-	TEST_ASSERT(rte_be_to_cpu_16(ipv4_hdr->packet_id) == 0xa4fb,
-		"GRO merged pkt IP id mismatch");
-
-	TEST_ASSERT(rte_be_to_cpu_16(tcp_hdr->src_port) == 52362,
-		"GRO merged pkt TCP src port mismatch");
-	TEST_ASSERT(rte_be_to_cpu_16(tcp_hdr->dst_port) == 5201,
-		"GRO merged pkt TCP dst port mismatch");
-	TEST_ASSERT(rte_be_to_cpu_32(tcp_hdr->sent_seq) == 4251552885,
-		"GRO merged pkt TCP seq num mismatch");
-	TEST_ASSERT(rte_be_to_cpu_32(tcp_hdr->recv_ack) == 428268870,
-		"GRO merged pkt TCP ack num mismatch");
-
-	return TEST_SUCCESS;
-
-failed:
-	return TEST_FAILED;
-}
-
 static struct unit_test_suite gro_testsuite  = {
 	.suite_name = "GRO Unit Test Suite",
-	.setup = testsuite_setup,
-	.teardown = testsuite_teardown,
+	.setup = NULL,
+	.teardown = NULL,
 	.unit_test_cases = {
 		TEST_CASE_ST(test_gro_tcp4_setup, test_gro_tcp4_teardown,
-			     test_gro_tcp4),
-
-		TEST_CASES_END() /**< NULL terminate unit test array */
+					 test_tcp4_single_flow_multi_segment),
+		TEST_CASE_ST(test_gro_tcp4_setup, test_gro_tcp4_teardown,
+					 test_tcp4_with_psh_flag),
+		TEST_CASE_ST(test_gro_tcp4_setup, test_gro_tcp4_teardown,
+					 test_tcp4_multiple_flows),
+		TEST_CASE_ST(test_gro_tcp4_setup, test_gro_tcp4_teardown,
+					 test_tcp4_mixed_flags),
+		TEST_CASE_ST(test_gro_tcp4_setup, test_gro_tcp4_teardown,
+					 test_tcp4_max_flows),
+		TEST_CASES_END()
 	}
 };
 
-- 
2.25.1

