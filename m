Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12CA2CA0FFE
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Sep 2025 14:28:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 82C7D4065F;
	Tue,  2 Sep 2025 16:28:10 +0200 (CEST)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com
 [209.85.219.51]) by mails.dpdk.org (Postfix) with ESMTP id 6C8944065E
 for <dev@dpdk.org>; Tue,  2 Sep 2025 16:28:09 +0200 (CEST)
Received: by mail-qv1-f51.google.com with SMTP id
 6a1803df08f44-70ddab8117cso43773336d6.0
 for <dev@dpdk.org>; Tue, 02 Sep 2025 07:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1756823289; x=1757428089; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B+r/+i69Xn8S2462hu4wOa5GIVjtTPnUodSLkRmrUR8=;
 b=Lln/7X8nPHRvXHmKt5qTc6FshavtLsBduxzTlZvamVqS1salx6mhs+5H1IWU0Bepo2
 ToCCkziM6DgIX+tOd2i1Q+J8IYiO6yK2KYM6uEWBPFhQQwY763G5U3Z21FmXnm2AVglg
 PQxR9FJlmVpACq/lxt38G4XpCc8s4qe7qIPp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756823289; x=1757428089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B+r/+i69Xn8S2462hu4wOa5GIVjtTPnUodSLkRmrUR8=;
 b=UL0g3NroVGQcpYon7UYthTyADZKbQWYN1osdf6GuyrGmI7Nxk1tx4HcxJXhZVghIA8
 QVIQxjRRhqqCbjhnl6EQcl0jxfLjuKu6ZtZr8Yskz98+J5cb4KPRlgZ5dWegkTpM2qwU
 1Pn5YydAsHoelGEWNP4hJXFRExTc5vondcKj/XDq2b8gp7Qx/R9TATlU46iRjsVyd3Sx
 kP5gNfEuQ8u34YK9CnKkFUtmc/wrqcxK6+Oxi9QlT1ywmKhseoQPB6zmYDe+PvnyESrD
 hxp1KJyHyZLG+uaVDQ20QQnRB/GxAVLjT9g4df3iXEgHzk4Igj0R0jnLd60AH8kJize8
 kfcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9L/R5JYJ+Nk/X5owe+u/WyanYZ8j29Bqbg/5hFPdNwmNghMqm/fqxeBvGKpL/K/YAmuo=@dpdk.org
X-Gm-Message-State: AOJu0Yw/PjoUURyFQtMAyTUljSvLj+XEGjcqrKTaT/8BPhq3wSbcssVk
 VrOEtD/FemcVMbu7jncZ8P9tRswMXpNUM+DxsTdPT41NeDISmwFMu+M3TxNY6vEZheU=
X-Gm-Gg: ASbGncsE6UgXfx5Y11D9FCKjvAcKGBdX87bWaYOcLrMKLZkqSAPFSaEfxVXXxlv9vDf
 OV6rtuo7O9tnOGtfRGUUogzDpXtOdOG0FKwQZRqDsj9fxVk9iXAhghiLejY2IOwW+0+nff/NpgY
 DLlXQCbOZCsiVi4yWWuG6INOptLEbijnSOin1TDpbaCoIHCC4h1v7P76vi3wdqPPjtO6XkwaG+1
 VWjMZd0GNZI5bFZ6bTbp0+NFBO9hsIP18bsk1Y2RrCvlqj4SSnVfxW2ZrYSXh5siHnNlulNO6Sa
 Zrfe2WbxKx23Vux1PYt5EXSmhL78nHUY1pPRQt0wi4GeQ0XXiIb9PtQ0DGlK3AXXug1pSzxfQRr
 ty61aGgpBcxyrp0s7waA1YpU+vf7Hr/rUhfIpSvIAEvEmIw==
