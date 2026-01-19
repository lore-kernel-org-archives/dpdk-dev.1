Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FD5D29C58
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Jan 2026 18:20:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 609B740658;
	Mon, 19 Jan 2026 19:20:35 +0100 (CET)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com
 [209.85.208.48]) by mails.dpdk.org (Postfix) with ESMTP id 27D7F40648
 for <dev@dpdk.org>; Mon, 19 Jan 2026 19:20:34 +0100 (CET)
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-65089cebdb4so7167332a12.0
 for <dev@dpdk.org>; Mon, 19 Jan 2026 10:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768846834;
 x=1769451634; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A9NvZ1TbNq3EpRiAMfdx3r03YzC5bQKdBMxdxTZX9zs=;
 b=C8ep60pyXJOcJPnGsxBn0zHoVvGt6VqMXnqoRKmSBwuxWThoBZx1XxxZVAStqg8Hfm
 lPy+sS9o8g8K4WrgBoeS/vf0LRvJtCMgo+3yAmrlnPiejY9aD0seVHAmSbl+J6bjyRoo
 c2InKbK1JlzgRrEfZKiDnOa5096YeKLtT3iSN4ZLSWQZROkLbf3Ef1q4qsTbtGialZLi
 +Jl46FAfg1JafRrpC50HYp2tlhvU0yzGES3KDCj4oRCgDi4E3wfNXOVUace8nl08Ylur
 lePeirtkvFB+XkD3a88K9R33b66MushLIyC7aFFcaaGdgm/4UfPU0Zo8yi+85gczxUa8
 NXOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768846834; x=1769451634;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=A9NvZ1TbNq3EpRiAMfdx3r03YzC5bQKdBMxdxTZX9zs=;
 b=XM1FYTA/4qNUw9ve5k/ZgL+p8MknQQFMsZFz7xCsri0lBoPCzNPq/TbwmXjs+gdaE6
 MrVCIqrfJY4Ac11HHvD7nQ8AhXGzs0V5Mj1/B6ZFSnUYlMtZ0c+cXbTw4ZtX9ybYvmzV
 JUooMxAVTR2jWLN2jwXfXtVbVqNvjJmQwsSvmI9zDLQb0UTI5KH8bsXSOf2UHsd6+/ct
 qSbNgZx4mJAzmQwlmvTWcY/T9UEVoSo+Wh26LcB0Eco6cUdrNhgjb3TVcxMdDoxQ7+BR
 8RY098F6jZELvzsKgMyihT0ToHN3gyNcwgOpjnrPIDrkSSl6OJTmOL8RF9KbPP2ikSa2
 RQkg==
X-Gm-Message-State: AOJu0YzZNHDlj0oH26ulmydm1K6oSaqThLTdOBGvSbZdnsQnyPpUty3z
 M0Vh7oNLGBurOosyOk123kkNNOIgj51gyYkqQVJ2OfrxlSqeQQ+lIhjvIstY/VikH9RZZdk0Dhi
 WYJXt
X-Gm-Gg: AZuq6aLP87ny0gZkD1IUhXpE4hJeUBj4vhIMWMsS/4fqS1yro818I9MHBFBrpyPxBXG
 w334FfHylZgmXHiJyblvSgj1UZhqPtb3RXMA9H5t448FY4n1mvpYiMoQVnibbPIO52OubIbL7l7
 g8ezNJx9P1OAF7TGUx7JH0U/+Kchn1v4yZe8rBCUW3rWyiNrOcLy8g20diZDwFiJVSAtf9GMuoj
 D/App5ohA/bCsKrJPd9w3XsLVkoxpwrjUmpTP/x8l8X7TMbQz7FZPxGnDUTtAtbzdLDE7r4Mhxv
 +kIJFysi9V3yOEGGEWT7x4sbo8Gk1qVb/a/F1gCgMlWeeburLxOHIDlN1N2/o3ZzNG0ClzS/1WA
 ng7+USXN3kzv0PhoiIU5IEsyoHKbyBxQZZjxDlIUAVHzAKOSiq/r02MLfj93pQRb0SbjtiGFftg
 drRNPHenxLXKArTktrGNCHFF22YcbSJ8EyXkTLdC8SaBKKUExU6A==
