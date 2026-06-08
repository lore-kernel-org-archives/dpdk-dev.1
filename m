Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D73F0CD8C9D
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Jun 2026 17:02:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 02A29402DD;
	Mon,  8 Jun 2026 19:02:09 +0200 (CEST)
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
 by mails.dpdk.org (Postfix) with ESMTP id 9B5034029D
 for <dev@dpdk.org>; Mon,  8 Jun 2026 19:02:07 +0200 (CEST)
Received: by mail-dl1-f46.google.com with SMTP id
 a92af1059eb24-13827115452so613570c88.0
 for <dev@dpdk.org>; Mon, 08 Jun 2026 10:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780938126;
 x=1781542926; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hJTxbzPWnzTFtQL/fb2YLQHxGROZRzR4StKCas1T57w=;
 b=EIzPChTxwShtsTi1JGJIPRRWV/njLK5K25NhngbrYLqJdCA0f84FQZypfYsFlQy058
 ntWWcUsoJRzDlPK8ACYXfQ8pz4sH2Hz4kgx1s2xw5Xv9/DBQ/krQDbZclqm2o8Ooa0rs
 3xWZCLjEy8R0fl/a5sQdh4V+ONSTAIw908uqNtTl9GM9WYjZ2edqCCLyRV1H8pLeKo0a
 M0TsnPwkJa16TMQigvc5KX2+pX6lyEecrmpWtbtbLF3UUFB1wpiF1awTmZ26ENnt4L4F
 wvpPFoTxu/OjSJF27bBHB+lc0Q/WYR7ZUtzzO5GY4TpKYjo3dIca3xHSoBvKFxFsd2Jt
 D9tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780938126; x=1781542926;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hJTxbzPWnzTFtQL/fb2YLQHxGROZRzR4StKCas1T57w=;
 b=hBVF4bR7lulx3w90qyYLl74DpZgyhDN4TueAbNsvuF155T0HTTabwIAN3z3SwzgVmr
 N6pqXEzMqWkv4Ve4fJln+yP6LogssHFUCqSNm57r+Nc6cT5LjQ1c71+FzoXmJWXR8SrX
 JdXoenkIYtzR2DNEEfd8oEK4Yd/Blfs2fuWCZDQvrtDC4sxOt22ZZXYG4E8uPdxuRykf
 WNdd5MHb1Mj76WHRCP4FLMPQTUiTURIc8gjtLKzhp/L8YpZRjAFupS3yFayo2k3GB+Ot
 sXjYBFmnNuBEZu6V7jBO/tWa3hLScujF4xm6rNI5x/YjFVopOj9g4veKkG0LI2guygKX
 Bwxw==
X-Gm-Message-State: AOJu0Yw7i0GI/1hvfe5WCin5sfXF6Gulrh7yKm5rlTJbsMY6Z/fKsmjI
 0nFzJlEP3ZEJ5R+BdG4ok6/qeTr04lSlAe2GKBSskGyRskrWSmacSQ6A6ptecNNywks=
X-Gm-Gg: Acq92OH9kB2Mmqo+Qz3Oid3El6w7F1zxUTf84xuKOJ+1ab43op4N+XjKXUm/q5GWJo+
 6s3NP3q+14/P5begWvlDWwtzvX66ioQMXrh/3QxyYpy8X0dDpsXfuCjxFZ3oBtddNiho5ejKHj9
 NggHNEMZX6VHKfSIctujPpqBMmYiAUUHohnlgAgOkidKSsWiHZPpjqOU+HsgTHGJk2iEYkmboFB
 XchzSlzVoj36AGDGVOfObPitzDHIbKAhxVviaeACYrWnKixRguyOg5Rz6yNcBBJ3P8BpOpkwdeR
 Jn1m0eyvHa2PL/gTRnBFzD+OiG6A9d7RCRN6/nQ106dwrvXY42DoYoZsUeCowsosLcqTCQFjAgk
 Jxo/ZBf4tw/kNpj5UL/4JZkQAM1qTnHD2aINkwoH/K54fV4vVINeSiNIf+whebxVrdVE02gs3Zi
 19CrmkzEBWVRr5v5yTrwZrApeddPLMJFaeCMGAYmCVkbq7y1qTp13ACoOtW6V/Xg0j5ZgnSMtb7
 Sc=
