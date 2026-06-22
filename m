Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1AFFCDB46F
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Jun 2026 15:44:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C7BAF40150;
	Mon, 22 Jun 2026 17:44:21 +0200 (CEST)
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
 by mails.dpdk.org (Postfix) with ESMTP id 37CF940144
 for <dev@dpdk.org>; Mon, 22 Jun 2026 17:44:20 +0200 (CEST)
Received: by mail-dl1-f44.google.com with SMTP id
 a92af1059eb24-1397e093f90so815585c88.1
 for <dev@dpdk.org>; Mon, 22 Jun 2026 08:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782143059;
 x=1782747859; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TxHw9FNXhs3WjoVuXdujkdpT0WKll9+MxvhTqcMgeeQ=;
 b=mLBRTuMVmW3xPcQtBBM72QShrcHVnBYJYG4gR+f+NVUv+fCJYdOVILc8AtgsiXwueb
 Ks0w9Q3WREBXn7X/qGsM9MdOjIwyu81dhCYvRZtUsa8u1rrOg+8QsFPivfznF2aFPeZm
 T7VTYVYVWHYejebN2l9W7+ne97iHx1pDS+lOHreUi/IAF7ex+vx7lWpMfhDjGhBwtfbk
 Ump0YnVlH5VexvquYSDEI0TeVT59HTK5szVOBl97gWL5N3adXtQwor/iVwEFuUxtK68r
 ZmXCfo2/EihCiK50jeFGQ8lgN4f7x7zPQs9DIsOgHi7PnfUKWs9pVXRwJ145IvSuchov
 LFrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782143059; x=1782747859;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TxHw9FNXhs3WjoVuXdujkdpT0WKll9+MxvhTqcMgeeQ=;
 b=hG1DeN4awYbSgjzwu7DI7gDp4Kl/ckBF4A73PeCVyBJMKhTkiwfK5l4LgSR2SSZpFE
 uaLYLmsGY6z2691IGfQ3unEAe1Vr2iECEzsjW+Fg3bSkgWFGjD3k92ONA5ZZIne5FM39
 CLILKB65vd6IbUi0RRrcg8nDtV+3gVsP/cEQZWUUTlmOtzb1a5ZR4cnWb2XdPJY0hn4n
 u2RuqevE/EdhEwv8gS1YCgvJi/StBw9wlVgwzDGsvfSp6cPZom9btYPYik9G4WZuSjZS
 F+0TLV5mGyrphlkLskOwQfZTFgOwcD1LVc/eBvB050zCpbIR7IwtK7skjgEBx2SU7MDf
 ZXlg==
X-Gm-Message-State: AOJu0YwAwdwRT1MAo0wkRFVeIrLoPd1E079z2OzCuvww0+8yJgrg14TU
 TDv0DDKOaD6i79gPfPGvU+HjRoYPwc95Mc52y1+hmKBUJk0FiH1yoWm7PB/icl1E2L8Y5aUwscj
 9Gcl5
X-Gm-Gg: AfdE7cn9Cts0CKHkZG5ElQc2Ding9iBABEB6ET3NmQ3wnKYQ1fZKp4WP9fq3ODsx0Lb
 IpKaaQq71DHPV/XbuZ/K5KiG+pe+Vpo1r8olCdw1py0YFMISLQkCH4UbThF77shcSA7lyf9uqra
 qhI+e1NzPv8ZCZZFvAMV8pvArATZFIy7tSa4qPNs1ObZRUk2HuiXoA6g209OTzlO4VftcVMH0p+
 JOmhlActP/W6YtVZgDG04p/s4RicpNFcR7WZ9LMLs5Au/ah2dnxqRsTeGw9kSDk6N8LHHbu6pOa
 k0eLqG1UmD1t1SrlIkW2OaDZn0q31MgTB/gia8qcZN60XrNsdclBUPmKvb+aKWkqN/GhtdEn7I/
 XGTLlWYS5GBB64KaZZ46GN9gfMyLHui467Ez4fwkv6AgXLBzfTLbryYtLCHs8LU+c8Hrlu6OWxN
 LndvO51dyQJIDU6i4YH077ZksGABR5kM2Fxs8knpmESghKZM6weH7yCA==
X-Received: by 2002:a05:7022:98d:b0:138:35da:3cc3 with SMTP id
 a92af1059eb24-139a3686db5mr8880846c88.30.1782143058411; 
 Mon, 22 Jun 2026 08:44:18 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139adcce488sm7516397c88.8.2026.06.22.08.44.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 08:44:18 -0700 (PDT)
