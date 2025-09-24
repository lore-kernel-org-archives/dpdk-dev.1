Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B123CAC5A5
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 16:47:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A2ECB40B94;
	Wed, 24 Sep 2025 18:47:41 +0200 (CEST)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com
 [209.85.219.54]) by mails.dpdk.org (Postfix) with ESMTP id 560E640695
 for <dev@dpdk.org>; Wed, 24 Sep 2025 18:47:38 +0200 (CEST)
Received: by mail-qv1-f54.google.com with SMTP id
 6a1803df08f44-79ad9aa2d95so64762406d6.1
 for <dev@dpdk.org>; Wed, 24 Sep 2025 09:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1758732458; x=1759337258; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9+gzWqeEtA40SwT/GJMJnaKNDc1q8CiLYIu87hknr4w=;
 b=RSm5qIA7tszBaQ4pk1KE9ejbYlMW/HG85HUuEdRMaNfYxJOtv0Oz9b+YriXT6LTIDa
 x2IC0ZPMrBLdBI3Yrj43CrdcQZ+y42Au03TxKWuNNQUiGtnWBh/h5rYQ0iK5GsHzYeJO
 EKeZJQ4KhMbKoywYaIdliRicMqRN+dUjJ1ydQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758732458; x=1759337258;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9+gzWqeEtA40SwT/GJMJnaKNDc1q8CiLYIu87hknr4w=;
 b=EXkpbRgGpRnUrOdVryh9te7l7GXKWE5nYIvV0jghiD3XwRoLkIoigDcdtaUxJkxn8U
 Thi2Zsu2YB9JRgvqQQy/FmYbeybOBlFYfuLhcRGodlnPLjHlY4OLjSs6uONeCMDw7Eu2
 kEHogw/UMeg8+yeeJsZwJ5uOg9S/NK4MtC1wSHSytwlHss5h7Xu5ytsUoyCPJ0fT4Q2l
 L2TSSnSG+AExJ+dC/oZrLHfYOKDiFpomT559KD5hbKSDeYn0BAnfO3tSKlbVY1qig4r1
 sv7AholCiFF1Mf/tXcWcp5yhE4zI6bN7npyMMBYhpBgpC5vd4ULS5M+tsgToPfWuyE73
 40CA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6tjbTVEGZNox8yvHZYSc07JnTH/3gIj4IO5KhERsZ68Akmq+GYmWo0C0uhye+E1F/hlE=@dpdk.org
X-Gm-Message-State: AOJu0Yz5nPMcnhVJQFcIsDZ+e2+fHskvwmD7FxgyV+zpyA6v5C8pAc8Z
 MQOIE3/SG/CdA5jwSlYOIOd9jtoDIQ2ZmVni/3itNWwVNDwg9CiTa0MSk8Xz3hBVDbo=
X-Gm-Gg: ASbGnctpLQeDOq1sYOc3UEdry7Ex/xwAXkzMKWqKjwKeI+sOkIKQ6b/X9MI/24oSWDh
 sBcb/auy+KMkBpmke3v/2L5A46gvqsP8/mfrtYNrntGwA78ApcWpYrb4ev5IhubJDeDVP9Pw7Tl
 BQpn4wtmacX49BgJknwFj6U4HsTw+Jn9zGMmN/ULA6HbjZQ2K81qEEfCSKfU6KmEB2EOuPFP5YR
 tB9rAK+NSWd9xeQUYfaFDGrvXlwUOHDXKe2vkA5313iCYqOo0BlXCbzPbFMMBHcBEfu5lCy1wmf
 GJ5eJV+WkB94NyRzujQRMmYfcw4onvAsltLNQeOObmq3ZE+I4f6kIdd9ml7IbokWFdQmPvMTFSB
 OFvT3D3evAZ/9HFmI4nzEWJY5fjziNa7fz7VGswlyyMFzYQ==
X-Google-Smtp-Source: AGHT+IEVkzZRAmACedygkvf/U1ticOcLLD6OuEiCgrqOYUUwYpqwiwQKpXJQcDJkMgRkmTZrQnTubA==
X-Received: by 2002:ad4:5947:0:b0:7f9:5850:70e7 with SMTP id
 6a1803df08f44-7fc3fcd92cdmr10822806d6.49.1758732457281; 
 Wed, 24 Sep 2025 09:47:37 -0700 (PDT)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-7a4c5785d49sm76849996d6.63.2025.09.24.09.47.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 09:47:36 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: luca.vizzarro@arm.com
Cc: abailey@iol.unh.edu, dev@dpdk.org, dmarx@iol.unh.edu,
 ivan.malov@arknetworks.am, probb@iol.unh.edu,
 Jeremy Spewock <jspewock@iol.unh.edu>
