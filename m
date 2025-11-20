Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB23CF9C72
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Nov 2025 17:08:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B8D8E402D1;
	Thu, 20 Nov 2025 18:08:25 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id D815C4026F
 for <dev@dpdk.org>; Thu, 20 Nov 2025 18:08:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763658503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=fRvPrHgQvSCgaqbxqe8waJXjUtMG4Gebxw2m3eQT87g=;
 b=RetXYRNaOzhIEjQq26Xs1RVFG6RLEnm4qjmpQyGRBOcpXb76ONcmDb3Df5u8c/QmVAcZoO
 LnuFK3UOSZp0qgopd7SxRKy+4tYyu1Aw3vSkA2+JhBnCJNxxF8rk6i3jqNXMSYXAc9t/J9
 GuJBD7j2NuiKyyKvebkc+wZOykcTSe8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-nBgVPWndP1SHaBdfkonCeA-1; Thu, 20 Nov 2025 12:08:21 -0500
X-MC-Unique: nBgVPWndP1SHaBdfkonCeA-1
X-Mimecast-MFC-AGG-ID: nBgVPWndP1SHaBdfkonCeA_1763658500
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4779b3749a8so9907605e9.1
 for <dev@dpdk.org>; Thu, 20 Nov 2025 09:08:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763658500; x=1764263300;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fRvPrHgQvSCgaqbxqe8waJXjUtMG4Gebxw2m3eQT87g=;
 b=ZcoJxM4CxLYPq0UJYYyAAdk8ukghKjzFPBg3fPA6xkYPksB8/libsq6Wkii1ytXMt7
 zZrDmyal3YN1tao2qy0ffk1RoPalBfQWOqBYwAnVXcO4c01TN3q04D1IrJ0+fTU39Dng
 m5SyaRgJzsR7DwkTUfv+qOl09PrsvRRedoW0xspxHHURDRbTdz/ha435/MdviyTi1U/y
 7YNjEu88mZ1tEI6PKg66X+dt7ObBcX0Lfiu52Y6VXbIj0OF4BhAmbSC2iDaJzkZngkEj
 lcWyGHzaMj1+SMhFnfawKLUAxe+YWMm6HErVx/I7nCndFJ8urM1k5xNZZUmrDVKqJS/d
 gONw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqzOEaPIz4YVcPzgYUepFYpScTXos3aybTLh9fykkizsZdmvGyToGxlUSxizPGpjVLuCA=@dpdk.org
X-Gm-Message-State: AOJu0Yzw4P7/XyP9h0AIbpB/n8XeCPq/OJZAuHORQPXisf+NQ7rn4jLT
 qQuMCt4XyJeoT0TQaHMHvPSlnjikKAKYYf0fEqbRKmASRt+el/BXalObUEmvhPfZ+GxlDwL70Hr
 5ABe9FLfHKmyjOYqKhXypcIGmy89L1bFtpMl1mLuukAHv
X-Gm-Gg: ASbGncteEiT5GDMGhbtCACfRBBvWQG3MNEw8BtK96sRq5SgLCezCR/9OBcFBggrqGEU
 IPpqW7uU0Kj+3PtMA4dxjXPIfA91U5XzJD12l/Bk39SShf8vkx+ml9vb6smP7OLngai4iBxyVfa
 dpFIVDFSGv0y3DgB5GXso115dCcUfpUPddE2RFrGF8P1k35ju63PhAc2hfHT9BB10O9Hvp88EsZ
 QqcP0B6BkgUyctinVxa/5+5A/Sy1xmE122hX7ysGau3L8nCSkTq8eq4R6WWJqwkgXFXSmQppKXV
 GQZtJIig0Cn/qRVjA1QdaqlQptOW88BVFRIKcHte+CYKlOI09WYB1JrHf4yLKd+7aHqWcBnuHZc
 KAQmjWN8DO9ln
