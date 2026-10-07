Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B08CCA6004
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 21:41:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D110742798;
	Wed,  7 Oct 2026 23:41:22 +0200 (CEST)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by mails.dpdk.org (Postfix) with ESMTP id 7EAF840265
 for <dev@dpdk.org>; Wed,  7 Oct 2026 23:41:19 +0200 (CEST)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-2dd1dcdcf95so400915ad.1
 for <dev@dpdk.org>; Wed, 07 Oct 2026 14:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791409279;
 x=1792014079; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=75bOyeBd/D8nAK6H4U4FZHmOTlcvRJYR6gpziIkwWmU=;
 b=mUkdLyBqMrPlNd0uZGf9htyjDZqLQbaNwRhKdufPYzWabJfot+rn0Ux5XHGHrSWr6L
 0F6CDd5GRAXRoS5bLtujua8iuOzL3D/1l/LQU34Dq5CQ99O/yHON7dLUvlVZWBiLmdYb
 nK6cxvlxkl+lsQ5wmQ5V/nWFV+1CfOW07LEzezbiyrBS38vl89yCJWf7M59KpjVC8OLE
 9bcsDJL0muqT5/+kB3uqEv1jaSdSPWESGgixcRnF+7TGyK2HkLCIl+YUyDI1PzXkJszS
 8bXpi7nVd7t2kN3ns9uDRqGZ2tFkG76IWghBzvSiha6UPjuaalRzXw+XhKwd5ZliBi2E
 j1+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791409279; x=1792014079;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=75bOyeBd/D8nAK6H4U4FZHmOTlcvRJYR6gpziIkwWmU=;
 b=NKKL83FrjZE3YZ4ySkybYsXwZo7ZyeuIGsq3HWxewQKI/dOsfJMx1o6oroJsWRAeQA
 3QSAE/4SEqwoWj9rhr28DYJw7/tGxM/mvpC003iTgFqORVrVywf2fKuPYWRKfgrGtpWG
 8PyYzSqeeKvlwl2k6DJQnFieXGZ9bGkPDLrUSRG1XXGcV6Y0ysjXvmAHE46WIoEHubYB
 AFPKo946Z/8uEIrUCq8TwiFJkFWZie4xfDLE2djBXDVQi2bI8YyF4aYu6AflToHcBr8o
 9CVu4C4zzNfgbiGXn1UR+6vOqpqOb+pSMHd4/BvWXIj1Fr2nw4C4sC/GV2QSPMMgaOtb
 9oGA==
X-Gm-Message-State: AFq9FYKkcJw6Rcgwne+ejbhkqO+s5pxN8Gj0yBjL6ufsi2TytYjy55Mn
 pGh4AnF7kvLhaqUg2iLHPZ0RJT7Kire51ASs4w6Pv05oLkMqCQxuMSmcCd7GRRHOaiae9Bh19PH
 NKVBftyA=
X-Gm-Gg: AYBFou3W3MtZnfQeBPC/jSpec2jFhTvDMnJrx450UySIXsiVRAOlKHJ2O+rWEqooJ9f
 GloMDe8+AlP7byaiaEZNAiahXoTiwOd9RghPlIuX7H0RFFYiQa8zJZrp7xPhI3fgPfv0XQ0QoJg
 PeG/+6gpzRDoZejSe2ZwykWarSj9tDhsnL+tWhNhhu+M2f2jOsYqwUVl9LyBADZWmjIfBE92CfE
 08YrZGHyTN8Tz/REgxhQpRMRUVmhqv7L6+2luHVefuf+6p5ElqCb5kZzUHApfgHJzzCSqnm82on
 p2ONotTj7WxvObDiE65QZ5D6IuJP5O6QUJz+domNDOK5JREGSjSAHPDHsiKey95aI5PzycO3FBd
 MvSV7t93IQWuWNr+HH0FSVudteaNCXDRsp9TJIHD3QzM16BEDnTOy7LQEyYtReMG6DtoEyW085D
 TIBgBAaxkMvw1YJKo2teSetxZbvmH2XsxTSmpKCn7rq23qY03bAR8vomaLxxQ0ZX2ktpHirqqsQ
 JS0jia3yKZE1lL7iGr5ikFzr7qWKDTICilYckb1Rj0Wdk9+GA==
X-Received: by 2002:a17:902:ef01:b0:2e6:e9a:eb48 with SMTP id
 d9443c01a7336-2e7ffe98eabmr2830435ad.41.1791409278368; 
 Wed, 07 Oct 2026 14:41:18 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e60484ca89sm16573335ad.57.2026.10.07.14.41.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 14:41:17 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 00/20] promote long standing experimental API to stable
