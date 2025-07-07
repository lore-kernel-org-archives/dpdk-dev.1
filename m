Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900F2C8303C
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Jul 2025 14:08:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B0C0D40287;
	Mon,  7 Jul 2025 16:08:23 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 089884025D
 for <dev@dpdk.org>; Mon,  7 Jul 2025 16:08:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751897301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JLfRa4hhYobJeN2YKP9PAHp2Quedusj0u2BnNrD3hrQ=;
 b=EX1Lrpd1/xeT22DqXyiUC0vGI2PSyBhSrQts+nMlkVKH1MzNvvVZq9oKD8zSH8yJVdg550
 zM7+HmCOSJ/CuEtWx9MZTvNuVVhBdAb5zVEx+GwNsAEOXa6f9IIbaWnPjLgF4VfI/f615C
 rsvzu4U7GuSPCaAwumbSl2IjOAA2rGs=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-K2pnB9jgONWbP5Htysaw0Q-1; Mon, 07 Jul 2025 10:08:20 -0400
X-MC-Unique: K2pnB9jgONWbP5Htysaw0Q-1
X-Mimecast-MFC-AGG-ID: K2pnB9jgONWbP5Htysaw0Q_1751897299
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-32b71af3b28so7390161fa.3
 for <dev@dpdk.org>; Mon, 07 Jul 2025 07:08:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751897298; x=1752502098;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JLfRa4hhYobJeN2YKP9PAHp2Quedusj0u2BnNrD3hrQ=;
 b=J9lIPUCivH+3nCZnlV9YTGmRT/KSmzabwmPyNVAChYH4Xi+JNENhUTqsKAgPZQzbg4
 tAKcomZ4yQt3v5x127ofwR9/ROTjv6BpgHLsGHrZNwnglBhesdcJHWJpEWHGRO90kd+f
 hXDP7Xu4Ub7NSwqj/gBw5eWh/vc5SpORugsLY+cgXu3LrIprPl5auzGGPP6H0JASWd+B
 wM44L0Udo1eDip8QmOAbEtpHckk9fvAF5uhQcg8Rabk3qWmk66eeVJbLEjpGypAFXCpr
 yqhC3uF0JdVxB/C2fJUrCBs6xToVpQMaVBkpbb9kjXgQpFjJNeBxbWiC7gNAhLddoydW
 +TXw==
X-Gm-Message-State: AOJu0YwaF0tNKWiI1SW9VQGYMXrdBOELLw+wDZRwKCIXNhfAd4NwZIDN
 Estw7OUuMWNwI1ULsE54EbcJdTplXPsUb8SNE0i6Qlpva5Ovk3d6JRhYbaayfAARkZmH7tskC90
 18gWOkrIQgqWW8z85dGnOkHoZrTKBNUmNtwClkNBPkUGYpnWKeWiApVrsf2klYHYUiJKe0X0ccT
 fQU/MGlwMInRfBS4j5jSc=
X-Gm-Gg: ASbGnctWcsqlYWb1pYFpB/JkYQLFkVgX9r7wgsXB/OqK5CaopGRgrZjgQIbLG00iIEp
 RI1SCLiax3eP8LXbsKyb27qNLCM70Ec0N7WxW2Nvbs0PiZ5SlwIH54XhsalPydisL0PsZT4815d
 ZxsPOqow==
X-Received: by 2002:a05:651c:2206:b0:32a:7750:a0e1 with SMTP id
 38308e7fff4ca-32f093060bbmr26807871fa.26.1751897298390; 
 Mon, 07 Jul 2025 07:08:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDbYA7Y7lcJhWrxX7I+ki5eZwpJES/BFoP8wVh7+OjF3oPJ5IJoDdsItwghhoUIxPT67g+btmuS8ekAxrRWHk=
X-Received: by 2002:a05:651c:2206:b0:32a:7750:a0e1 with SMTP id
 38308e7fff4ca-32f093060bbmr26807611fa.26.1751897297802; Mon, 07 Jul 2025
 07:08:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250701113146.1268492-1-david.marchand@redhat.com>
 <20250703082010.2002295-1-david.marchand@redhat.com>
 <f7tplecqft4.fsf@redhat.com>
In-Reply-To: <f7tplecqft4.fsf@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 7 Jul 2025 16:08:04 +0200
X-Gm-Features: Ac12FXzx7WlEKSjIW9akkwGHRlo_HIxYYueBqNEmIAm4lIC4UV3tRkKhUYSY2aU
Message-ID: <CAJFAV8yVE=q6LdSSuy3MzZYxxOvenH3prRZf2dQDL1SyaXFfiA@mail.gmail.com>
Subject: Re: [PATCH v2] ci: check C++ headers with clang
To: Aaron Conole <aconole@redhat.com>,
 Rui Ferreira <rui.ferreira1@h-partners.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com, 
 Michael Santana <maicolgabriel@hotmail.com>, Patrick Robb <probb@iol.unh.edu>, 
 Thomas Monjalon <thomas@monjalon.net>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: H4kB8Ciq-Se3B34kzBJNUr3H3c5pTbSb-aXl6W4-hSk_1751897299
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

On Mon, Jul 7, 2025 at 3:41=E2=80=AFPM Aaron Conole <aconole@redhat.com> wr=
ote:
>
> David Marchand <david.marchand@redhat.com> writes:
>
> > If not passing an explicit compiler for C++, meson uses c++ which
> > defaults to /usr/bin/g++ on a Ubuntu system.
> > Explicitly choose which compiler to use for C++.
> >
> > Signed-off-by: David Marchand <david.marchand@redhat.com>
> > ---
> > Changes since v1:
> > - rebased,
> > - moved CXX tweaking in the branch enabling headers check,
> >
>
> Not sure why we got a segfault with this in IOL:
>
>  36/120 DPDK:fast-tests / eal_flags_misc_autotest        FAIL            =
 3.78s   killed by signal 11 SIGSEGV

Strange segfault indeed.

The logs show:
...
EAL: VFIO support initialized
EAL: invalid parameters for --log-color
EAL: invalid log arguments.
EAL: Unregistering with invalid input parameter
EAL: Memzone is not allocated


This smells like a double free... maybe a race in the cleanup phase.

And then this reminds me of a change we did for v25.07.
d84bf0d9aeb4 ("eal/linux: unregister alarm callback before free")

But I don't see something wrong with this change.

Copying author and reviewer.


> I don't think it is related.

I don't see how my patch on testing headers with C++ could be related :-).


--=20
David Marchand

