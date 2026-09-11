Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C652EC88E50
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Sep 2026 14:14:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2C16142D91;
	Fri, 11 Sep 2026 16:14:34 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id EF8A942D2E
 for <dev@dpdk.org>; Fri, 11 Sep 2026 16:14:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789136072;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wQpKbO8Tj4Be9oWfrpDzEbfib3XXCCwgG3Ob7Fm4a5E=;
 b=gHh1w1xsqWaohmdGmRxOPRfLPZ5TknuB7t4JwZujp0Ld1rW6+R/xiOvwLBJemCSh78/CBw
 kcLl1WtiMNzVYdtbEK7n+6bFQByHqGUQU//BwNAmVuILnCKOtiaTQgkwDBvQj6XPe9s2Q7
 l5nKqc/HxcK501ZmXA1BKcaT/e5860E=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-PIoH0ODDNlWxVmdLl8axeQ-1; Fri, 11 Sep 2026 10:14:30 -0400
X-MC-Unique: PIoH0ODDNlWxVmdLl8axeQ-1
X-Mimecast-MFC-AGG-ID: PIoH0ODDNlWxVmdLl8axeQ_1789136069
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-3a33567d27dso4542511fa.2
 for <dev@dpdk.org>; Fri, 11 Sep 2026 07:14:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789136069; x=1789740869;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=wQpKbO8Tj4Be9oWfrpDzEbfib3XXCCwgG3Ob7Fm4a5E=;
 b=VWMQWL6C7HcY8JpIZpZXjKnH56XaA+SndB94bT0rWzg/8ywTbnPGxEOZprciJljWdg
 Iqn4XCIMO2MzDpcbANmfjYDhM8Mu0SziKUeOdzJJobrvlIGTs6/jyluysbhq/GmUNTym
 8Ix3JlDbHMKfxsD7cIqbhidCKTTIx2Cx8pEYax26IMH/qGqQzbs3rn5GJBJxBep4IRD9
 aDp/BWfW5JHZ2JE1lhGk+l3UJeuf4gigstqo0bF+5pdh05h0nOU9kfyetOEutSP6DjUi
 zhVnc7xgMPaByBUyFBUnhz5JLOmtYrp0bis9ykLfVzFXRyPfj5dR/dtzFTWhCeq3Gv0Q
 Cuug==
X-Gm-Message-State: AFuF++mxn2lR8H76Vk/kHaAaE22+vO+xxDED3Fawdmn0s3w05SHlkrTv
 lMy5rSiWGAaKy9jm2XKbmtO0OcDRPKKY6qO5w8Y8ptIMLNwvXp3SiD1zbBemcLiLQPzKmv+saop
 3HSwaWlEdxgAK9qD3AMfxcoGSAEcbezZwwoFYkDHL1LuAjKpdfxQ2Wsu+74Rwm3W5vgEPKVga3S
 R7NKCEJ3t9bOY+BnAzLWA=
X-Gm-Gg: AYBFou1UYKv7ao4C8EGYQgrVgUgXH9Xm/1xEwwFKvlEJRoqxfsBPhuNz50ynnGbgPyu
 b4bBoOWix8XDFy/eGOASEFRciPs2iccGzARqLSKON6B7wIJ3LP9+0JFKSy9ktP3dErDahl8uFNT
 SfZqYnYQnF+PLy9aoy/IGuu9sur5Z1NajL0dVkjCdQmX3CauM0Zk0daX9jIg0Nve53gNq0C38FT
 fIC/OLzXjWQWOoFzOcrSDt2oZ8LBMw3e4tiiOXxga6Nmbxi
X-Received: by 2002:a05:651c:50d:b0:3a2:74a:6fcf with SMTP id
 38308e7fff4ca-3a5a4fe6753mr5422711fa.4.1789136069301; 
 Fri, 11 Sep 2026 07:14:29 -0700 (PDT)
X-Received: by 2002:a05:651c:50d:b0:3a2:74a:6fcf with SMTP id
 38308e7fff4ca-3a5a4fe6753mr5422611fa.4.1789136068754; Fri, 11 Sep 2026
 07:14:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260403091836.1073484-1-david.marchand@redhat.com>
 <20260904122804.2256481-1-david.marchand@redhat.com>
 <20260904122804.2256481-2-david.marchand@redhat.com>
 <IA4PR11MB927840F83DA2372511FE1CFF8EB02@IA4PR11MB9278.namprd11.prod.outlook.com>
In-Reply-To: <IA4PR11MB927840F83DA2372511FE1CFF8EB02@IA4PR11MB9278.namprd11.prod.outlook.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 11 Sep 2026 16:14:16 +0200
X-Gm-Features: AcwNN1WTmG8zDQLVk14ughV2V8805MzTjllOqn849uzcJJTiKzQvBU6aEOAlw3E
Message-ID: <CAJFAV8wutDRxg8jf01VPC1Bgr=2vUYXjQ_Yzo5GnLbUWD-XGjA@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] net/iavf: fix duplicate MAC addresses install
To: "Loftus, Ciara" <ciara.loftus@intel.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, "Richardson,
 Bruce" <bruce.richardson@intel.com>, 
 "stable@dpdk.org" <stable@dpdk.org>, "Medvedkin,
 Vladimir" <vladimir.medvedkin@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PW8ps-IBIqyXOQZqqPSbJ1uBejSAZY73TwM9qBW3D_c_1789136069
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

