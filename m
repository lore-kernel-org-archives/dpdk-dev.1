Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FDF2C3ABC9
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 May 2025 13:30:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EE4DA40292;
	Fri, 16 May 2025 15:30:40 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id C419E4028F
 for <dev@dpdk.org>; Fri, 16 May 2025 15:30:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747402239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jLk9FgSuBoecYzvQkYNhn9u38Ikq5uUwx0fqGM5AJMg=;
 b=RSDg/2gZKMIa3rl4sr/b2R0S5OAq75ZMCFrmRe1ALFSEAfFlhMA7CyZX/ApXvkxh8g93Rp
 D4tYEu/58ARb9StIUc7dL6MmCNw8VtV6lW+oeeRV0vkA2YLBtybgzaDTBJYoy5j8ypq6fv
 2GqA13XFzAJuNrAux99qjWIBNCt/w+Q=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-c9Quc3rhOke5vtPbCRzLQQ-1; Fri, 16 May 2025 09:30:37 -0400
X-MC-Unique: c9Quc3rhOke5vtPbCRzLQQ-1
X-Mimecast-MFC-AGG-ID: c9Quc3rhOke5vtPbCRzLQQ_1747402236
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-54d6f93314bso1085586e87.2
 for <dev@dpdk.org>; Fri, 16 May 2025 06:30:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747402236; x=1748007036;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jLk9FgSuBoecYzvQkYNhn9u38Ikq5uUwx0fqGM5AJMg=;
 b=SIo/fWCd3OOCaPffaKxpIHpczHUlF2TUGD7lzmzYE2TKgHrwN5d7HwBKoIa8/2yBDs
 rKOwEfThsMyHczBNg//lJR4QmeKnnzE/VX7MyhQ2objCSIOHbkJ4wMPh08nv3pVoiDSX
 UTVksHZ28XwuUiOrANJ775rcq4Hkra4CDM69Tl4HQsXgBq+EHu1gRg+AAoFverroLSJT
 yyP3QXS+OJgpr5Ro/ZsvasFwOOUXcIVZoDajFkcOwmAfJF0Ay8I9kUFUIRNVb8UpesE5
 r9xfMBTGyvx/UY/u/Eo8pkLgbnZInyZ489LtaYLnEqiV6xYsZ/mK93Voq8gO3gojOnia
 E/ig==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1HI6rJ7wp59PPHWNbH/bAWsIpO5B1CRS4nBIzytXFPkkb+ov9/A5CV8bZ0rrCAcJFAD4=@dpdk.org
X-Gm-Message-State: AOJu0YzFLH50h0kk4zdnmhBBidy2OoLI899JxbyzVbV5FlgmDem/N17f
 8FCX84s056bZJIM6mHGWS/6yG8bGDJinV3M3a71lA8V+DQLHM0QR6/5hG7Ux+CJfrOwCv7pcC5Z
 9P8K7y8oBchH3kseZjjKshCk/UKeywTaMZ9MFhXrp5LUfZOh4mfRvGaXrWuTO255KxcGoj/SCAP
 b22eTAM0qujKBkbR2tftY=
X-Gm-Gg: ASbGncvqVFehLCRPhHKFXJC6x77/4tYgZZ/TiFm5ZvA+PWvqIwt30sNe5c0JGvN8uRn
 iDUm2vhaBP2ENq52NxBY0EOUQm0qxh1pC3LniXrCCaCnH4YZuayZvPFKlhWBBh43cK1e2IUA=
X-Received: by 2002:a05:6512:6409:b0:549:c1e6:cbb9 with SMTP id
 2adb3069b0e04-550e977f572mr743948e87.9.1747402236060; 
 Fri, 16 May 2025 06:30:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmdWv2YbeDONGGfEhutgsd4FeipEBVQoi10Hz8wIQX+Sasvbet3X056MiPK+Xw64EdQuWNzJ3YqpbHdy2wAPk=
X-Received: by 2002:a05:6512:6409:b0:549:c1e6:cbb9 with SMTP id
 2adb3069b0e04-550e977f572mr743937e87.9.1747402235604; Fri, 16 May 2025
 06:30:35 -0700 (PDT)
MIME-Version: 1.0
References: <1741311613-26629-1-git-send-email-andremue@linux.microsoft.com>
 <CAJFAV8z-FM5Jaw1tcVu0KQGoaPa7gbpvH3GjcVDEdqSF0Zn47A@mail.gmail.com>
 <20250516130918.GB29027@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To: <20250516130918.GB29027@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 16 May 2025 15:30:23 +0200
X-Gm-Features: AX0GCFstFSwCDMRmL1-xKVHR6_gf2-Xyc7TxVCknxTYmWBcoKN6LD9opyE1KQ7U
Message-ID: <CAJFAV8ykrMTkgmEpv6Pp1C9tULAaWMcgsmf6mL47hD14_1DH9g@mail.gmail.com>
Subject: Re: [PATCH] rcu: remove VLAs
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>, dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2IUKZOn64Y4gy-GhiivJXFcfB3OHD5cswO372LXG0fE_1747402236
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

On Fri, May 16, 2025 at 3:09=E2=80=AFPM Andre Muezerie
<andremue@linux.microsoft.com> wrote:
>
> On Fri, May 16, 2025 at 11:22:05AM +0200, David Marchand wrote:
> > Andre,
> >
> > On Fri, Mar 7, 2025 at 2:40=E2=80=AFAM Andre Muezerie
> > <andremue@linux.microsoft.com> wrote:
> > >
> > > There are two lines that were using VLAs, which are not supported by
> > > MSVC.
> > >
> > > 1)
> > > ../lib/rcu/rte_rcu_qsbr.c:326:12: warning: variable length array used=
 [-Wvla]
> > >   326 |         char data[dq->esize];
> > >       |                   ^~~~~~~~~
> > > 2)
> > > ../lib/rcu/rte_rcu_qsbr.c:389:12: warning: variable length array used=
 [-Wvla]
> > >   389 |         char data[dq->esize];
> > >       |                   ^~~~~~~~~
> > >
> > > The short-term fix is to use alloca, to allow progress with the msvc
> > > compatibility work.
> > > The long-term plan involves API changes and therefore can only be app=
lied
> > > with a new release. This long-term plan consists of introducing some
> > > reasonable limitation on RCU DQ element size.
> > >
> > > Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> >
> > Afaiu, enabling RCU with MSVC depends on this current patch and a fix
> > in test/ipfrag:
> > https://patchwork.dpdk.org/project/dpdk/patch/1741313581-14300-1-git-se=
nd-email-andremue@linux.microsoft.com/.
> > Is there anything else missing?
> >
> > If not, then I would be for doing this enabling as part of this
> > current patch (I can do this when applying).
> > WDYT?
> >
>
> You're correct. When enabling RCU lib, test_ipfrag is build and fails if =
the mentioned
> patch is not applied yet. If you apply that patch first, it would be grea=
t if you
> could enable RCU on Windows as part of this patch. Nothing else should be=
 missing.
>
> I had not enabled it before to not break the CI build.

Ok, I did my checks and it looks fine, so I squashed the mention
change as part of this patch.

I see patches on lpm and fib library for which I have similar questions.
I must stop merging for today but could you double check those
libraries can be enabled too?

This way it will be easier for me next week.


Thanks.

--=20
David Marchand

