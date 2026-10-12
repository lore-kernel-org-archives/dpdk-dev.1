Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 182B1CA9ED0
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Oct 2026 19:40:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 708DD4028D;
	Mon, 12 Oct 2026 21:40:56 +0200 (CEST)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com
 [209.85.218.42]) by mails.dpdk.org (Postfix) with ESMTP id 969A640272
 for <dev@dpdk.org>; Mon, 12 Oct 2026 21:40:54 +0200 (CEST)
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-c2dc63f8d8aso372465466b.0
 for <dev@dpdk.org>; Mon, 12 Oct 2026 12:40:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791834054; cv=none;
 d=google.com; s=arc-20260327;
 b=rjrtqIvnRyCQzdog3mVYZJ+iQhCyrBZJtQy0pJWjeo/kIGm9xRdS077uGnq5anjhc5
 Pfbicey+Fa4gD7opyXqaJPvZfCVDq+qrsvv5PrGv5GuPOhVgZzhZNEb8MtXfSEA/XZKr
 5B+TSPFncL+BTEYx1n/OexF2aTfZ4KvIo4tavPo0tEtuXwThmOhwD6f+sROS1tgmJvoX
 O3Mm7HHQxKQ+zVFxgSaE6BcSFd2FtCCJcDlK1AL61dK8K2aRwpur6oODBMcKwkAFMwzh
 n40OE+njOy8UxOy3vh+5maViJMKKLRYVmsxT6AgJTQSh5jxtakxKFj/idDEaJQrFfJTL
 gMYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=CZjjJwkXM446qNN3Wrds8Q7rZIWcgd3NPxRPID+owoo=;
 fh=Ux5vfJ0Icj96z5p/E+AeDXIYtNxgczTFn+LktbTtjJ0=;
 b=PJ+zho1blI6wK3MTaXkn/7IsQn6ez5ZmLKVEwLqgNuQq4DpVb+0SiKENo0K07ZiQpw
 oyjdPOfLIFvPeDj1oRWha/w/t+wqct6Ft0zquJsFKvsKWySJHNmINTN/0XtqOe+4pOEa
 e5KKI2rFmTq1sGzJ3ro8sRX4ol95h4INeGSFdegMMmeV9YOF3WOrKaJR7GyexmVSJEWt
 OtfliUkKL4jZ5fs263sbzf1gtvzqPz6fQauV5A5tE5Wx2iRumLVvb0pRSG6HJJ8tEeWe
 rPz9iOhX1vLJH6QAy89nr4bG66ayn8ZHGACfYa6YSpuZC/jWZ2adl++3gJChNoiYmys4
 Dw3w==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791834054; x=1792438854; darn=dpdk.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CZjjJwkXM446qNN3Wrds8Q7rZIWcgd3NPxRPID+owoo=;
 b=nGjoQK+Q9xPUGismowJeNKRXuyMxwY/87pYZ6saS4KhnXTdNaFSv0giEKFTdrdhnbs
 FkfyLwC5rvEYtEpVuyxFj63skAZoIK1AVD77/aUT86T13/jvb5DysmPeeLQJ6CzXdcEO
 BHNYsD6X660AvczBwc7dT/ExoBZ3WPMraHQFVFdxE78ixJI6smkJyCGx4diVCxa9G/ul
 Grd3BzcsPH9ugCwMXr3mCTDMi7eNFYrp62YtNtJnRk9RMHNvqDimoiTrMIZR2EQth/NZ
 mSiyy84pp0kM+7Ebfwe38E4Fbg3000clJCqbApGVyNZFYtRncx+fSPs7lLRLWEHssqut
 IobQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791834054; x=1792438854;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CZjjJwkXM446qNN3Wrds8Q7rZIWcgd3NPxRPID+owoo=;
 b=fE9DBufSb9LY1aW8v9eLq/6YpAeDoapzvA42vzOjfkgQOWmk/JGNdA+bgzEQRFef1L
 vqi/fg+afE7tngiy0yVXS1ju1Rn+ShbpeM5O0k5eJGdXNPbwmwgaW6LKMe8WjK6DDBJs
 jbTruySf86lgN94ppsS9uURd56A1w2uU29nuJtRco5R9tDE2NEYi46fzQ7gck6hKfssR
 IUw8bbXwhZkkYWwIaQeDzmxfoacSrQs8rW5An4Df7TXnhGeZXsXaGzzk12HlQA5xMOWW
 t444basU1VzoXN3iZu9mis8qn1WpDCtMD6U8Q599vUVcAtZwr1wntmzCCap3T0y+AxIa
 kRYA==
