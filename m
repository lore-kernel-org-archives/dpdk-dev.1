Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93724CD5BCB
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 11:27:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1F31340DD5;
	Thu, 13 Nov 2025 12:27:51 +0100 (CET)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com
 [209.85.222.173])
 by mails.dpdk.org (Postfix) with ESMTP id C491A40678
 for <dev@dpdk.org>; Thu, 13 Nov 2025 12:27:49 +0100 (CET)
Received: by mail-qk1-f173.google.com with SMTP id
 af79cd13be357-8b26b12be9eso78610485a.1
 for <dev@dpdk.org>; Thu, 13 Nov 2025 03:27:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763033269; x=1763638069;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8UGfnrlqCtK7d1kjHx3SbDjCCVdueI22YfYI3m1lmzU=;
 b=NfhAKEaoqnKSd+YwPo6v/rOXJqs27QLiMUVpxPtYBX2lco+hyhR1RdS2/j3oZXMpJQ
 4oyaC+KufOe18mRoZ0b1uXSW/VTMOAvCcTmHkNGdk9sa/ffVUheOMEvvjlAzFn+Dz1cp
 1KVdNbi8juxviGgh2F3ZUxUVeo5rPONXbFvQAuGwp2MKXiB/vbmHZyxicDaiiYDruGCx
 zbZ5U2pbk94kVj2sW6CckfzFJv1KOuoRkjwyxon+mzkDrwc5y0wQzrYmT2mHM5iJeqre
 fu9pUkQgfqAi+jjBqfFLLz/geozlwqaDR0tSegVueXxP44HLUmDFa0iEBtdJM9RwuGjr
 t7zQ==
X-Gm-Message-State: AOJu0YxsaQaebM6uib6e4sSNNzPJNxf8cQOnZt1Pg/FJEN9Hay4divKT
 fun3SeBRE1+a3EIu0KaXUxUtf6uTRg6WIecZYeHEBN4qB0c/uQLz2arrLgeN08CJ6Un2Mxn0s4Q
 YPYzdsc4VkM3kbi7q7x0i177SemxZ/5Y=
X-Gm-Gg: ASbGnctvdv8U5AJLgwbKreeEDTVadpL0Y5wwta2gHtvwtu2QoTHmh+ZLY40KMBvk+Ut
 7EwlohODZNMQihMg3pN5xews+j3kPu40KBFkEKFh1sblAJs7UspEDVmTcz0s9ac3HJecV2TK4xN
 rvp+d8DPW/XSBqd3Djej7nFEFnRcQFhIYp4QEXPHtYKvjP6eV5BaWa2l8fAOWq9OWYYR5uhyI+T
 kac31uzrH27Ma7hVj8b8giFs+lMoK9j3JfYHW8R7S/gvTrn2B4Lgq0HesM=
X-Google-Smtp-Source: AGHT+IHiAy+p5MYL93JA09gEY3NeRcoCueMb/1uUnLX/n240DwbLno1mt+zg1H5wBlFvSF3TmLi2FYNySoiiGIle9Zs=
X-Received: by 2002:a05:620a:d85:b0:89e:651b:d6de with SMTP id
 af79cd13be357-8b29b767a00mr768743685a.13.1763033268724; Thu, 13 Nov 2025
 03:27:48 -0800 (PST)
MIME-Version: 1.0
References: <20251113052931.1784953-1-hemant.agrawal@nxp.com>
 <20251113095917.1973514-1-hemant.agrawal@nxp.com>
 <20251113095917.1973514-2-hemant.agrawal@nxp.com>
In-Reply-To: <20251113095917.1973514-2-hemant.agrawal@nxp.com>
From: Maxime Leroy <maxime@leroys.fr>
Date: Thu, 13 Nov 2025 12:27:37 +0100
X-Gm-Features: AWmQ_bmo6cYJYd56zI50tGTDy0Eb2x9xvzNQiHMnqkm6sgvFY5RCU5-00TGLb2w
Message-ID: <CAHHRULU5Lm3VDj8dp1tzuwmPSkbz6rKPteK4u4FCxEyXbZg2=w@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] net/dpaa2: clear active VDQ state when freeing Rx
 queues
To: Hemant Agrawal <hemant.agrawal@nxp.com>
Cc: dev@dpdk.org, stephen@networkplumber.org, david.marchand@redhat.com, 
 jun.yang@nxp.com, stable@dpdk.org
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

