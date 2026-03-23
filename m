Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B7BF483CC
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Mar 2026 16:59:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7961F4060C;
	Mon, 23 Mar 2026 17:59:48 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id A148A4025F
 for <dev@dpdk.org>; Mon, 23 Mar 2026 17:59:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774285186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=IxUfs2j05+I3uLo7L3ycajenh0nXTUdpCec3h8hTPgM=;
 b=SnPb779t33LW9N7nVXxU3t+T8DTb2uAWHXuxeoOfaPJktXMHViQApAG5WNXR7uCRQGy8zz
 KI5bvi6nc74rKVmTSUdwJgGG/As2ZbMBT8vS8Bb4C83vpEse9/qn69bfqJpKRUXXiHFgjb
 w1K+Uokd84T39L3yT3NxQmbXvOHKDfQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-UfjZD7qANnuL5-GFaG3e8w-1; Mon, 23 Mar 2026 12:59:44 -0400
X-MC-Unique: UfjZD7qANnuL5-GFaG3e8w-1
X-Mimecast-MFC-AGG-ID: UfjZD7qANnuL5-GFaG3e8w_1774285183
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4836abfc742so20664025e9.0
 for <dev@dpdk.org>; Mon, 23 Mar 2026 09:59:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774285183; x=1774889983;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IxUfs2j05+I3uLo7L3ycajenh0nXTUdpCec3h8hTPgM=;
 b=sfUwaMH+cAAIamnjvSxqKemmAaNWmCZkjqopZe/2T4rULU5OfTd6cpDYZwMdRq+Ckv
 KuAkLLCwgVzWvoDXPZSZUnzMiyJjS08xXKlNY0qZ7qAM1qAc4w1gdN1bgkrU53RaUA5Q
 pNqhmCP9Ev9NjMXTi4WVlMSVenTtE5Ie/P3gXHWAXKc/e+ORUfjR9RFaqDuxyanlzlgh
 qCLmuuDKf38+FGp2KrVpwc82d7Re0aXM2tsIQOGewF6U7UOjPdzzBt+RKsim9vfFo4pt
 nHmiGrtM83hZbg155Fr/4MfnCq/6pqHC9BI/hN6hN/Lai2er6l4TJtfJXoIz33Rgtq2L
 6fiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAryrMWt5viDHcb3VhlOdEGJp5Cx7GebcjkEy3bKcpK9VSdZ6keeojbbXlg5zWQImR4JU=@dpdk.org
X-Gm-Message-State: AOJu0YwnpdSQcf8CjhQ6XYm8JyYkFIbJ1kmHcQkEZl+E6mWddD6f/UFu
 qwNyucARBIxMmbnwrWKQUyT1UuzC0cnBwxPkk5dqQVcrNd5rI2jlz1Cefd/9uVKIVsnwF6qWYV0
 D/wqCR8K5yBJqjbXz44/ea+PUq89f/VRbgfPoZY8lmug5
X-Gm-Gg: ATEYQzw8+iKt3l59PXLt9HHMHwEh/H4MZ3Uz+35K3QRBmX2iYBlNrjSJt20qCXW29Tm
 w/7RBOl8RF/2juS0oi7Zcgbua+8wodDDg16mu5foC7kBV2Uu6TOLLtaHzIC80B1ddMtkgBj8hHd
 sr1nT7wmdKfZUq9fYxB5mNR3rBFaWWiVp9lzQvsH0MOV2fNWLew41FD6nuNSKcWAVUzzayn+1NT
 l7jM49khJoN/KKqNEe9kGKYbjcUQR3sk34PW7OAe0ADJEczMmlxlaGsyJlMlZh5zzplXYals7D0
 hHW4iFRmiOIZB4BJkk1w5khqreSZucLTJ0JIbXCF4oxLcF6BuLgdOS5Uy/s87q/+Xi38MJtQIWy
 RxX0rjPZgTEac8YbL0YzC7Atp