X-Received: by 2002:a05:6402:26d3:b0:64b:42a6:3946 with SMTP id
 4fb4d7f45d1cf-654b93641a7mr9111871a12.7.1768846833630; 
 Mon, 19 Jan 2026 10:20:33 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-65452cdab55sm10878829a12.10.2026.01.19.10.20.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 10:20:32 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v5 5/5] test: add more tests for pcapng
Date: Mon, 19 Jan 2026 10:19:03 -0800
Message-ID: <20260119182016.44769-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260119182016.44769-1-stephen@networkplumber.org>
References: <20251126051218.50568-1-stephen@networkplumber.org>
 <20260119182016.44769-1-stephen@networkplumber.org>
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

Add some more cases where comment is set in pcapng file.

In order to exercise more logic in pcapng, vary the size
of the packets.

Want to make sure that test takes long enough that 32 bit
counter wraps around.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_pcapng.c | 145 ++++++++++++++++++++++++++++++-----------
 1 file changed, 108 insertions(+), 37 deletions(-)

diff --git a/app/test/test_pcapng.c b/app/test/test_pcapng.c
index 5d362ec70e..283a6496d4 100644
--- a/app/test/test_pcapng.c
+++ b/app/test/test_pcapng.c
@@ -27,11 +27,9 @@
 
 #define TOTAL_PACKETS	4096
 #define MAX_BURST	64
-#define MAX_GAP_US	100000
-#define DUMMY_MBUF_NUM	3
+#define DUMMY_MBUF_NUM	2
 
 static struct rte_mempool *mp;
-static const uint32_t pkt_len = 200;
 static uint16_t port_id;
 static const char null_dev[] = "net_null0";
 
