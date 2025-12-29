Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A126E92FF3
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Dec 2025 23:02:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EF7B94065A;
	Tue, 30 Dec 2025 00:02:36 +0100 (CET)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com
 [209.85.218.41]) by mails.dpdk.org (Postfix) with ESMTP id 8EA5640651
 for <dev@dpdk.org>; Tue, 30 Dec 2025 00:02:35 +0100 (CET)
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-b73a9592fb8so1832856766b.1
 for <dev@dpdk.org>; Mon, 29 Dec 2025 15:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767049355;
 x=1767654155; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w3fJaT/SSBLh+NEimCXqyX/PMjT8ge34el/C578d1Bc=;
 b=REXE7fLKPzDrXPCDSRxiCCuYxxMr0paPard/8vC1KyFxxNywqZolIEAUYcjg0/PUPI
 JcHHtmA417SWRoQeuMpAdTP51AL2dWo2I1dLiCJMq0K8wiPKo91iUChUK7o09ywiZwOM
 pMQTdrIPAPMYdOY1UhcZZzzgor5WlRd1ikLK+yfZ38KHTPEKH7pvMSrCwLm8HmNf3dLj
 kitZdbmkaZlNTkK+4tuAFHfS3Tpgxc++1RLA8vgpPS1MlyozqUFXCS0tI9oqH3gSTXLW
 LBrSHQDeijwr4aHgaiGRJeJLCdj+z/WxzWSsvrln8qubCbcwSkSbrUGZXFPIqbFSgYOS
 M3iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767049355; x=1767654155;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=w3fJaT/SSBLh+NEimCXqyX/PMjT8ge34el/C578d1Bc=;
 b=SB09ztcHfuMKIfGC+QIeHfCO1NA4ztp04WgVM7i+z6QYcaP9THP2W26CTgMyhvaVRm
 NfhMXOOuZ25qQtLuEWzr7LnGRX3aEvwpsD4Lj934FJVKoqgtwA2HasudewAnq/vsXMo7
 eVbw5Qj0Vbt2V54mQPIqrb1LzjB6wP6p1dF8bRf5XbR3jKVSPfIC3TWyUNvfvr7NMWXh
 vTt8aVJcuC09Hp4dQpxcWv+yiYxtLk3EGGF5k7cQ3xIihz1639+RiTV+eQMFFg6penWY
 OMDZ2LcnqcyLbNemn5h72yhBKuZacvuTC8ZHuHgXF8FoVlA/n00nKJTRZzLzxYE8ucyS
 etPw==
X-Gm-Message-State: AOJu0YzuREkoEfmDXFX1QS6Y4IU0a7wyCWeAJrO9dTRHF9ZaFbXBgtqq
 FHEWdfbripugLSJEO/31rYCn0MD6/S3hx4SxVRrsAwqcIWG+aYgXtgKkQtLigE9eMhuS4ewszXk
 RkeiDVIU=
X-Gm-Gg: AY/fxX5q6VDW19AkK6lbWIUQlQvg/TZFMfF4HzGPXCo+4D+9AWABmBSSVEllAugK8/z
 06cxFhJbY0iDtCsXfB8lsVJpAcLSv16Y9QBWfPuAOsdmnbvmuFzrMFzDnXGXG3PU3coxUTJajBn
 ifBcxYeGgEaz2i5FKvBQAybqYInLPToBXwewDWyd101WeAUZZTgdY7PFvb+quH/zPBPWaoJ33Ul
 OZJG8IZYbBfTf/I8eLJ8uEeAkZqHpsPzmND5zx1W+0exwKRv80o2+fMjGrRels7nNng8WJQH95m
 635hoIvjOregJr3g8uLp2Ia/Zjhn6J07WTZPomLfFzwbYKr9NCFsckA/ttSycMogfxnYd1YnVCL
 ySE2ccP2iyoQp79La41JBM6hJ8o40J66vcbmfurrKqUkXAFrKUZHCJQD5/cncC15gGDwbI9NQey
 LaX+LpeR3m9agxeWHIzv0LNFv5JSpslJdGYoZBuw+uAGMiAWv9Og==
X-Google-Smtp-Source: AGHT+IEVqPUSh5FP/WXcZy7eCbqvbUknOkH+SRqxglQmcp6z0jgKe2qZxlmwawqbb3MZ40qJr1p81g==
X-Received: by 2002:a17:907:960a:b0:b80:48f6:9cc6 with SMTP id
 a640c23a62f3a-b8048f69d3amr3478094466b.32.1767049355091; 
 Mon, 29 Dec 2025 15:02:35 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b830b5fe8cfsm1933148166b.59.2025.12.29.15.02.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 15:02:34 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v2 4/6] test: vary size of packets in pcapng test
Date: Mon, 29 Dec 2025 15:01:07 -0800
Message-ID: <20251229230223.151874-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251229230223.151874-1-stephen@networkplumber.org>
References: <20251126051218.50568-1-stephen@networkplumber.org>
 <20251229230223.151874-1-stephen@networkplumber.org>
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

