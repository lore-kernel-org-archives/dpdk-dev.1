Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32927CDB47F
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 16:38:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 12C79402BC;
	Wed, 24 Jun 2026 18:38:58 +0200 (CEST)
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181]) by mails.dpdk.org (Postfix) with ESMTP id 9991540293
 for <dev@dpdk.org>; Wed, 24 Jun 2026 18:38:56 +0200 (CEST)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-30b6dad2382so2217615eec.0
 for <dev@dpdk.org>; Wed, 24 Jun 2026 09:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782319135;
 x=1782923935; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+V7wPg/Nd8SFIhVr+GC1Ah6kJd+5CjgeMNwG0iFd5fI=;
 b=JcTb1lM55oWWa1pvK2akO5EPD0RQCYZ+znq7+qgUyPXp8tnXS082QJ1XJG1YkOKmPH
 ZOjPDYXki/v68ypoJka/qx6vYrwINjfUwbZZnkAUXpIqxl445262qxKOe0wvFDJLtJHD
 xxo0O6ZTAfR0CNBTJp1ec/MfxvfMn+XxFtys9uifcitepp8uUTgHbr3nTR6ICB6tNl3W
 JawRossK7zp0+RhCn5VgSgURD6XG9O301SskmJ3EMp75ytB2ggp1ZUkxUse67vcM/oz6
 YMy8zyVPv2qVlsxZhPYngfJL00Kt4UdfciUZc1/GR4wqJtqRSCfqx61BuATcX4CSsT9m
 db4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782319135; x=1782923935;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+V7wPg/Nd8SFIhVr+GC1Ah6kJd+5CjgeMNwG0iFd5fI=;
 b=gzNUXpuSNSTQBu/NQf+pNxDLwlU2uWzBoDvefciytUF/pvsM04Yg8x5m9nVssHWuTX
 tYrCLAh2kfIJzVvMT3LOyEcCeGg0T3GLfaBPF6nVI2XztNjmS0OZRwmWgsWDuQEFMjbf
 VInp6BVuVh6I+H9R2GjCMFxWPOLRMEqktZeCWe64+z1iG6NKJ32bTgQbE9xzRdmCmM/3
 Qmf6AZ2xp8xjP2+hm1o2K062rLaglEU/tPixjOdjiFgvPLlztKQwIX5+4925EsGj83pg
 AOwk0yl0VjaVUxB0kiNyJtrGZqDe44QHmZfrajz4rsUW2xdGoIS/N0UxDEwy+dOwVpyY
 Lrcg==
X-Gm-Message-State: AOJu0Yx7SPMYlcWsljJjsCi6kD2OwJzpj7/lzkv3jgtgU2znFDk0sOXt
 kIkya8XM2Ft0wZqdWqVzg7IvqTJ1H75Xznxg6osgCSew7ql0V0eXB76wxGdx3bkJh2gKJb+wNpr
 Scx05
X-Gm-Gg: AfdE7clDFYui70w8Bft8fUv6YJ0X3ItlCAeW4w97q2rvQ4OH1R3pZORJP+7z2UL5dh1
 3UAc1JCJHHLmDhW/wz/w0gq0DkWoVrd/llO5CdIcG0Mu7K6TsZqPHJE1mm4eebqCaLPTVLeYXmA
 UmgfmF2xQv29X+GmwDugf3ShLil+BQZp1LgKrURIAZ+NfsAhTkjL4XfeUaMVvZE7BWIEEUoRNv1
 PAI1V3Gt+6+NyuWA9ChZ6uaI/ROBd79TapDBunjiWYMRQIVxSht40dQC1omBKPldmjSYHQ2q5MN
 Ce/RRp1bn7rHQtLAwSdwdKRJ3w/ZyKBB7GH6YizhlHXgnIaM40rKreImOvxljNSwg4Ksm6y2O5t
 jYNCyK0za2AwR9uBaoQEsz47pjk38M5JlMk+I3dyQirwK5n89g18myLAYFLKpp90Ol8Li+6Ivuz
 b86Nh6HWYqHUP1x95iYGf8fYSiyfYh11Adpo7U2UjAN95EZ2ZN+BY1gA==
X-Received: by 2002:a05:693c:6383:10b0:30c:5cdc:176 with SMTP id
 5a478bee46e88-30c5cdc0343mr4549511eec.1.1782319135062; 
 Wed, 24 Jun 2026 09:38:55 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c4ca21fsm427601eec.6.2026.06.24.09.38.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 09:38:54 -0700 (PDT)
Date: Wed, 24 Jun 2026 09:38:52 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liujie5@linkdatatechnology.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v6 00/23] net/sxe2: added Linkdata sxe2 ethernet driver
Message-ID: <20260624093852.145524c4@phoenix.local>
In-Reply-To: <20260624020211.3687062-1-liujie5@linkdatatechnology.com>
References: <20260622092731.3092201-1-liujie5@linkdatatechnology.com>
 <20260624020211.3687062-1-liujie5@linkdatatechnology.com>
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

On Wed, 24 Jun 2026 10:02:11 +0800
liujie5@linkdatatechnology.com wrote:

