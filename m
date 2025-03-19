Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A05C35FFA
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Mar 2025 10:40:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A079F402E1;
	Wed, 19 Mar 2025 11:40:36 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 100134026B
 for <dev@dpdk.org>; Wed, 19 Mar 2025 11:40:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742380834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pz7SZ0+3g3rYBPI31nTFUiR9NBa40wGXGHuICLvO65U=;
 b=Ku61Q4Yu4Dt9hoIfHS+Bq4edQDHpI+ueFkAiwWP5whwHxM4jN/oYTZwrSoJTWvPtghJy+y
 efIUn3dv1LT0axjTffipOLVjwhccUVcmynczs/JqhLG26xn4PQ2StM9Z3zUteeUm1slXeQ
 1KvfTAqcBGyT7XIf45uFIhoUagRvnDQ=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-1weA8WA8O1uEQUqjJJWCtg-1; Wed, 19 Mar 2025 06:40:33 -0400
X-MC-Unique: 1weA8WA8O1uEQUqjJJWCtg-1
X-Mimecast-MFC-AGG-ID: 1weA8WA8O1uEQUqjJJWCtg_1742380832
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5495851a7a9so4522889e87.3
 for <dev@dpdk.org>; Wed, 19 Mar 2025 03:40:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742380831; x=1742985631;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pz7SZ0+3g3rYBPI31nTFUiR9NBa40wGXGHuICLvO65U=;
 b=TEdy/9IC7VzNGqTQdjdaBRJD9t+KcD2dnxnZvwoAKpyxiaG4QMIhtm4DKD7bxPG9UX
 aWC6DFbj9AW+fnHChbyxqXTnxS9Cbf0JNTODBATt3iMrVrpxzCl6Idj4851ge1Z3ae10
 ayVqKL88o9nJbWhTVQn/SFyM6cDVXytQBki6jWPdWcp8guInWtW5pLryAv0NPzcG+E8N
 Uel6h8X+UvHnqmUvGOoDTpQvyQhcaF8mfeIs+jKwQMEniS5evgZErOM2/N+7TjJTz/vU
 KCWmwsr2g+jjzlmXxHM9NtmhkSdriWFWOPE4FB0Inz+QZ+GOEZY05wsasr6FByullWlX
 K10g==
X-Gm-Message-State: AOJu0Yw26zNhSVhpyWEqC9OcDZQtAV4RVy1ULvCtzRFraM+0BhgXGMqN
 o5ILSlDRiy13d7BqHo/Vz9k4/589fIUa3QQNPiBtMxmuZx9jXoxM4f+MuyM2G+ubW07NbDvcgm8
 V2PIzxZBRw2yhx+iLcXTYH/n9RWWT8mGUuy5+jvMABDUZwpmDxA/SBQ/mVqH+NscPc+VPyE3SCn
 9NB8JoBDQgMHnBrLA=
X-Gm-Gg: ASbGncseWXfisG30gKjAi7j8IC0lnnDB1M3N+WVBRcdO+OaIoxrXcT8rQeQ6PGYLQkg
 FKyvMASB9IrESaacRfyigjLyNFGgOF/aXSTrGndSNFQusIVLIXRKmgvgD+fmPDM1uTlCLTA+Jgb
 Q=
X-Received: by 2002:a05:6512:3e1e:b0:548:91f6:4328 with SMTP id
 2adb3069b0e04-54acb1be834mr820337e87.15.1742380831556; 
 Wed, 19 Mar 2025 03:40:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELX0fssF5Evx5qKok5h8NOBmrLZnhdi+ydMOGENL5YtYkK/Vjlkjnal5gd/DT/f4gLfveLDz9ItfPOT2/yYEo=
