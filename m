Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D6BCA0FFE
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Sep 2025 11:43:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F3E7B40665;
	Tue,  2 Sep 2025 13:43:38 +0200 (CEST)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com
 [209.85.219.49]) by mails.dpdk.org (Postfix) with ESMTP id C35CA402B2
 for <dev@dpdk.org>; Tue,  2 Sep 2025 13:43:37 +0200 (CEST)
Received: by mail-qv1-f49.google.com with SMTP id
 6a1803df08f44-7220d7dea27so403676d6.1
 for <dev@dpdk.org>; Tue, 02 Sep 2025 04:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1756813417; x=1757418217; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XhlPu/xbexPtBIXb4GsyaSubhZVNam9xWRsQBAnMJPQ=;
 b=YUwToHY7nRkbD6FoD0aCZLI9BtLfJL9JPX/VuF4KL9dpn2lBfHhLAInKmX/OG4kBxu
 ftAWgb2+LuhQsBKaml4IQKd9VwKbKYZZn89hqF2hpcBL82tkFzvKjRK8azwSw+KbR46H
 n64g6lqog7SFw+kwPREw2vN1d0OIEltnCOtvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756813417; x=1757418217;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XhlPu/xbexPtBIXb4GsyaSubhZVNam9xWRsQBAnMJPQ=;
 b=eIXjY1I95mdHY+gajLyV5filCgtY7uAyTM2WHme/ZsJJrcwAkCc9IKMzPMmaAtKeKC
 OZGay71xT47ageelRuhRzWUDXxGQSnQB34XjlpZiJIZXZsir108zNRIHe49wMbLuzDzM
 1OvAorLVYjdAWu/rqoZ9Xpiw9Pl4yyNf+RIyIts40bQywwF8vJR8BQib4ZDdcosFGTCq
 pEQDIranpQIvKwG29qRAWC4S5CZzF1M5MIcg6IjlwNunKjj14ppJ/IcR8axoaFooknbv
 PIZKTbSgOl5G3dZwIvJEWLhh/B4VcSA+NvL5If6Sr8+op9M224IC2p2TuVi/N+Aq5km9
 hT7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvXz1yRYONypk0nr4Y2B/VP7OJWiqf5ILqlw4T8tPTGdFpQAsV/VO2M3lnpjH/SsMavzE=@dpdk.org
X-Gm-Message-State: AOJu0Yww5sqUwNfKtKakarNQWGAS7MkCTSXLL696WeT9T0b9g4QKPQZi
 ehqQsL/93b1kIDEJtIgmnwtx2X8pVOOcDcWxaZgkXpZPjan7M/mzm0MIkp3TllhqGrzYGhte4lg
 0hvmz
X-Gm-Gg: ASbGncs5MviwpinvPELf3wlCegXAg5SbO92zwQ2Dr+QlBWcyw8MFRi8AmMMCzsNY6fs
 w5SQcUTOD9a08KXS+Sa1/GzEMjVxIKcBeId1XmqQZf7zhhrbJg/u8LwVpw/fV7dVp5F8dDnugAX
 FHU5wnPIZA1+SSkJsn9LF+qZoJzSuk/vu4OBjVGL3r+yTVcqvKJiHIbecBXXDcZR3MWzPdJN1kN
 FlW2r57ByXa/bFLlDDotyZSXH/ttFYTMWd5bPj+ul53Pjojjqeis17Qe77mcSooZewVfGX6USfc
 Yujk74VF2lswG7RgpWedpRkPKPraqVtcvOJBbgXNYKD6cwqMCEPrvOgDE6IpEb44zDUN1kwFO5C
 SFoQlCOb99useLEC9I05vmxu2Spd5y/Jubik=
X-Google-Smtp-Source: AGHT+IEwkLRn+kTMtmnZny9/BT4MIZ8MvvjGKQVEswLDzkZ/Ze2qMZ86Zzd2/M8uVfhkfYKSYeElPg==
X-Received: by 2002:a05:6214:dc5:b0:714:36b2:a258 with SMTP id
 6a1803df08f44-71436b2ab88mr97527316d6.67.1756813416804; 
 Tue, 02 Sep 2025 04:43:36 -0700 (PDT)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8069d5ba3besm121813185a.64.2025.09.02.04.43.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Sep 2025 04:43:36 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: luca.vizzarro@arm.com
Cc: abailey@iol.unh.edu, dev@dpdk.org, dmarx@iol.unh.edu, probb@iol.unh.edu
Subject: [PATCH v1 3/3] dts: all are one
Date: Tue,  2 Sep 2025 07:43:27 -0400
Message-ID: <20250902114327.48185-4-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250902114327.48185-1-abailey@iol.unh.edu>
References: <20250902114327.48185-1-abailey@iol.unh.edu>
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

