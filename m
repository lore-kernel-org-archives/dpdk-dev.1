Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C24606A31C
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Nov 2026 00:53:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 127F240609;
	Fri, 13 Nov 2026 01:53:31 +0100 (CET)
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com
 [74.125.224.54])
 by mails.dpdk.org (Postfix) with ESMTPS id 239FF4029D
 for <dev@dpdk.org>; Fri, 13 Nov 2026 01:53:29 +0100 (CET)
Received: by mail-yx1-f54.google.com with SMTP id
 956f58d0204a3-67bef25eb92so569092d50.0
 for <dev@dpdk.org>; Thu, 12 Nov 2026 16:53:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794531208; cv=none;
 d=google.com; s=arc-20260327;
 b=dy6g0oUlTV/L9DAe7+SJ7Y7J3298KMLJaRBGy69tIh+HoFLbBtxCl6VrmxnyAdNsoN
 kHyLorw8tpZyoD6Aa6YWZ2LEauhO/kgRaiQQAgSNOoyl7O5FlbRtYlV2Ah3tip+lupD5
 yPwihV13SHB9TBLbL5m+z+RY25po0CsDAURNWQQPZ+ngnoPj2RFGH0rSBBFlVZt55nBm
 mR7yEXU5x4QrSrvE5Z1Qj1JfUMjrwLv8o/jf37OWa4bGrt1aHj4wu3k5Wvnv0FJDEECb
 QBrYmjfmsUIvygyqZ2PPxpHqTkPHhNWwjpWeyNDz3XhWcSkJ0sGZ+n7BKrh2rj6oPFjj
 fVRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=siiiEjcpC8FtjuQjXjZuNns28uen8W+ObWdWSi2kvCA=;
 fh=Q9Na040IGX3C5tjhKQZ153D9WAsxwedt3ODiec6w7P0=;
 b=kBDo/QeBJYS4wcxjLqhNTlKaV7cNLg9EueqTUGdqg1J+JMNzWdS54h5aPLTWVnE3b7
 /hy1WSU8bxVMm8VD0T8k8nCEl6Gnw1rEMa0ogYb5NtHCJtpSBdRVOqS/0JjdHOoAHTNb
 SnHaURf/kGf5OwCu0qwE/qT3nG1Ijj4NiRCjGHiecZUnTouIE2FqIdV4SlxpeuCpf69f
 +Fwo+6psR6fpyJEEoNlyc+kgTyHTtWfnx3lg4wIGf2lFW63ARBa9Lbnj2d5zdy+KrL4q
 Enke6RIFhzH8LnN1nlCqMMqWfnEpeHnu9nYCFG3MBRaA/sFGUtbNUaR0/TKYQ62g+Wml
 ocfQ==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794531208; x=1795136008;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=siiiEjcpC8FtjuQjXjZuNns28uen8W+ObWdWSi2kvCA=;
 b=npUVc/Rl2UVlETx/rHTWi7sE5sOnJHisQjNL3BlR9zzoTHcn+RtTjdR1hb9NVECIjf
 +0pRRwIY1MIK/ov04kG+7y/zz3a/MRnhDkt+3IrKgms+nj/fD+5sJW0mzK+eM8W6ywIi
 iH1JF429Tal/WgEmbOajKIvaTe5C4QuNL4RRYp+hT8numQcXdKYycJFedzkmPCgJ/haa
 9SNff4jPJfxfic0nNw0Pv3cnmxtZHZ2LLuvFBn2Z9m6/XUCRPdjM0nrA4tuLxlFZg5Qr
 m2chH+wAvWEv43oyxPiW9J6UCj9p6sTqZk/Jo4ZDLiUqGZ8DXc3nVv+WAToLdD2jt9HW
 aqNQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFlo03jE7JkG/WZV6HIxfAc0ex/Yz8nxasFERTWfsqMHHTudYRxJ3dqBSY5frlxuPjrksY=@dpdk.org
