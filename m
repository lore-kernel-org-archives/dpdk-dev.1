Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C287CD98E2
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Jun 2026 08:46:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2BF72402D1;
	Thu, 18 Jun 2026 10:46:21 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id C826740296
 for <dev@dpdk.org>; Thu, 18 Jun 2026 10:46:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781772378;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=etzFLunIf7iy4Bq9X007tgqoVMzK/sJN07cQhYCEo48=;
 b=OoDOXKKtR5YLsvHQcKaZp9iQR4S2mu9c2L1VysdqDzpMMWLp7v5kdQ/yHejwkJIVeVOZk9
 v6Ficp4CLMPv4F2GzDhi85hymKm6boz8VuvUGGaFOMa2x3lj8NtefWjZMxynTtxHwwbL0d
 GU3Bx9vdflExabfB4HPBvHLXvZ+NUrw=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-UH-v82HsOb-BOpk9bif3mA-1; Thu, 18 Jun 2026 04:46:16 -0400
X-MC-Unique: UH-v82HsOb-BOpk9bif3mA-1
X-Mimecast-MFC-AGG-ID: UH-v82HsOb-BOpk9bif3mA_1781772375
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5aa4bb157a9so655490e87.2
 for <dev@dpdk.org>; Thu, 18 Jun 2026 01:46:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781772375; x=1782377175;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=etzFLunIf7iy4Bq9X007tgqoVMzK/sJN07cQhYCEo48=;
 b=YvZXSZ5DxDG7UZ1tM7vjfuUqqLQz2Ola4910lW25DGsdk39EHQFHyoJIGUKICinUfr
 qxvNhNrtwJG2pGD0ZBUKIx9NIZBlXPa8Hx8reNyt+dXM25oS/8oJ0Do6O+hY5Uy2Jh8g
 Ntd1xPU4LOCoLlua7dzpEyCwo8hAp1lYgcnBuq/qhOIXTSqYzLJ4NLdjHzMhHcDp+uwX
 pAKO1rHddJ8IPvLgVdirDaK3U5ePTPtMKOq5aiLaorRNGfwkVL8dwNPbtmuB5un6ylxX
 HtRgQmp5yh+7EFKt83mGF7yEHznEKqAls3cImxZCQxGoBV899uITOLkyA/2oMXZKINCC
 cpFQ==
X-Gm-Message-State: AOJu0YzFa2S92ZkJTGvDZ9URmqBhR+3VDQWvjhUIunQAJ/vT4pSHzMCE
 jq0hULjG/SX4INFyUC8pZ5PG30JaLalcrIpCsTtnvoCkdW8e1HTYHqFyX7Fv3zRIy9jkdfMaKke
 I9uT7wiabZVsiIUKpg5u9U9dtKiyyy0LiAZrL4kbDDIvKFmo4502kUk+Z6kiJrD+e8mflrd1SjB
 efa2ypNkVVk23atnvpU4Q=
X-Gm-Gg: AfdE7cljCHmTgvwFq3OH6OEBNkS63W0TQvzp9CRPf+mpfYa0W2TtDR2LYQ/vXIpW0SO
 0VIt/vN21pqXRkQm3Oz3XyhjCN6oNyE87YyJFPRNP46SzSfNlz2xD/LwA+8Yn6s1SB44w55g1RK
 3SpYJJLZRMzgyAGnZS/wh/K/US6eks6XqtKrWA8VJqOlqEI/UL0yQZJctfSw69eE1ThTQh2dDa+
 9pUPRtjWBuXfr68I9Hfp/3MvvSbF4hVkoX0WfZ0e7MclLIReKCCxiCoZWk=
X-Received: by 2002:a05:6512:618e:b0:5ad:4af3:702e with SMTP id
 2adb3069b0e04-5ad4dada777mr728096e87.51.1781772374415; 
 Thu, 18 Jun 2026 01:46:14 -0700 (PDT)
X-Received: by 2002:a05:6512:618e:b0:5ad:4af3:702e with SMTP id
 2adb3069b0e04-5ad4dada777mr728079e87.51.1781772373749; Thu, 18 Jun 2026
 01:46:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260611154926.392670-1-maxime@leroys.fr>
 <20260616102727.708948-1-maxime@leroys.fr>
 <20260616102727.708948-4-maxime@leroys.fr>
In-Reply-To: <20260616102727.708948-4-maxime@leroys.fr>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 18 Jun 2026 10:46:01 +0200
X-Gm-Features: AVVi8CdqUpOL5-mRkLCaSjIoCzoUJNN259sX7KdtKOfZPex762NwzXXgryRymBM
Message-ID: <CAJFAV8zDcboK5WsC7KOG+HxD1653fsxnXw26EJdg-qraoeRm_w@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] net/dpaa2: support Rx queue interrupts
To: Maxime Leroy <maxime@leroys.fr>
Cc: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>, 
 Sachin Saxena <sachin.saxena@nxp.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bTo6UfHuM54oWVRHB1bQKOUEba40SmK_iQsyk4d9Los_1781772375
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

Hello Maxime,


