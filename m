Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A25CA0FE8
	for <dpdk-dev@archiver.kernel.org>; Sun, 31 Aug 2025 15:00:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5F3A040262;
	Sun, 31 Aug 2025 17:00:48 +0200 (CEST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com
 [209.85.218.45]) by mails.dpdk.org (Postfix) with ESMTP id 095324021E
 for <dev@dpdk.org>; Sun, 31 Aug 2025 17:00:47 +0200 (CEST)
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-b0411b83aafso121599166b.1
 for <dev@dpdk.org>; Sun, 31 Aug 2025 08:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756652446; x=1757257246; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5MBUwM+dwomxC+vdd7PcAdNLFsv4GtifJOhg3avcmNI=;
 b=YPFy64xZii9eqX8I5UBUgW9wlsdpkJ8LYkmwxXQslDWcUAK2WBkXubD3IyIq7JGmnb
 c9KIRFQuMMTuDDim+HYAxmeFVay18BFm7titxmz/2zzMT/CTWq1Sr60jUNQIuMb2eSNL
 iOQ7o4PlwrqLoAtXfNEeUZzmAQjoQa8Y74IR0Cuczp3YdGGAia256rANxUlFs3An7926
 GzyuBfKRPazZKqvrRxXf82KMNnxUjwKpjDE2PYhEsvL1pOUKWHP7gT/dM95JlqZHT3yf
 T48uxW55Fuac3wy2ki+7yK/IQ26rryxk74zBYXQo4UHhGKeXdWxPm0H7ICpoidZfaPun
 HHMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756652446; x=1757257246;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5MBUwM+dwomxC+vdd7PcAdNLFsv4GtifJOhg3avcmNI=;
 b=CgPQe4wGPfRp8q4JpOaF5DppVaZ5wIRjesTZiat1TWIQsCFVxxkPzfRg1AM8JTYZCr
 vtPYflnNbnz9fkxcGqznFRIdLbmLsJAAPDfWr/gFCS7QCMe5P7Pt3PDhvnHrOdWL2D9X
 5cJNL95/MrlysED1T72uCUcHSTRuzaw5BRbz03kYw2j7ZRSpnjUxeSw2UlLE8KRrtCPP
 J2RMZUq2K/H029bO0Ft9+wwRwF+wO1SvHEe+QcpMywW4eMAHzydbjhhRCVY6h+aJQmdA
 3NLJ9EPCdkFf2HrfFFuBgJj4PEU+KdffD7RGek4UGAW9i/vOC2an48BtTnug7PaCkJCY
 0gkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfKJrSwVzxzXmvhsxCw4glLysh0B6r1TsZ1IKgpTgjhPhomTeyy6aw4mwRGkXlq8bnMcg=@dpdk.org
X-Gm-Message-State: AOJu0YyM/W0XNjk3vX9pvJz4bf9MGWzQgrUHfCoZ58dF18ljvNlN5Ky4
 Ojc2skpsP1YuMaSD1b15RGMiqV1BAvsDPgqeD/BQeWkfBvJRwioC0o8JDly/UfQ91BNqJ/3Ugtn
 nwBHEOscr1OChuswJ/LfMBTmU3JOvmUs=
X-Gm-Gg: ASbGncsX9/JiJTEZ4ur88dJuFtoN+l8rcFUqRIa2D22eQFOzKqy4Q5V/FtE6oGBguSp
 ibYhjfZIMYRQSZVR8xRl8Eq8YOJtfZsRVGBLH/3X7g+WayxvlCuvZVcY0h6bMnbeJ8rQiPSKY/u
 EWafHpYduWxeae9MSUMc6C3lBU4lc3P8SfK8VDqyCVslk40BKkM5kQgM5YbNO/mHwOq2Kpr3aeQ
 eNm
X-Google-Smtp-Source: AGHT+IH8PXygKqyneMaUMtjupKHdlMeRybqemsuKK3ZwMISk7xIiIL6qNdy36erq5zyfdlX4y4wu2FaXjs7OJ/s3kS4=
X-Received: by 2002:a05:6402:5252:b0:61d:12df:75c7 with SMTP id
 4fb4d7f45d1cf-61d26ec99d9mr4617619a12.35.1756652446370; Sun, 31 Aug 2025
 08:00:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250830171706.428977-1-vladimir.medvedkin@intel.com>
 <20250830171706.428977-2-vladimir.medvedkin@intel.com>
 <5ace1139-ed01-dfe5-91ef-d96f1626b7f6@arknetworks.am>
In-Reply-To: <5ace1139-ed01-dfe5-91ef-d96f1626b7f6@arknetworks.am>
From: Vladimir Medvedkin <medvedkinv@gmail.com>
Date: Sun, 31 Aug 2025 16:00:34 +0100
X-Gm-Features: Ac12FXyzH0hGmt3T6aLo0FDXZerT0eE4WrhLbJjejennyy7ARDu8nEuPQXZYMD0
Message-ID: <CANDrEHkakfwt0iDDpfUBQYQV8-mYZ4b8StM7ovr=z2uw_sv-kg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/6] ethdev: extend and refactor DCB configuration
To: Ivan Malov <ivan.malov@arknetworks.am>
Cc: Vladimir Medvedkin <vladimir.medvedkin@intel.com>, dev@dpdk.org,
 bruce.richardson@intel.com, 
 anatoly.burakov@intel.com, thomas@monjalon.net, andrew.rybchenko@oktetlabs.ru, 
 stephen@networkplumber.org