X-Google-Smtp-Source: AGHT+IEGxgXt3/6p1t42Yh1WjYIG3NfIrr+68EjIGNQWLTz2Tfc+fZP4tWHptpzmhBPdnZ5OZpVPNw==
X-Received: by 2002:a05:6214:e88:b0:715:71d9:e430 with SMTP id
 6a1803df08f44-71571d9e59emr77008916d6.5.1756823288441; 
 Tue, 02 Sep 2025 07:28:08 -0700 (PDT)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-720b57c2893sm12346186d6.53.2025.09.02.07.28.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Sep 2025 07:28:07 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: luca.vizzarro@arm.com
Cc: abailey@iol.unh.edu, dev@dpdk.org, dmarx@iol.unh.edu, probb@iol.unh.edu
Subject: [PATCH v1 2/3] dts: add TX offload capabilities to NIC capabilities
Date: Tue,  2 Sep 2025 10:27:24 -0400
Message-ID: <20250902142725.56736-3-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250902142725.56736-1-abailey@iol.unh.edu>
References: <20250902142725.56736-1-abailey@iol.unh.edu>
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

Currently, there is support for tracking the RX offload capabilities of
a NIC, but not for TX offload capabilities. This is an issue if a test
suite is written requiring one of these capabilities, since there is no
way currently to verify that the NIC in use meets the requirements. Add
TX capabilities to the NIC capabiltiies at beginning of dts so
requirements can be verified.

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
---
 dts/framework/remote_session/testpmd_shell.py | 203 ++++++++++++++++++
 1 file changed, 203 insertions(+)

diff --git a/dts/framework/remote_session/testpmd_shell.py b/dts/framework/remote_session/testpmd_shell.py
index ad8cb273dc..786714d1c5 100644
--- a/dts/framework/remote_session/testpmd_shell.py
+++ b/dts/framework/remote_session/testpmd_shell.py
@@ -1278,6 +1278,99 @@ class TestPmdVerbosePacket(TextParser):
     )


