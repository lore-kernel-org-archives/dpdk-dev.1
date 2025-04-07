Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A1DC3601E
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Apr 2025 13:46:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 70EB740156;
	Mon,  7 Apr 2025 15:46:58 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 9908740041
 for <dev@dpdk.org>; Mon,  7 Apr 2025 15:46:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744033616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1ruJIKnHNlhlH1QD1MPfSNjGWluymlrzX8LJypdBLtw=;
 b=WFbRxNsAB00jExw9GCcnhtanpJfz0npeEiVpkby4bbhgeq6NmvtCHSsQ395RI7lfJZ4xFX
 M0aNqdwh+415kMlj39pvC243jqiQo23s72mMBC+YMQDiPmZ7/ED8CN5+oF1jSdhheImzLd
 92GBKauT2dNsD2QD8RNGmMpm57iYX/c=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-_EG7yhn_PV2u0WbBFgZyDw-1; Mon, 07 Apr 2025 09:46:52 -0400
X-MC-Unique: _EG7yhn_PV2u0WbBFgZyDw-1
X-Mimecast-MFC-AGG-ID: _EG7yhn_PV2u0WbBFgZyDw_1744033611
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5498879a3aeso1795685e87.1
 for <dev@dpdk.org>; Mon, 07 Apr 2025 06:46:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744033611; x=1744638411;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1ruJIKnHNlhlH1QD1MPfSNjGWluymlrzX8LJypdBLtw=;
 b=NKmZK33vdEG/uXCzYYD54HI7N95e0Njw+SIswXIHpEK7jFoHPZRa5kz6RlRuvxntQx
 yJC4jBlpCReQscY2cVag4XroTDIP3ClUOiG9wljob9Xi2g/WFs5rJQH1PgQ78lFhT8NP
 +Uh46xZ7LmeaW5QTYnpT+ucokKQU1IuPRdHlsZZTAbw2b9q7SBViAH3hkHhW3/hM+lMl
 tc9zQNxWM3E94WC1ROjwY5ukhyhfdf+BVPYWlvaqVDlWAWSi2eddsRv+cXGzqeMN+PjH
 15vs+uCjb8keXNDo+fpdFL7Lw4+ZoyJokg1HTp49hQknFTGUsC/sTG2OXxzsbS+47EGz
 OlKg==
X-Gm-Message-State: AOJu0Yyk9yOo2Og/mvWi3Vmd/M5R+v/m0r1BQOPUojRhHrZ/6mRoEh0n
 /mwTrG4zqkATA/7eATl2AmAQqRRsEEZwsVF9nNw78NoLrX89APM6Pyk4B16jRRe/V6HSrGBkPrK
 rYt+THnIFENJGASSLoNDlUcujMsBm+v1/VOz62+OAT4/pohwJwa7zCKYTw4D1gLOmKNp3AGS+Xd
 c1l7PIAhVbSWKi4TQ=
X-Gm-Gg: ASbGncsTY8e4230CIVvCj3wBEoI/7VbordDHsqMIoawZw0Zpcne4tbxHd1n11WltM54
 mDf4eRARJ3ip27+bt8UnmSsf9F6zCJq8Sqznlcw7nJUbPDBVkFPzuJEuVfho8PdKo0rzr6IUcIG
 c=
X-Received: by 2002:a05:6512:3988:b0:545:60b:f381 with SMTP id
 2adb3069b0e04-54c232f91eamr3117949e87.29.1744033611137; 
 Mon, 07 Apr 2025 06:46:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2w27YOl22K/ssuWl8MCXbbt5RyfDKV2W/jG1LAoAnQQ/JbzibOr9xeD0RkHnIwCXm789IUtSuOjJeTJf4Wyo=
X-Received: by 2002:a05:6512:3988:b0:545:60b:f381 with SMTP id
 2adb3069b0e04-54c232f91eamr3117938e87.29.1744033610785; Mon, 07 Apr 2025
 06:46:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250305212349.2036410-1-david.marchand@redhat.com>
 <20250403165845.1315380-1-david.marchand@redhat.com>
In-Reply-To: <20250403165845.1315380-1-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 7 Apr 2025 15:46:38 +0200
X-Gm-Features: ATxdqUHAxNKEeMQn3v5veVS5PAMBpdjbaH3xVq4V3kMdvX2qMp3OvYlC7HGVEZc
Message-ID: <CAJFAV8x2dTPZxnyEvvvJJGrj909-bqOSuNJ1eCd+ZDJCj2axqQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/8] Symbol versioning and export rework
To: David Marchand <david.marchand@redhat.com>, 
 Stephen Hemminger <stephen@networkplumber.org>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>, 
 bruce.richardson@intel.com, Jerin Jacob Kollanukkaran <jerinj@marvell.com>, 
 Raslan Darawsheh <rasland@nvidia.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>, 
 Akhil Goyal <gakhil@marvell.com>
Cc: dev@dpdk.org, thomas@monjalon.net, andremue@linux.microsoft.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PSJIPtUPfbdtQgcDV8_2duTGzdZiwIW-V_-k7NsC4-E_1744033611
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

On Thu, Apr 3, 2025 at 6:59=E2=80=AFPM David Marchand <david.marchand@redha=
t.com> wrote:
>
> So far, each DPDK library (or driver) exposing symbols in an ABI had to
> maintain a version.map and use some macros for symbol versioning,
> specially crafted with the GNU linker in mind.
>
> This series proposes to rework the whole principle, and instead rely on
> marking the symbol exports in the source code itself, then let it to the
> build framework to produce a version script adapted to the linker in use
> (think GNU linker vs MSVC linker).
>
> This greatly simplifies versioning symbols: a developer does not need to
> know anything about version.map, or that a versioned symbol must be
> renamed with _v26, annotated with __vsym, exported in a header etc...
>
> Checking symbol maps becomes unnecessary since generated by the build
> framework.
>
> Updating to a new ABI is just a matter of bumping the value in
> ABI_VERSION.
>
>
>
> --
> David Marchand
>
> Changes since v6:
> - used argparse in python scripts,
> - renamed eal_symbol_exports.h as eal_export.h,
> - renamed some base symbols export files,
>
> Changes since v5:
> - fixed Windows symbol exports for net/mlx5,
>
> Changes since RFC v4:
> - rebased on main, now that Bruce series is merged,
> - the export macros header has been moved to lib/eal/common/
>   and its inclusion is now mandatory (rather than an implicit -include),
> - reordered patches: symbol versioning is touched last and merged
>   in the export header (replacing the legacy rte_function_versioning.h),
>
> Changes since RFC v3:
> - fixed/simplified documentation,
> - rebased on top of Bruce series for common handling of AVX sources,
>
> Changes since RFC v2:
> - updated RTE_VERSION_SYMBOL() (and friends) so that only the fonction
>   signature is enclosed in the macro,
> - dropped invalid exports for some dead symbols or inline helpers,
> - updated documentation and tooling,
> - converted the whole tree (via a local script of mine),
>
> David Marchand (8):
>   lib: remove incorrect exported symbols
>   drivers: remove incorrect exported symbols
>   buildtools: display symbols version from map
>   build: generate symbol maps
>   build: mark exported symbols
>   build: use dynamically generated version maps
>   build: remove static version maps
>   eal: rework function versioning macros

Series applied.

Heads up to subtree maintainers.
TL;DR: please rebase your trees.

If you had changes on version.map in your trees, you'll need to
convert the new symbols and use RTE_EXPORT_SYMBOL* macros.
If you have some doubt, ping me and I'll help.


--=20
David Marchand