X-Received: by 2002:a05:6512:3e1e:b0:548:91f6:4328 with SMTP id
 2adb3069b0e04-54acb1be834mr820327e87.15.1742380830990; Wed, 19 Mar 2025
 03:40:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250314172339.12777-1-bruce.richardson@intel.com>
 <20250318173505.314529-1-bruce.richardson@intel.com>
 <20250318173505.314529-8-bruce.richardson@intel.com>
 <CAJFAV8wPvQKHNFgPvYa1k-L6Q46WcsRCq8O64Mxb9_AX34CgUA@mail.gmail.com>
 <Z9qbwPNR5g3DLIFT@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <Z9qbwPNR5g3DLIFT@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 19 Mar 2025 11:40:19 +0100
X-Gm-Features: AQ5f1JpJoyXz5n7QL8FCcfYJ3jO4znJ2S7Zm8nIh3b5BJ2bIVpocPm-0C8D9qDA
Message-ID: <CAJFAV8xQvCsAnJ7hn=9NGKv_W1oKvDsdKL9v1sOCSU2noR_paA@mail.gmail.com>
Subject: Re: [PATCH v3 07/11] acl: use common AVX build handling
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kkqJ8oeM5lGKopSuFOQFmibbW_-c9NWgVR1l1SsK32E_1742380832
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

On Wed, Mar 19, 2025 at 11:26=E2=80=AFAM Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> On Wed, Mar 19, 2025 at 11:16:09AM +0100, David Marchand wrote:
> > On Tue, Mar 18, 2025 at 6:35=E2=80=AFPM Bruce Richardson
> > <bruce.richardson@intel.com> wrote:
> > >
> > > remove custom logic for building AVX2 and AVX-512 files.
> > >
> > > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > > ---
> > >  lib/acl/meson.build | 54 ++++---------------------------------------=
--
> > >  1 file changed, 4 insertions(+), 50 deletions(-)
> > >
> > > diff --git a/lib/acl/meson.build b/lib/acl/meson.build
> > > index a80c172812..87e9f25f8e 100644
> > > --- a/lib/acl/meson.build
> > > +++ b/lib/acl/meson.build
> > > @@ -15,57 +15,11 @@ headers =3D files('rte_acl.h', 'rte_acl_osdep.h')
> > >
> > >  if dpdk_conf.has('RTE_ARCH_X86')
> > >      sources +=3D files('acl_run_sse.c')
> > > -
> > > -    avx2_tmplib =3D static_library('avx2_tmp',
> > > -            'acl_run_avx2.c',
> > > -            dependencies: static_rte_eal,
> > > -            c_args: [cflags, cc_avx2_flags])
> > > -    objs +=3D avx2_tmplib.extract_objects('acl_run_avx2.c')
> > > -
> > > -    # compile AVX512 version if:
> > > -    # we are building 64-bit binary AND binutils can generate proper=
 code
> > > -
> > > -    if dpdk_conf.has('RTE_ARCH_X86_64') and binutils_ok
> > > -
> > > -        # compile AVX512 version if either:
> > > -        # a. we have AVX512 supported in minimum instruction set
> > > -        #    baseline
> > > -        # b. it's not minimum instruction set, but supported by
> > > -        #    compiler
> > > -        #
> > > -        # in former case, just add avx512 C file to files list
> > > -        # in latter case, compile c file to static lib, using correc=
t
> > > -        # compiler flags, and then have the .o file from static lib
> > > -        # linked into main lib.
> > > -
> > > -        # check if all required flags already enabled (variant a).
> > > -        acl_avx512_flags =3D ['__AVX512F__', '__AVX512VL__',
> > > -            '__AVX512CD__', '__AVX512BW__']
> >
> > Not sure it is an issue.. CD is not part of common cc_avx512_flags.
> >
> It is since bce754b5d942 ("config/x86: add more flags in common AVX512 fl=
ags set")
> See: https://github.com/DPDK/dpdk/blob/main/config/x86/meson.build#L68

Err.. I meant the target_has_avx512 variable.
But looking again, it seems we can remove this variable entirely after
the series.


--=20
David Marchand

