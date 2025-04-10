Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F26B4C3601E
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Apr 2025 16:05:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DDA4D40693;
	Thu, 10 Apr 2025 18:05:32 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 679DF402ED
 for <dev@dpdk.org>; Thu, 10 Apr 2025 18:05:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744301131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nMtJQ/+2rz4LKXWCxX9ATgEYUweHZ12KcwztLkKNGsc=;
 b=aBzU7UpdWz3HecmrkM46iVgLGf4K50iJDXsEJo8kL8YDTp9zIS4PeRd15EZ+tItD83eQ+Z
 UiPcrkp2eP2QZIEd/giwAEWKu6ov5YpbNnZMvgP0NDM64VsuR/UmvnTDLYzgbhofVm3Q64
 4IqGRBSh/T4OEtHMnBGuEzFovQqLl3g=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-VJqSyv_YP4WeaDNUBzvJuQ-1; Thu, 10 Apr 2025 12:05:26 -0400
X-MC-Unique: VJqSyv_YP4WeaDNUBzvJuQ-1
X-Mimecast-MFC-AGG-ID: VJqSyv_YP4WeaDNUBzvJuQ_1744301125
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-30db3c4140fso5126141fa.2
 for <dev@dpdk.org>; Thu, 10 Apr 2025 09:05:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744301125; x=1744905925;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nMtJQ/+2rz4LKXWCxX9ATgEYUweHZ12KcwztLkKNGsc=;
 b=CMIye4/q+5hhJvn1McS4N+hduf8Mm8Z5vlMh+/t80sX58Qd+Q/UsaaRA98t6GHRsHh
 KWIMQAP+nlf5msZ8Z9eYhWVRT87p2Ufe8wZeR0Kf3XjM8jtmxE51Lq/z0DtyEgfYszQQ
 jlqX5MXBrNayulBO5OeoWN8gIvBaAmjqqc44/2ygDQFsd2b/6avqvRPgAdyfA4cIxLNM
 d+bcyoruw5zwe8LRIrTwEeY6E4qxl79rU2jQaEIrIF6vxcwJvLZGiOHkXOa+4waoRxSF
 zWAvx9zUdVri2NLrX89tTNTUwd6vc4+Ay9y/NDuwUj/TPLmnsRtJwrXhYA9XnyoPga1N
 HyZQ==
X-Gm-Message-State: AOJu0Ywfp+cKjX6P+pSDq/2GKgWTfIazD4V3fcdNSER2i3U0Q/nQfiUR
 r+8omQCstgvPyR8J+d/sjyNc8wGMIiw4Zsy+pSZg7HP46sfLciZg/6MvmNaJIUW1z5RAVmj17kj
 ZHROpSSmROlf5ozSY8GZx4cs3jl8I04rF9ybUzSO14nJGsCsmwqCQjQZ1dIQrr+52FAExgU8d39
 xl+9C5jwnf0Ge2RHE=
X-Gm-Gg: ASbGncue4Qv55SZGQcs4L3Eqk0wyc/Q3B9wucbe0W/dVDug1/801N8yCG9xa9Z6Y3qQ
 MZl+nQYsCGq5Jcj1pG5Ijs0wRa31G2F4Zsv90DOy2LYfyOZz8HIBmk/k4R8Ml1c5qUSSnDQA=
X-Received: by 2002:a05:651c:3131:b0:30b:ba06:b6f9 with SMTP id
 38308e7fff4ca-30facca4b2cmr14836861fa.26.1744301124617; 
 Thu, 10 Apr 2025 09:05:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE566rahEPa2xNb27EfvKnbZhc/0lY2O8NMX3lky5fvgp+tkFePYQyKGjiR+RV4/BR7I47UewJ/F7dFhL9ZMS4=
X-Received: by 2002:a05:651c:3131:b0:30b:ba06:b6f9 with SMTP id
 38308e7fff4ca-30facca4b2cmr14834661fa.26.1744301122445; Thu, 10 Apr 2025
 09:05:22 -0700 (PDT)
MIME-Version: 1.0
References: <1739311325-14425-1-git-send-email-andremue@linux.microsoft.com>
 <1740414265-12217-1-git-send-email-andremue@linux.microsoft.com>
 <1740414265-12217-6-git-send-email-andremue@linux.microsoft.com>
In-Reply-To: <1740414265-12217-6-git-send-email-andremue@linux.microsoft.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 10 Apr 2025 18:05:10 +0200
X-Gm-Features: ATxdqUG7BH_HQF6kOu_UUM2JJb9ivFX-0txYc7LZt-PEvXG6ZJn0Tqi6k2ydle8
Message-ID: <CAJFAV8xqEk=qgJteUDv0TJ9W_UyRoOtjVSU7NjkHrUVvgrHgYg@mail.gmail.com>
Subject: Re: [PATCH v6 05/10] test-pmd: avoid undefined behavior
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: dev@dpdk.org, Chengwen Feng <fengchengwen@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hHxVGH9UbzbX6nzcPzEoXl_BiSQq9La8zFX1aTPuXms_1744301125
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

On Mon, Feb 24, 2025 at 5:25=E2=80=AFPM Andre Muezerie
<andremue@linux.microsoft.com> wrote:
>
> Compiling with MSVC results in warnings like below:
>
> app/test-pmd/cmdline.c(9023): warning C5101: use of preprocessor
>     directive in function-like macro argument list is undefined behavior
>
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
> ---
>  app/test-pmd/cmdline.c | 12 ++++++++----
>  app/test-pmd/testpmd.h |  2 ++
>  2 files changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
> index 2afcf916c0..d0b47eac8f 100644
> --- a/app/test-pmd/cmdline.c
> +++ b/app/test-pmd/cmdline.c
> @@ -8980,6 +8980,14 @@ dump_socket_mem(FILE *f)
>         last_total =3D total;
>  }
>
> +#ifdef RTE_EXEC_ENV_WINDOWS
> +int
> +rte_trace_save(void)
> +{
> +       return TEST_SKIPPED;
> +}
> +#endif
> +

- I don't like this fake declaration.
It does not comply with this function documented API.
And there are other stubs for the trace API in eal/windows, where this
could be a better place.

- TEST_SKIPPED 77 is some known error code when invoking unit test via
meson, which does not make sense with testpmd.


I sent a simpler fix, could you have a look?
https://patchwork.dpdk.org/project/dpdk/patch/20250410160237.3067629-1-davi=
d.marchand@redhat.com/


--=20
David Marchand

