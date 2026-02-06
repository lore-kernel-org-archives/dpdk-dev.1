Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBD2EB28E2
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Feb 2026 08:29:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 927CE4029A;
	Fri,  6 Feb 2026 09:29:41 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 6E2D940293
 for <dev@dpdk.org>; Fri,  6 Feb 2026 09:29:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770366579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bD7xpl6At/hbgC2HioB6nW0vGRAmkxZS//MzL5t8o+8=;
 b=Gko64R5oeMke+Q9K41u4Alm3CriiuvU1JRmxfUh/1GHDRwJhFleGSKDLL7k4SBMk/spOKB
 9Bv7JfJv1+5MB+x+4L4el7k58dAo8uZiCM+zmYG2+ScoXBvLc0Bt9rE9i3JTC1OYJsJCvQ
 PdfQ3NRRwZeUvcEaiWwkqola0SGVj0I=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-HtwKLWOdMq-v28WFfpzA1w-1; Fri, 06 Feb 2026 03:29:38 -0500
X-MC-Unique: HtwKLWOdMq-v28WFfpzA1w-1
X-Mimecast-MFC-AGG-ID: HtwKLWOdMq-v28WFfpzA1w_1770366577
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-59b730b2b0aso1967574e87.0
 for <dev@dpdk.org>; Fri, 06 Feb 2026 00:29:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770366577; x=1770971377;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bD7xpl6At/hbgC2HioB6nW0vGRAmkxZS//MzL5t8o+8=;
 b=kXqcrNS5PwW7ZjgSOdhr5M/w9lhhoHpBAu2aUz/cQDhK5ObPNjHuNK66N2ovL8ypDQ
 hbbw1ekSjnkisbajH46ToTL/7Bxu05RMpzdDjVnfJ1Nz1oe+Hq2aTuEIQv3S4rQN8dlS
 9t7R5PXiL0zqiDZqlwQN8zGwb8T9UUTunBOkIXZ5hJCv+m4xbftV5ODdrRAVKhDi2N6p
 mhCRo73HB/MudzQPa9CeO2W90V2iV6OdVeWfYUea96062y8FREu5Dge1SaIVB6M/ld9P
 5zPgWnsrnwq7aneWOjCLzkQejCPBkkz0iQsS21zo/Fdj9VLsKM6B2zP8fRx1d81hKnkt
 0rMA==
X-Gm-Message-State: AOJu0Yw/B7d6HuVz0j9r0DZ60LJ1GrwnUY9pd+TbI8OQ4wY1i/ueZ7yi
 PtqVJoDd2UNbQ43uAOGRxmiiFR3tmCjGNSGL0AtwVsOQzq/H0ZmvFwAAwIhk6pcqzozLl3WHPLw
 WN5PxOccQOwVBoxa2Q/N482rar7ZmA/As7TAn+p+uWer0ENnYngwMfzVH05S3xg7eqBtq5JWZCq
 tcZ0bwVYXL/ki11H5oikM=
X-Gm-Gg: AZuq6aKGVXc6UwJaz/hl4TO7sD02iTkw+uDQ/u9qxmE4byDnD2amxLoGAZpse+hFMaW
 uonrbNjhWi+qqh+94uAEAk/ePtPGv+obY+2ogbWdAqVfUgS8HcuRLrziUGl0tCnbP/bzGRKesfU
 uFa4tICkj0TsAIRvBB7RVFFo50x45OMzil86qS6YrwuHGP2RFWglcURp0gp8tuDKk76s7AYCwzh
 BhRUgTfWgs6xp5a/A1ToBsg+YZsYt5Qk7H8v+n0buM51lPQFFPqBLKOvQ==
X-Received: by 2002:a05:6512:3619:b0:59e:3c79:2b18 with SMTP id
 2adb3069b0e04-59e3c792e73mr1457200e87.10.1770366576774; 
 Fri, 06 Feb 2026 00:29:36 -0800 (PST)
X-Received: by 2002:a05:6512:3619:b0:59e:3c79:2b18 with SMTP id
 2adb3069b0e04-59e3c792e73mr1457196e87.10.1770366576378; Fri, 06 Feb 2026
 00:29:36 -0800 (PST)
MIME-Version: 1.0
References: <20210412215339.2439530-1-thomas@monjalon.net>
 <20260205213044.702908-1-thomas@monjalon.net>
 <20260205213044.702908-12-thomas@monjalon.net>
In-Reply-To: <20260205213044.702908-12-thomas@monjalon.net>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 6 Feb 2026 09:29:24 +0100
X-Gm-Features: AZwV_QgEZZbUJNWTixyCIU9cQoB3tt3tIyRFu7uMRgDBAvwF_9FXrIoTk-eLLxY
Message-ID: <CAJFAV8zA+5M+CWeReaaQysDFHe7WhHgTuVeLr3XQRPJCDNBU3Q@mail.gmail.com>
Subject: Re: [PATCH v4 11/11] ci: check minsize build type in GHA
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org, Aaron Conole <aconole@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CBCPUiHW_fHIbk5RG1EKBqnYN7Qmq8tc_AeUHDm81xE_1770366577
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

On Thu, 5 Feb 2026 at 22:31, Thomas Monjalon <thomas@monjalon.net> wrote:
>
> In GitHub Actions, the build for Fedora with GCC is updated
> to use the Meson build type "minsize".
> This type may have some different requirements (or bugs),
> so it is better for its maintenance to test it regularly in the CI.
>
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
> ---
>  .ci/linux-build.sh          | 2 ++
>  .github/workflows/build.yml | 2 ++
>  2 files changed, 4 insertions(+)
>
> diff --git a/.ci/linux-build.sh b/.ci/linux-build.sh
> index aac0bd3dc5..e0b914a142 100755
> --- a/.ci/linux-build.sh
> +++ b/.ci/linux-build.sh
> @@ -85,6 +85,8 @@ buildtype=debugoptimized
>
>  if [ "$BUILD_DEBUG" = "true" ]; then
>      buildtype=debug
> +elif [ "$BUILD_MINSIZE" = "true" ]; then
> +    buildtype=minsize
>  fi
>
>  if [ "$BUILD_DOCS" = "true" ]; then
> diff --git a/.github/workflows/build.yml b/.github/workflows/build.yml
> index ab140f885e..f0142efd3b 100644
> --- a/.github/workflows/build.yml
> +++ b/.github/workflows/build.yml
> @@ -325,6 +325,7 @@ jobs:
>          config:
>            - image: fedora:43
>              compiler: gcc
> +            checks: minsize
>            - image: fedora:43
>              compiler: clang
>
> @@ -362,6 +363,7 @@ jobs:
>          echo CCACHE_DIR=/root/.ccache >> ~/env
>          echo DEF_LIB=${{ matrix.config.library }} >> ~/env
>          echo STDATOMIC=false >> ~/env
> +        echo BUILD_MINSIZE=${{ contains(matrix.config.checks, 'minsize') }} >> ~/env
>      - name: Load the cached image
>        run: |
>          docker load -i ~/.image/${{ matrix.config.image }}.tar

LGTM.

Note: the reason for this (ugly) manual filling of env is that we do
not use GHA support of containers.
At the time I added fedora containers, I had multiple occasions when
pulling the images resulted in failures (getting throttled).

Maybe things got better since then... I see OVS does use GHA support.
Any volunteer to reevaluate this?


-- 
David Marchand

