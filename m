Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D49EE4992
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Dec 2025 18:59:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DE95140652;
	Tue, 30 Dec 2025 19:58:51 +0100 (CET)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com
 [209.85.218.52]) by mails.dpdk.org (Postfix) with ESMTP id 40D6A4064F
 for <dev@dpdk.org>; Tue, 30 Dec 2025 19:58:50 +0100 (CET)
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-b832522b47cso576382466b.0
 for <dev@dpdk.org>; Tue, 30 Dec 2025 10:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767121130;
 x=1767725930; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w3fJaT/SSBLh+NEimCXqyX/PMjT8ge34el/C578d1Bc=;
 b=vUPr1HQFD80j20C8xNsmb/XxWcj4+ofx64aqpaVHHPSJFNavpprca1LnykOCoE8VO5
 8YGVReEi3TWAdxMoBwbwlFVMAVzKbGCBhKRDcOUQhhbKh5u/VUziGJ9e3hjN2PaFyYu2
 TPtxDiNTTYTv56behDtEDxOggufxO0zBWPSdzReMgXaLq3y9SeNP7AXZho15pNSQQDDE
 Txc4gec//Mkg6TCNJwkQloMin1wskYf0YOoJkKxmBUi+kfbhLqy/lrRIof6JdAMrXjEh
 d8Si+taBdw5cWEemD/6iQhcipXaALZhpNOqV2c6yWjHNOWbbfnOlduTsHQUM0vmV8X8h
 uJwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767121130; x=1767725930;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=w3fJaT/SSBLh+NEimCXqyX/PMjT8ge34el/C578d1Bc=;
 b=fTscTBFSfjJnx0RfZlzkEszlM76xZ2AziI1r69+3sePzq4H/bFi/G4byLlRYz5bVeu
 ljXgSqETUCOTIARhKI2IJ6KJFceLW2YUTs5g+cekQW28zMzW79HXro65+gjgilHIj4qy
 WrzVn84ZZOr6qGcWqa82VfaYjuvdA529tBQGOVZBxyJv6YpYwgwbPKinBik9K7mrgRws
 pqBUgXaU87PqJLkVU/fHZ70Cs7OC/Ppx8km2tDockV97xBEs6V7VXCdiuRr+GMiHTod3
 RVkTlp/ArFb+3mg4YMFaZNmDgmUmRX8xgwEspaj4b3mjjO6qpnV2iteiSBXztbXRGUNb
 pfrg==
X-Gm-Message-State: AOJu0Yyog3KL67HSI3EOLcf6Tt6fdsRnXFh6uzX1qn1ordoLx+kN4qnc
 ovmMhkBQyXY4rH0+wOKc0HUsNc1yDsLaHwh+/+WH5tntPhm4Y5c2jLiQ0A9XT2nr2PvyYcBKHsv
 D5B8VemM=
X-Gm-Gg: AY/fxX4N89delULzdon471mCvQdpJXjC3kRaGELx8lhkpoBJgNKY3x593qVNEkXp5/b
 2xjLkDr91dMOF/z5JPf3jo/rCGmlE292GtM8+Uw4727a677/cdMcRBHL+dWvZIvKvXZd6f+gGiz
 eyK3MKe2FuRIQJJ1qpPCeedn6hUSGGLPCcWuFmcRUskO2CyAHcTnHUgr/2X2z+LSn3zfHRZrk4Z
 t5Kk5m9Jw/ql71fJjVe85Dyorj/FuFyoxDttaPLy1hn1cpBaiwDJz02Y+xf/eGB9VHtqQMPhS6P
 utw7QVLvujw045rB3/7IlM/NgjBm+2ktUrJCIsQASCje8BucJrWToTSxGq3s5DO88tbjTy+XJvD
 Nix7uwtzimWXguIS0JAa9+SuzOxhnwl2nfbZwlzv89C5eC6t8e4IsOPCkIC79rR4l1m0cBxC9fD
 CDmcymUD28WpWqZy9XdCLHUrtNtMyfjW2+DYRAsLLkWQBL0Ur1JVVhZN9NDhFe
X-Google-Smtp-Source: AGHT+IEHv/Itbys4eLFaGNPkRE1RrsK4cGtIMmvTqY4H89QEcWO1ENXikjcldW3FThJC0ftIX+cWWQ==
X-Received: by 2002:a17:907:6d22:b0:b76:5b73:75fb with SMTP id
 a640c23a62f3a-b8036ecdbfcmr3326018766b.9.1767121129789; 
 Tue, 30 Dec 2025 10:58:49 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8037de0de1sm3745449366b.40.2025.12.30.10.58.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Dec 2025 10:58:49 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v2 4/7] test: vary size of packets in pcapng test
Date: Tue, 30 Dec 2025 10:55:12 -0800
Message-ID: <20251230185837.301163-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251230185837.301163-1-stephen@networkplumber.org>
References: <20251228184300.541639-1-stephen@networkplumber.org>
 <20251230185837.301163-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

In order exercise more logic in pcapng, vary the size
of the packets.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_pcapng.c | 94 +++++++++++++++++++++++++++++-------------
 1 file changed, 65 insertions(+), 29 deletions(-)

diff --git a/app/test/test_pcapng.c b/app/test/test_pcapng.c
index f2b49c31c7..5010355df5 100644
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
@@ -156,8 +190,7 @@ fill_pcapng_file(rte_pcapng_t *pcapng, unsigned int num_packets)
 		"Lockless and fearless — that’s how we roll in userspace."
 	};
 
-	/* make a dummy packet */
-	mbuf1_prepare(&mbfs, pkt_len);
+	mbuf1_prepare(&mbfs);
 	orig  = &mbfs.mb[0];
 
 	for (count = 0; count < num_packets; count += burst_size) {
@@ -174,6 +207,9 @@ fill_pcapng_file(rte_pcapng_t *pcapng, unsigned int num_packets)
 			if ((count + i) % 42 == 0)
 				comment = examples[rte_rand_max(RTE_DIM(examples))];
 
+			/* Vary the size of the packets */
+			mbuf1_resize(&mbfs, rte_rand_max(MAX_DATA_SIZE));
+
 			mc = rte_pcapng_copy(port_id, 0, orig, mp, rte_pktmbuf_pkt_len(orig),
 					     RTE_PCAPNG_DIRECTION_IN, comment);
 			if (mc == NULL) {
-- 
2.51.0

