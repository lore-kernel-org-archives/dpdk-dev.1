Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D50C83038
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Jul 2025 05:27:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D5D0C40285;
	Wed,  2 Jul 2025 07:27:31 +0200 (CEST)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com
 [209.85.222.175])
 by mails.dpdk.org (Postfix) with ESMTP id A603740269
 for <dev@dpdk.org>; Wed,  2 Jul 2025 07:27:30 +0200 (CEST)
Received: by mail-qk1-f175.google.com with SMTP id
 af79cd13be357-7d3f192a64eso589552985a.2
 for <dev@dpdk.org>; Tue, 01 Jul 2025 22:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1751434050; x=1752038850; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ClAlWElvBu1vPTQ4keEVsweS1wXXCoAT27wnMmIDO6c=;
 b=J+IIT3nhZAnMprTdRbUaeh2Tkrox90P3Joz2LHlSMyYbKrnQvGrdp35ekR82VfcEof
 y5IKyHD20nZJqRxNyP2p89td9xwatSXGs42s+8iqBfJ18Xf9qbLT727iSoRzTHr9M5cK
 qdsXEXHO2Hbq2dxjGsMphQSRi8bFucDBivji8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751434050; x=1752038850;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ClAlWElvBu1vPTQ4keEVsweS1wXXCoAT27wnMmIDO6c=;
 b=LB/20sHMTV/lN7NqZJhU7Ty8vIsXK/Wk3Ogp+uuX9rORBQmrarRJLywH2uPZGLNdlj
 qW1Gi8+xRH0IfOaY55DWAanD9gFBInvo9pnk7Jii6S5q3ZcuOi+t5l+aQjAIpJE1fDiy
 6ofmgchUIYnYEelQv/nRjN4cX+hIvZOughR4Zdgkmx2xzYo6GKsDRMtqopAT0XunI70X
 yJeK0tZHYIejkYVd6T3SM+gH7AoVBLiXHhZoU4SW7d3SqTCPeg4GAQMmlGehEA+AbnF8
 CIyUTYQA37AI5K40Aj6VlVJjzUUJnRSIUDzdjnJqgm3M6O+AkP/q3fPo9N1XKS86ZtKz
 e4Aw==
X-Gm-Message-State: AOJu0Ywsn0jV6oR94m3eLVQ67wSCYnhCsFNtWIuRTjvqfbCOXROAJXpT
 JNHhtfvLodmYqfIczD6a/MT8PRaQmb5vVzr/dNqmnW9xxnc45paKHopaieHLCgdp6qE=
X-Gm-Gg: ASbGnctKGg/72ulW3ihVVJBpNyf2KMgYtF5jr4fcKzsDqtZujWZN8r+Si93YWjAKMVw
 cGUbJ0+AAnRS8GiCAAerqIUnr21/XZhQm0sk42o/b5NLgHNMV1cZUB1w2uwMaBBFTHnlqYnIJ5u
 F6MZguK6WdOxTaTKsGmJ4HhEUK60Fl9BjW3x8T6g0H/8mI2CmWLQGCJOlTwEpWaGeJTf1DNKihk
 1G5at9RWsLSxNrXd3rmE4QwEFCr0keEjLuWKja62j/1MBoAsWGEtmnnUOXICSWNUm4cso2nyCYK
 73vywKfwgUaCOOkSJhwCp4dGcWM0MEVt6PSndGRsYTahzDyRkpOXLYkEEGsTCNykGPzTFxWy8TI
 =
X-Google-Smtp-Source: AGHT+IGUEKtOBDIsmjiDoLQTf5u42Kz7W+xhwDx2cSBawtFTahS7nvzugzSYv9YKrV1LbK7kiMSu5w==
X-Received: by 2002:a05:620a:4106:b0:7d4:1dac:9a65 with SMTP id
 af79cd13be357-7d5c47271a1mr236888185a.43.1751434049881; 
 Tue, 01 Jul 2025 22:27:29 -0700 (PDT)
Received: from patrick-laptop.iol.unh.edu ([2606:4100:3880:1257::10e7])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d45c0fe6dfsm469274185a.58.2025.07.01.22.27.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 22:27:29 -0700 (PDT)
From: Patrick Robb <probb@iol.unh.edu>
To: Paul.Szczepanek@arm.com
Cc: dev@dpdk.org, dmarx@iol.unh.edu, nprattedev@gmail.com,
 mmahajan@iol.unh.edu, abailey@iol.unh.edu, Luca.Vizzarro@arm.com,
 thomas.wilks@arm.com, Nicholas Pratte <npratte@iol.unh.edu>,
 Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH v3 1/5] dts: rework config module to support perf TGs
