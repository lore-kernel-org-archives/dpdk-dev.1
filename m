Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37FCFCA9EDE
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Oct 2026 18:13:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 75CE0402C8;
	Mon, 12 Oct 2026 20:13:47 +0200 (CEST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com
 [209.85.208.50]) by mails.dpdk.org (Postfix) with ESMTP id F1EB5402C6
 for <dev@dpdk.org>; Mon, 12 Oct 2026 20:13:45 +0200 (CEST)
Received: by mail-ed1-f50.google.com with SMTP id
 4fb4d7f45d1cf-6b1aa2848d2so2172162a12.3
 for <dev@dpdk.org>; Mon, 12 Oct 2026 11:13:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791828825; cv=none;
 d=google.com; s=arc-20260327;
 b=fPidsxoxqcXMzG4G/n7GAb3xcaLZsxJy/1kITbRJW0epWn8C5bGicndYBdGWQUwrZd
 rG3/Iaqga3doYayLej6hqTGboWVXk6zNpU6sr4OPkGNgRLWS+HZ6niCsv17pyB26Q6ic
 krqIgOts2zTE7yMnRg+/19UHa3xcOBBVcWPIaaDVeY8MGoPGpY3Zj5siXjLu+GEoSFx5
 TESLMhJ0WolLDnbX+tclQZzn8ktuN8JLSlvhh0SK8QUjxhwjScRv+Uy16iTCmgqs+Efo
 XQngbgnObVbGtaWOV/oghFHJy1Bkkf6eDipbPO3kAYoFVsmCg0UUEDUeOXQfWg2Bes4Y
 8ypw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7iGAEaEl7YyNPF9VvFkEkzplb7CwHfqJpRb7n8nzilM=;
 fh=Ux5vfJ0Icj96z5p/E+AeDXIYtNxgczTFn+LktbTtjJ0=;
 b=Q0I9FGA/+KjuFWRgoqqdvUvdJyrfu4gi64EacGl31+ofVhhLV33WFSJ2pNAR9NgMfX
 NSJRDDkOovi2ThKsl4rP2yMhPjqXzdccdEucBVp0t2MMCtOOkL9OcOu8cjCY+12L/MHl
 hG8iWUF/brhd+/TlgmPTxVjCFq21pzZKXEEzV6i/oHs069iI4jQn1WaAr+ul0vqRclLE
 AszFB1HPp4qMq1aS0q1Bj63WAX+Bg3h4CKmtjMoC6p88RgzitOz0FotXC9C2UZ7CMEjg
 t/beY5oDu4DuL+Dgu+ainA/uA5brazjBkpbZOS34295icut1280ObWRJbLRz6uFBK+Sa
 AmTQ==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791828825; x=1792433625; darn=dpdk.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7iGAEaEl7YyNPF9VvFkEkzplb7CwHfqJpRb7n8nzilM=;
 b=sKV5mN0oRmgimT5pJOf2BVEzqkIjs3uiVVfi5/1qyKP4SQ2FXqezCtMRvqrkowe446
 bW7DyeMOVXmF3qH4TSO7QK583Av92fFjllFKOY17zOf8hk/8XfuGBZiwQaNOyWV1WZQt
 HJdZ3yXMh7qY4MSECY6wCxU/6xj7WOVhZqlH9ASNpxz2JM+C11yIAj4gHwzaPtR8M7Ua
 /27V2AwCI573arg9LGjbPjwz//DDDRbCpn4KIk/11Oazl/cDY2KZybhbNHt0KHYmrBL6
 DuaLvLyFiwOnFr+rrlri6rqcgv4QIHLH/XNT49FMkKE/Ii+Pvid+SIEN2kVjlBpNua09
 1kAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791828825; x=1792433625;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7iGAEaEl7YyNPF9VvFkEkzplb7CwHfqJpRb7n8nzilM=;
 b=Spr8l/X1PMQTGxgNZIkb9yqPiEv/ylE9VtdSbzVPTPQzKxFjA18DiqNRr55lWuKJ59
 1//G+tkQDxNI+y3O7AyRBlhHiYXvbY54PKhXKkeHYW7sazMMo3Za0cDo1HlpxxSUJG9m
 xlW3hDS2SCFajdg7AsFwe785Cur66pnP9HI3U7U9WFmmBglbn8siIesflGk53goZpysd
 NXGd/YIgzhJdpVWIX9oLC9IvKv0M0J1bTgoUqVYMlBMdwkqXPC3cEoimjUTc+xN8fwpi
 JodoFLGm2u3U8d2HhKgapMsJ2kO94hHh8Wn1ICs5rXWmUiZNcvztJ+Aul3xXPhpDhHL/
 gVZw==
