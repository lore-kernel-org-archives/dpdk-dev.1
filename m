Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED5CBCC6B1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 05:48:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F438402ED;
	Wed, 14 Oct 2026 07:48:50 +0200 (CEST)
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com
 [74.125.224.43]) by mails.dpdk.org (Postfix) with ESMTP id 294264027C
 for <dev@dpdk.org>; Wed, 14 Oct 2026 06:47:01 +0200 (CEST)
Received: by mail-yx1-f43.google.com with SMTP id
 956f58d0204a3-6798eb0d13fso82390d50.0
 for <dev@dpdk.org>; Tue, 13 Oct 2026 21:47:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791953220; cv=none;
 d=google.com; s=arc-20260327;
 b=D+ckZ6eu9bjWe/V+G/sQglFiOUFD0VETzt5DxCG1dswbBFEm3NdH3sbnHwGaBaAbpr
 q0kfX9GDmu7T5sRdoGQy+lwOZlPKRBcH/OBSo7ViX/K+Fozvj5ZOAr3ojROsAPmFAiMw
 MlXpyQBeop7qZHy1jUKNwYahviXX6XPMU9WYGiLQq7Z6qfMCSRg3FEIrcr5qeCEwOi2u
 1x4CXZga8TvugBOSah+2iSklvrwrdDyphdDrSEeIAYKyk5eQ72wElyANKvQfy4uI+/Sv
 1ZpuUrzeaqBKkj68DyEAAoBQ/dKYFPcSZf2azZ/1QoBVX0dCSM2lkcAm14NoLhniq0YR
 LLeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vWVB3iXTb1RZPIt8+SqQWQt4MbxRVtEagoMusaTnTQs=;
 fh=n2WFL82Jq0C/SQTTHuXCaXFTg21m+pk0Yp3nMYCCj7Y=;
 b=V2dQjDHb/qeCXx2kOM7avqZooqvxTuH7PuxLYsZIUFSz9eeI/viy9VaXUzhi/g3oXm
 95lQd1y1lzK62cis0GxTzWQdIDEN/Ic3YJnv1q5YukoFKtJCxPvqPoWsoL213mEllAs1
 Oehd6SWiJFOJPkYPQTSg7GXUS9pz/tBhM6+jibT3EGCSZkd/KehNO0tRsg5RhCKdcVMe
 U9obeUeO64eM/8gVFqg+89O4TNjgiUsW2AVZJLbGsmfHDfxi71Qhj9MHCFsTU22XLq0h
 w995yvuO4s0p58QNSH6PXq6SoIINTdLNoeFdKFBTwnEgQGO8kZK0XJ+ywhrMpBlDhlVU
 jmiA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791953220; x=1792558020; darn=dpdk.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vWVB3iXTb1RZPIt8+SqQWQt4MbxRVtEagoMusaTnTQs=;
 b=qKG2Fh5cp1GtQvwrA92yGllMv08J7AuvmdMl7GeMZhuQODLcflt+ppbsYx4QcrwGj4
 VlPZ/WJwMpUA/LLed1AXudPnMBv4HzCZqV7Ar2caMNLYxF1BaKR3CsA6CdpVsMsiCBaN
 rd71Rt2DZq7gGUo5zaMxR09H9nR90WWOPZye2eH0iUzNHeZR35c0hNrFBafi2lz+euja
 aPEUKwsF2FwH8AE6cfKJWfLDBbpfapXGAoSqJY3TUDsxtSyIraDIgHB0xtXALPA/jX8u
 7h/gUuVqAYE366SZxL5+6PUE0jn1K8zxc66LV3+dBGeL8k/HbsfXQoXeTmNY7DDBV3U9
 RrBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791953220; x=1792558020;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vWVB3iXTb1RZPIt8+SqQWQt4MbxRVtEagoMusaTnTQs=;
 b=Ec4fZWfbe7pmM1iwAdui4WMVttgIurn1klwteCS65sEde1B6PoAvkDMIaw8kndz2or
 jfeaAaZIyl5nRUqKXvy9TbFyii7ScN2abE762P9jKJXg5n3n0nQktXiVy/kdhpkf73o3
 MhrSgsBFXQiXAf9T4wtVhK7VaZgZmWhKUdSQc3pXzkcFNlox+spvCU6RQo0xmWwRtLq+
 lFoBNVSDoRRQmQI4BWXSHZyUliJxJOJTiuA8a6ST3emEx2+DgDG6lMNNi9CiL7SYp+oT
 crLN3z++YLXR57MNO5tCkI6/2ZsaqYH7q2NCamSO6mN6iqbMe0Emd6ffSbhDldXZVtEl
 C4Bw==
