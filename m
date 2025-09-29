Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4062CCAC5B9
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Sep 2025 17:27:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 387C3406BA;
	Mon, 29 Sep 2025 19:27:44 +0200 (CEST)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com
 [209.85.222.181])
 by mails.dpdk.org (Postfix) with ESMTP id 8C5824067B
 for <dev@dpdk.org>; Mon, 29 Sep 2025 19:27:41 +0200 (CEST)
Received: by mail-qk1-f181.google.com with SMTP id
 af79cd13be357-84827ef386aso321254385a.0
 for <dev@dpdk.org>; Mon, 29 Sep 2025 10:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1759166861; x=1759771661; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Sg1hng1SuDl4Fx4hfnoNIuhyQI/LnQUsqM9IaZoFsA=;
 b=fY1uSGNyT+UptO/cpOzgq5M5aOJzbPtQsv8nXEYck/n86Nm65bomeWnjZ37/BcfZbN
 9b2tuoyoa2v/RpXuCeuZAH6TbNFp3Xoc0DaQspafnhteqiXTUATbftq/9Pcl4K5UZq7m
 Cn1tJaMQNoA+79YyOqf3bR+IKSh7Ggxsw+4jA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759166861; x=1759771661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+Sg1hng1SuDl4Fx4hfnoNIuhyQI/LnQUsqM9IaZoFsA=;
 b=BmhlWeKi2kkn4q/RNECCSdCKLtf91yco0EnzU07n18aZxyM3EErLqQdY6kw9vQLakw
 cqvbDaKmvRGjQ94jROd02Agn5WCan9ZWTvYB8yiy0FHgc/mGIXKNiWdKvLsfj2Zlfock
 yMPAbdZUbSbcWe5+fjc45/7QHSB1bz+d0067nJLYgfgFuiQ9snfFHckdTQGVYv9xN4F5
 Z0AC/sVf8WCr4mYCjwLMeuGeoEIy+AH7RvQJBIreEC+ySdWFFKi1o3ELDKjqOmYcb/o/
 WjprbuqtEjp0j/12ySAsxOGnWEob1Q0PgtPqpQHC6paGccpuv+lOd8b5FvWSy2hOTF0s
 cfMw==
X-Gm-Message-State: AOJu0YwDkPRyA6EVBcSf6+0tnBlsVWkaJndM8uFB4+45i31gmc2tneFj
 dtbcevkODMCCJdTIs2TZDEF1QjL4PNu5pVd+EITpmyxtzw8Ot/CoXKk5xDmyy9WcEqA=
X-Gm-Gg: ASbGncvMIg29bJg71wngGYhs4zgJoR+rO25WaR22UlZ2930WTae3mz9Cp/vAp6e6HFM
 yqHpFP/nMQlDmI3ETgK2jgsGLQHWGMA5zbh9ybemLDho+H/x9XaS1Z8I4ZWz8RHtI94U8XveWqq
 qbs7/zDJgPaNFsXldXs8xSOqHjjgvHiCxTuaDckDrUSqzA9UoG8OvTxHbZx72KSWEvuMFrosLAW
 rR4aH9ppCuY65cRu3v6TNxU2u3dJrSpMy/t949mKbBp+pmAbAY7bD22eODciWaFwcb17ap17g42
 mZL8xNpZZQgbUoNGh40QEd/bge+U7ol3V/86UrMbEwPY6WJotx2GhonJMs4TOn9YTQD7hxcFivS
 qniPOExxqRvPmzE3rV8XHzs9NHNL9/qgARuw=
X-Google-Smtp-Source: AGHT+IHZJ8/fAxUjBnjHFXpFSIANbaBxLCDzvPnhDo6RwDB0WzumpPi6Hcy5FTPlWgTIkVbn3xKgIQ==
X-Received: by 2002:a05:620a:4508:b0:864:1d18:4980 with SMTP id
 af79cd13be357-8641d184dc5mr1471270885a.24.1759166860372; 
 Mon, 29 Sep 2025 10:27:40 -0700 (PDT)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-85c337a1c97sm838586585a.55.2025.09.29.10.27.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 10:27:39 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: luca.vizzarro@arm.com
Cc: dev@dpdk.org, dmarx@iol.unh.edu, ivan.malov@arknetworks.am,
 probb@iol.unh.edu, Andrew Bailey <abailey@iol.unh.edu>,
 Jeremy Spewock <jspewock@iol.unh.edu>
Subject: [PATCH v6 2/3] dts: add TX offload capabilities to NIC capabilities
Date: Mon, 29 Sep 2025 13:27:33 -0400
Message-ID: <20250929172734.218467-3-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250929172734.218467-1-abailey@iol.unh.edu>
References: <20250902114327.48185-1-abailey@iol.unh.edu>
 <20250929172734.218467-1-abailey@iol.unh.edu>
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

Currently, there is no support for tracking tx_offload capabilities and
there is no separation between port capabilities and queue
capabilities. This is an issue if a test case requires a tx_offload
capability or if a test case requires that a card supports a capability
on a queue. This causes test cases with said requirements to not be
skipped when appropriate. Add tx_offload capabilities and distinguish
capabilities between ports and queues.

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
Signed-off-by: Jeremy Spewock <jspewock@iol.unh.edu>
---
 dts/api/capabilities.py                   | 126 ++++++++++--
 dts/api/testpmd/__init__.py               |  97 ++++++++-
 dts/api/testpmd/types.py                  | 227 +++++++++++++++-------
 dts/framework/parser.py                   |  30 +++
 dts/framework/testbed_model/capability.py | 109 +++++++++--
 dts/tests/TestSuite_checksum_offload.py   |  10 +-
 dts/tests/TestSuite_pmd_buffer_scatter.py |   4 +-
 dts/tests/TestSuite_vlan.py               |   4 +-
 8 files changed, 489 insertions(+), 118 deletions(-)

diff --git a/dts/api/capabilities.py b/dts/api/capabilities.py
index 1a79413f6f..243759668f 100644
--- a/dts/api/capabilities.py
+++ b/dts/api/capabilities.py
@@ -77,45 +77,65 @@ class NicCapability(IntEnum):
     #: Scattered packets Rx enabled.
     SCATTERED_RX_ENABLED = 0
     #: Device supports VLAN stripping.
