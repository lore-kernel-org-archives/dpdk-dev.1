Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE79710A1E81
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Mar 2026 11:52:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E4B9E40E1E;
	Thu, 26 Mar 2026 12:52:39 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id D31B94069F
 for <dev@dpdk.org>; Thu, 26 Mar 2026 12:52:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774525957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=pvHsz4f0/dxto2S1aFwlPsaJ5cq92z9wq4TAgP9JUYk=;
 b=LIETJ5x0KaEhvrJHF1ogKsGm+zBZGZK4vvS0aGFMgZcmVwn9arIVYaX9HPoDHvD/lCcth7
 q00AiNU8splgNXl1pwQljBK4TT60Kg7MJJqjFwFowaTqWUCBltxUknfLKncUpc/8i5C1LT
 0IorAbfSXim5BvzLaicUHN5LgJOQYbo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-pqfgp2zwMgOw2KSQaUfh7g-1; Thu, 26 Mar 2026 07:52:36 -0400
X-MC-Unique: pqfgp2zwMgOw2KSQaUfh7g-1
X-Mimecast-MFC-AGG-ID: pqfgp2zwMgOw2KSQaUfh7g_1774525955
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-486fe36cf73so9937685e9.1
 for <dev@dpdk.org>; Thu, 26 Mar 2026 04:52:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774525955; x=1775130755;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pvHsz4f0/dxto2S1aFwlPsaJ5cq92z9wq4TAgP9JUYk=;
 b=IUrWQTjnaDEoNAjvsR8bm9oHm4CzDXhLyHPObgiYpJcx57DGMzXGTRQJLMPQFCkoNw
 IHcj1MlBUV7KF4XYEdiDnp7YWFeoJFNtbGIIwgdCgWiyQJLa+GBzsKKE5eH9wOdurC6n
 eMrW4wTPVI/HcobfYB+VdQtD5LPCAq7i/nubqJkHxCILkZt01dYlXKoDC3Bwtx+eZTQb
 PMS60r2locs/3lmIGzMf21RYTfi/Xp3n9rln9XIAUMyM0KDQI9Ukt8LDAKwXpAChiuLI
 iPBs6OnlSGNW7XyParpluu+Ta+TgavdCfRYg1iGRQtrvJ8xpUWhV00opz2imCs88tIgD
 M/9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmyDCxY1Ron0ZPDdy6dtU/12u969pRVtQjKm/ta8oZO90k7CWjbxt+HTnbtWS/Y9AP4yE=@dpdk.org
X-Gm-Message-State: AOJu0Ywv3CGmVxdZ3aH4opZ7BiADlr5kKfHTvTep4WYIeHg4lX47/Fa1
 A7E2dwb9DoGemK1/Lk89rRn1vFjmZN7+iwwlZp1LL76ppjaTqrfyHCV9kc8UpGW3rIqaI7jEqlE
 qg7c4zBVbUfSF+rXZPbU9q8QN0Ozz7Db2UEbQ6t7cyB5g
X-Gm-Gg: ATEYQzwjJLfwBTXgiZOtVkrO/1N8GR5bOql+01RmSwVZOC/tjxDduxIAnNl7ejCEGT7
 NR5n9QqEk4FnLC2Al1G0Ffub3NdvcYLOp0hcxDyRZyGo3Pkifyqm547YMI1VOQOLnw32NofDfmM
 ozszAjUDQkRY0NqFSBGkk2WuS1w9pf56FGlqNWkbSvifHEqVxHQ04NOJEoenlnpxDmPvwhPygNs
 s4SzDqethUZ5/XCFVrOyKaLckbt66XOTdwBKgpFOvKur91k1b8c8CRnIyLb8fj+wkhtFTDpPhOY
 BIWgGENRjss5hwxffjU19qsLd0y8Q+0ntdZ3YzHbvNrmFcgYfJZjHKoF+8qW4jxWnkXMCeElbVK
 EkJX/jagPLXh79PDKNlRW7iRW
