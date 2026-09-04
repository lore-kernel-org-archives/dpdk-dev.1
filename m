Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3E7C624DE
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Sep 2026 09:30:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0744242E72;
	Fri,  4 Sep 2026 11:30:42 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 9805F42E63
 for <dev@dpdk.org>; Fri,  4 Sep 2026 11:30:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788514240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5TBmAC0AQbtkMT9q+BGsOWS+BstXfrm55ZQv9EQznHM=;
 b=a8LSfu/rJsoR2Lv09zbuBqi/9atD7YnZgDi08zk3dQtcthebLWN2GWmCFZ5nmg+OkOBbXn
 zu5X6P7J+vTZbqUuZ8/Bi5AvoHqt2MAGobuM8HuuyVxSa5HG/nJywyWNkqRcIklchCkfWK
 1NRsIIfth7yVJQF629tDptzCPyWuUlo=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-bmPARnS0OrqjA6KjOx2jcg-1; Fri, 04 Sep 2026 05:30:38 -0400
X-MC-Unique: bmPARnS0OrqjA6KjOx2jcg-1
X-Mimecast-MFC-AGG-ID: bmPARnS0OrqjA6KjOx2jcg_1788514237
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-3a23577c7e6so4869001fa.3
 for <dev@dpdk.org>; Fri, 04 Sep 2026 02:30:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788514237; x=1789119037;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=5TBmAC0AQbtkMT9q+BGsOWS+BstXfrm55ZQv9EQznHM=;
 b=ofsBH2y9lAEHqfzZq8GhGhcIs9BJUYTwIKGuT3FgFhHEsj8Le7Okxn47daQl9vFAhZ
 A0Qim5gIcmIfGKv4JyuTFYYlnOfQNw62Uwi48tU/BGZrVZk4WFhTSt392uN73rO7hZjw
 p+cS+VTMUHIGlK0IWu8IxVdBWsWSae272m4sym0m9miFEhnUDOcAROsF06l8H75YSl3/
 zRX3LDTrZK8EahzQ5x5JHPVuEaZtLs9rT92gB0Ty2oDfdPFyAdted5xsUB3REyEuwox3
 dJTgJNvYVuzBMxVvrecj1vzRPkrZe/QhXK2HF5Z7HETo0YM5kX6Bg4ptX6JcBbBaVpy3
 OTtw==
X-Gm-Message-State: AFuF++m1aEds0izlJO1ppr4h0OT2sBJRubYt2E14aXjseIYaia3mCLrz
 D6qlOpabQWzIbY+v09c6gB2iZlnrgH2KnIT+wlxHW7b5Q85J4GdUwZjuK5bavj6lQMpRLhnZLDq
 3HCgN3MFgRZrripRlcAKai0zItWOkRi6pkH0P0Uu7FliQE1UV4ZoPTSPjUkEp13rM7DFyW8E8kp
 avGt43x57fyN0R/NTs6YQ=
X-Gm-Gg: AYBFou2i3/pKIdrlCDIEcuC/NPNP+cM5fc5V5QfQVwU5PVPSr27X0o6jJNR0NIFLH2d
 WLSNQRIBfmxtdpbFGUdiodwaAqOvXGjnKyOBtZMqdWl3WZ1nyHfmTZH78J4Ikqzb7hbasmCOD6I
 gnCunLkoeYJM26mEWOJYOALR6w3iHRAmgR3ptkEzndOAulUo4UtMiDj5qEgbsFVmHNCZxR9rMrs
 ypNAlwDGTz0luVDgnC6jBeT/SbS091ymAulcZwKBDHrkFo2
X-Received: by 2002:a2e:a00d:0:b0:3a3:364:f789 with SMTP id
 38308e7fff4ca-3a371f6c2a0mr7915071fa.13.1788514237015; 
 Fri, 04 Sep 2026 02:30:37 -0700 (PDT)
X-Received: by 2002:a2e:a00d:0:b0:3a3:364:f789 with SMTP id
 38308e7fff4ca-3a371f6c2a0mr7914961fa.13.1788514236473; Fri, 04 Sep 2026
 02:30:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260720080035.673782-1-maxime@leroys.fr>
In-Reply-To: <20260720080035.673782-1-maxime@leroys.fr>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 4 Sep 2026 11:30:24 +0200
X-Gm-Features: AcwNN1X1PkQN82pORLzgGZneKHb13-MW25ov4N38iGrQc_nZDaZDh60MQxsq3So
Message-ID: <CAJFAV8xMCEhq4dzNjme_vkN3q0Xp81Psh7t0-uW2xmM8Qpk2tA@mail.gmail.com>
Subject: Re: [PATCH 0/6] examples/l3fwd-power: fix Rx interrupt mode for
 shared FD PMDs
To: Maxime Leroy <maxime@leroys.fr>, anatoly.burakov@intel.com,
 sivaprasad.tummala@amd.com
Cc: dev@dpdk.org, "Mcnamara, John" <john.mcnamara@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GJJ6mzJWlRMAWvhuQ4V9R83No-FYAZzms6ixygHJwY0_1788514237
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

On Mon, 20 Jul 2026 at 10:01, Maxime Leroy <maxime@leroys.fr> wrote:
>
> l3fwd-power's Rx interrupt (one-shot) mode was written around NICs whose
> interrupt fd is assigned per queue at setup, stays fixed and is
> level-triggered, as on MSI-X hardware. PMDs that do not fit that model
> never sleep on interrupts: they either fail to arm, watch an unbound fd,
> or miss the wake, and the 10 ms poll timeout hides all of it.
>
> dpaa2 is the motivating example: it delivers Rx interrupts through one
> QBMan portal per lcore, so the queues of a lcore share a single fd that
> is bound when the interrupt is enabled, not at queue setup; the
> notification is edge-triggered on an empty to non-empty transition; and
> arming a queue that already holds traffic returns -EAGAIN with the queue
> left unarmed.
>
> This series makes the interrupt and legacy loops handle those cases
> while leaving MSI-X NICs unchanged:
>
>   1/6 factor the duplicated arm/sleep/disarm block into a helper.
>   2/6 check the arm return: on -EAGAIN poll and retry, on any other
>       error drop interrupt mode for the lcore instead of sleeping on
>       unarmed queues.
>   3/6 register the fd in the epoll set after arming, not before, so a
>       fd bound at enable time is watched only once it exists.
>   4/6 accept -EEXIST when several queues share one fd.
>   5/6 recheck the queues before sleeping so a packet that arrived during
>       the arm window is not missed under edge-triggered interrupts.
>   6/6 block indefinitely instead of on a 10 ms timeout, and wake the
>       workers through an eventfd on exit, so a broken interrupt path no
>       longer hides behind periodic polling.
>
> Maxime Leroy (6):
>   examples/l3fwd-power: factor out Rx interrupt sleep path
>   examples/l3fwd-power: check Rx interrupt enable errors
>   examples/l3fwd-power: enable Rx interrupt before epoll add
>   examples/l3fwd-power: accept shared Rx interrupt FD
>   examples/l3fwd-power: recheck Rx queues before sleeping
>   examples/l3fwd-power: block until Rx interrupt or exit
>
>  examples/l3fwd-power/main.c | 184 +++++++++++++++++++++++++++++-------
>  1 file changed, 150 insertions(+), 34 deletions(-)

I had a quick look.
I am not a fan of changing applications because drivers behave
differently, but I think most of those changes are acceptable.

I sent one comment on the implementation of patch 3.
Patch 5 is a concern to me, as I don't think it solves anything, just
make the issue harder to reproduce maybe?

Anatoly, Sivaprasad, please review.


-- 
David Marchand

