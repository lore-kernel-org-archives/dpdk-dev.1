Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6686C5B56A
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Aug 2026 17:12:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C9F194026F;
	Tue, 11 Aug 2026 19:12:46 +0200 (CEST)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com
 [209.85.222.178])
 by mails.dpdk.org (Postfix) with ESMTP id 28E734021E
 for <dev@dpdk.org>; Tue, 11 Aug 2026 19:12:45 +0200 (CEST)
Received: by mail-qk1-f178.google.com with SMTP id
 af79cd13be357-92e6a434cabso10033485a.1
 for <dev@dpdk.org>; Tue, 11 Aug 2026 10:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1786468364; x=1787073164; darn=dpdk.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=DqZ8R5zq+FGc9ivOET+ooPSj4hnRo6ojU2Ng/ahOQ5Q=;
 b=BqWTdHplPaAsjkF44C9R9j8yvEMrG7wAwXM74sz/tM7TcvVp+/1+SoeCHe3suQtJPo
 kc2p2Zp0IVzXUH1BBJLM6VCrsdH+ZzW3hPPx9vg330il47RgpZDCr3T5Rn4klN2S4a5o
 W2YJkCJghgJd7+/wvMq0Ot2m2/SLIYrt9wqq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786468364; x=1787073164;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DqZ8R5zq+FGc9ivOET+ooPSj4hnRo6ojU2Ng/ahOQ5Q=;
 b=c3gSVGxjCwg+HnG4EzU77mPjpAYCvWj3GZ2ERtL/Wc6ttYKxdgpz7tKiQS61dQSbwM
 9WHp+aWs2aBub1wAL4u8ay3CSMtm0qhySKD/9Kc8kCMpTsWo0KdwljFJRuWEpgnZH1ch
 7bBz+KqOUhbDv2XIEHVeFoPKfUL/xEHbNab7dqs5wRTYb1JTnZZQLu9LesPy5Kg9qBpd
 mO5l7uAvrVeuJVIxb1VGaGBdt40rB+BkFDODbaK77w4ftPImfy8dQBnw4dhG+NGt9l6M
 yGOloazjbPP1j7K6R2u2Irjph/J5rfewz1sRmG4vqEFT7+VFRGq6dUJeEonLGXw3vYSY
 /XQg==
X-Gm-Message-State: AOJu0YxbsUgHt5Nuav86NvvQzW2EEhALPPRGJVNDFuz5VP9uqVG+Mlxd
 rPLAfCU/0QBpKZV0eOcoZUjN8yPA+2yksTHX4M0enIozsfgGjRvrLPAelRX4tWmat5JP5fUR73+
 ICHpDs3nFsVD+dX28+tYkYc4iKS+r8KM2WkNrNZnN+fK10hAP+JHdDZspBfha8sMTHMcvr1w3tj
 4vnCiIvtTEo+bTYMeSpXZsuxB4SSo=
X-Gm-Gg: AR+sD123rMigSZ4fW4JeUbBnzOq6RJKwcceaNz1G4id61sjSiYyCAT7o9MZksgT+/uQ
 T6EIj8en9Bqoiw4Axoj8y0ydOsJJ7cB/TYlRbDuXRDuDy0ySmcSpPNVul+TBO/bt4tHKAtX0c5p
 qHB8QQdX5FrDsjssn4qvjm3T/N2wdIPp3ArhqxzobN3rzKoVWqEd1tjTpDvDv4sNtHXZWsh5KRK
 p0wb0Ku+O4hfOuXQ3pTegbMlOl0tdIrcZ5pFF+Sq3YSppf5jZrKLLd//priNZlQSwanuMGei0tn
 WjYnx3f9IGOkhagIKYW8TlxStSxY8I0xHMM7ZXCP5+z78AhkDnaXsjYSwRSrzajXE3eXFPzUkF7
 Cw5S6e6yDwAvc47t9LsU40BvohO4zL5qAjkCyM3r6cuXlN8NUPtNfA0E3pmVh5ZSeKJwdB218yZ
 LzC6Lt0Ws8qVuZ/RW04hF9dfbmX106qz2joJV6VYYbuPXGYaeTNCfiOMxjogcrEe9RnQq/O+IOF
 4HBDDiLpmU=
X-Received: by 2002:a05:620a:3707:b0:915:e9c3:f1a0 with SMTP id
 af79cd13be357-936a8ec2b5fmr443518185a.12.1786468364202; 
 Tue, 11 Aug 2026 10:12:44 -0700 (PDT)
