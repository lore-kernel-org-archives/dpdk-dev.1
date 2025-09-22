Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7299DCAC592
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Sep 2025 05:52:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BEC8C4060F;
	Mon, 22 Sep 2025 07:52:48 +0200 (CEST)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com
 [209.85.160.173])
 by mails.dpdk.org (Postfix) with ESMTP id 3CA68402C4
 for <dev@dpdk.org>; Mon, 22 Sep 2025 07:52:47 +0200 (CEST)
Received: by mail-qt1-f173.google.com with SMTP id
 d75a77b69052e-4b7a8c428c3so31929121cf.0
 for <dev@dpdk.org>; Sun, 21 Sep 2025 22:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758520366; x=1759125166; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GnHQNSsoywmYqpEzhdIa68nBESn5oHadoA09HPcJs70=;
 b=fm5H5KxRkm0fuSCFnvniwdgSx0mDV773ENiWEDsmxgFgYpzX4ZK5yq/dx72QuoRCGj
 u/pLR0cAklFGS0j39JiC76ij0Kj0CddODFOn3TeoHAT5H1HvC9SDstzPHd1L4r0q0YJU
 g27YX4SHW1NPVzEfugrpFdkbbP93ZJ5nEe+t5/JUKUPSXIMS2mw+zpfRuylgRHXGLNwu
 xUiJCE4y1Ynbpn+KSKFLXs5FL9OodA/ByLzXGkm/3RcOS/PhDO3xkCA93OVwGe9ram3l
 8nxteGvTn/u4xQ6UbluvzIDDSGgNCzDv2ExgWr1kvW8Y3Z2KAZkkxbOX7kcWWzJLEOjV
 6WOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758520366; x=1759125166;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GnHQNSsoywmYqpEzhdIa68nBESn5oHadoA09HPcJs70=;
 b=bzjVVXUrKABe5flXY4eZ/UUSbw8MKiE2xbb1LOImbo2zkf+bNcCOzTWaEJqTdm+CcH
 78Oq8R8JfuXQBshR5byGqptfYBOE7wiMA5KnAUn/41r/gpull8Me0L+cjNnEMFp8ihx1
 GqJSvSNGINqrYSh2gHxFbbjwkcYLnQsLMKVe21jtdrHJQuZFuLFBnBOp8qbVd97A4UdD
 xvrCUIZjGO9dNxkVNpg6NBi61pG8zDlCEPXx373BVqtcmchPT8W3gxEZEcczERp776HH
 MpX120s7lvO9Sb/ZWB2aadUyvJ3I56iem3DPROGajU++10R5VTDpbe6v4P6peKPnv9CA
 l7bQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTSVh4fq5mwgFhGPDzS8/dCE0f64uZCUGlMmIGriAOsrmHSZ+QThrSC9WmYunyiqoQxlo=@dpdk.org
X-Gm-Message-State: AOJu0YzsrYFlVNdLx5lMy7nEaHW7LBNzofE6pvBlmyqMbNF+CGG+eDTx
 JDOJE91bu15b2HW6ZruIQqeUx50kexeaaRE8K634ls4dfI+mry1JMoYARzyK80Q/b+HEwj+w10P
 RIA2FZP7NGkTSHng4CE2DCD3m3Gi0iOblo358
X-Gm-Gg: ASbGncsv9VJOGmmgW5TdfSl5WkKwfHh91ALrOFU+V5bDULKCr8dX/sRBgDOdWNKhJOD
 nVb0dvxMI/Vp3s09uiFlzw7bqfReuy0Pr5HlFNN18m53Xj0+My0uciLmY4AHXE8WcF2KCx0b53C
 7cXavBllfkjaqHEW3RyVUOQp8UtueGeRi4ah5Z3e+E7Uv3XHUWtPusm0o6T3pRinqZW3ruQLXzF
 93rLQLMVshbl2uhBkU6DL+FQaM4b4qIND95YsywdCaffQpiX9dQdJXvBLm8j2M=
X-Google-Smtp-Source: AGHT+IHV1f5buYfqK9w86i4m+e12wSE58sYakWldwPhVEuEKsL+bCW67M3z7ywFYDN9GoRqIx8cSif7pg8WhUbXA9xE=
X-Received: by 2002:a05:622a:5e1b:b0:4b7:9f68:52de with SMTP id
 d75a77b69052e-4c23430a2aamr97444151cf.22.1758520366364; Sun, 21 Sep 2025
 22:52:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250714054041.2257589-1-vattunuru@marvell.com>
