Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D46CAC5A7
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Sep 2025 05:53:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 716F240612;
	Mon, 22 Sep 2025 07:53:32 +0200 (CEST)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com
 [209.85.160.173])
 by mails.dpdk.org (Postfix) with ESMTP id 83D88402C4
 for <dev@dpdk.org>; Mon, 22 Sep 2025 07:53:29 +0200 (CEST)
Received: by mail-qt1-f173.google.com with SMTP id
 d75a77b69052e-4b79a332631so48493641cf.0
 for <dev@dpdk.org>; Sun, 21 Sep 2025 22:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758520409; x=1759125209; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3dUI0sF6UwWvNMoLrZfnYGXbs7csx9slq4I1yVW02iM=;
 b=bMnMuaed5+kKgD5eB7vIjK7ViglbALYrqMOXPsCmYGDVR0dqBlUCGLj7yR5gTtDlga
 Z3OojUnNV+QgS24vOSoJ1UsVZELNYVY+kni6bPmCaKzF5v1eXGryn0LxYvU4eFSSPZOm
 sCFMnkvbf0lTY844VXmMYyqV9Iw+SHFN4lHAX/9PmksCBisl7QDJiYuxcidIBykuP95C
 Xc1qmsfXF2HzQRuVVglTtwrbzVGOAWknvd7OAVqbokjBoiBCxJQnnOZV9JfGp9iWZGl9
 69WMMKokPFCYgg4rWyhKEVXuZ9mS8fqWEXueT+QkVncXuYh1E1KjA+mNdPlYy+f7jS8z
 P6YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758520409; x=1759125209;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3dUI0sF6UwWvNMoLrZfnYGXbs7csx9slq4I1yVW02iM=;
 b=f/9A8Mqbq6HOrGJJkFKiD2LDzWD3+Ie0oh2BHpM9WfFIeI//GvjN3dlaJyjlSw6rbN
 ho17pkSJfMa3hYEzQkyYNjWJF9V+T6seU5ZNHXGDmpAiwgo5FNmC36KdK5SUArKs5fOH
 wDF8rXvFnrIVok/AAGXK7JKam0hoM5rrxUNLETP8LDBiRvXjJBIb2n4ydtkPrTDV0bgd
 qPaJ9dqF3gouTry40JhDtdC456KGEBKKcuR4RyxtofBNNgFFzQQWlF2bjj1ENVtTFEWD
 7LJEtP+1qPzPXef2KUg6wcBNKN2k5W/W1EyUeCfX5AUzLoMHEYNa6AEl4csXPVx5eMoj
 qzwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3ti2TEPAQlsdIgHk/lIevdRlc3GaKeBLWbq+/woELa5bP1mcBT6F41cjg2fTb+60X0No=@dpdk.org
X-Gm-Message-State: AOJu0YxOPEs6M/jRnan645Kmfm9qZOtJSzYTurHrZIKl/1rUjE2FaYQr
 RGLfx184GiS1QRfE/RbiV9DTEtdBKMod9eR+tNB2k37MZTL08QpHhSwwIqzYcEBtLQvyD48Dzzj
 DnKhCtAHeb1qq3LIU/NFOJ7U31DR9L0LErPQC
X-Gm-Gg: ASbGncu/lMOELJoeMaqwb7SBXINCJmodjun/jW8FWo58qYUybsRWTN0BwGSjk1wvfWJ
 Micd8z+oM7XSgtHNGRMf7kM9Ez7VaWYjBLkR22rqMOElBON3o4HbEQYoAh9sxl5B+saYeq9BUVN
 IO3W55GndrD7WYIF2JQ7NgB3+0i1tcV3vKtKhL/XWk/vWCNS3OotJdB6avr1Xy335OCvqFXYcgU
 kBQCPxM2eQHtgBDJGJebeRIzTLgHToOISvvLradFhUH+CjBTxv3oFcRGfGWvkI=
X-Google-Smtp-Source: AGHT+IEaaiEVKshkaPxa4uvM6OZUnaRBa06Ic6eFuAAng830i99IC6nr7Q8niN7pSlD8KNxCcHLDcKLJ6tv9ei9Eplw=
X-Received: by 2002:a05:622a:60a:b0:4b5:f2eb:ff1c with SMTP id
 d75a77b69052e-4c0755a38d8mr140501781cf.77.1758520408737; Sun, 21 Sep 2025
 22:53:28 -0700 (PDT)
