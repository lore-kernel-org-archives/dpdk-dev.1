Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 995E9CAC5B0
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Oct 2025 19:27:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 79C9740672;
	Fri,  3 Oct 2025 21:27:23 +0200 (CEST)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com
 [209.85.222.177])
 by mails.dpdk.org (Postfix) with ESMTP id 15891402B5
 for <dev@dpdk.org>; Fri,  3 Oct 2025 21:27:21 +0200 (CEST)
Received: by mail-qk1-f177.google.com with SMTP id
 af79cd13be357-87a0801ba1aso184292685a.2
 for <dev@dpdk.org>; Fri, 03 Oct 2025 12:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1759519640; x=1760124440; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7rB6x3a9FoiWmrW+mCeBMKYj9CGY9GENIC8ZYuYZnqA=;
 b=er5iJb58q4YBISpVHUXkZfYmfNf4++4Oca5osq5DD71Bmg5o7uLOFnpYmzn7HekBho
 uDbtt2G0FWineMKAjCPrlRAG1oJ6lEwSVF1mdObPOq8T99tg4lsyTjWY+VxzodzW5I4k
 //B5zgKm4m9WjLqSmnK89RwLrmieW9Jz3+T5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759519640; x=1760124440;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7rB6x3a9FoiWmrW+mCeBMKYj9CGY9GENIC8ZYuYZnqA=;
 b=l5f9WlaVyUlz8uQgyMO0AdJNEChvtctGnw6uYNa3z7sWUoQ6EB5JsK3/yVSPkbe1y+
 9E3LvS8XaHPvBYG/OgFr3D/vEQRqNbsvro1O12ESZm8Uw691DoV5mJSW1TO6LMr4dNSj
 i0XO0wOBSzigpjDS9s9d09/3Tcno5MwIGBIdjjQN78UtGcdne1mKgd/3vciapv4gkvtM
 p5eY+3dffa+6PfKbmzZ5TdajoIReFZRDNJzsCFq0G/JFlbvOUV0a2U6QD9riwPyyUnB6
 W1iHbSQgvO519PY7TOC/mnakLSzlC8lNUdfICBuMw82Gf6M9bfIWN6ec+Txl+I6btCjD
 FiWg==
X-Gm-Message-State: AOJu0YyuqFMdeUd9eu2STHmZ7FHjD35j0xxD/9PzvYgsOXh4owm0LVLG
 z4sGM1GrfCMANyFaj9Q7sLp2jgAmlzPOOkAbHw1lstURqO+SNCd2byz0wd3Zd4FfM7A=
X-Gm-Gg: ASbGnctCLjrTOJdkCgM/EUfVQADJ1FziNgQ1OsAuu0O9qvT2XQd+v4GtVUev4PfwQdN
 yREhvDxBCpjOMMQa71DJ5Y4mkrpSFDmky8zk7FEvbMPoTrgPxdkYtRRV73CvrdQaw/vXB6akHXB
 k6uc8zuSu1WlE5qNoWYeCgSJKBUY8ZjwcNtIGbBaKhMPKnWyBVJ0bD3TmPBfvGqmPsJYb3phkDo
 yNll2xunXDzcqfR2DisB4Yh39RrOIS47rcsL+w5/1mtPduHED8QafTTtTBecg2zWNX4pJVsWIrI
 LTnVzGOB0QtqpJB5f+noGZogS1Eohp0XUswQpeBz0TlluKlQ2NSK07z7imlfAs4b0/lusrXyaRx
 nxPWTBopon9xwP2GGsFc3NbJBSaWIvyOTsqjMOzv5V7NHYlKg
X-Google-Smtp-Source: AGHT+IH4TK4DBX80McAeeXyCbLFULI85e6fkP9OXBn9XqtEq+XQ5xLGjaAtkiukzd0mpEIShMPm2eg==
X-Received: by 2002:a05:620a:414f:b0:849:84b9:e1e4 with SMTP id
 af79cd13be357-87a33d360demr510653485a.7.1759519640186; 
 Fri, 03 Oct 2025 12:27:20 -0700 (PDT)
Received: from d121016.iol.unh.edu ([2606:4100:3880:1210::202])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-877735a0664sm492490785a.30.2025.10.03.12.27.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 12:27:19 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v2 2/2] dts: add virtio forwarding test suite
Date: Fri,  3 Oct 2025 15:27:16 -0400
Message-ID: <20251003192717.444490-2-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003192717.444490-1-dmarx@iol.unh.edu>
References: <20250916200458.259376-1-dmarx@iol.unh.edu>
 <20251003192717.444490-1-dmarx@iol.unh.edu>
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

Add test suite covering virtio-user and vhost
server/client forwarding scenarios with
testpmd packet validation.

Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
---
 doc/api/tests.TestSuite_virtio_fwd.rst |   8 ++
 dts/tests/TestSuite_virtio_fwd.py      | 180 +++++++++++++++++++++++++
 2 files changed, 188 insertions(+)
 create mode 100644 doc/api/tests.TestSuite_virtio_fwd.rst
 create mode 100644 dts/tests/TestSuite_virtio_fwd.py