In-Reply-To: <20250714054041.2257589-1-vattunuru@marvell.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Mon, 22 Sep 2025 11:22:20 +0530
X-Gm-Features: AS18NWDzF--c0plBpKzV95j6bkS-qWLH41pokrra_GIDEbwDni8Cm3hJhTtTeCs
Message-ID: <CALBAE1O3RSq2vHh-1C9i72Cp=vUBge8SNFSkx761xGrvbiL=bw@mail.gmail.com>
Subject: Re: [PATCH v0 1/1] net/octeon_ep: fix mbuf data offset update
To: Vamsi Krishna <vattunuru@marvell.com>
Cc: jerinj@marvell.com, dev@dpdk.org, stable@dpdk.org
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

On Mon, Jul 14, 2025 at 11:23=E2=80=AFAM Vamsi Krishna <vattunuru@marvell.c=
om> wrote:
>
> From: Vamsi Attunuru <vattunuru@marvell.com>
>
> Buffer refill routine uses mempool API instead of pktmbuf
> alloc to avoid mbuf reset. Patch uses rearm to update the
> mbuf fields. Also it removes redundant refill count update.
>
> Fixes: 35dee56cee00 ("net/octeon_ep: add new fastpath routines")
> Cc: stable@dpdk.org
>
> Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>

Applied to dpdk-next-net-mrvl/for-main. Thanks


> ---
>  drivers/net/octeon_ep/cnxk_ep_rx.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/octeon_ep/cnxk_ep_rx.c b/drivers/net/octeon_ep/c=
nxk_ep_rx.c
> index 7465e0a017..a10e9c536e 100644
> --- a/drivers/net/octeon_ep/cnxk_ep_rx.c
> +++ b/drivers/net/octeon_ep/cnxk_ep_rx.c
> @@ -10,7 +10,6 @@ cnxk_ep_process_pkts_scalar_mseg(struct rte_mbuf **rx_p=
kts, struct otx_ep_droq *
>  {
>         struct rte_mbuf **recv_buf_list =3D droq->recv_buf_list;
>         uint32_t total_pkt_len, bytes_rsvd =3D 0;
> -       uint16_t port_id =3D droq->otx_ep_dev->port_id;
>         uint16_t nb_desc =3D droq->nb_desc;
>         uint16_t pkts;
>
> @@ -22,7 +21,7 @@ cnxk_ep_process_pkts_scalar_mseg(struct rte_mbuf **rx_p=
kts, struct otx_ep_droq *
>                 uint32_t pkt_len =3D 0;
>
>                 mbuf =3D recv_buf_list[droq->read_idx];
> -               info =3D rte_pktmbuf_mtod(mbuf, struct otx_ep_droq_info *=
);
> +               info =3D cnxk_pktmbuf_mtod(mbuf, struct otx_ep_droq_info =
*);
>
>                 total_pkt_len =3D rte_bswap16(info->length >> 48) + OTX_E=
P_INFO_SIZE;
>
> @@ -37,7 +36,7 @@ cnxk_ep_process_pkts_scalar_mseg(struct rte_mbuf **rx_p=
kts, struct otx_ep_droq *
>                         if (!pkt_len) {
>                                 /* Note the first seg */
>                                 first_buf =3D mbuf;
> -                               mbuf->data_off +=3D OTX_EP_INFO_SIZE;
> +                               *(uint64_t *)&mbuf->rearm_data =3D droq->=
rearm_data;
>                                 mbuf->pkt_len =3D cpy_len - OTX_EP_INFO_S=
IZE;
>                                 mbuf->data_len =3D cpy_len - OTX_EP_INFO_=
SIZE;
>                         } else {
> @@ -57,12 +56,10 @@ cnxk_ep_process_pkts_scalar_mseg(struct rte_mbuf **rx=
_pkts, struct otx_ep_droq *
>                         droq->refill_count++;
>                 }
>                 mbuf =3D first_buf;
> -               mbuf->port =3D port_id;
>                 rx_pkts[pkts] =3D mbuf;
>                 bytes_rsvd +=3D pkt_len;
>         }
>
> -       droq->refill_count +=3D new_pkts;
>         droq->pkts_pending -=3D pkts;
>         /* Stats */
>         droq->stats.pkts_received +=3D pkts;
> --
> 2.34.1
>
