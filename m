Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01A8D10375
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Nov 2025 04:47:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3D89640DF5;
	Thu, 27 Nov 2025 05:47:51 +0100 (CET)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com
 [209.85.160.172])
 by mails.dpdk.org (Postfix) with ESMTP id 447DB4013F
 for <dev@dpdk.org>; Thu, 27 Nov 2025 05:47:50 +0100 (CET)
Received: by mail-qt1-f172.google.com with SMTP id
 d75a77b69052e-4ee4c64190cso4198051cf.0
 for <dev@dpdk.org>; Wed, 26 Nov 2025 20:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764218869; x=1764823669; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bP1TfivAkms6dv0iQSlGlg4CUq5xURZ0cF6tRTna6ow=;
 b=cV2Ah3fKxrRA4OA+Ub9YjzEq5B4C4NEyKxup5I+1MfNZn3JfLdAJtRPBAXo+BR/Pl0
 Z2tBvxhRw24LlTCzmzOCms68CS1ONnl9i8TqT2L6RID+gyeX8WYiJlrxttsqrzaUfpw8
 jFdJ0Ndge9C7K82ZMrM3B0GPox78THnMy+tJbl+a1WoYtDD43fOiI+nBKwCa+OXPzqjR
 nh3LzZWCLRXxTKYvJNjmsKrBWnz22Iz59tuiJjclFQgbh3CQ9Pa65as1ystJP9I2wwDv
 VjHOK1k1izl1Wy+SRiqVO1Db6lLCVIZ2dHXT3HuJc8YH7CXMUH01JKF2hFSKiXOcdAvP
 UUbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764218869; x=1764823669;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bP1TfivAkms6dv0iQSlGlg4CUq5xURZ0cF6tRTna6ow=;
 b=ovZUcUfYW3++OBw8edUUE8jCOJ+MloYyQCd8NgHgRDlpWK6MOAEmpaJKR/qOulO0nZ
 TKtFISFcdHR2w2aAn4mMxPu4wmBL2zO6MO8LUt7aDSTj9M6lmIVW4URFyUGqB9gnq2JR
 ++qVE1J7/3Bfxjcu6sgau/aeymwAuqvOfkMYjV57tUdaIZ80bAnYeztfUHmoY8oune8W
 HP4BCpvPpcB0VIg4qnVIxloOB/gfRc+idcUMCyZnpgqJhEffWgX/ZgDw29j2EyZ1hGJu
 NvlVI//kqbVBVPpS973st3Jihf/++YSZlMZKB7G2Go0JfJf0iRSUDoe2pjv6AEdL+fcx
 xRcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4pMuLOWj5sw13y+/fvt7MvjM1BnW+gIa76Eg8U0du1z/eCijyqm/ZUVKfe2Osp41MLzA=@dpdk.org
X-Gm-Message-State: AOJu0YxGtLE1Ndkvg9tgfhVDDTaPriCpZXXj3MmpfwGiy2A7KU4m2/bG
 zHSN3O1qKT+WawWu77MCJD3EUtE8d4ivbvHnVfN2ba8IT5VP1MzTPQtDm0T9i9gZWZJqgh9h2Be
 euUO57e1q697hBL3Cd8/OjHxnrXt99V0=
X-Gm-Gg: ASbGncuS94vMywMeOFya3/JKBVPfdbGBTKGx00kcHvQhUD2Uv8O5wSOYDZ75ijsK/PH
 spEnGHfV/JBlQtCFleirMJ6BJZ97lG7GtK5L1MQBsP5DTPRdfaytiTNunmkq5X8VTS3NJ6pmEZg
 Ti62YcRClXA6Q6pwnn0fCBW/MUfB4dnV1rI/HQIXec8aeMPLp/asWQB8lHMk78i4TdpM1gRx9Nm
 uwp2vExFzsF7vM6bkjT1T46uSbntHuVjkFKuiP7H24a28Kfl2D4gBimSSSgLcm+yzzhPMM1dLup
 hb1Y
X-Google-Smtp-Source: AGHT+IFT1IoDvwR0orb/pqGTw36zkiQH6xPM3DYaPnPBI//w9YWmdIF08oQl9c1jC+UAwxYk9KypmjBxiA/bFeul7Ts=
X-Received: by 2002:ac8:598c:0:b0:4ed:ddd9:1402 with SMTP id
 d75a77b69052e-4ee58a7fc80mr283284811cf.24.1764218869346; Wed, 26 Nov 2025
 20:47:49 -0800 (PST)
MIME-Version: 1.0
References: <20251126081353.85811-1-pbhagavatula@marvell.com>
 <20251126155358.16973-1-pbhagavatula@marvell.com>
