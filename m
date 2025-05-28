Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AEBFC5AD49
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 May 2025 10:11:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CAB5440A71;
	Wed, 28 May 2025 12:11:26 +0200 (CEST)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com
 [209.85.222.175])
 by mails.dpdk.org (Postfix) with ESMTP id E218840279;
 Wed, 28 May 2025 12:11:25 +0200 (CEST)
Received: by mail-qk1-f175.google.com with SMTP id
 af79cd13be357-7c922734cc2so76349385a.1; 
 Wed, 28 May 2025 03:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748427085; x=1749031885; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cJd5IBROJghzscxB4JST6ulgIsBYUzq/fl2PTxV2iI4=;
 b=HaSdCf5XskvCqp1uNCLK1btzipH2jpN0+GJKo1z28qWFKvZIfq14mON+ZXfDQ2QZ9m
 bT7+GgmjbvMuXn+OflVsLYzyidUBXIkvu/6QiM7dVM4eV6jbiea9bULdKQGlTyxOO4My
 J4ZrtrY0OTQ8/x4RmyBYuttZkjXaiZthesS8+S9O3Mx0lFcQQtkrHtphOLj9QPpMWxFK
 EjIJ6dIa7RGAZ2ZE0qfbj1vJ1CMxDKZ06nmhsvvmQSqn/fZRICTJCpR7Bn7/ItEtZqIq
 jSt1olCadcxtaD8/eX4RbHHmxDabpG4f8HVtLrwT41yup10ux9YHogL0XhShgzuEG6m0
 C32g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748427085; x=1749031885;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cJd5IBROJghzscxB4JST6ulgIsBYUzq/fl2PTxV2iI4=;
 b=G2iJ3/hr2k01EaQwwbUabF/khJPaAU8UeaJyBg7miJXLpn7U1EnoTYtYU0bwEexEoP
 pi/IN8kJuIlTthZYXh/r9BDmBkZMwRt4Of+TfDlR+ntbSXJfrXAcncNjhjwzsE/zkjWO
 G8KzdIrpLQCBGYUON8C6Imvb83+KHBt5sPiIxyz+w3yRIn6F/kYV6HxWxSXPXUZJDwom
 DVXPoho9U6TIo76NOoIoWGJT+bwfP68Cz7YlhkxAEmtlxvC96S9NP1HjUexjZESI9ni/
 wKzRmwSb03wSjf4CKFZW3BOd8Xcpu1TEYp3yd45GxSuYSMjZ+K17XmweqJ0W9hMO/F/+
 J8kA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsFxiEBCORtKQ4EU4+1mI9NcWjD0XiwYlSzuDnqRHIPyYHV7Ad0VKPnfceJ9v+S1IGYt/P3Ba2@dpdk.org,
 AJvYcCUt3VWA4zAVM9S9jFdypbIIZ6sJWGXX0eVuwGHQ+/y5dH0+DkfJCRCQjpwvaeEqduQAVAI=@dpdk.org
X-Gm-Message-State: AOJu0YyNp4sXo2TpMRE2RI6wegOWCTVKeDbyKdJ36AmoKg4hfYiyTgwQ
 /Rp4hu/WE+lqnAjtgkuqM0mfv8AAD2T933QFI72U44mTLg5QSZXofM3WA2tTbfAsmU4HEYouiR3
 +3ClprESxrlMP7XMBL0g86x/fD0kKLzriGA==
X-Gm-Gg: ASbGnctpLcGxQJmRvt1u/2pPkNntF5pYnIbRJq1+/5R+EISJvHG+giTDoE/F07J7o0/
 D94wGxN6z85AadByB0AU47763TpM9aP1oifgMbV55MME/BrdNLMMXiRLB5GFCME+EyNwNaSU19c
 Lp4hgfF5cW8nP0IRptVNICqX2C1NyY3jKa
X-Google-Smtp-Source: AGHT+IHnuP1sIXe3t+H31Tcc09kBO26roof+QjAmMeuUi3pXaZttbEoeKd+C1TkfeBD7PyxiLI8eYy9vJaMfROFs+uk=
X-Received: by 2002:a05:622a:996:b0:494:9d34:fca5 with SMTP id
 d75a77b69052e-4a2f51fdf4bmr66191521cf.13.1748427074076; Wed, 28 May 2025
 03:11:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250409061152.1096849-1-skori@marvell.com>
 <20250528062104.974392-1-skori@marvell.com>
