Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 130B7CD98DA
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 12:38:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7067E40289;
	Tue, 16 Jun 2026 14:38:25 +0200 (CEST)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by mails.dpdk.org (Postfix) with ESMTP id 2F2C34026A
 for <dev@dpdk.org>; Tue, 16 Jun 2026 14:38:24 +0200 (CEST)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-2c0c2d8b95bso34519985ad.1
 for <dev@dpdk.org>; Tue, 16 Jun 2026 05:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781613503; x=1782218303; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LocTYEejZBE7D1B/NNDfjX0jD/NO2T3H+9jfzA3Jb7k=;
 b=KS8lTCS3NE3aIqIynHkuvOXfHpFNXHr4Dve5tR/EuKLP7Hn7jGB3CeV9ErGt0AnZlZ
 imQs8JBwlqegWl1CYWbftxfOCf1CTdutM0Znp+1YhB7k3IfdY+y4dIH4fWb8mxZkLh61
 Jv74m9uR9KMU+DCGxdsqLu0vzFjQJATiUD59EE5/tgGrXkO8DGX+09bg/jJt9HcFlfHF
 shGKfG4omjqJB6cug4ZMHsB9Y/2eNsblD8GaPx8JDl6ZT9RV48k0+dVBDOdqj/EMQRxm
 KAEYOji6HBUHY2H9mP6ki5L140sw7Gq1lELmQV0F+dvGKMiS2iFCRP7iwJkd3Ag9xisg
 tAlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781613503; x=1782218303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LocTYEejZBE7D1B/NNDfjX0jD/NO2T3H+9jfzA3Jb7k=;
 b=Hdcd/XFxfGvkCVCGCBDpqAajnGEqFMq0q868vmingHUo5oDTnmbf/+3a0rwTeZ0i9Z
 hKp6d7oVH9nZXtMK+tMaDH81UMr6qolZY7mcD3uqzVRvX2xi3AkYNKpzhrwapX1HVxp9
 iUJTdE9ZPqMf/5qxHdR0HuXaO0pVA4o4RH22IpE+OJ4H7kZvyIAF6b8ADjouAun7SGTe
 SXHoIwBHOc6YZPjmtSpFPVofJvDJNs6X/jnJ5Alm9zlwybKwzh6Us5kiCumeMk9pEcXl
 ffLlliQPYOBKUxaDZlS+0lcYEUuJuap8jOdaiJ5ow9YPcT4Exgts7T+LiLVSaZg0tylx
 xOkw==
X-Gm-Message-State: AOJu0YzKpHs7ZwE8ZqZ/reofptg5R9ICHwzFKu7uIOJENdePWWDhGUyr
 krlhNqlSicuuIETQsdI1GtcnV2KCZpxDKCFlQ07j7HcbL4x4wb9imCPK
X-Gm-Gg: Acq92OE1JPYpRENCM5X50Y1iX9k18nDYzrhQAzhKFZsLGvVDhGv7QoIdKFTDalicMvv
 fvYAEYFgfREZcZgng0qp7SEAA5KLSFfo/ZZIpkDNr1vg/83LDcdWJ9zze0qyNLKnL7OF3/ylrl4
 d4sYvNXn0FLIy+DzyZq0hgnrHRJtBDZx9kZ8gzl6D6s57d2F5BWVLuvpVwFiksztyCC16e1erAv
 EPB4kICGS0Y/LVoZWLD+a80RlLMv2kF22xuZQfdWI+VnF7CS/W+DrtX1jLuUPSDXHnHN4o/6dLW
 MTzl+Fs1KuR4mNxebmXMk3h2gBg4G0O/fHFNaan4HkfWkpRryJPXJu3DMe1QN7CwGSdkRK+UayM
 pFCxKxbmp701QLPhCPrDDi5EMpaab7JqRt3tA21wdgybiGXPwBCVeM2oaXtY4mYlcPsJ62yFQtH
 C4UkD7xIb3OBE4jWTGJnWQkdrblIhsAZa3RCZls8xnYAe0Yg62ZEkCXFuR0dnez78=
X-Received: by 2002:a17:903:2351:b0:2c0:dd75:e824 with SMTP id
 d9443c01a7336-2c6641ca3cbmr167474945ad.4.1781613503212; 
 Tue, 16 Jun 2026 05:38:23 -0700 (PDT)
