Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E60CCF9E0
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 17:47:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 270D3402F1;
	Fri, 24 Oct 2025 19:47:14 +0200 (CEST)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com
 [209.85.219.44]) by mails.dpdk.org (Postfix) with ESMTP id B87A6402D1
 for <dev@dpdk.org>; Fri, 24 Oct 2025 19:47:09 +0200 (CEST)
Received: by mail-qv1-f44.google.com with SMTP id
 6a1803df08f44-78f30dac856so26232086d6.2
 for <dev@dpdk.org>; Fri, 24 Oct 2025 10:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1761328029; x=1761932829; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A34vYKm0SOjv+NbkSGWQKfOf5bATwvn+XWlrYd0Ltwk=;
 b=PK2FsFbzGT7xfgCfle25t+mdT9krpl9KDPUHL9dsZRQeYvfFyrhfD/RT4DllIW6+4T
 ucg9/aQ0W/EG6pcvBMVMdKWUXnpwimaC0oy/BVzD0Ykob99kAKAluYUvS4Se9jfhkfU1
 eZGazoOOf3SjaRNTZLWL3NjmYWC3AGa7You8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761328029; x=1761932829;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A34vYKm0SOjv+NbkSGWQKfOf5bATwvn+XWlrYd0Ltwk=;
 b=eaCw1VTXrGanZSHx3V6z3szq0NuJDX7Wno12J1JAm3clnuLpvor+JSIXpT4pN6ogBz
 rd5nqUm9/eZJeGAA4yVDHQMB10Ug79hGWokTyxJjlPmPUeycYa86jYB9m1W2/IKKi5o0
 Hby/EyR7Xd5dXqawNG8mS2RLMytcMIFcgqrdbDUX6h/MeFX1npJbJPtTGCWQ0NiTfQdQ
 Xti3KGX/jjlRxvyglGD+sIJR+Z446dedbOcZ2lLIEKOomRzU0qysY3EXAuqtnziOXgr0
 fUgwWXgjxbZOY9GjpJ/6TBc0t1kFGXCTmMzQgdTKM32nZdgx1aR/dy5aZ8aGcqFB0WTA
 Cp/A==
X-Gm-Message-State: AOJu0YzunPEacwJiHZ4MpzB+aTOZqANbCOcnEjGeAjoFFqOyeQ3pKEid
 TiTHjjda+7a6R3Oe3+v9lId7RyqZFrTt9Thk6E29SGmWti+QhG4QRMol5AsFVKhE8sA=
X-Gm-Gg: ASbGncteI6n/e5sh3c1gEuAp6siv8aTMJ4H+21trD3/w20NodjJgZZ+FBWTgRpiACND
 JQBubx3GHhvYAE16Y82tW+IaN+pMU+Jaos4UI/4DcuxNJhZ6DCIzO89qmGhMPOVCE1WJH7XD2DT
 KaravLmv3ERyVYhIcLOUnGDYR/OJ7DZ68quz8g1ZzjCEDnfISRov4eW6Tyd9u/ASQ8YhnmGwHO8
 W8uaB9Fcuf65zGZcu2vrnexTMc5aXnHCj8y2c1VEsKAGAJlhliOhbNqtkTrW5H5Ov/anfvHI/9B
 h+1oxg41DvHrlTzlE5AX1pl0lX8UmrJIHIhzT/69zsFODL2Htz099kuc6hNsPY9C8U3CoLyGUzX
 ACBTJ7unzDTEbbXV5EEvqzNQDVplxNAqmS2jAS/ydrVve+7cSOrQXCnZ+uK+sqI0J2B8phzWfGO
 urTX8=
X-Google-Smtp-Source: AGHT+IFoaPJt2yXFzW+b7uCy1VTEK13HPIdWHkZ/fiuO2odNrY0WyNRQyjkwvUm2hLTSRk1op6Z6cA==
X-Received: by 2002:a05:6214:2241:b0:786:5ae7:7846 with SMTP id
 6a1803df08f44-87f9ee79852mr86675626d6.32.1761328029012; 
 Fri, 24 Oct 2025 10:47:09 -0700 (PDT)