X-Received: by 2002:a05:600c:1f86:b0:483:1403:c47f with SMTP id
 5b1f17b1804b1-486febbc653mr189684895e9.6.1774285183215; 
 Mon, 23 Mar 2026 09:59:43 -0700 (PDT)
X-Received: by 2002:a05:600c:1f86:b0:483:1403:c47f with SMTP id
 5b1f17b1804b1-486febbc653mr189684405e9.6.1774285182699; 
 Mon, 23 Mar 2026 09:59:42 -0700 (PDT)
Received: from [192.168.0.65] ([78.16.129.161])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486ff1c16absm83521635e9.26.2026.03.23.09.59.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Mar 2026 09:59:41 -0700 (PDT)
Message-ID: <51f2b38e-ac0a-4b5f-ad64-ecbf9bdd523d@redhat.com>
Date: Mon, 23 Mar 2026 16:59:40 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] drivers/bus: require probe function for NXP drivers
To: David Marchand <david.marchand@redhat.com>, dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
References: <20260323105306.1531689-1-david.marchand@redhat.com>
 <20260323105306.1531689-4-david.marchand@redhat.com>
From: Kevin Traynor <ktraynor@redhat.com>
Autocrypt: addr=ktraynor@redhat.com; keydata=
 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
In-Reply-To: <20260323105306.1531689-4-david.marchand@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xeCYSz3uenKSl8Tsai_CJ1ajDa7ku0Ai01uebnUud6M_1774285183
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
> Rather than silently ignore an invalid driver, enforce every registered
> driver has a probe callback.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  drivers/bus/dpaa/dpaa_bus.c   | 6 +++---
>  drivers/bus/fslmc/fslmc_bus.c | 7 +------
>  2 files changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/bus/dpaa/dpaa_bus.c b/drivers/bus/dpaa/dpaa_bus.c
> index d9830b68ca..5e0f32bfe8 100644
> --- a/drivers/bus/dpaa/dpaa_bus.c
> +++ b/drivers/bus/dpaa/dpaa_bus.c
> @@ -614,6 +614,7 @@ void
>  rte_dpaa_driver_register(struct rte_dpaa_driver *driver)
>  {
>  	RTE_VERIFY(driver);
> +	RTE_VERIFY(driver->probe != NULL);
>  
>  	BUS_INIT_FUNC_TRACE();
>  
> @@ -808,9 +809,8 @@ rte_dpaa_bus_probe(void)
>  			if (rte_dev_is_probed(&dev->device))
>  				continue;
>  
> -			if (!drv->probe ||
> -			    (dev->device.devargs &&
> -			     dev->device.devargs->policy == RTE_DEV_BLOCKED))
> +			if (dev->device.devargs &&
> +			    dev->device.devargs->policy == RTE_DEV_BLOCKED)
>  				continue;
>  
>  			if (probe_all ||
> diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
> index abdb0ad50d..ac9fb7a08c 100644
> --- a/drivers/bus/fslmc/fslmc_bus.c
> +++ b/drivers/bus/fslmc/fslmc_bus.c
> @@ -465,9 +465,6 @@ rte_fslmc_probe(void)
>  			if (ret)
>  				continue;
>  
> -			if (!drv->probe)
> -				continue;
> -
>  			if (rte_dev_is_probed(&dev->device))
>  				continue;
>  
> @@ -534,6 +531,7 @@ void
>  rte_fslmc_driver_register(struct rte_dpaa2_driver *driver)
>  {
>  	RTE_VERIFY(driver);
> +	RTE_VERIFY(driver->probe != NULL);
>  
>  	TAILQ_INSERT_TAIL(&rte_fslmc_bus.driver_list, driver, next);
>  }
> @@ -601,9 +599,6 @@ fslmc_bus_plug(struct rte_device *rte_dev)
>  		if (ret)
>  			continue;
>  
> -		if (!drv->probe)
> -			continue;
> -
>  		if (rte_dev_is_probed(&dev->device))
>  			continue;
>  

Acked-by: Kevin Traynor <ktraynor@redhat.com>