-    RX_OFFLOAD_VLAN_STRIP = auto()
+    PORT_RX_OFFLOAD_VLAN_STRIP = auto()
+    QUEUE_RX_OFFLOAD_VLAN_STRIP = auto()
     #: Device supports L3 checksum offload.
-    RX_OFFLOAD_IPV4_CKSUM = auto()
+    PORT_RX_OFFLOAD_IPV4_CKSUM = auto()
+    QUEUE_RX_OFFLOAD_IPV4_CKSUM = auto()
     #: Device supports L4 checksum offload.
-    RX_OFFLOAD_UDP_CKSUM = auto()
+    PORT_RX_OFFLOAD_UDP_CKSUM = auto()
+    QUEUE_RX_OFFLOAD_UDP_CKSUM = auto()
     #: Device supports L4 checksum offload.
-    RX_OFFLOAD_TCP_CKSUM = auto()
+    PORT_RX_OFFLOAD_TCP_CKSUM = auto()
+    QUEUE_RX_OFFLOAD_TCP_CKSUM = auto()
     #: Device supports Large Receive Offload.
-    RX_OFFLOAD_TCP_LRO = auto()
+    PORT_RX_OFFLOAD_TCP_LRO = auto()
+    QUEUE_RX_OFFLOAD_TCP_LRO = auto()
     #: Device supports QinQ (queue in queue) offload.
-    RX_OFFLOAD_QINQ_STRIP = auto()
+    PORT_RX_OFFLOAD_QINQ_STRIP = auto()
+    QUEUE_RX_OFFLOAD_QINQ_STRIP = auto()
     #: Device supports inner packet L3 checksum.
-    RX_OFFLOAD_OUTER_IPV4_CKSUM = auto()
+    PORT_RX_OFFLOAD_OUTER_IPV4_CKSUM = auto()
+    QUEUE_RX_OFFLOAD_OUTER_IPV4_CKSUM = auto()
     #: Device supports MACsec.
-    RX_OFFLOAD_MACSEC_STRIP = auto()
+    PORT_RX_OFFLOAD_MACSEC_STRIP = auto()
+    QUEUE_RX_OFFLOAD_MACSEC_STRIP = auto()
     #: Device supports filtering of a VLAN Tag identifier.
-    RX_OFFLOAD_VLAN_FILTER = auto()
+    PORT_RX_OFFLOAD_VLAN_FILTER = auto()
+    QUEUE_RX_OFFLOAD_VLAN_FILTER = auto()
     #: Device supports VLAN offload.
-    RX_OFFLOAD_VLAN_EXTEND = auto()
+    PORT_RX_OFFLOAD_VLAN_EXTEND = auto()
+    QUEUE_RX_OFFLOAD_VLAN_EXTEND = auto()
     #: Device supports receiving segmented mbufs.
-    RX_OFFLOAD_SCATTER = auto()
+    PORT_RX_OFFLOAD_SCATTER = auto()
+    QUEUE_RX_OFFLOAD_SCATTER = auto()
     #: Device supports Timestamp.
-    RX_OFFLOAD_TIMESTAMP = auto()
+    PORT_RX_OFFLOAD_TIMESTAMP = auto()
+    QUEUE_RX_OFFLOAD_TIMESTAMP = auto()
     #: Device supports crypto processing while packet is received in NIC.
-    RX_OFFLOAD_SECURITY = auto()
+    PORT_RX_OFFLOAD_SECURITY = auto()
+    QUEUE_RX_OFFLOAD_SECURITY = auto()
     #: Device supports CRC stripping.
-    RX_OFFLOAD_KEEP_CRC = auto()
+    PORT_RX_OFFLOAD_KEEP_CRC = auto()
+    QUEUE_RX_OFFLOAD_KEEP_CRC = auto()
     #: Device supports L4 checksum offload.
-    RX_OFFLOAD_SCTP_CKSUM = auto()
+    PORT_RX_OFFLOAD_SCTP_CKSUM = auto()
+    QUEUE_RX_OFFLOAD_SCTP_CKSUM = auto()
     #: Device supports inner packet L4 checksum.
-    RX_OFFLOAD_OUTER_UDP_CKSUM = auto()
+    PORT_RX_OFFLOAD_OUTER_UDP_CKSUM = auto()
+    QUEUE_RX_OFFLOAD_OUTER_UDP_CKSUM = auto()
     #: Device supports RSS hashing.
-    RX_OFFLOAD_RSS_HASH = auto()
+    PORT_RX_OFFLOAD_RSS_HASH = auto()
+    QUEUE_RX_OFFLOAD_RSS_HASH = auto()
     #: Device supports scatter Rx packets to segmented mbufs.
-    RX_OFFLOAD_BUFFER_SPLIT = auto()
+    PORT_RX_OFFLOAD_BUFFER_SPLIT = auto()
+    QUEUE_RX_OFFLOAD_BUFFER_SPLIT = auto()
     #: Device supports all checksum capabilities.
-    RX_OFFLOAD_CHECKSUM = auto()
+    PORT_RX_OFFLOAD_CHECKSUM = auto()
+    QUEUE_RX_OFFLOAD_CHECKSUM = auto()
     #: Device supports all VLAN capabilities.
-    RX_OFFLOAD_VLAN = auto()
+    PORT_RX_OFFLOAD_VLAN = auto()
+    QUEUE_RX_OFFLOAD_VLAN = auto()
     #: Device supports Rx queue setup after device started.
     RUNTIME_RX_QUEUE_SETUP = auto()
     #: Device supports Tx queue setup after device started.
@@ -132,6 +152,72 @@ class NicCapability(IntEnum):
     FLOW_CTRL = auto()
     #: Device is running on a physical function.
     PHYSICAL_FUNCTION = auto()
