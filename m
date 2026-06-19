Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE21CD98F2
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Jun 2026 17:31:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F1FC64027C;
	Fri, 19 Jun 2026 19:31:36 +0200 (CEST)
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181]) by mails.dpdk.org (Postfix) with ESMTP id 5E1F840279
 for <dev@dpdk.org>; Fri, 19 Jun 2026 19:31:35 +0200 (CEST)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-30b9e755555so5019972eec.1
 for <dev@dpdk.org>; Fri, 19 Jun 2026 10:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781890294;
 x=1782495094; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aYxJGl5WdVtYcBNlwGUpbONCXyqgYCDXGY5b8uzuek4=;
 b=J2M+FHA7dZRdbEwIufwOApggZUdsv2XT0R1ceAvPfWFqlp/Jec0uiH5iO86soShe9H
 S7R64EHWCVFGGm8cMoHS4FUO/GW8llc5Y3fCZoXUnu+4MmzFQNLecqNupQSx3v/c4KDL
 AIb9L33AUdVb4Hq+BUnPba/aYNbX2Z6zBOJbTULs2syvttSNRpkrRhX8wkrknB2kJOFP
 fupuSHEbpKza99309lQBfe5YrIkNkHQbnfLR4nP6flc18sjoycnvT5YlU8Wxj8stU0Zd
 ZtWqy3SgDK5FJ+8shY4HwVIpBq/q2EJ9OZkAmZVfIGgKY5ecaHCV994qT6emUxfZES1/
 ljLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781890294; x=1782495094;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aYxJGl5WdVtYcBNlwGUpbONCXyqgYCDXGY5b8uzuek4=;
 b=A5hjtheecer1D6B7CsAJXelBxPrwfW/82hfQ8KnHi12hxB1KpKkQ3bSy6h9A+WXt61
 dYAqWKony2Ul7NfuTixeVnIpu5omPNCNCvqj7xtey4IlYhnxuygOYkp/HN66gETw/mnH
 oujde03hum/0osBZ8LJBRxt1gCumS5D9FUwpAwoxYQsQtmii7rjicXTR+KKThJTYXawj
 J6z60ea1i9cmYXh0mSs/Lj4s1ihFbkRT+jZGksCYJLx2FxC+eD6/WKoaQdb2TC2vqfJD
 /6PmNANurdU4iB1FNnjJDUMTQR38P1GH5zjp5fTDf4vySBICAyVkbqyqr8QD0pLNfadW
 Z/fA==
X-Gm-Message-State: AOJu0YxhMzkdBnKBCkM18NqHAGapWJMtXnmQ8MR1STMQC2DXYTGHcIpq
 yBiySQNNAE/OWBufbP3oeT6a+pqWTpWNNaU78tulXtv3SitEfeIHsv/K0hfNhrIvpvJxXDMTHmY
 gW4ed
X-Gm-Gg: AfdE7cl/zyj9wVEyx2ZaAtbOAjNQHE4CZLTPgroGFqUb7bqj1xgoyXGIPCJlSNFyTd7
 TKYFN0pZCpvjL0zPwcQMFdeYDchuzK0DFdbOZpgpU55MbPjX8Pjw4dzupzH14CaB3RfoW8nqClI
 ALpkyAGDLbMlnbNima8LBm6rsI4Y3RvMVwRkf65h/q7tceT6v/fCAYhmUgtzL/PJb7QFHN5VcgZ
 5CzH8wyD46Zde1s+T3OlomEv7JwzXJNlSICZHXh3spgSEe5BJRw8Ewp8cDc27OpqRR4lfNKD0NY
 tme7b0/1OSPwoi4SX9AkmfAw/6MJX6KWQ+2gKtzyd7tzUiXWJhcuIzGnimuzS1fyx4yxvR+s7OO
 tQ3ixnBurB1+MriyD2N2Dp25v3sbQ2AdKjVAhpMFzcewUzTagZVFltor5T9laDAhhNU8EvXwC/g
 BtYyCoBGQuV2DRFhYlJoGr3sJ4uLbwYvrONn5hf5D/dGmDjk4I6RYNHQ==