diff --git a/doc/api/tests.TestSuite_virtio_fwd.rst b/doc/api/tests.TestSuite_virtio_fwd.rst
new file mode 100644
index 0000000000..782eddad2d
--- /dev/null
+++ b/doc/api/tests.TestSuite_virtio_fwd.rst
@@ -0,0 +1,8 @@
+.. SPDX-License-Identifier: BSD-3-Clause
+
+virtio_fwd Test Suite
+===========================
+
+.. automodule:: tests.TestSuite_virtio_fwd
+   :members:
+   :show-inheritance:
\ No newline at end of file
diff --git a/dts/tests/TestSuite_virtio_fwd.py b/dts/tests/TestSuite_virtio_fwd.py
new file mode 100644
index 0000000000..194bd24257
--- /dev/null
+++ b/dts/tests/TestSuite_virtio_fwd.py
@@ -0,0 +1,180 @@
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
+from api.testpmd import TestPmd
+from api.testpmd.config import SimpleForwardingModes
+from framework.parser import TextParser
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
+    class ForwardingParsers:
+        """Class for gathering Rx/Tx packets from testpmd stats."""
+
+        rx_packets = TextParser.find_int(r"RX-packets:\s*(\d+)")
+        tx_packets = TextParser.find_int(r"TX-packets:\s*(\d+)")
+
+    class vdevs:
+        """Class containing virtio-user and vhost-user virtual devices."""
+
+        virtio_user = VirtualDevice(
+            "net_virtio_user0,mac=00:01:02:03:04:05,path=/tmp/vhost-net,server=1"
+        )
+        vhost_user = VirtualDevice("eth_vhost0,iface=/tmp/vhost-net,client=1")
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
+            * Stop packet forwarding on vhost session and collect Rx packet stats.
+
+        Verify:
+            * Vhost session receives packets from virtio session.
+        """
+        with (
+            TestPmd(
+                prefix="vhost",
+                no_pci=True,
+                memory_channels=4,
+                vdevs=[self.vdevs.vhost_user],
+            ) as vhost,
+            TestPmd(
+                prefix="virtio",
+                no_pci=True,
+                memory_channels=4,
+                vdevs=[self.vdevs.virtio_user],
+            ) as virtio,
+        ):
+            vhost.set_forward_mode(SimpleForwardingModes.mac)
+            virtio.set_forward_mode(SimpleForwardingModes.mac)
+
+            vhost.start()
+            virtio.start_tx_first(burst_num=32)
+
+            forwarding_stats = vhost.stop()
+
+            rx_packets = self.ForwardingParsers.rx_packets["TextParser_fn"](forwarding_stats) or 0
+            tx_packets = self.ForwardingParsers.tx_packets["TextParser_fn"](forwarding_stats) or 0
+
+            self.verify(
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
+            * Stop packet forwarding on vhost session and collect Rx packet stats.
+
+        Verify:
+            * Vhost session receives packets from relaunched virtio session.
+        """
+        with TestPmd(
+            prefix="vhost",
+            no_pci=True,
+            memory_channels=4,
+            vdevs=[self.vdevs.vhost_user],
+        ) as vhost:
+            with TestPmd(
+                prefix="virtio",
+                no_pci=True,
+                memory_channels=4,
+                vdevs=[self.vdevs.virtio_user],
+            ) as virtio:
+                pass
+            # end session and reconnect
+            with TestPmd(
+                prefix="virtio",
+                no_pci=True,
+                memory_channels=4,
+                vdevs=[self.vdevs.virtio_user],
+            ) as virtio:
+                virtio.set_forward_mode(SimpleForwardingModes.mac)
+                vhost.set_forward_mode(SimpleForwardingModes.mac)
+
+                vhost.start()
+                virtio.start_tx_first(burst_num=32)
+
+                forwarding_stats = vhost.stop()
+
+                rx_packets = (
+                    self.ForwardingParsers.rx_packets["TextParser_fn"](forwarding_stats) or 0
+                )
+                tx_packets = (
+                    self.ForwardingParsers.tx_packets["TextParser_fn"](forwarding_stats) or 0
+                )
+
+                self.verify(
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
+            * Physical interface receives all 100 sent packets.
+        """
+        self.sut_node = self._ctx.sut_node
+        if not isinstance(self.sut_node.main_session, LinuxSession):
+            self.verify(False, "Must be running on a Linux environment.")
+        with TestPmd(
+            prefix="virtio",
+            vdevs=[VirtualDevice("virtio_user0,path=/dev/vhost-net,queues=1,queue_size=1024")],
+        ) as virtio:
+            self.sut_node.main_session.send_command("ip link set dev tap0 up", privileged=True)
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
+                captured_packets = self.send_packets_and_capture(packets)
+
+                self.verify(
+                    len(captured_packets) >= 100, "Sent packets not received on physical interface."
+                )
-- 
2.51.0

