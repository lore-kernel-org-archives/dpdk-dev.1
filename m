Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 369D3C369CA
	for <dpdk-dev@archiver.kernel.org>; Sat, 19 Apr 2025 18:14:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F1CAF40265;
	Sat, 19 Apr 2025 20:14:54 +0200 (CEST)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com
 [209.85.208.53]) by mails.dpdk.org (Postfix) with ESMTP id B4C5D40156
 for <dev@dpdk.org>; Sat, 19 Apr 2025 20:14:52 +0200 (CEST)
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-5e5dce099f4so3418516a12.1
 for <dev@dpdk.org>; Sat, 19 Apr 2025 11:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745086492; x=1745691292; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ETGE8iJRNA9lyHnBauvebKAGkNderi6JaE/y8z153EU=;
 b=aufADbuKcHwbABAV3vn5B2btPr7gd+mGlXDBALdawACqFh/uj2fT+5RDhy3jIEl3if
 ns5PQQss4vfveSRdx8i1GXNAFrhnxLA2+waOBSWoZ1u38DzX3DJ6+khkaUwGc+fSbEGV
 wjgeNR6BLN9PacYnxJh7YIbcjBY6jQ9uvUi+iD+96NObVIFEHPXcbt0yovIf+xFRl69I
 yA2OgYERhPElkYXn3URlEAEtXoLiiQCtk03Uv1ty5zHI3T7DY70k1YbxbcSoPr4KJmq9
 fnXLy1W4NtUo2rDrthem+UwHPd99gyUYgCOUVut4MdyUvAVIHIPNJaTmm744T5wQgKjf
 KQYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745086492; x=1745691292;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ETGE8iJRNA9lyHnBauvebKAGkNderi6JaE/y8z153EU=;
 b=Rscj06UBwN4QuAluOObbKdOjU2wp/oLhy4bf40THmsTi3vaRnZKVJmLz3Eb7GkE0JH
 hmJEeUcyMuyOydIN5ZEemex5QVbYUfvzrR0nnLywUeA17PVPrr3HbBNT3bsAT0NPnoDj
 k9yeKoXZAv2HL8ZAwS/5MQyH8s5RQGV/pmXU76DgCZlFCCJuKlbGhJ8h3rbwl45GAff1
 oruRH55hpQqIN/LEr90TI1ukuvl5otlP84GeqywD6wrmOxbVc1pRiVCFSHblljs9fRTo
 sHGyLyN5nn1Nz1FkXdjOFaMWNXXuOyjSdvFNcrW5UHpCJo+N1Z7c3e6Ki/tRbVdZvdDY
 ULyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEVj8pjWHUZZHrS2TvW/yIanw/vqQixL+UCTybmgx3ysdSjft2WTdBAsEM8tVz8J2ZyyI=@dpdk.org
X-Gm-Message-State: AOJu0YyKxphVXk/zmSwpuI4VxpWdCVsynW3Gj9WWSbH01Qowb//KMaGu
 pYuoSHL6szSpPEnRhQj7LYNYuEYstAt1YcexJSsaMwUAvKypj3QDvcQ6lGboFfK1KL6gTUUBWy/
 I4TQgQyi9dqeqcWe5Q+Cx3QlMqes=
X-Gm-Gg: ASbGnctVgPRO+tLdoLk8ARhgrPP79QhgiMhy/r1fLHdRq4CFl303Ft8xry3ixwOdjmJ
 7Un2MT56qnSz0QrAbDbYVPqtIu60C5CI1KbjZSuAqyjd7YvqP15r/99UlHBPAT4YCzTdD552+6y
 trqzgclV+/AFr4l2y8/KQH/g==
X-Google-Smtp-Source: AGHT+IFuwvsrg8d51NEi+DnIxEvljkkA/wcbvGp2Dx2QDPLRP4n/+d9hZLEsaPxKQ7uDJpi93ZsSdvrl8+gmcpZ+W/o=
X-Received: by 2002:a17:907:2cc4:b0:acb:5583:6fdd with SMTP id
 a640c23a62f3a-acb74aac4a2mr527407066b.11.1745086491907; Sat, 19 Apr 2025
 11:14:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250415121052.1497155-1-adwivedi@marvell.com>
 <20250415121052.1497155-5-adwivedi@marvell.com>
 <380238cf-085c-48ff-800c-a876edc96dea@intel.com>
 <BY1PR18MB61094E892CA9C0E65883260EDDBF2@BY1PR18MB6109.namprd18.prod.outlook.com>
In-Reply-To: <BY1PR18MB61094E892CA9C0E65883260EDDBF2@BY1PR18MB6109.namprd18.prod.outlook.com>
From: Vladimir Medvedkin <medvedkinv@gmail.com>
Date: Sat, 19 Apr 2025 19:14:40 +0100
X-Gm-Features: ATxdqUF0d81koylmEKuk275uyuyhRCRVIjwcL0ZlKnCtCoZ_aJ6Y0yCeGLWZz_8
Message-ID: <CANDrEHnPsoiNwwiuCursBKoqGo+e0EXSg20sg5oS4KwwNrdB5A@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: [PATCH v1 04/12] node: add process callback for
 IP4 FIB