Date: Wed,  2 Jul 2025 01:21:50 -0400
Message-ID: <20250702052154.381690-1-probb@iol.unh.edu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423194011.1447679-1-npratte@iol.unh.edu>
References: <20250423194011.1447679-1-npratte@iol.unh.edu>
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

From: Nicholas Pratte <npratte@iol.unh.edu>

Rework test run configuration file for TGs to support both application
directory location and any necessary configuration files; an example
TREX configuration file is provided. Configuration files have been moved
to a configurations directory, requiring a slight modification to the
settings module.

Bugzilla ID: 1697
Signed-off-by: Nicholas Pratte <npratte@iol.unh.edu>
Signed-off-by: Patrick Robb <probb@iol.unh.edu>
Reviewed-by: Dean Marx <dmarx@iol.unh.edu>
---
 dts/{ => configurations}/nodes.example.yaml        |  0
 dts/{ => configurations}/test_run.example.yaml     | 13 +++++++------
 dts/{ => configurations}/tests_config.example.yaml |  0
 dts/framework/settings.py                          |  6 ++++--
 4 files changed, 11 insertions(+), 8 deletions(-)
 rename dts/{ => configurations}/nodes.example.yaml (100%)
 rename dts/{ => configurations}/test_run.example.yaml (80%)
 rename dts/{ => configurations}/tests_config.example.yaml (100%)

diff --git a/dts/nodes.example.yaml b/dts/configurations/nodes.example.yaml
similarity index 100%
rename from dts/nodes.example.yaml
rename to dts/configurations/nodes.example.yaml
diff --git a/dts/test_run.example.yaml b/dts/configurations/test_run.example.yaml
similarity index 80%
rename from dts/test_run.example.yaml
rename to dts/configurations/test_run.example.yaml
index 1bc436eed1..e9baf10035 100644
--- a/dts/test_run.example.yaml
+++ b/dts/configurations/test_run.example.yaml
@@ -1,8 +1,3 @@
-# SPDX-License-Identifier: BSD-3-Clause
-# Copyright 2022-2023 The DPDK contributors
-# Copyright 2023 Arm Limited
-
-# Define the test run environment
 dpdk:
   lcores: "" # use all available logical cores (Skips first core)
   memory_channels: 4 # tells DPDK to use 4 memory channels
@@ -23,8 +18,14 @@ dpdk:
     # in a subdirectory of DPDK tree root directory. Otherwise, will be using the `build_options`
     # to build the DPDK from source. Either `precompiled_build_dir` or `build_options` can be
     # defined, but not both.
-traffic_generator:
+func_traffic_generator:
   type: SCAPY
+  remote_path: "" # The remote path of the traffic generator application. (Leave blank for SCAPY)
+  config: "" # Additional configuration files. (Leave blank if not required)
+perf_traffic_generator:
+  type: TREX
+  remote_path: "/opt/trex/v3.03" # The remote path of the traffic generator application. (Leave blank for SCAPY)
+  config: "/opt/trex_config/trex_config.yaml" # Additional configuration files. (Leave blank if not required)
 perf: false # disable performance testing
 func: true # enable functional testing
 skip_smoke_tests: true # optional
diff --git a/dts/tests_config.example.yaml b/dts/configurations/tests_config.example.yaml
similarity index 100%
rename from dts/tests_config.example.yaml
rename to dts/configurations/tests_config.example.yaml
diff --git a/dts/framework/settings.py b/dts/framework/settings.py
index 3f21615223..ccf4df25b0 100644
--- a/dts/framework/settings.py
+++ b/dts/framework/settings.py
@@ -130,9 +130,11 @@ class Settings:
     """
 
     #:
-    test_run_config_path: Path = Path(__file__).parent.parent.joinpath("test_run.yaml")
+    test_run_config_path: Path = Path(__file__).parent.parent.joinpath(
+        "configurations/test_run.yaml"
+    )
     #:
-    nodes_config_path: Path = Path(__file__).parent.parent.joinpath("nodes.yaml")
+    nodes_config_path: Path = Path(__file__).parent.parent.joinpath("configurations/nodes.yaml")
     #:
     tests_config_path: Path | None = None
     #:
-- 
2.49.0

