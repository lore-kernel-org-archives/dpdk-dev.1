Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 969EEC55ABA
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 03:25:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6416A4027E;
	Thu,  6 Aug 2026 05:25:49 +0200 (CEST)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by mails.dpdk.org (Postfix) with ESMTP id 9CEB24003C
 for <dev@dpdk.org>; Thu,  6 Aug 2026 05:25:48 +0200 (CEST)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-c96c92c0980so1126068a12.3
 for <dev@dpdk.org>; Wed, 05 Aug 2026 20:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785986747;
 x=1786591547; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WY0A2VUWjU/uAAWxp1p9qdhEQBty4MRsIDFyilUGNzM=;
 b=F0SlOTDN8QuHX6qjP71BP7wa3KGinIcvOUvNFed1hM6FtYJNoEsEoZw47mQDhpelbI
 EbvGPOaDrJq77KYhOxljzvxfwt3ZNvc4QOfRYgqVhsieo4JWTJelgPqbXjVHSNuBhUAw
 RVwm1fkKcEcB79awwFh1CmxCqwr8TGf80k3w2aGP8HsItLnYAcZ/MwsM+7VjJMjzxqvz
 nRJhYFWKq+ICt06xPDEcmfv5D7vx6Loe6LngskBPscLVuubs1vLw6yF3G0O7t3A5scZZ
 15vg685ByhwkJqD12YjgC+FBosxVpt+t74HoULtfnTDzLwJxOIwJCWou+hykNH6tCZCd
 6bkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785986747; x=1786591547;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WY0A2VUWjU/uAAWxp1p9qdhEQBty4MRsIDFyilUGNzM=;
 b=mdZiVQ4Bo4FHQE8TlI4fkvVnBkoO+WmR3PNrGyJf+IZjmvKPfnSFAQn1NYy16Bsqba
 hI1fWqK3bQkDcn2mW4K06JApc4Jh+sOeNRCyeuxFOSZQLj7irLHZI+h3iCY70+3rT0gf
 eZuAvBQYERdkjwSqZEvudlu9/GjxkBtoCUZljUnaYVrjWHZDbgqrNp/uDjxs+NwMeUfo
 gUFcaZ7LR5tmZlsJWziiowOnYzuLCB178Vh8e3RwjtPkyCZrelZjjNGT0/hCRuaKUfWQ
 QaxMiQ9qkBS+Ezkqug9EZ6epBLpKwMJIm65WP9hwtTE2pg7/8+S6PYvrkVNynT/FKEmu
 8Uzg==
X-Gm-Message-State: AOJu0Yxpy5jgybxDA/rZ8nPUaeeqnFrsMguJfrK8v5/ThLEWqYOgfBf/
 pdPxUZCSh2pjFWH9S0O+OWm7crWXk0AuY6wGgdP8g+j45wrGcFwQWPNa2ftSmB6G7IdpMTB1bc0
 zfBfk
X-Gm-Gg: AR+sD12ReDIfchc+POmIWL6NzpjNLJ3sNhrlwx1ibG2mX7DmainlMsbGycO7Tx79ODR
 eHsPZLTRqdzj3YFB+oILZG9SRu08n17ydyId0l/bW75hhcRHbwhUiLLTZ62CLr6wrvZ6zAXDEE7
 v8Q+wbbDKYs/KhDPB+M06k6Sno7Jyuhwldye5Jq3QlpCCnrMDd+f2SA/4crO36ej0cMcKuovA2y
 Q4lkfTBVE1vkkJWVyAHwsQhah1sTf0p4C0uwnJWdjmVZa3pwBbwAZjuCdZD93M8tve6RugyUqOH
 reTILRKvAnxKlll59EOkF732MqCXx9CNjgO8UGguGznAgnhU+UZ9W5DJJkFBIYT5kU+4xg0fjsX
 2M9AnknJCRzC9Y7EwZkT+WBdwLbNHimIDkEVCLzbz7O1csb0Fr1isyLA9dwYs9OA8d+YFQJjkWK
 V9qIyEkqCiBOVeF76eVn/C8Fy2DEerh/bVg18ij7gK1kUbAJXfUoA5R64NwokZxO8rTisZtuKF/
 OtsxQHbVz/TA50q9evoTorXYBk=
