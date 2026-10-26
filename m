Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C7F606A31A
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 19:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iol.unh.edu header.i=@iol.unh.edu header.a=rsa-sha256 header.s=unh-iol header.b=TiaQSrmX
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E739F40151;
	Mon, 26 Oct 2026 20:08:34 +0100 (CET)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com
 [209.85.160.173])
 by mails.dpdk.org (Postfix) with ESMTPS id 2634F40041
 for <dev@dpdk.org>; Mon, 26 Oct 2026 20:08:34 +0100 (CET)
Received: by mail-qt1-f173.google.com with SMTP id
 d75a77b69052e-53381e53b80so36465281cf.1
 for <dev@dpdk.org>; Mon, 26 Oct 2026 12:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1793041713; x=1793646513; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=exdWz+DS2DFnzq1fXwKvN5FpCy9j+VgmmNUVMbkBAiA=;
 b=TiaQSrmXxz4XrVAmb0o4l9jujrBsQ5KuHRJ00bAMzLurjQnt5qZGlAfSWeqBqvooPP
 a56mboPvwr3W4PawPg2sR3e8GloAA6JgXtYu+8MNTbehz3qBv7YlgRufE29IQGY72vC0
 C38DlguN6uR2CkFljbqATjjK7Ry9Pt4oDbu/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793041713; x=1793646513;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=exdWz+DS2DFnzq1fXwKvN5FpCy9j+VgmmNUVMbkBAiA=;
 b=TRHIkpcSEemu9oTdzHzu9SbYcHzvYmzpn2U8cSXGcDfZxSegSuv9igGToc3xmRbuHm
 PhYRM66o+pPbvu8CxHXWDSpBOOqhPKQAaykw/Ch+g8achAo46TFkzwLH1ASTqappV0Tx
 ezgVFok3JPeirKnLCpaqR2JuzRwuGKAnF4h68SkQr2e51xBlf+8yuObwVc0izD2x/4t1
 L4mtoNI29q7hJYtXtHJ+CcbocSrlOlNb5gPThn8+1ymImpvHorSqCpm3REr/fDs6XXxz
 aI8mavCV8KD7k587ym1y82/U1RpaWHI7mq34duZy64aaKR1KwoSSbxHZ1AOKg3O7XYGp
 SlMw==
X-Gm-Message-State: AFq9FYK6pvTffwlsQdZXJyJRXBZ4mJLzqSkkg3fDmxKRCEGsxGsWw1t/
 EV5Bm/5dBoq4egnY/plaDCIn0NA07BZorVq9aOnJ7kPoh6erZEKLj+ZRwqozM6BOpHqmlKPblHt
 J9KMGQz75702YKnbF2irLsAwITujchhVkMq0dKkQeMtS1LYGMeSANTjBppxcHRr9Bi0RzA6e9mR
 3agCpsM8KU1cGOII8EnmEghpwxFeM=
X-Gm-Gg: AYBFou3f9f0+6kXkbDMGUoVKuuc5KPCw4BS71rU8p5HkXoZqJAZfsHBOTmGhsV/8Vk/
 T3iZ0E9JbiqMlVqpz2n93gmZWjDle3tlJszX9k56TnPvP3aDDGEzAVjfxyOPmTcNqIhcmHABazD
 MeixNygPET8pxW5OeJMOV55mCHrOqK5cuH8eDIa1mYEA1jTkymNLsSrp5/XhC8P6jc+NGpeTMw4
 VmQiFGcRT4w1uyIUeb0tpuy9goTCJn68EaJetMBIw545BhLeS6Y1OmgEtZSARgvOubqWkL0r+Q7
 DF1WusM10uMxEYBj0g9QPcZRH2ykQArjau9Sfw44Q6YzLpeuaeqEmye5w1Z0S6TUudwYRl+Oqsl
 UStksg8eW9QpWbkm+gJsBvxbUKkfA/kpvuWulZuYcwGDSrSaYDBFs07XYUbdHlB6HaMTDuRgbjM
 ZsTWWgbC9VeHnEQ7c48XTK2XuatCuY91Co5wm9e2ZIujBzJOqytrzMLYZQHJgZlwgfdaFVvaMXP
 evDgXeLLK+bBjdae7perefyFV1+fCa6kJlsWfMfKbYKG0jHJcIbjH5KGD+kwYUiPFkcC7FtKqTE
 1b+UnKKVPTJOFf8OpCkYi7s=
