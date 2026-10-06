Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E42CA5FFC
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Oct 2026 15:54:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8B69140290;
	Tue,  6 Oct 2026 17:54:41 +0200 (CEST)
Received: from rcdn-iport-6.cisco.com (rcdn-iport-6.cisco.com [173.37.86.77])
 by mails.dpdk.org (Postfix) with ESMTP id 7B8A440262
 for <dev@dpdk.org>; Tue,  6 Oct 2026 17:54:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cisco.com; i=@cisco.com; l=4690; q=dns/txt;
 s=iport01; t=1791302079; x=1792511679;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=fnVGPnPd478vGRE2OPMDopXAGugejsaQMEhBRnzFyig=;
 b=EGLSlgiel+4JuYbn7vW3YEgu8uynZ10/8i5mrw9voIHgEjQ4+SunVHQx
 HgQwm8fjlKAHF9nhHDVhgzxA1YeybqK7LtuwVe+SF+rvPcvXm6Qdb4xEe
 vu/tEJ2dkfzRxy8w+Wlv1dcJhBkpYh060GT4f97czp5BYbEQoL0ErJ7Lv
 GN9no0UaV8IVWlafLTaGSbYYGSicd5FWO0j7MdnjTXhCsoI2TrsZumRwc
 KpwYVw7hZbKDy7rfljxQin9LS82sich55oxfggNc7DQlB/bUOzgWa8lxa
 wK/hxTXRgLBQzEJplLmOADMhYNPxU/kn/j498+26j/4VSkceHkfClx692 A==;
X-CSE-ConnectionGUID: 20mVXCUZT32CLdSvWZyq8g==
X-CSE-MsgGUID: XA8FGUtLSQOeKCGO2ulmpA==
X-IPAS-Result: =?us-ascii?q?A0AnAACAGMVq/5P/Ja1aHAEBAQEBAQcBARIBAQQEAQGBf?=
 =?us-ascii?q?AcBAQsBgheBNGFCSYRXiBuJWJ4dgX4PAQEBDzcaBAEBhQECAgKOCQImNAkOA?=
 =?us-ascii?q?QIEAwIDAQEBAQEBAQEBAQEBCgEBBQEBAQIBBwWBDhOGTw2QEwIBAyMPAUYQJ?=
 =?us-ascii?q?QImAgJGEIJDWAGCdAO2InqBMoEB3kiBdBQBgQouAYheAYFxhAiDXYEfJxUGg?=
 =?us-ascii?q?UlEgRUygzeELYNxgmoEgg2BDxKDJ4NBjlkJgUEcA1ksAVUTFwsHBWGBBQOBB?=
 =?us-ascii?q?m4yHYEjPhcvWBsGBYEdgQkEE4IWIxk2eoEJXoErKWABEBeBCYIHAoJUggACA?=
 =?us-ascii?q?UlBDgdFUwklQxJHJiIIEgkBExowC4EbODwJKEEXDBBtPTcVGQQ9kUMeghozD?=
 =?us-ascii?q?gUBLAQnN4EmORkNOSiXHa9ZhCiMIpVUM4VbpRSZCKlDgWg8gVlNIxWDIglKG?=
 =?us-ascii?q?Q+OKxmDAoRlgknFZSg1PwcCBw8CkXQBJgeBTwEB?=
IronPort-Data: A9a23:8NjkV66DUAAcYkClOuieCAxRtCXGchMFZxGqfqrLsTDasY5as4F+v
 jAXWG2GO/6LYTHwedF3b9u29EoHuZXdy9ZlHAFqpHpjZn8b8sCt6fZ1gavT04J+CuWZESqLO
 u1HMoGowPgcFyGa+1H1dOex9RGQ7InQLpLkEunIJyttcgFtTSYlmHpLlvUw6mJSqYDR7zil5
 5Wo/KUzBHf/g2QqazpMtfrZwP9SlK2aVA0w7wRWic9j5Dcyp1FNZLoDKKe4KWfPQ4U8NoaSW
 +bZwbilyXjS9hErB8nNuu6TnpoiG+O60aCm0xK6aoD66vRwjnVaPpUTaJLwXXxqZwChxLid/
 jniWauYEm/FNoWU8AgUvoIx/ytWZcWq85efSZSzXFD6I0DuKxPRL/tS4E4eZ9UdxNZcPFNyr
 qYzDDw2cC+xlvvmz+fuIgVsrpxLwMjDJogTvDRkiDreF/tjGMiFSKTR7tge1zA17ixMNa+BP
 IxCNnw1MUmGOkEQUrsUIMpWcOOAnGX+eDBwo1OOrq1x6G/WpOB0+OW2aoKPJofQH625mG6oj
 zLo0FnlJiojE9G84hWiqG+og/fmyHaTtIU6UefQGuRRqFGe2EQfEBEVE1yhrpGRik23X8hWA
 0kd4DQjqax0/0uuJvH7UxSyoXqcowQVXvJVGvck5QWJjKHT5m6xHXQJVj5MbvQgudMpQiYpz
 luUmtnkH3poqrL9YXeX3qyRpCmuIigcN2IZdDQYQA4epdLkpekOYgnnVN1vFuuxy9byAzy1m
 mjMpykljLJVhskOv0mmwW36b/uXjsChZmYICs//BwpJMisRiFaZWrGV
