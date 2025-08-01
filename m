Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F44BC87FCB
	for <dpdk-dev@archiver.kernel.org>; Fri,  1 Aug 2025 15:28:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 40FA540662;
	Fri,  1 Aug 2025 17:28:49 +0200 (CEST)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47]) by mails.dpdk.org (Postfix) with ESMTP id AA0BD4065A
 for <dev@dpdk.org>; Fri,  1 Aug 2025 17:28:48 +0200 (CEST)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-31f255eb191so2035690a91.0
 for <dev@dpdk.org>; Fri, 01 Aug 2025 08:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1754062127; x=1754666927; darn=dpdk.org;
 h=cc:to:subject:message-id:date:mime-version:references:from
 :in-reply-to:from:to:cc:subject:date:message-id:reply-to;
 bh=b0DG6+0oJINqACGFCAM4AdI0LyOOAGc48d9S8Puu9Ec=;
 b=h2cqUhlhM51StXwO1GZtX490qcb/WCJ63INIlJWAXvJlGmh+go+Y++ZSiOxRntYQG5
 yQeRqPkQQ3iW+SmAV1P3MZBmBYMtcm4rB8WYOsLTosMVy8mYyBHYXiC4TuBDXflpu7fW
 JKTC8cRXHsNmDe732kNszL+4jj8dlKQu9NcelXtfr/G2xT8PauJ3/nCkr7j5uqByUu6l
 oFYDKtceF6FTOCwJsYu+1LdHxFTeguEFMaLTOnoXmJXTIuqTKZuKAOUfNjL92o7zQvjP
 VhZa/e7N/TGMv4Mcbc94p6a9PV3dWgPqUMA938IXTDd+0hmcC0CE/ZmiGKEkAfU6oH4v
 CwlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754062127; x=1754666927;
 h=cc:to:subject:message-id:date:mime-version:references:from
 :in-reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=b0DG6+0oJINqACGFCAM4AdI0LyOOAGc48d9S8Puu9Ec=;
 b=oLkv0Yy8GEOgifmniyCjdghkoAJcGvkf82JXe8G8o7AQGzEPxy6Ie5krmZunPEwy2P
 EzmW2/FrZSSCaXPj6w28kNotWBomtzEvAZmEaIMgFoXaUIjnIIPO274VVDfCBk3BPETq
 fXxsqPsBUyYSoht0l9+tmHpZnNOkUtBoT3dVczygDiiO4KPiEFSv95pwGZcu8olY6oPI
 tlZtcYzb7LfUPzPCFBM4ltvzgdepgJkXSFwjBt5/xRhPtn/fdAhIaSSO85KKm0IuXXza
 KOX0uEmmtF1+f2ZhubWWRPwx9uT9xpQwAUIDAy5TabZSeZrO9WQq8MHOhMLS/Iuq8MGz
 xEMg==
X-Gm-Message-State: AOJu0Yw0xoR7a2JsPFIa8OA52m59v4rqfg+yXlQ8/WHBv99frCvo4E4k
 vg5Eng3hek6f0KdyreZJYLzfCVbk5eFUns2PKCfbHURGK1cYPYOsrhx5VrtEfikf4Nqh7uojB7v
 Wbg9SBtmi6WqGZCef08QGuImFA0EG3fKD80Kzeq2xowP2VjGlG8vjHFU=
X-Gm-Gg: ASbGncu0M/VX8ndRXMgnmv+mUxS4EflKQKXvZ8SCBV5h8rgP9qV2pcfGi/O9T5xG+XA
 o5shWx8F7GYFHnAbbTLC0v5nAGozWlaSXb7/CulmR2/wVSfhrm8ZdX8a+ahKKBYs0pTcvdtwkLc
 uQ87bijzG0GooLsPPqZaR0FRkEYzFGOSeDRBpbt9xdkh77AU8xb432VB7b1njWwPnZbFspImGFr
 ztK4O9047D2Dw91aRar
