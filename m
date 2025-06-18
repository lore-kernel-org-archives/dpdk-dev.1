Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD47C7115A
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Jun 2025 09:51:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 068B6427D3;
	Wed, 18 Jun 2025 11:51:46 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id E2F0140EE2
 for <dev@dpdk.org>; Wed, 18 Jun 2025 11:51:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750240304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9PLXa7jRbj4cZVAl8DsXg8OgnNCwElLPkf4Zd4UN8+Y=;
 b=TMSuwIz/xK+jXcQBflBvyEfww59TmGuFQ+lMRh65PEK7uivgBR3OfQHY0WM6SyloS8+RvH
 DaLhkQNDAOvZnZjoggpqOO1L46JJu4It+SxC0AHAwv7/7gmwMwAKCn15ukUgQt6VcwHZ6B
 p0JoPdXQKnfp/5FzIYPDDxUFnYFfr8w=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-S4lvL7IHNTOxFNzOYC50Pw-1; Wed, 18 Jun 2025 05:51:43 -0400
X-MC-Unique: S4lvL7IHNTOxFNzOYC50Pw-1
X-Mimecast-MFC-AGG-ID: S4lvL7IHNTOxFNzOYC50Pw_1750240302
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-553a579a283so3474979e87.0
 for <dev@dpdk.org>; Wed, 18 Jun 2025 02:51:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750240301; x=1750845101;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9PLXa7jRbj4cZVAl8DsXg8OgnNCwElLPkf4Zd4UN8+Y=;
 b=OkF0azehwzr9fWNcdCp7If95NJjpNHs8B9c4BTQpKW7FUb0Vm9Ug4zK4VReUGL2JL4
 R4mgD6Qh6eedZNsWuY1+zAWzVEnP7ICDsPdUOTAFIAeUAH8ugbI6EL4VRozr5aIXhIS6
 wvGuiFnMM/fZ7YV/sMskYYh+d1mOlsceHGhcb9v4t2dTfRDTrt6lwNX1MFEEMBYr94QS
 FumtVW/Ov8wwydeB0hXuRW8ZujJcfP4UW1RHtrxvAMGZawelGjG4eTV1Z6i5j0brSM81
 IPZQi14+CSMhOEMe9XDl93F8UlhzJXnNPXC/4DSByIBXbJkRzD8aCRc4BvxArhXpfLKw
 v8pg==
X-Gm-Message-State: AOJu0YwYPlv4lXMH3ptfV/jCBLavHUxbPziU+Hwm0zfDXXbkp1ksjfkR
 QRkdHgqFX2cVAwkvzpf4JYoXg/UWoU3ejOVLXvDPrXufyvxR3ezL7At+OC+TfYPjWT7PKMDp5fk
 qBZlEEzXrCquIdHaYVFlVBC+d0Kz3+ASYnY4ARnCcnb0TM1zoH2zmLNhUES83ySfnYiQmYUC0vz
 dyZqduwYhnphHh7I/Jk84=
X-Gm-Gg: ASbGncvGP/gTwrdA5mSR+st5TE5tNPQyCwM1p4hkZOb/A0wSY9JbAvtNztCJ2gAmnd0
 w9ENF6I2ShALKy7hcoHxKu2C+rWsxGrr98E2ZP/d1UwD85bIjh+z1YJtFQr/3GMqxm2OFdDeCuM
 fG9HlDzw==
X-Received: by 2002:a05:6512:68a:b0:553:663d:736c with SMTP id
 2adb3069b0e04-553b6e84d23mr4598235e87.15.1750240301398; 
 Wed, 18 Jun 2025 02:51:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6jJXuKrx8Uj6jvOAOBzIjcfOf+79ah+6IbXSmdkFOpfL95VT0IizDP0/g3iHYPszIlgWC30uk+6TBulrHjDM=
X-Received: by 2002:a05:6512:68a:b0:553:663d:736c with SMTP id
 2adb3069b0e04-553b6e84d23mr4598229e87.15.1750240300932; Wed, 18 Jun 2025
 02:51:40 -0700 (PDT)
MIME-Version: 1.0
References: <1749831278-8286-1-git-send-email-andremue@linux.microsoft.com>
 <1750087871-27179-1-git-send-email-andremue@linux.microsoft.com>
 <aFA6e5m-4I4vpSna@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aFA6e5m-4I4vpSna@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 18 Jun 2025 11:51:29 +0200
X-Gm-Features: AX0GCFvVPNico17H02WaFcD_hGZ4c4D4YSLIpYSxb6k68h1t_uvdq4v1GtHk5TU
Message-ID: <CAJFAV8znce+o2Qcu9tqHzgZ8JyojqjQ4vu+BqpK03fa_KwUB9w@mail.gmail.com>
Subject: Re: [PATCH v2] buildtools: allow a different minimum meson version
 for Windows
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YtA5bSwwMPaySYVH0OZyM3rtC4DBp-_-WQqTTwdFWgA_1750240302
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

On Mon, Jun 16, 2025 at 5:38=E2=80=AFPM Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> On Mon, Jun 16, 2025 at 08:31:11AM -0700, Andre Muezerie wrote:
> > There is a minimum meson version specified in the DPDK meson project
> > section, which has been documented. This string is parsed by
> > buildtools\get-min-meson-version.py and this information is used by
> > lab automation to install the corresponding meson package on the
> > build machine.
> >
> > Turns out that the meson version specified on the DPDK project
> > (0.57.x) is buggy on Windows: it has issues related to path
> > manipulation, and these issues are causing failures. Therefore,
> > a newer meson is required on Windows.
> >
> > To avoid bringing the minimum requirements up for all operating
> > systems before a more appropriate release, this patch implements
> > a mechanism allowing a different version to be specified for Windows.
> >
> > Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied, thanks.

Two (non blocking) comments on this patch:
- could you send a followup patch for using this with the MSVC target
in GHA (see .github/workflows/build.yml) ?

- there is nothing really checking whether the minimum version is
correct on Windows.
  Would it make sense to have a "runtime" check in meson out of the
project() declaration?
  Something like (untested, probably broken):

diff --git a/meson.build b/meson.build
index 2423884df7..22128b6942 100644
--- a/meson.build
+++ b/meson.build
@@ -11,9 +11,13 @@ project('DPDK', 'c',
             'warning_level=3D2',
         ],
         meson_version: '>=3D 0.57.2'
-        # meson_version_windows: '>=3D 1.5.2'
 )

+meson_version_windows=3D'1.5.2'
+if is_windows and meson.version() < meson_version_windows
+    error('Minimum meson version on Windows is ' + meson_version_windows)
+endif
+
 fs =3D import('fs')

 # check for developer mode



--=20
David Marchand

