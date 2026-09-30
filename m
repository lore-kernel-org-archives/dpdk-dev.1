Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43664CA5FC7
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 15:26:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0177E40DCB;
	Wed, 30 Sep 2026 17:26:43 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id 805DC40278
 for <dev@dpdk.org>; Wed, 30 Sep 2026 17:26:41 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 d9443c01a7336-2d747ee1f9bso26300445ad.3
 for <dev@dpdk.org>; Wed, 30 Sep 2026 08:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790782000;
 x=1791386800; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZHM4Uwjc/NE/XyXGdJ8JHqNFR00M87KWG5xhaC0i9m0=;
 b=H8kqZUkFsH1sTKYQeYxgWJ8y+x6HMhcgOPjHuUKv0uWR2QkcC0ZPrj25eXfsgFGjRd
 ai86LNmvPfFxq1ysKcDCHzJz/LkkIGZ+x1qQx4xssFORH3DsQw/m2yJw44QbwWONJEnl
 rAWHWCeZHNqaL50JPIYYnR5o5JCUJSbpcfUOMVAqYwDe9RZLtoLctVAdFfff/2OcR6tG
 4WZpMd+v0sgj0JIWywlofDrcVIVt6e1BTgOznE+cMBaqUFoYkVrITvL3s1mSePrEWf4R
 3aTd2oNbmGdot/FXXq7cuMeCjrQLVhdjlKHMXRkx56oB+HHffkz0YndlY3DbBdc1m2BL
 nd2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790782000; x=1791386800;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZHM4Uwjc/NE/XyXGdJ8JHqNFR00M87KWG5xhaC0i9m0=;
 b=EbRlfdQdufFuL54X4zlUZlmoGYzAQJsakQ/3dlPtMnmuYnDdlZ+SlJV0hv3BzPuwOi
 wPfH9diw+2vts9oe69W7QGAPdYymGCeZMxi99jG9WX/lQPwbXPl9sTIU9lV26f6+Y8BO
 glfugXaXFmBx+SzI9bGS1xbYigoElfRBtPvLAEih23tvzoBGe7pEL4+DDJ884mKtp1f6
 gJN2qggPeNrirqUuoZlKIoYdh3UOmMlQBCn13KTicFM/Xkr8+8+XQkpN5ZjDTzQFvB+0
 smMVVo+qSjVtKEAkhLLZ7VrhVPzX1A1DBApPw+tHx2sd8fneMaiu4qw6N2yM5pniixTp
 kOuw==
X-Gm-Message-State: AFq9FYJP6yap3irLZaILg+a0lQKVqiCnBJBgnkjjormgt31v5Keay37m
 cg4hqlv6Tb0z9vXI1ALafrP3WGhaKUBlkmtT1oeyytN++GCXlX/KZUAxVUpkmgXKRhw=
X-Gm-Gg: AYBFou0ee1xWEXU6nJ5InsEcqieEZKYx1tqd5iE4FGuh9M2DHqABIbnhfT7zDW9hf6f
 stXt96jUHYmUCKazimSOUTgbLGKUeRA7KIMviwzFKd4w++oVnAY+9oz6dQ2a7CKuFDtGBUWy9Zr
 9BDXZS4muMoiTMxf1cMXrAD7hA5l00h7vdE9GJOGpfP7XrEK+mwmP8asxFKQ+8a8b+jlgfZpm3S
 IliB3pbWyTfhoOx6s38hU/d0pr4z6AetLT7Omdo2L/B3VI1cZZLHon1vV7NdzQs54LNVt5EoEG9
 JJOxD8b8bWJuCxleC22Eku6e6BdOF2k55Frp19wgijsCwW2hGiwCvWDvq6FTbiyxvvu0gz9HeNp
 2lD33od81YOM5sVKkX0YwjuTFfkraHz4f3mq03d0iNiynLj1oLkBE5thNt21R6cZixToq1TcH12
 EDr2c2wlORm0P8GpWua+oHQdPcTNgW0oCq5UlO4MnClNcAqzvXMFB/P6m58WpHb7Yn5W/JX42tB
 L0bIhfWtc3wIDPPshmmIZYP9/bHKqLgWA8+ELzz
X-Received: by 2002:a17:903:2f87:b0:2dd:c100:7cc7 with SMTP id
 d9443c01a7336-2e2e4b2eccdmr15950935ad.67.1790782000349; 
 Wed, 30 Sep 2026 08:26:40 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e2e5c4d910sm9547925ad.82.2026.09.30.08.26.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 08:26:40 -0700 (PDT)
Date: Wed, 30 Sep 2026 08:26:38 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: dev@dpdk.org, eperezma@redhat.com, david.marchand@redhat.com,
 thomas@monjalon.net
Subject: Re: [PATCH 1/2] config: add compatibility for old compilers with
 new UAPI headers
Message-ID: <20260930082638.0932a5e9@phoenix.local>
In-Reply-To: <20260930095800.551314-2-maxime.coquelin@redhat.com>
References: <20260930095800.551314-1-maxime.coquelin@redhat.com>
 <20260930095800.551314-2-maxime.coquelin@redhat.com>
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

On Wed, 30 Sep 2026 11:57:59 +0200
Maxime Coquelin <maxime.coquelin@redhat.com> wrote:

> This patch adds a compatibility define for __counted_by attribute,
> which is not present in older compilers but required for recent UAPI
> headers like vfio.h.
> 
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> ---
>  config/rte_config.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/config/rte_config.h b/config/rte_config.h
> index 0447cdf2ad..307e7dac62 100644
> --- a/config/rte_config.h
> +++ b/config/rte_config.h
> @@ -25,6 +25,15 @@
>  #define RTE_TOOLCHAIN_MSVC 1
>  #endif
>  
> +/*
> + * Compatibility define for Linux kernel UAPI headers that may use __counted_by
> + * attribute for bounds checking. This attribute is not understood by userspace
> + * compilers, so define it as empty if not already provided.
> + */
> +#ifndef __counted_by
> +#define __counted_by(m)
> +#endif
> +
>  /* legacy defines */
>  #ifdef RTE_EXEC_ENV_LINUX
>  #define RTE_EXEC_ENV_LINUXAPP 1

NAK this is best done by keeping up to date stddef over in virtio headers.
