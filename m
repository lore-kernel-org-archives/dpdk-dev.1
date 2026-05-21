Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D06ACD4F3D
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 May 2026 04:20:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 43AB64028D;
	Thu, 21 May 2026 06:20:48 +0200 (CEST)
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177]) by mails.dpdk.org (Postfix) with ESMTP id 41A8C4028D
 for <dev@dpdk.org>; Thu, 21 May 2026 06:20:47 +0200 (CEST)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-303f2fb7225so3908240eec.1
 for <dev@dpdk.org>; Wed, 20 May 2026 21:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779337246;
 x=1779942046; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WZLF2IbqPN6BYlJzROfUGNukh2E2KMc881DCiFHYp0E=;
 b=o8ow37m4idIydQF50Q7zPQlJtXKU21PeZcuR1OFBg3NAOgT3mWwuDiRjWA6taIV/yW
 DWAlTqQBGXMKNzHIviBdRxg5mk7/LPs68TZdewMTVJUZny6Lv3NJ3biUJHyl4pJbbcau
 t/Ahh6hl0N7Dgh3ZGmLyLpFsttLhwFiLu4WNl+rycX4KEeUAdO6cJoVv/bHqPbg2+SC5
 JVJzTfYeXBD5y7acSHEdNCBdTbkMZa6xbbVuolNnYpoVdBwg4vbi8anQ6o+2da/pkizz
 /zE1qDgb28tk1MFmIMm7KyEeANxtPxXKvFvRAAmBs61Lb7H3kxtzNP7WP/9eTAQEfrJx
 HWMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779337246; x=1779942046;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WZLF2IbqPN6BYlJzROfUGNukh2E2KMc881DCiFHYp0E=;
 b=kdZwic7gFTddCyK0g3w4EpHhrpQbblbMmnNyJIEmKsryMRmoTHp8/KTvoTMJjQLqN0
 orLsLIGFMcrE4L8KaG/xEgvJrbcvAm/BjqqHBng3YKyrvwLRclisGtaCeywe8v+KaUXh
 8C/J/bnoLlQa1cypApbsjjPKpkopiWP4/D8jrPIGG7Sgxg/saEKpeHyKfL5Vtrth2R0n
 yDLCSuCS3men6zMf3+nNaDatKMSGeOqt8N7c4Y7NBrx+2cPiZPvMLitATP7ZcSjDUB6C
 w/LLCC+rRgXTliaqQFy2TSgv8YPsH301LAa7jwXUOppb9S0n9VvTShuo1XYQNTBFqPCY
 nkNw==
X-Gm-Message-State: AOJu0YxdYFcfNDlACJmiRwxgJJt3usZWJgKcoGJ86NfNJRdpwHFfGJGa
 RczltUNszRG62D+I99SrZniojMOWa3L6Tl/nzNajGi6liTpAppOlQkYkzs+KfhA0b1eeBVJYRig
 jEHnY
X-Gm-Gg: Acq92OEdQncjL4vWa9wBxUQyDRVdjpiYuqKGkRRwzmxD49vwWypUl13eQNwmmXAZky/
 Kua01KuHEOd7exbVAIdFaAheLbxVvpf6osUpGmb6WwsPMsfNaPK4LNvT5pAVggXvLAetKtVz9EU
 HCFzPan1MArKrezdtiG+darmkTx0gEirWYviWRqODSyu5vs557XxCieYdEV2zeaY5Us62JkA8cx
 T63t7ClZ2XudYaJCgUgzHvTQPVe+29eQu2AuQaKv7dBchLQ09ktz2L1GGotf9c0gTkIAGl62Th5
 pGCYFBijvP7wC/R4CR1172C5WXXrdcVtGeNknQpchgat4oVUyNhJ9tOGx7ALUj8LpaBLzgT+Wco
 oysKR6AxGR8W9nCo0zG74xcTIGwBrBqsF4IyyeN7+Enb62CZqizVj0sazbScpJUiphkNwVP2U31
 wauxqs5tAl0vxZROwbx0WjR5H8bDh2Os6XGHkQK3ah7Of5uD2U1p4hUbSnmRSPC6hejy3Og2dH
X-Received: by 2002:a05:693c:8312:b0:2ed:935:aa33 with SMTP id
 5a478bee46e88-3042f4770d7mr476989eec.5.1779337245972; 
 Wed, 20 May 2026 21:20:45 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30293e2e686sm24347748eec.5.2026.05.20.21.20.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 21:20:45 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC 0/7] prepare deprecation of rte_atomicNN_*() family
