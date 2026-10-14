Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA03CC6B19
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 00:30:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 81E2840279;
	Wed, 14 Oct 2026 02:30:32 +0200 (CEST)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com
 [209.85.218.53]) by mails.dpdk.org (Postfix) with ESMTP id DF1EE40279
 for <dev@dpdk.org>; Wed, 14 Oct 2026 02:30:30 +0200 (CEST)
Received: by mail-ej1-f53.google.com with SMTP id
 a640c23a62f3a-c2e62319cfaso47396766b.2
 for <dev@dpdk.org>; Tue, 13 Oct 2026 17:30:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791937830; cv=none;
 d=google.com; s=arc-20260327;
 b=r2doqiB6Q1+lOk+yrO5I0Xfn4dnRP2wfedGCLgmiT60HPY3CXJe1A2PnJegiIXvfoT
 oc2ZFUOgt7Z4jtxiiwTbuSB0t9mfGlXSTtFgy/8Zn9sVaY5HXSt9NG2mtIoCfAmXIjvB
 ZIwIecynFURVxg4xSvXe7+yXo9oe7hFfudAsCsa67FUjG0CEK+sPh/7URp1R28l65tTc
 Y0JA19husvmcwK0b8RHpAGtLF3+6ZFz8kgqJNeNh0AmxjGBQIl3rtf8mysDu2D9ZkuiM
 LaIr603iI/zoIb8J3GLUSlKI9um09+oHGK7cX3JXwkJwKvSOa8cg5Qb/3wzHPXb81liU
 akLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Au+j6XLyrX/YKyIZbqxFRBKorf/ZVTFxzOym8fG+kTs=;
 fh=B7P2NvyyRGOjLSxx5zip+3vrfzLklYHr6xZFKEWgy2s=;
 b=RhUhVeXfuo+yVi/XsO1AcHZ4+4n+fdnJN1ULpTM9tFw4ijM32QnqW2UQCCNUxXMRVu
 fIdslTy7nswe3vyTwzAybw+h/b98LGBX118uJPaVR+RLGeV8v+pUc+am9DjSrGN7MhnV
 9+bT+xAtrWSbM7pCu5Kn9FeC05MPBagfTyWRxLfVeTfAbUlCOLdHl+3L03vW5ckt8056
 vBiT4vyrU8Wfl3sObvNi+DG4pcY9sb4YXld7xkWY5ezIeol3sIF1BNs8RIaQRL1gCMD4
 qwYfd7DxVLatxQjmMntggEIhwA3m+tyeoDP9BP27psqt0Sv9uzEq9Kc+8ayjgsxqRrdq
 0ASQ==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791937830; x=1792542630; darn=dpdk.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Au+j6XLyrX/YKyIZbqxFRBKorf/ZVTFxzOym8fG+kTs=;
 b=Hp2BM0rOWi/KTSrlTznOdiBuTHtFApkxKd8i2pONllQV9ynRlh9t8tqOxu+HBpQ+M+
 0Pa47VV1xxgUulkQCvS8MjUi5FXJl8AMby/hlRBE94QrI4zShSGsWlF5l71UHaOB/gWF
 hiV1qxb73u6pDSHS4Oh0qW4eFKYTk8B8pBdbO5005Gy1gczIaKGmIUZAHG6px9pLMEQk
 4j+afUz1iiiYC2lSuL5WWYYRXn3+oVqBg1sZUHT4QE29CAP/vUMmJpWvbejZReVqjxkH
 HBSMilnyB9Bx0WuinQeDCZgcptP6y3kxhNfkD4xdZhxKi2FNQ5txNBCivFx8RbYH8/0Z
 e5iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791937830; x=1792542630;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Au+j6XLyrX/YKyIZbqxFRBKorf/ZVTFxzOym8fG+kTs=;
 b=Q0moFUftOeHyzX5Vlsh2mq9vD/sJpE1GlneDOT8xBc+ZjGFbmaoo/aqgyP4SJ8YO4+
 mYBhSVAcu19sETwjVwqacnJiws5+XByXfZ9gA/9OUj3BLSgTk+/KYBzzKawwBLYgiNSt
 9vLF9N2cD6oDkUUtxhC6SxAJfoKSWCr7giKNvGeYnRknBZGx9wjA8tbnzg7YRw7nitza
 bFwlgObkSvALDjBBylBGlwbhWbENY3OqWufYHZANrly7V3gftBb/nWLe9QOXpPS1o3qK
 8yupjxRYF5XEMCNTxuKvewVBxSze6TXX9B4etZjv1h8nryiDyaz9aOs+XA+4rjcjCoQw
 vgGA==
X-Gm-Message-State: AFq9FYJar987h4OGnzQkCMBZcIyRJJf6NTu/J4GZYNki5p0qV74vXWIt
 J+lCdTcpcd/nc9XFu9dC9AqxZgk8Et+4tYlEp3Y0yPooVns+pZxOt79GZeGG78e+cGmT/Vou4Iu
 VWpH2OjrxStUR/yBIhnszuploa9QmjkTUvrzluxJm
