Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B4E5D1D494
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Jan 2026 21:19:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5BD87402DE;
	Thu,  8 Jan 2026 22:19:53 +0100 (CET)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com
 [209.85.222.49]) by mails.dpdk.org (Postfix) with ESMTP id D313A4028C
 for <dev@dpdk.org>; Thu,  8 Jan 2026 22:19:51 +0100 (CET)
Received: by mail-ua1-f49.google.com with SMTP id
 a1e0cc1a2514c-94121102a54so2355841241.1
 for <dev@dpdk.org>; Thu, 08 Jan 2026 13:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767907191; x=1768511991; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XG9OJUD//24onCMyZl0y+KA4Wbw5mkHgwGRHf3VZbi4=;
 b=Mm4BDlu2EjaX9xmMTIwZ+/fl409b7UOWatZifLzruhrDNJYbtiuWgNRPk+AMK4K0W8
 eoo8n9thoA2ynxFYnfN4mLlvQvs/bOLabOskUBuvR3v1mO/U414g42EaT6vhH+vabJA9
 5gsFuKCNMSGL3htx+s3+T4iCTiwulejsHT+K1Dm+REOYkEXIBB4SHwarDaCmcyjgAU56
 26n8PwQFNctgxmS/2VfM9c/iUGq0hODOdu97F56OEIe3sXKX+ComljIYdJ8VG5EI1gzO
 G56ZYfccBDQSmkWa+QXDoc/43Cmq3mw00w2l4UBPL0IzlKgx6tX3DVNmmCgEhMpa/MgQ
 BeLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767907191; x=1768511991;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XG9OJUD//24onCMyZl0y+KA4Wbw5mkHgwGRHf3VZbi4=;
 b=vUh//yGgSKtkU29S7cazhWUcM33wAXKrc1i8YmW13Ab3BroxDZXz2utpfs0ZLDpwfh
 aNw8gd/HguN2UKYvPZoNDNJPDX5UbKGf8psLDIG/W9FMxEtLMmeLdtHGPVb7F4GyvnaM
 ywytuiuqQnl8SRiKexDCtqpkZxfaBQ7gchMs+4UyfGwwSFb7eGqQGIB9PG53mdWiIfiq
 05PaasSKlEwnqi51qU8hd+NQSrFfxcqWJtn01oY2yoxFJVqMO7ayq1N2loHCryjo8YG+
 gwKNXDZzLnEV83xbzddcRjURuBEX+7B4BJw710CchgiscXG3f0NzlYDC2YKsDK5XZ/9J
 b3Xg==
X-Gm-Message-State: AOJu0Yyd+jnUdGA7bWQBTqBuDXVvX8K8TzTmDtSsUCCweq+gtSwsv0aR
 IS18ZQJkER1Rz2w4iHL8xTuUsCm3bZ7qCLDd9Mdd1iHF3NBkqwsvPvqqaUOXmfT3eSXzbav6AbV
 cj19Kj0MF/jecs6vGOtwe+Cy3QijuB2M=
X-Gm-Gg: AY/fxX5sVkd9xGuJS62vl8B38GtTeSBm4vRpPGx83sDZAHUbIO57+u3fKOKTYvQ2lpU
 fwHqu78lzeJi0oFtWxTN5LOOijW7ZXgsQ7d6Pz+Vst4vpLmog2VESOyuT1B681P2tI7KTwAUStO
 qyz2rba6YPSdhFbqicTrJTrYzoNZjzjyRfOiq9fCXvqTSmv5D4sJlrzWoklPHLC0JDV01OuG2O3
 mdjPh0Plz0DKnuFNvpIrs1S6TGjn37KDNJVUBMle4kYeRhg5vQvqeDglm4QMxaabQZ9SiNnk6F6
 1rFqt46O6T4VPctTXNb46CILoNA=
X-Google-Smtp-Source: AGHT+IHhwdPDAHrtGfsETl/stYnH/6k8fg4gy7DFouZO+cnH6Ux2Oo/2c2WrnMHKnrJV6qOgayeudmm9qe4n4vlVxYo=
X-Received: by 2002:a05:6102:2d04:b0:5ef:2457:8011 with SMTP id
 ada2fe7eead31-5ef24578298mr107401137.21.1767907189591; Thu, 08 Jan 2026
 13:19:49 -0800 (PST)
MIME-Version: 1.0
References: <20260108061338.27217-1-scott.k.mitch1@gmail.com>
 <20260108081229.60b095b9@phoenix.local>
In-Reply-To: <20260108081229.60b095b9@phoenix.local>
From: Scott Mitchell <scott.k.mitch1@gmail.com>
Date: Thu, 8 Jan 2026 16:19:37 -0500
X-Gm-Features: AZwV_QhFM1OWEXjvOgSs25I_eyOkc8mUxohWc-gU-0KKEwQA0wkwc9K4838vNUM
Message-ID: <CAFn2buDp4ffHuSXmTrW8mfNHxm-t3FL=TVgMKFAc2gU7fyXPGg@mail.gmail.com>
Subject: Re: [PATCH v5] net: optimize raw checksum computation
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, mb@smartsharesystems.com
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

On Thu, Jan 8, 2026 at 11:12=E2=80=AFAM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Thu,  8 Jan 2026 01:13:38 -0500
> scott.k.mitch1@gmail.com wrote:
>
> > +#ifdef RTE_CC_GCC
> > +     /* Suppress GCC -Wmaybe-uninitialized false positive. No assembly=
/runtime impacts. */
> > +     asm volatile("" : "+m" (psd_hdr));
> > +#endif
> >
>
> Maybe rte_compiler_barrier() will do same thing?

Agreed it feels like a compiler bug but looking for advice if I'm
missing something :)

My initial concern with rte_compiler_barrier is its a general barrier
which may have broader impacts on
optimizations and compiled code. Will that be an issue in this case? I
wasn't sure and the approach
in the patch is targeted at a specific variable and assembly from
clang/gcc was the same. I will
introduce a macro to make it cleaner and I can replace it with
rte_compiler_barrier if preferred.
