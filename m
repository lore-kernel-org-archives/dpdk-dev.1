Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36223C43458
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Jul 2026 10:36:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BD7F0402C3;
	Mon,  6 Jul 2026 12:36:14 +0200 (CEST)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com
 [209.85.128.175])
 by mails.dpdk.org (Postfix) with ESMTP id D1BC54027B
 for <dev@dpdk.org>; Mon,  6 Jul 2026 12:36:12 +0200 (CEST)
Received: by mail-yw1-f175.google.com with SMTP id
 00721157ae682-80c5cb9a888so32197817b3.3
 for <dev@dpdk.org>; Mon, 06 Jul 2026 03:36:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783334172; cv=none;
 d=google.com; s=arc-20260327;
 b=orZEKMK5pWFBTEN7ymDqZQ5gyDw2/JLEG7+tJ8Ndoe+y+jBdGcZ8wjOPzLRoaDTRaE
 cWV6QMFV6baBsg8O/4kue8Uks0WpJsfjKJD/U0RDjZHMbIl6JaDXzGl9RkN/YVG30lbd
 ssw0Av3pJ4OHcR1486zUMcYiZympFF/14zpyp6Ci7KwXh7NC7SDNAOqhQ24Zx/ysxC0d
 i5Ji6XQF4J7RxzLjzEst7RMdaZ2mpjWzHM+x9dy57sPCdZflFKeQJ/Vr5/dkDTwDosKa
 xqWb2/TqovP9uJzp54a5V61bhcglMKk5ixCZ44DLM1QKXMs7oeAQXFxg3zaxWhmir3X9
 dxlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=1av1SUMZCeLG9Hv+dCRHe4R3gS5apOkaIubiFvKhtwA=;
 fh=BjgJeim0EpDH8QWNTByuJ1toc0a82/5nb1cOn0NZ1xg=;
 b=Q3VYtu7UuPhNuMEqafhmA57S/oc0JkjfHc1wzDckpJaKgL+qkaRj2utgxvA1msokyB
 8SP+I90HOvdrLsZ+oCe0L+7ckIvaMq1YltoLYVFyXMF3Yr3tB6o5TGl3pGFomordU9Ln
 WiqUyXssWfgGDxrzG7bMZm/wp4IMzoo63d2djK9vefnL3iElsx62QE6HW/FWxGcswPht
 2phCB4LNwuH29HUlDD74zovdVqzk3t2l10Uhl17nR+ff1mCotVpS7BUNYSumgbSmsCZ+
 X+3Rq5wWAZP76VSUXAx7L+BHGr3awGO2h94xA3fSdTVPebUKAuizNhQrKwMMVvsGfKiq
 wlUg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783334172; x=1783938972;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1av1SUMZCeLG9Hv+dCRHe4R3gS5apOkaIubiFvKhtwA=;
 b=YI1GohSqrcHwdJJDl33tNb5IWg9g9KrAGaQ2e4uHH/GzfPWoXno9Yy1CrTdjZRRKLX
 C68GooItVRAS6YlxVYAfvenuQbyYLZe1AKNHUANhbAQMm/vK0Qkf8Vs1Fm+Akd6YgbdD
 ES9E/6IiD/rRH6Ez2o9OJdNHP9i6YBlRQOdIpbXTXAnkA/IKWWSODmatjEgKxmLwZRoo
 g59AWBGGCNhJUeUlg6JM/vbrJTnaHGEmPfxo6a4SvbVqXeRFQfYoQtCaBzJ4Nw9VDWwQ
 YqjrobYP31ZiObMqzHmo7a+/vRl7Cb2IqRfNiQgGHOgT2JsOmdesSES/hSmdXhDLtY23
 LsBA==
X-Gm-Message-State: AOJu0YzdZt6h5Tk5ZlbdMQnuJJ3KoaV/XXKpux4r+V3ffbxP4lefo0eN
 35wjMpIE6Qv/VsVp6+CxMMcbY4Hm8G1SrSAfS+GsVzCJlWjNocuvkeveLDDzjpxDusiB7SzshoR
 5hDoXuoWAcDwh97dbyd7tsZtz6PGgCLA=
