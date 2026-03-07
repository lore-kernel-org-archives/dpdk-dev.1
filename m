Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A86F55104
	for <dpdk-dev@archiver.kernel.org>; Sat,  7 Mar 2026 21:05:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AA2BD40041;
	Sat,  7 Mar 2026 22:05:24 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id BD6B64003C
 for <dev@dpdk.org>; Sat,  7 Mar 2026 22:05:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772917522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x0cFr2uhE93kR06FPis3Wq5u6KBGmSOVmy8e7KJhTj0=;
 b=DBBJY3aTb0W2DO3ktpcNUmZP6LhdwA8zV91dKRsLIgLrTT5mbRgnyCsbaTgJW5kUfN4BAP
 Ulm57f/ittEfEVx55Re+JEkq1H9hf8jJslJEdskYAlUpwnHlTjqe6IIk9OA8Vii/HkmXV2
 gKT8RquBJIbzeO6OIe31Upg/TkamZEg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-A7NiMUBrMg6k2kq8B48iyQ-1; Sat, 07 Mar 2026 16:05:21 -0500
X-MC-Unique: A7NiMUBrMg6k2kq8B48iyQ-1
X-Mimecast-MFC-AGG-ID: A7NiMUBrMg6k2kq8B48iyQ_1772917521
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-48071615686so91231865e9.1
 for <dev@dpdk.org>; Sat, 07 Mar 2026 13:05:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772917520; x=1773522320;
 h=in-reply-to:references:user-agent:from:cc:subject:to:message-id
 :date:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x0cFr2uhE93kR06FPis3Wq5u6KBGmSOVmy8e7KJhTj0=;
 b=vRezxrHRpz3F5EeT9wiRGy2OsZrG64J+Gm3FzgoyzxApwEdcTtSi5bp3ptiWwb9aAV
 SGUYvHOH0dvBEDtMThsDtMKdq4+jVfKMa/WTTPfLHbRSf1nohmMqseU/5J69yx2xZOIh
 T4QHDeDDYoZZkoAz37flZ4Owl61MDElbq8yhNPK2zmvVpFhMVjeFuTC+gK1qGFecOtib
 H/ZM589a7TsMgBxZOXFPy/TvfTo2FLf+DuEI/DRZgisizFmZ30r0v1BHOP0kDxyQIArx
 2r24TsZgd546bLqIA7y2vCHwKZViyRmksrOXRr4/Kf/WTHeSlX6Aeg9GtU7XsWKA6/cM
 CNZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXuJOsGNgmZssLyMjEYGQZ2v83UfsPAkKvsdYYo6LRicro+ZkawZtVsF2/Tp5i/FTf0x0=@dpdk.org
X-Gm-Message-State: AOJu0YxRQcAQpMoNUBd7KgQqo9sENIg6KxG4L35+AtLK+lZlglfqq+Q4
 6Q8ydrNBqqCJhUm0ax6nM7xyWFoMhUH0PC1e7kbz3DAW/0Pdxib3eJlgb0ZU4K1ekKoihyS1jUt
 g1+tOvZmpH22KOcXAAq3Kr9jgBDxCBnIsK0gQu5UkZCcdPerNS+Rq
X-Gm-Gg: ATEYQzwP6uBUB8DDqvMKEaTiJR6UNy9EDuSt+KPRfhBmJgOjgrx44C7MXhQJw0GP36G
 5fdY8m0ZyJnAt8WI5lyCOxis9Erb1DRFgTJraf51fpBIVO+fqTJmsFqtHlFA9E3L4EvW5uk5ImP
 Arbcdo38fs4/c51ZsOfQO6YWxvF0h05QPy6NDi0sU9VLQlxrfeRHafHVmjmJCWNulewRE3d5lCf
 D4D5LLYVXIOPKNJoVo/B0ggPTDdVyF9lNfq0b8fuL3rsLTof8mrMwzkl/+DyLrrTZDgszU9BWHI
 hRZrGwpZlRdGTyKpYnDJE3vMw2GDsHit6wRfkLsMIJKe2+CaMe9o/cJKQzbxZZXB9vyJM4Y7EIQ
 JV1QYJ8GoydTrn7mSmkrXpF1OV8zcmr7NQaz1ZxCPHCIalQ9d02edz0oJGH3yFRJ071M8qVBttw
 p0LN69
X-Received: by 2002:a05:600c:620b:b0:483:6d4e:9811 with SMTP id
 5b1f17b1804b1-4852696d451mr101881525e9.31.1772917520349; 
 Sat, 07 Mar 2026 13:05:20 -0800 (PST)
X-Received: by 2002:a05:600c:620b:b0:483:6d4e:9811 with SMTP id
 5b1f17b1804b1-4852696d451mr101881215e9.31.1772917519843; 
 Sat, 07 Mar 2026 13:05:19 -0800 (PST)
Received: from localhost (2a01cb00021ec0002fb5ec50e5a775d4.ipv6.abo.wanadoo.fr.
 [2a01:cb00:21e:c000:2fb5:ec50:e5a7:75d4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851fae02a8sm305729705e9.5.2026.03.07.13.05.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Mar 2026 13:05:19 -0800 (PST)
Mime-Version: 1.0
Date: Sat, 07 Mar 2026 22:05:18 +0100
Message-Id: <DGWUT4AD1G8Z.260Y1TBRNARJQ@redhat.com>
To: "David Marchand" <david.marchand@redhat.com>, <dev@dpdk.org>
Subject: Re: [RFC v3 7/7] eal: configure initial device probing
Cc: "Thomas Monjalon" <thomas@monjalon.net>, "Andrew Rybchenko"
 <andrew.rybchenko@oktetlabs.ru>
From: "Robin Jarry" <rjarry@redhat.com>
User-Agent: aerc/0.21.0-127-g39acbf663345
References: <20260225112922.3982104-1-david.marchand@redhat.com>
 <20260305164550.2067453-1-david.marchand@redhat.com>
 <20260305164550.2067453-8-david.marchand@redhat.com>
In-Reply-To: <20260305164550.2067453-8-david.marchand@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zNKc6g_HO1GEJr3I1tnyRW4GpqgpL_kGQEL8xMsGI2k_1772917521
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
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

David Marchand, Mar 05, 2026 at 17:45:
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
> ---
> Changes since RFC v2:
> - added -A short option alias as it seems intuitive to use with -a,
> - renamed option to --no-auto-probing (half Robin and half Thomas
>   suggestions),
> - made -A and -b conflicting options,
> - added opposite option in case an application wants an explicit behavior=
,
> - updated unit tests accordingly,
> - updated documentation (namely some detail on --vdev),
>
> Changes since RFC v1:
> - changed approach following Bruce suggestion,
>
> ---

Hey David,

thanks, LGTM.

Reviewed-by: Robin Jarry <rjarry@redhat.com>