X-Gm-Gg: AYBFou2kCDiB4Wtpv6VzoQF4/itRc/LH9S06ruay1WAXAtZEmAl5KxceLB1Tk2LBbRO
 x1Uz4j7VBBWGP7O2VFvdym32cYOXAan06osXda5pBYQrh1IGkupy/qWo4jnpUPhIWqif0rjJRi2
 7sGKW0GZliYCLLk7pOHSKe8mUI49QHMkntDPgdzG4xlvGfkeBDbLQldtHO2tVmDAgwgXD0i90kX
 pBhabzl6DdLOs+w7Z0r1M9jQNasw1SZWiu6v45b/YUrUDKSB1fwG821t6hvPj4M1a7ZZA4eN3KT
 BVwQLFjUdKPJFn5VP6Bo4wTm35XmnuVEEZ4UoJca6C+ajxyajw0HbnYLVNWLon3fzhC7z/whMk0
 PHolhP8w0Bw==
X-Received: by 2002:a17:907:7243:b0:c26:19de:9138 with SMTP id
 a640c23a62f3a-c31aa0c3392mr1396406766b.43.1791937829894; Tue, 13 Oct 2026
 17:30:29 -0700 (PDT)
MIME-Version: 1.0
References: <20261012105023.669486-1-tathagat.dpdk@gmail.com>
 <20261013104348.714550-1-tathagat.dpdk@gmail.com>
 <20261013104348.714550-3-tathagat.dpdk@gmail.com>
In-Reply-To: <20261013104348.714550-3-tathagat.dpdk@gmail.com>
From: Joshua Washington <joshwash@google.com>
Date: Tue, 13 Oct 2026 17:30:18 -0700
X-Gm-Features: AclHuK-qbmhjoXxvBqZgQcT5yGanylAcy6C80GKaY0skl4qpPPA_qxyESk3Hhos
Message-ID: <CALuQH+Uvi5_HyHAq9zviPt0BOvMBW9cTp1JibXPqdocNKEnyag@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] net/gve: fix DQO Tx queue stall on multi-seg and
 TSO
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
> The DPDK GVE driver previously tracked transmitted packet count (re_cnt)
> at the end of each burst rather than tracking descriptor intervals per
> packet against GVE_TX_MIN_RE_INTERVAL (32).
>
> In multi-segment and TSO transmissions, each packet consumes multiple
> descriptors. The descriptor ring could exhaust before 32 packets were
> sent, resulting in zero descriptors requesting report_event and
> preventing the hardware DMA engine from returning GVE_COMPL_TYPE_DQO_DESC
> completions. Without these completions, txq->nb_free was never
> replenished, permanently stalling the TX queue.
>
> Align with the Linux kernel driver (gve_tx_update_tail()) by tracking
> descriptor indices with last_re_idx:
> - Replace re_cnt with last_re_idx in struct gve_tx_queue.
> - Reset last_re_idx =3D 0 in gve_reset_tx_ring_state_dqo().
> - On each packet transmission, check descriptor interval
>   (last_desc_idx - last_re_idx) & mask >=3D GVE_TX_MIN_RE_INTERVAL.
>   When met, set report_event on the packet's last descriptor and
>   update last_re_idx.
> - Ring the transmit doorbell immediately upon setting report_event to
>   kick hardware processing early and reduce device fetch latency during
>   bursts of multi-descriptor TSO packets, amortizing MMIO writes over
>   RE_INTERVAL descriptors.
> - Defensively pop completion tags before writing TSO context descriptors
>   to avoid partial descriptor ring updates if completion tags are
>   exhausted.
>
> Fixes: 4022f9999f56 ("net/gve: support basic Tx data path for DQO")
> Fixes: 403c671a46b6 ("net/gve: support TSO in DQO RDA")
> Cc: stable@dpdk.org
>
> Signed-off-by: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
> ---
>  drivers/net/gve/gve_ethdev.h |  2 +-
>  drivers/net/gve/gve_tx_dqo.c | 46 ++++++++++++++++++++----------------
>  2 files changed, 27 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/net/gve/gve_ethdev.h b/drivers/net/gve/gve_ethdev.h
> index c9a176ff17..2033f49444 100644
> --- a/drivers/net/gve/gve_ethdev.h
> +++ b/drivers/net/gve/gve_ethdev.h
> @@ -193,8 +193,8 @@ struct gve_tx_queue {
>         uint16_t sw_size;
>         uint8_t cur_gen_bit;
>         uint32_t last_desc_cleaned;
> +       uint32_t last_re_idx;
>         void **txqs;
> -       uint16_t re_cnt;
>
>         /* Only valid for DQO_RDA queue format */
>         struct gve_tx_queue *complq;
> diff --git a/drivers/net/gve/gve_tx_dqo.c b/drivers/net/gve/gve_tx_dqo.c
> index c864d722d9..0839179d7f 100644
> --- a/drivers/net/gve/gve_tx_dqo.c
> +++ b/drivers/net/gve/gve_tx_dqo.c
> @@ -250,21 +250,23 @@ gve_fill_tx_pkt_desc(struct gve_tx_queue *txq, uint=
16_t *tx_id,
>  uint16_t
>  gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_=
pkts)
>  {
> +       volatile union gve_tx_desc_dqo *txr, *txd;
>         struct gve_tx_queue *txq =3D tx_queue;
> -       volatile union gve_tx_desc_dqo *txr;
> -       volatile union gve_tx_desc_dqo *txd;
> -       uint16_t mask =3D txq->nb_tx_desc - 1;
> -       struct gve_tx_pkt *pkts;
> +       uint32_t last_re_interval;
>         struct rte_mbuf *tx_pkt;
> -       uint16_t compl_tag;
> -       const char *reason;
> +       struct gve_tx_pkt *pkts;
> +       uint32_t last_desc_idx;
>         uint16_t nb_tx =3D 0;
>         uint64_t bytes =3D 0;
> +       const char *reason;
> +       uint16_t compl_tag;
>         uint64_t ol_flags;
>         uint16_t nb_descs;
> -       bool csum, tso;
>         uint16_t tx_id;
> +       bool csum, tso;
> +       uint16_t mask;

It's kind of hard to tell from first glance, given how many
declarations are here and how many are changing, but are all of these
changes necessary for a fix? Things like moving txr, txd to the same
line or separating the declaration and definition of mask, even though
txq is already defined in an earlier line anyway seem unnecessary at
first glance. There might be other such changes, but I stopped there,
since those are in the first 5 lines of delta. Let's try to keep the
fix focused, only making changes that are actually necessary.

>
> +       mask =3D txq->nb_tx_desc - 1;
>         pkts =3D txq->pkt_ring_dqo;
>         txr =3D txq->tx_ring;
>
> @@ -306,15 +308,15 @@ gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf **=
tx_pkts, uint16_t nb_pkts)
>                         break;
>                 }
>
> +               if (!gve_free_compl_tags_pop(txq, &compl_tag))
> +                       break;
> +
>                 if (tso) {
>                         txd =3D &txr[tx_id];
>                         gve_tx_fill_seg_desc_dqo(txd, tx_pkt);
>                         tx_id =3D (tx_id + 1) & mask;
>                 }
>
> -               if (!gve_free_compl_tags_pop(txq, &compl_tag))
> -                       break;
> -
>                 pkts[compl_tag].mbuf =3D tx_pkt;
>                 while (tx_pkt) {
>                         /* Skip writing descriptors if mbuf has no data. =
*/
> @@ -331,23 +333,26 @@ gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf **=
tx_pkts, uint16_t nb_pkts)
>                 txd =3D &txr[(tx_id - 1) & mask];
>                 txd->pkt.end_of_packet =3D 1;
>
> +               last_desc_idx =3D (tx_id - 1) & mask;
> +               last_re_interval =3D (last_desc_idx - txq->last_re_idx) &=
 mask;
