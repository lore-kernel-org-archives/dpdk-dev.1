Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B2C8CD98DA
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Jun 2026 09:26:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BA40B436E2;
	Mon, 15 Jun 2026 11:26:46 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 4B24E436DF
 for <dev@dpdk.org>; Mon, 15 Jun 2026 11:26:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781515603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SZ2eyNu9EVpmF5EFAt5Jz5436kacRt9K+oHYb4Wbuvc=;
 b=g+UaWXUnRWLbpNCuR9sQgnK0f/fNNgNIY5sFFDVbJcdyUuyDHXiOIpYzZ8W2F7K5WbxXxV
 uwCcymmoHbpGKA4yA9K9V7Y1MVK+vbZqV3NB/jfN3v6GBMRjFQicrlIvvwTwq/N4DwLDG7
 ACIZaMWEe3xrDImCS9251u8G4Yp4iwI=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-W6vH_TuFMNSz4YcYi9s9JA-1; Mon, 15 Jun 2026 05:26:41 -0400
X-MC-Unique: W6vH_TuFMNSz4YcYi9s9JA-1
X-Mimecast-MFC-AGG-ID: W6vH_TuFMNSz4YcYi9s9JA_1781515600
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5aa61a298a6so1937978e87.1
 for <dev@dpdk.org>; Mon, 15 Jun 2026 02:26:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781515600; x=1782120400;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SZ2eyNu9EVpmF5EFAt5Jz5436kacRt9K+oHYb4Wbuvc=;
 b=I2oBquJyXWs/WhqD+LSjzE/QuTuuRLgf99Hti00UBh1NwKAUJ+ElHgfKgu0PHaeAzI
 0WvMBRn9bH6D1RX+dK5rj2q/McEuuczRYJTlW7rgjqDwIi1o/J8j/zOB0ft3v+TDBJAc
 /0QhNHXUsBxacAoeqT/lH+3g6zKQyPIfBDK3Wvtrqm2XRBe73pMoED4bWuLMaqHkyhFX
 CttursQ0TiV4DatxxfijMRXzt9oV6kSCt4Ib1hWe8v5vUIjcxZJOq2qdhtEl8Yd0wIWY
 wrbB7TTaQZkX6s1lUO7WbMXWrRnXfvaxpc3r81Zm6CqzQ9rJwMthnznDkJTFju52gbiG
 H3Dg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9XcdghsWRawnGPiAIgK0FbiujTfAvRbahZjZs1Eexqu61jXdiOKQcWT3KJvYs1n3NLJDY=@dpdk.org
X-Gm-Message-State: AOJu0YzZgLiwvCC2Ef2BlBvTvMkITGuMZDIf2uvAgk+5R3IlX/7/jVW2
 LYf/7Hjs5T1JNkAKQJurkJO9eDnLhGf9uF/1hfnX2VJfDOXj5OrT8Cd06EqMaymzOgn5YZZ01EU
 ekodZofJiYQx312pKUJfxBYUM86XYhOzAWAah0KXQ7SRv+L/gg1nh7lyX52wBb6u19c0LzkM+xa
 3cRjZLXN/B+7zv0Xa4GYY=
X-Gm-Gg: Acq92OFCSAH/ckQQNbGbhpon8WXsCrJ4zRVztnkXO285HT2XhKfy4aIkXZpTvkKmZPL
 nBrsSnYo4AMTeno23xOMJwZKK1Vy9TYVxYAQummVeDTf2E1ekBioGxbpYSpXm/Z/eP3cecUG+57
 M+JYhOfqT4igCgIgUjqzt4lEGUr4kZiTdZsFxa1dyU0agPihrcIP422OWEKSpdsBSTGuHsyM0TO
 7QjgLu4P5npIKvz/gHMbUgy8/eh7JUwA1SFd/T+enwuD6DRyCpbxv9UzwQ1MV41Ir7kMA==
X-Received: by 2002:a05:6512:3f1b:b0:5aa:655b:ac29 with SMTP id
 2adb3069b0e04-5ad2db1d87amr4119771e87.13.1781515600024; 
 Mon, 15 Jun 2026 02:26:40 -0700 (PDT)
