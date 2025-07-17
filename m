Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF7EC83F1A
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Jul 2025 18:07:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7910B4013F;
	Thu, 17 Jul 2025 20:07:41 +0200 (CEST)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com
 [209.85.160.170])
 by mails.dpdk.org (Postfix) with ESMTP id 2AB87400EF
 for <dev@dpdk.org>; Thu, 17 Jul 2025 20:07:40 +0200 (CEST)
Received: by mail-qt1-f170.google.com with SMTP id
 d75a77b69052e-4ab6646476aso8606641cf.3
 for <dev@dpdk.org>; Thu, 17 Jul 2025 11:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752775659;
 x=1753380459; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iVmNwjpbZ0eYDst4g2JWTRFU2/d6TCi5K+Xvy750lhw=;
 b=ZQQfOUHog7ukpWtFe+fj4Pyv9H/sT/4StQveYZC2PsBhZ+01S6NAkbExDUuGQsZtz6
 FpHF4AfE+AgMo+rOByuJ2/jlYbbLbjDdwQLvyMGG0c4v7I0q+fxZRSb3Xepp0Ec4AZag
 9K84yoJAySale381CbhXa3YmwToOH8CZiq2hBDsEpV/X7EVg8ZFWDqTGT22qn5djsBVf
 lRfsDYGsBL3R1TDsg1tmwuD4fb0AzgnfhGdlv2oJGrcoVQRANYAK0oXSS4ZY9y6EXwh6
 CMz4WTWHsRHh7+MSgibzWO1cNRkwLtQOHZLYkWodGsh5YOB+csOnA+q+tmMdtw/Bn/6X
 qoCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752775659; x=1753380459;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iVmNwjpbZ0eYDst4g2JWTRFU2/d6TCi5K+Xvy750lhw=;
 b=fzL1v7qMNauv4Kp32Sn5CE65v0133/rYtCrOHyvb+gm1Z32ZGBFjviNpdm6eulIBnj
 Xpcx+a+t4yaOGKmeL5y5AV6hSTO4ZEhJ/AFX9+zhBX4/abdFVzu2DnW+LQfjQ9ox2FSJ
 nojq/L41dn3FjMqdHw4/2Sy4DOidWpJHp/0UBU3bTf/0wbNpW0vX/VK6Zv0+5w24i9Sk
 t4R5cD9Xp3tkH5z9rQ3UFqhHPtoc5TJ9Y8A6sYHgWWLIgMCMfzFrRaHGcXI28pNt78YR
 FmuL8l/uYLyvY0aN2a2rnK2QFSPNvvQDvS2Sq0ycfHDM42+DKdTpGrs12JdfmlNg/w1o
 zXfw==
X-Gm-Message-State: AOJu0YxYLEBmQJ8tJxxWWsrYZ6Q0sUjohQIQE7qRsjbNrf38pxHlpsB8
 S0kOkShH5f05fNz4hxZH30m7IYsQMYxUazJuYuIj13jzAojBkihNwiQjL071adEa4cc=
X-Gm-Gg: ASbGnct30jweTXpwzTGZGblNYm5DNtHKIQUXm9nhGAartHqrP4/uy0vG0yF6v7UcrkH
 OL1gxA+VKcjUG9rlBh12QnwdeMvA87dye6FhtfXjAjJQRRyMmGMph3BX/WROEQO9coguqcz7dqS
 /Q70RGw+ojtIyywXR5F8na/Ubh/ZfUXIhNRciChQ5h+YVjxMkeGmN8cMxio93oq3cjifrZ7nCPI
 kKgNoP1LqNcJuCA65CbBIgBPpCjiUfPEtWCvhyX+aP8QYPfqAy6ZHaNroo50ny+njEOesaiTkSp
 RUj2fINUPdS/ArVjgszdnOVer0Mz4gIV/uI4HwoEXBAU37fo70hREXvyg7eSk/2q8M+lG/OVvFn
 2p2cfBuLemrp4jizdrsvaFe3y6cwSUiLtZTLjdRX8PAs0nYZFlprt0Q5OFzC+uRTwrZkjT2zP74
 TPcF+iOxsMAw==
X-Google-Smtp-Source: AGHT+IEiVDKS6jTBSENL2OP9WufGBfxkH958N+f3KVX68bU4PDZ5aubSTqHQnZoTnVh1RW2mbYP7UA==
X-Received: by 2002:ac8:57d3:0:b0:4ab:6d9a:5057 with SMTP id
 d75a77b69052e-4aba3e1a2dfmr55792681cf.42.1752775659271; 
 Thu, 17 Jul 2025 11:07:39 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4aba3dcc1a4sm12695521cf.62.2025.07.17.11.07.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Jul 2025 11:07:39 -0700 (PDT)
Date: Thu, 17 Jul 2025 11:07:36 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jie Liu <liujie5@linkdatatechnology.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v5 03/14] net/sxe: add tx rx setup and data path
Message-ID: <20250717110736.68175489@hermes.local>
In-Reply-To: <20250710012021.7698-3-liujie5@linkdatatechnology.com>
References: <20250707115819.12826-14-liujie5@linkdatatechnology.com>
 <20250710012021.7698-1-liujie5@linkdatatechnology.com>
 <20250710012021.7698-3-liujie5@linkdatatechnology.com>
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

On Wed,  9 Jul 2025 21:20:10 -0400
Jie Liu <liujie5@linkdatatechnology.com> wrote:

> s32 __rte_cold __sxe_rx_queue_mbufs_alloc(struct sxe_rx_queue *rxq)
> +{
> +	struct sxe_rx_buffer *buf_ring = rxq->buffer_ring;
> +	s32 ret = 0;
> +	u64 dma_addr;
> +	u16 i;
> +
> +	for (i = 0; i < rxq->ring_depth; i++) {
> +		volatile union sxe_rx_data_desc *desc;
> +		struct rte_mbuf *mbuf = rte_mbuf_raw_alloc(rxq->mb_pool);
> +
> +		if (mbuf == NULL) {
> +			PMD_LOG_ERR(DRV, "rx mbuf alloc failed queue_id=%u",
> +					(u16)rxq->queue_id);
> +			ret = -ENOMEM;
> +			goto l_end;
> +		}
> +

Logging at error level could cause a lot of messages if pool gets exhausted under
load. Better to just have a rx_nombuf statistic.
