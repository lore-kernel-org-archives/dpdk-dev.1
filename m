Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB9BECC6B1D
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 00:50:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5AE39406BC;
	Wed, 14 Oct 2026 02:50:22 +0200 (CEST)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com
 [209.85.218.48]) by mails.dpdk.org (Postfix) with ESMTP id F0F9A402DA
 for <dev@dpdk.org>; Wed, 14 Oct 2026 02:50:20 +0200 (CEST)
Received: by mail-ej1-f48.google.com with SMTP id
 a640c23a62f3a-c2a4e013a44so77579266b.2
 for <dev@dpdk.org>; Tue, 13 Oct 2026 17:50:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791939020; cv=none;
 d=google.com; s=arc-20260327;
 b=Bp3OI/lBG1CuUbtCNMQxnDL+f2edavP31Z4sMgQ5yH1VIqd24PSNiA443LoKlCJPum
 HFy4Fu0FHUzxhtYUFFNWWMk5TqSOQa1oNxhxGNT7d/qBCAzb7PZ2ejvkj11//LqYxXRX
 l8i6SypPdMe/cNnOFI9UPpPcIrj5gfDC02zqaii0iYN0GVujR75BkQ98afeIRUk0hVuw
 n3IMVZ+Dfgk7EA+wegY1JKF8AGtB6wDRSaIP01Vu5vy4mh+QBWihdwpjWjBiHrglfEJr
 rGiy2iV5nQvAL6tUUWtOdubJHe/Wme6hOJAdKXVMZZg2fqhZzdnLhYyWPiwdN9YQyTJX
 i77w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/PjHDw+0Q8YRpBctlmh0ixuth0KhHm0jzO2cnHejdN0=;
 fh=B7P2NvyyRGOjLSxx5zip+3vrfzLklYHr6xZFKEWgy2s=;
 b=CT0apXqhJ6qNq8HbvjT66cGSOhLi2i/qJi6k1X0i3cSzupPG8XwkQ3n6X5fbogzJVq
 T861zcWwpC9RJ5WfYxyjH4EgwsJP9YuNabE03XlXjelIOa3LW0Glco7oifAMNfXYJKcx
 ABmjrOHRBKIHPWeYBKaxred22setKGCX3GMwBxHJnkxBfKYN3HTe1TUHzbicE5c8NULf
 YhpwToReYqoew31to7Ry0oU0rSyl9xG5SJqc5vjLRcBAhAlFQHNLJ+QImJX64cx4QwgN
 nZezUolw6x3qeW3+fS0Uy3xaHRWkkYyavNK0tWepLArxJxp+dGUUNe33PxMBSGgBobQ+
 /uFw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791939020; x=1792543820; darn=dpdk.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/PjHDw+0Q8YRpBctlmh0ixuth0KhHm0jzO2cnHejdN0=;
 b=dwYNi8WZoYkSuZxLvomJaGBpZjAsVMmVttAO1B3Grp17MANGDg0Rig0TIa9115opn3
 RDuzWzPE/D/PeKhLozu62c1m+/XWbu6H3tFC4UzYZiXyKzUDcMdZCKjivwRAz5NkdwFZ
 7eKP4fWWoo6ESYOYFgGKZzVcbaIbmDd+eQtCHXkA9guQjzItNm3/iV1ZjRk6ZelTfXa0
 gwLhP5WhhOT2Ef8X02tVVLT8Jqud9bVNctQ6TVR/1+vLDrZtDXNre95hRrqvE+kGtdZ5
 kUF19uVz+3laumIQ35xBW8i3LceRvib2kffUrEiYiqeHMznunbLanw7roBTSd0tPJOWm
 2RQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791939020; x=1792543820;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/PjHDw+0Q8YRpBctlmh0ixuth0KhHm0jzO2cnHejdN0=;
 b=wxAjv3Mku7TFa83k5hz5FFZuNAcZfrY6EJj93/sA/EEFajPqpUIJPb33edLBTqFZdZ
 g8KxxLsfkvQfLsdw4cGZcjwkY9xF+gEhr4NPPsnRMHM4S8QSMXrtKi9QapOCGqgnjR84
 oZKPNule5eonCzV4g5Qc5jFVHle9sbG/nt07Wb+lHQVatjPHtk+SyKZQhEc7yTi3vTSl
 YAdhkD0ro6Tq7N2Yb8sWcFWCnzIbAnplGEouN0ONzRNwkPB9jVpXAx9uL9zTlLywNuNM
 go7P7pfCKAJfXa0Pcpl8VltYO/A6Kn7H2PR6RLL9/wzxV8HdJNDkreXRVTdw/QGJYDe2
 TtHw==
