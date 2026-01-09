Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41BEED232DF
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 Jan 2026 05:34:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 22961402A7;
	Fri,  9 Jan 2026 06:34:51 +0100 (CET)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48]) by mails.dpdk.org (Postfix) with ESMTP id BF382400D5
 for <dev@dpdk.org>; Fri,  9 Jan 2026 06:34:49 +0100 (CET)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-431048c4068so1561142f8f.1
 for <dev@dpdk.org>; Thu, 08 Jan 2026 21:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767936889;
 x=1768541689; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9BFLIhvmdZc+LvYeKa3MwS3Hnt2+KDv4m1PgOLyl2Qk=;
 b=rPFkOO144E1YmOdsjESqKhx9ULnSlz9rzFzQVMj0KtkXj3+C1sPHS6luRVjdiL04qT
 L3F8rq54hQ7U6I4CsDYJF/BNapypoqpBWiL5n9TiVq3W0mqIN0iwi32/T09AEEEHRUZo
 cJAAGjiYDrluUxqQ0gXJhRspf0yyLOfyvXOWb8G5rJs2MTSZ38Gy2k4Q6xS2GaJWVAuJ
 aygDf9YkDWC6e+OXFJMLQZsVN4vEs2qvM70+s1mO/8NKO1jEP+UbQnDbq+b2ResF2kaG
 aizGUq7cbnrs5SGiGZybfViJa/7hQ97uxt7xtmIxQnBUOtEyyERfufpDyYABE83myTfY
 /7Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767936889; x=1768541689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9BFLIhvmdZc+LvYeKa3MwS3Hnt2+KDv4m1PgOLyl2Qk=;
 b=b5nElVa+BZLPU53f3TlJiqTb49SuFU7NrsH6YM+BmO3cZcBcUMGCiDTReNN2oJsW1e
 qqMfMnAfRjC3PynsOtk/d4RYjCaEKzfI5a0jHxF8bIICrEy9chrInucNLPdwlG2vvBYM
 sf2NsOPA6BIDRlNg5v/U2dgGFRkJre79foRflzy+PhcxfUxvHvSWeFjwwuRz4gN0saGC
 s2Bb4uK8s7aj9eArTtFFCKYxNY7oWX80HbwpATFSGZrmLaLyFNZ+K3tT/VO0GSgnKKkC
 0BAsgyWVWQXWVFLfGRI4qJZSTwYGQcKRSd/wmcYaACcFC9Bgbx9mZd4DblP1x18j12/S
 zg+Q==
X-Gm-Message-State: AOJu0YxeketLWthvhaN/nkbHCQe4SGXr1SclUY+NbTLZtl1y8U3h5aQt
 +yCig8NpGgn8lm79X3zmMOAzSsUGxD7cBcltl1NT9cxdZvUBgbCz3v5Mut6Xdn3y0wsryTTZ2gx
 MUyOt
X-Gm-Gg: AY/fxX5Gtm0PEzO71qH6DkSwLZvsUPF/liOqP/yVe0Z0vFVDZXKjbrDKtGowd5XoAe0
 qqOL8Ud2/E8y9D02HA0K1E/Hd0uQbpGy3taqaQbd7j8rhwLEAHXUxkVcNi9IP4zSVrLJosdSk+G
 5odFEouuBjtco219KypI3Ow3gB7YiIRkd9hPLdGe/9Kr0WmZ4xJswqpVOmVkXNm58sk/KHbhIhq
 yXQkrdzTzctrIC8kGKXP6aWuurrSmtAKy4cVdRw07Qy3K2eU1MOg/U+PZ2F56VVQQtcgdg47a/c
 7ET5GdZPM8AkRD3lEkss+MdU/cirBO6P0ifZV/5rWZZCkS7bPFhR9MQGPx4hNWPF/zefijFX/PP
 Qm+yRau4FIsqn0WsYRFuZ+mxeA/2GT86BJsrgyyp43WoXPwrC6TIVldDB0Bi/kV1P7mHfCUD6BF
 5MdEcXT2NWx86p9MXv0Qu3/43lPPgVX0UQG97dVY7h6FLyRsodqtl+