---
 dts/framework/remote_session/testpmd_shell.py | 342 +++++++++++++++++-
 dts/tests/TestSuite_rxtx_offload.py           | 153 ++++++++
 2 files changed, 493 insertions(+), 2 deletions(-)
 create mode 100644 dts/tests/TestSuite_rxtx_offload.py

diff --git a/dts/framework/remote_session/testpmd_shell.py b/dts/framework/remote_session/testpmd_shell.py
index ad8cb273dc..2867fbce7a 100644
--- a/dts/framework/remote_session/testpmd_shell.py
+++ b/dts/framework/remote_session/testpmd_shell.py
@@ -19,7 +19,7 @@
 import time
 from collections.abc import Callable, MutableSet
 from dataclasses import dataclass, field
-from enum import Flag, auto
+from enum import Enum, Flag, auto
 from os import environ
 from pathlib import PurePath
 from typing import TYPE_CHECKING, Any, ClassVar, Concatenate, Literal, ParamSpec, Tuple, TypeAlias
@@ -344,6 +344,13 @@ def make_parser(cls) -> ParserFn:
         )
 
 
+class RxTxArgFlag(Enum):
+    """Enum representing recieving or transmitting ports."""
+
+    TX = "tx"
+    RX = "rx"
+
+
 class DeviceCapabilitiesFlag(Flag):
     """Flag representing the device capabilities."""
 
@@ -1278,6 +1285,81 @@ class TestPmdVerbosePacket(TextParser):
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
 class RxOffloadCapability(Flag):
     """Rx offload capabilities of a device.
 
@@ -1376,6 +1458,24 @@ def make_parser(cls, per_port: bool) -> ParserFn:
         )
 
 
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
 @dataclass
 class RxOffloadCapabilities(TextParser):
     """The result of testpmd's ``show port <port_id> rx_offload capabilities`` command.