> +               if (unlikely(last_re_interval >=3D GVE_TX_MIN_RE_INTERVAL=
)) {
> +                       txd->pkt.report_event =3D true;
> +                       txq->last_re_idx =3D last_desc_idx;
> +                       rte_write32(tx_id, txq->qtx_tail);
> +                       txq->tx_tail =3D tx_id;
> +               }
> +
>                 txq->nb_free -=3D nb_descs;
>                 txq->nb_used +=3D nb_descs;
>         }
>
> -       /* update the tail pointer if any packets were processed */
> -       if (nb_tx > 0) {
> -               /* Request a descriptor completion on the last descriptor=
 */
> -               txq->re_cnt +=3D nb_tx;
> -               if (txq->re_cnt >=3D GVE_TX_MIN_RE_INTERVAL) {
> -                       txd =3D &txr[(tx_id - 1) & mask];
> -                       txd->pkt.report_event =3D true;
> -                       txq->re_cnt =3D 0;
> -               }
> -
> +       /* update the tail pointer if any uncommitted descriptors remain =
*/
> +       if (txq->tx_tail !=3D tx_id) {
>                 rte_write32(tx_id, txq->qtx_tail);
>                 txq->tx_tail =3D tx_id;
> +       }
>
> +       if (nb_tx > 0) {
>                 txq->stats.packets +=3D nb_tx;
>                 txq->stats.bytes +=3D bytes;
>                 txq->stats.errors +=3D nb_pkts - nb_tx;
> @@ -445,6 +450,7 @@ gve_reset_tx_ring_state_dqo(struct gve_tx_queue *txq)
>         txq->nb_used =3D 0;
>
>         txq->last_desc_cleaned =3D 0;
> +       txq->last_re_idx =3D 0;
>         txq->nb_free =3D txq->nb_tx_desc - 1;
>
>         txq->complq_tail =3D 0;
> --
> 2.43.0
>
