Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E18CAC59B
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Sep 2025 20:05:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5CDBA40608;
	Tue, 16 Sep 2025 22:05:04 +0200 (CEST)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com
 [209.85.222.176])
 by mails.dpdk.org (Postfix) with ESMTP id 71AB740431
 for <dev@dpdk.org>; Tue, 16 Sep 2025 22:05:03 +0200 (CEST)
Received: by mail-qk1-f176.google.com with SMTP id
 af79cd13be357-8287fedae95so419590385a.3
 for <dev@dpdk.org>; Tue, 16 Sep 2025 13:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1758053103; x=1758657903; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6YLVtetL/ZGAvHZzro+49OgF+ekebTzKUWakEdGZnoA=;
 b=fhhBinMoJshTLkc6KtZGc3iSpfeUrBuNqrtoi+Zd6bZYocyklnXYOBHztuuIWskGWP
 QlkXX7QA8hdEWaDP6pim46bW0zfnPmz5rAZThBRgkLc54qIDVhQCh1/j+gkXpo/iigcw
 DF70LFA9eh1FYJutlTprrUi64RXKqYpL578OE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758053103; x=1758657903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6YLVtetL/ZGAvHZzro+49OgF+ekebTzKUWakEdGZnoA=;
 b=GJvazyjMYrix95pJnePZ6jI4OPnzmqBg/P7FBU6zlaIxoMCbVddkVVFXKCEwsvo9nM
 ZQNSxC4NbuHCNM3PTLb8dd3zsXboFrfnSV1n8NgBdXPs1vFtdWdrbYYC48iiHdrs6Amv
 X3J6yMjNVxq7nKwj7AaqYFMOAlibZVbB/msgbMUOuxj1wb9W2+p7fYck4ff/uWEbpoei
 UoHw3VYql6Wjbat+Xb+DGgQK3xiWTS0r6wxmrCl0QMd/gGv0U+dtPNHhrlFjSoyPqwl2
 nXh1S/K9sbLe2Vsmapyp+TT39yaam0Z3u4OsDVXyVsUhL4Idu4uDTh1T89XLWeLYsUxo
 9mlw==
X-Gm-Message-State: AOJu0YynSMsomdyG7D8eKf1a1UybBCUf/RvLbX15jpeNkzOjZQNZAq4U
 XF3qkqEnZhQuCFZVa6IATCzEuC+MXXPmH088dlE37XZvvah1rsiW/3XXda+3BVawuSm7ca4QQpZ
 aAz4z
X-Gm-Gg: ASbGncsyTVX4GXmm1beL0qmu8MMgkHCUYqQN7QM487nfgjuuw8f4DDHlFmXnJKGWev9
 /0K2sNyrxtb/eTeycNa23JdTlqpNok5APx43H/lhj7chi3zaMxmXfGjdfFyY7B1H5U7gh444skq
 d6Q4zLh0cFWhjTEA1lXLGpkXyi85m72PmiJrqVazybFoE4sNnj7vOGzObFxc/EKOsg25L/wMa7C
 W8rtLOUo89aypw84Oy/kXD9Q+xpuvpkeAF2+W4lRIKExHkVpNjouKCWZnuWwGz71GtyM9hd1SHV
 duy7RAm+YGmRgULF9L+cQAX2MWgDzTkUFI7dw+IDf2MIUZGy6JOl962WvDGC4rLjrdwNz00TjqB
 NOolWsWfRYBXAcg/DefETOo70Lza+hqCGyA==
X-Google-Smtp-Source: AGHT+IGNxJn+d+fiqd6HO6N18kUiLfktSO9myIzScbXYfmMUKr5bUBaKBVP3M/zzMfxNIUxGHojg/w==
X-Received: by 2002:a05:620a:bcd:b0:808:95:2c8b with SMTP id
 af79cd13be357-82400187d62mr1879442785a.61.1758053102606; 
 Tue, 16 Sep 2025 13:05:02 -0700 (PDT)
Received: from d121016.iol.unh.edu ([2606:4100:3880:1271:ac5d:4186:4dc6:47eb])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-783278c7ea7sm42222796d6.46.2025.09.16.13.05.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 13:05:02 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v1 2/2] dts: add virtio forwarding test suite
Date: Tue, 16 Sep 2025 16:04:58 -0400
Message-ID: <20250916200458.259376-2-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916200458.259376-1-dmarx@iol.unh.edu>
References: <20250916200458.259376-1-dmarx@iol.unh.edu>
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
 doc/api/dts/tests.TestSuite_virtio_fwd.rst |   8 +
 dts/tests/TestSuite_virtio_fwd.py          | 179 +++++++++++++++++++++
 2 files changed, 187 insertions(+)
 create mode 100644 doc/api/dts/tests.TestSuite_virtio_fwd.rst
 create mode 100644 dts/tests/TestSuite_virtio_fwd.py

