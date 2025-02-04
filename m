Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7AC9C02194
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 13:39:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 50A6740E2A;
	Tue,  4 Feb 2025 14:39:18 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 214F540265
 for <dev@dpdk.org>; Tue,  4 Feb 2025 14:39:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738676356;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=spca63ZRdhGVXt2D3CJkWmnB0iPMbJZ97RlpPtC5yys=;
 b=EUR48BkUZnYqqZRe37fbPAExdTIVlaj9bhMQZ09F0ES/OD1+2U7PyzXqgpu4VEmbZv+/Nr
 Lnwmv3823Gm9GZiuhoTvYlRz3Y0GrjXw7DceYg7AwZlLnGvppuwohQvsi0gIZOzdrUyUTj
 o7KvIzQCmWK5OoGKTE3KgB8nLuQ3c8A=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-LiDFR4VjMVyo-zazurMPaw-1; Tue, 04 Feb 2025 08:39:15 -0500
X-MC-Unique: LiDFR4VjMVyo-zazurMPaw-1
X-Mimecast-MFC-AGG-ID: LiDFR4VjMVyo-zazurMPaw
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7bcf4d3c1c1so847971585a.2
 for <dev@dpdk.org>; Tue, 04 Feb 2025 05:39:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738676355; x=1739281155;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=spca63ZRdhGVXt2D3CJkWmnB0iPMbJZ97RlpPtC5yys=;
 b=KjDLDYTzWFXjzxxI3gDRd/sMuXg5/adzxwScwsmJfkdUuWgYYs6nQxNCQY+NFC5+Ib
 /B+tJoln7jG+8acJ0U8P4MZJYIbb9M0pNdYMhvAWOmB6oase6mGCIYc0HbaNnOCh9z7z
 f6BsCgdLlA7WdD7tSOJizZXkjyVsqxWI5JWNz4aSUt8k/XO0gQCu5HJzC+CkMSIlDZH0
 Qluu9ysossnlNUF/IuYnM4GhtYjeoQyz8ROecZ1OMXSVmo9Vz/tx2XXwm+8hS/2Yea7v
 0m8kFb87NGaMpGKM3dXMr1MqJuhX4aeNf4C8JEIFb+n9sFduypJ8jo8twpJF5udrMshP
 nNKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzlF4P2pbNCGN33ifJKIP0L4eTHBCdgqMty/+RWl3WAPiJP0PoyYiKw1ryMOaSyOEE6hA=@dpdk.org
X-Gm-Message-State: AOJu0YyZ//QN3M3U7ruUzzd2cziHRbZKvfE/1fOIfz0yIsB+cqF1Y8Xb
 EvdOzZFytR1OTJCYMaEVWuG+GxP4aqLLBJkCAy5EP7erM7kWSAuO6F8hh4SDWWEiV7pD8pV3N9J
 guoRSrk49STQro0QX/FTUEa4USsbd3Mo8z9qQ8cwB
X-Gm-Gg: ASbGncuT+k5/Re+j792upu7gFCX6aGRlV+b97RwAlBw6LSsjpBa2KlPA4a6xjIhS8tH
 hH/Sx2RVFj8jIT/RJGmPT4qwF0aw+giCSM4XWyYWudwjNlNdyWYtHvUULMcDYPcTsiTpaR6Bxwx
 Oss1URg6mUMknSod0dS+eIniLsiY6VapIOtbWXE2mOHpaLmVkkEBHDDuiUg9r0ZvCJSZV7mqebp
 g9+fU3E2wl0pY/DOwUlKbiiDAdEFbI3P6b5IZ3q0VDn9SWoJMpzglh1H0OHuEHMWspBUMusC9xJ
 fjPtbGLdki4iQJVBNyBoa9NRWWBz5QhqKzIrPIGPGrDxc928mqSyqmU4GK9bpdxJREaN