X-Gm-Message-State: AFq9FYI2FRI7EfqJsrpZBDRqOJYPdKdlrlhp6brNBNbV9y+er8/Toedo
 hPErECSoGkSxzY6IXHVB7VVo1ytPaaIiQ74tbnjyZ0+sX/maZLtKfalgQ0WQhiPgJdCySKpBskc
 iwQZMtc1sjB5+PL7JumDg6hvUz3MZrw1pJ9TZ0E0r
X-Gm-Gg: AYBFou2TkGhuJLVKizrgUCQciUXS9gCm2wH+QXFc+S87fz9EeK8Zk05J0DRRevwwciC
 0DGstyKWTTGutnPRlfnvTdjhFGN5HML6sBa+x8YJ9qpr14T6mQuWdf8R/qa+AnGYysDuFAgJu8w
 6ZM1urWXz/wmq6jPLQ/CAezRJ82PW/Se8SmdSToKTjlrB11gSOQvIxOUH2ervRfPPNO9L6ew+Y+
 Q/6XuwMawoLtownRthOn0560srjOh0WrpYbyO3poDukMffvD/44idCCu6g9Z2FnElJyOujpVZpQ
 uY93vkAMJNagyF1ksY8jOujNTv06yx93GjTfXTVvWm59dlkxQezQupl1P7ut8lVL56dP1tlMUM7
 UD1YLM+KTLw==
X-Received: by 2002:a17:907:2d21:b0:c2b:7686:4d7 with SMTP id
 a640c23a62f3a-c31a9ff6976mr1315550066b.39.1791939019922; Tue, 13 Oct 2026
 17:50:19 -0700 (PDT)
MIME-Version: 1.0
References: <20261012105023.669486-1-tathagat.dpdk@gmail.com>
 <20261013104348.714550-1-tathagat.dpdk@gmail.com>
 <20261013104348.714550-5-tathagat.dpdk@gmail.com>
In-Reply-To: <20261013104348.714550-5-tathagat.dpdk@gmail.com>
From: Joshua Washington <joshwash@google.com>
Date: Tue, 13 Oct 2026 17:50:08 -0700
X-Gm-Features: AclHuK-uHP0hDU_nvK0vBEtL6_vTZXSIuH93-rKTKIQue6-Jx1DDPK7OM4k2xC4
Message-ID: <CALuQH+U5ATv0wZ6aEAD3=QeCaWn6SZc5GmagV-Vi5h+5emD_+Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] net/gve: add packet and TSO hardware constraints
 for DQO
To: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
Cc: dev@dpdk.org, stephen@networkplumber.org, stable@dpdk.org
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

On Tue, Oct 13, 2026 at 3:44=E2=80=AFAM Tathagat Priyadarshi
<tathagat.dpdk@gmail.com> wrote:
>
> The GVNIC DQO hardware restricts each packet (or MTU segment in TSO)
> to at most 10 data descriptors (GVE_TX_MAX_DATA_DESCS), beyond which
> the hardware drops traffic. In addition to this 10-descriptor limit,
> the hardware imposes strict packet sizing and header constraints.
>
> Previously, failing the descriptor limit or rte_mbuf_check() broke
> from the Tx burst loop without consuming the invalid mbuf. This caused
> tx_burst to return a short count, leading the application to retry the
> same rejected packet indefinitely and causing Head-of-Line (HOL)
> queue stalls.
>
> Enforce hardware validation and prevent HOL blocking in DPDK:
> - Validate packet and hardware constraints prior to ring space checks.
> - When packet validation or rte_mbuf_check() fails, drop and free the
>   invalid mbuf with rte_pktmbuf_free(), update stats, and continue the
>   burst to prevent Head-of-Line (HOL) blocking.
> - Exclude dropped packets from txq->stats.packets while returning the
>   total consumed count to the caller.
> - Rename too_many_descs in struct gve_tx_stats to dropped_pkts to reflect
>   all validation and malformed mbuf drop events.
> - Reject packets whose descriptor count exceeds the maximum capacity of
>   the ring (accounting for reserved slots, cacheline overlap margin, and
>   unreported descriptors), preventing permanent queue stalls.
> - Define GVE_TX_MIN_PKT_SIZE_DQO (17 bytes) and GVE_TX_MAX_PKT_SIZE_DQO
>   (9728 bytes) to enforce wire packet boundaries for non-TSO packets
>   and TSO MSS.
> - Define GVE_TX_MAX_TSO_LEN_DQO (262143 bytes) to enforce the hardware
>   L4 payload limit in the 24-bit tso_total_len field.
> - In gve_tx_validate_descs():
>   * Enforce packet size in [17, 9728] for non-TSO packets alongside
>     the 10-descriptor limit (nb_descs <=3D GVE_TX_MAX_DATA_DESCS).
>   * Reject TSO packets missing an L4 header (l4_len =3D=3D 0).
>   * Reject packet with headers (L2-L4) not contiguous in first segment.
>   * Reject TSO packets without payload (pkt_len <=3D headlen).
>   * Enforce TSO total payload length limit (pkt_len - headlen <=3D 262143=
).
>   * Enforce MSS limits [88, 9728] and header length limit <=3D 255.

