Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BF3CD8CB9
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Jun 2026 17:13:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 72BAB42686;
	Wed, 10 Jun 2026 19:13:51 +0200 (CEST)
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182]) by mails.dpdk.org (Postfix) with ESMTP id 51674402BA
 for <dev@dpdk.org>; Wed, 10 Jun 2026 19:13:50 +0200 (CEST)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-304c520fe9aso2574234eec.0
 for <dev@dpdk.org>; Wed, 10 Jun 2026 10:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781111629;
 x=1781716429; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8tQ4UyNxvMUUL1n2hDSiiMRQ/nb92A/R8o6dQE0yy6c=;
 b=p2OuxflsbYVv87/ehA7te+jveaau1c9IH7NgVRWBufTL/LMzt46SJDnFDvQRvoCeOc
 ufasEOye5o/QwEQUuOnTIc7vieDD1IlWF8HWzYG8nFMVpSXrw0DzfW/g6N9vAfMMPmsp
 BCak9j3mvyDpGn4yqMM9dB1xGNnChHzg6+HuKTbIkOcu2684VbEHpg4/J1IGEJdS1+J7
 2icp59S7vwFIF8UhaIAoYjDuamkVGbcAuyIKbPegZhpoEZV1gvTpT0IM0kgQWxjZMa8o
 GDGEDQfE482Jd/2PRyvIcV9yCKbPhb33V3Xyk659rHpJZj0uMTf/pLMDXUY++u/Igk7t
 0XPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781111629; x=1781716429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8tQ4UyNxvMUUL1n2hDSiiMRQ/nb92A/R8o6dQE0yy6c=;
 b=k0dmr6xggkdmF5/lLMvi06zj7RgGrEHUDa16JDBbP2UHsByI6cq+uOG2LEdos9SsSA
 mT8Iq86gYgrPrOCCwHHUyrqPH94lVZsHeyZ1AFWdaDWuraTqVrC+oQK8uysjso/697x2
 3yKp95VM6w/w7RHhvM9YOWexIKtKN0CbhVmnH7Ew7W0xmaFEyPIAwIG3KDDB1QBWDWLK
 RJ3noLqgSLOSRADL4itJXLVyoY6/g7UrepK5L/oKIPFe7RXpiUS6nEp5YtqKizksKUBf
 Crgppu9So6d7yNSxa3Kz/J+BXMmGKpKjIEArBIbKQ2LM+4QASUcAQrgkRZ02iD/qe+QQ
 O4OQ==
X-Gm-Message-State: AOJu0YyynONfHRIdj621GWqTIiRAxvwEB/ldrqsc9d6meLe0Q/DzIKAH
 1MVbWbRd44u9ZMK9zvz5ymj9IACYkduDnIx1NjmuPDt+tBkgGM2qHy71zXWFdLZ6+qXcLoIVvhH
 V64or
X-Gm-Gg: Acq92OE9LeGVxYwHqzOi6HjTw/zRyDBpz+0wxOWAKvFBWRqPRxb81PTWf67PcrpTjBP
 S8Eul6hV9/liad1Vp1y3BVOu3lfu8AnpbCY08Jv/eEn3Rl3wp8oexeUX6/yXOJBvBIvcAV4GLA+
 brldwQgf0pFaKL83TLttWzvflod0ZqzK+BYGtnMU9hr/3QVgehz+OkwRT/xUdM/Id1aoS/OoYh0
 WNtJUV8rQnrhpwq43aT1W0chhI5n6GtQ1T3CAZovkz26KoimpPec4ND0Lf/UpzUjveWPpFiJdic
 sKyZln0GWSRn7H6tAPB8l6eWIaT3R6N8WHWzo+TVxNkJjlppR7QaWABDiib2OdyJ+zxyEO9ajH2
 YNSaIJu8LOyoXSA6YWz6NdInNGXLzBRpq+PumZ+uZSOvTH4BPIW8T4pPy9RRekQzlp+BZyh+c4Y
 Z3Nc7eXCFu2PINacRvR9HPoTKVFLCGlF7CjH7foYC94q/cfYX2hnL63OM0vHd9ByaojEBtPfXeC
 0k=
X-Received: by 2002:a05:7300:80c7:b0:2ed:e15:c926 with SMTP id
 5a478bee46e88-3077b8b5007mr18863123eec.34.1781111629063; 
 Wed, 10 Jun 2026 10:13:49 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074dcbe995sm33877206eec.13.2026.06.10.10.13.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 10:13:48 -0700 (PDT)
