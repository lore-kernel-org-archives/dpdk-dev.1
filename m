Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09FFAFDEE2B
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Apr 2026 17:04:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3FA0D40685;
	Thu, 23 Apr 2026 19:03:45 +0200 (CEST)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com
 [209.85.222.174])
 by mails.dpdk.org (Postfix) with ESMTP id 53F1740612
 for <dev@dpdk.org>; Thu, 23 Apr 2026 19:03:41 +0200 (CEST)
Received: by mail-qk1-f174.google.com with SMTP id
 af79cd13be357-8f231f3b130so6227685a.3
 for <dev@dpdk.org>; Thu, 23 Apr 2026 10:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1776963821; x=1777568621; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JJkKYZBdHd6XWv9tRpo/+Ix6WF2z7lQ45tdNJVgri/Y=;
 b=bkiGIvixTU5DGXJxnB2CBo0xCuFjM1gwVPhXoj5cs9Vnnb9R/q5MZl6QdazjfAaRBQ
 o5yHUwhFJrYC+8obx9tAE/Shx0BBSfw1gX2mDZAEsMENn1ZrKJC/B9UVcPePX8cQtHXS
 cJu0FaBcFKTrjQF72jLZgzADGkbYMQzQK6cmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776963821; x=1777568621;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JJkKYZBdHd6XWv9tRpo/+Ix6WF2z7lQ45tdNJVgri/Y=;
 b=FYK1b0j9j68V0NDkhIz7sqj/a5hdFhZH8EhTmMssZacrTsnyHrYMstKNIr9KPXtFUD
 Z7RE/OSp/ImFdTTxZDpa6Aj3DIxP3Z7lBX/e1vga4DYF3mhiRKBX7411Nwj+DBe6zVh/
 O+KJMTJaLIcLJExAFPnb6mjYtN9r9o26fEfjAQtAOLgXu8VYv/XpVEyLvTz9hl6fUhKD
 445rPZFaGyHsp2gDdLor0jguT7/zdz3YizEed1fF7vsuUSOI6XJfZZ7zpzTXYScm/2Fh
 7aRRtsb2iqLRzQBWBUhZcy61d+YbQzwVUjCi6mJfNFX+LbwJFoMN/nku56OsDUC6HF3l
 Uuyw==
X-Gm-Message-State: AOJu0YxNTmcb7S4dSTZu0+MydtFtGxidHIl2B7BVfQ36ddTlxYMffb9o
 mAEce4+aMP+n1/DZn4pmpYoXPGXi9mkzndq/+ZFjxB3nkfsybXK14wvUbwlOhBYbB9E=
X-Gm-Gg: AeBDievaxKKm5hZ8UQ6l+frEetcALx94yozRpk+wL5AhyV+pIvIqqPGzX3zmCLIWalc
 m7r7tzwIw8ykAv67XQWcdlguEoUT82Pg1b87XlxMW/BB1oNnnTBMVPwn7XToz7woY0cwMTE/XqE
 EPYtXthodB/MlEhY0/1XVW9YtC1sHGzrSsHMnz3oJQRX4lfAgJVp4mSxiblW6MKqX5SeTrs1n5h
 YCpKok9+RTNdzQYm4ZENC2BMlR8MMatGoRlcVjb+yWyouzsBnyVSrJREZal26CXyk9gqDluQU/T
 bpcU6nYB+CeTFdUxSQGaiOAzIPdTHk8ZgNHIzlbpfgYHj+daSTf5wRZ8JuZRibjlAs1wSrndRlQ
 WnOIzETH1lbFCDXiBR2YB+Ope5zajzchZDYNW0tIRMh/dG80m/xHUIluouqvy//OQW2NM1XDnsg
 TvOVSa4lGq1PfXEvkb9Xwyt/HYtby8GncZPWyKg4hetTonK5B2fhXy1Y0UTSLb4NHPCrvOt6kE
X-Received: by 2002:a05:620a:4513:b0:8d6:bd01:a684 with SMTP id
 af79cd13be357-8e78f72f075mr3984649185a.7.1776963820408; 
 Thu, 23 Apr 2026 10:03:40 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:ac5d:4186:4dc6:47eb])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8e7d8edb734sm1869831585a.29.2026.04.23.10.03.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 10:03:39 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: patrickrobb1997@gmail.com, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v1 6/8] dts: move params directory from framework to API
