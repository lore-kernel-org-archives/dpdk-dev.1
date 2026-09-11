Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA8ECC88E45
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Sep 2026 15:37:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3FCAC42D9F;
	Fri, 11 Sep 2026 17:37:21 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 325ED42D9F
 for <dev@dpdk.org>; Fri, 11 Sep 2026 17:37:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789141038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TTSMsa4qikgeShkCOIiDkHJ3rGwNjZVtsGYlYMgMmhY=;
 b=ANWvt+WEIrPker1BgnrXj2HMTwKTPBr77RDOcJIZBu/prXdZDEHP7rRL0AXtStrxn/t825
 2qa/brZCRAStbH2anvbyOij1SdSinRyAhFKmSc1dn159BCIgC4IbzGwJ4WphtTiPviRRbb
 v26JzePdXG96jk46+oFmA58gO+pHLOQ=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-1vIewNs8MDukbIiwve2auw-1; Fri, 11 Sep 2026 11:37:15 -0400
X-MC-Unique: 1vIewNs8MDukbIiwve2auw-1
X-Mimecast-MFC-AGG-ID: 1vIewNs8MDukbIiwve2auw_1789141034
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5b617595b4fso951658e87.0
 for <dev@dpdk.org>; Fri, 11 Sep 2026 08:37:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789141034; x=1789745834;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=TTSMsa4qikgeShkCOIiDkHJ3rGwNjZVtsGYlYMgMmhY=;
 b=E/IoxObtT6NZ4K7KMa2VZU39GBIMjNl2VaPRM8a5bgSwzqTUny1KSNVv7YNxUK/Vud
 czTeV7k0GYlsktW0763gxOzbp6A2gsUErcRoxfTQug7aaEGv2des6cj5BA49Ao/a/ed9
 7w/wNC/BHSo5DQ73a/9pAmUAywOZwuKdm03CCEgmbIepCOY/DA4LiUWgMAUm2MUR0reE
 L/8GnGw+Xr4X86NmPf7fm/7N0QMaCO1tnELCW6IQk+MCxmXJHotCU8ZT5Y6TbQlioz2r
 ygUuEg1tmANC8+boUhJV5Ug+XlMsEwyN3jUQGmwRiEL0lMAJPl6ipVG/2GiWJ6ofcJrm
 CIDA==
X-Gm-Message-State: AFuF++l5Hfc6SMk39pUjrMGFsBgjnT0q5iI6k6K4ewcsh4zHzG0ieyzo
 IhdDb0Tn6OW3x/EZ2mShKErPERtheolepR4nuVKBUTFMqIqJ+UF2s5qV3OtrFlIOWQyBLH2XcAs
 NtqThqp53jjFf3iRcHHnZY+cUE7BZFy3GToINTTFssUjEerAcTXhGRsrkKbBw8q0ETy1wlu21vr
 ZU5ZPMjIDHE2j+gK4CYXI=
X-Gm-Gg: AYBFou1ui4SnmyNs2Jf55HYGQE2r+0Yq3NI73dGTDNUSy8sXmmm6kMzxpOGnAjRjSv7
 lHtSx7zU7Rpv00WC6qYFZ4rMiXJmX3finaXfaXgbfohkx5seUdQBNK5WbFfnY1+tny/pI+WkBSZ
 xmgyoFBUznt6lTKzDnmIERabX9b02Gvs7jaQRBIwW7HiuwbCn5lBzjks21O8aH1zPTl3DmcKd6f
 I8XSC02kHjsegp/SIZJEjtyjvJj2r+oyk9sXEuPW960zhKg
X-Received: by 2002:a05:6512:3f0e:b0:5b6:1836:8082 with SMTP id
 2adb3069b0e04-5b8a03290b5mr2072102e87.28.1789141033787; 
 Fri, 11 Sep 2026 08:37:13 -0700 (PDT)
X-Received: by 2002:a05:6512:3f0e:b0:5b6:1836:8082 with SMTP id
 2adb3069b0e04-5b8a03290b5mr2072091e87.28.1789141033326; Fri, 11 Sep 2026
 08:37:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260403091836.1073484-1-david.marchand@redhat.com>
 <20260904122804.2256481-1-david.marchand@redhat.com>
 <20260904122804.2256481-2-david.marchand@redhat.com>
 <IA4PR11MB927840F83DA2372511FE1CFF8EB02@IA4PR11MB9278.namprd11.prod.outlook.com>
 <CAJFAV8wutDRxg8jf01VPC1Bgr=2vUYXjQ_Yzo5GnLbUWD-XGjA@mail.gmail.com>
In-Reply-To: <CAJFAV8wutDRxg8jf01VPC1Bgr=2vUYXjQ_Yzo5GnLbUWD-XGjA@mail.gmail.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 11 Sep 2026 17:37:00 +0200
X-Gm-Features: AcwNN1VeHShdrMjwebwrGSS0JGTDz4binsqWBW7hrGSro8LUNuxfjTcuMm67VaU
Message-ID: <CAJFAV8y7GrUQqk8aq=oS6GD50F85U19fBrbh4nCFOstCtbGBjA@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] net/iavf: fix duplicate MAC addresses install
To: "Loftus, Ciara" <ciara.loftus@intel.com>, 
 "Richardson, Bruce" <bruce.richardson@intel.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>, 
 "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>, 
 "Burakov, Anatoly" <anatoly.burakov@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xjwT18nkCEJ2osqISWD94slaYMglKea6LJWp9PQooys_1789141034
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

