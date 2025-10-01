Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4629CCA470
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Oct 2025 14:13:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D251A4028F;
	Wed,  1 Oct 2025 16:13:13 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id A5C97400D5
 for <dev@dpdk.org>; Wed,  1 Oct 2025 16:13:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759327992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0sUu9ozr/rYIu2z39Sc2HG0IKAZ1lqfd0WZ+d06cUG0=;
 b=H/+n9P1UAhzKZtoi0K+YA/3Ayo9uofiuNYlf8KiDQ6oUiDLvJ6fbkEEEXSKrLZeY0eACZ2
 j513fiyX4kcOu+XHtB34ibqMpsvKlHCdTsnvgqgBa6Ma8NJ/xcn409uJ0DSL7MiWaPpDiP
 yev6n6OxDPFStMh/5BZjYybYJFq7mHo=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-BVNCcgGLOEaspHy61Tb2Zw-1; Wed, 01 Oct 2025 10:13:11 -0400
X-MC-Unique: BVNCcgGLOEaspHy61Tb2Zw-1
X-Mimecast-MFC-AGG-ID: BVNCcgGLOEaspHy61Tb2Zw_1759327989
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-57bccf22e0bso5584326e87.3
 for <dev@dpdk.org>; Wed, 01 Oct 2025 07:13:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759327989; x=1759932789;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0sUu9ozr/rYIu2z39Sc2HG0IKAZ1lqfd0WZ+d06cUG0=;
 b=wnch9nigiMJMvyti8o1IFdeWo8fS/S0RiJrfnfNp+mRi++aYxIAERCDfRg1/PNVsDG
 CdfUbGcwjbePF3tx50g2thuOuQhAvRfIfzvzDR5J/KV83hhnwmXjNF+j5Fm8PeHRSaHC
 BRZ14NK4ALpb+ly4mBbKpavFDKFigb/2BtgKNzhMZqBIhPbnxa5dFvnJpzG2SFV93iJV
 GD38x4zE2upfjm9TWw65cNLOzV8HHzVpsCc4QR12s6y86K+x9fca/voBclaMUJ0BuyNs
 eW5f4SBnbB+X9DYTZAM74NVsR/OqCjzLm7Om8F6aTRlWuPyJGXvjCkmptc8Wb3qsaPW+
 jkDw==
X-Gm-Message-State: AOJu0YxI9EJeJMxFFxE8luxJfKIK+OKDghEmpo6xFzmc+qvAcDFM8CDZ
 0xFFQc2Eerk1ZJl5/GW5fFE17XNQnnmm+BrU8u7v9SmOAk1/sEKG/TC5D8HLlC5FruNoycDbBFf
 X8FDFFMvefJFE4f4dUgUQyGdMhnzYMkDJs/tssfNDUcdZWPlUjtbSO8lxp/0nw0RQpmFV01YTNS
 +chBs/D7WoMDN9Ch8HOqQ=
X-Gm-Gg: ASbGncuChsBlXQoYIWPHOkIG4Ayy8XJCny6ORyZ8507+x+kYJDGxFBrPDalk6dpHY4G
 w8fig0Az4xVBernzGf3NoWVvkZO9WHkXsmChqNy66z32UyG0AKRUWCwB80ILGjrGWUQaC3ZasZ9
 CmeLIFU7CHkHoDWMe83QGyNCL2JDca
X-Received: by 2002:a05:6512:3d10:b0:55f:5685:b5e9 with SMTP id
 2adb3069b0e04-58af9f0e54fmr1244661e87.8.1759327989348; 
 Wed, 01 Oct 2025 07:13:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmM+Yv39vBuOHWIvkKI0dMQZuRCyrL8Kk7wmywDwNNyZZdQ6NhWfvzAwofahPDH5Doi5KAsFiqgkbqhSPb7aU=
X-Received: by 2002:a05:6512:3d10:b0:55f:5685:b5e9 with SMTP id
 2adb3069b0e04-58af9f0e54fmr1244648e87.8.1759327988890; Wed, 01 Oct 2025
 07:13:08 -0700 (PDT)
MIME-Version: 1.0
References: <20251001081825.2638077-1-david.marchand@redhat.com>
 <9acb2557-1f42-4880-ba93-020b14e6a0f5@intel.com>
In-Reply-To: <9acb2557-1f42-4880-ba93-020b14e6a0f5@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 1 Oct 2025 16:12:57 +0200
X-Gm-Features: AS18NWCmzgiepIKbdVLuVbLqn5_94isjKGiw3cALcE10w4qJAVRUDalvPCtM1y0
Message-ID: <CAJFAV8ynhCwV76W+1QVwDrzXFLiRWv+x9FiQkCGq+fw2f0CLJw@mail.gmail.com>
Subject: Re: [PATCH] ci: configure Coderabbit
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, rjarry@redhat.com, Aaron Conole <aconole@redhat.com>, 
 Michael Santana <maicolgabriel@hotmail.com>,
 Thomas Monjalon <thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dYhri1xbXj_LinY8qlvbTtAiF9ntjEwwnoWhsSCj5yw_1759327989
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

On Wed, 1 Oct 2025 at 16:04, Burakov, Anatoly <anatoly.burakov@intel.com> wrote:
>
> On 10/1/2025 10:18 AM, David Marchand wrote:
> > Coderabbit currently runs in ovsrobot repository (and can be used in
> > public personal forks).
> >
> > poems are funny, but not really helpful.
> > Reduce some noise by disabling (or collapsing) some verbose outputs.
> >
> > Signed-off-by: David Marchand <david.marchand@redhat.com>
> > ---
> > I copied the tone instructions and some settings from grout.
> > The docstrings check is noisy, and often wrong for C headers
> > (especially EAL arch headers).
> >
> > Opinions?
> >
> > ---
>
> Hi David,
>
> Can you provide a little more details on what exactly you are proposing?
>
> On the back of this patch, I installed CodeRabbit in my IDE (VSCode),
> and did a review of one of my recent patchsets - it's quite interesting,
> actually, and the comments provided were basic but meaningful, alas the
> free version is limited to like 1 review per 30 minutes or something so
> it's a bit limiting. On top of that, I found the tool a lot more usable
> than GitHub Copilot reviews, which are attached to GH pull requests
> rather than Git branches, and they take a lot less time to boot, so I
> feel like this tool has potential.
>
> That said, I'm not sure what this patch is supposed to do - is it to
> have it set up to review patches automatically?

The ovsrobot creates pull requests in its dpdk github repository, and
Coderabbit and sourcery are invoked on them.
Look for a link in patchwork, under the name "ci/github-robot-post".

For example, this exact patch got a branch and pr in ovsrobot/dpdk:
https://github.com/ovsrobot/dpdk/tree/series_36267
https://github.com/ovsrobot/dpdk/pull/124


-- 
David Marchand