X-Received: by 2002:a05:693c:20c2:20b0:30c:a9a:ee57 with SMTP id
 5a478bee46e88-30c0a9af1c5mr1474972eec.15.1781890293786; 
 Fri, 19 Jun 2026 10:31:33 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1bd8d799sm346570eec.19.2026.06.19.10.31.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 10:31:33 -0700 (PDT)
Date: Fri, 19 Jun 2026 10:31:30 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liujie5@linkdatatechnology.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v4 00/23] et/sxe2: added Linkdata sxe2 ethernet driver
Message-ID: <20260619103130.3a8a33ff@phoenix.local>
In-Reply-To: <20260619080156.1539964-1-liujie5@linkdatatechnology.com>
References: <20260618082723.571054-21-liujie5@linkdatatechnology.com>
 <20260619080156.1539964-1-liujie5@linkdatatechnology.com>
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

On Fri, 19 Jun 2026 16:01:56 +0800
liujie5@linkdatatechnology.com wrote:

> From: Jie Liu <liujie5@linkdatatechnology.com>
> 
> This patch set implements core functionality for the SXE2 PMD,
> including basic driver framework, data path setup, and advanced
> offload features (VLAN, RSS,TM, PTP etc.).
> 
> V19:
>  - remove software statistics devargs
> 
> Jie Liu (23):
>   net/sxe2: remove software statistics devargs
>   net/sxe2: support AVX512 vectorized path for Rx and Tx
>   net/sxe2: add AVX2 vector data path for Rx and Tx
>   net/sxe2: add supported packet types get callback
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
>  drivers/net/sxe2/sxe2_ethdev.c             | 1513 ++++++++++++++-
>  drivers/net/sxe2/sxe2_ethdev.h             |  112 +-
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
>  drivers/net/sxe2/sxe2_mp.c                 |  414 ++++
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
>  drivers/net/sxe2/sxe2_txrx.c               | 1968 +++++++++++++++++++-
>  drivers/net/sxe2/sxe2_txrx.h               |    8 +
>  drivers/net/sxe2/sxe2_txrx_check_mbuf.c    |  595 ++++++
>  drivers/net/sxe2/sxe2_txrx_check_mbuf.h    |   38 +
>  drivers/net/sxe2/sxe2_txrx_poll.c          |  281 ++-
>  drivers/net/sxe2/sxe2_txrx_vec.c           |   46 +-
>  drivers/net/sxe2/sxe2_txrx_vec.h           |   38 +-
>  drivers/net/sxe2/sxe2_txrx_vec_avx2.c      |  748 ++++++++
>  drivers/net/sxe2/sxe2_txrx_vec_avx512.c    |  868 +++++++++
>  drivers/net/sxe2/sxe2_txrx_vec_common.h    |   53 +-
>  drivers/net/sxe2/sxe2_txrx_vec_neon.c      |  691 +++++++
>  drivers/net/sxe2/sxe2_txrx_vec_sse.c       |   29 +-
>  drivers/net/sxe2/sxe2_vsi.c                |  146 ++
>  drivers/net/sxe2/sxe2_vsi.h                |   12 +-
>  drivers/net/sxe2/sxe2vf_regs.h             |   85 +
>  67 files changed, 24809 insertions(+), 266 deletions(-)
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

This is look much better, there are a few minor things that you probably
want to address before I merge it.

The (overly verbose) AI feedback is...

[PATCH v4 00/23] sxe2 driver feature additions

This is in good shape. Substantive structural progress on essentially
everything I raised against v3.

Verified across the assembled tree:

- All 23 commits build cleanly end-to-end. git bisect now works. This is
  the first revision of the series where that's been true.
- No LLM citation placeholders remain in commit messages. The v3 19/20
  message with "[citation:1][citation:3][citation:5]" markers and the
  "approximately X%" placeholder are both gone.
- The atomic-sw-stats fix is properly placed. 01/23 is a clean standalone
  cleanup commit that removes RTE_ATOMIC qualifiers from
  sxe2_rxq_sw_stats, replaces the atomic load/store/fetch_add calls with
  plain operations, removes the if(sw_stats_en) gating, removes the now-
  unused #include <rte_stdatomic.h>, and renames high_performance_mode to
  no_sched_mode to match the devargs string. Verified zero atomic
  operations on sw_stats remain in the assembled tree.
