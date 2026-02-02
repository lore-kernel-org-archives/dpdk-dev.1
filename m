Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 604E3E7DF0F
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 18:48:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9DDA84027D;
	Mon,  2 Feb 2026 19:48:02 +0100 (CET)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43]) by mails.dpdk.org (Postfix) with ESMTP id 9CDDB4026D
 for <dev@dpdk.org>; Mon,  2 Feb 2026 19:48:00 +0100 (CET)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4806f80cac9so25312045e9.1
 for <dev@dpdk.org>; Mon, 02 Feb 2026 10:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770058080;
 x=1770662880; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9RDR6iSfNDdDUP7l7zZoUm6JX0ijq/7aJljAUQ7K6rY=;
 b=utfXkMqthBbN7znCvOlY3TB/ZARn7VKEFqTQu+H7UXT92dx7GEab8o5VWgBHqK5KoY
 OZcwqPxPZEYYeokCQfYZMNZ9E+etLzaB0J57McMhyFgJ9MwT8nC334a1bpYSCQo0b81v
 pHGAtr6FVi5trgVmIeSvZID+xjskp3odLV3myGD8M6E2vEIPfR7YVbzL7RZ6Nd8h+VOl
 LDurtcWgnFx7Btt7cKApfFnSX3A1HkGjRjAICjH0KbRkDAVjB0jCZVaIo0uMYi32SOm4
 Hk9vs27VPeGJ+g3kxFrQYcoDrRoxnlRuhJJIoresEUr1v2mLaNXnwbhGb5nwVvz+zUfA
 jdCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770058080; x=1770662880;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9RDR6iSfNDdDUP7l7zZoUm6JX0ijq/7aJljAUQ7K6rY=;
 b=blnAisf90yhR2vT/DWE2S208dNopjLwsdgtozzFB0+LSXB/4Tb6Dqp3kQa0H3cpaVR
 asUXtizYoySaJyIne9KlU9n1nLJ2rsvbEJCo/l6mDAk1qRBrNbJXXQu6F2/m1fpnWtGH
 uMCfYDs1pm+W1G4+T8fvo4Sx0eE2AM8qflZrhUq2Jq9LBxCrcTVt342cDwLpLiO0fBjb
 jgGZn6HiAbBKTaOiSFA8tG1/V/85TdoL6v8tvmBlVEwY37Bn8HWB0qBfTPCyAXMZY+z1
 IDkqAnCWEvCRieEUyEvxufvjIBEhbY+hOA4lYP0aD6RvRVbc5g2e6+LJyAatWtWfpFw8
 H5qg==
X-Gm-Message-State: AOJu0YxHB5b2cicAxGhiFwho8PyNACB5vPHgRsvY1JnU+Pgfop6Hd0UN
 zAmd/2bucglfwV5o4QdyhmrhbaeKmPeiTcXo6cVqvi6Tiwqw5UiqDMDryUgiZzoSc60=
X-Gm-Gg: AZuq6aIkrQrXB9XeTgBLp1G+Z+//1vFvjIhSBSs5V/eZNXB65uZZ55n+HeycWbQhSYr
 zRNDemei+TpSEF5q8dzzWNt3dABJzVQjWrbgdfUSztC9EvLan8qVAo11BJoLy5rTKU6D+xx2rWD
 zng1ILG17WXA8YTXEyd4qDSn433w10z0plhJn4C6mzxRhZXbWyboqceNxsC1VRda3JbdHGldT05
 qjBn1KzJr3hfkEvue8j3QzgfsgVLjkpe/IsiX+uuABBxAL4izjQQz+P04SuNi2BxFaMISVRFD8E
 t4ZmdSQ15eIGflMPoDYMORuE8C+aZEqaLPueicyRhSxBd1xJWzg0aJdtJTk9jFX9vixiSnRu8sA
 IRMpUVjgl0m0yMYSJyKvVUi7nBd740muVasrixPXaHVtgo2SGAVhYjPxTep0fxkM7PT4pOFOtL4
 /rITrK3Je/QvFRrxENLOChFXRcCkIPn7zb7kU0iC+x97u3Seo8E06b
X-Received: by 2002:a05:600c:6814:b0:480:69ae:f0e9 with SMTP id
 5b1f17b1804b1-482db4ac0b0mr166333605e9.16.1770058080120; 
 Mon, 02 Feb 2026 10:48:00 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4830511bfc6sm15919555e9.2.2026.02.02.10.47.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 10:47:59 -0800 (PST)
Date: Mon, 2 Feb 2026 10:47:55 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: scott.k.mitch1@gmail.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v4 4/4] net/af_packet: add software checksum offload
 support
Message-ID: <20260202104755.05d834b6@phoenix.local>
In-Reply-To: <20260202081456.4322-5-scott.k.mitch1@gmail.com>
References: <20260128191032.78916-1-scott.k.mitch1@gmail.com>
 <20260202081456.4322-1-scott.k.mitch1@gmail.com>
 <20260202081456.4322-5-scott.k.mitch1@gmail.com>
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

On Mon,  2 Feb 2026 00:14:56 -0800
scott.k.mitch1@gmail.com wrote:

