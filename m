Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5402C02198
	for <dpdk-dev@archiver.kernel.org>; Sat,  8 Feb 2025 20:31:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 78416402B7;
	Sat,  8 Feb 2025 21:31:55 +0100 (CET)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51]) by mails.dpdk.org (Postfix) with ESMTP id 8203D402A0
 for <dev@dpdk.org>; Sat,  8 Feb 2025 21:31:54 +0100 (CET)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-2f9d627b5fbso5842997a91.2
 for <dev@dpdk.org>; Sat, 08 Feb 2025 12:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739046713;
 x=1739651513; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qLvkKD+ESV5jjiXRZecf18JwJOK2TedQ2Ym7V7aJL0w=;
 b=ryHk7RIRU7H/ru6ygOoo/TjzWYOtQ7vlcd8W1a2ajA9+je3wEQ/sHQG2UNDuVBLMXq
 R3D16pajw8stdcCeyy6D5aovgfVi+NEQJoCJYAvY91Zgprxjx7ews8jROj80xmskm+cS
 cHJhg57vYObExppCosaXdZkvbhIgg465FelDB3/ByLFhyoNW3Ojs7V71rPvdAXjE1Rjm
 qDyEEa5OURGxCeZGFBJ7L/JAz0F5ZdvzMmP/3INzUUXigI6HU4TI8wnZqIXnYD0GsCma
 O4RTKycJ5mE423XtZeOn+MPrxV/F8Y5lawhEIUFOXH486vpa3SKsGDbU69BBIPjsB0P2
 YaJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739046713; x=1739651513;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qLvkKD+ESV5jjiXRZecf18JwJOK2TedQ2Ym7V7aJL0w=;
 b=YQclRFEW+2CE3gIdCjp/7kr8nZk82Xt/jzkipK400TQEQy0Dn0lVo9HDmSejJLz0th
 FfLRC5YeKzvzPYiPiZO6qf9x2FNW2Y7SG5fiwGs7Hd9n/gnafW2pJTJQzHUfADrCQkwf
 4fiXlWcVqimPr4/ZeF85h2yASI44/QvkGQ+F3eCxfwzx8o7JFki9stnhgeoZ6B0V2cqX
 AD0hvhYr+6j5PbF/x3dHAvGokxiq4Z3klkcJ+R/lFxQQzlV0UJ2Zz687p4ft/lOUZHDb
 OWSBaak9OZhJp9aimaq4CQfIRvSIOGXxQjPeiyopjMnWSXNhjoXzowNIkGBfVYtKJwKV
 QDMg==
X-Gm-Message-State: AOJu0Yzs5gb29XdqPzY3qTdMbby0ssULMJ7+Acs/ippPMjKRF5oZVIdC
 cC70HybzlNX1kXyMakwweEepbGF+1aDwQQGrX0iTDqYIvrs9iVhdORIcSiWY4QpwvnAvL6jvhZ4
 qhMQ=
X-Gm-Gg: ASbGncsrIm55nDFOzPOkXJSoa/3XsXwDhku3QaBFxoF/mToLcy7ei77en3rMW02++H3
 JEx2poNTUJBQEji/GYy1ECinW4SXU6xQT+KO4rCIf72B/UiXloUGXqIQpA1yJJfA8GBOjebdzxy
 PD+LnqG8ruWjyO9dw+uHW1n/42pOtgSTWLN37Sz+RlUhK1Mcnz/GCmUQ0/CeR5+kF+QbqqAgHPD
 impcCYGxpUYtqXWWZsqlTBhK+hzvVo7SQuPeNgMz8YIeUvIZoHM/5H3GrLth17tZQa0ilOmnP5K
 NG6Kg0l/qSBnQKlfXkfIBbXu6VYsNNbxVNUc4Mp+xXWGFPR6Wvg0cz5PCV/NJJOKRPjx
X-Google-Smtp-Source: AGHT+IEOS2EE+DE/iVAF9/AxJeuAqPUOmBBuindFTsEL2NYCj2KEioFnA/EHgZReRPbvdQtuRYfTNQ==
X-Received: by 2002:aa7:88cb:0:b0:727:3b77:4174 with SMTP id
 d2e1a72fcca58-7305d53aa2dmr13458559b3a.23.1739046713001; 
 Sat, 08 Feb 2025 12:31:53 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7304c780da5sm4882019b3a.69.2025.02.08.12.31.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 12:31:52 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 00/32] Use structure assignment instead of memcpy
Date: Sat,  8 Feb 2025 12:21:52 -0800
Message-ID: <20250208203142.242284-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
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

This patch series reduces use of memcpy and rte_memcpy
in DPDK. It changes memcpy to a simple assignment operator
which easier to read, generates the same code, and
keeps type safety.

Historically memcpy was used in textbooks because there
was no structure assignement in original K&R C.