- drv-sw-stats devarg removed entirely (defined, parsed, but unused in
  v3 - now gone).
- All surviving devargs are documented in doc/guides/nics/sxe2.rst with
  substantive explanations covering what each parameter does, valid
  values, defaults, and trade-offs.
- The v3 19/20 patch is split into 21/23 (memseg-walk callback
  infrastructure, common/sxe2 only) and 22/23 (devargs parsing,
  net/sxe2). Both commit messages now describe one thing each.
- The 469-entry runtime ptype-table initialiser is now a file-scope
  `static const alignas(RTE_CACHE_LINE_SIZE) uint32_t
  sxe2_ptype_tbl[]` with C99 designated initialisers.
- Patch 02/23 (AVX512) scope is tightened - dropped from 13 files to 6,
  and the files it touches are all AVX512-related now.
- The v3 03/20 patch is split into 04/23 ("supported packet types") and
  05/23 ("link update callback"), addressing the scope-drift complaint.

Three remaining items, none blocking:

[PATCH v4 04/23] subject still does not match content

The commit message says the patch adds `dev_supported_ptypes_get`, and
the patch adds that callback - but it also creates the entire 1793-line
drivers/net/sxe2/sxe2_txrx.c with the Tx/Rx framework, packet-type
constant table, classification helpers, etc. The ptype callback is a
small piece of what this patch does. Either rename the subject to
something like "net/sxe2: add Rx/Tx framework and packet types callback"
(more honest) or split the txrx framework into a separate prior commit
with ptype-callback registration as a small follow-up.

[PATCH v4 04/23] ptype table refactor is incomplete

The static const table is correct, but adapter->ptype_tbl is still
declared in struct sxe2_adapter and sxe2_init_ptype_tbl() now just
memcpy's the const table into the per-adapter copy at init. The vec
paths in sxe2_txrx_vec_avx2.c, _avx512.c, _sse.c and the poll path all
read through rxq->vsi->adapter->ptype_tbl[] rather than the file-scope
const. To finish: remove the adapter field, remove sxe2_init_ptype_tbl,
and have all readers reference sxe2_ptype_tbl directly. The inner-loop
saves one indirection per packet, and per-port memory drops by
SXE2_MAX_PTYPE_NUM * 4 bytes.

[PATCH v4 22/23] flow-duplicate-pattern still defaults to 1

This devarg now has good documentation, but the documentation
clarifies the design objection rather than resolving it: a boolean
that toggles "duplicate rte_flow rules are rejected with EEXIST" vs
"duplicate rte_flow rules are accepted" is a per-boot toggle for
standard-API contract semantics. Standard APIs shouldn't behave
differently based on a vendor devarg. Pick one policy (rejecting
duplicates with EEXIST is what every other PMD does), apply it
unconditionally, and remove the devarg. The
switch_pattern_dup_allow rule metadata can stay if hardware needs it
internally - just don't expose the policy as a boot-time knob.

The other surviving devargs are acceptable as posted:
- no-sched-mode: kernel-coexistence rationale documented, defensible.
- rx-low-latency: ITR throttling threshold, well-documented trade-off,
  precedent in other PMDs.
- function-flow-direct: DPDK/kernel flow-table coexistence policy with
  no rte_flow analogue. The documentation explains this clearly.
- fnav-stat-type: hardware counter-mode selection. The cleaner long-
  term shape would be separate xstats names, but the current form is
  documented and reasonable for now.
- sched-layer-mode: hardware-imposed TM hierarchy cap. Should ideally
  be exposed via rte_tm_capabilities_get and selected at hierarchy
  build time rather than via devarg; worth raising as a future rte_tm
  enhancement.

Minor cosmetic:

In sxe2_parse_no_sched_mode() (22/23) the local variable is still
named `high_performance_mode`. The struct field rename in 01/23
didn't propagate to this parser local. Cosmetic.

Once 22/23 drops flow-duplicate-pattern and 04/23's subject is
either renamed or split, I'd consider this ready.