X-Received: by 2002:a05:6512:3f1b:b0:5aa:655b:ac29 with SMTP id
 2adb3069b0e04-5ad2db1d87amr4119754e87.13.1781515599371; Mon, 15 Jun 2026
 02:26:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260611154926.392670-1-maxime@leroys.fr>
 <20260611154926.392670-9-maxime@leroys.fr>
In-Reply-To: <20260611154926.392670-9-maxime@leroys.fr>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 15 Jun 2026 11:26:27 +0200
X-Gm-Features: AVVi8CdSgBvQ4sZPUprWPRmDLiD3POwAH5_Rewha_KJTDl_K2R4Pbtg8aQgK6Bw
Message-ID: <CAJFAV8xTgkgdSzX980qW3zT+gqcDkrQyDV48SMzGh5qSCkz=7Q@mail.gmail.com>
Subject: Re: [PATCH 8/9] ethdev: keep fast-path ops valid after port stop
To: Maxime Leroy <maxime@leroys.fr>
Cc: hemant.agrawal@nxp.com, sachin.saxena@nxp.com, dev@dpdk.org, 
 stable@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, 
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>, 
 Sunil Kumar Kori <skori@marvell.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: aWfYrf1nKlodp6hP7HDOuILS2CdsxVs3jz4KqJUUXuI_1781515600
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

On Thu, 11 Jun 2026 at 17:51, Maxime Leroy <maxime@leroys.fr> wrote:
>
> eth_dev_fp_ops_reset() restores a port's fast-path ops on stop/release
> via a compound literal, so every field it omits is zeroed to NULL. It
> sets only rx_pkt_burst/tx_pkt_burst (and the rxq/txq data), leaving
> rx_queue_count, tx_queue_count, rx/tx_descriptor_status, tx_pkt_prepare
> and the recycle callbacks NULL.
>
> In non-debug builds these ops are reached through an unguarded indirect
> call (the NULL check exists only under RTE_ETHDEV_DEBUG_RX/TX). So a
> thread calling e.g. rte_eth_rx_queue_count() on a port being stopped
> dereferences NULL and crashes, while the same race on rte_eth_rx_burst()
> is harmless because the burst ops are reset to dummies. A poll-mode
> worker re-checking rx_queue_count before arming the Rx interrupt and
> sleeping hits exactly this.
>
> Reset these ops to the same dummies eth_dev_set_dummy_fops() installs,
> so a stopped port behaves like a freshly allocated one: every fast-path
> op is a safe no-op, none is NULL.
>
> Fixes: 066f3d9cc21c ("ethdev: remove callback checks from fast path")
> Cc: stable@dpdk.org
> Signed-off-by: Maxime Leroy <maxime@leroys.fr>
> ---
>  lib/ethdev/ethdev_private.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/lib/ethdev/ethdev_private.c b/lib/ethdev/ethdev_private.c
> index 72a0723846..75ea3eedff 100644
> --- a/lib/ethdev/ethdev_private.c
> +++ b/lib/ethdev/ethdev_private.c
> @@ -263,6 +263,13 @@ eth_dev_fp_ops_reset(struct rte_eth_fp_ops *fpo)
>         *fpo = (struct rte_eth_fp_ops) {
>                 .rx_pkt_burst = dummy_eth_rx_burst,
>                 .tx_pkt_burst = dummy_eth_tx_burst,
> +               .tx_pkt_prepare = rte_eth_tx_pkt_prepare_dummy,
> +               .rx_queue_count = rte_eth_queue_count_dummy,
> +               .tx_queue_count = rte_eth_queue_count_dummy,
> +               .rx_descriptor_status = rte_eth_descriptor_status_dummy,
> +               .tx_descriptor_status = rte_eth_descriptor_status_dummy,
> +               .recycle_tx_mbufs_reuse = rte_eth_recycle_tx_mbufs_reuse_dummy,
> +               .recycle_rx_descriptors_refill = rte_eth_recycle_rx_descriptors_refill_dummy,
>                 .rxq = {
>                         .data = (void **)&dummy_queues_array[port_id],
>                         .clbk = dummy_data,

Could we replace eth_dev_set_dummy_fops() with a call to
eth_dev_fp_ops_reset() in rte_eth_dev_allocate?
I don't like keeping two separate helpers.


-- 
David Marchand

