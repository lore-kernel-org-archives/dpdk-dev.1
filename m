Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94DD4C7EE30
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Jul 2025 11:38:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1474640674;
	Tue,  1 Jul 2025 13:37:48 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 297904064F
 for <dev@dpdk.org>; Tue,  1 Jul 2025 13:37:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751369865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2lmkh4qJJVa7BBAPSCvNlBb1gMj6QXTcox/G4s26XFA=;
 b=LoB9Dd4M2kzKcrEJVJaAQdAYpBtzeMBltLprB/TT4g+2tgiHp3UMMXpoFOg1fJEWUjJsyH
 l/SRPO62vsqlWMKIb+FKVKxKzQp2cOX8//XHoqjQroDCOzMiQwHfxDcbIPArPIsX4Y0WfK
 lxa/CsxSUHnBDB/E99RblSRD6HzYoZI=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-Ew6DTXzXP7iywiOPV6Irrw-1; Tue, 01 Jul 2025 07:37:44 -0400
X-MC-Unique: Ew6DTXzXP7iywiOPV6Irrw-1
X-Mimecast-MFC-AGG-ID: Ew6DTXzXP7iywiOPV6Irrw_1751369863
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-32b49f95c5eso22750971fa.0
 for <dev@dpdk.org>; Tue, 01 Jul 2025 04:37:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751369863; x=1751974663;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2lmkh4qJJVa7BBAPSCvNlBb1gMj6QXTcox/G4s26XFA=;
 b=k+hI9Ur/4Z3yUil2L99lzT5ctPqgCWtDFXV7OE881z2BFYdauUr3JAv602KQdaMEVO
 K3CcFzzCD90/bBwoj3WTDbz9hy3E27sJxUdvFKHSAzUy0GZ48cFq2DXK1+Zhk2N+R7P0
 yUl8x85ilEkQEpTjnV71CcmZe1vbThWCAQkgnn9W3/B/igxeAke+qyGOsWi5C9uZGpnU
 dQYM9fvj3cPa4r8t7rrCWelSm1Yf/gHLFHuzAl7FkdFQkSs78FHPdxbk9dpI4QvuE6cX
 FVjZKWgeHWcJ8vWeXblIs3L3jnr/XLpgD/cjEvmhLH21+4VtUeNWfASz3lJxgdYTROZv
 wrrw==
X-Gm-Message-State: AOJu0YwkxBQIxExD/eBiTKYS8ReqOaYMubOijCWxqqpcz2wUkfWduotd
 vZMcGweF3IKpANAdVGmjUARkVQtGAjRSGF2BDYcMkP279UH5Ve55ILtPd5F9u8PvZEtsCGxEGKu
 9c14cH+mRMwUKpG9lm3jQBy7KVo/oKIaDoABJ/qx7MkzQN7bhCbNrnXrRbiefWZ0CVUd2LSS2Us
 O6E4mV213bXFkjDs4cuOUhpuSQ7srTFA==
X-Gm-Gg: ASbGncveTL/fEVVomlX2J5ZdNsTLD95NYISP9pi9Hwt6JeIWD19nGKRB+yH1iNLdBka
 6YHmcR2peYa3ZxPe7CSb8WCkZXS/M7SSzWbtMn4ZjJvE6apHV2MsYYVAad5VI+Pyq/MuPX20/IS
 K+rfB8rQ==
X-Received: by 2002:a05:6512:4007:b0:553:5135:6a0e with SMTP id
 2adb3069b0e04-5550b869bd5mr6045321e87.4.1751369862691; 
 Tue, 01 Jul 2025 04:37:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+BIqGp4i3D5q6zrwvv1YGsNhvWCaW3kKSskwChMGeF7XQeZShsa2mgg3uwhPEFkKzETzlyM4vR0IyuHPcbXc=
X-Received: by 2002:a05:6512:4007:b0:553:5135:6a0e with SMTP id
 2adb3069b0e04-5550b869bd5mr6045308e87.4.1751369862149; Tue, 01 Jul 2025
 04:37:42 -0700 (PDT)
MIME-Version: 1.0
References: <20250701113146.1268492-1-david.marchand@redhat.com>
In-Reply-To: <20250701113146.1268492-1-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 1 Jul 2025 13:37:30 +0200
X-Gm-Features: Ac12FXxtt2ZDMUTGsHSxRpTifkBI33uzKxNUFuxNcYQyido-m-TFe2ZHXl8TSt8
Message-ID: <CAJFAV8yEDadxrpNjnjOkqna8vDdf8gEgdSLB-250-o9x+ZccoQ@mail.gmail.com>
Subject: Re: [PATCH] ci: check C++ headers with clang
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, Aaron Conole <aconole@redhat.com>, 
 Michael Santana <maicolgabriel@hotmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5-8KcWHtuO6PmN13MwMtUHlqGsWp21D09BpsIF7HblE_1751369863
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

On Tue, Jul 1, 2025 at 1:33=E2=80=AFPM David Marchand <david.marchand@redha=
t.com> wrote:
>
> If not passing an explicit compiler for C++, meson uses c++ which
> defaults to /usr/bin/g++ on a Ubuntu system.
> Explicitly choose which compiler to use for C++.
>
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
> Depends-on: series-35592 ("node: fix C++ compatibility errors (option 2)"=
)
>
> ---
>  .ci/linux-build.sh | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/.ci/linux-build.sh b/.ci/linux-build.sh
> index e9272d3931..6156fc0e80 100755
> --- a/.ci/linux-build.sh
> +++ b/.ci/linux-build.sh
> @@ -54,6 +54,12 @@ check_traces() {
>
>  cross_file=3D
>
> +if [ "${CC%%clang}" !=3D "$CC" ]; then
> +    export CXX=3Dclang++
> +else
> +    export CXX=3Dg++
> +fi
> +

Looking again, it may be safer to move this block in the
check_includes branch (wrt cross compilation targets, though I would
expect the cross config file to override any CC or CXX variables
content).
But let's see what the CI has to tell with this first revision.

>  if [ "$AARCH64" =3D "true" ]; then
>      if [ "${CC%%clang}" !=3D "$CC" ]; then
>          cross_file=3Dconfig/arm/arm64_armv8_linux_clang_ubuntu


--=20
David Marchand