+class TxOffloadCapability(Flag):
+    """TX offload capabilities of a device.
+
+    The flags are taken from ``lib/ethdev/rte_ethdev.h``.
+    They're prefixed with ``RTE_ETH_TX_OFFLOAD`` in ``lib/ethdev/rte_ethdev.h``
+    instead of ``TX_OFFLOAD``, which is what testpmd changes the prefix to.
+    The values are not contiguous, so the correspondence is preserved
+    by specifying concrete values interspersed between auto() values.
+
+    The ``TX_OFFLOAD`` prefix has been preserved so that the same flag names can be used
+    in :class:`NicCapability`. The prefix is needed in :class:`NicCapability` since there's
+    no other qualifier which would sufficiently distinguish it from other capabilities.
+
+    References:
+        DPDK lib: ``lib/ethdev/rte_ethdev.h``
+        testpmd display function: ``app/test-pmd/cmdline.c:print_rx_offloads()``
+    """
+
+    TX_OFFLOAD_VLAN_INSERT = auto()
+    TX_OFFLOAD_IPV4_CKSUM = auto()
+    TX_OFFLOAD_UDP_CKSUM = auto()
+    TX_OFFLOAD_TCP_CKSUM = auto()
+    TX_OFFLOAD_SCTP_CKSUM = auto()
+    TX_OFFLOAD_TCP_TSO = auto()
+    TX_OFFLOAD_UDP_TSO = auto()
+    TX_OFFLOAD_OUTER_IPV4_CKSUM = auto()
+    TX_OFFLOAD_QINQ_INSERT = auto()
+    TX_OFFLOAD_VXLAN_TNL_TSO = auto()
+    TX_OFFLOAD_GRE_TNL_TSO = auto()
+    TX_OFFLOAD_IPIP_TNL_TSO = auto()
+    TX_OFFLOAD_GENEVE_TNL_TSO = auto()
+    TX_OFFLOAD_MACSEC_INSERT = auto()
+    TX_OFFLOAD_MT_LOCKFREE = auto()
+    TX_OFFLOAD_MULTI_SEGS = auto()
+    TX_OFFLOAD_MBUF_FAST_FREE = auto()
+    TX_OFFLOAD_SECURITY = auto()
+    TX_OFFLOAD_UDP_TNL_TSO = auto()
+    TX_OFFLOAD_IP_TNL_TSO = auto()
+    TX_OFFLOAD_OUTER_UDP_CKSUM = auto()
+    TX_OFFLOAD_SEND_ON_TIMESTAMP = auto()
+
+    @classmethod
+    def from_string(cls, line: str) -> Self:
+        """Make an instance from a string containing the flag names separated with a space.
+
+        Args:
+            line: The line to parse.
+
+        Returns:
+            A new instance containing all found flags.
+        """
+        flag = cls(0)
+        for flag_name in line.split():
+            flag |= cls[f"TX_OFFLOAD_{flag_name}"]
+        return flag
+
+    @classmethod
+    def make_parser(cls, per_port: bool) -> ParserFn:
+        """Make a parser function.
+
+        Args:
+            per_port: If :data:`True`, will return capabilities per port. If :data:`False`,
+                will return capabilities per queue.
+
+        Returns:
+            ParserFn: A dictionary for the `dataclasses.field` metadata argument containing a
+                parser function that makes an instance of this flag from text.
+        """
+        granularity = "Port" if per_port else "Queue"
+        return TextParser.wrap(
+            TextParser.find(rf"Per {granularity}\s+:(.*)$", re.MULTILINE),
+            cls.from_string,
+        )
+
+
+@dataclass
+class TxOffloadCapabilities(TextParser):
+    """The result of testpmd's ``show port <port_id> tx_offload capabilities`` command.
+
+    References:
+        testpmd command function: ``app/test-pmd/cmdline.c:cmd_tx_offload_get_capa()``
+        testpmd display function: ``app/test-pmd/cmdline.c:cmd_tx_offload_get_capa_parsed()``
+    """
+
+    port_id: int = field(
+        metadata=TextParser.find_int(r"Tx Offloading Capabilities of port (\d+) :")
+    )
+    #: Per-queue Tx offload capabilities.
+    per_queue: TxOffloadCapability = field(metadata=TxOffloadCapability.make_parser(False))
+    #: Capabilities other than per-queue Tx offload capabilities.
+    per_port: TxOffloadCapability = field(metadata=TxOffloadCapability.make_parser(True))
+
+
 class RxOffloadCapability(Flag):
     """Rx offload capabilities of a device.

@@ -2390,6 +2483,28 @@ def close(self) -> None:
     ====== Capability retrieval methods ======
     """