X-Gm-Message-State: AFq9FYKw0Ac5/QqlVwUuGaHbPC+eaG2aQigy+d3uXjzqmdNDxqpRYpTa
 DoDXyQN6JUEBT9YEQ+9kOz6L57qNazbFc8eVacPJy11gsmlTywcImBb0dWnmzT9IknUvg4vCzqK
 L8Fq2rF97XyrMSSvixrMpAGSvlaPeM5La6pCGYR3u
X-Gm-Gg: AYBFou0nRKa85PcLLMyESiICrIrCrbL9+ae4TcR4rEtLfyF8xeAgtXcbvQk6QFuYe7S
 QAKxvMdnNpxTJA3fWbbAqQ5olCbJnjO5699QpC6KxgT6k3myy3SH9jfmeEg4dyHWTpWIBOwz/A1
 qTtqp4h9lPlSrHLcO1jEG/P63GyxAE2B5DaiFQkd1MCaFgTXO5dtSm7JY8VTfbgBR7P4aDrS06c
 uJiSY3bI7wVrG9lH/wqvX1GwELjUDuDvtTWAdca2KsbylJEjKS+uPTzjlpIYw3kafvcNH7Cx/2Y
 0re3BZe9ElwWp6HZinhXgLC5Y5mTChPE+6dYqJNYHEkf9REq3jwG3yeP
X-Received: by 2002:a17:906:f586:b0:c2e:4742:4c91 with SMTP id
 a640c23a62f3a-c31aa08e8a5mr903018766b.35.1791834053340; Mon, 12 Oct 2026
 12:40:53 -0700 (PDT)
MIME-Version: 1.0
References: <20261012105023.669486-1-tathagat.dpdk@gmail.com>
 <20261012105023.669486-5-tathagat.dpdk@gmail.com>
In-Reply-To: <20261012105023.669486-5-tathagat.dpdk@gmail.com>
From: Joshua Washington <joshwash@google.com>
Date: Mon, 12 Oct 2026 12:40:41 -0700
X-Gm-Features: AclHuK8cXEWJt3LnF5MlLVpIIpF4q3mFp6JdTJcICfngKFf4tIhv-a0L8jALHkE
Message-ID: <CALuQH+XBx1yMAhAB-4r-QbhteX42JDDRH8aYwbEgWowu4Y749Q@mail.gmail.com>
Subject: Re: [PATCH 4/4] net/gve: add packet and TSO hardware constraints for
 DQO
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
> The GVNIC DQO hardware restricts each packet (or MTU segment in TSO)
> to at most 10 data descriptors (GVE_TX_MAX_DATA_DESCS), beyond which
> the hardware drops traffic. In addition to this 10-descriptor limit,
> the hardware imposes strict packet sizing and header constraints.
>
> Enforce these hardware packet and TSO validation constraints in DQO
> RDA mode within gve_tx_validate_descs() matching the upstream Linux
> kernel driver:
> - Define GVE_TX_MAX_TSO_MSS_DQO (9728 bytes) to avoid 14-bit MSS
>   field overflow in struct gve_tx_tso_context_desc_dqo.
> - Define GVE_TX_MIN_PKT_SIZE_DQO (17 bytes) and GVE_TX_MAX_PKT_SIZE_DQO
>   (9728 bytes) to reject runts (which cause hardware DMA parse errors)
>   and oversized non-TSO packets.
> - In gve_tx_validate_descs():
>   * Reject zero-length mbufs (nb_descs =3D=3D 0 or pkt_len =3D=3D 0).
>   * Enforce packet size in [17, 9728] for non-TSO packets alongside
>     the 10-descriptor limit (nb_descs <=3D GVE_TX_MAX_DATA_DESCS).
>   * Reject split transport headers across mbuf segments
>     (data_len < headlen).
>   * Reject TSO packets missing an L4 header (l4_len =3D=3D 0).
>   * Reject TSO packets without payload (pkt_len <=3D headlen).
>   * Enforce MSS limits [88, 9728] and header length limit <=3D 255.
>
> Fixes: 403c671a46b6 ("net/gve: support TSO in DQO RDA")
> Cc: stable@dpdk.org
>
> Acked-by: Joshua Washington <joshwash@google.com>
> Signed-off-by: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
> ---
>  drivers/net/gve/base/gve_desc_dqo.h |  3 ++
>  drivers/net/gve/gve_tx_dqo.c        | 44 ++++++++++++++++++++++++-----
>  2 files changed, 40 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/net/gve/base/gve_desc_dqo.h b/drivers/net/gve/base/g=
ve_desc_dqo.h
> index c1534959c2..1740f69d73 100644
> --- a/drivers/net/gve/base/gve_desc_dqo.h
> +++ b/drivers/net/gve/base/gve_desc_dqo.h
> @@ -12,6 +12,9 @@
>
>  #define GVE_TX_MAX_HDR_SIZE_DQO 255
>  #define GVE_TX_MIN_TSO_MSS_DQO 88
> +#define GVE_TX_MAX_TSO_MSS_DQO 9728
> +#define GVE_TX_MIN_PKT_SIZE_DQO 17
> +#define GVE_TX_MAX_PKT_SIZE_DQO 9728