IronPort-HdrOrdr: A9a23:TkCL7K026Ns9o7wVgEHbRgqjBJIkLtp133Aq2lEZdPWaSKClfq
 eV7ZEmPH7P+VQssR4b9+xoVJPrfZqYz/5ICOoqTNOftXfd2VdARbsKheDfKn/bak7DH4Vmup
 uIHZISNPTASX5nkM39/A60V/wkwNWB7eSUoN229QYLcemvAJsQljuQzW2gYytLeDU=
X-Talos-CUID: 9a23:5rXNqGHl5iGiAytzqmI9rEsqKusYQEGGllz0L3SmNlR4Ue2aHAo=
X-Talos-MUID: =?us-ascii?q?9a23=3AHSUv7AyZ5H7OSbR4IygG2dnJ3FSaqJSHWG4irIk?=
 =?us-ascii?q?igPCjOA9bFBDHkTCyWqZyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,143,1787011200"; d="scan'208";a="532024322"
Received: from rcdn-l-core-10.cisco.com ([173.37.255.147])
 by rcdn-iport-6.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 06 Oct 2026 15:54:38 +0000
Received: from rtp-orb-10405.cisco.com (rtp-orb-10405.cisco.com [64.100.22.53])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by rcdn-l-core-10.cisco.com (Postfix) with ESMTPS id 313AB18000262;
 Tue,  6 Oct 2026 15:54:38 +0000 (GMT)
From: Randy L Tice <rtice@cisco.com>
To: dev@dpdk.org
Cc: Morten =?utf-8?q?Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Harman Kalra <hkalra@marvell.com>
Subject: [PATCH v4 0/1] mbuf: add runtime metadata dynamic-field storage
Date: Tue, 06 Oct 2026 11:54:37 -0400
Message-Id: <179130207755.4.10786861462241375385.v4-0000-cover-letter.patch@cisco.com>
In-Reply-To: <179061941387.2.17741463412422386825.v3-0000-cover-letter.patch@cisco.com>
References: <179061941387.2.17741463412422386825.v3-0000-cover-letter.patch@cisco.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
X-Outbound-Client-TLS: ANONYMOUS; rtp-orb-10405.cisco.com [64.100.22.53];
 TLSv1.2; ECDHE-RSA-AES256-GCM-SHA384; 256
X-Outbound-SMTP-Client: 64.100.22.53, rtp-orb-10405.cisco.com
X-Outbound-Node: rcdn-l-core-10.cisco.com
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

This revision changes direction from the v3 build-time dynfield3
layout.  It adds a runtime EAL-configured per-mbuf metadata area that is
placed after the fixed struct rte_mbuf header and before per-pool private
data.  This keeps sizeof(struct rte_mbuf) fixed while allowing deployments
that need globally consistent per-mbuf metadata to reserve that storage.

The metadata area is still managed by the mbuf dynamic-field registry.
Fields registered with RTE_MBUF_DYNFIELD_F_METADATA are allocated from the
metadata area and are not copied by generic mbuf copy, clone, or attach
operations.  Fields registered without the flag continue to use the existing
copied mbuf dynamic-field storage and cannot overlap the metadata area.

The existing per-pool private data area does not provide a central layout
registry and is configured independently for each mbuf pool.  That makes it
hard for multiple libraries, drivers, or application modules to safely share
metadata without out-of-band coordination, especially when pools are created
by different components.

Mbuf object layout calculations that need to include the optional metadata
area now use rte_mbuf_size().  The primary process validates and publishes
the metadata size through the shared mem config; secondary processes may
omit the option, but if provided it must match the primary value.

The octeontx mempool driver rejects allocation when mbuf metadata is
configured because the hardware mbuf header offset must remain 128 bytes.

Validation:
- git diff --check HEAD~1..HEAD
- devtools/check-git-log.sh -n1
- devtools/checkpatches.sh -n1
- ninja -C /tmp/dpdk-upstream-metadata-test-build -j8 app/dpdk-test
- app/dpdk-test --mbuf-metadata-size=384 mbuf_autotest
- app/dpdk-test --mbuf-metadata-size=512 mbuf_autotest
- focused scans for raw post-mbuf pointer arithmetic and direct
  sizeof(struct rte_mbuf) usage in changed files