Date: Wed, 20 May 2026 21:17:00 -0700
Message-ID: <20260521042043.1590536-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The goal is to land every deprecation currently listed in the release
notes by the 26.11 ABI bump. Working back from there: any function to
be removed in 26.11 needs to be marked __rte_deprecated by 26.07, and
all in-tree users converted off it before the marker patch goes in so
CI stays clean.

This series is the preparatory work for the rte_atomicNN_*() family
under that plan. It does not yet add the __rte_deprecated marker;
that's a separate follow-up once the remaining in-tree users are
converted. Other items on the deprecation list (VXLAN_GPE,
pipeline/table/port legacy API, the MAX enum fix, regexdev, pdump,
TM locks) will follow as their own series on the same timeline.

Patch 3 is the load-bearing change: the last lib/ caller of
rte_atomic32_cmpset() is converted, clearing the way.

Patch 7 drops RTE_FORCE_INTRINSICS entirely. With the option always on,
the asm implementations of atomics, spinlock and byteorder become dead
code. ~900 lines deleted; the patch most worth review attention.
This makes it easier to flag the rte_atomicNN as deprecated
since they are all in one place.

Patch 2 retires the rte_smp_*mb deprecation notice (open since 2021)
by reimplementing those APIs as wrappers over rte_atomic_thread_fence,
preserving the API for readability. Patches 5 and 6 convert and clean
up two driver users (bonding, nbl).

Patch 4 is a preparatory workaround for a pre-existing GCC bitfield
-Wmaybe-uninitialized false positive in net/zxdh, surfaced by the
improved compiler visibility after patch 7. Placed ahead of patch 7
to keep every commit bisectable.

Follow on patches will mechanically convert drivers.
If driver writer fixes it themselves; all the beter.

Stephen Hemminger (7):
  doc: update versions in deprecation file
  eal: reimplement rte_smp_*mb with rte_atomic_thread_fence
  ring: use C11 atomic operations for MP/SP head/tail
  net/zxdh: work around GCC bitfield uninit false positive
  net/bonding: use stdatomic
  net/nbl: remove unused rte_atomic16 field
  config: use RTE_FORCE_INTRINSICS on all platforms

 config/arm/meson.build                        |   1 -
 config/loongarch/meson.build                  |   1 -
 config/meson.build                            |   3 -
 config/riscv/meson.build                      |   1 -
 doc/guides/rel_notes/deprecation.rst          |  12 +-
 doc/guides/rel_notes/release_26_07.rst        |   5 +
 drivers/net/bonding/eth_bond_8023ad_private.h |   4 +-
 drivers/net/bonding/rte_eth_bond_8023ad.c     |  18 +-
 drivers/net/nbl/nbl_hw/nbl_resource.h         |   1 -
 drivers/net/zxdh/zxdh_msg.c                   |   4 +-
 lib/eal/arm/include/rte_atomic_32.h           |   9 -
 lib/eal/arm/include/rte_atomic_64.h           |   9 -
 lib/eal/arm/include/rte_byteorder.h           |   3 -
 lib/eal/arm/include/rte_spinlock.h            |   3 -
 lib/eal/include/generic/rte_atomic.h          | 164 ++++----------
 lib/eal/include/generic/rte_byteorder.h       |   2 -
 lib/eal/include/generic/rte_spinlock.h        |  10 -
 lib/eal/loongarch/include/rte_atomic.h        |   9 -
 lib/eal/loongarch/include/rte_spinlock.h      |   3 -
 lib/eal/ppc/include/rte_atomic.h              | 179 ---------------
 lib/eal/ppc/include/rte_byteorder.h           |  13 --
 lib/eal/ppc/include/rte_spinlock.h            |  26 ---
 lib/eal/riscv/include/rte_atomic.h            |   9 -
 lib/eal/riscv/include/rte_spinlock.h          |   3 -
 lib/eal/x86/include/rte_atomic.h              | 205 +-----------------
 lib/eal/x86/include/rte_atomic_32.h           | 188 ----------------
 lib/eal/x86/include/rte_atomic_64.h           | 157 --------------
 lib/eal/x86/include/rte_byteorder.h           |  49 -----
 lib/eal/x86/include/rte_spinlock.h            |  49 -----
 lib/ring/rte_ring_generic_pvt.h               |  64 ++++--
 30 files changed, 118 insertions(+), 1086 deletions(-)

-- 
2.53.0

