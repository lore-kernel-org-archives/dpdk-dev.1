Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9976C3ABC9
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 May 2025 20:19:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 08C1840651;
	Fri, 16 May 2025 22:19:03 +0200 (CEST)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com
 [209.85.222.182])
 by mails.dpdk.org (Postfix) with ESMTP id 21E0F40395
 for <dev@dpdk.org>; Fri, 16 May 2025 22:19:01 +0200 (CEST)
Received: by mail-qk1-f182.google.com with SMTP id
 af79cd13be357-7c5445cb72dso28765785a.3
 for <dev@dpdk.org>; Fri, 16 May 2025 13:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1747426740; x=1748031540; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tYIvkvkvzyRSw75X2aUP7lr9orOpT/hlBSy46lcWAzA=;
 b=CpVUKZs5Fn/PtUEBeJB0FCRNyZsU1fqZ8lrnBlIFmTA3DQkBP+x85H/SrSj81w+bto
 w42NcRBCB/5UL7fiYGbABeZiqiJHwYRTUFkQNW8cy+3BgEWWEBJNixtd/+GxZLxXFpwV
 urn8/pG/iQHwfT2/VtO9SXwSTNUsDFOMmG0+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747426740; x=1748031540;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tYIvkvkvzyRSw75X2aUP7lr9orOpT/hlBSy46lcWAzA=;
 b=uUEEnI7bMgN9Wb9u7Zm+FsRfTwLnq6+oegopLazy+IIyw9gIaLQBMj4HYhawrOfN0Z
 BrsKmAa8ps/Q22oc2C0fxu9MlQB51taS7xVsmdChtxHBcGug9CgMK5qulpr9dAIipiW8
 EfnX980D+7GqgnAfLdEWQDWz3KCmE+Ur6b560z2GeAx8nPb/UE0xyjVnW/Qdr1xdKLZu
 DBiCfA+LXITyn3SdojPqmM2crxYJ13A0KvfHpyv6GHLPZqDy9954NMLXcXodtXTlfjTF
 R97QEF8PY1RLyK26mFpk0BJ0kuhSSV2G4MwEHaCSuuHlTT1ZoHiZgLOccpeKbeIOcINo
 3EBA==
X-Gm-Message-State: AOJu0YzzvmNrOAx5mXYnID+/CWwGIAb7lY6k2VliyFJicrx9d3QclfQb
 jeLw1oyKQ/oEHgN7nSUclg3etT5afLhtrV124Cfx3f9wj211dAYAnhzAfwixLEvBpyw=
X-Gm-Gg: ASbGncsBhWIbnMZkYKAbMdZ665mKovyuTOoJ1NBmRrkPoUipzFwTR7Ve0VIy5bhe+R6
 WOUiBR+eIgpnXkoHVZm+wXs7ATFJt/uB3U17tqb3WnKUB8zuarPKsvF4T2w2tvEMDbFS7fVESfP
 /jV26PY6SUuXC/d9pv9FMJsMncpPzvHp6G0HXHGc0AiCcZMI+eU7e6LA9xa1cLm6QNz3um8l8Az
 zs2wJTh3H96fBRIY1wy4MVDZDFuaYXOZgWzZAClY9VQwgJuZBA9kPQtoe/BQdDCJiAkEF5pX/kH
 pTEWZQkI0yzFlwLdkXz49q44I7RZxjBiqG71fB1DhP1XYHKqCB8rVIraeAShbT4=
X-Google-Smtp-Source: AGHT+IHTjFjRhvGkeffU1e6vaNyMBYy1HIsGSwRqVaL7I3fS1eI7z1WGoe4Xhq69aUg+0Q17J42bUw==
X-Received: by 2002:a05:620a:2605:b0:7c3:c340:70bf with SMTP id
 af79cd13be357-7cd467d9535mr307598785a.14.1747426740373; 
 Fri, 16 May 2025 13:19:00 -0700 (PDT)