To: Ankur Dwivedi <adwivedi@marvell.com>
Cc: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>,
 "dev@dpdk.org" <dev@dpdk.org>, Jerin Jacob <jerinj@marvell.com>,
 Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>, 
 Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, 
 Rakesh Kudurumalla <rkudurumalla@marvell.com>
Content-Type: multipart/alternative; boundary="00000000000073e0250633259cdd"
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

--00000000000073e0250633259cdd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ankur,

=D0=BF=D1=82, 18 =D0=B0=D0=BF=D1=80. 2025=E2=80=AF=D0=B3. =D0=B2 15:45, Ank=
ur Dwivedi <adwivedi@marvell.com>:

>
> Hi Vladimir,
> >> diff --git a/lib/node/ip4_lookup_fib.c b/lib/node/ip4_lookup_fib.c
> >> index e87864e672..c535b191f8 100644
> >> --- a/lib/node/ip4_lookup_fib.c
> >> +++ b/lib/node/ip4_lookup_fib.c
> >> @@ -40,6 +40,169 @@ static struct ip4_lookup_fib_node_main
> >ip4_lookup_fib_nm;
> >>   #define IP4_LOOKUP_NODE_PRIV1_OFF(ctx) \
> >>      (((struct ip4_lookup_fib_node_ctx *)ctx)->mbuf_priv1_off)
> >>
> >> +static uint16_t
> >> +ip4_lookup_fib_node_process(struct rte_graph *graph, struct rte_node
> >*node, void **objs,
> >> +                        uint16_t nb_objs)
> >> +{
> >> +    struct rte_mbuf *mbuf0, *mbuf1, *mbuf2, *mbuf3, **pkts;
> >> +    struct rte_fib *fib =3D IP4_LOOKUP_NODE_FIB(node->ctx);
> >> +    const int dyn =3D IP4_LOOKUP_NODE_PRIV1_OFF(node->ctx);
> >> +    struct rte_ipv4_hdr *ipv4_hdr;
> >> +    uint64_t next_hop[nb_objs];
> >> +    uint16_t lookup_err =3D 0;
> >> +    void **to_next, **from;
> >> +    uint16_t last_spec =3D 0;
> >> +    rte_edge_t next_index;
> >> +    uint16_t n_left_from;
> >> +    uint32_t ip[nb_objs];
> >> +    uint16_t held =3D 0;
> >> +    uint32_t drop_nh;
> >> +    uint16_t next;
> >> +    int i, rc;
> >> +
> >> +    /* Speculative next */
> >> +    next_index =3D RTE_NODE_IP4_LOOKUP_NEXT_REWRITE;
> >> +    /* Drop node */
> >> +    drop_nh =3D ((uint32_t)RTE_NODE_IP4_LOOKUP_NEXT_PKT_DROP) <<
> >16;
> >> +
> >> +    pkts =3D (struct rte_mbuf **)objs;
> >> +    from =3D objs;
> >> +    n_left_from =3D nb_objs;
> >> +
> >> +    /* Get stream for the speculated next node */
> >> +    to_next =3D rte_node_next_stream_get(graph, node, next_index,
> >> +nb_objs);
> >> +
> >> +    for (i =3D OBJS_PER_CLINE; i < RTE_GRAPH_BURST_SIZE; i +=3D
> >OBJS_PER_CLINE)
> >> +            rte_prefetch0(&objs[i]);
> >
> >Does this prefetching loop make any sense? Unless objs are not passed
> across
> >threads this array likely to be in the cache already.
> >
> >And if objs are passed across threads, then why do you start prefetching
> from
> >the next cache line instead of the first, and why don't you stop at
> nb_objs?
> For example if cache size is 64 bytes. Then there will be 8 pointers to
> mbuf per cache line (if address size is 8 bytes). If nb_objs is 256, then
> the remaining pointers needs to be prefetched to cache. This loop helps t=
o
> prefetch nb_objs pointers to cache.
>

My comment was about necessity. I'll rephrase and enumerate my questions to
be more clear:
1. Are mbuf pointers contained in the objs array not in cache? My
assumptions here are:
    - If you run graph in RTC mode, objs array is very likely already be in
your L1 cache (since some previous node/nodes just put packets there)
    - In dispatch mode it doesn't make much sense to run this lookup node i=
n
an another thread separately from the remaining nodes processing IPv4

2. if you still thing this prefetching loop is required here, then:

> The loop can be changed to stop at nb_objs.
> for (i =3D OBJS_PER_CLINE; i < nb_objs; i +=3D OBJS_PER_CLINE) { }
>
>
  why you start from the OBJS_PER_CLINE (second cache line of the objs
array)

3. "i < nb_objs". Should be "i < RTE_ALIGN_CEIL(nb_objs, OBJS_PER_CLINE) /
OBJS_PER_CLINE"

>
> >> +
> >> +#if RTE_GRAPH_BURST_SIZE > 64
> >> +    for (i =3D 0; i < 4 && i < n_left_from; i++) {
> >> +            rte_prefetch0(pkts[i]);
> >> +            rte_prefetch0(rte_pktmbuf_mtod_offset(pkts[i], void *,
> >> +                                    sizeof(struct rte_ether_hdr)));
> >
> >This construction does not make sense to me. Same as similar constructio=
ns
> >below
> >
> >The second prefetch has memory dependency of the data, that will be
> >prefetched by the first one. Does removing this prefetch affects
> performance?
> The first prefetches the data at mbuf address. The second prefetch is for
> the address containing ipv4 header. Both can be in separate cache lines, =
as
> ipv4 starts at mbuf->buf_addr + mbuf->data_off + sizeof(ethernet header).
> data_off is generally 64 bytes or 128 bytes depending on cache line size.
> >
>

Indeed, both of them are in separate cache lines. But my point here is
about data dependency for the second prefetch. In order to issue the
prefetch instruction for the cache line containing the ipv4 header you must
know the address. You calculate this address by:
rte_pktmbuf_mtod_offset(pkts[i], void *, sizeof(struct rte_ether_hdr))
rte_pktmbuf_mtod_offset is accessing mbuf->buf_addr and mbuf->data_off , as
you mentioned. But, these fields are not in your L1 cache at the moment,
because you just asked to prefetch them with the previous instruction.
So my suggestion here would be to look at how it is done in
ipv4_lookup_sse.c:ip4_lookup_node_process_vec()
Simplifying, in a run loop it prefetches mbuf + 2, then prefetches CL with
the v4 header of the mbuf + 1 (assuming in a previous invocation mbuf CL
was already fetched into L1), and finally does processing of the mbuf + 0
(again, assuming the previous iteration ipv4 CL was fetched).


> >> +    }
> >> +#endif
> >> +
> >> +    i =3D 0;
> >> +    while (n_left_from >=3D 4) {
> >> +#if RTE_GRAPH_BURST_SIZE > 64
> >> +            if (likely(n_left_from > 7)) {
> >> +                    rte_prefetch0(pkts[4]);
> >> +                    rte_prefetch0(rte_pktmbuf_mtod_offset(pkts[4], vo=
id
> >*,
> >> +                                    sizeof(struct rte_ether_hdr)));
> >> +                    rte_prefetch0(pkts[5]);
> >> +                    rte_prefetch0(rte_pktmbuf_mtod_offset(pkts[5], vo=
id
> >*,
> >> +                                    sizeof(struct rte_ether_hdr)));
> >> +                    rte_prefetch0(pkts[6]);
> >> +                    rte_prefetch0(rte_pktmbuf_mtod_offset(pkts[6], vo=
id
> >*,
> >> +                                    sizeof(struct rte_ether_hdr)));
> >> +                    rte_prefetch0(pkts[7]);
> >> +                    rte_prefetch0(rte_pktmbuf_mtod_offset(pkts[7], vo=
id
> >*,
> >> +                                    sizeof(struct rte_ether_hdr)));
> >> +            }
> >> +#endif
> >> +
> >> +            mbuf0 =3D pkts[0];
> >> +            mbuf1 =3D pkts[1];
> >> +            mbuf2 =3D pkts[2];
> >> +            mbuf3 =3D pkts[3];
> >> +            pkts +=3D 4;
> >> +            n_left_from -=3D 4;
> >> +            /* Extract DIP of mbuf0 */
> >> +            ipv4_hdr =3D rte_pktmbuf_mtod_offset(mbuf0, struct
> >rte_ipv4_hdr *,
> >> +                            sizeof(struct rte_ether_hdr));
> >> +            /* Extract cksum, ttl as ipv4 hdr is in cache */
> >> +            node_mbuf_priv1(mbuf0, dyn)->cksum =3D ipv4_hdr-
> >>hdr_checksum;
> >> +            node_mbuf_priv1(mbuf0, dyn)->ttl =3D ipv4_hdr->time_to_li=
ve;
> >> +
> >> +            ip[i++] =3D rte_be_to_cpu_32(ipv4_hdr->dst_addr);
> >> +
> >> +            /* Extract DIP of mbuf1 */
> >> +            ipv4_hdr =3D rte_pktmbuf_mtod_offset(mbuf1, struct
> >rte_ipv4_hdr *,
> >> +                            sizeof(struct rte_ether_hdr));
> >> +            /* Extract cksum, ttl as ipv4 hdr is in cache */
> >> +            node_mbuf_priv1(mbuf1, dyn)->cksum =3D ipv4_hdr-
> >>hdr_checksum;
> >> +            node_mbuf_priv1(mbuf1, dyn)->ttl =3D ipv4_hdr->time_to_li=
ve;
> >> +
> >> +            ip[i++] =3D rte_be_to_cpu_32(ipv4_hdr->dst_addr);
> >> +
> >> +            /* Extract DIP of mbuf2 */
> >> +            ipv4_hdr =3D rte_pktmbuf_mtod_offset(mbuf2, struct
> >rte_ipv4_hdr *,
> >> +                            sizeof(struct rte_ether_hdr));
> >> +            /* Extract cksum, ttl as ipv4 hdr is in cache */
> >> +            node_mbuf_priv1(mbuf2, dyn)->cksum =3D ipv4_hdr-
> >>hdr_checksum;
> >> +            node_mbuf_priv1(mbuf2, dyn)->ttl =3D ipv4_hdr->time_to_li=
ve;
> >> +
> >> +            ip[i++] =3D rte_be_to_cpu_32(ipv4_hdr->dst_addr);
> >> +
> >> +            /* Extract DIP of mbuf3 */
> >> +            ipv4_hdr =3D rte_pktmbuf_mtod_offset(mbuf3, struct
> >rte_ipv4_hdr *,
> >> +                            sizeof(struct rte_ether_hdr));
> >> +
> >> +            /* Extract cksum, ttl as ipv4 hdr is in cache */
> >> +            node_mbuf_priv1(mbuf3, dyn)->cksum =3D ipv4_hdr-
> >>hdr_checksum;
> >> +            node_mbuf_priv1(mbuf3, dyn)->ttl =3D ipv4_hdr->time_to_li=
ve;
> >> +
> >> +            ip[i++] =3D rte_be_to_cpu_32(ipv4_hdr->dst_addr);
> >> +    }
> >> +    while (n_left_from > 0) {
> >> +            mbuf0 =3D pkts[0];
> >> +            pkts +=3D 1;
> >> +            n_left_from -=3D 1;
> >> +
> >> +            /* Extract DIP of mbuf0 */
> >> +            ipv4_hdr =3D rte_pktmbuf_mtod_offset(mbuf0, struct
> >rte_ipv4_hdr *,
> >> +                            sizeof(struct rte_ether_hdr));
> >> +            /* Extract cksum, ttl as ipv4 hdr is in cache */
> >> +            node_mbuf_priv1(mbuf0, dyn)->cksum =3D ipv4_hdr-
> >>hdr_checksum;
> >> +            node_mbuf_priv1(mbuf0, dyn)->ttl =3D ipv4_hdr->time_to_li=
ve;
> >> +
> >> +            ip[i++] =3D rte_be_to_cpu_32(ipv4_hdr->dst_addr);
> >> +    }
> >> +
> >> +    rc =3D rte_fib_lookup_bulk(fib, ip, next_hop, nb_objs);
> >> +    if (unlikely(rc !=3D 0))
> >> +            return 0;
> >> +
> >> +    for (i =3D 0; i < nb_objs; i++) {
> >> +            if (unlikely(next_hop[i] =3D=3D FIB_DEFAULT_NH)) {
> >> +                    next_hop[i] =3D drop_nh;
> >maybe it is worth just do define FIB_DEFAULT_NH as a drop_nh vaue to omi=
t
> >these next_hop reassignments?
> Ack.
> >> +                    lookup_err +=3D 1;
> >> +            }
> >> +
> >> +            mbuf0 =3D (struct rte_mbuf *)objs[i];
> >> +            node_mbuf_priv1(mbuf0, dyn)->nh =3D (uint16_t)next_hop[i]=
;
> >> +            next =3D (uint16_t)(next_hop[i] >> 16);
> >> +
> >> +            if (unlikely(next_index ^ next)) {
> >> +                    /* Copy things successfully speculated till now *=
/
> >> +                    rte_memcpy(to_next, from, last_spec *
> >sizeof(from[0]));
> >> +                    from +=3D last_spec;
> >> +                    to_next +=3D last_spec;
> >> +                    held +=3D last_spec;
> >> +                    last_spec =3D 0;
> >> +
> >> +                    rte_node_enqueue_x1(graph, node, next, from[0]);
> >> +                    from +=3D 1;
> >> +            } else {
> >> +                    last_spec +=3D 1;
> >> +            }
> >> +    }
> >> +
> >> +    /* !!! Home run !!! */
> >> +    if (likely(last_spec =3D=3D nb_objs)) {
> >> +            rte_node_next_stream_move(graph, node, next_index);
> >> +            return nb_objs;
> >> +    }
> >> +
> >> +    NODE_INCREMENT_XSTAT_ID(node, 0, lookup_err !=3D 0, lookup_err);
> >> +    held +=3D last_spec;
> >> +    rte_memcpy(to_next, from, last_spec * sizeof(from[0]));
> >> +    rte_node_next_stream_put(graph, node, next_index, held);
> >> +
> >> +    return nb_objs;
> >> +}
> >> +
> >>   RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_node_ip4_fib_route_add, 25.07)
> >>   int
> >>   rte_node_ip4_fib_route_add(uint32_t ip, uint8_t depth, uint16_t
> >> next_hop, @@ -147,6 +310,7 @@ static struct rte_node_xstats
> >ip4_lookup_fib_xstats =3D {
> >>   };
> >>
> >>   static struct rte_node_register ip4_lookup_fib_node =3D {
> >> +    .process =3D ip4_lookup_fib_node_process,
> >>      .name =3D "ip4_lookup_fib",
> >>
> >>      .init =3D ip4_lookup_fib_node_init,
> >
> >--
> >Regards,
> >Vladimir
>
>

--=20
Regards,
Vladimir

--00000000000073e0250633259cdd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Ankur,</div><br><div class=3D"gmail_qu=
ote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">=D0=BF=D1=
=82, 18 =D0=B0=D0=BF=D1=80. 2025=E2=80=AF=D0=B3. =D0=B2 15:45, Ankur Dwived=
i &lt;<a href=3D"mailto:adwivedi@marvell.com">adwivedi@marvell.com</a>&gt;:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
Hi Vladimir,<br>
&gt;&gt; diff --git a/lib/node/ip4_lookup_fib.c b/lib/node/ip4_lookup_fib.c=
<br>
&gt;&gt; index e87864e672..c535b191f8 100644<br>
&gt;&gt; --- a/lib/node/ip4_lookup_fib.c<br>
&gt;&gt; +++ b/lib/node/ip4_lookup_fib.c<br>
&gt;&gt; @@ -40,6 +40,169 @@ static struct ip4_lookup_fib_node_main<br>
&gt;ip4_lookup_fib_nm;<br>
&gt;&gt;=C2=A0 =C2=A0#define IP4_LOOKUP_NODE_PRIV1_OFF(ctx) \<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 (((struct ip4_lookup_fib_node_ctx *)ctx)-&gt;m=
buf_priv1_off)<br>
&gt;&gt;<br>
&gt;&gt; +static uint16_t<br>
&gt;&gt; +ip4_lookup_fib_node_process(struct rte_graph *graph, struct rte_n=
ode<br>
&gt;*node, void **objs,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 uint16_t nb_objs)<br>
&gt;&gt; +{<br>
&gt;&gt; +=C2=A0 =C2=A0 struct rte_mbuf *mbuf0, *mbuf1, *mbuf2, *mbuf3, **p=
kts;<br>
&gt;&gt; +=C2=A0 =C2=A0 struct rte_fib *fib =3D IP4_LOOKUP_NODE_FIB(node-&g=
t;ctx);<br>
&gt;&gt; +=C2=A0 =C2=A0 const int dyn =3D IP4_LOOKUP_NODE_PRIV1_OFF(node-&g=
t;ctx);<br>
&gt;&gt; +=C2=A0 =C2=A0 struct rte_ipv4_hdr *ipv4_hdr;<br>
&gt;&gt; +=C2=A0 =C2=A0 uint64_t next_hop[nb_objs];<br>
&gt;&gt; +=C2=A0 =C2=A0 uint16_t lookup_err =3D 0;<br>
&gt;&gt; +=C2=A0 =C2=A0 void **to_next, **from;<br>
&gt;&gt; +=C2=A0 =C2=A0 uint16_t last_spec =3D 0;<br>
&gt;&gt; +=C2=A0 =C2=A0 rte_edge_t next_index;<br>
&gt;&gt; +=C2=A0 =C2=A0 uint16_t n_left_from;<br>
&gt;&gt; +=C2=A0 =C2=A0 uint32_t ip[nb_objs];<br>
&gt;&gt; +=C2=A0 =C2=A0 uint16_t held =3D 0;<br>
&gt;&gt; +=C2=A0 =C2=A0 uint32_t drop_nh;<br>
&gt;&gt; +=C2=A0 =C2=A0 uint16_t next;<br>
&gt;&gt; +=C2=A0 =C2=A0 int i, rc;<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 /* Speculative next */<br>
&gt;&gt; +=C2=A0 =C2=A0 next_index =3D RTE_NODE_IP4_LOOKUP_NEXT_REWRITE;<br=
>
&gt;&gt; +=C2=A0 =C2=A0 /* Drop node */<br>
&gt;&gt; +=C2=A0 =C2=A0 drop_nh =3D ((uint32_t)RTE_NODE_IP4_LOOKUP_NEXT_PKT=
_DROP) &lt;&lt;<br>
&gt;16;<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 pkts =3D (struct rte_mbuf **)objs;<br>
&gt;&gt; +=C2=A0 =C2=A0 from =3D objs;<br>
&gt;&gt; +=C2=A0 =C2=A0 n_left_from =3D nb_objs;<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 /* Get stream for the speculated next node */<br>
&gt;&gt; +=C2=A0 =C2=A0 to_next =3D rte_node_next_stream_get(graph, node, n=
ext_index,<br>
&gt;&gt; +nb_objs);<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 for (i =3D OBJS_PER_CLINE; i &lt; RTE_GRAPH_BURST_S=
IZE; i +=3D<br>
&gt;OBJS_PER_CLINE)<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rte_prefetch0(&amp;objs=
[i]);<br>
&gt;<br>
&gt;Does this prefetching loop make any sense? Unless objs are not passed a=
cross<br>
&gt;threads this array likely to be in the cache already.<br>
&gt;<br>
&gt;And if objs are passed across threads, then why do you start prefetchin=
g from<br>
&gt;the next cache line instead of the first, and why don&#39;t you stop at=
 nb_objs?<br>
For example if cache size is 64 bytes. Then there will be 8 pointers to mbu=
f per cache line (if address size is 8 bytes). If nb_objs is 256, then the =
remaining pointers needs to be prefetched to cache. This loop helps to pref=
etch nb_objs pointers to cache. <br></blockquote><div><br></div><div>My com=
ment was about necessity. I&#39;ll rephrase and enumerate my questions to b=
e more clear:</div><div>1. Are mbuf pointers contained in the objs array no=
t in cache? My assumptions here are:</div><div>=C2=A0=C2=A0=C2=A0 - If you =
run graph in RTC mode,=C2=A0objs array is very likely already be in your L1=
 cache (since some previous node/nodes just put packets there)</div><div>=
=C2=A0=C2=A0=C2=A0 - In dispatch mode<span style=3D"white-space:pre-wrap"> =
it </span><span class=3D"gmail-aNeGP0gI0B9AV8JaHPyH" style=3D"white-space:p=
re-wrap">doesn</span><span style=3D"white-space:pre-wrap">&#39;t make </spa=
n><span class=3D"gmail-aNeGP0gI0B9AV8JaHPyH" style=3D"white-space:pre-wrap"=
>much</span><span style=3D"white-space:pre-wrap"> </span><span class=3D"gma=
il-aNeGP0gI0B9AV8JaHPyH" style=3D"white-space:pre-wrap">sense</span><span s=
tyle=3D"white-space:pre-wrap"> to </span><span class=3D"gmail-aNeGP0gI0B9AV=
8JaHPyH" style=3D"white-space:pre-wrap">run</span><span style=3D"white-spac=
e:pre-wrap"> </span><span class=3D"gmail-aNeGP0gI0B9AV8JaHPyH" style=3D"whi=
te-space:pre-wrap">this</span><span style=3D"white-space:pre-wrap"> lookup<=
/span><span style=3D"white-space:pre-wrap"> </span><span class=3D"gmail-aNe=
GP0gI0B9AV8JaHPyH" style=3D"white-space:pre-wrap">node</span><span style=3D=
"white-space:pre-wrap"> </span><span class=3D"gmail-aNeGP0gI0B9AV8JaHPyH" s=
tyle=3D"white-space:pre-wrap">in</span><span style=3D"white-space:pre-wrap"=
> an another</span><span style=3D"white-space:pre-wrap"> </span><span class=
=3D"gmail-aNeGP0gI0B9AV8JaHPyH" style=3D"white-space:pre-wrap">thread</span=
><span style=3D"white-space:pre-wrap"> </span><span class=3D"gmail-aNeGP0gI=
0B9AV8JaHPyH" style=3D"white-space:pre-wrap">separately</span><span style=
=3D"white-space:pre-wrap"> </span><span class=3D"gmail-aNeGP0gI0B9AV8JaHPyH=
" style=3D"white-space:pre-wrap">from</span><span style=3D"white-space:pre-=
wrap"> the </span><span class=3D"gmail-aNeGP0gI0B9AV8JaHPyH" style=3D"white=
-space:pre-wrap">remaining</span><span style=3D"white-space:pre-wrap"> </sp=
an><span class=3D"gmail-aNeGP0gI0B9AV8JaHPyH" style=3D"white-space:pre-wrap=
">nodes</span><span style=3D"white-space:pre-wrap"> </span><span class=3D"g=
mail-aNeGP0gI0B9AV8JaHPyH" style=3D"white-space:pre-wrap">processing</span>=
<span style=3D"white-space:pre-wrap"> </span><span class=3D"gmail-aNeGP0gI0=
B9AV8JaHPyH" style=3D"white-space:pre-wrap">IPv4</span></div><div><br></div=
><div>2. if you still thing this prefetching loop is required here, then: <=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
The loop can be changed to stop at nb_objs.<br>
for (i =3D OBJS_PER_CLINE; i &lt; nb_objs; i +=3D OBJS_PER_CLINE) { }<br>=
=C2=A0 <br></blockquote><div>=C2=A0 why you start from the OBJS_PER_CLINE (=
second cache line of the objs array)</div><div>=C2=A0=C2=A0</div><div>3. &q=
uot;i &lt; nb_objs&quot;. Should be &quot;i &lt; RTE_ALIGN_CEIL(nb_objs, OB=
JS_PER_CLINE) / OBJS_PER_CLINE&quot;</div><div><br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
&gt;<br>
&gt;&gt; +<br>
&gt;&gt; +#if RTE_GRAPH_BURST_SIZE &gt; 64<br>
&gt;&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; 4 &amp;&amp; i &lt; n_left_fro=
m; i++) {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rte_prefetch0(pkts[i]);=
<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rte_prefetch0(rte_pktmb=
uf_mtod_offset(pkts[i], void *,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(struc=
t rte_ether_hdr)));<br>
&gt;<br>
&gt;This construction does not make sense to me. Same as similar constructi=
ons<br>
&gt;below<br>
&gt;<br>
&gt;The second prefetch has memory dependency of the data, that will be<br>
&gt;prefetched by the first one. Does removing this prefetch affects perfor=
mance?<br>
The first prefetches the data at mbuf address. The second prefetch is for t=
he address containing ipv4 header. Both can be in separate cache lines, as =
ipv4 starts at mbuf-&gt;buf_addr + mbuf-&gt;data_off + sizeof(ethernet head=
er). data_off is generally 64 bytes or 128 bytes depending on cache line si=
ze.<br>
&gt;<br></blockquote><div><br></div><div><span class=3D"gmail-aNeGP0gI0B9AV=
8JaHPyH" style=3D"white-space:pre-wrap">Indeed</span><span class=3D"gmail-a=
NeGP0gI0B9AV8JaHPyH" style=3D"white-space:pre-wrap">,</span><span style=3D"=
white-space:pre-wrap"> </span><span class=3D"gmail-aNeGP0gI0B9AV8JaHPyH" st=
yle=3D"white-space:pre-wrap">both</span><span style=3D"white-space:pre-wrap=
"> of </span><span class=3D"gmail-aNeGP0gI0B9AV8JaHPyH" style=3D"white-spac=
e:pre-wrap">them</span><span style=3D"white-space:pre-wrap"> </span><span c=
lass=3D"gmail-aNeGP0gI0B9AV8JaHPyH" style=3D"white-space:pre-wrap">are</spa=
n><span style=3D"white-space:pre-wrap"> </span><span class=3D"gmail-aNeGP0g=
I0B9AV8JaHPyH" style=3D"white-space:pre-wrap">in</span><span style=3D"white=
-space:pre-wrap"> </span><span class=3D"gmail-aNeGP0gI0B9AV8JaHPyH" style=
=3D"white-space:pre-wrap">separate</span><span style=3D"white-space:pre-wra=
p"> </span><span class=3D"gmail-aNeGP0gI0B9AV8JaHPyH" style=3D"white-space:=
pre-wrap">cache</span><span style=3D"white-space:pre-wrap"> </span><span cl=
ass=3D"gmail-aNeGP0gI0B9AV8JaHPyH" style=3D"white-space:pre-wrap">lines</sp=
an><span class=3D"gmail-aNeGP0gI0B9AV8JaHPyH" style=3D"white-space:pre-wrap=
">. But my point here is about data dependency for the second prefetch. In =
order to issue the prefetch instruction for the cache line containing the i=
pv4 header you must know the address. You calculate this address by:</span>=
</div><div>rte_pktmbuf_mtod_offset(pkts[i], void *, sizeof(struct rte_ether=
_hdr))</div><div>rte_pktmbuf_mtod_offset is accessing mbuf-&gt;buf_addr and=
 mbuf-&gt;data_off , as you mentioned. But, these fields are not in your L1=
 cache at the moment, because you just asked to prefetch them with the prev=
ious instruction.</div><div>So my suggestion here would be to look at how i=
t is done in ipv4_lookup_sse.c:ip4_lookup_node_process_vec()</div><div>Simp=
lifying, in a run loop it prefetches mbuf + 2, then prefetches CL with the =
v4 header of the mbuf + 1 (assuming in a previous invocation mbuf CL was al=
ready fetched into L1), and finally does processing of the mbuf=C2=A0+ 0 (a=
gain, assuming the previous iteration ipv4 CL was fetched).</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt; +#endif<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 i =3D 0;<br>
&gt;&gt; +=C2=A0 =C2=A0 while (n_left_from &gt;=3D 4) {<br>
&gt;&gt; +#if RTE_GRAPH_BURST_SIZE &gt; 64<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (likely(n_left_from =
&gt; 7)) {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 rte_prefetch0(pkts[4]);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 rte_prefetch0(rte_pktmbuf_mtod_offset(pkts[4], void<br>
&gt;*,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(struc=
t rte_ether_hdr)));<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 rte_prefetch0(pkts[5]);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 rte_prefetch0(rte_pktmbuf_mtod_offset(pkts[5], void<br>
&gt;*,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(struc=
t rte_ether_hdr)));<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 rte_prefetch0(pkts[6]);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 rte_prefetch0(rte_pktmbuf_mtod_offset(pkts[6], void<br>
&gt;*,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(struc=
t rte_ether_hdr)));<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 rte_prefetch0(pkts[7]);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 rte_prefetch0(rte_pktmbuf_mtod_offset(pkts[7], void<br>
&gt;*,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(struc=
t rte_ether_hdr)));<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt; +#endif<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mbuf0 =3D pkts[0];<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mbuf1 =3D pkts[1];<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mbuf2 =3D pkts[2];<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mbuf3 =3D pkts[3];<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pkts +=3D 4;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 n_left_from -=3D 4;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Extract DIP of mbuf0=
 */<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ipv4_hdr =3D rte_pktmbu=
f_mtod_offset(mbuf0, struct<br>
&gt;rte_ipv4_hdr *,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(struct rte_ether_hdr));<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Extract cksum, ttl a=
s ipv4 hdr is in cache */<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 node_mbuf_priv1(mbuf0, =
dyn)-&gt;cksum =3D ipv4_hdr-<br>
&gt;&gt;hdr_checksum;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 node_mbuf_priv1(mbuf0, =
dyn)-&gt;ttl =3D ipv4_hdr-&gt;time_to_live;<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ip[i++] =3D rte_be_to_c=
pu_32(ipv4_hdr-&gt;dst_addr);<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Extract DIP of mbuf1=
 */<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ipv4_hdr =3D rte_pktmbu=
f_mtod_offset(mbuf1, struct<br>
&gt;rte_ipv4_hdr *,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(struct rte_ether_hdr));<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Extract cksum, ttl a=
s ipv4 hdr is in cache */<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 node_mbuf_priv1(mbuf1, =
dyn)-&gt;cksum =3D ipv4_hdr-<br>
&gt;&gt;hdr_checksum;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 node_mbuf_priv1(mbuf1, =
dyn)-&gt;ttl =3D ipv4_hdr-&gt;time_to_live;<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ip[i++] =3D rte_be_to_c=
pu_32(ipv4_hdr-&gt;dst_addr);<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Extract DIP of mbuf2=
 */<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ipv4_hdr =3D rte_pktmbu=
f_mtod_offset(mbuf2, struct<br>
&gt;rte_ipv4_hdr *,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(struct rte_ether_hdr));<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Extract cksum, ttl a=
s ipv4 hdr is in cache */<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 node_mbuf_priv1(mbuf2, =
dyn)-&gt;cksum =3D ipv4_hdr-<br>
&gt;&gt;hdr_checksum;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 node_mbuf_priv1(mbuf2, =
dyn)-&gt;ttl =3D ipv4_hdr-&gt;time_to_live;<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ip[i++] =3D rte_be_to_c=
pu_32(ipv4_hdr-&gt;dst_addr);<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Extract DIP of mbuf3=
 */<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ipv4_hdr =3D rte_pktmbu=
f_mtod_offset(mbuf3, struct<br>
&gt;rte_ipv4_hdr *,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(struct rte_ether_hdr));<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Extract cksum, ttl a=
s ipv4 hdr is in cache */<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 node_mbuf_priv1(mbuf3, =
dyn)-&gt;cksum =3D ipv4_hdr-<br>
&gt;&gt;hdr_checksum;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 node_mbuf_priv1(mbuf3, =
dyn)-&gt;ttl =3D ipv4_hdr-&gt;time_to_live;<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ip[i++] =3D rte_be_to_c=
pu_32(ipv4_hdr-&gt;dst_addr);<br>
&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt; +=C2=A0 =C2=A0 while (n_left_from &gt; 0) {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mbuf0 =3D pkts[0];<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pkts +=3D 1;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 n_left_from -=3D 1;<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Extract DIP of mbuf0=
 */<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ipv4_hdr =3D rte_pktmbu=
f_mtod_offset(mbuf0, struct<br>
&gt;rte_ipv4_hdr *,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(struct rte_ether_hdr));<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Extract cksum, ttl a=
s ipv4 hdr is in cache */<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 node_mbuf_priv1(mbuf0, =
dyn)-&gt;cksum =3D ipv4_hdr-<br>
&gt;&gt;hdr_checksum;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 node_mbuf_priv1(mbuf0, =
dyn)-&gt;ttl =3D ipv4_hdr-&gt;time_to_live;<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ip[i++] =3D rte_be_to_c=
pu_32(ipv4_hdr-&gt;dst_addr);<br>
&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 rc =3D rte_fib_lookup_bulk(fib, ip, next_hop, nb_ob=
js);<br>
&gt;&gt; +=C2=A0 =C2=A0 if (unlikely(rc !=3D 0))<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; nb_objs; i++) {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (unlikely(next_hop[i=
] =3D=3D FIB_DEFAULT_NH)) {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 next_hop[i] =3D drop_nh;<br>
&gt;maybe it is worth just do define FIB_DEFAULT_NH as a drop_nh vaue to om=
it<br>
&gt;these next_hop reassignments?<br>
Ack.<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 lookup_err +=3D 1;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mbuf0 =3D (struct rte_m=
buf *)objs[i];<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 node_mbuf_priv1(mbuf0, =
dyn)-&gt;nh =3D (uint16_t)next_hop[i];<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 next =3D (uint16_t)(nex=
t_hop[i] &gt;&gt; 16);<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (unlikely(next_index=
 ^ next)) {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 /* Copy things successfully speculated till now */<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 rte_memcpy(to_next, from, last_spec *<br>
&gt;sizeof(from[0]));<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 from +=3D last_spec;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 to_next +=3D last_spec;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 held +=3D last_spec;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 last_spec =3D 0;<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 rte_node_enqueue_x1(graph, node, next, from[0]);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 from +=3D 1;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 last_spec +=3D 1;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 /* !!! Home run !!! */<br>
&gt;&gt; +=C2=A0 =C2=A0 if (likely(last_spec =3D=3D nb_objs)) {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rte_node_next_stream_mo=
ve(graph, node, next_index);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return nb_objs;<br>
&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 NODE_INCREMENT_XSTAT_ID(node, 0, lookup_err !=3D 0,=
 lookup_err);<br>
&gt;&gt; +=C2=A0 =C2=A0 held +=3D last_spec;<br>
&gt;&gt; +=C2=A0 =C2=A0 rte_memcpy(to_next, from, last_spec * sizeof(from[0=
]));<br>
&gt;&gt; +=C2=A0 =C2=A0 rte_node_next_stream_put(graph, node, next_index, h=
eld);<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 return nb_objs;<br>
&gt;&gt; +}<br>
&gt;&gt; +<br>
&gt;&gt;=C2=A0 =C2=A0RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_node_ip4_fib_route_=
add, 25.07)<br>
&gt;&gt;=C2=A0 =C2=A0int<br>
&gt;&gt;=C2=A0 =C2=A0rte_node_ip4_fib_route_add(uint32_t ip, uint8_t depth,=
 uint16_t<br>
&gt;&gt; next_hop, @@ -147,6 +310,7 @@ static struct rte_node_xstats<br>
&gt;ip4_lookup_fib_xstats =3D {<br>
&gt;&gt;=C2=A0 =C2=A0};<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0static struct rte_node_register ip4_lookup_fib_node =
=3D {<br>
&gt;&gt; +=C2=A0 =C2=A0 .process =3D ip4_lookup_fib_node_process,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 .name =3D &quot;ip4_lookup_fib&quot;,<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 .init =3D ip4_lookup_fib_node_init,<br>
&gt;<br>
&gt;--<br>
&gt;Regards,<br>
&gt;Vladimir<br>
<br>
</blockquote></div><div><br clear=3D"all"></div><br><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><div>Regards,<br></div>Vladimir<br></div></div></div>

--00000000000073e0250633259cdd--
