Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F037BC5AC7C
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 17:51:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 56ADB402EE;
	Thu,  6 Aug 2026 19:51:02 +0200 (CEST)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com
 [209.85.222.181])
 by mails.dpdk.org (Postfix) with ESMTP id 42531402D0
 for <dev@dpdk.org>; Thu,  6 Aug 2026 19:51:01 +0200 (CEST)
Received: by mail-qk1-f181.google.com with SMTP id
 af79cd13be357-930f72317a6so147594985a.3
 for <dev@dpdk.org>; Thu, 06 Aug 2026 10:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1786038660; x=1786643460; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Uip/sPYAR/Z3+LhoEcjG3ajVdrulA2X/OszkD4RTmNU=;
 b=TwDben5oQJ7su8WtnDL+e5W4bbknUw5StG2IINcO6Mg52v8RMlSsXHyGlz/Y4ShqER
 9wd7nnklYB15x43so2oFL0zWMUrXQM/SzJ9AbDigSSHAf47vk0ACL0jiZWDZLkU6V8UY
 w5CsmDYTZ/FNLtKPzCqrCW0ik3yzGAr9yPleE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786038660; x=1786643460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Uip/sPYAR/Z3+LhoEcjG3ajVdrulA2X/OszkD4RTmNU=;
 b=lAb/7LOHEqRjFd2hIQj6AOXIknHHfqLK6izhYrq6sebu2/Qa5rKoolb8XlXFlUm6I/
 bYxLThwuYzwoWOw0eK+M+Pt5O4ZUTQ07NKXX4sugRfc2UXb8U8ZJnpptm7Tt+lK+pbQ0
 a519+Oyv54ThckgTlvMebuOoBzuKZz36dn/yGdE23Q1EbjOly1RaRpxwqHFcockhFiuB
 OZ0J0O+3eYoC/EhCItHkJs4l25fqLAMX3EjGm3Qvfrtx1x5ELlhwSNXFtVuJlHu5TWF/
 1nWHvBHRTvRF0rmVNaeAPIVhIPRhfuo4CNbjAd9Pt2hcI2gp3xEIfu3njozogbcYaT4S
 BlDg==
X-Gm-Message-State: AOJu0YyRWZjqSyJgBvDV8bYI1yZpyF/msqCpaBVs62qI8tOzetA2Pek7
 oPCzs+7vN8mgkTMFBbFAz48JDJQO1JMQzCvO1APfjRaUaht5L8sK7SDazTkWKJWBBLSReSk6SWT
 pKOwTl18QkpopDBs8egEugXgqiwEoPkgVSwLhBRQu+j1D29NnstazIb211AWhirMm8omVSYoGj7
 0P44HsdkJNQ8t6dR7yIYhd72QDr3A=
X-Gm-Gg: AR+sD13zlFmHF1XFuOKbT4bQRM55jDdrb/AaDUQC+0lwTNVnLCKDzSUZisKxnXFRC80
 fEaUImrOAP6sFpk8NtuyYZ49BZ9UX2F4SOL9mCt72HBvZ7kXlcYRHE51NaAxnhtQLm52G5aexdU
 TwX3N18JQoF40JMtjptIBprL+R0ZReoeYXV+x52Gq1K+uYLkIp0wQbcEwaNs3M5ClWhnUSmwiFh
 rxa+Q2ma4nS8oJkK+BlyZMjkdw25D25hYbUYaz0gOflAdn61VVuD7aAfqx6MQX61dOCHfVhSyF9
 /K63e2gyIX7/QtTxopRYsQZs1GJqQyoaDf7i/f/gABpVp9KJGqYCBWCBG7ecESuVBt5k9EF6Hpp
 p3dRax6R2kDjcksMG2ddsNVcATJOA0bG6pHMP2P2Ld2OWWcV6Wdb3Ji3DGXJNdjQNUiH6AUnrqw
 2E1qFSfxiicdSf6Dxtcq4QLcTea91IGa1VdpsMvKRnaXkWnyZcL2K/IihThvKiWkYejowkvqmRd
 N7N58z5S5ZyDEE0GkdCvNdcJcOqeo4aNLrg5UDy