MIME-Version: 1.0
References: <20250714055849.2258453-1-vattunuru@marvell.com>
In-Reply-To: <20250714055849.2258453-1-vattunuru@marvell.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Mon, 22 Sep 2025 11:23:01 +0530
X-Gm-Features: AS18NWASKrXtpN1DJHZsMJ_7jCn_vo9N9FfYKYIyA1bpJRgXbNz9wwjxoikJj2w
Message-ID: <CALBAE1MRk3coCra2fX3tCRtEfwROo5f+osbf7C2MV6ZeNeQBAA@mail.gmail.com>
Subject: Re: [PATCH v0 1/1] net/octeon_ep: fix device start routine
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

On Mon, Jul 14, 2025 at 11:29=E2=80=AFAM Vamsi Krishna <vattunuru@marvell.c=
om> wrote:
>
> From: Vamsi Attunuru <vattunuru@marvell.com>
>
> Currently the device start routine clears the TX doorbell and
> updates RX doorbell, which causes the device start operation
> to fail after a device stop.
>
> Patch corrects the handling of RX & TX doorbell and ensures
> that any pending packets in the RX queue are drained and gets
> refilled before starting the device.
>
> Fixes: 2c82554c98bd ("net/octeontx_ep: add device start and stop")
> Cc: stable@dpdk.org
>
> Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>


Applied to dpdk-next-net-mrvl/for-main. Thanks

