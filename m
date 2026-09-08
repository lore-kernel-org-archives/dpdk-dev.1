Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4045C79F99
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Sep 2026 17:20:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B337402D8;
	Tue,  8 Sep 2026 19:20:44 +0200 (CEST)
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com
 [74.125.224.46]) by mails.dpdk.org (Postfix) with ESMTP id 655974028D
 for <dev@dpdk.org>; Tue,  8 Sep 2026 19:20:42 +0200 (CEST)
Received: by mail-yx1-f46.google.com with SMTP id
 956f58d0204a3-66fc2844f0eso4986083d50.1
 for <dev@dpdk.org>; Tue, 08 Sep 2026 10:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1788888042; x=1789492842; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7Mg6NzbZmBtuyXz9stXEk7RsaQzOnu4OK5YeaLbDIYk=;
 b=S8bbSPLjDFG9WcW6YmOc2OAoxu3GupgpuopMu3x2oDUG52u8EHcIcy6Oylvdd2l37n
 UHHn5QRdDdepX+uM/AVKguiyUaiW+Vggp33vo9zecpoUKt6aX+R700zuuzEyTP8M3Gdm
 YW7jedjNtj+nZkA0OoxQm1fk0lr3Am6oiT7cE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788888042; x=1789492842;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7Mg6NzbZmBtuyXz9stXEk7RsaQzOnu4OK5YeaLbDIYk=;
 b=rIHLhLssKKKT5oz7tW/ItpgwnT+syuEbhiSkj4+Gj3Au19WatUjiU4A6/Zj9ean+Aq
 KtOYIgx9zk1vePhD3Uv3iTzzfB7vg968EIFE1gAKGHA8TAKW6IhL+G71G66pw+Xzqdvp
 6z2XAfagCfJtjWxRr14JPsixJFKoVZLAy+e7gXuhd9FwC+ZQGDIJ0t67TQ011AnRp9aI
 W84paIk6qb1cIOPHlWYcg6YvyAI2RJqXnR2FxOvWpXImBh+sRf2KCJJuuvAI6QoiGodc
 Yui6po4fvaIR9Z/Ir44RL5Apvgq7oglWO2yfbMBUpyNSj6i+DRM3R6q2P7v+j62GrRAW
 RuYg==
X-Forwarded-Encrypted: i=1;
 AKwUvByyNgG1WLrARmlwxrVjt4YgPztGV/v1vXp708A1PuUss5T9eA3vRwo0YM48bEc/cMAfG/k=@dpdk.org
X-Gm-Message-State: AFuF++k1rTkQ+hkHgNLiX7zZSSaGREg3MiSfATyUKjvkyyVJsg6R3wrD
 5ZvfS6Asf+UnrTwUKzTHLBxQLr3sJqE5/I22F5g78yXSsUwZQbYqA2sblz03ItnYGOE=
X-Gm-Gg: AYBFou20FYRNAW6Miq1ytZoxofFCCh1oQ9oOJhN9xmy3DLRpS2TzcWpLVt4/9ENIQZI
 pdAqK78Wh9dwkJHqmavRXB7mH44ndjvFXr8Tm7perBGzxI2OBMhe9mtqr8R2TeXshdZjh18pJa5
 1Fs4Arn6K4ztqcpabpQLlSe7htNekv9xcwdwxxGsGtQyYQf1rt7mdzLNF9bPbqeSrFEOpUJMVxx
 ZEO5WISVv6wWxJbxypfghl3SiRz+Kh6Q+l/q1lzPku39C8ywdbmVxbwq5tSq0MehonPS2GGI3jN
 tKh+xeX2Eq+NKobyTlMVN1s6N5Ea+9mt+Y5GqnbyuWdtOyivja8/CNVvrDFst7yq2AC0HjaIW+M
 PiXDPPbv2vfVNcwv/GpNlpgMYLFo0ihPls8v79Ipq7N0zylRrho1zzjTTlph2p1qDd2PX3IXlNK
 ItvSk8XkdIBIEU5cBKe0RfO8/nu396eL2ZNKRS4yVBtVajxLpie9lF3cgsueuzQq82iwOXpNuIY
 VFrGlFAvPFY6kIhwNdZPNkmunw0
X-Received: by 2002:a05:690e:4089:b0:66f:c1d5:c6dd with SMTP id
 956f58d0204a3-66fc20cc9damr6796276d50.100.1788888041324; 
 Tue, 08 Sep 2026 10:20:41 -0700 (PDT)
Received: from X1-Gen-9.iol.unh.edu ([2606:4100:3880:1210:e912:3cd:a473:fed1])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91040595f81sm122480496d6.2.2026.09.08.10.20.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 10:20:40 -0700 (PDT)
From: Dillon Ladd <dladd@iol.unh.edu>
To: luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com,
	dev@dpdk.org
Cc: lylavoie@iol.unh.edu, knimoji@iol.unh.edu, abailey@iol.unh.edu,
 Dillon Ladd <dladd@iol.unh.edu>
Subject: [RFC PATCH] dts: add eventdev pipeline performance testsuite
Date: Tue,  8 Sep 2026 13:19:41 -0400
Message-ID: <20260908171941.1617787-1-dladd@iol.unh.edu>
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

This patch adds the eventdev pipeline performance testsuite,
which launches the dpdk-test-eventdev application to measure
packet forwarding throughput performance across various frame
sizes and pipeline scheduling modes against expected baseline metrics.