X-Gm-Gg: AfdE7ck53nZxp+Q30X2DoA9BG0wZZuhBst6XiNXOD6DhyG+8iqvLxc2tBLI6L/5VAyw
 PpImjTXLb6vZkxW+KKXgpBS0ctjQyU4cBrxuBejpTOx/tjHLsfD2Vk4qaUnuBWp9FssijBV/drG
 bTN8I13EjJInL/hyOXznueVw989pwmM4rPrPJrYfjlUw2KjWUbUSnR8vmcZ/C/rO/JjVufxC1GL
 4ul2uP1GIcBEGgfOGZ/p4yvXYJA7EORTb9UelxhPhwErFpdIQ6vZkSUEquIsPH3ycEOgQ==
X-Received: by 2002:a05:690c:7281:b0:814:3d9f:c073 with SMTP id
 00721157ae682-817373469f9mr105938737b3.14.1783334171998; Mon, 06 Jul 2026
 03:36:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260616102727.708948-1-maxime@leroys.fr>
 <20260630144329.457643-1-maxime@leroys.fr>
 <20260630144329.457643-6-maxime@leroys.fr>
 <3ac32501-55de-4d8b-87dd-55d31ca7e4bf@oss.nxp.com>
In-Reply-To: <3ac32501-55de-4d8b-87dd-55d31ca7e4bf@oss.nxp.com>
From: Maxime Leroy <maxime@leroys.fr>
Date: Mon, 6 Jul 2026 12:36:01 +0200
X-Gm-Features: AVVi8Ce-s56JueknQPL90GzSv7TAMVYGxCiCLnbg2trw1yUZlKxAO_l7a2G0sXE
Message-ID: <CAHHRULW=Dsdya4CFX=5jeLtJuinwnt965dR0YwU9uFbaR_FSXA@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] net/dpaa2: support Rx queue interrupts
To: Hemant Agrawal <hemant.agrawal@oss.nxp.com>
Cc: dev@dpdk.org, hemant.agrawal@nxp.com, sachin.saxena@nxp.com, 
 david.marchand@redhat.com
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

Hi Hemant,