diff --git a/doc/api/dts/tests.TestSuite_virtio_fwd.rst b/doc/api/dts/tests.TestSuite_virtio_fwd.rst
new file mode 100644
index 0000000000..782eddad2d
--- /dev/null
+++ b/doc/api/dts/tests.TestSuite_virtio_fwd.rst
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
index 0000000000..3521fdfc08
--- /dev/null
+++ b/dts/tests/TestSuite_virtio_fwd.py
@@ -0,0 +1,179 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2025 University of New Hampshire
+
+"""Virtio forwarding test suite.
+
+Verify vhost/virtio pvp and loopback topology functionalities.
+"""
+
+import re
+
+from scapy.layers.inet import IP
+from scapy.layers.l2 import Ether
+
+from framework.params.testpmd import SimpleForwardingModes
+from framework.remote_session.testpmd_shell import TestPmdShell
+from framework.test_suite import TestSuite, func_test
+from framework.testbed_model.capability import requires
+from framework.testbed_model.linux_session import LinuxSession
+from framework.testbed_model.topology import TopologyType
+from framework.testbed_model.virtual_device import VirtualDevice
+
+
+@requires(topology_type=TopologyType.two_links)
+class TestVirtioFwd(TestSuite):
+    """Virtio forwarding test suite."""
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
+            TestPmdShell(
+                prefix="vhost",
+                no_pci=True,
+                memory_channels=4,
+                vdevs=[VirtualDevice("eth_vhost0,iface=/tmp/vhost-net,client=1")],
+            ) as vhost,
+            TestPmdShell(
+                prefix="virtio",
+                no_pci=True,
+                memory_channels=4,
+                vdevs=[
+                    VirtualDevice(
+                        "net_virtio_user0,mac=00:01:02:03:04:05,path=/tmp/vhost-net,server=1"
+                    )
+                ],
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
+            match_rx = re.search(r"RX-packets:\s*(\d+)", forwarding_stats)
+            match_tx = re.search(r"TX-packets:\s*(\d+)", forwarding_stats)
+            rx_packets = int(match_rx[1]) if match_rx else 0
+            tx_packets = int(match_tx[1]) if match_tx else 0
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
+        with TestPmdShell(
+            prefix="vhost",
+            no_pci=True,
+            memory_channels=4,
+            vdevs=[VirtualDevice("eth_vhost0,iface=/tmp/vhost-net,client=1")],
+        ) as vhost:
+            with TestPmdShell(
+                prefix="virtio",
+                no_pci=True,
+                memory_channels=4,
+                vdevs=[
+                    VirtualDevice(
+                        "net_virtio_user0,mac=00:01:02:03:04:05,path=/tmp/vhost-net,server=1"
+                    )
+                ],
+            ) as virtio:
+                pass
+            # end session and reconnect
+            with TestPmdShell(
+                prefix="virtio",
+                no_pci=True,
+                memory_channels=4,
+                vdevs=[
+                    VirtualDevice(
+                        "net_virtio_user0,mac=00:01:02:03:04:05,path=/tmp/vhost-net,server=1"
+                    )
+                ],
+            ) as virtio:
+                virtio.set_forward_mode(SimpleForwardingModes.mac)
+                vhost.set_forward_mode(SimpleForwardingModes.mac)
+
+                vhost.start()
+                virtio.start_tx_first(burst_num=32)
+
+                forwarding_stats = vhost.stop()
+
+                match_rx = re.search(r"RX-packets:\s*(\d+)", forwarding_stats)
+                match_tx = re.search(r"TX-packets:\s*(\d+)", forwarding_stats)
+                rx_packets = int(match_rx[1]) if match_rx else 0
+                tx_packets = int(match_tx[1]) if match_tx else 0
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
+        if not isinstance(self._ctx.sut_node.main_session, LinuxSession):
+            self.verify(False, "Must be running on a Linux environment.")
+        with TestPmdShell(
+            prefix="virtio",
+            vdevs=[VirtualDevice("virtio_user0,path=/dev/vhost-net,queues=1,queue_size=1024")],
+        ) as virtio:
+            self.sut_node.main_session.send_command("ip link set dev tap0 up", privileged=True)
+            with TestPmdShell(
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

