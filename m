Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 841E0FF5106
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Apr 2026 15:17:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A571B40265;
	Tue,  7 Apr 2026 17:17:42 +0200 (CEST)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by mails.dpdk.org (Postfix) with ESMTP id AB0824025F
 for <dev@dpdk.org>; Tue,  7 Apr 2026 17:17:40 +0200 (CEST)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-c70fb6aa323so1851671a12.3
 for <dev@dpdk.org>; Tue, 07 Apr 2026 08:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775575060;
 x=1776179860; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hKTBVN8Y5/6ng4XquO2TpBUFhR59h+OPOnQfXtUwhaM=;
 b=ipiOfZSUZPDkMgumT9GtHUe+Bfxg17XirEpx8hMLzc3CrWoiSgzYOW9RBtPUkfSOtQ
 GoeoCBmr93SBsZneZLy/YTi73PkYz1KZOCi478QFH0jhDxRPUydxyxrhdq/oBe7dUuta
 KVPaDNdVLhiriLBZdf7sz/yAu2qqZYudrzsUnPFJi62w210JBqFgJDCJq0672Ey8iag4
 oYf93VHZxfay+1bFzMhGtMpGVERzG7cHvXPGBYMxE4oI15XJ7Ml5b3+GutDdOkhoa8B5
 pjk3UddNc1oD2YMFy25Zd4wN6kSQEjedW/PncKiS+aY1eBGy1yL3wXUeETfUsdnP1bYN
 3Pwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775575060; x=1776179860;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hKTBVN8Y5/6ng4XquO2TpBUFhR59h+OPOnQfXtUwhaM=;
 b=XBscMAwBLIlNC+WG1ZkEtRDzRYxQ62xJvIO982zeQvt0vsNUtpFSnF8pJbLa+veC4r
 xVkOdxjAZLEkn85Mp+2SO6CSzLrNzTAH09pW4EWtaw03FoMbuYmR5V8NVo3WRPmfXS71
 CBxIUR3AFtuwe8rt5Bb0/DwHoCBRNuLtO3QoS9sjVvEFZit15CuEzzZAPMrOEyIB46w1
 RE2vdZNYhIGEdwqDUlE3cr3tY8ym6qmK3PEQMJlRDAuZ1j9vd9GGt2YE8ikuRB5EMb4E
 ItTetCZjomfI5fPBqyvf8WgPdhAVuLHHSubzw1yq/krm+dLbZXsyPgDwdIM6rtDTgC1a
 WIRA==
X-Gm-Message-State: AOJu0YymK38YdFGF65OgYBcQACQvJTLOnnefzQAU5k/uE/NX0rc+zzl6
 XfHY4hbWz2fL3EKddCfj4/OFwsObtzE2WAA5IynhbbKQCF+/4CTsxs+nq8vlz6IRjQqpExFhvdD
 5QrwU
X-Gm-Gg: AeBDietBccswh3gumkLoOZjylzMNFhXBuXTut6m7r0xohYbUQYnBIw1JQUXlNEfEMCz
 RVsPXSHknOc01lOMtGL5TOwZFpwhAmQI8FBOLDk8bmX3DZmp5Cvdi/hO69Q+46lryxqr+hc5T9c
 heeCalZInsyY5JO65QG9SfC+xrOYVBoxxqH7bIrwYSbn/OaqNVpOL0s4s0wV6Jlgqkux97FWoqD
 ED0Bk9UBuH0ktrr+Q24mN3QpVSGnX5RofsW18qdPvjuNZhVP+LCpjQCfOCGR6OOYwrQLUCA94+i
 iqaMwMtdZpNjMcg9jIUysZhhnKIHuevouLoMLhX9Q2oy8d6p/ZpGW+blyWtQeIjUdCBCm5EnmK9
 3pHP/SBAkKaaXG5InwkdGecZiXRfc56tsI6zhbW2xgAoDpK8np7cEBT2Yj/IgCwdspBuMoJryn4
 R2mx75kn9SrIueIIDForQ9iFQlZJIkYjov
X-Received: by 2002:a05:6a20:12c5:b0:398:7357:bb81 with SMTP id
 adf61e73a8af0-39f2ee56b16mr18303142637.15.1775575059603; 
 Tue, 07 Apr 2026 08:17:39 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76c6477bbcsm15842933a12.3.2026.04.07.08.17.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 08:17:39 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 00/23] examples: fix -Wshadow warnings
Date: Tue,  7 Apr 2026 08:15:56 -0700
Message-ID: <20260407151732.272195-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407035209.650419-1-stephen@networkplumber.org>
References: <20260407035209.650419-1-stephen@networkplumber.org>
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

Several DPDK examples had -Wshadow disabled via no_shadow_cflag in
their meson.build files. This series fixes all shadow variable
warnings and removes the suppression flag, so that -Wshadow is
enabled uniformly across every example.

The fixes fall into three categories:
 - Renaming function parameters or local variables that shadow
   globals (most patches)
 - Removing unused function parameters that duplicated globals
   (dma, bond, flow_filtering, ipsec-secgw, vhost, qos_sched)
 - Simply removing no_shadow_cflag where there were no warnings
   (vm_power_manage, bbdev_app, l2fwd-crypto, l2fwd-event,
   l3fwd-graph)

