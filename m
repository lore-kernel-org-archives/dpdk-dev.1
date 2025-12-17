Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4421D66B85
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Dec 2025 19:52:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 850FE4029A;
	Wed, 17 Dec 2025 20:51:59 +0100 (CET)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com
 [209.85.219.54]) by mails.dpdk.org (Postfix) with ESMTP id 16EF54025A
 for <dev@dpdk.org>; Wed, 17 Dec 2025 20:51:58 +0100 (CET)
Received: by mail-qv1-f54.google.com with SMTP id
 6a1803df08f44-8888a444300so48293026d6.1
 for <dev@dpdk.org>; Wed, 17 Dec 2025 11:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1766001117; x=1766605917; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UNzSMkXL5Q0I0eBzlA9fnQdSTU6l4WAVJ0iloFpBjSE=;
 b=Kb/wkeIWL1x5KtJ6cpTElbu3cAmCNr8PIUQF1oTZ4m2ZN9KTW9/yGiLNrep5gTAZtX
 k8wtJ8Nf0Hv2I1lB7nmC7GKJEQ46JLWCEIfFAhUsy7zelZQ/5LDSUlRWV5QfaI3gExPu
 rUZC7LomUJXNGjOk/tmdpQqbKFF8BasGbaYjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766001117; x=1766605917;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UNzSMkXL5Q0I0eBzlA9fnQdSTU6l4WAVJ0iloFpBjSE=;
 b=n63VbJ3En1W3jU1h1VAe1Mv6SLI3O+XuJkwCSw4MdOQNMn9jntcOhxboGnkDAxHN7e
 d0p9kTkt0kUVJO+eDPtLU2TAcoe0CT5uBcgeQ4TqwcT8tjjGXcMw3b+pXDmAN6fYCv7X
 GcEDQcuXpnGk7Fl6ZRpXFkuTHxrqiYsBEcg44lvH/MuIMBN+ZccGN/9d6sdgY+ghA793
 jXW3UbZzCIPRsCkmVcT43gFYxgx1y0zI2p8xCEW6Pptx+SGF6nkNMHyP8PYzk+loGRb9
 k2UA7y2xjlV2nwKm6tLabygQIn2fu/rwPVeIFhpJUoDWPmh8rTbrwdCVbOjV9wyWQNEQ
 zJGg==
X-Gm-Message-State: AOJu0Yxf/o7PDd26/8JrrHTy4Auh7LsCMzAudL+H3cGhwNgPcDqY3Mc4
 tcBPKDVbSdxpTmFDxFfJV1qwfcJC1PitD3prY9/mQ2XIDK4NMr4umRlBnW2QwTPJOfo=
X-Gm-Gg: AY/fxX5rPLzxA20UKj7qNmzMF1KEFaLOKpJtifwCr2kcYUPt12R3zx6eotIF3mVLmzo
 +2+EQmd/2LgR3J2xCqHzYqRI7Ix9PomtPJ8bIPAqBfBkMZZRb7YqTYhs7VLYi/RMRwI6hFDZpXb
 X7YFQCjsKF3j2BMgTfA1FA50HL7iAi2vmyJlDXlHqndixYbf3euc/WVhSOwJgXvdSwRs47RqxVS
 9CaHI60sGeDsStsMq7t4u7ib/ZY8qtCxUA/JYemOiulrcICFRkZS0k5UkwjPPOYw6x9+Z1UxRUc
 TTNwdsYshk3ahXsQQMxMIFK5f3mpg38CDGmHtu4Pfdu+cNHILKiFdgY72Hp6HYdwBl5zHDmQAAE
 x2cc3m+Q2gU1s2migkLEB42SXZCASFCf04qV7yKw65zPFIKulkJ90wb0JZoJ56luz8qsFfJv3/H
 RtAq6XCgbKVGUCdA==
X-Google-Smtp-Source: AGHT+IEBRFSuFwjNRvUE7MIHEP1ZN7XdM+pallkJga4dWoU04Spk1ej+Mx5GXn3+KO6ZziJG8RtLvA==
X-Received: by 2002:a05:6214:766:b0:882:437d:282d with SMTP id
 6a1803df08f44-8887e0454c6mr280421726d6.30.1766001117357; 
 Wed, 17 Dec 2025 11:51:57 -0800 (PST)
Received: from d121016.iol.unh.edu ([2606:4100:3880:1210::202])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88c5e05b87fsm2313836d6.18.2025.12.17.11.51.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Dec 2025 11:51:56 -0800 (PST)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [RFC PATCH] dts: add PVVP case to virtio suite
Date: Wed, 17 Dec 2025 14:51:53 -0500
Message-ID: <20251217195155.32350-1-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.51.0
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

Add an additional test case to the virtio_fwd suite which
tests packet forwarding across a physical-virtual-virtual-physical
topology.

Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
---
 dts/tests/TestSuite_virtio_fwd.py | 99 +++++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/dts/tests/TestSuite_virtio_fwd.py b/dts/tests/TestSuite_virtio_fwd.py
index bdecdb76fd..e78da7da05 100644
--- a/dts/tests/TestSuite_virtio_fwd.py
+++ b/dts/tests/TestSuite_virtio_fwd.py
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
2.51.0