X-Received: by 2002:a05:620a:2992:b0:7b9:a387:3cd8 with SMTP id
 af79cd13be357-7bffcd956e1mr3068937485a.42.1738676354729; 
 Tue, 04 Feb 2025 05:39:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG50QQvvaJgqK9FzuQMwiW7Z+BvOb9afJupCzCEa2eLVFRydi+ytsN9XveAdkW2SkcAYseSBg==
X-Received: by 2002:a05:620a:2992:b0:7b9:a387:3cd8 with SMTP id
 af79cd13be357-7bffcd956e1mr3068935085a.42.1738676354422; 
 Tue, 04 Feb 2025 05:39:14 -0800 (PST)
Received: from ?IPV6:2a06:5900:c00c:9000:d9e8:eec:cb1c:a376?
 ([2a06:5900:c00c:9000:d9e8:eec:cb1c:a376])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c00a8d0273sm635047585a.44.2025.02.04.05.39.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Feb 2025 05:39:14 -0800 (PST)
Message-ID: <8fefafc7-754f-4965-a117-2e9d9c281c41@redhat.com>
Date: Tue, 4 Feb 2025 13:39:11 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] net/af_xdp: Refactor af_xdp_tx_zc
To: Ariel Otilibili <ariel.otilibili@6wind.com>, dev@dpdk.org
Cc: stable@dpdk.org, Thomas Monjalon <thomas@monjalon.net>,
 David Marchand <david.marchand@redhat.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Ciara Loftus <ciara.loftus@intel.com>
References: <20250116195640.68885-1-ariel.otilibili@6wind.com>
 <20250201100300.2194018-1-ariel.otilibili@6wind.com>
 <20250201100300.2194018-3-ariel.otilibili@6wind.com>
From: Maryam Tahhan <mtahhan@redhat.com>
In-Reply-To: <20250201100300.2194018-3-ariel.otilibili@6wind.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: szAukmWoPVmNwkflsvBeIVy_pVZe3MPeCDfeo9TSlKg_1738676355
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hi Ariel

Have you had a chance to test this? I'm currently getting a segfault 
with testpmd

testpmd>
Thread 4 "dpdk-worker0" received signal SIGSEGV, Segmentation fault.
[Switching to Thread 0x7ffff4e00400 (LWP 3768882)]
0x0000000000b57b44 in eth_af_xdp_tx ()

Thanks
Maryam

