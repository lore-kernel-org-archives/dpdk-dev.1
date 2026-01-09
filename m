Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01083D232DF
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 Jan 2026 05:39:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D0141402A7;
	Fri,  9 Jan 2026 06:39:21 +0100 (CET)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41]) by mails.dpdk.org (Postfix) with ESMTP id 0FCBA400D5
 for <dev@dpdk.org>; Fri,  9 Jan 2026 06:39:21 +0100 (CET)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-47d63594f7eso23575295e9.0
 for <dev@dpdk.org>; Thu, 08 Jan 2026 21:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767937161;
 x=1768541961; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4V90jgHyNaKYrdnsAxvWICw0JlPM+0uMlXqTGtub7Mc=;
 b=ZBnTUA0YRR7GYWm8jxzQDL0+vtqVerRlQ3C55zxTcvnDFKjgwWg4Sk0GJx1v3jKn2c
 1D+OEMDQBSZgceQy/4Rz882Dz+hx1TphFbHb65Qj/okeq4CxPCda6NGMr/FxKFmM7w+N
 iFZqTafTBh36W1Q5iu+jSNsxrKXM5K4nuTiYLh/ns8KJsBUU4tKh7wNPdAAkyaRfPK2U
 RC3bnJOv+YdG66b8Tb83y2sJFKcD2i13dZ7Fb4Bw9GCryT9YQSBUjMFEsocJjg9nuWRf
 GfjzJEaZ0GJqOzSYeOCIZX0txBWdxwOpUohkCyEntsAGnJD6UL2rCI67x4pcPbXtkWO+
 xarw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767937161; x=1768541961;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4V90jgHyNaKYrdnsAxvWICw0JlPM+0uMlXqTGtub7Mc=;
 b=ZtEBvcUmlDF4BfCHcSM4BsIc8UI/44gophfCe4bUpBtjkZPTzRikO5srEM00MnGEHl
 CNGC5/l/OflKeTQ9msxZ0jfphGo3xHkRjNYcc/So6M0n8YgTcUOyGiW+rvqbtojxNbcv
 rxaK+/w2WcC8J1WJmFcmPiL+IzV553u7vcPtmG/wcvT5Yy2xTSrUrf669w0gvHy6gbs6
 S/hW3JLU7CXYGTL9xLPH8C3hRg9/yLAbUDQ14Ema1KTBuyvUO7kSYI8IgK4loX+hTrfR
 w4aHoWuyOzZnqr4d/YywUbRkQVAK2YmCNYxSXupzG98Idd5Ipdc+75jV6Wexo17xO0Ra
 PR3w==
X-Gm-Message-State: AOJu0YyZr/d7QrURYUhj0w2yrca6oZrj0UZIwCb3ScH4M6ZvS6HOYzBk
 NCUg/3iQ76LXh0bdLdfJj1Azv5XlUaDcatd/wLsE/+67SXhRbcY84eU5ePn8ahAxq/g=
X-Gm-Gg: AY/fxX6SkqJnNwwPpgCrQu8nfb84XPOImkBbt9k6ktbvDSNUCXERpfBch0fkGhi12Rb
 IfJwE+K5JWkDcpK+Sj7rgpPCjLqjLJgKGFCpGXN/rWRH9LbkN03F13x+9gnSOJRabbBx2CRcJ9w
 xPQwpf3drC+oBHjJvCICHRqNZhkHPNoJx5SeeUfJVwSegTSzDg5Jp2zqELW7auilqu25EaWR9Bt
 ZcfZHcyRb8+0rbdQmeC4FdifFInWQwKoj1Mwvqr/gY6VsDeanRdExfqvojl7w2OMcdTltjlolvm
 fLo2P7vJ0w/tWtXXIASHvun4yxle7CW/F6qi2XAoBjpxOoz2zke9BVlmwFdRIEQ8qfAEjgotTW5
 1JSymgP88nTQ+ptbaIfDz13wki5AG16gMArscBLTY8lnqe356CGrj5kqCS0/IdHuxMR026seFRT
 65gxYaf999W7gD7BRg2Z1Vz0rPV0vlDUjkjxCiCN7EzjhcyIsVv4du
X-Google-Smtp-Source: AGHT+IHNWs8fwwrBXrZeCzsJJ5nn2AAqtfrqAPX824mq0K40zRGvWZX3GT/0cMCTw5/KbOFeKRmFEQ==
X-Received: by 2002:a05:600c:37c8:b0:475:de12:d3b5 with SMTP id
 5b1f17b1804b1-47d84b40816mr76987195e9.34.1767937160456; 
 Thu, 08 Jan 2026 21:39:20 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d8660be14sm57073875e9.1.2026.01.08.21.39.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 21:39:20 -0800 (PST)