Date: Mon, 22 Jun 2026 08:44:15 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liujie5@linkdatatechnology.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v5 00/23] net/sxe2: added Linkdata sxe2 ethernet driver
Message-ID: <20260622084415.4e25bdd6@phoenix.local>
In-Reply-To: <20260622092324.3091185-1-liujie5@linkdatatechnology.com>
References: <20260619081304.1546974-1-liujie5@linkdatatechnology.com>
 <20260622092324.3091185-1-liujie5@linkdatatechnology.com>
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

On Mon, 22 Jun 2026 17:23:24 +0800
liujie5@linkdatatechnology.com wrote:

> From: Jie Liu <liujie5@linkdatatechnology.com>
> 
> This patch set implements core functionality for the SXE2 PMD,
> including basic driver framework, data path setup, and advanced
> offload features (VLAN, RSS,TM, PTP etc.).
> 
> V5:
> 	Refactored sxe2_ptype_tbl from adapter-indirection pattern (adapter->ptype_tbl[]) 
> 	to extern const direct-access pattern, matching txgbe PMD convention
> 
> 	All vector/SIMD Rx paths (SSE, AVX2, AVX512, NEON) index sxe2_ptype_tbl[] directly without local pointer indirection
> 
> Jie Liu (23):
>   net/sxe2: remove software statistics devargs
>   net/sxe2: add Rx framework and packet types callback
>   net/sxe2: support AVX512 vectorized path for Rx and Tx
>   net/sxe2: add AVX2 vector data path for Rx and Tx
>   net/sxe2: add link update callback
>   net/sxe2: support L2 filtering and MAC config
>   drivers: support RSS feature
>   net/sxe2: support TM hierarchy and shaping
>   net/sxe2: support IPsec inline protocol offload
>   net/sxe2: support statistics and multi-process
>   drivers: interrupt handling
>   net/sxe2: add NEON vec Rx/Tx burst functions
>   drivers: add support for VF representors
>   net/sxe2: add support for custom UDP tunnel ports
>   net/sxe2: support firmware version reading
>   net/sxe2: implement get monitor address
>   common/sxe2: add shared SFP module definitions
>   net/sxe2: support SFP module info and EEPROM access
>   net/sxe2: implement private dump info
>   net/sxe2: add mbuf validation in Tx debug mode
>   common/sxe2: add callback for memory event handling
>   net/sxe2: add private devargs parsing
>   net/sxe2: update sxe2 feature matrix docs
> 
>  doc/guides/nics/features/sxe2.ini          |   56 +
>  doc/guides/nics/sxe2.rst                   |  164 ++
>  drivers/common/sxe2/sxe2_common.c          |  156 ++
>  drivers/common/sxe2/sxe2_common.h          |    4 +
>  drivers/common/sxe2/sxe2_flow_public.h     |  633 +++++++
>  drivers/common/sxe2/sxe2_ioctl_chnl.c      |  178 +-
>  drivers/common/sxe2/sxe2_ioctl_chnl_func.h |   18 +
>  drivers/common/sxe2/sxe2_msg.h             |  118 ++
>  drivers/net/sxe2/meson.build               |   52 +
>  drivers/net/sxe2/sxe2_cmd_chnl.c           | 1587 +++++++++++++++-
>  drivers/net/sxe2/sxe2_cmd_chnl.h           |  139 ++
>  drivers/net/sxe2/sxe2_drv_cmd.h            |  523 +++++-
>  drivers/net/sxe2/sxe2_dump.c               |  302 +++
>  drivers/net/sxe2/sxe2_dump.h               |   12 +
>  drivers/net/sxe2/sxe2_ethdev.c             | 1511 ++++++++++++++-
>  drivers/net/sxe2/sxe2_ethdev.h             |  111 +-
>  drivers/net/sxe2/sxe2_ethdev_repr.c        |  609 ++++++
>  drivers/net/sxe2/sxe2_ethdev_repr.h        |   32 +
>  drivers/net/sxe2/sxe2_filter.c             |  895 +++++++++
>  drivers/net/sxe2/sxe2_filter.h             |  100 +
>  drivers/net/sxe2/sxe2_flow.c               | 1394 ++++++++++++++
>  drivers/net/sxe2/sxe2_flow.h               |   30 +
>  drivers/net/sxe2/sxe2_flow_define.h        |  144 ++
>  drivers/net/sxe2/sxe2_flow_parse_action.c  | 1182 ++++++++++++
>  drivers/net/sxe2/sxe2_flow_parse_action.h  |   23 +
>  drivers/net/sxe2/sxe2_flow_parse_engine.c  |  106 ++
>  drivers/net/sxe2/sxe2_flow_parse_engine.h  |   13 +
>  drivers/net/sxe2/sxe2_flow_parse_pattern.c | 1935 +++++++++++++++++++
>  drivers/net/sxe2/sxe2_flow_parse_pattern.h |   46 +
>  drivers/net/sxe2/sxe2_ipsec.c              | 1565 ++++++++++++++++
>  drivers/net/sxe2/sxe2_ipsec.h              |  254 +++
>  drivers/net/sxe2/sxe2_irq.c                | 1026 ++++++++++
>  drivers/net/sxe2/sxe2_irq.h                |   25 +
>  drivers/net/sxe2/sxe2_mac.c                |  530 ++++++
>  drivers/net/sxe2/sxe2_mac.h                |   84 +
>  drivers/net/sxe2/sxe2_mp.c                 |  414 +++++
>  drivers/net/sxe2/sxe2_mp.h                 |   67 +
>  drivers/net/sxe2/sxe2_queue.c              |   17 +-
>  drivers/net/sxe2/sxe2_queue.h              |   15 +-
>  drivers/net/sxe2/sxe2_rss.c                |  584 ++++++
>  drivers/net/sxe2/sxe2_rss.h                |   81 +
>  drivers/net/sxe2/sxe2_rx.c                 |   93 +-
>  drivers/net/sxe2/sxe2_rx.h                 |    2 +
>  drivers/net/sxe2/sxe2_security.c           |  335 ++++
>  drivers/net/sxe2/sxe2_security.h           |   77 +
>  drivers/net/sxe2/sxe2_stats.c              |  586 ++++++
>  drivers/net/sxe2/sxe2_stats.h              |   39 +
>  drivers/net/sxe2/sxe2_switchdev.c          |  332 ++++
>  drivers/net/sxe2/sxe2_switchdev.h          |   33 +
>  drivers/net/sxe2/sxe2_tm.c                 | 1151 ++++++++++++
>  drivers/net/sxe2/sxe2_tm.h                 |   76 +
>  drivers/net/sxe2/sxe2_tx.c                 |    7 +
>  drivers/net/sxe2/sxe2_txrx.c               | 1958 +++++++++++++++++++-
>  drivers/net/sxe2/sxe2_txrx.h               |    8 +
>  drivers/net/sxe2/sxe2_txrx_check_mbuf.c    |  595 ++++++
>  drivers/net/sxe2/sxe2_txrx_check_mbuf.h    |   38 +
>  drivers/net/sxe2/sxe2_txrx_poll.c          |  284 ++-
>  drivers/net/sxe2/sxe2_txrx_vec.c           |   46 +-
>  drivers/net/sxe2/sxe2_txrx_vec.h           |   38 +-
>  drivers/net/sxe2/sxe2_txrx_vec_avx2.c      |  747 ++++++++
>  drivers/net/sxe2/sxe2_txrx_vec_avx512.c    |  867 +++++++++
>  drivers/net/sxe2/sxe2_txrx_vec_common.h    |   54 +-
>  drivers/net/sxe2/sxe2_txrx_vec_neon.c      |  689 +++++++
>  drivers/net/sxe2/sxe2_txrx_vec_sse.c       |   38 +-
>  drivers/net/sxe2/sxe2_vsi.c                |  146 ++
>  drivers/net/sxe2/sxe2_vsi.h                |   12 +-
>  drivers/net/sxe2/sxe2vf_regs.h             |   85 +
>  67 files changed, 24798 insertions(+), 273 deletions(-)
>  create mode 100644 drivers/common/sxe2/sxe2_flow_public.h
>  create mode 100644 drivers/common/sxe2/sxe2_msg.h
>  create mode 100644 drivers/net/sxe2/sxe2_dump.c
>  create mode 100644 drivers/net/sxe2/sxe2_dump.h
>  create mode 100644 drivers/net/sxe2/sxe2_ethdev_repr.c
>  create mode 100644 drivers/net/sxe2/sxe2_ethdev_repr.h
>  create mode 100644 drivers/net/sxe2/sxe2_filter.c
>  create mode 100644 drivers/net/sxe2/sxe2_filter.h
>  create mode 100644 drivers/net/sxe2/sxe2_flow.c
>  create mode 100644 drivers/net/sxe2/sxe2_flow.h
>  create mode 100644 drivers/net/sxe2/sxe2_flow_define.h
>  create mode 100644 drivers/net/sxe2/sxe2_flow_parse_action.c
>  create mode 100644 drivers/net/sxe2/sxe2_flow_parse_action.h
>  create mode 100644 drivers/net/sxe2/sxe2_flow_parse_engine.c
>  create mode 100644 drivers/net/sxe2/sxe2_flow_parse_engine.h
>  create mode 100644 drivers/net/sxe2/sxe2_flow_parse_pattern.c
>  create mode 100644 drivers/net/sxe2/sxe2_flow_parse_pattern.h
>  create mode 100644 drivers/net/sxe2/sxe2_ipsec.c
>  create mode 100644 drivers/net/sxe2/sxe2_ipsec.h
>  create mode 100644 drivers/net/sxe2/sxe2_irq.c
>  create mode 100644 drivers/net/sxe2/sxe2_mac.c
>  create mode 100644 drivers/net/sxe2/sxe2_mac.h
>  create mode 100644 drivers/net/sxe2/sxe2_mp.c
>  create mode 100644 drivers/net/sxe2/sxe2_mp.h
>  create mode 100644 drivers/net/sxe2/sxe2_rss.c
>  create mode 100644 drivers/net/sxe2/sxe2_rss.h
>  create mode 100644 drivers/net/sxe2/sxe2_security.c
>  create mode 100644 drivers/net/sxe2/sxe2_security.h
>  create mode 100644 drivers/net/sxe2/sxe2_stats.c
>  create mode 100644 drivers/net/sxe2/sxe2_stats.h
>  create mode 100644 drivers/net/sxe2/sxe2_switchdev.c
>  create mode 100644 drivers/net/sxe2/sxe2_switchdev.h
>  create mode 100644 drivers/net/sxe2/sxe2_tm.c
>  create mode 100644 drivers/net/sxe2/sxe2_tm.h
>  create mode 100644 drivers/net/sxe2/sxe2_txrx_check_mbuf.c
>  create mode 100644 drivers/net/sxe2/sxe2_txrx_check_mbuf.h
>  create mode 100644 drivers/net/sxe2/sxe2_txrx_vec_avx2.c
>  create mode 100644 drivers/net/sxe2/sxe2_txrx_vec_avx512.c
>  create mode 100644 drivers/net/sxe2/sxe2_txrx_vec_neon.c
>  create mode 100644 drivers/net/sxe2/sxe2vf_regs.h
> 

