Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C15ECC83F1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Jul 2025 13:27:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 13CD440DCE;
	Wed, 23 Jul 2025 15:27:49 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id B52E340B98
 for <dev@dpdk.org>; Wed, 23 Jul 2025 15:27:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753277267;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YMFOU02aRRJToAlKHa7Uua/We6n830IzfbHm+BFkm7E=;
 b=hT/PVx36AFwXn0U1LWArSQnYkUUzb+GxbpDcsiWq5IrIOg/S5in9aUaAcB3tBHoxHu8v/M
 KqRGe3XhSoHpmynrR+RXoJ1UyL2kcVw+RXvwx7sXRcUKN1NnaJRwWUa08turMSwzrXSoH4
 Pjo4r8bhI/QvueiMwjKPGtcbCWlXkG8=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-fsqpXVjeOwyxciwkdg40kA-1; Wed, 23 Jul 2025 09:27:46 -0400
X-MC-Unique: fsqpXVjeOwyxciwkdg40kA-1
X-Mimecast-MFC-AGG-ID: fsqpXVjeOwyxciwkdg40kA_1753277265
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-553b94b73d6so4671674e87.2
 for <dev@dpdk.org>; Wed, 23 Jul 2025 06:27:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753277264; x=1753882064;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YMFOU02aRRJToAlKHa7Uua/We6n830IzfbHm+BFkm7E=;
 b=PrwCvOZYFVHB/zHjpPukqXm+FsoW938qkt9TVYVWEI/pW12m0BnOrY7RW4Y1iOAz48
 nY6iCfWETdjT21QEMI6nBnVRpumYTv1sXBvhV8Vj4Wfa6ypeBX/ZHAkQAFeV5Bb8Posf
 09r4+1EQFrurNGX+7TEysNLss8y0jyoLbH1isEgkSa5WZ1QzJYLEI+sIECJ+EnmExcnk
 BRaZpHW9Ia0i0lLzdrFyz46Zjl/PT7lQLduO1hLPKlwpHjHV/YBZV5z0PJzBZ5Z3CoVW
 7Fx33COZIT63GeuxwrBWEWT8vYlAMWxQWnIjzfoVMOFnlw4uQ29RIiKZKiBpIWZwrUk/
 rGCA==
X-Gm-Message-State: AOJu0Yz3tRpz7XAmj63fXT0+UDhU5O0fC4fsysE4QvYz+D5CxMGUpW4R
 OaiFY0SWZA7zCvaF/KpFWx/4Zzc35Oo4s7o/XF9v+j0T+mGXpZMjZatCOKu4BNJvyFOiJ6+Cswd
 8zTQ8KAHr3onuzGSknJwwquPg76MO+DR8sV6ucD3svPFvOkFz0LmyYtKQAPLgiDE5fTjwsi2he7
 WGTG0+X1iWXuN6RF4jqe8=
X-Gm-Gg: ASbGncvFqoYetYufsaW9Ix8cxiJERMX8rONtkwktqcxqbD1qIXQYO7/YM49NUJ03FVU
 4bclA85iNP4vBXw4K2BdoYxmfUBdO2pE4TIhjd83iO0UrpdjfZszAI+VZ2cvKAPq5lfWTjQRB1Z
 Hi6HV3ySWRpPYCIfGZmOjtvY8=
X-Received: by 2002:ac2:5394:0:b0:553:ca33:46f with SMTP id
 2adb3069b0e04-55a513e8100mr758106e87.29.1753277264395; 
 Wed, 23 Jul 2025 06:27:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFubbeQfGEU+swoNRs/JWR3ggZYMAFE8qfw0ycw3mRcTVLg4GT5eOsEF4WUAR96qP/elQQqCSi41VqZHXeXJUo=
X-Received: by 2002:ac2:5394:0:b0:553:ca33:46f with SMTP id
 2adb3069b0e04-55a513e8100mr758096e87.29.1753277263857; Wed, 23 Jul 2025
 06:27:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250722132441.3700305-1-david.marchand@redhat.com>
 <aIDDpWm_M6m2SCIp@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aIDDpWm_M6m2SCIp@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 23 Jul 2025 15:27:31 +0200
X-Gm-Features: Ac12FXw0e7xF1gDtSaACPuAx8kKdmmhCpS-qUmjQvqI1f5NyPuVXjKN6gqKOd8M
Message-ID: <CAJFAV8ykvyJ97iM1VO-Vs6X=ayphx+nHqc3A-1My871dpug92A@mail.gmail.com>
Subject: Re: [PATCH 1/2] version: 25.11.0-rc0
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, thomas@monjalon.net, 
 Bruce Richardson <bruce.richardson@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _c-MBF8ODJOUvHxEW7hMaRejkGTp7j-yPDQueHCVEn4_1753277265
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

On Wed, Jul 23, 2025 at 1:27=E2=80=AFPM Bruce Richardson
<bruce.richardson@intel.com> wrote:
> On Tue, Jul 22, 2025 at 03:24:40PM +0200, David Marchand wrote:
> > Start a new release cycle with empty release notes.
> >
> > The ABI version becomes 26.0.
> > The ABI exceptions are dropped and CI ABI checks are disabled because
> > compatibility is not preserved.
> >
> > Signed-off-by: David Marchand <david.marchand@redhat.com>
> > ---
> >  .github/workflows/build.yml            |   4 +-
> >  ABI_VERSION                            |   2 +-
> >  VERSION                                |   2 +-
> >  devtools/libabigail.abignore           |  14 ---
> >  doc/guides/rel_notes/index.rst         |   1 +
> >  doc/guides/rel_notes/release_25_11.rst | 136 +++++++++++++++++++++++++
> >  6 files changed, 141 insertions(+), 18 deletions(-)
> >  create mode 100644 doc/guides/rel_notes/release_25_11.rst
> >
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
>
> Thanks for this, this opens up the release notes for 25.11, unblocking us
> from sending patches referencing it!

Thanks for the review.

Series applied, here we go!


--=20
David Marchand

