Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94FB2C282EC
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Mar 2025 09:47:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B7078402D1;
	Mon, 17 Mar 2025 10:47:58 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 6DAAA402BB
 for <dev@dpdk.org>; Mon, 17 Mar 2025 10:47:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742204875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J8+MlaD14zH7Paqot2hw+B4UXck3kNTzywedMs3itaI=;
 b=MPmfTD0/rCj0mGk/I7OsTH4esF998KGY+o+BiVpZZg46d1yj7VMadgGSvhD0HkW2W9+YZL
 eLR1fG7FlSAY9g/PRkzbbqzqCUgN2NO/DHpEEufeadfra+M/qP1C3LcOPyeRf9N67tNzDy
 LO2db83IzQ+cfIXEfVkNDd93+BQDgck=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-CedjPYovNjC__0sbEFMpBg-1; Mon, 17 Mar 2025 05:47:54 -0400
X-MC-Unique: CedjPYovNjC__0sbEFMpBg-1
X-Mimecast-MFC-AGG-ID: CedjPYovNjC__0sbEFMpBg_1742204873
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-307359756d0so21912471fa.0
 for <dev@dpdk.org>; Mon, 17 Mar 2025 02:47:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742204873; x=1742809673;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J8+MlaD14zH7Paqot2hw+B4UXck3kNTzywedMs3itaI=;
 b=N9bMOFXsRm3kyp912R9qXQOtVb6o/YNERJHhzJBnP/T//g1sBxgXybJ2JOsY6VpqGU
 Y0gZxX0G72xUdETdg8FffPQmIn9FG0mnYtuT+uip42u0akKMl6hdXsoDUKfSoSVAKwPu
 39M0ImjS9y/kdSVDj0VoK9h6NCFGXYKg7cTniwOtHyjRjmGWaHVbrm6/Cy3IVWDz4MTS
 qZV3WFBHKiEMTnXSqRXz+TMjZWyU1XxA3RNbkSs1u4pD6c44aHWNWhtrIaPdS+Vf9Sd+
 KqmPxDAZ9gPOP3Fzb34OUVdOFp4lA7KG6MnSh8r9EpjnJprr+erTK4L5UrcOnndq2vWH
 w0nw==
X-Gm-Message-State: AOJu0YwqfMIingU6FUnWiIZXnMsufhhfhcG5SY6OUzqL3l+FowvVyYCM
 QyNloXGyqrc8pZ7PBTFHRhFs8AnAvimDA7tCqnF8slxUKIxZ76DOlOuRuEXIL8HyP16OJHL56Cp
 oOMHTSagr8eexT3CyR2aVlVhIjS3G2VnSVnpzgjGCWT230IOrH68KMg7Ozuqg4JcSbVNjz1eS0n
 fU627aLCNxRdG+zjU=
X-Gm-Gg: ASbGncsuCWOnsnC12BYgOOmUCnMyE+SYVNQh9yKnqhJyaX1AXGIjuSGAj0cu4XQ1ZQ8
 bZc/Is7frO4A+5JIubEr1WoYBV8Au4tFFFDikdU7rQQ3ctnQZ4TNBmhgHohRZ3x6n8VGyiuhC42
 c=
X-Received: by 2002:a05:6512:1050:b0:545:ea9:1a24 with SMTP id
 2adb3069b0e04-549c38e2eaamr6094356e87.14.1742204872896; 
 Mon, 17 Mar 2025 02:47:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEy76XQN6zxwpbCmwDlDM/wjD1Vg+axkG9hofi8H7eaQZO3remTXM6diS7Nq/5G2835mEGycNIhHT3caj3CXDw=
X-Received: by 2002:a05:6512:1050:b0:545:ea9:1a24 with SMTP id
 2adb3069b0e04-549c38e2eaamr6094337e87.14.1742204872565; Mon, 17 Mar 2025
 02:47:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250314172339.12777-1-bruce.richardson@intel.com>
 <20250314174439.112658-1-bruce.richardson@intel.com>
 <20250314174439.112658-5-bruce.richardson@intel.com>
In-Reply-To: <20250314174439.112658-5-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 17 Mar 2025 10:47:41 +0100
X-Gm-Features: AQ5f1JrkhQ4rKX6vxLuJBQLdnZRl-GFYvG5Yr1gBqwe5OFj1apMNT9aJP_gYw5U
Message-ID: <CAJFAV8wDyJLz-=9nkqWv8ZW-pFbQ1pD_An72TN25ezKX07q4jw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] drivers/net: remove AVX2 build-time define
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Ajit Khaparde <ajit.khaparde@broadcom.com>, 
 Somnath Kotur <somnath.kotur@broadcom.com>,
 Vamsi Attunuru <vattunuru@marvell.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pyJ2gXeEYzuAVkEJwoMckzC9KP1MAfuJGCUZaYzbSUE_1742204873
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Mar 14, 2025 at 6:44=E2=80=AFPM Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> Since all supported compilers can generate AVX2 code, we will always
> enable the build of the AVX2 files on x86. This means that
> CC_AVX2_SUPPORT is always true on x86, so it can be removed and a
> regular "#ifdef RTE_ARCH_x86" used in its place.
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  drivers/net/bnxt/bnxt_ethdev.c        | 2 --
>  drivers/net/octeon_ep/meson.build     | 1 -
>  drivers/net/octeon_ep/otx_ep_ethdev.c | 4 ----
>  3 files changed, 7 deletions(-)
>
> diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethde=
v.c
> index 144d4377bd..a318604c20 100644
> --- a/drivers/net/bnxt/bnxt_ethdev.c
> +++ b/drivers/net/bnxt/bnxt_ethdev.c
> @@ -3238,8 +3238,6 @@ static const struct {
>  #if defined(RTE_ARCH_X86)
>         {bnxt_crx_pkts_vec,             "Vector SSE"},
>         {bnxt_recv_pkts_vec,            "Vector SSE"},
> -#endif
> -#if defined(RTE_ARCH_X86) && defined(CC_AVX2_SUPPORT)

I was wondering why this was not coming along a meson.build.
On the principle, this
Fixes: d58c6c077cc2 ("net/bnxt: add AVX2 Rx for compressed CQE")


>         {bnxt_crx_pkts_vec_avx2,        "Vector AVX2"},
>         {bnxt_recv_pkts_vec_avx2,       "Vector AVX2"},
>  #endif


--=20
David Marchand

