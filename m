Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79464C87FC9
	for <dpdk-dev@archiver.kernel.org>; Sat,  2 Aug 2025 11:08:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 308FC40662;
	Sat,  2 Aug 2025 13:08:20 +0200 (CEST)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by mails.dpdk.org (Postfix) with ESMTP id A17D140041
 for <dev@dpdk.org>; Sat,  2 Aug 2025 13:08:18 +0200 (CEST)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-b3f80661991so2894881a12.0
 for <dev@dpdk.org>; Sat, 02 Aug 2025 04:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1754132897; x=1754737697; darn=dpdk.org;
 h=cc:to:subject:message-id:date:in-reply-to:references:mime-version
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=JAPmaq5LHEiA8GzdggJqq3a59JJq6ZhivNJFoMmOZk0=;
 b=EyYGRlyJb8v8WRwPZm1zC5SbAr78CuGvSBluyWKF+IJ0+plhp7WybyqR1+gtFyK5v2
 6YmHjUDQK0GHyMPs/PN56bX6osYw6e74861UOClrHuWCHTGas4Rw0adR44Vg/FeFEpGJ
 JTiXq4m7g57LoVIhHqFAm3ETyOrCOUzbEU5JA7JAPDem16a5WQqxAGSIKNW93rAXFohj
 12O4P/nRBVx7nzMATulL+Lwt4JBKChfHrwzC69/SqtbMdEaY+S9TR3kXxWJh+cyt34R4
 kEFAOHd4cpSVh3ioNavDJjxHG+Q1gIV5lotJ+EVMkfEDffOdPMI0m1geG96twSNI85JT
 AzOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754132897; x=1754737697;
 h=cc:to:subject:message-id:date:in-reply-to:references:mime-version
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JAPmaq5LHEiA8GzdggJqq3a59JJq6ZhivNJFoMmOZk0=;
 b=FiZ8+mmHY80giPQpXbKeXC5+7MhJ90TSZEQSeOaXyZlSkfh8Z5zc7nWotNpJDzNJ16
 q6+TOPqWwxA21G+Nik13m/jkdJ9wjp+oYE68w3/gWng3nEJMpiSebMAXQTj+PXaCM2Dz
 TAC793dxeFuB+jnZnvT8NhYDY+hAcbe7a8xRExigYIoTMyelWrYoxQQ4BQCUyZlg2VQ8
 fzIv9w6lazlvx1Rdg/oyi/MB4pXcxbpLg1dQYjVkXhPAaM9CyiQJvIsRcW5se9JlPIOL
 mxK1O/WiDLy3R3zjrCygAoZITxEQvTtJqD37XYihApQuau3gJ0SRgYVeXRmx4dLAhuki
 Ot+A==
X-Gm-Message-State: AOJu0Yz0mpT0l89apZf8Hz1Zj3OcS9rutmat3MY5Mh3a+bS7kSZK/Xor
 xH53nUNWLqUl77NNlxuSocdO6XKhz7ig/QNZ4BzhdNA7t+9sWYyOWNofQgS4xRqmfS6SY3cbvMf
 24fdCDuJ60imwmgpej7pv6VGIaYLIAqDHMpfREXAbgC64w2wv58Cl
X-Gm-Gg: ASbGnctA09bb5cUKrehosJHOgzIYrV1gDs2ObQyxa6DTw41eaVw25OdM7wV8zCtDroM
 0+DLxHAL0NRXdEFP/U7okdUJPcffUxxYkYAdiU+fRkauSUUi4X4y7MtVbkX1F7x3CFtamttnx+e
 XJyyjIfmUCP0zGsMGnxAv3wmOo+T68nFCzGt9Nt4/I9dbWEWxI4ZgBlH33l6Ff8vgojAx4CD8KQ
 SDz7zR0ShbNiE7bNjzh
X-Google-Smtp-Source: AGHT+IFE7bXmJ4xVd1/Y28Snk1VdvspWMlPzSytWwNz/DA7nw81Ll5DgbXZgbFqN/qoTGtKWYJwZF4AnyN9RGwH46R0=
X-Received: by 2002:a17:90b:3148:b0:312:dbcd:b93d with SMTP id
 98e67ed59e1d1-320da613eebmr13532772a91.14.1754132897209; Sat, 02 Aug 2025
 04:08:17 -0700 (PDT)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST; 
 Sat, 2 Aug 2025 04:08:16 -0700
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST; 
 Sat, 2 Aug 2025 04:08:16 -0700