Date: Thu, 8 Jan 2026 21:39:16 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: scott.k.mitch1@gmail.com
Cc: dev@dpdk.org, mb@smartsharesystems.com
Subject: Re: [PATCH v9] net: optimize raw checksum computation
Message-ID: <20260108213916.618cb75a@phoenix.local>
In-Reply-To: <20260108214713.52987-1-scott.k.mitch1@gmail.com>
References: <20260108214713.52987-1-scott.k.mitch1@gmail.com>
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

On Thu,  8 Jan 2026 16:47:13 -0500
scott.k.mitch1@gmail.com wrote:

> diff --git a/lib/net/rte_ip6.h b/lib/net/rte_ip6.h
> index d1abf1f5d5..8a7e5e4b8a 100644
> --- a/lib/net/rte_ip6.h
> +++ b/lib/net/rte_ip6.h
> @@  -560,19 +560,18 @@ rte_ipv6_phdr_cksum(const struct rte_ipv6_hdr *ipv6_hdr, uint64_t ol_flags)
>  static inline uint16_t
>  rte_ipv6_phdr_cksum(const struct rte_ipv6_hdr *ipv6_hdr, uint64_t ol_flags)
>  {
> -	uint32_t sum;
>  	struct {
>  		rte_be32_t len;   /* L4 length. */
>  		rte_be32_t proto; /* L4 protocol - top 3 bytes must be zero */
> -	} psd_hdr;
> -
> -	psd_hdr.proto = (uint32_t)(ipv6_hdr->proto << 24);
> -	if (ol_flags & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_UDP_SEG))
> -		psd_hdr.len = 0;
> -	else
> -		psd_hdr.len = ipv6_hdr->payload_len;
> +	} psd_hdr = {
> +		.len = (ol_flags & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_UDP_SEG))
> +			? (rte_be32_t)0
> +			: ipv6_hdr->payload_len,
> +		.proto = (uint32_t)(ipv6_hdr->proto << 24)
> +	};
> +	RTE_SUPPRESS_UNINITIALIZED_WARNING(psd_hdr);
>  
> -	sum = __rte_raw_cksum(&ipv6_hdr->src_addr,
> +	uint32_t sum = __rte_raw_cksum(&ipv6_hdr->src_addr,
>  		sizeof(ipv6_hdr->src_addr) + sizeof(ipv6_hdr->dst_addr),
>  		0);
>  	sum = __rte_raw_cksum(&psd_hdr, sizeof(psd_hdr), sum);
> -- 

Seems like this could be unrolled as well.

static inline uint16_t
rte_ipv6_phdr_cksum(const struct rte_ipv6_hdr *ipv6_hdr, uint64_t ol_flags)
{
	union {
		struct {
			struct rte_ipv6_addr src_addr;  /* 16 bytes */
			struct rte_ipv6_addr dst_addr;  /* 16 bytes */
			rte_be32_t len;                 /* 4 bytes  */
			rte_be32_t proto;               /* 4 bytes  */
		} psd;
		uint16_t u16[20];
	} hdr = {
		.psd = {
			.src_addr = ipv6_hdr->src_addr,
			.dst_addr = ipv6_hdr->dst_addr,
			.proto = (uint32_t)(ipv6_hdr->proto << 24),
		}
	};
	uint32_t sum;

	if (!(ol_flags & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_UDP_SEG)))
		hdr.psd.len = ipv6_hdr->payload_len;

	/* Unrolled sum of 20 uint16_t words:
	 * [0-7]:   src_addr
	 * [8-15]:  dst_addr
	 * [16-17]: len
	 * [18-19]: proto (3 zero bytes + next header)
	 */
	sum = hdr.u16[0]  + hdr.u16[1]  + hdr.u16[2]  + hdr.u16[3]  +
	      hdr.u16[4]  + hdr.u16[5]  + hdr.u16[6]  + hdr.u16[7]  +
	      hdr.u16[8]  + hdr.u16[9]  + hdr.u16[10] + hdr.u16[11] +
	      hdr.u16[12] + hdr.u16[13] + hdr.u16[14] + hdr.u16[15] +
	      hdr.u16[16] + hdr.u16[17] + hdr.u16[18] + hdr.u16[19];

	sum = (sum & 0xffff) + (sum >> 16);
	sum = (sum & 0xffff) + (sum >> 16);
	return (uint16_t)sum;
}