X-Gm-Message-State: AFq9FYJZ+wDDIem1RLv3UTa3WWuShUfFWpbFPW+B5ZF4nlqKi364nm3B
 L4OdQkcJay6yOu0RQOYmOYqEBek1dwJQeJ0+h3Qi8bhkMQSL/ug5Czkb0B+BgM1i3BJ+tiUZ8tw
 /SXN3wyIR1e7tyj7TP/RaP71ziIcHcGhXeq987kNqKxAAdPDOV4t3dXK9
X-Gm-Gg: AYBFou29t/wlLSLw8OV7CYdkDYFwnib/Gv5K9iz0eJe1KYtNzZkBZiF2jDlXCZT46cr
 gsmv5lP/TxJ+fy2sZHbaTTnvS1On8JiafSElROL6vceoj8kctm5idzW8ysNgO13ZCJYnHrudVSQ
 46SpJmC4JdMtZKZOUmJGZt0aR7sD3kv5GSEP0NxGg5E4CQLGlMzyYHJdYjkcfgzhiJE9KWhZi1b
 OYW5NVyPr8PmbyC4vKPzxJ3FrZq7Y1YvAUQ2ETbK1t+j//8Tpm3N1EFVnMwK03Io/8yf1262uLA
 RGRYRAF484gSBq2MfuWYJ0de1mOYZZ7ZMAOdmGmkuQXSvadPUrGvqMFj
X-Received: by 2002:a17:907:94c2:b0:c2e:9034:138f with SMTP id
 a640c23a62f3a-c31aa0d3522mr1102426166b.47.1791828824845; Mon, 12 Oct 2026
 11:13:44 -0700 (PDT)
MIME-Version: 1.0
References: <20261012105023.669486-1-tathagat.dpdk@gmail.com>
 <20261012105023.669486-3-tathagat.dpdk@gmail.com>
In-Reply-To: <20261012105023.669486-3-tathagat.dpdk@gmail.com>
From: Joshua Washington <joshwash@google.com>
Date: Mon, 12 Oct 2026 11:13:32 -0700
X-Gm-Features: AclHuK-VGIGbxdpkIKNDESrD40Z6VbsrKKHU3TgAFj1ZzL6OK9uCaOYZksR8f-M
Message-ID: <CALuQH+VG4zC4Zh9v7_0ZPoMv5nCWkR_NCDL6qD9mCO22AmKBeQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] net/gve: fix DQO TX queue stall on multi-seg and TSO
To: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
Cc: dev@dpdk.org, stable@dpdk.org
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

On Mon, Oct 12, 2026 at 3:50=E2=80=AFAM Tathagat Priyadarshi
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
>
> Fixes: 4022f9999f56 ("net/gve: support basic Tx data path for DQO")
> Fixes: 403c671a46b6 ("net/gve: support TSO in DQO RDA")
> Cc: stable@dpdk.org
>
> Acked-by: Joshua Washington <joshwash@google.com>
> Signed-off-by: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
> ---
>  drivers/net/gve/gve_ethdev.h |  2 +-
>  drivers/net/gve/gve_tx_dqo.c | 18 ++++++++++--------
>  2 files changed, 11 insertions(+), 9 deletions(-)
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
> index c864d722d9..a8382ff3c4 100644
> --- a/drivers/net/gve/gve_tx_dqo.c
> +++ b/drivers/net/gve/gve_tx_dqo.c
> @@ -264,6 +264,8 @@ gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf **tx=
_pkts, uint16_t nb_pkts)
>         uint16_t nb_descs;
>         bool csum, tso;
>         uint16_t tx_id;
> +       uint32_t last_desc_idx;
> +       uint32_t last_re_interval;

Minor nit: in this driver, the common practice is to follow reverse
Christmas tree declaration ordering where practical.

>
>         pkts =3D txq->pkt_ring_dqo;
>         txr =3D txq->tx_ring;
> @@ -331,20 +333,19 @@ gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf **=
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

Should we write the tail here? Allowing the device to start processing
packets right away instead of only at the end of TX might save some
failed bursts if dealing with a bursts of many-descriptor TSO packets.
The MMIO writes would also be amortized over RE_INTERVAL descriptors.

> +               }
> +
>                 txq->nb_free -=3D nb_descs;
>                 txq->nb_used +=3D nb_descs;
>         }
>
>         /* update the tail pointer if any packets were processed */
>         if (nb_tx > 0) {
> -               /* Request a descriptor completion on the last descriptor=
 */
> -               txq->re_cnt +=3D nb_tx;
> -               if (txq->re_cnt >=3D GVE_TX_MIN_RE_INTERVAL) {
> -                       txd =3D &txr[(tx_id - 1) & mask];
> -                       txd->pkt.report_event =3D true;
> -                       txq->re_cnt =3D 0;
> -               }
> -
>                 rte_write32(tx_id, txq->qtx_tail);
>                 txq->tx_tail =3D tx_id;
>
> @@ -445,6 +446,7 @@ gve_reset_tx_ring_state_dqo(struct gve_tx_queue *txq)
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
