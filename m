Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0364FCA1009
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Sep 2025 18:04:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3AB9F40E41;
	Wed,  3 Sep 2025 20:04:36 +0200 (CEST)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com
 [209.85.160.175])
 by mails.dpdk.org (Postfix) with ESMTP id C5D4A40609
 for <dev@dpdk.org>; Wed,  3 Sep 2025 20:04:33 +0200 (CEST)
Received: by mail-qt1-f175.google.com with SMTP id
 d75a77b69052e-4b2f4ac4786so2182861cf.1
 for <dev@dpdk.org>; Wed, 03 Sep 2025 11:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1756922673; x=1757527473; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t67hxE9gtDPOJO4t0YS1twAM19x3FppUvV5Xa0XjmMw=;
 b=Ih/6EPmoCY3sgZistiQ1IN1gOvHfnszXFG//AprNltdbU9a4XTYBkvIz6tj03M6DnM
 IUseSOq2hC+UEQU44/6+zHXCpOY6bv06cdk5eBJpoW09K9TbST9cvAoXafDq+ume4dIH
 qOUsEYjhfyvdYu3iYUj5UW/Uwv/4GwefD74Sk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756922673; x=1757527473;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t67hxE9gtDPOJO4t0YS1twAM19x3FppUvV5Xa0XjmMw=;
 b=uN+QYUVBZ0xIQJH5bv+TgpEUDrC+hxZalOwkcN1MFcH51voKqTOS+KgAXp+QwoTJDe
 5JCGvTZrFGgMt8wn+h9YOSXa88ywfxBseEUHPMkKcBJWBEKjLtRgu96n4F3IFBIZgYow
 8MwHI5BOR3T9W01GSPQgaCvvFo82WLwqxTOMc1KArCRCYYlAGf/+FSg203eagm9CPIJP
 VkcWelIhuPHQsex22XkXPV2oKTTWlzGmY4uWwYrTQ97oEI0eKiV0h5iNPodS9no9hS+0
 Zye+LOuM2xSdHSk41luTKImAzzA1txAm8SX5+4/SSNI777vvyklKtvW+S3EHpcH/BMD3
 BerA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVq35WeUJaf66UQj4dubPKZNG0MZuTziJWdNv4BI3PR5FndYV7y6zLFz0wgIBvfp8IPxkU=@dpdk.org
X-Gm-Message-State: AOJu0YxmryiX0L1kMj4X0kPjZZMwkbfRorv/WwJcYb8sd+GHx3uxSQju
 128U7jr47ld6LlzeutYSB9G0FzVXqjnRgvee0gBH3joBwvCUgTpk22S2LFjUGB2c1IM=
X-Gm-Gg: ASbGncugo2JJanihfo9+dZaZ7HEwm8sgAm0H7Xgu6aURVPgzBhzqB7uRyxOHI4uI2AR
 FiaRi6HJr1crDBmUZghtZjd54AFdhPgWxBNaufEXLeb2wS/MsrMJjsJFhwkUJ9hhLwsCiGB6Fam
 WeI9qCZRPs/3djO52ISx9nbTGwOIOgkPpE8mOSKj6lwnmcob7UeYvAETuOvu1rF1npkTdVvqWq8
 trcHA8I2F9PuTB3mEguSmDTxPqHQzZpkSvjsz33+kJzRg4XE9pGDVrQB3Efh+5jIOR3xjKeEP/p
 HvP1Z0+01ziAS/d0Fi+ot7NCwIbTl1ZYKhnJhc1VKnJbzge47/zLAKVI2R5QNhLuq8TJjDCI6Qt
 QP5nq3U8W3OVuK9XNkhuQX+RSxg+g6KWGt3U3KI2oVZm0
X-Google-Smtp-Source: AGHT+IEN6sL0c29tuJ8xBaxqcNKsywqVaz1kTMkU0fmjg0MxtADjjNtyk1bQ8cKI6hLYGY1Ouuyn6Q==
X-Received: by 2002:ac8:5a47:0:b0:4b3:1c38:b22a with SMTP id
 d75a77b69052e-4b31d80cc3dmr194723421cf.14.1756922672945; 
 Wed, 03 Sep 2025 11:04:32 -0700 (PDT)
Received: from dhcp-10-21-133-214.unh.edu
 ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4b48f62a861sm15073121cf.8.2025.09.03.11.04.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Sep 2025 11:04:32 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: luca.vizzarro@arm.com
Cc: abailey@iol.unh.edu, dev@dpdk.org, dmarx@iol.unh.edu,
 ivan.malov@arknetworks.am, probb@iol.unh.edu
Subject: [PATCH v2 2/3] dts: add TX offload capabilities to NIC capabilities
Date: Wed,  3 Sep 2025 14:04:13 -0400
Message-ID: <20250903180414.83001-3-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250903180414.83001-1-abailey@iol.unh.edu>
References: <20250902142725.56736-1-abailey@iol.unh.edu>
 <20250903180414.83001-1-abailey@iol.unh.edu>
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

Currently, there is support for tracking the Rx offload capabilities of
a NIC, but not for Tx offload capabilities. This is an issue if a test
suite is written requiring one of these capabilities, since there is no
way currently to verify that the NIC in use meets the requirements. Add
Tx capabilities to the NIC capabilities at beginning of dts so
requirements can be verified.

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
---
 dts/framework/remote_session/testpmd_shell.py | 203 ++++++++++++++++++
 1 file changed, 203 insertions(+)

diff --git a/dts/framework/remote_session/testpmd_shell.py b/dts/framework/remote_session/testpmd_shell.py
index 4d9caceb37..dfd83ebdb3 100644
--- a/dts/framework/remote_session/testpmd_shell.py
+++ b/dts/framework/remote_session/testpmd_shell.py
@@ -1285,6 +1285,99 @@ class TestPmdVerbosePacket(TextParser):
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
 
@@ -2397,6 +2490,28 @@ def close(self) -> None:
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
@@ -2824,6 +2939,94 @@ class NicCapability(NoAliasEnum):
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