Subject: [PATCH v4 2/3]  dts: add TX offload capabilities to NIC capabilities
Date: Wed, 24 Sep 2025 12:47:24 -0400
Message-ID: <20250924164725.168773-3-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250924164725.168773-1-abailey@iol.unh.edu>
References: <20250902114327.48185-1-abailey@iol.unh.edu>
 <20250924164725.168773-1-abailey@iol.unh.edu>
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
 dts/framework/parser.py                       |  30 +
 dts/framework/remote_session/testpmd_shell.py | 678 ++++++++++++++----
 dts/tests/TestSuite_checksum_offload.py       |  10 +-
 dts/tests/TestSuite_pmd_buffer_scatter.py     |   4 +-
 dts/tests/TestSuite_vlan.py                   |   4 +-
 5 files changed, 593 insertions(+), 133 deletions(-)

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
diff --git a/dts/framework/remote_session/testpmd_shell.py b/dts/framework/remote_session/testpmd_shell.py
index ecbdd66edd..db7e33222a 100644
--- a/dts/framework/remote_session/testpmd_shell.py
+++ b/dts/framework/remote_session/testpmd_shell.py
@@ -43,6 +43,7 @@
 from framework.settings import SETTINGS
 from framework.utils import REGEX_FOR_MAC_ADDRESS, StrEnum
 
+RxTxLiteralSwitch = Literal["rx", "tx"]
 P = ParamSpec("P")
 TestPmdShellMethod = Callable[Concatenate["TestPmdShell", P], Any]
 
@@ -1278,7 +1279,99 @@ class TestPmdVerbosePacket(TextParser):
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
@@ -1297,102 +1390,108 @@ class RxOffloadCapability(Flag):
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
+    """The result of testpmd's ``show port <port_id> tx_offload capabilities`` command.
 
-        Returns:
-            A new instance containing all found flags.
-        """
-        flag = cls(0)
-        for flag_name in line.split():
-            flag |= cls[f"RX_OFFLOAD_{flag_name}"]
-        return flag
+    References:
+        testpmd command function: ``app/test-pmd/cmdline.c:cmd_tx_offload_get_capa()``
+        testpmd display function: ``app/test-pmd/cmdline.c:cmd_tx_offload_get_capa_parsed()``
+    """
 
-    @classmethod
-    def make_parser(cls, per_port: bool) -> ParserFn:
-        """Make a parser function.
+    port_id: int = field(metadata=TextParser.find_int(r"Offloading Capabilities of port (\d+) :"))
+    #: Per-queue Rx offload capabilities.
+    per_queue: OffloadCapability
+    #: Capabilities other than per-queue Rx offload capabilities.
+    per_port: OffloadCapability
 
-        Args:
-            per_port: If :data:`True`, will return capabilities per port. If :data:`False`,
-                will return capabilities per queue.
 
-        Returns:
-            ParserFn: A dictionary for the `dataclasses.field` metadata argument containing a
-                parser function that makes an instance of this flag from text.
-        """
-        granularity = "Port" if per_port else "Queue"
-        return TextParser.wrap(
-            TextParser.find(rf"Per {granularity}\s+:(.*)$", re.MULTILINE),
-            cls.from_string,
-        )
+@dataclass
+class RxOffloadCapabilities(OffloadCapabilities):
+    """Extends :class:`OffloadCapabilities` with Rx specific functionality."""
+
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
     )
-    #: Per-queue Rx offload capabilities.
-    per_queue: RxOffloadCapability = field(metadata=RxOffloadCapability.make_parser(False))
-    #: Capabilities other than per-queue Rx offload capabilities.
-    per_port: RxOffloadCapability = field(metadata=RxOffloadCapability.make_parser(True))
+    port: OffloadCapability = field(metadata=RxOffloadCapability.make_parser("port"))
+
+
+@dataclass
+class TxOffloadConfiguration(OffloadConfiguration):
+    """Extends :class:`OffloadingConfiguration` with Tx specific functionality."""
+
+    queues: list[OffloadCapability] = field(
+        metadata=TxOffloadCapability.make_parser("queue", find_multiple=True)
+    )
+    port: OffloadCapability = field(metadata=TxOffloadCapability.make_parser("port"))
 
 
 @dataclass
@@ -2390,27 +2489,54 @@ def close(self) -> None:
     ====== Capability retrieval methods ======
     """
 
