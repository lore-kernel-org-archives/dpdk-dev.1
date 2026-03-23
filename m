Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 348D3F483CC
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Mar 2026 16:59:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 538AC40268;
	Mon, 23 Mar 2026 17:59:43 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id BC55A4025F
 for <dev@dpdk.org>; Mon, 23 Mar 2026 17:59:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774285181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5OL+iIxrXM7up75ps6Z0+0seX3Oc72Jk+lAhx9oef9M=;
 b=dn5hHleNgSiEIONyBsCQVqP8zrTISF3BzS36HUFtFWkMm0dW0ev3lmTCkljmG4pCcFunw3
 K3Je228svnhtk2ChEkEEq8EZ9C0FacPTYYs8oRB2dP7rEbZadsoRLdcC2p6y0vbQXVNhs2
 8bTP6YW/J8oW4Auz3z0i/2rjckKaiRE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-D4TA4s1ROhCdb2Kx0EkEZQ-1; Mon, 23 Mar 2026 12:59:39 -0400
X-MC-Unique: D4TA4s1ROhCdb2Kx0EkEZQ-1
X-Mimecast-MFC-AGG-ID: D4TA4s1ROhCdb2Kx0EkEZQ_1774285179
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4870221e1fdso21680245e9.0
 for <dev@dpdk.org>; Mon, 23 Mar 2026 09:59:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774285178; x=1774889978;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5OL+iIxrXM7up75ps6Z0+0seX3Oc72Jk+lAhx9oef9M=;
 b=rk276pwfuvWa7LIWRHCtHYWSO69cEYPWQwSex0oQa9BEfvZzDYvwhZ7Hm/+prAc98L
 GIitO5M0sldYCSiq0Pgur7LyWV3HaEVswSl6O1BMFNWw2Lws2i1/FVhfKqK4fLSroArX
 nhdgVDNu9nMWNB+M/8CPAek6gN0YDnhOyZgI0dZrPHSTMFY5GAQtsWiM2StXSwvQpppo
 TCdALuTkFbemh6TAYdDrvd18xqzxUqT7EMHFUSnU6LN1zso/172hPFH+P9x7SK/Dbdnw
 WKopg8FpuGn1AmfEbEV8/0JG0Ox5/j1KuOHheOgGk9gpMrmWn9hN9/6xVrpR0/d/Ywl9
 v3rg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBlT3C77SjllbLSMmPjRG8L63iAy4zatAWTbOuBBWH1wc60pbeK1dp6N44hdpMUbTqmts=@dpdk.org
X-Gm-Message-State: AOJu0Yx+WgSOn5xGxCGo/1YfAZcBvtzi70TpfRn7MGOPkUEMUj4x05OL
 Cq1+j+juB6RqL8gT5QdxIoUbdgk5BEx5OLd7E4cdqSmzlGWMVU58Ln1wP0B+3nfXvEVsEEuPwdW
 CmZK1r6y9oOlXjOgpo9JFkEElA5JOwCE6SyczK60M5YW8
X-Gm-Gg: ATEYQzwvTuRnsNn3ICxUVfijG+Gh+blJbgc6a8t6yOmjp29MOy8zog8uPbejyk1gzNO
 oGbTE6ijdH75At2DpZDnPgv6qKMPAhwhFVQw9pwWqfGJx5ex+0uHTK628SrH/Yr4RyaTP3Hk3Aw
 u9cxNCFWqkK1W+rhQozwr86WFsJ4b5F1sEOqMNxRemMUod0X95mmsU7wg5wc271vjZPrE5ZFcr9
 gfpyum6Ib1b9DmvnLvZw5GVtEHQh3vldsi7JyuXCkI+ptDpS67GvfhQYLU80kE7zbYLmKfuQN/L
 f3dTxjaR0CoFrN+9zcNOinx1sbGTZTpMyKquhYpyCgBSE4TuraRexyErcnZ7JfdCRp3eFAq9t2D
 GeCmJfMbFJWi/bpYx1Hl2cbe8
