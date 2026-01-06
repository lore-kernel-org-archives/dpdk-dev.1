Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 640A0CE9D7D
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Jan 2026 16:33:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 88C3D4069F;
	Tue,  6 Jan 2026 17:33:45 +0100 (CET)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50]) by mails.dpdk.org (Postfix) with ESMTP id 930DF402DC
 for <dev@dpdk.org>; Tue,  6 Jan 2026 17:33:43 +0100 (CET)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-477a2ab455fso11050755e9.3
 for <dev@dpdk.org>; Tue, 06 Jan 2026 08:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767717223;
 x=1768322023; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X3+dAYNhfMEUeWyX38Q8I9RGTNw2fGKlRsxGIFxXmVM=;
 b=Y7zt7NwzKFCQFHSd76K/B8hu+/wQzQnHhxdwykoTYr3/xC1wi307m5hMjGElG5TJtj
 GJrXZ30hVDivyoGLTQ0K30+1MH8E8VCLip3rU0w7Tml2y5ubsn7P4Miyyz9OuzWRmU71
 tmOmw4eSbLlan1HM+JO3luSB6ui9uKN67cRklXELCEVQVKV9voPeE7qJlyuRXyJ4bMFQ
 uNLQO9XJnRD2N1PuSr/9ag5h2YFP0/zFw6+G6eEPEH8s/Kh6xovUqXd2/hGwDZrAfdH6
 syiKxjtTUQGe/NXAtkEJPIuPN0QxtK5IMaqqo0ROcgSnJYL9oTSnBCh4rEDp0hWQUepT
 RUuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767717223; x=1768322023;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=X3+dAYNhfMEUeWyX38Q8I9RGTNw2fGKlRsxGIFxXmVM=;
 b=AaEE5itBpsQeAGNTBf6FfW0WhW8AcHR8DID3zKHaCsBrgZ1nNrLiZNIxdyPcgNSzoB
 y9iGc44DUuQDNpmBendUC3ZBwNW4C6NJIm8YTTJJvathgpjYyiFB42YO3vftwaZdyMWo
 I5BcrZ4d25osSXpExO2Vu6RSOoI1vBwKabi2PdqFkoMwfoRUAXU8IRtHwPCwKkxO9Crx
 SCDsRiI+Ed1Q2I3nS8Bu5lJVRgavhPXPbpeid/VNa2MRfCZzAMan2QjPYLd7z0MKJ/GD
 ngte4izzCxmx3BLwxwiihDrhDw6U9cBnd9ajB0ZAEzjXKM21ezO4LfyXMJETsvl8+E0i
 WMOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvk/3jDF6fSpRi/a8kUWgtCWppvana2tSiZ3ymtvuExyUww//hHEhXyZzi3lj+OBuIKss=@dpdk.org
X-Gm-Message-State: AOJu0YxWXURrUqAN6NfvXnhUqb753Sld6eRP9UDO7HKa7qYl6cq3axE4
 tEHUHKNfR6WijfglG8s8v/gVgCX82BtqcgHMoPTJ9ITCsRAJMFJ/eUk01pWkl2/KBjw=
X-Gm-Gg: AY/fxX6iH3SaQELRsYAJ7d3oTxLRLn0FsUMicKNMffv5H9k4xKqJL2+Gm4XaDO901E0
 ZmRJPUIQfPAH+MerfIo0+lFsW9h/Q8TQVMptZZyT2vO5V+ECj3jjPdD/405z53RD1GxBgtD+hdO
 PUAvHd6Hk0awMH3HMD0mZEMK2qqzFQiwBhmsw3c7jEGU0HumSvZ/w6etEjxN868sue/yZV49mNI
 OJCgozG2byJY/yOmAyT1W5MfCzideO59B/aNFzMDtox8erlvbmVqonZ+v5TpxCaOkGiZtcZW6ct
 bpOgyu9aXQpkbjjRKy2vDjPV3pB0nBIbvfqEQLwhOi744f0WoI/SR0o9JJpPBPbNahqfyrl08Wb
 x7YV8llkMwQ7rl033lGlfrHhHsiCEUuusO44Dy9D0XNnoduM6Mlw/lmB0GVOFR5d1JQroiKThpm
 GX3vOXf2KqsGyOacypdi/SPYbf3UKPRlycbo+r9lhj0PmpIKY03th1