Date: Wed, 10 Jun 2026 10:11:40 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liujie5@linkdatatechnology.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v1 00/20] net/sxe2: added Linkdata sxe2 ethernet driver
Message-ID: <20260610101140.2eb767dd@phoenix.local>
In-Reply-To: <20260610013936.3634968-1-liujie5@linkdatatechnology.com>
References: <20260609013951.3359199-21-liujie5@linkdatatechnology.com>
 <20260610013936.3634968-1-liujie5@linkdatatechnology.com>
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

On Wed, 10 Jun 2026 09:39:16 +0800
liujie5@linkdatatechnology.com wrote:

> From: Jie Liu <liujie5@linkdatatechnology.com>
> 
> This patch set implements core functionality for the SXE2 PMD,
> including basic driver framework, data path setup, and advanced
> offload features (VLAN, RSS,TM, PTP etc.).
> 
> Jie Liu (20):
>   net/sxe2: support AVX512 vectorized path for Rx and Tx
>   net/sxe2: add AVX2 vector data path for Rx and Tx
>   drivers: add supported packet types get callback
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
>   drivers: add testpmd commands for private features
>   net/sxe2: update sxe2 feature matrix docs
> 
>  doc/guides/nics/features/sxe2.ini          |   56 +
>  drivers/common/sxe2/sxe2_common.c          |  156 ++
>  drivers/common/sxe2/sxe2_common.h          |    4 +
>  drivers/common/sxe2/sxe2_flow_public.h     |  633 +++++++
>  drivers/common/sxe2/sxe2_ioctl_chnl.c      |  178 +-
>  drivers/common/sxe2/sxe2_ioctl_chnl_func.h |   18 +
>  drivers/common/sxe2/sxe2_msg.h             |  118 ++
>  drivers/common/sxe2/sxe2_ptype.h           | 1793 ++++++++++++++++++
>  drivers/net/sxe2/meson.build               |   56 +-
>  drivers/net/sxe2/sxe2_cmd_chnl.c           | 1587 +++++++++++++++-
>  drivers/net/sxe2/sxe2_cmd_chnl.h           |  139 ++
>  drivers/net/sxe2/sxe2_drv_cmd.h            |  521 +++++-
>  drivers/net/sxe2/sxe2_dump.c               |  304 +++
>  drivers/net/sxe2/sxe2_dump.h               |   12 +
>  drivers/net/sxe2/sxe2_ethdev.c             | 1531 +++++++++++++++-
>  drivers/net/sxe2/sxe2_ethdev.h             |  112 +-
>  drivers/net/sxe2/sxe2_ethdev_repr.c        |  610 ++++++
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
>  drivers/net/sxe2/sxe2_flow_parse_pattern.c | 1935 ++++++++++++++++++++
>  drivers/net/sxe2/sxe2_flow_parse_pattern.h |   46 +
>  drivers/net/sxe2/sxe2_ipsec.c              | 1565 ++++++++++++++++
>  drivers/net/sxe2/sxe2_ipsec.h              |  254 +++
>  drivers/net/sxe2/sxe2_irq.c                | 1026 +++++++++++
>  drivers/net/sxe2/sxe2_irq.h                |   25 +
>  drivers/net/sxe2/sxe2_mac.c                |  535 ++++++
>  drivers/net/sxe2/sxe2_mac.h                |   84 +
>  drivers/net/sxe2/sxe2_mp.c                 |  414 +++++
>  drivers/net/sxe2/sxe2_mp.h                 |   67 +
>  drivers/net/sxe2/sxe2_queue.c              |   17 +-
>  drivers/net/sxe2/sxe2_rss.c                |  584 ++++++
>  drivers/net/sxe2/sxe2_rss.h                |   81 +
>  drivers/net/sxe2/sxe2_rx.c                 |   38 +
>  drivers/net/sxe2/sxe2_rx.h                 |    2 +
>  drivers/net/sxe2/sxe2_security.c           |  335 ++++
>  drivers/net/sxe2/sxe2_security.h           |   77 +
>  drivers/net/sxe2/sxe2_stats.c              |  591 ++++++
>  drivers/net/sxe2/sxe2_stats.h              |   39 +
>  drivers/net/sxe2/sxe2_switchdev.c          |  332 ++++
>  drivers/net/sxe2/sxe2_switchdev.h          |   33 +
>  drivers/net/sxe2/sxe2_testpmd.c            |  733 ++++++++
>  drivers/net/sxe2/sxe2_testpmd_lib.c        |  969 ++++++++++
>  drivers/net/sxe2/sxe2_testpmd_lib.h        |  142 ++
>  drivers/net/sxe2/sxe2_tm.c                 | 1169 ++++++++++++
>  drivers/net/sxe2/sxe2_tm.h                 |   78 +
>  drivers/net/sxe2/sxe2_tx.c                 |    7 +
>  drivers/net/sxe2/sxe2_txrx.c               |  176 +-
>  drivers/net/sxe2/sxe2_txrx.h               |    4 +
>  drivers/net/sxe2/sxe2_txrx_check_mbuf.c    |  595 ++++++
>  drivers/net/sxe2/sxe2_txrx_check_mbuf.h    |   38 +
>  drivers/net/sxe2/sxe2_txrx_poll.c          |  243 ++-
>  drivers/net/sxe2/sxe2_txrx_vec.c           |   46 +-
>  drivers/net/sxe2/sxe2_txrx_vec.h           |   38 +-
>  drivers/net/sxe2/sxe2_txrx_vec_avx2.c      |  776 ++++++++
>  drivers/net/sxe2/sxe2_txrx_vec_avx512.c    |  897 +++++++++
>  drivers/net/sxe2/sxe2_txrx_vec_common.h    |    1 +
>  drivers/net/sxe2/sxe2_txrx_vec_neon.c      |  721 ++++++++
>  drivers/net/sxe2/sxe2_vsi.c                |  146 ++
>  drivers/net/sxe2/sxe2_vsi.h                |   12 +-
>  drivers/net/sxe2/sxe2vf_regs.h             |   85 +
>  68 files changed, 26576 insertions(+), 124 deletions(-)
>  create mode 100644 drivers/common/sxe2/sxe2_flow_public.h
>  create mode 100644 drivers/common/sxe2/sxe2_msg.h
>  create mode 100644 drivers/common/sxe2/sxe2_ptype.h
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
>  create mode 100644 drivers/net/sxe2/sxe2_testpmd.c
>  create mode 100644 drivers/net/sxe2/sxe2_testpmd_lib.c
>  create mode 100644 drivers/net/sxe2/sxe2_testpmd_lib.h
>  create mode 100644 drivers/net/sxe2/sxe2_tm.c
>  create mode 100644 drivers/net/sxe2/sxe2_tm.h
>  create mode 100644 drivers/net/sxe2/sxe2_txrx_check_mbuf.c
>  create mode 100644 drivers/net/sxe2/sxe2_txrx_check_mbuf.h
>  create mode 100644 drivers/net/sxe2/sxe2_txrx_vec_avx2.c
>  create mode 100644 drivers/net/sxe2/sxe2_txrx_vec_avx512.c
>  create mode 100644 drivers/net/sxe2/sxe2_txrx_vec_neon.c
>  create mode 100644 drivers/net/sxe2/sxe2vf_regs.h
> 