> From: Jie Liu <liujie5@linkdatatechnology.com>
> 
> This patch set implements core functionality for the SXE2 PMD,
> including basic driver framework, data path setup, and advanced
> offload features (VLAN, RSS,TM, PTP etc.).
> 
> V6:
> 	Refactored sxe2_ptype_tbl from adapter-indirection pattern (adapter->ptype_tbl[]) 
> 	to extern const direct-access pattern, matching txgbe PMD convention
> 
> 	All vector/SIMD Rx paths (SSE, AVX2, AVX512, NEON) index sxe2_ptype_tbl[] directly without local pointer indirection
> 
> 	remove flow_dup_pattern_mode devarg
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
>  doc/guides/nics/sxe2.rst                   |  147 ++
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
>  drivers/net/sxe2/sxe2_dump.c               |  300 +++
>  drivers/net/sxe2/sxe2_dump.h               |   12 +
>  drivers/net/sxe2/sxe2_ethdev.c             | 1468 ++++++++++++++-
>  drivers/net/sxe2/sxe2_ethdev.h             |  111 +-
>  drivers/net/sxe2/sxe2_ethdev_repr.c        |  609 ++++++
>  drivers/net/sxe2/sxe2_ethdev_repr.h        |   32 +
>  drivers/net/sxe2/sxe2_filter.c             |  895 +++++++++
>  drivers/net/sxe2/sxe2_filter.h             |  100 +
>  drivers/net/sxe2/sxe2_flow.c               | 1391 ++++++++++++++
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
>  67 files changed, 24733 insertions(+), 273 deletions(-)
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

On the duplicate flow devargs; your observation was correct, mlx5 has similar devarg option.
Sorry that I didn't strongly nudge AI in the right direction earlier.

To be clear:
  - sxe2 should use same devarg as mlx5 for this "allow_duplicate_pattern"
  - default should be 1
  - make sure documentation matches flag.

The patch looks much better; but there is a bisection breaking
patch ordering around 6 and 7.

After I pushed AI review to follow that, the review was the following:
(I means Claude AI, not me Stephen)

[PATCH v6 00/23] sxe2 driver feature additions

The flow-duplicate-pattern situation regressed in the wrong direction.

I reread mlx5's allow_duplicate_pattern in light of your "align to mlx5"
guidance and I was wrong to push for removal in v4 and v5. mlx5 has the same
devarg: name allow_duplicate_pattern, default 1, valid 0|1, and both values
expose a real hardware capability that rte_flow itself does not articulate
(value 0 -> EEXIST on duplicate; value 1 -> hardware queues duplicates as
shadow rules that activate when prior rules are deleted). That is not a
"standard API by boot flag" semantics violation as I had read it - it is a
hardware capability switch, and it is documented in doc/guides/nics/mlx5.rst
exactly the way sxe2's was. My v4-v5 push to drop it was based on a
misreading.

Unfortunately the v6 response is to half-remove the devarg in a way that is
worse than either keeping it or removing it cleanly:

[PATCH v6 22/23] flow-duplicate-pattern parsing removed, field left behind

Verified in the assembled tree:

  drivers/net/sxe2/sxe2_ethdev.h:138:
      uint8_t flow_dup_pattern_mode;          /* field still in struct */

  drivers/net/sxe2/sxe2_flow.c:806:
      rte_flow_error_set(error, EEXIST, ..., NULL,
                         adapter->devargs.flow_dup_pattern_mode ?
                         "Duplicate flow pattern." :
                         "Duplicate flow pattern is not allowed.");

  drivers/common/sxe2/sxe2_flow_public.h:603:
      uint8_t switch_pattern_dup_allow;       /* still in flow metadata */

The devarg's parser, default-setter, register_param_string entry, and
documentation are all gone, but the storage and the read site remain.
The field is zero-initialized and never written, so the ternary always picks
the "is not allowed" string. The hardware-capability path that the value=1
branch used to drive (setting switch_pattern_dup_allow on per-rule metadata)
has no caller now either. None of this is a correctness bug - duplicate
rules are uniformly rejected with EEXIST, which is the conservative
behaviour - but it is dead code that misleads the next reader.

Suggested fix: revert the v5-to-v6 changes that removed the parser and
docs, and instead align with mlx5:

  - Rename the devarg to allow_duplicate_pattern (underscore, matching
    mlx5's spelling).
  - Keep default = 1, matching mlx5's non-HWS default.
  - Reuse mlx5's documentation wording in sxe2.rst, adapted for the
    switch engine. The "only the first rule takes effect, the next
    activates when the first is deleted" semantic from mlx5.rst describes
    what the value=1 path does in hardware, and that wording is what was
    missing from v5's documentation.
  - Keep switch_pattern_dup_allow in flow metadata since it is what
    propagates the policy to the hardware programming path.

Or, if the cleaner path is preferred: actually finish the removal. Drop
flow_dup_pattern_mode from struct sxe2_devargs, replace the ternary in
sxe2_flow.c with the single "is not allowed" string, and drop
switch_pattern_dup_allow from struct (or wire it to a compile-time
constant if hardware programming truly needs it). Either direction is
defensible; the v6 in-between state is not.

[PATCH v6 06/23 and 07/23] patches posted in wrong order in the bundle

The bundle has 07/23 (drivers: support RSS feature) before 06/23
(net/sxe2: support L2 filtering and MAC config). git am applies them in
mbox order, so the series fails to apply: 07/23 depends on symbols 06/23
introduces. The fix is just to repost the bundle in numeric order;
contents are byte-identical to v5 for both patches. Worth fixing before
the next post because anyone running git am < bundle.mbox hits this.

Once the mbox order is fixed and the flow-duplicate-pattern situation is
resolved one way or the other, this is ready.

