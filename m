Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49439CD342C
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 May 2026 04:52:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 30CB74026D;
	Thu,  7 May 2026 06:52:18 +0200 (CEST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com
 [209.85.208.176])
 by mails.dpdk.org (Postfix) with ESMTP id 79C8140265
 for <dev@dpdk.org>; Thu,  7 May 2026 06:52:17 +0200 (CEST)
Received: by mail-lj1-f176.google.com with SMTP id
 38308e7fff4ca-38be5e86918so4238291fa.3
 for <dev@dpdk.org>; Wed, 06 May 2026 21:52:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778129537; cv=none;
 d=google.com; s=arc-20240605;
 b=LvuNtK+DYtqQTQmCw7fOdr4bFPaE8yGLGjrR9cUSKJdhO8+tt1FIoWWAoiHFSZRF9K
 z42YFW0GUQ6BqZrFiGds3OXlINLXo6aDWxExuUdUMtPn2TQwFKaTEJJ3Fxs/oD//OknV
 RqI8ApFcSfV7dYx1g+kft4etrtN1U4DjN+o8YNg55W/wi0F2zw95QNPSBxynIJ29sDlX
 /OZFM0Tc1vEnq3c7TvLVbNtI0QoOmwOIiCIFa/vUVCvdvIijjr9u39JCiNApvztkkJj0
 ZkWIycrd0k/cXcbDLmif55ah6AG8O4k8RIOeYosKmsEG9C9Va8nInKZE22N9A02y9D5O
 6wHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mAvkR81Ec8FZfQstFzul5hWdGYx4UySkawg0SaI5N38=;
 fh=XYr84m3B/UHoc2lCDe0rBctGDcHZDfdVePN+zFDZ4UQ=;
 b=H5UVrVOTF35nCLrM8kWWZ0ZXsAUvDL4f8VYFpnDEV/kTD9DR6+viy3gY4iPZ3LAiZg
 70OyLotKWFNTkHuaZcDncfk0ew0dE6pEUKsRpyUC2T+qqzu2TdnWRgXHyOMjqwPq3EBD
 efdBJr3KptFsQbVD/dsvYLLf4kDGNeiUP8X9M9ZSg4EDdquVLmaYBupc+vf0pUe23zZg
 2WaoE4nGm/4k88FPbaA6Fsn0WaH+YAMB2T/t0BYCgVTTpiKhmxZ9FekbsGI/IHPKTKGg
 jTF4GFkwkPIPZFi12XFhhT/ejI4IGAazurtVUu+x4oP0EDfRxF5vxSsxZJHvL+58xdN+
 1H6A==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778129537; x=1778734337; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mAvkR81Ec8FZfQstFzul5hWdGYx4UySkawg0SaI5N38=;
 b=JwjOhLG+1bMvEbrBESx8jopfap9MN14zt2Al13y2yOcg0Nz+pYi+fab5Ka0ScsxT7a
 i7kgKX7R/zX1FtK+24Ci/JKj8ExwpjiztzTntLzxsamQTlv5JlnTjIQ+8BGMMzMCnkej
 mTJDbFead08DyqjWR7h6rS4TIFR4+3yIiZOIhsbWHAganEvZBsQMsk3/6fzDyithddpl
 rnWKhsex8jKXq2GQfPu4m+DRGGqRCETJ+M2l9UB+AqRApQs3JMK+PhxOnfpH+SFveKPj
 praaoN7ZbGPNgzTCun+pp7ObbuhZBcV/mqXUOE0qxaWjzFtj9dzsUI1zC/GvIGmPBCuO
 wioA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778129537; x=1778734337;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mAvkR81Ec8FZfQstFzul5hWdGYx4UySkawg0SaI5N38=;
 b=Z0/tgcq/DZ37X3owIjelWS2phq3imnJG/jV1UZwUxDbpUFxXlNfhaRteVog7WnluGL
 5i88QjknOIusN7Zb21p/RLopJHETdhlA3gMUUgCT5UDP8M6TqD3aBcQmv6AERnhc4SjU
 LhUMPVvT/6TcHnrgLL0qAWTvzvmdE4iiU6i/6w+OxCFpNovuPOcnUv6bFLEKK/be4I/z
 Eu68LQhjgHbVfD4+UbYceNUsPWg8UzOmSazrjdYZxJYqUYxMmujNJnmo4T4mPIsYn/9k
 F09DT9Rcmcdt9h1KvDpLnqRv7o/eZpBlncKuZaMoEJJJ8+wzM4fu44tdwCtfO19BRhFA
 ftkQ==