X-Google-Smtp-Source: AGHT+IF97P5Vr6Z/VPZCOq4Td3rjM92GLV+GqFF+Dk4/oUrZSpsBuVJqghxTnWN7KJZA8OuagaZjjQ==
X-Received: by 2002:a5d:5d86:0:b0:430:fcbc:dc4a with SMTP id
 ffacd0b85a97d-432bcfd2232mr14001776f8f.19.1767936888938; 
 Thu, 08 Jan 2026 21:34:48 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0dad8bsm20830102f8f.8.2026.01.08.21.34.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 21:34:48 -0800 (PST)
Date: Thu, 8 Jan 2026 21:34:43 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: scott.k.mitch1@gmail.com
Cc: dev@dpdk.org, mb@smartsharesystems.com
Subject: Re: [PATCH v9] net: optimize raw checksum computation
Message-ID: <20260108213443.0ab2f0c3@phoenix.local>
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

> diff --git a/lib/net/rte_ip4.h b/lib/net/rte_ip4.h
> index 822a660cfb..63852717c9 100644
> --- a/lib/net/rte_ip4.h
> +++ b/lib/net/rte_ip4.h
> @@ -223,21 +223,17 @@ rte_ipv4_phdr_cksum(const struct rte_ipv4_hdr *ipv4_hdr, uint64_t ol_flags)
>  		uint8_t  zero;     /* zero. */
>  		uint8_t  proto;    /* L4 protocol type. */
>  		uint16_t len;      /* L4 length. */
> -	} psd_hdr;
> -
> -	uint32_t l3_len;
> -
> -	psd_hdr.src_addr = ipv4_hdr->src_addr;
> -	psd_hdr.dst_addr = ipv4_hdr->dst_addr;
> -	psd_hdr.zero = 0;
> -	psd_hdr.proto = ipv4_hdr->next_proto_id;
> -	if (ol_flags & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_UDP_SEG)) {
> -		psd_hdr.len = 0;
> -	} else {
> -		l3_len = rte_be_to_cpu_16(ipv4_hdr->total_length);
> -		psd_hdr.len = rte_cpu_to_be_16((uint16_t)(l3_len -
> -			rte_ipv4_hdr_len(ipv4_hdr)));
> -	}
> +	} psd_hdr = {
> +		.src_addr = ipv4_hdr->src_addr,
> +		.dst_addr = ipv4_hdr->dst_addr,
> +		.proto = ipv4_hdr->next_proto_id,
> +		.len = (ol_flags & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_UDP_SEG))
> +			? (uint16_t)0
> +			: rte_cpu_to_be_16((uint16_t)(rte_be_to_cpu_16(ipv4_hdr->total_length) -
> +					rte_ipv4_hdr_len(ipv4_hdr)))
> +	};
> +	RTE_SUPPRESS_UNINITIALIZED_WARNING(psd_hdr);
> +
>  	return rte_raw_cksum(&psd_hdr, sizeof(psd_hdr));
>  }

Since this is all fixed size, why not hand unroll it?
That is what Linux kernel does for IPv4 checksum and this would be
another case. No loop is really necessary.

static inline uint16_t
rte_ipv4_phdr_cksum(const struct rte_ipv4_hdr *ipv4_hdr, uint64_t ol_flags)
{
	union {
		struct {
			uint32_t src_addr;
			uint32_t dst_addr;
			uint8_t  zero;
			uint8_t  proto;
			rte_be16_t len;
		} psd;
		uint16_t u16[6];
	} hdr = {
		.psd = {
			.src_addr = ipv4_hdr->src_addr,
			.dst_addr = ipv4_hdr->dst_addr,
			.proto = ipv4_hdr->next_proto_id,
		}
	};
	uint32_t sum;

	if (!(ol_flags & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_UDP_SEG))) {
		hdr.psd.len = rte_cpu_to_be_16(
			(uint16_t)(rte_be_to_cpu_16(ipv4_hdr->total_length) -
				   rte_ipv4_hdr_len(ipv4_hdr)));
	}

	/* Unrolled sum of 6 uint16_t words */
	sum = hdr.u16[0] + hdr.u16[1] + hdr.u16[2] +
	      hdr.u16[3] + hdr.u16[4] + hdr.u16[5];

	sum = (sum & 0xffff) + (sum >> 16);
	sum = (sum & 0xffff) + (sum >> 16);
	return (uint16_t)sum;
}

I.e Don't use the rte_raw_cksum at all.

Same for IPv6.
