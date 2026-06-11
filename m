Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46562CD98CE
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 13:53:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1279E43265;
	Thu, 11 Jun 2026 15:53:17 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 2E9AE40041
 for <dev@dpdk.org>; Thu, 11 Jun 2026 15:53:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781185995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FxhGRYpT/mbA/lOCL10cMqRP2IlpKGa8AdFMIna4EkI=;
 b=WOAQwyHTFfWlkjBbhx6gfjmCADcrt2i/x2L8EzwOg5mo74OXP8YTFYMB/mCsBupv3c7FD9
 L0a3eWOuelhEQLaWGv4Mb5a9ZUGl6V7tdGWWdPHxapyWn1pu0oqe/wZOix55KcirwVdqV1
 aRSFFuPPQDEdmTAnz+M40n+o6mj9BV0=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-XVeOf4NLN1KltdrqY5-X_w-1; Thu, 11 Jun 2026 09:53:12 -0400
X-MC-Unique: XVeOf4NLN1KltdrqY5-X_w-1
X-Mimecast-MFC-AGG-ID: XVeOf4NLN1KltdrqY5-X_w_1781185991
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-3966c1df9e6so32182631fa.3
 for <dev@dpdk.org>; Thu, 11 Jun 2026 06:53:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781185991; x=1781790791;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FxhGRYpT/mbA/lOCL10cMqRP2IlpKGa8AdFMIna4EkI=;
 b=I6Ab+5LBj3U5C7/p59xkQXUhpyQk6EiUyTycR+AYb5Yn2WofwwYoQylmUBX/Ii2PfY
 vVSA74iMsFdIztJXyhYGfm04eSmC9G/wTXyjK/BP6/gaUx7wnEvXKUyZhXMWD6SiAuiu
 CNce9StgBK/PamDaX2qOU2FUgkGAdvvjjD8TLX07YyxKmJTHxkZRaSiAQfpVRIYeL2jF
 OK8wZxXzKDxYEIPKIGLXkIBoSNzaxSsGKmBNio9XW63Xo/nzqs5ymE2HYKVdegM5N/Vn
 z2iATNkQO4Ztl7Hql0rNq6aXNHUcNj72VZ5aVBDE6T6WolfUaffDEmlLzvc/epWCqpLT
 1LGQ==
X-Gm-Message-State: AOJu0YyG2cIbfRCVmiJG372WnMA3au/d0cDVsYKQFRKHdt07MVFcxrbV
 ZkF7CKpKtIMplJ1VjT3cE5EHl8AzaYwfTp0+pDT0MChMnjGY57RjY/11cJecrrmdGqs6ASi2q3p
 m03uYgwj6YnJOeQrmz1ONHRNxaQ/HLDU3zp/eRzPVlVGMEXS/axqVhqoChtrFkX0E/wOqqdVhuv
 FtpEglbXVik9Rb0N5q0iA=
X-Gm-Gg: Acq92OHS1Qr7EtTwwo7C2Jq8GmsrR1nAPPIicPv8x8kVF8E5eDCLcjENyuyL5wPUOLl
 t/D8QaMpl9kL68FNZVjqbOy/oJ+frruLo30KbZpXSQhUDWFM20HVeRS0pefsWqrEQf7Vt4ZRjGL
 JL8WFA1uUl55Tz5nwdWDrdk9gC7ppaBtW0Ib+NwWkS2a+fRm8XhDrxWcfJA57LKEQJIee2Yx5Yq
 CHghzJZ3pG3w9vZylLTUcssNZI2txchZdqQm2HFDh03MzNjNbhxU/FqOXX5fQ7cZiwyKCjbo221
 xuzg
X-Received: by 2002:a05:651c:1502:b0:396:8588:d5a9 with SMTP id
 38308e7fff4ca-3991a0b6f28mr8037091fa.11.1781185990546; 
 Thu, 11 Jun 2026 06:53:10 -0700 (PDT)
X-Received: by 2002:a05:651c:1502:b0:396:8588:d5a9 with SMTP id
 38308e7fff4ca-3991a0b6f28mr8037021fa.11.1781185990002; Thu, 11 Jun 2026
 06:53:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260516110828.35701-1-shofiqtest@gmail.com>
In-Reply-To: <20260516110828.35701-1-shofiqtest@gmail.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 11 Jun 2026 15:52:56 +0200
X-Gm-Features: AVVi8Cf764Yijhd2X7Cuz1cng-VVrkg9km5f91PjHTempCYAAyP0tJK4GSkqDIg
Message-ID: <CAJFAV8wKuD+TDEjgE74BOUFvQvw1tN9xAgrU8wih_q3K_J_mgQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] dpaa2: fix error propagation in remove path
To: Md Shofiqul Islam <shofiqtest@gmail.com>
Cc: dev@dpdk.org, hemant.agrawal@nxp.com, stable@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ptNFi42LwYlmB-YOHgjOtaNU8l-cSictzpZPmUxQXL8_1781185991
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

On Sun, 17 May 2026 at 14:54, Md Shofiqul Islam <shofiqtest@gmail.com> wrote:
>
> This series fixes two bugs in the dpaa2/fslmc device removal path where
> error codes were silently discarded, making it impossible for callers to
> detect removal failures.
>
> Patch 1 fixes fslmc_bus_unplug() to capture and propagate the return
> value of drv->remove() instead of ignoring it.
>
> Patch 2 fixes dpaa2_qdma_remove() to return the actual error code from
> rte_dma_pmd_release() instead of unconditionally returning 0.
>
> v2:
>  - bus/fslmc: use 'if (ret != 0)' style per DPDK coding standard
>
> Md Shofiqul Islam (2):
>   bus/fslmc: fix ignored return value in fslmc_bus_unplug
>   dma/dpaa2: fix dpaa2_qdma_remove always returning success
>
>  drivers/bus/fslmc/fslmc_bus.c  | 4 +++-
>  drivers/dma/dpaa2/dpaa2_qdma.c | 2 +-
>  2 files changed, 4 insertions(+), 2 deletions(-)

Series applied, thanks.


-- 
David Marchand

