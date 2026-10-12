Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B08FDCA9ED0
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Oct 2026 11:05:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4EB2B40274;
	Mon, 12 Oct 2026 13:05:33 +0200 (CEST)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
 by mails.dpdk.org (Postfix) with ESMTP id 8E96840041
 for <dev@dpdk.org>; Mon, 12 Oct 2026 13:05:29 +0200 (CEST)
X-QQ-mid: zesmtpsz4t1791803125tf1af3288
X-QQ-Originating-IP: f6XWuhqdtWbq2aXnWDKYeqHcGH+H7576tZ8m3DDKgis=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.198.217.6])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 12 Oct 2026 19:05:21 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8227700296351571134
EX-QQ-RecipientCnt: 2
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>
Subject: [PATCH v8 00/16] Wangxun fixes and new features
Date: Mon, 12 Oct 2026 18:56:17 +0800
Message-ID: <AD092E591B8D145D+20261012110518.1911-1-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OblxaHnXes79UlilagwtckSZk6sYD37jj9sx6HRt2zB0EbeeF2su27e7
 zx/R5P22VJk/7gmf/Kits+UbWRW/qEm/wpjaIfL00wkrw4Rkd2Xemp45ab+4GH629vU6RV8
 dG54qf/byhUcq4ZZAw/MLMYhiY/JtjRP3Lr7ojjXlQ1fhR6M17joVjA/gJhAX7BgMHKci0C
 5yrc0awR8vZ7ALS2FyZSv3/K1HEreKbOkNW44NTDEFFCZeZFpbb75tL1RVTSgKUQo4vCB8w
 ZdJt1QsRWKWLRFe1yKpL6cvNGER0+m0HmYYnEj51FbSSsU2HDKhoDuamogLLrBt4/ICL0u0
 5fGZ1vHjn16bkc1jKpJGLPElIKzSYxwWoYFZmDSqZkSMF3RdjIZuAjtQjl/uTi29f6kYVoE
 iTMcKGkw9hvfgMWvxYxm3aO4MEPOpWykTubneFI/IduHIq2/kPRynFNkvzsSXklsLsbJVNx
 DnStLbE8ei2VW7y7QNK+nBqIUReQVPsts/LzyjTyXduAii2DjYkIzXF6nd/FfCSu1tzX9df
 2RxC5FiT2zmrP0gKXgSWVitqWVgZhwWsZ/sewywi9DreCh4jlpb2QndIxrYEBYENyhgg3of
 cjLlGEWHvCVgWWCzcRwMw+y8fEC7MIPEue9rPPOAmTwxYNnVXtTZjPTYUw0nk/5Tfs4Bwnm
 NYiUN3MG5HNV7Xo9OzFUkY2qRb0fAjqmaOkrrFXuYwmetNKI/MY0VATDtnlTaHRhw2MLVj1
 7+15YVZbAJI8PKAncZ6NpREILj/z4ioibKAiM+tQRUPDcmUikl9fjEb6m7a/Gv7NqUNpfyA
 898TbENSUgwgGdezcijgBjgZxsjUrJ7O+iswZRC+yq4ZeldeMbIImTETF6dtrvQUnyBck/3
 vftKiYzY6LDKfCGPzWlQ8P11EYNVB8ZtgMelNQakahIvA49tCj6IUKi3bsMukKIM789ESYN
 tc2R6jsiaVhn8IkhC9oLb6t4DLsQoKsQJiU1lP+/M4UWBw3PPgu6XFcoQKL8NNM5cK0cCOy
 o2iJGvRjG6rKeYCP9AYZTSGBg+GVTLuX3XMs+89Q==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0
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

This series addresses link-related issues on Wangxun Amber-lite 25G/40G NICs (CR/KR training, hot-plug, 10G link state).

---
v8:
 - P05: keep a retry from reconfiguring an established AN73 link, while
        still restarting PHY configuration when the link is down or AN is
        incomplete.
 - P10: on AML40, mark unsupported and unclassifiable QSFP modules as
        unknown so the module poll does not repeatedly identify them or
        rerun module and link setup.
 - P12: place the txgbe release-note entries between the Solarflare and
        ZTE driver entries.
 - P13: rerun complete AML40 link setup on set_link_up() with laser_off
        enabled, restoring the DAC configuration without adding a separate
        state flag.
 - P14: correct the AN FSM condition described in the commit message
        and remove the stray line after the Signed-off-by trailer.
 - P15: assign the detected 10G speed for passive and active-limiting
        DACs, and remove the unreachable AML40 10G SFP capability branch.
 - P16: add a new patch to keep Amber-Lite ports administratively down
        by preventing the AN73 watchdog and setup-link retry paths from
        configuring PHY while hw->dev_start is cleared.
