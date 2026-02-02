Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 664C1D172C6
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 04:31:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A4A4640661;
	Mon,  2 Feb 2026 05:31:22 +0100 (CET)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com
 [209.85.222.45]) by mails.dpdk.org (Postfix) with ESMTP id 066A940281
 for <dev@dpdk.org>; Mon,  2 Feb 2026 05:31:22 +0100 (CET)
Received: by mail-ua1-f45.google.com with SMTP id
 a1e0cc1a2514c-9489bf609bcso431668241.3
 for <dev@dpdk.org>; Sun, 01 Feb 2026 20:31:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770006681; cv=none;
 d=google.com; s=arc-20240605;
 b=PLJhEL+NdNGkMsaOQIqxY9TI0KeN3azy5qkja4Hmr8mZSAbOaWf0XPpXpnuLE6cic/
 gCF0OcVMuH4WvpJJhNlRO9AE+CxpPJOygrZ26IbIY36LU2x5Aq+zsYsrQiyZ2jvhIENu
 v8HMMO0eAMmLnNldsO+Fm7vaYVQazucytShLjHdFCpDAUzL6fm7jmuEj26mwvHnRD+bC
 adeKHzRdiVp6eU/fPJhNW9fq6wXy/B+dgeij2xIbC9K/aSHxsDmd2ie7IleS8qbXZHVH
 ktnQcgrXT5IjSLYticpmYIkYhcTbHRouFyKPR6TvtQVasYsgfP02ZERa+R9W/RH/eqkd
 AcUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=EG99g+LiNzlN2n70K9BiCIxKyXXltgR2fQZBlGU95ZE=;
 fh=lp8/5lCUVqjUwHnLwxx65mgTt9gMDJwwaypuJyLQZIs=;
 b=OtkyrbaDW/mh6xsRa0A3Msnv029nTlFDfn38t10LxrjnfqpDqLxCX+8bWtT4f+44/G
 eXMPAImXNhx7E9bvK2GEFEqVw2D675t5wBc+4Y3X+nYhrpjQZfqCsERIM61Mzkecx/se
 +yGvTBwGQnePJygBsR+nBdtnbAfSfucYHYRhC0cC+wPFpF1IDudgpl7vaOddEnwargDi
 8/5fq7FOZZ/7jyuNG4eAl7ZD+nsZBp26+Wn0n2TTFeI+4fEI5Ww2aa0yqWUAGfYeIKjO
 G6XASyYdHvb4dQTZIK5RF1poAjNprB32m2yfl4opN/spHe6Vl0ze+T4c+e66R/dICknP
 AQFg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770006681; x=1770611481; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EG99g+LiNzlN2n70K9BiCIxKyXXltgR2fQZBlGU95ZE=;
 b=GEwcdwdh8ahUwMhICQVH+7nROPVCNl+G4FRl4cR94iidXk1FxhF4S721oYv9cEtXLS
 stRBwLW5YkXFOmrdZ6Ia+u/VLTKvGilVcEmjUWpxRhjON/vm2oonJJDRgdX2WrdL/mxG
 B9TB/2wvld82W9OjKR2n97M49YkWl2LtikHNYmHRKfcmJqeKL3XoWXDKETKTDnbcX08D
 i44Z1WT72zFxExHoSF2vmyke0qJYBzNAN2Zg5wXNp443ZkhlobdvDetujVB/ga+9JWwG
 KF01AejDcI6AG619SS34iGGeKvzyufS4owU/pclK0jea2KMYwGaPXxiEQ3ich8PFlAPt
 mXzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770006681; x=1770611481;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EG99g+LiNzlN2n70K9BiCIxKyXXltgR2fQZBlGU95ZE=;
 b=J16hox7piNrd7e7aNRT5A5KdIbZiwQPDlFbi523a7Ex3fSpfdU0pvoILTSEN5HMLMy
 HgVjQHBj5a61pr0hsK8CfyRYU6/y7P6DaT88Cmsk537KYDAOJNDiInJRKIb/uZ86eVZM
 3ZyzKPJJEwaiYleuCgRNy3/Wjbc0lbm6QPBPXl2QX9SB+XVCxpsgqNQc10nwIyLVGhaJ
 1iZ6B2FFBencXsRgJLuDZIIZ7P47B2A9w9t4lEmK8IBnlzZCr2pmWgX3WmR/qNr9NzK6
 6Z75b6CxDX8OZz4O4UrlcDpIynL/+eE0fB5vq/309gcs0me6/hxfGu14UDVD7yNM0Mqk
 3qvQ==
X-Gm-Message-State: AOJu0YxZmDsIW6iNYPjq609kBZ/wLtqbjbtDZ9fEiM/Fq5Fw+pZTG9vU
 syfg78f84dAwneU041Ch9VOA57b0J0tgAXiTLcjmpQ2izdg/i1vxr3V6i42+DDBtZ936n+dm1f8
 tWRAKl2/xD4EzExShI39LFk674MMm1DQ=
