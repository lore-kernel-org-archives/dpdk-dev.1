Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC508CD6E4A
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Jun 2026 11:40:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7A731402A9;
	Tue,  2 Jun 2026 13:40:00 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 1C5AF40150
 for <dev@dpdk.org>; Tue,  2 Jun 2026 13:39:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780400397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tB0P5Wtj7CN7QyjOyk+DJgXYSL59baw1Bk07honmGkU=;
 b=JaqHHG7XykRe+wiIaJKKhWz2D0COdsHk8vpMztypPg6yfrA2J+TbYmNfTLqit/2YMAmlph
 5Z7wgQW/1YqU/ICnfvZOOBgDO5DGWaTpYSNYBLaJBIu27tWuHEEYa8Nl6t4eDkURKvYcW3
 LeRI/rV36w6E0g+6F0Q/ZDVLdCAeSZs=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-TYFKr0JcNoiIvrpg92OIIQ-1; Tue, 02 Jun 2026 07:39:56 -0400
X-MC-Unique: TYFKr0JcNoiIvrpg92OIIQ-1
X-Mimecast-MFC-AGG-ID: TYFKr0JcNoiIvrpg92OIIQ_1780400395
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-3965eab1524so17899021fa.1
 for <dev@dpdk.org>; Tue, 02 Jun 2026 04:39:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780400394; x=1781005194;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tB0P5Wtj7CN7QyjOyk+DJgXYSL59baw1Bk07honmGkU=;
 b=PlLEDzIhcf+c3RXfAEg2lf04/n/dzY0z0VwR+v0sJWvPnGiVk1pcIJvoPvgBe3QVdE
 hLJlwh8e8VHPts0LI+7TY+Yv8PAHST8uQw1o9qbFLuTnL7gIoVRr74yWWQsCIsXaRmKH
 lexBmYwUTXISURyIcSqtePDgzqu/JsczlEaeVV0l7vGcYtjR2Rjyy2FlCpCC5gE1Eiio
 cQQDSgHZ9oK4xUHmQecWaBcBOAA/RKfWi/y3eJHHyR0SoO613wv0zXLB+r0QsUoeSGyq
 n/9sn+Dcf5zbC3PAnbMJImT2CAUDqQNKN+LqK+opLVwS620NjyzwoQsFBkuozhfeo3B2
 66Ww==
X-Gm-Message-State: AOJu0Ywg8lno++ehqg1FzrI475XjK6Olv5VPF0NmxAjvepf2HNuI2eij
 nk/1AOfw3aMlGM9+ok/zP8D7Bhe8H1qXauCu260XvCYvdiishWT5U3BpWaRN9DtaOzTEpLMk2Fk
 pElRS23LqUl9ETOuAGyRYZlJhXruzm1u+Hb6gVTXZ4XFz8FsrzDGmwYgEIwJx66jNwwaQ4N/VT7
 duBdxeIxp6kZe06wKL+1I=
X-Gm-Gg: Acq92OFg60bNtqVxpKJkMVDCGHmrp4F5FUQtkjLJcJWHaMGJxt0zpDwWfV79VO2mqeX
 3/54xlaGH2zdwMcdblbGAcFPAb+QRQe0oql+CGEj8GaOL91Eyp/h5H9pzdvrht/DuM9fq3wFAYR
 ctM3TsXSwq0VLeqRYsIIqngiDLgjb9lPj0lqy4YrvLXWdtUSJr2SyrvrMMTzeNbyTfjcl3rfBNx
 +aIPYKAOguu/5mWSW5rBv10vEF3yaYmWW1P+jKSq1RTsn2YE65qWxjUAghak+S4koAdhxsSIJ9f
 rf3C
X-Received: by 2002:a05:651c:1511:b0:396:a826:a278 with SMTP id
 38308e7fff4ca-396a826a6a3mr2724051fa.19.1780400394458; 
 Tue, 02 Jun 2026 04:39:54 -0700 (PDT)
X-Received: by 2002:a05:651c:1511:b0:396:a826:a278 with SMTP id
 38308e7fff4ca-396a826a6a3mr2723931fa.19.1780400393892; Tue, 02 Jun 2026
 04:39:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260602090847.905721-1-bruce.richardson@intel.com>
 <20260602090847.905721-4-bruce.richardson@intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F658D8@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F658D8@smartserver.smartshare.dk>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 2 Jun 2026 13:39:42 +0200
X-Gm-Features: AVHnY4K_KXKnxCaGKfSMd_qkGyP7ZmozkrmqdXSiMKfYuuT8dOuenj8KefecfyY
Message-ID: <CAJFAV8x5_JihAXe_bruriVu01b5wmF4fJ7vD42yFfNwpJQwDtQ@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] build: deprecate HPET build option
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>, 
 Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1crMdOycNHw_tj5yas87Hxx4XrzXnjjXEXW02YFh1pk_1780400395
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

On Tue, 2 Jun 2026 at 12:47, Morten Br=C3=B8rup <mb@smartsharesystems.com> =
wrote:
>
> > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > Sent: Tuesday, 2 June 2026 11.09
> >
> > We can enable the building of the HPET code by default on Linux, since
> > the timers are not used - or even initialized - by default. Instead an
> > app needs to explicitly call rte_eal_hpet_init() to use the HPET timer
> > APIs. Therefore, let's simplify the user experience by deprecating the
> > option "use_hpet" and make it a no-op.
> >
> > To avoid issue with the dpdk-test binary which was trying to initialize
> > the hpet on startup, move the hpet init call to the timer autotest -
> > the
> > only place where it was used.
> >
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > ---
>
> Careful!
> I think this patch has unintended side effects:
>
> On Linux, it unconditionally enables HPET (and sets RTE_LIBEAL_USE_HPET),=
 which was previously disabled by default.
>
> So, if some Linux applications use #ifdef RTE_LIBEAL_USE_HPET, they will =
now tell DPDK to use that timer instead of the TSC.
> We can fix the apps/examples in the DPDK repo, but it will potentially ch=
ange behavior of DPDK user's applications.
>
> I'm not opposed to unconditionally enabling HPET ability in DPDK itself o=
n Linux.
> But I'm worried about side effects of unconditionally enabling #ifdef RTE=
_LIBEAL_USE_HPET in Linux user applications.

I don't see a functional impact.

There may be an impact on performance?
But users can switch to rte_get_tsc_cycles() to avoid the added branch.


On the other hand, did you consider dropping HPET altogether?


--=20
David Marchand