X-Received: by 2002:a05:600c:154b:b0:485:3cef:d6ea with SMTP id
 5b1f17b1804b1-4870f212c1emr4618155e9.13.1774285178512; 
 Mon, 23 Mar 2026 09:59:38 -0700 (PDT)
X-Received: by 2002:a05:600c:154b:b0:485:3cef:d6ea with SMTP id
 5b1f17b1804b1-4870f212c1emr4617805e9.13.1774285178102; 
 Mon, 23 Mar 2026 09:59:38 -0700 (PDT)
Received: from [192.168.0.65] ([78.16.129.161])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486ff1c16absm83521635e9.26.2026.03.23.09.59.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Mar 2026 09:59:37 -0700 (PDT)
Message-ID: <0b33ca24-dce4-47f2-aacd-cb0e9ecfd5d6@redhat.com>
Date: Mon, 23 Mar 2026 16:59:35 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] bus/fslmc: fix bus cleanup
To: David Marchand <david.marchand@redhat.com>, dev@dpdk.org
Cc: stable@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Rohit Raj <rohit.raj@nxp.com>
References: <20260323105306.1531689-1-david.marchand@redhat.com>
 <20260323105306.1531689-3-david.marchand@redhat.com>
From: Kevin Traynor <ktraynor@redhat.com>
Autocrypt: addr=ktraynor@redhat.com; keydata=
 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
In-Reply-To: <20260323105306.1531689-3-david.marchand@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: El1l6Ga9VeHR36qmuVnQo85EejyAzTOoa1Mu1FfGJ8s_1774285179
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
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

On 3/23/26 10:52 AM, David Marchand wrote:
> The close operation was never closing probed devices.
> 
> Taking a step back, reevaluating the devargs makes no sense during the
> close step, as a probed device must have passed the allow/block list
> evaluation initially.
> 
> Since the device contains a reference to the driver that probed it,
> simply call this driver remove op.
> 
> Fixes: 274fd921ff7f ("bus/fslmc: support close operation")
> Cc: stable@dpdk.org
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
>  drivers/bus/fslmc/fslmc_vfio.c | 21 ++++-----------------
>  1 file changed, 4 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/bus/fslmc/fslmc_vfio.c b/drivers/bus/fslmc/fslmc_vfio.c
> index 550d4e0e8d..7daa18d850 100644
> --- a/drivers/bus/fslmc/fslmc_vfio.c
> +++ b/drivers/bus/fslmc/fslmc_vfio.c
> @@ -1393,7 +1393,7 @@ fslmc_close_iodevices(struct rte_dpaa2_device *dev,
>  {
>  	struct rte_dpaa2_object *object = NULL;
>  	struct rte_dpaa2_driver *drv;
> -	int ret, probe_all;
> +	int ret;
>  
>  	switch (dev->dev_type) {
>  	case DPAA2_IO:
> @@ -1411,22 +1411,9 @@ fslmc_close_iodevices(struct rte_dpaa2_device *dev,
>  	case DPAA2_ETH:
>  	case DPAA2_CRYPTO:
>  	case DPAA2_QDMA:
> -		probe_all = rte_fslmc_bus.bus.conf.scan_mode !=
> -			    RTE_BUS_SCAN_ALLOWLIST;
> -		TAILQ_FOREACH(drv, &rte_fslmc_bus.driver_list, next) {
> -			if (drv->drv_type != dev->dev_type)
> -				continue;
> -			if (rte_dev_is_probed(&dev->device))
> -				continue;
> -			if (probe_all ||
> -			    (dev->device.devargs &&
> -			     dev->device.devargs->policy ==
> -			     RTE_DEV_ALLOWED)) {
> -				ret = drv->remove(dev);
> -				if (ret)
> -					DPAA2_BUS_ERR("Unable to remove");
> -			}
> -		}
> +		drv = dev->driver;
> +		if (drv && drv->remove && drv->remove(dev))

Not new but dpaa2_qdma_remove doesn't return an error which seems like a
bug, but it has it's own log and it's just a log here anyway, so not
critical.

> +			DPAA2_BUS_ERR("Unable to remove");
>  		break;
>  	default:
>  		break;

