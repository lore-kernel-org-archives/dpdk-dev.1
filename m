Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094B4606A32C
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Nov 2026 17:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iol.unh.edu header.i=@iol.unh.edu header.a=rsa-sha256 header.s=unh-iol header.b=GZ0ZrxYr
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C0DF9427BB;
	Thu,  5 Nov 2026 18:41:53 +0100 (CET)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com
 [209.85.222.179])
 by mails.dpdk.org (Postfix) with ESMTPS id 2F9E2427B6
 for <dev@dpdk.org>; Thu,  5 Nov 2026 18:41:53 +0100 (CET)
Received: by mail-qk1-f179.google.com with SMTP id
 af79cd13be357-93a40a9a01aso108001885a.0
 for <dev@dpdk.org>; Thu, 05 Nov 2026 09:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1793900512; x=1794505312; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lznq61srfAck5/qCTeVBk1annbeZ43Qdr7q8iImFtrU=;
 b=GZ0ZrxYr+TQHFATA/TaSr8jE0CCLS5Cz7WbkEXURn6dBtd46q7hlfnCUFCQgFYV9JL
 +8tnuGLkAUnP25AdaBFdGmJKzTuVD6aZ7xTfwCvJTOLoo9eCjOp8eczPb/p6xs9p0eeL
 n0Hj79CHP7dKYZCoO3N5ckr0AwqUyx2j0kLwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793900512; x=1794505312;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lznq61srfAck5/qCTeVBk1annbeZ43Qdr7q8iImFtrU=;
 b=jodh5otoihZQIvNT3O7WCS5ioR2iKS6pwFNLGUcvOhx+LCYCctEkHrHsDrYABPKWhA
 VRBvlsT+uA6OgONhb3CMDrziDDG9iTNjV/dwc7zcxMXHnUa+BNqXwB1Gj+AC0cwvls/e
 BC02uDtCO2kq60ThU2oQyxiE6oJPRtNApJUPs7kMLclGzt3cyfC5JTFHyoLmvmrWPGOQ
 jXeBXsMtpAU6+bD3ajziZseSRosdRF1XRqDm0vpuFwFd2bjoQ/nYK7W9kCuUZlcnOysq
 ARZmrbLcUfJTVC1/Hx7WOyZZthBApoaJXA3AKouvcBFMWjz7P9n6jE/33tpQ33qZ2loE
 QI7g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwv5HVg+byKU1ZMdXQDHRHO92/JsJEtdb4QAX5BfwYQ483zwqjWHzgLO743la5DO88M7jk=@dpdk.org
X-Gm-Message-State: APuU4Z8tH8A3NN1o0LfI5+KirOiHboIQLpMVqHL+DJ8d/OdDnp/ZDiNY
 y0+/4AzwK6GMfotMNa09KRCTaXmVgNG5guGDz2j/dQMu6UyreAX+wf3BpFatzkLknDo=
X-Gm-Gg: AYBFou2S9JhpgmFp82OLbMRvRSB+5czzlVEukmAnCJ3k+87rbIFcmIXNHeI6TOevq9C
 /j7f4WYH0jbv6uRipIiCFx6P2c1Rm21uN9AkdSpeQNSGDJUjDB8vE5p98K+JmpG7ECgPMO7UP/X
 55ZDVY+rwmJL0GvOHw2sKjLmPFEtO8ncUg/Bwu5qSiAZVLT0BQm2WFucANHbwoEpn5AwQvEOM2W
 gTRbaBBOhjTdyC/QRNikapslOgImZYD5yLAecnS7jTLt5fLCUsKsJpKmWq5O/2m7kKljX05MZdS
 G4SlICsWhr9abJtoWFMFsUttimMzTdy1pxcVe1k3qNOfbNg+kkrkvtLiKkAO3Zw0tyatG9wXdT/
 DCX+ArwOB4RbnBsVQbpMQ4HhS7HCggY/A8yi8KMpf47DX3qh9NdY01WeCvJs4dvgkOW3mu9Thaj
 sylZHKYkS5W/wHDGWCxWuuI4C/spY36t+P2CmUMPClJNuP3NZeLJwFQ6FveuQ6Uj7jVxG9JqZql
 rJ3NScXX+6EIicEXNY+ZMitlTmm0sJnHGCo8hJur6RWWpSxVeepTapeJvtjRUrt6T3DA+mNk5Ai
 RDbzIoVgkVM5v4Yj1QWG1YZDIIlQGqRFbLtTWLyRtz4idXBky2PzsBDo5ebF2zjr0kcWUA==
