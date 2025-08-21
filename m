Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC9DCA0EEB
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 Aug 2025 15:35:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 786B4402BD;
	Thu, 21 Aug 2025 17:35:33 +0200 (CEST)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51]) by mails.dpdk.org (Postfix) with ESMTP id 9668F402B1
 for <dev@dpdk.org>; Thu, 21 Aug 2025 17:35:31 +0200 (CEST)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-3c380aa1ad0so647443f8f.3
 for <dev@dpdk.org>; Thu, 21 Aug 2025 08:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755790531;
 x=1756395331; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ajjyQU5TqAroicseuVnpqDAgHMTDP2x5Rs0MtS/EWok=;
 b=sS5IlKQP2GBNvIAxvAri+BzXWnYLwMeoDOgGM1v3TGC8J60p+QJbdMkwR0X3UMrpQp
 UnChtGSU45Ssr8EnVdd1THEZXCCeCbb5WlR1rvKNTlhZUpuQKNBSOLVWenAJMpkBf1xx
 /6C9h3R2dtjnI+bTAAjTn9/hSAWFRO2VWacMBHOv2/Bx6snPKOyOtUg2NRIq+BIBAUiC
 bwdBiWSlCT2bIQcu+6BFzbVAkOU8OeIGydpx4krBnYOhzhF9DIFKk+cWO/f3fuf+0w1/
 NH2jbwY3h6ehB9pg3Qe99wnmlDrrOjVxtxevA8y18UT5tqb+zXrqhS+Zm0vJRdfYqaAA
 1YwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755790531; x=1756395331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ajjyQU5TqAroicseuVnpqDAgHMTDP2x5Rs0MtS/EWok=;
 b=dyGEOOfTUi1oXFXJhRC6fpS0QqAFHSTATf7o/tJRNKsu7fVpacvlkm1RE0ysWQyZZB
 qy4av6n6uZ6QMFa1guy93HDPbDXzqY2NOrubbwjwAfG8+Facz3miViRof1qLXlptnP4i
 OFvMZ+H6OLns78EwrTe2FRB6zu7A2dfUnoGo59X4RvGryXynKTnmhStJ+yEUp+Q6ZXk/
 VXFVc4t+f2bzYYIoZi0Y9vp8L8zHzH4Jld5wVZv0QPlTU03dzB4oaCaCzYZz2AJkyPsp
 +/s0RvCn7FnSo413z5tdwWn+I+ohviVz+p7S/BcC0dOGhaH6ymHTqOI5606MGqag69iP
 xVnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHm4ZiIgmJGMP60SkcmnZYIVQ53mDAX0AQ/33iFRYB7L/H1YW7UgVYk1zG+9h0J9Fnl5U=@dpdk.org
X-Gm-Message-State: AOJu0YxrbMDzQ/IK8kNCAChnK2eNCLY4ggNtYFjLSvYQa4h2IEe0G5+5
 fmwJWz3+KrcwPZ5nMEmQ3FNrUcgXJDhp5FpZi2YU0Y/2oEDb1J7ebAog4VDdoA+Tbx4=
X-Gm-Gg: ASbGncuFIFgqQhR37wEOlXxAUPyYnpzDMfKC4s7GUAlHEQZW0GUFAvpjkK4GQWBwnns
 x3F6KlxaHHXzMb4iH7bJrUOROl1Xh+HoeIQCX4cnRvnNQuTmrI0yUyJYogijO768lPaWZVwG562
 vmfDvUxQXAPVwPNIHimCuqVXiVEwk/CkIGvbiWY2GMIOcnGGdayUVjcSIwWDLiUJzH1dJwgHa/y
 +gWbYT0GCzB6WachHjwTUUV9ss6dtR1a31xvJ0EIY7WUX55AniCutmSQZiefhXbGlC0xMAVRNkt
 f7C1lCn9thibureEcq4GkEkXojJhdyxGcmbtSv2pEjInelYwYFtB1sI9lL9faD1OAGToYn8ll6/
 l4iEQxskxUPmzdJYaREVr98MvEiTUEIe5o1XJC5jNZU9EDmwXgUk/Dpp4r55NlJVYiygMkE8s16
 0=