+    #:
+    PORT_TX_OFFLOAD_VLAN_INSERT = auto()
+    QUEUE_TX_OFFLOAD_VLAN_INSERT = auto()
+    #:
+    PORT_TX_OFFLOAD_IPV4_CKSUM = auto()
+    QUEUE_TX_OFFLOAD_IPV4_CKSUM = auto()
+    #:
+    PORT_TX_OFFLOAD_UDP_CKSUM = auto()
+    QUEUE_TX_OFFLOAD_UDP_CKSUM = auto()
+    #:
+    PORT_TX_OFFLOAD_TCP_CKSUM = auto()
+    QUEUE_TX_OFFLOAD_TCP_CKSUM = auto()
+    #:
+    PORT_TX_OFFLOAD_SCTP_CKSUM = auto()
+    QUEUE_TX_OFFLOAD_SCTP_CKSUM = auto()
+    #:
+    PORT_TX_OFFLOAD_TCP_TSO = auto()
+    QUEUE_TX_OFFLOAD_TCP_TSO = auto()
+    #:
+    PORT_TX_OFFLOAD_UDP_TSO = auto()
+    QUEUE_TX_OFFLOAD_UDP_TSO = auto()
+    #:
+    PORT_TX_OFFLOAD_OUTER_IPV4_CKSUM = auto()
+    QUEUE_TX_OFFLOAD_OUTER_IPV4_CKSUM = auto()
+    #:
+    PORT_TX_OFFLOAD_QINQ_INSERT = auto()
+    QUEUE_TX_OFFLOAD_QINQ_INSERT = auto()
+    #:
+    PORT_TX_OFFLOAD_VXLAN_TNL_TSO = auto()
+    QUEUE_TX_OFFLOAD_VXLAN_TNL_TSO = auto()
+    #:
+    PORT_TX_OFFLOAD_GRE_TNL_TSO = auto()
+    QUEUE_TX_OFFLOAD_GRE_TNL_TSO = auto()
+    #:
+    PORT_TX_OFFLOAD_IPIP_TNL_TSO = auto()
+    QUEUE_TX_OFFLOAD_IPIP_TNL_TSO = auto()
+    #:
+    PORT_TX_OFFLOAD_GENEVE_TNL_TSO = auto()
+    QUEUE_TX_OFFLOAD_GENEVE_TNL_TSO = auto()
+    #:
+    PORT_TX_OFFLOAD_MACSEC_INSERT = auto()
+    QUEUE_TX_OFFLOAD_MACSEC_INSERT = auto()
+    #:
+    PORT_TX_OFFLOAD_MT_LOCKFREE = auto()
+    QUEUE_TX_OFFLOAD_MT_LOCKFREE = auto()
+    #:
+    PORT_TX_OFFLOAD_MULTI_SEGS = auto()
+    QUEUE_TX_OFFLOAD_MULTI_SEGS = auto()
+    #:
+    PORT_TX_OFFLOAD_MBUF_FAST_FREE = auto()
+    QUEUE_TX_OFFLOAD_MBUF_FAST_FREE = auto()
+    #:
+    PORT_TX_OFFLOAD_SECURITY = auto()
+    QUEUE_TX_OFFLOAD_SECURITY = auto()
+    #:
+    PORT_TX_OFFLOAD_UDP_TNL_TSO = auto()
+    QUEUE_TX_OFFLOAD_UDP_TNL_TSO = auto()
+    #:
+    PORT_TX_OFFLOAD_IP_TNL_TSO = auto()
+    QUEUE_TX_OFFLOAD_IP_TNL_TSO = auto()
+    #:
+    PORT_TX_OFFLOAD_OUTER_UDP_CKSUM = auto()
+    QUEUE_TX_OFFLOAD_OUTER_UDP_CKSUM = auto()
+    #:
+    PORT_TX_OFFLOAD_SEND_ON_TIMESTAMP = auto()
+    QUEUE_TX_OFFLOAD_SEND_ON_TIMESTAMP = auto()
 
 
 def requires_link_topology(
diff --git a/dts/api/testpmd/__init__.py b/dts/api/testpmd/__init__.py
index 39696ddde2..90c44b5adc 100644
--- a/dts/api/testpmd/__init__.py
+++ b/dts/api/testpmd/__init__.py
@@ -39,6 +39,8 @@
     FlowRule,
     RxOffloadCapabilities,
     RxOffloadCapability,
+    RxOffloadConfiguration,
+    RxTxLiteralSwitch,
     TestPmdDevice,
     TestPmdPort,
     TestPmdPortFlowCtrl,
@@ -46,6 +48,9 @@
     TestPmdQueueInfo,
     TestPmdRxqInfo,
     TestPmdVerbosePacket,
+    TxOffloadCapabilities,
+    TxOffloadCapability,
+    TxOffloadConfiguration,
     VLANOffloadFlag,
 )
 from framework.context import get_ctx
@@ -1190,13 +1195,14 @@ def _update_capabilities_from_flag(
         unsupported_capabilities: MutableSet["NicCapability"],
         flag_class: type[Flag],
         supported_flags: Flag,
+        prefix: str = "",
     ) -> None:
         """Divide all flags from `flag_class` into supported and unsupported."""
         for flag in flag_class:
             if flag in supported_flags:
-                supported_capabilities.add(NicCapability[str(flag.name)])
+                supported_capabilities.add(NicCapability[f"{prefix}{flag.name}"])
             else:
-                unsupported_capabilities.add(NicCapability[str(flag.name)])
+                unsupported_capabilities.add(NicCapability[f"{prefix}{flag.name}"])
 
     @_requires_started_ports
     def get_capabilities_rxq_info(
@@ -1293,6 +1299,55 @@ def get_capabilities_physical_function(
         else:
             unsupported_capabilities.add(NicCapability.PHYSICAL_FUNCTION)
 
+    @staticmethod
+    def get_offload_capabilities_func(
+        rxtx: RxTxLiteralSwitch,
+    ) -> Callable[["TestPmd", MutableSet["NicCapability"], MutableSet["NicCapability"]], None]:
+        """High-order function that returns a method for gathering Rx/Tx offload capabilities.
+
+        Args:
+            rxtx: whether to gather the rx or tx capabilities in the returned method.
+
+        Returns:
+            A method for gathering Rx/Tx offload capabilities that meets the required structure.
+        """
+
+        def get_capabilities(
+            self: "TestPmd",
+            supported_capabilities: MutableSet["NicCapability"],
+            unsupported_capabilities: MutableSet["NicCapability"],
+        ) -> None:
+            """Get all rx/tx offload capabilities and divide them into supported and unsupported.
+
+            Args:
+                self: The shell instance to get the capabilities from.
+                supported_capabilities: Supported capabilities will be added to this set.
+                unsupported_capabilities: Unsupported capabilities will be added to this set.
+            """
+            self._logger.info(f"Getting {rxtx} offload capabilities.")
+            command = f"show port {self.ports[0].id} {rxtx}_offload capabilities"
+            offload_capabilities_out = self.send_command(command)
+
+            capabilities = TxOffloadCapabilities if rxtx == "tx" else RxOffloadCapabilities
+            offload_capabilities = capabilities.parse(offload_capabilities_out)
+
+            self._update_capabilities_from_flag(
+                supported_capabilities,
+                unsupported_capabilities,
+                TxOffloadCapability if rxtx == "tx" else RxOffloadCapability,
+                offload_capabilities.per_port | offload_capabilities.per_queue,
+                prefix=f"PORT_{rxtx.upper()}_OFFLOAD_",
+            )
+            self._update_capabilities_from_flag(
+                supported_capabilities,
+                unsupported_capabilities,
+                TxOffloadCapability if rxtx == "tx" else RxOffloadCapability,
+                offload_capabilities.per_queue,
+                prefix=f"QUEUE_{rxtx.upper()}_OFFLOAD_",
+            )
+
+        return get_capabilities
+
     @_requires_stopped_ports
     def set_port_mbuf_fast_free(
         self,
@@ -1352,3 +1407,41 @@ def set_queue_mbuf_fast_free(
             raise InteractiveCommandExecutionError(
                 f"Failed to get offload config on port {port_id}, queue {queue_id}:\n{output}"
             )
+
+    @_requires_started_ports
+    def get_offload_config(
+        self,
+        rxtx: RxTxLiteralSwitch,
+        port_id: int,
+        /,
+        verify: bool = True,
+    ) -> RxOffloadConfiguration | TxOffloadConfiguration:
+        """Get the Rx or Tx offload configuration of the queues from the given port.
+
+        Args:
+            rxtx: Whether to get the Rx or Tx configuration of the given queues.
+            port_id: The port ID that contains the desired queues.
+            verify: If :data:`True` the output of the command will be scanned in an attempt to
+                verify that the offload configuration was retrieved successfully on all queues.
+
+        Returns:
+            An offload configuration containing the capabilities of the port and queues.
+
+        Raises:
+            InteractiveCommandExecutionError: If all queue offload configurations could not be
+                retrieved.
+        """
+        config_output = self.send_command(f"show port {port_id} {rxtx}_offload configuration")
+        if verify:
+            if (
+                f"Rx Offloading Configuration of port {port_id}" not in config_output
+                and f"Tx Offloading Configuration of port {port_id}" not in config_output
+            ):
+                self._logger.debug(f"Get port offload config error\n{config_output}")
+                raise InteractiveCommandExecutionError(
+                    f"Failed to get offload config on port {port_id}:\n{config_output}"
+                )
+        if rxtx == "rx":
+            return RxOffloadConfiguration.parse(config_output)
+        else:
+            return TxOffloadConfiguration.parse(config_output)
diff --git a/dts/api/testpmd/types.py b/dts/api/testpmd/types.py
index d1ebf6f2d1..46ae034cec 100644
--- a/dts/api/testpmd/types.py
+++ b/dts/api/testpmd/types.py
@@ -18,6 +18,8 @@
 from framework.parser import ParserFn, TextParser
 from framework.utils import REGEX_FOR_MAC_ADDRESS, StrEnum
 
+RxTxLiteralSwitch = Literal["rx", "tx"]
+
 
 class TestPmdDevice:
     """The data of a device that testpmd can recognize.
@@ -1246,7 +1248,99 @@ class TestPmdVerbosePacket(TextParser):
     )
 
 
-class RxOffloadCapability(Flag):
+class OffloadCapability(Flag):
+    """Flags generated from RxOffloadCapabilites and TxOffloadCapabilities classes."""
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
+            flag |= cls[flag_name]
+        return flag
+
+    @classmethod
+    def from_list(cls, lines: list[str]) -> list[Self]:
+        """Gather capabilities from a list of strings.
+
+        Args:
+            lines: The list of capabilities to make flags from.
+        """
+        return [cls.from_string(line) for line in lines]
+
+    @classmethod
+    def make_parser(
+        cls, per_port: Literal["port", "queue"], /, find_multiple: bool = False
+    ) -> ParserFn:
+        """Make a parser function.
+
+        Args:
+            per_port: If :data:`True`, will return capabilities per port. If :data:`False`,
+                will return capabilities per queue.
+            find_multiple: If :data:`True`, will use :func:`TextParser.find_all` to find all
+                matches for the regex query and return a list of instances based on those matches.
+                If :data:`False`, will return a single instance of the flag based off a single
+                match.
+
+        Returns:
+            ParserFn: A dictionary for the `dataclasses.field` metadata argument containing a
+                parser function that makes an instance of this flag from text.
+        """
+        granularity = per_port.capitalize()
+        regex = rf"{granularity}[\s\[\]\d]+:(.*)$"
+        if find_multiple:
+            return TextParser.wrap(TextParser.find_all(regex, re.MULTILINE), cls.from_list)
+        return TextParser.wrap(TextParser.find(regex, re.MULTILINE), cls.from_string)
+
+
+class TxOffloadCapability(OffloadCapability):
+    """TX offload capabilities of a device.
+
+    The flags are taken from ``lib/ethdev/rte_ethdev.h``.
+    They're prefixed with ``RTE_ETH_TX_OFFLOAD`` in ``lib/ethdev/rte_ethdev.h``
+    instead of ``TX_OFFLOAD``, which is what testpmd changes the prefix to.
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
+    VLAN_INSERT = auto()
+    IPV4_CKSUM = auto()
+    UDP_CKSUM = auto()
+    TCP_CKSUM = auto()
+    SCTP_CKSUM = auto()
+    TCP_TSO = auto()
+    UDP_TSO = auto()
+    OUTER_IPV4_CKSUM = auto()
+    QINQ_INSERT = auto()
+    VXLAN_TNL_TSO = auto()
+    GRE_TNL_TSO = auto()
+    IPIP_TNL_TSO = auto()
+    GENEVE_TNL_TSO = auto()
+    MACSEC_INSERT = auto()
+    MT_LOCKFREE = auto()
+    MULTI_SEGS = auto()
+    MBUF_FAST_FREE = auto()
+    SECURITY = auto()
+    UDP_TNL_TSO = auto()
+    IP_TNL_TSO = auto()
+    OUTER_UDP_CKSUM = auto()
+    SEND_ON_TIMESTAMP = auto()
+
+
+class RxOffloadCapability(OffloadCapability):
     """Rx offload capabilities of a device.
 
     The flags are taken from ``lib/ethdev/rte_ethdev.h``.
@@ -1265,102 +1359,103 @@ class RxOffloadCapability(Flag):
     """
 
     #:
-    RX_OFFLOAD_VLAN_STRIP = auto()
+    VLAN_STRIP = auto()
     #: Device supports L3 checksum offload.
-    RX_OFFLOAD_IPV4_CKSUM = auto()
+    IPV4_CKSUM = auto()
     #: Device supports L4 checksum offload.
-    RX_OFFLOAD_UDP_CKSUM = auto()
+    UDP_CKSUM = auto()
     #: Device supports L4 checksum offload.
-    RX_OFFLOAD_TCP_CKSUM = auto()
+    TCP_CKSUM = auto()
     #: Device supports Large Receive Offload.
-    RX_OFFLOAD_TCP_LRO = auto()
+    TCP_LRO = auto()
     #: Device supports QinQ (queue in queue) offload.
-    RX_OFFLOAD_QINQ_STRIP = auto()
+    QINQ_STRIP = auto()
     #: Device supports inner packet L3 checksum.
-    RX_OFFLOAD_OUTER_IPV4_CKSUM = auto()
+    OUTER_IPV4_CKSUM = auto()
     #: Device supports MACsec.
-    RX_OFFLOAD_MACSEC_STRIP = auto()
+    MACSEC_STRIP = auto()
     #: Device supports filtering of a VLAN Tag identifier.
-    RX_OFFLOAD_VLAN_FILTER = 1 << 9
+    VLAN_FILTER = 1 << 9
     #: Device supports VLAN offload.
-    RX_OFFLOAD_VLAN_EXTEND = auto()
+    VLAN_EXTEND = auto()
     #: Device supports receiving segmented mbufs.
-    RX_OFFLOAD_SCATTER = 1 << 13
+    SCATTER = 1 << 13
     #: Device supports Timestamp.
-    RX_OFFLOAD_TIMESTAMP = auto()
+    TIMESTAMP = auto()
     #: Device supports crypto processing while packet is received in NIC.
-    RX_OFFLOAD_SECURITY = auto()
+    SECURITY = auto()
     #: Device supports CRC stripping.
-    RX_OFFLOAD_KEEP_CRC = auto()
+    KEEP_CRC = auto()
     #: Device supports L4 checksum offload.
-    RX_OFFLOAD_SCTP_CKSUM = auto()
+    SCTP_CKSUM = auto()
     #: Device supports inner packet L4 checksum.
-    RX_OFFLOAD_OUTER_UDP_CKSUM = auto()
+    OUTER_UDP_CKSUM = auto()
     #: Device supports RSS hashing.
-    RX_OFFLOAD_RSS_HASH = auto()
+    RSS_HASH = auto()
     #: Device supports
-    RX_OFFLOAD_BUFFER_SPLIT = auto()
+    BUFFER_SPLIT = auto()
     #: Device supports all checksum capabilities.
-    RX_OFFLOAD_CHECKSUM = RX_OFFLOAD_IPV4_CKSUM | RX_OFFLOAD_UDP_CKSUM | RX_OFFLOAD_TCP_CKSUM
+    CHECKSUM = IPV4_CKSUM | UDP_CKSUM | TCP_CKSUM
     #: Device supports all VLAN capabilities.
-    RX_OFFLOAD_VLAN = (
-        RX_OFFLOAD_VLAN_STRIP
-        | RX_OFFLOAD_VLAN_FILTER
-        | RX_OFFLOAD_VLAN_EXTEND
-        | RX_OFFLOAD_QINQ_STRIP
-    )
+    VLAN = VLAN_STRIP | VLAN_FILTER | VLAN_EXTEND | QINQ_STRIP
 
-    @classmethod
-    def from_string(cls, line: str) -> Self:
-        """Make an instance from a string containing the flag names separated with a space.
 
-        Args:
-            line: The line to parse.
+@dataclass
+class OffloadCapabilities(TextParser):
+    """The result of testpmd's ``show port <port_id> rx/tx_offload capabilities`` command."""
 
-        Returns:
-            A new instance containing all found flags.
-        """
-        flag = cls(0)
-        for flag_name in line.split():
-            flag |= cls[f"RX_OFFLOAD_{flag_name}"]
-        return flag
+    port_id: int = field(metadata=TextParser.find_int(r"Offloading Capabilities of port (\d+) :"))
+    #: Per-queue offload capabilities.
+    per_queue: OffloadCapability
+    #: Capabilities other than per-queue offload capabilities.
+    per_port: OffloadCapability
 
-    @classmethod
-    def make_parser(cls, per_port: bool) -> ParserFn:
-        """Make a parser function.
 
-        Args:
-            per_port: If :data:`True`, will return capabilities per port. If :data:`False`,
-                will return capabilities per queue.
+@dataclass
+class RxOffloadCapabilities(OffloadCapabilities):
+    """Extends :class:`OffloadCapabilities` with Rx specific functionality."""
 
-        Returns:
-            ParserFn: A dictionary for the `dataclasses.field` metadata argument containing a
-                parser function that makes an instance of this flag from text.
-        """
-        granularity = "Port" if per_port else "Queue"
-        return TextParser.wrap(
-            TextParser.find(rf"Per {granularity}\s+:(.*)$", re.MULTILINE),
-            cls.from_string,
-        )
+    per_queue: OffloadCapability = field(metadata=RxOffloadCapability.make_parser("queue"))
+    per_port: OffloadCapability = field(metadata=RxOffloadCapability.make_parser("port"))
 
 
 @dataclass
-class RxOffloadCapabilities(TextParser):
-    """The result of testpmd's ``show port <port_id> rx_offload capabilities`` command.
+class TxOffloadCapabilities(OffloadCapabilities):
+    """Extends :class:`OffloadCapabilities` with Tx specific functionality."""
 
-    References:
-        testpmd command function: ``app/test-pmd/cmdline.c:cmd_rx_offload_get_capa()``
-        testpmd display function: ``app/test-pmd/cmdline.c:cmd_rx_offload_get_capa_parsed()``
-    """
+    per_queue: OffloadCapability = field(metadata=TxOffloadCapability.make_parser("queue"))
+    per_port: OffloadCapability = field(metadata=TxOffloadCapability.make_parser("port"))
 
-    #:
-    port_id: int = field(
-        metadata=TextParser.find_int(r"Rx Offloading Capabilities of port (\d+) :")
+
+@dataclass
+class OffloadConfiguration(TextParser):
+    """The result of testpmd's ``show port <port_id> rx/tx_offload configuration`` command."""
+
+    port_id: int = field(metadata=TextParser.find_int(r"Offloading Configuration of port (\d+) :"))
+    #: Queue offload configurations.
+    queues: list[OffloadCapability]
+    #: Port offload configuration.
+    port: OffloadCapability
+
+
+@dataclass
+class RxOffloadConfiguration(OffloadConfiguration):
+    """Extends :class:`OffloadingConfiguration` with Rx specific functionality."""
+
+    queues: list[OffloadCapability] = field(
+        metadata=RxOffloadCapability.make_parser("queue", find_multiple=True)
+    )
+    port: OffloadCapability = field(metadata=RxOffloadCapability.make_parser("port"))
+
+
+@dataclass
+class TxOffloadConfiguration(OffloadConfiguration):
+    """Extends :class:`OffloadingConfiguration` with Tx specific functionality."""
+
+    queues: list[OffloadCapability] = field(
+        metadata=TxOffloadCapability.make_parser("queue", find_multiple=True)
     )
-    #: Per-queue Rx offload capabilities.
-    per_queue: RxOffloadCapability = field(metadata=RxOffloadCapability.make_parser(False))
-    #: Capabilities other than per-queue Rx offload capabilities.
-    per_port: RxOffloadCapability = field(metadata=RxOffloadCapability.make_parser(True))
+    port: OffloadCapability = field(metadata=TxOffloadCapability.make_parser("port"))
 
 
 @dataclass
diff --git a/dts/framework/parser.py b/dts/framework/parser.py
index 7254c75b71..4170cdb1dd 100644
--- a/dts/framework/parser.py
+++ b/dts/framework/parser.py
@@ -116,6 +116,36 @@ def _composite_parser_fn(text: str) -> Any:
 
         return ParserFn(TextParser_fn=_composite_parser_fn)
 
+    @staticmethod
+    def find_all(
+        pattern: str | re.Pattern[str],
+        flags: re.RegexFlag = re.RegexFlag(0),
+    ) -> ParserFn:
+        """Makes a parser function that finds all of the regular expression matches in the text.
+
+        If there are no matches found in the text than None will be returned, otherwise a list
+        containing all matches will be returned. Patterns that contain multiple groups will pack
+        the matches for each group into a tuple.
+
+        Args:
+            pattern: The regular expression pattern.
+            flags: The regular expression flags. Ignored if the given pattern is already compiled.
+
+        Returns:
+            A :class:`ParserFn` that can be used as metadata for a dataclass field.
+        """
+        if isinstance(pattern, str):
+            pattern = re.compile(pattern, flags)
+
+        def _find_all(text: str) -> list[str] | None:
+            m = pattern.findall(text)
+            if len(m) == 0:
+                return None
+
+            return m
+
+        return ParserFn(TextParser_fn=_find_all)
+
     @staticmethod
     def find(
         pattern: str | re.Pattern[str],
diff --git a/dts/framework/testbed_model/capability.py b/dts/framework/testbed_model/capability.py
index f67cff94dc..b166014e0c 100644
--- a/dts/framework/testbed_model/capability.py
+++ b/dts/framework/testbed_model/capability.py
@@ -227,28 +227,95 @@ def mapping(cap: NicCapability) -> TestPmdNicCapability:
                 case NicCapability.SCATTERED_RX_ENABLED:
                     return (TestPmd.get_capabilities_rxq_info, _add_remove_mtu(9000))
                 case (
-                    NicCapability.RX_OFFLOAD_VLAN_STRIP
-                    | NicCapability.RX_OFFLOAD_IPV4_CKSUM
-                    | NicCapability.RX_OFFLOAD_UDP_CKSUM
-                    | NicCapability.RX_OFFLOAD_TCP_CKSUM
-                    | NicCapability.RX_OFFLOAD_TCP_LRO
-                    | NicCapability.RX_OFFLOAD_QINQ_STRIP
-                    | NicCapability.RX_OFFLOAD_OUTER_IPV4_CKSUM
-                    | NicCapability.RX_OFFLOAD_MACSEC_STRIP
-                    | NicCapability.RX_OFFLOAD_VLAN_FILTER
-                    | NicCapability.RX_OFFLOAD_VLAN_EXTEND
-                    | NicCapability.RX_OFFLOAD_SCATTER
-                    | NicCapability.RX_OFFLOAD_TIMESTAMP
-                    | NicCapability.RX_OFFLOAD_SECURITY
-                    | NicCapability.RX_OFFLOAD_KEEP_CRC
-                    | NicCapability.RX_OFFLOAD_SCTP_CKSUM
-                    | NicCapability.RX_OFFLOAD_OUTER_UDP_CKSUM
-                    | NicCapability.RX_OFFLOAD_RSS_HASH
-                    | NicCapability.RX_OFFLOAD_BUFFER_SPLIT
-                    | NicCapability.RX_OFFLOAD_CHECKSUM
-                    | NicCapability.RX_OFFLOAD_VLAN
+                    NicCapability.PORT_RX_OFFLOAD_VLAN_STRIP
+                    | NicCapability.PORT_RX_OFFLOAD_IPV4_CKSUM
+                    | NicCapability.PORT_RX_OFFLOAD_UDP_CKSUM
+                    | NicCapability.PORT_RX_OFFLOAD_TCP_CKSUM
+                    | NicCapability.PORT_RX_OFFLOAD_TCP_LRO
+                    | NicCapability.PORT_RX_OFFLOAD_QINQ_STRIP
+                    | NicCapability.PORT_RX_OFFLOAD_OUTER_IPV4_CKSUM
+                    | NicCapability.PORT_RX_OFFLOAD_MACSEC_STRIP
+                    | NicCapability.PORT_RX_OFFLOAD_VLAN_FILTER
+                    | NicCapability.PORT_RX_OFFLOAD_VLAN_EXTEND
+                    | NicCapability.PORT_RX_OFFLOAD_SCATTER
+                    | NicCapability.PORT_RX_OFFLOAD_TIMESTAMP
+                    | NicCapability.PORT_RX_OFFLOAD_SECURITY
+                    | NicCapability.PORT_RX_OFFLOAD_KEEP_CRC
+                    | NicCapability.PORT_RX_OFFLOAD_SCTP_CKSUM
+                    | NicCapability.PORT_RX_OFFLOAD_OUTER_UDP_CKSUM
+                    | NicCapability.PORT_RX_OFFLOAD_RSS_HASH
+                    | NicCapability.PORT_RX_OFFLOAD_BUFFER_SPLIT
+                    | NicCapability.PORT_RX_OFFLOAD_CHECKSUM
+                    | NicCapability.PORT_RX_OFFLOAD_VLAN
+                    | NicCapability.QUEUE_RX_OFFLOAD_VLAN_STRIP
+                    | NicCapability.QUEUE_RX_OFFLOAD_IPV4_CKSUM
+                    | NicCapability.QUEUE_RX_OFFLOAD_UDP_CKSUM
+                    | NicCapability.QUEUE_RX_OFFLOAD_TCP_CKSUM
+                    | NicCapability.QUEUE_RX_OFFLOAD_TCP_LRO
+                    | NicCapability.QUEUE_RX_OFFLOAD_QINQ_STRIP
+                    | NicCapability.QUEUE_RX_OFFLOAD_OUTER_IPV4_CKSUM
+                    | NicCapability.QUEUE_RX_OFFLOAD_MACSEC_STRIP
+                    | NicCapability.QUEUE_RX_OFFLOAD_VLAN_FILTER
+                    | NicCapability.QUEUE_RX_OFFLOAD_VLAN_EXTEND
+                    | NicCapability.QUEUE_RX_OFFLOAD_SCATTER
+                    | NicCapability.QUEUE_RX_OFFLOAD_TIMESTAMP
+                    | NicCapability.QUEUE_RX_OFFLOAD_SECURITY
+                    | NicCapability.QUEUE_RX_OFFLOAD_KEEP_CRC
+                    | NicCapability.QUEUE_RX_OFFLOAD_SCTP_CKSUM
+                    | NicCapability.QUEUE_RX_OFFLOAD_OUTER_UDP_CKSUM
+                    | NicCapability.QUEUE_RX_OFFLOAD_RSS_HASH
+                    | NicCapability.QUEUE_RX_OFFLOAD_BUFFER_SPLIT
+                    | NicCapability.QUEUE_RX_OFFLOAD_CHECKSUM
+                    | NicCapability.QUEUE_RX_OFFLOAD_VLAN
                 ):
-                    return (TestPmd.get_capabilities_rx_offload, None)
+                    return (TestPmd.get_offload_capabilities_func("rx"), None)
+                case (
+                    NicCapability.PORT_TX_OFFLOAD_VLAN_INSERT
+                    | NicCapability.PORT_TX_OFFLOAD_IPV4_CKSUM
+                    | NicCapability.PORT_TX_OFFLOAD_UDP_CKSUM
+                    | NicCapability.PORT_TX_OFFLOAD_TCP_CKSUM
+                    | NicCapability.PORT_TX_OFFLOAD_SCTP_CKSUM
+                    | NicCapability.PORT_TX_OFFLOAD_TCP_TSO
+                    | NicCapability.PORT_TX_OFFLOAD_UDP_TSO
+                    | NicCapability.PORT_TX_OFFLOAD_OUTER_IPV4_CKSUM
+                    | NicCapability.PORT_TX_OFFLOAD_QINQ_INSERT
+                    | NicCapability.PORT_TX_OFFLOAD_VXLAN_TNL_TSO
+                    | NicCapability.PORT_TX_OFFLOAD_GRE_TNL_TSO
+                    | NicCapability.PORT_TX_OFFLOAD_IPIP_TNL_TSO
+                    | NicCapability.PORT_TX_OFFLOAD_GENEVE_TNL_TSO
+                    | NicCapability.PORT_TX_OFFLOAD_MACSEC_INSERT
+                    | NicCapability.PORT_TX_OFFLOAD_MT_LOCKFREE
+                    | NicCapability.PORT_TX_OFFLOAD_MULTI_SEGS
+                    | NicCapability.PORT_TX_OFFLOAD_MBUF_FAST_FREE
+                    | NicCapability.PORT_TX_OFFLOAD_SECURITY
+                    | NicCapability.PORT_TX_OFFLOAD_UDP_TNL_TSO
+                    | NicCapability.PORT_TX_OFFLOAD_IP_TNL_TSO
+                    | NicCapability.PORT_TX_OFFLOAD_OUTER_UDP_CKSUM
+                    | NicCapability.PORT_TX_OFFLOAD_SEND_ON_TIMESTAMP
+                    | NicCapability.QUEUE_TX_OFFLOAD_VLAN_INSERT
+                    | NicCapability.QUEUE_TX_OFFLOAD_IPV4_CKSUM
+                    | NicCapability.QUEUE_TX_OFFLOAD_UDP_CKSUM
+                    | NicCapability.QUEUE_TX_OFFLOAD_TCP_CKSUM
+                    | NicCapability.QUEUE_TX_OFFLOAD_SCTP_CKSUM
+                    | NicCapability.QUEUE_TX_OFFLOAD_TCP_TSO
+                    | NicCapability.QUEUE_TX_OFFLOAD_UDP_TSO
+                    | NicCapability.QUEUE_TX_OFFLOAD_OUTER_IPV4_CKSUM
+                    | NicCapability.QUEUE_TX_OFFLOAD_QINQ_INSERT
+                    | NicCapability.QUEUE_TX_OFFLOAD_VXLAN_TNL_TSO
+                    | NicCapability.QUEUE_TX_OFFLOAD_GRE_TNL_TSO
+                    | NicCapability.QUEUE_TX_OFFLOAD_IPIP_TNL_TSO
+                    | NicCapability.QUEUE_TX_OFFLOAD_GENEVE_TNL_TSO
+                    | NicCapability.QUEUE_TX_OFFLOAD_MACSEC_INSERT
+                    | NicCapability.QUEUE_TX_OFFLOAD_MT_LOCKFREE
+                    | NicCapability.QUEUE_TX_OFFLOAD_MULTI_SEGS
+                    | NicCapability.QUEUE_TX_OFFLOAD_MBUF_FAST_FREE
+                    | NicCapability.QUEUE_TX_OFFLOAD_SECURITY
+                    | NicCapability.QUEUE_TX_OFFLOAD_UDP_TNL_TSO
+                    | NicCapability.QUEUE_TX_OFFLOAD_IP_TNL_TSO
+                    | NicCapability.QUEUE_TX_OFFLOAD_OUTER_UDP_CKSUM
+                    | NicCapability.QUEUE_TX_OFFLOAD_SEND_ON_TIMESTAMP
+                ):
+                    return (TestPmd.get_offload_capabilities_func("tx"), None)
                 case (
                     NicCapability.RUNTIME_RX_QUEUE_SETUP
                     | NicCapability.RUNTIME_TX_QUEUE_SETUP
diff --git a/dts/tests/TestSuite_checksum_offload.py b/dts/tests/TestSuite_checksum_offload.py
index 70ae9c124c..6e54e12d32 100644
--- a/dts/tests/TestSuite_checksum_offload.py
+++ b/dts/tests/TestSuite_checksum_offload.py
@@ -32,9 +32,9 @@
 
 
 @requires_link_topology(LinkTopology.TWO_LINKS)
-@requires_nic_capability(NicCapability.RX_OFFLOAD_IPV4_CKSUM)
-@requires_nic_capability(NicCapability.RX_OFFLOAD_UDP_CKSUM)
-@requires_nic_capability(NicCapability.RX_OFFLOAD_TCP_CKSUM)
+@requires_nic_capability(NicCapability.PORT_RX_OFFLOAD_IPV4_CKSUM)
+@requires_nic_capability(NicCapability.PORT_RX_OFFLOAD_UDP_CKSUM)
+@requires_nic_capability(NicCapability.PORT_RX_OFFLOAD_TCP_CKSUM)
 class TestChecksumOffload(TestSuite):
     """Checksum offload test suite.
 
@@ -291,7 +291,7 @@ def validate_rx_checksum(self) -> None:
                     packet=packet_list[i], good_L4=False, good_IP=True, testpmd=testpmd, id=dport_id
                 )
 
-    @requires_nic_capability(NicCapability.RX_OFFLOAD_VLAN)
+    @requires_nic_capability(NicCapability.PORT_RX_OFFLOAD_VLAN)
     @func_test
     def vlan_checksum(self) -> None:
         """Test VLAN Rx checksum hardware offload and verify packet reception.
@@ -350,7 +350,7 @@ def vlan_checksum(self) -> None:
                     packet=packet_list[i], good_L4=False, good_IP=True, testpmd=testpmd, id=dport_id
                 )
 
-    @requires_nic_capability(NicCapability.RX_OFFLOAD_SCTP_CKSUM)
+    @requires_nic_capability(NicCapability.PORT_RX_OFFLOAD_SCTP_CKSUM)
     @func_test
     def validate_sctp_checksum(self) -> None:
         """Test SCTP Rx checksum hardware offload and verify packet reception.
diff --git a/dts/tests/TestSuite_pmd_buffer_scatter.py b/dts/tests/TestSuite_pmd_buffer_scatter.py
index 06d2e5f7e5..a1f4841acf 100644
--- a/dts/tests/TestSuite_pmd_buffer_scatter.py
+++ b/dts/tests/TestSuite_pmd_buffer_scatter.py
@@ -32,7 +32,7 @@
 
 
 @requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
-@requires_nic_capability(NicCapability.RX_OFFLOAD_SCATTER)
+@requires_nic_capability(NicCapability.PORT_RX_OFFLOAD_SCATTER)
 class TestPmdBufferScatter(TestSuite):
     """DPDK PMD packet scattering test suite.
 
@@ -146,7 +146,7 @@ def scatter_mbuf_2048(self) -> None:
         """
         self._pmd_scatter(mb_size=2048)
 
-    @requires_nic_capability(NicCapability.RX_OFFLOAD_SCATTER)
+    @requires_nic_capability(NicCapability.PORT_RX_OFFLOAD_SCATTER)
     @func_test
     def scatter_mbuf_2048_with_offload(self) -> None:
         """Run the :meth:`pmd_scatter` test with `mb_size` set to 2048 and rx_scatter offload.
diff --git a/dts/tests/TestSuite_vlan.py b/dts/tests/TestSuite_vlan.py
index 6c1b181c74..b42f87d800 100644
--- a/dts/tests/TestSuite_vlan.py
+++ b/dts/tests/TestSuite_vlan.py
@@ -26,7 +26,7 @@
 from framework.test_suite import TestSuite, func_test
 
 
-@requires_nic_capability(NicCapability.RX_OFFLOAD_VLAN_FILTER)
+@requires_nic_capability(NicCapability.PORT_RX_OFFLOAD_VLAN_FILTER)
 @requires_link_topology(LinkTopology.TWO_LINKS)
 class TestVlan(TestSuite):
     """DPDK VLAN test suite.
@@ -140,7 +140,7 @@ def vlan_receipt_no_stripping(self) -> None:
             testpmd.start()
             self._send_vlan_packet_and_verify(should_receive=True, strip=False, vlan_id=1)
 
-    @requires_nic_capability(NicCapability.RX_OFFLOAD_VLAN_STRIP)
+    @requires_nic_capability(NicCapability.PORT_RX_OFFLOAD_VLAN_STRIP)
     @func_test
     def vlan_receipt_stripping(self) -> None:
         """Ensure VLAN packet received with no tag when receipts and header stripping are enabled.
-- 
2.50.1