Stephen Hemminger (32):
  devtools/cocci: prefer structure assignment over memcpy
  app/testpmd: replace memcpy with assignment
  app/graph: replace memcpy with structure assignment
  crypto/dpaa_sec: replace memcpy with assignment
  dma/dpaa2: replace memcpy with assignment
  eventdev: replace memcpy with assignment
  event/dpaa2: replace memcpy with structure assignment
  event/dsw: replace memcpy with assignment
  ml/cnxk: replace memcpy with assignment
  examples: replace memcpy with assignment
  node: replace memcpy with assignment
  pipeline: replace memcpy with assignment
  sched: replace memcpy with structure assignment
  table: replace memcpy with structure assignment
  net/ntnic: replace memcpy with structure assignment
  net/bnxt: replace memcpy with structure assignment
  crypto/qat: replace memcpy with structure assignment
  mempool/cnxk: replace memcpy with structure assignment
  net/dpaa2: replace memcpy with assignment
  net/enic: replace memcpy with assignment
  net/intel/i40e: replace memcpy with structure assignment
  net/nfp: replace memcpy with assignment
  net/txgbe: replace memcpy with assignment
  net/bnx2x: replace memcpy with structure assignment
  net/dpaa2: replace memcpy with structure assignment
  net/bonding: replace memcpy with structure assignment
  net/cnxk: replace memcpy with structure assignment
  net/enic: replace memcpy with structure assignment
  net/iavf: replace memcpy with structure assignment
  net/ice: replace memcpy with structure assignment
  test: replace memcpy with structure assignment
  test/cryptodev: replace memcpy with structure assignment

 app/graph/ethdev.c                            |  2 +-
 app/test-pmd/cmdline_flow.c                   |  2 +-
 app/test/test_acl.c                           |  5 ++-
 app/test/test_compressdev.c                   | 36 +++++++------------
 app/test/test_cryptodev.c                     |  3 +-
 app/test/test_security_inline_proto.c         | 23 +++++-------
 devtools/cocci/struct-assign.cocci            | 15 ++++++++
 drivers/crypto/dpaa_sec/dpaa_sec.c            |  2 +-
 drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c  |  3 +-
 drivers/crypto/qat/dev/qat_crypto_pmd_gen5.c  |  3 +-
 drivers/dma/dpaa2/dpaa2_qdma.c                |  4 +--
 drivers/event/dpaa2/dpaa2_eventdev.c          |  7 ++--
 drivers/event/dsw/dsw_event.c                 |  3 +-
 drivers/mempool/cnxk/cnxk_mempool_ops.c       |  2 +-
 drivers/ml/cnxk/cnxk_ml_ops.c                 |  2 +-
 drivers/net/bnx2x/bnx2x_stats.c               |  2 +-
 drivers/net/bnxt/bnxt_hwrm.c                  |  3 +-
 drivers/net/bnxt/tf_core/tf_rm.c              |  8 ++---
 drivers/net/bnxt/tf_ulp/ulp_tun.c             |  3 +-
 drivers/net/bonding/rte_eth_bond_pmd.c        |  2 +-
 drivers/net/cnxk/cnxk_ethdev_cman.c           |  2 +-
 drivers/net/dpaa2/dpaa2_ethdev.c              |  5 ++-
 drivers/net/dpaa2/dpaa2_flow.c                |  9 ++---
 drivers/net/dpaa2/dpaa2_mux.c                 |  2 +-
 drivers/net/enic/enic_fm_flow.c               |  2 +-
 drivers/net/enic/enic_main.c                  |  2 +-
 drivers/net/intel/i40e/i40e_ethdev.c          |  6 ++--
 drivers/net/intel/i40e/i40e_fdir.c            |  3 +-
 drivers/net/intel/i40e/i40e_flow.c            |  3 +-
 drivers/net/intel/i40e/rte_pmd_i40e.c         |  3 +-
 drivers/net/intel/iavf/iavf_ipsec_crypto.c    |  3 +-
 drivers/net/intel/ice/ice_hash.c              |  6 ++--
 drivers/net/intel/ixgbe/ixgbe_flow.c          |  4 +--
 .../net/nfp/flower/nfp_flower_representor.c   |  2 +-
 .../net/ntnic/nthw/flow_api/flow_id_table.c   |  4 +--
 .../profile_inline/flow_api_profile_inline.c  |  2 +-
 drivers/net/txgbe/txgbe_flow.c                |  4 +--
 examples/bbdev_app/main.c                     |  2 +-
 examples/ip_pipeline/parser.c                 |  2 +-
 examples/l2fwd-cat/cat.c                      |  3 +-
 examples/ptpclient/ptpclient.c                |  4 +--
 lib/eventdev/rte_event_dma_adapter.c          |  2 +-
 lib/eventdev/rte_event_timer_adapter.c        |  2 +-
 lib/node/ethdev_rx.c                          |  2 +-
 lib/node/ip4_reassembly.c                     |  2 +-
 lib/node/kernel_rx.c                          |  2 +-
 lib/pipeline/rte_pipeline.c                   |  6 ++--
 lib/pipeline/rte_swx_ctl.c                    |  2 +-
 lib/pipeline/rte_swx_ipsec.c                  |  2 +-
 lib/pipeline/rte_swx_pipeline_spec.c          | 36 +++++++------------
 lib/sched/rte_sched.c                         |  2 +-
 lib/table/rte_swx_table_selector.c            |  2 +-
 52 files changed, 108 insertions(+), 155 deletions(-)
 create mode 100644 devtools/cocci/struct-assign.cocci

-- 
2.47.2