Signed-off-by: Dillon Ladd <dladd@iol.unh.edu>
---
 dts/tests/TestSuite_eventdev_pipeline_perf.py | 138 ++++++++++++++++++
 1 file changed, 138 insertions(+)
 create mode 100644 dts/tests/TestSuite_eventdev_pipeline_perf.py

diff --git a/dts/tests/TestSuite_eventdev_pipeline_perf.py b/dts/tests/TestSuite_eventdev_pipeline_perf.py
new file mode 100644
index 0000000000..a631a89990
--- /dev/null
+++ b/dts/tests/TestSuite_eventdev_pipeline_perf.py
@@ -0,0 +1,138 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2026 University of New Hampshire
+
+"""EventDev pipeline performance test suite.
+
+Measures packet forwarding throughput (MPPS) using dpdk-test-eventdev pipeline mode.
+"""
+
+from dataclasses import dataclass
+
+from scapy.layers.inet import IP
+from scapy.layers.l2 import Ether
+from scapy.packet import Raw
+
+from api.capabilities import (
+    LinkTopology,
+    requires_link_topology,
+)
+from api.packet import assess_performance_by_packet
+from api.test import verify, write_performance_json
+from framework.params import Option, Params, TextArgument
+from framework.remote_session.dpdk_shell import DPDKShell
+from framework.test_suite import BaseConfig, TestSuite, perf_test
+
+
+@dataclass(kw_only=True)
+class EventDevParams(Params):
+
+    test: str | None = TextArgument("--test")
+    prod_type_ethdev: bool = Option("--prod_type_ethdev")
+    stlist: str | None = TextArgument("--stlist")
+    wlcores: str | None = TextArgument("--wlcores")
+    pool_sz: int | None = TextArgument("--pool-sz")
+
+
+class Config(BaseConfig):
+
+    frame_sizes: list[int] = [64, 128, 256, 512, 1024, 1518]
+    num_descriptors: int = 1024
+    traffic_duration: int = 5
+    pool_size: int = 16384
+    delta_tolerance: float = 0.05
+    expected_mpps: dict[int, float] = {
+        64: 14.8,
+        128: 12.0,
+        256: 8.5,
+        512: 4.5,
+        1024: 2.3,
+        1518: 1.5,
+    }
+
+
+@requires_link_topology(LinkTopology.TWO_LINKS)
+class TestEventdevPipelinePerf(TestSuite):
+
+    config: Config
+
+    def set_up_suite(self) -> None:
+
+        self.delta_tolerance = self.config.delta_tolerance
+
+    def _transmit(self, frame_size: int, repetitions: int = 5) -> float:
+        padding = max(0, frame_size - len(Ether() / IP()))
+        packet = Ether() / IP() / Raw(b"X" * padding)
+
+        total_mpps = 0.0
+        for _ in range(repetitions):
+            stats = assess_performance_by_packet(
+                packet=packet,
+                duration=self.config.traffic_duration,
+            )
+            total_mpps += stats.rx_mpps
+
+        return total_mpps / repetitions
+
+    def _produce_stats_table(self, test_parameters: list[dict[str, int | float]]) -> None:
+    
+        header = f"{'Frame Size':>12} | {'TXD/RXD':>12} | {'Real MPPS':>12} | {'Expected MPPS':>14}"
+        print("-" * len(header))
+        print(header)
+        print("-" * len(header))
+        for params in test_parameters:
+
+            print(f"{params['frame_size']:>12} | {params['num_descriptors']:>12} | ", end="")
+            print(f"{params['measured_mpps']:>12} | {params['expected_mpps']:>14}")
+            print("-" * len(header))
+
+        write_performance_json({"results": test_parameters})
+
+    @perf_test
+    def test_perf_eventdev_pipeline_1ports_atomic_performance(self) -> None:
+        results = []
+
+        worker_core = str(self.sut_node.lcores[1].id)
+
+        eventdev_params = EventDevParams(
+
+            test="pipeline_atq",
+            prod_type_ethdev=True,
+            stlist="a",
+            wlcores=worker_core,
+            pool_sz=self.config.pool_size,
+        )
+
+        with self.sut_node.create_interactive_shell(
+
+            DPDKShell,
+            app_name="dpdk-test-eventdev",
+            app_params=eventdev_params,
+            eal_params=Params(vdev="event_sw0"),
+            privileged=True,
+        ) as eventdev_app:
+            for frame_size in self.config.frame_sizes:
+                
+                measured_mpps = round(self._transmit(frame_size=frame_size, repetitions=5), 2)
+                expected_mpps = self.config.expected_mpps.get(frame_size, 0.0)
+                passed = measured_mpps >= (expected_mpps * (1 - self.delta_tolerance))
+
+                results.append(
+                    {
+                        "frame_size": frame_size,
+                        "num_descriptors": self.config.num_descriptors,
+                        "measured_mpps": measured_mpps,
+                        "expected_mpps": expected_mpps,
+                        "pass": passed,
+                    }
+                )
+
+        self._produce_stats_table(results)
+
+        for result in results:
+
+            expected_baseline = result["expected_mpps"] * (1 - self.delta_tolerance)
+            verify(
+                result["pass"],
+                f"Measured MPPS ({result['measured_mpps']:.2f}) for frame size {result['frame_size']} "
+                f"is below expected baseline ({expected_baseline:.2f}).",
+            )
-- 
2.53.0

