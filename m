Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B0EBC3600B
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Mar 2025 08:18:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 14ED44065F;
	Thu, 27 Mar 2025 09:18:18 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 125E940261
 for <dev@dpdk.org>; Thu, 27 Mar 2025 09:18:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743063496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YmHGwFM+7NEgYiE0eDjX0UsO71Fmy7Ihw/Unq0xnL0Q=;
 b=gQrNltPfPy/ObLn3fdCkZvbNCx/hGoL0KA9H/Hbe+spPEi4gWUeui/3racNi2YttcAbPfo
 WC5jJWuyyqDjPdpglQF9ZNxg2fBaQtUxvzLQaU4dbPMD5zLakMDGtUVTAXT0/dmIjWOi4i
 ZedotKnUZoD5SSLWgzPEKgyXZ0nDt9g=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-8j_A-IZ6OdCtnqHaNjA2_g-1; Thu, 27 Mar 2025 04:18:10 -0400
X-MC-Unique: 8j_A-IZ6OdCtnqHaNjA2_g-1
X-Mimecast-MFC-AGG-ID: 8j_A-IZ6OdCtnqHaNjA2_g_1743063488
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-30bfae51e79so3213391fa.0
 for <dev@dpdk.org>; Thu, 27 Mar 2025 01:18:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743063488; x=1743668288;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YmHGwFM+7NEgYiE0eDjX0UsO71Fmy7Ihw/Unq0xnL0Q=;
 b=i/IaUZMnYAGYt91XA0M8M3PFD+FTXlJUECaS5Ex6juSknUZgvz28BTr3c/Huu5mjCN
 YecvZJiz6v7SPb+0zyAPVBRJF3Cfyp+t55MhaYdVhTSvGRSHSOc/wZDkOHveB3Vc9PfP
 /dSiYOOhPzztCzmwdF7/8A8NjGvmCMIdJv8IrZ3MgGoePkf3EgR2z8UGlHCq/on+hfA+
 Ipe30iQlxWFWKh5PtSB3ZBTZJrZC0ZoEq9X2vfhpTwWsoTRJBPvuanqY8vAyukFOliXE
 S0KdlQMiZIWxBuP9O8vqHLWoFJTe7GQnyKND7nBFfnyrJ5C2ewRM7HaS37GpX5VOOpJ0
 ciMA==
X-Gm-Message-State: AOJu0YxwW5XxdiNlEm/RkNABc591Ik3O3Xa1gJBqKYe1tZ2cnyW1LDJy
 EjVKQAUTHIVzoALFMsHDVReAX8it8aGAe8b/GrwTKtsve9wMpgxBBToPt7z60O53C2FXvJVvQwU
 bUhODkSWtJ8TmEGjvvTZtHWCidEUTxcJoEDcDspZbRv9cYwtWJYy6mqEP6icXua1qDTt4TULCUk
 wAAOx8mSVlFsKF4cE=
X-Gm-Gg: ASbGncvVcwKLe4j1nE4lGsMC5GSV4Pmgx3lBJ4eaiEW4Nvb4rTnLQd3H04tWF4HSYni
 kKvax27Dov0IjPn5ECUdby5yklVC1Ht+P9FyFKweZ3++7eh01IKq+ulHljNH2GddAPJpT3yEqzx
 s=
X-Received: by 2002:a05:6512:1054:b0:545:3031:40aa with SMTP id
 2adb3069b0e04-54b011cdc88mr885949e87.9.1743063488392; 
 Thu, 27 Mar 2025 01:18:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfe1aYwmftAWd3/Mdmwixu9tfebtMftB/I+M7vi1z3UxjAtSWh0c9bohh6E0/wegobNzC43uO9KUAqXrkKaGA=
X-Received: by 2002:a05:6512:1054:b0:545:3031:40aa with SMTP id
 2adb3069b0e04-54b011cdc88mr885931e87.9.1743063487946; Thu, 27 Mar 2025
 01:18:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250326103928.1189243-1-david.marchand@redhat.com>
In-Reply-To: <20250326103928.1189243-1-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 27 Mar 2025 09:17:56 +0100
X-Gm-Features: AQ5f1JpQIz3aHO0HSngTwZzIMI1q9ZWSxEQQatop0G1XVQ7_0Nc72qRe0Rzs9-Y
Message-ID: <CAJFAV8ydP+HQ-THXF-TU=_YKVB7D-arMXrwpcsiEz9zqxm2FfQ@mail.gmail.com>
Subject: Re: [PATCH] acl: fix build with GCC 15 on aarch64
To: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>, 
 Bruce Richardson <bruce.richardson@intel.com>, 
 Wathsala Vithanage <wathsala.vithanage@arm.com>
Cc: dev@dpdk.org, bluca@debian.org, stable@dpdk.org, 
 David Christensen <drc@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JnPJ7naY17WoTMTeTRFJ6pHPuH_KoHM_b9Rsx1paFVc_1743063488
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

Hi guys,

On Wed, Mar 26, 2025 at 11:40=E2=80=AFAM David Marchand
<david.marchand@redhat.com> wrote:
>
> Caught in OBS for Fedora Rawhide on aarch64:
>
> [  198s] In file included from ../lib/acl/acl_run_neon.h:7,
> [  198s]                  from ../lib/acl/acl_run_neon.c:5:
> [  198s] In function =E2=80=98alloc_completion=E2=80=99,
> [  198s]     inlined from =E2=80=98acl_start_next_trie=E2=80=99 at
>         ../lib/acl/acl_run.h:140:24,
> [  198s]     inlined from =E2=80=98search_neon_4.isra=E2=80=99 at
>         ../lib/acl/acl_run_neon.h:239:20:
> [  198s] ../lib/acl/acl_run.h:93:25: error: =E2=80=98cmplt=E2=80=99 may b=
e used
>         uninitialized [-Werror=3Dmaybe-uninitialized]
> [  198s]    93 |                 if (p[n].count =3D=3D 0) {
> [  198s]       |                     ~~~~^~~~~~
> [  198s] ../lib/acl/acl_run_neon.h: In function =E2=80=98search_neon_4.is=
ra=E2=80=99:
> [  198s] ../lib/acl/acl_run_neon.h:230:27: note: =E2=80=98cmplt=E2=80=99 =
declared here
> [  198s]   230 |         struct completion cmplt[4];
> [  198s]       |                           ^~~~~
>
> The code was resetting sequentially cmpl[].count at the exact index that
> later call to alloc_completion uses.
> While this code seems correct, GCC 15 does not understand this (probably
> when applying some optimisations).
>
> Instead, reset cmpl[].count all at once in acl_set_flow, and cleanup the
> various vectorized implementations accordingly.
>
> Bugzilla ID: 1678
> Cc: stable@dpdk.org
>
> Signed-off-by: David Marchand <david.marchand@redhat.com>

No pressure, but could you have a look?
This is for fixing some build issue in the CI (affecting main, at least).


--=20
David Marchand

