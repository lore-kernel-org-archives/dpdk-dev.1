Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5984AF3D331
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Mar 2026 16:55:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B597640A7F;
	Thu,  5 Mar 2026 17:55:56 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 766394029D
 for <dev@dpdk.org>; Thu,  5 Mar 2026 17:55:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772729755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DRqFOPasYzui6le6qj09Hs90ivYR8CZcBKw9o/fk/5Y=;
 b=JUl0hfjGZHKh63I27XvVpg69V4uU98PhfdjXWOtKx6QsbI4zsOxZO6NfasCeAotXYjp0CG
 WfKkHhkka/e77l1a/yR7yCpzIlc5uqBAyI7/NYngfxVzka+iAnuBUH+r91pqXBmV8iDP/W
 9jf7nX5iVFNjay4+C1KzgIiC8y6s65U=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-7jXUSPDIM72j3egXyKMWxw-1; Thu, 05 Mar 2026 11:55:53 -0500
X-MC-Unique: 7jXUSPDIM72j3egXyKMWxw-1
X-Mimecast-MFC-AGG-ID: 7jXUSPDIM72j3egXyKMWxw_1772729752
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-38a32088ed1so13055241fa.1
 for <dev@dpdk.org>; Thu, 05 Mar 2026 08:55:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772729752; x=1773334552;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DRqFOPasYzui6le6qj09Hs90ivYR8CZcBKw9o/fk/5Y=;
 b=EwdpHkphtusC1yiMe+1jLfr6KXZT9BECgy6hR+eVTX5d9hkCDMKm5dYt7oWWiu6/77
 L21U+vbiuwYr1i7v0l4cWCz3SBIO/a1uwc1Snz3KQRvGmYDAfW5DNQPfwpLqV04k2hFG
 QEF3jXE8H55fyEABbYLDK4JOl6qXZba7EVQ+Zwpv8urT83aoRkLphGCkwbYM9fNNN+f0
 hv3jTCEokFsI8eLzJUZ+yoOLHcRKmbTMls1EoLc+rC6dlKvDBefux59DU/ums4c9PP7r
 R10/CnNe7uqyjlz7mfOp6/mZ+RUUKdsKZUdVGEyDyjUPydZfbAMoksi2xOG2v55XkcYe
 v/ww==
X-Gm-Message-State: AOJu0YyI1LsGCs9YEPlFXd4TmPiYEnWvOiSk+v/GzjV/7WbyzGIzq9x/
 uIw8cHE2sAEMOLyFl7fZIM9lq66HtZnaMtvEAulfZ/I1o9RzWLVxDm9vww+nDrqULYedvNK6fM0
 LOrDkJGAXRjtXzh9npJm37P2WJclJ/KYuI+HxgkusV5JfwWAViKulfZmAPO5mI0J2WJw9k748KT
 3gNyXj0ONwSHsJAbMHsg0=
X-Gm-Gg: ATEYQzx2RGmuiR6J/nkHZ6xkaRaUouFlYGGdheyZsbNicCKU73xFbeF+q5N/ULHnLHo
 HeyYAX36nyMV7XxsViqGld7lUBvKfjFAO4FVGNrGwsskeFnbRA2C0MGoz5YbNQVIL1AYEvmI3A3
 g8S43ezzN4Di+KODGIUC5klaUmKyB/Ga9cGzJ0a2zRvWNHvmdv/AfzberEEdxyqIG7QOeEMrmJe
 YYCw7AvCjzdE7Q2EVkp0AI+gjYWcYOAAjYccWeUG5v101GX31hhPQk/eUPEmpLFlxiIhg==
X-Received: by 2002:a05:651c:1473:b0:386:78ba:efda with SMTP id
 38308e7fff4ca-38a352bc56fmr12451541fa.19.1772729752216; 
 Thu, 05 Mar 2026 08:55:52 -0800 (PST)
X-Received: by 2002:a05:651c:1473:b0:386:78ba:efda with SMTP id
 38308e7fff4ca-38a352bc56fmr12451391fa.19.1772729751718; Thu, 05 Mar 2026
 08:55:51 -0800 (PST)
MIME-Version: 1.0
References: <20260218160453.142311-1-maxime@leroys.fr>
 <20260226143341.282188-1-maxime@leroys.fr>
 <20260226112551.7ec09c50@phoenix.local>
