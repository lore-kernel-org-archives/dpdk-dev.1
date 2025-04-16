Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E3DAC369BD
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Apr 2025 07:32:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D2759406B8;
	Wed, 16 Apr 2025 09:32:24 +0200 (CEST)
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com
 [209.85.221.180])
 by mails.dpdk.org (Postfix) with ESMTP id 64CF040279
 for <dev@dpdk.org>; Wed, 16 Apr 2025 09:32:23 +0200 (CEST)
Received: by mail-vk1-f180.google.com with SMTP id
 71dfb90a1353d-51eb1818d4fso6772967e0c.1
 for <dev@dpdk.org>; Wed, 16 Apr 2025 00:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744788742; x=1745393542; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FcvMjQQqjIJyH7CBPSXiIgiw8c2ti+bOrFZdIuI9kew=;
 b=FPe68clW/iF0u5eARlTNal4aLjaT1LYv6s1Ues7V+ykJidWTqpxi2SODCdAaXXu421
 JLGvC7gNDxE7ydYUzlW+fNE/Rs5AwUIqfMjjer1hYJvJaew4DbxD4QsKUIolgR31Pyea
 AeF94cJFn3U86n2/B/QmStN4295gUBLr0JtltJalbtRssmL+O9Rt22lOqT8XSFW2eHxj
 VZDLVnkHuwK48u7ZqdAW23huLUlABUK/FA82K2Gv+ePTBkWuptJ/wlBdEculG0CAUgJE
 3UtbR6pjq0O7l5KtVDMqfugewhVCRfTgbyc76GerRCOH4YFI+537z3RUQi8Vtff/YJso
 HjOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744788742; x=1745393542;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FcvMjQQqjIJyH7CBPSXiIgiw8c2ti+bOrFZdIuI9kew=;
 b=VnlpuOylVwRR1er1nZ9E3bAHUPqWmXv5aKcAqyt2r/JFtE3T2FlYeVNMEUdeupTYTR
 O6NeNJZ5a6n66ytoE1cRUzS6MeB4dc1UdrinfKdShvDZgt5xyvfEmpJ7CCqWKxUR5h/K
 SGyXsuWUHfpVVz9JFFW+S5q3aobd27aJvYq7yHrYz8D2fqOBqkERtRrFVqdgnNhXlRf7
 uHXzc9JF4B6RYbuFTq2D3dczP+QW4az8eqUKVYhP1sm5jW4LhET9uUMtNSRUpsSzol9F
 KIVsLY1NQ5ovy9maFRdNOwRh3jMKgL+9kF1U3lt+DD8c1viaiC4qde6qrMbbBvogPBHC
 4AUQ==
X-Gm-Message-State: AOJu0YxER87/H6lqEJh+252LwhGO/V9TBRDaUg6MA5taWngGHHa3/wWe
 7luweYds+U3PtipQBqwm49Dx9ei+EMJszcOoRZIs4I3ea3FaUCwFxV+L8QZnVCKwmEN7+svTqH8
 NhBszdOouShaTiXE+W98OyOaQGLk=
X-Gm-Gg: ASbGncuQeNPJNk+Zqxy3RIkftEddQGFuMITTD8n2mSJK/pWDgNgp4r71fH4AXoR0jHa
 xFLsR+D99L63l9dZVFdb+SVxBqCP7iFuTPmWGG34vWh4eqyiPujgdpAL7c8xNBqaAaJuX7FZ/p0
 MZgDdLGbVPfZ4ruBioT84hvsNxP+ZqpMs0gA==
X-Google-Smtp-Source: AGHT+IH6SgD6BiVLa2mksfjrf94xO54/iNLHM4NOoCjvq5iykvf5mKS3BQ+jxP4eXXu0LrtWLrKYTC6NUEnxSLb+gaE=
X-Received: by 2002:a05:6102:310d:b0:4c3:6544:c250 with SMTP id
 ada2fe7eead31-4cb593194b4mr184610137.23.1744788742503; Wed, 16 Apr 2025
 00:32:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250415121052.1497155-1-adwivedi@marvell.com>
 <20250415121052.1497155-3-adwivedi@marvell.com>
In-Reply-To: <20250415121052.1497155-3-adwivedi@marvell.com>
From: Nitin Saxena <nsaxena16@gmail.com>
Date: Wed, 16 Apr 2025 13:02:11 +0530
X-Gm-Features: ATxdqUHjM3bE2NyqYIx3yyd4w_2VQHhCQkZh3tRi9XxgRdm0r3u5h-qDHssb_iU
Message-ID: <CAG6-93x0TTnbE9sR81W4xRMmT1TPSG25OUK80ftEYf_65KqDJg@mail.gmail.com>
Subject: Re: [PATCH v1 02/12] node: add IP4 lookup FIB node
To: Ankur Dwivedi <adwivedi@marvell.com>
Cc: dev@dpdk.org, jerinj@marvell.com, vladimir.medvedkin@intel.com, 
 ndabilpuram@marvell.com, pbhagavatula@marvell.com, skori@marvell.com, 
 rkudurumalla@marvell.com
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