On Tue, 16 Jun 2026 at 12:28, Maxime Leroy <maxime@leroys.fr> wrote:
>
> Implement .rx_queue_intr_enable / .rx_queue_intr_disable so a worker
> can sleep on a queue's data-availability notification instead of
> busy-polling, through the generic rte_eth_dev_rx_intr_* API.
>
> A worker wakes on its software portal's DQRI, which fires when the
> portal's DQRR holds frames, so the Rx FQ must be scheduled to a channel
> that portal dequeues. The natural dpni_set_queue with a notification
> destination holds the global MC lock long enough to wedge the firmware
> and must target a disabled dpni. But the polling portal is only known
> once a worker affines, after dev_start, so the destination cannot be
> the worker's portal.
>
> Bind each Rx FQ to its own DPCON channel instead. The default Rx burst
> pulls frames from the FQ with a volatile dequeue and cannot be
> interrupt-driven; to wake on the DQRI the FQ must be pushed to the
> portal's DQRR. dev_start issues the DEST_DPCON set_queue statically on
> the still-disabled dpni with no knowledge of the polling lcore; a worker
> later subscribes its own ethrx portal to the channel and arms the DQRI
> in rx_queue_intr_enable (a one-shot per-portal MC op plus QBMan, never
> the wedging set_queue).
>
> This pushed/DQRR consumption is how the event PMD works, but the DPCON
> use differs. The event PMD uses one DPCON per worker, concentrates N
> FQs onto it, and lets the QBMan scheduler load-balance events across
> cores. Here affinity is static and there is no scheduling, so each FQ
> gets its own DPCON (one per FQ, more channels, drawn from the shared
> pool that the DPCON move to the fslmc bus now feeds), bound once at
> dev_start before the lcore is known. Frames are delivered by
> rte_eth_rx_burst (dpaa2_dev_rx_dqrr), not as events via
> rte_event_dequeue.
>
> rte_eth_dev_rx_intr_enable(q) subscribes the lcore portal to q's DPCON
> and arms the DQRI. rte_eth_dev_rx_intr_ctl_q(q) adds q's eventfd (the
> portal DQRI fd) to the thread epoll.
>
>       wire
>        |
>     [ DPMAC ]
>        |
>     [ DPNI ]                                     (1)
>        |
>     TC0:  FQ0   FQ1   FQ2   FQ3                  (2)
>            |     |     |     |                   (3)
>         [DPCON][DPCON][DPCON][DPCON]
>             \     |     |     /                  (4)
>           [ DPIO A ]      [ DPIO B ]             (5)
>              |               |
>             DQRR            DQRR                 (6)
>              |               |
>             DQRI            DQRI                 (7)
>              |               |
>           eventfd         eventfd                (8)
>              |               |
>         rte_epoll_wait  rte_epoll_wait           (9)
>              |               |
>         dpaa2_dev_rx_dqrr                        (10)
>
>   (1)  WRIOP picks a TC (QoS), then RSS-hashes within the TC to an FQ
>   (2)  FQ0..FQ3 are the rte_eth Rx queues
>   (3)  dpni_set_queue(DEST_DPCON): one DPCON per FQ
>   (4)  the lcore portal subscribes to its DPCONs (push_set)
>   (5)  one QBMan software portal per lcore
>   (6)  QMan pushes the FDs into the portal DQRR
>   (7)  DQRI is raised when the DQRR is non-empty
>   (8)  a portal's queues share one fd (its DQRI eventfd)
>   (9)  worker sleeps here when all its queues are idle
>   (10) dpaa2_dev_rx_dqrr drains the DQRR, demuxes FDs to FQs by fqd_ctx
>
> The DQRI and eventfd are portal-wide: a queue's eventfd is its portal's
> DQRI fd, and the inhibit bit is refcounted by armed queues so disabling
> one queue never masks a sibling. The static per-queue bind also lets a
> queue be re-homed to another lcore at runtime, the new worker
> reclaiming the channel, with no set_queue and no port stop.
>
> On single-core 64-byte forwarding this interrupt path runs at ~5.0 Mpps
> versus ~5.86 Mpps polling: per-frame DQRR demux and consume cost about
> 15 percent over the polling batch dequeue.
>
> Signed-off-by: Maxime Leroy <maxime@leroys.fr>

I did not review in detail, but one aspect caught my eye:

[snip]

> diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
> index 803a8321e0..61e7c820de 100644
> --- a/drivers/net/dpaa2/dpaa2_ethdev.c
> +++ b/drivers/net/dpaa2/dpaa2_ethdev.c

[snip]

> @@ -845,6 +853,19 @@ dpaa2_eth_dev_configure(struct rte_eth_dev *dev)
>                 }
>         }
>
> +       if (dev->data->dev_conf.intr_conf.rxq) {
> +               if (!dev->intr_handle)
> +                       dev->intr_handle = rte_intr_instance_alloc(RTE_INTR_INSTANCE_F_PRIVATE);

Something is strange here.

I plan to move this allocation in the probe_device handler of the bus
(https://patchwork.dpdk.org/project/dpdk/patch/20260611094551.1514962-6-david.marchand@redhat.com/).
However, even without this change of mine, the intr_handle should be
allocated in the bus code (see allocation in scan_one_fslmc_device).
A NULL pointer during configure indicates a bug somewhere around the
device pointer life.


> +               if (!dev->intr_handle ||
> +                   rte_intr_vec_list_alloc(dev->intr_handle, "rxq_intr",
> +                               dev->data->nb_rx_queues) ||
> +                   rte_intr_nb_efd_set(dev->intr_handle, dev->data->nb_rx_queues) ||
> +                   rte_intr_type_set(dev->intr_handle, RTE_INTR_HANDLE_EXT)) {
> +                       DPAA2_PMD_ERR("Failed to set up rx-queue interrupts");
> +                       return -rte_errno;
> +               }
> +       }
> +
>         dpaa2_tm_init(dev);
>
>         return 0;


-- 
David Marchand

