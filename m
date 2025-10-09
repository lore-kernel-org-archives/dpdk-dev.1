Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A6D0CCD183
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 19:01:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3136140297;
	Thu,  9 Oct 2025 21:01:38 +0200 (CEST)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com
 [209.85.218.47]) by mails.dpdk.org (Postfix) with ESMTP id 07D144027A
 for <dev@dpdk.org>; Thu,  9 Oct 2025 21:01:37 +0200 (CEST)
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-b3e7cc84b82so253356766b.0
 for <dev@dpdk.org>; Thu, 09 Oct 2025 12:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=atomicrules-com.20230601.gappssmtp.com; s=20230601; t=1760036496;
 x=1760641296; darn=dpdk.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XZrzYSKABj7FV79wEH2X3hyKN8A7qzS/E0wh+olIJRM=;
 b=ua4wl63eV8Jcw55cGEuB+E+uY+o+ArJ0gRcr4BG4HXBPT11QgAbcjhHbiRpiQqRPY6
 6UZw/POH/GGSqUjMimYQY0fLJsBHEOYi/xGM96ne78WCY5fosV6XLnOKy3JN6V5po5iY
 +2DvHVP0SPU5QFGW2vBAUhYPea6stbYjX/AGS1Chv8dRN9lGwS7ZxgG+peqlgf6NCZUA
 ik5vght6jmW81E//iYpjUpNhfzsgCMZm0gW9DvlI1CSzE/p+qCYH9v7waEBF1cK/cnQd
 Y64BhSPVdIYtsFzG82dIQqm583girr3Q3GGxGa2DIWX06gKJxJws/i7zBWlnKXFiiQnC
 iS6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760036496; x=1760641296;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XZrzYSKABj7FV79wEH2X3hyKN8A7qzS/E0wh+olIJRM=;
 b=IaMnl29OeSJOY29+F5Pm8Ff1oiGbqJIIfy9xWnbpbkHsUztzKohItdU/fMl2Fysljb
 4f5ytwc2fBKAgdJBe0ZMarFyLpJ0D/kdrmDg4IJBXByYAqjsG5do4xwK6Zb7ctRfU2bz
 QjwxBk81+R8pH/0IHxCxG5V2aJTYXNWwMFJpIUUawwkrbItnPbuVGux+7Ca2OENITX2+
 +GW0Ao/wunDPveiX99e46r8VEGMTAKTv7yGdjAA6xVnn8OhmAlAnwQND2VKz7XzKXogE
 IvGnY2zjAtc0ntojcOEKvc+x2xAlA6iNkgqEwJPRaIEn6ONb0CqA9/U4GcYp32xohcaK
 ykaQ==
X-Gm-Message-State: AOJu0YzS1ltFcP1FBZao4v5qZ3XUPQtVlXlQOeD50oxVWeiMQVmRv5Xe
 BsXLqtCgq2B2ptQgv9G1S7iysuO/Qw3BjW1xJBu1wID+pAqjn0w8Q5msqqnL/CTp6soo3wzZPYZ
 fJ+/HQ3yaEKEAsOPO673457MfkW5ICCCQU+FiiCRZ4fnHMTA0uVI=
X-Gm-Gg: ASbGncvcJZ+RR6SlaJIUSHyMl+JuAGbVP+YHeT1c1mxo/EFuqATvZgocCu+fCmhlrdJ
 0wI/7vfKsJ1v+TTXaDw+qLc4QFuy/Mqig19m0RyvGp7J57hSixjTBzqp+iotJr2GyAJhbJMyRBf
 qL7pf0owNwv9aMYPkrSszW4fG8J8WNpOgStzejaTS10oXWEoAq97EGIQ8/72tXAoRonB0bRkQvH
 zJtFi2hCkjXD6usMmgBhpqJpe1/Z4Aa
X-Google-Smtp-Source: AGHT+IEURAQF7y05vZtvOVisKys/IyClHbw2lW5zDhDQr+SkUeb7SBCvBl1iKP35xHF1q9iMALWeVDmv2Sw5duHAAd8=
X-Received: by 2002:a17:907:1b12:b0:b3d:73e1:d809 with SMTP id
 a640c23a62f3a-b50ac5d0201mr964097566b.48.1760036495526; Thu, 09 Oct 2025
 12:01:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250926163519.430680-1-stephen@networkplumber.org>
In-Reply-To: <20250926163519.430680-1-stephen@networkplumber.org>
From: Ed Czeck <ed.czeck@atomicrules.com>
Date: Thu, 9 Oct 2025 15:01:24 -0400
X-Gm-Features: AS18NWC2nxbph6xgEQmtW-1lH-k3TgFqCZx8aYUgEeg4hO7SluPUia9R3oe0DjQ
Message-ID: <CALZ3GuhV1c2QNGxaZW7iWC8H5hx5PhRvkjH0n6Ets2oeJBjDeg@mail.gmail.com>
Subject: Re: [RFC] net/ark: use ark_ prefix on on global variables
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Shepard Siegel <shepard.siegel@atomicrules.com>, 
 John Miller <john.miller@atomicrules.com>
Content-Type: multipart/alternative; boundary="0000000000001b9c210640be6e62"
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

--0000000000001b9c210640be6e62
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Acked-by:Ed Czeck <ed.czeck@atomicrules.com>

