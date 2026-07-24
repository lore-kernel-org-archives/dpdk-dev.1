Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B491DC531F9
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Jul 2026 11:37:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 665AA4029B;
	Fri, 24 Jul 2026 13:37:06 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 4E16040276
 for <dev@dpdk.org>; Fri, 24 Jul 2026 13:37:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784893023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=utvzctCdrqazHNo4s5e4GxuSa0kN8Ps+eOGZCMGyLXk=;
 b=GLyl4fcuAa0p1AEsero0yIzmF75PwR5r0KQDWUEV5zLQ0+J7baNYR6oc9MV/tIpqEAPMku
 0STVj9lJ+f/Ta3VhHLoS5YvCrqF4SKt9/o3ke4+o9rqgUwaRbFrZyZzykaAJ25HpVFzG4M
 ItIHIY9jAYGrm2pukQ3p7o3qZmIC5zk=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-Lbs-k0TrOAKckX80sb3BUg-1; Fri, 24 Jul 2026 07:37:01 -0400
X-MC-Unique: Lbs-k0TrOAKckX80sb3BUg-1
X-Mimecast-MFC-AGG-ID: Lbs-k0TrOAKckX80sb3BUg_1784893020
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5b01f81d9c0so282944e87.1
 for <dev@dpdk.org>; Fri, 24 Jul 2026 04:37:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784893020; x=1785497820;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=utvzctCdrqazHNo4s5e4GxuSa0kN8Ps+eOGZCMGyLXk=;
 b=Y42y4JwDbPVXyYhr0mLyFPkH8mAMLYwtIvckcr+X/NOeJFKtF0uUdd+Wby6jD/w+Ko
 3y1ktjIjlcuw6WqQ/PUARp8E7c8HU+JAWSbkUIBz91Hu+iixGpxcnCNcXyREJ1Fmqp1C
 oDI1wH065fRp+Qb0XZSDSAKHoxj2BDtudmezdZTBoZlLOJt1fy9+uAlQnvceEJZDG+XV
 xNsYHhglpxqv+BcyKPba4idR/1tlH6vGJDmk1ob6sp6Ws2Doef/akQG//2dnRZjZVdLx
 0JuYrfDlFR4JpKQlh81PO+q7CcPXaNiRHoWYypJxN0TryXd9RycFXrFLpXDJWqkYDGoS
 GdKQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpsO6XDDYtXVD1OMNclrZDYoGW/N7TJnQRRpnultznQ8mH2jYlUdlVTiXmLuZQYKS5N+pE=@dpdk.org
X-Gm-Message-State: AOJu0YyrpqdKRE0IKzeXrGmZ/2tpGE2maObVibYI1EaMgx0F/0tjFOEp
 7LPxKsZQo/KODeGxlkIe35dh5ZpdCLBZqgr4Zn2TqNbUjI+o8k1OQTZ1iP7mcTLyqi6H5nZPdFM
 XUSSL0THJId4k7aZsYmGB90aSg5wt9Gz0Nbu2BmjlM0GRvVP3ZccuEfn1493Lt9BMVvmtxSUXco
 QpIlnurxEItvH+Y6VeMEs=
X-Gm-Gg: AR+sD112WjvRHuJbEp5fgNbdp+9JMrhWNM00wgpUGOM/Ci5fYCfUDkqr+rwUOMcTiA4
 zG/nLaD3l8VQZzU+MmiJCUCHmWOK6StgE2yovDzL2+PUjpMLRxaLKhrbiYv7W5lPEdrJvYT7VjO
 /Xj0rBKYfNGzx9poy8ihrP4Itpqr4GoGWDLyzVFPmS7xMpkdxar/Mg4FTjUYDq2APykHqYQJW6z
 5P/G6tpJsIaAdmZxWH0ncZe18h+A0SZgujfSkWD5jfamcgS
X-Received: by 2002:a05:6512:3d0d:b0:5b1:56c7:5753 with SMTP id
 2adb3069b0e04-5b2b2f6d2e4mr1528172e87.47.1784893020148; 
 Fri, 24 Jul 2026 04:37:00 -0700 (PDT)
X-Received: by 2002:a05:6512:3d0d:b0:5b1:56c7:5753 with SMTP id
 2adb3069b0e04-5b2b2f6d2e4mr1528163e87.47.1784893019632; Fri, 24 Jul 2026
 04:36:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260723131908.3313223-1-david.marchand@redhat.com>
 <20260723131908.3313223-2-david.marchand@redhat.com>
 <amIYn1U_a0WmjMSs@bricha3-mobl1.ger.corp.intel.com>
 <CAJFAV8wqcNPWffRmFLcUNcSL4KD3T0v5v-kjLX886BqFiV4XWQ@mail.gmail.com>
 <1ece3c764a64471ab966dd324bc19d76@huawei.com>
 <amIngBPWflvFJeY6@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <amIngBPWflvFJeY6@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 24 Jul 2026 13:36:47 +0200
X-Gm-Features: AUfX_my31XPkY-CUXB5euO0qe4G8Ary8uiq22TJIkI9y85VygvePosl5SoxTAhY
Message-ID: <CAJFAV8x5U0rXXV6WdUWpaNtM-zNfEAvuOyWC8OLnGy=0+MKeUQ@mail.gmail.com>
Subject: Re: [RFC 1/4] bus/pci: fix check on interrupt FD for FreeBSD
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: Marat Khalili <marat.khalili@huawei.com>, "dev@dpdk.org" <dev@dpdk.org>, 
 "hkalra@marvell.com" <hkalra@marvell.com>, Chenbo Xia <chenbox@nvidia.com>,
 Nipun Gupta <nipun.gupta@amd.com>, Tetsuya Mukawa <mtetsuyah@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YyyiBbMq1oG96OmtIscVw9E9ze-Ws6p76HQk0SZhHLk_1784893020
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

On Thu, 23 Jul 2026 at 16:39, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> On Thu, Jul 23, 2026 at 02:31:23PM +0000, Marat Khalili wrote:
> > > > > --- a/drivers/bus/pci/bsd/pci.c
> > > > > +++ b/drivers/bus/pci/bsd/pci.c
> > > > > @@ -93,7 +93,7 @@ pci_uio_free_resource(struct rte_pci_device *dev,
> > > > >  {
> > > > >       rte_free(uio_res);
> > > > >
> > > > > -     if (rte_intr_fd_get(dev->intr_handle)) {
> > > > > +     if (rte_intr_fd_get(dev->intr_handle) >= 0) {
> > > > >               close(rte_intr_fd_get(dev->intr_handle));
> > > > >               rte_intr_fd_set(dev->intr_handle, -1);
> > > > >               rte_intr_type_set(dev->intr_handle, RTE_INTR_HANDLE_UNKNOWN);
> > > >
> > > > Unlikely that we actually have fd as 0 for this call, but change is
> > > > technically correct.
> > >
> > > Yes, this is why I did not Cc: stable.
> > > Thanks.
> >
> > Just trying to understand what's going on here out of curiosity.
> >
> > Zero fd is valid and negative (typically -1) indicating error is a standard
> > logic in Linux, but here intr_handle->fd is zero-filled by
> > rte_intr_instance_alloc, so its initial state is 0 instead of -1. Do we have
> > reasons to believe that something always sets fd to non-zero value before
> > pci_uio_free_resource is called? Should rte_intr_instance_alloc set it to -1?
>
> I believe that's what patch 3 of this set does, initializing each to -1.
> Perhaps that patch should appear before this one in the set, to avoid the
> possibility of temporary breakage.

True, in this case, it does not make sense to have this change separate.


-- 
David Marchand

