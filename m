Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F7FDD58E48
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Mar 2026 16:50:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 30B2F4025F;
	Mon,  2 Mar 2026 17:50:33 +0100 (CET)
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com
 [209.85.167.181])
 by mails.dpdk.org (Postfix) with ESMTP id 8D701400D7
 for <dev@dpdk.org>; Mon,  2 Mar 2026 17:50:32 +0100 (CET)
Received: by mail-oi1-f181.google.com with SMTP id
 5614622812f47-4648448e387so3524545b6e.1
 for <dev@dpdk.org>; Mon, 02 Mar 2026 08:50:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772470232; cv=none;
 d=google.com; s=arc-20240605;
 b=MPDTbEuSxGlhO1/yKY3jxLARloQWgEiMBlVWZR+iUpw8lUdabinyABQX1d3R3yBgV6
 SaENrt3sxcRxiJZDXXsA0WKMODp+ZSwa/1CoWB+V2hAM66Uh6usjjLrRmmxE8jbrHzfp
 UjVDCUByuEqO4uJfmOwXJzkNOKLMQ/uxfBVohjJ+A+zIK+M7a5swpnPaNtoPTxSjFlZS
 Tt+qF6FG56kkryYqSPImEtyW9KQFeczABEfE+UgAu+U0ArwRd3JPVgBaaGbdHZ3NvNoR
 PYjsoXrEDZ2ymWydO9SuOdeJcu8GxBSzzioZY2UrglEA4QKhV9cjfTmdPEByhImpWARG
 c7JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GaudJsFQ7PRZIHjC76C3E7Q9dlf41PtK/9kK2DMkabQ=;
 fh=49UfdALgzMjI7gPveT70gPgnEqS0rtIiBrh8PDEN8Gk=;
 b=QMdN+mlFtqzB7q/mUqWjrK6S04GbDc0wKl9QgzfbVx9iJ/+ZXIELu1i0Hj6U8eaywL
 yo2OKuFKbR5DUljf2xk3MyUZGzZRN+zTxtmiVqZGxkILAoHcKo056VO7jJ/hRGIkt1xy
 OS0uXH3CrMReqYlYRmDO0K6BttAwk9+cuOcTV+q2H32UFWNb4FYC7EsI8s+HMNKip+8a
 aWm4J/+AWZDwJMLM6lYqKt25IWqA63KS+Yer1b6K9DpBCs36uNOjgQ8LhRPalN6gVFVw
 7Syu3ptMqSsnPU0l0usMe00dUM2RJmJUaIegNIYVdlfI5NW+JAlRRh7kRk0WsqcVDI4X
 CAvA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772470232; x=1773075032; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GaudJsFQ7PRZIHjC76C3E7Q9dlf41PtK/9kK2DMkabQ=;
 b=RydOFOlmmtQYK8EryRlxOB27LxoX3/jkF5LtG0agG2b+6+r6u4MnLF81Oqlyw95IFe
 gjvDqAWKaQoX39v8ZCpmpfIq5Ty/M1tBlrBQmqKn7M8R09xdw8Byy2JT2KHP3kg/Blbq
 ccRrRov6vgIexYp+gI7c02Pcz0S77TFDK9CJvBVJvs9iU8JV6GCgaW/Rlk76HGuIAplE
 qeSBXH74uNV7H3FHu72EXBpt2OCiuvuLRNmRYG15GqjEtxCcyRkYPO+5pOpiEX1pEtrt
 jVQiIVHe6zQgPkIdBEBp0Y25jKQSscdUySuIG6+onHMrzM3uqWc0YsoHBMMMz/5CyQxc
 MzeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772470232; x=1773075032;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GaudJsFQ7PRZIHjC76C3E7Q9dlf41PtK/9kK2DMkabQ=;
 b=nUNvHdEMDTiA54sGm4lP28fw+FRH3GyL4bo5mbtQeFnSXLR7pUZNZjc8Ifldty7wYC
 uPp1EsCgFNFBz2ifNPJO0IaDrHaRKeF60g+9OO1gqoQNyWZyzNKs57M/bn1ofLWanJfA
 Jn8WB6QSzyAI8aofNfuU9cerqgBMLDlwkyiz95oRkRZY9hITkPohlgTmIZYgJ9IE/1ya
 hrpPef6+94nmAnd0OIdZ8tvYumHalDgWiDV8DMcKAS4OLZ/hjKsDgz8TAyBXq3WLa2lT
 kcauIzTAR5f9okxvBf6k258449xfraxLc6wEl6konrEeaxx7Bdbt82on255ltiVcyDjM
 q59w==
