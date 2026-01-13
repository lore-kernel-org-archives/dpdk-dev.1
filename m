Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E66CF45D4
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 00:52:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 19BB040611;
	Tue, 13 Jan 2026 01:52:13 +0100 (CET)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46]) by mails.dpdk.org (Postfix) with ESMTP id E5E4640659
 for <dev@dpdk.org>; Tue, 13 Jan 2026 01:52:11 +0100 (CET)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-4327555464cso4185156f8f.1
 for <dev@dpdk.org>; Mon, 12 Jan 2026 16:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768265531;
 x=1768870331; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SyecOMMJsQ6n5J2quP18a7K23v91l1OnL8xFwuscGbI=;
 b=WL8jtmCtoy+PZSBM6WWiZyeZtbNV7ZAmq9/QfKRpclRVXE4275EG87FP5K8ThOyxOZ
 O8DU1LwAOWBE0SE1DHKpBGR74MEtEEoz5r6/jBIoHXt7Lzp0egIg3Gtb+fmkfl9IKOYI
 AbVvRbVExzVzXzwyU7v0pUB6hv9l2x+49mXt4jnjvKtd3hjLUJXIynNWIgj1v4OAM3pO
 WIrESN5+pt3eXe+jBT8D09F7LILlEjCqLBEGPoo3BGrEdjyW4BqNXZQGzK+T/G1u03ck
 R+4IJEjgx/XKU/0yhRgpqBRdKRyrEKI+bgKlJT0MAKDLnOxbvd+iG/8yYtYn9TZQ0gD/
 cNnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768265531; x=1768870331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SyecOMMJsQ6n5J2quP18a7K23v91l1OnL8xFwuscGbI=;
 b=e7UH1LE9ksQR2+t6ata0CFboY4/C6Lnc7oa+AYuzOSGvGqHdprxvmnb2oxXd832jnI
 QUj02QdBIufUj4vD7uHzYMlKf//1T4k6//75fuIiy2eIUOAdMXs7EodNuFJKGCUHkWP9
 Ttm6idH/Naz3X1IYFws0SdANBDlOjnxhoSGj0t2LCFMuUtIS1vJ9FW5qZExrrCh2YVWL
 brX2clV1GRFtRNr14iFMS3jrnHNcNqX43R7fMXuozynvPOlrMrQPwP8aJrIsMIzjFa1G
 l+4/kVQDqE4pSBTY2UCMl/hYSS5QjiYU6OqI+1GB9SRH8ZeYOcPTjvT3nLThSmplbZt0
 x0lw==
X-Gm-Message-State: AOJu0Yydo0APtKLBpD/YPPI8cF6gzy+0zo/3fuycNFvB34ca9AGSL5qT
 46Jv58s+1xcvQ6SNAymnYGXsLSZl7MAyqWv1no3uXFyM9U8ZjlygrQP7DcUeMEFhsjB+yuMNWD9
 3dE+n
X-Gm-Gg: AY/fxX7SLOf9qCoNxR/wQS0JWjczHPewWmukrE3fBWdaLctzwjkEscUNn6DC3ro+blU
 SneFSQYA6bqjoc8y5ybM4vqzGqgeK9aTVp83JNvjXfJcU2DYiHJdVvcee1i7M2kDxSI4tK6Rtxh
 OfQjqbxrgENZVhseigI8XvGZZlWHOMdlN1Yd6f0TnRBEvvMmxMdqRC9n/ou6vqEUnG8tUQpcTee
 y3AdZRq23pEx6ZyCJUMv/aWAgrZsv+TSU4zXAZ7TdZD35SmyjsnVlZPCA19e9bOg+dWWY4zn6pC
 i6PYPw7OAQIqXaVULRLOhfj9GyFZxCRQ11GsDteSqHtFozMN7Gcc2YAPilYuGs5b6eZnd8kLfMD
 FEEwSAI0kKBrFAPcfFNv/qhrKjWnQ9wG/bc8MmVDn/5gp7J6cyBvssdtsonaTP/Gcsa4kZQk1WK
 8uO/6+5XtfJ+zjf6/EbcqY0dslYNju8nMXLpa5yUQdg/SFQIFu4A==
X-Google-Smtp-Source: AGHT+IH7gZ/x5VxMBHjvI2hcGUcqtl7NBe+xPkF29HhVT+WcVbNvSxwtesx9U+tyHx5MbrzihPk5bA==
X-Received: by 2002:adf:f54f:0:b0:432:e00b:866f with SMTP id
 ffacd0b85a97d-432e00b8b14mr9638087f8f.60.1768265531426; 
 Mon, 12 Jan 2026 16:52:11 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0dad8bsm41603051f8f.8.2026.01.12.16.52.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 16:52:11 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v4 5/7] test: vary size of packets in pcapng test
