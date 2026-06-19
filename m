Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63EF6CD98FA
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Jun 2026 02:16:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3FD724028F;
	Fri, 19 Jun 2026 04:16:48 +0200 (CEST)
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180]) by mails.dpdk.org (Postfix) with ESMTP id 681934027F
 for <dev@dpdk.org>; Fri, 19 Jun 2026 04:16:46 +0200 (CEST)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-30bf8b2bd20so2353890eec.0
 for <dev@dpdk.org>; Thu, 18 Jun 2026 19:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781835405;
 x=1782440205; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h4Sp4ezXPv1IYBAY2/XnnjXLDIeq2Zf0pQUTJWAkI54=;
 b=Dy8OfzWvSBwQAg3g0Jk4rl4bZ7HPLo5NeiLK7eZnfpamZ1fNJZV0LLhAaVQiClEWZB
 GOSkhKLMPnc3MJmMTzNDlTAQPzqOP/I6f2e6LsjBrKMgKWlMmELGn9AMNcGPnM+Q2eXq
 ZBRbSLOS5IhBvXORyBvx6bYAuMA3my0AgRP1nIqY9ffNSXfEmUpiuaqiHXh37S3RPg+0
 TRhEFuPnW2uLFfQMvgyZInkydEI/6kGUHomVyyIwFBzEMBKAHFl4zZLWbYc1rYUmDmIe
 4z/iZg8HQGQf54Iq8lugzU//Oa/1DVKE0iZfjBY6reDuwtZ1UDXb8Xypw/CJi347DVIs
 Yikw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781835405; x=1782440205;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=h4Sp4ezXPv1IYBAY2/XnnjXLDIeq2Zf0pQUTJWAkI54=;
 b=AChNOA7TWwumy+KNFBn6GvmMN7FJphdR5itfy/NDDpRylZZGEb12qumjdm2xk6gilg
 65UrdTEFuuWET7pk2ewsLok3n2TgxGCTeZ9kWovAR8zwPieC7OBW+LMjQhNWE4P5oxL9
 0yF3mioIVWMTMSPfDDZK4hu6ZTFhsi8zXpfO+M0BO1oU6+v50EYumkNGsskJlrY7ZnDH
 d50lhvcBIHQ1sMsLzPTGzFAX3kLZxYmQmxI9oveDPNoBrtdYrzZATcVkLElxhSBPEnF+
 v+m2DEeuxD11dv/xnusDRV9N0aklEXA/8zFm3kjWjMgxjRdpoZKoI6Erg5Nywz0Freou
 ezXQ==
X-Gm-Message-State: AOJu0Yynou4JLWKbbjLD80mV8ZLWfW450wkKqw/X2b/PR9Kho961tzUP
 xKDFteC9EA0tevkdJynJ3O3UTlBdFxxRbcGOHKNT4AKm7doq4up5tKfq5Umwx9SG7pK/echz59X
 dKNd3
X-Gm-Gg: AfdE7cnTwL2pcGeYYOL/qErdAv9A2X4o92MZ0uoHg/SDtjj5clTmsMU+axbxc4BfQHS
 6rFazsjIebAjHwqPII6Wio2+X1yOdT2aEPDkTPa6pl7/lLVVyC9D0MRFzGqR1TIKe+q0aGdzRX/
 mFIide0VNbW/lsJLwcMg0kQWlcbPRdx/fD/PA2IDqGWZHV+qro37fk9+3n22rpr/QwAZiUE0MVO
 XIvD8iacP4bCpql8arvBJkmxZk+ovRAX/CzCvm+X2IiAAwjClvSl36pHe4I17seuHedB/zbS4El
 EWlpFe5qtGPg8PKLi9UyC5JdruJJv/+nHA9M1PKyjFvJ9CyRo8I1+TlU6zkZpHEeBu2eJr6UMWP
 vau7Kj8V0u+7JqT0tm7+TZ1zjzqG7o1YEEyLV2iiCU4BUOKOT0G0MhaxDkJQ9Wxr7oCyDRtcX7W
 Thux9D8PUpIfQFP34aHEzPHpEOCC0K+7lU2qJ/mdStLWHIDBdp1TRw7KCw4cVA/RZI