Hi Ankur,

Please see my comments inline below

Thanks,
Nitin

On Tue, Apr 15, 2025 at 5:41=E2=80=AFPM Ankur Dwivedi <adwivedi@marvell.com=
> wrote:
>
> Adds a lookup FIB node for IP4.
>
> Signed-off-by: Ankur Dwivedi <adwivedi@marvell.com>
> ---
>  lib/node/ip4_lookup_fib.c | 127 ++++++++++++++++++++++++++++++++++++++
>  lib/node/meson.build      |   3 +-
>  2 files changed, 129 insertions(+), 1 deletion(-)
>  create mode 100644 lib/node/ip4_lookup_fib.c
>
> diff --git a/lib/node/ip4_lookup_fib.c b/lib/node/ip4_lookup_fib.c
> new file mode 100644
> index 0000000000..9c71610718
> --- /dev/null
> +++ b/lib/node/ip4_lookup_fib.c
> @@ -0,0 +1,127 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright(C) 2025 Marvell.
> + */
> +
> +#include <rte_errno.h>
> +#include <rte_ether.h>
> +#include <rte_fib.h>
> +#include <rte_graph.h>
> +#include <rte_graph_worker.h>
> +#include <rte_ip.h>
> +
> +#include "rte_node_ip4_api.h"
> +
> +#include "node_private.h"
> +
> +/* IP4 Lookup global data struct */
> +struct ip4_lookup_fib_node_main {
> +       struct rte_fib *fib[RTE_MAX_NUMA_NODES];
> +};
> +
> +struct ip4_lookup_fib_node_ctx {
> +       /* Socket's FIB */
> +       struct rte_fib *fib;
> +       /* Dynamic offset to mbuf priv1 */
> +       int mbuf_priv1_off;
> +};
> +
> +static struct ip4_lookup_fib_node_main ip4_lookup_fib_nm;
> +
> +#define FIB_MAX_ROUTES (1 << 16)
> +#define FIB_NUM_TBL8   (1 << 15)
> +#define FIB_DEFAULT_NH 999

These macros may not be required if we expose public setup_api() with
arguments. See below

> +
> +#define IP4_LOOKUP_NODE_FIB(ctx) \
> +       (((struct ip4_lookup_fib_node_ctx *)ctx)->fib)
> +
> +#define IP4_LOOKUP_NODE_PRIV1_OFF(ctx) \
> +       (((struct ip4_lookup_fib_node_ctx *)ctx)->mbuf_priv1_off)
> +
> +static int
> +setup_fib(unsigned int socket)

Should we add public API to allow applications to control MAX_ROUTES?
In a typical stack multiple fibs can be set up for each VRF (~~ port_id).

A public API:

int rte_ip4_lookup_fib_setup(int fib_index, int port_id, uint32_t
max_routes) where

For now we can assume fib_index =3D=3D 0, is global fib table (can be
extended to VRF later). Socket_id can be determined from port_Id