Received: from d121016.iol.unh.edu ([2606:4100:3880:1257::100a])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87f9de816a2sm40527256d6.24.2025.10.24.10.47.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Oct 2025 10:47:08 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v3 3/3] dts: add virtio forwarding test suite
Date: Fri, 24 Oct 2025 13:47:00 -0400
Message-ID: <20251024174702.600147-3-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024174702.600147-1-dmarx@iol.unh.edu>
References: <20251003192717.444490-1-dmarx@iol.unh.edu>
 <20251024174702.600147-1-dmarx@iol.unh.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add test suite covering virtio-user/vhost-user
server/client forwarding scenarios with
testpmd packet validation.

Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
---
 doc/api/dts/tests.TestSuite_virtio_fwd.rst |   8 +
 dts/tests/TestSuite_virtio_fwd.py          | 191 +++++++++++++++++++++
 2 files changed, 199 insertions(+)
 create mode 100644 doc/api/dts/tests.TestSuite_virtio_fwd.rst
 create mode 100644 dts/tests/TestSuite_virtio_fwd.py

diff --git a/doc/api/dts/tests.TestSuite_virtio_fwd.rst b/doc/api/dts/tests.TestSuite_virtio_fwd.rst
new file mode 100644
index 0000000000..ef0d86a776
--- /dev/null
+++ b/doc/api/dts/tests.TestSuite_virtio_fwd.rst
@@ -0,0 +1,8 @@
+.. SPDX-License-Identifier: BSD-3-Clause
+
+virtio_fwd Test Suite
+=====================
+
+.. automodule:: tests.TestSuite_virtio_fwd
+   :members:
+   :show-inheritance:
\ No newline at end of file
diff --git a/dts/tests/TestSuite_virtio_fwd.py b/dts/tests/TestSuite_virtio_fwd.py
new file mode 100644
index 0000000000..8f5fe03335
--- /dev/null
+++ b/dts/tests/TestSuite_virtio_fwd.py
@@ -0,0 +1,191 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2025 University of New Hampshire
+
+"""Virtio forwarding test suite.
+
+Verify vhost/virtio pvp and loopback topology functionalities.
+"""
+
+from scapy.layers.inet import IP
+from scapy.layers.l2 import Ether
+
+from api.capabilities import LinkTopology
+from api.packet import send_packets_and_capture
+from api.test import log, verify
+from api.testpmd import TestPmd
+from api.testpmd.config import SimpleForwardingModes
+from framework.test_suite import TestSuite, func_test
+from framework.testbed_model.capability import requires
+from framework.testbed_model.linux_session import LinuxSession
+from framework.testbed_model.virtual_device import VirtualDevice
+
+
+@requires(topology_type=LinkTopology.TWO_LINKS)
+class TestVirtioFwd(TestSuite):
+    """Virtio forwarding test suite."""
+
+    virtio_user_vdev = VirtualDevice(
+        "net_virtio_user0,mac=00:01:02:03:04:05,path=/tmp/vhost-net,server=1"
+    )
+    vhost_user_vdev = VirtualDevice("eth_vhost0,iface=/tmp/vhost-net,client=1")
+
+    @func_test
+    def virtio_server(self) -> None:
+        """Test virtio server packet transmission.
+
+        Steps:
+            * Launch a testpmd session with a vhost-user virtual device (client side).
+            * Launch a testpmd session with a virtio-user virtual device (server side).
+            * Set the forwarding mode to mac in both sessions.
+            * Start packet forwarding on vhost session.
+            * Send a burst of packets from the virtio session.
+            * Stop packet forwarding on vhost session and collect packet stats.
+
+        Verify:
+            * Vhost session receives packets from virtio session.
+        """
+        with (
+            TestPmd(
+                prefix="vhost",
+                no_pci=True,
+                memory_channels=4,
+                vdevs=[self.vhost_user_vdev],
+            ) as vhost,
+            TestPmd(
+                prefix="virtio",
+                no_pci=True,
+                memory_channels=4,
+                vdevs=[self.virtio_user_vdev],
+            ) as virtio,
+        ):
+            vhost.set_forward_mode(SimpleForwardingModes.mac)
+            virtio.set_forward_mode(SimpleForwardingModes.mac)
+
+            vhost.start()
+            virtio.start_tx_first(burst_num=32)
+            vhost.stop()
+
+            vhost_forwarding_stats, vhost_raw_output = vhost.show_port_stats_all()
+
+            rx_packets = vhost_forwarding_stats[0].rx_packets
+            tx_packets = vhost_forwarding_stats[0].tx_packets
+
+            log(f"Vhost forwarding statistics:\n{vhost_raw_output}")
+
+            verify(
+                rx_packets != 0 and tx_packets != 0,
+                "Vhost session failed to receive packets from virtio session.",
+            )
+
+    @func_test
+    def virtio_server_reconnect(self) -> None:
+        """Test virtio server reconnection.
+
+        Steps:
+            * Launch a testpmd session with a vhost-user virtual device (client side).
+            * Launch a testpmd session with a virtio-user virtual device (server side).
+            * Close the virtio session and relaunch it.
+            * Start packet forwarding on vhost session.
+            * Send a burst of packets from the virtio session.
+            * Stop packet forwarding on vhost session and collect packet stats.
+
+        Verify:
+            * Vhost session receives packets from relaunched virtio session.
+        """
+        with TestPmd(
+            prefix="vhost",
+            no_pci=True,
+            memory_channels=4,
+            vdevs=[self.vhost_user_vdev],
+        ) as vhost:
+            with TestPmd(
+                prefix="virtio",
+                no_pci=True,
+                memory_channels=4,
+                vdevs=[self.virtio_user_vdev],
+            ) as virtio:
+                pass
+            # end session and reconnect
+            with TestPmd(
+                prefix="virtio",
+                no_pci=True,
+                memory_channels=4,
+                vdevs=[self.virtio_user_vdev],
+            ) as virtio:
+                virtio.set_forward_mode(SimpleForwardingModes.mac)
+                vhost.set_forward_mode(SimpleForwardingModes.mac)
+
+                vhost.start()
+                virtio.start_tx_first(burst_num=32)
+                vhost.stop()
+
+                vhost_forwarding_stats, vhost_raw_output = vhost.show_port_stats_all()
+
+                rx_packets = vhost_forwarding_stats[0].rx_packets
+                tx_packets = vhost_forwarding_stats[0].tx_packets
+
+                log(f"Vhost forwarding statistics:\n{vhost_raw_output}")
+
+                verify(
+                    rx_packets != 0 and tx_packets != 0,
+                    "Vhost session failed to receive packets from virtio session.",
+                )
+
+    @func_test
+    def pvp_loop(self) -> None:
+        """Test vhost/virtio physical-virtual-physical loop topology.
+
+        Steps:
+            * Launch testpmd session with a physical NIC and virtio-user vdev
+                connected to a vhost-net socket.
+            * Configure the tap interface that is created with IP address and
+                set link state to UP.
+            * Launch second testpmd session with af_packet vdev connected to
+                the tap interface.
+            * Start packet forwarding on both testpmd sessions.
+            * Send 100 packets to the physical interface from external tester.
+            * Capture packets on the same physical interface.
+
+        Verify:
+            * Vhost session receives/forwards 100+ packets.
+            * Physical interface receives all 100 sent packets.
+        """
+        self.sut_node = self._ctx.sut_node
+        if not isinstance(self.sut_node.main_session, LinuxSession):
+            verify(False, "Must be running on a Linux environment.")
+        with TestPmd(
+            prefix="virtio",
+            vdevs=[VirtualDevice("virtio_user0,path=/dev/vhost-net,queues=1,queue_size=1024")],
+        ) as virtio:
+            self.sut_node.main_session.set_interface_link_up(name="tap0")
+            with TestPmd(
+                prefix="vhost", no_pci=True, vdevs=[VirtualDevice("net_af_packet0,iface=tap0")]
+            ) as vhost:
+                virtio.set_forward_mode(SimpleForwardingModes.mac)
+                vhost.set_forward_mode(SimpleForwardingModes.mac)
+                vhost.start()
+                virtio.start()
+
+                packet = Ether() / IP()
+                packets = [packet] * 100
+                captured_packets = send_packets_and_capture(packets)
+
+                vhost.stop()
+                virtio.stop()
+
+                vhost_forwarding_stats, vhost_raw_output = vhost.show_port_stats_all()
+
+                rx_packets = vhost_forwarding_stats[0].rx_packets
+                tx_packets = vhost_forwarding_stats[0].tx_packets
+
+                log(f"Vhost forwarding statistics:\n{vhost_raw_output}")
+
+                verify(
+                    rx_packets >= 100 and tx_packets >= 100,
+                    f"PVP loop forwarding verification failed: vhost interface RX={rx_packets},"
+                    f" TX={tx_packets} (expected ≥100 each).",
+                )
+
+                verify(
+                    len(captured_packets) >= 100, "Sent packets not received on physical interface."
+                )
-- 
2.51.0