X-Received: by 2002:a05:620a:a010:b0:915:75ba:1797 with SMTP id
 af79cd13be357-9364921bc56mr1564250985a.29.1786038660318; 
 Thu, 06 Aug 2026 10:51:00 -0700 (PDT)
Received: from syn-2603-7083-bff0-a0d0-0000-0000-0000-1a64.res6.spectrum.com
 ([2606:4100:3880:1257::1039]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93657688090sm317311285a.27.2026.08.06.10.50.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 10:50:59 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: dev@dpdk.org,
	luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: knimoji@iol.unh.edu, lylavoie@iol.unh.edu, dladd@iol.unh.edu,
 Andrew Bailey <abailey@iol.unh.edu>, Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v6 2/7] dts: move utils from framework to API
Date: Thu,  6 Aug 2026 13:50:19 -0400
Message-ID: <20260806175024.13655-3-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260806175024.13655-1-abailey@iol.unh.edu>
References: <20260806135346.568766-1-abailey@iol.unh.edu>
 <20260806175024.13655-1-abailey@iol.unh.edu>
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

The utils module is used to generate a set of random
packets in certain test suites. Move this to the API.

Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
---
 doc/api/dts/{framework.utils.rst => api.utils.rst}            | 2 +-
 doc/api/dts/index.rst                                         | 2 +-
 dts/api/cryptodev/config.py                                   | 2 +-
 dts/api/packet.py                                             | 2 +-
 dts/api/testpmd/config.py                                     | 2 +-
 dts/api/testpmd/types.py                                      | 2 +-
 dts/{framework => api}/utils.py                               | 0
 dts/framework/config/node.py                                  | 2 +-
 dts/framework/config/test_run.py                              | 2 +-
 dts/framework/remote_session/dpdk.py                          | 2 +-
 dts/framework/test_suite.py                                   | 2 +-
 dts/framework/testbed_model/cpu.py                            | 2 +-
 dts/framework/testbed_model/linux_session.py                  | 2 +-
 dts/framework/testbed_model/os_session.py                     | 2 +-
 dts/framework/testbed_model/posix_session.py                  | 4 ++--
 .../traffic_generator/capturing_traffic_generator.py          | 2 +-
 .../testbed_model/traffic_generator/traffic_generator.py      | 2 +-
 dts/framework/testbed_model/traffic_generator/trex.py         | 2 +-
 dts/tests/TestSuite_l2fwd.py                                  | 2 +-
 dts/tests/TestSuite_rss.py                                    | 2 +-
 dts/tests/TestSuite_smoke_tests.py                            | 2 +-
 dts/tests/TestSuite_softnic.py                                | 2 +-
 22 files changed, 22 insertions(+), 22 deletions(-)
 rename doc/api/dts/{framework.utils.rst => api.utils.rst} (80%)
 rename dts/{framework => api}/utils.py (100%)

diff --git a/doc/api/dts/framework.utils.rst b/doc/api/dts/api.utils.rst
similarity index 80%
rename from doc/api/dts/framework.utils.rst
rename to doc/api/dts/api.utils.rst
index cc06d4c3c3..0b4baff1b5 100644
--- a/doc/api/dts/framework.utils.rst
+++ b/doc/api/dts/api.utils.rst
@@ -3,6 +3,6 @@
 utils - Various Utilities
 =========================
 
-.. automodule:: framework.utils
+.. automodule:: api.utils
    :members:
    :show-inheritance:
diff --git a/doc/api/dts/index.rst b/doc/api/dts/index.rst
index 01f630e7cd..783270f6e9 100644
--- a/doc/api/dts/index.rst
+++ b/doc/api/dts/index.rst
@@ -35,7 +35,7 @@ Modules
    framework.context
    framework.logger
    framework.parser
-   framework.utils
+   api.utils
    api.exception
 
 
diff --git a/dts/api/cryptodev/config.py b/dts/api/cryptodev/config.py
index 69ff7aa59a..a88e70d45c 100644
--- a/dts/api/cryptodev/config.py
+++ b/dts/api/cryptodev/config.py
@@ -6,9 +6,9 @@
 from enum import auto
 from typing import Literal
 
+from api.utils import StrEnum
 from framework.params import Params, Switch
 from framework.params.eal import EalParams
-from framework.utils import StrEnum
 
 Silent = Literal[""]
 