> +{
> +       struct ip4_lookup_fib_node_main *nm =3D &ip4_lookup_fib_nm;
> +       struct rte_fib_conf conf;
> +       char s[RTE_FIB_NAMESIZE];
> +
> +       /* One fib per socket */
> +       if (nm->fib[socket])
> +               return 0;
> +
> +       conf.type =3D RTE_FIB_DIR24_8;
> +       conf.default_nh =3D FIB_DEFAULT_NH;

FIB_DEFAULT_NH can be defined in such a way, fast path can decode
next_edge from return of rte_fib_lookup_bulk()
Like
union {
   struct u64;
   struct {
       uint32_t next_hop_id;
       uint16_t  next_edge;
       uint16_t. reserved;
   };
} rte_ip4_lookup_fib_nexthop_t;

FIB_DEFAULT_NH should be set as

rte_ip4_lookup_fib_nexthop_t default_next_hop =3D {.next_edge =3D
IP4_FIB_LOOKUP_NEXT_DROP}

This way in fast path a return from fib_bulk() can be directly used to
send packet to pkt_drop node

> +       conf.max_routes =3D FIB_MAX_ROUTES;
> +       conf.rib_ext_sz =3D 0;
> +       conf.dir24_8.nh_sz =3D RTE_FIB_DIR24_8_4B;
> +       conf.dir24_8.num_tbl8 =3D FIB_NUM_TBL8;
> +       conf.flags =3D 0;
> +       snprintf(s, sizeof(s), "IPV4_LOOKUP_FIB_%d", socket);
> +       nm->fib[socket] =3D rte_fib_create(s, socket, &conf);
> +       if (nm->fib[socket] =3D=3D NULL)
> +               return -rte_errno;
> +
> +       return 0;
> +}
> +
> +static int
> +ip4_lookup_fib_node_init(const struct rte_graph *graph, struct rte_node =
*node)
> +{
> +       static uint8_t init_once;
> +       unsigned int socket;
> +       uint16_t lcore_id;
> +       int rc;
> +
> +       RTE_BUILD_BUG_ON(sizeof(struct ip4_lookup_fib_node_ctx) > RTE_NOD=
E_CTX_SZ);
> +
> +       if (!init_once) {
> +               node_mbuf_priv1_dynfield_offset =3D rte_mbuf_dynfield_reg=
ister(
> +                               &node_mbuf_priv1_dynfield_desc);
> +               if (node_mbuf_priv1_dynfield_offset < 0)
> +                       return -rte_errno;

You may need to rebase this patch on top of
https://patches.dpdk.org/project/dpdk/patch/20250409135554.2180390-2-nsaxen=
a@marvell.com/
for using global mbuf field

> +
> +               /* Setup FIB for all sockets */
> +               RTE_LCORE_FOREACH(lcore_id)

Instead can be use rte_socket_count() which allow to loop for socket
instead of port? Ideally we may need to add fib for virtual interfaces
or VRF (later)

> +               {
> +                       socket =3D rte_lcore_to_socket_id(lcore_id);
> +                       rc =3D setup_fib(socket);
> +                       if (rc) {
> +                               node_err("ip4_lookup_fib",
> +                                        "Failed to setup fib for sock %u=
, rc=3D%d",
> +                                        socket, rc);
> +                               return rc;
> +                       }
> +               }
> +               init_once =3D 1;
> +       }
> +
> +       /* Update socket's FIB and mbuf dyn priv1 offset in node ctx */
> +       IP4_LOOKUP_NODE_FIB(node->ctx) =3D ip4_lookup_fib_nm.fib[graph->s=
ocket];
> +       IP4_LOOKUP_NODE_PRIV1_OFF(node->ctx) =3D node_mbuf_priv1_dynfield=
_offset;
> +
> +       node_dbg("ip4_lookup_fib", "Initialized ip4_lookup_fib node");
> +
> +       return 0;
> +}
> +
> +static struct rte_node_xstats ip4_lookup_fib_xstats =3D {
> +       .nb_xstats =3D 1,
> +       .xstat_desc =3D {
> +               [0] =3D "ip4_lookup_fib_error",
> +       },
> +};
> +
> +static struct rte_node_register ip4_lookup_fib_node =3D {
> +       .name =3D "ip4_lookup_fib",
> +
> +       .init =3D ip4_lookup_fib_node_init,
> +       .xstats =3D &ip4_lookup_fib_xstats,
> +
> +       .nb_edges =3D RTE_NODE_IP4_LOOKUP_NEXT_PKT_DROP + 1,
> +       .next_nodes =3D {
> +               [RTE_NODE_IP4_LOOKUP_NEXT_IP4_LOCAL] =3D "ip4_local",
> +               [RTE_NODE_IP4_LOOKUP_NEXT_REWRITE] =3D "ip4_rewrite",
> +               [RTE_NODE_IP4_LOOKUP_NEXT_PKT_DROP] =3D "pkt_drop",
> +       },
> +};
> +
> +RTE_NODE_REGISTER(ip4_lookup_fib_node);
> diff --git a/lib/node/meson.build b/lib/node/meson.build
> index 0bed97a96c..d2011c8f56 100644
> --- a/lib/node/meson.build
> +++ b/lib/node/meson.build
> @@ -13,6 +13,7 @@ sources =3D files(
>          'ethdev_tx.c',
>          'ip4_local.c',
>          'ip4_lookup.c',
> +        'ip4_lookup_fib.c',
>          'ip4_reassembly.c',
>          'ip4_rewrite.c',
>          'ip6_lookup.c',
> @@ -34,4 +35,4 @@ headers =3D files(
>
>  # Strict-aliasing rules are violated by uint8_t[] to context size casts.
>  cflags +=3D '-fno-strict-aliasing'
> -deps +=3D ['graph', 'mbuf', 'lpm', 'ethdev', 'mempool', 'cryptodev', 'ip=
_frag']
> +deps +=3D ['graph', 'mbuf', 'lpm', 'ethdev', 'mempool', 'cryptodev', 'ip=
_frag', 'fib']
> --
> 2.25.1
>