X-Received: by 2002:a05:622a:451:b0:536:725f:588 with SMTP id
 d75a77b69052e-5383b780a50mr117623081cf.76.1793041712584; 
 Mon, 26 Oct 2026 12:08:32 -0700 (PDT)
Received: from d121029.iol.unh.edu ([2606:4100:3880:1210::219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91c47bda586sm79951016d6.8.2026.10.26.12.08.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 12:08:32 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: dev@dpdk.org,
	luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: knimoji@iol.unh.edu, lylavoie@iol.unh.edu, dladd@iol.unh.edu,
 Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v2] dts: update single core performance test configuration
Date: Mon, 26 Oct 2026 15:08:18 -0400
Message-ID: <20261026190818.45530-1-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20260805153658.345207-1-abailey@iol.unh.edu>
References: <20260805153658.345207-1-abailey@iol.unh.edu>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The single core forward performance test suite can run a variety of
combinations of buffer sizes and number of descriptors. It would be
beneficial if any possible combination of these parameters could be
tested against a specific delta tolerance, rather than a globally
defined tolerance for all testing. Along with this, adjusting
traffic duration and test repetitions helps users define a more accurate
test run if they wish to get a more refined average. Furthermore, the
cores allotted to TREX can vary among systems and should be defined by
the user.

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
---
v2:
 * Updated commit description.
 * Made TREX cores optional with a default of 10.
 * Updated the config examples with new descriptions.

 dts/configurations/test_run.example.yaml      |  3 ++
 dts/configurations/tests_config.example.yaml  | 14 +++++
 dts/framework/config/test_run.py              |  1 +
 .../testbed_model/traffic_generator/trex.py   |  3 +-
 .../TestSuite_single_core_forward_perf.py     | 52 ++++++++++++++-----
 5 files changed, 60 insertions(+), 13 deletions(-)

diff --git a/dts/configurations/test_run.example.yaml b/dts/configurations/test_run.example.yaml
index 182ee377aa..cf169e88ea 100644
--- a/dts/configurations/test_run.example.yaml
+++ b/dts/configurations/test_run.example.yaml
@@ -33,6 +33,8 @@
 #   `traffic_generator_node`:
 #   	This field may be None When `port_topology` is specified as a no link topology, Otherwise it
 #   	is required.
+#   `cores`:
+#     The number of core to provide TREX traffic generator. If not provided, 10 will be used by default.

 # Define the test run environment
 dpdk:
@@ -65,6 +67,7 @@ func_traffic_generator:
 #   type: TREX
 #   remote_path: "/opt/trex/v3.03" # The remote path of the traffic generator application.
 #   config: "/opt/trex_config/trex_config.yaml" # Additional configuration files. (Leave blank if not required)
+#   cores: 10 # The number of cores to run TRex with.
 perf: false # disable performance testing
 func: true # enable functional testing
 crypto: false # disable cryptographic testing
diff --git a/dts/configurations/tests_config.example.yaml b/dts/configurations/tests_config.example.yaml
index ce67385b0b..a59fb9ca33 100644
--- a/dts/configurations/tests_config.example.yaml
+++ b/dts/configurations/tests_config.example.yaml
@@ -2,6 +2,17 @@

 # Optional Fields:
 #   All fields are optional, uncomment a test suite to run it with a specific configuration.
+#   `single_core_forward_perf`:
+#     `delta_tolerance`:
+#       Can be provided under `single_core_forward_perf` to apply to each configuration.
+#       Additionally, it can be provided within one list item to apply a unique delta tolerance
+#       to only that `frame_size` + `num_descriptors` combination.
+#     `test_duration`:
+#       Can be provided to define a duration in seconds to send traffic to the TG per config. If
+#       this field is not provided, 5 is used by default.
+#     `test_repetitions`:
+#       Can be provided to define how many times to repeat the performance test to calculate a more
+#       precise average. If this field is not provided, 5 is used by default.

 # Define the custom test suite configurations
 hello_world:
@@ -11,12 +22,15 @@ hello_world:
 #     - frame_size: 64
 #       num_descriptors: 512
 #       expected_mpps: 1.0 # Set millions of packets per second according to your devices expected throughput for this given frame size / descriptor count
+#       delta_tolerance: 0.06 # See `Optional Fields`
 #     - frame_size: 64
 #       num_descriptors: 1024
 #       expected_mpps: 1.0
 #     - frame_size: 512
 #       num_descriptors: 1024
 #       expected_mpps: 1.0
+#   test_duration: 5 # See `Optional Fields`
+#   test_repetitions: 5 # See `Optional Fields`
 #   delta_tolerance: 0.05
 # pmd_rss:
 #   NUM_QUEUES: 4
diff --git a/dts/framework/config/test_run.py b/dts/framework/config/test_run.py
index 97c9a7417a..b8eb5c888b 100644
--- a/dts/framework/config/test_run.py
+++ b/dts/framework/config/test_run.py
@@ -422,6 +422,7 @@ class TrexTrafficGeneratorConfig(TrafficGeneratorConfig):
     type: Literal[TrafficGeneratorType.TREX]
     remote_path: PurePath
     config: PurePath
+    cores: int = Field(default=10)


 #: A union type discriminating traffic generators by the `type` field.
diff --git a/dts/framework/testbed_model/traffic_generator/trex.py b/dts/framework/testbed_model/traffic_generator/trex.py
index 7ce1d40d79..b698b91c30 100644
--- a/dts/framework/testbed_model/traffic_generator/trex.py
+++ b/dts/framework/testbed_model/traffic_generator/trex.py
@@ -81,7 +81,7 @@ class TrexTrafficGenerator(PerformanceTrafficGenerator):

     _streaming_mode: TrexStatelessTXModes = TrexStatelessTXModes.STLTXCont

-    _tg_cores: int = 10
+    _tg_cores: int

     _trex_app: BlockingApp

@@ -104,6 +104,7 @@ def __init__(self, tg_node: Node, config: TrexTrafficGeneratorConfig) -> None:
         super().__init__(tg_node=tg_node, config=config)
         self._tg_node_config = tg_node.config
         self._tg_config = config
+        self._tg_cores = config.cores

         self._os_session = create_session(self._tg_node.config, "TRex", self._logger)

diff --git a/dts/tests/TestSuite_single_core_forward_perf.py b/dts/tests/TestSuite_single_core_forward_perf.py
index 4b22c5d091..ee54eeef59 100644
--- a/dts/tests/TestSuite_single_core_forward_perf.py
+++ b/dts/tests/TestSuite_single_core_forward_perf.py
@@ -32,14 +32,37 @@ class Config(BaseConfig):
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
+        },
+        {
+            "frame_size": 256,
+            "num_descriptors": 1024,
+            "expected_mpps": 1.00,
+        },
+        {
+            "frame_size": 512,
+            "num_descriptors": 1024,
+            "expected_mpps": 1.00,
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
+        },
     ]