Date: Mon, 12 Jan 2026 16:51:28 -0800
Message-ID: <20260113005154.44551-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260113005154.44551-1-stephen@networkplumber.org>
References: <20251126051218.50568-1-stephen@networkplumber.org>
 <20260113005154.44551-1-stephen@networkplumber.org>
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

In order to exercise more logic in pcapng, vary the size
of the packets.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_pcapng.c | 94 +++++++++++++++++++++++++++++-------------
 1 file changed, 65 insertions(+), 29 deletions(-)

diff --git a/app/test/test_pcapng.c b/app/test/test_pcapng.c
index 09a963c676..f1405cfa7c 100644
--- a/app/test/test_pcapng.c
+++ b/app/test/test_pcapng.c
@@ -28,10 +28,9 @@
 #define TOTAL_PACKETS	4096
 #define MAX_BURST	64
 #define MAX_GAP_US	100000
-#define DUMMY_MBUF_NUM	3
+#define DUMMY_MBUF_NUM	2
 
 static struct rte_mempool *mp;
-static const uint32_t pkt_len = 200;
 static uint16_t port_id;
 static const char null_dev[] = "net_null0";
 
@@ -41,13 +40,36 @@ struct dummy_mbuf {
 	uint8_t buf[DUMMY_MBUF_NUM][RTE_MBUF_DEFAULT_BUF_SIZE];
 };
 
+#define MAX_DATA_SIZE (RTE_MBUF_DEFAULT_BUF_SIZE - RTE_PKTMBUF_HEADROOM)
+
+/* RFC 864 chargen pattern used for comment testing */
+#define FILL_LINE_LENGTH 72
+#define FILL_START	0x21 /* ! */
+#define FILL_END	0x7e /* ~ */
+#define FILL_RANGE	(FILL_END - FILL_START)
+
 static void
-dummy_mbuf_prep(struct rte_mbuf *mb, uint8_t buf[], uint32_t buf_len,
-	uint32_t data_len)
+fill_mbuf(struct rte_mbuf *mb)
 {
-	uint32_t i;
-	uint8_t *db;
+	unsigned int len = rte_pktmbuf_tailroom(mb);
+	char *buf = rte_pktmbuf_append(mb, len);
+	unsigned int n = 0;
+
+	while (n < len - 1) {
+		char ch = FILL_START + (n % FILL_LINE_LENGTH) % FILL_RANGE;
+		for (unsigned int i = 0; i < FILL_LINE_LENGTH && n < len - 1; i++) {
+			buf[n++] = ch;
+			if (++ch == FILL_END)
+				ch = FILL_START;
+		}
+		if (n < len - 1)
+			buf[n++] = '\n';
+	}
+}
 
+static void
+dummy_mbuf_prep(struct rte_mbuf *mb, uint8_t buf[], uint32_t buf_len)
+{
 	mb->buf_addr = buf;
 	rte_mbuf_iova_set(mb, (uintptr_t)buf);
 	mb->buf_len = buf_len;
@@ -57,15 +79,11 @@ dummy_mbuf_prep(struct rte_mbuf *mb, uint8_t buf[], uint32_t buf_len,
 	mb->pool = (void *)buf;
 
 	rte_pktmbuf_reset(mb);
-	db = (uint8_t *)rte_pktmbuf_append(mb, data_len);
-
-	for (i = 0; i != data_len; i++)
-		db[i] = i;
 }
 
 /* Make an IP packet consisting of chain of one packets */
 static void
-mbuf1_prepare(struct dummy_mbuf *dm, uint32_t plen)
+mbuf1_prepare(struct dummy_mbuf *dm)
 {
 	struct {
 		struct rte_ether_hdr eth;
@@ -84,32 +102,47 @@ mbuf1_prepare(struct dummy_mbuf *dm, uint32_t plen)
 			.dst_addr = rte_cpu_to_be_32(RTE_IPV4_BROADCAST),
 		},
 		.udp = {
+			.src_port = rte_cpu_to_be_16(19), /* Chargen port */
 			.dst_port = rte_cpu_to_be_16(9), /* Discard port */
 		},
 	};
 
 	memset(dm, 0, sizeof(*dm));
-	dummy_mbuf_prep(&dm->mb[0], dm->buf[0], sizeof(dm->buf[0]), plen);
+	dummy_mbuf_prep(&dm->mb[0], dm->buf[0], sizeof(dm->buf[0]));
+	dummy_mbuf_prep(&dm->mb[1], dm->buf[1], sizeof(dm->buf[1]));
 
 	rte_eth_random_addr(pkt.eth.src_addr.addr_bytes);
-	plen -= sizeof(struct rte_ether_hdr);
+	memcpy(rte_pktmbuf_append(&dm->mb[0], sizeof(pkt)), &pkt, sizeof(pkt));
+
+	fill_mbuf(&dm->mb[1]);
+	rte_pktmbuf_chain(&dm->mb[0], &dm->mb[1]);
+
+	rte_mbuf_sanity_check(&dm->mb[0], 1);
+	rte_mbuf_sanity_check(&dm->mb[1], 0);
+}
 
