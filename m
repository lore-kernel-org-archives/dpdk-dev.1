Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4146BC7115B
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Jun 2025 14:03:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 722EF402E9;
	Mon, 23 Jun 2025 16:03:01 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 384B040151
 for <dev@dpdk.org>; Mon, 23 Jun 2025 16:03:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750687379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zf0yUAXLnjg60t+/ihiTey6qdUTDEEUwPBvlpkyS0PM=;
 b=EKYJGgh9gOps+USp/Zc5fbDooeNuj5uY500mxUo91ryq9v2Wri++Go9SBSgej2RdYFjs7w
 i2zI3DDE9Acfat6KXZplw+IhzZNBDbzbI5kqUIsazmjbMy0i4PTmO4ZoiAeYW0uQFhOTmA
 b5aKa+v7tpTnUaGIwA2U8o4i3qzan/I=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-0-dm5tVgNsG5dJ22HTcgxw-1; Mon, 23 Jun 2025 10:02:58 -0400
X-MC-Unique: 0-dm5tVgNsG5dJ22HTcgxw-1
X-Mimecast-MFC-AGG-ID: 0-dm5tVgNsG5dJ22HTcgxw_1750687377
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-32b30ead2fbso16137461fa.3
 for <dev@dpdk.org>; Mon, 23 Jun 2025 07:02:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750687377; x=1751292177;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zf0yUAXLnjg60t+/ihiTey6qdUTDEEUwPBvlpkyS0PM=;
 b=O8llcrqTfEMoOpBYo6bqxWZkBRODkBEbwNKSGdweEJssjejZNH7HfuuEPzZR87U/kk
 /zGHZLdX21O74EIqgjah8BS3/74XlyanTeM/cgvlpXbM7a8VilugI9JuMgtURusLmIQd
 ZjvK9I/Q/cVUTFLITCULrhz/bZR3Cr8WnrzUAOTGnlU8zNblYOBbyM+WhgQGaztrxBEw
 Cj53Yj+j9UGxG7ifwv2wNHCNQqyNTTecjKfrW3AFN/hRqgDN519AUK3EMvhQ455X7Ukt
 lmOCLgCeU01SGWBICIr9srKuuuKMCwIKRCJDxfq6lGtaFInQAG/U/siOPahDaEPOOZQ6
 n2CA==
X-Gm-Message-State: AOJu0YwmSLu3mgSivo80/W/AoqcMzUjXJPGPrjsm/yTZfkFx5ow4SIkb
 oWDG23kyMUTE3mlX5u33G5+QI9GxbprxHjUVOHdhriaUAK8AzDxOqpyEHS+ogxFS7/Dglehu7Pg
 lXkc6n9XEr7NMgniExC+z/vLKNjJGGGP9JwproIjLjuwrX19ALwTHuBA99f9CNMaGMb5BBT5UU8
 B8kow6Z36/+tc93N+Wu+Ca4Zz1VGA=
X-Gm-Gg: ASbGncvjiW2ETjI2rnvzyOrGCXLBizmBh82h1rg8/idPzon+uRRlwlZnMl9nJcmqfit
 Bqpb9EG8oNHK3Z7ZJ1IzK0G3Y10m0ZeHrLvWbYTqyHNS8kR7Sd7SlruaO6gUMpg3F6Fsupw4JqR
 PhtVN6Mw==
X-Received: by 2002:a2e:a7c1:0:b0:32b:43a3:68a1 with SMTP id
 38308e7fff4ca-32b98cb3b7dmr34840541fa.0.1750687376233; 
 Mon, 23 Jun 2025 07:02:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmf19sJ6QYFTNmxCCbkz1n3MlJyZTZA+fvgqnbOzv+7qR/P5Mm3FrsFDPwfYkp0bJfnBd3ZqSCsy87mNC/1o0=
X-Received: by 2002:a2e:a7c1:0:b0:32b:43a3:68a1 with SMTP id
 38308e7fff4ca-32b98cb3b7dmr34839811fa.0.1750687375415; Mon, 23 Jun 2025
 07:02:55 -0700 (PDT)
MIME-Version: 1.0
References: <1735243903-26857-1-git-send-email-andremue@linux.microsoft.com>
 <1749737842-30538-1-git-send-email-andremue@linux.microsoft.com>
In-Reply-To: <1749737842-30538-1-git-send-email-andremue@linux.microsoft.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 23 Jun 2025 16:02:42 +0200
X-Gm-Features: AX0GCFtLABsXztu5ajvXiJsDR4PO3rCImfnXDzApy65RnD0vjo39cr7KlRWJt0A
Message-ID: <CAJFAV8z6duPF8ENY6jTKgVzOpGDaZ8r6iHQMrCwb_uqQ=C4mHg@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] enable drivers to be compiled with MSVC
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: T9AMdqXsJYA9XtKVZBpTqfYfnDvXQfQmc64a1FdgYG8_1750687377
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

On Thu, Jun 12, 2025 at 4:17=E2=80=AFPM Andre Muezerie
<andremue@linux.microsoft.com> wrote:
>
> This patchset solves the last issues preventing drivers from being
> compiled with MSVC (array range initialization) and enables the
> drivers to be built with it.
>
> Array range initialization is non-standard and is not provided by
> all compilers. MSVC does not implement it and ends up emitting
> errors like the one below:
>
> drivers/net/r8169/r8169_phy.c(380):
>     error C2143: syntax error: missing ':' before '...'
> case CFG_METHOD_48 ... CFG_METHOD_57:
>
> The fix is to explicitly initialize each element in the range.
>
> v3:
> - Add a patch to enable drivers to be compiled with MSVC.
>
> v2:
> - Rebase on top of latest main.
>
> Andre Muezerie (3):
>   app/test: remove use of non-standard array range initialization
>   drivers/net: remove use of non-standard array range initialization
>   drivers: enable drivers to be compiled with MSVC
>
>  app/test/test_cryptodev_zuc_test_vectors.h | 156 ++++++-
>  drivers/meson.build                        |   4 -
>  drivers/net/octeon_ep/otx_ep_mbox.c        |  24 +-
>  drivers/net/r8169/base/rtl8125a_mcu.c      |   8 +-
>  drivers/net/r8169/base/rtl8126a.c          |   5 +-
>  drivers/net/r8169/r8169_ethdev.c           |  34 +-
>  drivers/net/r8169/r8169_hw.c               | 447 ++++++++++++++++++---
>  drivers/net/r8169/r8169_phy.c              | 163 +++++++-
>  drivers/net/r8169/r8169_rxtx.c             |  25 +-
>  9 files changed, 770 insertions(+), 96 deletions(-)

Recheck-request: rebase=3Dmain, iol-compile-amd64-testing, iol-unit-amd64-t=
esting

--=20
David Marchand