From: Su Sai <susai.ss@bytedance.com>
X-Mailer: git-send-email 2.20.1
Mime-Version: 1.0
References: <CABsP7wMLpN-mggd7dY42YEbq_YH5nz=BQSQHV43yZWhpbDNy=Q@mail.gmail.com>
In-Reply-To: <CABsP7wMLpN-mggd7dY42YEbq_YH5nz=BQSQHV43yZWhpbDNy=Q@mail.gmail.com>
X-Original-From: Su Sai <susai.ss@bytedance.com>
Date: Sat, 2 Aug 2025 04:08:16 -0700
X-Gm-Features: Ac12FXyUMPBV_VWEeWIab1j5AqMwSvHsEJy52kZsHbPIMTDPDowLbfNCmksPPCA
Message-ID: <CABsP7wOxyD2zEnZ2Yc0BrSDg3aMAVxcNqrHR=mWygUZTShRfDA@mail.gmail.com>
Subject: [v3] net/cksum: compute raw cksum for several segments
To: dev@dpdk.org
Cc: Su Sai <susai.ss@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
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

The rte_raw_cksum_mbuf function is used to compute
the raw checksum of a packet.
If the packet payload stored in multi mbuf, the function
will goto the hard case. In hard case,
the variable 'tmp' is a type of uint32_t,
so rte_bswap16 will drop high 16 bit.
Meanwhile, the variable 'sum' is a type of uint32_t,
so 'sum += tmp' will drop the carry when overflow.
Both drop will make cksum incorrect.
This commit fixes the above bug.

Signed-off-by: Su Sai <susai.ss@bytedance.com>
---
 .mailmap              |   1 +
 app/test/test_cksum.c | 107 ++++++++++++++++++++++++++++++++++++++++++
 lib/net/rte_cksum.h   |  26 ++++++++--
 3 files changed, 130 insertions(+), 4 deletions(-)

diff --git a/.mailmap b/.mailmap
index 34a99f93a1..838b544a97 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1891,3 +1891,4 @@ Zoltan Kiss <zoltan.kiss@schaman.hu>
<zoltan.kiss@linaro.org>
 Zorik Machulsky <zorik@amazon.com>
 Zyta Szpak <zyta@marvell.com> <zr@semihalf.com>
 Zyta Szpak <zyta@marvell.com> <zyta.szpak@semihalf.com>
+Su Sai <susai.ss@bytedance.com>
diff --git a/app/test/test_cksum.c b/app/test/test_cksum.c
index f2ab5af5a7..6765f48572 100644
--- a/app/test/test_cksum.c
+++ b/app/test/test_cksum.c
@@ -85,6 +85,42 @@ static const char test_cksum_ipv4_opts_udp[] = {
 	0x00, 0x35, 0x00, 0x09, 0x89, 0x6f, 0x78,
 };

