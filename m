Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C0BC43458
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Jul 2026 16:03:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C7464026F;
	Fri,  3 Jul 2026 18:03:56 +0200 (CEST)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43]) by mails.dpdk.org (Postfix) with ESMTP id A54004026A
 for <dev@dpdk.org>; Fri,  3 Jul 2026 18:03:54 +0200 (CEST)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-3804e42ad5fso794587a91.2
 for <dev@dpdk.org>; Fri, 03 Jul 2026 09:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1783094628;
 x=1783699428; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6R10nls4JJ2Q0KuxpbOXtwOFkbKtQK0iDgSIJSxnMFU=;
 b=CN9wSXTXeqjTTQMf22fAJ1H8RgX2wJZizR94Uk+Td/HDxtWXMqwKXQp0rw6NHtECC4
 BfyAohcz7Krrh02d6KiB4cSr9U/ijAoNxStsC5Q7KniMOSp4hS3aSW/CPY0NxUIMB1n+
 KDM8w5aypncqobrDIgLYEvirqAm5gjc9mUJDYeoywZR35/8Nmt3jBVkxQjKfKT6fOjTJ
 aUHSlJJgL8rw7254y6sblU2Kfb8B0dZEfquZsNTVyoQ/sSoHVwhGeYjWmzYukOpFCFs5
 OrdkerRg80uv9Ac+tiFQaBGaw3gsnD3x9ppsO3Td7rjaiW5kj2KRUXkaCdw28qvTcaPn
 27zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783094628; x=1783699428;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6R10nls4JJ2Q0KuxpbOXtwOFkbKtQK0iDgSIJSxnMFU=;
 b=tBgUEkn9O6x3TFHwWoh7gX+jFZPsnUUrPKh/udw0wwXJnV/9lsxQKXLMNGKQWxA99+
 8rGLuvVPfnhbEwQttsX0khY9Gaxg34aGB8jxGkUPUsiaHMnfgJqJ2zbttF7C3eT55iZk
 ZVZvDtuk0pgL/tIljGfOQxt/wHlqWCGv0BOhhk6hs2iNKKC6+IIj6xw2I0b9kEGGUnhJ
 9ey6h3SZwS3joltIhOafc5F72OGsttdzWi/nWWD/u3q30R7o/bhMwqjnfPzMXain5txD
 v5grL/qnk4R4FpFcIgfgbck2TSIxAN79o07gYfg9asF7xCnxPZwU6G746juIfFIE+Ly6
 +nkQ==
X-Gm-Message-State: AOJu0YyOw7xt05F0AtwcqY9wRYwSk12lhT8vF3LdAdTBQWrfN280e3j4
 7CKpKGQKr0xbefzne9PKcTuGmAu5FxPRjvnaAwiv8We9K3f7lVqsNesW4iygT9Q5nsc=
X-Gm-Gg: AfdE7cm5Cl/hB2sb6ytDc9gHM1InPHDJqA2/BxqJIjii36sHe4+w0od29jFKLEgPZZr
 T1fKkGyjCKnl4E2Vj8lB3Y10RNbJiAT1X7722WC146W4dngJfnw2xzsFf8E/9weTNQFZyU/5zHa
 i61HEJtRZr16MeIwmVUW/PsN3ZI17W4pN5Sm4FEORc12Q10wemcgfozMfjK3k1PKbauHPBWHQZK
 qvtAAxIlujMxEOvKTVo33aR93hLoOXQuzWgbMwYjDS9uas82nSMkWYMfpSAdEIVq93GFDHPmOOj
 BqnbxfIV1rFoLt6BfvMbfSTyjyOmJAuLS2CpVtomlmpHyNDif+uskOLkO9Z9Gsj43lWtiMLBlvf
 emPmrqvST1tXF/dcPfJUDS/9a7x1IERASsd57m4gg3hnVPPQar6cWhOFMdeUtGt0Z+Ifg2lTF3u
 32k5E0E6fuyFbw8/rRYPNp7AEiSD+kyw6j0aVxU6x7E+UDfWQBCPHEgr9dTmut1RjE
X-Received: by 2002:a17:90b:17c1:b0:366:52fe:e749 with SMTP id
 98e67ed59e1d1-382802beab6mr159347a91.5.1783094628560; 
 Fri, 03 Jul 2026 09:03:48 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f0bc2e119sm21322403eec.28.2026.07.03.09.03.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 09:03:47 -0700 (PDT)
Date: Fri, 3 Jul 2026 09:03:45 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Maxime Leroy <maxime@leroys.fr>
Cc: dev@dpdk.org, hemant.agrawal@nxp.com, sachin.saxena@nxp.com,
 david.marchand@redhat.com
Subject: Re: [PATCH v3 0/6] net/dpaa2: NAPI-style Rx queue interrupts
Message-ID: <20260703090345.3e4099cd@phoenix.local>
In-Reply-To: <20260630144329.457643-1-maxime@leroys.fr>
References: <20260616102727.708948-1-maxime@leroys.fr>
 <20260630144329.457643-1-maxime@leroys.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Tue, 30 Jun 2026 16:43:23 +0200
Maxime Leroy <maxime@leroys.fr> wrote:

> This series lets a dpaa2 worker sleep on a queue's data-availability
> notification instead of busy-polling, exposed through the generic
> rte_eth_dev_rx_intr_* API (NAPI-style: poll while frames keep coming,
> arm the interrupt and sleep when the queue runs dry).
> 
> Why it is not a trivial .rx_queue_intr_enable
> ----------------------------------------------
> A worker wakes on its software portal's DQRI, which fires when the
> portal's DQRR holds frames. The default dpaa2 Rx burst pulls frames
> from the FQ with a volatile dequeue and cannot be interrupt-driven; to
> wake on the DQRI the FQ must instead be pushed to the portal's DQRR.
> 
> The natural dpni_set_queue with a notification destination would have to
> target the worker's portal, but that portal is only known once a worker
> affines, after dev_start, and that MC command holds the global MC lock
> long enough to wedge the firmware while traffic runs. So the bind cannot
> be done late, against the polling lcore.
> 
> Design
> ------
> Each Rx FQ is bound to its own DPCON channel, statically, at dev_start
> while the dpni is still disabled (no knowledge of the polling lcore). A
> worker later subscribes its own ethrx portal to the channel and arms the
> DQRI in rx_queue_intr_enable, a one-shot per-portal op, never the wedging
> set_queue. On a wakeup the worker drains each of its queues by a volatile
> dequeue on the queue's own DPCON channel (one FQ per channel, so no
> per-frame demux); it polls all its queues, the same scheduling contract
> as plain DPDK polling. A queue can be re-homed to another lcore at
> runtime with no set_queue and no port stop.
> 
> This reuses the event PMD's pushed/DQRR model but with one DPCON per FQ
> and static affinity (no QBMan scheduling), so the DPCON allocator is
> moved from the event driver to the fslmc bus and shared.
> 
> Patch 1 disables the DPCON channel before closing it, an event/dpaa2 fix
> the shared allocator depends on. Patches 2 to 4 move the DPCON allocator
> to the fslmc bus, make the portal DQRI epoll optional, and add the
> dpcon_set_notification MC command. Patch 5 adds the interrupt support
> proper; patch 6 pins each DPIO's MSI to the lcore that arms it, a latency
> optimisation.
> 
> Tested on LX2160A (lx2160acex7).
> 
> v3:
> - Reworked the Rx drain. Both versions bind one DPCON per FQ, but v2
>   drained the shared portal DQRR and demuxed frames to their FQ by
>   fqd_ctx, stashing foreign frames in a per-queue FIFO. v3 drains each
>   queue with a volatile dequeue on its own channel (one FQ per channel),
>   which drops the demux and stash code.
> - Dropped the rx_queue_count fix; it is applied to main.
> - Dropped the software VLAN strip patch; an independent net/dpaa2 cleanup,
>   sent standalone and now applied to next-net.
> - Dropped the Depends-on: the ethdev fast-path ops fix is now in main.
> - Split the dpcon_set_notification MC command into its own patch.
> - Added an event/dpaa2 fix to disable the DPCON channel before close,
>   needed once the allocator is shared.
> - Dropped the DQRI holdoff-tuning patch; the immediate-DQRI holdoff is now
>   set inline in the arm path.
> - Added a patch reusing the event driver's MSI-affinity helper (exposed
>   from its RTE_EVENT_DPAA2 guard) to pin the portal MSI to the lcore that
>   arms it, so a CDAN wake lands on the worker's own core.
> 
> v2:
> - Dropped the RSS RETA patch, an independent net/dpaa2 change the
>   interrupt path does not require; it will be sent as its own series.
> - Dropped the ethdev fast-path ops fix; it is now a standalone series.
> - Dropped the eal/interrupts -EEXIST fix, applied to main by David
>   Marchand.
> - Declared qbman_swp_interrupt_set_inhibit and qbman_swp_dqrr_size
>   __rte_internal (David Marchand).
> - Minor formatting cleanup in the Rx interrupt setup.
> 
> Maxime Leroy (6):
>   event/dpaa2: disable channel before closing it
>   bus/fslmc: move DPCON management from event driver to bus
>   bus/fslmc/dpio: make the portal DQRI epoll optional
>   bus/fslmc/mc: implement dpcon_set_notification
>   net/dpaa2: support Rx queue interrupts
>   net/dpaa2: pin Rx queue interrupt to the polling core
> 
>  doc/guides/nics/dpaa2.rst                     |  21 +
>  doc/guides/nics/features/dpaa2.ini            |   1 +
>  doc/guides/rel_notes/release_26_07.rst        |   1 +
>  drivers/bus/fslmc/mc/dpcon.c                  |  31 ++
>  drivers/bus/fslmc/mc/fsl_dpcon.h              |  18 +
>  drivers/bus/fslmc/meson.build                 |   1 +
>  .../fslmc/portal}/dpaa2_hw_dpcon.c            |  17 +-
>  drivers/bus/fslmc/portal/dpaa2_hw_dpio.c      | 112 ++++--
>  drivers/bus/fslmc/portal/dpaa2_hw_dpio.h      |  12 +
>  drivers/bus/fslmc/portal/dpaa2_hw_pvt.h       |  12 +
>  .../fslmc/qbman/include/fsl_qbman_portal.h    |   5 +
>  drivers/bus/fslmc/qbman/qbman_portal.c        |   5 +
>  drivers/event/dpaa2/dpaa2_eventdev.h          |   3 -
>  drivers/event/dpaa2/meson.build               |   1 -
>  drivers/net/dpaa2/dpaa2_ethdev.c              | 372 +++++++++++++++++-
>  drivers/net/dpaa2/dpaa2_ethdev.h              |   4 +
>  drivers/net/dpaa2/dpaa2_rxtx.c                | 104 +++--
>  17 files changed, 649 insertions(+), 71 deletions(-)
>  rename drivers/{event/dpaa2 => bus/fslmc/portal}/dpaa2_hw_dpcon.c (88%)
> 
> 
> base-commit: 030328f5f920a87dabde54dacd4f5ac411ddcac9

Looks good, applied to net-next
