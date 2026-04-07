Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0066FB5190
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Apr 2026 03:52:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D57E54025A;
	Tue,  7 Apr 2026 05:52:14 +0200 (CEST)
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
 by mails.dpdk.org (Postfix) with ESMTP id 8E86C4014F
 for <dev@dpdk.org>; Tue,  7 Apr 2026 05:52:13 +0200 (CEST)
Received: by mail-dl1-f48.google.com with SMTP id
 a92af1059eb24-128e4d0cc48so4784122c88.1
 for <dev@dpdk.org>; Mon, 06 Apr 2026 20:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775533932;
 x=1776138732; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kOQZhpf9KHWM3owC0yNBsCz9WH868IwH8vAeW7HbiCI=;
 b=hloOAsZxpJ7uFZIEafkQ4aiYZDU2m82o7w8ncAXCuy5LIFTc4g7ISqJuUGtNGAgyOX
 htC/v3tZLlWTnqsnBaRQplppyrLoWIV6ZBpr4bXGKUf9G5pCwpq5nx7B2pm1bbS+Y3zY
 7vk8IXLyGOZsJrC2fxlrh5ovQ2VOzO4ZTrDS7SyxOk1TTUgheF382HmrCmd1RV/PAEKB
 wlRMuCYNJ2xBOVd/LKHlJfZXZ55dpKyCXJm0VRwoIe1SzFBUoshcitWLuCRU6dXmeLLd
 4Nnr3bik5KEeaGmjQxwq/vxCfXUF/3Rn105qIguESDLFZz7ADcNZqeEV8O+1fcJg2P+/
 DamQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775533932; x=1776138732;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kOQZhpf9KHWM3owC0yNBsCz9WH868IwH8vAeW7HbiCI=;
 b=dN+M1wf+dSmIbCzgDP3P5fTqBAlGFr/BIHtmJ9zPg0PnhGjc6fXCF4t3zSfKJG+qBm
 7oTIuFdBAD4EIFKmnslmNsLXHMeN23jRIUEdYmoRAq8vE0Gh0qZKzI54DPCH3TPw4IUb
 tjPWiLI4RVzTywNTOEr8KQQy4rAIcIW9qRiu8uFBCpiveELs8444u7optDlT/rQg0u00
 SFPvi/8HLWUAPqudLywv0y2yb1umAmQZMw+3XC0O8gkQIktMVBpQqbSP+1lUytmAuegx
 wEuE32avIBHnjgibSQM9pbwTpiIxpIP8kVGitj4k8Cs3jWq45h9zGMNHmD4VRjuTLcZ3
 eH9A==
X-Gm-Message-State: AOJu0YyjoU396XnQ+dNiENPnNQF3pv4h82W7WZu0D52fwUZnZmCJjDm/
 Lr/mTXqXfW4kPOQeKpVVAQi0QzABtsWoiJBhu/AX4pjw7c7Kdl2VMXlSyvKeY7f0nSNIGZ350j9
 kSAel
X-Gm-Gg: AeBDiev5/9B78ikArAeYE2zC5ljM3fGNC+EjChE1gHXBxLeMKrQja+uNkAt6u7O5zFC
 dgVHtkxuvb14TLWgEHzE+vPPSHir/SD059nGmqqkciqn/4BuB5Yi3lceVCXQZSBCdym/BtynB72
 BisLaaceo3zc+xWeji1l9TnkUcyBSwksQYaRgjtl0/OGzUWL/Ls/J7FQf6DUmw0WvEmJBVy7BFx
 XdNtZ7jo5gzuGcRzel066P0iddAFyzniS26KtXL4zAl3A0hfIPo4hhahmfk6qFfNQY71sQzX3ee
 0eUTqjtf1cgPolfpzUWacarql56G7sjmg6V7dycHAErzc6AqMeIat94g9H8NI3uW7j0uUq1vMOc
 ewON1IjgK46eBeLD9G2EYFrReOnVSt9nwKOxShURZJ38uoHYHO2+QnCuV8tWalDN9BAZz7w9eNc
 EZfo70x2x4Y0wpvNhkkZ9/g8zNmEyOVdJr
X-Received: by 2002:a05:7022:f31a:b0:12c:8b9:7208 with SMTP id
 a92af1059eb24-12c08b973a1mr1993724c88.26.1775533932106; 
 Mon, 06 Apr 2026 20:52:12 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12bede545e8sm12716093c88.11.2026.04.06.20.52.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 20:52:11 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 00/23] examples: enable -Wshadow across all examples
Date: Mon,  6 Apr 2026 20:49:26 -0700
Message-ID: <20260407035209.650419-1-stephen@networkplumber.org>
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

All the patches are listed as fixes they are not worth
back porting so no Fixes: tag is given.

Stephen Hemminger (23):
  examples/ethtool: fix shadow variable warning
  examples/eventdev_pipeline: fix shadow variable warning
  examples/dma: fix shadow variable warnings
  examples/packet_ordering: fix shadow variable warning
  examples/bond: fix shadow variable warnings
  examples/vmdq: fix shadow variable warning
  examples/server_node_efd: fix shadowed variable
  examples/flow_filtering: fix shadowed variables
  examples/ipsec-secgw: fix shadowed variables
  examples/ip_pipeline: fix shadow variable
  examples/multi_process: fix shadowed variable
  examples/vm_power_manage: enable shadow warnings
  examples/bbdev_app: enable shadow warnings
  examples/ptpclient: fix shadow variable warnings
  examples/vhost: fix shadow warnings
  examples/qos_sched: eliminate shadowed variables
  examples/l2fwd-jobstats: fix shadowed variable
  examples/l2fwd-crypto: remove no shadow flag
  examples/l2fwd-event: remove no shadow flag
  examples/l2fwd-keepalive: fix shadow variable warning
  examples/l3fwd-graph: remove no shadow flag
  examples/l3fwd: fix shadow variable warnings
  examples/l3fwd-power: fix shadow variable warnings

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
 examples/ipsec-secgw/ipsec-secgw.c            |   3 +-
 examples/ipsec-secgw/ipsec.c                  |   3 +-
 examples/ipsec-secgw/ipsec.h                  |   1 -
 examples/ipsec-secgw/ipsec_worker.c           |  30 ++--
 examples/ipsec-secgw/ipsec_worker.h           |   4 +-
 examples/ipsec-secgw/meson.build              |   1 -
 examples/ipsec-secgw/sa.c                     |  34 ++---
 examples/l2fwd-crypto/meson.build             |   1 -
 examples/l2fwd-event/meson.build              |   1 -
 examples/l2fwd-jobstats/main.c                |   6 +-
 examples/l2fwd-jobstats/meson.build           |   1 -
 examples/l2fwd-keepalive/main.c               |   2 +-
 examples/l2fwd-keepalive/meson.build          |   1 -
 examples/l3fwd-graph/meson.build              |   1 -
 examples/l3fwd-power/main.c                   |  12 +-
 examples/l3fwd-power/meson.build              |   1 -
 examples/l3fwd/l3fwd.h                        |   2 +-
 examples/l3fwd/l3fwd_em.c                     |  32 ++--
 examples/l3fwd/l3fwd_em_hlm.h                 |   8 +-
 examples/l3fwd/l3fwd_lpm.c                    |   4 +-
 examples/l3fwd/l3fwd_route.h                  |  12 +-
 examples/l3fwd/main.c                         |  12 +-
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
 55 files changed, 216 insertions(+), 244 deletions(-)

-- 
2.53.0