---
v7:
 - P14: fix a TRAINING log-string typo.
        move the variable declarations in txgbe_e56_get_txffe().
        clarify the comment of page-exchange timeout budget.
---
v6:
  - fix the apply failure.
---
v5:
 - drop the UDP tunnel patch: the generic UDP tunnel flag covers any UDP
   tunnel, so the tunnel type cannot be resolved from the destination port.
 - P02: advertise 10G, 25G, and 40G from the requested speed mask instead
        of the device ID, so the 25G and 40G parts advertise 10G by
        default as well.
 - P07: keep the patch limited to decoding the 10G link speed from PORTSTAT;
        the AML40 default 10G|40G advertisement change is now in P02.
 - P09: gate the SFP detection alarm and the AN73 watchdog on a new per-port
        flag that dev_stop clears before the first cancel.
        cancel SFP detection before the watchdog.
 - P10: re-arm the 40G module poll only while the SFP/AN73 alarm flag is set.
 - P12: treat the ffe_pre2 and bp_capa devargs as a feature rather than a fix;
        drop the Fixes tags and stable Cc, and document the 25G/40G Amber-Lite
        FFE defaults.
 - P14: bound the AN page exchange, propagate its timeout to the watchdog
        handler, and avoid register reads used only by disabled BP debug logs.
 - P15: stop clearing the auto_neg devarg when a 10G-only DAC disables AN;
        derive the effective AN73 state from the current module capabilities
        instead. Classify 40G active cables through the optical path, unify
        DAC checks on txgbe_is_dac_cable().
---
Not handled in this revision:
 - P10: On AML40, the poll caches unsupported or unclassifiable modules
        as unknown. A module replacement between polls without an observed
        absent level therefore cannot be detected, including replacement of
        an unsupported module by a supported one. An observed removal resets
        the cached state and allows the next inserted module to be identified.
 - P12: bp_capa and the other devargs are not range-checked yet. Input
        validation for all txgbe devargs will be added in a separate change.
 - P14: AN page exchange and CL72 training still run in the shared alarm
        callback. A later change will move negotiation out of that callback
        so that different ports can negotiate independently in parallel.
---

Zaiyu Wang (16):
  net/txgbe: fix failure to configure 10G on dual-speed DAC
  net/txgbe: use the requested speed in E56 AN setup
  net/txgbe: fix e56 PHY configuration error
  net/txgbe: fix incorrect link state in 10G forced mode
  net/txgbe: do not force reconfig on link retry
  net/txgbe: set i2c sda hold time
  net/txgbe: fix link speed display info for 10G mode
  net/txgbe: remove stale outer UDP checksum offload flag
  net/txgbe: fix SFP hot-plug when auto-negotiation is on
  net/txgbe: fix DAC hot-plug on 40G NIC with auto-negotiation
  net/txgbe: fix 40G FFE tuning applied to first lane only
  net/txgbe: add pre2 FFE tap and backplane capability devargs
  net/txgbe: add devarg to turn off Tx laser for 40G NIC
  net/txgbe: fix CR/KR link training and recovery
  net/txgbe: align link capabilities and DAC classification
  net/txgbe: respect manual link-down on Amber-Lite

 doc/guides/nics/txgbe.rst              |  25 +++-
 doc/guides/rel_notes/release_26_11.rst |  11 ++
 drivers/net/txgbe/base/txgbe_aml.c     |   9 +-
 drivers/net/txgbe/base/txgbe_aml40.c   |  83 ++++++++--
 drivers/net/txgbe/base/txgbe_e56.c     |  14 +-
 drivers/net/txgbe/base/txgbe_e56.h     |   6 +
 drivers/net/txgbe/base/txgbe_e56_bp.c  | 196 ++++++++++++++----------
 drivers/net/txgbe/base/txgbe_e56_bp.h  |   4 +-
 drivers/net/txgbe/base/txgbe_hw.c      |  33 ++++
 drivers/net/txgbe/base/txgbe_osdep.h   |  12 +-
 drivers/net/txgbe/base/txgbe_phy.c     |  38 ++++-
 drivers/net/txgbe/base/txgbe_phy.h     |   7 +
 drivers/net/txgbe/base/txgbe_regs.h    |   3 +
 drivers/net/txgbe/base/txgbe_type.h    |  17 ++-
 drivers/net/txgbe/txgbe_ethdev.c       | 200 +++++++++++++++++++++++--
 drivers/net/txgbe/txgbe_ethdev.h       |   2 +
 drivers/net/txgbe/txgbe_rxtx.c         |   1 -
 17 files changed, 529 insertions(+), 132 deletions(-)

-- 
2.55.0.windows.2