X-Google-Smtp-Source: AGHT+IGDpQff90bI/g6u1z0zFnjL+wFjpQ6mKDquPG628ma6DQB6wnBDpeWwmDDb4ZjM6gDrfemZrA==
X-Received: by 2002:a5d:64e3:0:b0:3b7:8832:fde6 with SMTP id
 ffacd0b85a97d-3c49433ee08mr2549423f8f.13.1755790530924; 
 Thu, 21 Aug 2025 08:35:30 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b50dce6c2sm1482225e9.6.2025.08.21.08.35.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Aug 2025 08:35:30 -0700 (PDT)
Date: Thu, 21 Aug 2025 08:35:25 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Tejasree Kondoj <ktejasree@marvell.com>
Cc: Akhil Goyal <gakhil@marvell.com>, Anoob Joseph <anoobj@marvell.com>,
 Aakash Sasidharan <asasidharan@marvell.com>, Nithinsen Kaithakadan
 <nkaithakadan@marvell.com>, Rupesh Chiluka <rchiluka@marvell.com>,
 Sucharitha Sarananaga <ssarananaga@marvell.com>, Vidya Sagar Velumuri
 <vvelumuri@marvell.com>, <dev@dpdk.org>
Subject: Re: [PATCH v2 0/8] fixes and improvements to cnxk crypto PMD
Message-ID: <20250821083525.094aeabe@hermes.local>
In-Reply-To: <20250821061341.3790775-1-ktejasree@marvell.com>
References: <20250821061341.3790775-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Thu, 21 Aug 2025 11:43:33 +0530
Tejasree Kondoj <ktejasree@marvell.com> wrote:

> Adding fixes and improvements to cnxk crypto PMD.
>=20
> v2:
> - Fixed coding style issues.
>=20
> Nithinsen Kaithakadan (3):
>   common/cnxk: get context ilen as devarg
>   crypto/cnxk: fix compilation error and warnings
>   crypto/cnxk: align cptr to 256B in cn20k
>=20
> Sucharitha Sarananaga (3):
>   crypto/cnxk: add new API to get fpm tbl address
>   crypto/cnxk: add new API to get EC grp tbl address
>   crypto/cnxk: refactor rsa verification
>=20
> Tejasree Kondoj (2):
>   crypto/cnxk: align PDCP API with latest firmware
>   crypto/cnxk: support custom metadata with CN20K
>=20
>  doc/guides/cryptodevs/cnxk.rst               |  11 +
>  drivers/common/cnxk/cnxk_security.c          |  20 +-
>  drivers/common/cnxk/cnxk_security.h          |  25 +-
>  drivers/common/cnxk/hw/cpt.h                 |  14 +-
>  drivers/common/cnxk/roc_cpt.c                |   8 +-
>  drivers/common/cnxk/roc_cpt.h                |   5 +
>  drivers/common/cnxk/roc_se.h                 |  37 +-
>  drivers/crypto/cnxk/cn10k_cryptodev_ops.c    |  16 +-
>  drivers/crypto/cnxk/cn10k_ipsec.c            |   4 +-
>  drivers/crypto/cnxk/cn10k_tls.c              |  16 +-
>  drivers/crypto/cnxk/cn20k_cryptodev_ops.c    |  20 +-
>  drivers/crypto/cnxk/cn20k_ipsec.c            |  80 +++--
>  drivers/crypto/cnxk/cn20k_ipsec.h            |  15 +-
>  drivers/crypto/cnxk/cn20k_ipsec_la_ops.h     |  41 ++-
>  drivers/crypto/cnxk/cn9k_cryptodev_ops.c     |   4 +-
>  drivers/crypto/cnxk/cnxk_ae.h                |  15 +-
>  drivers/crypto/cnxk/cnxk_cryptodev.h         |   1 +
>  drivers/crypto/cnxk/cnxk_cryptodev_devargs.c |  49 +++
>  drivers/crypto/cnxk/cnxk_cryptodev_ops.c     | 130 ++++++-
>  drivers/crypto/cnxk/cnxk_se.h                | 340 +++++++++++++------
>  drivers/crypto/cnxk/rte_pmd_cnxk_crypto.h    |  96 ++++++
>  drivers/net/cnxk/cn10k_ethdev_sec.c          |  14 +-
>  drivers/net/cnxk/cn20k_ethdev_sec.c          |   8 +-
>  23 files changed, 725 insertions(+), 244 deletions(-)
>=20