Received: from YTJMJ2RP0G.bytedance.net ([139.177.225.229])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c42fbb4134sm118865005ad.30.2026.06.16.05.38.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 16 Jun 2026 05:38:22 -0700 (PDT)
From: Su Sai <spiderdetective.ss@gmail.com>
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	spiderdetective.ss@gmail.com
Subject: [v4] net/cksum: compute raw cksum for several segments
Date: Tue, 16 Jun 2026 20:38:12 +0800
Message-Id: <20260616123812.21048-1-spiderdetective.ss@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20260608100202.0deac83d@phoenix.local>
References: <20260608100202.0deac83d@phoenix.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
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

Signed-off-by: Su Sai <spiderdetective.ss@gmail.com>
---
 .mailmap              |   1 +
 app/test/test_cksum.c | 102 ++++++++++++++++++++++++++++++++++++++++++
 lib/net/rte_cksum.h   |  27 +++++++++--
 3 files changed, 126 insertions(+), 4 deletions(-)

diff --git a/.mailmap b/.mailmap
index 4001e5fb0e..bcf73cb902 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1630,6 +1630,7 @@ Sylvia Grundwürmer <sylvia.grundwuermer@b-plus.com>
 Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>
 Sylwia Wnuczko <sylwia.wnuczko@intel.com>
 Szymon Sliwa <szs@semihalf.com>
+Su Sai <spiderdetective.ss@gmail.com> <susai.ss@bytedance.com>
 Szymon T Cudzilo <szymon.t.cudzilo@intel.com>
 Tadhg Kearney <tadhg.kearney@intel.com>
 Taekyung Kim <kim.tae.kyung@navercorp.com>
diff --git a/app/test/test_cksum.c b/app/test/test_cksum.c
index ea443382a1..5bd9723fbd 100644
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
 test_l4_cksum(struct rte_mempool *pktmbuf_pool, const char *pktdata, size_t len)
@@ -223,6 +259,66 @@ test_l4_cksum(struct rte_mempool *pktmbuf_pool, const char *pktdata, size_t len)
 	return -1;
 }
 
+/* test l4 checksum api for a packet with multiple mbufs */
+static int
+test_l4_cksum_multi_mbufs(struct rte_mempool *pktmbuf_pool, const char *pktdata, size_t len,
+			     const uint8_t *segs, size_t segs_len)
+{
+	struct rte_mbuf *m[NB_MBUF] = {0};
+	struct rte_mbuf *m_hdr = NULL;
+	struct rte_net_hdr_lens hdr_lens;
+	size_t i, off = 0;
+	uint32_t packet_type, l3;
+	void *l3_hdr;
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
+		memcpy(data, pktdata + off, segs[i]);
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
+	rte_pktmbuf_free_bulk(m, segs_len);
+
+	return 0;
+
+fail:
+	rte_pktmbuf_free_bulk(m, segs_len);
+
+	return -1;
+}
+
 static int
 test_cksum(void)
 {
@@ -256,6 +352,12 @@ test_cksum(void)
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
index a8e8927952..679ba82eb6 100644
--- a/lib/net/rte_cksum.h
+++ b/lib/net/rte_cksum.h
@@ -80,6 +80,25 @@ __rte_raw_cksum_reduce(uint32_t sum)
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
+
+	tmp = __rte_raw_cksum_reduce((uint32_t)sum);
+	tmp += __rte_raw_cksum_reduce((uint32_t)(sum >> 32));
+	return __rte_raw_cksum_reduce(tmp);
+}
+
 /**
  * Process the non-complemented checksum of a buffer.
  *
@@ -119,8 +138,8 @@ rte_raw_cksum_mbuf(const struct rte_mbuf *m, uint32_t off, uint32_t len,
 {
 	const struct rte_mbuf *seg;
 	const char *buf;
-	uint32_t sum, tmp;
-	uint32_t seglen, done;
+	uint32_t seglen, done, tmp;
+	uint64_t sum;
 
 	/* easy case: all data in the first segment */
 	if (off + len <= rte_pktmbuf_data_len(m)) {
@@ -157,7 +176,7 @@ rte_raw_cksum_mbuf(const struct rte_mbuf *m, uint32_t off, uint32_t len,
 	for (;;) {
 		tmp = __rte_raw_cksum(buf, seglen, 0);
 		if (done & 1)
-			tmp = rte_bswap16((uint16_t)tmp);
+			tmp = rte_bswap32(tmp);
 		sum += tmp;
 		done += seglen;
 		if (done == len)
@@ -169,7 +188,7 @@ rte_raw_cksum_mbuf(const struct rte_mbuf *m, uint32_t off, uint32_t len,
 			seglen = len - done;
 	}
 
-	*cksum = __rte_raw_cksum_reduce(sum);
+	*cksum = __rte_raw_cksum_reduce_u64(sum);
 	return 0;
 }
 
-- 
2.20.1