On Fri, Jul 3, 2026 at 7:21=E2=80=AFPM Hemant Agrawal
<hemant.agrawal@oss.nxp.com> wrote:
>
>
> On 30-06-2026 20:13, Maxime Leroy wrote:
>
> diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_e=
thdev.c
> index a68404ee5e..36f8669644 100644
> --- a/drivers/net/dpaa2/dpaa2_ethdev.c
> +++ b/drivers/net/dpaa2/dpaa2_ethdev.c
> @@ -5,6 +5,8 @@
>
>  #include <time.h>
>  #include <net/if.h>
> +#include <unistd.h>
> +#include <errno.h>
>
>  #include <eal_export.h>
>  #include <rte_mbuf.h>
> @@ -25,6 +27,7 @@
>  #include <dpaa2_hw_mempool.h>
>  #include <dpaa2_hw_dpio.h>
>  #include <mc/fsl_dpmng.h>
> +#include <mc/fsl_dpcon.h>
>  #include "dpaa2_ethdev.h"
>  #include "dpaa2_sparser.h"
>  #include <fsl_qbman_debug.h>
> @@ -658,6 +661,8 @@ dpaa2_clear_queue_active_dps(struct dpaa2_queue *q, i=
nt num_lcores)
>   }
>  }
>
> +static void dpaa2_dev_rx_queue_intr_unbind(struct dpaa2_queue *dpaa2_q);
> +
>  static void
>  dpaa2_free_rx_tx_queues(struct rte_eth_dev *dev)
>  {
> @@ -675,6 +680,12 @@ dpaa2_free_rx_tx_queues(struct rte_eth_dev *dev)
>   /* cleaning up queue storage */
>   for (i =3D 0; i < priv->nb_rx_queues; i++) {
>   dpaa2_q =3D priv->rx_vq[i];
> + if (dpaa2_q->napi_dpcon) { /* release the rx-intr channel */
> + dpaa2_dev_rx_queue_intr_unbind(dpaa2_q);
> + rte_dpaa2_free_dpcon_dev(dpaa2_q->napi_dpcon);
> + dpaa2_q->napi_dpcon =3D NULL;
> + dpaa2_q->napi_sub_dpio =3D NULL;
> + }
>   dpaa2_clear_queue_active_dps(dpaa2_q,
>   RTE_MAX_LCORE);
>   dpaa2_queue_storage_free(dpaa2_q,
> @@ -880,6 +891,26 @@ dpaa2_eth_dev_configure(struct rte_eth_dev *dev)
>   }
>   }
>
> + if (dev->data->dev_conf.intr_conf.rxq) {
> + if (!dev->intr_handle)
> + dev->intr_handle =3D rte_intr_instance_alloc(RTE_INTR_INSTANCE_F_PRIVAT=
E);
> + if (!dev->intr_handle ||
> +    rte_intr_vec_list_alloc(dev->intr_handle, "rxq_intr",
> + dev->data->nb_rx_queues) ||
> +    rte_intr_nb_efd_set(dev->intr_handle, dev->data->nb_rx_queues) ||
> +    rte_intr_type_set(dev->intr_handle, RTE_INTR_HANDLE_EXT)) {
> + DPAA2_PMD_ERR("Failed to set up rx-queue interrupts");
> + /* capture the error before cleanup may clobber rte_errno */
> + ret =3D rte_errno ? -rte_errno : -EIO;
> + if (dev->intr_handle) {
> + rte_intr_vec_list_free(dev->intr_handle);
> + rte_intr_instance_free(dev->intr_handle);
> + dev->intr_handle =3D NULL;
> + }
> + return ret;
> + }
> + }
> +
>
> If dev_configure() is called a second time (e.g. after changing nb_rx_que=
ues), dev->intr_handle is already non-NULL. The code skips rte_intr_instanc=
e_alloc() but calls rte_intr_vec_list_alloc() on the existing handle withou=
t first freeing the old vector list. This leaks the previously allocated ve=
ctor list and may also cause a size mismatch if nb_rx_queues changed betwee=
n calls.
>
> Should not we free the old vector list before reallocating:
>
> if (dev->intr_handle)
>
>     rte_intr_vec_list_free(dev->intr_handle);
>
> else
>
>     dev->intr_handle =3D rte_intr_instance_alloc(RTE_INTR_INSTANCE_F_PRIV=
ATE);
>
>  /* then always call rte_intr_vec_list_alloc() */
>

real bug, but not a leak. rte_intr_vec_list_alloc() returns early when
intr_vec !=3D NULL, so a second configure() allocates nothing. The
opposite happens: the vector list keeps its old size, and if
nb_rx_queues grew
 (stop/reconfigure/start, no close, which the API allows), arming the
new queues fails with -ERANGE.

 Freeing only the vector list isn't enough either, it leaves
nb_efd/the eventfd array stale. The fix is to rebuild the whole handle
on re-entry:
 if (dev->intr_handle) {
     rte_intr_vec_list_free(dev->intr_handle);
     rte_intr_instance_free(dev->intr_handle);
     dev->intr_handle =3D NULL;
 }
 dev->intr_handle =3D rte_intr_instance_alloc(...);

I'll fix this in v4.

>
>   dpaa2_tm_init(dev);
>
>   return 0;
> @@ -898,6 +929,7 @@ dpaa2_dev_rx_queue_setup(struct rte_eth_dev *dev,
>  {
>   struct dpaa2_dev_priv *priv =3D dev->data->dev_private;
>   struct fsl_mc_io *dpni =3D dev->process_private;
> + bool dpcon_allocated =3D false;
>   struct dpaa2_queue *dpaa2_q;
>   struct dpni_queue cfg;
>   uint8_t options =3D 0;
> @@ -938,6 +970,25 @@ dpaa2_dev_rx_queue_setup(struct rte_eth_dev *dev,
>   dpaa2_q->bp_array =3D rte_dpaa2_bpid_info;
>   dpaa2_q->offloads =3D rx_conf->offloads;
>
> + /* NAPI: grab a DPCON channel for dev_start to bind this FQ statically =
*/
> + dpaa2_q->napi_sub_dpio =3D NULL;
>
>
> dpaa2_q->napi_sub_dpio is declared as RTE_ATOMIC(struct dpaa2_dpio_dev *)=
 in dpaa2_hw_pvt.h, but here it is assigned with a plain =3D NULL instead o=
f rte_atomic_store_explicit(...). This is inconsistent with the atomic stor=
es used elsewhere (e.g. in dpaa2_dev_rx_queue_intr_unbind) and may cause me=
mory-ordering issues on weakly-ordered architectures (ARM/aarch64).
>
> Please use:
>
> rte_atomic_store_explicit(&dpaa2_q->napi_sub_dpio, NULL, rte_memory_order=
_release);

I'll switch to rte_atomic_store_explicit() for consistency and MSVC
(where RTE_ATOMIC(x) is a plain type). But it's not an ordering bug:
the field is _Atomic (plain store is already seq_cst), and this is
rx_queue_setup, before dev_start, with no reader yet. So this is
cleanup, not a correctness fix, I'll change it in v4

Thanks,

Maxime