Hello,

On Wed, 9 Sept 2026 at 11:41, Loftus, Ciara <ciara.loftus@intel.com> wrote:
>
> > Subject: [PATCH v6 2/2] net/iavf: fix duplicate MAC addresses install
> >
> > On port restart, all MAC addresses get pushed *twice* to the hardware,
> > once by the driver and once by the eth_dev_mac_restore() in ethdev.
> >
> > On the other hand, MAC address filters are reset in the hardware
> > by the PF only when a VF reset is triggered.
> >
> > Strictly speaking, the mac restore on port (re)start is unneeded,
> > if no VF reset happened, so we can announce to ethdev that no mac
> > restoration is needed via a get_restore_flags callback.
> >
> > Then, move the mac restoration to the VF reset handler.
> >
> > Fixes: 3d42086def30 ("net/iavf: preserve MAC address with i40e PF Linux
> > driver")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: David Marchand <david.marchand@redhat.com>
> > ---
> > Changes since v4:
> > - rebased on next-net-intel,
> >
> > Changes since v4:
> > - moved mac restoration in iavf_post_reset_reconfig,
> >
> > ---
> >  drivers/net/intel/iavf/iavf_ethdev.c | 27 ++++++++++++++++-----------
> >  1 file changed, 16 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/net/intel/iavf/iavf_ethdev.c
> > b/drivers/net/intel/iavf/iavf_ethdev.c
> > index bbd1f08ff0..bec7b3b6d7 100644
> > --- a/drivers/net/intel/iavf/iavf_ethdev.c
> > +++ b/drivers/net/intel/iavf/iavf_ethdev.c
> > @@ -292,11 +292,12 @@ iavf_get_restore_flags(__rte_unused struct
> > rte_eth_dev *dev,
> >                      __rte_unused enum rte_eth_dev_operation op)
> >  {
> >       /*
> > -      * The unicast and multicast promiscuous settings persist across a
> > +      * The mac addresses, unicast and multicast promiscuous settings
> > persist across a
> >        * stop/start; they are only cleared by a VF reset, which the driver
> >        * restores itself. So ethdev does not need to restore them on start.
> >        */
> > -     return RTE_ETH_RESTORE_ALL & ~(RTE_ETH_RESTORE_PROMISC |
> > +     return RTE_ETH_RESTORE_ALL & ~(RTE_ETH_RESTORE_MAC_ADDR |
> > +                                    RTE_ETH_RESTORE_PROMISC |
> >                                      RTE_ETH_RESTORE_ALLMULTI);
> >  }
> >
> > @@ -1095,15 +1096,14 @@ iavf_dev_start(struct rte_eth_dev *dev)
> >               rte_intr_enable(intr_handle);
> >       }
> >
> > -     /* Set all mac addrs */
> > -     iavf_add_del_all_mac_addr(adapter, true);
> > -
> > -     if (!adapter->mac_primary_set)
> > -             adapter->mac_primary_set = true;
> > -
> > -     /* Set all multicast addresses */
> > -     iavf_add_del_mc_addr_list(adapter, vf->mc_addrs, vf-
> > >mc_addrs_num,
> > -                               true);
> > +     if (!adapter->mac_primary_set) {
> > +             if (iavf_add_del_eth_addr(adapter, &dev->data-
> > >mac_addrs[0], true,
> > +                             VIRTCHNL_ETHER_ADDR_PRIMARY) != 0)
> > +                     PMD_DRV_LOG(ERR, "failed to add primary MAC:"
> > RTE_ETHER_ADDR_PRT_FMT,
> > +                             RTE_ETHER_ADDR_BYTES(&dev->data-
> > >mac_addrs[0]));
> > +             else
> > +                     adapter->mac_primary_set = true;
> > +     }
> >
> >       rte_spinlock_init(&vf->phc_time_aq_lock);
> >
> > @@ -3434,6 +3434,11 @@ iavf_post_reset_reconfig(struct rte_eth_dev
> > *dev)
> >       int ret = 0;
> >       bool allmulti = false, allunicast = false;
> >       struct iavf_adapter *adapter = IAVF_DEV_PRIVATE_TO_ADAPTER(dev-
> > >data->dev_private);
> > +     struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(dev->data-
> > >dev_private);
> > +
> > +     /* After a VF reset, all MAC addresses got flushed, restore them. */
> > +     iavf_add_del_all_mac_addr(adapter, true);
>
> Could this lead to a double install of the primary on the reset path? In
> iavf_handle_hw_reset, dev_start can run before
> iavf_post_reset_reconfig and can install the primary MAC and set
> mac_primary_set. iavf_post_reset_reconfig then calls
> iavf_add_del_all_mac_addr which can install the primary again as it
> doesn't check mac_primary_set.

Indeed good catch, I'll fix it in next revision.


-- 
David Marchand

