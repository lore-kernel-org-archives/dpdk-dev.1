Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 199F0C8303F
	for <dpdk-dev@archiver.kernel.org>; Thu, 28 Aug 2025 14:49:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C82C74025A;
	Thu, 28 Aug 2025 16:49:15 +0200 (CEST)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42]) by mails.dpdk.org (Postfix) with ESMTP id 4A782400D6
 for <dev@dpdk.org>; Thu, 28 Aug 2025 16:49:14 +0200 (CEST)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-45a1b05fe23so6390435e9.1
 for <dev@dpdk.org>; Thu, 28 Aug 2025 07:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756392554;
 x=1756997354; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4vhzLgR6BYazDqnWQL2B/Sh0Ksg+Zk2oOoMNZTiaKqA=;
 b=nfhw1ey5tA6LiQns6aZIyq9J5m7fpFaUMhIT2Wn7JpOOZC9YJD+hV8ZFUVRm6LtsrB
 4a0c2Di8KCo4L528sjWNT2FnkmopnTfnrbZzX8DSX2KxpBxui0gmvC5Mz80XHKxuX4YS
 /ZI759VAJ2ZrHcugZATLw2xWBjofubXTXG8Epo+OOBucAyNxb0ycLoedX0fcIO2d1BRb
 yrg5k7XYOHFdmt9eGmD1RCi9/TGsWGL0RDyoKy+JyqPaqOifeYrcf0dfTfEcunCg2G4g
 ws4dIGkztV1q2GWOEWub+6ypqrqImV4Q5DedWvEA1gW7RLOGVqCjy8ybLOu1wMD5BxA7
 1yWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756392554; x=1756997354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4vhzLgR6BYazDqnWQL2B/Sh0Ksg+Zk2oOoMNZTiaKqA=;
 b=gNzgXUNmh+k6F9+RumDMPY3eZg5PWQEzsKx2sYCw1Qu4tgukH/tTUq8DaKyK+HmXz8
 obifS2p+HRxmgXHNAfO5brrMtdLn1TCQnSoLF2ZhTRgphmlNTf/tlWFC28nNzdkGv080
 /dE/uCC47DyhPs0/jUt0iIlVZBReKb2pbWGj1ME9WPtAGujgxTZor+NL3rjqlCaPAxEY
 7eRxG7cpO6i6p///gmwQsRdu9l84pGS0zUtbduHsScU/fafIXMS2UC+EvUO4FISmWxuV
 MEaG4GqxlaNGJM8bRM0/TRATBErFWQkFDT2av670UaTTESz2Rt1au9z/p1kg3ZV0C6D2
 iHCQ==
X-Gm-Message-State: AOJu0YzYJ1SsF1nMLjhgeEfzps56W6iFl3+nGvC+lZ8ZZkSOj1hOcKhR
 U3uyikhZxKlYxqX2Z7DEQrTNVm9/9qj/KbFo5QzyPgT2eSg6N0z+w+UhdauNgOA/1Ieo75t74sS
 CqzFt
X-Gm-Gg: ASbGncvwUSKiebj6lETZTK0o0BmMVJrAepSuh8D3Zu7RK5JgOhcUgO6eM99sCbCK1RY
 /OPfo5C3wIOxI5MFoiWYjnOR4a937WppSkVVU+A5yugF/XDsruhWjYHv9JPrq7ASOcIkNs4pe9d
 NOfXjfg1/lS1/eDmwphyXIrrJVXW722Poe20G8rqh5ulkWWqB9jX62qoY69ahFn4JBOrz+w1DX+
 JVucoc8V5jeg62mu2fG0Y9AXfUmP2B7vk2hyykscy1QNSczwd5fqABw3Y0peu7/GIdUsCQtSBru
 dZl4j4ThuGb4AY/hNbqsufgDrhU1edJgkJwKLN7cpig2d/NyE2ZNJsW/Nx9EkM5b+jRiR2XtIao
 zDjrC6J28Bps4njeLNR8vgqgo163LmjL8yPC0qQmBkfCs3KWt1BFh1lYPto4a0APL6N6PIOx/WK
 4=
X-Google-Smtp-Source: AGHT+IH68gSlBLBMcFeKocK/fqAyEvWYuOahxHcAUJJHIDcPls8WiIJUvbgxJydQ9jD2/23bFsQL1w==
X-Received: by 2002:a05:600c:1c25:b0:458:bc3f:6a7b with SMTP id
 5b1f17b1804b1-45b72e9ae0bmr49140775e9.18.1756392553654; 
 Thu, 28 Aug 2025 07:49:13 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b79799c33sm35187745e9.5.2025.08.28.07.49.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 07:49:13 -0700 (PDT)
Date: Thu, 28 Aug 2025 07:49:10 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: <dev@dpdk.org>
Subject: Re: Ubuntu 20.04 EOL
Message-ID: <20250828074910.49eff575@hermes.local>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FE7E@smartserver.smartshare.dk>
References: <20250827213430.41806a48@hermes.local>
 <98CBD80474FA8B44BF855DF32C47DC35E9FE7E@smartserver.smartshare.dk>
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

On Thu, 28 Aug 2025 08:50:23 +0200
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> >=20
> > Asking because the recent patch to handle shadow warnings doesn't work =
on
> > compilers like Gcc 9.4 which don't know what -Wshadow is. =20
>=20
> Our current minimum GCC compiler requirement is version 8.0:
> https://git.dpdk.org/dpdk/tree/doc/guides/linux_gsg/sys_reqs.rst#n32
>=20
> Which GCC version is required to support -Wshadow, and which GCC versions=
 are included in relevant distros?
>=20
> Maybe the -Wshadow can be added conditionally, depending on compiler vers=
ion.
> Shadow variables will not be caught locally, if using an old compiler ver=
sion. But the CI will catch them in the tests running on recent compiler ve=
rsions.
>=20


Meson handles that part fine. It is the Pragma logic that seems to confuse.
Working on doing it without pragma