> +/**
> + * Compute IPv4 header and UDP/TCP checksums in software.
> + *
> + * Computes checksums based on mbuf offload flags:
> + * - RTE_MBUF_F_TX_IP_CKSUM: Compute IPv4 header checksum
> + * - RTE_MBUF_F_TX_UDP_CKSUM: Compute UDP checksum (IPv4 or IPv6)
> + * - RTE_MBUF_F_TX_TCP_CKSUM: Compute TCP checksum (IPv4 or IPv6)
> + *
> + * @param mbuf
> + *   The packet mbuf. Must have l2_len and l3_len set correctly.
> + * @param copy
> + *   If true, copy L2/L3/L4 headers to a new segment before computing
> + *   checksums. This is safe for indirect mbufs but has overhead.
> + *   If false, compute checksums in place. This is only safe if the
> + *   mbuf will be copied afterward (e.g., to a device ring buffer).
> + * @return
> + *   - On success: Returns mbuf (new segment if copy=true, original if copy=false)
> + *   - On error: Returns NULL (allocation failed or malformed packet)
> + */
> +__rte_experimental
> +static inline struct rte_mbuf *
> +rte_net_ip_udptcp_cksum_mbuf(struct rte_mbuf *mbuf, bool copy)
> +{
> +	const uint64_t l4_ol_flags = mbuf->ol_flags & RTE_MBUF_F_TX_L4_MASK;
> +	const uint64_t l4_offset = mbuf->l2_len + mbuf->l3_len;
> +	uint32_t hdrlens = l4_offset;
> +	void *l3_hdr = NULL;
> +
> +	/* Determine total header length needed */
> +	if (l4_ol_flags == RTE_MBUF_F_TX_UDP_CKSUM)
> +		hdrlens += sizeof(struct rte_udp_hdr);
> +	else if (l4_ol_flags == RTE_MBUF_F_TX_TCP_CKSUM)
> +		hdrlens += sizeof(struct rte_tcp_hdr);
> +	else if (l4_ol_flags != RTE_MBUF_F_TX_L4_NO_CKSUM)
> +		return NULL; /* Unsupported L4 checksum type */
> +	else if (!(mbuf->ol_flags & RTE_MBUF_F_TX_IP_CKSUM))
> +		return mbuf; /* Nothing to do */
> +
> +	/* Validate we at least have L2+L3 headers before doing any work */
> +	if (unlikely(rte_pktmbuf_data_len(mbuf) < l4_offset))
> +		return NULL;
> +
> +	if (copy) {
> +		/*
> +		 * Copy headers to new segment to handle indirect mbufs.
> +		 * This ensures we can safely modify checksums without
> +		 * corrupting shared/read-only data.
> +		 */
> +		struct rte_mbuf *seg = rte_pktmbuf_copy(mbuf, mbuf->pool, 0, hdrlens);
> +		if (!seg)
> +			return NULL;
> +
> +		rte_pktmbuf_adj(mbuf, hdrlens);
> +		rte_pktmbuf_chain(seg, mbuf);
> +		mbuf = seg;
> +	} else if (unlikely(!RTE_MBUF_DIRECT(mbuf) || rte_mbuf_refcnt_read(mbuf) > 1))
> +		return NULL;
> +
> +	l3_hdr = rte_pktmbuf_mtod_offset(mbuf, void *, mbuf->l2_len);
> +
> +	/* IPv4 header checksum */
> +	if (mbuf->ol_flags & RTE_MBUF_F_TX_IP_CKSUM) {
> +		struct rte_ipv4_hdr *iph = (struct rte_ipv4_hdr *)l3_hdr;
> +		iph->hdr_checksum = 0;
> +		iph->hdr_checksum = rte_ipv4_cksum(iph);
> +	}
> +
> +	/* L4 checksum (UDP or TCP) - skip if headers not in first segment */
> +	if (l4_ol_flags == RTE_MBUF_F_TX_UDP_CKSUM && rte_pktmbuf_data_len(mbuf) >= hdrlens) {
> +		struct rte_udp_hdr *udp_hdr = rte_pktmbuf_mtod_offset(mbuf, struct rte_udp_hdr *,
> +				l4_offset);
> +		udp_hdr->dgram_cksum = 0;
> +		udp_hdr->dgram_cksum = (mbuf->ol_flags & RTE_MBUF_F_TX_IPV4) ?
> +			rte_ipv4_udptcp_cksum_mbuf(mbuf, (const struct rte_ipv4_hdr *)l3_hdr,
> +					l4_offset) :
> +			rte_ipv6_udptcp_cksum_mbuf(mbuf, (const struct rte_ipv6_hdr *)l3_hdr,
> +					l4_offset);
> +	} else if (l4_ol_flags == RTE_MBUF_F_TX_TCP_CKSUM &&
> +			rte_pktmbuf_data_len(mbuf) >= hdrlens) {
> +		struct rte_tcp_hdr *tcp_hdr = rte_pktmbuf_mtod_offset(mbuf, struct rte_tcp_hdr *,
> +				l4_offset);
> +		tcp_hdr->cksum = 0;
> +		tcp_hdr->cksum = (mbuf->ol_flags & RTE_MBUF_F_TX_IPV4) ?
> +			rte_ipv4_udptcp_cksum_mbuf(mbuf,  (const struct rte_ipv4_hdr *)l3_hdr,
> +					l4_offset) :
> +			rte_ipv6_udptcp_cksum_mbuf(mbuf, (const struct rte_ipv6_hdr *)l3_hdr,
> +					l4_offset);
> +	}
> +
> +	return mbuf;
> +}
> +

This is getting a little large to be inline.
Maybe split into inline that checks offload flags, and non-inline
that does the checksum if necessary.

The code could use rte_pktmbuf_linearize() if necessary.


There is code duplication in multiple arms of the if statement
Can the code just "do the right thing" based on the mbufs it is given.
If the mbuf is indirect or has ref count > 1 then copy headers, otherwise
do in place.