X-Gm-Message-State: AFq9FYKuJzPEjrIGmdnvYOAHz0a4JieDgXlLoBeZYYcdpy9KjInnIXVp
 M1ghrSRBatD1qsBB50EU5B6qiaEh7GXAAC0K/aMYlRPip4xlAtuFBCLiVIBiF/KlyeCaD8uwXXj
 NqsrZwFZPoSvswJqcUEbFMIFyoTMLAsc=
X-Gm-Gg: AYBFou1BrWxME1bpqbN76yQOFf8Ka2+3/z7h8m0Im7vOa5KlOUUobOcvtzQzHk392rL
 RQgz53ICp6nlT1g2Y2Ck8nbvE22YLqArkyIFh1smqs2pMM1c487MhN386KVwzcf0oTqZDoSSIMj
 TNYeHVsG3SJFW49yQroFJ1VEVDHLNnPcVnFihth2JXvLiv6wYHeNRBgMgLP+MdrhOLfCRHVqOoU
 5RCQTRZy7J3pLQqcPRr0KDmkXFQY0bJRPQ2dkSVqYOD2HNntwpnWiRtsZbuhcEGYO8eQQgW7e1X
 7oNM27VBL8Nv6OUoCLWfCQvNvAMGjC5l94fJedFL5ta7mVVmZgdwMxeXHouM2x/CfcPTbsw9JzY
 0hwz5NNgIgu7AhBk9kpCOu+0m
X-Received: by 2002:a05:690e:128c:b0:673:8cbe:c16e with SMTP id
 956f58d0204a3-6796fe85edamr2046493d50.69.1791953219840; Tue, 13 Oct 2026
 21:46:59 -0700 (PDT)
MIME-Version: 1.0
References: <20261012105023.669486-1-tathagat.dpdk@gmail.com>
 <20261013104348.714550-1-tathagat.dpdk@gmail.com>
 <20261013104348.714550-5-tathagat.dpdk@gmail.com>
 <CALuQH+U5ATv0wZ6aEAD3=QeCaWn6SZc5GmagV-Vi5h+5emD_+Q@mail.gmail.com>
In-Reply-To: <CALuQH+U5ATv0wZ6aEAD3=QeCaWn6SZc5GmagV-Vi5h+5emD_+Q@mail.gmail.com>
From: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
Date: Wed, 14 Oct 2026 10:16:47 +0530
X-Gm-Features: AclHuK8f3tuhqDWjEiw6wmOxlvzBzd8MC9sHLTap7a4R46L99gBWWOJWr4p7wds
Message-ID: <CA++LmPU+Xj0jEBhXo_xZiLZcY5fS1VhCEV-DPpUSJ2w96P-qbQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] net/gve: add packet and TSO hardware constraints
 for DQO
To: Joshua Washington <joshwash@google.com>
Cc: dev@dpdk.org, stephen@networkplumber.org, stable@dpdk.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 14 Oct 2026 07:48:49 +0200
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

Thanks Joshua,

I'll get this sorted out. In trying to incorporate all the feedback
from you, Stephen, and AI suggestions at once, I ended up losing focus
on the main scope.
I'm going to break this work down into smaller, focused commits so
it=E2=80=99s much easier to review and test.