Received: from d121029.iol.unh.edu ([2606:4100:3880:1210::219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-936a8472b1fsm151124685a.7.2026.08.11.10.12.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 10:12:43 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: dev@dpdk.org,
	luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: knimoji@iol.unh.edu, lylavoie@iol.unh.edu, dladd@iol.unh.edu,
 Dean Marx <dmarx@iol.unh.edu>, Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v1] dts: add PVVP case to virtio suite
Date: Tue, 11 Aug 2026 13:12:30 -0400
Message-ID: <20260811171235.519323-1-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.55.0
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

From: Dean Marx <dmarx@iol.unh.edu>

Add an additional test case to the virtio_fwd suite which
tests packet forwarding across a physical-virtual-virtual-physical
topology.

Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
Reviewed-by: Andrew Bailey <abailey@iol.unh.edu>
---
 dts/tests/TestSuite_virtio_forward.py | 99 +++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/dts/tests/TestSuite_virtio_forward.py b/dts/tests/TestSuite_virtio_forward.py
index 6efaa4e156..3f165e9ae0 100644
--- a/dts/tests/TestSuite_virtio_forward.py
+++ b/dts/tests/TestSuite_virtio_forward.py
@@ -6,6 +6,8 @@
 Verify vhost/virtio pvp and fully virtual functionalities.
 """
 
+from pathlib import PurePath
+
 from scapy.layers.inet import IP
 from scapy.layers.l2 import Ether
 
@@ -195,3 +197,100 @@ def pvp_loop(self) -> None:
                     f"PVP loop forwarding verification failed: vhost interface RX={rx_packets},"
                     f" TX={tx_packets} (expected ≥100 each).",
                 )
+
+    @requires(topology_type=LinkTopology.ONE_LINK)
+    @func_test
+    def pvvp_loop(self) -> None:
+        """Test vhost/virtio physical-virtual-virtual-physical topology.
+
+        Steps:
+            * Create directory for vhost-user socket files.
+            * Launch primary testpmd session with physical NICs and two virtio-user
+                vdevs connected to vhost-user sockets in server mode.
+            * Launch first vhost testpmd session with vhost vdev connected to the
+                first vhost-user socket as client.
+            * Launch second vhost testpmd session with vhost vdev connected to the
+                second vhost-user socket as client.
+            * Configure port forwarding order in primary session to chain physical
+                port through both virtual devices.
+            * Start packet forwarding on all three testpmd sessions.
+            * Send 100 packets to the physical interface from external tester.
+
+        Verify:
+            * Both vhost sessions receive/forward 100+ packets each.
+        """
+        self.sut_node = self._ctx.sut_node
+        if not isinstance(self.sut_node.main_session, LinuxSession):
+            verify(False, "Must be running on a Linux environment.")
+        self.sut_node.main_session.remove_remote_dir("/tmp/vhost-sockets")
+        self.sut_node.main_session.create_directory(PurePath("/tmp/vhost-sockets"))
+        with (
+            TestPmd(
+                prefix="vhost1",
+                vdevs=[
+                    VirtualDevice("net_vhost0,iface=/tmp/vhost-sockets/vhost0,queues=1,client=1")
+                ],
+                no_pci=True,
+            ) as vhost1,
+            TestPmd(
+                prefix="vhost2",
+                vdevs=[
+                    VirtualDevice("net_vhost1,iface=/tmp/vhost-sockets/vhost1,queues=1,client=1")
+                ],
+                no_pci=True,
+            ) as vhost2,
+            TestPmd(
+                prefix="virtio",
+                vdevs=[
+                    VirtualDevice(
+                        "net_virtio_user0,mac=00:00:00:00:00:01,path=/tmp/vhost-sockets/vhost0,queues=1,queue_size=1024,server=1"
+                    ),
+                    VirtualDevice(
+                        "net_virtio_user1,mac=00:00:00:00:00:02,path=/tmp/vhost-sockets/vhost1,queues=1,queue_size=1024,server=1"
+                    ),
+                ],
+                port_topology=PortTopology.chained,
+            ) as virtio,
+        ):
+            virtio.set_forward_mode(SimpleForwardingModes.mac)
+            vhost1.set_forward_mode(SimpleForwardingModes.mac)
+            vhost2.set_forward_mode(SimpleForwardingModes.mac)
+
+            portlist_order = [0, 2, 3, 1] if len(virtio.ports) == 4 else [0, 2, 1]
+            virtio.set_portlist(order=portlist_order)
+
+            virtio.start()
+            vhost1.start()
+            vhost2.start()
+
+            packet = Ether() / IP()
+            packets = [packet] * 100
+            send_packets_and_capture(packets)
+
+            vhost1.stop()
+            vhost2.stop()
+            virtio.stop()
+
+            vhost1_forwarding_stats, vhost1_raw_output = vhost1.show_port_stats_all()
+            vhost2_forwarding_stats, vhost2_raw_output = vhost2.show_port_stats_all()
+
+            rx_packets_vhost1 = vhost1_forwarding_stats[0].rx_packets
+            tx_packets_vhost1 = vhost1_forwarding_stats[0].tx_packets
+
+            rx_packets_vhost2 = vhost2_forwarding_stats[0].rx_packets
+            tx_packets_vhost2 = vhost2_forwarding_stats[0].tx_packets
+
+            log(f"Vhost1 forwarding statistics:\n{vhost1_raw_output}")
+            log(f"Vhost2 forwarding statistics:\n{vhost2_raw_output}")
+
+            verify(
+                rx_packets_vhost1 >= 100 and tx_packets_vhost1 >= 100,
+                f"PVP loop forwarding verification failed: vhost1 interface RX={rx_packets_vhost1},"
+                f" TX={tx_packets_vhost1} (expected ≥100 each).",
+            )
+
+            verify(
+                rx_packets_vhost2 >= 100 and tx_packets_vhost2 >= 100,
+                f"PVP loop forwarding verification failed: vhost2 interface RX={rx_packets_vhost2},"
+                f" TX={tx_packets_vhost2} (expected ≥100 each).",
+            )
-- 
2.55.0