+/*
+ * generated in scapy with
+ * Ether()/IP()/TCP(options=[NOP,NOP,Timestamps])/os.urandom(113))
+ */
+static const char test_cksum_ipv4_tcp_multi_segs[] = {
+	0x00, 0x16, 0x3e, 0x0b, 0x6b, 0xd2, 0xee, 0xff,
+	0xff, 0xff, 0xff, 0xff, 0x08, 0x00, 0x45, 0x00,
+	0x00, 0xa5, 0x46, 0x10, 0x40, 0x00, 0x40, 0x06,
+	0x80, 0xb5, 0xc0, 0xa8, 0xf9, 0x1d, 0xc0, 0xa8,
+	0xf9, 0x1e, 0xdc, 0xa2, 0x14, 0x51, 0xbb, 0x8f,
+	0xa0, 0x00, 0xe4, 0x7c, 0xe4, 0xb8, 0x80, 0x10,
+	0x02, 0x00, 0x4b, 0xc1, 0x00, 0x00, 0x01, 0x01,
+	0x08, 0x0a, 0x90, 0x60, 0xf4, 0xff, 0x03, 0xc5,
+	0xb4, 0x19, 0x77, 0x34, 0xd4, 0xdc, 0x84, 0x86,
+	0xff, 0x44, 0x09, 0x63, 0x36, 0x2e, 0x26, 0x9b,
+	0x90, 0x70, 0xf2, 0xed, 0xc8, 0x5b, 0x87, 0xaa,
+	0xb4, 0x67, 0x6b, 0x32, 0x3d, 0xc4, 0xbf, 0x15,
+	0xa9, 0x16, 0x6c, 0x2a, 0x9d, 0xb2, 0xb7, 0x6b,
+	0x58, 0x44, 0x58, 0x12, 0x4b, 0x8f, 0xe5, 0x12,
+	0x11, 0x90, 0x94, 0x68, 0x37, 0xad, 0x0a, 0x9b,
+	0xd6, 0x79, 0xf2, 0xb7, 0x31, 0xcf, 0x44, 0x22,
+	0xc8, 0x99, 0x3f, 0xe5, 0xe7, 0xac, 0xc7, 0x0b,
+	0x86, 0xdf, 0xda, 0xed, 0x0a, 0x0f, 0x86, 0xd7,
+	0x48, 0xe2, 0xf1, 0xc2, 0x43, 0xed, 0x47, 0x3a,
+	0xea, 0x25, 0x2d, 0xd6, 0x60, 0x38, 0x30, 0x07,
+	0x28, 0xdd, 0x1f, 0x0c, 0xdd, 0x7b, 0x7c, 0xd9,
+	0x35, 0x9d, 0x14, 0xaa, 0xc6, 0x35, 0xd1, 0x03,
+	0x38, 0xb1, 0xf5,
+};
+
+static const uint8_t test_cksum_ipv4_tcp_multi_segs_len[] = {
+	66,  /* the first seg contains all headers, including L2 to L4 */
+	61,  /* the second seg length is odd, test byte order independent */
+	52,  /* three segs are sufficient to test the most complex scenarios */
+};
+
 /* test l3/l4 checksum api */
 static int
 test_l4_cksum(struct rte_mempool *pktmbuf_pool, const char *pktdata,
size_t len)
@@ -223,6 +259,71 @@ test_l4_cksum(struct rte_mempool *pktmbuf_pool,
const char *pktdata, size_t len)
 	return -1;
 }

+/* test l4 checksum api for a packet with multiple mbufs */
+static int
+test_l4_cksum_multi_mbufs(struct rte_mempool *pktmbuf_pool, const
char *pktdata, size_t len,
+			     const uint8_t *segs, size_t segs_len)
+{
+	struct rte_mbuf *m[NB_MBUF] = {0};
+	struct rte_mbuf *m_hdr = NULL;
+	struct rte_net_hdr_lens hdr_lens;
+	size_t i, off = 0;
+	uint32_t packet_type;
+	void *l3_hdr;
+	uint32_t l3;
+	char *data;
+
+	for (i = 0; i < segs_len; i++) {
+		m[i] = rte_pktmbuf_alloc(pktmbuf_pool);
+		if (m[i] == NULL)
+			GOTO_FAIL("Cannot allocate mbuf");
+
+		data = rte_pktmbuf_append(m[i], segs[i]);
+		if (data == NULL)
+			GOTO_FAIL("Cannot append data");
+
+		rte_memcpy(data, pktdata + off, segs[i]);
+		off += segs[i];
+
+		if (m_hdr) {
+			if (rte_pktmbuf_chain(m_hdr, m[i]))
+				GOTO_FAIL("Cannot chain mbuf");
+		} else {
+			m_hdr = m[i];
+		}
+	}
+
+	if (off != len)
+		GOTO_FAIL("Invalid segs");
+
+	packet_type = rte_net_get_ptype(m_hdr, &hdr_lens, RTE_PTYPE_ALL_MASK);
+	l3 = packet_type & RTE_PTYPE_L3_MASK;
+
+	l3_hdr = rte_pktmbuf_mtod_offset(m_hdr, void *, hdr_lens.l2_len);
+	off = hdr_lens.l2_len + hdr_lens.l3_len;
+
+	if (l3 == RTE_PTYPE_L3_IPV4 || l3 == RTE_PTYPE_L3_IPV4_EXT) {
+		if (rte_ipv4_udptcp_cksum_mbuf_verify(m_hdr, l3_hdr, off) != 0)
+			GOTO_FAIL("Invalid L4 checksum verification for multiple mbufs");
+	} else if (l3 == RTE_PTYPE_L3_IPV6 || l3 == RTE_PTYPE_L3_IPV6_EXT) {
+		if (rte_ipv6_udptcp_cksum_mbuf_verify(m_hdr, l3_hdr, off) != 0)
+			GOTO_FAIL("Invalid L4 checksum verification for multiple mbufs");
+	}
+
+	for (i = 0; i < segs_len; i++)
+		rte_pktmbuf_free(m[i]);
+
+	return 0;
+
+fail:
+	for (i = 0; i < segs_len; i++) {
+		if (m[i])
+			rte_pktmbuf_free(m[i]);
+	}
+
+	return -1;
+}
+
 static int
 test_cksum(void)
 {
@@ -256,6 +357,12 @@ test_cksum(void)
 			  sizeof(test_cksum_ipv4_opts_udp)) < 0)
 		GOTO_FAIL("checksum error on ipv4_opts_udp");