X-Received: by 2002:a05:600c:3553:b0:477:55ce:f3c3 with SMTP id
 5b1f17b1804b1-477babc1f61mr26373925e9.5.1763658500024; 
 Thu, 20 Nov 2025 09:08:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEaj1f3zedRE0GjUR/BJwslJBh1kiJyN3G1KdzrfJcFy8xyAWy6y8abiWtEH+01Bf2/B+7fAw==
X-Received: by 2002:a05:600c:3553:b0:477:55ce:f3c3 with SMTP id
 5b1f17b1804b1-477babc1f61mr26373545e9.5.1763658499578; 
 Thu, 20 Nov 2025 09:08:19 -0800 (PST)
Received: from [192.168.0.56] ([78.16.128.110])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477b1076865sm116843885e9.13.2025.11.20.09.08.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Nov 2025 09:08:18 -0800 (PST)
Message-ID: <2da88441-307a-4287-8387-d1906edf3755@redhat.com>
Date: Thu, 20 Nov 2025 17:08:17 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] net/mlx5: release representor interrupt handler
To: Bing Zhao <bingz@nvidia.com>, viacheslavo@nvidia.com, dev@dpdk.org,
 rasland@nvidia.com
Cc: orika@nvidia.com, dsosnowski@nvidia.com, suanmingm@nvidia.com,
 matan@nvidia.com, thomas@monjalon.net, Roi Dayan <roid@nvidia.com>,
 xuemingl@nvidia.com, Shani Peretz <shperetz@nvidia.com>
References: <20251112074015.8901-1-bingz@nvidia.com>
From: Kevin Traynor <ktraynor@redhat.com>
Autocrypt: addr=ktraynor@redhat.com; keydata=
 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
In-Reply-To: <20251112074015.8901-1-bingz@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ABeGJ91v-GxXCAAr-3GEfXFz5mwtDSWHfhmPp4-pxwo_1763658500
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

On 12/11/2025 07:40, Bing Zhao wrote:
> From: Roi Dayan <roid@nvidia.com>
> 
> Looks like commit the cited commit removed the representor
> interrupt handler cleanup by mistake. Fix it.
> 
> Fixes: 5cf0707fc7e9 ("net/mlx5: remove Rx queue data list from device")
> Cc: xuemingl@nvidia.com
> 

Hi,

Some of this series (see below) is fixing issues in older releases, but
does not include stable tag to indicate the fixes should be backported.

Just checking if this is deliberate, or an oversight and they should be
backported ?

thanks,
Kevin.

25.11 dbaed15366 - F net/mlx5: release representor interrupt handler
(Fixes issue in 21.11)

25.11 aef94343d3 - F common/mlx5: release unused mempool entries (Fixes
issue in  21.11 (partially fixed in 8947eebc999e @ 21.11))

25.11 8d1fe10768 - F net/mlx5/hws: fix buddy memory allocation (Fixes
issue in 22.11)


> Signed-off-by: Roi Dayan <roid@nvidia.com>
> ---
>  drivers/net/mlx5/mlx5.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/net/mlx5/mlx5.c b/drivers/net/mlx5/mlx5.c
> index 666216c21a..591420c77f 100644
> --- a/drivers/net/mlx5/mlx5.c
> +++ b/drivers/net/mlx5/mlx5.c
> @@ -2389,6 +2389,11 @@ mlx5_dev_close(struct rte_eth_dev *dev)
>  	/* Free the eCPRI flex parser resource. */
>  	mlx5_flex_parser_ecpri_release(dev);
>  	mlx5_flex_item_port_cleanup(dev);
> +	if (priv->representor) {
> +		/* Each representor has a dedicated interrupts handler */
> +		rte_intr_instance_free(dev->intr_handle);
> +		dev->intr_handle = NULL;
> +	}
>  	mlx5_indirect_list_handles_release(dev);
>  #ifdef HAVE_MLX5_HWS_SUPPORT
>  	mlx5_nta_sample_context_free(dev);