X-Gm-Message-State: APuU4Z921JQ+tH8dJ9lhEhaQPfau5+qhY+RfXSo3kKmQsjwZNgxtf0dT
 K4mqAtr3Ue768UGHsoKjiG3s0we9iWVuVcNklwTk4ut1g+R98sUE6ks0lDTXYTBiTmHR50iIONc
 M5H6Y0+i+mZ4jnzIkBOO9OExGO181+Z8=
X-Gm-Gg: AYBFou0rwjCWcPXyJJmG5t50J1aTSZJZhJ0qaFG+jki34JOKnEwSArPKx29eDEoG+JB
 wqt3N97TguzW1KnIEtBLQGku6QODIUelaPuHS3hAo8S6TGGJGO8Ijvx1k/Xggz2TDrOzareLYwF
 ftF8oizPF2AmN7y1sgT6SzvAPwt89//6fs0j25it8/P9Ci/ahlSd+kQdqF7b3RYGLPWL/5topt8
 1dm6Ve1cegO8hg4JfGcnXmSgLhQhAgZkAyWDDcuh+cHhOKPLWOGC4yCisHrbUEc/UCbhgSwDUZD
 ubvEohbECaHFbRZ0OD/dfHEEbw/EMoLBUTUp1rPBkThw26rPp/alaCVijLO60ceOSdzKw6gIJGd
 b9kwdP67PINsmcSr7BSt7Nbg01cZlDabG+ER/Jri+kDopP0vlXomweyVOIiRW5aT1nNSDEIi5ox
 dU2jLMyYkJZ9+6oh/K55zZcnMyu8A=
X-Received: by 2002:a05:690e:1248:b0:67c:2c9e:bf90 with SMTP id
 956f58d0204a3-67c790641f2mr2562793d50.38.1794531207798; Thu, 12 Nov 2026
 16:53:27 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260915120208.4185877-1-prashant.gupta_3@nxp.com>
 <20261023134346.37727-1-prashant.gupta_3@nxp.com>
 <20261023134346.37727-53-prashant.gupta_3@nxp.com>
In-Reply-To: <20261023134346.37727-53-prashant.gupta_3@nxp.com>
From: Maxime Leroy <maxime@leroys.fr>
Date: Fri, 13 Nov 2026 01:53:15 +0100
X-Gm-Features: AclHuK8UR5zN5OK59GpS3CIBtRxuxUQUj8DZVaG-J_seg2DaNEavCPo06pXP1TM
Message-ID: <CAHHRULWAsqhrJE-7CGu0OEFo_b66FBRYfSFF9r5pW9LYqox7hg@mail.gmail.com>
Subject: Re: [PATCH v4-S3 52/65] net/dpaa2: bind per-queue DPIO for rx-queue
 interrupts
To: Prashant Gupta <prashant.gupta_3@nxp.com>
Cc: stephen@networkplumber.org, dev@dpdk.org, Jun Yang <jun.yang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Jun,

This patch and 47/65 are not in v5-S3. These comments are for when
they come back. I only read the code, I did not run v4-S3 on LX2160A.

My three main concerns:
    1. the PMD changes the CPU frequency governor;
    2. the Rx burst uses the lcore id as a Linux CPU number;
    3. one DPIO per Rx queue is expensive.

Details below.

On Fri, Oct 23, 2026 at 3:49=E2=80=AFPM Prashant Gupta <prashant.gupta_3@nx=
p.com> wrote:
>
> From: Jun Yang <jun.yang@nxp.com>
>
> The DPAA2 rx-queue interrupt path never delivered a wakeup to the
> application.

This is not correct. The current code works if the application calls
rte_eth_dev_rx_intr_enable() before rte_eth_dev_rx_intr_ctl_q(). This
order is documented in dpaa2.rst, and grout uses it.

l3fwd-power calls them in the other order, so it does not work. I
sent a series to fix l3fwd-power:
https://mails.dpdk.org/archives/dev/2026-September/345474.html

Please reword the commit message. Also, what does a DPIO per queue
bring, once l3fwd-power is fixed?

