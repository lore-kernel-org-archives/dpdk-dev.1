Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD684CAC59A
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Sep 2025 08:28:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A668C402C1;
	Fri, 19 Sep 2025 10:28:37 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 0D6AF402B7
 for <dev@dpdk.org>; Fri, 19 Sep 2025 10:28:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758270516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qam1muhUPYP48j79mlBd6XAwtXjMHLysPLbFtwL0xvY=;
 b=cJnJc2jL0U8X0dcl15iWwrhltnmF/sEXa3Vn/BVVojT2r+jZJWfr7r3Iw9ysWay3s+9O6m
 6AyCFcrVi4Pq2g/gt/kWCqdkKV5WFRpytSJ5aK7p3BKLJtiXVTXewApvn9TgNWA/q/JfIh
 qTELNjtUgTg336x2xX3xS3cswhx8ia0=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-aXQ9svzYOi2dbQ_uZZaQgQ-1; Fri, 19 Sep 2025 04:28:33 -0400
X-MC-Unique: aXQ9svzYOi2dbQ_uZZaQgQ-1
X-Mimecast-MFC-AGG-ID: aXQ9svzYOi2dbQ_uZZaQgQ_1758270512
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5711e6ebaabso932250e87.1
 for <dev@dpdk.org>; Fri, 19 Sep 2025 01:28:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758270512; x=1758875312;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qam1muhUPYP48j79mlBd6XAwtXjMHLysPLbFtwL0xvY=;
 b=Z6pDOOBn9HRv0c/eK84d+1W+JgbzrA4LacjOsa3uSfIsa2/EoMd2FtTaIw38YLw2X3
 bwLjALXFqS6ndvz3kuAGzkjCI5ogZVfqJ6JnEJ4guA9IuW1CvhtO127BMVl+55BH+Ywl
 6E+T5mLlhc50WTIqNF9MEoXNmHCxfG45Y+qAuxWp3GKGRnf/42GXIQNYHrDKyaGDMPp4
 yI1Ft/5yRwm0j8oSGWKFDLLM+N7CyYEzXRLzrxrQvhQyVpZaUza76PngE7la3jV7cNpc
 W2qve+LigstuSTTRaiTIy5ciJIlEhwcCUx6ikAiEYPw4ZS4JpSI0no9xC/Llot6/pwHk
 ZPbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX73iFBZIycTai3sqde6jMFlFydUBpTc3U7uh/5Rfpx4+N3/qGMrYpzvtQt6mvFkt/KQb4=@dpdk.org
X-Gm-Message-State: AOJu0YyZNLSAhVLm1WG2eU9u9zMvblFtSFduCPNfTzkaE3dEeRp3veja
 pFdS7Qx7SJfW7up1/5UDpoHa/pwecfZEhOIHI3N09QVTRewHFcESPKUhRrftpG4C+zbSDDsGzbp
 yG8uSRAF6WYL7P55oYYnffSkLopWepWusS+SYmgVskE5sLfIH7atkfUeFJp55jgFFp/vYYWrCTl
 s0JDzd8PjNkG3qabekM+A=
X-Gm-Gg: ASbGncudB+gU09BrVgozHD+oZtB1T7bp8pxGEhlUw5Q2xEj/y67/tJuwQeJxO9AGJXA
 Syvp/8MNYC5iCUf9JmglfmjGi6SHN0BgMWeUCblBlLlPlk1hL4yiui/rCS2auNxPd9AyqSBtGt2
 ZcFCD73q0MMNQJCZhs7LGoqwg=
X-Received: by 2002:a05:6512:3d8b:b0:574:927f:8c24 with SMTP id
 2adb3069b0e04-579e1b6824bmr637097e87.25.1758270512211; 
 Fri, 19 Sep 2025 01:28:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRuSgIlvzSMOy/u1e0S4SocOpWVF3W0fsJwuQlg0keInNX5mTLDHSHCmDrlpxhro/YMJI1TuJBX1jCaTlZmgE=
X-Received: by 2002:a05:6512:3d8b:b0:574:927f:8c24 with SMTP id
 2adb3069b0e04-579e1b6824bmr637087e87.25.1758270511729; Fri, 19 Sep 2025
 01:28:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250903072826.1727004-1-david.marchand@redhat.com>
 <20250903151800.1965006-9-david.marchand@redhat.com>
 <20250905211157.00ab0e5a@hermes.local>
 <2776153.atdPhlSkOF@thomas> <20250918081652.36fd3566@hermes.local>
In-Reply-To: <20250918081652.36fd3566@hermes.local>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 19 Sep 2025 10:28:20 +0200
X-Gm-Features: AS18NWA63FhyOXkufEPSkdgUozee_UQkHO900EJ18j9Ij53hXfFmtZx1FL07HW0
Message-ID: <CAJFAV8wE83yx_rFY7J_F80hmf5C7Zetbjcv5YsdL+_zuBOUUFQ@mail.gmail.com>
Subject: Re: [RFC v2 8/9] uapi: import VFIO header
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Thomas Monjalon <thomas@monjalon.net>, dev@dpdk.org,
 maxime.coquelin@redhat.com, anatoly.burakov@intel.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1MDGHYKuBmv8_gHL7rHIV04R8BHICqbukgee3MnFdpg_1758270512
X-Mimecast-Originator: redhat.com
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

On Thu, 18 Sept 2025 at 17:17, Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Thu, 18 Sep 2025 10:48:12 +0200
> Thomas Monjalon <thomas@monjalon.net> wrote:
>
> > 06/09/2025 06:11, Stephen Hemminger:
> > > On Wed,  3 Sep 2025 17:17:58 +0200
> > > David Marchand <david.marchand@redhat.com> wrote:
> > >
> > > > Import VFIO header (from v6.16) to be included in many parts of DPDK.
> > > >
> > > > Signed-off-by: David Marchand <david.marchand@redhat.com>
> > > > ---
> > > >  kernel/linux/uapi/linux/vfio.h | 1836 ++++++++++++++++++++++++++++++++
> > > >  kernel/linux/uapi/version      |    2 +-
> > > >  2 files changed, 1837 insertions(+), 1 deletion(-)
> > > >  create mode 100644 kernel/linux/uapi/linux/vfio.h
> > >
> > > The linux kernel source tree has a well defined method for making exported
> > > uapi headers:
> > >     make headers_install
> > >
> > > DPDK should not be inventing its own method for this.
> > >
> > > If you use this on current released kernel (6.16) you will get slightly different file.
> > > The point of having DPDK vfio.h was to workaround case where distro was too old;
> > > not to be different.
> >
> > The diff below is because of a different (but compatible) version.
> > I don't see the point about the method.
>
>
> The reason to use the same method of generating uapi headers
> is then the guard values are the same. If some other header happens
> to include the other vfio.h there will be no problem.

The current script does not align the include guard, that can be fixed.

Now, if the concern is about inclusion of a system installed uapi
header, then using make headers_install is not enough.
We must also ensure that DPDK code includes "our" uapi header first,
otherwise, we will again face issues with (build system) outdated uapi
header.

I'll post a new revision with this change soon.


-- 
David Marchand

