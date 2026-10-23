Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B2A606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 14:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CXzgjGB8
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5130640276;
	Fri, 23 Oct 2026 16:44:46 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id A133540265
 for <dev@dpdk.org>; Fri, 23 Oct 2026 16:44:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792766684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OtTbh8GQ+12a0pdPpDc8wXdXmFrTZ+nXbQgS2NrEy+Y=;
 b=CXzgjGB81FEl0TLEn1lUw9x/Z+S+9oM9sR36DsdXI+QrzN37mZe3vVSfQaXJbU5gujvrOx
 HZC0EMmKcfCTUvSvl6weiaX0OZrtFISOkBTs3ojunhMDVyBKTHR8vOWBAsyO6+bzx0TNu4
 Ryt0ksnCIsco8GVdsMwSLfXvFLLTy64=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-zWNesPEKM86cBFFeZ_Ca9A-1; Fri, 23 Oct 2026 10:44:42 -0400
X-MC-Unique: zWNesPEKM86cBFFeZ_Ca9A-1
X-Mimecast-MFC-AGG-ID: zWNesPEKM86cBFFeZ_Ca9A_1792766681
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-3ab426be412so4339481fa.1
 for <dev@dpdk.org>; Fri, 23 Oct 2026 07:44:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792766681; x=1793371481;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=OtTbh8GQ+12a0pdPpDc8wXdXmFrTZ+nXbQgS2NrEy+Y=;
 b=f7I82OhNU/bWBremtw2p/aw6+6oK88XWzFZOYW0QBolU04pE0btO3gg1TRSL60n76s
 kzrVMAqTLYmnDzOHMHxP+erbFlEgm9YeVbM+RdZ5TtfUvYY3Dq5U5ENKyEcPGIaM6l1c
 D860rzJPNK5BU2fRAqAnjI/T82qXYE3xbAn2zf/BpdaPSvt2jjt8HCEMjI3/6EW5obaj
 Ees9TDm/aLHUgHng7F62D1LPCgogtrExlaQNd431Qw9BfuGLM0Uj6p+oLa+Nfeb5j209
 1EXe889u+Zv/wxzRFRgqmogbAfDhhJwL0z3euvX1gqbUhn2LfDvHXYqLobwexaW6GNlh
 VG9Q==
X-Gm-Message-State: AFq9FYKLXYg0du1a/zH5DYhP6rNH5xAgKG4DRif3dhbAuA28EK1K4Zh8
 u/bqIoa/ZRBhpZnCG3bu6HB4fsvRykVOBTOgg5M2OC9OiW6xE3b/wD5MYe/mCItH12eWECorBFC
 j4oDu+YhYPqbMovuzY04UKPkvPYP6Uc7pK19kdqKtexwYyWs1uvr3nUVYIopeohf/PcuYsjWevb
 H6pjw189wSlWT9aIkluGU=
X-Gm-Gg: AYBFou3tNumCiWAnBB+P3T5pQNgOGnUXMgW2V1tN3CyiNEBqKi4nZnKTjNCNycWkVs4
 LOhSG2RfkPatoKgMK5lKJFBt34JufUi7cLeZZ8RK7q8wgYUIi92JrYpgAeLUXNjlFlPPV4TjLgP
 aoR3cdOyrw0XKdFdfMLyavNnZ9nkGBd+h0cTLlejDrfJ/0qEHeonu4RntXx9tSMGa4gkC8NemUD
 WJeMlVEziady3KGr5K30j/11oSX1Bj45h+Ybpt301vbpL8Y
X-Received: by 2002:a05:651c:1441:b0:3a3:7682:49a1 with SMTP id
 38308e7fff4ca-3ac663711e0mr5968171fa.22.1792766681034; 
 Fri, 23 Oct 2026 07:44:41 -0700 (PDT)
X-Received: by 2002:a05:651c:1441:b0:3a3:7682:49a1 with SMTP id
 38308e7fff4ca-3ac663711e0mr5968131fa.22.1792766680610; Fri, 23 Oct 2026
 07:44:40 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <5766e02ea3243de1f63eb68efc210719f11815b6.1792763492.git.anatoly.burakov@intel.com>
 <8e863c1aa5d265fa27560dd27ba61858c217ff3d.1792763492.git.anatoly.burakov@intel.com>
 <CAJFAV8yi8VxCz8kyuw=Qz155KPzWw2OPGMPJ0nRH+HhBFTMHsw@mail.gmail.com>
 <0615fe20-ce56-4ce8-a7d6-be46f741949e@intel.com>
In-Reply-To: <0615fe20-ce56-4ce8-a7d6-be46f741949e@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 23 Oct 2026 16:44:28 +0200
X-Gm-Features: AclHuK_LNfikJQ05h5KZoZCCH7A4Adrrw2f-OHCtsPwWH13tA8HcQ4u6mdJPo-4
Message-ID: <CAJFAV8ypGhAUU_XvFrxe9nMrxCWXwRmYL6sqzPjT0UKrYQLw1g@mail.gmail.com>
Subject: Re: [PATCH v4 2/8] interrupts: fix event arrays copy on instance
 duplication
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, Harman Kalra <hkalra@marvell.com>,
 Ray Kinsella <mdr@ashroe.eu>, Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ywL004Yp7QWZP2EztUPdwrrlzDc5eVI_tcJQPyxd4Ek_1792766681
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 23 Oct 2026 at 16:37, Burakov, Anatoly
<anatoly.burakov@intel.com> wrote:
>
> On 10/23/2026 4:15 PM, David Marchand wrote:
> > On Fri, 23 Oct 2026 at 15:51, Anatoly Burakov <anatoly.burakov@intel.com> wrote:
> >>
> >> The event FD and epoll event arrays are copied using the number of
> >> entries as a byte count, so only a fraction of the entries make it
> >> into the duplicate.
> >>
> >> Copy the arrays by element size.
> >>
> >> Fixes: b7c984291611 ("interrupts: add allocator and accessors")
> >> Cc: stable@dpdk.org
> >>
> >> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> >
> > Thanks for working on those issues on such short notice.
> >
> > I already put a series for fixing a number of issues with interrupts.
> > As part of it, I would remove the whole duplication principle.
> >
> > Could you perhaps test your series on top of mine?
> >
> > https://patchwork.dpdk.org/project/dpdk/list/?series=39749
> >
> >
>
> It seems that your patchset makes most of mine obsolete, as only 3
> commits survived the rebase (incidentally, the ones I had in v2), and
> the conflicts were trivial enough to resolve on apply IMO. If you like I

Indeed.

> can rebase my patchset on top of yours so that you may include it in
> yours and take over?

I don't mind taking over.
We just need to agree on my comment on the last patch.

The other two fixes lgtm.


-- 
David Marchand