X-Gm-Message-State: AOJu0YwkbRE940wWms1xR/3BX1NFDGujQ0M/Ex6PY5Csb6VZI/B0lFBO
 uGPYr/Hlmr4W/QlviCcsNBscYdhuEd6LJoT5AxMoK+3mX2wi7kHmJwOdPIS/fXByf1Q2xLRXON6
 dqf+L9lYg5O7rUDoGyGPf0HY1KOS9dSs=
X-Gm-Gg: AeBDies6yCgIRYTtDdAwgLYkraO05Cnz6roNi9P24dAEXLXkdjXRVpbLZjzkz0k3mQJ
 csWU6V1lGANN/UScSFW8UDfjaXCyFDyXj3H8SPy2aepHxP5VZCcyGhWpLqW/64GZgZULiAFc7KO
 IoD6L7tDjb0BhL5NHregeW04UIx64uxbzQEp7WuzDq1ZulZoV7tZS/x3CTwMRU/1DBFSRA9XTpL
 vrdHbX2zRlCTVU6W140Sqyr5RFxmEwHm5C2faVcLA9JFp3Kr0L9/Gb+mSFCdJiVlb1HyP63CTkC
 9COyUSloDrfTt9XQUkWOBJfGuusRKtY3z6ErTUs=
X-Received: by 2002:a05:6512:128d:b0:5a8:6b81:6694 with SMTP id
 2adb3069b0e04-5a887ce5e99mr2109522e87.30.1778129536470; Wed, 06 May 2026
 21:52:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260401192401.6243-1-stanislaw.kardach@gmail.com>
 <7c10b2b5-71e9-4ef7-be7e-02da5bda7aaf@iscas.ac.cn>
In-Reply-To: <7c10b2b5-71e9-4ef7-be7e-02da5bda7aaf@iscas.ac.cn>
From: =?UTF-8?Q?Stanis=C5=82aw_Kardach?= <stanislaw.kardach@gmail.com>
Date: Thu, 7 May 2026 06:52:05 +0200
X-Gm-Features: AVHnY4KAOZxb4EJcq4xVZ-Rlj9KC-ouYEKAOix0tWLIGCa0ZBqxKZezgvfFGTRk
Message-ID: <CAJcPQBpyWh7YU0Ef2w7AHNCHGKN66koT-xS_wXVKBFwq1zLi7Q@mail.gmail.com>
Subject: Re: [PATCH] maintainers: update RISC-V maintainer
To: sunyuechi <sunyuechi@iscas.ac.cn>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>
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

Kind ping Thomas, would you be able to pull in this change so that Sun
can be unblocked?

On Thu, Apr 2, 2026 at 6:08=E2=80=AFAM sunyuechi <sunyuechi@iscas.ac.cn> wr=
ote:
>
> On 4/2/26 3:24 AM, Stanislaw Kardach wrote:
>
> > Change the RISC-V maintainer to Sun Yuechi and remove myself as
> > I'm unable to properly perform maintainer duties due to time
> > constraints.
> >
> > Signed-off-by: Stanislaw Kardach <stanislaw.kardach@gmail.com>
> > ---
> >   MAINTAINERS | 3 +--
> >   1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 0f5539f851..eeb55951b4 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -334,11 +334,10 @@ F: examples/*/*_altivec.*
> >   F: examples/common/altivec/
> >
> >   RISC-V
> > -M: Stanis=C5=82aw Kardach <stanislaw.kardach@gmail.com>
> > +M: Sun Yuechi <sunyuechi@iscas.ac.cn>
> >   F: config/riscv/
> >   F: doc/guides/linux_gsg/cross_build_dpdk_for_riscv.rst
> >   F: lib/eal/riscv/
> > -M: Sun Yuechi <sunyuechi@iscas.ac.cn>
> >   F: lib/**/*rvv*
> >
> >   Intel x86
> Acked-by: Sun Yuechi <sunyuechi@iscas.ac.cn>
>
