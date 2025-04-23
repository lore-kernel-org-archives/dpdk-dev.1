Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B33CC369D5
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Apr 2025 19:40:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2C3BA40156;
	Wed, 23 Apr 2025 21:40:17 +0200 (CEST)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com
 [209.85.160.173])
 by mails.dpdk.org (Postfix) with ESMTP id CA69C400D5
 for <dev@dpdk.org>; Wed, 23 Apr 2025 21:40:15 +0200 (CEST)
Received: by mail-qt1-f173.google.com with SMTP id
 d75a77b69052e-47681cda32eso193461cf.3
 for <dev@dpdk.org>; Wed, 23 Apr 2025 12:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1745437215; x=1746042015; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KTYq7BiKFpeP6Lm06aDKkT1RNV+liNT51dyUweUpILA=;
 b=ALWijdjhOQvUn7s/nESLzMwGLvczCroWdjSW66NMpPiwj4dov9Ru4S9UwSYnp8kTLn
 +HItFOCmq49a0mezYSNSTJO4mlSnj6EsVdZWLohDJFupmzf6QLuZ7zvlNhN25HZQKx/n
 quVs6Xhjt2mQPcMHxLV8G4R3fB5pFfYhszqo4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745437215; x=1746042015;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KTYq7BiKFpeP6Lm06aDKkT1RNV+liNT51dyUweUpILA=;
 b=A3gHVi+bwjwOiX+SiGtdzVU/WQj/74La267jml3ARqSJ8FZN/pOVHAE9JV3YI1uxn+
 rJyXQg1ALA7j/7YPwqTACyLf5ZtnjgpVbUEfEoo8TBDj+v+JhXUniZFriwRAtB4Z2Gse
 d08X5SIjI3nbmCtvTHphMKLxwihbMsZVTRYLNlNAsl06grBN94uWBkyO+FomI5u/Rq9M
 WagOEZCgEMqB7eIWySls58o+LaV5mvP7kW67WOmpnNWpA1DCrfQn2bVWK77s1un3hlYk
 MN69qcfBPOQCQlAR4ZmXKP6YNlADjwKKrJsMNGu/VrhLGV7V7q48ZwKwMhyPcESfaYLO
 KbrQ==
X-Gm-Message-State: AOJu0YwfKdoBR0eBYgegIC8APmQIh36+r8iE98rjx2aObtL/yojDidUb
 /UHvyDPIQILR1lMtqnD3GAbduRPFyQwNJfasIOT0kcDR+J+wPlwPuiflmVa0x8I=
X-Gm-Gg: ASbGncsgjuIsKDMhIXT58I2DPoJh+A7V0Zi1pD9VsqYZAZs7gsfPH76/FBJtVeI/FEd
 +/TPd/P3gg9buPfAKS2PvIc0d0E54GLXvrNpIw0Qkvs6uFg2nobu0ph9SOvMrSgmQhT4HfGswvP
 2ZPuA09PRIBUo5X0zSdc3J4tJaOiYuQOvpS2x5vVGEEHGtL6uAdYmJ8oC1s7oV+v2lAjxIaarkd
 Lr/SyPmh8MVgsBNomawqsP6kSu+aR1wnmfqbQKFTafjCRlpDzFHuhtkcxcjLdGpjO7ZYeVAe6gl
 VkOc7DKVCBOOd06R5sJlbB+pget3VVxuJlOIMPbMOUOUZJU1sQtV79V9fX1GAz8c9U+fSjHlGo3
 RANYAWw==
X-Google-Smtp-Source: AGHT+IHSsm181ObYZOiBLR4dY5TPjvgJUFRgM3yiI+8uOpBISt6MTYG1NVDFrWXHWcbu8k2g8eAgPQ==
X-Received: by 2002:a05:622a:206:b0:475:876:ac3d with SMTP id
 d75a77b69052e-47aec4c34demr115564181cf.13.1745437214913; 
 Wed, 23 Apr 2025 12:40:14 -0700 (PDT)
Received: from localhost.unh.edu ([2606:4100:3880:1271:e2f8:4ec3:8bf3:864c])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-47ae9cf9f7dsm71635691cf.74.2025.04.23.12.40.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 12:40:14 -0700 (PDT)
From: Nicholas Pratte <npratte@iol.unh.edu>
To: ian.stokes@intel.com, yoan.picchi@foss.arm.com, probb@iol.unh.edu,
 paul.szczepanek@arm.com, Honnappa.Nagarahalli@arm.com, thomas@monjalon.net,
 luca.vizzarro@arm.com, thomas.wilks@arm.com, dmarx@iol.unh.edu,
 stephen@networkplumber.org
Cc: dev@dpdk.org,
	Nicholas Pratte <npratte@iol.unh.edu>
Subject: [RFC Patch v1 0/5] Add TREX Traffic Generator to DTS Framework
Date: Wed, 23 Apr 2025 15:40:06 -0400
Message-ID: <20250423194011.1447679-1-npratte@iol.unh.edu>
X-Mailer: git-send-email 2.47.1
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

Included in a semi-complete, RFC implementation for a would-be
implementation of the TREX traffic generator, in addition to a
mock implementation of a single core performance test suite,
leveraging newly added performance test API functionality.

Code is incomplete with a handful of typing issues, but does execute
without errors on my system.

Nicholas Pratte (5):
  dts: rework config module to support perf TGs
  dts: rework traffic generator inheritance structure.
  dts: add asychronous support to ssh sessions.
  dts: add trex traffic generator to dts framework
  dts: add performance test functions to test suite api

 dts/{ => configurations}/nodes.example.yaml   |   0
 .../test_run.example.yaml                     |   8 +-
 .../tests_config.example.yaml                 |   0
 .../trex_configs/intel_40g.yaml               |  18 ++
 dts/framework/config/test_run.py              |  20 +-
 dts/framework/context.py                      |  11 +-
 dts/framework/remote_session/ssh_session.py   |  17 ++
 dts/framework/settings.py                     |   6 +-
 dts/framework/test_run.py                     |  28 +-
 dts/framework/test_suite.py                   |  33 +-
 .../traffic_generator/__init__.py             |  22 +-
 .../capturing_traffic_generator.py            |  34 +++
 .../performance_traffic_generator.py          |  62 ++++
 .../traffic_generator/traffic_generator.py    |  43 +--
 .../testbed_model/traffic_generator/trex.py   | 287 ++++++++++++++++++
 dts/tests/TestSuite_single_core_perf.py       |  24 ++
 16 files changed, 550 insertions(+), 63 deletions(-)
 rename dts/{ => configurations}/nodes.example.yaml (100%)
 rename dts/{ => configurations}/test_run.example.yaml (82%)
 rename dts/{ => configurations}/tests_config.example.yaml (100%)
 create mode 100644 dts/configurations/trex_configs/intel_40g.yaml
 create mode 100644 dts/framework/testbed_model/traffic_generator/performance_traffic_generator.py
 create mode 100644 dts/framework/testbed_model/traffic_generator/trex.py
 create mode 100644 dts/tests/TestSuite_single_core_perf.py

-- 
2.47.1