X-Received: by 2002:a05:620a:2688:b0:945:d7a2:4b57 with SMTP id
 af79cd13be357-945e1623519mr502123785a.21.1793900511940; 
 Thu, 05 Nov 2026 09:41:51 -0800 (PST)
Received: from X1-Gen-9.iol.unh.edu ([2606:4100:3880:1271:980d:bd8a:336d:5c24])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-945d4852ba3sm509329785a.31.2026.11.05.09.41.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 09:41:50 -0800 (PST)
From: Dillon Ladd <dladd@iol.unh.edu>
To: luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com,
	dev@dpdk.org
Cc: knimoji@iol.unh.edu, abailey@iol.unh.edu, Dillon Ladd <dladd@iol.unh.edu>
Subject: [PATCH v1 2/2] dts: add eventdev pipeline performance test suite
Date: Thu,  5 Nov 2026 12:41:37 -0500
Message-ID: <20261105174137.498850-2-dladd@iol.unh.edu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261105174137.498850-1-dladd@iol.unh.edu>
References: <20261105174137.498850-1-dladd@iol.unh.edu>
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

Add a test suite measuring eventdev pipeline forwarding
performance across frame sizes against expected baselines.

Each run sets the scheduled type list, frame size and
expected MPPS, with a configurable delta tolerance.

Ported from the old DTS, as the current DTS has no eventdev
testing coverage.

Signed-off-by: Dillon Ladd <dladd@iol.unh.edu>
---
 dts/tests/TestSuite_eventdev_pipeline_perf.py | 143 ++++++++++++++++++
 1 file changed, 143 insertions(+)
 create mode 100644 dts/tests/TestSuite_eventdev_pipeline_perf.py