I have been doing test builds with more warnings enabled.
These drivers have a lot of shadowed variables which are often a source of =
bugs.

In file included from ../drivers/crypto/cnxk/cnxk_cryptodev_ops.c:30:
../drivers/crypto/cnxk/cnxk_se.h: In function =E2=80=98cpt_sm_prep=E2=80=99:
../drivers/crypto/cnxk/cnxk_se.h:1160:41: warning: declaration of =E2=80=98=
src=E2=80=99 shadows a previous local [-Wshadow]
 1160 |                         const uint64_t *src =3D fc_params->iv_buf;
      |                                         ^~~
../drivers/crypto/cnxk/cnxk_se.h:1105:24: note: shadowed declaration is here
 1105 |         const uint8_t *src =3D NULL;
      |                        ^~~
../drivers/crypto/cnxk/cnxk_se.h: In function =E2=80=98cpt_enc_hmac_prep=E2=
=80=99:
../drivers/crypto/cnxk/cnxk_se.h:1330:41: warning: declaration of =E2=80=98=
src=E2=80=99 shadows a previous local [-Wshadow]
 1330 |                         const uint64_t *src =3D fc_params->iv_buf;
      |                                         ^~~
../drivers/crypto/cnxk/cnxk_se.h:1200:24: note: shadowed declaration is here
 1200 |         const uint8_t *src =3D NULL;
      |                        ^~~
../drivers/crypto/cnxk/cnxk_se.h: In function =E2=80=98cpt_dec_hmac_prep=E2=
=80=99:
../drivers/crypto/cnxk/cnxk_se.h:1487:41: warning: declaration of =E2=80=98=
src=E2=80=99 shadows a previous local [-Wshadow]
 1487 |                         const uint64_t *src =3D fc_params->iv_buf;
      |                                         ^~~
../drivers/crypto/cnxk/cnxk_se.h:1369:24: note: shadowed declaration is here
 1369 |         const uint8_t *src =3D NULL;
      |                        ^~~
../drivers/crypto/cnxk/cnxk_se.h: In function =E2=80=98fill_digest_params=
=E2=80=99:
../drivers/crypto/cnxk/cnxk_se.h:3233:34: warning: declaration of =E2=80=98=
src=E2=80=99 shadows a previous local [-Wshadow]
 3233 |                         uint8_t *src, direction =3D 0;
      |                                  ^~~
../drivers/crypto/cnxk/cnxk_se.h:3200:14: note: shadowed declaration is here
 3200 |         char src[SRC_IOV_SIZE];
      |              ^~~
../drivers/crypto/cnxk/cnxk_se.h:3273:39: warning: declaration of =E2=80=98=
space=E2=80=99 shadows a previous local [-Wshadow]
 3273 |                         int32_t dlen, space;
      |                                       ^~~~~
../drivers/crypto/cnxk/cnxk_se.h:3190:18: note: shadowed declaration is here
 3190 |         uint32_t space =3D 0;
      |                  ^~~~~
../drivers/crypto/cnxk/cnxk_se.h: In function =E2=80=98fill_raw_fc_params=
=E2=80=99:
../drivers/crypto/cnxk/cnxk_se.h:3576:12: warning: this condition has ident=
ical branches [-Wduplicated-branches]
 3576 |         if (is_kasumi) {
      |            ^

