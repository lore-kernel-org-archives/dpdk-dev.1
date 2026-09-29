Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73BFFCA5FA1
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 08:06:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BF4FE40E68;
	Tue, 29 Sep 2026 10:06:52 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id B82DE4013F
 for <dev@dpdk.org>; Tue, 29 Sep 2026 10:06:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790669210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2XrZUN6oPU1QjDBRaw1bD+WAhcIu2OdAxQo46CuWmyE=;
 b=J12S1f+YOWmRtZ9uV9ywXWYjV53XUNe3QLoJ40LMiF9+hj6T3PRp5cItoe9sgYUljseXTH
 VwjktPeiSa4nbBHQwY10KUZr9JNjUS92VuidonJukH2BnnqAuAJYNzTBd73hcfjMjhNXKY
 76s9hIbOVOx+KrvVTNF7NXH/PulNSRE=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-bCj3DENHPAGuGtcqQ8Cu_A-1; Tue, 29 Sep 2026 04:06:48 -0400
X-MC-Unique: bCj3DENHPAGuGtcqQ8Cu_A-1
X-Mimecast-MFC-AGG-ID: bCj3DENHPAGuGtcqQ8Cu_A_1790669207
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-3a59db0a722so17611411fa.0
 for <dev@dpdk.org>; Tue, 29 Sep 2026 01:06:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790669207; x=1791274007;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=2XrZUN6oPU1QjDBRaw1bD+WAhcIu2OdAxQo46CuWmyE=;
 b=SvFlD6P4HPaEGShgVCQ7Gt81SWNK4YyP8usvl8waua3AoakCwMckFFiqdRPJsxwjTG
 OWk0bfNw4UOd3jIaG684qr3xW0YBsZBigV2vxnpsPNFSBrDipF5lwo/Omf3920sCO8mT
 ZRjXdnrv817YpIGOCUKzlM7ZI38swqRv3IekxOYGEmlRATaqPSQasMybIRwmqWSZUI9h
 CwfrfD6FZXYzjPXxh4N5pGHSMc7YKOEp2b6z+SAyiD7xV06BGdc8Vm4/Y8R5jL5a6CgB
 JwTuK7hsPZJvhmZl4/2RScyYQgxE5CHmos5W83YnTKZo0R5Uaem64cvEqL1643zz6AmJ
 ifvw==
X-Gm-Message-State: AFq9FYIZk4/gnN0qdhF8BsRTWeazsQOZN1gwBvoqcC/6hHy6TuDG/pnP
 4Jp60OXc1T8aaqTv7gFlTQ//bEHbWhIe5Nz7KAj09lj/7HmvD863Cu4JxN7IcacN0hrSV3Ikd3S
 jDuXN+kVI02mPbJQ6N63A3WYHcHNkNvH3/Vw18Z1a8LjypZF67DyvTaa4xX7y7Cjr5Ti3uwEIxS
 AmzTnwTEe7l0WEeVwzZgUuYO7YyO0=
X-Gm-Gg: AYBFou2IUxkyRPnTOFNFc8coF3Yj8cItW+bAZydi+NHGIOJFB2MK2BQ9mfzV/5Sg4wa
 a5ftkCz6f+GOShNotkubo/hi2GZ4etYq61qlcaXsCemEft78kxzN1g5XsKyFPilNoBhQ2Mk0pcY
 QLcVIsRG86VPgx+QJN5Y+J07L+BoSNleV+ehMTIuufcXAY2solevT5Gl9rq3KYu+cCq7WekgdX7
 NH8Tsc8vvxQAhl22kDMjym4N08tvcmAg1yBQv8p1faKF1mm
X-Received: by 2002:a05:651c:b23:b0:3a5:e027:1b49 with SMTP id
 38308e7fff4ca-3a64c71fe9bmr29035691fa.2.1790669207040; 
 Tue, 29 Sep 2026 01:06:47 -0700 (PDT)
X-Received: by 2002:a05:651c:b23:b0:3a5:e027:1b49 with SMTP id
 38308e7fff4ca-3a64c71fe9bmr29035601fa.2.1790669206528; Tue, 29 Sep 2026
 01:06:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260917201119.2168234-1-stephen@networkplumber.org>
 <20260917201119.2168234-6-stephen@networkplumber.org>
In-Reply-To: <20260917201119.2168234-6-stephen@networkplumber.org>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 29 Sep 2026 10:06:33 +0200
X-Gm-Features: AclHuK-oNE5Dj1_YuAbhd3tv8zXy-uo_YTqIBQPBzVSc2jLvpw6qZdB35MNeOHA
Message-ID: <CAJFAV8yVHjfNzah3rcpcrd+_-LJHDrR9FfZ4H+x_XdTLjDVjpw@mail.gmail.com>
Subject: Re: [PATCH v8 05/25] net/failsafe: convert to stdatomic
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Gaetan Rivet <grive@u256.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YL7njRCBAYGg0WmDA9LD0751-tD6lJymZG85s6Y2OOs_1790669207
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

On Thu, 17 Sept 2026 at 22:12, Stephen Hemminger
<stephen@networkplumber.org> wrote:
> @@ -440,14 +440,13 @@ fs_rx_queue_setup(struct rte_eth_dev *dev,
>         }
>         rxq = rte_zmalloc(NULL,
>                           sizeof(*rxq) +
> -                         sizeof(rte_atomic64_t) * PRIV(dev)->subs_tail,
> +                         sizeof(*rxq->refcnt) * PRIV(dev)->subs_tail,
>                           RTE_CACHE_LINE_SIZE);
>         if (rxq == NULL) {
>                 fs_unlock(dev, 0);
>                 return -ENOMEM;
>         }
> -       FOREACH_SUBDEV(sdev, i, dev)
> -               rte_atomic64_init(&rxq->refcnt[i]);
> +
>         rxq->qid = rx_queue_id;
>         rxq->socket_id = socket_id;
>         rxq->info.mp = mb_pool;
> @@ -617,14 +616,13 @@ fs_tx_queue_setup(struct rte_eth_dev *dev,
>         }
>         txq = rte_zmalloc("ethdev TX queue",
>                           sizeof(*txq) +
> -                         sizeof(rte_atomic64_t) * PRIV(dev)->subs_tail,
> +                         sizeof(uint64_t) * PRIV(dev)->subs_tail,

sizeof(*txq->refcnt) for consistency.


>                           RTE_CACHE_LINE_SIZE);
>         if (txq == NULL) {
>                 fs_unlock(dev, 0);
>                 return -ENOMEM;
>         }
> -       FOREACH_SUBDEV(sdev, i, dev)
> -               rte_atomic64_init(&txq->refcnt[i]);
> +
>         txq->qid = tx_queue_id;
>         txq->socket_id = socket_id;
>         txq->info.conf = *tx_conf;


-- 
David Marchand