X-Google-Smtp-Source: AGHT+IGb+p81eLktxEQOr2cJkF9KdBft3ArN84nPYXwnDltOclb5bcOgX70WCA2l1jgNza1M+LGRBs2uOxb9o3c7/Jk=
X-Received: by 2002:a17:90b:3882:b0:315:af43:12ee with SMTP id
 98e67ed59e1d1-321162bc330mr259668a91.16.1754062127145; Fri, 01 Aug 2025
 08:28:47 -0700 (PDT)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST; 
 Fri, 1 Aug 2025 08:28:46 -0700
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST; 
 Fri, 1 Aug 2025 08:28:46 -0700
In-Reply-To: <CABsP7wOFAsE2-BmnHZW1c3rOkkrUWfox7qrbim6zmP6gbmJqzg@mail.gmail.com>
From: Su Sai <susai.ss@bytedance.com>
References: <CABsP7wOFAsE2-BmnHZW1c3rOkkrUWfox7qrbim6zmP6gbmJqzg@mail.gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
X-Original-From: Su Sai <susai.ss@bytedance.com>
Date: Fri, 1 Aug 2025 08:28:46 -0700
X-Gm-Features: Ac12FXw06OWAtHyHbzgUPf4Yuo7wfqa82jLn45djZjPaKrbeDC1TwWIKWelvlpg
Message-ID: <CABsP7wMLpN-mggd7dY42YEbq_YH5nz=BQSQHV43yZWhpbDNy=Q@mail.gmail.com>
Subject: [v2] net/cksum: compute raw cksum for several segments
To: dev@dpdk.org
Cc: jasvinder.singh@intel.com, thomas@monjalon.net, marat.khalili@huawei.com, 
 Su Sai <susai.ss@bytedance.com>
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
 app/test/test_cksum.c | 104 ++++++++++++++++++++++++++++++++++++++++++
 lib/net/rte_cksum.h   |  26 +++++++++--
 3 files changed, 128 insertions(+), 3 deletions(-)

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
index f2ab5af5a7..d2435a9962 100644
--- a/app/test/test_cksum.c
+++ b/app/test/test_cksum.c
@@ -85,6 +85,39 @@ static const char test_cksum_ipv4_opts_udp[] = {
 	0x00, 0x35, 0x00, 0x09, 0x89, 0x6f, 0x78,
 };

+/* generated in scapy with
Ether()/IP()/TCP(options=[NOP,NOP,Timestamps])/os.urandom(113)) */
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
+	61,  /* the second seg lenght is odd, test byte order independent */
+	52,  /* three segs are sufficient to test the most complex scenarios */
+};
+
 /* test l3/l4 checksum api */
 static int
 test_l4_cksum(struct rte_mempool *pktmbuf_pool, const char *pktdata,
size_t len)
@@ -223,6 +256,71 @@ test_l4_cksum(struct rte_mempool *pktmbuf_pool,
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
@@ -256,6 +354,12 @@ test_cksum(void)
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
index a8e8927952..aa584d5f8d 100644
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
@@ -119,8 +138,9 @@ rte_raw_cksum_mbuf(const struct rte_mbuf *m,
uint32_t off, uint32_t len,
 {
 	const struct rte_mbuf *seg;
 	const char *buf;
-	uint32_t sum, tmp;
+	uint32_t tmp;
 	uint32_t seglen, done;
+	uint64_t sum;

 	/* easy case: all data in the first segment */
 	if (off + len <= rte_pktmbuf_data_len(m)) {
@@ -157,7 +177,7 @@ rte_raw_cksum_mbuf(const struct rte_mbuf *m,
uint32_t off, uint32_t len,
 	for (;;) {
 		tmp = __rte_raw_cksum(buf, seglen, 0);
 		if (done & 1)
-			tmp = rte_bswap16((uint16_t)tmp);
+			tmp = rte_bswap32(tmp);
 		sum += tmp;
 		done += seglen;
 		if (done == len)
@@ -169,7 +189,7 @@ rte_raw_cksum_mbuf(const struct rte_mbuf *m,
uint32_t off, uint32_t len,
 			seglen = len - done;
 	}

-	*cksum = __rte_raw_cksum_reduce(sum);
+	*cksum = __rte_raw_cksum_reduce_u64(sum);
 	return 0;
 }

-- 
2.39.2 (Apple Git-143)