Content-Type: multipart/alternative; boundary="0000000000000f5454063daa857b"
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

--0000000000000f5454063daa857b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D0=B1, 30 =D0=B0=D0=B2=D0=B3. 2025=E2=80=AF=D0=B3. =D0=B2 20:52, Iva=
n Malov <ivan.malov@arknetworks.am>:

> Hi Vladimir,
>
> On Sat, 30 Aug 2025, Vladimir Medvedkin wrote:
>
> > Currently there are two structutes defined for DCB configuration, one f=
or
>
> Typo: structuRes.
>
> > RX and one for TX. They do have slight semantic difference, but in term=
s
> > of their structure they are identical. Refactor DCB configuration API t=
o
> > use common structute for both TX and RX.
> >
> > Additionally, current structure do not reflect everything that is
> > required by the DCB specification, such as per Traffic Class bandwidth
> > allocation and Traffic Selection Algorithm (TSA). Extend rte_eth_dcb_co=
nf
> > with additional DCB settings
> >
> > Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
> > ---
> > app/test-pmd/testpmd.c             | 19 ++++++-
> > drivers/net/intel/ice/ice_ethdev.c | 80 ++++++++++++++++++++----------
> > lib/ethdev/rte_ethdev.h            | 25 ++++++----
> > 3 files changed, 85 insertions(+), 39 deletions(-)
> >
> > diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
> > index bb88555328..d64a7dcac5 100644
> > --- a/app/test-pmd/testpmd.c
> > +++ b/app/test-pmd/testpmd.c
> > @@ -4134,9 +4134,9 @@ get_eth_dcb_conf(struct rte_eth_conf *eth_conf,
> enum dcb_mode_enable dcb_mode,
> >                                       (rx_mq_mode &
> RTE_ETH_MQ_RX_VMDQ_DCB);
> >               eth_conf->txmode.mq_mode =3D RTE_ETH_MQ_TX_VMDQ_DCB;
> >       } else {
> > -             struct rte_eth_dcb_rx_conf *rx_conf =3D
> > +             struct rte_eth_dcb_conf *rx_conf =3D
> >                               &eth_conf->rx_adv_conf.dcb_rx_conf;
> > -             struct rte_eth_dcb_tx_conf *tx_conf =3D
> > +             struct rte_eth_dcb_conf *tx_conf =3D
> >                               &eth_conf->tx_adv_conf.dcb_tx_conf;
> >
> >               rx_conf->nb_tcs =3D num_tcs;
> > @@ -4148,6 +4148,21 @@ get_eth_dcb_conf(struct rte_eth_conf *eth_conf,
> enum dcb_mode_enable dcb_mode,
> >                       tx_conf->dcb_tc[i] =3D dcb_tc_val;
> >               }
> >
> > +             const int bw_share_percent =3D 100 / num_tcs;
> > +             const int bw_share_left =3D 100 - bw_share_percent * num_=
tcs;
> > +             for (i =3D 0; i < num_tcs; i++) {
> > +                     rx_conf->dcb_tc_bw[i] =3D bw_share_percent;
> > +                     tx_conf->dcb_tc_bw[i] =3D bw_share_percent;
> > +
> > +                     rx_conf->dcb_tsa[i] =3D RTE_ETH_DCB_TSA_ETS;
> > +                     tx_conf->dcb_tsa[i] =3D RTE_ETH_DCB_TSA_ETS;
> > +             }
> > +
> > +             for (i =3D 0; i < bw_share_left; i++) {
> > +                     rx_conf->dcb_tc_bw[i]++;
> > +                     tx_conf->dcb_tc_bw[i]++;
> > +             }
>
> A brief comment would make the purpose clearer.
>
> > +
> >               eth_conf->rxmode.mq_mode =3D
> >                               (enum rte_eth_rx_mq_mode)
> >                                       (rx_mq_mode &
> RTE_ETH_MQ_RX_DCB_RSS);
> > diff --git a/drivers/net/intel/ice/ice_ethdev.c
> b/drivers/net/intel/ice/ice_ethdev.c
> > index 8ab0da3549..7ba25049d7 100644
> > --- a/drivers/net/intel/ice/ice_ethdev.c
> > +++ b/drivers/net/intel/ice/ice_ethdev.c
> > @@ -3760,10 +3760,13 @@ static int ice_init_rss(struct ice_pf *pf)
> > }
> >
> > static int
> > -check_dcb_conf(int is_8_ports, struct rte_eth_dcb_rx_conf *dcb_conf)
> > +check_dcb_conf(int is_8_ports, struct rte_eth_dcb_conf *dcb_conf)
> > {
> >       uint32_t tc_map =3D 0;
> >       int i;
> > +     int total_bw_allocated =3D 0;
> > +     bool ets_seen =3D false;
> > +     int nb_tc_used;
> >
> >       enum rte_eth_nb_tcs nb_tcs =3D dcb_conf->nb_tcs;
> >       if (nb_tcs !=3D RTE_ETH_4_TCS && is_8_ports) {
> > @@ -3784,7 +3787,31 @@ check_dcb_conf(int is_8_ports, struct
> rte_eth_dcb_rx_conf *dcb_conf)
> >               return -1;
> >       }
> >
> > -     return rte_popcount32(tc_map);
> > +     nb_tc_used =3D rte_popcount32(tc_map);
> > +
> > +     /* calculate total ETS Bandwidth allocation */
> > +     for (i =3D 0; i < nb_tc_used; i++) {
> > +             if (dcb_conf->dcb_tsa[i] =3D=3D RTE_ETH_DCB_TSA_ETS) {
> > +                     if (dcb_conf->dcb_tc_bw[i] =3D=3D 0) {
> > +                             PMD_DRV_LOG(ERR,
> > +                                     "Bad ETS BW configuration, can no=
t
> allocate 0%%");
> > +                             return -1;
> > +                     }
> > +                     total_bw_allocated +=3D dcb_conf->dcb_tc_bw[i];
> > +                     ets_seen =3D true;
> > +             } else if (dcb_conf->dcb_tsa[i] !=3D RTE_ETH_DCB_TSA_STRI=
CT)
> {
> > +                     PMD_DRV_LOG(ERR, "Invalid TC TSA setting - only
> Strict and ETS are supported");
> > +                     return -1;
> > +             }
> > +     }
> > +
> > +     /* total ETS BW allocation must add up to 100% */
> > +     if (ets_seen && total_bw_allocated !=3D 100) {
> > +             PMD_DRV_LOG(ERR, "Invalid TC Bandwidth allocation
> configuration");
> > +             return -1;
> > +     }
> > +
> > +     return nb_tc_used;
> > }
> >
> > static int
> > @@ -3819,15 +3846,22 @@ ice_dev_configure(struct rte_eth_dev *dev)
> >               struct ice_qos_cfg *qos_cfg =3D &port_info->qos_cfg;
> >               struct ice_dcbx_cfg *local_dcb_conf =3D
> &qos_cfg->local_dcbx_cfg;
> >               struct ice_vsi_ctx ctxt;
> > -             struct rte_eth_dcb_rx_conf *dcb_conf =3D
> &dev->data->dev_conf.rx_adv_conf.dcb_rx_conf;
> > +             struct rte_eth_dcb_conf *rx_dcb_conf =3D
> > +                     &dev->data->dev_conf.rx_adv_conf.dcb_rx_conf;
> > +             struct rte_eth_dcb_conf *tx_dcb_conf =3D
> > +                     &dev->data->dev_conf.tx_adv_conf.dcb_tx_conf;
> >               int i;
> > -             enum rte_eth_nb_tcs nb_tcs =3D dcb_conf->nb_tcs;
> > -             int nb_tc_used, queues_per_tc;
> > +             enum rte_eth_nb_tcs nb_tcs =3D rx_dcb_conf->nb_tcs;
> > +             int nb_tc_used_rx, nb_tc_used_tx, queues_per_tc;
> >               uint16_t total_q_nb;
> >
> > -             nb_tc_used =3D check_dcb_conf(ice_get_port_max_cgd(hw) =
=3D=3D
> ICE_4_CGD_PER_PORT,
> > -                     dcb_conf);
> > -             if (nb_tc_used < 0)
> > +             nb_tc_used_rx =3D check_dcb_conf(ice_get_port_max_cgd(hw)=
 =3D=3D
> ICE_4_CGD_PER_PORT,
> > +                     rx_dcb_conf);
> > +             if (nb_tc_used_rx < 0)
> > +                     return -EINVAL;
> > +             nb_tc_used_tx =3D check_dcb_conf(ice_get_port_max_cgd(hw)=
 =3D=3D
> ICE_4_CGD_PER_PORT,
> > +                     tx_dcb_conf);
> > +             if (nb_tc_used_tx < 0)
> >                       return -EINVAL;
> >
> >               ctxt.info =3D vsi->info;
> > @@ -3837,8 +3871,8 @@ ice_dev_configure(struct rte_eth_dev *dev)
> >               }
> >
> >               total_q_nb =3D dev->data->nb_rx_queues;
> > -             queues_per_tc =3D total_q_nb / nb_tc_used;
> > -             if (total_q_nb % nb_tc_used !=3D 0) {
> > +             queues_per_tc =3D total_q_nb / nb_tc_used_rx;
> > +             if (total_q_nb % nb_tc_used_rx !=3D 0) {
> >                       PMD_DRV_LOG(ERR, "For DCB, number of queues must
> be evenly divisble by number of used TCs");
> >                       return -EINVAL;
> >               } else if (!rte_is_power_of_2(queues_per_tc)) {
> > @@ -3846,7 +3880,7 @@ ice_dev_configure(struct rte_eth_dev *dev)
> >                       return -EINVAL;
> >               }
> >
> > -             for (i =3D 0; i < nb_tc_used; i++) {
> > +             for (i =3D 0; i < nb_tc_used_rx; i++) {
> >                       ctxt.info.tc_mapping[i] =3D
> >                               rte_cpu_to_le_16(((i * queues_per_tc) <<
> ICE_AQ_VSI_TC_Q_OFFSET_S) |
> >                                       (rte_log2_u32(queues_per_tc) <<
> ICE_AQ_VSI_TC_Q_NUM_S));
> > @@ -3858,29 +3892,21 @@ ice_dev_configure(struct rte_eth_dev *dev)
> >
> >               /* Associate each VLAN UP with particular TC */
> >               for (i =3D 0; i < ICE_MAX_TRAFFIC_CLASS; i++) {
> > -                     local_dcb_conf->etscfg.prio_table[i] =3D
> dcb_conf->dcb_tc[i];
> > -                     local_dcb_conf->etsrec.prio_table[i] =3D
> dcb_conf->dcb_tc[i];
> > +                     local_dcb_conf->etscfg.prio_table[i] =3D
> rx_dcb_conf->dcb_tc[i];
> > +                     local_dcb_conf->etsrec.prio_table[i] =3D
> tx_dcb_conf->dcb_tc[i];
> >               }
> >
> > -             /*
> > -              * Since current API does not support setting ETS BW Shar=
e
> and Scheduler
> > -              * configure all TC as ETS and evenly share load across
> all existing TC
> > -              **/
> > -             const int bw_share_percent =3D 100 / nb_tc_used;
> > -             const int bw_share_left =3D 100 - bw_share_percent *
> nb_tc_used;
> > -             for (i =3D 0; i < nb_tc_used; i++) {
> > +             for (i =3D 0; i < nb_tc_used_rx; i++) {
> >                       /* Per TC bandwidth table (all valued must add up
> to 100%), valid on ETS */
> > -                     local_dcb_conf->etscfg.tcbwtable[i] =3D
> bw_share_percent;
> > -                     local_dcb_conf->etsrec.tcbwtable[i] =3D
> bw_share_percent;
> > +                     local_dcb_conf->etscfg.tcbwtable[i] =3D
> rx_dcb_conf->dcb_tc_bw[i];
> >
> >                       /**< Transmission Selection Algorithm. 0 - Strict
> prio, 2 - ETS */
> > -                     local_dcb_conf->etscfg.tsatable[i] =3D 2;
> > -                     local_dcb_conf->etsrec.tsatable[i] =3D 2;
> > +                     local_dcb_conf->etscfg.tsatable[i] =3D
> rx_dcb_conf->dcb_tsa[i];
> >               }
> >
> > -             for (i =3D 0; i < bw_share_left; i++) {
> > -                     local_dcb_conf->etscfg.tcbwtable[i]++;
> > -                     local_dcb_conf->etsrec.tcbwtable[i]++;
> > +             for (i =3D 0; i < nb_tc_used_tx; i++) {
> > +                     local_dcb_conf->etsrec.tcbwtable[i] =3D
> tx_dcb_conf->dcb_tc_bw[i];
> > +                     local_dcb_conf->etsrec.tsatable[i] =3D
> tx_dcb_conf->dcb_tsa[i];
> >               }
> >
> >               local_dcb_conf->pfc.pfccap =3D nb_tcs;
> > diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
> > index f9fb6ae549..13b1a41d3b 100644
> > --- a/lib/ethdev/rte_ethdev.h
> > +++ b/lib/ethdev/rte_ethdev.h
> > @@ -853,6 +853,7 @@ rte_eth_rss_hf_refine(uint64_t rss_hf)
> > /**@{@name VMDq and DCB maximums */
> > #define RTE_ETH_VMDQ_MAX_VLAN_FILTERS   64 /**< Maximum nb. of VMDq VLA=
N
> filters. */
> > #define RTE_ETH_DCB_NUM_USER_PRIORITIES 8  /**< Maximum nb. of DCB
> priorities. */
> > +#define RTE_ETH_DCB_NUM_TCS   8 /**< Maximum nb. of DCB traffic
> classes. */
> > #define RTE_ETH_VMDQ_DCB_NUM_QUEUES     128 /**< Maximum nb. of VMDq DC=
B
> queues. */
> > #define RTE_ETH_DCB_NUM_QUEUES          128 /**< Maximum nb. of DCB
> queues. */
> > /**@}*/
> > @@ -929,11 +930,21 @@ enum rte_eth_nb_pools {
> >       RTE_ETH_64_POOLS =3D 64   /**< 64 VMDq pools. */
> > };
> >
> > +#define RTE_ETH_DCB_TSA_STRICT       0
> > +#define RTE_ETH_DCB_TSA_ETS  2
>
> Why not enum?
>

Agree, enum will be better


>
> > +
> > /* This structure may be extended in future. */
> > -struct rte_eth_dcb_rx_conf {
> > +struct rte_eth_dcb_conf {
> >       enum rte_eth_nb_tcs nb_tcs; /**< Possible DCB TCs, 4 or 8 TCs */
> > -     /** Traffic class each UP mapped to. */
> > +     /** Traffic class each UP mapped to.
>
> Perhaps keep '/**' on a separate line in a multi-line comment.
>
> Thank you.
>
> > +      *  Rx packets VLAN UP for Rx configuration
> > +      *  Rx PFC Pause frames UP for Tx configuration
> > +      */
> >       uint8_t dcb_tc[RTE_ETH_DCB_NUM_USER_PRIORITIES];
> > +     /** Traffic class selector algorithm */
> > +     uint8_t dcb_tsa[RTE_ETH_DCB_NUM_TCS];
> > +     /** Traffic class relative bandwidth in percents */
> > +     uint8_t dcb_tc_bw[RTE_ETH_DCB_NUM_TCS];
> > };
> >
> > struct rte_eth_vmdq_dcb_tx_conf {
> > @@ -942,12 +953,6 @@ struct rte_eth_vmdq_dcb_tx_conf {
> >       uint8_t dcb_tc[RTE_ETH_DCB_NUM_USER_PRIORITIES];
> > };
> >
> > -struct rte_eth_dcb_tx_conf {
> > -     enum rte_eth_nb_tcs nb_tcs; /**< Possible DCB TCs, 4 or 8 TCs. */
> > -     /** Traffic class each UP mapped to. */
> > -     uint8_t dcb_tc[RTE_ETH_DCB_NUM_USER_PRIORITIES];
> > -};
> > -
> > struct rte_eth_vmdq_tx_conf {
> >       enum rte_eth_nb_pools nb_queue_pools; /**< VMDq mode, 64 pools. *=
/
> > };
> > @@ -1531,7 +1536,7 @@ struct rte_eth_conf {
> >               /** Port VMDq+DCB configuration. */
> >               struct rte_eth_vmdq_dcb_conf vmdq_dcb_conf;
> >               /** Port DCB Rx configuration. */
> > -             struct rte_eth_dcb_rx_conf dcb_rx_conf;
> > +             struct rte_eth_dcb_conf dcb_rx_conf;
> >               /** Port VMDq Rx configuration. */
> >               struct rte_eth_vmdq_rx_conf vmdq_rx_conf;
> >       } rx_adv_conf; /**< Port Rx filtering configuration. */
> > @@ -1539,7 +1544,7 @@ struct rte_eth_conf {
> >               /** Port VMDq+DCB Tx configuration. */
> >               struct rte_eth_vmdq_dcb_tx_conf vmdq_dcb_tx_conf;
> >               /** Port DCB Tx configuration. */
> > -             struct rte_eth_dcb_tx_conf dcb_tx_conf;
> > +             struct rte_eth_dcb_conf dcb_tx_conf;
> >               /** Port VMDq Tx configuration. */
> >               struct rte_eth_vmdq_tx_conf vmdq_tx_conf;
> >       } tx_adv_conf; /**< Port Tx DCB configuration (union). */
> > --
> > 2.43.0
> >
> >
>


--=20
Regards,
Vladimir

--0000000000000f5454063daa857b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">=D1=81=D0=B1, 3=
0 =D0=B0=D0=B2=D0=B3. 2025=E2=80=AF=D0=B3. =D0=B2 20:52, Ivan Malov &lt;<a =
href=3D"mailto:ivan.malov@arknetworks.am">ivan.malov@arknetworks.am</a>&gt;=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi Vladimir,<b=
r>
<br>
On Sat, 30 Aug 2025, Vladimir Medvedkin wrote:<br>
<br>
&gt; Currently there are two structutes defined for DCB configuration, one =
for<br>
<br>
Typo: structuRes.<br>
<br>
&gt; RX and one for TX. They do have slight semantic difference, but in ter=
ms<br>
&gt; of their structure they are identical. Refactor DCB configuration API =
to<br>
&gt; use common structute for both TX and RX.<br>
&gt;<br>
&gt; Additionally, current structure do not reflect everything that is<br>
&gt; required by the DCB specification, such as per Traffic Class bandwidth=
<br>
&gt; allocation and Traffic Selection Algorithm (TSA). Extend rte_eth_dcb_c=
onf<br>
&gt; with additional DCB settings<br>
&gt;<br>
&gt; Signed-off-by: Vladimir Medvedkin &lt;<a href=3D"mailto:vladimir.medve=
dkin@intel.com" target=3D"_blank">vladimir.medvedkin@intel.com</a>&gt;<br>
&gt; ---<br>
&gt; app/test-pmd/testpmd.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
| 19 ++++++-<br>
&gt; drivers/net/intel/ice/ice_ethdev.c | 80 ++++++++++++++++++++----------=
<br>
&gt; lib/ethdev/rte_ethdev.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 25 =
++++++----<br>
&gt; 3 files changed, 85 insertions(+), 39 deletions(-)<br>
&gt;<br>
&gt; diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c<br>
&gt; index bb88555328..d64a7dcac5 100644<br>
&gt; --- a/app/test-pmd/testpmd.c<br>
&gt; +++ b/app/test-pmd/testpmd.c<br>
&gt; @@ -4134,9 +4134,9 @@ get_eth_dcb_conf(struct rte_eth_conf *eth_conf, =
enum dcb_mode_enable dcb_mode,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(rx_mq=
_mode &amp; RTE_ETH_MQ_RX_VMDQ_DCB);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0eth_conf-&gt;txm=
ode.mq_mode =3D RTE_ETH_MQ_TX_VMDQ_DCB;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct rte_eth_dcb_rx=
_conf *rx_conf =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct rte_eth_dcb_co=
nf *rx_conf =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;eth_conf-&gt;rx_adv_conf.dcb_=
rx_conf;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct rte_eth_dcb_tx=
_conf *tx_conf =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct rte_eth_dcb_co=
nf *tx_conf =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;eth_conf-&gt;tx_adv_conf.dcb_=
tx_conf;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rx_conf-&gt;nb_t=
cs =3D num_tcs;<br>
&gt; @@ -4148,6 +4148,21 @@ get_eth_dcb_conf(struct rte_eth_conf *eth_conf,=
 enum dcb_mode_enable dcb_mode,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0tx_conf-&gt;dcb_tc[i] =3D dcb_tc_val;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const int bw_share_pe=
rcent =3D 100 / num_tcs;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const int bw_share_le=
ft =3D 100 - bw_share_percent * num_tcs;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; =
num_tcs; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0rx_conf-&gt;dcb_tc_bw[i] =3D bw_share_percent;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0tx_conf-&gt;dcb_tc_bw[i] =3D bw_share_percent;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0rx_conf-&gt;dcb_tsa[i] =3D RTE_ETH_DCB_TSA_ETS;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0tx_conf-&gt;dcb_tsa[i] =3D RTE_ETH_DCB_TSA_ETS;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; =
bw_share_left; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0rx_conf-&gt;dcb_tc_bw[i]++;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0tx_conf-&gt;dcb_tc_bw[i]++;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
A brief comment would make the purpose clearer.<br>
<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0eth_conf-&gt;rxm=
ode.mq_mode =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(enum rte_eth_rx_mq_mode)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(rx_mq=
_mode &amp; RTE_ETH_MQ_RX_DCB_RSS);<br>
&gt; diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ic=
e/ice_ethdev.c<br>
&gt; index 8ab0da3549..7ba25049d7 100644<br>
&gt; --- a/drivers/net/intel/ice/ice_ethdev.c<br>
&gt; +++ b/drivers/net/intel/ice/ice_ethdev.c<br>
&gt; @@ -3760,10 +3760,13 @@ static int ice_init_rss(struct ice_pf *pf)<br>
&gt; }<br>
&gt;<br>
&gt; static int<br>
&gt; -check_dcb_conf(int is_8_ports, struct rte_eth_dcb_rx_conf *dcb_conf)<=
br>
&gt; +check_dcb_conf(int is_8_ports, struct rte_eth_dcb_conf *dcb_conf)<br>
&gt; {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t tc_map =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int i;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int total_bw_allocated =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0bool ets_seen =3D false;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int nb_tc_used;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0enum rte_eth_nb_tcs nb_tcs =3D dcb_conf-&gt;=
nb_tcs;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (nb_tcs !=3D RTE_ETH_4_TCS &amp;&amp; is_=
8_ports) {<br>
&gt; @@ -3784,7 +3787,31 @@ check_dcb_conf(int is_8_ports, struct rte_eth_d=
cb_rx_conf *dcb_conf)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0return rte_popcount32(tc_map);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0nb_tc_used =3D rte_popcount32(tc_map);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* calculate total ETS Bandwidth allocation */<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; nb_tc_used; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (dcb_conf-&gt;dcb_=
tsa[i] =3D=3D RTE_ETH_DCB_TSA_ETS) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (dcb_conf-&gt;dcb_tc_bw[i] =3D=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PMD_DRV_LOG(ERR,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;Bad ET=
S BW configuration, can not allocate 0%%&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0total_bw_allocated +=3D dcb_conf-&gt;dcb_tc_bw[i];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0ets_seen =3D true;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (dcb_conf-&=
gt;dcb_tsa[i] !=3D RTE_ETH_DCB_TSA_STRICT) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0PMD_DRV_LOG(ERR, &quot;Invalid TC TSA setting - only Strict and ETS =
are supported&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return -1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* total ETS BW allocation must add up to 100% */=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ets_seen &amp;&amp; total_bw_allocated !=3D 1=
00) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PMD_DRV_LOG(ERR, &quo=
t;Invalid TC Bandwidth allocation configuration&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return nb_tc_used;<br>
&gt; }<br>
&gt;<br>
&gt; static int<br>
&gt; @@ -3819,15 +3846,22 @@ ice_dev_configure(struct rte_eth_dev *dev)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct ice_qos_c=
fg *qos_cfg =3D &amp;port_info-&gt;qos_cfg;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct ice_dcbx_=
cfg *local_dcb_conf =3D &amp;qos_cfg-&gt;local_dcbx_cfg;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct ice_vsi_c=
tx ctxt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct rte_eth_dcb_rx=
_conf *dcb_conf =3D &amp;dev-&gt;data-&gt;dev_conf.rx_adv_conf.dcb_rx_conf;=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct rte_eth_dcb_co=
nf *rx_dcb_conf =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0&amp;dev-&gt;data-&gt;dev_conf.rx_adv_conf.dcb_rx_conf;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct rte_eth_dcb_co=
nf *tx_dcb_conf =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0&amp;dev-&gt;data-&gt;dev_conf.tx_adv_conf.dcb_tx_conf;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int i;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0enum rte_eth_nb_tcs n=
b_tcs =3D dcb_conf-&gt;nb_tcs;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int nb_tc_used, queue=
s_per_tc;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0enum rte_eth_nb_tcs n=
b_tcs =3D rx_dcb_conf-&gt;nb_tcs;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int nb_tc_used_rx, nb=
_tc_used_tx, queues_per_tc;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint16_t total_q=
_nb;<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nb_tc_used =3D check_=
dcb_conf(ice_get_port_max_cgd(hw) =3D=3D ICE_4_CGD_PER_PORT,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0dcb_conf);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (nb_tc_used &lt; 0=
)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nb_tc_used_rx =3D che=
ck_dcb_conf(ice_get_port_max_cgd(hw) =3D=3D ICE_4_CGD_PER_PORT,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0rx_dcb_conf);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (nb_tc_used_rx &lt=
; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return -EINVAL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nb_tc_used_tx =3D che=
ck_dcb_conf(ice_get_port_max_cgd(hw) =3D=3D ICE_4_CGD_PER_PORT,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0tx_dcb_conf);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (nb_tc_used_tx &lt=
; 0)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return -EINVAL;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"http:=
//ctxt.info" rel=3D"noreferrer" target=3D"_blank">ctxt.info</a> =3D vsi-&gt=
;info;<br>
&gt; @@ -3837,8 +3871,8 @@ ice_dev_configure(struct rte_eth_dev *dev)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0total_q_nb =3D d=
ev-&gt;data-&gt;nb_rx_queues;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0queues_per_tc =3D tot=
al_q_nb / nb_tc_used;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (total_q_nb % nb_t=
c_used !=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0queues_per_tc =3D tot=
al_q_nb / nb_tc_used_rx;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (total_q_nb % nb_t=
c_used_rx !=3D 0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0PMD_DRV_LOG(ERR, &quot;For DCB, number of queues must be evenl=
y divisble by number of used TCs&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return -EINVAL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (!rte_=
is_power_of_2(queues_per_tc)) {<br>
&gt; @@ -3846,7 +3880,7 @@ ice_dev_configure(struct rte_eth_dev *dev)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return -EINVAL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; =
nb_tc_used; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; =
nb_tc_used_rx; i++) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0ctxt.info.tc_mapping[i] =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rte_cpu_to_le_16(((i * queues_per_=
tc) &lt;&lt; ICE_AQ_VSI_TC_Q_OFFSET_S) |<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(rte_l=
og2_u32(queues_per_tc) &lt;&lt; ICE_AQ_VSI_TC_Q_NUM_S));<br>
&gt; @@ -3858,29 +3892,21 @@ ice_dev_configure(struct rte_eth_dev *dev)<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Associate eac=
h VLAN UP with particular TC */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i =
&lt; ICE_MAX_TRAFFIC_CLASS; i++) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0local_dcb_conf-&gt;etscfg.prio_table[i] =3D dcb_conf-&gt;dcb_tc[i];<=
br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0local_dcb_conf-&gt;etsrec.prio_table[i] =3D dcb_conf-&gt;dcb_tc[i];<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0local_dcb_conf-&gt;etscfg.prio_table[i] =3D rx_dcb_conf-&gt;dcb_tc[i=
];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0local_dcb_conf-&gt;etsrec.prio_table[i] =3D tx_dcb_conf-&gt;dcb_tc[i=
];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Since current API =
does not support setting ETS BW Share and Scheduler<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * configure all TC a=
s ETS and evenly share load across all existing TC<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 **/<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const int bw_share_pe=
rcent =3D 100 / nb_tc_used;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const int bw_share_le=
ft =3D 100 - bw_share_percent * nb_tc_used;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; =
nb_tc_used; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; =
nb_tc_used_rx; i++) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0/* Per TC bandwidth table (all valued must add up to 100%), va=
lid on ETS */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0local_dcb_conf-&gt;etscfg.tcbwtable[i] =3D bw_share_percent;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0local_dcb_conf-&gt;etsrec.tcbwtable[i] =3D bw_share_percent;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0local_dcb_conf-&gt;etscfg.tcbwtable[i] =3D rx_dcb_conf-&gt;dcb_tc_bw=
[i];<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0/**&lt; Transmission Selection Algorithm. 0 - Strict prio, 2 -=
 ETS */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0local_dcb_conf-&gt;etscfg.tsatable[i] =3D 2;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0local_dcb_conf-&gt;etsrec.tsatable[i] =3D 2;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0local_dcb_conf-&gt;etscfg.tsatable[i] =3D rx_dcb_conf-&gt;dcb_tsa[i]=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; =
bw_share_left; i++) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0local_dcb_conf-&gt;etscfg.tcbwtable[i]++;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0local_dcb_conf-&gt;etsrec.tcbwtable[i]++;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; =
nb_tc_used_tx; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0local_dcb_conf-&gt;etsrec.tcbwtable[i] =3D tx_dcb_conf-&gt;dcb_tc_bw=
[i];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0local_dcb_conf-&gt;etsrec.tsatable[i] =3D tx_dcb_conf-&gt;dcb_tsa[i]=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0local_dcb_conf-&=
gt;pfc.pfccap =3D nb_tcs;<br>
&gt; diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h<br>
&gt; index f9fb6ae549..13b1a41d3b 100644<br>
&gt; --- a/lib/ethdev/rte_ethdev.h<br>
&gt; +++ b/lib/ethdev/rte_ethdev.h<br>
&gt; @@ -853,6 +853,7 @@ rte_eth_rss_hf_refine(uint64_t rss_hf)<br>
&gt; /**@{@name VMDq and DCB maximums */<br>
&gt; #define RTE_ETH_VMDQ_MAX_VLAN_FILTERS=C2=A0 =C2=A064 /**&lt; Maximum n=
b. of VMDq VLAN filters. */<br>
&gt; #define RTE_ETH_DCB_NUM_USER_PRIORITIES 8=C2=A0 /**&lt; Maximum nb. of=
 DCB priorities. */<br>
&gt; +#define RTE_ETH_DCB_NUM_TCS=C2=A0 =C2=A08 /**&lt; Maximum nb. of DCB =
traffic classes. */<br>
&gt; #define RTE_ETH_VMDQ_DCB_NUM_QUEUES=C2=A0 =C2=A0 =C2=A0128 /**&lt; Max=
imum nb. of VMDq DCB queues. */<br>
&gt; #define RTE_ETH_DCB_NUM_QUEUES=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 128 /=
**&lt; Maximum nb. of DCB queues. */<br>
&gt; /**@}*/<br>
&gt; @@ -929,11 +930,21 @@ enum rte_eth_nb_pools {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0RTE_ETH_64_POOLS =3D 64=C2=A0 =C2=A0/**&lt; =
64 VMDq pools. */<br>
&gt; };<br>
&gt;<br>
&gt; +#define RTE_ETH_DCB_TSA_STRICT=C2=A0 =C2=A0 =C2=A0 =C2=A00<br>
&gt; +#define RTE_ETH_DCB_TSA_ETS=C2=A0 2<br>
<br>
Why not enum?<br></blockquote><div><br></div><div>Agree, enum will be bette=
r</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +<br>
&gt; /* This structure may be extended in future. */<br>
&gt; -struct rte_eth_dcb_rx_conf {<br>
&gt; +struct rte_eth_dcb_conf {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0enum rte_eth_nb_tcs nb_tcs; /**&lt; Possible=
 DCB TCs, 4 or 8 TCs */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0/** Traffic class each UP mapped to. */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/** Traffic class each UP mapped to.<br>
<br>
Perhaps keep &#39;/**&#39; on a separate line in a multi-line comment.<br>
<br>
Thank you.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 *=C2=A0 Rx packets VLAN UP for Rx configuration<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 *=C2=A0 Rx PFC Pause frames UP for Tx configurat=
ion<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint8_t dcb_tc[RTE_ETH_DCB_NUM_USER_PRIORITI=
ES];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/** Traffic class selector algorithm */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0uint8_t dcb_tsa[RTE_ETH_DCB_NUM_TCS];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/** Traffic class relative bandwidth in percents =
*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0uint8_t dcb_tc_bw[RTE_ETH_DCB_NUM_TCS];<br>
&gt; };<br>
&gt;<br>
&gt; struct rte_eth_vmdq_dcb_tx_conf {<br>
&gt; @@ -942,12 +953,6 @@ struct rte_eth_vmdq_dcb_tx_conf {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint8_t dcb_tc[RTE_ETH_DCB_NUM_USER_PRIORITI=
ES];<br>
&gt; };<br>
&gt;<br>
&gt; -struct rte_eth_dcb_tx_conf {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0enum rte_eth_nb_tcs nb_tcs; /**&lt; Possible DCB =
TCs, 4 or 8 TCs. */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0/** Traffic class each UP mapped to. */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0uint8_t dcb_tc[RTE_ETH_DCB_NUM_USER_PRIORITIES];<=
br>
&gt; -};<br>
&gt; -<br>
&gt; struct rte_eth_vmdq_tx_conf {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0enum rte_eth_nb_pools nb_queue_pools; /**&lt=
; VMDq mode, 64 pools. */<br>
&gt; };<br>
&gt; @@ -1531,7 +1536,7 @@ struct rte_eth_conf {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/** Port VMDq+DC=
B configuration. */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct rte_eth_v=
mdq_dcb_conf vmdq_dcb_conf;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/** Port DCB Rx =
configuration. */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct rte_eth_dcb_rx=
_conf dcb_rx_conf;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct rte_eth_dcb_co=
nf dcb_rx_conf;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/** Port VMDq Rx=
 configuration. */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct rte_eth_v=
mdq_rx_conf vmdq_rx_conf;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0} rx_adv_conf; /**&lt; Port Rx filtering con=
figuration. */<br>
&gt; @@ -1539,7 +1544,7 @@ struct rte_eth_conf {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/** Port VMDq+DC=
B Tx configuration. */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct rte_eth_v=
mdq_dcb_tx_conf vmdq_dcb_tx_conf;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/** Port DCB Tx =
configuration. */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct rte_eth_dcb_tx=
_conf dcb_tx_conf;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct rte_eth_dcb_co=
nf dcb_tx_conf;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/** Port VMDq Tx=
 configuration. */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct rte_eth_v=
mdq_tx_conf vmdq_tx_conf;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0} tx_adv_conf; /**&lt; Port Tx DCB configura=
tion (union). */<br>
&gt; -- <br>
&gt; 2.43.0<br>
&gt;<br>
&gt;<br>
</blockquote></div><div><br clear=3D"all"></div><br><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><div>Regards,<br></div>Vladimir<br></div></div></div>

--0000000000000f5454063daa857b--