On Fri, Sep 26, 2025 at 12:35=E2=80=AFPM Stephen Hemminger <
stephen@networkplumber.org> wrote:
>
> Rather than eth_ark_XXX use ark_XXX as prefix on all visible
> global variables. This makes device consistent with other PMD's.
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  drivers/net/ark/ark_ethdev.c    | 154 ++++++++++++++++----------------
>  drivers/net/ark/ark_ethdev_rx.c |  50 +++++------
>  drivers/net/ark/ark_ethdev_rx.h |  18 ++--
>  drivers/net/ark/ark_ethdev_tx.c |  32 +++----
>  drivers/net/ark/ark_ethdev_tx.h |  14 +--
>  5 files changed, 134 insertions(+), 134 deletions(-)
>
> diff --git a/drivers/net/ark/ark_ethdev.c b/drivers/net/ark/ark_ethdev.c
> index 8d3c0a1b02..04a15d006f 100644
> --- a/drivers/net/ark/ark_ethdev.c
> +++ b/drivers/net/ark/ark_ethdev.c
> @@ -22,32 +22,32 @@
>  #include "ark_pktchkr.h"
>
>  /*  Internal prototypes */
> -static int eth_ark_check_args(struct ark_adapter *ark, const char
*params);
> -static int eth_ark_dev_init(struct rte_eth_dev *dev);
> +static int ark_check_args(struct ark_adapter *ark, const char *params);
> +static int ark_dev_init(struct rte_eth_dev *dev);
>  static int ark_config_device(struct rte_eth_dev *dev);
> -static int eth_ark_dev_uninit(struct rte_eth_dev *eth_dev);
> -static int eth_ark_dev_configure(struct rte_eth_dev *dev);
> -static int eth_ark_dev_start(struct rte_eth_dev *dev);
> -static int eth_ark_dev_stop(struct rte_eth_dev *dev);
> -static int eth_ark_dev_close(struct rte_eth_dev *dev);
> -static int eth_ark_dev_info_get(struct rte_eth_dev *dev,
> +static int ark_dev_uninit(struct rte_eth_dev *eth_dev);
> +static int ark_dev_configure(struct rte_eth_dev *dev);
> +static int ark_dev_start(struct rte_eth_dev *dev);
> +static int ark_dev_stop(struct rte_eth_dev *dev);
> +static int ark_dev_close(struct rte_eth_dev *dev);
> +static int ark_dev_info_get(struct rte_eth_dev *dev,
>                                 struct rte_eth_dev_info *dev_info);
> -static int eth_ark_dev_link_update(struct rte_eth_dev *dev,
> +static int ark_dev_link_update(struct rte_eth_dev *dev,
>                                    int wait_to_complete);
> -static int eth_ark_dev_set_link_up(struct rte_eth_dev *dev);
> -static int eth_ark_dev_set_link_down(struct rte_eth_dev *dev);
> -static int eth_ark_dev_stats_get(struct rte_eth_dev *dev,
> +static int ark_dev_set_link_up(struct rte_eth_dev *dev);
> +static int ark_dev_set_link_down(struct rte_eth_dev *dev);
> +static int ark_dev_stats_get(struct rte_eth_dev *dev,
>                                   struct rte_eth_stats *stats);
> -static int eth_ark_dev_stats_reset(struct rte_eth_dev *dev);
> -static int eth_ark_set_default_mac_addr(struct rte_eth_dev *dev,
> +static int ark_dev_stats_reset(struct rte_eth_dev *dev);
> +static int ark_set_default_mac_addr(struct rte_eth_dev *dev,
>                                          struct rte_ether_addr *mac_addr)=
;
> -static int eth_ark_macaddr_add(struct rte_eth_dev *dev,
> +static int ark_macaddr_add(struct rte_eth_dev *dev,
>                                struct rte_ether_addr *mac_addr,
>                                uint32_t index,
>                                uint32_t pool);
> -static void eth_ark_macaddr_remove(struct rte_eth_dev *dev,
> +static void ark_macaddr_remove(struct rte_eth_dev *dev,
>                                    uint32_t index);
> -static int  eth_ark_set_mtu(struct rte_eth_dev *dev, uint16_t size);
> +static int  ark_set_mtu(struct rte_eth_dev *dev, uint16_t size);
>
>  /*
>   * The packet generator is a functional block used to generate packet
> @@ -145,7 +145,7 @@ ark_device_caps[] =3D {
>  };
>
>  static int
> -eth_ark_pci_probe(struct rte_pci_driver *pci_drv __rte_unused,
> +ark_pci_probe(struct rte_pci_driver *pci_drv __rte_unused,
>                 struct rte_pci_device *pci_dev)
>  {
>         struct rte_eth_dev *eth_dev;
> @@ -156,7 +156,7 @@ eth_ark_pci_probe(struct rte_pci_driver *pci_drv
__rte_unused,
>         if (eth_dev =3D=3D NULL)
>                 return -ENOMEM;
>
> -       ret =3D eth_ark_dev_init(eth_dev);
> +       ret =3D ark_dev_init(eth_dev);
>         if (ret)
>                 rte_eth_dev_release_port(eth_dev);
>
> @@ -164,47 +164,47 @@ eth_ark_pci_probe(struct rte_pci_driver *pci_drv
__rte_unused,
>  }
>
>  static int
> -eth_ark_pci_remove(struct rte_pci_device *pci_dev)
> +ark_pci_remove(struct rte_pci_device *pci_dev)
>  {
> -       return rte_eth_dev_pci_generic_remove(pci_dev,
eth_ark_dev_uninit);
> +       return rte_eth_dev_pci_generic_remove(pci_dev, ark_dev_uninit);
>  }
>
>  static struct rte_pci_driver rte_ark_pmd =3D {
>         .id_table =3D pci_id_ark_map,
>         .drv_flags =3D RTE_PCI_DRV_NEED_MAPPING | RTE_PCI_DRV_INTR_LSC,
> -       .probe =3D eth_ark_pci_probe,
> -       .remove =3D eth_ark_pci_remove,
> +       .probe =3D ark_pci_probe,
> +       .remove =3D ark_pci_remove,
>  };
>
>  static const struct eth_dev_ops ark_eth_dev_ops =3D {
> -       .dev_configure =3D eth_ark_dev_configure,
> -       .dev_start =3D eth_ark_dev_start,
> -       .dev_stop =3D eth_ark_dev_stop,
> -       .dev_close =3D eth_ark_dev_close,
> +       .dev_configure =3D ark_dev_configure,
> +       .dev_start =3D ark_dev_start,
> +       .dev_stop =3D ark_dev_stop,
> +       .dev_close =3D ark_dev_close,
>
> -       .dev_infos_get =3D eth_ark_dev_info_get,
> +       .dev_infos_get =3D ark_dev_info_get,
>
> -       .rx_queue_setup =3D eth_ark_dev_rx_queue_setup,
> -       .tx_queue_setup =3D eth_ark_tx_queue_setup,
> +       .rx_queue_setup =3D ark_dev_rx_queue_setup,
> +       .tx_queue_setup =3D ark_tx_queue_setup,
>
> -       .link_update =3D eth_ark_dev_link_update,
> -       .dev_set_link_up =3D eth_ark_dev_set_link_up,
> -       .dev_set_link_down =3D eth_ark_dev_set_link_down,
> +       .link_update =3D ark_dev_link_update,
> +       .dev_set_link_up =3D ark_dev_set_link_up,
> +       .dev_set_link_down =3D ark_dev_set_link_down,
>
> -       .rx_queue_start =3D eth_ark_rx_start_queue,
> -       .rx_queue_stop =3D eth_ark_rx_stop_queue,
> +       .rx_queue_start =3D ark_rx_start_queue,
> +       .rx_queue_stop =3D ark_rx_stop_queue,
>
> -       .tx_queue_start =3D eth_ark_tx_queue_start,
> -       .tx_queue_stop =3D eth_ark_tx_queue_stop,
> +       .tx_queue_start =3D ark_tx_queue_start,
> +       .tx_queue_stop =3D ark_tx_queue_stop,
>
> -       .stats_get =3D eth_ark_dev_stats_get,
> -       .stats_reset =3D eth_ark_dev_stats_reset,
> +       .stats_get =3D ark_dev_stats_get,
> +       .stats_reset =3D ark_dev_stats_reset,
>
> -       .mac_addr_add =3D eth_ark_macaddr_add,
> -       .mac_addr_remove =3D eth_ark_macaddr_remove,
> -       .mac_addr_set =3D eth_ark_set_default_mac_addr,
> +       .mac_addr_add =3D ark_macaddr_add,
> +       .mac_addr_remove =3D ark_macaddr_remove,
> +       .mac_addr_set =3D ark_set_default_mac_addr,
>
> -       .mtu_set =3D eth_ark_set_mtu,
> +       .mtu_set =3D ark_set_mtu,
>  };
>
>  static int
> @@ -297,7 +297,7 @@ check_for_ext(struct ark_adapter *ark)
>  }
>
>  static int
> -eth_ark_dev_init(struct rte_eth_dev *dev)
> +ark_dev_init(struct rte_eth_dev *dev)
>  {
>         struct ark_adapter *ark =3D dev->data->dev_private;
>         struct rte_pci_device *pci_dev;
> @@ -376,7 +376,7 @@ eth_ark_dev_init(struct rte_eth_dev *dev)
>                 return -1;
>
>         dev->dev_ops =3D &ark_eth_dev_ops;
> -       dev->rx_queue_count =3D eth_ark_dev_rx_queue_count;
> +       dev->rx_queue_count =3D ark_dev_rx_queue_count;
>
>         dev->data->mac_addrs =3D rte_zmalloc("ark", RTE_ETHER_ADDR_LEN, 0=
);
>         if (!dev->data->mac_addrs) {
> @@ -398,7 +398,7 @@ eth_ark_dev_init(struct rte_eth_dev *dev)
>         }
>
>         if (pci_dev->device.devargs)
> -               ret =3D eth_ark_check_args(ark,
pci_dev->device.devargs->args);
> +               ret =3D ark_check_args(ark, pci_dev->device.devargs->args=
);
>         else
>                 ARK_PMD_LOG(INFO, "No Device args found\n");
>
> @@ -539,7 +539,7 @@ ark_config_device(struct rte_eth_dev *dev)
>  }
>
>  static int
> -eth_ark_dev_uninit(struct rte_eth_dev *dev)
> +ark_dev_uninit(struct rte_eth_dev *dev)
>  {
>         struct ark_adapter *ark =3D dev->data->dev_private;
>
> @@ -559,11 +559,11 @@ eth_ark_dev_uninit(struct rte_eth_dev *dev)
>  }
>
>  static int
> -eth_ark_dev_configure(struct rte_eth_dev *dev)
> +ark_dev_configure(struct rte_eth_dev *dev)
>  {
>         struct ark_adapter *ark =3D dev->data->dev_private;
>
> -       eth_ark_dev_set_link_up(dev);
> +       ark_dev_set_link_up(dev);
>         if (ark->user_ext.dev_configure)
>                 return ark->user_ext.dev_configure(dev,
>                            ark->user_data[dev->data->port_id]);
> @@ -571,23 +571,23 @@ eth_ark_dev_configure(struct rte_eth_dev *dev)
>  }
>
>  static int
> -eth_ark_dev_start(struct rte_eth_dev *dev)
> +ark_dev_start(struct rte_eth_dev *dev)
>  {
>         struct ark_adapter *ark =3D dev->data->dev_private;
>         int i;
>
>         /* RX Side */
>         for (i =3D 0; i < dev->data->nb_rx_queues; i++)
> -               eth_ark_rx_start_queue(dev, i);
> +               ark_rx_start_queue(dev, i);
>
>         /* TX Side */
>         for (i =3D 0; i < dev->data->nb_tx_queues; i++)
> -               eth_ark_tx_queue_start(dev, i);
> +               ark_tx_queue_start(dev, i);
>
>         ark->started =3D 1;
>         /* set xmit and receive function */
> -       dev->rx_pkt_burst =3D &eth_ark_recv_pkts;
> -       dev->tx_pkt_burst =3D &eth_ark_xmit_pkts;
> +       dev->rx_pkt_burst =3D &ark_recv_pkts;
> +       dev->tx_pkt_burst =3D &ark_xmit_pkts;
>
>         if (!ark->isvf && ark->start_pg)
>                 ark_pktchkr_run(ark->pc);
> @@ -618,7 +618,7 @@ eth_ark_dev_start(struct rte_eth_dev *dev)
>  }
>
>  static int
> -eth_ark_dev_stop(struct rte_eth_dev *dev)
> +ark_dev_stop(struct rte_eth_dev *dev)
>  {
>         uint16_t i;
>         int status;
> @@ -645,11 +645,11 @@ eth_ark_dev_stop(struct rte_eth_dev *dev)
>
>         /* Stop RX Side */
>         for (i =3D 0; i < dev->data->nb_rx_queues; i++)
> -               eth_ark_rx_stop_queue(dev, i);
> +               ark_rx_stop_queue(dev, i);
>
>         /* STOP TX Side */
>         for (i =3D 0; i < dev->data->nb_tx_queues; i++) {
> -               status =3D eth_ark_tx_queue_stop(dev, i);
> +               status =3D ark_tx_queue_stop(dev, i);
>                 if (status !=3D 0) {
>                         uint16_t port =3D dev->data->port_id;
>                         ARK_PMD_LOG(ERR,
> @@ -662,7 +662,7 @@ eth_ark_dev_stop(struct rte_eth_dev *dev)
>         ark_udm_dump_stats(ark->udm.v, "Post stop");
>
>         for (i =3D 0; i < dev->data->nb_rx_queues; i++)
> -               eth_ark_rx_dump_queue(dev, i, __func__);
> +               ark_rx_dump_queue(dev, i, __func__);
>
>         /* Stop the packet checker if it is running */
>         if (!ark->isvf && ark->start_pg) {
> @@ -674,7 +674,7 @@ eth_ark_dev_stop(struct rte_eth_dev *dev)
>  }
>
>  static int
> -eth_ark_dev_close(struct rte_eth_dev *dev)
> +ark_dev_close(struct rte_eth_dev *dev)
>  {
>         struct ark_adapter *ark =3D dev->data->dev_private;
>         uint16_t i;
> @@ -686,7 +686,7 @@ eth_ark_dev_close(struct rte_eth_dev *dev)
>                 ark->user_ext.dev_close(dev,
>                  ark->user_data[dev->data->port_id]);
>
> -       eth_ark_dev_stop(dev);
> +       ark_dev_stop(dev);
>
>         /*
>          * This should only be called once for the device during shutdown
> @@ -696,12 +696,12 @@ eth_ark_dev_close(struct rte_eth_dev *dev)
>                 ark_pktdir_setup(ark->pd, ARK_PKT_DIR_INIT_VAL);
>
>         for (i =3D 0; i < dev->data->nb_tx_queues; i++) {
> -               eth_ark_tx_queue_release(dev->data->tx_queues[i]);
> +               ark_tx_queue_release(dev->data->tx_queues[i]);
>                 dev->data->tx_queues[i] =3D 0;
>         }
>
>         for (i =3D 0; i < dev->data->nb_rx_queues; i++) {
> -               eth_ark_dev_rx_queue_release(dev->data->rx_queues[i]);
> +               ark_dev_rx_queue_release(dev->data->rx_queues[i]);
>                 dev->data->rx_queues[i] =3D 0;
>         }
>
> @@ -709,7 +709,7 @@ eth_ark_dev_close(struct rte_eth_dev *dev)
>  }
>
>  static int
> -eth_ark_dev_info_get(struct rte_eth_dev *dev,
> +ark_dev_info_get(struct rte_eth_dev *dev,
>                      struct rte_eth_dev_info *dev_info)
>  {
>         struct ark_adapter *ark =3D dev->data->dev_private;
> @@ -749,7 +749,7 @@ eth_ark_dev_info_get(struct rte_eth_dev *dev,
>  }
>
>  static int
> -eth_ark_dev_link_update(struct rte_eth_dev *dev, int wait_to_complete)
> +ark_dev_link_update(struct rte_eth_dev *dev, int wait_to_complete)
>  {
>         ARK_PMD_LOG(DEBUG, "link status =3D %d\n",
>                         dev->data->dev_link.link_status);
> @@ -764,7 +764,7 @@ eth_ark_dev_link_update(struct rte_eth_dev *dev, int
wait_to_complete)
>  }
>
>  static int
> -eth_ark_dev_set_link_up(struct rte_eth_dev *dev)
> +ark_dev_set_link_up(struct rte_eth_dev *dev)
>  {
>         dev->data->dev_link.link_status =3D 1;
>         struct ark_adapter *ark =3D dev->data->dev_private;
> @@ -776,7 +776,7 @@ eth_ark_dev_set_link_up(struct rte_eth_dev *dev)
>  }
>
>  static int
> -eth_ark_dev_set_link_down(struct rte_eth_dev *dev)
> +ark_dev_set_link_down(struct rte_eth_dev *dev)
>  {
>         dev->data->dev_link.link_status =3D 0;
>         struct ark_adapter *ark =3D dev->data->dev_private;
> @@ -788,7 +788,7 @@ eth_ark_dev_set_link_down(struct rte_eth_dev *dev)
>  }
>
>  static int
> -eth_ark_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats
*stats)
> +ark_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
>  {
>         uint16_t i;
>         struct ark_adapter *ark =3D dev->data->dev_private;
> @@ -801,9 +801,9 @@ eth_ark_dev_stats_get(struct rte_eth_dev *dev, struct
rte_eth_stats *stats)
>         stats->oerrors =3D 0;
>
>         for (i =3D 0; i < dev->data->nb_tx_queues; i++)
> -               eth_tx_queue_stats_get(dev->data->tx_queues[i], stats);
> +               ark_tx_queue_stats_get(dev->data->tx_queues[i], stats);
>         for (i =3D 0; i < dev->data->nb_rx_queues; i++)
> -               eth_rx_queue_stats_get(dev->data->rx_queues[i], stats);
> +               ark_rx_queue_stats_get(dev->data->rx_queues[i], stats);
>         if (ark->user_ext.stats_get)
>                 return ark->user_ext.stats_get(dev, stats,
>                         ark->user_data[dev->data->port_id]);
> @@ -811,15 +811,15 @@ eth_ark_dev_stats_get(struct rte_eth_dev *dev,
struct rte_eth_stats *stats)
>  }
>
>  static int
> -eth_ark_dev_stats_reset(struct rte_eth_dev *dev)
> +ark_dev_stats_reset(struct rte_eth_dev *dev)
>  {
>         uint16_t i;
>         struct ark_adapter *ark =3D dev->data->dev_private;
>
>         for (i =3D 0; i < dev->data->nb_tx_queues; i++)
> -               eth_tx_queue_stats_reset(dev->data->tx_queues[i]);
> +               ark_tx_queue_stats_reset(dev->data->tx_queues[i]);
>         for (i =3D 0; i < dev->data->nb_rx_queues; i++)
> -               eth_rx_queue_stats_reset(dev->data->rx_queues[i]);
> +               ark_rx_queue_stats_reset(dev->data->rx_queues[i]);
>         if (ark->user_ext.stats_reset)
>                 ark->user_ext.stats_reset(dev,
>                           ark->user_data[dev->data->port_id]);
> @@ -828,7 +828,7 @@ eth_ark_dev_stats_reset(struct rte_eth_dev *dev)
>  }
>
>  static int
> -eth_ark_macaddr_add(struct rte_eth_dev *dev,
> +ark_macaddr_add(struct rte_eth_dev *dev,
>                     struct rte_ether_addr *mac_addr,
>                     uint32_t index,
>                     uint32_t pool)
> @@ -847,7 +847,7 @@ eth_ark_macaddr_add(struct rte_eth_dev *dev,
>  }
>
>  static void
> -eth_ark_macaddr_remove(struct rte_eth_dev *dev, uint32_t index)
> +ark_macaddr_remove(struct rte_eth_dev *dev, uint32_t index)
>  {
>         struct ark_adapter *ark =3D dev->data->dev_private;
>
> @@ -857,7 +857,7 @@ eth_ark_macaddr_remove(struct rte_eth_dev *dev,
uint32_t index)
>  }
>
>  static int
> -eth_ark_set_default_mac_addr(struct rte_eth_dev *dev,
> +ark_set_default_mac_addr(struct rte_eth_dev *dev,
>                              struct rte_ether_addr *mac_addr)
>  {
>         struct ark_adapter *ark =3D dev->data->dev_private;
> @@ -871,7 +871,7 @@ eth_ark_set_default_mac_addr(struct rte_eth_dev *dev,
>  }
>
>  static int
> -eth_ark_set_mtu(struct rte_eth_dev *dev, uint16_t  size)
> +ark_set_mtu(struct rte_eth_dev *dev, uint16_t  size)
>  {
>         struct ark_adapter *ark =3D dev->data->dev_private;
>
> @@ -936,7 +936,7 @@ process_file_args(const char *key, const char *value,
void *extra_args)
>  }
>
>  static int
> -eth_ark_check_args(struct ark_adapter *ark, const char *params)
> +ark_check_args(struct ark_adapter *ark, const char *params)
>  {
>         struct rte_kvargs *kvlist;
>         unsigned int k_idx;
> diff --git a/drivers/net/ark/ark_ethdev_rx.c
b/drivers/net/ark/ark_ethdev_rx.c
> index 8b18d93eaa..f221137931 100644
> --- a/drivers/net/ark/ark_ethdev_rx.c
> +++ b/drivers/net/ark/ark_ethdev_rx.c
> @@ -22,11 +22,11 @@ struct ark_rx_meta;
>
>  static void dump_mbuf_data(struct rte_mbuf *mbuf, uint16_t lo, uint16_t
hi);
>  static void ark_ethdev_rx_dump(const char *name, struct ark_rx_queue
*queue);
> -static uint32_t eth_ark_rx_jumbo(struct ark_rx_queue *queue,
> +static uint32_t ark_rx_jumbo(struct ark_rx_queue *queue,
>                                  struct ark_rx_meta *meta,
>                                  struct rte_mbuf *mbuf0,
>                                  uint32_t cons_index);
> -static inline int eth_ark_rx_seed_mbufs(struct ark_rx_queue *queue);
> +static inline int ark_rx_seed_mbufs(struct ark_rx_queue *queue);
>
>  /*
************************************************************************* *=
/
>  struct __rte_cache_aligned ark_rx_queue {
> @@ -67,7 +67,7 @@ struct __rte_cache_aligned ark_rx_queue {
>
>  /*
************************************************************************* *=
/
>  static int
> -eth_ark_rx_hw_setup(struct rte_eth_dev *dev,
> +ark_rx_hw_setup(struct rte_eth_dev *dev,
>                     struct ark_rx_queue *queue,
>                     uint16_t rx_queue_idx)
>  {
> @@ -100,18 +100,18 @@ eth_ark_rx_hw_setup(struct rte_eth_dev *dev,
>  }
>
>  static inline void
> -eth_ark_rx_update_cons_index(struct ark_rx_queue *queue, uint32_t
cons_index)
> +ark_rx_update_cons_index(struct ark_rx_queue *queue, uint32_t cons_index=
)
>  {
>         queue->cons_index =3D cons_index;
>         if ((cons_index + queue->queue_size - queue->seed_index) >=3D
ARK_RX_MPU_CHUNK) {
> -               eth_ark_rx_seed_mbufs(queue);
> +               ark_rx_seed_mbufs(queue);
>                 ark_mpu_set_producer(queue->mpu, queue->seed_index);
>         }
>  }
>
>  /*
************************************************************************* *=
/
>  int
> -eth_ark_dev_rx_queue_setup(struct rte_eth_dev *dev,
> +ark_dev_rx_queue_setup(struct rte_eth_dev *dev,
>                            uint16_t queue_idx,
>                            uint16_t nb_desc,
>                            unsigned int socket_id,
> @@ -129,7 +129,7 @@ eth_ark_dev_rx_queue_setup(struct rte_eth_dev *dev,
>
>         /* We may already be setup, free memory prior to re-allocation */
>         if (dev->data->rx_queues[queue_idx] !=3D NULL) {
> -
eth_ark_dev_rx_queue_release(dev->data->rx_queues[queue_idx]);
> +               ark_dev_rx_queue_release(dev->data->rx_queues[queue_idx])=
;
>                 dev->data->rx_queues[queue_idx] =3D NULL;
>         }
>
> @@ -215,7 +215,7 @@ eth_ark_dev_rx_queue_setup(struct rte_eth_dev *dev,
>         ark_udm_queue_stats_reset(queue->udm);
>
>         /* populate mbuf reserve */
> -       status =3D eth_ark_rx_seed_mbufs(queue);
> +       status =3D ark_rx_seed_mbufs(queue);
>
>         if (queue->seed_index !=3D nb_desc) {
>                 ARK_PMD_LOG(ERR, "Failed to allocate %u mbufs for RX
queue %d\n",
> @@ -224,7 +224,7 @@ eth_ark_dev_rx_queue_setup(struct rte_eth_dev *dev,
>         }
>         /* MPU Setup */
>         if (status =3D=3D 0)
> -               status =3D eth_ark_rx_hw_setup(dev, queue, queue_idx);
> +               status =3D ark_rx_hw_setup(dev, queue, queue_idx);
>
>         if (unlikely(status !=3D 0)) {
>                 struct rte_mbuf **mbuf;
> @@ -248,7 +248,7 @@ eth_ark_dev_rx_queue_setup(struct rte_eth_dev *dev,
>
>  /*
************************************************************************* *=
/
>  uint16_t
> -eth_ark_recv_pkts(void *rx_queue,
> +ark_recv_pkts(void *rx_queue,
>                   struct rte_mbuf **rx_pkts,
>                   uint16_t nb_pkts)
>  {
> @@ -267,7 +267,7 @@ eth_ark_recv_pkts(void *rx_queue,
>         if (unlikely(nb_pkts =3D=3D 0))
>                 return 0;
>         if (unlikely(queue->starvation))
> -               eth_ark_rx_seed_mbufs(queue);
> +               ark_rx_seed_mbufs(queue);
>
>         prod_index =3D queue->prod_index;
>         cons_index =3D queue->cons_index;
> @@ -318,7 +318,7 @@ eth_ark_recv_pkts(void *rx_queue,
>                 }
>
>                 if (unlikely(meta->pkt_len > queue->dataroom)) {
> -                       uint32_t tcons =3D eth_ark_rx_jumbo(queue, meta,
mbuf, cons_index + 1);
> +                       uint32_t tcons =3D ark_rx_jumbo(queue, meta, mbuf=
,
cons_index + 1);
>                         if ((int32_t)(prod_index - tcons) >=3D 0)
>                                 cons_index =3D tcons; /* nominal conditio=
n
*/
>                         else
> @@ -340,14 +340,14 @@ eth_ark_recv_pkts(void *rx_queue,
>                 rx_user_meta_hook(mbuf, meta->user_meta,
queue->ext_user_data);
>         }
>
> -       eth_ark_rx_update_cons_index(queue, cons_index);
> +       ark_rx_update_cons_index(queue, cons_index);
>
>         return nb;
>  }
>
>  /*
************************************************************************* *=
/
>  static uint32_t
> -eth_ark_rx_jumbo(struct ark_rx_queue *queue,
> +ark_rx_jumbo(struct ark_rx_queue *queue,
>                  struct ark_rx_meta *meta,
>                  struct rte_mbuf *mbuf0,
>                  uint32_t cons_index)
> @@ -388,7 +388,7 @@ eth_ark_rx_jumbo(struct ark_rx_queue *queue,
>
>  /* Drain the internal queue allowing hw to clear out. */
>  static void
> -eth_ark_rx_queue_drain(struct ark_rx_queue *queue)
> +ark_rx_queue_drain(struct ark_rx_queue *queue)
>  {
>         register uint32_t cons_index;
>         struct rte_mbuf *mbuf;
> @@ -400,12 +400,12 @@ eth_ark_rx_queue_drain(struct ark_rx_queue *queue)
>                 mbuf =3D queue->reserve_q[cons_index & queue->queue_mask]=
;
>                 rte_pktmbuf_free(mbuf);
>                 cons_index++;
> -               eth_ark_rx_update_cons_index(queue, cons_index);
> +               ark_rx_update_cons_index(queue, cons_index);
>         }
>  }
>
>  int
> -eth_ark_dev_rx_queue_count(void *rx_queue)
> +ark_dev_rx_queue_count(void *rx_queue)
>  {
>         struct ark_rx_queue *queue;
>
> @@ -415,7 +415,7 @@ eth_ark_dev_rx_queue_count(void *rx_queue)
>
>  /*
************************************************************************* *=
/
>  int
> -eth_ark_rx_start_queue(struct rte_eth_dev *dev, uint16_t queue_id)
> +ark_rx_start_queue(struct rte_eth_dev *dev, uint16_t queue_id)
>  {
>         struct ark_rx_queue *queue;
>
> @@ -438,7 +438,7 @@ eth_ark_rx_start_queue(struct rte_eth_dev *dev,
uint16_t queue_id)
>  /* Queue can be restarted.   data remains
>   */
>  int
> -eth_ark_rx_stop_queue(struct rte_eth_dev *dev, uint16_t queue_id)
> +ark_rx_stop_queue(struct rte_eth_dev *dev, uint16_t queue_id)
>  {
>         struct ark_rx_queue *queue;
>
> @@ -455,7 +455,7 @@ eth_ark_rx_stop_queue(struct rte_eth_dev *dev,
uint16_t queue_id)
>
>  /*
************************************************************************* *=
/
>  static inline int
> -eth_ark_rx_seed_mbufs(struct ark_rx_queue *queue)
> +ark_rx_seed_mbufs(struct ark_rx_queue *queue)
>  {
>         uint32_t limit =3D RTE_ALIGN_FLOOR(queue->cons_index,
ARK_RX_MPU_CHUNK) +
>                 queue->queue_size;
> @@ -539,7 +539,7 @@ eth_ark_rx_seed_mbufs(struct ark_rx_queue *queue)
>  }
>
>  void
> -eth_ark_rx_dump_queue(struct rte_eth_dev *dev, uint16_t queue_id,
> +ark_rx_dump_queue(struct rte_eth_dev *dev, uint16_t queue_id,
>                       const char *msg)
>  {
>         struct ark_rx_queue *queue;
> @@ -552,7 +552,7 @@ eth_ark_rx_dump_queue(struct rte_eth_dev *dev,
uint16_t queue_id,
>  /*
************************************************************************* *=
/
>  /* Call on device closed no user API, queue is stopped */
>  void
> -eth_ark_dev_rx_queue_release(void *vqueue)
> +ark_dev_rx_queue_release(void *vqueue)
>  {
>         struct ark_rx_queue *queue;
>
> @@ -565,7 +565,7 @@ eth_ark_dev_rx_queue_release(void *vqueue)
>         ark_mpu_stop(queue->mpu);
>
>         /* Need to clear out mbufs here, dropping packets along the way *=
/
> -       eth_ark_rx_queue_drain(queue);
> +       ark_rx_queue_drain(queue);
>
>         rte_free(queue->reserve_q);
>         rte_free(queue->paddress_q);
> @@ -573,7 +573,7 @@ eth_ark_dev_rx_queue_release(void *vqueue)
>  }
>
>  void
> -eth_rx_queue_stats_get(void *vqueue, struct rte_eth_stats *stats)
> +ark_rx_queue_stats_get(void *vqueue, struct rte_eth_stats *stats)
>  {
>         struct ark_rx_queue *queue;
>         struct ark_udm_t *udm;
> @@ -596,7 +596,7 @@ eth_rx_queue_stats_get(void *vqueue, struct
rte_eth_stats *stats)
>  }
>
>  void
> -eth_rx_queue_stats_reset(void *vqueue)
> +ark_rx_queue_stats_reset(void *vqueue)
>  {
>         struct ark_rx_queue *queue;
>
> diff --git a/drivers/net/ark/ark_ethdev_rx.h
b/drivers/net/ark/ark_ethdev_rx.h
> index 12d4f61637..7a5bab20a9 100644
> --- a/drivers/net/ark/ark_ethdev_rx.h
> +++ b/drivers/net/ark/ark_ethdev_rx.h
> @@ -11,21 +11,21 @@
>  #include <rte_mempool.h>
>  #include <ethdev_driver.h>
>
> -int eth_ark_dev_rx_queue_setup(struct rte_eth_dev *dev,
> +int ark_dev_rx_queue_setup(struct rte_eth_dev *dev,
>                                uint16_t queue_idx,
>                                uint16_t nb_desc,
>                                unsigned int socket_id,
>                                const struct rte_eth_rxconf *rx_conf,
>                                struct rte_mempool *mp);
> -int eth_ark_dev_rx_queue_count(void *rx_queue);
> -int eth_ark_rx_stop_queue(struct rte_eth_dev *dev, uint16_t queue_id);
> -int eth_ark_rx_start_queue(struct rte_eth_dev *dev, uint16_t queue_id);
> -uint16_t eth_ark_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
> +int ark_dev_rx_queue_count(void *rx_queue);
> +int ark_rx_stop_queue(struct rte_eth_dev *dev, uint16_t queue_id);
> +int ark_rx_start_queue(struct rte_eth_dev *dev, uint16_t queue_id);
> +uint16_t ark_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
>                            uint16_t nb_pkts);
> -void eth_ark_dev_rx_queue_release(void *rx_queue);
> -void eth_rx_queue_stats_get(void *vqueue, struct rte_eth_stats *stats);
> -void eth_rx_queue_stats_reset(void *vqueue);
> -void eth_ark_rx_dump_queue(struct rte_eth_dev *dev, uint16_t queue_id,
> +void ark_dev_rx_queue_release(void *rx_queue);
> +void ark_rx_queue_stats_get(void *vqueue, struct rte_eth_stats *stats);
> +void ark_rx_queue_stats_reset(void *vqueue);
> +void ark_rx_dump_queue(struct rte_eth_dev *dev, uint16_t queue_id,
>                            const char *msg);
>
>  #endif
> diff --git a/drivers/net/ark/ark_ethdev_tx.c
b/drivers/net/ark/ark_ethdev_tx.c
> index ca6cd297a1..2c61cd5486 100644
> --- a/drivers/net/ark/ark_ethdev_tx.c
> +++ b/drivers/net/ark/ark_ethdev_tx.c
> @@ -53,15 +53,15 @@ struct __rte_cache_aligned ark_tx_queue {
>  };
>
>  /* Forward declarations */
> -static int eth_ark_tx_jumbo(struct ark_tx_queue *queue,
> +static int ark_tx_jumbo(struct ark_tx_queue *queue,
>                             struct rte_mbuf *mbuf,
>                             uint32_t *user_meta, uint8_t meta_cnt);
> -static int eth_ark_tx_hw_queue_config(struct ark_tx_queue *queue);
> +static int ark_tx_hw_queue_config(struct ark_tx_queue *queue);
>  static void free_completed_tx(struct ark_tx_queue *queue);
>
>  /*
************************************************************************* *=
/
>  static inline void
> -eth_ark_tx_desc_fill(struct ark_tx_queue *queue,
> +ark_tx_desc_fill(struct ark_tx_queue *queue,
>                      struct rte_mbuf *mbuf,
>                      uint8_t  flags,
>                      uint32_t *user_meta,
> @@ -101,7 +101,7 @@ eth_ark_tx_desc_fill(struct ark_tx_queue *queue,
>
>  /*
************************************************************************* *=
/
>  uint16_t
> -eth_ark_xmit_pkts(void *vtxq, struct rte_mbuf **tx_pkts, uint16_t
nb_pkts)
> +ark_xmit_pkts(void *vtxq, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
>  {
>         struct ark_tx_queue *queue;
>         struct rte_mbuf *mbuf;
> @@ -159,12 +159,12 @@ eth_ark_xmit_pkts(void *vtxq, struct rte_mbuf
**tx_pkts, uint16_t nb_pkts)
>                         tx_user_meta_hook(mbuf, user_meta, &user_len,
>                                           queue->ext_user_data);
>                 if (unlikely(mbuf->nb_segs !=3D 1)) {
> -                       stat =3D eth_ark_tx_jumbo(queue, mbuf,
> +                       stat =3D ark_tx_jumbo(queue, mbuf,
>                                                 user_meta, user_len);
>                         if (unlikely(stat !=3D 0))
>                                 break;          /* Queue is full */
>                 } else {
> -                       eth_ark_tx_desc_fill(queue, mbuf,
> +                       ark_tx_desc_fill(queue, mbuf,
>                                              ARK_DDM_SOP | ARK_DDM_EOP,
>                                              user_meta, user_len);
>                 }
> @@ -195,7 +195,7 @@ eth_ark_xmit_pkts(void *vtxq, struct rte_mbuf
**tx_pkts, uint16_t nb_pkts)
>
>  /*
************************************************************************* *=
/
>  static int
> -eth_ark_tx_jumbo(struct ark_tx_queue *queue, struct rte_mbuf *mbuf,
> +ark_tx_jumbo(struct ark_tx_queue *queue, struct rte_mbuf *mbuf,
>                  uint32_t *user_meta, uint8_t meta_cnt)
>  {
>         struct rte_mbuf *next;
> @@ -212,7 +212,7 @@ eth_ark_tx_jumbo(struct ark_tx_queue *queue, struct
rte_mbuf *mbuf,
>                 next =3D mbuf->next;
>                 flags |=3D (next =3D=3D NULL) ? ARK_DDM_EOP : 0;
>
> -               eth_ark_tx_desc_fill(queue, mbuf, flags, user_meta,
meta_cnt);
> +               ark_tx_desc_fill(queue, mbuf, flags, user_meta, meta_cnt)=
;
>
>                 flags &=3D ~ARK_DDM_SOP;  /* drop SOP flags */
>                 meta_cnt =3D 0;           /* Meta only on SOP */
> @@ -224,7 +224,7 @@ eth_ark_tx_jumbo(struct ark_tx_queue *queue, struct
rte_mbuf *mbuf,
>
>  /*
************************************************************************* *=
/
>  int
> -eth_ark_tx_queue_setup(struct rte_eth_dev *dev,
> +ark_tx_queue_setup(struct rte_eth_dev *dev,
>                        uint16_t queue_idx,
>                        uint16_t nb_desc,
>                        unsigned int socket_id,
> @@ -291,7 +291,7 @@ eth_ark_tx_queue_setup(struct rte_eth_dev *dev,
>         queue->ddm =3D RTE_PTR_ADD(ark->ddm.v, qidx * ARK_DDM_QOFFSET);
>         queue->mpu =3D RTE_PTR_ADD(ark->mputx.v, qidx * ARK_MPU_QOFFSET);
>
> -       status =3D eth_ark_tx_hw_queue_config(queue);
> +       status =3D ark_tx_hw_queue_config(queue);
>
>         if (unlikely(status !=3D 0)) {
>                 rte_free(queue->meta_q);
> @@ -305,7 +305,7 @@ eth_ark_tx_queue_setup(struct rte_eth_dev *dev,
>
>  /*
************************************************************************* *=
/
>  static int
> -eth_ark_tx_hw_queue_config(struct ark_tx_queue *queue)
> +ark_tx_hw_queue_config(struct ark_tx_queue *queue)
>  {
>         rte_iova_t queue_base, ring_base, cons_index_addr;
>
> @@ -333,7 +333,7 @@ eth_ark_tx_hw_queue_config(struct ark_tx_queue *queue=
)
>
>  /*
************************************************************************* *=
/
>  void
> -eth_ark_tx_queue_release(void *vtx_queue)
> +ark_tx_queue_release(void *vtx_queue)
>  {
>         struct ark_tx_queue *queue;
>
> @@ -352,7 +352,7 @@ eth_ark_tx_queue_release(void *vtx_queue)
>
>  /*
************************************************************************* *=
/
>  int
> -eth_ark_tx_queue_stop(struct rte_eth_dev *dev, uint16_t queue_id)
> +ark_tx_queue_stop(struct rte_eth_dev *dev, uint16_t queue_id)
>  {
>         struct ark_tx_queue *queue;
>         int cnt =3D 0;
> @@ -376,7 +376,7 @@ eth_ark_tx_queue_stop(struct rte_eth_dev *dev,
uint16_t queue_id)
>  }
>
>  int
> -eth_ark_tx_queue_start(struct rte_eth_dev *dev, uint16_t queue_id)
> +ark_tx_queue_start(struct rte_eth_dev *dev, uint16_t queue_id)
>  {
>         struct ark_tx_queue *queue;
>
> @@ -415,7 +415,7 @@ free_completed_tx(struct ark_tx_queue *queue)
>
>  /*
************************************************************************* *=
/
>  void
> -eth_tx_queue_stats_get(void *vqueue, struct rte_eth_stats *stats)
> +ark_tx_queue_stats_get(void *vqueue, struct rte_eth_stats *stats)
>  {
>         struct ark_tx_queue *queue;
>         struct ark_ddm_t *ddm;
> @@ -435,7 +435,7 @@ eth_tx_queue_stats_get(void *vqueue, struct
rte_eth_stats *stats)
>  }
>
>  void
> -eth_tx_queue_stats_reset(void *vqueue)
> +ark_tx_queue_stats_reset(void *vqueue)
>  {
>         struct ark_tx_queue *queue;
>         struct ark_ddm_t *ddm;
> diff --git a/drivers/net/ark/ark_ethdev_tx.h
b/drivers/net/ark/ark_ethdev_tx.h
> index 7134dbfeed..ee66ed19cc 100644
> --- a/drivers/net/ark/ark_ethdev_tx.h
> +++ b/drivers/net/ark/ark_ethdev_tx.h
> @@ -10,18 +10,18 @@
>  #include <ethdev_driver.h>
>
>
> -uint16_t eth_ark_xmit_pkts(void *vtxq,
> +uint16_t ark_xmit_pkts(void *vtxq,
>                            struct rte_mbuf **tx_pkts,
>                            uint16_t nb_pkts);
> -int eth_ark_tx_queue_setup(struct rte_eth_dev *dev,
> +int ark_tx_queue_setup(struct rte_eth_dev *dev,
>                            uint16_t queue_idx,
>                            uint16_t nb_desc,
>                            unsigned int socket_id,
>                            const struct rte_eth_txconf *tx_conf);
> -void eth_ark_tx_queue_release(void *vtx_queue);
> -int eth_ark_tx_queue_stop(struct rte_eth_dev *dev, uint16_t queue_id);
> -int eth_ark_tx_queue_start(struct rte_eth_dev *dev, uint16_t queue_id);
> -void eth_tx_queue_stats_get(void *vqueue, struct rte_eth_stats *stats);
> -void eth_tx_queue_stats_reset(void *vqueue);
> +void ark_tx_queue_release(void *vtx_queue);
> +int ark_tx_queue_stop(struct rte_eth_dev *dev, uint16_t queue_id);
> +int ark_tx_queue_start(struct rte_eth_dev *dev, uint16_t queue_id);
> +void ark_tx_queue_stats_get(void *vqueue, struct rte_eth_stats *stats);
> +void ark_tx_queue_stats_reset(void *vqueue);
>
>  #endif
> --
> 2.47.3
>

--0000000000001b9c210640be6e62
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Acked-by:Ed Czeck &lt;<a href=3D"mailto:ed.czeck@atomicrul=
es.com">ed.czeck@atomicrules.com</a>&gt;<br><br>On Fri, Sep 26, 2025 at 12:=
35=E2=80=AFPM Stephen Hemminger &lt;<a href=3D"mailto:stephen@networkplumbe=
r.org">stephen@networkplumber.org</a>&gt; wrote:<br>&gt;<br>&gt; Rather tha=
n eth_ark_XXX use ark_XXX as prefix on all visible<br>&gt; global variables=
. This makes device consistent with other PMD&#39;s.<br>&gt;<br>&gt; Signed=
-off-by: Stephen Hemminger &lt;<a href=3D"mailto:stephen@networkplumber.org=
">stephen@networkplumber.org</a>&gt;<br>&gt; ---<br>&gt; =C2=A0drivers/net/=
ark/ark_ethdev.c =C2=A0 =C2=A0| 154 ++++++++++++++++----------------<br>&gt=
; =C2=A0drivers/net/ark/ark_ethdev_rx.c | =C2=A050 +++++------<br>&gt; =C2=
=A0drivers/net/ark/ark_ethdev_rx.h | =C2=A018 ++--<br>&gt; =C2=A0drivers/ne=
t/ark/ark_ethdev_tx.c | =C2=A032 +++----<br>&gt; =C2=A0drivers/net/ark/ark_=
ethdev_tx.h | =C2=A014 +--<br>&gt; =C2=A05 files changed, 134 insertions(+)=
, 134 deletions(-)<br>&gt;<br>&gt; diff --git a/drivers/net/ark/ark_ethdev.=
c b/drivers/net/ark/ark_ethdev.c<br>&gt; index 8d3c0a1b02..04a15d006f 10064=
4<br>&gt; --- a/drivers/net/ark/ark_ethdev.c<br>&gt; +++ b/drivers/net/ark/=
ark_ethdev.c<br>&gt; @@ -22,32 +22,32 @@<br>&gt; =C2=A0#include &quot;ark_p=
ktchkr.h&quot;<br>&gt;<br>&gt; =C2=A0/* =C2=A0Internal prototypes */<br>&gt=
; -static int eth_ark_check_args(struct ark_adapter *ark, const char *param=
s);<br>&gt; -static int eth_ark_dev_init(struct rte_eth_dev *dev);<br>&gt; =
+static int ark_check_args(struct ark_adapter *ark, const char *params);<br=
>&gt; +static int ark_dev_init(struct rte_eth_dev *dev);<br>&gt; =C2=A0stat=
ic int ark_config_device(struct rte_eth_dev *dev);<br>&gt; -static int eth_=
ark_dev_uninit(struct rte_eth_dev *eth_dev);<br>&gt; -static int eth_ark_de=
v_configure(struct rte_eth_dev *dev);<br>&gt; -static int eth_ark_dev_start=
(struct rte_eth_dev *dev);<br>&gt; -static int eth_ark_dev_stop(struct rte_=
eth_dev *dev);<br>&gt; -static int eth_ark_dev_close(struct rte_eth_dev *de=
v);<br>&gt; -static int eth_ark_dev_info_get(struct rte_eth_dev *dev,<br>&g=
t; +static int ark_dev_uninit(struct rte_eth_dev *eth_dev);<br>&gt; +static=
 int ark_dev_configure(struct rte_eth_dev *dev);<br>&gt; +static int ark_de=
v_start(struct rte_eth_dev *dev);<br>&gt; +static int ark_dev_stop(struct r=
te_eth_dev *dev);<br>&gt; +static int ark_dev_close(struct rte_eth_dev *dev=
);<br>&gt; +static int ark_dev_info_get(struct rte_eth_dev *dev,<br>&gt; =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct rte_eth_dev_info *dev_info);<=
br>&gt; -static int eth_ark_dev_link_update(struct rte_eth_dev *dev,<br>&gt=
; +static int ark_dev_link_update(struct rte_eth_dev *dev,<br>&gt; =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int wait_to_complete);<br>&gt;=
 -static int eth_ark_dev_set_link_up(struct rte_eth_dev *dev);<br>&gt; -sta=
tic int eth_ark_dev_set_link_down(struct rte_eth_dev *dev);<br>&gt; -static=
 int eth_ark_dev_stats_get(struct rte_eth_dev *dev,<br>&gt; +static int ark=
_dev_set_link_up(struct rte_eth_dev *dev);<br>&gt; +static int ark_dev_set_=
link_down(struct rte_eth_dev *dev);<br>&gt; +static int ark_dev_stats_get(s=
truct rte_eth_dev *dev,<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 struct rte_eth_stats *stats);<br>&gt; -static int eth_ark_dev_stats_res=
et(struct rte_eth_dev *dev);<br>&gt; -static int eth_ark_set_default_mac_ad=
dr(struct rte_eth_dev *dev,<br>&gt; +static int ark_dev_stats_reset(struct =
rte_eth_dev *dev);<br>&gt; +static int ark_set_default_mac_addr(struct rte_=
eth_dev *dev,<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0struct rte_ether_addr *mac_addr);<br>&gt; -static int e=
th_ark_macaddr_add(struct rte_eth_dev *dev,<br>&gt; +static int ark_macaddr=
_add(struct rte_eth_dev *dev,<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0struct rte_ether_addr *mac_addr,<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0uint32_t index,<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t =
pool);<br>&gt; -static void eth_ark_macaddr_remove(struct rte_eth_dev *dev,=
<br>&gt; +static void ark_macaddr_remove(struct rte_eth_dev *dev,<br>&gt; =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t index);<br>&gt=
; -static int =C2=A0eth_ark_set_mtu(struct rte_eth_dev *dev, uint16_t size)=
;<br>&gt; +static int =C2=A0ark_set_mtu(struct rte_eth_dev *dev, uint16_t s=
ize);<br>&gt;<br>&gt; =C2=A0/*<br>&gt; =C2=A0 * The packet generator is a f=
unctional block used to generate packet<br>&gt; @@ -145,7 +145,7 @@ ark_dev=
ice_caps[] =3D {<br>&gt; =C2=A0};<br>&gt;<br>&gt; =C2=A0static int<br>&gt; =
-eth_ark_pci_probe(struct rte_pci_driver *pci_drv __rte_unused,<br>&gt; +ar=
k_pci_probe(struct rte_pci_driver *pci_drv __rte_unused,<br>&gt; =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct rte_pci_device *pci_de=
v)<br>&gt; =C2=A0{<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct rte_eth_dev *=
eth_dev;<br>&gt; @@ -156,7 +156,7 @@ eth_ark_pci_probe(struct rte_pci_drive=
r *pci_drv __rte_unused,<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (eth_dev =
=3D=3D NULL)<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 return -ENOMEM;<br>&gt;<br>&gt; - =C2=A0 =C2=A0 =C2=A0 ret =3D eth_ark_=
dev_init(eth_dev);<br>&gt; + =C2=A0 =C2=A0 =C2=A0 ret =3D ark_dev_init(eth_=
dev);<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret)<br>&gt; =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rte_eth_dev_release_port(eth_dev)=
;<br>&gt;<br>&gt; @@ -164,47 +164,47 @@ eth_ark_pci_probe(struct rte_pci_dr=
iver *pci_drv __rte_unused,<br>&gt; =C2=A0}<br>&gt;<br>&gt; =C2=A0static in=
t<br>&gt; -eth_ark_pci_remove(struct rte_pci_device *pci_dev)<br>&gt; +ark_=
pci_remove(struct rte_pci_device *pci_dev)<br>&gt; =C2=A0{<br>&gt; - =C2=A0=
 =C2=A0 =C2=A0 return rte_eth_dev_pci_generic_remove(pci_dev, eth_ark_dev_u=
ninit);<br>&gt; + =C2=A0 =C2=A0 =C2=A0 return rte_eth_dev_pci_generic_remov=
e(pci_dev, ark_dev_uninit);<br>&gt; =C2=A0}<br>&gt;<br>&gt; =C2=A0static st=
ruct rte_pci_driver rte_ark_pmd =3D {<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 .=
id_table =3D pci_id_ark_map,<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 .drv_flags=
 =3D RTE_PCI_DRV_NEED_MAPPING | RTE_PCI_DRV_INTR_LSC,<br>&gt; - =C2=A0 =C2=
=A0 =C2=A0 .probe =3D eth_ark_pci_probe,<br>&gt; - =C2=A0 =C2=A0 =C2=A0 .re=
move =3D eth_ark_pci_remove,<br>&gt; + =C2=A0 =C2=A0 =C2=A0 .probe =3D ark_=
pci_probe,<br>&gt; + =C2=A0 =C2=A0 =C2=A0 .remove =3D ark_pci_remove,<br>&g=
t; =C2=A0};<br>&gt;<br>&gt; =C2=A0static const struct eth_dev_ops ark_eth_d=
ev_ops =3D {<br>&gt; - =C2=A0 =C2=A0 =C2=A0 .dev_configure =3D eth_ark_dev_=
configure,<br>&gt; - =C2=A0 =C2=A0 =C2=A0 .dev_start =3D eth_ark_dev_start,=
<br>&gt; - =C2=A0 =C2=A0 =C2=A0 .dev_stop =3D eth_ark_dev_stop,<br>&gt; - =
=C2=A0 =C2=A0 =C2=A0 .dev_close =3D eth_ark_dev_close,<br>&gt; + =C2=A0 =C2=
=A0 =C2=A0 .dev_configure =3D ark_dev_configure,<br>&gt; + =C2=A0 =C2=A0 =
=C2=A0 .dev_start =3D ark_dev_start,<br>&gt; + =C2=A0 =C2=A0 =C2=A0 .dev_st=
op =3D ark_dev_stop,<br>&gt; + =C2=A0 =C2=A0 =C2=A0 .dev_close =3D ark_dev_=
close,<br>&gt;<br>&gt; - =C2=A0 =C2=A0 =C2=A0 .dev_infos_get =3D eth_ark_de=
v_info_get,<br>&gt; + =C2=A0 =C2=A0 =C2=A0 .dev_infos_get =3D ark_dev_info_=
get,<br>&gt;<br>&gt; - =C2=A0 =C2=A0 =C2=A0 .rx_queue_setup =3D eth_ark_dev=
_rx_queue_setup,<br>&gt; - =C2=A0 =C2=A0 =C2=A0 .tx_queue_setup =3D eth_ark=
_tx_queue_setup,<br>&gt; + =C2=A0 =C2=A0 =C2=A0 .rx_queue_setup =3D ark_dev=
_rx_queue_setup,<br>&gt; + =C2=A0 =C2=A0 =C2=A0 .tx_queue_setup =3D ark_tx_=
queue_setup,<br>&gt;<br>&gt; - =C2=A0 =C2=A0 =C2=A0 .link_update =3D eth_ar=
k_dev_link_update,<br>&gt; - =C2=A0 =C2=A0 =C2=A0 .dev_set_link_up =3D eth_=
ark_dev_set_link_up,<br>&gt; - =C2=A0 =C2=A0 =C2=A0 .dev_set_link_down =3D =
eth_ark_dev_set_link_down,<br>&gt; + =C2=A0 =C2=A0 =C2=A0 .link_update =3D =
ark_dev_link_update,<br>&gt; + =C2=A0 =C2=A0 =C2=A0 .dev_set_link_up =3D ar=
k_dev_set_link_up,<br>&gt; + =C2=A0 =C2=A0 =C2=A0 .dev_set_link_down =3D ar=
k_dev_set_link_down,<br>&gt;<br>&gt; - =C2=A0 =C2=A0 =C2=A0 .rx_queue_start=
 =3D eth_ark_rx_start_queue,<br>&gt; - =C2=A0 =C2=A0 =C2=A0 .rx_queue_stop =
=3D eth_ark_rx_stop_queue,<br>&gt; + =C2=A0 =C2=A0 =C2=A0 .rx_queue_start =
=3D ark_rx_start_queue,<br>&gt; + =C2=A0 =C2=A0 =C2=A0 .rx_queue_stop =3D a=
rk_rx_stop_queue,<br>&gt;<br>&gt; - =C2=A0 =C2=A0 =C2=A0 .tx_queue_start =
=3D eth_ark_tx_queue_start,<br>&gt; - =C2=A0 =C2=A0 =C2=A0 .tx_queue_stop =
=3D eth_ark_tx_queue_stop,<br>&gt; + =C2=A0 =C2=A0 =C2=A0 .tx_queue_start =
=3D ark_tx_queue_start,<br>&gt; + =C2=A0 =C2=A0 =C2=A0 .tx_queue_stop =3D a=
rk_tx_queue_stop,<br>&gt;<br>&gt; - =C2=A0 =C2=A0 =C2=A0 .stats_get =3D eth=
_ark_dev_stats_get,<br>&gt; - =C2=A0 =C2=A0 =C2=A0 .stats_reset =3D eth_ark=
_dev_stats_reset,<br>&gt; + =C2=A0 =C2=A0 =C2=A0 .stats_get =3D ark_dev_sta=
ts_get,<br>&gt; + =C2=A0 =C2=A0 =C2=A0 .stats_reset =3D ark_dev_stats_reset=
,<br>&gt;<br>&gt; - =C2=A0 =C2=A0 =C2=A0 .mac_addr_add =3D eth_ark_macaddr_=
add,<br>&gt; - =C2=A0 =C2=A0 =C2=A0 .mac_addr_remove =3D eth_ark_macaddr_re=
move,<br>&gt; - =C2=A0 =C2=A0 =C2=A0 .mac_addr_set =3D eth_ark_set_default_=
mac_addr,<br>&gt; + =C2=A0 =C2=A0 =C2=A0 .mac_addr_add =3D ark_macaddr_add,=
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 .mac_addr_remove =3D ark_macaddr_remove,<br=
>&gt; + =C2=A0 =C2=A0 =C2=A0 .mac_addr_set =3D ark_set_default_mac_addr,<br=
>&gt;<br>&gt; - =C2=A0 =C2=A0 =C2=A0 .mtu_set =3D eth_ark_set_mtu,<br>&gt; =
+ =C2=A0 =C2=A0 =C2=A0 .mtu_set =3D ark_set_mtu,<br>&gt; =C2=A0};<br>&gt;<b=
r>&gt; =C2=A0static int<br>&gt; @@ -297,7 +297,7 @@ check_for_ext(struct ar=
k_adapter *ark)<br>&gt; =C2=A0}<br>&gt;<br>&gt; =C2=A0static int<br>&gt; -e=
th_ark_dev_init(struct rte_eth_dev *dev)<br>&gt; +ark_dev_init(struct rte_e=
th_dev *dev)<br>&gt; =C2=A0{<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct ark=
_adapter *ark =3D dev-&gt;data-&gt;dev_private;<br>&gt; =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 struct rte_pci_device *pci_dev;<br>&gt; @@ -376,7 +376,7 @@ eth_=
ark_dev_init(struct rte_eth_dev *dev)<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>&gt;<br>&gt; =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 dev-&gt;dev_ops =3D &amp;ark_eth_dev_ops;<br>&gt; - =C2=A0 =C2=A0 =
=C2=A0 dev-&gt;rx_queue_count =3D eth_ark_dev_rx_queue_count;<br>&gt; + =C2=
=A0 =C2=A0 =C2=A0 dev-&gt;rx_queue_count =3D ark_dev_rx_queue_count;<br>&gt=
;<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev-&gt;data-&gt;mac_addrs =3D rte_zm=
alloc(&quot;ark&quot;, RTE_ETHER_ADDR_LEN, 0);<br>&gt; =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 if (!dev-&gt;data-&gt;mac_addrs) {<br>&gt; @@ -398,7 +398,7 @@ eth_=
ark_dev_init(struct rte_eth_dev *dev)<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 }=
<br>&gt;<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (pci_dev-&gt;device.devargs=
)<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D eth_ar=
k_check_args(ark, pci_dev-&gt;device.devargs-&gt;args);<br>&gt; + =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D ark_check_args(ark, pci_d=
ev-&gt;device.devargs-&gt;args);<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 else<b=
r>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ARK_PMD_LOG(=
INFO, &quot;No Device args found\n&quot;);<br>&gt;<br>&gt; @@ -539,7 +539,7=
 @@ ark_config_device(struct rte_eth_dev *dev)<br>&gt; =C2=A0}<br>&gt;<br>&=
gt; =C2=A0static int<br>&gt; -eth_ark_dev_uninit(struct rte_eth_dev *dev)<b=
r>&gt; +ark_dev_uninit(struct rte_eth_dev *dev)<br>&gt; =C2=A0{<br>&gt; =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 struct ark_adapter *ark =3D dev-&gt;data-&gt;dev_p=
rivate;<br>&gt;<br>&gt; @@ -559,11 +559,11 @@ eth_ark_dev_uninit(struct rte=
_eth_dev *dev)<br>&gt; =C2=A0}<br>&gt;<br>&gt; =C2=A0static int<br>&gt; -et=
h_ark_dev_configure(struct rte_eth_dev *dev)<br>&gt; +ark_dev_configure(str=
uct rte_eth_dev *dev)<br>&gt; =C2=A0{<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 s=
truct ark_adapter *ark =3D dev-&gt;data-&gt;dev_private;<br>&gt;<br>&gt; - =
=C2=A0 =C2=A0 =C2=A0 eth_ark_dev_set_link_up(dev);<br>&gt; + =C2=A0 =C2=A0 =
=C2=A0 ark_dev_set_link_up(dev);<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ar=
k-&gt;user_ext.dev_configure)<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 return ark-&gt;user_ext.dev_configure(dev,<br>&gt; =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0ark-&gt;user_data[dev-&gt;data-&gt;port_id]);<br>&gt; @=
@ -571,23 +571,23 @@ eth_ark_dev_configure(struct rte_eth_dev *dev)<br>&gt;=
 =C2=A0}<br>&gt;<br>&gt; =C2=A0static int<br>&gt; -eth_ark_dev_start(struct=
 rte_eth_dev *dev)<br>&gt; +ark_dev_start(struct rte_eth_dev *dev)<br>&gt; =
=C2=A0{<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct ark_adapter *ark =3D dev=
-&gt;data-&gt;dev_private;<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 int i;<br>&g=
t;<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* RX Side */<br>&gt; =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 for (i =3D 0; i &lt; dev-&gt;data-&gt;nb_rx_queues; i++)<br>&=
gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 eth_ark_rx_start_que=
ue(dev, i);<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ark_=
rx_start_queue(dev, i);<br>&gt;<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* TX S=
ide */<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; dev-&gt;dat=
a-&gt;nb_tx_queues; i++)<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 eth_ark_tx_queue_start(dev, i);<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ark_tx_queue_start(dev, i);<br>&gt;<br>&gt; =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 ark-&gt;started =3D 1;<br>&gt; =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 /* set xmit and receive function */<br>&gt; - =C2=A0 =C2=A0 =C2=
=A0 dev-&gt;rx_pkt_burst =3D &amp;eth_ark_recv_pkts;<br>&gt; - =C2=A0 =C2=
=A0 =C2=A0 dev-&gt;tx_pkt_burst =3D &amp;eth_ark_xmit_pkts;<br>&gt; + =C2=
=A0 =C2=A0 =C2=A0 dev-&gt;rx_pkt_burst =3D &amp;ark_recv_pkts;<br>&gt; + =
=C2=A0 =C2=A0 =C2=A0 dev-&gt;tx_pkt_burst =3D &amp;ark_xmit_pkts;<br>&gt;<b=
r>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!ark-&gt;isvf &amp;&amp; ark-&gt;sta=
rt_pg)<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ark_=
pktchkr_run(ark-&gt;pc);<br>&gt; @@ -618,7 +618,7 @@ eth_ark_dev_start(stru=
ct rte_eth_dev *dev)<br>&gt; =C2=A0}<br>&gt;<br>&gt; =C2=A0static int<br>&g=
t; -eth_ark_dev_stop(struct rte_eth_dev *dev)<br>&gt; +ark_dev_stop(struct =
rte_eth_dev *dev)<br>&gt; =C2=A0{<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint1=
6_t i;<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 int status;<br>&gt; @@ -645,11 +=
645,11 @@ eth_ark_dev_stop(struct rte_eth_dev *dev)<br>&gt;<br>&gt; =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 /* Stop RX Side */<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 for (i =3D 0; i &lt; dev-&gt;data-&gt;nb_rx_queues; i++)<br>&gt; - =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 eth_ark_rx_stop_queue(dev, i);<br=
>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ark_rx_stop_queue(=
dev, i);<br>&gt;<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* STOP TX Side */<br>=
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; dev-&gt;data-&gt;nb_t=
x_queues; i++) {<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 status =3D eth_ark_tx_queue_stop(dev, i);<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 status =3D ark_tx_queue_stop(dev, i);<br>&gt; =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (status !=3D 0) =
{<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 uint16_t port =3D dev-&gt;data-&gt;port_id;<br>&gt; =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ARK_PMD_LOG(ERR,<br>&gt; @@ -662,7 +662,7 @@ eth_ark_dev_stop(st=
ruct rte_eth_dev *dev)<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 ark_udm_dump_sta=
ts(ark-&gt;udm.v, &quot;Post stop&quot;);<br>&gt;<br>&gt; =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 for (i =3D 0; i &lt; dev-&gt;data-&gt;nb_rx_queues; i++)<br>&gt;=
 - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 eth_ark_rx_dump_queue(d=
ev, i, __func__);<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 ark_rx_dump_queue(dev, i, __func__);<br>&gt;<br>&gt; =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 /* Stop the packet checker if it is running */<br>&gt; =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 if (!ark-&gt;isvf &amp;&amp; ark-&gt;start_pg) {<br>&g=
t; @@ -674,7 +674,7 @@ eth_ark_dev_stop(struct rte_eth_dev *dev)<br>&gt; =
=C2=A0}<br>&gt;<br>&gt; =C2=A0static int<br>&gt; -eth_ark_dev_close(struct =
rte_eth_dev *dev)<br>&gt; +ark_dev_close(struct rte_eth_dev *dev)<br>&gt; =
=C2=A0{<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct ark_adapter *ark =3D dev=
-&gt;data-&gt;dev_private;<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint16_t i;<=
br>&gt; @@ -686,7 +686,7 @@ eth_ark_dev_close(struct rte_eth_dev *dev)<br>&=
gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ark-&gt;user_ex=
t.dev_close(dev,<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0ark-&gt;user_data[dev-&gt;data-&gt;port_id]);<br>&gt;<br>&gt; =
- =C2=A0 =C2=A0 =C2=A0 eth_ark_dev_stop(dev);<br>&gt; + =C2=A0 =C2=A0 =C2=
=A0 ark_dev_stop(dev);<br>&gt;<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>&g=
t; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* This should only be called once for =
the device during shutdown<br>&gt; @@ -696,12 +696,12 @@ eth_ark_dev_close(=
struct rte_eth_dev *dev)<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 ark_pktdir_setup(ark-&gt;pd, ARK_PKT_DIR_INIT_VAL);<br>&gt;<b=
r>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; dev-&gt;data-&gt;nb=
_tx_queues; i++) {<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 eth_ark_tx_queue_release(dev-&gt;data-&gt;tx_queues[i]);<br>&gt; + =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ark_tx_queue_release(dev-&gt;=
data-&gt;tx_queues[i]);<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 dev-&gt;data-&gt;tx_queues[i] =3D 0;<br>&gt; =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 }<br>&gt;<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i=
 &lt; dev-&gt;data-&gt;nb_rx_queues; i++) {<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 eth_ark_dev_rx_queue_release(dev-&gt;data-&gt;r=
x_queues[i]);<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ar=
k_dev_rx_queue_release(dev-&gt;data-&gt;rx_queues[i]);<br>&gt; =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev-&gt;data-&gt;rx_queues[i]=
 =3D 0;<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>&gt;<br>&gt; @@ -709,7 +70=
9,7 @@ eth_ark_dev_close(struct rte_eth_dev *dev)<br>&gt; =C2=A0}<br>&gt;<b=
r>&gt; =C2=A0static int<br>&gt; -eth_ark_dev_info_get(struct rte_eth_dev *d=
ev,<br>&gt; +ark_dev_info_get(struct rte_eth_dev *dev,<br>&gt; =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct rt=
e_eth_dev_info *dev_info)<br>&gt; =C2=A0{<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 struct ark_adapter *ark =3D dev-&gt;data-&gt;dev_private;<br>&gt; @@ -7=
49,7 +749,7 @@ eth_ark_dev_info_get(struct rte_eth_dev *dev,<br>&gt; =C2=A0=
}<br>&gt;<br>&gt; =C2=A0static int<br>&gt; -eth_ark_dev_link_update(struct =
rte_eth_dev *dev, int wait_to_complete)<br>&gt; +ark_dev_link_update(struct=
 rte_eth_dev *dev, int wait_to_complete)<br>&gt; =C2=A0{<br>&gt; =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 ARK_PMD_LOG(DEBUG, &quot;link status =3D %d\n&quot;,<br>&=
gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 dev-&gt;data-&gt;dev_link.link_status);<br>&gt; @@ -764,7 +76=
4,7 @@ eth_ark_dev_link_update(struct rte_eth_dev *dev, int wait_to_complet=
e)<br>&gt; =C2=A0}<br>&gt;<br>&gt; =C2=A0static int<br>&gt; -eth_ark_dev_se=
t_link_up(struct rte_eth_dev *dev)<br>&gt; +ark_dev_set_link_up(struct rte_=
eth_dev *dev)<br>&gt; =C2=A0{<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev-&gt;d=
ata-&gt;dev_link.link_status =3D 1;<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 str=
uct ark_adapter *ark =3D dev-&gt;data-&gt;dev_private;<br>&gt; @@ -776,7 +7=
76,7 @@ eth_ark_dev_set_link_up(struct rte_eth_dev *dev)<br>&gt; =C2=A0}<br=
>&gt;<br>&gt; =C2=A0static int<br>&gt; -eth_ark_dev_set_link_down(struct rt=
e_eth_dev *dev)<br>&gt; +ark_dev_set_link_down(struct rte_eth_dev *dev)<br>=
&gt; =C2=A0{<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev-&gt;data-&gt;dev_link.=
link_status =3D 0;<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct ark_adapter *=
ark =3D dev-&gt;data-&gt;dev_private;<br>&gt; @@ -788,7 +788,7 @@ eth_ark_d=
ev_set_link_down(struct rte_eth_dev *dev)<br>&gt; =C2=A0}<br>&gt;<br>&gt; =
=C2=A0static int<br>&gt; -eth_ark_dev_stats_get(struct rte_eth_dev *dev, st=
ruct rte_eth_stats *stats)<br>&gt; +ark_dev_stats_get(struct rte_eth_dev *d=
ev, struct rte_eth_stats *stats)<br>&gt; =C2=A0{<br>&gt; =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 uint16_t i;<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct ark_adapt=
er *ark =3D dev-&gt;data-&gt;dev_private;<br>&gt; @@ -801,9 +801,9 @@ eth_a=
rk_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)<br>&=
gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 stats-&gt;oerrors =3D 0;<br>&gt;<br>&gt; =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; dev-&gt;data-&gt;nb_tx_que=
ues; i++)<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 eth_tx=
_queue_stats_get(dev-&gt;data-&gt;tx_queues[i], stats);<br>&gt; + =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ark_tx_queue_stats_get(dev-&gt;da=
ta-&gt;tx_queues[i], stats);<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D=
 0; i &lt; dev-&gt;data-&gt;nb_rx_queues; i++)<br>&gt; - =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 eth_rx_queue_stats_get(dev-&gt;data-&gt;rx_=
queues[i], stats);<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 ark_rx_queue_stats_get(dev-&gt;data-&gt;rx_queues[i], stats);<br>&gt; =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ark-&gt;user_ext.stats_get)<br>&gt; =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ark-&gt;user_ext.st=
ats_get(dev, stats,<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ark-&gt;user_data[dev-&gt;data-&gt;p=
ort_id]);<br>&gt; @@ -811,15 +811,15 @@ eth_ark_dev_stats_get(struct rte_et=
h_dev *dev, struct rte_eth_stats *stats)<br>&gt; =C2=A0}<br>&gt;<br>&gt; =
=C2=A0static int<br>&gt; -eth_ark_dev_stats_reset(struct rte_eth_dev *dev)<=
br>&gt; +ark_dev_stats_reset(struct rte_eth_dev *dev)<br>&gt; =C2=A0{<br>&g=
t; =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint16_t i;<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 struct ark_adapter *ark =3D dev-&gt;data-&gt;dev_private;<br>&gt;<br>&g=
t; =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; dev-&gt;data-&gt;nb_tx_=
queues; i++)<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 eth=
_tx_queue_stats_reset(dev-&gt;data-&gt;tx_queues[i]);<br>&gt; + =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ark_tx_queue_stats_reset(dev-&gt;dat=
a-&gt;tx_queues[i]);<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &l=
t; dev-&gt;data-&gt;nb_rx_queues; i++)<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 eth_rx_queue_stats_reset(dev-&gt;data-&gt;rx_queue=
s[i]);<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ark_rx_qu=
eue_stats_reset(dev-&gt;data-&gt;rx_queues[i]);<br>&gt; =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (ark-&gt;user_ext.stats_reset)<br>&gt; =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ark-&gt;user_ext.stats_reset(dev,<br>&gt=
; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 ark-&gt;user_data[dev-&gt;data-&gt;port_id]);<br>&gt; @@ =
-828,7 +828,7 @@ eth_ark_dev_stats_reset(struct rte_eth_dev *dev)<br>&gt; =
=C2=A0}<br>&gt;<br>&gt; =C2=A0static int<br>&gt; -eth_ark_macaddr_add(struc=
t rte_eth_dev *dev,<br>&gt; +ark_macaddr_add(struct rte_eth_dev *dev,<br>&g=
t; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 st=
ruct rte_ether_addr *mac_addr,<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t index,<br>&gt; =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t pool)<br>&=
gt; @@ -847,7 +847,7 @@ eth_ark_macaddr_add(struct rte_eth_dev *dev,<br>&gt=
; =C2=A0}<br>&gt;<br>&gt; =C2=A0static void<br>&gt; -eth_ark_macaddr_remove=
(struct rte_eth_dev *dev, uint32_t index)<br>&gt; +ark_macaddr_remove(struc=
t rte_eth_dev *dev, uint32_t index)<br>&gt; =C2=A0{<br>&gt; =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 struct ark_adapter *ark =3D dev-&gt;data-&gt;dev_private;<br>=
&gt;<br>&gt; @@ -857,7 +857,7 @@ eth_ark_macaddr_remove(struct rte_eth_dev =
*dev, uint32_t index)<br>&gt; =C2=A0}<br>&gt;<br>&gt; =C2=A0static int<br>&=
gt; -eth_ark_set_default_mac_addr(struct rte_eth_dev *dev,<br>&gt; +ark_set=
_default_mac_addr(struct rte_eth_dev *dev,<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0struct rte_ether_addr *mac_addr)<br>&gt; =C2=A0{<br>&gt; =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 struct ark_adapter *ark =3D dev-&gt;data-&gt;dev_private;=
<br>&gt; @@ -871,7 +871,7 @@ eth_ark_set_default_mac_addr(struct rte_eth_de=
v *dev,<br>&gt; =C2=A0}<br>&gt;<br>&gt; =C2=A0static int<br>&gt; -eth_ark_s=
et_mtu(struct rte_eth_dev *dev, uint16_t =C2=A0size)<br>&gt; +ark_set_mtu(s=
truct rte_eth_dev *dev, uint16_t =C2=A0size)<br>&gt; =C2=A0{<br>&gt; =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 struct ark_adapter *ark =3D dev-&gt;data-&gt;dev_priv=
ate;<br>&gt;<br>&gt; @@ -936,7 +936,7 @@ process_file_args(const char *key,=
 const char *value, void *extra_args)<br>&gt; =C2=A0}<br>&gt;<br>&gt; =C2=
=A0static int<br>&gt; -eth_ark_check_args(struct ark_adapter *ark, const ch=
ar *params)<br>&gt; +ark_check_args(struct ark_adapter *ark, const char *pa=
rams)<br>&gt; =C2=A0{<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct rte_kvargs=
 *kvlist;<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int k_idx;<br>&gt; d=
iff --git a/drivers/net/ark/ark_ethdev_rx.c b/drivers/net/ark/ark_ethdev_rx=
.c<br>&gt; index 8b18d93eaa..f221137931 100644<br>&gt; --- a/drivers/net/ar=
k/ark_ethdev_rx.c<br>&gt; +++ b/drivers/net/ark/ark_ethdev_rx.c<br>&gt; @@ =
-22,11 +22,11 @@ struct ark_rx_meta;<br>&gt;<br>&gt; =C2=A0static void dump=
_mbuf_data(struct rte_mbuf *mbuf, uint16_t lo, uint16_t hi);<br>&gt; =C2=A0=
static void ark_ethdev_rx_dump(const char *name, struct ark_rx_queue *queue=
);<br>&gt; -static uint32_t eth_ark_rx_jumbo(struct ark_rx_queue *queue,<br=
>&gt; +static uint32_t ark_rx_jumbo(struct ark_rx_queue *queue,<br>&gt; =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct ark_rx_meta *meta,<br>&gt; =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct rte_mbuf *mbuf0,<br>&gt=
; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t cons_index);<br>&gt; =
-static inline int eth_ark_rx_seed_mbufs(struct ark_rx_queue *queue);<br>&g=
t; +static inline int ark_rx_seed_mbufs(struct ark_rx_queue *queue);<br>&gt=
;<br>&gt; =C2=A0/* ********************************************************=
***************** */<br>&gt; =C2=A0struct __rte_cache_aligned ark_rx_queue =
{<br>&gt; @@ -67,7 +67,7 @@ struct __rte_cache_aligned ark_rx_queue {<br>&g=
t;<br>&gt; =C2=A0/* *******************************************************=
****************** */<br>&gt; =C2=A0static int<br>&gt; -eth_ark_rx_hw_setup=
(struct rte_eth_dev *dev,<br>&gt; +ark_rx_hw_setup(struct rte_eth_dev *dev,=
<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 struct ark_rx_queue *queue,<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint16_t rx_queue_idx)<br>&gt; =C2=A0{<b=
r>&gt; @@ -100,18 +100,18 @@ eth_ark_rx_hw_setup(struct rte_eth_dev *dev,<b=
r>&gt; =C2=A0}<br>&gt;<br>&gt; =C2=A0static inline void<br>&gt; -eth_ark_rx=
_update_cons_index(struct ark_rx_queue *queue, uint32_t cons_index)<br>&gt;=
 +ark_rx_update_cons_index(struct ark_rx_queue *queue, uint32_t cons_index)=
<br>&gt; =C2=A0{<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 queue-&gt;cons_index =
=3D cons_index;<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((cons_index + queue=
-&gt;queue_size - queue-&gt;seed_index) &gt;=3D ARK_RX_MPU_CHUNK) {<br>&gt;=
 - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 eth_ark_rx_seed_mbufs(q=
ueue);<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ark_rx_se=
ed_mbufs(queue);<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 ark_mpu_set_producer(queue-&gt;mpu, queue-&gt;seed_index);<br>&gt; =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>&gt; =C2=A0}<br>&gt;<br>&gt; =C2=A0/* ****=
********************************************************************* */<br=
>&gt; =C2=A0int<br>&gt; -eth_ark_dev_rx_queue_setup(struct rte_eth_dev *dev=
,<br>&gt; +ark_dev_rx_queue_setup(struct rte_eth_dev *dev,<br>&gt; =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0uint16_t queue_idx,<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint16=
_t nb_desc,<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int socket_id,<br>&gt; @=
@ -129,7 +129,7 @@ eth_ark_dev_rx_queue_setup(struct rte_eth_dev *dev,<br>&=
gt;<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* We may already be setup, free me=
mory prior to re-allocation */<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (dev-=
&gt;data-&gt;rx_queues[queue_idx] !=3D NULL) {<br>&gt; - =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 eth_ark_dev_rx_queue_release(dev-&gt;data-&=
gt;rx_queues[queue_idx]);<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ark_dev_rx_queue_release(dev-&gt;data-&gt;rx_queues[queue_idx]);=
<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev-&gt;da=
ta-&gt;rx_queues[queue_idx] =3D NULL;<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 }=
<br>&gt;<br>&gt; @@ -215,7 +215,7 @@ eth_ark_dev_rx_queue_setup(struct rte_=
eth_dev *dev,<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 ark_udm_queue_stats_reset=
(queue-&gt;udm);<br>&gt;<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* populate mb=
uf reserve */<br>&gt; - =C2=A0 =C2=A0 =C2=A0 status =3D eth_ark_rx_seed_mbu=
fs(queue);<br>&gt; + =C2=A0 =C2=A0 =C2=A0 status =3D ark_rx_seed_mbufs(queu=
e);<br>&gt;<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (queue-&gt;seed_index !=
=3D nb_desc) {<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 ARK_PMD_LOG(ERR, &quot;Failed to allocate %u mbufs for RX queue %d\n&qu=
ot;,<br>&gt; @@ -224,7 +224,7 @@ eth_ark_dev_rx_queue_setup(struct rte_eth_=
dev *dev,<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>&gt; =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 /* MPU Setup */<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (status =
=3D=3D 0)<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 status=
 =3D eth_ark_rx_hw_setup(dev, queue, queue_idx);<br>&gt; + =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 status =3D ark_rx_hw_setup(dev, queue, q=
ueue_idx);<br>&gt;<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (unlikely(status =
!=3D 0)) {<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
struct rte_mbuf **mbuf;<br>&gt; @@ -248,7 +248,7 @@ eth_ark_dev_rx_queue_se=
tup(struct rte_eth_dev *dev,<br>&gt;<br>&gt; =C2=A0/* *********************=
**************************************************** */<br>&gt; =C2=A0uint1=
6_t<br>&gt; -eth_ark_recv_pkts(void *rx_queue,<br>&gt; +ark_recv_pkts(void =
*rx_queue,<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 struct rte_mbuf **rx_pkts,<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint16_t nb_pkts)<br>&gt; =C2=A0{<br>&gt; @=
@ -267,7 +267,7 @@ eth_ark_recv_pkts(void *rx_queue,<br>&gt; =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 if (unlikely(nb_pkts =3D=3D 0))<br>&gt; =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>&gt; =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 if (unlikely(queue-&gt;starvation))<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 eth_ark_rx_seed_mbufs(queue);<br>&gt; + =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ark_rx_seed_mbufs(queue);<br>&gt;=
<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 prod_index =3D queue-&gt;prod_index;<b=
r>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 cons_index =3D queue-&gt;cons_index;<br>=
&gt; @@ -318,7 +318,7 @@ eth_ark_recv_pkts(void *rx_queue,<br>&gt; =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>&gt;<br>&gt; =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (unlikely(meta-&gt;pkt_=
len &gt; queue-&gt;dataroom)) {<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t tcons =3D eth_ark_rx=
_jumbo(queue, meta, mbuf, cons_index + 1);<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t tcons =3D =
ark_rx_jumbo(queue, meta, mbuf, cons_index + 1);<br>&gt; =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((int=
32_t)(prod_index - tcons) &gt;=3D 0)<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 cons_index =3D tcons; /* nominal condition */<br>&gt; =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 e=
lse<br>&gt; @@ -340,14 +340,14 @@ eth_ark_recv_pkts(void *rx_queue,<br>&gt;=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rx_user_meta_hook(=
mbuf, meta-&gt;user_meta, queue-&gt;ext_user_data);<br>&gt; =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 }<br>&gt;<br>&gt; - =C2=A0 =C2=A0 =C2=A0 eth_ark_rx_update_co=
ns_index(queue, cons_index);<br>&gt; + =C2=A0 =C2=A0 =C2=A0 ark_rx_update_c=
ons_index(queue, cons_index);<br>&gt;<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 r=
eturn nb;<br>&gt; =C2=A0}<br>&gt;<br>&gt; =C2=A0/* ************************=
************************************************* */<br>&gt; =C2=A0static u=
int32_t<br>&gt; -eth_ark_rx_jumbo(struct ark_rx_queue *queue,<br>&gt; +ark_=
rx_jumbo(struct ark_rx_queue *queue,<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct ark_rx_meta *meta,<br>&gt; =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct rte_mbuf *mbu=
f0,<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u=
int32_t cons_index)<br>&gt; @@ -388,7 +388,7 @@ eth_ark_rx_jumbo(struct ark=
_rx_queue *queue,<br>&gt;<br>&gt; =C2=A0/* Drain the internal queue allowin=
g hw to clear out. */<br>&gt; =C2=A0static void<br>&gt; -eth_ark_rx_queue_d=
rain(struct ark_rx_queue *queue)<br>&gt; +ark_rx_queue_drain(struct ark_rx_=
queue *queue)<br>&gt; =C2=A0{<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 register =
uint32_t cons_index;<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct rte_mbuf *m=
buf;<br>&gt; @@ -400,12 +400,12 @@ eth_ark_rx_queue_drain(struct ark_rx_que=
ue *queue)<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
mbuf =3D queue-&gt;reserve_q[cons_index &amp; queue-&gt;queue_mask];<br>&gt=
; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rte_pktmbuf_free(=
mbuf);<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cons=
_index++;<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 eth_ar=
k_rx_update_cons_index(queue, cons_index);<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ark_rx_update_cons_index(queue, cons_index);<br=
>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>&gt; =C2=A0}<br>&gt;<br>&gt; =C2=A0i=
nt<br>&gt; -eth_ark_dev_rx_queue_count(void *rx_queue)<br>&gt; +ark_dev_rx_=
queue_count(void *rx_queue)<br>&gt; =C2=A0{<br>&gt; =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 struct ark_rx_queue *queue;<br>&gt;<br>&gt; @@ -415,7 +415,7 @@ eth_=
ark_dev_rx_queue_count(void *rx_queue)<br>&gt;<br>&gt; =C2=A0/* ***********=
************************************************************** */<br>&gt; =
=C2=A0int<br>&gt; -eth_ark_rx_start_queue(struct rte_eth_dev *dev, uint16_t=
 queue_id)<br>&gt; +ark_rx_start_queue(struct rte_eth_dev *dev, uint16_t qu=
eue_id)<br>&gt; =C2=A0{<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct ark_rx_q=
ueue *queue;<br>&gt;<br>&gt; @@ -438,7 +438,7 @@ eth_ark_rx_start_queue(str=
uct rte_eth_dev *dev, uint16_t queue_id)<br>&gt; =C2=A0/* Queue can be rest=
arted. =C2=A0 data remains<br>&gt; =C2=A0 */<br>&gt; =C2=A0int<br>&gt; -eth=
_ark_rx_stop_queue(struct rte_eth_dev *dev, uint16_t queue_id)<br>&gt; +ark=
_rx_stop_queue(struct rte_eth_dev *dev, uint16_t queue_id)<br>&gt; =C2=A0{<=
br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct ark_rx_queue *queue;<br>&gt;<br>=
&gt; @@ -455,7 +455,7 @@ eth_ark_rx_stop_queue(struct rte_eth_dev *dev, uin=
t16_t queue_id)<br>&gt;<br>&gt; =C2=A0/* **********************************=
*************************************** */<br>&gt; =C2=A0static inline int<=
br>&gt; -eth_ark_rx_seed_mbufs(struct ark_rx_queue *queue)<br>&gt; +ark_rx_=
seed_mbufs(struct ark_rx_queue *queue)<br>&gt; =C2=A0{<br>&gt; =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 uint32_t limit =3D RTE_ALIGN_FLOOR(queue-&gt;cons_index, =
ARK_RX_MPU_CHUNK) +<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 queue-&gt;queue_size;<br>&gt; @@ -539,7 +539,7 @@ eth_ark_rx_see=
d_mbufs(struct ark_rx_queue *queue)<br>&gt; =C2=A0}<br>&gt;<br>&gt; =C2=A0v=
oid<br>&gt; -eth_ark_rx_dump_queue(struct rte_eth_dev *dev, uint16_t queue_=
id,<br>&gt; +ark_rx_dump_queue(struct rte_eth_dev *dev, uint16_t queue_id,<=
br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 const char *msg)<br>&gt; =C2=A0{<br>&gt; =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 struct ark_rx_queue *queue;<br>&gt; @@ -552,7 +552,7 @@ eth_ark_rx_d=
ump_queue(struct rte_eth_dev *dev, uint16_t queue_id,<br>&gt; =C2=A0/* ****=
********************************************************************* */<br=
>&gt; =C2=A0/* Call on device closed no user API, queue is stopped */<br>&g=
t; =C2=A0void<br>&gt; -eth_ark_dev_rx_queue_release(void *vqueue)<br>&gt; +=
ark_dev_rx_queue_release(void *vqueue)<br>&gt; =C2=A0{<br>&gt; =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 struct ark_rx_queue *queue;<br>&gt;<br>&gt; @@ -565,7 +56=
5,7 @@ eth_ark_dev_rx_queue_release(void *vqueue)<br>&gt; =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ark_mpu_stop(queue-&gt;mpu);<br>&gt;<br>&gt; =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 /* Need to clear out mbufs here, dropping packets along the way =
*/<br>&gt; - =C2=A0 =C2=A0 =C2=A0 eth_ark_rx_queue_drain(queue);<br>&gt; + =
=C2=A0 =C2=A0 =C2=A0 ark_rx_queue_drain(queue);<br>&gt;<br>&gt; =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 rte_free(queue-&gt;reserve_q);<br>&gt; =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 rte_free(queue-&gt;paddress_q);<br>&gt; @@ -573,7 +573,7 @@ eth_=
ark_dev_rx_queue_release(void *vqueue)<br>&gt; =C2=A0}<br>&gt;<br>&gt; =C2=
=A0void<br>&gt; -eth_rx_queue_stats_get(void *vqueue, struct rte_eth_stats =
*stats)<br>&gt; +ark_rx_queue_stats_get(void *vqueue, struct rte_eth_stats =
*stats)<br>&gt; =C2=A0{<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct ark_rx_q=
ueue *queue;<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct ark_udm_t *udm;<br>=
&gt; @@ -596,7 +596,7 @@ eth_rx_queue_stats_get(void *vqueue, struct rte_et=
h_stats *stats)<br>&gt; =C2=A0}<br>&gt;<br>&gt; =C2=A0void<br>&gt; -eth_rx_=
queue_stats_reset(void *vqueue)<br>&gt; +ark_rx_queue_stats_reset(void *vqu=
eue)<br>&gt; =C2=A0{<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct ark_rx_queu=
e *queue;<br>&gt;<br>&gt; diff --git a/drivers/net/ark/ark_ethdev_rx.h b/dr=
ivers/net/ark/ark_ethdev_rx.h<br>&gt; index 12d4f61637..7a5bab20a9 100644<b=
r>&gt; --- a/drivers/net/ark/ark_ethdev_rx.h<br>&gt; +++ b/drivers/net/ark/=
ark_ethdev_rx.h<br>&gt; @@ -11,21 +11,21 @@<br>&gt; =C2=A0#include &lt;rte_=
mempool.h&gt;<br>&gt; =C2=A0#include &lt;ethdev_driver.h&gt;<br>&gt;<br>&gt=
; -int eth_ark_dev_rx_queue_setup(struct rte_eth_dev *dev,<br>&gt; +int ark=
_dev_rx_queue_setup(struct rte_eth_dev *dev,<br>&gt; =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0uint16_t queue_idx,<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0uint16_t nb_desc,<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0un=
signed int socket_id,<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const str=
uct rte_eth_rxconf *rx_conf,<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0st=
ruct rte_mempool *mp);<br>&gt; -int eth_ark_dev_rx_queue_count(void *rx_que=
ue);<br>&gt; -int eth_ark_rx_stop_queue(struct rte_eth_dev *dev, uint16_t q=
ueue_id);<br>&gt; -int eth_ark_rx_start_queue(struct rte_eth_dev *dev, uint=
16_t queue_id);<br>&gt; -uint16_t eth_ark_recv_pkts(void *rx_queue, struct =
rte_mbuf **rx_pkts,<br>&gt; +int ark_dev_rx_queue_count(void *rx_queue);<br=
>&gt; +int ark_rx_stop_queue(struct rte_eth_dev *dev, uint16_t queue_id);<b=
r>&gt; +int ark_rx_start_queue(struct rte_eth_dev *dev, uint16_t queue_id);=
<br>&gt; +uint16_t ark_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,=
<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint16_t nb_pkts);<br>&gt; -void eth_ark_dev=
_rx_queue_release(void *rx_queue);<br>&gt; -void eth_rx_queue_stats_get(voi=
d *vqueue, struct rte_eth_stats *stats);<br>&gt; -void eth_rx_queue_stats_r=
eset(void *vqueue);<br>&gt; -void eth_ark_rx_dump_queue(struct rte_eth_dev =
*dev, uint16_t queue_id,<br>&gt; +void ark_dev_rx_queue_release(void *rx_qu=
eue);<br>&gt; +void ark_rx_queue_stats_get(void *vqueue, struct rte_eth_sta=
ts *stats);<br>&gt; +void ark_rx_queue_stats_reset(void *vqueue);<br>&gt; +=
void ark_rx_dump_queue(struct rte_eth_dev *dev, uint16_t queue_id,<br>&gt; =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0const char *msg);<br>&gt;<br>&gt; =C2=A0#endif<br>&=
gt; diff --git a/drivers/net/ark/ark_ethdev_tx.c b/drivers/net/ark/ark_ethd=
ev_tx.c<br>&gt; index ca6cd297a1..2c61cd5486 100644<br>&gt; --- a/drivers/n=
et/ark/ark_ethdev_tx.c<br>&gt; +++ b/drivers/net/ark/ark_ethdev_tx.c<br>&gt=
; @@ -53,15 +53,15 @@ struct __rte_cache_aligned ark_tx_queue {<br>&gt; =C2=
=A0};<br>&gt;<br>&gt; =C2=A0/* Forward declarations */<br>&gt; -static int =
eth_ark_tx_jumbo(struct ark_tx_queue *queue,<br>&gt; +static int ark_tx_jum=
bo(struct ark_tx_queue *queue,<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct rte_m=
buf *mbuf,<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t *user_meta, uint8_t meta=
_cnt);<br>&gt; -static int eth_ark_tx_hw_queue_config(struct ark_tx_queue *=
queue);<br>&gt; +static int ark_tx_hw_queue_config(struct ark_tx_queue *que=
ue);<br>&gt; =C2=A0static void free_completed_tx(struct ark_tx_queue *queue=
);<br>&gt;<br>&gt; =C2=A0/* ***********************************************=
************************** */<br>&gt; =C2=A0static inline void<br>&gt; -eth=
_ark_tx_desc_fill(struct ark_tx_queue *queue,<br>&gt; +ark_tx_desc_fill(str=
uct ark_tx_queue *queue,<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct rte_mbuf *mbuf,<br>&gt; =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint8_t =
=C2=A0flags,<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0uint32_t *user_meta,<br>&gt; @@ -101,7 +101,7 @@ et=
h_ark_tx_desc_fill(struct ark_tx_queue *queue,<br>&gt;<br>&gt; =C2=A0/* ***=
********************************************************************** */<b=
r>&gt; =C2=A0uint16_t<br>&gt; -eth_ark_xmit_pkts(void *vtxq, struct rte_mbu=
f **tx_pkts, uint16_t nb_pkts)<br>&gt; +ark_xmit_pkts(void *vtxq, struct rt=
e_mbuf **tx_pkts, uint16_t nb_pkts)<br>&gt; =C2=A0{<br>&gt; =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 struct ark_tx_queue *queue;<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 struct rte_mbuf *mbuf;<br>&gt; @@ -159,12 +159,12 @@ eth_ark_xmit_pkts(=
void *vtxq, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)<br>&gt; =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 t=
x_user_meta_hook(mbuf, user_meta, &amp;user_len,<br>&gt; =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 queue-&gt;ext_user_=
data);<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (=
unlikely(mbuf-&gt;nb_segs !=3D 1)) {<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stat =3D eth_ark_tx_jumbo(=
queue, mbuf,<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 stat =3D ark_tx_jumbo(queue, mbuf,<br>&gt; =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 user_meta, user_len);<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (unlikely(stat !=3D=
 0))<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break; =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0/* Queue is full */<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 eth_ark_tx_desc_fill(queue=
, mbuf,<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 ark_tx_desc_fill(queue, mbuf,<br>&gt; =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AR=
K_DDM_SOP | ARK_DDM_EOP,<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0user_meta, user_len);<br>&gt; =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>&gt; @@ -195,7=
 +195,7 @@ eth_ark_xmit_pkts(void *vtxq, struct rte_mbuf **tx_pkts, uint16_=
t nb_pkts)<br>&gt;<br>&gt; =C2=A0/* ***************************************=
********************************** */<br>&gt; =C2=A0static int<br>&gt; -eth=
_ark_tx_jumbo(struct ark_tx_queue *queue, struct rte_mbuf *mbuf,<br>&gt; +a=
rk_tx_jumbo(struct ark_tx_queue *queue, struct rte_mbuf *mbuf,<br>&gt; =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t *user_m=
eta, uint8_t meta_cnt)<br>&gt; =C2=A0{<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
struct rte_mbuf *next;<br>&gt; @@ -212,7 +212,7 @@ eth_ark_tx_jumbo(struct =
ark_tx_queue *queue, struct rte_mbuf *mbuf,<br>&gt; =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 next =3D mbuf-&gt;next;<br>&gt; =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flags |=3D (next =3D=3D NU=
LL) ? ARK_DDM_EOP : 0;<br>&gt;<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 eth_ark_tx_desc_fill(queue, mbuf, flags, user_meta, meta_cnt=
);<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ark_tx_desc_f=
ill(queue, mbuf, flags, user_meta, meta_cnt);<br>&gt;<br>&gt; =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flags &amp;=3D ~ARK_DDM_SOP; =C2=
=A0/* drop SOP flags */<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 meta_cnt =3D 0; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Meta on=
ly on SOP */<br>&gt; @@ -224,7 +224,7 @@ eth_ark_tx_jumbo(struct ark_tx_que=
ue *queue, struct rte_mbuf *mbuf,<br>&gt;<br>&gt; =C2=A0/* ****************=
********************************************************* */<br>&gt; =C2=A0=
int<br>&gt; -eth_ark_tx_queue_setup(struct rte_eth_dev *dev,<br>&gt; +ark_t=
x_queue_setup(struct rte_eth_dev *dev,<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint16_t queue_idx,<=
br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0uint16_t nb_desc,<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int socket_id,=
<br>&gt; @@ -291,7 +291,7 @@ eth_ark_tx_queue_setup(struct rte_eth_dev *dev=
,<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 queue-&gt;ddm =3D RTE_PTR_ADD(ark-&gt=
;ddm.v, qidx * ARK_DDM_QOFFSET);<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 queue-=
&gt;mpu =3D RTE_PTR_ADD(ark-&gt;mputx.v, qidx * ARK_MPU_QOFFSET);<br>&gt;<b=
r>&gt; - =C2=A0 =C2=A0 =C2=A0 status =3D eth_ark_tx_hw_queue_config(queue);=
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 status =3D ark_tx_hw_queue_config(queue);<b=
r>&gt;<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (unlikely(status !=3D 0)) {<b=
r>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rte_free(que=
ue-&gt;meta_q);<br>&gt; @@ -305,7 +305,7 @@ eth_ark_tx_queue_setup(struct r=
te_eth_dev *dev,<br>&gt;<br>&gt; =C2=A0/* *********************************=
**************************************** */<br>&gt; =C2=A0static int<br>&gt=
; -eth_ark_tx_hw_queue_config(struct ark_tx_queue *queue)<br>&gt; +ark_tx_h=
w_queue_config(struct ark_tx_queue *queue)<br>&gt; =C2=A0{<br>&gt; =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 rte_iova_t queue_base, ring_base, cons_index_addr;<br>=
&gt;<br>&gt; @@ -333,7 +333,7 @@ eth_ark_tx_hw_queue_config(struct ark_tx_q=
ueue *queue)<br>&gt;<br>&gt; =C2=A0/* *************************************=
************************************ */<br>&gt; =C2=A0void<br>&gt; -eth_ark=
_tx_queue_release(void *vtx_queue)<br>&gt; +ark_tx_queue_release(void *vtx_=
queue)<br>&gt; =C2=A0{<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct ark_tx_qu=
eue *queue;<br>&gt;<br>&gt; @@ -352,7 +352,7 @@ eth_ark_tx_queue_release(vo=
id *vtx_queue)<br>&gt;<br>&gt; =C2=A0/* ***********************************=
************************************** */<br>&gt; =C2=A0int<br>&gt; -eth_ar=
k_tx_queue_stop(struct rte_eth_dev *dev, uint16_t queue_id)<br>&gt; +ark_tx=
_queue_stop(struct rte_eth_dev *dev, uint16_t queue_id)<br>&gt; =C2=A0{<br>=
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct ark_tx_queue *queue;<br>&gt; =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 int cnt =3D 0;<br>&gt; @@ -376,7 +376,7 @@ eth_ark_tx=
_queue_stop(struct rte_eth_dev *dev, uint16_t queue_id)<br>&gt; =C2=A0}<br>=
&gt;<br>&gt; =C2=A0int<br>&gt; -eth_ark_tx_queue_start(struct rte_eth_dev *=
dev, uint16_t queue_id)<br>&gt; +ark_tx_queue_start(struct rte_eth_dev *dev=
, uint16_t queue_id)<br>&gt; =C2=A0{<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 st=
ruct ark_tx_queue *queue;<br>&gt;<br>&gt; @@ -415,7 +415,7 @@ free_complete=
d_tx(struct ark_tx_queue *queue)<br>&gt;<br>&gt; =C2=A0/* *****************=
******************************************************** */<br>&gt; =C2=A0v=
oid<br>&gt; -eth_tx_queue_stats_get(void *vqueue, struct rte_eth_stats *sta=
ts)<br>&gt; +ark_tx_queue_stats_get(void *vqueue, struct rte_eth_stats *sta=
ts)<br>&gt; =C2=A0{<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct ark_tx_queue=
 *queue;<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct ark_ddm_t *ddm;<br>&gt;=
 @@ -435,7 +435,7 @@ eth_tx_queue_stats_get(void *vqueue, struct rte_eth_st=
ats *stats)<br>&gt; =C2=A0}<br>&gt;<br>&gt; =C2=A0void<br>&gt; -eth_tx_queu=
e_stats_reset(void *vqueue)<br>&gt; +ark_tx_queue_stats_reset(void *vqueue)=
<br>&gt; =C2=A0{<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct ark_tx_queue *q=
ueue;<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct ark_ddm_t *ddm;<br>&gt; di=
ff --git a/drivers/net/ark/ark_ethdev_tx.h b/drivers/net/ark/ark_ethdev_tx.=
h<br>&gt; index 7134dbfeed..ee66ed19cc 100644<br>&gt; --- a/drivers/net/ark=
/ark_ethdev_tx.h<br>&gt; +++ b/drivers/net/ark/ark_ethdev_tx.h<br>&gt; @@ -=
10,18 +10,18 @@<br>&gt; =C2=A0#include &lt;ethdev_driver.h&gt;<br>&gt;<br>&=
gt;<br>&gt; -uint16_t eth_ark_xmit_pkts(void *vtxq,<br>&gt; +uint16_t ark_x=
mit_pkts(void *vtxq,<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct rte_mbuf **tx_pk=
ts,<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint16_t nb_pkts);<br>&gt; -int eth_ark_t=
x_queue_setup(struct rte_eth_dev *dev,<br>&gt; +int ark_tx_queue_setup(stru=
ct rte_eth_dev *dev,<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint16_t queue_idx,<br>=
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0uint16_t nb_desc,<br>&gt; =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0unsigned int socket_id,<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const struct rte=
_eth_txconf *tx_conf);<br>&gt; -void eth_ark_tx_queue_release(void *vtx_que=
ue);<br>&gt; -int eth_ark_tx_queue_stop(struct rte_eth_dev *dev, uint16_t q=
ueue_id);<br>&gt; -int eth_ark_tx_queue_start(struct rte_eth_dev *dev, uint=
16_t queue_id);<br>&gt; -void eth_tx_queue_stats_get(void *vqueue, struct r=
te_eth_stats *stats);<br>&gt; -void eth_tx_queue_stats_reset(void *vqueue);=
<br>&gt; +void ark_tx_queue_release(void *vtx_queue);<br>&gt; +int ark_tx_q=
ueue_stop(struct rte_eth_dev *dev, uint16_t queue_id);<br>&gt; +int ark_tx_=
queue_start(struct rte_eth_dev *dev, uint16_t queue_id);<br>&gt; +void ark_=
tx_queue_stats_get(void *vqueue, struct rte_eth_stats *stats);<br>&gt; +voi=
d ark_tx_queue_stats_reset(void *vqueue);<br>&gt;<br>&gt; =C2=A0#endif<br>&=
gt; --<br>&gt; 2.47.3<br>&gt;<br></div>

--0000000000001b9c210640be6e62--