X-Received: by 2002:a05:7022:671e:b0:12d:de3f:d843 with SMTP id
 a92af1059eb24-1380674bb87mr7581733c88.38.1780938125695; 
 Mon, 08 Jun 2026 10:02:05 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137f5539432sm15102022c88.9.2026.06.08.10.02.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 10:02:05 -0700 (PDT)
Date: Mon, 8 Jun 2026 10:02:02 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Su Sai <spiderdetective.ss@gmail.com>
Cc: dev@dpdk.org
Subject: Re: [v3] net/cksum: compute raw cksum for several segments
Message-ID: <20260608100202.0deac83d@phoenix.local>
In-Reply-To: <20250804035430.4058391-1-spiderdetective.ss@gmail.com>
References: <20250803090837.15589edd@hermes.local>
 <20250804035430.4058391-1-spiderdetective.ss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Mon,  4 Aug 2025 11:54:30 +0800
Su Sai <spiderdetective.ss@gmail.com> wrote:

> The rte_raw_cksum_mbuf function is used to compute
> the raw checksum of a packet.
> If the packet payload stored in multi mbuf, the function
> will goto the hard case. In hard case,
> the variable 'tmp' is a type of uint32_t,
> so rte_bswap16 will drop high 16 bit.
> Meanwhile, the variable 'sum' is a type of uint32_t,
> so 'sum += tmp' will drop the carry when overflow.
> Both drop will make cksum incorrect.
> This commit fixes the above bug.
> 
> Signed-off-by: Su Sai <spiderdetective.ss@gmail.com>
> ---
>  .mailmap              |   1 +
>  app/test/test_cksum.c | 106 ++++++++++++++++++++++++++++++++++++++++++
>  lib/net/rte_cksum.h   |  27 +++++++++--
>  3 files changed, 130 insertions(+), 4 deletions(-)
> 
> diff --git a/.mailmap b/.mailmap
> index 34a99f93a1..1da1d9f8e1 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -1552,6 +1552,7 @@ Sunil Kumar Kori <skori@marvell.com> <sunil.kori@nxp.com>
>  Sunil Pai G <sunil.pai.g@intel.com>
>  Sunil Uttarwar <sunilprakashrao.uttarwar@amd.com>
>  Sun Jiajia <sunx.jiajia@intel.com>
> +Su Sai <spiderdetective.ss@gmail.com> <susai.ss@bytedance.com>
>  Sunyang Wu <sunyang.wu@jaguarmicro.com>
>  Surabhi Boob <surabhi.boob@intel.com>
>  Suyang Ju <sju@paloaltonetworks.com>
> diff --git a/app/test/test_cksum.c b/app/test/test_cksum.c
> index f2ab5af5a7..fb2e3cf9e6 100644
> --- a/app/test/test_cksum.c
> +++ b/app/test/test_cksum.c
> @@ -85,6 +85,42 @@ static const char test_cksum_ipv4_opts_udp[] = {
>  	0x00, 0x35, 0x00, 0x09, 0x89, 0x6f, 0x78,
>  };
>  
> +/*
> + * generated in scapy with
> + * Ether()/IP()/TCP(options=[NOP,NOP,Timestamps])/os.urandom(113))
> + */
> +static const char test_cksum_ipv4_tcp_multi_segs[] = {
> +	0x00, 0x16, 0x3e, 0x0b, 0x6b, 0xd2, 0xee, 0xff,
> +	0xff, 0xff, 0xff, 0xff, 0x08, 0x00, 0x45, 0x00,
> +	0x00, 0xa5, 0x46, 0x10, 0x40, 0x00, 0x40, 0x06,
> +	0x80, 0xb5, 0xc0, 0xa8, 0xf9, 0x1d, 0xc0, 0xa8,
> +	0xf9, 0x1e, 0xdc, 0xa2, 0x14, 0x51, 0xbb, 0x8f,
> +	0xa0, 0x00, 0xe4, 0x7c, 0xe4, 0xb8, 0x80, 0x10,
> +	0x02, 0x00, 0x4b, 0xc1, 0x00, 0x00, 0x01, 0x01,
> +	0x08, 0x0a, 0x90, 0x60, 0xf4, 0xff, 0x03, 0xc5,
> +	0xb4, 0x19, 0x77, 0x34, 0xd4, 0xdc, 0x84, 0x86,
> +	0xff, 0x44, 0x09, 0x63, 0x36, 0x2e, 0x26, 0x9b,
> +	0x90, 0x70, 0xf2, 0xed, 0xc8, 0x5b, 0x87, 0xaa,
> +	0xb4, 0x67, 0x6b, 0x32, 0x3d, 0xc4, 0xbf, 0x15,
> +	0xa9, 0x16, 0x6c, 0x2a, 0x9d, 0xb2, 0xb7, 0x6b,
> +	0x58, 0x44, 0x58, 0x12, 0x4b, 0x8f, 0xe5, 0x12,
> +	0x11, 0x90, 0x94, 0x68, 0x37, 0xad, 0x0a, 0x9b,
> +	0xd6, 0x79, 0xf2, 0xb7, 0x31, 0xcf, 0x44, 0x22,
> +	0xc8, 0x99, 0x3f, 0xe5, 0xe7, 0xac, 0xc7, 0x0b,
> +	0x86, 0xdf, 0xda, 0xed, 0x0a, 0x0f, 0x86, 0xd7,
> +	0x48, 0xe2, 0xf1, 0xc2, 0x43, 0xed, 0x47, 0x3a,
> +	0xea, 0x25, 0x2d, 0xd6, 0x60, 0x38, 0x30, 0x07,
> +	0x28, 0xdd, 0x1f, 0x0c, 0xdd, 0x7b, 0x7c, 0xd9,
> +	0x35, 0x9d, 0x14, 0xaa, 0xc6, 0x35, 0xd1, 0x03,
> +	0x38, 0xb1, 0xf5,
> +};
> +
> +static const uint8_t test_cksum_ipv4_tcp_multi_segs_len[] = {
> +	66,  /* the first seg contains all headers, including L2 to L4 */
> +	61,  /* the second seg length is odd, test byte order independent */
> +	52,  /* three segs are sufficient to test the most complex scenarios */
> +};
> +
>  /* test l3/l4 checksum api */
>  static int
>  test_l4_cksum(struct rte_mempool *pktmbuf_pool, const char *pktdata, size_t len)
> @@ -223,6 +259,70 @@ test_l4_cksum(struct rte_mempool *pktmbuf_pool, const char *pktdata, size_t len)
>  	return -1;
>  }
>  
> +/* test l4 checksum api for a packet with multiple mbufs */
> +static int
> +test_l4_cksum_multi_mbufs(struct rte_mempool *pktmbuf_pool, const char *pktdata, size_t len,
> +			     const uint8_t *segs, size_t segs_len)
> +{
> +	struct rte_mbuf *m[NB_MBUF] = {0};
> +	struct rte_mbuf *m_hdr = NULL;
> +	struct rte_net_hdr_lens hdr_lens;
> +	size_t i, off = 0;
> +	uint32_t packet_type, l3;
> +	void *l3_hdr;
> +	char *data;
> +
> +	for (i = 0; i < segs_len; i++) {
> +		m[i] = rte_pktmbuf_alloc(pktmbuf_pool);
> +		if (m[i] == NULL)
> +			GOTO_FAIL("Cannot allocate mbuf");
> +
> +		data = rte_pktmbuf_append(m[i], segs[i]);
> +		if (data == NULL)
> +			GOTO_FAIL("Cannot append data");
> +
> +		rte_memcpy(data, pktdata + off, segs[i]);

Tests (except rte_memcpy test) should not use rte_memcpy, instead use
regular memcpy which has better coverage from analyzers.

> +		off += segs[i];
> +
> +		if (m_hdr) {
> +			if (rte_pktmbuf_chain(m_hdr, m[i]))
> +				GOTO_FAIL("Cannot chain mbuf");
> +		} else {
> +			m_hdr = m[i];
> +		}
> +	}
> +
> +	if (off != len)
> +		GOTO_FAIL("Invalid segs");
> +
> +	packet_type = rte_net_get_ptype(m_hdr, &hdr_lens, RTE_PTYPE_ALL_MASK);
> +	l3 = packet_type & RTE_PTYPE_L3_MASK;
> +
> +	l3_hdr = rte_pktmbuf_mtod_offset(m_hdr, void *, hdr_lens.l2_len);
> +	off = hdr_lens.l2_len + hdr_lens.l3_len;
> +
> +	if (l3 == RTE_PTYPE_L3_IPV4 || l3 == RTE_PTYPE_L3_IPV4_EXT) {
> +		if (rte_ipv4_udptcp_cksum_mbuf_verify(m_hdr, l3_hdr, off) != 0)
> +			GOTO_FAIL("Invalid L4 checksum verification for multiple mbufs");
> +	} else if (l3 == RTE_PTYPE_L3_IPV6 || l3 == RTE_PTYPE_L3_IPV6_EXT) {
> +		if (rte_ipv6_udptcp_cksum_mbuf_verify(m_hdr, l3_hdr, off) != 0)
> +			GOTO_FAIL("Invalid L4 checksum verification for multiple mbufs");
> +	}
> +
> +	for (i = 0; i < segs_len; i++)
> +		rte_pktmbuf_free(m[i]);

Can avoid the loop here and elsewhere by using rte_pktmbuf_free_bulk()

> +	return 0;
> +
> +fail:
> +	for (i = 0; i < segs_len; i++) {
> +		if (m[i])
> +			rte_pktmbuf_free(m[i]);
> +	}

Freebulk will work here

> +	return -1;
> +}
> +
>  static int
>  test_cksum(void)
>  {
> @@ -256,6 +356,12 @@ test_cksum(void)
>  			  sizeof(test_cksum_ipv4_opts_udp)) < 0)
>  		GOTO_FAIL("checksum error on ipv4_opts_udp");
>  
> +	if (test_l4_cksum_multi_mbufs(pktmbuf_pool, test_cksum_ipv4_tcp_multi_segs,
> +			  sizeof(test_cksum_ipv4_tcp_multi_segs),
> +			  test_cksum_ipv4_tcp_multi_segs_len,
> +			  sizeof(test_cksum_ipv4_tcp_multi_segs_len)) < 0)
> +		GOTO_FAIL("checksum error on multi mbufs check");
> +
>  	rte_mempool_free(pktmbuf_pool);
>  
>  	return 0;
> diff --git a/lib/net/rte_cksum.h b/lib/net/rte_cksum.h
> index a8e8927952..679ba82eb6 100644
> --- a/lib/net/rte_cksum.h
> +++ b/lib/net/rte_cksum.h
> @@ -80,6 +80,25 @@ __rte_raw_cksum_reduce(uint32_t sum)
>  	return (uint16_t)sum;
>  }
>  
> +/**
> + * @internal Reduce a sum to the non-complemented checksum.
> + * Helper routine for the rte_raw_cksum_mbuf().
> + *
> + * @param sum
> + *   Value of the sum.
> + * @return
> + *   The non-complemented checksum.
> + */
> +static inline uint16_t
> +__rte_raw_cksum_reduce_u64(uint64_t sum)
> +{
> +	uint32_t tmp;
> +
> +	tmp = __rte_raw_cksum_reduce((uint32_t)sum);
> +	tmp += __rte_raw_cksum_reduce((uint32_t)(sum >> 32));
> +	return __rte_raw_cksum_reduce(tmp);
> +}
> +
>  /**
>   * Process the non-complemented checksum of a buffer.
>   *
> @@ -119,8 +138,8 @@ rte_raw_cksum_mbuf(const struct rte_mbuf *m, uint32_t off, uint32_t len,
>  {
>  	const struct rte_mbuf *seg;
>  	const char *buf;
> -	uint32_t sum, tmp;
> -	uint32_t seglen, done;
> +	uint32_t seglen, done, tmp;
> +	uint64_t sum;
>  
>  	/* easy case: all data in the first segment */
>  	if (off + len <= rte_pktmbuf_data_len(m)) {
> @@ -157,7 +176,7 @@ rte_raw_cksum_mbuf(const struct rte_mbuf *m, uint32_t off, uint32_t len,
>  	for (;;) {
>  		tmp = __rte_raw_cksum(buf, seglen, 0);
>  		if (done & 1)
> -			tmp = rte_bswap16((uint16_t)tmp);
> +			tmp = rte_bswap32(tmp);
>  		sum += tmp;
>  		done += seglen;
>  		if (done == len)
> @@ -169,7 +188,7 @@ rte_raw_cksum_mbuf(const struct rte_mbuf *m, uint32_t off, uint32_t len,
>  			seglen = len - done;
>  	}
>  
> -	*cksum = __rte_raw_cksum_reduce(sum);
> +	*cksum = __rte_raw_cksum_reduce_u64(sum);
>  	return 0;
>  }
>  