X-Received: by 2002:a05:7300:80c4:b0:307:26a3:75d8 with SMTP id
 5a478bee46e88-30c0703b9d8mr1253373eec.1.1781835404984; 
 Thu, 18 Jun 2026 19:16:44 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c06d40141sm1054930eec.21.2026.06.18.19.16.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 19:16:44 -0700 (PDT)
Date: Thu, 18 Jun 2026 19:16:42 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liujie5@linkdatatechnology.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v3 00/20] net/sxe2: added Linkdata sxe2 ethernet driver
Message-ID: <20260618191642.1f852612@phoenix.local>
In-Reply-To: <20260618082723.571054-1-liujie5@linkdatatechnology.com>
References: <20260614092328.201826-21-liujie5@linkdatatechnology.com>
 <20260618082723.571054-1-liujie5@linkdatatechnology.com>
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

On Thu, 18 Jun 2026 16:27:03 +0800
liujie5@linkdatatechnology.com wrote:

> From: Jie Liu <liujie5@linkdatatechnology.com>
> 
> V3:
> 	Remove the `drv-sw-stats` devarg
> 
> Jie Liu (20):
>   net/sxe2: support AVX512 vectorized path for Rx and Tx
>   net/sxe2: add AVX2 vector data path for Rx and Tx
>   drivers: add supported packet types and link state
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
>   drivers: add parameters parsed using rte_kvargs
>   net/sxe2: update sxe2 feature matrix docs
> 
>  doc/guides/nics/features/sxe2.ini          |   56 +
>  doc/guides/nics/sxe2.rst                   |  132 ++
>  drivers/common/sxe2/sxe2_common.c          |  156 ++
>  drivers/common/sxe2/sxe2_common.h          |    4 +
>  drivers/common/sxe2/sxe2_flow_public.h     |  633 +++++++
>  drivers/common/sxe2/sxe2_ioctl_chnl.c      |  178 +-
>  drivers/common/sxe2/sxe2_ioctl_chnl_func.h |   18 +
>  drivers/common/sxe2/sxe2_msg.h             |  118 ++
>  drivers/net/sxe2/meson.build               |   54 +-
>  drivers/net/sxe2/sxe2_cmd_chnl.c           | 1587 +++++++++++++++-
>  drivers/net/sxe2/sxe2_cmd_chnl.h           |  139 ++
>  drivers/net/sxe2/sxe2_drv_cmd.h            |  523 +++++-
>  drivers/net/sxe2/sxe2_dump.c               |  302 +++
>  drivers/net/sxe2/sxe2_dump.h               |   12 +
>  drivers/net/sxe2/sxe2_ethdev.c             | 1515 ++++++++++++++-
>  drivers/net/sxe2/sxe2_ethdev.h             |  110 +-
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
>  drivers/net/sxe2/sxe2_tm.c                 | 1169 ++++++++++++
>  drivers/net/sxe2/sxe2_tm.h                 |   78 +
>  drivers/net/sxe2/sxe2_tx.c                 |    7 +
>  drivers/net/sxe2/sxe2_txrx.c               | 1969 +++++++++++++++++++-
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
>  67 files changed, 24800 insertions(+), 266 deletions(-)
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

I will do manual review on next series, but could you address these things
found by redoing AI review on this version.

[PATCH v3 00/20] net/sxe2: support AVX512 vectorized path

Good news first: the atomic-operations issue raised against v2 is properly
fixed. struct sxe2_rxq_sw_stats now uses plain uint64_t, the hot-path writer
uses ordinary += increments, and the if (sw_stats_en) gating is gone -
software stats are now always-on, which is what was asked for. Verified
against the assembled tree.

The rest of v3 has problems.

[PATCH v3 01/20] - and patches 02-09 - do not build

08/20 still has `if (adapter->devargs.sw_stats_en)` at sxe2_stats.c:212,
but 01/20 removed that field from struct sxe2_devargs. The series builds
at HEAD but commits 08 through 09 fail with "struct sxe2_devargs has no
member named 'sw_stats_en'". This is the same class of break as the
SXE2_DEV_TO_PCI issue in v1: the atomic-removal cleanup was applied to
the AVX512 patch (01/20) when it logically belongs to the stats patch
(08/20), and one straggler use was missed in the rebase.