X-Gm-Message-State: AOJu0YzClrV7+pEoeWjTfq2YrRL/M0XrDsm/bWpZl1sddAbqkBSGPzui
 dYYK9/9Qo/gO6YhBkM24BQ9AmfBOGuBPtp0fRJO8raayDAXH0A5K7w4saVnlZhchGASNQTc/KEl
 OnEaXIQUKx+0J4eUbgtJjOH7VM0wSFxY=
X-Gm-Gg: ATEYQzyB1K1Y1XqXWoT1hNmInmjoVUzLT70yjBXcfWb4FiPTu1Lnfng0aJIZrIf3y+x
 sxHc3x6Yb8X2mCtxRJarAu6DKiW9QAUAHqPe2F9QKFR9UBbCpIbJJ9xUBYa3qdYhc6U3VE+L8NU
 qm1Wx7WK2oJmIz08tLmXmKQQfCKlUOcPu3iahJrcrDkMlMxq5udi6XJEqGyOtKrGYUOeaho1/90
 w/52pAkoiD3Na0jaBgn0mouUwOvMI58eq2+mB3b7Is8A2CwQOHXgMxgiqmB2Vg59iC5qFldCfDd
 vTQ=
X-Received: by 2002:a05:6808:1493:b0:45e:e15e:4ab2 with SMTP id
 5614622812f47-464bebaf90fmr8595536b6e.45.1772470231553; Mon, 02 Mar 2026
 08:50:31 -0800 (PST)
MIME-Version: 1.0
References: <20260120195418.466318-1-stephen@networkplumber.org>
 <20260205175750.653353-1-stephen@networkplumber.org>
 <20260205175750.653353-4-stephen@networkplumber.org>
In-Reply-To: <20260205175750.653353-4-stephen@networkplumber.org>
From: Nithin Dabilpuram <nithind1988@gmail.com>
Date: Mon, 2 Mar 2026 22:20:20 +0530
X-Gm-Features: AaiRm51akxYJJFAZvN-xm35JeL_kV-vC-HYN0O8QzgRXOehxbHm7tsue_s9jI6I
Message-ID: <CAMuDWKQKw3Fs9zt1C2cPWqg0rLn9gk7LUgvBKqCJm8aN1U1AtA@mail.gmail.com>
Subject: Re: [PATCH v6 3/6] common/cnxk: re-enable vla warnings
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Nithin Dabilpuram <ndabilpuram@marvell.com>, 
 Kiran Kumar K <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, 
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
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

Acked-by: Nithin Dabilpuram <ndabilpuram@marvell.com>

On Thu, Feb 5, 2026 at 11:28=E2=80=AFPM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> The code in common/cnxk no longer uses VLAs.
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  drivers/common/cnxk/meson.build | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/common/cnxk/meson.build b/drivers/common/cnxk/meson.=
build
> index 2b33022eb7..9db77a9702 100644
> --- a/drivers/common/cnxk/meson.build
> +++ b/drivers/common/cnxk/meson.build
> @@ -94,7 +94,6 @@ sources +=3D files('cnxk_telemetry_bphy.c',
>                   'cnxk_telemetry_sso.c',
>  )
>
> -cflags +=3D no_wvla_cflag
>  cflags +=3D no_shadow_cflag
>
>  if meson.is_cross_build()
> --
> 2.51.0
>
