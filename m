Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29219EF99CF
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 19:21:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 545094067A;
	Fri, 13 Feb 2026 20:20:57 +0100 (CET)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46]) by mails.dpdk.org (Postfix) with ESMTP id 01CE24065C
 for <dev@dpdk.org>; Fri, 13 Feb 2026 20:20:55 +0100 (CET)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-48375f1defeso7281725e9.0
 for <dev@dpdk.org>; Fri, 13 Feb 2026 11:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771010454;
 x=1771615254; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iiwdTqVCjK4pxBjxes1avacxMFh3TxhjRik9mP0URqc=;
 b=wdvkIuxVXqz3tU/JVNoBRLWqJnZ/PwPLmFOzXzbktC2fvQL6uOvurOGoULSnh9a5Oc
 vfzUWwhVT3N+fEwMI7lr+OnpUtNTZemWDCdGbQHgql7ezxAQc1Gue0p6XOVC7NR4RtbM
 qYYt3rKMZrmdvBNhBoAKxX14SiFmVDvTgz0DDUCh9EQq9XVbi77alm1O16fynfBIv7VX
 kQFR8sWFlErIx1jgp0GKbLBUijZ9as70qBr9J2V9qx2H3ik5y6gl861QvDa0gtGjheJG
 mPyvynpNRJVrY93/4vpKuyUo/HQHEnPQZOnL8lP1gzMXGbWdkUaeaj71waTtXBoBC/oQ
 tVyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771010454; x=1771615254;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iiwdTqVCjK4pxBjxes1avacxMFh3TxhjRik9mP0URqc=;
 b=q3zf3eMaB819IizmkIZ8mYa+k5UZudmpd4U+f0qGRRVnb3s7iBXTFysBB9JgFYAzQm
 9VdKFwu20DKCuJnPZlqzgfLYUW2sv7ImHijdYwDsyvMH0Sz1s+ue2/ZRvrSNWIB94HnV
 8st+onT+fIq69YiY00c5cOnQ2lmBt2o3bjg1tYZFOCb13I+cPHozy95Q0MnDLg5usnxZ
 Xb24vTi+nfx5+QDtL9Yy21YaXB2+IGYxtrPoFil1LFTb3SLQWL8cjP8MGxuP0QXR0JGf
 Oo6CRdbZU9InNorGDPNuB6A+NBOC9qGEk0/zFae8oJ+c7ZR1Y40P/44UGWrx3lE2D8pH
 qLeQ==
X-Gm-Message-State: AOJu0Yw9sckfwDCZGgmIPV0nBueLzuX2msASgSOm/1vWKdLrHgaNHuJk
 fhpNxdBQB8mtsC/ir1+ulty7PEPM2KzSLG/mptFizCVGlGqWOs2T/3B24u2SVTvpUAGsPfb4/jG
 dnxQC
X-Gm-Gg: AZuq6aL7Us2l47b6eh34B3NYRkVRJpiB4cgQvxHI4KyDgAE5Hy+n8BdYCgnOQMwcfeF
 mkacExWGzTbwK2oKU9wN7F8Ac5axIVH3gCvAUAHrlwqBSC5OMRhVBTPArLHVzi5E4vCeeIkTuAY
 IZaoFcSsjYpBNkOQ2w3WKn1hjrvMRTFv31Rp1AgW9z9xipzdDWfa43w9V7bn+3GYbD4bOUbEuwc
 ng4lcDfpruEi2kyi78+xJeebyTWVNS5i4B942xQs1Xgsthx7OD5xezdGizoJxBTk7akqoNQ95GP
 nfYKSszSTAId5o7pkrQDMIlWAZZOcLZSBKRKQwO4jlrLLE/PPPLxUl221wU0XMfpQkDRRbg0P7S
 pR7f5SftFKqvt86pTuXVf5Is9sEJlBRfeHYGFAUB1THggJep7VWUdMthdHRALEuE34Azp6vurQ0
 nKPV7VNEoK198obO07nFfayXSy9/O/RPK5bnfZeegYoKbZeT0g+6CczF/tWDEpbg==
X-Received: by 2002:a05:6000:250a:b0:437:719d:a74a with SMTP id
 ffacd0b85a97d-437979525d0mr5583141f8f.58.1771010454447; 
 Fri, 13 Feb 2026 11:20:54 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796ac8d82sm7758723f8f.31.2026.02.13.11.20.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 11:20:54 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v7 5/7] test/pcapng: add tests for comments
Date: Fri, 13 Feb 2026 11:18:22 -0800
Message-ID: <20260213192039.221213-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260213192039.221213-1-stephen@networkplumber.org>
References: <20260126210615.175816-1-stephen@networkplumber.org>
 <20260213192039.221213-1-stephen@networkplumber.org>
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

Expand pcapng test coverage to exercise comment handling and
additional code paths:

* Add packet comments of varying lengths, including strings longer than
  256 bytes, to verify option block encoding.

