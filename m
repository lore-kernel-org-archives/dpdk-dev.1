Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF94103A9A8
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 10:57:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3B795402CE;
	Wed, 25 Mar 2026 11:57:40 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 063384028E
 for <dev@dpdk.org>; Wed, 25 Mar 2026 11:57:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774436258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=q5C5UkfhyyX1O9Fui90ofgfVDR53e84kHn/fMph08sg=;
 b=PjswKA9+td/j741+FVavUHX7kpCZ/v3tg6pO6kmh7hTDLGYUEclfBnaXnepOZgBNrZHfNU
 F6h80HYvf2LdYhqw75zFcdyEXVcvyuZ93YSnnTc8vSAQG8Plo3HVXqXhyg92imPna1v/DC
 2VO/7rfJTFCTXa12JJPT/X+iCQDgzZM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-M0FoH1QVMP-X_ONKGMNxug-1; Wed, 25 Mar 2026 06:57:34 -0400
X-MC-Unique: M0FoH1QVMP-X_ONKGMNxug-1
X-Mimecast-MFC-AGG-ID: M0FoH1QVMP-X_ONKGMNxug_1774436254
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-439c54e0f6aso614520f8f.0
 for <dev@dpdk.org>; Wed, 25 Mar 2026 03:57:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774436254; x=1775041054;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q5C5UkfhyyX1O9Fui90ofgfVDR53e84kHn/fMph08sg=;
 b=VfBEnGjAmFLv5YdeKBCiZUmZDFe96m9Y6kGTPs2n5KVS0uCgv1KcK/KRbSJweXSSV+
 tNjsSC1avKcR7hisUUaZA9lKcWNfZ3yxwQevQBqybAq18rJT29hVo5gIZWUJmbNBcYbT
 wVTaFU8U3nvDBzX1+3gxnTrDXbxBrrQDrZXlmpRhnA/zEKfJ0hvkl/52l6GGZkan8niI
 SwmMOwWtNxyqp9IKmWjVIpU3O50HThTp8ukF8LSn3THYh90RmX+VxH44zoQsUzbhXlvx
 lNF4XSZOO95UlkU5Jx/Y5j+LRBXTR1x4hvjyb1kZ1UFcgi/W+NGZ37NPW4YOqJaex/yR
 KMBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkak7xzuT6v/4yQzarYxAboj7Fhcxv4Z1wxj8owamEQIwZiGzQIEmPEvW4zZLi0Ngv+7c=@dpdk.org
X-Gm-Message-State: AOJu0YwIMA059xAfvffBkpDqhp6cuNBfqIiWZPsipeZI1k/Nj6kRv50P
 nm2Et/0AFRe0J5xGGIxF+A4MXOdyiSB/p+5WgUBB7yNzG/wGxuUA5Dk4kSNIcxkHr31GuLHwmSA
 tHNBGGjscBv+LTcdhh679wD4vWsjHUAb7pyIfskAA9mXc
X-Gm-Gg: ATEYQzwEtBAPR0uFEZE9JIMpTXfuuckuj/BqO6vgT+vaBqtpFNA498PyURwGDHkRQ34
 GG3qZ0ZEi9yfsNMY+JNiipvXd3YR6yb/ZmAAAx+o1OaGEFHL4RdCAgkXxCKVrVs/GhnlMNYorwT
 8xZgmWJQwYMJBSDXzcQHNd01Tfi2GwxAf0XDVEvE7qW+vvGTRL3LNgKFcebzgKqqBZmrXd7zIui
 k2xS7j18ADPptp1YXUX1qIb1aQCNzNBeOLV+zVIAEYuxwLbLNddZ0zCnElhj9/Yi4PFKBPAdMST
 KuU0v/ycZC6JQmb9VQVTqEnLaDJGDBCZh0R4i4ZP3/uPpEtaNNo1R2sE34RWQXxytYZaAWidXfS
 R8+g/lKjfna0wJywqWA35XJVc
X-Received: by 2002:a05:6000:612:b0:43b:63d9:6360 with SMTP id
 ffacd0b85a97d-43b883c8843mr5233584f8f.20.1774436253618; 
 Wed, 25 Mar 2026 03:57:33 -0700 (PDT)
X-Received: by 2002:a05:6000:612:b0:43b:63d9:6360 with SMTP id
 ffacd0b85a97d-43b883c8843mr5233512f8f.20.1774436253042; 
 Wed, 25 Mar 2026 03:57:33 -0700 (PDT)
Received: from [192.168.0.65] ([78.16.129.161])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b64714e2esm49189985f8f.32.2026.03.25.03.57.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2026 03:57:32 -0700 (PDT)
Message-ID: <a1cc78fc-1ac6-4a1e-a319-f1b2467f1174@redhat.com>
Date: Wed, 25 Mar 2026 10:57:29 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] eal: configure initial device probing
To: David Marchand <david.marchand@redhat.com>, dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Robin Jarry <rjarry@redhat.com>, Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
References: <20260323105306.1531689-1-david.marchand@redhat.com>
 <20260323105306.1531689-9-david.marchand@redhat.com>
From: Kevin Traynor <ktraynor@redhat.com>
Autocrypt: addr=ktraynor@redhat.com; keydata=
 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
In-Reply-To: <20260323105306.1531689-9-david.marchand@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bw0qnfdKZiRiu0ELwgdwUmCgV8YVoePlWApqFarJaAM_1774436254
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

On 3/23/26 10:53 AM, David Marchand wrote:
> Some applications use port hotplug as their primary way for using DPDK
> resources.
> Having a systematic device probing is a problem when not all available
> resources will be used by the application, as such applications won't set
> an explicit allow list at startup.
> 
> This is the case for OVS on systems with multiple mlx5 devices:
> one device can be used by the kernel while the other(s) are used by DPDK.
> In such a setup, the kernel used device may get reconfigured in
> unexpected ways and trigger issues like the one described by Kevin
> not so long ago in bugzilla 1873.
> 
> Add an EAL option so that we can change the default behavior from
> block-listing to allow-listing which can be summed up as disabling
> automatic probing.
> In case some applications want to require automatic probing, add the
> opposite option.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> Reviewed-by: Robin Jarry <rjarry@redhat.com>
> ---
> Changes since RFC v2:
> - added -A short option alias as it seems intuitive to use with -a,

nit: I think I would have said '-B' as it's not allowing anything and
it's equivalent of adding a -b for all devices, but let's not bike shed
on it :-)

> - renamed option to --no-auto-probing (half Robin and half Thomas
>   suggestions),
> - made -A and -b conflicting options,
> - added opposite option in case an application wants an explicit behavior,
> - updated unit tests accordingly,
> - updated documentation (namely some detail on --vdev),
> 
> Changes since RFC v1:
> - changed approach following Bruce suggestion,
> 
> ---
>  app/test/test_eal_flags.c                 | 63 +++++++++++++++++++++++
>  devtools/test-null.sh                     |  2 +-
>  doc/guides/linux_gsg/eal_args.include.rst | 13 +++++
>  lib/eal/common/eal_common_bus.c           | 17 +++---
>  lib/eal/common/eal_common_options.c       | 10 ++++
>  lib/eal/common/eal_internal_cfg.h         |  1 +
>  lib/eal/common/eal_option_list.h          |  2 +
>  7 files changed, 101 insertions(+), 7 deletions(-)
> 

LGTM

Acked-by: Kevin Traynor <ktraynor@redhat.com>