In-Reply-To: <20260226112551.7ec09c50@phoenix.local>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 5 Mar 2026 17:55:39 +0100
X-Gm-Features: AaiRm517b-OaXIjvdqF4Hn2q43VYh7xyY5OnhQHgnwJI5GEJs-g96CDix9s8jIU
Message-ID: <CAJFAV8yFRfHOoBha12Vistp48reyhdgNxaxZpys66eC_MOz5Tw@mail.gmail.com>
Subject: Re: [PATCH v2 00/17] net/dpaa2: fixes and improvements
To: Maxime Leroy <maxime@leroys.fr>,
 Stephen Hemminger <stephen@networkplumber.org>, hemant.agrawal@nxp.com
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BnZ9sUHqJ-ammVfUBZdtNskpHouXHpUNoDHpm2SwDZc_1772729752
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

On Thu, 26 Feb 2026 at 20:26, Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Thu, 26 Feb 2026 15:33:24 +0100
> Maxime Leroy <maxime@leroys.fr> wrote:
>
> > Various fixes and improvements for the dpaa2 net driver and fslmc bus.
> >
> > Patches 1-6 fix resource leaks on port close, error paths, link status
> > and devargs propagation on hotplug.
> >
> > Patches 7-14 fix additional bugs: spurious VLAN insertion, error packet
> > dump crash, packet type classification, checksum offload flags, software
> > taildrop buffer access, burst mode info reporting, SG table walk bounds,
> > and MAC stats DMA allocation.
> >
> > Patch 15 is a minor cleanup in the link status area.
> >
> > Patches 16-17 add devargs alternatives for getenv-based configuration
> > of taildrop and data stashing options.
> >
> > Changes since v1:
> > - Add Cc: stable@dpdk.org on patches with Fixes: tags (Stephen)
> > - Reorder series: fixes first, then improvements (Stephen)
> > - Patch 2: squash with former patch 4 (Hemant)
> > - Patch 6: move devargs refresh from plug to scan rescan path (David)
> > - Patch 17: keep getenv for backward compatibility, add devargs as
> >   alternative instead of replacement
> > - Drop former patch 11 (bus/fslmc: remove dead blocklist check) to
> >   avoid disaligning with other buses (David)
> > - New patches 8, 11-14 fixing issues reported by Stephen
> > - New patches 7, 9-10 fixing VLAN insertion and packet classification
> >   issues
> >
> > Maxime Leroy (17):
> >   net/dpaa2: fix queue block memory leak on port close
> >   net/dpaa2: fix rx error queue memory leaks
> >   net/dpaa2: warn on rx descriptor limit only in high perf buffer mode
> >   net/dpaa2: fix resource leak on softparser failure
> >   net/dpaa2: fix link not up after port stop/start
> >   bus/fslmc: fix devargs not propagated on hotplug
> >   net/dpaa2: fix spurious VLAN insertion on non-VLAN packets
> >   net/dpaa2: fix error packet dump crash and memory leak
> >   net/dpaa2: fix L4 packet type classification in slow parse path
> >   net/dpaa2: fix L3/L4 checksum offload flags
> >   net/dpaa2: fix software taildrop buffer access
> >   net/dpaa2: fix burst mode info to report active burst function
> >   net/dpaa2: add SG table walk upper bound in Rx path
> >   net/dpaa2: fix MAC stats DMA buffer allocation per xstats call
> >   net/dpaa2: use CHECK_INTERVAL macro in set_link_down
> >   net/dpaa2: add devargs to disable Rx taildrop
> >   net/dpaa2: add devargs alternative for data stashing getenv
> >
> >  drivers/bus/fslmc/fslmc_bus.c           |   4 +
> >  drivers/bus/fslmc/portal/dpaa2_hw_pvt.h |  16 +-
> >  drivers/net/dpaa2/dpaa2_ethdev.c        | 211 ++++++++++++------------
> >  drivers/net/dpaa2/dpaa2_ethdev.h        |   3 +
> >  drivers/net/dpaa2/dpaa2_rxtx.c          |  85 +++++-----
> >  drivers/net/dpaa2/mc/fsl_dpni.h         |   6 +
> >  6 files changed, 164 insertions(+), 161 deletions(-)
> >
>
> Please fix the free bulk bug on Transmit and revise

As I replied in other thread, I see no bug on usage of free bulk (not
the raw helper).

> patches so that check-git-log.sh does not complain so much.

Maxime, this will need a new revision on those warnings.

Hemant, in the mean time, could NXP review/test on real hw?


Thanks.

-- 
David Marchand