* Vary packet sizes randomly to test different capture lengths

* Calculate inter-packet delays to ensure timestamp values wrap
  around 32 bits at least twice during the test.

* Add a statistics block write before packet capture.

* Use RFC 864 chargen pattern for predictable fill data.

Increase total packets from 4096 to 10000 and refactor mbuf
preparation for more flexible packet construction.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_pcapng.c | 151 ++++++++++++++++++++++++++++++-----------
 1 file changed, 113 insertions(+), 38 deletions(-)

diff --git a/app/test/test_pcapng.c b/app/test/test_pcapng.c
index 5d362ec70e..50cc92ad7d 100644
--- a/app/test/test_pcapng.c
+++ b/app/test/test_pcapng.c
@@ -25,13 +25,11 @@
 
 #define PCAPNG_TEST_DEBUG 0
 
-#define TOTAL_PACKETS	4096
+#define TOTAL_PACKETS	10000
 #define MAX_BURST	64
-#define MAX_GAP_US	100000
-#define DUMMY_MBUF_NUM	3
+#define DUMMY_MBUF_NUM	2
 
 static struct rte_mempool *mp;
-static const uint32_t pkt_len = 200;
 static uint16_t port_id;
 static const char null_dev[] = "net_null0";
 
@@ -41,13 +39,40 @@ struct dummy_mbuf {
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
+	unsigned int line = 0;
 
+	while (n < len - 1) {
+		char ch = FILL_START + (line % FILL_RANGE);
+		unsigned int i;
+
+		for (i = 0; i < FILL_LINE_LENGTH && n < len - 1; i++) {
+			buf[n++] = ch;
+			if (++ch > FILL_END)
+				ch = FILL_START;
+		}
+		if (n < len - 1)
+			buf[n++] = '\n';
+		line++;
+	}
+}
+
+static void
+dummy_mbuf_prep(struct rte_mbuf *mb, uint8_t buf[], uint32_t buf_len)
+{
 	mb->buf_addr = buf;
 	rte_mbuf_iova_set(mb, (uintptr_t)buf);
 	mb->buf_len = buf_len;
@@ -57,15 +82,11 @@ dummy_mbuf_prep(struct rte_mbuf *mb, uint8_t buf[], uint32_t buf_len,
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
@@ -84,32 +105,47 @@ mbuf1_prepare(struct dummy_mbuf *dm, uint32_t plen)
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
+
+static void
+mbuf1_resize(struct dummy_mbuf *dm, uint16_t len)
+{
+	struct {
+		struct rte_ether_hdr eth;
+		struct rte_ipv4_hdr ip;
+		struct rte_udp_hdr udp;
+	} *pkt = rte_pktmbuf_mtod(&dm->mb[0], void *);
 
-	pkt.ip.total_length = rte_cpu_to_be_16(plen);
-	pkt.ip.hdr_checksum = rte_ipv4_cksum(&pkt.ip);
+	dm->mb[1].data_len = len;
+	dm->mb[0].pkt_len = dm->mb[0].data_len + dm->mb[1].data_len;
 
-	plen -= sizeof(struct rte_ipv4_hdr);
-	pkt.udp.src_port = rte_rand();
-	pkt.udp.dgram_len = rte_cpu_to_be_16(plen);
+	len += sizeof(struct rte_udp_hdr);
+	pkt->udp.dgram_len = rte_cpu_to_be_16(len);
 
-	memcpy(rte_pktmbuf_mtod(dm->mb, void *), &pkt, sizeof(pkt));
+	len += sizeof(struct rte_ipv4_hdr);
+	pkt->ip.total_length = rte_cpu_to_be_16(len);
+	pkt->ip.hdr_checksum = 0;
+	pkt->ip.hdr_checksum = rte_ipv4_cksum(&pkt->ip);
 
-	/* Idea here is to create mbuf chain big enough that after mbuf deep copy they won't be
-	 * compressed into single mbuf to properly test store of chained mbufs
-	 */
-	dummy_mbuf_prep(&dm->mb[1], dm->buf[1], sizeof(dm->buf[1]), pkt_len);
-	dummy_mbuf_prep(&dm->mb[2], dm->buf[2], sizeof(dm->buf[2]), pkt_len);
-	rte_pktmbuf_chain(&dm->mb[0], &dm->mb[1]);
-	rte_pktmbuf_chain(&dm->mb[0], &dm->mb[2]);
+	rte_mbuf_sanity_check(&dm->mb[0], 1);
+	rte_mbuf_sanity_check(&dm->mb[1], 0);
 }
 
 static int
@@ -126,7 +162,7 @@ test_setup(void)
 	/* Make a pool for cloned packets */
 	mp = rte_pktmbuf_pool_create_by_ops("pcapng_test_pool",
 					    MAX_BURST * 32, 0, 0,
-					    rte_pcapng_mbuf_size(pkt_len) + 128,
+					    rte_pcapng_mbuf_size(MAX_DATA_SIZE),
 					    SOCKET_ID_ANY, "ring_mp_sc");
 	if (mp == NULL) {
 		fprintf(stderr, "Cannot create mempool\n");
@@ -142,19 +178,44 @@ test_setup(void)
 }
 
 static int
-fill_pcapng_file(rte_pcapng_t *pcapng, unsigned int num_packets)
+fill_pcapng_file(rte_pcapng_t *pcapng)
 {
 	struct dummy_mbuf mbfs;
 	struct rte_mbuf *orig;
 	unsigned int burst_size;
 	unsigned int count;
 	ssize_t len;
+	/*
+	 * These are some silly comments to test various lengths and alignments sprinkle
+	 * into the file. You can see these comments by using the dumpcap program on the file
+	 */
+	static const char * const examples[] = {
+		"Lockless and fearless - that’s how we roll in userspace.",
+		"Memory pool deep / Mbufs swim in lockless rings / Zero copy dreams,",
+		"Poll mode driver waits / No interrupts disturb its zen / Busy loop finds peace,",
+		"Memory barriers / rte_atomic_thread_fence() / Guards our shared state",
+		"Hugepages so vast / Two megabytes of glory / TLB misses weep",
+		"Packets flow like streams / Through the graph node pipeline / Iterate in place",
+
+		/* Long one to make sure we can do > 256 characters */
+		("Dear future maintainer: I am sorry. This packet was captured at 3 AM while "
+		 "debugging a priority flow control issue that turned out to be a loose cable. "
+		 "The rte_eth_tx_burst() call you see here has been cargo-culted through four "
+		 "generations of example code. The magic number 32 is not documented because "
+		 "nobody remembers why. Trust the process."),
+	};
+	/* How many microseconds does it take TSC to wrap around 32 bits */
+	const unsigned wrap_us
+		= (US_PER_S * (uint64_t)UINT32_MAX) / rte_get_tsc_hz();
+
+	/* Want overall test to take to wraparound at least twice. */
+	const unsigned int avg_gap = (2 * wrap_us)
+		/ (TOTAL_PACKETS / (MAX_BURST / 2));
 
-	/* make a dummy packet */
-	mbuf1_prepare(&mbfs, pkt_len);
+	mbuf1_prepare(&mbfs);
 	orig  = &mbfs.mb[0];
 
-	for (count = 0; count < num_packets; count += burst_size) {
+	for (count = 0; count < TOTAL_PACKETS; count += burst_size) {
 		struct rte_mbuf *clones[MAX_BURST];
 		unsigned int i;
 
@@ -162,9 +223,17 @@ fill_pcapng_file(rte_pcapng_t *pcapng, unsigned int num_packets)
 		burst_size = rte_rand_max(MAX_BURST) + 1;
 		for (i = 0; i < burst_size; i++) {
 			struct rte_mbuf *mc;
+			const char *comment = NULL;
+
+			/* Put randomized comment on every 100th packet (1%) */
+			if (count % 100 == 0)
+				comment = examples[rte_rand_max(RTE_DIM(examples))];
+
+			/* Vary the size of the packets, okay to allow 0 sized packet */
+			mbuf1_resize(&mbfs, rte_rand_max(MAX_DATA_SIZE));
 
 			mc = rte_pcapng_copy(port_id, 0, orig, mp, rte_pktmbuf_pkt_len(orig),
-					     RTE_PCAPNG_DIRECTION_IN, NULL);
+					     RTE_PCAPNG_DIRECTION_IN, comment);
 			if (mc == NULL) {
 				fprintf(stderr, "Cannot copy packet\n");
 				return -1;
@@ -182,8 +251,7 @@ fill_pcapng_file(rte_pcapng_t *pcapng, unsigned int num_packets)
 			return -1;
 		}
 
-		/* Leave a small gap between packets to test for time wrap */
-		usleep(rte_rand_max(MAX_GAP_US));
+		rte_delay_us_block(rte_rand_max(2 * avg_gap));
 	}
 
 	return count;
@@ -386,7 +454,7 @@ static int
 test_write_packets(void)
 {
 	char file_name[] = "/tmp/pcapng_test_XXXXXX.pcapng";
-	static rte_pcapng_t *pcapng;
+	rte_pcapng_t *pcapng = NULL;
 	int ret, tmp_fd, count;
 	uint64_t now = current_timestamp();
 
@@ -413,7 +481,14 @@ test_write_packets(void)
 		goto fail;
 	}
 
-	count = fill_pcapng_file(pcapng, TOTAL_PACKETS);
+	/* write a statistics block */
+	ret = rte_pcapng_write_stats(pcapng, port_id, 0, 0, NULL);
+	if (ret <= 0) {
+		fprintf(stderr, "Write of statistics failed\n");
+		goto fail;
+	}
+
+	count = fill_pcapng_file(pcapng);
 	if (count < 0)
 		goto fail;
 
-- 
2.51.0