X-Received: by 2002:a05:600c:6287:b0:479:1b0f:dfff with SMTP id
 5b1f17b1804b1-48715fd545bmr109754815e9.10.1774525954751; 
 Thu, 26 Mar 2026 04:52:34 -0700 (PDT)
X-Received: by 2002:a05:600c:6287:b0:479:1b0f:dfff with SMTP id
 5b1f17b1804b1-48715fd545bmr109754255e9.10.1774525954271; 
 Thu, 26 Mar 2026 04:52:34 -0700 (PDT)
Received: from [192.168.0.65] ([78.16.129.161])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-487208ca5b0sm47823485e9.2.2026.03.26.04.52.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Mar 2026 04:52:33 -0700 (PDT)
Message-ID: <d0bd0f6e-0cd9-4c77-b9a2-d814f9db4a8a@redhat.com>
Date: Thu, 26 Mar 2026 11:52:31 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] bus: factorize device selection
To: David Marchand <david.marchand@redhat.com>, dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Robin Jarry <rjarry@redhat.com>, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Maxime Leroy <maxime@leroys.fr>, Parav Pandit <parav@nvidia.com>,
 Xueming Li <xuemingl@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>,
 Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Chenbo Xia <chenbox@nvidia.com>,
 Tomasz Duszynski <tduszynski@marvell.com>,
 Chengwen Feng <fengchengwen@huawei.com>, Long Li <longli@microsoft.com>,
 Wei Hu <weh@microsoft.com>, Kevin Laatz <kevin.laatz@intel.com>
References: <20260323105306.1531689-1-david.marchand@redhat.com>
 <20260326102424.2361945-1-david.marchand@redhat.com>
 <20260326102424.2361945-7-david.marchand@redhat.com>
From: Kevin Traynor <ktraynor@redhat.com>
Autocrypt: addr=ktraynor@redhat.com; keydata=
 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
In-Reply-To: <20260326102424.2361945-7-david.marchand@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: srJGvZqhycDcp7bbHUEsYUKPOroSCD_T_HJQlW4ntIM_1774525955
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

On 3/26/26 10:24 AM, David Marchand wrote:
> All buses (thankfully) implement the same logic when it comes to
> selecting the devices to probe based on -a/-b options.
> As we want to adjust how devices are selected, provide a common helper
> in EAL and use it in the buses.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> Reviewed-by: Robin Jarry <rjarry@redhat.com>
> Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
> Tested-by: Maxime Leroy <maxime@leroys.fr>
> ---
> Changes since v1:
> - fixed device selection in dma/idxd,
> 
> Changes since RFC v2:
> - changed API to query about a device name and hide the devargs meaning
>   in the common code,
> 
> ---
>  drivers/bus/auxiliary/auxiliary_common.c | 19 ----------------
>  drivers/bus/auxiliary/linux/auxiliary.c  |  2 +-
>  drivers/bus/auxiliary/private.h          |  6 -----
>  drivers/bus/cdx/cdx.c                    | 21 +-----------------
>  drivers/bus/dpaa/dpaa_bus.c              | 24 ++++++--------------
>  drivers/bus/fslmc/fslmc_bus.c            | 22 ++++++-------------
>  drivers/bus/pci/bsd/pci.c                |  5 ++++-
>  drivers/bus/pci/linux/pci.c              |  2 +-
>  drivers/bus/pci/pci_common.c             | 23 -------------------
>  drivers/bus/pci/private.h                | 11 ----------
>  drivers/bus/pci/windows/pci.c            |  4 +++-
>  drivers/bus/platform/platform.c          | 28 ++----------------------
>  drivers/bus/uacce/uacce.c                | 22 +------------------
>  drivers/bus/vmbus/vmbus_common.c         | 25 +--------------------
>  drivers/dma/idxd/idxd_bus.c              |  8 ++-----
>  lib/eal/common/eal_common_bus.c          | 19 ++++++++++++++++
>  lib/eal/include/bus_driver.h             |  6 +++++
>  17 files changed, 55 insertions(+), 192 deletions(-)

Acked-by: Kevin Traynor <ktraynor@redhat.com>