Le jeu. 13 nov. 2025 =C3=A0 10:59, Hemant Agrawal <hemant.agrawal@nxp.com> =
a =C3=A9crit :
>
> From: Maxime Leroy <maxime@leroys.fr>
>
> When using the prefetch Rx path (dpaa2_dev_prefetch_rx), the driver keeps
> track of one outstanding VDQCR command per DPIO portal in the global
> rte_global_active_dqs_list[] array. Each queue_storage_info_t also stores
> the active result buffer and portal index:
>
>   qs->active_dqs
>   qs->active_dpio_id
>
> Before issuing a new pull command, dpaa2_dev_prefetch_rx() checks for an
> active entry and spins on qbman_check_command_complete() until the
> corresponding VDQCR completes.
>
> On port close / hotplug remove, dpaa2_free_rx_tx_queues() frees all
> per-lcore queue_storage_info_t structures and their dq_storage[] buffers,
> but never clears the global rte_global_active_dqs_list[] entries. After a
> detach/attach sequence (or "del/add" in grout), the prefetch Rx path
> still sees an active entry for the portal and spins forever on a stale dq
> buffer that has been freed and will never be completed by hardware. In
> gdb, dq->dq.tok stays 0 and dpaa2_dev_prefetch_rx() loops in:
>
>   while (!qbman_check_command_complete(get_swp_active_dqs(idx)))
>       ;
>
> Fix this by clearing the active VDQ state before freeing queue storage.
> For each Rx queue and lcore, if qs->active_dqs is non-NULL, call
> clear_swp_active_dqs(qs->active_dpio_id) and set qs->active_dqs to NULL.
> Then dpaa2_queue_storage_free() can safely free q_storage and
> dq_storage[].
>
> After this change, a DPNI detach/attach sequence no longer leaves stale
> entries in rte_global_active_dqs_list[], and the prefetch Rx loop does
> not hang waiting for a completion from a previous device instance.
>
> Reproduction:
>   - grout:
>       grcli interface add  port dpni.1 devargs fslmc:dpni.1
>       grcli interface del  dpni.1
>       grcli interface add  port dpni.1 devargs fslmc:dpni.1
>     -> Rx was stuck in qbman_check_command_complete(), now works.
>
>   - testpmd:
>       dpdk-testpmd -n1 -a fslmc:dpni.65535 -- -i --forward-mode=3Drxonly
>       testpmd> port attach fslmc:dpni.1
>       testpmd> port start all
>       testpmd> start
>       testpmd> stop
>       testpmd> port stop all
>       testpmd> port detach 0
>       testpmd> port attach fslmc:dpni.1
>       testpmd> port start all
>       testpmd> start
>     -> Rx was hanging, now runs normal
>
> Fixes: 12d98eceb8ac ("bus/fslmc: enhance QBMAN DQ storage logic")
> Cc: jun.yang@nxp.com
> Cc: stable@dpdk.org
>
> Signed-off-by: Maxime Leroy <maxime@leroys.fr>
> ---
>  .mailmap                         |  2 +-
>  drivers/net/dpaa2/dpaa2_ethdev.c | 22 ++++++++++++++++++++++
>  2 files changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/.mailmap b/.mailmap
> index 10c37a97a6..d92d4fc24b 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -1035,7 +1035,7 @@ Mauricio Vasquez B <mauricio.vasquez@polito.it> <ma=
uricio.vasquezbernal@studenti
>  Mauro Annarumma <mauroannarumma@hotmail.it>
>  Maxime Coquelin <maxime.coquelin@redhat.com>
>  Maxime Gouin <maxime.gouin@6wind.com>
> -Maxime Leroy <maxime.leroy@6wind.com>
> +Maxime Leroy <maxime.leroy@6wind.com> <maxime@leroys.fr>
>  Md Fahad Iqbal Polash <md.fahad.iqbal.polash@intel.com>
>  Megha Ajmera <megha.ajmera@intel.com>
>  Meijuan Zhao <meijuanx.zhao@intel.com>
> diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_e=
thdev.c
> index fc63cf4f09..c94034104a 100644
> --- a/drivers/net/dpaa2/dpaa2_ethdev.c
> +++ b/drivers/net/dpaa2/dpaa2_ethdev.c
> @@ -631,6 +631,27 @@ dpaa2_alloc_rx_tx_queues(struct rte_eth_dev *dev)
>         return ret;
>  }
>
> +static void
> +dpaa2_clear_queue_active_dps(struct dpaa2_queue *q)
> +{
> +       int lcore_id;
> +
> +       RTE_LCORE_FOREACH(lcore_id) {

RTE_LCORE_FOREACH does not iterate over NON-EAL threads. However,
Grout creates NON-EAL threads using the pthread library to poll the RX
queue.

As a result, using RTE_LCORE_FOREACH breaks the fix. We should revert
to the previous version of the fix.

Thanks,

Maxime Leroy
