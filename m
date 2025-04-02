Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F51C28B20
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Apr 2025 13:09:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C2C0440273;
	Wed,  2 Apr 2025 15:09:02 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 06D5F40261
 for <dev@dpdk.org>; Wed,  2 Apr 2025 15:09:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743599340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cObhcTZWu2zqhSUpPa+k7wLmoKt2Nas5gNOQ7ynSnds=;
 b=cRA0nvPz/+ehAMaEkDTen5R52FXLGGJov5Z4CPshon6R5pSnsCPzEHBDdR3Kj7MGoRG8/1
 RRACeK1MdxkUMMJAhXKetwh88SYFbcUJxkuRql/+boFYDaYlsmgF5ncxkAUXpVKkhlJQDF
 Zn/381pG3JouEVdhO/Wu1FkZ65t78y0=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-4IVYJWYvMQuq2d7h9xStOg-1; Wed, 02 Apr 2025 09:08:59 -0400
X-MC-Unique: 4IVYJWYvMQuq2d7h9xStOg-1
X-Mimecast-MFC-AGG-ID: 4IVYJWYvMQuq2d7h9xStOg_1743599337
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-54991f28058so3330687e87.3
 for <dev@dpdk.org>; Wed, 02 Apr 2025 06:08:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743599337; x=1744204137;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cObhcTZWu2zqhSUpPa+k7wLmoKt2Nas5gNOQ7ynSnds=;
 b=nrU/MYaxCGWOmgsaU9XYyb4KTxOa2kDtnLCaIf5YtOikMRVMMtqcBA+YXMAosoXk75
 lIpgZw6uMvKr3x7GzjwcB4JDyXqhcVbL+yMTjc0TkUeCTLw/sEp3FOHuNornGhrf6VzU
 n14SXVnEBuGn3FyrrxYVud6vQB7vN6q827+nng/HRjHP4oQWzMAymn5zwNQeIl2KlvRe
 +B4isfwbT3Kzf1z+qrS68jswpv/UwENoZvz0A9GQ+8maHXAMRm5fx4Ci7ZMfmMCeflv9
 PGFY+6s2ExLoriSSfNMLSONaWHp5VjuAaO1cLhWMjobJv0t6ar84BDkcTEyWO8x7IhzJ
 3Igg==
X-Gm-Message-State: AOJu0Yz9iGT2DIvenV62ylZqMEO3boZDRpgHrQgoCUWGnZurp5d1k8SX
 MFh+2jqE/bu8JUTJ68keM78FNcVzDAeyklyF7sN5K8lYcSFZjpYMK2Dav3zyoRoVYddjDjEaow9
 vO+VCl2cnL3wwNobD3l1OyNXDKTxMmpiTzsk8LBXXRu5Z8/S5hY3iESAk1BgWPGG7DgYiQgPbwE
 oN9SLjmgYoDC4DwEw=
X-Gm-Gg: ASbGncv3jE3D4GTSs4HHbWDugiBHtMckzb9MjsE9A7wyyO0/yEON4sDURoeZAChEuVH
 ueXsLr9+Kab2sYGtRhXMrOHjtlZBjXmKZKGtkdWTjqUq8wMr2xdtMCXFOpU99mndM/4FgGprrNA
 8=
X-Received: by 2002:a05:6512:138c:b0:549:4e79:d4c0 with SMTP id
 2adb3069b0e04-54c19c9a0fdmr686992e87.53.1743599337331; 
 Wed, 02 Apr 2025 06:08:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRFmPVM9Z3Nkgwbk4L6DMIGpOzLkbjx9fdhRTWhK1GzDgQBXWqIZbk/V2TP1xjOp40DJxueAu37Bu2pmMzzUg=
X-Received: by 2002:a05:6512:138c:b0:549:4e79:d4c0 with SMTP id
 2adb3069b0e04-54c19c9a0fdmr686981e87.53.1743599336948; Wed, 02 Apr 2025
 06:08:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250331161000.9886-1-bruce.richardson@intel.com>
In-Reply-To: <20250331161000.9886-1-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 2 Apr 2025 15:08:45 +0200
X-Gm-Features: AQ5f1Jrc6QPfzlQIrWSvNYpluI1xBmXkqQ1Jw3ik-9TdBYDMc4z_iObTwv95MGk
Message-ID: <CAJFAV8w3uth7PNR8e9gD0vOhmdd29TdaLtcT0mE2Y2D6eRV9Ag@mail.gmail.com>
Subject: Re: [PATCH 00/10] centralise base code handling for drivers
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, 
 Stephen Hemminger <stephen@networkplumber.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lIZsnYfQZLJKHuesOTb3UnHpp8JbosdTV39CjFH7VD8_1743599337
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

On Mon, Mar 31, 2025 at 6:10=E2=80=AFPM Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> Many DPDK drivers use the same pattern for base code handling, having
> a meson.build file in the base code directory which optionally defines
> some custom cflags for the base code build, then builds the code as a
> static library and extracts the objects from it. (The reason behind this
> is that, in meson, cflags apply per-object, so we need to have a
> separate build object for the base code to use custom flags)
>
> This patchset deduplicates this logic by putting it into the
> drivers/meson.build file, and allowing individual drivers to then just
> specify values for "base_sources" and "base_cflags".

In general, this series lgtm.

> Depends-on: Series-34946 ("net/intel: clean up base code build")

This dependency is a bit problematic, as this series is already merged
in next-net-intel.
There will be some merge conflict to resolve.
Instead, it would have been better if next-net-intel relied on this new ser=
ies.


After this series, the only remaining special case is for SVE stuff in
net/hns3 and we would have all source compiling handled by
drivers/meson.build.
Do you plan to clean it too?


--=20
David Marchand