X-Google-Smtp-Source: AGHT+IHbeIN1RBTTgaSxWE1ro86Y+Du9MvK+sl6j2t9omVI/01cYtDRoNnGFBb8z0EMOO+k1P2y80w==
X-Received: by 2002:a05:600c:a16:b0:477:58af:a91d with SMTP id
 5b1f17b1804b1-47d7f06b874mr42610275e9.5.1767717223004; 
 Tue, 06 Jan 2026 08:33:43 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0dade5sm5294149f8f.9.2026.01.06.08.33.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 08:33:42 -0800 (PST)
Date: Tue, 6 Jan 2026 08:33:36 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Gregory Etelson <getelson@nvidia.com>
Cc: <andrew.rybchenko@oktetlabs.ru>, <dev@dpdk.org>, <mkashani@nvidia.com>,
 <thomas@monjalon.net>, <viacheslavo@nvidia.com>, <matan@nvidia.com>
Subject: Re: [RFC PATCH v3] ethdev: support selective Rx data
Message-ID: <20260106083336.07408e78@phoenix.local>
In-Reply-To: <20260106154554.40556-1-getelson@nvidia.com>
References: <20260104131301.196350-1-getelson@nvidia.com>
 <20260106154554.40556-1-getelson@nvidia.com>
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

On Tue, 6 Jan 2026 17:45:54 +0200
Gregory Etelson <getelson@nvidia.com> wrote:

> In some cases application does not need to receive entire packet
> from port hardware.
> If application could receive required Rx data only and safely discard
> the rest of Rx packet data, that could improve port performance by
> reducing PCI bandwidth and application memory consumption.
> 
> Selective Rx data allows application to receive
> only pre-configured packet segments and discard the rest.
> For example:
> - Deliver the first N bytes only.
> - Deliver the last N bytes only.
> - Deliver N1 bytes from offset Off1 and N2 bytes from offset Off2.
> 
> Selective Rx data is implemented on-top of the existing Rx
> BUFFER_SPLIT functionality:
> - The rte_eth_rxseg_split will use the NULL mempool for data segments
> that should be discarded.
> - PMD will not create MBUF segments if no data was read.
> 
> For example: Deliver Ethernet header only
> 
> Rx queue segments configuration:
> struct rte_eth_rxseg_split split[2] = {
>     {
>         .mp = <some mempool>,
>         .length = sizeof(struct rte_ether_hdr)
>     },
>     {
>         .mp = NULL, /* discard data */
>         .length = <MTU>
>     }
> };
> 
> Received MBUF configuration:
> mbuf[0].pkt_len = <original packet length>;
> mbuf[0].data_len = sizeof(struct rte_ether_hdr);
> mbuf[0].next = NULL; /* The next segment did not deliver data */
> 
> A PMD activates the selective Rx data capability by setting the
> rte_eth_rxseg_capa.selective_read bit.
> 
> Signed-off-by: Gregory Etelson <getelson@nvidia.com>
> ---
> v3: Change the selective_read bit location.
> ---
>  lib/ethdev/rte_ethdev.h | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
> index a66c2abbdb..84769d3d26 100644
> --- a/lib/ethdev/rte_ethdev.h
> +++ b/lib/ethdev/rte_ethdev.h
> @@ -1121,7 +1121,11 @@ struct rte_eth_txmode {
>   *   The rest will be put into the last valid pool.
>   */
>  struct rte_eth_rxseg_split {
> -	struct rte_mempool *mp; /**< Memory pool to allocate segment from. */
> +	/**
> +	 * Memory pool to allocate segment from.
> +	 * NULL means skipped segment in selective Rx data. @see selective_read.
> +	 */
> +	struct rte_mempool *mp;
>  	uint16_t length; /**< Segment data length, configures split point. */
>  	uint16_t offset; /**< Data offset from beginning of mbuf data buffer. */
>  	/**
> @@ -1758,6 +1762,7 @@ struct rte_eth_rxseg_capa {
>  	uint32_t multi_pools:1; /**< Supports receiving to multiple pools.*/
>  	uint32_t offset_allowed:1; /**< Supports buffer offsets. */
>  	uint32_t offset_align_log2:4; /**< Required offset alignment. */
> +	uint32_t selective_read:1; /**< Supports selective read. */
>  	uint16_t max_nseg; /**< Maximum amount of segments to split. */
>  	uint16_t reserved; /**< Reserved field. */
>  };

Will need testpmd extension and a driver (ideally multiple) that support it.
