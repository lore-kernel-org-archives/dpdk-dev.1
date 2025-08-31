Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A954FCA0FF2
	for <dpdk-dev@archiver.kernel.org>; Sun, 31 Aug 2025 15:09:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 89A3840262;
	Sun, 31 Aug 2025 17:09:21 +0200 (CEST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com
 [209.85.208.49]) by mails.dpdk.org (Postfix) with ESMTP id DDE8D4021E
 for <dev@dpdk.org>; Sun, 31 Aug 2025 17:09:19 +0200 (CEST)
Received: by mail-ed1-f49.google.com with SMTP id
 4fb4d7f45d1cf-61cc281171cso6141413a12.0
 for <dev@dpdk.org>; Sun, 31 Aug 2025 08:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756652959; x=1757257759; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hMsSHoXQFTeKyDKvrvIgCMouYc1u9x10zl77Izrf+aw=;
 b=IUWrYrkshK8fMGzRYukTYGDrZKnlEYjkLIx2oFnSp6dslvNafv6F5NRY2TSuxFNBmv
 kxdoPiW9JgW19YMEe2T2cEzP/bxh34RYsKcA7GWRajnmT5lbj+E5b+TlWYgbReXSYFML
 lVRWEngN9J3RMP3vNHrMf0ZR4ooNZ29nszGMcFRyVmpBDzXwbs0wcegAujdLyCV82ORc
 8QnNCPoWrgQm99ZTn/JF26pMjTglTpDIU7GTfTkhoIn71VyNKwbyc7NSlPBxOJV1lcNe
 jGcHwxHXZM9ixNPZbORVBwcD6j4kqCw5ofocCl5aUCWsPjixwI54LHkWrHOrCMlyEjMX
 1nrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756652959; x=1757257759;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hMsSHoXQFTeKyDKvrvIgCMouYc1u9x10zl77Izrf+aw=;
 b=Mi4bPT6xyTelR2+XEKz/KCbcVb1FWH+0dcVN6oCyX4mFP1QdMzgIc8btvBo/muDRTv
 EZ/PICc6PFGgsH928Trq/pGl8jXpJMQuwhakyRRuWgLIkqQRZoYRgpvvR5lkgLLKWKji
 pC4MadDyYsecde0vDxfQQjwu6rwABYmKum7oXL5eqdsNMAHV6MeR0bhjhJXBjqWmnZ3q
 02B3175WNu/KFU2nhUmg8vzI3zcEyKFLKxdHx7Qf7QCTTTPmrygzKesW1az4himP6sw6
 Uwh79EfAnfcaJ+pwVUX9uatOEWEgw6wROy/UeYm6nfIp1mz48V9OctG3z55iyyaZrJ75
 /03Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQT4pl89booqydo3cHbLnKul5bmsFv3asuirsLcMYlKS3DC3kgGyl1leUFAHb9pVjaNPg=@dpdk.org
X-Gm-Message-State: AOJu0Yx8INc31fO174fj+2qQVEI8Vn2o6amVJh5ifG1iJ3h7dsymFNZ2
 e+PeTlsk1ys6s+I0Pgy7cC8idz+4I3boIv8zIMqRHozPMS3iDdUbQKDt+TiuP5PaycV5+tUPLTh
 uISoqged3RHnPyfEGxHuaGVaN8YKxb6H69CkZadw=
X-Gm-Gg: ASbGncvgQ2ZITo4xVSErGmkFeSwqQsEpaqLokAqg96AK7F5Kituh0GtiTFTptULV6X4
 3M6Ic2YZbJ7BuoFurLcY/6/MbvY/tXEEcf8iZKYfgQchBzQHLOMqaW+Qm1sWhsF4oS2sZ9FQLiK
 tvVna+qxpQKwrkPcL7LOzJ9qSUtd68vTl5WheUsba83F01FdinapM2Y2Q7QTuy+BSlCvNNSKzy/
 izd5MqmGigK7wg=
X-Google-Smtp-Source: AGHT+IHVaKd7AcR7nAWITr779Fk5tsyNUOLXrJ9TcZiNN0INifA6bzbV66y54bC3A4v3sAJyiAusuW04IDF8ywOXXWY=
X-Received: by 2002:a05:6402:26c4:b0:61c:7f48:c48a with SMTP id
 4fb4d7f45d1cf-61d26d91a9amr3594045a12.20.1756652959108; Sun, 31 Aug 2025
 08:09:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250830171706.428977-1-vladimir.medvedkin@intel.com>
 <20250830171706.428977-5-vladimir.medvedkin@intel.com>
 <e9910cf9-ebc7-861a-2f30-791309416011@arknetworks.am>
In-Reply-To: <e9910cf9-ebc7-861a-2f30-791309416011@arknetworks.am>
From: Vladimir Medvedkin <medvedkinv@gmail.com>
Date: Sun, 31 Aug 2025 16:09:08 +0100
X-Gm-Features: Ac12FXz9dq0hTzzDFRpdgVoCkI4R_MDIEh8Yygr6cPyYL0WeciJLIEQ5PfbHNTM
Message-ID: <CANDrEHkrO_GEe1_95grSq2jTc7wM8jjBpqUEnNNdnscasRjybQ@mail.gmail.com>
Subject: Re: [RFC PATCH 4/6] ethdev: extend VMDq/DCB configuration with queue
 mapping
To: Ivan Malov <ivan.malov@arknetworks.am>
Cc: Vladimir Medvedkin <vladimir.medvedkin@intel.com>, dev@dpdk.org,
 bruce.richardson@intel.com, 
 anatoly.burakov@intel.com, thomas@monjalon.net, andrew.rybchenko@oktetlabs.ru, 
 stephen@networkplumber.org
Content-Type: multipart/alternative; boundary="0000000000009f1172063daaa375"
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

--0000000000009f1172063daaa375
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D0=B1, 30 =D0=B0=D0=B2=D0=B3. 2025=E2=80=AF=D0=B3. =D0=B2 21:54, Iva=
n Malov <ivan.malov@arknetworks.am>:

> Hi Vladimir,
>
> On Sat, 30 Aug 2025, Vladimir Medvedkin wrote:
>
> > Currently DCB Traffic Class queue mapping is only used when calling get
> > DCB info API, while setting up queue mappings is up to each individual
> > driver. Use the tc queue mapping structure to enable setting up custom
> > mapping explicitly.
> >
> > Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
> > ---
> > app/test-pmd/testpmd.c             | 57 ++++++++++++++++++------------
> > drivers/net/intel/ice/ice_ethdev.c | 39 ++++++++++----------
> > drivers/net/intel/ice/ice_rxtx.c   | 27 +++++++-------
> > lib/ethdev/rte_ethdev.h            | 43 +++++++++++-----------
> > 4 files changed, 92 insertions(+), 74 deletions(-)
> >
> > diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
> > index b5a7e7b3ee..3a55434d44 100644
> > --- a/app/test-pmd/testpmd.c
> > +++ b/app/test-pmd/testpmd.c
> > @@ -4158,6 +4158,16 @@ get_eth_dcb_conf(struct rte_eth_conf *eth_conf,
> enum dcb_mode_enable dcb_mode,
> >               struct rte_eth_dcb_conf *tx_conf =3D
> >                               &eth_conf->tx_adv_conf.dcb_tx_conf;
> >
> > +             struct rte_eth_dcb_tc_queue_mapping *q_map =3D
> &eth_conf->q_map;
> > +             memset(q_map, 0, sizeof(*q_map));
> > +             int queues_per_tc =3D nb_rxq / num_tcs;
> > +             for (i =3D 0; i < num_tcs; i++) {
> > +                     q_map->tc_rxq[0][i].base =3D i * queues_per_tc;
> > +                     q_map->tc_txq[0][i].base =3D i * queues_per_tc;
> > +                     q_map->tc_rxq[0][i].nb_queue =3D queues_per_tc;
> > +                     q_map->tc_txq[0][i].nb_queue =3D queues_per_tc;
> > +             }
> > +
> >               for (i =3D 0; i < RTE_ETH_DCB_NUM_USER_PRIORITIES; i++) {
> >                       dcb_tc_val =3D prio_tc_en ? prio_tc[i] : i % num_=
tcs;
> >                       rx_conf->dcb_tc[i] =3D dcb_tc_val;
> > @@ -4231,6 +4241,30 @@ init_port_dcb_config(portid_t pid,
> >       /* retain the original device configuration. */
> >       memcpy(&port_conf, &rte_port->dev_conf, sizeof(struct
> rte_eth_conf));
> >
> > +     if (num_tcs > 1 && keep_qnum =3D=3D 0) {
> > +             /* Assume the ports in testpmd have the same dcb capabili=
ty
> > +              * and has the same number of rxq and txq in dcb mode
> > +              */
> > +             if (dcb_mode =3D=3D DCB_VT_ENABLED) {
> > +                     if (rte_port->dev_info.max_vfs > 0) {
> > +                             nb_rxq =3D rte_port->dev_info.nb_rx_queue=
s;
> > +                             nb_txq =3D rte_port->dev_info.nb_tx_queue=
s;
> > +                     } else {
> > +                             nb_rxq =3D rte_port->dev_info.max_rx_queu=
es;
> > +                             nb_txq =3D rte_port->dev_info.max_tx_queu=
es;
> > +                     }
> > +             } else {
> > +                     /*if vt is disabled, use all pf queues */
>
> Missing space between '/*' and 'if'.
>
> > +                     if (rte_port->dev_info.vmdq_pool_base =3D=3D 0) {
> > +                             nb_rxq =3D rte_port->dev_info.max_rx_queu=
es;
> > +                             nb_txq =3D rte_port->dev_info.max_tx_queu=
es;
> > +                     } else {
> > +                             nb_rxq =3D (queueid_t)num_tcs;
> > +                             nb_txq =3D (queueid_t)num_tcs;
> > +                     }
> > +             }
> > +     }
> > +
> >       if (num_tcs > 1) {
> >               /* set configuration of DCB in vt mode and DCB in non-vt
> mode */
> >               get_eth_dcb_conf(&port_conf, dcb_mode, num_tcs, pfc_en,
> prio_tc, prio_tc_en);
> > @@ -4267,29 +4301,6 @@ init_port_dcb_config(portid_t pid,
> >               return -1;
> >       }
> >
> > -     if (num_tcs > 1 && keep_qnum =3D=3D 0) {
> > -             /* Assume the ports in testpmd have the same dcb capabili=
ty
> > -              * and has the same number of rxq and txq in dcb mode
> > -              */
> > -             if (dcb_mode =3D=3D DCB_VT_ENABLED) {
> > -                     if (rte_port->dev_info.max_vfs > 0) {
> > -                             nb_rxq =3D rte_port->dev_info.nb_rx_queue=
s;
> > -                             nb_txq =3D rte_port->dev_info.nb_tx_queue=
s;
> > -                     } else {
> > -                             nb_rxq =3D rte_port->dev_info.max_rx_queu=
es;
> > -                             nb_txq =3D rte_port->dev_info.max_tx_queu=
es;
> > -                     }
> > -             } else {
> > -                     /*if vt is disabled, use all pf queues */
> > -                     if (rte_port->dev_info.vmdq_pool_base =3D=3D 0) {
> > -                             nb_rxq =3D rte_port->dev_info.max_rx_queu=
es;
> > -                             nb_txq =3D rte_port->dev_info.max_tx_queu=
es;
> > -                     } else {
> > -                             nb_rxq =3D (queueid_t)num_tcs;
> > -                             nb_txq =3D (queueid_t)num_tcs;
> > -                     }
> > -             }
> > -     }
> >       rx_free_thresh =3D 64;
> >
> >       memcpy(&rte_port->dev_conf, &port_conf, sizeof(struct
> rte_eth_conf));
> > diff --git a/drivers/net/intel/ice/ice_ethdev.c
> b/drivers/net/intel/ice/ice_ethdev.c
> > index ecde00182f..27559bbe18 100644
> > --- a/drivers/net/intel/ice/ice_ethdev.c
> > +++ b/drivers/net/intel/ice/ice_ethdev.c
> > @@ -3846,7 +3846,7 @@ ice_dev_configure(struct rte_eth_dev *dev)
> >               struct rte_eth_dcb_conf *tx_dcb_conf =3D
> >                       &dev->data->dev_conf.tx_adv_conf.dcb_tx_conf;
> >               int i;
> > -             int nb_tc_used_rx, nb_tc_used_tx, queues_per_tc;
> > +             int nb_tc_used_rx, nb_tc_used_tx;
> >               uint16_t total_q_nb;
> >
> >               nb_tc_used_rx =3D check_dcb_conf(ice_get_port_max_cgd(hw)=
 =3D=3D
> ICE_4_CGD_PER_PORT,
> > @@ -3865,19 +3865,23 @@ ice_dev_configure(struct rte_eth_dev *dev)
> >               }
> >
> >               total_q_nb =3D dev->data->nb_rx_queues;
> > -             queues_per_tc =3D total_q_nb / nb_tc_used_rx;
> > -             if (total_q_nb % nb_tc_used_rx !=3D 0) {
> > -                     PMD_DRV_LOG(ERR, "For DCB, number of queues must
> be evenly divisble by number of used TCs");
> > -                     return -EINVAL;
> > -             } else if (!rte_is_power_of_2(queues_per_tc)) {
> > -                     PMD_DRV_LOG(ERR, "For DCB, number of queues per T=
C
> must be a power of 2");
> > -                     return -EINVAL;
> > -             }
> > -
> > +             struct rte_eth_dcb_tc_queue_mapping *q_map =3D
> &dev->data->dev_conf.q_map;
> >               for (i =3D 0; i < nb_tc_used_rx; i++) {
> > +                     if (q_map->tc_rxq[0][i].nb_queue !=3D 0 &&
>
> How is 'nb_queue =3D=3D 0' case handled here and below? Should some
> driver-default
> fill-in be used, similar to code being deleted above?
>
> Or is '(0 << ICE_AQ_VSI_TC_Q_OFFSET_S) | (0 << ICE_AQ_VSI_TC_Q_NUM_S)'
> legit?
>

Yes, this is legit. In this case packets arriving to the corresponding TC
will be sent to the default queue (i.e. the first queue).


>
> > +
>  !rte_is_power_of_2(q_map->tc_rxq[0][i].nb_queue)) {
> > +                             PMD_DRV_LOG(ERR, "For DCB, number of
> queues per TC must be a power of 2");
> > +                             return -EINVAL;
> > +                     }
> > +                     if ((q_map->tc_rxq[0][i].base +
> q_map->tc_rxq[0][i].nb_queue) > total_q_nb) {
> > +                             PMD_DRV_LOG(ERR, "Queue range for TC %d
> exceeds total number of queues",
> > +                                     i);
> > +                             return -EINVAL;
> > +                     }
> >                       ctxt.info.tc_mapping[i] =3D
> > -                             rte_cpu_to_le_16(((i * queues_per_tc) <<
> ICE_AQ_VSI_TC_Q_OFFSET_S) |
> > -                                     (rte_log2_u32(queues_per_tc) <<
> ICE_AQ_VSI_TC_Q_NUM_S));
> > +                             rte_cpu_to_le_16((q_map->tc_rxq[0][i].bas=
e
> <<
> > +                                     ICE_AQ_VSI_TC_Q_OFFSET_S) |
> > +
>  (rte_log2_u32(q_map->tc_rxq[0][i].nb_queue) <<
> > +                                     ICE_AQ_VSI_TC_Q_NUM_S));
>
> This seems to always use pool [0] but does not seem to check if 'nb_queue=
'
> in,
> say, pool [1] is non-zero, to return an error or something. Or is this
> unneeded?
>

Yes, this is unneeded. DCB with VMDq is not supported in ice PMD. In more
detail, we do not support VMDq1, where per-VM queue ranges are "exposed"
like in older ixgbe HW. Instead we support VMDq2, where each per-VM queue
range is covered under VSI (think of it as a virtual interface) abstraction
layer.
For queue mapping I reuse the existing structure, which is used
with rte_eth_dev_get_dcb_info() API. Maybe it is better to create a
dedicated queue mapping structure without all VMDq-related stuff?


>
> >               }
> >
> >               memset(local_dcb_conf, 0, sizeof(*local_dcb_conf));
> > @@ -3941,6 +3945,7 @@ ice_get_dcb_info(struct rte_eth_dev *dev, struct
> rte_eth_dcb_info *dcb_info)
> >       struct ice_dcbx_cfg *dcb_conf =3D &qos_cfg->local_dcbx_cfg;
> >       struct ice_vsi *vsi =3D pf->main_vsi;
> >       struct ice_vsi_ctx ctxt =3D { 0 };
> > +     struct rte_eth_dcb_tc_queue_mapping *q_map =3D
> &dev->data->dev_conf.q_map;
> >
> >       ctxt.info =3D vsi->info;
> >       if (rte_le_to_cpu_16(ctxt.info.mapping_flags) =3D=3D
> ICE_AQ_VSI_Q_MAP_NONCONTIG) {
> > @@ -3953,13 +3958,11 @@ ice_get_dcb_info(struct rte_eth_dev *dev, struc=
t
> rte_eth_dcb_info *dcb_info)
> >               dcb_info->prio_tc[i] =3D dcb_conf->etscfg.prio_table[i];
> >               dcb_info->tc_bws[i] =3D dcb_conf->etscfg.tcbwtable[i];
> >               /* Using VMDQ pool zero since DCB+VMDQ is not supported *=
/
> > -             uint16_t tc_rx_q_map =3D
> rte_le_to_cpu_16(ctxt.info.tc_mapping[i]);
> > -             dcb_info->tc_queue.tc_rxq[0][i].base =3D tc_rx_q_map &
> ICE_AQ_VSI_TC_Q_OFFSET_M;
> > -             dcb_info->tc_queue.tc_rxq[0][i].nb_queue =3D
> > -                     1 << ((tc_rx_q_map & ICE_AQ_VSI_TC_Q_NUM_M) >>
> ICE_AQ_VSI_TC_Q_NUM_S);
> > +             dcb_info->tc_queue.tc_rxq[0][i].base =3D
> q_map->tc_rxq[0][i].base;
> > +             dcb_info->tc_queue.tc_rxq[0][i].nb_queue =3D
> q_map->tc_rxq[0][i].nb_queue;
> >
> > -             dcb_info->tc_queue.tc_txq[0][i].base =3D
> dcb_info->tc_queue.tc_rxq[0][i].base;
> > -             dcb_info->tc_queue.tc_txq[0][i].nb_queue =3D
> dcb_info->tc_queue.tc_rxq[0][i].nb_queue;
> > +             dcb_info->tc_queue.tc_txq[0][i].base =3D
> q_map->tc_txq[0][i].base;
> > +             dcb_info->tc_queue.tc_txq[0][i].nb_queue =3D
> q_map->tc_txq[0][i].nb_queue;
> >       }
> >
> >       return 0;
> > diff --git a/drivers/net/intel/ice/ice_rxtx.c
> b/drivers/net/intel/ice/ice_rxtx.c
> > index 451816affd..55424e7a23 100644
> > --- a/drivers/net/intel/ice/ice_rxtx.c
> > +++ b/drivers/net/intel/ice/ice_rxtx.c
> > @@ -796,6 +796,7 @@ ice_tx_queue_start(struct rte_eth_dev *dev, uint16_=
t
> tx_queue_id)
> >       int buf_len;
> >       struct ice_adapter *ad =3D
> ICE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
> >       u16 q_base, q_range, cgd_idx =3D 0;
> > +     struct rte_eth_dcb_tc_queue_mapping *q_map =3D
> &dev->data->dev_conf.q_map;
> >
> >       PMD_INIT_FUNC_TRACE();
> >
> > @@ -840,22 +841,22 @@ ice_tx_queue_start(struct rte_eth_dev *dev,
> uint16_t tx_queue_id)
> >       tx_ctx.legacy_int =3D 1; /* Legacy or Advanced Host Interface */
> >       tx_ctx.tsyn_ena =3D 1;
> >
> > -     /* Mirror RXQ<->CGD association to TXQ<->CDG */
> > -     for (int i =3D 0; i < ICE_MAX_TRAFFIC_CLASS; i++) {
> > -             q_base =3D rte_le_to_cpu_16(vsi->info.tc_mapping[i]) &
> ICE_AQ_VSI_TC_Q_OFFSET_M;
> > -             q_range =3D 1 << ((rte_le_to_cpu_16(vsi->info.tc_mapping[=
i])
> &
> > -                     ICE_AQ_VSI_TC_Q_NUM_M) >> ICE_AQ_VSI_TC_Q_NUM_S);
> > +     if (dev->data->dev_conf.txmode.mq_mode =3D=3D RTE_ETH_MQ_TX_DCB) =
{
> > +             for (int i =3D 0; i < ICE_MAX_TRAFFIC_CLASS; i++) {
> > +                     q_base =3D q_map->tc_txq[0][i].base;
> > +                     q_range =3D q_map->tc_txq[0][i].nb_queue;
> >
> > -             if (q_base <=3D tx_queue_id && tx_queue_id < q_base +
> q_range)
> > -                     break;
> > +                     if (q_base <=3D tx_queue_id && tx_queue_id < q_ba=
se
> + q_range)
> > +                             break;
> >
> > -             cgd_idx++;
> > -     }
> > +                     cgd_idx++;
> > +             }
> >
> > -     if (cgd_idx >=3D ICE_MAX_TRAFFIC_CLASS) {
> > -             PMD_DRV_LOG(ERR, "Bad queue mapping configuration");
> > -             rte_free(txq_elem);
> > -             return -EINVAL;
> > +             if (cgd_idx >=3D ICE_MAX_TRAFFIC_CLASS) {
> > +                     PMD_DRV_LOG(ERR, "Bad queue mapping
> configuration");
> > +                     rte_free(txq_elem);
> > +                     return -EINVAL;
> > +             }
> >       }
> >
> >       tx_ctx.cgd_num =3D cgd_idx;
> > diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
> > index c220760043..0bd86e1e7d 100644
> > --- a/lib/ethdev/rte_ethdev.h
> > +++ b/lib/ethdev/rte_ethdev.h
> > @@ -1472,6 +1472,26 @@ struct rte_eth_intr_conf {
> >
> > #define rte_intr_conf rte_eth_intr_conf
> >
> > +#define RTE_ETH_DCB_NUM_TCS    8
> > +#define RTE_ETH_MAX_VMDQ_POOL  64
> > +
> > +/**
> > + * A structure used to get the information of queue and
> > + * TC mapping on both Tx and Rx paths.
> > + */
> > +struct rte_eth_dcb_tc_queue_mapping {
> > +     /** Rx queues assigned to tc per Pool */
> > +     struct {
> > +             uint16_t base;
> > +             uint16_t nb_queue;
> > +     } tc_rxq[RTE_ETH_MAX_VMDQ_POOL][RTE_ETH_DCB_NUM_TCS];
> > +     /** Rx queues assigned to tc per Pool */
> > +     struct {
> > +             uint16_t base;
> > +             uint16_t nb_queue;
> > +     } tc_txq[RTE_ETH_MAX_VMDQ_POOL][RTE_ETH_DCB_NUM_TCS];
> > +};
> > +
> > /**
> >  * A structure used to configure an Ethernet port.
> >  * Depending upon the Rx multi-queue mode, extra advanced
> > @@ -1492,18 +1512,21 @@ struct rte_eth_conf {
> >                                Read the datasheet of given Ethernet
> controller
> >                                for details. The possible values of this
> field
> >                                are defined in implementation of each
> driver. */
> > +     struct rte_eth_dcb_tc_queue_mapping q_map;
>
> Is the driver supposed to tell 'q_map' is valid by looking at [0][0]
> 'nb_queue'?
>

Could you please clarify what validity criteria for the [0][0] 'nb_queue'
do you mean?


>
> >       struct {
> >               struct rte_eth_rss_conf rss_conf; /**< Port RSS
> configuration */
> >               /** Port DCB Rx configuration. */
> >               struct rte_eth_dcb_conf dcb_rx_conf;
> >               /** Port VMDq Rx configuration. */
> >               struct rte_eth_vmdq_rx_conf vmdq_rx_conf;
> > +             /* VMDQ and DCB Rx queue mapping configuration. */
>
> Perhaps it's better to have just one such comment right before 'q_map'.
>

Oh, my bad, last minute rework, thanks!


>
> Thank you.
>
> >       } rx_adv_conf; /**< Port Rx filtering configuration. */
> >       struct {
> >               /** Port DCB Tx configuration. */
> >               struct rte_eth_dcb_conf dcb_tx_conf;
> >               /** Port VMDq Tx configuration. */
> >               struct rte_eth_vmdq_tx_conf vmdq_tx_conf;
> > +             /* VMDQ and DCB Tx queue mapping configuration. */
> >       } tx_adv_conf; /**< Port Tx DCB configuration (union). */
> >       /** Currently,Priority Flow Control(PFC) are supported,if DCB wit=
h
> PFC
> >           is needed,and the variable must be set
> RTE_ETH_DCB_PFC_SUPPORT. */
> > @@ -1930,26 +1953,6 @@ struct rte_eth_xstat_name {
> >       char name[RTE_ETH_XSTATS_NAME_SIZE]; /**< The statistic name. */
> > };
> >
> > -#define RTE_ETH_DCB_NUM_TCS    8
> > -#define RTE_ETH_MAX_VMDQ_POOL  64
> > -
> > -/**
> > - * A structure used to get the information of queue and
> > - * TC mapping on both Tx and Rx paths.
> > - */
> > -struct rte_eth_dcb_tc_queue_mapping {
> > -     /** Rx queues assigned to tc per Pool */
> > -     struct {
> > -             uint16_t base;
> > -             uint16_t nb_queue;
> > -     } tc_rxq[RTE_ETH_MAX_VMDQ_POOL][RTE_ETH_DCB_NUM_TCS];
> > -     /** Rx queues assigned to tc per Pool */
> > -     struct {
> > -             uint16_t base;
> > -             uint16_t nb_queue;
> > -     } tc_txq[RTE_ETH_MAX_VMDQ_POOL][RTE_ETH_DCB_NUM_TCS];
> > -};
> > -
> > /**
> >  * A structure used to get the information of DCB.
> >  * It includes TC UP mapping and queue TC mapping.
> > --
> > 2.43.0
> >
> >
>


--=20
Regards,
Vladimir

--0000000000009f1172063daaa375
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">=D1=81=D0=B1, 30 =D0=
=B0=D0=B2=D0=B3. 2025=E2=80=AF=D0=B3. =D0=B2 21:54, Ivan Malov &lt;<a href=
=3D"mailto:ivan.malov@arknetworks.am" target=3D"_blank">ivan.malov@arknetwo=
rks.am</a>&gt;:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
Hi Vladimir,<br>
<br>
On Sat, 30 Aug 2025, Vladimir Medvedkin wrote:<br>
<br>
&gt; Currently DCB Traffic Class queue mapping is only used when calling ge=
t<br>
&gt; DCB info API, while setting up queue mappings is up to each individual=
<br>
&gt; driver. Use the tc queue mapping structure to enable setting up custom=
<br>
&gt; mapping explicitly.<br>
&gt;<br>
&gt; Signed-off-by: Vladimir Medvedkin &lt;<a href=3D"mailto:vladimir.medve=
dkin@intel.com" target=3D"_blank">vladimir.medvedkin@intel.com</a>&gt;<br>
&gt; ---<br>
&gt; app/test-pmd/testpmd.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
| 57 ++++++++++++++++++------------<br>
&gt; drivers/net/intel/ice/ice_ethdev.c | 39 ++++++++++----------<br>
&gt; drivers/net/intel/ice/ice_rxtx.c=C2=A0 =C2=A0| 27 +++++++-------<br>
&gt; lib/ethdev/rte_ethdev.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 43 =
+++++++++++-----------<br>
&gt; 4 files changed, 92 insertions(+), 74 deletions(-)<br>
&gt;<br>
&gt; diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c<br>
&gt; index b5a7e7b3ee..3a55434d44 100644<br>
&gt; --- a/app/test-pmd/testpmd.c<br>
&gt; +++ b/app/test-pmd/testpmd.c<br>
&gt; @@ -4158,6 +4158,16 @@ get_eth_dcb_conf(struct rte_eth_conf *eth_conf,=
 enum dcb_mode_enable dcb_mode,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct rte_eth_d=
cb_conf *tx_conf =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;eth_conf-&gt;tx_adv_conf.dcb_=
tx_conf;<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct rte_eth_dcb_tc=
_queue_mapping *q_map =3D &amp;eth_conf-&gt;q_map;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memset(q_map, 0, size=
of(*q_map));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int queues_per_tc =3D=
 nb_rxq / num_tcs;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; =
num_tcs; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0q_map-&gt;tc_rxq[0][i].base =3D i * queues_per_tc;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0q_map-&gt;tc_txq[0][i].base =3D i * queues_per_tc;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0q_map-&gt;tc_rxq[0][i].nb_queue =3D queues_per_tc;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0q_map-&gt;tc_txq[0][i].nb_queue =3D queues_per_tc;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i =
&lt; RTE_ETH_DCB_NUM_USER_PRIORITIES; i++) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0dcb_tc_val =3D prio_tc_en ? prio_tc[i] : i % num_tcs;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0rx_conf-&gt;dcb_tc[i] =3D dcb_tc_val;<br>
&gt; @@ -4231,6 +4241,30 @@ init_port_dcb_config(portid_t pid,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* retain the original device configuration.=
 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0memcpy(&amp;port_conf, &amp;rte_port-&gt;dev=
_conf, sizeof(struct rte_eth_conf));<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (num_tcs &gt; 1 &amp;&amp; keep_qnum =3D=3D 0)=
 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Assume the ports i=
n testpmd have the same dcb capability<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * and has the same n=
umber of rxq and txq in dcb mode<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (dcb_mode =3D=3D D=
CB_VT_ENABLED) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (rte_port-&gt;dev_info.max_vfs &gt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nb_rxq =3D rte_port-&gt;dev_info.nb_rx_q=
ueues;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nb_txq =3D rte_port-&gt;dev_info.nb_tx_q=
ueues;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0} else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nb_rxq =3D rte_port-&gt;dev_info.max_rx_=
queues;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nb_txq =3D rte_port-&gt;dev_info.max_tx_=
queues;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0/*if vt is disabled, use all pf queues */<br>
<br>
Missing space between &#39;/*&#39; and &#39;if&#39;.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (rte_port-&gt;dev_info.vmdq_pool_base =3D=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nb_rxq =3D rte_port-&gt;dev_info.max_rx_=
queues;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nb_txq =3D rte_port-&gt;dev_info.max_tx_=
queues;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0} else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nb_rxq =3D (queueid_t)num_tcs;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nb_txq =3D (queueid_t)num_tcs;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (num_tcs &gt; 1) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* set configura=
tion of DCB in vt mode and DCB in non-vt mode */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0get_eth_dcb_conf=
(&amp;port_conf, dcb_mode, num_tcs, pfc_en, prio_tc, prio_tc_en);<br>
&gt; @@ -4267,29 +4301,6 @@ init_port_dcb_config(portid_t pid,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (num_tcs &gt; 1 &amp;&amp; keep_qnum =3D=3D 0)=
 {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Assume the ports i=
n testpmd have the same dcb capability<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * and has the same n=
umber of rxq and txq in dcb mode<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (dcb_mode =3D=3D D=
CB_VT_ENABLED) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (rte_port-&gt;dev_info.max_vfs &gt; 0) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nb_rxq =3D rte_port-&gt;dev_info.nb_rx_q=
ueues;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nb_txq =3D rte_port-&gt;dev_info.nb_tx_q=
ueues;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0} else {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nb_rxq =3D rte_port-&gt;dev_info.max_rx_=
queues;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nb_txq =3D rte_port-&gt;dev_info.max_tx_=
queues;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0}<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0/*if vt is disabled, use all pf queues */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (rte_port-&gt;dev_info.vmdq_pool_base =3D=3D 0) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nb_rxq =3D rte_port-&gt;dev_info.max_rx_=
queues;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nb_txq =3D rte_port-&gt;dev_info.max_tx_=
queues;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0} else {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nb_rxq =3D (queueid_t)num_tcs;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nb_txq =3D (queueid_t)num_tcs;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0}<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; -=C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0rx_free_thresh =3D 64;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0memcpy(&amp;rte_port-&gt;dev_conf, &amp;port=
_conf, sizeof(struct rte_eth_conf));<br>
&gt; diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ic=
e/ice_ethdev.c<br>
&gt; index ecde00182f..27559bbe18 100644<br>
&gt; --- a/drivers/net/intel/ice/ice_ethdev.c<br>
&gt; +++ b/drivers/net/intel/ice/ice_ethdev.c<br>
&gt; @@ -3846,7 +3846,7 @@ ice_dev_configure(struct rte_eth_dev *dev)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct rte_eth_d=
cb_conf *tx_dcb_conf =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0&amp;dev-&gt;data-&gt;dev_conf.tx_adv_conf.dcb_tx_conf;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int i;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int nb_tc_used_rx, nb=
_tc_used_tx, queues_per_tc;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int nb_tc_used_rx, nb=
_tc_used_tx;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint16_t total_q=
_nb;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nb_tc_used_rx =
=3D check_dcb_conf(ice_get_port_max_cgd(hw) =3D=3D ICE_4_CGD_PER_PORT,<br>
&gt; @@ -3865,19 +3865,23 @@ ice_dev_configure(struct rte_eth_dev *dev)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0total_q_nb =3D d=
ev-&gt;data-&gt;nb_rx_queues;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0queues_per_tc =3D tot=
al_q_nb / nb_tc_used_rx;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (total_q_nb % nb_t=
c_used_rx !=3D 0) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0PMD_DRV_LOG(ERR, &quot;For DCB, number of queues must be evenly divi=
sble by number of used TCs&quot;);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return -EINVAL;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (!rte_is_po=
wer_of_2(queues_per_tc)) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0PMD_DRV_LOG(ERR, &quot;For DCB, number of queues per TC must be a po=
wer of 2&quot;);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return -EINVAL;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; -<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct rte_eth_dcb_tc=
_queue_mapping *q_map =3D &amp;dev-&gt;data-&gt;dev_conf.q_map;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i =
&lt; nb_tc_used_rx; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (q_map-&gt;tc_rxq[0][i].nb_queue !=3D 0 &amp;&amp;<br>
<br>
How is &#39;nb_queue =3D=3D 0&#39; case handled here and below? Should some=
 driver-default<br>
fill-in be used, similar to code being deleted above?<br>
<br>
Or is &#39;(0 &lt;&lt; ICE_AQ_VSI_TC_Q_OFFSET_S) | (0 &lt;&lt; ICE_AQ_VSI_T=
C_Q_NUM_S)&#39; legit?<br></blockquote><div><br></div><div>Yes, this is leg=
it. In this case packets arriving to the corresponding TC will be sent to t=
he default queue (i.e. the first queue).</div><div>=C2=A0</div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0!rte_is_powe=
r_of_2(q_map-&gt;tc_rxq[0][i].nb_queue)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PMD_DRV_LOG(ERR, &quot;For DCB, number o=
f queues per TC must be a power of 2&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if ((q_map-&gt;tc_rxq[0][i].base + q_map-&gt;tc_rxq[0][i].nb_queue) =
&gt; total_q_nb) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PMD_DRV_LOG(ERR, &quot;Queue range for T=
C %d exceeds total number of queues&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0ctxt.info.tc_mapping[i] =3D<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rte_cpu_to_le_16(((i * queues_per_tc) &l=
t;&lt; ICE_AQ_VSI_TC_Q_OFFSET_S) |<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(rte_log2_u3=
2(queues_per_tc) &lt;&lt; ICE_AQ_VSI_TC_Q_NUM_S));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rte_cpu_to_le_16((q_map-&gt;tc_rxq[0][i]=
.base &lt;&lt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ICE_AQ_VSI_T=
C_Q_OFFSET_S) |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(rte_log2_u3=
2(q_map-&gt;tc_rxq[0][i].nb_queue) &lt;&lt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ICE_AQ_VSI_T=
C_Q_NUM_S));<br>
<br>
This seems to always use pool [0] but does not seem to check if &#39;nb_que=
ue&#39; in,<br>
say, pool [1] is non-zero, to return an error or something. Or is this unne=
eded?<br></blockquote><div><br></div><div>Yes, this is unneeded. DCB with V=
MDq is not supported in ice PMD. In more detail, we do not support VMDq1, w=
here per-VM queue ranges are &quot;exposed&quot; like in older ixgbe HW. In=
stead we support=C2=A0VMDq2, where each per-VM queue range is covered under=
 VSI (think of it as a virtual interface) abstraction layer.</div><div>For =
queue mapping I reuse the existing structure, which is used with=C2=A0rte_e=
th_dev_get_dcb_info() API. Maybe it is better to create a dedicated queue m=
apping structure without all VMDq-related stuff?</div><div>=C2=A0</div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memset(local_dcb=
_conf, 0, sizeof(*local_dcb_conf));<br>
&gt; @@ -3941,6 +3945,7 @@ ice_get_dcb_info(struct rte_eth_dev *dev, struct=
 rte_eth_dcb_info *dcb_info)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct ice_dcbx_cfg *dcb_conf =3D &amp;qos_c=
fg-&gt;local_dcbx_cfg;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct ice_vsi *vsi =3D pf-&gt;main_vsi;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct ice_vsi_ctx ctxt =3D { 0 };<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct rte_eth_dcb_tc_queue_mapping *q_map =3D &a=
mp;dev-&gt;data-&gt;dev_conf.q_map;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"http://ctxt.info" rel=3D"noreferr=
er" target=3D"_blank">ctxt.info</a> =3D vsi-&gt;info;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (rte_le_to_cpu_16(<a href=3D"http://ctxt.=
info" target=3D"_blank">ctxt.info</a>.mapping_flags) =3D=3D ICE_AQ_VSI_Q_MA=
P_NONCONTIG) {<br>
&gt; @@ -3953,13 +3958,11 @@ ice_get_dcb_info(struct rte_eth_dev *dev, stru=
ct rte_eth_dcb_info *dcb_info)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dcb_info-&gt;pri=
o_tc[i] =3D dcb_conf-&gt;etscfg.prio_table[i];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dcb_info-&gt;tc_=
bws[i] =3D dcb_conf-&gt;etscfg.tcbwtable[i];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Using VMDQ po=
ol zero since DCB+VMDQ is not supported */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint16_t tc_rx_q_map =
=3D rte_le_to_cpu_16(ctxt.info.tc_mapping[i]);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dcb_info-&gt;tc_queue=
.tc_rxq[0][i].base =3D tc_rx_q_map &amp; ICE_AQ_VSI_TC_Q_OFFSET_M;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dcb_info-&gt;tc_queue=
.tc_rxq[0][i].nb_queue =3D<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A01 &lt;&lt; ((tc_rx_q_map &amp; ICE_AQ_VSI_TC_Q_NUM_M) &gt;&gt; ICE_A=
Q_VSI_TC_Q_NUM_S);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dcb_info-&gt;tc_queue=
.tc_rxq[0][i].base =3D q_map-&gt;tc_rxq[0][i].base;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dcb_info-&gt;tc_queue=
.tc_rxq[0][i].nb_queue =3D q_map-&gt;tc_rxq[0][i].nb_queue;<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dcb_info-&gt;tc_queue=
.tc_txq[0][i].base =3D dcb_info-&gt;tc_queue.tc_rxq[0][i].base;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dcb_info-&gt;tc_queue=
.tc_txq[0][i].nb_queue =3D dcb_info-&gt;tc_queue.tc_rxq[0][i].nb_queue;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dcb_info-&gt;tc_queue=
.tc_txq[0][i].base =3D q_map-&gt;tc_txq[0][i].base;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dcb_info-&gt;tc_queue=
.tc_txq[0][i].nb_queue =3D q_map-&gt;tc_txq[0][i].nb_queue;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/=
ice_rxtx.c<br>
&gt; index 451816affd..55424e7a23 100644<br>
&gt; --- a/drivers/net/intel/ice/ice_rxtx.c<br>
&gt; +++ b/drivers/net/intel/ice/ice_rxtx.c<br>
&gt; @@ -796,6 +796,7 @@ ice_tx_queue_start(struct rte_eth_dev *dev, uint16=
_t tx_queue_id)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int buf_len;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct ice_adapter *ad =3D ICE_DEV_PRIVATE_T=
O_ADAPTER(dev-&gt;data-&gt;dev_private);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0u16 q_base, q_range, cgd_idx =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct rte_eth_dcb_tc_queue_mapping *q_map =3D &a=
mp;dev-&gt;data-&gt;dev_conf.q_map;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0PMD_INIT_FUNC_TRACE();<br>
&gt;<br>
&gt; @@ -840,22 +841,22 @@ ice_tx_queue_start(struct rte_eth_dev *dev, uint=
16_t tx_queue_id)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0tx_ctx.legacy_int =3D 1; /* Legacy or Advanc=
ed Host Interface */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0tx_ctx.tsyn_ena =3D 1;<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0/* Mirror RXQ&lt;-&gt;CGD association to TXQ&lt;-=
&gt;CDG */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0for (int i =3D 0; i &lt; ICE_MAX_TRAFFIC_CLASS; i=
++) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0q_base =3D rte_le_to_=
cpu_16(vsi-&gt;info.tc_mapping[i]) &amp; ICE_AQ_VSI_TC_Q_OFFSET_M;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0q_range =3D 1 &lt;&lt=
; ((rte_le_to_cpu_16(vsi-&gt;info.tc_mapping[i]) &amp;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0ICE_AQ_VSI_TC_Q_NUM_M) &gt;&gt; ICE_AQ_VSI_TC_Q_NUM_S);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (dev-&gt;data-&gt;dev_conf.txmode.mq_mode =3D=
=3D RTE_ETH_MQ_TX_DCB) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (int i =3D 0; i &=
lt; ICE_MAX_TRAFFIC_CLASS; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0q_base =3D q_map-&gt;tc_txq[0][i].base;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0q_range =3D q_map-&gt;tc_txq[0][i].nb_queue;<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (q_base &lt;=3D tx=
_queue_id &amp;&amp; tx_queue_id &lt; q_base + q_range)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (q_base &lt;=3D tx_queue_id &amp;&amp; tx_queue_id &lt; q_base + =
q_range)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cgd_idx++;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0cgd_idx++;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (cgd_idx &gt;=3D ICE_MAX_TRAFFIC_CLASS) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PMD_DRV_LOG(ERR, &quo=
t;Bad queue mapping configuration&quot;);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rte_free(txq_elem);<b=
r>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (cgd_idx &gt;=3D I=
CE_MAX_TRAFFIC_CLASS) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0PMD_DRV_LOG(ERR, &quot;Bad queue mapping configuration&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0rte_free(txq_elem);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return -EINVAL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0tx_ctx.cgd_num =3D cgd_idx;<br>
&gt; diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h<br>
&gt; index c220760043..0bd86e1e7d 100644<br>
&gt; --- a/lib/ethdev/rte_ethdev.h<br>
&gt; +++ b/lib/ethdev/rte_ethdev.h<br>
&gt; @@ -1472,6 +1472,26 @@ struct rte_eth_intr_conf {<br>
&gt;<br>
&gt; #define rte_intr_conf rte_eth_intr_conf<br>
&gt;<br>
&gt; +#define RTE_ETH_DCB_NUM_TCS=C2=A0 =C2=A0 8<br>
&gt; +#define RTE_ETH_MAX_VMDQ_POOL=C2=A0 64<br>
&gt; +<br>
&gt; +/**<br>
&gt; + * A structure used to get the information of queue and<br>
&gt; + * TC mapping on both Tx and Rx paths.<br>
&gt; + */<br>
&gt; +struct rte_eth_dcb_tc_queue_mapping {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/** Rx queues assigned to tc per Pool */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint16_t base;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint16_t nb_queue;<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0} tc_rxq[RTE_ETH_MAX_VMDQ_POOL][RTE_ETH_DCB_NUM_T=
CS];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/** Rx queues assigned to tc per Pool */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint16_t base;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint16_t nb_queue;<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0} tc_txq[RTE_ETH_MAX_VMDQ_POOL][RTE_ETH_DCB_NUM_T=
CS];<br>
&gt; +};<br>
&gt; +<br>
&gt; /**<br>
&gt;=C2=A0 * A structure used to configure an Ethernet port.<br>
&gt;=C2=A0 * Depending upon the Rx multi-queue mode, extra advanced<br>
&gt; @@ -1492,18 +1512,21 @@ struct rte_eth_conf {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Read the datasheet of given Ether=
net controller<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for details. The possible values =
of this field<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 are defined in implementation of =
each driver. */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct rte_eth_dcb_tc_queue_mapping q_map;<br>
<br>
Is the driver supposed to tell &#39;q_map&#39; is valid by looking at [0][0=
] &#39;nb_queue&#39;?<br></blockquote><div><br></div><div>Could you please =
clarify what validity criteria for the [0][0] &#39;nb_queue&#39; do you mea=
n?</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct rte_eth_r=
ss_conf rss_conf; /**&lt; Port RSS configuration */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/** Port DCB Rx =
configuration. */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct rte_eth_d=
cb_conf dcb_rx_conf;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/** Port VMDq Rx=
 configuration. */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct rte_eth_v=
mdq_rx_conf vmdq_rx_conf;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* VMDQ and DCB Rx qu=
eue mapping configuration. */<br>
<br>
Perhaps it&#39;s better to have just one such comment right before &#39;q_m=
ap&#39;.<br></blockquote><div><br></div><div>Oh, my bad, last minute rework=
, thanks!</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">
<br>
Thank you.<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0} rx_adv_conf; /**&lt; Port Rx filtering con=
figuration. */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/** Port DCB Tx =
configuration. */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct rte_eth_d=
cb_conf dcb_tx_conf;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/** Port VMDq Tx=
 configuration. */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct rte_eth_v=
mdq_tx_conf vmdq_tx_conf;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* VMDQ and DCB Tx qu=
eue mapping configuration. */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0} tx_adv_conf; /**&lt; Port Tx DCB configura=
tion (union). */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/** Currently,Priority Flow Control(PFC) are=
 supported,if DCB with PFC<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0is needed,and the variable mus=
t be set RTE_ETH_DCB_PFC_SUPPORT. */<br>
&gt; @@ -1930,26 +1953,6 @@ struct rte_eth_xstat_name {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0char name[RTE_ETH_XSTATS_NAME_SIZE]; /**&lt;=
 The statistic name. */<br>
&gt; };<br>
&gt;<br>
&gt; -#define RTE_ETH_DCB_NUM_TCS=C2=A0 =C2=A0 8<br>
&gt; -#define RTE_ETH_MAX_VMDQ_POOL=C2=A0 64<br>
&gt; -<br>
&gt; -/**<br>
&gt; - * A structure used to get the information of queue and<br>
&gt; - * TC mapping on both Tx and Rx paths.<br>
&gt; - */<br>
&gt; -struct rte_eth_dcb_tc_queue_mapping {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0/** Rx queues assigned to tc per Pool */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0struct {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint16_t base;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint16_t nb_queue;<br=
>
&gt; -=C2=A0 =C2=A0 =C2=A0} tc_rxq[RTE_ETH_MAX_VMDQ_POOL][RTE_ETH_DCB_NUM_T=
CS];<br>
&gt; -=C2=A0 =C2=A0 =C2=A0/** Rx queues assigned to tc per Pool */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0struct {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint16_t base;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint16_t nb_queue;<br=
>
&gt; -=C2=A0 =C2=A0 =C2=A0} tc_txq[RTE_ETH_MAX_VMDQ_POOL][RTE_ETH_DCB_NUM_T=
CS];<br>
&gt; -};<br>
&gt; -<br>
&gt; /**<br>
&gt;=C2=A0 * A structure used to get the information of DCB.<br>
&gt;=C2=A0 * It includes TC UP mapping and queue TC mapping.<br>
&gt; -- <br>
&gt; 2.43.0<br>
&gt;<br>
&gt;<br>
</blockquote></div><div><br clear=3D"all"></div><br><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><div>Regards,<br></div>Vladimir<br></div></div></div>
</div>

--0000000000009f1172063daaa375--