X-Gm-Gg: AZuq6aKp5MAJkqC/SzbJo0RURarf8WkHV2A26xV168TRz10QCxBekHBU58nBkA4vgYb
 jD3qdeIKZu/vuvKwqAVOfXYAa3zKHKsUvviN5tpkueM3+bY61psTt30r+k2QGxLz831HMoeplyR
 gGRam59XiCj9S8lYD3L65iV9h2Po+AOhN4agCKBMeLKD9f4TsoqjiNI7IAHmrc4dmBOVtQ2Xjs1
 ncRun7r1bK3c3nWfJsLsirilS4EueZMHbimYy6UeMoQ4tBGVMrkLrrC/l3N5Ue3jvC1q5M=
X-Received: by 2002:a05:6102:50ac:b0:5f1:72a7:f879 with SMTP id
 ada2fe7eead31-5f8e2602825mr3504210137.28.1770006680646; Sun, 01 Feb 2026
 20:31:20 -0800 (PST)
MIME-Version: 1.0
References: <20260128180516.76786-1-scott.k.mitch1@gmail.com>
 <20260128194141.90018-1-scott.k.mitch1@gmail.com>
 <20260128194141.90018-2-scott.k.mitch1@gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35F656C5@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F656C5@smartserver.smartshare.dk>
From: Scott Mitchell <scott.k.mitch1@gmail.com>
Date: Sun, 1 Feb 2026 20:31:09 -0800
X-Gm-Features: AZwV_Qjpqzwol_RlXzkQPlZ1BSURZBnGXUwN7h9vm6TRNwXTsAkJAHcLWnWk9u0
Message-ID: <CAFn2buAMd_5nO3Bnp5O==i67bMrdKyXkLT_jih+vQxFEn4jv8g@mail.gmail.com>
Subject: Re: [PATCH v18 1/2] eal: add __rte_may_alias and __rte_aligned to
 unaligned typedefs
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, stephen@networkplumber.org, bruce.richardson@intel.com, 
 david.marchand@redhat.com, Cyril Chemparathy <cchemparathy@ezchip.com>,
 stable@dpdk.org
Content-Type: text/plain; charset="UTF-8"
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

> > +                             hash32 = rte_jhash_32b((const uint32_t *)key,
> >                                               hashtest_key_lens[i] >> 2,
> >                                               hashtest_initvals[j]);
> >                               if (hash != hash32) {
>
> rte_jhash_32b() correctly takes a pointer to (aligned) uint32_t, not unaligned, so casting to unaligned might be introducing a bug. (The automatically aligned allocation of the local "key" variable prevents this bug from occurring, but anyway.)
> Instead of changing the type cast, I'd prefer fixing this as follows:
> Add a local variable uint32_t key32[sizeof(key)/sizeof(uint32_t)], and memcpy(key32,key,sizeof(key)), and then call rte_jhash_32b(key32,...) without type casting.

Sounds good, fix coming in v19.

> > +/**
> > + * Types for potentially unaligned access.
> > + *
> > + * __rte_aligned(1) - Reduces alignment requirement to 1 byte,
> > allowing
> > + *                    these types to safely access memory at any
> > address.
> > + *                    Without this, accessing a uint16_t at an odd
> > address
> > + *                    is undefined behavior (even on x86 where
> > hardware
> > + *                    handles it).
> > + *
> > + * __rte_may_alias  - Prevents strict-aliasing optimization bugs where
> > + *                    compilers may incorrectly elide memory
> > operations
> > + *                    when casting between pointer types.
> > + */
> > +#ifdef RTE_TOOLCHAIN_MSVC
> > +typedef __rte_may_alias __rte_aligned(1) uint64_t unaligned_uint64_t;
> > +typedef __rte_may_alias __rte_aligned(1) uint32_t unaligned_uint32_t;
> > +typedef __rte_may_alias __rte_aligned(1) uint16_t unaligned_uint16_t;
> > +#else
> > +typedef uint64_t unaligned_uint64_t __rte_may_alias __rte_aligned(1);
> > +typedef uint32_t unaligned_uint32_t __rte_may_alias __rte_aligned(1);
> > +typedef uint16_t unaligned_uint16_t __rte_may_alias __rte_aligned(1);
> >  #endif
>
> Skimming GCC documentation, it looks like older versions required placing such attributes after the type, but newer versions seem to recommend placing them before, like qualifiers (const, volatile, ...).
> Placing them before the type, like qualifiers, seems more natural to me.
> And apparently, MSVC requires it.
> Does it work for GCC and Clang if they are placed before, like MSVC?
> Then we can get rid of the #ifdef RTE_TOOLCHAIN_MSVC.

Good call! https://godbolt.org/z/oYrnfsMM3 gcc 8 and clang 7 both
support attributes before the type.