+    def get_capabilities_tx_offload(
+        self,
+        supported_capabilities: MutableSet["NicCapability"],
+        unsupported_capabilities: MutableSet["NicCapability"],
+    ) -> None:
+        """Get all TX offload capabilities and divide them into supported and unsupported.
+
+        Args:
+            supported_capabilities: Supported capabilities will be added to this set.
+            unsupported_capabilities: Unsupported capabilities will be added to this set.
+        """
+        self._logger.debug("Getting TX offload capabilities.")
+        command = f"show port {self.ports[0].id} tx_offload capabilities"
+        tx_offload_capabilities_out = self.send_command(command)
+        tx_offload_capabilities = TxOffloadCapabilities.parse(tx_offload_capabilities_out)
+        self._update_capabilities_from_flag(
+            supported_capabilities,
+            unsupported_capabilities,
+            TxOffloadCapability,
+            tx_offload_capabilities.per_port | tx_offload_capabilities.per_queue,
+        )
+
     def get_capabilities_rx_offload(
         self,
         supported_capabilities: MutableSet["NicCapability"],
@@ -2698,6 +2813,94 @@ class NicCapability(NoAliasEnum):
     we don't go looking for it again if a different test case also needs it.
     """

+    TX_OFFLOAD_VLAN_INSERT: TestPmdShellNicCapability = (
+        TestPmdShell.get_capabilities_tx_offload,
+        None,
+    )
+    TX_OFFLOAD_IPV4_CKSUM: TestPmdShellNicCapability = (
+        TestPmdShell.get_capabilities_tx_offload,
+        None,
+    )
+    TX_OFFLOAD_UDP_CKSUM: TestPmdShellNicCapability = (
+        TestPmdShell.get_capabilities_tx_offload,
+        None,
+    )
+    TX_OFFLOAD_TCP_CKSUM: TestPmdShellNicCapability = (
+        TestPmdShell.get_capabilities_tx_offload,
+        None,
+    )
+    TX_OFFLOAD_SCTP_CKSUM: TestPmdShellNicCapability = (
+        TestPmdShell.get_capabilities_tx_offload,
+        None,
+    )
+    TX_OFFLOAD_TCP_TSO: TestPmdShellNicCapability = (
+        TestPmdShell.get_capabilities_tx_offload,
+        None,
+    )
+    TX_OFFLOAD_UDP_TSO: TestPmdShellNicCapability = (
+        TestPmdShell.get_capabilities_tx_offload,
+        None,
+    )
+    TX_OFFLOAD_OUTER_IPV4_CKSUM: TestPmdShellNicCapability = (
+        TestPmdShell.get_capabilities_tx_offload,
+        None,
+    )
+    TX_OFFLOAD_QINQ_INSERT: TestPmdShellNicCapability = (
+        TestPmdShell.get_capabilities_tx_offload,
+        None,
+    )
+    TX_OFFLOAD_VXLAN_TNL_TSO: TestPmdShellNicCapability = (
+        TestPmdShell.get_capabilities_tx_offload,
+        None,
+    )
+    TX_OFFLOAD_GRE_TNL_TSO: TestPmdShellNicCapability = (
+        TestPmdShell.get_capabilities_tx_offload,
+        None,
+    )
+    TX_OFFLOAD_IPIP_TNL_TSO: TestPmdShellNicCapability = (
+        TestPmdShell.get_capabilities_tx_offload,
+        None,
+    )
+    TX_OFFLOAD_GENEVE_TNL_TSO: TestPmdShellNicCapability = (
+        TestPmdShell.get_capabilities_tx_offload,
+        None,
+    )
+    TX_OFFLOAD_MACSEC_INSERT: TestPmdShellNicCapability = (
+        TestPmdShell.get_capabilities_tx_offload,
+        None,
+    )
+    TX_OFFLOAD_MT_LOCKFREE: TestPmdShellNicCapability = (
+        TestPmdShell.get_capabilities_tx_offload,
+        None,
+    )
+    TX_OFFLOAD_MULTI_SEGS: TestPmdShellNicCapability = (
+        TestPmdShell.get_capabilities_tx_offload,
+        None,
+    )
+    TX_OFFLOAD_MBUF_FAST_FREE: TestPmdShellNicCapability = (
+        TestPmdShell.get_capabilities_tx_offload,
+        None,
+    )
+    TX_OFFLOAD_SECURITY: TestPmdShellNicCapability = (
+        TestPmdShell.get_capabilities_tx_offload,
+        None,
+    )
+    TX_OFFLOAD_UDP_TNL_TSO: TestPmdShellNicCapability = (
+        TestPmdShell.get_capabilities_tx_offload,
+        None,
+    )
+    TX_OFFLOAD_IP_TNL_TSO: TestPmdShellNicCapability = (
+        TestPmdShell.get_capabilities_tx_offload,
+        None,
+    )
+    TX_OFFLOAD_OUTER_UDP_CKSUM: TestPmdShellNicCapability = (
+        TestPmdShell.get_capabilities_tx_offload,
+        None,
+    )
+    TX_OFFLOAD_SEND_ON_TIMESTAMP: TestPmdShellNicCapability = (
+        TestPmdShell.get_capabilities_tx_offload,
+        None,
+    )
     #: Scattered packets Rx enabled
     SCATTERED_RX_ENABLED: TestPmdShellNicCapability = (
         TestPmdShell.get_capabilities_rxq_info,
--
2.50.1