Date: Thu, 23 Apr 2026 13:03:18 -0400
Message-ID: <20260423170331.33193-7-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260423170331.33193-1-dmarx@iol.unh.edu>
References: <20240925192013.17446-1-jspewock@iol.unh.edu>
 <20260423170331.33193-1-dmarx@iol.unh.edu>
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

The params directory is imported in test suites such as
packet capture to use as a base class for dumpcap.
Move this to the API.

Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
---
 dts/api/cryptodev/__init__.py                     | 4 ++--
 dts/api/cryptodev/config.py                       | 4 ++--
 dts/api/packet.py                                 | 4 ++--
 dts/{framework => api}/params/__init__.py         | 0
 dts/{framework => api}/params/eal.py              | 2 +-
 dts/{framework => api}/params/types.py            | 2 +-
 dts/api/test.py                                   | 2 +-
 dts/api/testpmd/__init__.py                       | 4 ++--
 dts/api/testpmd/config.py                         | 6 +++---
 dts/framework/remote_session/blocking_app.py      | 6 +++---
 dts/framework/remote_session/dpdk.py              | 4 ++--
 dts/framework/remote_session/dpdk_shell.py        | 4 ++--
 dts/framework/remote_session/interactive_shell.py | 4 ++--
 dts/framework/test_run.py                         | 2 +-
 dts/tests/TestSuite_cryptodev_throughput.py       | 2 +-
 dts/tests/TestSuite_l2fwd.py                      | 2 +-
 dts/tests/TestSuite_packet_capture.py             | 2 +-
 dts/tests/TestSuite_single_core_forward_perf.py   | 2 +-
 18 files changed, 28 insertions(+), 28 deletions(-)
 rename dts/{framework => api}/params/__init__.py (100%)
 rename dts/{framework => api}/params/eal.py (97%)
 rename dts/{framework => api}/params/types.py (99%)

diff --git a/dts/api/cryptodev/__init__.py b/dts/api/cryptodev/__init__.py
index 67dcb02130..bbfe3622c2 100644
--- a/dts/api/cryptodev/__init__.py
+++ b/dts/api/cryptodev/__init__.py
@@ -14,6 +14,7 @@
 
 from typing_extensions import Unpack
 
+from api.context import get_ctx
 from api.cryptodev.config import CryptoPmdParams, TestType
 from api.cryptodev.types import (
     CryptodevResults,
@@ -23,11 +24,10 @@
     VerifyResults,
 )
 from api.exception import RemoteCommandExecutionError, SkippedTestException
-from api.context import get_ctx
 from framework.remote_session.dpdk_shell import compute_eal_params
 
 if TYPE_CHECKING:
-    from framework.params.types import CryptoPmdParamsDict
+    from api.params.types import CryptoPmdParamsDict
 from pathlib import PurePath
 
 
diff --git a/dts/api/cryptodev/config.py b/dts/api/cryptodev/config.py
index a88e70d45c..3420c2fe91 100644
--- a/dts/api/cryptodev/config.py
+++ b/dts/api/cryptodev/config.py
@@ -6,9 +6,9 @@
 from enum import auto
 from typing import Literal
 
+from api.params import Params, Switch
+from api.params.eal import EalParams
 from api.utils import StrEnum
-from framework.params import Params, Switch
-from framework.params.eal import EalParams
 
 Silent = Literal[""]
 
diff --git a/dts/api/packet.py b/dts/api/packet.py
index 393fee542b..873b8f0324 100644
--- a/dts/api/packet.py
+++ b/dts/api/packet.py
@@ -27,6 +27,7 @@
 from scapy.layers.l2 import Ether
 from scapy.packet import Packet, Padding, raw
 
+from api.context import get_ctx
 from api.exception import InternalError
 from api.test import fail, log_debug
 from api.testbed_model.traffic_generator.capturing_traffic_generator import (
@@ -36,7 +37,6 @@
     PerformanceTrafficStats,
 )
 from api.utils import get_packet_summaries
