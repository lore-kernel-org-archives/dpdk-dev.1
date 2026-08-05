Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5174C55174
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Aug 2026 15:37:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA39E4042C;
	Wed,  5 Aug 2026 17:37:21 +0200 (CEST)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com
 [209.85.219.50]) by mails.dpdk.org (Postfix) with ESMTP id B14FD4021F
 for <dev@dpdk.org>; Wed,  5 Aug 2026 17:37:19 +0200 (CEST)
Received: by mail-qv1-f50.google.com with SMTP id
 6a1803df08f44-8f29ec73064so7679836d6.1
 for <dev@dpdk.org>; Wed, 05 Aug 2026 08:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1785944239; x=1786549039; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=20q0TFA++hih8p3+nuZ+ZA5sd/GInbn7tCLAAEJlYZk=;
 b=djZxx0XAfDkrbS9h1mSO+5Vwk1+wIyUA8r8dqfW/a1vBQQZ98cX7V0sM1saoyglplt
 lO5odDCXcY/scPQtVklVuQ20Xqndsj2i4ZOdAHl0kE+xBTxXrbGiw4AW4P5vlasLm4de
 VmtDMx+iVX2+jPoIUqlmUlgnKIkBU/6qZdzVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785944239; x=1786549039;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=20q0TFA++hih8p3+nuZ+ZA5sd/GInbn7tCLAAEJlYZk=;
 b=atzP7j5jlNpqHrDoaKZGcq9Jyiz6fi+C6/3B2+kjauOQVwMeQSxzwRj5AjEZ4u9t7W
 bR/kIi3r1+rNm+IENV/h/SS27HQ+eNhLUebLz/w3Ts/ZSwoThIfCtLoYViFTzPYDKC8C
 z0+qlGg9PA0Dh157XbrwdsuFOnu6QRj2nUpjoDQmf6egE4zvHkK9tolB4b2Smh+ArAtV
 g9C3krD7c/L+WVZm/zY7Q0OpkfPdhNn0K91a0Se/lqf83+I9RioOEydZnjNDG8q4Akkz
 oFST5QjouR0Svr7Oq6f5ZuZFjW/2cASgRLWbClA4oBqiwPfHCBM0o73H8GGL8G7nHIwY
 r4jA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpXPraGS0xDzAoxfyLb3mmXWCT9H+4cRMOE3RVZHUBWAd1Tx3/3IF9WwKzfesILt0KEDXE=@dpdk.org
X-Gm-Message-State: AOJu0Yy5tBhx1kHp5oTD26/QIJT0S0SRXB1wnSf3qxNiW1+K3ujaeMtu
 VJo5wR+krlV7jymF3nJcvufvGduvlFAd4TjSuGTHHUdx/zV2jBCli1z4RnkNXfs/vVY=
X-Gm-Gg: AR+sD13dSVoUwwILaG90hw8sIoXNCkV0lNZr6CDrkKK+/eKLLTgIcahCLiF6eJdTxzt
 LgaYC3NPQBGI7TuoRM5MTOHwpgTV3FbqfUkxjg+F6vUVgvIl+VNLqmMKiVB7O9nbzS/RD/fvxxH
 6F4LQeSxtOOzA2Op96cyuZnIlwNPs2fNFGMrQZHaA8L1cMDNcqxN7Z3CWHnikiLCx5l7qg+0nww
 8fKNMF/Wn3lU/6fJup7TcsCqSbpnNA2uLNcehURNMgcL7vJ9jkcwXY5QI6vXCp1O9FrUkDuPdgc
 CPCfn3cy9bMhfhy8WDB476HgRUAAd8TiIgAusJnWDg7CU7ODFQsF2eKanB+u1rdbqBq0lcDBaQT
 k7nJ298rbdlfCcsdkNFBIpMFSmGp6puF5v0zBZrLEMzQrQKhNYp7WskUYIeN7Q27VfEq1d5wh+A
 JUpKRaaO/SuRN5DABwLsVErYTHe6+6+BLd/BWeVn8fiIUKKda3fVKlNN1VyFOf1ffbYJ0f