I assume you meant v15 for this. The simple things first.
The code needs rebase against main and you need to run at a minimum the
full set of build tests: devtools/test-meson-builds.sh

Also, concerned that not all patches will bisect cleanly.
You should run a build at each step; yes that means 20 builds.

The amount of new devargs and testpmd functions concerns me.
Each new option increases the amount of options, and increases the probablity
of bugs. 

AI code review also found:

Deep-dive review of the latest sxe2 respin (01-20/20), including full
compilation of the assembled tree and per-commit bisect builds.

[09/20] drivers: interrupt handling

Error: patches 09/20 through 18/20 do not link. sxe2_irq.c (added by 09/20)
calls SXE2_DEV_TO_PCI() at lines 430 and 512, but that macro no longer exists:
upstream removed it from sxe2_ethdev.h in early June (it was present in the
May 29 tree, gone by June 8). Nothing in this series defines it. The series
only links from 19/20 onward, where the two calls are converted to
container_of(dev->device, struct rte_pci_device, device).

Verified empirically, not by patch inspection: I applied the series to a
June 8 upstream base (applies cleanly) and built at every one of the 20
commits. Commits 9-18 all fail with "undefined reference to SXE2_DEV_TO_PCI";
commits 19-20 link. Ten consecutive broken commits breaks git bisect.

This looks like rebase fallout from the upstream macro removal: the previous
revision removed the macro definition in 19/20 (correct when the base still
had it); after upstream deleted it, that hunk was dropped - but the
container_of conversion stayed in 19/20 instead of moving into 09/20 where
the calls are introduced. Fix: have 09/20 use RTE_DEV_TO_PCI(dev->device)
or container_of directly, and drop the conversion hunk from 19/20.

Also note the series needs a trivial rebase: 11/20 conflicts with the June 10
sxe2_common.c refactor on current main.


