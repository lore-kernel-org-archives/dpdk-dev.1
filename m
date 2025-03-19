Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C462FC35FFA
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Mar 2025 17:12:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D7A99402C4;
	Wed, 19 Mar 2025 18:12:55 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 928914026B
 for <dev@dpdk.org>; Wed, 19 Mar 2025 18:12:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742404372;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NJkYPEHySA0Xt7xQB5PLWymDK3blAOUa8UQmmTTc+zQ=;
 b=IDJtDdLwyijGnOACUfre+spzXsA4+bIY8aw4lmEZq3nI5x7wBJ7R80v2UHg5xEUCWb+8MW
 0Gqu/6TpJhkR9En/3oAsdRFTADuw6C/bT57e+4f+Ij/WTRwBNfjgZj077loidoFjb2nX1c
 nTeHKTaxWZ8NP3ZUVXDX3QPCLc5qKXg=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-LfH1F4HqPxWNhhWDIgIIZA-1; Wed, 19 Mar 2025 13:12:51 -0400
X-MC-Unique: LfH1F4HqPxWNhhWDIgIIZA-1
X-Mimecast-MFC-AGG-ID: LfH1F4HqPxWNhhWDIgIIZA_1742404370
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-542a77b4a4cso4218335e87.1
 for <dev@dpdk.org>; Wed, 19 Mar 2025 10:12:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742404370; x=1743009170;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NJkYPEHySA0Xt7xQB5PLWymDK3blAOUa8UQmmTTc+zQ=;
 b=cxunMl2gmdgij40YVNNPfhIP0k5CVHPtzARvZkdNI2KFQ6fB9bjjMV3hOvy52qOgWM
 wMZxb/Z8xTrjRwniYf8RXlZsgASVISAn9+k751DXQzNYW6licJVsaxQ+kWVwVX5N/fPi
 M2zAraqN4glXtYEoP0DTJwpDPXWyt4X032ISDEqMV6nTz1J1DPjlnIF4cmr+pwd11qJ+
 Ya46eDby/YLSyNWMTAQta94H9w43Azf7PuUSKFtcdbAd9PujygocfKfCyCpaRHUvyj0F
 7uTrPjscoU+9EXOkfRO1KKRuQbxEEVel34j3TrwyqHhRS/+v2O8dUAGUdsNrW0aAiQi7
 47BA==
X-Gm-Message-State: AOJu0YwRaGvk8l6ioNKreEkyClkJjMGrwuVsOJJaBvbigGja+9RPeurn
 W+5Ec969P2+muTZAhxWzcY2PM3e1iO9nt2jk8gjuPrjMsuidQvZjqHVO8vgdu66zkhTcnabXOHt
 oFWXtH74cgFld7mO5FOjMXc+4NuCldhfDcjq/11NaY0B7nXTxSxtGcFensC9V/K1zc0d95vDx1M
 liemg37TzSsG8saVE=
X-Gm-Gg: ASbGncvhgyt4BurHUWCO/UDlRc9BjC1JWdYzXgBirCLfjbvl7SYRKLtIigHpWFNZbQN
 O5JNbXSb4XJz9OMK8B1K3lheXeAC2w84zslnMdXbMCtGXybWVzfDsmg+gkZ8awYbGGa/M9dLxfD
 HHXin+IQpBmCSzYA9ig1ofMWbUBaIkEQ==
X-Received: by 2002:a05:6512:1305:b0:545:a2f:22b4 with SMTP id
 2adb3069b0e04-54acb1fe2a3mr869234e87.40.1742404369853; 
 Wed, 19 Mar 2025 10:12:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWuhB9jvrwUQH5FZ6rr3QpHGYv/HMuOV9kxSDIhRKCDbeeXPj15dKciAjYniWhMojg34nR34OF+UR9koewNm0=
X-Received: by 2002:a05:6512:1305:b0:545:a2f:22b4 with SMTP id
 2adb3069b0e04-54acb1fe2a3mr869223e87.40.1742404369369; Wed, 19 Mar 2025
 10:12:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250305212349.2036410-1-david.marchand@redhat.com>
 <20250317154308.2782689-1-david.marchand@redhat.com>
 <20250317154308.2782689-6-david.marchand@redhat.com>
 <20250319091912.3b14713e@hermes.local>
In-Reply-To: <20250319091912.3b14713e@hermes.local>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 19 Mar 2025 18:12:37 +0100
X-Gm-Features: AQ5f1Jpk2jcMUTBA6xqvrNl2vNOtITLrpVxBfPRkKJB3SwjO_k8xUfCiWFDlfa0
Message-ID: <CAJFAV8wnNCqWmuz5Kw9097BWE51GiiBmypJca71dMm5=WmBgyg@mail.gmail.com>
Subject: Re: [RFC v4 5/8] build: generate symbol maps
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, thomas@monjalon.net, bruce.richardson@intel.com, 
 andremue@linux.microsoft.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MwQ4cSHkNQhgGdnv4T1MX3K9Bsh85wFwU0g-trPhSJI_1742404370
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

On Wed, Mar 19, 2025 at 5:19=E2=80=AFPM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Mon, 17 Mar 2025 16:43:01 +0100
> David Marchand <david.marchand@redhat.com> wrote:
>
> > Rather than maintain a file in parallel of the code, symbols to be
> > exported can be marked with a token RTE_EXPORT_*SYMBOL.
> >
> > From those marks, the build framework generates map files only for
> > symbols actually compiled (which means that the WINDOWS_NO_EXPORT hack
> > becomes unnecessary).
> >
> > The build framework directly creates a map file in the format that the
> > linker expects (rather than converting from GNU linker to MSVC linker).
> >
> > Empty maps are allowed again as a replacement for drivers/version.map.
> >
> > The symbol check is updated to only support the new format.
> >
> > Signed-off-by: David Marchand <david.marchand@redhat.com>
> > ---
> > Changes since RFC v3:
> > - polished python,
> > - fixed doc updates not belonging to this patch,
> > - renamed map files,
> > - changed msvc->mslinker as link mode,
> > - added parsing of AVX sources,
> >
> > Changes since RFC v2:
> > - because of MSVC limitations wrt macro passed via cmdline,
> >   used an internal header for defining RTE_EXPORT_* macros,
> > - updated documentation and tooling,
>
> Looks like a good idea.
> Is there any way to make symbols in drivers local by default?
> Right now if a driver defines a non-static function it will
> be visible in other code when DPDK application is statically linked.
>
> This can lead to problems where exports are missing or accidental
> name conflicts. Gcc has -fvisiblity=3Dhidden not sure about others.

This could be interesting, though it is a step further the current series.


- For clang, I would expect -fvisibility is supported.

- There is one warning I am not too fond of, in gcc manual:
           Be aware that headers from outside your project, in
particular system headers and headers from any other library you use,
may not be expecting to be compiled with visibility other than the
default.  You may need to explicitly
           say "#pragma GCC visibility push(default)" before including
any such headers.

I also see that this requires annotating symbol at the declaration level.
That would require to parse headers instead of sources (which seems
more appropriate as we are talking about symbol exports).

I have some doubt though wrt base driver code, that we are not
supposed to update...
The current RTE_EXPORT_* macros of this series were not doing anything
to the symbol themselves, and could be located anywhere as long as
meson could parse them.


- Not sure what the default for MSVC is, Andr=C3=A9?


--=20
David Marchand