X-Received: by 2002:a05:6214:d4d:b0:8ee:cee4:7497 with SMTP id
 6a1803df08f44-9088125aa85mr88061506d6.16.1785944238985; 
 Wed, 05 Aug 2026 08:37:18 -0700 (PDT)
Received: from d121029.iol.unh.edu ([2606:4100:3880:1210::219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-908846e6155sm18112886d6.43.2026.08.05.08.37.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 08:37:18 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: dladd@iol.unh.edu, dev@dpdk.org, luca.vizzarro@arm.com,
 patrickrobb1997@gmail.com
Cc: knimoji@iol.unh.edu, lylavoie@iol.unh.edu,
 Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v1] dts: update configuration for performance test
Date: Wed,  5 Aug 2026 11:36:58 -0400
Message-ID: <20260805153658.345207-1-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.55.0
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

The single core forward performance test suite can run a variety of
combinations of buffer sizes and number of descriptors. It is beneficial
if any possible combination of these parameters could be tested against
a specific delta tolerance; Rather than a globally defined tolerance for
all testing. Along with this, adjusting traffic duration and test
repetitions helps users define a more accurate test run if they wish to
get a more refined average. Furthermore, the cores allotted to TREX can
vary among systems and should be defined by the user.

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
---
 dts/configurations/test_run.example.yaml      |  1 +
 dts/framework/config/test_run.py              |  1 +
 .../testbed_model/traffic_generator/trex.py   |  3 +-
 .../TestSuite_single_core_forward_perf.py     | 52 ++++++++++++++-----
 4 files changed, 43 insertions(+), 14 deletions(-)

diff --git a/dts/configurations/test_run.example.yaml b/dts/configurations/test_run.example.yaml
index 51f9ab8237..c6eb086211 100644
--- a/dts/configurations/test_run.example.yaml
+++ b/dts/configurations/test_run.example.yaml
@@ -52,6 +52,7 @@ func_traffic_generator:
 #   type: TREX
 #   remote_path: "/opt/trex/v3.03" # The remote path of the traffic generator application.
 #   config: "/opt/trex_config/trex_config.yaml" # Additional configuration files. (Leave blank if not required)
+#   cores: 10 # The number of cores to run TRex with.
 perf: false # disable performance testing
 func: true # enable functional testing
 crypto: false # disable cryptographic testing
diff --git a/dts/framework/config/test_run.py b/dts/framework/config/test_run.py
index 81630df77d..1ffb6b2365 100644
--- a/dts/framework/config/test_run.py
+++ b/dts/framework/config/test_run.py
@@ -420,6 +420,7 @@ class TrexTrafficGeneratorConfig(TrafficGeneratorConfig):
     type: Literal[TrafficGeneratorType.TREX]
     remote_path: PurePath
     config: PurePath
+    cores: int
 
 
 #: A union type discriminating traffic generators by the `type` field.
diff --git a/dts/framework/testbed_model/traffic_generator/trex.py b/dts/framework/testbed_model/traffic_generator/trex.py
index d53791b0a6..2b52cfcbd1 100644
--- a/dts/framework/testbed_model/traffic_generator/trex.py
+++ b/dts/framework/testbed_model/traffic_generator/trex.py
@@ -82,7 +82,7 @@ class TrexTrafficGenerator(PerformanceTrafficGenerator):
 
     _streaming_mode: TrexStatelessTXModes = TrexStatelessTXModes.STLTXCont
 
-    _tg_cores: int = 10
+    _tg_cores: int
 
     _trex_app: BlockingApp
 
@@ -102,6 +102,7 @@ def __init__(self, tg_node: Node, config: TrexTrafficGeneratorConfig) -> None:
         super().__init__(tg_node=tg_node, config=config)
         self._tg_node_config = tg_node.config
         self._tg_config = config
+        self._tg_cores = config.cores
 
         self._os_session = create_session(self._tg_node.config, "TRex", self._logger)
 
diff --git a/dts/tests/TestSuite_single_core_forward_perf.py b/dts/tests/TestSuite_single_core_forward_perf.py
index 57aecdf7a4..a966d44ebd 100644
--- a/dts/tests/TestSuite_single_core_forward_perf.py
+++ b/dts/tests/TestSuite_single_core_forward_perf.py
@@ -32,14 +32,40 @@ class Config(BaseConfig):
     """Performance test metrics."""
 
     test_parameters: list[dict[str, int | float]] = [
-        {"frame_size": 64, "num_descriptors": 1024, "expected_mpps": 1.00},
-        {"frame_size": 128, "num_descriptors": 1024, "expected_mpps": 1.00},
-        {"frame_size": 256, "num_descriptors": 1024, "expected_mpps": 1.00},
-        {"frame_size": 512, "num_descriptors": 1024, "expected_mpps": 1.00},
-        {"frame_size": 1024, "num_descriptors": 1024, "expected_mpps": 1.00},
-        {"frame_size": 1518, "num_descriptors": 1024, "expected_mpps": 1.00},
+        {"frame_size": 64, "num_descriptors": 1024, "expected_mpps": 1.00, "delta_tolerance": 0.05},
+        {
+            "frame_size": 128,
+            "num_descriptors": 1024,
+            "expected_mpps": 1.00,
+            "delta_tolerance": 0.05,
+        },
+        {
+            "frame_size": 256,
+            "num_descriptors": 1024,
+            "expected_mpps": 1.00,
+            "delta_tolerance": 0.05,
+        },
+        {
+            "frame_size": 512,
+            "num_descriptors": 1024,
+            "expected_mpps": 1.00,
+            "delta_tolerance": 0.05,
+        },
+        {
+            "frame_size": 1024,
+            "num_descriptors": 1024,
+            "expected_mpps": 1.00,
+            "delta_tolerance": 0.05,
+        },
+        {
+            "frame_size": 1518,
+            "num_descriptors": 1024,
+            "expected_mpps": 1.00,
+            "delta_tolerance": 0.05,
+        },
     ]
-    delta_tolerance: float = 0.05
+    traffic_duration: int = 5
+    test_repetitions: int = 5
 
 
 @requires_link_topology(LinkTopology.TWO_LINKS)
@@ -51,7 +77,8 @@ class TestSingleCoreForwardPerf(TestSuite):
     def set_up_suite(self):
         """Set up the test suite."""
         self.test_parameters = self.config.test_parameters
-        self.delta_tolerance = self.config.delta_tolerance
+        self.traffic_duration = self.config.traffic_duration
+        self.test_repetitions = self.config.test_repetitions
 
     def _transmit(self, testpmd: TestPmd, frame_size: int, repetitions: int = 1) -> float:
         """Create a testpmd session with every rule in the given list, verify jump behavior.
@@ -76,8 +103,7 @@ def _transmit(self, testpmd: TestPmd, frame_size: int, repetitions: int = 1) ->
         rx_avg = 0.0
 
         for _ in range(repetitions):
-            # Transmit for 5 seconds.
-            stats = assess_performance_by_packet(packet=packet, duration=5)
+            stats = assess_performance_by_packet(packet=packet, duration=self.traffic_duration)
             rx_avg += stats.rx_pps
         return rx_avg / (repetitions * 1_000_000)
 
@@ -134,21 +160,21 @@ def single_core_forward_perf(self) -> None:
                 **driver_specific_testpmd_args,
             ) as testpmd:
                 params["measured_mpps"] = round(
-                    self._transmit(testpmd, frame_size, repetitions=5), 3
+                    self._transmit(testpmd, frame_size, repetitions=self.test_repetitions), 3
                 )
                 params["performance_delta"] = round(
                     (float(params["measured_mpps"]) - float(params["expected_mpps"]))
                     / float(params["expected_mpps"]),
                     3,
                 )
-                params["pass"] = float(params["performance_delta"]) >= -self.delta_tolerance
+                params["pass"] = float(params["performance_delta"]) >= -params["delta_tolerance"]
 
         self._produce_stats_table(self.test_parameters)
 
         for params in self.test_parameters:
             verify(
                 params["pass"] is True,
-                f"""Packets forwarded is less than {(1 - self.delta_tolerance) * 100}%
+                f"""Packets forwarded is less than {(1 - params["delta_tolerance"]) * 100}%
                 of the expected baseline.
                 Measured MPPS = {params["measured_mpps"]}
                 Expected MPPS = {params["expected_mpps"]}""",
-- 
2.55.0