+	if (test_l4_cksum_multi_mbufs(pktmbuf_pool, test_cksum_ipv4_tcp_multi_segs,
+			  sizeof(test_cksum_ipv4_tcp_multi_segs),
+			  test_cksum_ipv4_tcp_multi_segs_len,
+			  sizeof(test_cksum_ipv4_tcp_multi_segs_len)) < 0)
+		GOTO_FAIL("checksum error on multi mbufs check");
+
 	rte_mempool_free(pktmbuf_pool);

 	return 0;
diff --git a/lib/net/rte_cksum.h b/lib/net/rte_cksum.h
index a8e8927952..0f0b63a916 100644
--- a/lib/net/rte_cksum.h
+++ b/lib/net/rte_cksum.h
@@ -80,6 +80,24 @@ __rte_raw_cksum_reduce(uint32_t sum)
 	return (uint16_t)sum;
 }

+/**
+ * @internal Reduce a sum to the non-complemented checksum.
+ * Helper routine for the rte_raw_cksum_mbuf().
+ *
+ * @param sum
+ *   Value of the sum.
+ * @return
+ *   The non-complemented checksum.
+ */
+static inline uint16_t
+__rte_raw_cksum_reduce_u64(uint64_t sum)
+{
+	uint32_t tmp;
+	tmp = __rte_raw_cksum_reduce((uint32_t)sum);
+	tmp += __rte_raw_cksum_reduce((uint32_t)(sum >> 32));
+	return __rte_raw_cksum_reduce(tmp);
+}
+
 /**
  * Process the non-complemented checksum of a buffer.
  *
@@ -119,8 +137,8 @@ rte_raw_cksum_mbuf(const struct rte_mbuf *m,
uint32_t off, uint32_t len,
 {
 	const struct rte_mbuf *seg;
 	const char *buf;
-	uint32_t sum, tmp;
-	uint32_t seglen, done;
+	uint32_t tmp, seglen, done;
+	uint64_t sum;

 	/* easy case: all data in the first segment */
 	if (off + len <= rte_pktmbuf_data_len(m)) {
@@ -157,7 +175,7 @@ rte_raw_cksum_mbuf(const struct rte_mbuf *m,
uint32_t off, uint32_t len,
 	for (;;) {
 		tmp = __rte_raw_cksum(buf, seglen, 0);
 		if (done & 1)
-			tmp = rte_bswap16((uint16_t)tmp);
+			tmp = rte_bswap32(tmp);
 		sum += tmp;
 		done += seglen;
 		if (done == len)
@@ -169,7 +187,7 @@ rte_raw_cksum_mbuf(const struct rte_mbuf *m,
uint32_t off, uint32_t len,
 			seglen = len - done;
 	}

-	*cksum = __rte_raw_cksum_reduce(sum);
+	*cksum = __rte_raw_cksum_reduce_u64(sum);
 	return 0;
 }

-- 
2.20.1
