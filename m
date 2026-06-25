Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E951CDB466
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 07:39:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 08C3740280;
	Thu, 25 Jun 2026 09:39:00 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 3D7174025F
 for <dev@dpdk.org>; Thu, 25 Jun 2026 09:38:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782373137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZuTxCze+QjjQI97OeLbWBVsqHUD+XV7olBbzfHz5Y7A=;
 b=KeKoyCzMUhIb+q7EFszkSN5Rl29WVQHVH63ui1H0xVCaxKzqfv9aKSQlncHq+Ln7Z4KOFt
 k51I9L+WLZ8vMV3W79wA6l27Snt8iuyiKiwgVSMYWlyW5T692lwbcpxl+y/pM/qjT7ZhYy
 jmRLCW8DJOg++hSMx5N3XyO5LRhG5UY=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-2z8_b_ZnN8yMjAdpn0Z16w-1; Thu, 25 Jun 2026 03:38:56 -0400
X-MC-Unique: 2z8_b_ZnN8yMjAdpn0Z16w-1
X-Mimecast-MFC-AGG-ID: 2z8_b_ZnN8yMjAdpn0Z16w_1782373134
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5ad62ce7c15so1045951e87.0
 for <dev@dpdk.org>; Thu, 25 Jun 2026 00:38:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782373134; x=1782977934;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZuTxCze+QjjQI97OeLbWBVsqHUD+XV7olBbzfHz5Y7A=;
 b=pSULowax/RcmhnsQPd6FHvmqJeyclyPG0MUbV/YcWaGwH4yjdIGXuj25N1JncqTTLP
 FOPKxwTSgoJ807B8xtqi6dGxNJTSL+dvBtzdl8eByRYGY6yL4BWDFA9lVFV679wnt0AT
 q2Vm5iWCq50CiqbeNbPLi7JVxJRGrTvC0AqaJn0Z4pXDjnpCPHlbz0urfzBuhaH6RkE0
 oAKNnbojFY3N0QF40rValrE7evQN07iBff0OTt/YulA8MmqPG1kj2LkOctq+IuRGz+gu
 QQkttYdZaprhOqxGvkRjeegm4xEvYEYPl1X+wiGFAT4necTXC6zht6zLbPGk4BndQHNQ
 hYug==
X-Gm-Message-State: AOJu0YyRuZcZtFYluK2Mf1tTbSLd5y9Bt7znKIs57TFUfogA1rT4bC04
 QvWdS9N5NWnbnz54Z0rbI+M1oAJJWoe9du4mt1YDiOeGlT/PhT23vzpWw6oxZP9iqlvH8duXGHb
 RaPL1F9/78siIxP4UqI4JPyrCavlqVeIRb4qtfBP3e+CzthKsNrLYCGEqaZBjGfimZVE1ck2tKR
 kaZdfAeRx/IdKvmuBXjFU=
X-Gm-Gg: AfdE7cm8uVWhBb21iAFJI5MTblx0DmtCZ3t6NHXHZWJpy6YbmVHjFD9dr2xxhmp6GCZ
 jYOnel3pHPXcwcVYObWc9CoKur867GAj3lLuz4dmNqMmHPBC3LZGhkA69o/3OwEEJk8Olq15hp7
 ZCP9okp5s18O7jl/gJLcQgeuehoW5PCQTi6h1OxFdD0Bwmcex10RONQmHiYFCp7zty2a3a+VW7X
 I/LliG5aAZAwZiSyD0+HxTtCgyNFXxYpcLbdxwTClNrpLVIu5iGcqpumVE=
X-Received: by 2002:a05:6512:a8d:b0:5aa:6641:c45c with SMTP id
 2adb3069b0e04-5aea1f2ed68mr458533e87.18.1782373134413; 
 Thu, 25 Jun 2026 00:38:54 -0700 (PDT)
X-Received: by 2002:a05:6512:a8d:b0:5aa:6641:c45c with SMTP id
 2adb3069b0e04-5aea1f2ed68mr458521e87.18.1782373133885; Thu, 25 Jun 2026
 00:38:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260623113752.1100072-1-dsosnowski@nvidia.com>
 <20260624131337.1127323-1-dsosnowski@nvidia.com>
 <20260624131337.1127323-3-dsosnowski@nvidia.com>
In-Reply-To: <20260624131337.1127323-3-dsosnowski@nvidia.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 25 Jun 2026 09:38:41 +0200
X-Gm-Features: AVVi8Cd9BDgY6gmFw0ymShdNHgeYjZ5LeaUEtWZkUIKiaGgguN3iAJpTCUHQ1F0
Message-ID: <CAJFAV8xDOvg_DSLj8Ah1agTGSLxk1sn12_cw_7wbCv86J4KvUA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] build: support function versioning for drivers
To: Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Yu Jiang <yux.jiang@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8mvaQ45dvg2VP-u1ozR8bIG2Mpbu0uGBq7fM4rPymzo_1782373134
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Wed, 24 Jun 2026 at 15:15, Dariusz Sosnowski <dsosnowski@nvidia.com> wrote:
>
> Add support for enabling function versioning
> (through use_function_versioning meson variable) for drivers,
> similar to libraries.
>
> Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> ---
>  drivers/meson.build | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/meson.build b/drivers/meson.build
> index 4d95604ecd..a63d93372a 100644
> --- a/drivers/meson.build
> +++ b/drivers/meson.build
> @@ -171,6 +171,7 @@ foreach subpath:subdirs
>          pkgconfig_extra_libs = []
>          testpmd_sources = []
>          require_iova_in_mbuf = true
> +        use_function_versioning = false
>          # for handling base code files which may need extra cflags
>          base_sources = []
>          base_cflags = []
> @@ -273,6 +274,13 @@ foreach subpath:subdirs
>          endif
>          dpdk_conf.set(lib_name.to_upper(), 1)
>
> +        if developer_mode and is_windows and use_function_versioning
> +            message('@0@: Function versioning is not supported by Windows.'.format(name))
> +        endif
> +        if use_function_versioning
> +            cflags += '-DRTE_USE_FUNCTION_VERSIONING'
> +        endif
> +
>          dpdk_extra_ldflags += pkgconfig_extra_libs
>
>          dpdk_headers += headers

Don't we need to build with RTE_BUILD_SHARED_LIB for the shared library objects?


-- 
David Marchand