On Fri, 11 Sept 2026 at 16:14, David Marchand <david.marchand@redhat.com> wrote:
>
> Hello,
>
> On Wed, 9 Sept 2026 at 11:41, Loftus, Ciara <ciara.loftus@intel.com> wrote:
> >
> > > Subject: [PATCH v6 2/2] net/iavf: fix duplicate MAC addresses install
> > >
> > > On port restart, all MAC addresses get pushed *twice* to the hardware,
> > > once by the driver and once by the eth_dev_mac_restore() in ethdev.
> > >
> > > On the other hand, MAC address filters are reset in the hardware
> > > by the PF only when a VF reset is triggered.
> > >
> > > Strictly speaking, the mac restore on port (re)start is unneeded,
> > > if no VF reset happened, so we can announce to ethdev that no mac
> > > restoration is needed via a get_restore_flags callback.
> > >
> > > Then, move the mac restoration to the VF reset handler.
> > >
> > > Fixes: 3d42086def30 ("net/iavf: preserve MAC address with i40e PF Linux
> > > driver")
> > > Cc: stable@dpdk.org
> > >
> > > Signed-off-by: David Marchand <david.marchand@redhat.com>
> > > ---
> > > Changes since v4:
> > > - rebased on next-net-intel,
> > >
> > > Changes since v4:
> > > - moved mac restoration in iavf_post_reset_reconfig,
> > >
> > > ---
> > >  drivers/net/intel/iavf/iavf_ethdev.c | 27 ++++++++++++++++-----------
> > >  1 file changed, 16 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/drivers/net/intel/iavf/iavf_ethdev.c
> > > b/drivers/net/intel/iavf/iavf_ethdev.c
> > > index bbd1f08ff0..bec7b3b6d7 100644
> > > --- a/drivers/net/intel/iavf/iavf_ethdev.c
> > > +++ b/drivers/net/intel/iavf/iavf_ethdev.c
> > > @@ -292,11 +292,12 @@ iavf_get_restore_flags(__rte_unused struct
> > > rte_eth_dev *dev,
> > >                      __rte_unused enum rte_eth_dev_operation op)
> > >  {
> > >       /*
> > > -      * The unicast and multicast promiscuous settings persist across a
> > > +      * The mac addresses, unicast and multicast promiscuous settings
> > > persist across a
> > >        * stop/start; they are only cleared by a VF reset, which the driver
> > >        * restores itself. So ethdev does not need to restore them on start.
> > >        */
> > > -     return RTE_ETH_RESTORE_ALL & ~(RTE_ETH_RESTORE_PROMISC |
> > > +     return RTE_ETH_RESTORE_ALL & ~(RTE_ETH_RESTORE_MAC_ADDR |
> > > +                                    RTE_ETH_RESTORE_PROMISC |
> > >                                      RTE_ETH_RESTORE_ALLMULTI);
> > >  }
> > >
> > > @@ -1095,15 +1096,14 @@ iavf_dev_start(struct rte_eth_dev *dev)
> > >               rte_intr_enable(intr_handle);
> > >       }
> > >
> > > -     /* Set all mac addrs */
> > > -     iavf_add_del_all_mac_addr(adapter, true);
> > > -
> > > -     if (!adapter->mac_primary_set)
> > > -             adapter->mac_primary_set = true;
> > > -
> > > -     /* Set all multicast addresses */
> > > -     iavf_add_del_mc_addr_list(adapter, vf->mc_addrs, vf-
> > > >mc_addrs_num,
> > > -                               true);
> > > +     if (!adapter->mac_primary_set) {
> > > +             if (iavf_add_del_eth_addr(adapter, &dev->data-
> > > >mac_addrs[0], true,
> > > +                             VIRTCHNL_ETHER_ADDR_PRIMARY) != 0)
> > > +                     PMD_DRV_LOG(ERR, "failed to add primary MAC:"
> > > RTE_ETHER_ADDR_PRT_FMT,
> > > +                             RTE_ETHER_ADDR_BYTES(&dev->data-
> > > >mac_addrs[0]));
> > > +             else
> > > +                     adapter->mac_primary_set = true;
> > > +     }
> > >
> > >       rte_spinlock_init(&vf->phc_time_aq_lock);
> > >
> > > @@ -3434,6 +3434,11 @@ iavf_post_reset_reconfig(struct rte_eth_dev
> > > *dev)
> > >       int ret = 0;
> > >       bool allmulti = false, allunicast = false;
> > >       struct iavf_adapter *adapter = IAVF_DEV_PRIVATE_TO_ADAPTER(dev-
> > > >data->dev_private);
> > > +     struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(dev->data-
> > > >dev_private);
> > > +
> > > +     /* After a VF reset, all MAC addresses got flushed, restore them. */
> > > +     iavf_add_del_all_mac_addr(adapter, true);
> >
> > Could this lead to a double install of the primary on the reset path? In
> > iavf_handle_hw_reset, dev_start can run before
> > iavf_post_reset_reconfig and can install the primary MAC and set
> > mac_primary_set. iavf_post_reset_reconfig then calls
> > iavf_add_del_all_mac_addr which can install the primary again as it
> > doesn't check mac_primary_set.
>
> Indeed good catch, I'll fix it in next revision.

Interesting..

It's been so long I started touching this code, I am not sure at what
I tested now...

It seems I found a leak of the mac address array on VF reset.
iavf_dev_uninit + iavf_dev_init results in overwriting
dev->data->mac_addrs right?

This should break the mac restoration during a VF reset, regardless of
who does it, the driver or ethdev.

The multicast addresses look unaffected, as those are stored in the
iavf_info struct.

I could copy the mac address and reinsert the mac addresses during
iavf_post_reset_reconfig...
But I think it is simpler to just check eth->data->mac_addrs state in
iavf_dev_init.

Opinions?


-- 
David Marchand

