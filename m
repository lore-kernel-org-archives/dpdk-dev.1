Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEDCC282D1
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Mar 2025 13:11:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 84ADE4065F;
	Thu,  6 Mar 2025 14:11:06 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id ABBB640430
 for <dev@dpdk.org>; Thu,  6 Mar 2025 14:11:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741266664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GX6DP6VtG4nYL5pAmqMwdj3XxgUeprG0kEsNGMUdzyI=;
 b=Ma5C9yru9SDij9HQMgmc6TsT0J4BIv1IextOvIQcd6/+7cMI2LX4sVc1Iy1WxXaKWo4BRa
 0/WNdFcKXtBY60HzULTREs3WIae1OoB3hq05rGYRyA2Rq28SzBe5TbNxHOtJpDXF/aq0WD
 swHkYFFqdfzRVGb67AjXIB9IDYb9Sww=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-bCswf97rOluaGqxcJ4fVkA-1; Thu, 06 Mar 2025 08:11:03 -0500
X-MC-Unique: bCswf97rOluaGqxcJ4fVkA-1
X-Mimecast-MFC-AGG-ID: bCswf97rOluaGqxcJ4fVkA_1741266662
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5498b25aae9so300314e87.2
 for <dev@dpdk.org>; Thu, 06 Mar 2025 05:11:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741266661; x=1741871461;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GX6DP6VtG4nYL5pAmqMwdj3XxgUeprG0kEsNGMUdzyI=;
 b=TI5p1gf0ExaieeVWu67x4D1uv8uemZNPMdtT370KCq921IoZHS6eFMJHUmV3Y9VmjQ
 qld/spTy+2hSCFbb+qb3OXeDs/gloyQN8r1SCfzg4rIssIS+jWs1CL6B+GMmW6RezaPk
 9jX6LCnwT4tP6x3JRJW0VxNgM+EfMhuEuGCdrraJ00GxfYCCO4zKQ5Hw51C4/70S/HAO
 ViIQFeY7tJ1l5wYfhnVzVKbr2RnPf5MWr9xqqbgHB8dQVJFoH1Kdhz613JfzUSgjuHsS
 DK0fa+U1yQMAU4CMNSrtKhtYqi2Fe9QC7iyPD3HkHEvaO8Sfxd2cuqKxZm3cQnnvOPGm
 VGOQ==
X-Gm-Message-State: AOJu0YxIn7+Pk6SPckTFZbiM5gys1TIWEF1RyO5dwP5UJOKnm4Pbn9or
 2ldMwhgNcPgvdvZZAY134YwNOPvjVGojUwHY9T15WMBN/rVUuRxE0H34x+J2/ptbYxq+giCz0so
 MeejbelYMjzMgEU35pI+EYhIdAOdR2Lp7MFIyZpi9BVNFhipI15FHkG/uYT8IU0usLa48ZJFeuK
 nRORb/NuYpiI0dAVY=
X-Gm-Gg: ASbGnctEt+XKl5CfsA9LBSEEfmae3Ed9UDbmaxIk5/nwitA0qHjFoK1DKbXOhiY2F1N
 r8vaf6HWLgsJ9F5Ey9bUrrsuGLillkF652m1TDf7oCHaJy4dkYlk2bNWP8cANpZK4qWpzUhzrwC
 U=
X-Received: by 2002:a05:6512:31c6:b0:546:27f0:21a7 with SMTP id
 2adb3069b0e04-5497d38379amr3183403e87.49.1741266661460; 
 Thu, 06 Mar 2025 05:11:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEbE0IOwNJYrW3R6NCfMkD2hQSCB/420dx2sDA2uujsvDXqkYS/sSE8Isl37VSyH2nphEPG1QRhhe0qA5xQjsE=
X-Received: by 2002:a05:6512:31c6:b0:546:27f0:21a7 with SMTP id
 2adb3069b0e04-5497d38379amr3183391e87.49.1741266661001; Thu, 06 Mar 2025
 05:11:01 -0800 (PST)
MIME-Version: 1.0
References: <1733342995-3722-2-git-send-email-andremue@linux.microsoft.com>
 <1738940668-21653-1-git-send-email-andremue@linux.microsoft.com>
In-Reply-To: <1738940668-21653-1-git-send-email-andremue@linux.microsoft.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 6 Mar 2025 14:10:48 +0100
X-Gm-Features: AQ5f1JoqtjrDwqkTsIQFLViVI0nz-arA5wUGB_J3hrKr14pRK3KLQbkvBQVsMJk
Message-ID: <CAJFAV8xrJ0MzCJ-6Os_9dffmaWzR5uHGm5NT3jScSaV2ck4WPQ@mail.gmail.com>
Subject: Re: [PATCH v6] eal: define __SIZEOF_LONG__ when using MSVC
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>, 
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cl-b3X_a2I15TiRVIPbPsJDjfaxRmtlBTlEVme3oMz4_1741266662
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

On Fri, Feb 7, 2025 at 4:04=E2=80=AFPM Andre Muezerie
<andremue@linux.microsoft.com> wrote:
>
> Macro __SIZEOF_LONG__ is not standardized and MSVC does not define it.
> Therefore the errors below are seen with MSVC:
>
> ../lib/mldev/mldev_utils_scalar.c(465): error C2065:
>     '__SIZEOF_LONG__': undeclared identifier
> ../lib/mldev/mldev_utils_scalar.c(478): error C2051:
>     case expression not constant
>
> ../lib/mldev/mldev_utils_scalar_bfloat16.c(33): error C2065:
>     '__SIZEOF_LONG__': undeclared identifier
> ../lib/mldev/mldev_utils_scalar_bfloat16.c(49): error C2051:
>     case expression not constant
>
> The fix is to define __SIZEOF_LONG__ in a common header when
> MSVC is used.
>
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>

Applied, thanks.


--=20
David Marchand