-from api.context import get_ctx
 
 
 def send_packet_and_capture(
@@ -82,10 +82,10 @@ def send_packets_and_capture(
     Returns:
         A list of received packets.
     """
+    from api.context import get_ctx
     from api.testbed_model.traffic_generator.capturing_traffic_generator import (
         CapturingTrafficGenerator,
     )
-    from api.context import get_ctx
 
     assert isinstance(
         get_ctx().func_tg, CapturingTrafficGenerator
diff --git a/dts/framework/params/__init__.py b/dts/api/params/__init__.py
similarity index 100%
rename from dts/framework/params/__init__.py
rename to dts/api/params/__init__.py
diff --git a/dts/framework/params/eal.py b/dts/api/params/eal.py
similarity index 97%
rename from dts/framework/params/eal.py
rename to dts/api/params/eal.py
index 86bfd3fcc6..64fa45ae12 100644
--- a/dts/framework/params/eal.py
+++ b/dts/api/params/eal.py
@@ -6,9 +6,9 @@
 from dataclasses import dataclass, field
 from typing import TYPE_CHECKING, Literal
 
+from api.params import Params, Switch
 from api.testbed_model.cpu import LogicalCoreList
 from api.testbed_model.virtual_device import VirtualDevice
-from framework.params import Params, Switch
 
 if TYPE_CHECKING:
     from api.testbed_model.port import Port
diff --git a/dts/framework/params/types.py b/dts/api/params/types.py
similarity index 99%
rename from dts/framework/params/types.py
rename to dts/api/params/types.py
index f2fa69f8b8..55a0e546c1 100644
--- a/dts/framework/params/types.py
+++ b/dts/api/params/types.py
@@ -32,6 +32,7 @@ def create_testpmd(**kwargs: Unpack[TestPmdParamsDict]):
     TestType,
     TLSVersion,
 )
+from api.params import Switch, YesNoSwitch
 from api.testbed_model.cpu import LogicalCoreList
 from api.testbed_model.port import Port
 from api.testbed_model.virtual_device import VirtualDevice
@@ -56,7 +57,6 @@ def create_testpmd(**kwargs: Unpack[TestPmdParamsDict]):
     TXRingParams,
     TxUDPPortPair,
 )
-from framework.params import Switch, YesNoSwitch
 
 
 class EalParamsDict(TypedDict, total=False):
diff --git a/dts/api/test.py b/dts/api/test.py
index a1f2326075..03846639ad 100644
--- a/dts/api/test.py
+++ b/dts/api/test.py
@@ -10,8 +10,8 @@
 from datetime import datetime
 
 from api.artifact import Artifact
-from api.exception import InternalError, SkippedTestException, TestCaseVerifyError
 from api.context import get_ctx
+from api.exception import InternalError, SkippedTestException, TestCaseVerifyError
 from framework.logger import DTSLogger
 
 
diff --git a/dts/api/testpmd/__init__.py b/dts/api/testpmd/__init__.py
index a528663c21..e9cd822bac 100644
--- a/dts/api/testpmd/__init__.py
+++ b/dts/api/testpmd/__init__.py
@@ -32,7 +32,9 @@
 from typing_extensions import Unpack
 
 from api.capabilities import LinkTopology, NicCapability
+from api.context import get_ctx
 from api.exception import InteractiveCommandExecutionError, InternalError
+from api.params.types import TestPmdParamsDict
 from api.testpmd.config import PortTopology, SimpleForwardingModes, TestPmdParams
 from api.testpmd.types import (
     ChecksumOffloadOptions,
@@ -55,8 +57,6 @@
     TxOffloadConfiguration,
     VLANOffloadFlag,
 )
-from api.context import get_ctx
-from framework.params.types import TestPmdParamsDict
 from framework.remote_session.dpdk_shell import DPDKShell
 from framework.remote_session.interactive_shell import only_active
 from framework.settings import SETTINGS
diff --git a/dts/api/testpmd/config.py b/dts/api/testpmd/config.py
index 8b688834ee..96fe5e79fb 100644
--- a/dts/api/testpmd/config.py
+++ b/dts/api/testpmd/config.py
@@ -13,8 +13,7 @@
 from pathlib import PurePath
 from typing import Literal, NamedTuple
 
-from api.utils import StrEnum
-from framework.params import (
+from api.params import (
     Params,
     Switch,
     YesNoSwitch,
@@ -24,7 +23,8 @@
     modify_str,
     str_from_flag_value,
 )
-from framework.params.eal import EalParams
+from api.params.eal import EalParams
+from api.utils import StrEnum
 
 
 class PortTopology(StrEnum):
diff --git a/dts/framework/remote_session/blocking_app.py b/dts/framework/remote_session/blocking_app.py
index 955a7ccdba..537d937eca 100644
--- a/dts/framework/remote_session/blocking_app.py
+++ b/dts/framework/remote_session/blocking_app.py
@@ -30,10 +30,10 @@
 
 from typing_extensions import Self
 
-from api.testbed_model.node import Node
 from api.context import get_ctx
-from framework.params import Params
-from framework.params.eal import EalParams
+from api.params import Params
+from api.params.eal import EalParams
+from api.testbed_model.node import Node
 from framework.remote_session.dpdk_shell import compute_eal_params
 from framework.remote_session.interactive_shell import InteractiveShell
 
diff --git a/dts/framework/remote_session/dpdk.py b/dts/framework/remote_session/dpdk.py
index 68897bfefe..afdf7526d9 100644
--- a/dts/framework/remote_session/dpdk.py
+++ b/dts/framework/remote_session/dpdk.py
@@ -13,7 +13,9 @@
 from pathlib import Path, PurePath
 from typing import ClassVar, Final
 
+from api.context import get_ctx
 from api.exception import ConfigurationError, RemoteFileNotFoundError
+from api.params.eal import EalParams
 from api.testbed_model.cpu import LogicalCore, LogicalCoreCount, LogicalCoreList, lcore_filter
 from api.testbed_model.node import Node
 from api.testbed_model.os_session import OSSession
@@ -30,9 +32,7 @@
     RemoteDPDKTarballLocation,
     RemoteDPDKTreeLocation,
 )
-from api.context import get_ctx
 from framework.logger import DTSLogger, get_dts_logger
-from framework.params.eal import EalParams
 from framework.remote_session.remote_session import CommandResult
 
 
diff --git a/dts/framework/remote_session/dpdk_shell.py b/dts/framework/remote_session/dpdk_shell.py
index 947f60f75c..61cc4687f3 100644
--- a/dts/framework/remote_session/dpdk_shell.py
+++ b/dts/framework/remote_session/dpdk_shell.py
@@ -10,9 +10,9 @@
 from abc import ABC, abstractmethod
 from pathlib import PurePath
 
-from api.testbed_model.cpu import LogicalCoreList
 from api.context import get_ctx
-from framework.params.eal import EalParams
+from api.params.eal import EalParams
+from api.testbed_model.cpu import LogicalCoreList
 from framework.remote_session.interactive_shell import (
     InteractiveShell,
     only_active,
diff --git a/dts/framework/remote_session/interactive_shell.py b/dts/framework/remote_session/interactive_shell.py
index 6aebef3f45..f7f0669eea 100644
--- a/dts/framework/remote_session/interactive_shell.py
+++ b/dts/framework/remote_session/interactive_shell.py
@@ -29,15 +29,15 @@
 from paramiko import Channel, channel
 from typing_extensions import Self
 
+from api.context import get_ctx
 from api.exception import (
     InteractiveCommandExecutionError,
     InteractiveSSHSessionDeadError,
     InteractiveSSHTimeoutError,
 )
+from api.params import Params
 from api.testbed_model.node import Node
-from api.context import get_ctx
 from framework.logger import DTSLogger, get_dts_logger
-from framework.params import Params
 from framework.settings import SETTINGS
 
 P = ParamSpec("P")
diff --git a/dts/framework/test_run.py b/dts/framework/test_run.py
index 914bf9491d..c133fbecb0 100644
--- a/dts/framework/test_run.py
+++ b/dts/framework/test_run.py
@@ -106,6 +106,7 @@
 from types import MethodType
 from typing import ClassVar, Protocol, Union
 
+from api.context import Context, init_ctx
 from api.exception import InternalError, SkippedTestException, TestCaseVerifyError
 from api.test_suite import BaseConfig, TestCase, TestCaseType, TestSuite
 from api.testbed_model.capability import (
@@ -117,7 +118,6 @@
 from api.testbed_model.topology import PortLink, Topology
 from api.testbed_model.traffic_generator import create_traffic_generator
 from framework.config.test_run import TestRunConfiguration
-from api.context import Context, init_ctx
 from framework.logger import DTSLogger, get_dts_logger
 from framework.remote_session.dpdk import DPDKBuildEnvironment, DPDKRuntimeEnvironment
 from framework.settings import SETTINGS
diff --git a/dts/tests/TestSuite_cryptodev_throughput.py b/dts/tests/TestSuite_cryptodev_throughput.py
index 67ebbc64c2..d2a6cbab94 100644
--- a/dts/tests/TestSuite_cryptodev_throughput.py
+++ b/dts/tests/TestSuite_cryptodev_throughput.py
@@ -13,6 +13,7 @@
     LinkTopology,
     requires_link_topology,
 )
+from api.context import get_ctx
 from api.cryptodev import Cryptodev
 from api.cryptodev.config import (
     AeadAlgName,
@@ -33,7 +34,6 @@
 from api.test import verify
 from api.test_suite import BaseConfig, TestSuite, crypto_test
 from api.testbed_model.virtual_device import VirtualDevice
-from api.context import get_ctx
 
 config_list: list[dict[str, int | float | str]] = [
     {"buff_size": 64, "Gbps": 1.00},
diff --git a/dts/tests/TestSuite_l2fwd.py b/dts/tests/TestSuite_l2fwd.py
index f4833340a6..f237821a04 100644
--- a/dts/tests/TestSuite_l2fwd.py
+++ b/dts/tests/TestSuite_l2fwd.py
@@ -13,6 +13,7 @@
     requires_link_topology,
     requires_nic_capability,
 )
+from api.context import filter_cores
 from api.packet import (
     get_expected_packets,
     match_all_packets,
@@ -23,7 +24,6 @@
 from api.testpmd import TestPmd
 from api.testpmd.config import EthPeer, SimpleForwardingModes
 from api.utils import generate_random_packets
-from api.context import filter_cores
 
 
 @requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
diff --git a/dts/tests/TestSuite_packet_capture.py b/dts/tests/TestSuite_packet_capture.py
index fd5cef5268..ba67c9e1c6 100644
--- a/dts/tests/TestSuite_packet_capture.py
+++ b/dts/tests/TestSuite_packet_capture.py
@@ -35,6 +35,7 @@
     match_all_packets,
     send_packets_and_capture,
 )
+from api.params import Params
 from api.test import verify
 from api.test_suite import TestSuite, func_test
 from api.testbed_model.cpu import LogicalCoreList
@@ -42,7 +43,6 @@
     PacketFilteringConfig,
 )
 from api.testpmd import TestPmd
-from framework.params import Params
 from framework.remote_session.blocking_app import BlockingApp
 from framework.remote_session.dpdk_shell import compute_eal_params
 
diff --git a/dts/tests/TestSuite_single_core_forward_perf.py b/dts/tests/TestSuite_single_core_forward_perf.py
index f1eb435759..24f2cebf17 100644
--- a/dts/tests/TestSuite_single_core_forward_perf.py
+++ b/dts/tests/TestSuite_single_core_forward_perf.py
@@ -21,11 +21,11 @@
     requires_link_topology,
 )
 from api.packet import assess_performance_by_packet
+from api.params.types import TestPmdParamsDict
 from api.test import verify, write_performance_json
 from api.test_suite import BaseConfig, TestSuite, perf_test
 from api.testpmd import TestPmd
 from api.testpmd.config import RXRingParams, TXRingParams
-from framework.params.types import TestPmdParamsDict
 
 
 class Config(BaseConfig):
-- 
2.52.0

