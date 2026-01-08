Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC25D1D478
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Jan 2026 16:24:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A0009402D3;
	Thu,  8 Jan 2026 17:24:41 +0100 (CET)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com
 [209.85.218.42]) by mails.dpdk.org (Postfix) with ESMTP id 077CA4027A
 for <dev@dpdk.org>; Thu,  8 Jan 2026 17:24:40 +0100 (CET)
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-b804646c718so493319466b.2
 for <dev@dpdk.org>; Thu, 08 Jan 2026 08:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767889479;
 x=1768494279; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MFe97FpGSB6wgssPUB1DaURSEiKEIuIWRpigkpCiZKE=;
 b=GIKx2kXy3wv35dKO8dAaEUuw9hdqS86aZv12ZN024q7EgXOa38hVCES2Uytt8sI6EO
 jkSk/kXYwhxqf8MsSa5AUd9XauJ+FskTfBfow7M/FxL8drncHfAckczD/BFSqFM7idL5
 waG6F5hga71WUCkzb/pCF1PZ22pICJNNSACDZBSF09wseUeSiC8uXTZLSeYgEtIPnqLw
 8k7Exz9PfQrvSIr1C3qHBFGRp0ocH7BMxJO82qqQOdU4+1UpapC3YNyWnqmHoAZgWHSL
 Trf9OQQHGFEYHOLFlwHdZXF1FvEFiMhPFX9DpX1Qa+eIODbEhSzYjcFO04bVPKwu9gw9
 6Z9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767889479; x=1768494279;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MFe97FpGSB6wgssPUB1DaURSEiKEIuIWRpigkpCiZKE=;
 b=Vg5vaK01Dv8a3W+pvR6SEBQLeCr5kL67pPm4TMaFDzK+gZhc8iR+o+U742VwdK0LkH
 L4zI8IenQYP6nT5dMsH4T2XHrUhPaZFaco0qe1K2aXC0RdXNG3+IO9XEwZaNedzFZ/Yx
 GifNBMLgUY6iUtAY5pOCSwVL6Tx77ex6ehTPafBHqi/LVMr+17jfUqtsySx1oBK4qFit
 W9VAD91nTC9X5nFHkbnZ364hJjMRWRqbZEJYNHUbytllMaoGSHGYahtcoyOMJi8TENRY
 GPEJiGWPQLRkcvHQRcUPe55JoEP8FoJ+ilBEpUS1g2ubtcLPBxbXdda1xqr0OkO6/uah
 k3HA==
X-Gm-Message-State: AOJu0YyIEavrJMEVzQYyyH1Wk46Sy6sw6a8wKaTZ0lvk16PZFafO8Vhb
 UWeracfsBDGtAKIs8CgvWdpmbjWYNsmGCkVPcZxAShmlUGf7A9aZupQrVqqSpJfH234=
X-Gm-Gg: AY/fxX55xDKpyVdiME/ojVvlMw8WbxRA2jGzT7T43niAhweirD6hXM0f0kBpGUPmet3
 4eZgcqKM/crBD5tNqUeURrPfnriP0q66Z2X56RJVrPrbZnlEda3hmLXOAsXGC7x+3GY/9fBzSYw
 O0aENxW/f7OuYeTNlPOzKFeaIjiDW8ft97fB9zaArZTrFkdWAyp2Q0RbIswbMOyZBfyjs6rElpV
 w1NemmOn3WioLnLRv/Xl141/34n4d0xCxD3mgukVx8oAlLad/25s1dWCXiTW70JXfFtoKrav+a9
 lnaDg/gWhs0pVSsftnvfl0zGX+/+mzWF9EwQ2zUn5hHhYPMzjapvgVNhZwm/ieZ0T0ct6Vfx3P0
 U9RVzkxSV2HFDgh6kcUzcUQzZIZCoXOLqj3rV/aKPwt7x8DTk22ojK7eHbpwy9V3UiKWYnFYl4H
 rSI7hGz6peFX/0LT0X0Ed+ZRM9yI4z7XxZQ90kyNWvh+Eab9Jz3uG1
X-Google-Smtp-Source: AGHT+IERKq0do+1X88VBU1Iy5fUf3wTStKhpUTEiap1JHyU4laDNi6EF66o5Nn7HcZUW8DkxwnN86A==
X-Received: by 2002:a17:907:94c2:b0:b73:7184:b7d3 with SMTP id
 a640c23a62f3a-b84453e2967mr621060966b.58.1767889479345; 
 Thu, 08 Jan 2026 08:24:39 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a5118eesm834469766b.52.2026.01.08.08.24.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 08:24:39 -0800 (PST)
Date: Thu, 8 Jan 2026 08:24:33 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: scott.k.mitch1@gmail.com
Cc: dev@dpdk.org, mb@smartsharesystems.com
Subject: Re: [PATCH v7] net: optimize raw checksum computation
Message-ID: <20260108082433.3a70ca07@phoenix.local>
In-Reply-To: <20260108145913.92421-1-scott.k.mitch1@gmail.com>
References: <20260108145913.92421-1-scott.k.mitch1@gmail.com>
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

On Thu,  8 Jan 2026 09:59:13 -0500
scott.k.mitch1@gmail.com wrote:

> diff --git a/lib/net/rte_ip4.h b/lib/net/rte_ip4.h
> index 822a660cfb..67033875cc 100644
> --- a/lib/net/rte_ip4.h
> +++ b/lib/net/rte_ip4.h
> @@ -223,21 +223,19 @@ rte_ipv4_phdr_cksum(const struct rte_ipv4_hdr *ipv4_hdr, uint64_t ol_flags)
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
> +		.len = (ol_flags & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_UDP_SEG)) ? 0 :
> +			rte_cpu_to_be_16((uint16_t)(rte_be_to_cpu_16(ipv4_hdr->total_length) -
> +				rte_ipv4_hdr_len(ipv4_hdr)))
> +	};
> +#ifdef RTE_

I find it hard to read complex expressions in initialiazers.
Much better as original if statement.
Sometimes you need a union to convince compiler of aliasing


