Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62567C5AD49
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Jun 2025 14:17:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8185B40A89;
	Tue,  3 Jun 2025 16:17:35 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 7534F40A87
 for <dev@dpdk.org>; Tue,  3 Jun 2025 16:17:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748960254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DcxnC2fOtqJ52aZdzyA0goNuJQyfx3sG37sZ2pxNNh8=;
 b=MdmdeoMx5ga03yfGwTq5d3fh56r16JxhbFrFC8BKTX3JQ6YxNtN8JpTdYYrOUKr3flGCD/
 F6DtPxoGF/wZrQEaal/KgjIoDjAILUihKsXWmMoPrqKnCNd8ikB7+i0yAo3FR+g153YjLF
 w14hIspqsAU0z8xZqlr0i+7JQggeDGI=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-KF2oAjKoNpes8YyXKStkbQ-1; Tue, 03 Jun 2025 10:17:32 -0400
X-MC-Unique: KF2oAjKoNpes8YyXKStkbQ-1
X-Mimecast-MFC-AGG-ID: KF2oAjKoNpes8YyXKStkbQ_1748960251
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-32a6c3d3a75so20286391fa.3
 for <dev@dpdk.org>; Tue, 03 Jun 2025 07:17:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748960251; x=1749565051;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DcxnC2fOtqJ52aZdzyA0goNuJQyfx3sG37sZ2pxNNh8=;
 b=Nlqk7WTwKPitpmULxnfClqv67QdLz33mRWxhUNYOgvPiOIEbG+5iMqWgmz9xDzWlpq
 29iyVk3aXtsG1hGUhP2pxeYcExXqsbUxohKTUNxUibYk4JHeQLzDHs5z4qOer0UAPLf0
 2dF4lM3Vwiol8qBNpjf9FDAn/glavo6e0T3AUGW/uzh82hxnTWDwAALL9r6+VZxFouNj
 qMIjiiCAoF0/Ry3dALz8+C9Ir/29eRpHUHJyK9hRugXcZ+SCJczC5P0UWq7lFQH05uqG
 EN+KMNlpkwiqBkPXM5ZYBhujAkgrGTqPM85X+LLkHPdHy1oDnm4vwMFy5437md+Yv9X3
 pjZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUF8OWojFgicIkqyKKlmz5ileNOAFXJ9qDwJoeFX+XAYR3XseAOfsCexhM4XgkKXXGawMA=@dpdk.org
X-Gm-Message-State: AOJu0Yz37NmZe/jQHZkTAjY0im87PwDpTXSYaHg7cP8r+wI7jFsQjZon
 qXJdFt76/hkJsXHTcN7bUlYdd81pniXuYfO31ZZiFBqjL3knn+9HT6SNBOCtnNRHDxSoUdk3l5R
 WrhRlx6AUpc11E3V51rExbt2a/BfFY/AxhAm2+UkhE4gMW98al9g0htAQjiK+wrmUN/i8X5VElq
 6bNFMiyMFnfcBHf6E9puk=
X-Gm-Gg: ASbGnctRQYeaGofaL1H+TWs4jhQ18mRoSgD6w3PGvPBlMrrtjtxpJRpkEO0ev0ywXTY
 i/hv3KCXz/Lnru6rOqKaH7vbLZ5vGFuasWFLoXjRTNh+mSxZHEIth2epFn2C3aiiF8YS+6Wc=
X-Received: by 2002:a05:6512:3090:b0:553:28a6:4384 with SMTP id
 2adb3069b0e04-55342f54674mr3821484e87.10.1748960251141; 
 Tue, 03 Jun 2025 07:17:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEX0j1lmMJ1XYdBqZ5ptVilKQnPjjdu3gL7sscqNi7YDmK54TSjC266SfahkvmOAxGcXU2hTtHbG1RATSQmliU=
X-Received: by 2002:a05:6512:3090:b0:553:28a6:4384 with SMTP id
 2adb3069b0e04-55342f54674mr3821472e87.10.1748960250650; Tue, 03 Jun 2025
 07:17:30 -0700 (PDT)
MIME-Version: 1.0
References: <1746827534-19881-1-git-send-email-andremue@linux.microsoft.com>
 <CAJFAV8y8vibAGFsAR1XPFedR0-q+KC+Rm1=2cNPyJ5vF3ATKfQ@mail.gmail.com>
 <20250516125035.GA29027@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <8651425.NyiUUSuA9g@thomas>
In-Reply-To: <8651425.NyiUUSuA9g@thomas>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 3 Jun 2025 16:17:18 +0200
X-Gm-Features: AX0GCFsWvDQNXGXvJEMP2JgLlEwWaXVSVm1fuA-tSn8CKsAZhMNb6wgnBp5Jlvc
Message-ID: <CAJFAV8zQwrXyA+Learg2nRVbDVGgg_GytjqSOk_NY2PFVfmCag@mail.gmail.com>
Subject: Re: [PATCH] regexdev: enable to be compiled on Windows
To: Thomas Monjalon <thomas@monjalon.net>
Cc: Andre Muezerie <andremue@linux.microsoft.com>, dev@dpdk.org,
 Ori Kam <orika@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yuX8P50m8NQ9J_rm_uW_FBkYNC_dv2kGSykp5PnK_Kc_1748960251
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

On Fri, May 16, 2025 at 4:44=E2=80=AFPM Thomas Monjalon <thomas@monjalon.ne=
t> wrote:
>
> 16/05/2025 14:50, Andre Muezerie:
> > On Fri, May 16, 2025 at 10:01:42AM +0200, David Marchand wrote:
> > > On Fri, May 9, 2025 at 11:52=E2=80=AFPM Andre Muezerie
> > > <andremue@linux.microsoft.com> wrote:
> > > >
> > > > Now that mbuf is compiling on Windows, this library can be enabled =
as
> > > > well.
> > > >
> > > > Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> > >
> > > The test-regex app can probably be compiled too.
> > > Yet.. why do you want to enable this library on Windows?
> > >
> > > Support for this device class is defacto deprecated, as no vendor is
> > > providing recent hardware implementing this feature.
> > >
> > > Also note that it was not built with clang on Windows so far (I did
> > > not double check this assertion, I just based on the fact this patch
> > > removes a is_windows, and not a is_ms_compiler).
> > >
> > >
> >
> > I was not aware this code was deprecated. You're right that it was not
> > being compiled with Clang. This was just part of the effort to increase
> > code compatibility on Windows.
> >
> > I see no harm in enabling it, but at the same time, there's no clear
> > benefit either. I'll let you decide what to do with this.
>
> The benefit is to remove special handling for Windows,
> so I vote for enabling it.
> There was no regex development recently but we never know
> how it could be used in future :)

Well yes, there is no activity so adding this for Windows will
probably not add much maintenance work..


--=20
David Marchand