In-Reply-To: <20250528062104.974392-1-skori@marvell.com>
From: Nithin Dabilpuram <nithind1988@gmail.com>
Date: Wed, 28 May 2025 15:40:56 +0530
X-Gm-Features: AX0GCFsA51RNvqV_cJFlZEtTIajFB4GLhkqFPcL9MA58cdpgpNRu_mP-EPT0m7k
Message-ID: <CAMuDWKQu5o1V36AFBZV0J-DEgPueddq_Ge0HESkjPtWQc9CWNA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] net/cnxk: mark invalid MAC address if it doesn't
 exist
To: skori@marvell.com
Cc: Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>, 
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>,
 dev@dpdk.org, stable@dpdk.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Acked-by: Nithin Dabilpuram<ndabilpuram@marvell.com>

On Wed, May 28, 2025 at 11:51=E2=80=AFAM <skori@marvell.com> wrote:
>
> From: Sunil Kumar Kori <skori@marvell.com>
>
> When user requests to configure a device which is already in
> configured state then first device gets resets to default and
> then reconfigured with latest parameters.
>
> While resetting the device, MAC address table is left stale which
> causes entry update in later state.
>
> Hence marking the MAC address entries as invalid to avoid any error
> due to further operation on MAC table.
>
> Fixes: b75e0aca84b0 ("net/cnxk: add device configuration operation")
> Cc: stable@dpdk.org
>
> Signed-off-by: Sunil Kumar Kori <skori@marvell.com>
> Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
> ---
> v1..v2:
> - Instead of restoring the MAC addresses, reset to them as invalid
>   during restore process.
>
>  drivers/net/cnxk/cnxk_ethdev.c     | 26 ++++++++++++--
>  drivers/net/cnxk/cnxk_ethdev.h     |  3 ++
>  drivers/net/cnxk/cnxk_ethdev_ops.c | 57 ++++++++++++++++++++++++++++--
>  3 files changed, 81 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/cnxk/cnxk_ethdev.c b/drivers/net/cnxk/cnxk_ethde=
v.c
> index b9a0b37425..64d7937be6 100644
> --- a/drivers/net/cnxk/cnxk_ethdev.c
> +++ b/drivers/net/cnxk/cnxk_ethdev.c
> @@ -1230,8 +1230,8 @@ cnxk_nix_configure(struct rte_eth_dev *eth_dev)
>         uint16_t nb_rxq, nb_txq, nb_cq;
>         struct rte_ether_addr *ea;
>         uint64_t rx_cfg;
> +       int rc, i;
>         void *qs;
> -       int rc;
>
>         rc =3D -EINVAL;
>
> @@ -1286,6 +1286,12 @@ cnxk_nix_configure(struct rte_eth_dev *eth_dev)
>                 roc_nix_tm_fini(nix);
>                 nix_rxchan_cfg_disable(dev);
>                 roc_nix_lf_free(nix);
> +
> +               /* Reset to invalid */
> +               for (i =3D 0; i < dev->max_mac_entries; i++)
> +                       dev->dmac_idx_map[i] =3D CNXK_NIX_DMAC_IDX_INVALI=
D;
> +
> +               dev->dmac_filter_count =3D 1;
>         }
>
>         dev->rx_offloads =3D rxmode->offloads;
> @@ -1891,7 +1897,7 @@ cnxk_eth_dev_init(struct rte_eth_dev *eth_dev)
>         struct rte_security_ctx *sec_ctx;
>         struct roc_nix *nix =3D &dev->nix;
>         struct rte_pci_device *pci_dev;
> -       int rc, max_entries;
> +       int rc, max_entries, i;
>
>         eth_dev->dev_ops =3D &cnxk_eth_dev_ops;
>         eth_dev->rx_queue_count =3D cnxk_nix_rx_queue_count;
> @@ -1993,6 +1999,17 @@ cnxk_eth_dev_init(struct rte_eth_dev *eth_dev)
>                 goto free_mac_addrs;
>         }
>
> +       dev->dmac_addrs =3D rte_malloc("dmac_addrs", max_entries * RTE_ET=
HER_ADDR_LEN, 0);
> +       if (dev->dmac_addrs =3D=3D NULL) {
> +               plt_err("Failed to allocate memory for dmac addresses");
> +               rc =3D -ENOMEM;
> +               goto free_mac_addrs;
> +       }
> +
> +       /* Reset to invalid */
> +       for (i =3D 0; i < max_entries; i++)
> +               dev->dmac_idx_map[i] =3D CNXK_NIX_DMAC_IDX_INVALID;
> +
>         dev->max_mac_entries =3D max_entries;
>         dev->dmac_filter_count =3D 1;
>
> @@ -2051,6 +2068,8 @@ cnxk_eth_dev_init(struct rte_eth_dev *eth_dev)
>
>  free_mac_addrs:
>         rte_free(eth_dev->data->mac_addrs);
> +       rte_free(dev->dmac_addrs);
> +       dev->dmac_addrs =3D NULL;
>         rte_free(dev->dmac_idx_map);
>  dev_fini:
>         roc_nix_dev_fini(nix);
> @@ -2182,6 +2201,9 @@ cnxk_eth_dev_uninit(struct rte_eth_dev *eth_dev, bo=
ol reset)
>         rte_free(dev->dmac_idx_map);
>         dev->dmac_idx_map =3D NULL;
>
> +       rte_free(dev->dmac_addrs);
> +       dev->dmac_addrs =3D NULL;
> +
>         rte_free(eth_dev->data->mac_addrs);
>         eth_dev->data->mac_addrs =3D NULL;
>
> diff --git a/drivers/net/cnxk/cnxk_ethdev.h b/drivers/net/cnxk/cnxk_ethde=
v.h
> index d62cc1ec20..1ced6dd65e 100644
> --- a/drivers/net/cnxk/cnxk_ethdev.h
> +++ b/drivers/net/cnxk/cnxk_ethdev.h
> @@ -106,6 +106,8 @@
>  /* Fastpath lookup */
>  #define CNXK_NIX_FASTPATH_LOOKUP_MEM "cnxk_nix_fastpath_lookup_mem"
>
> +#define CNXK_NIX_DMAC_IDX_INVALID -1
> +
>  struct cnxk_fc_cfg {
>         enum rte_eth_fc_mode mode;
>         uint8_t rx_pause;
> @@ -342,6 +344,7 @@ struct cnxk_eth_dev {
>         uint8_t max_mac_entries;
>         bool dmac_filter_enable;
>         int *dmac_idx_map;
> +       struct rte_ether_addr *dmac_addrs;
>
>         uint16_t flags;
>         uint8_t ptype_disable;
> diff --git a/drivers/net/cnxk/cnxk_ethdev_ops.c b/drivers/net/cnxk/cnxk_e=
thdev_ops.c
> index 9970c5ff5c..abef1a9eaf 100644
> --- a/drivers/net/cnxk/cnxk_ethdev_ops.c
> +++ b/drivers/net/cnxk/cnxk_ethdev_ops.c
> @@ -473,11 +473,20 @@ cnxk_nix_mac_addr_add(struct rte_eth_dev *eth_dev, =
struct rte_ether_addr *addr,
>  {
>         struct cnxk_eth_dev *dev =3D cnxk_eth_pmd_priv(eth_dev);
>         struct roc_nix *nix =3D &dev->nix;
> +       struct rte_ether_addr *current;
>         int rc;
>
> -       PLT_SET_USED(index);
>         PLT_SET_USED(pool);
>
> +       if (dev->dmac_idx_map[index] !=3D CNXK_NIX_DMAC_IDX_INVALID) {
> +               current =3D &dev->dmac_addrs[index];
> +               plt_nix_dbg("Mac address %02x:%02x:%02x:%02x:%02x:%02x al=
ready exists at index %u",
> +                           current->addr_bytes[0], current->addr_bytes[1=
], current->addr_bytes[2],
> +                           current->addr_bytes[3], current->addr_bytes[4=
], current->addr_bytes[5],
> +                           index);
> +               return 0;
> +       }
> +
>         rc =3D roc_nix_mac_addr_add(nix, addr->addr_bytes);
>         if (rc < 0) {
>                 plt_err("Failed to add mac address, rc=3D%d", rc);
> @@ -485,6 +494,11 @@ cnxk_nix_mac_addr_add(struct rte_eth_dev *eth_dev, s=
truct rte_ether_addr *addr,
>         }
>
>         dev->dmac_idx_map[index] =3D rc;
> +       plt_nix_dbg("Added mac address %02x:%02x:%02x:%02x:%02x:%02x at i=
ndex %u(%d)",
> +                   addr->addr_bytes[0], addr->addr_bytes[1], addr->addr_=
bytes[2],
> +                   addr->addr_bytes[3], addr->addr_bytes[4], addr->addr_=
bytes[5], index, rc);
> +
> +       memcpy(&dev->dmac_addrs[index], addr, RTE_ETHER_ADDR_LEN);
>
>         /* Enable promiscuous mode at NIX level */
>         roc_nix_npc_promisc_ena_dis(nix, true);
> @@ -506,6 +520,8 @@ cnxk_nix_mac_addr_del(struct rte_eth_dev *eth_dev, ui=
nt32_t index)
>         if (rc)
>                 plt_err("Failed to delete mac address, rc=3D%d", rc);
>
> +       plt_nix_dbg("Deleted mac address at index %u(%d)", index, dev->dm=
ac_idx_map[index]);
> +       dev->dmac_idx_map[index] =3D CNXK_NIX_DMAC_IDX_INVALID;
>         dev->dmac_filter_count--;
>  }
>
> @@ -1117,6 +1133,23 @@ cnxk_nix_rss_hash_conf_get(struct rte_eth_dev *eth=
_dev,
>         return 0;
>  }
>
> +static int
> +nix_find_mac_addr(struct rte_eth_dev *eth_dev, struct rte_ether_addr *ad=
dr)
> +{
> +       struct cnxk_eth_dev *dev =3D cnxk_eth_pmd_priv(eth_dev);
> +       struct rte_ether_addr null_mac_addr;
> +       int i;
> +
> +       memset(&null_mac_addr, 0, sizeof(null_mac_addr));
> +       addr =3D addr ? addr : &null_mac_addr;
> +       for (i =3D 0; i < dev->max_mac_entries; i++) {
> +               if (!memcmp(&eth_dev->data->mac_addrs[i], addr, sizeof(*a=
ddr)))
> +                       return i;
> +       }
> +
> +       return -ENOENT;
> +}
> +
>  static inline int
>  nix_mc_addr_list_flush(struct rte_eth_dev *eth_dev)
>  {
> @@ -1138,6 +1171,9 @@ nix_mc_addr_list_flush(struct rte_eth_dev *eth_dev)
>                                 return rc;
>                         }
>
> +                       plt_nix_dbg("Deleted mac address at index %u(%d)"=
, i, dev->dmac_idx_map[i]);
> +
> +                       dev->dmac_idx_map[i] =3D CNXK_NIX_DMAC_IDX_INVALI=
D;
>                         dev->dmac_filter_count--;
>                         /* Update address in NIC data structure */
>                         rte_ether_addr_copy(&null_mac_addr,
> @@ -1155,7 +1191,7 @@ cnxk_nix_mc_addr_list_configure(struct rte_eth_dev =
*eth_dev, struct rte_ether_ad
>         struct cnxk_eth_dev *dev =3D cnxk_eth_pmd_priv(eth_dev);
>         struct rte_eth_dev_data *data =3D eth_dev->data;
>         struct roc_nix *nix =3D &dev->nix;
> -       int index, mc_addr_cnt =3D 0;
> +       int index, mc_addr_cnt =3D 0, j;
>         uint32_t i;
>
>         if (!mc_addr_set || !nb_mc_addr)
> @@ -1174,8 +1210,15 @@ cnxk_nix_mc_addr_list_configure(struct rte_eth_dev=
 *eth_dev, struct rte_ether_ad
>         }
>         nix_mc_addr_list_flush(eth_dev);
>
> +       j =3D 0;
>         /* Multicast addresses are to be installed */
>         for (i =3D 0; i < nb_mc_addr; i++) {
> +               j =3D nix_find_mac_addr(eth_dev, NULL);
> +               if (j < 0) {
> +                       plt_err("Failed to find free mac address");
> +                       return -ENOSPC;
> +               }
> +
>                 index =3D roc_nix_mac_addr_add(nix, mc_addr_set[i].addr_b=
ytes);
>                 if (index < 0) {
>                         plt_err("Failed to add mcast mac address, rc=3D%d=
",
> @@ -1183,9 +1226,17 @@ cnxk_nix_mc_addr_list_configure(struct rte_eth_dev=
 *eth_dev, struct rte_ether_ad
>                         return index;
>                 }
>
> +               dev->dmac_idx_map[j] =3D index;
> +               plt_nix_dbg("Added mac address %02x:%02x:%02x:%02x:%02x:%=
02x at index %u(%d)",
> +                           mc_addr_set[i].addr_bytes[0], mc_addr_set[i].=
addr_bytes[1],
> +                           mc_addr_set[i].addr_bytes[2], mc_addr_set[i].=
addr_bytes[3],
> +                           mc_addr_set[i].addr_bytes[4], mc_addr_set[i].=
addr_bytes[5], j, index);
> +
>                 dev->dmac_filter_count++;
>                 /* Update address in NIC data structure */
> -               rte_ether_addr_copy(&mc_addr_set[i], &data->mac_addrs[ind=
ex]);
> +               rte_ether_addr_copy(&mc_addr_set[i], &data->mac_addrs[j])=
;
> +               rte_ether_addr_copy(&mc_addr_set[i], &dev->dmac_addrs[j])=
;
> +               data->mac_pool_sel[j] =3D RTE_BIT64(0);
>         }
>
>         roc_nix_npc_promisc_ena_dis(nix, true);
> --
> 2.43.0
>