I agree with the AI code review on this patch description.
> 4. The commit message lists the diff line by line. Cut it to the
> problem (invalid packets stalled the queue; hardware limits were
> not enforced) and the fix (drop and continue; the limits enforced).

Can we trim this message down a bit, and more succinctly explain the
error condition and how this patch fixes it? If it cannot be describe
succinctly, that might be a sign that the patch should be split up
into smaller logical pieces.

>
> Fixes: 4022f9999f56 ("net/gve: support basic Tx data path for DQO")
> Fixes: f4a70b449bfa ("net/gve: add DQO Tx descriptor limit")
> Fixes: 403c671a46b6 ("net/gve: support TSO in DQO RDA")
> Cc: stable@dpdk.org
>
> Signed-off-by: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
> ---
>  drivers/net/gve/base/gve_desc_dqo.h |  3 +
>  drivers/net/gve/gve_ethdev.h        |  2 +-
>  drivers/net/gve/gve_tx_dqo.c        | 92 +++++++++++++++++++++++------
>  3 files changed, 79 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/net/gve/base/gve_desc_dqo.h b/drivers/net/gve/base/g=
ve_desc_dqo.h
> index c1534959c2..53e394f01c 100644
> --- a/drivers/net/gve/base/gve_desc_dqo.h
> +++ b/drivers/net/gve/base/gve_desc_dqo.h
> @@ -12,6 +12,9 @@
>
>  #define GVE_TX_MAX_HDR_SIZE_DQO 255
>  #define GVE_TX_MIN_TSO_MSS_DQO 88
> +#define GVE_TX_MIN_PKT_SIZE_DQO 17
> +#define GVE_TX_MAX_PKT_SIZE_DQO 9728
> +#define GVE_TX_MAX_TSO_LEN_DQO ((256 * 1024) - 1)
>
>  /* Basic TX descriptor (DTYPE 0x0C) */
>  struct gve_tx_pkt_desc_dqo {
> diff --git a/drivers/net/gve/gve_ethdev.h b/drivers/net/gve/gve_ethdev.h
> index 2033f49444..d6d71c31bb 100644
> --- a/drivers/net/gve/gve_ethdev.h
> +++ b/drivers/net/gve/gve_ethdev.h
> @@ -113,7 +113,7 @@ struct gve_tx_stats {
>         uint64_t packets;
>         uint64_t bytes;
>         uint64_t errors;
> -       uint64_t too_many_descs;
> +       uint64_t dropped_pkts;

Is there any reason to change this to a general "dropped_pkts" instead
of adding a different stat if there is a different error condition
that needs to be captured? These are extended stats, so if we can give
more specific drop conditions, I think we should aim to. However,
there is nothing wrong with also introducing a new aggregate
dropped_pkts stat. Not sure if adding new stats would be considered
scope creep, though.

>  };
>
>  struct gve_rx_stats {
> diff --git a/drivers/net/gve/gve_tx_dqo.c b/drivers/net/gve/gve_tx_dqo.c
> index eee1f10df1..94ea426961 100644
> --- a/drivers/net/gve/gve_tx_dqo.c
> +++ b/drivers/net/gve/gve_tx_dqo.c
> @@ -126,20 +126,67 @@ gve_tx_clean_descs_dqo(struct gve_tx_queue *txq, ui=
nt16_t nb_descs) {
>                 gve_tx_clean_dqo(txq);
>  }
>
> +/* Max descriptors a single packet may use. A larger packet can never pa=
ss
> + * gve_can_tx(): one slot is always reserved, the cacheline overlap marg=
in
> + * must stay free, and up to GVE_TX_MIN_RE_INTERVAL - 1 descriptors post=
ed
> + * after the last report_event are not reclaimed until more are posted.
> + */
> +static inline int
> +gve_tx_max_pkt_descs(const struct gve_tx_queue *txq)
> +{
> +       return (int)txq->nb_tx_desc - 1 - GVE_TX_MIN_DESC_PREVENT_CACHE_O=
VERLAP -
> +               (GVE_TX_MIN_RE_INTERVAL - 1);
> +}
> +
>  /* GVE expects at most 10 data descriptors per mtu-sized segment. Beyond=
 this,
>   * the hardware will assume the driver is malicious and stop transmittin=
g
>   * packets altogether. Validate that a packet can be sent to avoid sendi=
ng
>   * posting descriptors for an invalid packet.
>   */
>  static inline bool
> -gve_tx_validate_descs(struct rte_mbuf *tx_pkt, uint16_t nb_descs, bool i=
s_tso)
> +gve_tx_validate_descs(const struct gve_tx_queue *txq, struct rte_mbuf *t=
x_pkt,
> +                     uint16_t nb_descs, bool is_tso)
>  {
> -       if (!is_tso)
> +       int num_descs, seg_offset, mbuf_len;
> +       int tso_segsz, headlen;
> +
> +       /* Reject packets that can never fit in the ring */
> +       if (unlikely(nb_descs > gve_tx_max_pkt_descs(txq)))
> +               return false;
> +
> +       if (!is_tso) {
> +               /* Reject packets that violate hardware length constraint=
s */
> +               if (unlikely(tx_pkt->pkt_len < GVE_TX_MIN_PKT_SIZE_DQO ||
> +                            tx_pkt->pkt_len > GVE_TX_MAX_PKT_SIZE_DQO))
> +                       return false;
>                 return nb_descs <=3D GVE_TX_MAX_DATA_DESCS;
> +       }
>
> -       int tso_segsz =3D tx_pkt->tso_segsz;
> -       int num_descs, seg_offset, mbuf_len;
> -       int headlen =3D tx_pkt->l2_len + tx_pkt->l3_len + tx_pkt->l4_len;
> +       headlen =3D tx_pkt->l2_len + tx_pkt->l3_len + tx_pkt->l4_len;
> +
> +       /* Reject missing TCP header on TSO */
> +       if (unlikely(tx_pkt->l4_len =3D=3D 0))
> +               return false;
> +
> +       /* Reject packet with headers (L2-L4) not contiguous in first seg=
ment */
> +       if (unlikely(tx_pkt->data_len < headlen))
> +               return false;
> +
> +       /* Reject TSO packet without payload */
> +       if (unlikely(tx_pkt->pkt_len <=3D (uint32_t)headlen))
> +               return false;
> +
> +       /* Enforce GVE hardware TSO total length limit */
> +       if (unlikely(tx_pkt->pkt_len - headlen > GVE_TX_MAX_TSO_LEN_DQO))
> +               return false;
> +
> +       /* Enforce GVE hardware MSS and header limits */
> +       if (unlikely(tx_pkt->tso_segsz < GVE_TX_MIN_TSO_MSS_DQO ||
> +                    tx_pkt->tso_segsz > GVE_TX_MAX_PKT_SIZE_DQO ||
> +                    headlen > GVE_TX_MAX_HDR_SIZE_DQO))
> +               return false;
> +
> +       tso_segsz =3D tx_pkt->tso_segsz;
>
>         /* Headers will be split into their own buffer. */
>         num_descs =3D 1;
> @@ -147,14 +194,18 @@ gve_tx_validate_descs(struct rte_mbuf *tx_pkt, uint=
16_t nb_descs, bool is_tso)
>         mbuf_len =3D tx_pkt->data_len - headlen;
>
>         while (tx_pkt) {
> +               int seg_remain;
> +
>                 if (!mbuf_len)
>                         goto next_mbuf;
>
> -               int seg_remain =3D tso_segsz - seg_offset;
> +               seg_remain =3D tso_segsz - seg_offset;
>                 if (num_descs =3D=3D GVE_TX_MAX_DATA_DESCS && seg_remain)
>                         return false;
>
>                 if (seg_remain < mbuf_len) {
> +                       int mbuf_remain =3D tx_pkt->data_len % GVE_TX_MAX=
_BUF_SIZE_DQO;
> +
>                         seg_offset =3D mbuf_len % tso_segsz;
>                         /* The MSS is bound from above by 9728B, so a
>                          * single TSO segment in the middle of an mbuf
> @@ -162,7 +213,6 @@ gve_tx_validate_descs(struct rte_mbuf *tx_pkt, uint16=
_t nb_descs, bool is_tso)
>                          * is not at risk of defying this limitation.
>                          * Thus, such segments are ignored.
>                          */
> -                       int mbuf_remain =3D tx_pkt->data_len % GVE_TX_MAX=
_BUF_SIZE_DQO;
>
>                         /* For each TSO segment, HW will prepend
>                          * headers. The remaining bytes of this mbuf
> @@ -184,7 +234,6 @@ gve_tx_validate_descs(struct rte_mbuf *tx_pkt, uint16=
_t nb_descs, bool is_tso)
>                         mbuf_len =3D tx_pkt->data_len;
>         }
>
> -
>         return true;
>  }
>
> @@ -256,6 +305,7 @@ gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf **tx=
_pkts, uint16_t nb_pkts)
>         struct rte_mbuf *tx_pkt;
>         struct gve_tx_pkt *pkts;
>         uint32_t last_desc_idx;
> +       uint16_t nb_drop =3D 0;

Minor nit: maybe we can capture the number of packet sent after we
write the descriptors instead? Then we can increment in one place
instead of two, and remove the math in getting the number of packets
sent.

>         uint16_t nb_tx =3D 0;
>         uint64_t bytes =3D 0;
>         const char *reason;
> @@ -281,9 +331,13 @@ gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf **t=
x_pkts, uint16_t nb_pkts)
>                                                txq->rs_thresh);
>
>
> -               if (rte_mbuf_check(tx_pkt, true, &reason)) {
> +               if (unlikely(rte_mbuf_check(tx_pkt, true, &reason))) {
>                         PMD_DRV_DP_LOG(DEBUG, "Invalid mbuf: %s", reason)=
;
> -                       break;
> +                       txq->stats.dropped_pkts++;
> +                       txq->stats.errors++;
> +                       rte_pktmbuf_free(tx_pkt);
> +                       nb_drop++;
> +                       continue;
>                 }
>
>                 ol_flags =3D tx_pkt->ol_flags;
> @@ -292,6 +346,16 @@ gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf **t=
x_pkts, uint16_t nb_pkts)
>
>                 nb_descs =3D gve_tx_pkt_nb_data_descs(tx_pkt);
>                 nb_descs +=3D tso;
> +
> +               /* Drop packet if it doesn't adhere to hardware limits. *=
/
> +               if (unlikely(!gve_tx_validate_descs(txq, tx_pkt, nb_descs=
, tso))) {
> +                       txq->stats.dropped_pkts++;
> +                       txq->stats.errors++;
> +                       rte_pktmbuf_free(tx_pkt);
> +                       nb_drop++;
> +                       continue;
> +               }
> +
>                 req_descs =3D nb_descs + GVE_TX_MIN_DESC_PREVENT_CACHE_OV=
ERLAP;
>
>                 /* Clean if there aren't enough descriptors to send the p=
acket
> @@ -306,12 +370,6 @@ gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf **t=
x_pkts, uint16_t nb_pkts)
>                                 break;
>                 }
>
> -               /* Drop packet if it doesn't adhere to hardware limits. *=
/
> -               if (!gve_tx_validate_descs(tx_pkt, nb_descs, tso)) {
> -                       txq->stats.too_many_descs++;
> -                       break;
> -               }
> -
>                 if (!gve_free_compl_tags_pop(txq, &compl_tag))
>                         break;
>
> @@ -357,7 +415,7 @@ gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf **tx=
_pkts, uint16_t nb_pkts)
>         }
>
>         if (nb_tx > 0) {
> -               txq->stats.packets +=3D nb_tx;
> +               txq->stats.packets +=3D (nb_tx - nb_drop);
>                 txq->stats.bytes +=3D bytes;
>                 txq->stats.errors +=3D nb_pkts - nb_tx;
>         }
> --
> 2.43.0
>