X-Received: by 2002:a05:6a20:a125:b0:3c3:7ecd:72df with SMTP id
 adf61e73a8af0-3cb85f50866mr13294169637.30.1785986747271; 
 Wed, 05 Aug 2026 20:25:47 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315863b0c61sm23301631eec.6.2026.08.05.20.25.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 20:25:46 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v7 00/24] remove legacy atomic functions
Date: Wed,  5 Aug 2026 20:22:52 -0700
Message-ID: <20260806032544.21337-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260521042043.1590536-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
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

The rte_atomicNN_* family was flagged for deprecation in 2021 by
commit 3ec965b6de12 ("doc: update atomic operation deprecation")
but removal had stalled and usage contined to grow.

This series finishes converting every remaining in-tree caller to
the C11-style rte_atomic_*_explicit() / RTE_ATOMIC() API, then
removes the legacy functions. The deprecation has been out there
long enough so not a big surprise to users.

v7 - fix some review comments
   - remove unused macros
   - remove ret_atomicNN functions (rather than deprecating them).

v6 - rebase for 26.11
   - address some more AI review comments

Stephen Hemminger (24):
  bpf: use C11 atomics in BPF_ST_ATOMIC_REG
  net/bonding: use stdatomic
  net/nbl: remove unused rte_atomic16 field
  net/ena: replace use of rte_atomicNN
  net/failsafe: convert to stdatomic
  net/enic: do not use deprecated rte_atomic64
  net/pfe: use ethdev linkstatus helpers
  net/sfc: replace rte_atomic with stdatomic
  crypto/ccp: replace use of rte_atomic64 with stdatomic
  bus/dpaa: replace rte_atomic16 with stdatomic
  bus/fslmc: replace rte_atomic16 with stdatomic
  net/netvsc: replace rte_atomic32 with stdatomic
  event/sw: convert from rte_atomic32 to stdatomic
  bus/vmbus: convert from rte_atomic to stdatomic
  common/dpaax: remove unused atomic wrappers
  net/bnx2x: convert from rte_atomic32 to stdatomic
  bus/fslmc: replace rte_atomic32 with stdatomic
  drivers/event: replace rte_atomic32 in selftests
  net/hinic: replace rte_atomic32 with stdatomic
  net/txgbe: replace rte_atomic32 with stdatomic
  net/vhost: use stdatomic instead of rte_atomic32
  vdpa/ifc: replace rte_atomic32 with stdatomic
  test/atomic: drop old rte_atomicNN tests
  eal: remove rte_atomicNN functions

 app/test/test_atomic.c                        | 523 +---------
 devtools/checkpatches.sh                      |   8 -
 doc/guides/rel_notes/deprecation.rst          |   7 -
 doc/guides/rel_notes/release_26_11.rst        |   7 +
 drivers/bus/dpaa/base/qbman/qman.c            |   9 +-
 drivers/bus/fslmc/portal/dpaa2_hw_dpbp.c      |  11 +-
 drivers/bus/fslmc/portal/dpaa2_hw_dpci.c      |  11 +-
 drivers/bus/fslmc/portal/dpaa2_hw_dpcon.c     |  11 +-
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.c      |  14 +-
 drivers/bus/fslmc/portal/dpaa2_hw_pvt.h       |   9 +-
 drivers/bus/fslmc/qbman/include/compat.h      |  16 +-
 drivers/bus/vmbus/private.h                   |   2 +-
 drivers/bus/vmbus/vmbus_bufring.c             |  39 +-
 drivers/common/dpaax/compat.h                 |  14 -
 drivers/crypto/ccp/ccp_crypto.c               |  11 +-
 drivers/crypto/ccp/ccp_crypto.h               |   2 +-
 drivers/crypto/ccp/ccp_dev.c                  |  10 +-
 drivers/crypto/ccp/ccp_dev.h                  |   4 +-
 drivers/event/dpaa2/dpaa2_eventdev_selftest.c |  26 +-
 drivers/event/octeontx/ssovf_evdev_selftest.c |  61 +-
 drivers/event/sw/sw_evdev.c                   |   8 +-
 drivers/event/sw/sw_evdev.h                   |   4 +-
 drivers/event/sw/sw_evdev_worker.c            |  16 +-
 drivers/net/bnx2x/bnx2x.c                     |   6 +-
 drivers/net/bnx2x/bnx2x.h                     |   2 +-
 drivers/net/bnx2x/ecore_sp.c                  |   6 +-
 drivers/net/bonding/eth_bond_8023ad_private.h |   6 +-
 drivers/net/bonding/rte_eth_bond_8023ad.c     |  35 +-
 drivers/net/ena/base/ena_plat_dpdk.h          |  14 +-
 drivers/net/ena/ena_ethdev.c                  |  21 +-
 drivers/net/ena/ena_ethdev.h                  |   7 +-
 drivers/net/enic/enic.h                       |   6 +-
 drivers/net/enic/enic_compat.h                |   1 -
 drivers/net/enic/enic_main.c                  |  17 +-
 drivers/net/enic/enic_rxtx.c                  |  14 +-
 drivers/net/enic/enic_rxtx_vec_avx2.c         |   4 +-
 drivers/net/failsafe/failsafe_ops.c           |  12 +-
 drivers/net/failsafe/failsafe_private.h       |  29 +-
 drivers/net/failsafe/failsafe_rxtx.c          |   2 +-
 drivers/net/hinic/base/hinic_compat.h         |   2 +-
 drivers/net/hinic/base/hinic_pmd_hwdev.c      |  24 +-
 drivers/net/hinic/base/hinic_pmd_hwdev.h      |   4 +-
 drivers/net/nbl/nbl_hw/nbl_resource.h         |   1 -
 drivers/net/netvsc/hn_rndis.c                 |  28 +-
 drivers/net/netvsc/hn_rxtx.c                  |  12 +-
 drivers/net/netvsc/hn_var.h                   |   6 +-
 drivers/net/pfe/pfe_ethdev.c                  |  32 +-
 drivers/net/sfc/sfc.c                         |   9 +-
 drivers/net/sfc/sfc.h                         |   4 +-
 drivers/net/sfc/sfc_port.c                    |   7 +-
 drivers/net/sfc/sfc_stats.h                   |   2 +-
 drivers/net/txgbe/base/txgbe_mng.c            |   4 +-
 drivers/net/txgbe/base/txgbe_type.h           |   2 +-
 drivers/net/vhost/rte_eth_vhost.c             |  92 +-
 drivers/vdpa/ifc/ifcvf_vdpa.c                 |  37 +-
 lib/bpf/bpf_exec.c                            |  13 +-
 lib/eal/arm/include/rte_atomic_32.h           |   4 -
 lib/eal/arm/include/rte_atomic_64.h           |   4 -
 lib/eal/include/generic/rte_atomic.h          | 928 ------------------
 lib/eal/loongarch/include/rte_atomic.h        |   4 -
 lib/eal/ppc/include/rte_atomic.h              | 175 ----
 lib/eal/riscv/include/rte_atomic.h            |   4 -
 lib/eal/x86/include/meson.build               |   1 -
 lib/eal/x86/include/rte_atomic.h              | 187 +---
 lib/eal/x86/include/rte_atomic_32.h           | 212 ----
 lib/eal/x86/include/rte_atomic_64.h           | 157 ---
 66 files changed, 416 insertions(+), 2544 deletions(-)
 delete mode 100644 lib/eal/x86/include/rte_atomic_32.h

-- 
2.53.0