On Wed, Oct 14, 2026 at 6:20=E2=80=AFAM Joshua Washington <joshwash@google.=
com> wrote:
>
> On Tue, Oct 13, 2026 at 3:44=E2=80=AFAM Tathagat Priyadarshi
> <tathagat.dpdk@gmail.com> wrote:
> >
> > The GVNIC DQO hardware restricts each packet (or MTU segment in TSO)
> > to at most 10 data descriptors (GVE_TX_MAX_DATA_DESCS), beyond which
> > the hardware drops traffic. In addition to this 10-descriptor limit,
> > the hardware imposes strict packet sizing and header constraints.
> >
> > Previously, failing the descriptor limit or rte_mbuf_check() broke
> > from the Tx burst loop without consuming the invalid mbuf. This caused
> > tx_burst to return a short count, leading the application to retry the
> > same rejected packet indefinitely and causing Head-of-Line (HOL)
> > queue stalls.
> >
> > Enforce hardware validation and prevent HOL blocking in DPDK:
> > - Validate packet and hardware constraints prior to ring space checks.
> > - When packet validation or rte_mbuf_check() fails, drop and free the
> >   invalid mbuf with rte_pktmbuf_free(), update stats, and continue the
> >   burst to prevent Head-of-Line (HOL) blocking.
> > - Exclude dropped packets from txq->stats.packets while returning the
> >   total consumed count to the caller.
> > - Rename too_many_descs in struct gve_tx_stats to dropped_pkts to refle=
ct
> >   all validation and malformed mbuf drop events.
> > - Reject packets whose descriptor count exceeds the maximum capacity of
> >   the ring (accounting for reserved slots, cacheline overlap margin, an=
d
> >   unreported descriptors), preventing permanent queue stalls.
> > - Define GVE_TX_MIN_PKT_SIZE_DQO (17 bytes) and GVE_TX_MAX_PKT_SIZE_DQO
> >   (9728 bytes) to enforce wire packet boundaries for non-TSO packets
> >   and TSO MSS.
> > - Define GVE_TX_MAX_TSO_LEN_DQO (262143 bytes) to enforce the hardware
> >   L4 payload limit in the 24-bit tso_total_len field.
> > - In gve_tx_validate_descs():
> >   * Enforce packet size in [17, 9728] for non-TSO packets alongside
> >     the 10-descriptor limit (nb_descs <=3D GVE_TX_MAX_DATA_DESCS).
> >   * Reject TSO packets missing an L4 header (l4_len =3D=3D 0).
> >   * Reject packet with headers (L2-L4) not contiguous in first segment.
> >   * Reject TSO packets without payload (pkt_len <=3D headlen).
> >   * Enforce TSO total payload length limit (pkt_len - headlen <=3D 2621=
43).
> >   * Enforce MSS limits [88, 9728] and header length limit <=3D 255.
>
> I agree with the AI code review on this patch description.
> > 4. The commit message lists the diff line by line. Cut it to the
> > problem (invalid packets stalled the queue; hardware limits were
> > not enforced) and the fix (drop and continue; the limits enforced).
>
> Can we trim this message down a bit, and more succinctly explain the
> error condition and how this patch fixes it? If it cannot be describe
> succinctly, that might be a sign that the patch should be split up
> into smaller logical pieces.
>
> >
> > Fixes: 4022f9999f56 ("net/gve: support basic Tx data path for DQO")
> > Fixes: f4a70b449bfa ("net/gve: add DQO Tx descriptor limit")
> > Fixes: 403c671a46b6 ("net/gve: support TSO in DQO RDA")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
> > ---
> >  drivers/net/gve/base/gve_desc_dqo.h |  3 +
> >  drivers/net/gve/gve_ethdev.h        |  2 +-
> >  drivers/net/gve/gve_tx_dqo.c        | 92 +++++++++++++++++++++++------
> >  3 files changed, 79 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/net/gve/base/gve_desc_dqo.h b/drivers/net/gve/base=
/gve_desc_dqo.h
> > index c1534959c2..53e394f01c 100644
> > --- a/drivers/net/gve/base/gve_desc_dqo.h
> > +++ b/drivers/net/gve/base/gve_desc_dqo.h
> > @@ -12,6 +12,9 @@
> >
> >  #define GVE_TX_MAX_HDR_SIZE_DQO 255
> >  #define GVE_TX_MIN_TSO_MSS_DQO 88
> > +#define GVE_TX_MIN_PKT_SIZE_DQO 17
> > +#define GVE_TX_MAX_PKT_SIZE_DQO 9728
> > +#define GVE_TX_MAX_TSO_LEN_DQO ((256 * 1024) - 1)
> >
> >  /* Basic TX descriptor (DTYPE 0x0C) */
> >  struct gve_tx_pkt_desc_dqo {
> > diff --git a/drivers/net/gve/gve_ethdev.h b/drivers/net/gve/gve_ethdev.=
h
> > index 2033f49444..d6d71c31bb 100644
> > --- a/drivers/net/gve/gve_ethdev.h
> > +++ b/drivers/net/gve/gve_ethdev.h
> > @@ -113,7 +113,7 @@ struct gve_tx_stats {
> >         uint64_t packets;
> >         uint64_t bytes;
> >         uint64_t errors;
> > -       uint64_t too_many_descs;
> > +       uint64_t dropped_pkts;
>
> Is there any reason to change this to a general "dropped_pkts" instead
> of adding a different stat if there is a different error condition
> that needs to be captured? These are extended stats, so if we can give
> more specific drop conditions, I think we should aim to. However,
> there is nothing wrong with also introducing a new aggregate
> dropped_pkts stat. Not sure if adding new stats would be considered
> scope creep, though.
>
> >  };
> >
> >  struct gve_rx_stats {
> > diff --git a/drivers/net/gve/gve_tx_dqo.c b/drivers/net/gve/gve_tx_dqo.=
c
> > index eee1f10df1..94ea426961 100644
> > --- a/drivers/net/gve/gve_tx_dqo.c
> > +++ b/drivers/net/gve/gve_tx_dqo.c
> > @@ -126,20 +126,67 @@ gve_tx_clean_descs_dqo(struct gve_tx_queue *txq, =
uint16_t nb_descs) {
> >                 gve_tx_clean_dqo(txq);
> >  }
> >
> > +/* Max descriptors a single packet may use. A larger packet can never =
pass
> > + * gve_can_tx(): one slot is always reserved, the cacheline overlap ma=
rgin
> > + * must stay free, and up to GVE_TX_MIN_RE_INTERVAL - 1 descriptors po=
sted
> > + * after the last report_event are not reclaimed until more are posted=
.
> > + */
> > +static inline int
> > +gve_tx_max_pkt_descs(const struct gve_tx_queue *txq)
> > +{
> > +       return (int)txq->nb_tx_desc - 1 - GVE_TX_MIN_DESC_PREVENT_CACHE=
_OVERLAP -
> > +               (GVE_TX_MIN_RE_INTERVAL - 1);
> > +}
> > +
> >  /* GVE expects at most 10 data descriptors per mtu-sized segment. Beyo=
nd this,
> >   * the hardware will assume the driver is malicious and stop transmitt=
ing
> >   * packets altogether. Validate that a packet can be sent to avoid sen=
ding
> >   * posting descriptors for an invalid packet.
> >   */
> >  static inline bool
> > -gve_tx_validate_descs(struct rte_mbuf *tx_pkt, uint16_t nb_descs, bool=
 is_tso)
> > +gve_tx_validate_descs(const struct gve_tx_queue *txq, struct rte_mbuf =
*tx_pkt,
> > +                     uint16_t nb_descs, bool is_tso)
> >  {
> > -       if (!is_tso)
> > +       int num_descs, seg_offset, mbuf_len;
> > +       int tso_segsz, headlen;
> > +
> > +       /* Reject packets that can never fit in the ring */
> > +       if (unlikely(nb_descs > gve_tx_max_pkt_descs(txq)))
> > +               return false;
> > +
> > +       if (!is_tso) {
> > +               /* Reject packets that violate hardware length constrai=
nts */
> > +               if (unlikely(tx_pkt->pkt_len < GVE_TX_MIN_PKT_SIZE_DQO =
||
> > +                            tx_pkt->pkt_len > GVE_TX_MAX_PKT_SIZE_DQO)=
)
> > +                       return false;
> >                 return nb_descs <=3D GVE_TX_MAX_DATA_DESCS;
> > +       }
> >
> > -       int tso_segsz =3D tx_pkt->tso_segsz;
> > -       int num_descs, seg_offset, mbuf_len;
> > -       int headlen =3D tx_pkt->l2_len + tx_pkt->l3_len + tx_pkt->l4_le=
n;
> > +       headlen =3D tx_pkt->l2_len + tx_pkt->l3_len + tx_pkt->l4_len;
> > +
> > +       /* Reject missing TCP header on TSO */
> > +       if (unlikely(tx_pkt->l4_len =3D=3D 0))
> > +               return false;
> > +
> > +       /* Reject packet with headers (L2-L4) not contiguous in first s=
egment */
> > +       if (unlikely(tx_pkt->data_len < headlen))
> > +               return false;
> > +
> > +       /* Reject TSO packet without payload */
> > +       if (unlikely(tx_pkt->pkt_len <=3D (uint32_t)headlen))
> > +               return false;
> > +
> > +       /* Enforce GVE hardware TSO total length limit */
> > +       if (unlikely(tx_pkt->pkt_len - headlen > GVE_TX_MAX_TSO_LEN_DQO=
))
> > +               return false;
> > +
> > +       /* Enforce GVE hardware MSS and header limits */
> > +       if (unlikely(tx_pkt->tso_segsz < GVE_TX_MIN_TSO_MSS_DQO ||
> > +                    tx_pkt->tso_segsz > GVE_TX_MAX_PKT_SIZE_DQO ||
> > +                    headlen > GVE_TX_MAX_HDR_SIZE_DQO))
> > +               return false;
> > +
> > +       tso_segsz =3D tx_pkt->tso_segsz;
> >
> >         /* Headers will be split into their own buffer. */
> >         num_descs =3D 1;
> > @@ -147,14 +194,18 @@ gve_tx_validate_descs(struct rte_mbuf *tx_pkt, ui=
nt16_t nb_descs, bool is_tso)
> >         mbuf_len =3D tx_pkt->data_len - headlen;
> >
> >         while (tx_pkt) {
> > +               int seg_remain;
> > +
> >                 if (!mbuf_len)
> >                         goto next_mbuf;
> >
> > -               int seg_remain =3D tso_segsz - seg_offset;
> > +               seg_remain =3D tso_segsz - seg_offset;
> >                 if (num_descs =3D=3D GVE_TX_MAX_DATA_DESCS && seg_remai=
n)
> >                         return false;
> >
> >                 if (seg_remain < mbuf_len) {
> > +                       int mbuf_remain =3D tx_pkt->data_len % GVE_TX_M=
AX_BUF_SIZE_DQO;
> > +
> >                         seg_offset =3D mbuf_len % tso_segsz;
> >                         /* The MSS is bound from above by 9728B, so a
> >                          * single TSO segment in the middle of an mbuf
> > @@ -162,7 +213,6 @@ gve_tx_validate_descs(struct rte_mbuf *tx_pkt, uint=
16_t nb_descs, bool is_tso)
> >                          * is not at risk of defying this limitation.
> >                          * Thus, such segments are ignored.
> >                          */
> > -                       int mbuf_remain =3D tx_pkt->data_len % GVE_TX_M=
AX_BUF_SIZE_DQO;
> >
> >                         /* For each TSO segment, HW will prepend
> >                          * headers. The remaining bytes of this mbuf
> > @@ -184,7 +234,6 @@ gve_tx_validate_descs(struct rte_mbuf *tx_pkt, uint=
16_t nb_descs, bool is_tso)
> >                         mbuf_len =3D tx_pkt->data_len;
> >         }
> >
> > -
> >         return true;
> >  }
> >
> > @@ -256,6 +305,7 @@ gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf **=
tx_pkts, uint16_t nb_pkts)
> >         struct rte_mbuf *tx_pkt;
> >         struct gve_tx_pkt *pkts;
> >         uint32_t last_desc_idx;
> > +       uint16_t nb_drop =3D 0;
>
> Minor nit: maybe we can capture the number of packet sent after we
> write the descriptors instead? Then we can increment in one place
> instead of two, and remove the math in getting the number of packets
> sent.
>
> >         uint16_t nb_tx =3D 0;
> >         uint64_t bytes =3D 0;
> >         const char *reason;
> > @@ -281,9 +331,13 @@ gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf *=
*tx_pkts, uint16_t nb_pkts)
> >                                                txq->rs_thresh);
> >
> >
> > -               if (rte_mbuf_check(tx_pkt, true, &reason)) {
> > +               if (unlikely(rte_mbuf_check(tx_pkt, true, &reason))) {
> >                         PMD_DRV_DP_LOG(DEBUG, "Invalid mbuf: %s", reaso=
n);
> > -                       break;
> > +                       txq->stats.dropped_pkts++;
> > +                       txq->stats.errors++;
> > +                       rte_pktmbuf_free(tx_pkt);
> > +                       nb_drop++;
> > +                       continue;
> >                 }
> >
> >                 ol_flags =3D tx_pkt->ol_flags;
> > @@ -292,6 +346,16 @@ gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf *=
*tx_pkts, uint16_t nb_pkts)
> >
> >                 nb_descs =3D gve_tx_pkt_nb_data_descs(tx_pkt);
> >                 nb_descs +=3D tso;
> > +
> > +               /* Drop packet if it doesn't adhere to hardware limits.=
 */
> > +               if (unlikely(!gve_tx_validate_descs(txq, tx_pkt, nb_des=
cs, tso))) {
> > +                       txq->stats.dropped_pkts++;
> > +                       txq->stats.errors++;
> > +                       rte_pktmbuf_free(tx_pkt);
> > +                       nb_drop++;
> > +                       continue;
> > +               }
> > +
> >                 req_descs =3D nb_descs + GVE_TX_MIN_DESC_PREVENT_CACHE_=
OVERLAP;
> >
> >                 /* Clean if there aren't enough descriptors to send the=
 packet
> > @@ -306,12 +370,6 @@ gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf *=
*tx_pkts, uint16_t nb_pkts)
> >                                 break;
> >                 }
> >
> > -               /* Drop packet if it doesn't adhere to hardware limits.=
 */
> > -               if (!gve_tx_validate_descs(tx_pkt, nb_descs, tso)) {
> > -                       txq->stats.too_many_descs++;
> > -                       break;
> > -               }
> > -
> >                 if (!gve_free_compl_tags_pop(txq, &compl_tag))
> >                         break;
> >
> > @@ -357,7 +415,7 @@ gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf **=
tx_pkts, uint16_t nb_pkts)
> >         }
> >
> >         if (nb_tx > 0) {
> > -               txq->stats.packets +=3D nb_tx;
> > +               txq->stats.packets +=3D (nb_tx - nb_drop);
> >                 txq->stats.bytes +=3D bytes;
> >                 txq->stats.errors +=3D nb_pkts - nb_tx;
> >         }
> > --
> > 2.43.0
> >
