Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2940C369BA
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Apr 2025 07:55:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 82DB9406B8;
	Wed, 16 Apr 2025 09:55:04 +0200 (CEST)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com
 [209.85.222.49]) by mails.dpdk.org (Postfix) with ESMTP id 6415040279
 for <dev@dpdk.org>; Wed, 16 Apr 2025 09:55:03 +0200 (CEST)
Received: by mail-ua1-f49.google.com with SMTP id
 a1e0cc1a2514c-86d3907524cso2475747241.0
 for <dev@dpdk.org>; Wed, 16 Apr 2025 00:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744790102; x=1745394902; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C051Tm/tTEWFPvm12vDgcHM7vOhPD1IEKpYwE46FC1U=;
 b=SFdnBROI6at9FcGw1R6vy/rm950iARIZNTzZgBcBAoxZmBDOdgTloC9oQZiGedKVLC
 4mf0baSRiuh7Zqlukq0e0sVwHJrYtBQQklk5S5zy+bZoNG0khPt/A+wkAuOvcJgH6wVA
 5JIx3N7HQk/AG4p4tHhv1QMyyS0eoUL6NYgDI6hWNnRnXJzt0Oym3FXW/ifEDs4AeKgU
 2YTqCLWCkM/QvTWQAWuXoHepppsYZKjZ/OzImI8oOQqm5+LCzsAhpWHWxw8ONzJ9Szkp
 oGR0k0bfqLrsFp0Yhwdo+MqJ+yUDnnujkG/LguwwZQtL5BcVL7kynfOaa+Ul/8jyvlWU
 HeKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744790102; x=1745394902;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C051Tm/tTEWFPvm12vDgcHM7vOhPD1IEKpYwE46FC1U=;
 b=A9MkzYwdhoCyv6s/zRrSbZXBkixrSGAtJxxaJKYl2viMWMRIWk8Yo9IM+8b+vyrWRv
 B8lHliVFiESQkX5lC/XCz/WdgOJXEHSbS74z3PJGKE6PZOtm9BXwXEK0Vy5xKquasGnR
 K1HNKR6GyF8AqO+jyjS54hwMFI4YKzhRR/FQc4/UIYcRNcyLbBKnSyd5x+iTFcxUeOQj
 jfTjXgxQ8Eln3m9++zod7J7hDbkqCNmukF9J8OeXK8IGZkqdNhuvcDFyKt58JgIAOzWb
 DN7ZWICbymrj4gQhBOXGGp9hCdEbqDjm/N9AitZo/VF+Bby4VP3WhfBwMOIQ0r6yc37C
 0SRA==
X-Gm-Message-State: AOJu0YzDoo471eAmu8AabqKtgtjbpafkk0mLqPkY0rHzFof+p3xwzlM1
 TOodw7t22I8M1DC+jSaEghdPPb2/Vv76magHdPvgCvehd4uY2ROW52rpLa1LJr3OFjTHsXXUwkf
 SM7Ra/Nf1siHiEOw568ibA8ZbgP4=
X-Gm-Gg: ASbGncuXmOb+0PhV4WiMU6GHX6pTl6qG3iTUSl/hsENi3CJRKFaJsXUdhMTGivhf2gI
 VV6AFlJo1qAEw+3zyiUPJjzE2f2ZbzH169WcoNX4o1mLX4SAaOWnu1tW/8uonY6ZhA5g6P0KsWR
 lGGE+O5el36cgqN+qzJXqf4/Q=
X-Google-Smtp-Source: AGHT+IGu6pnLLODwKjWn7O1m3wfCWNgibNZ4QbPRWWZpbFoGUSNhUgehSYa0OceVLrRlbx7FEFdDMySOqtONV+kkswI=
X-Received: by 2002:a05:6102:2329:b0:4c5:904d:f358 with SMTP id
 ada2fe7eead31-4cb592e0afcmr192570137.23.1744790102686; Wed, 16 Apr 2025
 00:55:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250415121052.1497155-1-adwivedi@marvell.com>
 <20250415121052.1497155-5-adwivedi@marvell.com>
