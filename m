Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4B1606A31A
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 11:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=doa50NMq
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E0F3C40270;
	Tue, 20 Oct 2026 13:22:47 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id D177740144
 for <dev@dpdk.org>; Tue, 20 Oct 2026 13:22:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792495365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8OYvQGERqmV1TRkDcsclqlK8zjKNDkV9i1SYlk5WBDY=;
 b=doa50NMqmByb8/MK83QC2PihAc2kLwBDiib7XVItx022o9Bmwdcxhl0UJyFBYl4tNVCXDM
 zkolxWsxVpZ+MGqnoOXK+LTLQvIyULe2SXDBbe9/1p56JHfG8oq+FY9VjWZSJz0zhd6qPY
 IdXgu5O65UVKt7Rb/nsHFdXp+puH0UA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-qUorSXlfPUeraY9cQITZnQ-1; Tue, 20 Oct 2026 11:22:44 +0000
X-MC-Unique: qUorSXlfPUeraY9cQITZnQ-1
X-Mimecast-MFC-AGG-ID: qUorSXlfPUeraY9cQITZnQ_1792495363
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4a16faefac0so19015075e9.0
 for <dev@dpdk.org>; Tue, 20 Oct 2026 04:22:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792495363; x=1793100163;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8OYvQGERqmV1TRkDcsclqlK8zjKNDkV9i1SYlk5WBDY=;
 b=27X8exZ6Qbidp8iClsO4eTJe4KOGzhXu7hSA62oxRve5PL29vTQI6BgL5SwEawrQ1/
 2ZPfQK3MpxAWGz9vILrHcOLUcqD4SWuO2xjQHBPUt5mNl97JRg2Gp+MV28MLNI1hdGlf
 +Oderm+KpeQIbmx4JqCHLaS4tNyokhVypexEePIUT1I0+7npgl+SHFQRQQicb2mj9+Xd
 Rh/eSzBz6Ki8HifDtsOuaNgVkMF5M3UBD5w5pusCsbPgCpokGCOw6JtemQuD/MT3kDgY
 RbU1S5W49YnOetwedQ2gVL0Ra/4vaQjXswAqI24LHQMj0KAQRLC0VokwKVmtMBM20fqc
 p0DQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByugcWyLi23Qu5q/c6NASPGvcEVZ7vrDAQ2s+U51BGhvHtiF5PZiO5IZT5hDOcBD7h6nYY=@dpdk.org
X-Gm-Message-State: AFq9FYL2t0XFPS0hXJf5wn5D1j/V1LrgkUSjdg3U/sW3P7+H4ceT+7/v
 upJzWWma2Xp0i3vFqeHrf+fH5nkLqEEuD+BNzNqnaH3vw1yCItPTU+O0wCY4T6nm2WC1OpyfGv0
 XkXiiYF7+DJq6zznUW6uZ5ha3895j33BXKebRiEqGDs6W
X-Gm-Gg: AYBFou3bfyWfWgdhfD8YZ718PMxGeTvJg3qnozESiGZlm9ixjWgiYqkV7RDPCEtRDKG
 NnB8OzrX/YfX4JXN7cqJhB2w5eMGm9yd57XD7m9q10qUnma/S+QDDhyF7c9TPxvz0TielsutXN6
 iyPsCtgopSDOs2Fxh9nLvhbouqta37em0EhRJV+hbWmky8ag6MoYEpd7AgwaLrYf86paq7fvw1E
 ahIZzZqiNsRLFhE7W/AajpYasHgnJ2uzcDH/NQPDUhC18MPTzy1/tDdp9RSQL20gjXUFqVzDzd5
 wbC8TNtxldhUOyfjj27SfdiJe/yUT48fl8PKeSoD0q81l75HC8YJAVKGmYX2T2+lmbgc0aSSBoV
 WVaqsz5/WDpljKKyRvxM9SxPU47FDuzw/NA6r8+0xaM58i+zo4ZG5peEiQL91CP1iAr/btltrdY
 VBsTL0J3z4IP08hnRRe4gIva8qCGsZaNJ8Owvr55uS913xAKYG9rMSvNTxOx7H4YCDp4T80aHg8
 eKmZGqiRo1q17gQhAPZn3dDhg==
X-Received: by 2002:a05:600c:63cb:b0:49f:ce72:e931 with SMTP id
 5b1f17b1804b1-4a1d76356c9mr157729045e9.35.1792495362781; 
 Tue, 20 Oct 2026 04:22:42 -0700 (PDT)
X-Received: by 2002:a05:600c:63cb:b0:49f:ce72:e931 with SMTP id
 5b1f17b1804b1-4a1d76356c9mr157728655e9.35.1792495362275; 
 Tue, 20 Oct 2026 04:22:42 -0700 (PDT)
Received: from [10.50.0.132] (82-66-145-51.subs.proxad.net. [82.66.145.51])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f69d9b1esm41003195e9.7.2026.10.20.04.22.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 04:22:41 -0700 (PDT)
Message-ID: <bd27c796-7986-407c-b1d1-05eb376ed2fe@redhat.com>
Date: Tue, 20 Oct 2026 13:22:40 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vhost: make cryptodev support optional
To: David Marchand <david.marchand@redhat.com>, dev@dpdk.org
Cc: gmuthukrishn@marvell.com, gakhil@marvell.com,
 Chenbo Xia <chenbox@nvidia.com>
References: <20261014163138.1639970-1-david.marchand@redhat.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
In-Reply-To: <20261014163138.1639970-1-david.marchand@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LfEfnn7r_ts90mY__ltbhTCmDXDFkMILKSu2QUET5cI_1792495363
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 10/14/26 6:31 PM, David Marchand wrote:
> The vhost crypto part has seen CVEs in the past and is getting a lot of
> eyes those days.
>
> Contrary to the vhost async datapath code, the cryptodev code seems to
> have active contributors, so dropping this code does not seem a good
> thing.
>
> This change here allows to keep this support, yet disable it for
> uninterested parties.
>
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
>   lib/vhost/meson.build | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/lib/vhost/meson.build b/lib/vhost/meson.build
> index 6a24981d10..93366a9609 100644
> --- a/lib/vhost/meson.build
> +++ b/lib/vhost/meson.build
> @@ -30,7 +30,6 @@ sources = files(
>           'vdpa.c',
>           'vduse.c',
>           'vhost.c',
> -        'vhost_crypto.c',
>           'vhost_user.c',
>           'virtio_net.c',
>           'virtio_net_ctrl.c',
> @@ -39,9 +38,14 @@ headers = files(
>           'rte_vdpa.h',
>           'rte_vhost.h',
>           'rte_vhost_async.h',
> -        'rte_vhost_crypto.h',
>   )
>   driver_sdk_headers = files(
>           'vdpa_driver.h',
>   )
> -deps += ['ethdev', 'cryptodev', 'hash', 'pci', 'dmadev']
> +deps += ['ethdev', 'pci', 'dmadev']
> +
> +if dpdk_conf.has('RTE_LIB_CRYPTODEV')
> +    sources += files('vhost_crypto.c')
> +    headers += files('rte_vhost_crypto.h')
> +    deps += ['cryptodev', 'hash']
> +endif

Reviewed-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Thanks,

Maxime

