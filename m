Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2477D2502F
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Jan 2026 04:54:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4751640A87;
	Mon, 12 Jan 2026 05:54:17 +0100 (CET)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com
 [209.85.208.54]) by mails.dpdk.org (Postfix) with ESMTP id 8D93340A6C
 for <dev@dpdk.org>; Mon, 12 Jan 2026 05:54:15 +0100 (CET)
Received: by mail-ed1-f54.google.com with SMTP id
 4fb4d7f45d1cf-64b8b5410a1so8767291a12.2
 for <dev@dpdk.org>; Sun, 11 Jan 2026 20:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768193655;
 x=1768798455; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WQIHzKbk1DzNzg5T1fIcd0GWFgYckYkFxcvD4ENDa5g=;
 b=XHWIX1LAFiU1bgKz+eFRHx7PWHHu4xLY+4+XAcpOKQNLFZKBGFz6CUxwig4mfoeMMy
 Q0i9u2Gg5UNe3DIzTIlkqYi0zcaLtw/tW6H7lI07s9sgPnGxCxW5AA8VNmvcpOcm0ndr
 IjH+j2vHfVy7XRc0/86eBtedDmMKulqKIklXV/mx+pod59gf8NHPV7EzKnFiU6DBJGII
 xkOchM95GnkHaIiPIyZZbTODw9iXTaWLQNjpMnGKUPHqAJ3PfBRU9fhbnaX785VpXVe1
 pBmSa1nQq8KDky8TREKOJp7eOA1kF74gFlI/fex+CCdsvYqIP8sm/Xu11q68/nCpo9G8
 u1JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768193655; x=1768798455;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WQIHzKbk1DzNzg5T1fIcd0GWFgYckYkFxcvD4ENDa5g=;
 b=kuYbyc/upEZlMPIC+KQGxbJMtsVuujbrPqZFnhIMVgWVSSdgzLqr6aWeQzrFpuZxZ2
 P5DbtThGbberO9vqgZGrbcYbeg6RsJUHTWbTB4W6eMdz3dC0G65HahOIVGCn408FRCKG
 clvLN1f6P8MQh28qBIXZFZf2KFBTefUtOzKyuzP5V/NVswbOiYfn0pK+N1QXwN7njNdW
 aawA32qBB67qBvszyulePfIUKa4hvCDuJn2LF5/5+c/G2RFiFQc0PY1lRKZI2d8r9/Hj
 Zy49fMewAV0JPp5kMBDUpbuuOLS9cPcIG5CW0oiJwBJ8ygyDyatBjq52ef0NxPXp3M/U
 DHQw==
X-Gm-Message-State: AOJu0Yyc53DrPFFH/qteuAl2oSFqz4h58I2DPTZ99vimxWWMjLmVOaT0
 fwd4gfgZIpJauWBIJRl66NC8f+h6oJTthl7MtBllzhppHEkKkw4gaWpqnlh8nhZ0S44dwn0A+oP
 YAery
X-Gm-Gg: AY/fxX5kOp0XvjWzQ1uvVr3vhtO79l6rZ3fbOZwZrDLUdM1ZVT7pt87wS5h1FzAh7Dt
 0trYnvLuazfndNjhBCHUKOy1tBGOh8/AXRYpXPP7BXu+Le+5WoI4TxUhVDp0aMykKhukkblPS6A
 4ysS/1NZDInEbLiflInU/4XMnAD09UMDouPXZmvKUQw6iVT3Grg6R8JFWMZzeJJyEA2l+GV4uhg
 /E6eTIdkxtF+RXlVIv6BaRb00GTdcLoFHsZmc/4QGsVWytIJZ2M4jdYon2VS8crQE1b3d4sy1Zu
 tVTnwAIewCxGWPwpxgbvpcfKzJVPfSdMW6oOL1tzAW8f+2tAkqducfCbWpGPHjzrWJ311oKlWQD
 ZM5ZqQ9W3oUvQeN9/XUMykDvtGzG3JaO5HhYsCFivv+wjWCU21Tk/NjUK+FvCYWTh+WxFvjq4Bp
 MM74xhxGRhmM5vz15s8ywGboDacn1dUb4QR0IoKUWnqEflZb4+Aw==
X-Google-Smtp-Source: AGHT+IFXNZNwICAY7to+pmENVvYF/DDGd9iDg/W30y7/0VyhvGsyATluiTjGcjm6BdNs64jKHlA/SQ==
X-Received: by 2002:a17:907:d19:b0:b80:2e49:692c with SMTP id
 a640c23a62f3a-b844502e09emr1573121466b.9.1768193655041; 
 Sun, 11 Jan 2026 20:54:15 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b86f9a9103bsm534327166b.30.2026.01.11.20.54.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Jan 2026 20:54:14 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v3 5/7] test: vary size of packets in pcapng test
Date: Sun, 11 Jan 2026 20:50:18 -0800
Message-ID: <20260112045359.142999-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260112045359.142999-1-stephen@networkplumber.org>
References: <20251126051218.50568-1-stephen@networkplumber.org>
 <20260112045359.142999-1-stephen@networkplumber.org>
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

In order to exercise more logic in pcapng, vary the size
of the packets.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_pcapng.c | 94 +++++++++++++++++++++++++++++-------------
 1 file changed, 65 insertions(+), 29 deletions(-)

diff --git a/app/test/test_pcapng.c b/app/test/test_pcapng.c
index 228724d4c9..6e3df17525 100644
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
@@ -157,8 +191,7 @@ fill_pcapng_file(rte_pcapng_t *pcapng, unsigned int num_packets)
 		"Lockless and fearless - that’s how we roll in userspace."
 	};
 
-	/* make a dummy packet */
-	mbuf1_prepare(&mbfs, pkt_len);
+	mbuf1_prepare(&mbfs);
 	orig  = &mbfs.mb[0];
 
 	for (count = 0; count < num_packets; count += burst_size) {
@@ -175,6 +208,9 @@ fill_pcapng_file(rte_pcapng_t *pcapng, unsigned int num_packets)
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