Received: from localhost.unh.edu ([2606:4100:3880:1271:e2f8:4ec3:8bf3:864c])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7cd467d93d5sm159673685a.31.2025.05.16.13.18.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 May 2025 13:18:59 -0700 (PDT)
From: Nicholas Pratte <npratte@iol.unh.edu>
To: stephen@networkplumber.org, dmarx@iol.unh.edu, luca.vizzarro@arm.com,
 paul.szczepanek@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, thomas@monjalon.net, thomas.wilks@arm.com,
 probb@iol.unh.edu
Cc: dev@dpdk.org,
	Nicholas Pratte <npratte@iol.unh.edu>
Subject: [RFC v2 1/6] dts: rework config module to support perf TGs
Date: Fri, 16 May 2025 16:18:29 -0400
Message-ID: <20250516201834.626206-2-npratte@iol.unh.edu>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250516201834.626206-1-npratte@iol.unh.edu>
References: <20250423194011.1447679-1-npratte@iol.unh.edu>
 <20250516201834.626206-1-npratte@iol.unh.edu>
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

Rework test run configuration file for TGs to support both application
directory location and any necessary configuration files; an example
TREX configuration file is provided. Configuration files have been moved
to a configurations directory, requiring a slight modification to the
settings module.

Bugzilla ID: 1697
Signed-off-by: Nicholas Pratte <npratte@iol.unh.edu>
---
 dts/{ => configurations}/nodes.example.yaml    |  0
 dts/{ => configurations}/test_run.example.yaml |  8 +++++++-
 .../tests_config.example.yaml                  |  0
 dts/configurations/trex_configs/intel_40g.yaml | 18 ++++++++++++++++++
 dts/framework/settings.py                      |  6 ++++--
 5 files changed, 29 insertions(+), 3 deletions(-)
 rename dts/{ => configurations}/nodes.example.yaml (100%)
 rename dts/{ => configurations}/test_run.example.yaml (82%)
 rename dts/{ => configurations}/tests_config.example.yaml (100%)
 create mode 100644 dts/configurations/trex_configs/intel_40g.yaml

diff --git a/dts/nodes.example.yaml b/dts/configurations/nodes.example.yaml
similarity index 100%
rename from dts/nodes.example.yaml
rename to dts/configurations/nodes.example.yaml
diff --git a/dts/test_run.example.yaml b/dts/configurations/test_run.example.yaml
similarity index 82%
rename from dts/test_run.example.yaml
rename to dts/configurations/test_run.example.yaml
index 1bc436eed1..49088b44b6 100644
--- a/dts/test_run.example.yaml
+++ b/dts/configurations/test_run.example.yaml
@@ -23,8 +23,14 @@ dpdk:
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
+  config: "trex_config.yaml" # Additional configuration files. (Leave blank if not required)
 perf: false # disable performance testing
 func: true # enable functional testing
 skip_smoke_tests: true # optional
diff --git a/dts/tests_config.example.yaml b/dts/configurations/tests_config.example.yaml
similarity index 100%
rename from dts/tests_config.example.yaml
rename to dts/configurations/tests_config.example.yaml
diff --git a/dts/configurations/trex_configs/intel_40g.yaml b/dts/configurations/trex_configs/intel_40g.yaml
new file mode 100644
index 0000000000..dae003795b
--- /dev/null
+++ b/dts/configurations/trex_configs/intel_40g.yaml
@@ -0,0 +1,18 @@
+### Config file generated by dpdk_setup_ports.py ###
+
+- version: 2
+  interfaces: ['11:00.0', '11:00.1']
+  port_bandwidth_gb: 40
+  port_info:
+      - dest_mac: 3c:fd:fe:d5:e5:f9 # MAC OF LOOPBACK TO IT'S DUAL INTERFACE
+        src_mac:  3c:fd:fe:d5:e5:f8
+      - dest_mac: 3c:fd:fe:d5:e5:f8 # MAC OF LOOPBACK TO IT'S DUAL INTERFACE
+        src_mac:  3c:fd:fe:d5:e5:f9
+
+  platform:
+      master_thread_id: 0
+      latency_thread_id: 7
+      dual_if:
+        - socket: 0
+          threads: [1,2,3,4,5,6]
+
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
2.47.1

