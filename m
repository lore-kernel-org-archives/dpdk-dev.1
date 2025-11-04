Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86141CCFA04
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 15:29:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 93C834028C;
	Tue,  4 Nov 2025 16:29:06 +0100 (CET)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com
 [209.85.160.174])
 by mails.dpdk.org (Postfix) with ESMTP id 49A0440269
 for <dev@dpdk.org>; Tue,  4 Nov 2025 16:29:05 +0100 (CET)
Received: by mail-qt1-f174.google.com with SMTP id
 d75a77b69052e-4ed0d2a949dso38628871cf.1
 for <dev@dpdk.org>; Tue, 04 Nov 2025 07:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762270144; x=1762874944; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h3rKDB2nkx61x0mXz9g1wj7+r1lS2zu1gxF09qkXczU=;
 b=NG/++MMbl9621y9AZCgqMnjhpwIL5rBRJaxy+5bBexCCWqbw0UFAWwVXgL4aUbU6wX
 6qzL1O8vmaa099eJ6KmXmme/lU6lSz+MIN5exvIMjlbZli4bhz5WvgoxqhS7FEASgJOV
 J9/ICo35sXwtffvlqVXuSG0JY0QwVBt1croDocplm409wFrkayJsVysFSzZ8Ws0tRlG2
 Dj9X8Nv2nPTDQYEq6GHUjTtrl62mOs9PrwrN742+7wVlFYG5OodWRlSuxTtuXtpWMsUV
 MzVul2DLo+XaroQ1nGW67bRY9kKF6r9OgExnmiNRbpxjqnHYR1tuY6EEjk/okSwYD+lh
 AJcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762270144; x=1762874944;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h3rKDB2nkx61x0mXz9g1wj7+r1lS2zu1gxF09qkXczU=;
 b=v/LEJB48XU4tsuVQrQDpXIBUkV8YbsOdZVMpxojGIzz+oxU4iEdafxmIHQ5jw6q4DG
 dulPmZTD8TRG5zQDh9S9SP1l7tDYi2SHlr42ykDctvDLjO2b2l7xdnRhU/S1PIkAlkW/
 +2XCXpOUKlvsu3oHKtGnYeFDKMzmmr9dbw3zfEloyfPsg3vtqdZic9j+VL8ccInF5Ni8
 +xd+rtrKWuXxdPjgB7JufnXlT1UZsGtOiqTF02brOyoWrZP5+rjG1aGQn3NW1PRuYCP1
 BZg+bNQ56IZqRV9mfgvh9pqX/qBOv4OaIR8JubfZUGKQM3FP6VQ08IE5BErqisWozRUP
 2N6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkyuXjxVb+QPBsD82hummxX1PuIU4qCTc+WqiZbpC+A39lW65T7IkwPraeuQCdV/T4TSk=@dpdk.org
X-Gm-Message-State: AOJu0Yw2ghD+Zq86tJFrFbnZyc6STeXY4lFZDshu2p+Lqrzk69DWyHC1
 Pq4vfRD8t1RYIziOYmLeoRbCIUpZoOWieranykM/r+MVASDe1n/LZrC8cLsvAXPgWAJuWsGJKTd
 A93g3OODQRQEHauUeH927GW+fpHGZ9qA=
X-Gm-Gg: ASbGnctz6FcV/CKN+ZSTTVkPoIVmkg0SsDA9i5OzmOi1iBsow/JhIeaU9bSO71xPg6f
 idVOxO/LnAf1pu7me+sdaUtZ1lAobUZA7hCQyQ81oo/d4iH+rsKJacA3XR68aOiplSnVvPHy5t5
 ZPGuYeUWnFcgNpYmdOI3BFF5mPWKzeiR1kFNUHKkgnVf9pscw/xkhfJTovjHSkH8YnEs6EyzBcU
 toquqXk0e+rwaANYJpPCxx8C0Fmf86XMHDAfZjaMSJYpQ/tWjMrrvNN7cc=
X-Google-Smtp-Source: AGHT+IHwwkwTcMajiqaNyxlKT0FSpbv4rWAI9kbsEHZ5Ym9W6Vtf+qD+gK9cRrqLMZj7ng+bDMsg7ruihW4zU/OTJSU=
X-Received: by 2002:a05:622a:4c11:b0:4c4:6b67:ccd7 with SMTP id
 d75a77b69052e-4ed31073e28mr220381221cf.55.1762270144570; Tue, 04 Nov 2025
 07:29:04 -0800 (PST)
MIME-Version: 1.0
References: <20250901073036.1381560-1-ndabilpuram@marvell.com>
 <20251023172728.770661-1-ndabilpuram@marvell.com>
 <20251023172728.770661-19-ndabilpuram@marvell.com>
 <2492954.jbyF5MZJ3u@thomas>
In-Reply-To: <2492954.jbyF5MZJ3u@thomas>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Tue, 4 Nov 2025 20:58:37 +0530
X-Gm-Features: AWmQ_bn0yiM8NAPlR78KdDvdH5OOmbZB8dXy0fokLkFw59_NAXCbepsgKTL_t_0
Message-ID: <CALBAE1MQBeyAXxmunOVEV2gFux5_TBLBPXgbVN03C4C8Jy46Ew@mail.gmail.com>
Subject: Re: [PATCH v3 19/19] drivers: fix Klocwork issues
To: Thomas Monjalon <thomas@monjalon.net>
Cc: Nithin Dabilpuram <ndabilpuram@marvell.com>, Aarnav JP <ajp@marvell.com>, 
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, 
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>,
 jerinj@marvell.com, dev@dpdk.org, stable@dpdk.org
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

On Fri, Oct 24, 2025 at 12:25=E2=80=AFAM Thomas Monjalon <thomas@monjalon.n=
et> wrote:
>
> 23/10/2025 19:27, Nithin Dabilpuram:
> > From: Aarnav JP <ajp@marvell.com>
> >
> > fixed klocwork suggested issues in
> > cnxk component of drivers module
> >
> > Fixes: db5744d3cd23 ("common/cnxk: support NIX debug for CN20K")
> > Fixes: 3c31a7485172 ("common/cnxk: config CPT result address for CN20K"=
)
> > Fixes: 4b8eb5bd6627 ("common/cnxk: reserve CPT LF for Rx inject")
> > Fixes: f410059baac6 ("common/cnxk: support inline inbound queue")
> > Fixes: 47cca253d605 ("net/cnxk: support Rx inject")
> > Fixes: ac35d4bf4cd6 ("net/cnxk: support ingress meter pre-color")
> > Cc: stable@dpdk.org
>
> Would be better to split and provide details of the bugs.


@Nithin Dabilpuram  @Aarnav JP  Could you send the next version with
this. Good to merge the next version.



>
>
