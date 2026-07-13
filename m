Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42400C43458
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Jul 2026 14:10:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 16E214068E;
	Mon, 13 Jul 2026 16:10:58 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id B626340041
 for <dev@dpdk.org>; Mon, 13 Jul 2026 16:10:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783951856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GwNGh1oJSSkH+sEUj0Kh5rldm/ZgPAln/FqmVU8yKj4=;
 b=esY+bMrI6j5WRJQiri35WqBy9C1CL/mOhuczvQvw0ZDYhvl3uRwmP9vXxQGUueE4WJ88uW
 MkNG6oNH4yE6mqOxj7qK9GoefwFJZ9xx7Wcfz2XfZJYj9YZHlJB4d/Fm4k/ygeB/Mpo9ab
 0ZrRvXHI2I1Ts+oJJagnmHqYfyO9BM8=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-_yndBD5IMoKouzc3_H61fQ-1; Mon, 13 Jul 2026 10:10:52 -0400
X-MC-Unique: _yndBD5IMoKouzc3_H61fQ-1
X-Mimecast-MFC-AGG-ID: _yndBD5IMoKouzc3_H61fQ_1783951851
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-39b25964a9aso16616741fa.0
 for <dev@dpdk.org>; Mon, 13 Jul 2026 07:10:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783951851; x=1784556651;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=GwNGh1oJSSkH+sEUj0Kh5rldm/ZgPAln/FqmVU8yKj4=;
 b=d0bs7vc/c2PTvouRYE3kO5XK74yWmmAbcVcyEFm8tuPXJWsQmE865/3p3VpStOQIu8
 VB/zY6JHJYPYfhorqBujJQGueAz1cR3nIKmbTUEGBo7Oq37pQ569SjNz0m6MIEl5zwqA
 zQ6O7ws+wJoGGYiZO9wPd6UlS3CovqfTgXNRQ5e/LZje4ImaBQa3epQepHRIIZUODrRB
 DJImb9nxp1DZ3ywovaCGdFxbJ7ORkhegNISElmdcVWzhnF5dzPgOxKz4Jf3ev3Pw+utX
 j9a+KV/KUz9E4f4W4SR/9EgwtgTa7ZaqKtvUEDtGftHieeiN+sGhRbQLfVCkirI3jfGR
 Pq4A==
X-Gm-Message-State: AOJu0YxZsf+hibA/HhPzfeq37/D/swu1BabkJC7O4t4j95lSjKqOuCxz
 GFgIFdiRXSsA8xyw3cyZU72jo+boTactZdnxaG6G5Ozo2mDqyA405fOTRHNO+mG7uyGAUqV+j/P
 NwrzO9dxkLU53DjjD8LJgZrlpyLqAdxPlE0pfs5TpF1d9+bsQBs2qtD94frrQoNbfRYF+w2Q+fG
 JzcWK0wlY2yZ9nEC7x8kQ=
X-Gm-Gg: AfdE7clkCWwhGdDAWld2i9BUisxxJt1yBsQEKbrttZb/dasDASWAI6EUTgqhgof69a8
 ipM7s+cfEtAlPbryCMe1UOYvpFzro+3ss7yL/yjcbg+qEKQlVbyJIy+z98LcO+vxgiBFqFGtMrK
 AhBiV7zj/VMJWYInamCLrew4Nqm3sMuUu8ahpZOQTC+/dBBzl+nxQ+/mR6bbRpcc8LpMNq6UQFW
 JJcHqZJ9QOrZAnSGGrOdLs50EmkeJ3JUjEZoOPz3Zjbb8EOit8AbKl2ocA=
X-Received: by 2002:a2e:ad92:0:b0:39c:a06f:12ba with SMTP id
 38308e7fff4ca-39caa8b50dbmr20228141fa.40.1783951851023; 
 Mon, 13 Jul 2026 07:10:51 -0700 (PDT)
X-Received: by 2002:a2e:ad92:0:b0:39c:a06f:12ba with SMTP id
 38308e7fff4ca-39caa8b50dbmr20228041fa.40.1783951850503; Mon, 13 Jul 2026
 07:10:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260403091836.1073484-1-david.marchand@redhat.com>
 <20260709160247.1798575-1-david.marchand@redhat.com>
 <20260709160247.1798575-6-david.marchand@redhat.com>
 <IA4PR11MB92781CFE503B95525EC366AF8EFA2@IA4PR11MB9278.namprd11.prod.outlook.com>