-	pkt.ip.total_length = rte_cpu_to_be_16(plen);
-	pkt.ip.hdr_checksum = rte_ipv4_cksum(&pkt.ip);
+static void
+mbuf1_resize(struct dummy_mbuf *dm, uint16_t len)
+{
+	struct {
+		struct rte_ether_hdr eth;
+		struct rte_ipv4_hdr ip;
+		struct rte_udp_hdr udp;
+	} *pkt = rte_pktmbuf_mtod(&dm->mb[0], void *);
 
-	plen -= sizeof(struct rte_ipv4_hdr);
-	pkt.udp.src_port = rte_rand();
-	pkt.udp.dgram_len = rte_cpu_to_be_16(plen);
+	dm->mb[1].data_len = len;
+	dm->mb[0].pkt_len = dm->mb[0].data_len + dm->mb[1].data_len;
 
-	memcpy(rte_pktmbuf_mtod(dm->mb, void *), &pkt, sizeof(pkt));
+	len += sizeof(struct rte_udp_hdr);
+	pkt->udp.dgram_len = rte_cpu_to_be_16(len);
 
-	/* Idea here is to create mbuf chain big enough that after mbuf deep copy they won't be
-	 * compressed into single mbuf to properly test store of chained mbufs
-	 */
-	dummy_mbuf_prep(&dm->mb[1], dm->buf[1], sizeof(dm->buf[1]), pkt_len);
-	dummy_mbuf_prep(&dm->mb[2], dm->buf[2], sizeof(dm->buf[2]), pkt_len);
-	rte_pktmbuf_chain(&dm->mb[0], &dm->mb[1]);
-	rte_pktmbuf_chain(&dm->mb[0], &dm->mb[2]);
+	len += sizeof(struct rte_ipv4_hdr);
+	pkt->ip.total_length = rte_cpu_to_be_16(len);
+	pkt->ip.hdr_checksum = 0;
+	pkt->ip.hdr_checksum = rte_ipv4_cksum(&pkt->ip);
+
+	rte_mbuf_sanity_check(&dm->mb[0], 1);
+	rte_mbuf_sanity_check(&dm->mb[1], 0);
 }
 
 static int
@@ -125,7 +158,8 @@ test_setup(void)
 
 	/* Make a pool for cloned packets */
 	mp = rte_pktmbuf_pool_create_by_ops("pcapng_test_pool",
-					    MAX_BURST * 32, 0, 0, rte_pcapng_mbuf_size(pkt_len),
+					    MAX_BURST * 32, 0, 0,
+					    rte_pcapng_mbuf_size(MAX_DATA_SIZE),
 					    SOCKET_ID_ANY, "ring_mp_sc");
 	if (mp == NULL) {
 		fprintf(stderr, "Cannot create mempool\n");
@@ -165,8 +199,7 @@ fill_pcapng_file(rte_pcapng_t *pcapng, unsigned int num_packets)
 		 "nobody remembers why. Trust the process."),
 	};
 
-	/* make a dummy packet */
-	mbuf1_prepare(&mbfs, pkt_len);
+	mbuf1_prepare(&mbfs);
 	orig  = &mbfs.mb[0];
 
 	for (count = 0; count < num_packets; count += burst_size) {
@@ -183,6 +216,9 @@ fill_pcapng_file(rte_pcapng_t *pcapng, unsigned int num_packets)
 			if ((count + i) % 41 == 0)
 				comment = examples[rte_rand_max(RTE_DIM(examples))];
 
+			/* Vary the size of the packets */
+			mbuf1_resize(&mbfs, rte_rand_max(MAX_DATA_SIZE));
+
 			mc = rte_pcapng_copy(port_id, 0, orig, mp, rte_pktmbuf_pkt_len(orig),
 					     RTE_PCAPNG_DIRECTION_IN, comment);
 			if (mc == NULL) {
-- 
2.51.0