@@ -2390,6 +2490,28 @@ def close(self) -> None:
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
@@ -2672,6 +2794,134 @@ def get_capabilities_physical_function(
         else:
             unsupported_capabilities.add(NicCapability.PHYSICAL_FUNCTION)
 
+    @requires_started_ports
+    def get_rxtx_offload_config(
+        self,
+        rxtx: RxTxArgFlag,
+        verify: bool,
+        port_id: int = 0,
+        num_queues: int = 0,
+    ) -> dict[int | str, str]:
+        """Get the RX or TX offload configuration of the queues from the given port.
+
+        Args:
+            rxtx: Whether to get the RX or TX configuration of the given queues.
+            verify: If :data:'True' the output of the command will be scanned in an attempt to
+                verify that the offload configuration was retrieved succesfully on all queues.
+            num_queues: The number of queues to get the offload configuration for.
+            port_id: The port ID that contains the desired queues.
+
+        Returns:
+            A dict containing port info at key 'port' and queue info keyed by the appropriate queue
+                id.
+
+        Raises:
+            InteractiveCommandExecutionError: If all queue offlaod configutrations could not be
+                retrieved.
+
+        """
+        returnDict: dict[int | str, str] = {}
+
+        config_output = self.send_command(f"show port {port_id} {rxtx.value}_offload configuration")
+        if verify:
+            if (
+                f"Rx Offloading Configuration of port {port_id}" not in config_output
+                and f"Tx Offloading Configuration of port {port_id}" not in config_output
+            ):
+                self._logger.debug(f"Get port offload config error\n{config_output}")
+                raise InteractiveCommandExecutionError(
+                    f"""Failed to get offload config on port {port_id}:\n{config_output}"""
+                )
+        # Actual ouput data starts on the thrid line
+        tempList: list[str] = config_output.splitlines()[3::]
+        returnDict["port"] = tempList[0]
+        for i in range(0, num_queues):
+            returnDict[i] = tempList[i + 1]
+        return returnDict
+
+    @requires_stopped_ports
+    def set_port_rxtx_mbuf_fast_free(
+        self, rxtx: RxTxArgFlag, on: bool, verify: bool, port_id: int = 0
+    ) -> None:
+        """Sets the mbuf_fast_free configuration for the RX or TX offload for a given port.
+
+        Args:
+            rxtx: Whether to set the mbuf_fast_free on the RX or TX port.
+            on: If :data:'True' mbuf_fast_free will be enabled, disable it otherwise.
+            verify: If :data:'True' the output of the command will be scanned in an attempt to
+                verify that the mbuf_fast_free was set successfully.
+            port_id: The port number to enable or disable mbuf_fast_free on.
+
+        Raises:
+            InteractiveCommandExecutionError: If mbuf_fast_free could not be set successfully
+        """
+        mbuf_output = self.send_command(
+            f"port config {port_id} {rxtx.value}_offload mbuf_fast_free {"on" if on else "off"}"
+        )
+
+        if "error" in mbuf_output and verify:
+            raise InteractiveCommandExecutionError(
+                f"""Unable to set mbuf_fast_free config on port {port_id}:\n{mbuf_output}"""
+            )
+
+    @requires_stopped_ports
+    def set_queue_rxtx_mbuf_fast_free(
+        self,
+        rxtx: RxTxArgFlag,
+        on: bool,
+        verify: bool,
+        port_id: int = 0,
+        queue_id: int = 0,
+    ) -> None:
+        """Sets RX or TX mbuf_fast_free configuration of the specified queue on a given port.
+
+        Args:
+            rxtx: Whether to set mbuf_fast_free for the RX or TX offload configuration on the
+                given queues.
+            on: If :data:'True' the mbuf_fast_free configuration will be enabled, otherwise
+                disabled.
+            verify: If :data:'True' the output of the command will be scanned in an attempt to
+                verify that mbuf_fast_free was set successfully on all ports.
+            queue_id: The queue to disable mbuf_fast_free on.
+            port_id: The ID of the port containing the queues.
+
+        Raises:
+            InteractiveCommandExecutionError: If all queues could not be set successfully.
+        """
+        toggle = "on" if on else "off"
+        output = self.send_command(
+            f"port {port_id} {rxtx.value}q {queue_id} {rxtx.value}_offload mbuf_fast_free {toggle}"
+        )
+        if verify:
+            if "Error" in output:
+                self._logger.debug(f"Set queue offload config error\n{output}")
+                raise InteractiveCommandExecutionError(
+                    f"Failed to get offload config on port {port_id}, queue {queue_id}:\n{output}"
+                )
+
+    def set_all_queues_rxtx_mbuf_fast_free(
+        self,
+        rxtx: RxTxArgFlag,
+        on: bool,
+        verify: bool,
+        port_id=0,
+        num_queues: int = 0,
+    ) -> None:
+        """Sets mbuf_fast_free configuration for the RX or TX offload of all queues on a given port.
+
+        Args:
+            rxtx: Whether to set mbuf_fast_free for the RX or TX offload configuration on the
+                given queues.
+            on: If :data:'True' the mbuf fast_free_configuration will be enabled, otherwise
+                disabled.
+            verify: If :data:'True' the output of the command will be scanned in an attempt to
+                verify that mbuf_fast_free was set successfully on all ports.
+            port_id: The ID of the port containing the queues.
+            num_queues: The queue to disable mbuf_fast_free on.
+        """
+        for i in range(0, num_queues):
+            self.set_queue_rxtx_mbuf_fast_free(rxtx, on, verify, port_id=port_id, queue_id=i)
+
 
 class NicCapability(NoAliasEnum):
     """A mapping between capability names and the associated :class:`TestPmdShell` methods.
@@ -2698,7 +2948,95 @@ class NicCapability(NoAliasEnum):
     we don't go looking for it again if a different test case also needs it.
     """
 
-    #: Scattered packets Rx enabled
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
+    # : Scattered packets Rx enabled
     SCATTERED_RX_ENABLED: TestPmdShellNicCapability = (
         TestPmdShell.get_capabilities_rxq_info,
         add_remove_mtu(9000),
diff --git a/dts/tests/TestSuite_rxtx_offload.py b/dts/tests/TestSuite_rxtx_offload.py
new file mode 100644
index 0000000000..90ba58bb25
--- /dev/null
+++ b/dts/tests/TestSuite_rxtx_offload.py
@@ -0,0 +1,153 @@
+# Copyright(c) 2025 University of New Hampshire
+
+"""RX TX offload test suite.
+
+Test the testpmd feature of configuring RX and TX offloads
+"""
+
+from time import sleep
+from framework.remote_session.testpmd_shell import (
+    RxTxArgFlag,
+    TestPmdShell,
+)
+from framework.test_suite import TestSuite, func_test
+from framework.testbed_model.capability import requires, NicCapability
+
+
+@requires(NicCapability.TX_OFFLOAD_MACSEC_INSERT)
+class TestRxTxOffload(TestSuite):
+    """RX/TX offload test suite."""
+
+    def check_port_config(
+        self,
+        testpmd: TestPmdShell,
+        offload: str,
+        rxtx: RxTxArgFlag,
+        verify: bool,
+        port_id: int = 0,
+    ) -> bool:
+        """Checks that the current port configuration matches the given offload.
+
+        Args:
+            testpmd: The currrent testpmd shell session to send commands to.
+            offload: The expected configuration of the given port.
+            rxtx: Wether to check the RX or TX configuration of the given port.
+            verify: Wether to verify the result of call to testpmd.
+            port_id: Id of the port to check.
+
+        Returns:
+            Whether current configuration matches given offload.
+        """
+        output = testpmd.get_rxtx_offload_config(rxtx, verify, port_id, 0)
+        return offload in output["port"] or (
+            offload == "NULL" and "MBUF_FAST_FREE" not in output["port"]
+        )
+
+    def check_queue_config(
+        self,
+        testpmd: TestPmdShell,
+        offload: list[str],
+        rxtx: RxTxArgFlag,
+        verify: bool,
+        port_id: int = 0,
+        num_queues: int = 0,
+    ) -> bool:
+        """Checks that the queue configuration matches the given offlad.
+
+        Args:
+            testpmd: The currrent testpmd shell session to send commands to.
+            offload: The expected configuration of the queues, each index corresponds
+                to the queue id.
+            rxtx: Whether to check the RX or TX configuration of the given queues.
+            verify: Whether to verify commands sent to testpmd.
+            port_id: The port of which the queues reside.
+            num_queues: The number of queues to check.
+
+        Returns:
+            Whether current configuration matches given offload
+        """
+        output = testpmd.get_rxtx_offload_config(rxtx, verify, port_id, num_queues)
+        for i in range(0, num_queues):
+            if not (
+                offload[i] in output[i]
+                or (offload[i] == "NULL" and "MBUF_FAST_FREE" not in output[i])
+            ):
+                return False
+        return True
+
+    @func_test
+    def test_mbuf_fast_free_configurations(self) -> None:
+        """Ensure mbuf_fast_free can be configured with testpmd.
+
+        Steps:
+            Start up testpmd shell.
+            Toggle mbuf_fast_free on.
+            Toggle mbuf_fast_free off.
+
+        Verify:
+            Mbuf_fast_free starts disabled.
+            Mbuf_fast_free can be configured on.
+            Mbuf_fast_free can be configured off.
+        """
+        with TestPmdShell() as testpmd:
+            verify: bool = True
+            port_id: int = 0
+            num_queues: int = 4
+            queue_off: list[str] = []
+            queue_on: list[str] = []
+            mbuf_on = "MBUF_FAST_FREE"
+            mbuf_off = "NULL"
+            tx = RxTxArgFlag.TX
+
+            for _ in range(0, num_queues):
+                queue_off.append(mbuf_off)
+                queue_on.append(mbuf_on)
+
+            testpmd.set_ports_queues(num_queues)
+            testpmd.start_all_ports()
+
+            # Ensure mbuf_fast_free is disabled by default on port and queues
+            self.verify(
+                self.check_port_config(testpmd, mbuf_off, tx, verify, port_id),
+                "Mbuf_fast_free enabled on port start",
+            )
+            self.verify(
+                self.check_queue_config(testpmd, queue_off, tx, verify, port_id, num_queues),
+                "Mbuf_fast_free enabled on queue start",
+            )
+
+            # Enable mbuf_fast_free per queue and verify
+            testpmd.set_all_queues_rxtx_mbuf_fast_free(tx, True, verify, port_id, num_queues)
+            self.verify(
+                self.check_port_config(testpmd, mbuf_off, tx, verify, port_id),
+                "Port configuration changed without call",
+            )
+            self.verify(
+                self.check_queue_config(testpmd, queue_on, tx, verify, port_id, num_queues),
+                "Queues failed to enable mbuf_fast_free",
+            )
+
+            # Enable mbuf_fast_free per port and verify
+            testpmd.set_port_rxtx_mbuf_fast_free(tx, True, verify, port_id)
+            self.verify(
+                self.check_port_config(testpmd, mbuf_on, tx, verify, port_id),
+                "Port failed to enable mbuf_fast_free",
+            )
+
+            # Disable mbuf_fast_free per queue and verify
+            testpmd.set_all_queues_rxtx_mbuf_fast_free(tx, False, verify, port_id, num_queues)
+            self.verify(
+                self.check_port_config(testpmd, mbuf_on, tx, verify, port_id),
+                "Port configuration changed without call",
+            )
+            self.verify(
+                self.check_queue_config(testpmd, queue_off, tx, verify, port_id, num_queues),
+                "Queues failed to disable mbuf_fast_free",
+            )
+
+            # Disable mbuf_fast_free per port and verify
+            testpmd.set_port_rxtx_mbuf_fast_free(tx, False, verify, port_id)
+            self.verify(
+                self.check_port_config(testpmd, mbuf_off, tx, verify, port_id),
+                "Port failed to disable mbuf_fast_free",
+            )
-- 
2.50.1

