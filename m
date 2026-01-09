Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882D9D232E1
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 Jan 2026 05:36:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9E4FA402A7;
	Fri,  9 Jan 2026 06:36:57 +0100 (CET)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41]) by mails.dpdk.org (Postfix) with ESMTP id 58954400D5
 for <dev@dpdk.org>; Fri,  9 Jan 2026 06:36:56 +0100 (CET)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-47775fb6c56so36376505e9.1
 for <dev@dpdk.org>; Thu, 08 Jan 2026 21:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767937016;
 x=1768541816; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u7//A/OFyAnlUdW3B32W84TzXnVcqeEK8bNzsWNzjm8=;
 b=FG7mcHUtkwi/OQbQV5GH1QknXFDF/DSqOYsFONIIhCfGjybj7EbClY3+YD9LieMd54
 Y0H5SrNiNx6Po1ol+1ajmu6gi766nTN/OPnw4zlXUibggQvgxjCMrFwaU21z9p4jktv4
 uC06Mfv7uSH6dgFIGzTTBb2KzzIAiUkG0byXY+5ZVWYl0SQHIPPVVaVJZe3cD2ORiGqX
 epcOrCkdX4cl3cwDGifhMPlw/WQsC8Feco1F3z7Y2OWbptDSBBDMcZSobzaLvnqgmO0D
 nBAOYALhnIOLybb/jytoRyWWqdg/RRvX+GC0TIv0Ege6UgaUZ6kRc1uV2I5lc9V5d9px
 W5Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767937016; x=1768541816;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=u7//A/OFyAnlUdW3B32W84TzXnVcqeEK8bNzsWNzjm8=;
 b=QLxB+OLtjrSKYf1FxEVHwLKlG1O/f+Rz4PjPRyYrx2CZ3zSIH303Wv3xGd3OensqbN
 Lc/YqXNtu78NLXaRvlKyo1zzm9AaGjH56mHpbLGA8F3QKUEXZddpjhawH7wsis9RHa2L
 +6dp6IPn1PHliteBpg6WcsqIrlXSNu3NJCmT9dDSw9rbe+X0F/iEk+R53gNJdKLnWqfa
 IKAJpPrgBwoqNWNaeXtPrGd/YCpQNuUW1vMwNRRQEQlR41T1PEGNiJmdoQRkqoZaHEH1
 U1jJhEHPU++osaj5A+1oqH1sIgHi5ZZLlaUMBTLziSPqBSQrLS9V+iueWLEETZYmodfX
 Qu/w==
X-Gm-Message-State: AOJu0YyX5whQ322ALepNkO0qgc0QUYRPuq9EY5PtSBtMKWS/OC1w/Gdo
 zMVkimGmPgdxaTG6ql+IemKENig/k49AxGZOcbcjI8OzlBsbp+eLpdCnMySPRSPDjm4=
X-Gm-Gg: AY/fxX7KFAxcByqcKecJmV8ebtLuQWzFthXjbf6jav4+eF6trOLzt+6KTJOzglpJoZa
 HKvL0EQHwmRY6LKamlFquGERf7gcWVedar1MPtU6PIz83rlJAPyKT4a4bFzkbklPdcObjVQcHAt
 JCzTTGqdKyb0SplQejOhLfDRNN0ghyNUGP8kMxOB+F9w9kqWeSOuzOi4GUnx2dWofN7BPc2w7YY
 WDUWLToBa4euBt++T/1T9zsJFRJSMW8p8zPF4B1t67u0jod2YesbXagFhFtDP5xEUhbdN/6XFW1
 f64CQcckBkoKbC9pRf3B/KNxHgFQqIO3k3MQIHjnTdHUu+RGcjlXN0PNURdppvyeTk/tQL06qIR
 n5SgOaCfL0NxAFrElpMHJpUk3snT0GUolC5f8/gmpM7t62Tw/tPO4DkjEHO506LW5n4H0wtBT5s
 OoeuY9qp4LCAk88SaeKupJryooM3ckyl2hu1YxBNYb1einbwSf7xvO
X-Google-Smtp-Source: AGHT+IHf5VTmkDbbmQichJqi7NKPcAn4tM7IOKX2fQSW9mLBmlqw0Q/wVjoaQTU0ch9vY/5dcTF0oQ==
X-Received: by 2002:a05:600c:4e49:b0:477:a36f:1a57 with SMTP id
 5b1f17b1804b1-47d84b1897fmr92410995e9.3.1767937015919; 
 Thu, 08 Jan 2026 21:36:55 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d865f0cf2sm54052825e9.3.2026.01.08.21.36.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 21:36:55 -0800 (PST)
Date: Thu, 8 Jan 2026 21:36:51 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: scott.k.mitch1@gmail.com
Cc: dev@dpdk.org, mb@smartsharesystems.com
Subject: Re: [PATCH v9] net: optimize raw checksum computation
Message-ID: <20260108213651.36b7b492@phoenix.local>
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
>  

I also observed while looking at rte_ipv4.h that the structure elements
in the psd_hdr are not correct type. Src,dst should be rte_be32_t and len should be rte_be16_t
