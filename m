Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0743C369CB
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Apr 2025 19:40:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 135D1402E0;
	Wed, 23 Apr 2025 21:40:48 +0200 (CEST)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com
 [209.85.222.169])
 by mails.dpdk.org (Postfix) with ESMTP id A0D73400D5
 for <dev@dpdk.org>; Wed, 23 Apr 2025 21:40:46 +0200 (CEST)
Received: by mail-qk1-f169.google.com with SMTP id
 af79cd13be357-7c55d853b54so2307085a.0
 for <dev@dpdk.org>; Wed, 23 Apr 2025 12:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1745437246; x=1746042046; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=awlGJwxKG9yYM6YamZECTm9jjX7nX5PDOgoTLOnXkzI=;
 b=fcK1BALdNoUrfZKEI4kWX8woVcO4jPmHSy8O3aEC9vBUg7RFydGntbIbuwMwF69Gtj
 fkOvHsyfQOJhPbf37afGUVat41LUigN+8yZdeBv3C6UYcRqLWjsTCcprEGZ7jyE/nCdU
 3U55lY5dR8wmZbiszAQmGEtTlr9jUrUSl9u9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745437246; x=1746042046;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=awlGJwxKG9yYM6YamZECTm9jjX7nX5PDOgoTLOnXkzI=;
 b=SBw/Gp4poUkKBZVFPtBTJc8YmFRYi7jkb1hCiEYZqiU1lVcY4AXV7siZs0J6ow8/Q/
 SCAvPkIKieoxvKnJIqtcdLSrfdOdbcRb63h9LGCA58BwPk5psF2ZApQWFMFOvR69fbFF
 a3Uyu/Ps68HCbRPFVlcNrYThdYpWrn05TVnH4XgkYbNrZKim7gVDrsVaVFpBo2/SX+Kh
 SR+R5YUEqK1Z81rI7Xl3izYr+RUe+hkebaF5A82hx2InzrHfvvadrCt6+fZjWs7WxoCt
 njDrXYtkTbpu1COptn8Jg5WECN9jcJ75MKMNBV7VhmJ4dSdXmdQtYilTZJTexxhKo4qc
 GD9g==
X-Gm-Message-State: AOJu0Yw8Z7bZO2tw1oSTQEhqNHyDlL1pMbcUTzXQLpn4VTazBHVwQefW
 IUCzAEbOCByo2ycN3YsRlX7QraVH+LXXhlF2IG3eIVYL151BB9UU+vACTsjV7oI=
X-Gm-Gg: ASbGncuEF34/avCsLKODHKLI+Pr1JLrFziY+9eS5jhb2iUVpk2cl7SYX9ilYN42VPR8
 VibrUB1BSRZ+OzHsTzJ2CYy3DKJPZMyQNsuP+K4Dx114HxMUbJVh/ClxSFcoANcE06pJvq4XZWW
 WKB7N+Zec5WPDB4ntXscPOmWq/4gkJORq8nt8yEntpDaxpQtiO9joxRCXuo9OScZ1b+Hmi/956e
 D63FBOw4AuwZXn1Yo+KCZ7uHLKKiISKiFeMXofh5fEb6aqBhCSLy7wYsZCAfLTi1Ys+z2M0fEhI
 7Jzuwp+aYYjlZdpZnr7BIlKbk1Ma03VbYvnl3r23jQiDEL0mHCl5vkTt9DjQt23OlQ7aqC9VQWE
 sl9VHqw==
X-Google-Smtp-Source: AGHT+IHOmM7uwf7A8x36qCgFjC2w6NVkrWI372EOZ4KHzyiynODlw9TXtNqt+OgWtpeyJ9kGxYOorg==
X-Received: by 2002:a05:620a:394b:b0:7c3:d266:3342 with SMTP id
 af79cd13be357-7c956eb1d0fmr6118385a.5.1745437245784; 
 Wed, 23 Apr 2025 12:40:45 -0700 (PDT)
Received: from localhost.unh.edu ([2606:4100:3880:1271:e2f8:4ec3:8bf3:864c])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-47ae9cf9f7dsm71635691cf.74.2025.04.23.12.40.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 12:40:44 -0700 (PDT)
From: Nicholas Pratte <npratte@iol.unh.edu>
To: ian.stokes@intel.com, yoan.picchi@foss.arm.com, probb@iol.unh.edu,
 paul.szczepanek@arm.com, Honnappa.Nagarahalli@arm.com, thomas@monjalon.net,
 luca.vizzarro@arm.com, thomas.wilks@arm.com, dmarx@iol.unh.edu,
 stephen@networkplumber.org
Cc: dev@dpdk.org,
	Nicholas Pratte <npratte@iol.unh.edu>
Subject: [RFC Patch v1 1/5] dts: rework config module to support perf TGs
Date: Wed, 23 Apr 2025 15:40:07 -0400
Message-ID: <20250423194011.1447679-2-npratte@iol.unh.edu>
X-Mailer: git-send-email 2.47.1
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
index 330a31bb18..fdfff4a879 100644
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
 skip_smoke_tests: false # optional
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