In-Reply-To: <IA4PR11MB92781CFE503B95525EC366AF8EFA2@IA4PR11MB9278.namprd11.prod.outlook.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 13 Jul 2026 16:10:38 +0200
X-Gm-Features: AVVi8Cf7CL23vio4BmKkBjHrg04k83MUxLNfZhs3lLnd7Zbd8x2h0wxUq91Cjco
Message-ID: <CAJFAV8xbkajqm+BPF+-+24NvT7XG4Rv=tB7ci4M6BSg+0roD8w@mail.gmail.com>
Subject: Re: [PATCH v4 05/10] net/iavf: fix duplicate MAC addresses install
To: "Loftus, Ciara" <ciara.loftus@intel.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, "rjarry@redhat.com" <rjarry@redhat.com>, 
 "cfontain@redhat.com" <cfontain@redhat.com>,
 "stable@dpdk.org" <stable@dpdk.org>, 
 "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>, 
 "Richardson, Bruce" <bruce.richardson@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GEYiq2HFMedN3ldqM2UAAu8mJZE8AjHbQluRXoQ_khk_1783951851
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

On Mon, 13 Jul 2026 at 15:14, Loftus, Ciara <ciara.loftus@intel.com> wrote:
>
> > Subject: [PATCH v4 05/10] net/iavf: fix duplicate MAC addresses install
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
> >  drivers/net/intel/iavf/iavf_ethdev.c | 31 ++++++++++++++++++++--------
> >  1 file changed, 22 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/net/intel/iavf/iavf_ethdev.c
> > b/drivers/net/intel/iavf/iavf_ethdev.c
> > index 179d90ec55..fe54df4b9f 100644
> > --- a/drivers/net/intel/iavf/iavf_ethdev.c
> > +++ b/drivers/net/intel/iavf/iavf_ethdev.c
> > @@ -134,6 +134,8 @@ static int iavf_dev_vlan_filter_set(struct rte_eth_dev
> > *dev,
> >  static int iavf_vlan_tpid_set(struct rte_eth_dev *dev,
> >                            enum rte_vlan_type vlan_type, uint16_t tpid);
> >  static int iavf_dev_vlan_offload_set(struct rte_eth_dev *dev, int mask);
> > +static uint64_t iavf_get_restore_flags(struct rte_eth_dev *dev,
> > +                                    enum rte_eth_dev_operation op);
> >  static int iavf_dev_rss_reta_update(struct rte_eth_dev *dev,
> >                                  struct rte_eth_rss_reta_entry64 *reta_conf,
> >                                  uint16_t reta_size);
> > @@ -264,6 +266,7 @@ static const struct eth_dev_ops iavf_eth_dev_ops = {
> >       .tx_done_cleanup            = iavf_dev_tx_done_cleanup,
> >       .get_monitor_addr           = iavf_get_monitor_addr,
> >       .tm_ops_get                 = iavf_tm_ops_get,
> > +     .get_restore_flags          = iavf_get_restore_flags,
> >  };
> >
> >  static int
> > @@ -284,6 +287,13 @@ iavf_tm_ops_get(struct rte_eth_dev *dev,
> >       return 0;
> >  }
> >
> > +static uint64_t
> > +iavf_get_restore_flags(__rte_unused struct rte_eth_dev *dev,
> > +                    __rte_unused enum rte_eth_dev_operation op)
> > +{
> > +     return RTE_ETH_RESTORE_ALL & ~RTE_ETH_RESTORE_MAC_ADDR;
> > +}
> > +
> >  __rte_unused
> >  static int
> >  iavf_vfr_inprogress(struct iavf_hw *hw)
> > @@ -1074,15 +1084,14 @@ iavf_dev_start(struct rte_eth_dev *dev)
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
> > @@ -3424,6 +3433,10 @@ iavf_handle_hw_reset(struct rte_eth_dev *dev,
> > bool vf_initiated_reset)
> >               if (ret)
> >                       goto error;
> >
> > +             /* after a VF reset, all mac addresses got flushed, restore them
> > */
> > +             iavf_add_del_all_mac_addr(adapter, true);
> > +             iavf_add_del_mc_addr_list(adapter, vf->mc_addrs, vf-
> > >mc_addrs_num, true);
> > +
>
> This restore block only runs if the device was started when the handler was
> entered. It might make more sense to move it into iavf_post_reset_reconfig
> which will run for VF-initiated resets regardless of started state, and for
> PF-initiated will run if the device was started on entry.
> For PF-initiated if the device was not started we return from
> iavf_handle_hw_reset() immediately, so there's no opportunity to restore
> the MAC addresses at all. It needs to be considered how to restore the macs
> in that case.
> Need to consider as well how the restore_flags and auto_reconfig features
> work with one another. If the auto_reconfig devarg is set to zero it means
> the user doesn't want any restoration of settings upon reset.

I was not aware of this knob.
It seems crazy to me to have such specific flag to disable something
that I take foregranted during the life of a DPDK port.
I really hope no application relies on the mac addresses list being
flushed during a VF reset...

While moving the code to iavf_post_reset_reconfig kind of makes sense
to me, I honesly don't know what to do wrt restore_flags.
It seems orthogonal to me.
If ethdev decides to restore the mac addresses, I don't see why some
devargs would have something to say about it.


-- 
David Marchand