> ---
>  drivers/net/octeon_ep/cnxk_ep_rx.c    | 40 +++++++++++++++++++++++++++
>  drivers/net/octeon_ep/cnxk_ep_vf.c    | 32 ++++++++++-----------
>  drivers/net/octeon_ep/otx2_ep_vf.c    | 30 +++++++++-----------
>  drivers/net/octeon_ep/otx_ep_common.h |  1 +
>  drivers/net/octeon_ep/otx_ep_ethdev.c |  6 ++++
>  drivers/net/octeon_ep/otx_ep_rxtx.h   |  3 ++
>  6 files changed, 77 insertions(+), 35 deletions(-)
>
> diff --git a/drivers/net/octeon_ep/cnxk_ep_rx.c b/drivers/net/octeon_ep/c=
nxk_ep_rx.c
> index 7465e0a017..ec2a1d96a6 100644
> --- a/drivers/net/octeon_ep/cnxk_ep_rx.c
> +++ b/drivers/net/octeon_ep/cnxk_ep_rx.c
> @@ -154,3 +154,43 @@ cn9k_ep_recv_pkts_mseg(void *rx_queue, struct rte_mb=
uf **rx_pkts, uint16_t nb_pk
>
>         return new_pkts;
>  }
> +
> +void
> +cnxk_ep_drain_rx_pkts(void *rx_queue)
> +{
> +       struct otx_ep_droq *droq =3D (struct otx_ep_droq *)rx_queue;
> +       struct rte_mbuf *rx_pkt, *next_seg, *seg;
> +       uint16_t i, j, nb_pkts;
> +
> +       if (droq->read_idx =3D=3D 0 && droq->pkts_pending =3D=3D 0 && dro=
q->refill_count)
> +               return;
> +
> +       /* Check for pending packets */
> +       nb_pkts =3D cnxk_ep_rx_pkts_to_process(droq, droq->nb_desc);
> +
> +       /* Drain the pending packets */
> +       for (i =3D 0; i < nb_pkts; i++) {
> +               rx_pkt =3D NULL;
> +               cnxk_ep_process_pkts_scalar_mseg(&rx_pkt, droq, 1);
> +               if (rx_pkt) {
> +                       seg =3D rx_pkt->next;
> +                       for (j =3D 1; j < rx_pkt->nb_segs; j++) {
> +                               next_seg =3D seg->next;
> +                               rte_mempool_put(droq->mpool, seg);
> +                               seg =3D next_seg;
> +                       }
> +                       rx_pkt->nb_segs =3D 1;
> +                       rte_mempool_put(droq->mpool, rx_pkt);
> +               }
> +       }
> +
> +       cnxk_ep_rx_refill(droq);
> +
> +       /* Reset the indexes */
> +       droq->read_idx  =3D 0;
> +       droq->write_idx =3D 0;
> +       droq->refill_idx =3D 0;
> +       droq->refill_count =3D 0;
> +       droq->last_pkt_count =3D 0;
> +       droq->pkts_pending =3D 0;
> +}
> diff --git a/drivers/net/octeon_ep/cnxk_ep_vf.c b/drivers/net/octeon_ep/c=
nxk_ep_vf.c
> index ca84cac962..a1d9f65f38 100644
> --- a/drivers/net/octeon_ep/cnxk_ep_vf.c
> +++ b/drivers/net/octeon_ep/cnxk_ep_vf.c
> @@ -138,6 +138,18 @@ cnxk_ep_vf_setup_iq_regs(struct otx_ep_device *otx_e=
p, uint32_t iq_no)
>                 return -EIO;
>         }
>
> +       /* Clear the IQ doorbell  */
> +       loop =3D OTX_EP_BUSY_LOOP_COUNT;
> +       while ((rte_read64(iq->doorbell_reg) !=3D 0ull) && loop--) {
> +               rte_write32(OTX_EP_CLEAR_INSTR_DBELL, iq->doorbell_reg);
> +               rte_delay_ms(1);
> +       }
> +
> +       if (loop < 0) {
> +               otx_ep_err("INSTR DBELL is not zero");
> +               return -EIO;
> +       }
> +
>         /* IN INTR_THRESHOLD is set to max(FFFFFFFF) which disable the IN=
 INTR
>          * to raise
>          */
> @@ -237,8 +249,8 @@ cnxk_ep_vf_setup_oq_regs(struct otx_ep_device *otx_ep=
, uint32_t oq_no)
>         droq->pkts_sent_ism =3D
>                 (uint32_t __rte_atomic *)((uint8_t *)otx_ep->ism_buffer_m=
z->addr
>                              + CNXK_EP_OQ_ISM_OFFSET(oq_no));
> -       otx_ep_err("SDP_R[%d] OQ ISM virt: %p dma: 0x%" PRIX64,
> -                   oq_no, (void *)(uintptr_t)droq->pkts_sent_ism, ism_ad=
dr);
> +       otx_ep_dbg("SDP_R[%d] OQ ISM virt: %p dma: 0x%" PRIX64, oq_no,
> +                  (void *)(uintptr_t)droq->pkts_sent_ism, ism_addr);
>         *droq->pkts_sent_ism =3D 0;
>         droq->pkts_sent_prev =3D 0;
>
> @@ -266,24 +278,8 @@ cnxk_ep_vf_setup_oq_regs(struct otx_ep_device *otx_e=
p, uint32_t oq_no)
>  static int
>  cnxk_ep_vf_enable_iq(struct otx_ep_device *otx_ep, uint32_t q_no)
>  {
> -       int loop =3D OTX_EP_BUSY_LOOP_COUNT;
>         uint64_t reg_val =3D 0ull;
>
> -       /* Resetting doorbells during IQ enabling also to handle abrupt
> -        * guest reboot. IQ reset does not clear the doorbells.
> -        */
> -       oct_ep_write64(0xFFFFFFFF, otx_ep->hw_addr + CNXK_EP_R_IN_INSTR_D=
BELL(q_no));
> -
> -       while (((oct_ep_read64(otx_ep->hw_addr +
> -                CNXK_EP_R_IN_INSTR_DBELL(q_no))) !=3D 0ull) && loop--) {
> -               rte_delay_ms(1);
> -       }
> -
> -       if (loop < 0) {
> -               otx_ep_err("INSTR DBELL not coming back to 0");
> -               return -EIO;
> -       }
> -
>         reg_val =3D oct_ep_read64(otx_ep->hw_addr + CNXK_EP_R_IN_ENABLE(q=
_no));
>         reg_val |=3D 0x1ull;
>
> diff --git a/drivers/net/octeon_ep/otx2_ep_vf.c b/drivers/net/octeon_ep/o=
tx2_ep_vf.c
> index a482f4266e..00f723a5a8 100644
> --- a/drivers/net/octeon_ep/otx2_ep_vf.c
> +++ b/drivers/net/octeon_ep/otx2_ep_vf.c
> @@ -287,6 +287,18 @@ otx2_vf_setup_iq_regs(struct otx_ep_device *otx_ep, =
uint32_t iq_no)
>                 return -EIO;
>         }
>
> +       /* Clear the IQ doorbell  */
> +       loop =3D OTX_EP_BUSY_LOOP_COUNT;
> +       while ((rte_read64(iq->doorbell_reg) !=3D 0ull) && loop--) {
> +               rte_write32(OTX_EP_CLEAR_INSTR_DBELL, iq->doorbell_reg);
> +               rte_delay_ms(1);
> +       }
> +
> +       if (loop < 0) {
> +               otx_ep_err("INSTR DBELL is not zero");
> +               return -EIO;
> +       }
> +
>         /* IN INTR_THRESHOLD is set to max(FFFFFFFF) which disable the IN=
 INTR
>          * to raise
>          */
> @@ -388,7 +400,7 @@ otx2_vf_setup_oq_regs(struct otx_ep_device *otx_ep, u=
int32_t oq_no)
>         droq->pkts_sent_ism =3D
>                 (uint32_t __rte_atomic *)((uint8_t *)otx_ep->ism_buffer_m=
z->addr
>                              + OTX2_EP_OQ_ISM_OFFSET(oq_no));
> -       otx_ep_err("SDP_R[%d] OQ ISM virt: %p, dma: 0x%x", oq_no,
> +       otx_ep_dbg("SDP_R[%d] OQ ISM virt: %p, dma: 0x%x", oq_no,
>                    (void *)(uintptr_t)droq->pkts_sent_ism,
>                    (unsigned int)ism_addr);
>         *droq->pkts_sent_ism =3D 0;
> @@ -411,24 +423,8 @@ otx2_vf_setup_oq_regs(struct otx_ep_device *otx_ep, =
uint32_t oq_no)
>  static int
>  otx2_vf_enable_iq(struct otx_ep_device *otx_ep, uint32_t q_no)
>  {
> -       int loop =3D SDP_VF_BUSY_LOOP_COUNT;
>         uint64_t reg_val =3D 0ull;
>
> -       /* Resetting doorbells during IQ enabling also to handle abrupt
> -        * guest reboot. IQ reset does not clear the doorbells.
> -        */
> -       oct_ep_write64(0xFFFFFFFF, otx_ep->hw_addr + SDP_VF_R_IN_INSTR_DB=
ELL(q_no));
> -
> -       while (((oct_ep_read64(otx_ep->hw_addr +
> -                SDP_VF_R_IN_INSTR_DBELL(q_no))) !=3D 0ull) && loop--) {
> -               rte_delay_ms(1);
> -       }
> -
> -       if (loop < 0) {
> -               otx_ep_err("INSTR DBELL not coming back to 0");
> -               return -EIO;
> -       }
> -
>         reg_val =3D oct_ep_read64(otx_ep->hw_addr + SDP_VF_R_IN_ENABLE(q_=
no));
>         reg_val |=3D 0x1ull;
>
> diff --git a/drivers/net/octeon_ep/otx_ep_common.h b/drivers/net/octeon_e=
p/otx_ep_common.h
> index 122926cd40..53de8b18d6 100644
> --- a/drivers/net/octeon_ep/otx_ep_common.h
> +++ b/drivers/net/octeon_ep/otx_ep_common.h
> @@ -589,6 +589,7 @@ int otx_ep_delete_oqs(struct otx_ep_device *otx_ep, u=
int32_t oq_no);
>  #define OTX_EP_CLEAR_ISIZE_BSIZE 0x7FFFFFULL
>  #define OTX_EP_CLEAR_OUT_INT_LVLS 0x3FFFFFFFFFFFFFULL
>  #define OTX_EP_CLEAR_IN_INT_LVLS 0xFFFFFFFF
> +#define OTX_EP_CLEAR_INSTR_DBELL 0xFFFFFFFF
>  #define OTX_EP_CLEAR_SDP_IN_INT_LVLS 0x3FFFFFFFFFFFFFUL
>  #define OTX_EP_DROQ_BUFSZ_MASK 0xFFFF
>  #define OTX_EP_CLEAR_SLIST_DBELL 0xFFFFFFFF
> diff --git a/drivers/net/octeon_ep/otx_ep_ethdev.c b/drivers/net/octeon_e=
p/otx_ep_ethdev.c
> index 10f2f8a2e0..cd8e4bad3b 100644
> --- a/drivers/net/octeon_ep/otx_ep_ethdev.c
> +++ b/drivers/net/octeon_ep/otx_ep_ethdev.c
> @@ -232,6 +232,12 @@ otx_ep_dev_start(struct rte_eth_dev *eth_dev)
>         int ret;
>
>         otx_epvf =3D (struct otx_ep_device *)OTX_EP_DEV(eth_dev);
> +
> +       for (q =3D 0; q < otx_epvf->nb_rx_queues; q++) {
> +               cnxk_ep_drain_rx_pkts(otx_epvf->droq[q]);
> +               otx_epvf->fn_list.setup_oq_regs(otx_epvf, q);
> +       }
> +
>         /* Enable IQ/OQ for this device */
>         ret =3D otx_epvf->fn_list.enable_io_queues(otx_epvf);
>         if (ret) {
> diff --git a/drivers/net/octeon_ep/otx_ep_rxtx.h b/drivers/net/octeon_ep/=
otx_ep_rxtx.h
> index 6b3abe21b1..384e4fb412 100644
> --- a/drivers/net/octeon_ep/otx_ep_rxtx.h
> +++ b/drivers/net/octeon_ep/otx_ep_rxtx.h
> @@ -32,6 +32,9 @@ otx_ep_incr_index(uint32_t index, uint32_t count, uint3=
2_t max)
>         return ((index + count) & (max - 1));
>  }
>
> +void
> +cnxk_ep_drain_rx_pkts(void *rx_queue);
> +
>  uint16_t
>  otx_ep_xmit_pkts(void *tx_queue, struct rte_mbuf **pkts, uint16_t nb_pkt=
s);
>
> --
> 2.34.1
>