In-Reply-To: <20251126155358.16973-1-pbhagavatula@marvell.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Thu, 27 Nov 2025 10:17:23 +0530
X-Gm-Features: AWmQ_bmkUjfejaNLZb7R24szFvmfrfblpKA54zdn20zYDHzYyqAPgslRe73MVQc
Message-ID: <CALBAE1NMMTEDykgdJ7vC4GdXcXm64ask-iHbAJZA5grGmfPYHg@mail.gmail.com>
Subject: Re: [PATCH v4] event/cnxk: fix offload flags
To: pbhagavatula@marvell.com
Cc: jerinj@marvell.com, Shijith Thotton <sthotton@marvell.com>, 
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>, 
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>, 
 Harman Kalra <hkalra@marvell.com>, dev@dpdk.org, stable@dpdk.org
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

On Wed, Nov 26, 2025 at 9:41=E2=80=AFPM <pbhagavatula@marvell.com> wrote:
>
> From: Pavan Nikhilesh <pbhagavatula@marvell.com>
>
> Use device configured Rx offloads instead of hardcoded values while
> draining work.
>
> Fixes: e8594de2731d ("event/cnxk: implement event port quiesce function")
> Cc: stable@dpdk.org
>
> Signed-off-by: Pavan Nikhilesh <pbhagavatula@marvell.com>

Acked-by: Jerin Jacob <jerinj@marvell.com>


