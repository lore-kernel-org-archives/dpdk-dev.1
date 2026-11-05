Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A14C606A31B
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Nov 2026 20:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iol.unh.edu header.i=@iol.unh.edu header.a=rsa-sha256 header.s=unh-iol header.b=OUbU0fQl
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 62BB0427BB;
	Thu,  5 Nov 2026 21:05:04 +0100 (CET)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com
 [209.85.219.54])
 by mails.dpdk.org (Postfix) with ESMTPS id 58691427B6
 for <dev@dpdk.org>; Thu,  5 Nov 2026 21:05:03 +0100 (CET)
Received: by mail-qv1-f54.google.com with SMTP id
 6a1803df08f44-91c76540d0bso23408336d6.0
 for <dev@dpdk.org>; Thu, 05 Nov 2026 12:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1793909102; x=1794513902; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ftZ++o89wtZ6QsZ7vB3gLQzeXdigrY5aMHJ6MzAA5X0=;
 b=OUbU0fQl31mMG3J2hh8NUxYwrj/zAxN79tCNSRtJ8aVQFd1T9SHOCNuM49lU4ImgSN
 deer5/4QJH25fWTd5X64tXS2tDa65zN5HT8cAmEY9pBAorcw5yuUVTQtg/4eAxfccRDS
 0cL+0YTVTPzJgCy4D2v05Zr/rBFaXSeV+4ypg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793909102; x=1794513902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ftZ++o89wtZ6QsZ7vB3gLQzeXdigrY5aMHJ6MzAA5X0=;
 b=oWCXgLkkXH0xD9ByZwlpLW4Chv23nvd6UclXZOsLlF5kk63cMr96bBtp+CBOXgJhsD
 hYKhkQaGXoDWL42i9BaBcQEb2YDQutRjkWK5FK1MnFjG4txBYslCL7Go77Z+C7yd7bsM
 DYjcbjSXPp0yTAehydLFvLJ4shn+lhWNgDSWMdagR4azVe1jbgWfmpxQbKr0z8wRyF0b
 stM/Eor8R3Sl8Sn6gzegAbSC6a+4xZVjWfIcm8cUv4U84NSKUdiDPfIo0VE0OMadYS4N
 pbguRsq1s0Aa4TJ2XfjcILLT4gWjmJLKHIlza54I2VeGpA3w1EFr1Bk+YZsnpMahSgmi
 455g==
X-Gm-Message-State: APuU4Z8WeNFhcDg0T6+XxSj4KwTrfy2nTTbLBTJ+Up9YgWmu3zqp6WQM
 mOalw9KQUdfA4X1DuIJ49j0zSaINWpL1hsZl7XgD4eoRwRxFVA/Y1I16sOpqz0mCWOc=
X-Gm-Gg: AYBFou3p5QLtn+ids+LBgTaO54+HFWYT9wW2mDsinZe9ZZozcq1TE2zsoioE0AajIR0
 cz1TenDH2MkqODewVIE+nRLdlu7I7IB3oprj8h/ieMmoZTdKmI2iPd6hICfMYVGNSHJrxJPmwCE
 v2kCtP1NZvSMV9/Ma0JulwlaADbVVZX/Gc9FQsiTob7ARJJfeRCC+IUR6jB2bZNCtZGWeausk+w
 n4I6r1GylRihfUq+jSlaw5bbUcNQCH8qqhq6A19kkeeyusV6RuuXfEFo8kt64SxQY2XpN70I+KC
 xJ3HojBMTm4xW2DOoacRJFZaLn9bl+Lo54Mu8fWOkSupe7DDqVRNo997OQYJFsvzqWbbMr2GXB8
 UHC99/B3lG/tXum7YDf00WdfVfzyjXtSnLX55ftHhLI2pEV2QApYZwTHWt0YyovsNV+jUT8SNqa
 GAoJVGb8q+KLznhXMI3MlaGLQNPVpju4fTNtlNrMOEMKdqHvANV7UKW4uNFVnNowy6bhEP0F/2P
 JLFD4p+XhfrxHuiUyAaCxcEPffR71TBGtwv/RBsU3a1HKN75WEZW7A0Ya1VayypCWFTfRUPcK5/
 zxjU6w/DQBEREyL7DOJ9bn4GgdxNZKlBdBJdYxycGPM9giE4jMO27wX+0+amL5H+vDVm3Q==
X-Received: by 2002:a05:6214:3981:b0:917:8a83:a15c with SMTP id
 6a1803df08f44-91ea971f9c6mr739136d6.34.1793909101893; 
 Thu, 05 Nov 2026 12:05:01 -0800 (PST)
Received: from X1-Gen-9.iol.unh.edu ([2606:4100:3880:1271:52c6:dd10:2790:6507])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91ea6a71bfesm3544646d6.25.2026.11.05.12.05.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 12:05:01 -0800 (PST)
From: Dillon Ladd <dladd@iol.unh.edu>
To: patrickrobb1997@gmail.com,
	luca.vizzarro@arm.com
Cc: dev@dpdk.org, knimoji@iol.unh.edu, abailey@iol.unh.edu,
 Dillon Ladd <dladd@iol.unh.edu>
Subject: [PATCH v2 2/2] dts: add eventdev pipeline performance test suite
Date: Thu,  5 Nov 2026 15:04:12 -0500
Message-ID: <20261105200413.513618-2-dladd@iol.unh.edu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261105200413.513618-1-dladd@iol.unh.edu>
References: <20261105174137.498850-1-dladd@iol.unh.edu>
 <20261105200413.513618-1-dladd@iol.unh.edu>
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
index 0000000000..9efcea3770
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
+from api.test_suite import BaseConfig, TestSuite, perf_test, perf_suite
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
+@perf_suite
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