diff --git a/dts/tests/TestSuite_eventdev_pipeline_perf.py b/dts/tests/TestSuite_eventdev_pipeline_perf.py
new file mode 100644
index 0000000000..9c35bb0fb4
--- /dev/null
+++ b/dts/tests/TestSuite_eventdev_pipeline_perf.py
@@ -0,0 +1,143 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2026 University of New Hampshire
+
+"""Eventdev pipeline performance test suite.
+
+This suite measures the packet rate forwarded through the DPDK event device pipeline using the
+dpdk-test-eventdev application. For each set of parameters in the test config, which consist of a
+scheduled type list, a frame size and the expected MPPS, a performance traffic generator sends
+traffic through the pipeline. The measured MPPS is compared against the expected baseline.
+"""
+
+import time
+
+from scapy.layers.inet import IP
+from scapy.layers.l2 import Ether
+from scapy.packet import Raw
+
+from api.capabilities import (
+    LinkTopology,
+    requires_link_topology,
+)
+from api.eventdev import Eventdev
+from api.packet import assess_performance_by_packet
+from api.test import verify, write_performance_json
+from api.test_suite import BaseConfig, TestSuite, perf_test
+
+
+class Config(BaseConfig):
+    """Performance test metrics.
+
+    Attributes:
+        test: The eventdev test to run.
+        num_workers: The number of worker cores.
+        pool_size: The size of the mbuf mempool.
+        test_parameters: The scheduled type list, frame size and expected MPPS of each test run.
+        delta_tolerance: The allowed tolerance below a given baseline.
+        link_up_delay: The time in seconds to wait for the links to come up.
+    """
+
+    test: str = "pipeline_queue"
+    num_workers: int = 1
+    pool_size: int = 16384
+    test_parameters: list[dict[str, int | float | str]] = [
+        {"stlist": "a", "frame_size": 64, "expected_mpps": 1.00},
+        {"stlist": "a", "frame_size": 128, "expected_mpps": 1.00},
+        {"stlist": "a", "frame_size": 256, "expected_mpps": 1.00},
+        {"stlist": "a", "frame_size": 512, "expected_mpps": 1.00},
+        {"stlist": "a", "frame_size": 1024, "expected_mpps": 1.00},
+        {"stlist": "a", "frame_size": 1518, "expected_mpps": 1.00},
+    ]
+    delta_tolerance: float = 0.05
+    link_up_delay: int = 5
+
+
+@requires_link_topology(LinkTopology.TWO_LINKS)
+class TestEventdevPipelinePerf(TestSuite):
+    """Eventdev pipeline performance test suite."""
+
+    config: Config
+
+    def _transmit(self, frame_size: int, repetitions: int = 1) -> float:
+        """Send packets of the given size and measure the average Rx rate.
+
+        Args:
+            frame_size: The size of the frames to send.
+            repetitions: The number of times to send traffic.
+
+        Returns:
+            The average Rx rate in MPPS.
+        """
+        assert repetitions > 0, "Invalid number of repetitions given."
+        # Build packet with dummy values, and account for the 14B and 20B Ether and IP headers.
+        packet = (
+            Ether(src="52:00:00:00:00:00")
+            / IP(src="1.2.3.4", dst="192.18.1.0")
+            / Raw(load="x" * (frame_size - 14 - 20))
+        )
+
+        rx_avg = 0.0
+        for _ in range(repetitions):
+            stats = assess_performance_by_packet(packet=packet, duration=5)
+            rx_avg += stats.rx_pps
+        return rx_avg / (repetitions * 1_000_000)
+
+    def _produce_stats_table(self, test_parameters: list[dict[str, int | float | str]]) -> None:
+        """Print the results table and write the results to the performance JSON.
+
+        Args:
+            test_parameters: The test parameters, including the measured MPPS.
+        """
+        header = f"{'Stlist':>8} | {'Frame Size':>12} | {'Real MPPS':>12} | {'Expected MPPS':>14}"
+        print("-" * len(header))
+        print(header)
+        print("-" * len(header))
+        for params in test_parameters:
+            print(f"{params['stlist']:>8} | {params['frame_size']:>12} | ", end="")
+            print(f"{params['measured_mpps']:>12} | {params['expected_mpps']:>14}")
+            print("-" * len(header))
+
+        write_performance_json({"results": test_parameters})
+
+    @perf_test
+    def eventdev_pipeline_perf(self) -> None:
+        """Eventdev pipeline performance test.
+
+        Steps:
+            * Launch dpdk-test-eventdev with the software event device and an Ethernet device as
+              the producer.
+            * Send traffic at each configured frame size.
+
+        Verify:
+            * Measured MPPS is within the delta tolerance of the expected MPPS.
+        """
+        for params in self.config.test_parameters:
+            with Eventdev(
+                test=self.config.test,
+                num_workers=self.config.num_workers,
+                stlist=str(params["stlist"]),
+                pool_sz=self.config.pool_size,
+            ):
+                time.sleep(self.config.link_up_delay)
+                params["measured_mpps"] = round(
+                    self._transmit(int(params["frame_size"]), repetitions=5), 3
+                )
+            params["performance_delta"] = round(
+                (float(params["measured_mpps"]) - float(params["expected_mpps"]))
+                / float(params["expected_mpps"]),
+                3,
+            )
+            params["pass"] = float(params["performance_delta"]) >= -self.config.delta_tolerance
+
+        self._produce_stats_table(self.config.test_parameters)
+
+        for params in self.config.test_parameters:
+            verify(
+                params["pass"] is True,
+                f"""Packets forwarded is less than {(1 - self.config.delta_tolerance) * 100}%
+                of the expected baseline.
+                Stlist = {params["stlist"]}
+                Frame size = {params["frame_size"]}
+                Measured MPPS = {params["measured_mpps"]}
+                Expected MPPS = {params["expected_mpps"]}""",
+            )
-- 
2.53.0