-    def get_capabilities_rx_offload(
-        self,
-        supported_capabilities: MutableSet["NicCapability"],
-        unsupported_capabilities: MutableSet["NicCapability"],
-    ) -> None:
-        """Get all rx offload capabilities and divide them into supported and unsupported.
+    @staticmethod
+    def get_offload_capabilities_func(
+        rxtx: RxTxLiteralSwitch,
+    ) -> Callable[["TestPmdShell", MutableSet["NicCapability"], MutableSet["NicCapability"]], None]:
+        """High-order function that returns a method for gathering Rx/Tx offload capabilities.
 
         Args:
-            supported_capabilities: Supported capabilities will be added to this set.
-            unsupported_capabilities: Unsupported capabilities will be added to this set.
-        """
-        self._logger.debug("Getting rx offload capabilities.")
-        command = f"show port {self.ports[0].id} rx_offload capabilities"
-        rx_offload_capabilities_out = self.send_command(command)
-        rx_offload_capabilities = RxOffloadCapabilities.parse(rx_offload_capabilities_out)
-        self._update_capabilities_from_flag(
-            supported_capabilities,
-            unsupported_capabilities,
-            RxOffloadCapability,
-            rx_offload_capabilities.per_port | rx_offload_capabilities.per_queue,
-        )
+            rxtx: whether to gather the rx or tx capabilities in the returned method.
+
+        Returns:
+            A method for gathering Rx/Tx offload capabilities that meets the required structure.
+        """
+
+        def get_capabilities(
+            self: "TestPmdShell",
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
+            self._logger.debug(f"Getting {rxtx} offload capabilities.")
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
 
     def get_port_queue_info(
         self, port_id: int, queue_id: int, is_rx_queue: bool
@@ -2569,13 +2695,52 @@ def _update_capabilities_from_flag(
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
+
+    @requires_started_ports
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
 
     @requires_started_ports
     def get_capabilities_rxq_info(
@@ -2758,102 +2923,367 @@ class NicCapability(NoAliasEnum):
     we don't go looking for it again if a different test case also needs it.
     """
 
+    PORT_TX_OFFLOAD_VLAN_INSERT: TestPmdShellNicCapability = (
+        TestPmdShell.get_offload_capabilities_func("tx"),
+        None,
+    )
+    QUEUE_TX_OFFLOAD_VLAN_INSERT: TestPmdShellNicCapability = (
+        TestPmdShell.get_offload_capabilities_func("tx"),
+        None,
+    )
+    PORT_TX_OFFLOAD_IPV4_CKSUM: TestPmdShellNicCapability = (
+        TestPmdShell.get_offload_capabilities_func("tx"),
+        None,
+    )
+    QUEUE_TX_OFFLOAD_IPV4_CKSUM: TestPmdShellNicCapability = (
+        TestPmdShell.get_offload_capabilities_func("tx"),
+        None,
+    )
+    PORT_TX_OFFLOAD_UDP_CKSUM: TestPmdShellNicCapability = (
+        TestPmdShell.get_offload_capabilities_func("tx"),
+        None,
+    )
+    QUEUE_TX_OFFLOAD_UDP_CKSUM: TestPmdShellNicCapability = (
+        TestPmdShell.get_offload_capabilities_func("tx"),
+        None,
+    )
+    PORT_TX_OFFLOAD_TCP_CKSUM: TestPmdShellNicCapability = (
+        TestPmdShell.get_offload_capabilities_func("tx"),
+        None,
+    )
+    QUEUE_TX_OFFLOAD_TCP_CKSUM: TestPmdShellNicCapability = (
+        TestPmdShell.get_offload_capabilities_func("tx"),
+        None,
+    )
+    PORT_TX_OFFLOAD_SCTP_CKSUM: TestPmdShellNicCapability = (
+        TestPmdShell.get_offload_capabilities_func("tx"),
+        None,
+    )
+    QUEUE_TX_OFFLOAD_SCTP_CKSUM: TestPmdShellNicCapability = (
+        TestPmdShell.get_offload_capabilities_func("tx"),
+        None,
+    )
+    PORT_TX_OFFLOAD_TCP_TSO: TestPmdShellNicCapability = (
+        TestPmdShell.get_offload_capabilities_func("tx"),
+        None,
+    )
+    QUEUE_TX_OFFLOAD_TCP_TSO: TestPmdShellNicCapability = (
+        TestPmdShell.get_offload_capabilities_func("tx"),
+        None,
+    )
+    PORT_TX_OFFLOAD_UDP_TSO: TestPmdShellNicCapability = (
+        TestPmdShell.get_offload_capabilities_func("tx"),
+        None,
+    )
+    QUEUE_TX_OFFLOAD_UDP_TSO: TestPmdShellNicCapability = (
+        TestPmdShell.get_offload_capabilities_func("tx"),
+        None,
+    )
+    PORT_TX_OFFLOAD_OUTER_IPV4_CKSUM: TestPmdShellNicCapability = (
+        TestPmdShell.get_offload_capabilities_func("tx"),
+        None,
+    )
+    QUEUE_TX_OFFLOAD_OUTER_IPV4_CKSUM: TestPmdShellNicCapability = (
+        TestPmdShell.get_offload_capabilities_func("tx"),
+        None,
+    )
+    PORT_TX_OFFLOAD_QINQ_INSERT: TestPmdShellNicCapability = (
+        TestPmdShell.get_offload_capabilities_func("tx"),
+        None,
+    )
+    QUEUE_TX_OFFLOAD_QINQ_INSERT: TestPmdShellNicCapability = (
+        TestPmdShell.get_offload_capabilities_func("tx"),
+        None,
+    )
+    PORT_TX_OFFLOAD_VXLAN_TNL_TSO: TestPmdShellNicCapability = (
+        TestPmdShell.get_offload_capabilities_func("tx"),
+        None,
+    )
+    QUEUE_TX_OFFLOAD_VXLAN_TNL_TSO: TestPmdShellNicCapability = (
+        TestPmdShell.get_offload_capabilities_func("tx"),
+        None,
+    )
+    PORT_TX_OFFLOAD_GRE_TNL_TSO: TestPmdShellNicCapability = (
+        TestPmdShell.get_offload_capabilities_func("tx"),
+        None,
+    )
+    QUEUE_TX_OFFLOAD_GRE_TNL_TSO: TestPmdShellNicCapability = (
+        TestPmdShell.get_offload_capabilities_func("tx"),
+        None,
+    )
+    PORT_TX_OFFLOAD_IPIP_TNL_TSO: TestPmdShellNicCapability = (
+        TestPmdShell.get_offload_capabilities_func("tx"),
+        None,
+    )
+    QUEUE_TX_OFFLOAD_IPIP_TNL_TSO: TestPmdShellNicCapability = (
+        TestPmdShell.get_offload_capabilities_func("tx"),
+        None,
+    )
+    PORT_TX_OFFLOAD_GENEVE_TNL_TSO: TestPmdShellNicCapability = (
+        TestPmdShell.get_offload_capabilities_func("tx"),
+        None,
+    )
+    QUEUE_TX_OFFLOAD_GENEVE_TNL_TSO: TestPmdShellNicCapability = (
+        TestPmdShell.get_offload_capabilities_func("tx"),
+        None,
+    )
+    PORT_TX_OFFLOAD_MACSEC_INSERT: TestPmdShellNicCapability = (
+        TestPmdShell.get_offload_capabilities_func("tx"),
+        None,
+    )
+    QUEUE_TX_OFFLOAD_MACSEC_INSERT: TestPmdShellNicCapability = (
+        TestPmdShell.get_offload_capabilities_func("tx"),
+        None,
+    )
+    PORT_TX_OFFLOAD_MT_LOCKFREE: TestPmdShellNicCapability = (
+        TestPmdShell.get_offload_capabilities_func("tx"),
+        None,
+    )
+    QUEUE_TX_OFFLOAD_MT_LOCKFREE: TestPmdShellNicCapability = (
+        TestPmdShell.get_offload_capabilities_func("tx"),
+        None,
+    )
+    PORT_TX_OFFLOAD_MULTI_SEGS: TestPmdShellNicCapability = (
+        TestPmdShell.get_offload_capabilities_func("tx"),
+        None,
+    )
+    QUEUE_TX_OFFLOAD_MULTI_SEGS: TestPmdShellNicCapability = (
+        TestPmdShell.get_offload_capabilities_func("tx"),
+        None,
+    )
+    PORT_TX_OFFLOAD_MBUF_FAST_FREE: TestPmdShellNicCapability = (
+        TestPmdShell.get_offload_capabilities_func("tx"),
+        None,
+    )
+    QUEUE_TX_OFFLOAD_MBUF_FAST_FREE: TestPmdShellNicCapability = (
+        TestPmdShell.get_offload_capabilities_func("tx"),
+        None,
+    )
+    PORT_TX_OFFLOAD_SECURITY: TestPmdShellNicCapability = (
+        TestPmdShell.get_offload_capabilities_func("tx"),
+        None,
+    )
+    QUEUE_TX_OFFLOAD_SECURITY: TestPmdShellNicCapability = (
+        TestPmdShell.get_offload_capabilities_func("tx"),
+        None,
+    )
+    PORT_TX_OFFLOAD_UDP_TNL_TSO: TestPmdShellNicCapability = (
+        TestPmdShell.get_offload_capabilities_func("tx"),
+        None,
+    )
+    QUEUE_TX_OFFLOAD_UDP_TNL_TSO: TestPmdShellNicCapability = (
+        TestPmdShell.get_offload_capabilities_func("tx"),
+        None,
+    )
+    PORT_TX_OFFLOAD_IP_TNL_TSO: TestPmdShellNicCapability = (
+        TestPmdShell.get_offload_capabilities_func("tx"),
+        None,
+    )
+    QUEUE_TX_OFFLOAD_IP_TNL_TSO: TestPmdShellNicCapability = (
+        TestPmdShell.get_offload_capabilities_func("tx"),
+        None,
+    )
+    PORT_TX_OFFLOAD_OUTER_UDP_CKSUM: TestPmdShellNicCapability = (
+        TestPmdShell.get_offload_capabilities_func("tx"),
+        None,
+    )
+    QUEUE_TX_OFFLOAD_OUTER_UDP_CKSUM: TestPmdShellNicCapability = (
+        TestPmdShell.get_offload_capabilities_func("tx"),
+        None,
+    )
+    PORT_TX_OFFLOAD_SEND_ON_TIMESTAMP: TestPmdShellNicCapability = (
+        TestPmdShell.get_offload_capabilities_func("tx"),
+        None,
+    )
+    QUEUE_TX_OFFLOAD_SEND_ON_TIMESTAMP: TestPmdShellNicCapability = (
+        TestPmdShell.get_offload_capabilities_func("tx"),
+        None,
+    )
     #: Scattered packets Rx enabled
     SCATTERED_RX_ENABLED: TestPmdShellNicCapability = (
         TestPmdShell.get_capabilities_rxq_info,
         add_remove_mtu(9000),
     )
     #:
-    RX_OFFLOAD_VLAN_STRIP: TestPmdShellNicCapability = (
-        TestPmdShell.get_capabilities_rx_offload,
+    PORT_RX_OFFLOAD_VLAN_STRIP: TestPmdShellNicCapability = (
+        TestPmdShell.get_offload_capabilities_func("rx"),
+        None,
+    )
+    QUEUE_RX_OFFLOAD_VLAN_STRIP: TestPmdShellNicCapability = (
+        TestPmdShell.get_offload_capabilities_func("rx"),
         None,
     )
     #: Device supports L3 checksum offload.
-    RX_OFFLOAD_IPV4_CKSUM: TestPmdShellNicCapability = (
-        TestPmdShell.get_capabilities_rx_offload,
+    PORT_RX_OFFLOAD_IPV4_CKSUM: TestPmdShellNicCapability = (
+        TestPmdShell.get_offload_capabilities_func("rx"),
+        None,
+    )
+    QUEUE_RX_OFFLOAD_IPV4_CKSUM: TestPmdShellNicCapability = (
+        TestPmdShell.get_offload_capabilities_func("rx"),
         None,
     )
     #: Device supports L4 checksum offload.
-    RX_OFFLOAD_UDP_CKSUM: TestPmdShellNicCapability = (
-        TestPmdShell.get_capabilities_rx_offload,
+    PORT_RX_OFFLOAD_UDP_CKSUM: TestPmdShellNicCapability = (
+        TestPmdShell.get_offload_capabilities_func("rx"),
+        None,
+    )
+    QUEUE_RX_OFFLOAD_UDP_CKSUM: TestPmdShellNicCapability = (
+        TestPmdShell.get_offload_capabilities_func("rx"),
         None,
     )
     #: Device supports L4 checksum offload.
-    RX_OFFLOAD_TCP_CKSUM: TestPmdShellNicCapability = (
-        TestPmdShell.get_capabilities_rx_offload,
+    PORT_RX_OFFLOAD_TCP_CKSUM: TestPmdShellNicCapability = (
+        TestPmdShell.get_offload_capabilities_func("rx"),
+        None,
+    )
+    QUEUE_RX_OFFLOAD_TCP_CKSUM: TestPmdShellNicCapability = (
+        TestPmdShell.get_offload_capabilities_func("rx"),
         None,
     )
     #: Device supports Large Receive Offload.
-    RX_OFFLOAD_TCP_LRO: TestPmdShellNicCapability = (TestPmdShell.get_capabilities_rx_offload, None)
+    PORT_RX_OFFLOAD_TCP_LRO: TestPmdShellNicCapability = (
+        TestPmdShell.get_offload_capabilities_func("rx"),
+        None,
+    )
+    QUEUE_RX_OFFLOAD_TCP_LRO: TestPmdShellNicCapability = (
+        TestPmdShell.get_offload_capabilities_func("rx"),
+        None,
+    )
     #: Device supports QinQ (queue in queue) offload.
-    RX_OFFLOAD_QINQ_STRIP: TestPmdShellNicCapability = (
-        TestPmdShell.get_capabilities_rx_offload,
+    PORT_RX_OFFLOAD_QINQ_STRIP: TestPmdShellNicCapability = (
+        TestPmdShell.get_offload_capabilities_func("rx"),
+        None,
+    )
+    QUEUE_RX_OFFLOAD_QINQ_STRIP: TestPmdShellNicCapability = (
+        TestPmdShell.get_offload_capabilities_func("rx"),
         None,
     )
     #: Device supports inner packet L3 checksum.
-    RX_OFFLOAD_OUTER_IPV4_CKSUM: TestPmdShellNicCapability = (
-        TestPmdShell.get_capabilities_rx_offload,
+    PORT_RX_OFFLOAD_OUTER_IPV4_CKSUM: TestPmdShellNicCapability = (
+        TestPmdShell.get_offload_capabilities_func("rx"),
+        None,
+    )
+    QUEUE_RX_OFFLOAD_OUTER_IPV4_CKSUM: TestPmdShellNicCapability = (
+        TestPmdShell.get_offload_capabilities_func("rx"),
         None,
     )
     #: Device supports MACsec.
-    RX_OFFLOAD_MACSEC_STRIP: TestPmdShellNicCapability = (
-        TestPmdShell.get_capabilities_rx_offload,
+    PORT_RX_OFFLOAD_MACSEC_STRIP: TestPmdShellNicCapability = (
+        TestPmdShell.get_offload_capabilities_func("rx"),
+        None,
+    )
+    QUEUE_RX_OFFLOAD_MACSEC_STRIP: TestPmdShellNicCapability = (
+        TestPmdShell.get_offload_capabilities_func("rx"),
         None,
     )
     #: Device supports filtering of a VLAN Tag identifier.
-    RX_OFFLOAD_VLAN_FILTER: TestPmdShellNicCapability = (
-        TestPmdShell.get_capabilities_rx_offload,
+    PORT_RX_OFFLOAD_VLAN_FILTER: TestPmdShellNicCapability = (
+        TestPmdShell.get_offload_capabilities_func("rx"),
+        None,
+    )
+    QUEUE_RX_OFFLOAD_VLAN_FILTER: TestPmdShellNicCapability = (
+        TestPmdShell.get_offload_capabilities_func("rx"),
         None,
     )
     #: Device supports VLAN offload.
-    RX_OFFLOAD_VLAN_EXTEND: TestPmdShellNicCapability = (
-        TestPmdShell.get_capabilities_rx_offload,
+    PORT_RX_OFFLOAD_VLAN_EXTEND: TestPmdShellNicCapability = (
+        TestPmdShell.get_offload_capabilities_func("rx"),
+        None,
+    )
+    QUEUE_RX_OFFLOAD_VLAN_EXTEND: TestPmdShellNicCapability = (
+        TestPmdShell.get_offload_capabilities_func("rx"),
         None,
     )
     #: Device supports receiving segmented mbufs.
-    RX_OFFLOAD_SCATTER: TestPmdShellNicCapability = (TestPmdShell.get_capabilities_rx_offload, None)
+    PORT_RX_OFFLOAD_SCATTER: TestPmdShellNicCapability = (
+        TestPmdShell.get_offload_capabilities_func("rx"),
+        None,
+    )
+    QUEUE_RX_OFFLOAD_SCATTER: TestPmdShellNicCapability = (
+        TestPmdShell.get_offload_capabilities_func("rx"),
+        None,
+    )
     #: Device supports Timestamp.
-    RX_OFFLOAD_TIMESTAMP: TestPmdShellNicCapability = (
-        TestPmdShell.get_capabilities_rx_offload,
+    PORT_RX_OFFLOAD_TIMESTAMP: TestPmdShellNicCapability = (
+        TestPmdShell.get_offload_capabilities_func("rx"),
+        None,
+    )
+    QUEUE_RX_OFFLOAD_TIMESTAMP: TestPmdShellNicCapability = (
+        TestPmdShell.get_offload_capabilities_func("rx"),
         None,
     )
     #: Device supports crypto processing while packet is received in NIC.
-    RX_OFFLOAD_SECURITY: TestPmdShellNicCapability = (
-        TestPmdShell.get_capabilities_rx_offload,
+    PORT_RX_OFFLOAD_SECURITY: TestPmdShellNicCapability = (
+        TestPmdShell.get_offload_capabilities_func("rx"),
+        None,
+    )
+    QUEUE_RX_OFFLOAD_SECURITY: TestPmdShellNicCapability = (
+        TestPmdShell.get_offload_capabilities_func("rx"),
         None,
     )
     #: Device supports CRC stripping.
-    RX_OFFLOAD_KEEP_CRC: TestPmdShellNicCapability = (
-        TestPmdShell.get_capabilities_rx_offload,
+    PORT_RX_OFFLOAD_KEEP_CRC: TestPmdShellNicCapability = (
+        TestPmdShell.get_offload_capabilities_func("rx"),
+        None,
+    )
+    QUEUE_RX_OFFLOAD_KEEP_CRC: TestPmdShellNicCapability = (
+        TestPmdShell.get_offload_capabilities_func("rx"),
         None,
     )
     #: Device supports L4 checksum offload.
-    RX_OFFLOAD_SCTP_CKSUM: TestPmdShellNicCapability = (
-        TestPmdShell.get_capabilities_rx_offload,
+    PORT_RX_OFFLOAD_SCTP_CKSUM: TestPmdShellNicCapability = (
+        TestPmdShell.get_offload_capabilities_func("rx"),
+        None,
+    )
+    QUEUE_RX_OFFLOAD_SCTP_CKSUM: TestPmdShellNicCapability = (
+        TestPmdShell.get_offload_capabilities_func("rx"),
         None,
     )
     #: Device supports inner packet L4 checksum.
-    RX_OFFLOAD_OUTER_UDP_CKSUM: TestPmdShellNicCapability = (
-        TestPmdShell.get_capabilities_rx_offload,
+    PORT_RX_OFFLOAD_OUTER_UDP_CKSUM: TestPmdShellNicCapability = (
+        TestPmdShell.get_offload_capabilities_func("rx"),
+        None,
+    )
+    QUEUE_RX_OFFLOAD_OUTER_UDP_CKSUM: TestPmdShellNicCapability = (
+        TestPmdShell.get_offload_capabilities_func("rx"),
         None,
     )
     #: Device supports RSS hashing.
-    RX_OFFLOAD_RSS_HASH: TestPmdShellNicCapability = (
-        TestPmdShell.get_capabilities_rx_offload,
+    PORT_RX_OFFLOAD_RSS_HASH: TestPmdShellNicCapability = (
+        TestPmdShell.get_offload_capabilities_func("rx"),
+        None,
+    )
+    QUEUE_RX_OFFLOAD_RSS_HASH: TestPmdShellNicCapability = (
+        TestPmdShell.get_offload_capabilities_func("rx"),
         None,
     )
     #: Device supports scatter Rx packets to segmented mbufs.
-    RX_OFFLOAD_BUFFER_SPLIT: TestPmdShellNicCapability = (
-        TestPmdShell.get_capabilities_rx_offload,
+    PORT_RX_OFFLOAD_BUFFER_SPLIT: TestPmdShellNicCapability = (
+        TestPmdShell.get_offload_capabilities_func("rx"),
+        None,
+    )
+    QUEUE_RX_OFFLOAD_BUFFER_SPLIT: TestPmdShellNicCapability = (
+        TestPmdShell.get_offload_capabilities_func("rx"),
         None,
     )
     #: Device supports all checksum capabilities.
-    RX_OFFLOAD_CHECKSUM: TestPmdShellNicCapability = (
-        TestPmdShell.get_capabilities_rx_offload,
+    PORT_RX_OFFLOAD_CHECKSUM: TestPmdShellNicCapability = (
+        TestPmdShell.get_offload_capabilities_func("rx"),
+        None,
+    )
+    QUEUE_RX_OFFLOAD_CHECKSUM: TestPmdShellNicCapability = (
+        TestPmdShell.get_offload_capabilities_func("rx"),
         None,
     )
     #: Device supports all VLAN capabilities.
-    RX_OFFLOAD_VLAN: TestPmdShellNicCapability = (TestPmdShell.get_capabilities_rx_offload, None)
+    PORT_RX_OFFLOAD_VLAN: TestPmdShellNicCapability = (
+        TestPmdShell.get_offload_capabilities_func("rx"),
+        None,
+    )
+    QUEUE_RX_OFFLOAD_VLAN: TestPmdShellNicCapability = (
+        TestPmdShell.get_offload_capabilities_func("rx"),
+        None,
+    )
     #: Device supports Rx queue setup after device started.
     RUNTIME_RX_QUEUE_SETUP: TestPmdShellNicCapability = (
         TestPmdShell.get_capabilities_show_port_info,
diff --git a/dts/tests/TestSuite_checksum_offload.py b/dts/tests/TestSuite_checksum_offload.py
index ff916a4bb7..8e06c6b65f 100644
--- a/dts/tests/TestSuite_checksum_offload.py
+++ b/dts/tests/TestSuite_checksum_offload.py
@@ -30,9 +30,9 @@
 
 
 @requires(topology_type=TopologyType.two_links)
-@requires(NicCapability.RX_OFFLOAD_IPV4_CKSUM)
-@requires(NicCapability.RX_OFFLOAD_UDP_CKSUM)
-@requires(NicCapability.RX_OFFLOAD_TCP_CKSUM)
+@requires(NicCapability.PORT_RX_OFFLOAD_IPV4_CKSUM)
+@requires(NicCapability.PORT_RX_OFFLOAD_UDP_CKSUM)
+@requires(NicCapability.PORT_RX_OFFLOAD_TCP_CKSUM)
 class TestChecksumOffload(TestSuite):
     """Checksum offload test suite.
 
@@ -285,7 +285,7 @@ def validate_rx_checksum(self) -> None:
                     packet=packet_list[i], good_L4=False, good_IP=True, testpmd=testpmd, id=dport_id
                 )
 
-    @requires(NicCapability.RX_OFFLOAD_VLAN)
+    @requires(NicCapability.PORT_RX_OFFLOAD_VLAN)
     @func_test
     def vlan_checksum(self) -> None:
         """Test VLAN Rx checksum hardware offload and verify packet reception.
@@ -342,7 +342,7 @@ def vlan_checksum(self) -> None:
                     packet=packet_list[i], good_L4=False, good_IP=True, testpmd=testpmd, id=dport_id
                 )
 
-    @requires(NicCapability.RX_OFFLOAD_SCTP_CKSUM)
+    @requires(NicCapability.PORT_RX_OFFLOAD_SCTP_CKSUM)
     @func_test
     def validate_sctp_checksum(self) -> None:
         """Test SCTP Rx checksum hardware offload and verify packet reception.
diff --git a/dts/tests/TestSuite_pmd_buffer_scatter.py b/dts/tests/TestSuite_pmd_buffer_scatter.py
index 802777a697..54627157b5 100644
--- a/dts/tests/TestSuite_pmd_buffer_scatter.py
+++ b/dts/tests/TestSuite_pmd_buffer_scatter.py
@@ -29,7 +29,7 @@
 
 
 @requires(NicCapability.PHYSICAL_FUNCTION)
-@requires(NicCapability.RX_OFFLOAD_SCATTER)
+@requires(NicCapability.PORT_RX_OFFLOAD_SCATTER)
 class TestPmdBufferScatter(TestSuite):
     """DPDK PMD packet scattering test suite.
 
@@ -135,7 +135,7 @@ def scatter_mbuf_2048(self) -> None:
         """Run the :meth:`pmd_scatter` test with `mb_size` set to 2048."""
         self.pmd_scatter(mb_size=2048)
 
-    @requires(NicCapability.RX_OFFLOAD_SCATTER)
+    @requires(NicCapability.PORT_RX_OFFLOAD_SCATTER)
     @func_test
     def scatter_mbuf_2048_with_offload(self) -> None:
         """Run the :meth:`pmd_scatter` test with `mb_size` set to 2048 and rx_scatter offload."""
diff --git a/dts/tests/TestSuite_vlan.py b/dts/tests/TestSuite_vlan.py
index ed36a2950d..906ceb0072 100644
--- a/dts/tests/TestSuite_vlan.py
+++ b/dts/tests/TestSuite_vlan.py
@@ -20,7 +20,7 @@
 from framework.testbed_model.capability import NicCapability, TopologyType, requires
 
 
-@requires(NicCapability.RX_OFFLOAD_VLAN_FILTER)
+@requires(NicCapability.PORT_RX_OFFLOAD_VLAN_FILTER)
 @requires(topology_type=TopologyType.two_links)
 class TestVlan(TestSuite):
     """DPDK VLAN test suite.
@@ -129,7 +129,7 @@ def vlan_receipt_no_stripping(self) -> None:
             testpmd.start()
             self.send_vlan_packet_and_verify(True, strip=False, vlan_id=1)
 
-    @requires(NicCapability.RX_OFFLOAD_VLAN_STRIP)
+    @requires(NicCapability.PORT_RX_OFFLOAD_VLAN_STRIP)
     @func_test
     def vlan_receipt_stripping(self) -> None:
         """Ensure VLAN packet received with no tag when receipts and header stripping are enabled.
-- 
2.50.1

