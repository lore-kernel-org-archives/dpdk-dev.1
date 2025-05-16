Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00DAC3ABD8
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 May 2025 08:09:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 29B74402DE;
	Fri, 16 May 2025 10:09:27 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id A660C400EF
 for <dev@dpdk.org>; Fri, 16 May 2025 10:09:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747382965;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tttm9TgA48bviPpR5+iARb1okawf9k4GmSvAkcDfCIE=;
 b=WCKAE/MHBi+CQ3AvzmaeAOuWo7gKz8SduAQqMfcbv/2dzcm8bqL/q9MDKeZsisJQBtmiC0
 w5NIvSoz4PcpyRZG2X1+TymBEeD72uWrYsmQAeJ2RrESVAWAxRIjsT+TU6FXXBedWTaAvE
 k3/x8CIT9OvHIQ3DJQBIA3x4iJ7aQFo=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-6ww1SmCIMk2gsTEnkog6ZA-1; Fri, 16 May 2025 04:09:23 -0400
X-MC-Unique: 6ww1SmCIMk2gsTEnkog6ZA-1
X-Mimecast-MFC-AGG-ID: 6ww1SmCIMk2gsTEnkog6ZA_1747382962
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-3280a1d3304so3068271fa.3
 for <dev@dpdk.org>; Fri, 16 May 2025 01:09:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747382962; x=1747987762;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tttm9TgA48bviPpR5+iARb1okawf9k4GmSvAkcDfCIE=;
 b=cJG49jHTXXJeu/hBYteke5E78B0JI7nR3PDoKiTNWMha1O+9JJJC8+/OjbF3oLaN4g
 zdA3aEOOG0FJkME65b1w4wdxNGJbQYhxBjFDtR2hmaXEGLqak8m8lSdSXW7+iApoK3kQ
 pCckgugh+dZjXV6h4U+xjXIensdfCs3dn3BUztStl4PN5/15SZ3yrTfbezdI23ZHzxzZ
 m2BlRM732+UM1j2sbLDKtcCGeCaGdD0qzowsELXq2bdxhdkjmLfqXQVACvP/0//BMwfr
 WLj5avyCt33szBHu/gtr75UsDqSRABTHSbiA3Ked2SUcRZNY5jMZDxwm1MbIfNORuG+E
 HIrA==
X-Gm-Message-State: AOJu0YwM6StTOKexliY9qu7hpvyWGn0DzNqPmbwx6dUmwVPCT4Wg4OPR
 80Oxvvu4meBUp4Rn16h/dlHeOQrqMkXgZ4Zhn9oyEo5ixmQZQF5jtQQ1Urf3C+/XhODN8Al+Mrz
 a+/4BOf0qJSs0f/M9zo86vxLlLP7jX/1uo/FgbD17iqjKCBpI1CjZ0IZIzrMEJORxD0XQpz4LAa
 OJVEz5vxILaiOMzl+A760=
X-Gm-Gg: ASbGncsTHwPxa3tX6X+CQPy0vfYfdPtzpyY7QmfWJ2SxCDKeWe5wJF8RmwRWtffTZ1D
 M6m41fQ1WofBdX1FVXxwNm7enTTeSxVnXJ3DZYrTsZzzJtUvHHUg75cHnpC57UxNCV2wjeXY=
X-Received: by 2002:a05:6512:2286:b0:545:60b:f381 with SMTP id
 2adb3069b0e04-550e71d2f97mr740198e87.29.1747382962231; 
 Fri, 16 May 2025 01:09:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSP+s+/YRDxC2xk+hI3p6+qE1YB9R5CC9i3e3Fb4DYjE/MUwZS9fui5wpQczNA6ntej8jTyXIX7TuSaiZFUWQ=
X-Received: by 2002:a05:6512:2286:b0:545:60b:f381 with SMTP id
 2adb3069b0e04-550e71d2f97mr740189e87.29.1747382961817; Fri, 16 May 2025
 01:09:21 -0700 (PDT)
MIME-Version: 1.0
References: <1744401578-30459-1-git-send-email-andremue@linux.microsoft.com>
 <DS0PR18MB5502FE130E5E4877DF9EB25EAEB22@DS0PR18MB5502.namprd18.prod.outlook.com>
In-Reply-To: <DS0PR18MB5502FE130E5E4877DF9EB25EAEB22@DS0PR18MB5502.namprd18.prod.outlook.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 16 May 2025 10:09:09 +0200
X-Gm-Features: AX0GCFsYCO16bA7RnaQFdCwkB-5ScJN8So2PNxynmppCGWjEBjh3tqLzJZ94_gg
Message-ID: <CAJFAV8wy=z7FW0MAv5sLfLxUnqrG-zwNDRQM84JH95Urz_-jJA@mail.gmail.com>
Subject: Re: [EXTERNAL] [PATCH] mldev: enable to be compiled with msvc
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>,
 Srikanth Yalavarthi <syalavarthi@marvell.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rIZ4s0vsqgr8ltEorYYSDYuJeHSX_QvWGfptIKmhqg0_1747382962
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

On Tue, Apr 15, 2025 at 6:05=E2=80=AFAM Srikanth Yalavarthi
<syalavarthi@marvell.com> wrote:
>
> > Now that the issues preventing this lib from being compiled with MSVC
> > are solved, it can be enabled.
> >
> > Signed-off-by: Andre Muezerie <mailto:andremue@linux.microsoft.com>
> Acked-by: Srikanth Yalavarthi <syalavarthi@marvell.com>

Applied, thanks.


--=20
David Marchand

