Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D1BC43458
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Jul 2026 07:17:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1738A40264;
	Wed,  8 Jul 2026 09:17:56 +0200 (CEST)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by mails.dpdk.org (Postfix) with ESMTP id D0B0740041
 for <dev@dpdk.org>; Wed,  8 Jul 2026 09:17:54 +0200 (CEST)
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-c9e607d81fcso190908a12.2
 for <dev@dpdk.org>; Wed, 08 Jul 2026 00:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783495074; x=1784099874; darn=dpdk.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lNoWrnvV+fySq1NRZweFgBK7ZJDE8RCe4F2H+eqCDGo=;
 b=ZbZ0yu4xo28+EWctjSUJd8fWc25kQsRVFWdOhv9G1BpRh/0IAU9BqJgf3TDyAAVEJx
 iDJ+4JMJ7TNPANiKLqQda5akUMpWvMNbkNrIEoOskivHAbQeMVrdDEEyBhuyIUBohGEB
 qyDcYCwKzpTxxrxHNNaQTQ1scdM7ywqcYI7M2IcYiUKiOFUMCkBBPztInFYOEssbjwYw
 A0z1bvfuRdsR8J6/t2VIuMpk+P5UhMqa54y2pPdtya+2/SDlERmpBAW+B7OUJxoD6Lkp
 6duTkRnNQVUPf/krdpNJ80////VC6NK4P7NmE5aqACDPPMNw6Ij+t1qrx+KQZF+/HO12
 VVcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783495074; x=1784099874;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lNoWrnvV+fySq1NRZweFgBK7ZJDE8RCe4F2H+eqCDGo=;
 b=D3r915ObLEyC+Cnm8bPSEq2e2GCUJkz6qDvJRW7lo5J6utZAc+TzUS9dwpLNMuQcIX
 m4qWT3Z3+I5wKCk7nv3CU2jrt/9IDVZB2lorOMW1yoXEqck91qgCGr8fs2g5mrKpfWSm
 d60gutCsw4l4xPRn546SrD0fS8qjzF/OgR4Vv9RDXOFxs8SbTrHAlHw0TvEKFwET2nJN
 y08fPnxlPwq0FpooB/Nviz9durAn6ce72dJNKP4orSb8mTZnG+yCCai/dgLjLa7aU9ag
 oLnbzhPEOg6ttFgbt/O2M2BaBF8keZnkrrm4gOBDdei4bwFnoYaMlAGfV2ozvPQVmZVK
 S3KA==
X-Gm-Message-State: AOJu0Yy+GYh2upQSjZYZNsMZ42WNn81/S3qMLmhoJSGeF5joTCvoZHfp
 rRAnoynRlKHuKIw53MybRQ/JsIEAVVeRtDSik3EgLAWB67HZ3j72PxBa
X-Gm-Gg: AfdE7ckmCgLzjfKDLzsabOgryc+vSQtvhIu/oDfya1A3DHslf5NbeSuYRpbKA8er66i
 yHXYP2w50wsWpdy6KC2rgHv0EwowEqJ4QzNeEnwPhGUPcbK4B0zLE0DpUTsQ0IjzhfoZmsT9LxF
 bHuo7xyTcZXExZvKxTxIHipw+/h+FSi+kppPUqwcoYE2U7weIqAGxTqLLNgagyCG0CP1JtDk5cN
 0o0Xf4KHvl8+NRbjwkTfS/fkJg5DNw7lje1XgIfgTMS2Ni2pJl+hUAbG7mLOBTSQiaJgYdRWURR
 6aEBchpwuYCfb3Hlpl1ZOP71Zo/zRf8feDWOkSz93fg6AjzOmK6F2LE3o/kORZQyH+tbBe3+bIW
 CC+2cetvq0ivTUhwXH+INs34Vl5EU0hHJ4QFAWbZa/sQdJkoyG5ijIkNyUerXdF9GYHWpYppMuZ
 tpjca19wBjHBlazOpFUG82+AIBilF4IGAnLT8=
X-Received: by 2002:a05:6a20:1615:b0:3c0:9c19:b272 with SMTP id
 adf61e73a8af0-3c0bcc32329mr1530992637.64.1783495073548; 
 Wed, 08 Jul 2026 00:17:53 -0700 (PDT)
Received: from YTJMJ2RP0G.bytedance.net ([2408:8740:c4ff:1::8])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ca5afdb7534sm1956997a12.12.2026.07.08.00.17.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 08 Jul 2026 00:17:53 -0700 (PDT)
From: Su Sai <spiderdetective.ss@gmail.com>
To: stephen@networkplumber.org,
	marat.khalili@huawei.com
Cc: dev@dpdk.org,
	spiderdetective.ss@gmail.com
Subject: [v5] net/cksum: compute raw cksum for several segments
Date: Wed,  8 Jul 2026 15:17:42 +0800
Message-Id: <20260708071742.94924-1-spiderdetective.ss@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20260703074132.2a718abe@phoenix.local>
References: <20260703074132.2a718abe@phoenix.local>
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
Acked-by: Marat Khalili <marat.khalili@huawei.com>
---
 .mailmap              |   1 +
 app/test/test_cksum.c | 109 ++++++++++++++++++++++++++++++++++++++++++
 lib/net/rte_cksum.h   |  27 +++++++++--
 3 files changed, 133 insertions(+), 4 deletions(-)

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
index ea443382a1..73f2511731 100644
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
@@ -223,6 +259,73 @@ test_l4_cksum(struct rte_mempool *pktmbuf_pool, const char *pktdata, size_t len)
 	return -1;
 }
 
+/* test l4 checksum api for a packet with mbuf chain */
+static int
+test_l4_cksum_mbuf_chain(struct rte_mempool *pktmbuf_pool, const char *pktdata, size_t len,
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
+		if (data == NULL) {
+			rte_pktmbuf_free(m[i]);
+			m[i] = NULL;
+			GOTO_FAIL("Cannot append data");
+		}
+
+		memcpy(data, pktdata + off, segs[i]);
+		off += segs[i];
+
+		if (m_hdr) {
+			if (rte_pktmbuf_chain(m_hdr, m[i])) {
+				rte_pktmbuf_free(m[i]);
+				m[i] = NULL;
+				GOTO_FAIL("Cannot chain mbuf");
+			}
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
+			GOTO_FAIL("Invalid L4 checksum verification for mbuf chain");
+	} else if (l3 == RTE_PTYPE_L3_IPV6 || l3 == RTE_PTYPE_L3_IPV6_EXT) {
+		if (rte_ipv6_udptcp_cksum_mbuf_verify(m_hdr, l3_hdr, off) != 0)
+			GOTO_FAIL("Invalid L4 checksum verification for mbuf chain");
+	}
+
+	rte_pktmbuf_free(m_hdr);
+
+	return 0;
+
+fail:
+	if (m_hdr)
+		rte_pktmbuf_free(m_hdr);
+
+	return -1;
+}
+
 static int
 test_cksum(void)
 {
@@ -256,6 +359,12 @@ test_cksum(void)
 			  sizeof(test_cksum_ipv4_opts_udp)) < 0)
 		GOTO_FAIL("checksum error on ipv4_opts_udp");
 
+	if (test_l4_cksum_mbuf_chain(pktmbuf_pool, test_cksum_ipv4_tcp_multi_segs,
+			  sizeof(test_cksum_ipv4_tcp_multi_segs),
+			  test_cksum_ipv4_tcp_multi_segs_len,
+			  sizeof(test_cksum_ipv4_tcp_multi_segs_len)) < 0)
+		GOTO_FAIL("checksum error on mbuf chain check");
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