-    delta_tolerance: float = 0.05
+    traffic_duration: int = 5
+    test_repetitions: int = 5
+    delta_tolerance: float | None = 0.05


 @requires_link_topology(LinkTopology.TWO_LINKS)
@@ -51,6 +74,8 @@ class TestSingleCoreForwardPerf(TestSuite):
     def set_up_suite(self):
         """Set up the test suite."""
         self.test_parameters = self.config.test_parameters
+        self.traffic_duration = self.config.traffic_duration
+        self.test_repetitions = self.config.test_repetitions
         self.delta_tolerance = self.config.delta_tolerance

     def _transmit(self, testpmd: TestPmd, frame_size: int, repetitions: int = 1) -> float:
@@ -76,8 +101,7 @@ def _transmit(self, testpmd: TestPmd, frame_size: int, repetitions: int = 1) ->
         rx_avg = 0.0

         for _ in range(repetitions):
-            # Transmit for 5 seconds.
-            stats = assess_performance_by_packet(packet=packet, duration=5)
+            stats = assess_performance_by_packet(packet=packet, duration=self.traffic_duration)
             rx_avg += stats.rx_pps
         return rx_avg / (repetitions * 1_000_000)

@@ -134,21 +158,25 @@ def single_core_forward_perf(self) -> None:
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
+                params["pass"] = float(params["performance_delta"]) >= -params.get(
+                    "delta_tolerance", self.delta_tolerance
+                )

         self._produce_stats_table(self.test_parameters)

         for params in self.test_parameters:
             verify(
                 params["pass"] is True,
-                f"""Packets forwarded is less than {(1 - self.delta_tolerance) * 100}%
+                f"""Packets forwarded is less than {
+                    (1 - params.get("delta_tolerance", self.delta_tolerance)) * 100
+                }%
                 of the expected baseline.
                 Measured MPPS = {params["measured_mpps"]}
                 Expected MPPS = {params["expected_mpps"]}""",
--
2.56.0