diff --git a/dts/api/packet.py b/dts/api/packet.py
index eaecf205f7..98f995deb5 100644
--- a/dts/api/packet.py
+++ b/dts/api/packet.py
@@ -29,6 +29,7 @@
 
 from api.exception import InternalError
 from api.test import fail, log_debug
+from api.utils import get_packet_summaries
 from framework.context import get_ctx
 from framework.testbed_model.traffic_generator.capturing_traffic_generator import (
     PacketFilteringConfig,
@@ -36,7 +37,6 @@
 from framework.testbed_model.traffic_generator.performance_traffic_generator import (
     PerformanceTrafficStats,
 )
-from framework.utils import get_packet_summaries
 
 
 def send_packet_and_capture(
diff --git a/dts/api/testpmd/config.py b/dts/api/testpmd/config.py
index f0581843ca..3850a4eb8a 100644
--- a/dts/api/testpmd/config.py
+++ b/dts/api/testpmd/config.py
@@ -13,6 +13,7 @@
 from pathlib import PurePath
 from typing import Literal, NamedTuple
 
+from api.utils import StrEnum
 from framework.params import (
     Params,
     Switch,
@@ -25,7 +26,6 @@
     str_from_flag_value,
 )
 from framework.params.eal import EalParams
-from framework.utils import StrEnum
 
 from .types import RxOffloadCapability, TxOffloadCapability
 
diff --git a/dts/api/testpmd/types.py b/dts/api/testpmd/types.py
index bca40d6f34..7f8f449941 100644
--- a/dts/api/testpmd/types.py
+++ b/dts/api/testpmd/types.py
@@ -15,8 +15,8 @@
 
 from typing_extensions import Self
 
+from api.utils import REGEX_FOR_MAC_ADDRESS, StrEnum
 from framework.parser import ParserFn, TextParser
-from framework.utils import REGEX_FOR_MAC_ADDRESS, StrEnum
 
 RxTxLiteralSwitch = Literal["rx", "tx"]
 
diff --git a/dts/framework/utils.py b/dts/api/utils.py
similarity index 100%
rename from dts/framework/utils.py
rename to dts/api/utils.py
diff --git a/dts/framework/config/node.py b/dts/framework/config/node.py
index 792290f11f..28f23389a7 100644
--- a/dts/framework/config/node.py
+++ b/dts/framework/config/node.py
@@ -14,7 +14,7 @@
 from pydantic import Field, model_validator
 from typing_extensions import Self
 
-from framework.utils import REGEX_FOR_IDENTIFIER, REGEX_FOR_PCI_ADDRESS, StrEnum
+from api.utils import REGEX_FOR_IDENTIFIER, REGEX_FOR_PCI_ADDRESS, StrEnum
 
 from .common import FrozenModel
 
diff --git a/dts/framework/config/test_run.py b/dts/framework/config/test_run.py
index 9aa0938d4e..b87c7b2d19 100644
--- a/dts/framework/config/test_run.py
+++ b/dts/framework/config/test_run.py
@@ -28,7 +28,7 @@
 from typing_extensions import TYPE_CHECKING, Self
 
 from api.exception import InternalError
-from framework.utils import REGEX_FOR_PORT_LINK, StrEnum
+from api.utils import REGEX_FOR_PORT_LINK, StrEnum
 
 from .common import FrozenModel, load_fields_from_settings
 
diff --git a/dts/framework/remote_session/dpdk.py b/dts/framework/remote_session/dpdk.py
index 0618855fc5..ba91c88d11 100644
--- a/dts/framework/remote_session/dpdk.py
+++ b/dts/framework/remote_session/dpdk.py
@@ -15,6 +15,7 @@
 
 from api.capabilities import LinkTopology
 from api.exception import ConfigurationError, RemoteFileNotFoundError
+from api.utils import MesonArgs, TarCompressionFormat
 from framework.config.test_run import (
     DPDKBuildConfiguration,
     DPDKBuildOptionsConfiguration,
@@ -34,7 +35,6 @@
 from framework.testbed_model.node import Node
 from framework.testbed_model.os_session import OSSession
 from framework.testbed_model.virtual_device import VirtualDevice
-from framework.utils import MesonArgs, TarCompressionFormat
 
 
 @dataclass(slots=True, frozen=True)
diff --git a/dts/framework/test_suite.py b/dts/framework/test_suite.py
index e06fdd28b9..426c98fdf6 100644
--- a/dts/framework/test_suite.py
+++ b/dts/framework/test_suite.py
@@ -30,12 +30,12 @@
 from typing_extensions import Self
 
 from api.exception import ConfigurationError, InternalError
+from api.utils import to_pascal_case
 from framework.config.common import FrozenModel
 from framework.testbed_model.capability import TestProtocol
 from framework.testbed_model.topology import Topology
 
 from .logger import DTSLogger, get_dts_logger
-from .utils import to_pascal_case
 
 if TYPE_CHECKING:
     from framework.context import Context
diff --git a/dts/framework/testbed_model/cpu.py b/dts/framework/testbed_model/cpu.py
index a9471709dd..68e9c7dffb 100644
--- a/dts/framework/testbed_model/cpu.py
+++ b/dts/framework/testbed_model/cpu.py
@@ -24,7 +24,7 @@
 from dataclasses import dataclass
 from enum import auto, unique
 
-from framework.utils import StrEnum, expand_range
+from api.utils import StrEnum, expand_range
 
 
 @unique
diff --git a/dts/framework/testbed_model/linux_session.py b/dts/framework/testbed_model/linux_session.py
index 4495ae35cf..26c53f069c 100644
--- a/dts/framework/testbed_model/linux_session.py
+++ b/dts/framework/testbed_model/linux_session.py
@@ -23,8 +23,8 @@
     InternalError,
     RemoteCommandExecutionError,
 )
+from api.utils import expand_range
 from framework.testbed_model.port import PortInfo
-from framework.utils import expand_range
 
 from .cpu import LogicalCore
 from .port import Port
diff --git a/dts/framework/testbed_model/os_session.py b/dts/framework/testbed_model/os_session.py
index f88427a53d..08122874e6 100644
--- a/dts/framework/testbed_model/os_session.py
+++ b/dts/framework/testbed_model/os_session.py
@@ -29,12 +29,12 @@
 from enum import Flag, auto
 from pathlib import Path, PurePath, PurePosixPath
 
+from api.utils import MesonArgs, TarCompressionFormat
 from framework.config.node import NodeConfiguration
 from framework.logger import DTSLogger
 from framework.remote_session.interactive_remote_session import InteractiveRemoteSession
 from framework.remote_session.remote_session import CommandResult, RemoteSession
 from framework.settings import SETTINGS
-from framework.utils import MesonArgs, TarCompressionFormat
 
 from .cpu import Architecture, LogicalCore
 from .port import Port, PortInfo
diff --git a/dts/framework/testbed_model/posix_session.py b/dts/framework/testbed_model/posix_session.py
index db2c3c0c40..61c634dad1 100644
--- a/dts/framework/testbed_model/posix_session.py
+++ b/dts/framework/testbed_model/posix_session.py
@@ -17,14 +17,14 @@
 from pathlib import Path, PurePath, PurePosixPath
 
 from api.exception import DPDKBuildError, RemoteCommandExecutionError
-from framework.settings import SETTINGS
-from framework.utils import (
+from api.utils import (
     MesonArgs,
     TarCompressionFormat,
     convert_to_list_of_string,
     create_tarball,
     extract_tarball,
 )
+from framework.settings import SETTINGS
 
 from .cpu import Architecture
 from .os_session import FilePermissions, OSSession, OSSessionInfo
diff --git a/dts/framework/testbed_model/traffic_generator/capturing_traffic_generator.py b/dts/framework/testbed_model/traffic_generator/capturing_traffic_generator.py
index 7655751d7e..2804d64990 100644
--- a/dts/framework/testbed_model/traffic_generator/capturing_traffic_generator.py
+++ b/dts/framework/testbed_model/traffic_generator/capturing_traffic_generator.py
@@ -17,8 +17,8 @@
 from scapy.packet import Packet
 
 from api.artifact import Artifact
+from api.utils import get_packet_summaries
 from framework.testbed_model.port import Port
-from framework.utils import get_packet_summaries
 
 from .traffic_generator import TrafficGenerator
 
diff --git a/dts/framework/testbed_model/traffic_generator/traffic_generator.py b/dts/framework/testbed_model/traffic_generator/traffic_generator.py
index cdda5a7c08..fedce77fdf 100644
--- a/dts/framework/testbed_model/traffic_generator/traffic_generator.py
+++ b/dts/framework/testbed_model/traffic_generator/traffic_generator.py
@@ -25,7 +25,7 @@ class TrafficGenerator(ABC):
 
     Exposes the common public methods of all traffic generators and defines private methods
     that must implement the traffic generation logic in subclasses. This class also extends from
-    :class:`framework.utils.MultiInheritanceBaseClass` to allow subclasses the ability to inherit
+    :class:`api.utils.MultiInheritanceBaseClass` to allow subclasses the ability to inherit
     from multiple classes to fulfil the traffic generating functionality without breaking
     single inheritance.
     """
diff --git a/dts/framework/testbed_model/traffic_generator/trex.py b/dts/framework/testbed_model/traffic_generator/trex.py
index 2c3beebc59..7fd6234d27 100644
--- a/dts/framework/testbed_model/traffic_generator/trex.py
+++ b/dts/framework/testbed_model/traffic_generator/trex.py
@@ -12,6 +12,7 @@
 from scapy.packet import Packet
 
 from api.exception import SSHTimeoutError
+from api.utils import StrEnum
 from framework.config.node import OS, NodeConfiguration
 from framework.config.test_run import TrexTrafficGeneratorConfig
 from framework.parser import TextParser
@@ -24,7 +25,6 @@
     PerformanceTrafficGenerator,
     PerformanceTrafficStats,
 )
-from framework.utils import StrEnum
 
 
 @dataclass(slots=True)
diff --git a/dts/tests/TestSuite_l2fwd.py b/dts/tests/TestSuite_l2fwd.py
index 596b892730..1e99b82b8c 100644
--- a/dts/tests/TestSuite_l2fwd.py
+++ b/dts/tests/TestSuite_l2fwd.py
@@ -20,10 +20,10 @@
 )
 from api.testpmd import TestPmd
 from api.testpmd.config import EthPeer, SimpleForwardingModes
+from api.utils import generate_random_packets
 from framework.context import filter_cores
 from framework.test_suite import TestSuite, func_test
 from framework.testbed_model.cpu import LogicalCoreCount
-from framework.utils import generate_random_packets
 
 
 @requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
diff --git a/dts/tests/TestSuite_rss.py b/dts/tests/TestSuite_rss.py
index 1af0782ffc..1e60bdba07 100644
--- a/dts/tests/TestSuite_rss.py
+++ b/dts/tests/TestSuite_rss.py
@@ -30,8 +30,8 @@
     RSSOffloadTypesFlag,
     TestPmdVerbosePacket,
 )
+from api.utils import StrEnum
 from framework.test_suite import BaseConfig, TestSuite, func_test
-from framework.utils import StrEnum
 
 
 class Config(BaseConfig):
diff --git a/dts/tests/TestSuite_smoke_tests.py b/dts/tests/TestSuite_smoke_tests.py
index 271ad4301c..fce83604a6 100644
--- a/dts/tests/TestSuite_smoke_tests.py
+++ b/dts/tests/TestSuite_smoke_tests.py
@@ -20,11 +20,11 @@
 )
 from api.test import verify
 from api.testpmd import TestPmd
+from api.utils import REGEX_FOR_PCI_ADDRESS
 from framework.config.node import PortConfig
 from framework.settings import SETTINGS
 from framework.test_suite import TestSuite, func_test
 from framework.testbed_model.linux_session import LinuxSession
-from framework.utils import REGEX_FOR_PCI_ADDRESS
 
 
 @requires_link_topology(LinkTopology.NO_LINK)
diff --git a/dts/tests/TestSuite_softnic.py b/dts/tests/TestSuite_softnic.py
index fa91f7ee2f..c57a12c932 100644
--- a/dts/tests/TestSuite_softnic.py
+++ b/dts/tests/TestSuite_softnic.py
@@ -20,9 +20,9 @@
 )
 from api.testpmd import TestPmd
 from api.testpmd.config import EthPeer
+from api.utils import generate_random_packets
 from framework.test_suite import TestSuite, func_test
 from framework.testbed_model.virtual_device import VirtualDevice
-from framework.utils import generate_random_packets
 
 
 @requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
-- 
2.55.0