@@ -41,13 +39,36 @@ struct dummy_mbuf {
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
@@ -57,15 +78,11 @@ dummy_mbuf_prep(struct rte_mbuf *mb, uint8_t buf[], uint32_t buf_len,
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
@@ -84,32 +101,47 @@ mbuf1_prepare(struct dummy_mbuf *dm, uint32_t plen)
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
 
-	pkt.ip.total_length = rte_cpu_to_be_16(plen);
-	pkt.ip.hdr_checksum = rte_ipv4_cksum(&pkt.ip);
+	fill_mbuf(&dm->mb[1]);
+	rte_pktmbuf_chain(&dm->mb[0], &dm->mb[1]);
 
-	plen -= sizeof(struct rte_ipv4_hdr);
-	pkt.udp.src_port = rte_rand();
-	pkt.udp.dgram_len = rte_cpu_to_be_16(plen);
+	rte_mbuf_sanity_check(&dm->mb[0], 1);
+	rte_mbuf_sanity_check(&dm->mb[1], 0);
+}
 
-	memcpy(rte_pktmbuf_mtod(dm->mb, void *), &pkt, sizeof(pkt));
+static void
+mbuf1_resize(struct dummy_mbuf *dm, uint16_t len)
+{
+	struct {
+		struct rte_ether_hdr eth;
+		struct rte_ipv4_hdr ip;
+		struct rte_udp_hdr udp;
+	} *pkt = rte_pktmbuf_mtod(&dm->mb[0], void *);
 
-	/* Idea here is to create mbuf chain big enough that after mbuf deep copy they won't be
-	 * compressed into single mbuf to properly test store of chained mbufs
-	 */
-	dummy_mbuf_prep(&dm->mb[1], dm->buf[1], sizeof(dm->buf[1]), pkt_len);
-	dummy_mbuf_prep(&dm->mb[2], dm->buf[2], sizeof(dm->buf[2]), pkt_len);
-	rte_pktmbuf_chain(&dm->mb[0], &dm->mb[1]);
-	rte_pktmbuf_chain(&dm->mb[0], &dm->mb[2]);
+	dm->mb[1].data_len = len;
+	dm->mb[0].pkt_len = dm->mb[0].data_len + dm->mb[1].data_len;
+
+	len += sizeof(struct rte_udp_hdr);
+	pkt->udp.dgram_len = rte_cpu_to_be_16(len);
+
+	len += sizeof(struct rte_ipv4_hdr);
+	pkt->ip.total_length = rte_cpu_to_be_16(len);
+	pkt->ip.hdr_checksum = 0;
+	pkt->ip.hdr_checksum = rte_ipv4_cksum(&pkt->ip);
+
+	rte_mbuf_sanity_check(&dm->mb[0], 1);
+	rte_mbuf_sanity_check(&dm->mb[1], 0);
 }
 
 static int
@@ -126,7 +158,7 @@ test_setup(void)
 	/* Make a pool for cloned packets */
 	mp = rte_pktmbuf_pool_create_by_ops("pcapng_test_pool",
 					    MAX_BURST * 32, 0, 0,
-					    rte_pcapng_mbuf_size(pkt_len) + 128,
+					    rte_pcapng_mbuf_size(MAX_DATA_SIZE),
 					    SOCKET_ID_ANY, "ring_mp_sc");
 	if (mp == NULL) {
 		fprintf(stderr, "Cannot create mempool\n");
@@ -142,19 +174,44 @@ test_setup(void)
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
 
-	/* make a dummy packet */
-	mbuf1_prepare(&mbfs, pkt_len);
+	/* Want overall test to take to wraparound at least twice. */
+	const unsigned int avg_gap = (2 * wrap_us)
+		/ (TOTAL_PACKETS / (MAX_BURST / 2));
+
+	mbuf1_prepare(&mbfs);
 	orig  = &mbfs.mb[0];
 
-	for (count = 0; count < num_packets; count += burst_size) {
+	for (count = 0; count < TOTAL_PACKETS; count += burst_size) {
 		struct rte_mbuf *clones[MAX_BURST];
 		unsigned int i;
 
@@ -162,9 +219,17 @@ fill_pcapng_file(rte_pcapng_t *pcapng, unsigned int num_packets)
 		burst_size = rte_rand_max(MAX_BURST) + 1;
 		for (i = 0; i < burst_size; i++) {
 			struct rte_mbuf *mc;
+			const char *comment = NULL;
+
+			/* Put comment on occasional packets */
+			if ((count + i) % 41 == 0)
+				comment = examples[rte_rand_max(RTE_DIM(examples))];
+
+			/* Vary the size of the packets */
+			mbuf1_resize(&mbfs, rte_rand_max(MAX_DATA_SIZE));
 
 			mc = rte_pcapng_copy(port_id, 0, orig, mp, rte_pktmbuf_pkt_len(orig),
-					     RTE_PCAPNG_DIRECTION_IN, NULL);
+					     RTE_PCAPNG_DIRECTION_IN, comment);
 			if (mc == NULL) {
 				fprintf(stderr, "Cannot copy packet\n");
 				return -1;
@@ -182,8 +247,7 @@ fill_pcapng_file(rte_pcapng_t *pcapng, unsigned int num_packets)
 			return -1;
 		}
 
-		/* Leave a small gap between packets to test for time wrap */
-		usleep(rte_rand_max(MAX_GAP_US));
+		rte_delay_us_block(rte_rand_max(2 * avg_gap));
 	}
 
 	return count;
@@ -386,7 +450,7 @@ static int
 test_write_packets(void)
 {
 	char file_name[] = "/tmp/pcapng_test_XXXXXX.pcapng";
-	static rte_pcapng_t *pcapng;
+	rte_pcapng_t *pcapng = NULL;
 	int ret, tmp_fd, count;
 	uint64_t now = current_timestamp();
 
@@ -413,7 +477,14 @@ test_write_packets(void)
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