Date: Wed,  7 Oct 2026 14:39:30 -0700
Message-ID: <20261007214115.3092715-1-stephen@networkplumber.org>
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

The experimental tag is supposed to be temporary: a way to ship an API
while its shape is still being settled. In practice many symbols keep
the tag long after the interface has stopped changing. That discourages
use, because applications reasonably avoid an API that advertises it may
disappear, and it hides the small number of APIs that really are still
in flux.

This series promotes 196 symbols across fifteen libraries. The oldest
date from 20.11 and the bulk are three years old or more. In every case
the prototype has not changed since it was introduced, and most are in
use by in-tree applications, examples or drivers.

By introduction release:

  20.11  SWX port, table and pipeline API
  21.05  SWX fd and ring ports, wildcard match table,
         cryptodev raw enqueue/dequeue and mbuf-to-vec helpers
  21.08  SWX selector table
  21.11  SWX learner table
  22.07  SWX hash function registration, learner timeout and rearm
  22.11  SWX pipeline lookup and code generation
  23.03  SWX RSS and IPsec, cryptodev algorithm name helpers
  23.07  pdcp library, node ip6 route and rewrite
  23.11  dispatcher library, node ip4 reassembly and udp4 input,
         power uncore environment and frequency list
  24.03  argparse parse and parse_type, node ethdev rx next update
  24.07  hash RCU queue reclaim, mempool memory range and
         object alignment getters
  24.11  power PM QoS, thash key generation, eal lcore variables,
         cryptodev asymmetric opcap check
  25.03  soring enqueue, dequeue, acquire and release,
         cmdline bool token ops
  25.07  node ip4/ip6 FIB and mbuf dynfield register,
         rte_memzero_explicit, rte_free_sensitive, rte_size_to_str
  25.11  argparse print_help, rte_basename,
         ethdev link connector to string

Where a library had nothing left to keep experimental the file level
"all functions in this file may be changed or removed" warnings are
dropped as well, along with the then unused rte_compat.h includes.

The node library deserves a note. Most of its headers carried that file
level warning while rte_node_ip4_route_add() and rte_node_ip4_rewrite_add()
sat underneath it as stable exports, so the warning was already wrong.
The whole library is promoted. An API that cannot be declared stable
after several releases of use is not helping anyone, and should be
removed rather than left in limbo.

Deliberately left experimental:

  - trace point symbols (__rte_*_trace_*) in eal, ethdev, eventdev,
    cryptodev, dmadev, bbdev and mempool
  - debug and dump output whose format may still change:
    rte_soring_dump, rte_ring_headtail_dump, rte_bbdev_queue_ops_dump,
    rte_bbdev_ops_param_string and rte_bbdev_ops_trace
  - APIs with only one implementation, where the interface should not
    be frozen before a second driver has tried to use it.
  - the metrics rte_metrics_tel_* API, which has no in-tree users and
    should be deprecated rather than promoted; a deprecation notice
    will be sent separately
  - new subsystems that have not had a release of real use: the
    eventdev vector adapter, the graph feature arc and the pmu
    library (all 25.07), and the dmadev access pair group API (25.11)
  - the soring peek API, rte_eth_get_queue_rate_limit,
    rte_mempool_stats_reset and rte_bbdev_queue_stats_get, added in
    26.07
  - rte_cpu_socket_id, added this release
  - rte_event_eth_rx_adapter_queues_add, deferred in commit
    42235267000c ("eventdev/eth_rx: promote adapter API to stable")
  - eal rte_vfio_get_device_info, left alone while the VFIO rework is
    in progress
  - rte_str_skip_leading_spaces, a static inline in rte_string_fns.h
    with no exported symbol; it can follow separately
  - mbuf history API; debug and new in 25.11

No change in functionality, and test results are the same as
before these changes.

