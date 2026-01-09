Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3379D232C6
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 Jan 2026 00:01:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 80BE040281;
	Fri,  9 Jan 2026 01:01:09 +0100 (CET)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52]) by mails.dpdk.org (Postfix) with ESMTP id 99BDD40279
 for <dev@dpdk.org>; Fri,  9 Jan 2026 01:01:07 +0100 (CET)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-42fb2314eb0so2973222f8f.2
 for <dev@dpdk.org>; Thu, 08 Jan 2026 16:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767916867;
 x=1768521667; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/1Sz8umHbkObYU3ypuOVQyRULd8ejmLzR85LEHELjg0=;
 b=DsWhfKaQF0gwqLJ6qHY3bAfBUFQatnDTzif0XYSK77ahDuBGWDsgAHwvgrYxzHg7Wm
 OrCEaP74mZ8gTmynKrfWJI5dAou4wQgv2zWNryDX4I+wftkVtZnacTdaH1VaRv23mphc
 dWEssuhAsSYSAWEYjisuxr1gC2DLLITKgXptGkSG/pcxxW/Wxn1VEtXFIiyVMpptZBAs
 IcnbDqM4JhV2gmpQo8UWQWjFSLQAFw9pq/ewiufXjEmv65saq7jGsiwIQRPdCbuFxM3I
 Mz4A5geYkAfyEtkQRakNfAf4iCk6QHMf8BXZPdSFS/SMOOOoSPPGgvoJlVbArbhR8NyK
 P59w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767916867; x=1768521667;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/1Sz8umHbkObYU3ypuOVQyRULd8ejmLzR85LEHELjg0=;
 b=ww7ZYgY71gedJALIr9pe6hqr6tnPi63zXuTpInQCjHRiaeF8YVBrqlgy9C8x72gPij
 9ZjCd4vUUKgOK6kCJRyZ6U0oDDzqCwZQSx4HfOgkuOxSRAK+/i4TwylvKDDd4Z1HCsjX
 vOPrGel6qDe5/uXefoIJhqyrDMb5n3HmGLozEJohvO1N6oG84aQGCE2SLNEj2q8v0WBs
 cdtdLOjwfQsvj7+aikgmgyulsY22fM3RmpykyO+Hv7jdLr+LaiUHHCjkdYNH+4hBtFjU
 ru3qSI/8J20P4ISQrIuvAAOzDltVUYoHRgkCGyE6sn1AOGEERj+nHQh82fdzz0Wil0BN
 C3EA==
X-Gm-Message-State: AOJu0YxA4gSdNqgY8Tf/74V5znn6Eakpic8SRF8ARV6KzJLStbwxFe/s
 50q89Ur72iyZMDi44hy6ZyffKJJ8jjFxNZFriaKDbhX1/Ke14JpixDEDC/8SgxfuCvcU5KpXim5
 x3NST
X-Gm-Gg: AY/fxX4qSnhthvXYUozT1DuDA0v0JFjUctCV4MZ3DheDos03BKLE/DM11wNHbdraziM
 fd3rX2vO43mLvIpxGsUkBw8VQaNq+5dEhF+CQrrPJhRsiBmmw7OZUEit71L57/nle5/sBUsh2Ta
 JJfYcqlh50l0kXTDb3I5H4CmOfJpyGIuCgVVp/e6KZkUxvQMGfETFjQ/ehqNh9EwhKc7+ZsGI3R
 zL84aVoDPdsRBycje83VlO0AkBwt2r946R/OVgPVWhvCYN2f5lzRZjNMAin+hD2VnNb78sj+16I
 Jo8d80W4oE0jVsbbR1hdt6u6KTT47LwkM3LjOzOD7EX1xynqk3EAf4DAw5/noQaXtQbR0prQtT2
 YQIETcUIftiVj7+YIJ4Df6Js2iX8l48zUEkbLj5iejQ7EqjX7+9PC8WUPDbtqDXIru5UDfDVBkt
 leFyh/Ok9nZtBtZE4+ks3xHbYL5xKellgFV/80F5uEAIiUqLjPKVY8mbAf8TVDK1Y=
X-Google-Smtp-Source: AGHT+IGccEpOCWFkjInRB+EHC5fJbHRHMMUnDFebrFNNP5sTBNOJ9BrSfvZjw1IbYhyLYrH7c+u/Sg==
X-Received: by 2002:a05:6000:2886:b0:42f:b581:c69a with SMTP id
 ffacd0b85a97d-432c378a894mr10607357f8f.5.1767916866961; 
 Thu, 08 Jan 2026 16:01:06 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0dade5sm19530643f8f.9.2026.01.08.16.01.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 16:01:06 -0800 (PST)
Date: Thu, 8 Jan 2026 16:00:58 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Scott Mitchell <scott.k.mitch1@gmail.com>
Cc: dev@dpdk.org, mb@smartsharesystems.com
Subject: Re: [PATCH v5] net: optimize raw checksum computation
Message-ID: <20260108160058.685cf7a7@phoenix.local>
In-Reply-To: <CAFn2buDp4ffHuSXmTrW8mfNHxm-t3FL=TVgMKFAc2gU7fyXPGg@mail.gmail.com>
References: <20260108061338.27217-1-scott.k.mitch1@gmail.com>
 <20260108081229.60b095b9@phoenix.local>
 <CAFn2buDp4ffHuSXmTrW8mfNHxm-t3FL=TVgMKFAc2gU7fyXPGg@mail.gmail.com>
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

On Thu, 8 Jan 2026 16:19:37 -0500
Scott Mitchell <scott.k.mitch1@gmail.com> wrote:

> On Thu, Jan 8, 2026 at 11:12=E2=80=AFAM Stephen Hemminger
> <stephen@networkplumber.org> wrote:
> >
> > On Thu,  8 Jan 2026 01:13:38 -0500
> > scott.k.mitch1@gmail.com wrote:
> > =20
> > > +#ifdef RTE_CC_GCC
> > > +     /* Suppress GCC -Wmaybe-uninitialized false positive. No assemb=
ly/runtime impacts. */
> > > +     asm volatile("" : "+m" (psd_hdr));
> > > +#endif
> > > =20
> >
> > Maybe rte_compiler_barrier() will do same thing? =20
>=20
> Agreed it feels like a compiler bug but looking for advice if I'm
> missing something :)
>=20
> My initial concern with rte_compiler_barrier is its a general barrier
> which may have broader impacts on
> optimizations and compiled code. Will that be an issue in this case? I
> wasn't sure and the approach
> in the patch is targeted at a specific variable and assembly from
> clang/gcc was the same. I will
> introduce a macro to make it cleaner and I can replace it with
> rte_compiler_barrier if preferred.

Maybe try with -fanalyzer and it might tell you more.
I suspect some of the aliasing setting are causing issues.
Some drivers are turning on no-strict-aliasing



