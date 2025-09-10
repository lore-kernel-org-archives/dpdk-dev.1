Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2838CA101F
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Sep 2025 06:49:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2BED6402E9;
	Wed, 10 Sep 2025 08:49:42 +0200 (CEST)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43]) by mails.dpdk.org (Postfix) with ESMTP id 81BD040270
 for <dev@dpdk.org>; Wed, 10 Sep 2025 08:49:40 +0200 (CEST)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-45dde353b47so18340685e9.3
 for <dev@dpdk.org>; Tue, 09 Sep 2025 23:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=6wind.com; s=google; t=1757486980; x=1758091780; darn=dpdk.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZFUuatgEI5hoLWfFMDM/uWu4qbdOiqxfJR9+iwy+o38=;
 b=LYX/lmkw3x+XZETbVA3mYlkq1Quae1DjGznCSsR1dY9VV7By0B0MbjtNZaUqq82XUY
 IwE7SIfc+IW/MjamoPJ65aW2zS32+e25NCNywx3CJ30TYE1KLHw+4O2kfocOz81VCyLn
 N9RqWQ2Rbxxgso23TcKQ1w1YXN8TsS+SCenx5PMLJcTQosbahmeCsBwr15PH7lqtOSM3
 AcLMrOpktoZbpMW9uwO8JmLjJ1GqPtbU7kHi9CcjrEr6Fh9MzFJxVgQJII4ucE0Xme+8
 MAxeSnsDlCLhbayPaLW1/nQQA6D1zrzWvg9WxZ1gsrIEMGfZlsUMjRpsJbVtFTRjA1aP
 tN7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757486980; x=1758091780;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZFUuatgEI5hoLWfFMDM/uWu4qbdOiqxfJR9+iwy+o38=;
 b=HTwlSypNbPjhGDo9y4bUa2zf7CBJYB4XLrVcsQo+uLmD4vywOc+P1gzXRBrIKUE7vm
 FHqJBiQnAxUtWaR2SUiVaTbQqJSSDBTMSkjekhew8PpGkVeCzzgxyoHOV0gnUR1lQHor
 PnvyV2/G/M6msXebAyd5lelfMlQlBZ4jh7wqBZqbvJqfK8KIiJFF81FdtPLt77myRIXl
 hwx/nIKOqLr96GB9yit+c2VH6kg4G4LoaMPLfmm1YTcrs8m7jxNcYLu1yJK435GbrsWp
 ycgM0eTue7WaKhskx+j8zKwHZzEhvoODktwq5oVagXpXa+MpmCmWxYw074+j5b6OHKyK
 ewHQ==
X-Gm-Message-State: AOJu0YzREj8dX2Yms7TL+F9hVxUuyibUGLAL8sxv7S+69ri2Yo+UxinR
 YLu6cNVtiyVaymZst+y8vl6+2qhCisnKf33qZD85BYlmUYelcfwbp8t94TrUmXfEug==
X-Gm-Gg: ASbGncsS8z5bYDgNfI3WNvc4WKRxklKB62K6mG9NGscLL9ldcDsQTzVer1RxETEAM/m
 l1UGIRvu9uT4h0SPMm8d+3clKLNX/WDHJmFS4/wN2nQRLWru6ydU1TZQ+7w/R9fH9q67QNcK2vb
 SeYUYdp7V/rc6Twrne5svh5YAURT1Fsy2xZmW9wOZC9xT6z1gsbCrPvS7RgqXHRZJLO/f2DBvbk
 X7qB805Axek9iPCikrhScnosMApRo32gfmPB4g4phAgwEQaYjEkQomLsOrpG22xtmJuqydIYsDq
 8EO9K9kWO3zRHEsvotWgRFh4L9qA7aHXL434BLutrMikdPhWKLjkF1PobMCvODUDEW1GNbzCN5y
 5w+4aNKgYRoUVjsfDH4TYmy3bQV+4YdKA8S2bEg==
X-Google-Smtp-Source: AGHT+IGIGh785bXhJ9VRlDIpmVmlBDlLjcc/6t664fb9Q/N5OsVpyUIpScX7QulxlnWZb+IwbcoZRA==
X-Received: by 2002:a05:6000:24c5:b0:3e7:458e:f69 with SMTP id
 ffacd0b85a97d-3e7458e1a33mr10150253f8f.56.1757486980007; 
 Tue, 09 Sep 2025 23:49:40 -0700 (PDT)