In-Reply-To: <20250415121052.1497155-5-adwivedi@marvell.com>
From: Nitin Saxena <nsaxena16@gmail.com>
Date: Wed, 16 Apr 2025 13:24:50 +0530
X-Gm-Features: ATxdqUHZa1ICGu8IXf1a3vK17hI1fIwtIEmVAjlTVRHFV5NWkihz_Lc2YQ0ey1Y
Message-ID: <CAG6-93wOdPnGS9kLoRmJTS41x=W7kY0bMu5_bNbosDXg1KjdDQ@mail.gmail.com>
Subject: Re: [PATCH v1 04/12] node: add process callback for IP4 FIB
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

Same comments apply to IPv6 nodes as well. See for ip4 lookup comments

Thanks,
Nitin

On Tue, Apr 15, 2025 at 6:20=E2=80=AFPM Ankur Dwivedi <adwivedi@marvell.com=
> wrote:
>
> Adds the process callback function for ip4_lookup_fib node.
>
> Signed-off-by: Ankur Dwivedi <adwivedi@marvell.com>
> ---
>  lib/node/ip4_lookup_fib.c | 164 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 164 insertions(+)
>
> diff --git a/lib/node/ip4_lookup_fib.c b/lib/node/ip4_lookup_fib.c
> index e87864e672..c535b191f8 100644
> --- a/lib/node/ip4_lookup_fib.c
> +++ b/lib/node/ip4_lookup_fib.c
> @@ -40,6 +40,169 @@ static struct ip4_lookup_fib_node_main ip4_lookup_fib=
_nm;
>  #define IP4_LOOKUP_NODE_PRIV1_OFF(ctx) \
>         (((struct ip4_lookup_fib_node_ctx *)ctx)->mbuf_priv1_off)
>
> +static uint16_t
> +ip4_lookup_fib_node_process(struct rte_graph *graph, struct rte_node *no=
de, void **objs,
> +                           uint16_t nb_objs)
> +{
> +       struct rte_mbuf *mbuf0, *mbuf1, *mbuf2, *mbuf3, **pkts;
> +       struct rte_fib *fib =3D IP4_LOOKUP_NODE_FIB(node->ctx);
> +       const int dyn =3D IP4_LOOKUP_NODE_PRIV1_OFF(node->ctx);
> +       struct rte_ipv4_hdr *ipv4_hdr;
> +       uint64_t next_hop[nb_objs];
> +       uint16_t lookup_err =3D 0;
> +       void **to_next, **from;
> +       uint16_t last_spec =3D 0;
> +       rte_edge_t next_index;
> +       uint16_t n_left_from;
> +       uint32_t ip[nb_objs];
> +       uint16_t held =3D 0;
> +       uint32_t drop_nh;
> +       uint16_t next;
> +       int i, rc;
> +
> +       /* Speculative next */
> +       next_index =3D RTE_NODE_IP4_LOOKUP_NEXT_REWRITE;

Is it possible if we add next_edge in node->ctx? Save next_index in
node->init() function and at the end of process() function for
better speculative performance

Also in general, this function is assuming packets are being forwarded
to rewrite node but there be can other paths as well like
- LOCAL
- PUNT etc.

So let next_hop returned from rte_fib_lookup_bulk() determine the
next_edge (even pkt_drop node). Control plane feeds next_edge in 8B
next_hop which I defined in other patch and also below
(rte_ip4_lookup_fib_next_hop_t)


> +       /* Drop node */
> +       drop_nh =3D ((uint32_t)RTE_NODE_IP4_LOOKUP_NEXT_PKT_DROP) << 16;

Let drop be determined from next_hop returned from rte_ip4_lookup_fib_next_=
hop_t
Control plane feeds default next_hop as part of setup_fib() as follows
struct {
   struct {
     uint32_t next_hop_od;
    uint16_t next_edge;
    uint16_t reserved;
   };
   uint64_t u4;
} rte_ip4_lookpu_fib_next_hop_t;

default_nh =3D {,next =3D RTE_NODE_IP4_LOOKUP_NEXT_PKT_DROP}; which is
programmed in setup_fib
> +
> +       pkts =3D (struct rte_mbuf **)objs;
> +       from =3D objs;
> +       n_left_from =3D nb_objs;
> +
> +       /* Get stream for the speculated next node */
> +       to_next =3D rte_node_next_stream_get(graph, node, next_index, nb_=
objs);
> +
> +       for (i =3D OBJS_PER_CLINE; i < RTE_GRAPH_BURST_SIZE; i +=3D OBJS_=
PER_CLINE)
> +               rte_prefetch0(&objs[i]);
> +
> +#if RTE_GRAPH_BURST_SIZE > 64
> +       for (i =3D 0; i < 4 && i < n_left_from; i++) {
> +               rte_prefetch0(pkts[i]);
> +               rte_prefetch0(rte_pktmbuf_mtod_offset(pkts[i], void *,
> +                                       sizeof(struct rte_ether_hdr)));
> +       }
> +#endif
> +
> +       i =3D 0;
> +       while (n_left_from >=3D 4) {
> +#if RTE_GRAPH_BURST_SIZE > 64
> +               if (likely(n_left_from > 7)) {
> +                       rte_prefetch0(pkts[4]);
> +                       rte_prefetch0(rte_pktmbuf_mtod_offset(pkts[4], vo=
id *,
> +                                       sizeof(struct rte_ether_hdr)));
> +                       rte_prefetch0(pkts[5]);
> +                       rte_prefetch0(rte_pktmbuf_mtod_offset(pkts[5], vo=
id *,
> +                                       sizeof(struct rte_ether_hdr)));
> +                       rte_prefetch0(pkts[6]);
> +                       rte_prefetch0(rte_pktmbuf_mtod_offset(pkts[6], vo=
id *,
> +                                       sizeof(struct rte_ether_hdr)));
> +                       rte_prefetch0(pkts[7]);
> +                       rte_prefetch0(rte_pktmbuf_mtod_offset(pkts[7], vo=
id *,
> +                                       sizeof(struct rte_ether_hdr)));
> +               }
> +#endif
> +
> +               mbuf0 =3D pkts[0];
> +               mbuf1 =3D pkts[1];
> +               mbuf2 =3D pkts[2];
> +               mbuf3 =3D pkts[3];
> +               pkts +=3D 4;
> +               n_left_from -=3D 4;
> +               /* Extract DIP of mbuf0 */
> +               ipv4_hdr =3D rte_pktmbuf_mtod_offset(mbuf0, struct rte_ip=
v4_hdr *,
> +                               sizeof(struct rte_ether_hdr));
> +               /* Extract cksum, ttl as ipv4 hdr is in cache */
> +               node_mbuf_priv1(mbuf0, dyn)->cksum =3D ipv4_hdr->hdr_chec=
ksum;
> +               node_mbuf_priv1(mbuf0, dyn)->ttl =3D ipv4_hdr->time_to_li=
ve;
> +
> +               ip[i++] =3D rte_be_to_cpu_32(ipv4_hdr->dst_addr);
> +
> +               /* Extract DIP of mbuf1 */
> +               ipv4_hdr =3D rte_pktmbuf_mtod_offset(mbuf1, struct rte_ip=
v4_hdr *,
> +                               sizeof(struct rte_ether_hdr));
> +               /* Extract cksum, ttl as ipv4 hdr is in cache */
> +               node_mbuf_priv1(mbuf1, dyn)->cksum =3D ipv4_hdr->hdr_chec=
ksum;
> +               node_mbuf_priv1(mbuf1, dyn)->ttl =3D ipv4_hdr->time_to_li=
ve;
> +
> +               ip[i++] =3D rte_be_to_cpu_32(ipv4_hdr->dst_addr);
> +
> +               /* Extract DIP of mbuf2 */
> +               ipv4_hdr =3D rte_pktmbuf_mtod_offset(mbuf2, struct rte_ip=
v4_hdr *,
> +                               sizeof(struct rte_ether_hdr));
> +               /* Extract cksum, ttl as ipv4 hdr is in cache */
> +               node_mbuf_priv1(mbuf2, dyn)->cksum =3D ipv4_hdr->hdr_chec=
ksum;
> +               node_mbuf_priv1(mbuf2, dyn)->ttl =3D ipv4_hdr->time_to_li=
ve;
> +
> +               ip[i++] =3D rte_be_to_cpu_32(ipv4_hdr->dst_addr);
> +
> +               /* Extract DIP of mbuf3 */
> +               ipv4_hdr =3D rte_pktmbuf_mtod_offset(mbuf3, struct rte_ip=
v4_hdr *,
> +                               sizeof(struct rte_ether_hdr));
> +
> +               /* Extract cksum, ttl as ipv4 hdr is in cache */
> +               node_mbuf_priv1(mbuf3, dyn)->cksum =3D ipv4_hdr->hdr_chec=
ksum;
> +               node_mbuf_priv1(mbuf3, dyn)->ttl =3D ipv4_hdr->time_to_li=
ve;
> +
> +               ip[i++] =3D rte_be_to_cpu_32(ipv4_hdr->dst_addr);
> +       }
> +       while (n_left_from > 0) {
> +               mbuf0 =3D pkts[0];
> +               pkts +=3D 1;
> +               n_left_from -=3D 1;
> +
> +               /* Extract DIP of mbuf0 */
> +               ipv4_hdr =3D rte_pktmbuf_mtod_offset(mbuf0, struct rte_ip=
v4_hdr *,
> +                               sizeof(struct rte_ether_hdr));
> +               /* Extract cksum, ttl as ipv4 hdr is in cache */
> +               node_mbuf_priv1(mbuf0, dyn)->cksum =3D ipv4_hdr->hdr_chec=
ksum;
> +               node_mbuf_priv1(mbuf0, dyn)->ttl =3D ipv4_hdr->time_to_li=
ve;
> +
> +               ip[i++] =3D rte_be_to_cpu_32(ipv4_hdr->dst_addr);
> +       }
> +
> +       rc =3D rte_fib_lookup_bulk(fib, ip, next_hop, nb_objs);
> +       if (unlikely(rc !=3D 0))
> +               return 0;
> +
> +       for (i =3D 0; i < nb_objs; i++) {
> +               if (unlikely(next_hop[i] =3D=3D FIB_DEFAULT_NH)) {

This check can be removed since we have programmed drop node in default_nh.

> +                       next_hop[i] =3D drop_nh;
> +                       lookup_err +=3D 1;
> +               }
> +
> +               mbuf0 =3D (struct rte_mbuf *)objs[i];
> +               node_mbuf_priv1(mbuf0, dyn)->nh =3D (uint16_t)next_hop[i]=
;
> +               next =3D (uint16_t)(next_hop[i] >> 16);

Please get next and next_hop from next_hop itself

      node_mbuf_priv1(mbuf0, dyn)->nh =3D
((rte_ip4_lookup_fib_next_hop_t *)next_hop[i])->next_edge
      next =3D ((rte_ip4_lookup_fib_next_hop_t *)next_hop[i])->next_hop_id;
> +
> +               if (unlikely(next_index ^ next)) {
> +                       /* Copy things successfully speculated till now *=
/
> +                       rte_memcpy(to_next, from, last_spec * sizeof(from=
[0]));
> +                       from +=3D last_spec;
> +                       to_next +=3D last_spec;
> +                       held +=3D last_spec;
> +                       last_spec =3D 0;
> +
> +                       rte_node_enqueue_x1(graph, node, next, from[0]);
> +                       from +=3D 1;
> +               } else {
> +                       last_spec +=3D 1;
> +               }
> +       }
> +
> +       /* !!! Home run !!! */
> +       if (likely(last_spec =3D=3D nb_objs)) {
> +               rte_node_next_stream_move(graph, node, next_index);
> +               return nb_objs;
> +       }
> +
> +       NODE_INCREMENT_XSTAT_ID(node, 0, lookup_err !=3D 0, lookup_err);
> +       held +=3D last_spec;
> +       rte_memcpy(to_next, from, last_spec * sizeof(from[0]));

Save current next_index in node->ctx to make speculation work in next
iteration.
> +       rte_node_next_stream_put(graph, node, next_index, held);
> +
> +       return nb_objs;
> +}
> +
>  RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_node_ip4_fib_route_add, 25.07)
>  int
>  rte_node_ip4_fib_route_add(uint32_t ip, uint8_t depth, uint16_t next_hop=
,
> @@ -147,6 +310,7 @@ static struct rte_node_xstats ip4_lookup_fib_xstats =
=3D {
>  };
>
>  static struct rte_node_register ip4_lookup_fib_node =3D {
> +       .process =3D ip4_lookup_fib_node_process,
>         .name =3D "ip4_lookup_fib",
>
>         .init =3D ip4_lookup_fib_node_init,
> --
> 2.25.1
>