GVE_TX_MAX_TSO_MSS_DQO and GVE_TX_MAX_PKT_SIZE_DQO have the same
semantic meaning: they represent the maximum wire packet allowed on
the NIC. Let's opt to use a single value here.

>
>  /* Basic TX descriptor (DTYPE 0x0C) */
>  struct gve_tx_pkt_desc_dqo {
> diff --git a/drivers/net/gve/gve_tx_dqo.c b/drivers/net/gve/gve_tx_dqo.c
> index 9210b02eb1..03ac3bd5dd 100644
> --- a/drivers/net/gve/gve_tx_dqo.c
> +++ b/drivers/net/gve/gve_tx_dqo.c
> @@ -134,12 +134,43 @@ gve_tx_clean_descs_dqo(struct gve_tx_queue *txq, ui=
nt16_t nb_descs) {
>  static inline bool
>  gve_tx_validate_descs(struct rte_mbuf *tx_pkt, uint16_t nb_descs, bool i=
s_tso)
>  {
> -       if (!is_tso)
> +       int tso_segsz, seg_remain, mbuf_remain;
> +       int num_descs, seg_offset, mbuf_len;
> +       int headlen;
> +
> +       /* Reject zero-length packet */
> +       if (unlikely(nb_descs =3D=3D 0 || tx_pkt->pkt_len =3D=3D 0))
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
> +       /* Reject split transport header */
> +       if (unlikely(tx_pkt->data_len < headlen))
> +               return false;
> +
> +       /* Reject missing TCP header on TSO */
> +       if (unlikely(tx_pkt->l4_len =3D=3D 0))
> +               return false;
> +
> +       /* Reject TSO packet without payload */
> +       if (unlikely(tx_pkt->pkt_len <=3D (uint32_t)headlen))
> +               return false;
> +
> +       /* Enforce GVE hardware MSS and header limits */
> +       if (unlikely(tx_pkt->tso_segsz < GVE_TX_MIN_TSO_MSS_DQO ||
> +                    tx_pkt->tso_segsz > GVE_TX_MAX_TSO_MSS_DQO ||
> +                    headlen > GVE_TX_MAX_HDR_SIZE_DQO))
> +               return false;
> +
> +       tso_segsz =3D tx_pkt->tso_segsz;
>
>         /* Headers will be split into their own buffer. */
>         num_descs =3D 1;
> @@ -150,7 +181,7 @@ gve_tx_validate_descs(struct rte_mbuf *tx_pkt, uint16=
_t nb_descs, bool is_tso)
>                 if (!mbuf_len)
>                         goto next_mbuf;
>
> -               int seg_remain =3D tso_segsz - seg_offset;
> +               seg_remain =3D tso_segsz - seg_offset;

Thanks for fixing the forward declarations but generally, declarations
should happen in the smallest scope possible. Since seg_remain and
mbuf_remain aren't used outside of this loop and branch, respectively,
they should be declared at those scopes. It might also be appropriate
to just declare both at the start of the loop.

>                 if (num_descs =3D=3D GVE_TX_MAX_DATA_DESCS && seg_remain)
>                         return false;
>
> @@ -162,7 +193,7 @@ gve_tx_validate_descs(struct rte_mbuf *tx_pkt, uint16=
_t nb_descs, bool is_tso)
>                          * is not at risk of defying this limitation.
>                          * Thus, such segments are ignored.
>                          */
> -                       int mbuf_remain =3D tx_pkt->data_len % GVE_TX_MAX=
_BUF_SIZE_DQO;
> +                       mbuf_remain =3D tx_pkt->data_len % GVE_TX_MAX_BUF=
_SIZE_DQO;
>
>                         /* For each TSO segment, HW will prepend
>                          * headers. The remaining bytes of this mbuf
> @@ -184,7 +215,6 @@ gve_tx_validate_descs(struct rte_mbuf *tx_pkt, uint16=
_t nb_descs, bool is_tso)
>                         mbuf_len =3D tx_pkt->data_len;
>         }
>
> -
>         return true;
>  }
>
> --
> 2.43.0
>

Thanks for sending this!