v2 - fix additional shadow warnings only visible with clang

Stephen Hemminger (23):
  examples/ethtool: resolve shadow variable warnings
  examples/eventdev_pipeline: resolve shadow variable warning
  examples/dma: resolve shadow variable warnings
  examples/packet_ordering: resolve shadow variable warning
  examples/bond: resolve shadow variable warnings
  examples/vmdq: resolve shadow variable warning
  examples/server_node_efd: resolve shadow variable warning
  examples/flow_filtering: resolve shadowed variable warnings
  examples/ipsec-secgw: resolve shadowed variable warnings
  examples/ip_pipeline: resolve shadow variable warning
  examples/multi_process: resolve shadowed variable warnings
  examples/vm_power_manage: enable shadow warnings
  examples/bbdev_app: enable shadow warnings
  examples/ptpclient: resolve shadow variable warnings
  examples/vhost: resolve shadow warnings
  examples/qos_sched: eliminate shadowed variables
  examples/l2fwd-jobstats: resolve shadowed variable
  examples/l2fwd-crypto: resolve shadow variable
  examples/l2fwd-event: resolve shadowed variable
  examples/l2fwd-keepalive: resolve shadow variable warning
  examples/l3fwd-graph: resolve shadow variable warning
  examples/l3fwd: resolve shadow variable warnings
  examples/l3fwd-power: resolve shadow variable warnings

 examples/bbdev_app/main.c                     |   4 +-
 examples/bbdev_app/meson.build                |   1 -
 examples/bond/main.c                          |  21 ++-
 examples/bond/meson.build                     |   1 -
 examples/dma/dmafwd.c                         |  10 +-
 examples/dma/meson.build                      |   1 -
 examples/ethtool/ethtool-app/main.c           |   4 +-
 examples/ethtool/meson.build                  |   1 -
 examples/eventdev_pipeline/meson.build        |   1 -
 .../eventdev_pipeline/pipeline_worker_tx.c    |   4 +-
 examples/flow_filtering/flow_skeleton.c       |  10 +-
 examples/flow_filtering/main.c                |   4 +-
 examples/flow_filtering/meson.build           |   1 -
 examples/ip_pipeline/cli.c                    |   9 +-
 examples/ip_pipeline/meson.build              |   1 -
 examples/ipsec-secgw/ipsec-secgw.c            |  17 +--
 examples/ipsec-secgw/ipsec.c                  |   3 +-
 examples/ipsec-secgw/ipsec.h                  |   1 -
 examples/ipsec-secgw/ipsec_worker.c           |  30 ++--
 examples/ipsec-secgw/ipsec_worker.h           |   4 +-
 examples/ipsec-secgw/meson.build              |   1 -
 examples/ipsec-secgw/sa.c                     |  34 ++---
 examples/l2fwd-crypto/main.c                  |  50 +++----
 examples/l2fwd-crypto/meson.build             |   1 -
 examples/l2fwd-event/main.c                   |  15 +-
 examples/l2fwd-event/meson.build              |   1 -
 examples/l2fwd-jobstats/main.c                |   6 +-
 examples/l2fwd-jobstats/meson.build           |   1 -
 examples/l2fwd-keepalive/main.c               |   2 +-
 examples/l2fwd-keepalive/meson.build          |   1 -
 examples/l3fwd-graph/main.c                   |   8 +-
 examples/l3fwd-graph/meson.build              |   1 -
 examples/l3fwd-power/main.c                   |  12 +-
 examples/l3fwd-power/meson.build              |   1 -
 examples/l3fwd/l3fwd.h                        |   2 +-
 examples/l3fwd/l3fwd_em.c                     |  32 ++--
 examples/l3fwd/l3fwd_em_hlm.h                 |   8 +-
 examples/l3fwd/l3fwd_lpm.c                    |   4 +-
 examples/l3fwd/l3fwd_route.h                  |  12 +-
 examples/l3fwd/main.c                         |  68 ++++-----
 examples/l3fwd/meson.build                    |   1 -
 .../client_server_mp/mp_server/args.c         |  12 +-
 .../client_server_mp/mp_server/meson.build    |   1 -
 examples/packet_ordering/main.c               |   6 +-
 examples/packet_ordering/meson.build          |   1 -
 examples/ptpclient/meson.build                |   1 -
 examples/ptpclient/ptpclient.c                | 138 +++++++++---------
 examples/qos_sched/cfg_file.c                 |  12 +-
 examples/qos_sched/cfg_file.h                 |   4 +-
 examples/qos_sched/init.c                     |   4 +-
 examples/qos_sched/meson.build                |   1 -
 examples/server_node_efd/efd_server/args.c    |   6 +-
 .../server_node_efd/efd_server/meson.build    |   1 -
 examples/vhost/main.c                         |  19 +--
 examples/vhost/meson.build                    |   1 -
 .../vm_power_manager/guest_cli/meson.build    |   1 -
 examples/vm_power_manager/meson.build         |   1 -
 examples/vmdq/main.c                          |   8 +-
 examples/vmdq/meson.build                     |   1 -
 59 files changed, 288 insertions(+), 319 deletions(-)

-- 
2.53.0