- AGENTS.md plus dpdk-codereview review gate

Randy Tice (1):
  mbuf: add runtime metadata dynamic-field storage

 app/test-crypto-perf/cperf_test_common.c      |  8 +-
 app/test-pmd/testpmd.c                        |  2 +-
 app/test/suites/meson.build                   | 14 +++
 app/test/test_cryptodev.c                     |  4 +-
 app/test/test_cryptodev.h                     |  3 +-
 app/test/test_event_crypto_adapter.c          |  2 +-
 app/test/test_mbuf.c                          | 82 ++++++++++++++---
 app/test/test_pdcp.c                          |  2 +-
 doc/guides/linux_gsg/eal_args.include.rst     |  8 ++
 doc/guides/prog_guide/mbuf_lib.rst            | 16 ++++
 doc/guides/rel_notes/release_26_11.rst        | 21 ++++-
 drivers/crypto/cnxk/cn10k_cryptodev_ops.c     |  8 +-
 drivers/crypto/cnxk/cn20k_cryptodev_ops.c     |  8 +-
 drivers/event/cnxk/cn10k_worker.h             |  6 +-
 drivers/event/cnxk/cn20k_eventdev.c           |  2 +-
 drivers/event/cnxk/cn20k_worker.h             | 10 +--
 drivers/event/cnxk/cn9k_worker.h              | 23 ++---
 drivers/event/cnxk/cnxk_eventdev_adptr.c      |  2 +-
 drivers/mempool/dpaa/dpaa_mempool.c           |  2 +-
 drivers/mempool/dpaa2/dpaa2_hw_mempool.c      |  6 +-
 drivers/mempool/octeontx/meson.build          |  1 -
 .../mempool/octeontx/rte_mempool_octeontx.c   |  6 ++
 drivers/net/af_xdp/rte_eth_af_xdp.c           |  6 +-
 drivers/net/bnxt/bnxt_rxr.c                   |  2 +-
 drivers/net/bnxt/bnxt_txr.c                   |  2 +-
 drivers/net/cnxk/cn10k_ethdev_sec.c           |  2 +-
 drivers/net/cnxk/cn10k_rx.h                   | 58 +++++++------
 drivers/net/cnxk/cn20k_ethdev_sec.c           |  2 +-
 drivers/net/cnxk/cn20k_rx.h                   | 19 ++--
 drivers/net/cnxk/cnxk_eswitch.c               |  4 +-
 drivers/net/cnxk/cnxk_ethdev.c                |  6 +-
 drivers/net/cnxk/cnxk_ethdev_dp.h             |  2 +-
 drivers/net/cnxk/cnxk_ethdev_sec.c            |  6 +-
 drivers/net/intel/fm10k/fm10k_ethdev.c        |  2 +-
 drivers/net/mlx5/mlx5_trigger.c               |  6 +-
 drivers/net/nfp/flower/nfp_flower.c           |  2 +-
 drivers/net/nfp/nfp_rxtx.c                    |  2 +-
 drivers/net/pfe/pfe_hif.c                     |  2 +-
 drivers/net/pfe/pfe_hif_lib.c                 |  4 +-
 drivers/net/sfc/sfc_rx.c                      |  2 +-
 drivers/net/softnic/rte_eth_softnic_mempool.c |  4 +-
 examples/fips_validation/fips_validation.h    |  2 +-
 examples/fips_validation/main.c               |  2 +-
 examples/ntb/ntb_fwd.c                        |  2 +-
 lib/cryptodev/rte_crypto.h                    |  4 +-
 lib/eal/common/eal_common_config.c            |  3 +
 lib/eal/common/eal_common_mcfg.c              | 16 +++-
 lib/eal/common/eal_common_options.c           | 20 +++++
 lib/eal/common/eal_internal_cfg.h             |  3 +
 lib/eal/common/eal_memcfg.h                   |  4 +-
 lib/eal/common/eal_option_list.h              |  1 +
 lib/eal/common/eal_private.h                  |  1 +
 lib/eal/freebsd/eal.c                         |  3 +-
 lib/eal/linux/eal.c                           |  3 +-
 lib/mbuf/mbuf_history.c                       |  4 +-
 lib/mbuf/rte_mbuf.c                           | 17 ++--
 lib/mbuf/rte_mbuf.h                           |  9 +-
 lib/mbuf/rte_mbuf_core.h                      | 37 ++++++++
 lib/mbuf/rte_mbuf_dyn.c                       | 87 +++++++++++++++----
 lib/mbuf/rte_mbuf_dyn.h                       | 11 ++-
 lib/pcapng/rte_pcapng.c                       |  2 +-
 lib/vhost/vhost.h                             |  2 +-
 62 files changed, 438 insertions(+), 164 deletions(-)

-- 
2.35.6