Stephen Hemminger (20):
  eal: add missing export for rte_basename
  eal: promote rte_basename to stable
  eal: promote explicit zero and sensitive free to stable
  eal: promote rte_size_to_str to stable
  eal: promote lcore variables API to stable
  cmdline: promote bool token ops to stable
  ethdev: promote link connector to string to stable
  port: promote SWX port API to stable
  table: promote SWX table API to stable
  pipeline: promote SWX IPsec API to stable
  pipeline: promote SWX pipeline and control API to stable
  power: promote PM QoS and uncore API to stable
  ring: promote soring API to stable
  dispatcher: promote API to stable
  argparse: promote API to stable
  node: promote API to stable
  hash: promote RCU reclaim and thash key generation to stable
  cryptodev: promote algorithm helpers to stable
  pdcp: promote API to stable
  mempool: promote memory range and alignment to stable

 doc/guides/rel_notes/release_26_11.rst |  50 ++++++++-
 lib/argparse/rte_argparse.c            |   6 +-
 lib/argparse/rte_argparse.h            |  13 ---
 lib/cmdline/cmdline_parse_bool.c       |   2 +-
 lib/cryptodev/rte_crypto_sym.h         |   2 -
 lib/cryptodev/rte_cryptodev.c          |  10 +-
 lib/cryptodev/rte_cryptodev.h          |  10 --
 lib/dispatcher/rte_dispatcher.c        |  26 ++---
 lib/dispatcher/rte_dispatcher.h        |  18 ---
 lib/eal/common/eal_common_lcore_var.c  |   2 +-
 lib/eal/common/eal_common_memory.c     |   2 +-
 lib/eal/common/eal_common_string_fns.c |   2 +-
 lib/eal/common/rte_malloc.c            |   2 +-
 lib/eal/include/rte_common.h           |   4 -
 lib/eal/include/rte_lcore_var.h        |   3 -
 lib/eal/include/rte_malloc.h           |   4 -
 lib/eal/include/rte_memory.h           |   4 -
 lib/eal/include/rte_string_fns.h       |   4 -
 lib/eal/unix/rte_basename.c            |   2 +-
 lib/eal/windows/rte_basename.c         |   2 +
 lib/ethdev/rte_ethdev.c                |   2 +-
 lib/ethdev/rte_ethdev.h                |   4 -
 lib/hash/rte_cuckoo_hash.c             |   2 +-
 lib/hash/rte_hash.h                    |   1 -
 lib/hash/rte_thash.c                   |   2 +-
 lib/hash/rte_thash.h                   |   4 -
 lib/mempool/rte_mempool.c              |   4 +-
 lib/mempool/rte_mempool.h              |   8 --
 lib/node/ethdev_ctrl.c                 |   2 +-
 lib/node/ip4_lookup_fib.c              |   4 +-
 lib/node/ip4_reassembly.c              |   2 +-
 lib/node/ip6_lookup.c                  |   2 +-
 lib/node/ip6_lookup_fib.c              |   4 +-
 lib/node/ip6_rewrite.c                 |   2 +-
 lib/node/node_mbuf_dynfield.c          |   2 +-
 lib/node/rte_node_eth_api.h            |   6 -
 lib/node/rte_node_ip4_api.h            |   9 --
 lib/node/rte_node_ip6_api.h            |   9 --
 lib/node/rte_node_mbuf_dynfield.h      |   6 -
 lib/node/rte_node_pkt_cls_api.h        |   4 -
 lib/node/rte_node_udp4_input_api.h     |   8 --
 lib/node/udp4_input.c                  |   4 +-
 lib/pdcp/rte_pdcp.c                    |  10 +-
 lib/pdcp/rte_pdcp.h                    |  29 -----
 lib/pdcp/rte_pdcp_group.h              |   6 -
 lib/pipeline/rte_swx_ctl.c             |  34 +++---
 lib/pipeline/rte_swx_ctl.h             |  61 -----------
 lib/pipeline/rte_swx_ipsec.c           |  14 +--
 lib/pipeline/rte_swx_ipsec.h           |   8 --
 lib/pipeline/rte_swx_pipeline.c        | 146 ++++++++++++-------------
 lib/pipeline/rte_swx_pipeline.h        |  32 ------
 lib/port/rte_swx_port_ethdev.c         |   4 +-
 lib/port/rte_swx_port_fd.c             |   4 +-
 lib/port/rte_swx_port_ring.c           |   4 +-
 lib/port/rte_swx_port_source_sink.c    |   6 +-
 lib/power/rte_power_qos.c              |   4 +-
 lib/power/rte_power_qos.h              |  10 --
 lib/power/rte_power_uncore.c           |   8 +-
 lib/power/rte_power_uncore.h           |   5 -
 lib/ring/rte_soring.c                  |   4 +-
 lib/ring/rte_soring.h                  |  72 ------------
 lib/ring/soring.c                      |  32 +++---
 lib/table/rte_swx_table_em.c           |   4 +-
 lib/table/rte_swx_table_learner.c      |  20 ++--
 lib/table/rte_swx_table_learner.h      |  12 --
 lib/table/rte_swx_table_selector.c     |  12 +-
 lib/table/rte_swx_table_selector.h     |   8 --
 lib/table/rte_swx_table_wm.c           |   2 +-
 68 files changed, 248 insertions(+), 562 deletions(-)

-- 
2.53.0