> ---
>  drivers/event/cnxk/cn10k_eventdev.c | 9 +++------
>  drivers/event/cnxk/cn10k_worker.h   | 6 +++---
>  drivers/event/cnxk/cn20k_eventdev.c | 8 +++-----
>  drivers/event/cnxk/cn20k_worker.h   | 4 ++--
>  drivers/net/cnxk/cn10k_rx.h         | 6 +++---
>  drivers/net/cnxk/cn20k_rx.h         | 6 +++---
>  6 files changed, 17 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/event/cnxk/cn10k_eventdev.c b/drivers/event/cnxk/cn1=
0k_eventdev.c
> index 3832eb7e000f..0c1431b4e70c 100644
> --- a/drivers/event/cnxk/cn10k_eventdev.c
> +++ b/drivers/event/cnxk/cn10k_eventdev.c
> @@ -126,8 +126,7 @@ cn10k_sso_hws_flush_events(void *hws, uint8_t queue_i=
d, uintptr_t base,
>
>         while (aq_cnt || cq_ds_cnt || ds_cnt) {
>                 plt_write64(req, ws->base + SSOW_LF_GWS_OP_GET_WORK0);
> -               cn10k_sso_hws_get_work_empty(
> -                       ws, &ev, (NIX_RX_OFFLOAD_MAX - 1) | NIX_RX_REAS_F=
 | NIX_RX_MULTI_SEG_F);
> +               cn10k_sso_hws_get_work_empty(ws, &ev, dev->rx_offloads);
>                 if (fn !=3D NULL && ev.u64 !=3D 0)
>                         fn(arg, ev);
>                 if (ev.sched_type !=3D SSO_TT_EMPTY)
> @@ -473,8 +472,7 @@ cn10k_sso_port_quiesce(struct rte_eventdev *event_dev=
, void *port,
>         } while (ptag &
>                  (BIT_ULL(62) | BIT_ULL(58) | BIT_ULL(56) | BIT_ULL(54)))=
;
>
> -       cn10k_sso_hws_get_work_empty(ws, &ev,
> -                                    (NIX_RX_OFFLOAD_MAX - 1) | NIX_RX_RE=
AS_F | NIX_RX_MULTI_SEG_F);
> +       cn10k_sso_hws_get_work_empty(ws, &ev, dev->rx_offloads);
>         if (is_pend && ev.u64)
>                 if (flush_cb)
>                         flush_cb(event_dev->data->dev_id, ev, args);
> @@ -503,8 +501,7 @@ cn10k_sso_port_quiesce(struct rte_eventdev *event_dev=
, void *port,
>             SSO_TT_EMPTY) {
>                 plt_write64(BIT_ULL(16) | 1,
>                             ws->base + SSOW_LF_GWS_OP_GET_WORK0);
> -               cn10k_sso_hws_get_work_empty(
> -                       ws, &ev, (NIX_RX_OFFLOAD_MAX - 1) | NIX_RX_REAS_F=
 | NIX_RX_MULTI_SEG_F);
> +               cn10k_sso_hws_get_work_empty(ws, &ev, dev->rx_offloads);
>                 if (ev.u64) {
>                         if (flush_cb)
>                                 flush_cb(event_dev->data->dev_id, ev, arg=
s);
> diff --git a/drivers/event/cnxk/cn10k_worker.h b/drivers/event/cnxk/cn10k=
_worker.h
> index 954dee5a2a9e..9b6abdf18db2 100644
> --- a/drivers/event/cnxk/cn10k_worker.h
> +++ b/drivers/event/cnxk/cn10k_worker.h
> @@ -52,12 +52,12 @@ cn10k_process_vwqe(uintptr_t vwqe, uint16_t port_id, =
const uint32_t flags, struc
>         uint64_t mbuf_init =3D 0x100010000ULL | RTE_PKTMBUF_HEADROOM;
>         struct cnxk_timesync_info *tstamp =3D ws->tstamp[port_id];
>         void *lookup_mem =3D ws->lookup_mem;
> +       uint64_t meta_aura =3D 0, laddr =3D 0;
> +       uint16_t lmt_id =3D 0, d_off =3D 0;
>         uintptr_t lbase =3D ws->lmt_base;
> -       uint64_t meta_aura =3D 0, laddr;
> +       struct rte_mempool *mp =3D NULL;
>         struct rte_event_vector *vec;
>         uint16_t nb_mbufs, non_vec;
> -       struct rte_mempool *mp;
> -       uint16_t lmt_id, d_off;
>         struct rte_mbuf **wqe;
>         struct rte_mbuf *mbuf;
>         uint64_t sa_base =3D 0;
> diff --git a/drivers/event/cnxk/cn20k_eventdev.c b/drivers/event/cnxk/cn2=
0k_eventdev.c
> index b25e570211f1..1c5d9272398a 100644
> --- a/drivers/event/cnxk/cn20k_eventdev.c
> +++ b/drivers/event/cnxk/cn20k_eventdev.c
> @@ -192,7 +192,7 @@ cn20k_sso_hws_flush_events(void *hws, uint8_t queue_i=
d, uintptr_t base, cnxk_han
>
>         while (aq_cnt || cq_ds_cnt || ds_cnt) {
>                 plt_write64(req, ws->base + SSOW_LF_GWS_OP_GET_WORK0);
> -               cn20k_sso_hws_get_work_empty(ws, &ev, 0);
> +               cn20k_sso_hws_get_work_empty(ws, &ev, dev->rx_offloads);
>                 if (fn !=3D NULL && ev.u64 !=3D 0)
>                         fn(arg, ev);
>                 if (ev.sched_type !=3D SSO_TT_EMPTY)
> @@ -521,8 +521,7 @@ cn20k_sso_port_quiesce(struct rte_eventdev *event_dev=
, void *port,
>                 ptag =3D plt_read64(ws->base + SSOW_LF_GWS_PENDSTATE);
>         } while (ptag & (BIT_ULL(62) | BIT_ULL(58) | BIT_ULL(56) | BIT_UL=
L(54)));
>
> -       cn20k_sso_hws_get_work_empty(ws, &ev,
> -                                    (NIX_RX_OFFLOAD_MAX - 1) | NIX_RX_RE=
AS_F | NIX_RX_MULTI_SEG_F);
> +       cn20k_sso_hws_get_work_empty(ws, &ev, dev->rx_offloads);
>         if (is_pend && ev.u64)
>                 if (flush_cb)
>                         flush_cb(event_dev->data->dev_id, ev, args);
> @@ -548,8 +547,7 @@ cn20k_sso_port_quiesce(struct rte_eventdev *event_dev=
, void *port,
>
>         if (CNXK_TT_FROM_TAG(plt_read64(ws->base + SSOW_LF_GWS_PRF_WQE0))=
 !=3D SSO_TT_EMPTY) {
>                 plt_write64(BIT_ULL(16) | 1, ws->base + SSOW_LF_GWS_OP_GE=
T_WORK0);
> -               cn20k_sso_hws_get_work_empty(
> -                       ws, &ev, (NIX_RX_OFFLOAD_MAX - 1) | NIX_RX_REAS_F=
 | NIX_RX_MULTI_SEG_F);
> +               cn20k_sso_hws_get_work_empty(ws, &ev, dev->rx_offloads);
>                 if (ev.u64) {
>                         if (flush_cb)
>                                 flush_cb(event_dev->data->dev_id, ev, arg=
s);
> diff --git a/drivers/event/cnxk/cn20k_worker.h b/drivers/event/cnxk/cn20k=
_worker.h
> index df0abd9202fd..608f93dcd465 100644
> --- a/drivers/event/cnxk/cn20k_worker.h
> +++ b/drivers/event/cnxk/cn20k_worker.h
> @@ -54,12 +54,12 @@ cn20k_process_vwqe(uintptr_t vwqe, uint16_t port_id, =
const uint32_t flags, struc
>         struct cnxk_timesync_info *tstamp =3D ws->tstamp[port_id];
>         uint8_t m_sz =3D sizeof(struct rte_mbuf);
>         void *lookup_mem =3D ws->lookup_mem;
> +       uint64_t meta_aura =3D 0, laddr =3D 0;
>         uintptr_t lbase =3D ws->lmt_base;
> -       uint64_t meta_aura =3D 0, laddr;
> +       uint16_t lmt_id =3D 0, d_off =3D 0;
>         struct rte_event_vector *vec;
>         uint16_t nb_mbufs, non_vec;
>         struct rte_mempool *mp;
> -       uint16_t lmt_id, d_off;
>         struct rte_mbuf **wqe;
>         struct rte_mbuf *mbuf;
>         uint64_t sa_base =3D 0;
> diff --git a/drivers/net/cnxk/cn10k_rx.h b/drivers/net/cnxk/cn10k_rx.h
> index e79306e6467f..e55910b57599 100644
> --- a/drivers/net/cnxk/cn10k_rx.h
> +++ b/drivers/net/cnxk/cn10k_rx.h
> @@ -572,7 +572,7 @@ nix_sec_meta_to_mbuf(uint64_t cq_w1, uint64_t cq_w5, =
uintptr_t inb_sa,
>         const struct cpt_cn10k_parse_hdr_s *hdr =3D
>                 (const struct cpt_cn10k_parse_hdr_s *)cpth;
>         uint64_t mbuf_init =3D vgetq_lane_u64(*rearm, 0);
> -       struct cn10k_inb_priv_data *inb_priv;
> +       struct cn10k_inb_priv_data *inb_priv =3D NULL;
>         uintptr_t p;
>
>         /* Clear checksum flags */
> @@ -1464,9 +1464,9 @@ cn10k_nix_recv_pkts_vector(void *args, struct rte_m=
buf **mbufs, uint16_t pkts,
>         struct rte_mbuf *mbuf0, *mbuf1, *mbuf2, *mbuf3;
>         uint8_t loff =3D 0, lnum =3D 0, shft =3D 0;
>         struct rte_mempool *meta_pool =3D NULL;
> +       uint16_t lmt_id =3D 0, d_off =3D 0;
> +       uint64_t lbase =3D 0, laddr =3D 0;
>         uint8x16_t f0, f1, f2, f3;
> -       uint16_t lmt_id, d_off;
> -       uint64_t lbase, laddr;
>         uintptr_t sa_base =3D 0;
>         uint16_t packets =3D 0;
>         uint16_t pkts_left;
> diff --git a/drivers/net/cnxk/cn20k_rx.h b/drivers/net/cnxk/cn20k_rx.h
> index 56826318151a..1944e507b0b2 100644
> --- a/drivers/net/cnxk/cn20k_rx.h
> +++ b/drivers/net/cnxk/cn20k_rx.h
> @@ -307,7 +307,7 @@ nix_cqe_xtract_mseg(const union nix_rx_parse_u *rx, s=
truct rte_mbuf *mbuf, uint6
>         const struct cpt_parse_hdr_s *hdr =3D (const struct cpt_parse_hdr=
_s *)cpth;
>         struct cn20k_inb_priv_data *inb_priv =3D NULL;
>         const struct cpt_frag_info_s *finfo =3D NULL;
> -       uint64_t fsz_w1 =3D 0, cq_w1, cq_w5, sg;
> +       uint64_t fsz_w1 =3D 0, cq_w1, cq_w5 =3D 0, sg;
>         uint32_t offset =3D hdr->w2.ptr_offset;
>         uint8_t num_frags =3D 0, nxt_frag =3D 0;
>         struct rte_mbuf *head, *last_mbuf;
> @@ -845,10 +845,10 @@ cn20k_nix_recv_pkts_vector(void *args, struct rte_m=
buf **mbufs, uint16_t pkts, c
>         uint64x2_t rearm2 =3D vdupq_n_u64(mbuf_initializer);
>         uint64x2_t rearm3 =3D vdupq_n_u64(mbuf_initializer);
>         struct rte_mbuf *mbuf0, *mbuf1, *mbuf2, *mbuf3;
> +       uint64_t lbase =3D 0, laddr =3D 0, buf_sz =3D 0;
>         uint8_t loff =3D 0, lnum =3D 0, shft =3D 0;
> -       uint64_t lbase, laddr, buf_sz;
> +       uint16_t lmt_id =3D 0, d_off;
>         uint8x16_t f0, f1, f2, f3;
> -       uint16_t lmt_id, d_off;
>         uintptr_t sa_base =3D 0;
>         uint16_t packets =3D 0;
>         uint16_t pkts_left;
> --
> 2.50.1 (Apple Git-155)
>