Received: from [10.17.1.39] ([185.13.181.2]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e75224d7f5sm5822210f8f.59.2025.09.09.23.49.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Sep 2025 23:49:39 -0700 (PDT)
Message-ID: <151c401a-87dc-423c-8bae-89d325dc8c90@6wind.com>
Date: Wed, 10 Sep 2025 08:49:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [V3] net/qede: reduce the optimization level for gcc > 11
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>,
 Devendra Singh Rawat <dsinghrawat@marvell.com>,
 Alok Prasad <palok@marvell.com>, Jerin Jacob <jerinj@marvell.com>,
 Olivier Matz <olivier.matz@6wind.com>,
 Edwin Brossette <edwin.brossette@6wind.com>, stable@dpdk.org
References: <20250908070414.1297844-1-thierry.herbelot@6wind.com>
 <20250909054023.3263401-1-thierry.herbelot@6wind.com>
 <20250909091724.2ea0615e@hermes.local>
Content-Language: en-US
From: Thierry Herbelot <thierry.herbelot@6wind.com>
In-Reply-To: <20250909091724.2ea0615e@hermes.local>
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

Hello Stephen,

On 9/9/25 18:17, Stephen Hemminger wrote:
> On Tue,  9 Sep 2025 07:40:23 +0200
> Thierry Herbelot <thierry.herbelot@6wind.com> wrote:
> 
>> The qede PMD stopped working under Ubuntu-24.04 (using gcc-13) when
>> compiled with -O3 (default level for all DPDK code). A bug is opened
>> for this issue (see Link). The same issue is also seen with gcc-12
>> and gcc-14. The issue is not seen with clang-20.
>>
>> A first workaround is to just disable all optimizations (-O0), which
>> restores packet Rx with Qlogic NICs. However, the performance impact
>> is not acceptable (around 50% drop).
>>
>> A better compromise is to use -O1 for the qede PMD:
>> - there is some perf impact,
>> - but the PMD is working as expected (packets are correctly received).
>>
>> When compiling with both -O2 and -O3 and gcc > 11, there is no packet
>> reception when using the qede PMD. The root cause could be missing
>> 'volatile' keywords or missing memory barriers in the qede PMD code.
>>
>> Link: https://bugs.dpdk.org/show_bug.cgi?id=1379
>> Signed-off-by: Thierry Herbelot <thierry.herbelot@6wind.com>
> 
> Which rx_burst gets used on that hardware?
> 
> Is there any indication of errors (like rx_mbuf_alloc_failed) in the stats.
> 
> The driver does not appear to have any write barrier after updating the consumed packets.
> 
> Would this help?
> diff --git a/drivers/net/qede/qede_rxtx.c b/drivers/net/qede/qede_rxtx.c
> index 25e28fd9f6..1b5109d966 100644
> --- a/drivers/net/qede/qede_rxtx.c
> +++ b/drivers/net/qede/qede_rxtx.c
> @@ -1295,6 +1295,8 @@ static inline void qede_rx_bd_ring_consume(struct qede_rx_queue *rxq)
>   {
>          ecore_chain_consume(&rxq->rx_bd_ring);
>          rxq->sw_rx_cons++;
> +
> +       rte_wmb();
>   }
>   
I just checked with this patch, but the error is still present:

testpmd> show fwd stats all

   ---------------------- Forward statistics for port 0 
----------------------
   RX-packets: 0              RX-dropped: 10            RX-total: 10
   RX-error: 0
   RX-nombufs: 10
   TX-packets: 0              TX-dropped: 0             TX-total: 0
  
----------------------------------------------------------------------------

The error chain is:

RX-nombufs
  => (testpmd) stats.rx_nombuf
   => (qede) p_stats->common.no_buff_discards
    => (qede/base) HILO_64_REGPAIR(mstats.no_buff_discard)
          (internal to the NIC)

	Best regards

	Thierry


> 
> 
> 

-- 
Thierry Herbelot