On 01/02/2025 10:03, Ariel Otilibili wrote:
> Both legs of the loop share the same logic: the common parts are about
> reserving and filling both address and length into the description.
>
> This is moved into reserve_and_fill().
>
> Bugzilla ID: 1440
> Suggested-by: Maryam Tahhan <mtahhan@redhat.com>
> Signed-off-by: Ariel Otilibili <ariel.otilibili@6wind.com>
> ---
>   drivers/net/af_xdp/rte_eth_af_xdp.c | 62 ++++++++++++++++-------------
>   1 file changed, 34 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/net/af_xdp/rte_eth_af_xdp.c b/drivers/net/af_xdp/rte_eth_af_xdp.c
> index 092bcb73aa0a..840a12dbf508 100644
> --- a/drivers/net/af_xdp/rte_eth_af_xdp.c
> +++ b/drivers/net/af_xdp/rte_eth_af_xdp.c
> @@ -536,6 +536,31 @@ kick_tx(struct pkt_tx_queue *txq, struct xsk_ring_cons *cq)
>   		}
>   }
>   
> +static inline struct xdp_desc *
> +reserve_and_fill(struct pkt_tx_queue *txq, struct rte_mbuf *mbuf,
> +		 struct xsk_umem_info *umem)
> +{
> +	struct xdp_desc *desc = NULL;
> +	uint32_t *idx_tx = NULL;
> +	uint64_t addr, offset;
> +
> +	if (!xsk_ring_prod__reserve(&txq->tx, 1, idx_tx))
> +		goto out;
> +
> +	desc = xsk_ring_prod__tx_desc(&txq->tx, *idx_tx);
> +	desc->len = mbuf->pkt_len;
> +
> +	addr = (uint64_t)mbuf - (uint64_t)umem->buffer
> +		- umem->mb_pool->header_size;
> +	offset = rte_pktmbuf_mtod(mbuf, uint64_t) - (uint64_t)mbuf
> +		+ umem->mb_pool->header_size;
> +	offset = offset << XSK_UNALIGNED_BUF_OFFSET_SHIFT;
> +	desc->addr = addr | offset;
> +
> +out:
> +	return desc;
> +}
> +
>   #if defined(XDP_UMEM_UNALIGNED_CHUNK_FLAG)
>   static uint16_t
>   af_xdp_tx_zc(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
> @@ -545,10 +570,8 @@ af_xdp_tx_zc(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
>   	struct rte_mbuf *mbuf;
>   	unsigned long tx_bytes = 0;
>   	int i;
> -	uint32_t idx_tx;
>   	uint16_t count = 0;
>   	struct xdp_desc *desc;
> -	uint64_t addr, offset;
>   	struct xsk_ring_cons *cq = &txq->pair->cq;
>   	uint32_t free_thresh = cq->size >> 1;
>   
> @@ -559,21 +582,12 @@ af_xdp_tx_zc(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
>   		mbuf = bufs[i];
>   
>   		if (mbuf->pool == umem->mb_pool) {
> -			if (!xsk_ring_prod__reserve(&txq->tx, 1, &idx_tx)) {
> +			if (!(desc = reserve_and_fill(txq, mbuf, umem))) {
>   				kick_tx(txq, cq);
> -				if (!xsk_ring_prod__reserve(&txq->tx, 1,
> -							    &idx_tx))
> +				if (!(desc = reserve_and_fill(txq, mbuf, umem)))
>   					goto out;
>   			}
> -			desc = xsk_ring_prod__tx_desc(&txq->tx, idx_tx);
> -			desc->len = mbuf->pkt_len;
> -			addr = (uint64_t)mbuf - (uint64_t)umem->buffer -
> -					umem->mb_pool->header_size;
> -			offset = rte_pktmbuf_mtod(mbuf, uint64_t) -
> -					(uint64_t)mbuf +
> -					umem->mb_pool->header_size;
> -			offset = offset << XSK_UNALIGNED_BUF_OFFSET_SHIFT;
> -			desc->addr = addr | offset;
> +
>   			tx_bytes += desc->len;
>   			count++;
>   		} else {
> @@ -584,26 +598,18 @@ af_xdp_tx_zc(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
>   			if (local_mbuf == NULL)
>   				goto out;
>   
> -			if (!xsk_ring_prod__reserve(&txq->tx, 1, &idx_tx)) {
> +			if (!(desc = reserve_and_fill(txq, local_mbuf, umem))) {
>   				rte_pktmbuf_free(local_mbuf);
>   				goto out;
>   			}
>   
> -			desc = xsk_ring_prod__tx_desc(&txq->tx, idx_tx);
> -			desc->len = mbuf->pkt_len;
> -
> -			addr = (uint64_t)local_mbuf - (uint64_t)umem->buffer -
> -					umem->mb_pool->header_size;
> -			offset = rte_pktmbuf_mtod(local_mbuf, uint64_t) -
> -					(uint64_t)local_mbuf +
> -					umem->mb_pool->header_size;
> -			pkt = xsk_umem__get_data(umem->buffer, addr + offset);
> -			offset = offset << XSK_UNALIGNED_BUF_OFFSET_SHIFT;
> -			desc->addr = addr | offset;
> +			pkt = xsk_umem__get_data(umem->buffer,
> +						 (desc->addr & ~0xFFF)
> +						 + (desc->addr & 0xFFF));
>   			rte_memcpy(pkt, rte_pktmbuf_mtod(mbuf, void *),
> -					desc->len);
> -			tx_bytes += desc->len;
> +				   desc->len);
>   			rte_pktmbuf_free(mbuf);
> +			tx_bytes += desc->len;
>   			count++;
>   		}
>   	}

