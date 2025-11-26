Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E012D1037D
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Nov 2025 04:59:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3AC4640A7F;
	Wed, 26 Nov 2025 05:59:53 +0100 (CET)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com
 [209.85.160.180])
 by mails.dpdk.org (Postfix) with ESMTP id D96B54029A
 for <dev@dpdk.org>; Wed, 26 Nov 2025 05:59:51 +0100 (CET)
Received: by mail-qt1-f180.google.com with SMTP id
 d75a77b69052e-4ed82ee9e57so89425101cf.0
 for <dev@dpdk.org>; Tue, 25 Nov 2025 20:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764133191; x=1764737991; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Z7kYd6Fd2Yx1tVmOqWYFLf+bgnd9zvn6GZg3Fz7wS4=;
 b=gvBu5YVlJBpY53/dTSFxMCr6+uJYKIpTO1sdWCFyN4whxpTiiCTtl7B71/xFfg8zI1
 pEUWtWZ+/Hhl9fe59K5GZtidPQ8meMGc6nK1Te3Pe4V/R0TNjDcRcfFOQVXM4rRHh4yU
 zNVvaQsu6JuhnFYJem/twOPzznI6OckmwOe/MgvZ0eRY76cLPz+sm1Evj42nZJEHChAu
 3uAI/waL3PzPlMtifQZZfQi1b0SU2Pg/i9G61wwA6/HX9+mnwvLX0o1AdUNmIejiYylE
 cdr55X/sLGMiCmLrzhnpahqJ5CwcoVIEw+NWJoenfMik6/hV6vG84+6V4edkr6q2Ju37
 rIcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764133191; x=1764737991;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4Z7kYd6Fd2Yx1tVmOqWYFLf+bgnd9zvn6GZg3Fz7wS4=;
 b=TMTAz++ecNWBnm1IR4TuKJre9TSmCpDjlc/0Llr64BBH3o8lXQkHkKV9ydAhkbpaXA
 duIpK1LnyHSIDopegNOHkOEjx/NlBR+gMpKEsT2uA1Lhi4JiwwHowBx5smaTECpixbCR
 /LuqJDDsGAzUhnmFFaF5w40O9PkDcTyC1kqv2bMJAcjf9fu5lX5LGWXecg0ZTuEHpc7o
 16580hX6tiJyVWxguRIJYDC0frVeN3M7YWTVO8QMJSs+bUcCm9MoRoG8ho3q4u93h3Tz
 2qfX29dFMeNjxHVeksbKIlHkCNvKr8mKTPMpDP2Odtb/SjqJisyX6ewJm/LIOxOlgdzv
 S5yw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRaNftbao9QJYSVjssnsD9YvvKrMaoOmdceQb59h3gBWf5qwYsq0RJD3FkBVTHV/kJWn0=@dpdk.org
X-Gm-Message-State: AOJu0Yy+e3l3J6+FYR+sO7XTFCG2hDODO3uSe3OavUeaGMh4lbti6laj
 CiqKOgZzAvzj0QN7yMbKLdonSA4xe4VCZXvqKSvZ2fn7eCtnD7kOVJ/AOor03/mJohLQLfeOJms
 EZ76QFgyZ7xy1X5MKhCVMaosTDkrFtok=
X-Gm-Gg: ASbGnctvyzXw3cZLVbLmcM8SMn0WvXQeeAHegch2A1UzCcJ2QHWNiWBTv6QbaSi6RBQ
 sjibsvA5iZVktWAb9eSsxuS/dyo5mmSLo3SrarM4YBK+DzevB/o4qqkNoYqnpLV7Q9cIFQMvf+r
 EcCsukj7/QrYuwij9KBEN8VmtcVKP114dHdHfx0Vdro/0O4M3X1nKDXY5DUda4ylIotSBSs6XG2
 kCkcrWxScDxJedq0cr17CyLX/nS1R52JqxxSNxrS32QhYD8FAwjWEi7s7QPhsDto4cxQRc=
X-Google-Smtp-Source: AGHT+IHBVJS9a3/LTeUCIrIjlnRX6aSHiNHGQrUiVEIFlqxzDVnIpWp0bvLuFrxooliG4ksOxf0BMCiPKB9WN7PqfXU=
X-Received: by 2002:ac8:7d85:0:b0:4ee:1576:a75b with SMTP id
 d75a77b69052e-4ee58afa229mr247853461cf.78.1764133190901; Tue, 25 Nov 2025
 20:59:50 -0800 (PST)
MIME-Version: 1.0
References: <20251125191102.5324-1-pbhagavatula@marvell.com>
In-Reply-To: <20251125191102.5324-1-pbhagavatula@marvell.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Wed, 26 Nov 2025 10:29:37 +0530
X-Gm-Features: AWmQ_bkLez7oHFNeoLqu_HqUQC1dgzrRZvKHKswqSDP7Bp8Tg87j8LVXueQBtuM
Message-ID: <CALBAE1M8zz8sfQ76hYMmWdy-TkOcaC5y3OH5vq1CDMqdVqdoDw@mail.gmail.com>
Subject: Re: [PATCH] event/cnxk: fix offload flags
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

On Wed, Nov 26, 2025 at 12:41=E2=80=AFAM <pbhagavatula@marvell.com> wrote:
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



Please check the CI failures

https://github.com/ovsrobot/dpdk/actions/runs/19685881669/job/56391193057


> ---
>  drivers/event/cnxk/cn10k_eventdev.c | 9 +++------
>  drivers/event/cnxk/cn10k_worker.h   | 4 ++--
>  drivers/event/cnxk/cn20k_eventdev.c | 8 +++-----
>  drivers/net/cnxk/cn10k_rx.h         | 4 ++--
>  4 files changed, 10 insertions(+), 15 deletions(-)
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
> index 954dee5a2a9e..e612d5634eb9 100644
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
>         struct rte_event_vector *vec;
>         uint16_t nb_mbufs, non_vec;
>         struct rte_mempool *mp;
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
> diff --git a/drivers/net/cnxk/cn10k_rx.h b/drivers/net/cnxk/cn10k_rx.h
> index e79306e6467f..ef3bf454536d 100644
> --- a/drivers/net/cnxk/cn10k_rx.h
> +++ b/drivers/net/cnxk/cn10k_rx.h
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
> --
> 2.50.1 (Apple Git-155)
>