[...]
> +RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_dpio_intr_thread_affinity)
> +void dpaa2_dpio_intr_thread_affinity(struct dpaa2_dpio_dev *dpio_dev)
> +{
> +       int ret;
> +
> +       ret =3D dpaa2_dpio_intr_affinity_set(dpio_dev);
> +       if (ret) {
> +               DPAA2_BUS_WARN("Failed(%d) to affinity dpio.%d's interrup=
t on core%d",
> +                       ret, dpio_dev->hw_id, dpio_dev->cpu_affine);
> +       }
> +       ret =3D dpaa2_dpio_configure_stashing(dpio_dev);
> +       if (ret) {
> +               DPAA2_BUS_WARN("Failed(%d) to configure dpio.%d's stashin=
g on core%d",
> +                       ret, dpio_dev->hw_id, dpio_dev->cpu_affine);
> +       };
> +
> +       ret =3D dpaa2_dpio_cpufreq_governor(dpio_dev->cpu_affine, false);

Please remove the governor change. The power policy belongs to the
application, not to the PMD.

grout uses the schedutil governor. The CPU runs fast while the worker
polls, and slows down while the worker sleeps on the Rx interrupt.
If the PMD forces "performance", the CPU never slows down, and Rx
interrupts save no power.

The restore is also wrong in three cases:
    - Two ports are polled by the same lcore. Closing the first port
      restores the governor, but the second port is still running.
    - A queue moves from CPU A to CPU B. Only B is restored. A stays
      in "performance".
    - A queue was set up but never polled. Its cpu_affine is still -1,
      so the restore applies to all CPUs.

[...]
> @@ -1579,17 +1582,11 @@ dpaa2_dev_rx_queue_setup(struct rte_eth_dev *dev,
>         dpaa2_q->bp_array =3D rte_dpaa2_bpid_info;
>         dpaa2_q->offloads =3D rx_conf->offloads;
>
> -       /* NAPI: grab a DPCON channel so dev_start can bind this FQ stati=
cally.
> -        * The DQRR burst replaces the poll path for every queue at once,=
 so a
> -        * missing channel is fatal rather than a silent per-queue fallba=
ck.
> -        */
> -       rte_atomic_store_explicit(&dpaa2_q->napi_sub_dpio, NULL,
> -                       rte_memory_order_release);
> -       if (dev->data->dev_conf.intr_conf.rxq && !dpaa2_q->napi_dpcon) {
> -               dpaa2_q->napi_dpcon =3D rte_dpaa2_alloc_dpcon_dev();
> +       if (dev->data->dev_conf.intr_conf.rxq) {
> +               if (!dpaa2_q->napi_dpcon)
> +                       dpaa2_q->napi_dpcon =3D rte_dpaa2_alloc_dpcon_dev=
();
>                 if (!dpaa2_q->napi_dpcon) {
> -                       DPAA2_PMD_ERR("rxq %d: no DPCON for rx-queue inte=
rrupts",
> -                               rx_queue_id);
> +                       DPAA2_PMD_ERR("rxq %d: no DPCON for rx-queue inte=
rrupts", rx_queue_id);
>                         ret =3D -ENODEV;
>                         goto err_quit;
>                 }
> @@ -1600,6 +1597,27 @@ dpaa2_dev_rx_queue_setup(struct rte_eth_dev *dev,
>                         DPAA2_PMD_ERR("rxq %d: dpcon_enable: %d", rx_queu=
e_id, ret);
>                         goto err_quit;
>                 }
> +               if (!dpaa2_q->napi_dpio) {
> +                       dpaa2_q->napi_dpio =3D rte_dpaa2_alloc_dpio_devic=
e(true,
> +                               DPAA2_PORTAL_INTR_COALESC_DISABLE, -1, fa=
lse);

Each Rx queue now takes its own DPIO.

For example, with 12 workers, each polling one Rx queue per port:
    - before this patch: 12 DPIOs for Rx (one per worker, shared by
      all its queues)
    - with this patch:   24 DPIOs for Rx with 2 ports, 48 with 4 ports

  How many DPIOs can each SoC provide (LX2160A, LS2088A, LS1088A)?

[...]
> @@ -3706,74 +3699,42 @@ dpaa2_dev_rx_queue_intr_enable(struct rte_eth_dev=
 *dev, uint16_t queue_id)
>  {
>         struct dpaa2_dev_priv *priv =3D dev->data->dev_private;
>         struct dpaa2_queue *dpaa2_q =3D priv->rx_vq[queue_id];
> -       struct dpaa2_dpio_dev *dpio, *old;
>         int ret;
>
> -       /* the generic API has no dev_started guard (unlike the burst dum=
my ops),
> -        * so it can reach us after a stop; do not arm a stopped port, le=
t the
> -        * caller fall back to polling.
> -        */
> -       if (!dev->data->dev_started)
> -               return -EIO;

Why is this check removed?

The ethdev layer does not check that the port is started, so the
driver now arms a queue on a stopped port.

> -       if (!dpaa2_q->napi_dpcon)
> -               return -ENOTSUP;        /* no channel -> caller keeps pol=
ling */
> -
> -       if (dpaa2_affine_qbman_ethrx_swp())
> -               return -EIO;
> -       dpio =3D DPAA2_PER_LCORE_ETHRX_DPIO;
> +       if (dpaa2_q->napi_armed)
> +               return 0;
>
> -       old =3D rte_atomic_load_explicit(&dpaa2_q->napi_sub_dpio, rte_mem=
ory_order_acquire);
> -       if (old && old !=3D dpio && dpaa2_q->napi_armed) {
> -               DPAA2_PMD_ERR("rxq %d still armed on another portal; disa=
ble it first",
> -                             queue_id);
> -               return -EBUSY;
> -       }
> +       if (!dpaa2_q->napi_dpcon || !dpaa2_q->napi_dpio)
> +               return -ENOTSUP;
>
>         ret =3D dpaa2_napi_quiesce_vdq(dpaa2_q);
>         if (ret)
> -               return ret;
> +               goto err_quit;
>
> -       /* holdoff 0: the DQRI fires immediately on the first entry, so t=
he
> -        * threshold is moot (1 here). build_epoll=3Dfalse: the generic r=
x-intr API
> -        * waits on the application epoll, not the portal's private one. =
Idempotent
> -        * per dpio.
> -        */
> -       ret =3D dpaa2_dpio_intr_init(dpio, 1, 0, false);
> +       ret =3D dpaa2_napi_subscribe(dev, queue_id, dpaa2_q->napi_dpio);

Before this patch, dpaa2_napi_subscribe() was called only when the
portal changed.
Now it is called every time the queue is armed, so every time the
worker goes to sleep.

Each call sends an MC command (dpcon_set_notification()).

The DPIO never changes now. Please call it once, in rx_queue_setup().

[...]
> diff --git a/drivers/net/dpaa2/dpaa2_rxtx.c b/drivers/net/dpaa2/dpaa2_rxt=
x.c
> index 0df758148c..efaa862623 100644
> --- a/drivers/net/dpaa2/dpaa2_rxtx.c
> +++ b/drivers/net/dpaa2/dpaa2_rxtx.c
> @@ -963,7 +963,7 @@ dpaa2_dev_prefetch_rx_common(struct dpaa2_queue *dpaa=
2_q,
>  {
>         /* Function receive frames for a given device and VQ*/
>         struct qbman_result *dq_storage, *dq_storage1 =3D NULL;
> -       int ret, num_rx =3D 0;
> +       int ret, num_rx =3D 0, cpu =3D rte_lcore_id();
>         bool by_channel =3D dpaa2_q->napi_dpcon ? true : false;
>         uint32_t id, pull_size;
>         uint8_t pending, status;
> @@ -971,26 +971,36 @@ dpaa2_dev_prefetch_rx_common(struct dpaa2_queue *dp=
aa2_q,
>         const struct qbman_fd *fd;
>         struct qbman_pull_desc pulldesc;
>         struct queue_storage_info_t *q_storage;
> +       struct dpaa2_dpio_dev *dpio;
>
> -       q_storage =3D dpaa2_q->q_storage[rte_lcore_id()];
> +       q_storage =3D dpaa2_q->q_storage[cpu];
>
> -       if (unlikely(!DPAA2_PER_LCORE_ETHRX_DPIO)) {
> -               ret =3D dpaa2_affine_qbman_ethrx_swp();
> -               if (ret) {
> -                       DPAA2_PMD_ERR("Failure in affining portal");
> -                       return 0;
> +       if (dpaa2_q->napi_dpio) {
> +               dpio =3D dpaa2_q->napi_dpio;
> +               if (unlikely(dpio->cpu_affine !=3D cpu)) {
> +                       dpio->cpu_affine =3D cpu;
> +                       dpaa2_dpio_intr_thread_affinity(dpio);

Two problems here.

First, "cpu" is a DPDK lcore id, not a Linux CPU number. They are
equal only with the default mapping. They differ with --lcores, and
for threads created with rte_thread_register(), like grout workers.
In that case the IRQ affinity, the stashing destination and the
governor are set for the wrong CPU. Please use dpaa2_get_core_id(),
as the removed dpaa2_dpio_affine_intr_to_core() did.

Second, this runs inside rte_eth_rx_burst(). cpu_affine starts at -1,
so it runs on the first burst of every queue, and again each
time the queue moves. It reads /proc/interrupts, writes
/proc/irq/N/smp_affinity_list and sends an MC command.

 Proposal:
    - set the IRQ affinity in dpaa2_dev_rx_queue_intr_enable(). It
      runs on the polling lcore, just before the worker sleeps.
    - keep only the stashing update in the burst.

>                 }
> +       } else {
> +               if (unlikely(!DPAA2_PER_LCORE_ETHRX_DPIO)) {
> +                       ret =3D dpaa2_affine_qbman_ethrx_swp();
> +                       if (ret) {
> +                               DPAA2_PMD_ERR("Failure in affining portal=
");
> +                               return 0;
> +                       }
> +               }
> +               dpio =3D DPAA2_PER_LCORE_ETHRX_DPIO;
>         }
> +       swp =3D dpio->sw_portal;
>
> -       swp =3D DPAA2_PER_LCORE_ETHRX_PORTAL;
>         if (dpaa2_q->napi_dpcon)
>                 id =3D dpaa2_q->napi_dpcon->qbman_ch_id;
>         else
>                 id =3D dpaa2_q->fqid;
>         pull_size =3D (nb_pkts > dpaa2_dqrr_size) ? dpaa2_dqrr_size : nb_=
pkts;
>         if (unlikely(!q_storage->active_dqs)) {
> -               dpaa2_dev_rx_active_dq_storage(q_storage, DPAA2_PER_LCORE=
_ETHRX_DPIO,
> -                       id, pull_size, by_channel, qbman_pull_type_active=
);
> +               dpaa2_dev_rx_active_dq_storage(q_storage, dpio, id, pull_=
size,
> +                       by_channel, qbman_pull_type_active);
>         }
>
>         dq_storage =3D q_storage->active_dqs;

The DPIO never changes now. Please call it once, in
rx_queue_setup().The DPIO never changes now. Please call it once, in
rx_queue_setup().The DPIO never changes now. Please call it once, in
rx_queue_setup().A question about queue migration. grout moves a queue
from one worker
to another without stopping the port.

When the queue moves from lcore A to lcore B, the DPIO follows the
queue, but q_storage is still per lcore. If A left a VDQ in flight,
its frames stay in q_storage[A]. B waits for that VDQ to complete,
then pulls into q_storage[B]. It never reads the frames in
q_storage[A].

This is not new: q_storage is already per lcore in 26.07, and the
only cleanup, dpaa2_clear_queue_active_dps(), runs at close and does
not read the frames. But now that the DPIO belongs to the queue,
q_storage could belong to the queue too. Then B would simply read
the frames left by A. What do you think?

Last point: dpaa2.rst and the comments in
dpaa2_dev_rx_queue_intr_enable()/disable() still describe the old
model (shared per-lcore portal, fd bound when the queue is armed,
sibling queues).

dpaa2.rst should also say that each Rx queue needs a DPIO, not only a DPCON=
.

Thanks,

Maxime