The fix is twofold:
- Move the struct field removal and the cleanup of all its uses into
  08/20 ("support statistics and multi-process"), where the field is
  actually about.
- Delete the SXE2_DEVARG_SW_STATS / "drv-sw-stats" devarg entirely. After
  the atomic removal it has no consumer in the assembled tree - it is
  defined, registered with rte_kvargs and listed in
  RTE_PMD_REGISTER_PARAM_STRING, but nothing reads it. Dead code.

Please run per-commit builds before posting the next revision. Both this
break and the v1 break would have been caught by `git rebase -x "ninja
-C build" <base>`, or by devtools/test-meson-builds.sh. Two consecutive
revisions with broken bisect bands in the same series is the wrong
trend.

[PATCH v3 19/20] commit message contains LLM citation placeholders

The body has "[citation:1][citation:3][citation:5]" markers, which are
unresolved LLM output. Same shape as the "Performance shows approximately
X% improvement in small packet forwarding scenarios" placeholder in
01/20. Please rewrite both commit messages by hand.

The 19/20 commit message also describes two unrelated changes (kvargs
parsing and memseg_walk callback infrastructure). These are separate
features and should be separate patches.

Patch scope drift

The v2 review noted that 03/20 carried scope unrelated to its subject.
In v3 this got worse:
- 03/20 grew by 777 lines and now creates sxe2_txrx.c (1793 lines) under
  the subject "drivers: add supported packet types and link state". Tx/Rx
  framework is not the same feature as a ptype callback.
- 01/20 grew by 227 lines and now touches 13 files including
  sxe2_txrx_poll.c, sxe2_queue.h, sxe2_rx.c, sxe2_txrx_vec_sse.c,
  sxe2_ethdev.c/h, and meson.build. The subject is "support AVX512 vector
  path"; the atomic-removal cleanup, the struct rename of
  high_performance_mode to no_sched_mode, and the SSE common-code changes
  do not belong under that subject.
- 19/20 touches 15 files spanning kvargs, memseg walking, tm, flow, irq,
  rx, and dump. Pick one feature per patch.

Each patch should do one thing the commit message describes. The split
makes review tractable and bisect meaningful.

Devargs design - mostly unresolved from off-list discussion

Of the seven devargs, only no-sched-mode and rx-low-latency have
defensible justification. The rest need to either be removed or have
their justifications documented in sxe2.rst:

- drv-sw-stats - orphaned dead code as noted above, remove.
- flow-duplicate-pattern - default value 1 ("allow duplicate rte_flow
  rules") changes the standard rte_flow contract per boot flag. The
  duplicate-rule behaviour should be one fixed policy compiled into the
  driver, not a runtime knob; pick one and remove the devarg.
- function-flow-direct - no documented rationale anywhere. Either
  explain what cross-PMD feature this represents and why no standard API
  covers it, or remove.
- fnav-stat-type - selects which set of fnav (flow-director) counters
  the driver exposes. These should be xstats names the user picks at
  query time, not a boot-time selection.
- sched-layer-mode - TM hierarchy depth should be inferred from the
  rte_tm topology the application builds, not configured by devarg.
  Propose this as an rte_tm enhancement if the standard API really
  cannot express it.

Minor

In sxe2_parse_no_sched_mode() the local variable is still named
high_performance_mode - the rename did not propagate from the struct
field to the parser. Cosmetic, but the name no longer matches what the
function parses.

The earlier suggestion to convert the 469-entry runtime-initialised
ptype table into a single static const uint32_t with designated
initialisers was not addressed. Lower priority but still worth doing.

The atomics fix and the kvargs work are real progress - this revision
is much closer to mergeable than v2 was. The two essential items for v4
are: fix the build break in commits 08-09 (and run per-commit builds),
and the devargs cleanup. Patch scope and the commit-message placeholders
are secondary but should also be addressed.

Stephen Hemminger <stephen@networkplumber.org>