Much better, still some AI review feedback items.
I agree with AI on this; duplicate rules should be handled similar to other
drivers.

[PATCH v5 00/23] sxe2 driver feature additions

v5 cleanly addresses the v4 follow-ups except flow-duplicate-pattern.

Verified across the assembled tree:

- All 23 commits build end-to-end. Bisect works. The structural
  reorganization (Rx framework now precedes the vector paths instead of
  the other way around) was non-trivial and could easily have
  reintroduced the build-band problem; it didn't.

- The v4 "subject does not match content" issue on 04/23 is resolved by
  reshuffling: 02/23 ("net/sxe2: add Rx framework and packet types
  callback") now correctly bundles the sxe2_txrx.c creation with the
  ptype callback registration, AVX512 and AVX2 are layered on top as
  separate patches (03/23, 04/23), and the old standalone "supported
  packet types get callback" patch is absorbed into 02/23. The
  ordering also makes more sense - frame, then vector specializations.

- The ptype-table refactor is now complete: adapter->ptype_tbl field
  removed from struct sxe2_adapter, sxe2_init_ptype_tbl() function
  removed entirely, all readers (vec_avx2, vec_avx512, vec_sse, vec_neon,
  poll) now reference the file-scope static const sxe2_ptype_tbl[]
  directly. One indirection saved per packet in the inner loop, and
  SXE2_MAX_PTYPE_NUM * 4 bytes saved per port.

- The high_performance_mode local in sxe2_parse_no_sched_mode() is
  renamed to no_sched_mode, matching the struct field and the devarg
  string. The rename is now consistent throughout the series.

- No regressions: full rescan for the usual high-value classes
  (raw_free_bulk on mixed pools, volatile inter-thread flags, 64-bit
  shifts, forbidden tokens, asm-generic, LLM placeholders) finds
  nothing. All long-standing fixes from earlier rounds persist (atomics
  removed from sw_stats, event_thread_run atomic, monitor DD_MASK,
  Inline crypto matrix entry).

One open design item:

[PATCH v5 22/23] flow-duplicate-pattern still defaults to 1

This was the only v4 item I considered design-blocking, and it isn't
addressed in v5. The devarg still toggles whether rte_flow rules with
identical patterns are accepted (value=1) or rejected with EEXIST
(value=0), and 1 is the default. The behaviour of a standard API
shouldn't vary per boot flag, and every other PMD rejects duplicates
with EEXIST. Pick that policy, apply it unconditionally, and drop the
devarg. The switch_pattern_dup_allow field on rule metadata can stay
if the hardware/firmware path internally needs it - just don't expose
the policy choice to userspace as a boot-time knob.

With that one change, this is ready.

