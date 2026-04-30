Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD825CD13D2
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Apr 2026 22:06:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 027E04066C;
	Fri,  1 May 2026 00:06:47 +0200 (CEST)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com
 [209.85.219.53]) by mails.dpdk.org (Postfix) with ESMTP id A09F04021F
 for <dev@dpdk.org>; Fri,  1 May 2026 00:06:44 +0200 (CEST)
Received: by mail-qv1-f53.google.com with SMTP id
 6a1803df08f44-89fc4147f2eso16712626d6.3
 for <dev@dpdk.org>; Thu, 30 Apr 2026 15:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1777586804; x=1778191604; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5UOv33c6yduKhk0TPWsA0xfUiVCLtlTiYiVUWKOlTbg=;
 b=cBJ21pC+z4DJy79+aTJUH4X2KFLqvyFRysr2O2qGJ2QUnhvRbwwBfABFovpsk3x8Yt
 d6XaQm+w6JuAsN2KmOeqlcrpxwWgE/SjePEUVn/M3xocIF53TKSZMEztbRB2f/bQgRJQ
 h7yikB98TyeuwDuTvDphQMFMemRDPQJayC2YY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777586804; x=1778191604;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5UOv33c6yduKhk0TPWsA0xfUiVCLtlTiYiVUWKOlTbg=;
 b=jvWrsBsFE3slerc6DOgMJZzcYahXltOLOSp0+LeOgNQOBewsfGBdbbdVZDoCXIwt5V
 FvBRKvc8Bm3ZZCXDFBLFQQNmejbAfnZfIwVtZk6pulQsc+ZdmDSO++XdRT7AOPdipEbH
 HRXyRHX07b9Iet6NCCZB37DNEBj+vqxiTuZzQFSOFP2i1cCFXi8FDdTV7xAU/XUJaJJJ
 l2fiS9mq+fSawZ64B3oXpsnD0PqS473M0oidLXLCryKOMnJkXy58/RWBdtyX5Fbex4T1
 /8XQTifD85Ya4oZLnRiGadTFfeWvh2FwNHizP41FqzcaYJRNWOl88Xdsejba3LpsimEM
 p36g==
X-Gm-Message-State: AOJu0YxsusGFHF1+TgkoPIYLGJoeaYRmOCtks1ccWxuhVARGgTyjHIvq
 xLpoVVQj2lED7aYph9GNOjjnZsJoxcJWmkQk7n8fYc+hoDMevqi8dBUee6I7wok3ta4=
X-Gm-Gg: AeBDiesKAR6roOLjVi57fYNue2+qir4y1hjz4VLyhmG26k5VSNZV+H3iA/Mu28ZmO/c
 +OvGZNu4T8eGs0ojrGWbLyGOCxZ1RH+ab3+aP1u+cUXsLUn6KmljRmVKnsR8pyfe2oII45C1WDP
 t+Lx+Yo5nYxLHdsKW7Bld5KeVd4nzg/pSDbfqLHonJBy0fLjuIYYbGQYzIm7fyg/7s/gUnmo5yr
 Jl6oBNy9PiqfsPQx+pE4eFx4tRWdVzkL6eK+OudrFt6qKI/GZGomZ1VMlB3js01O1MdaA4Bdakp
 K+FLIbYj8ZqboM/c4epJ6DhGnIB1YU5KWhUHGfReLo5bmLhS2j84a2BeNuGW1e+AG5K9O3kZru2
 VwZ0O+IKlyRQlYbYK5K2DSUNfVz/yw6hZgjlAOJjSrUDTVfJUxb5Fx5wGux1DItlYIqzztWp/0+
 rlpAK/zzLJV1mdREvGWXTuSjgYgpnlvoZyd8zSkM47E4Sl+6Yp2/mvnEZV/lLv8JA1sII8yCk8
X-Received: by 2002:a05:6214:4a82:b0:89f:2fa:a9bb with SMTP id
 6a1803df08f44-8b3fe721b33mr76255626d6.9.1777586803860; 
 Thu, 30 Apr 2026 15:06:43 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:ac5d:4186:4dc6:47eb])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b53d83114fsm3146136d6.48.2026.04.30.15.06.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 15:06:43 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: patrickrobb1997@gmail.com, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v4 2/7] dts: move utils from framework to API
Date: Thu, 30 Apr 2026 18:06:33 -0400
Message-ID: <20260430220638.30666-3-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260430220638.30666-1-dmarx@iol.unh.edu>
References: <20260424170139.20592-1-dmarx@iol.unh.edu>
 <20260430220638.30666-1-dmarx@iol.unh.edu>
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
 dts/tests/TestSuite_pmd_rss.py                                | 2 +-
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
index cabb39a8dd..b7a9bb28bf 100644
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
index e71a3e1ef0..8b688834ee 100644
--- a/dts/api/testpmd/config.py
+++ b/dts/api/testpmd/config.py
@@ -13,6 +13,7 @@
 from pathlib import PurePath
 from typing import Literal, NamedTuple
 
+from api.utils import StrEnum
 from framework.params import (
     Params,
     Switch,
@@ -24,7 +25,6 @@
     str_from_flag_value,
 )
 from framework.params.eal import EalParams
-from framework.utils import StrEnum
 
 
 class PortTopology(StrEnum):
diff --git a/dts/api/testpmd/types.py b/dts/api/testpmd/types.py
index 0d322aece2..5c847b4bd6 100644
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
index 62aaba033a..977067f42a 100644
--- a/dts/framework/config/test_run.py
+++ b/dts/framework/config/test_run.py
@@ -28,7 +28,7 @@
 from typing_extensions import TYPE_CHECKING, Self
 
 from api.exception import InternalError
-from framework.utils import REGEX_FOR_PORT_LINK, StrEnum
+from api.utils import REGEX_FOR_PORT_LINK, StrEnum
 
 from .common import FrozenModel, load_fields_from_settings
 
diff --git a/dts/framework/remote_session/dpdk.py b/dts/framework/remote_session/dpdk.py
index d803a9e4bd..69b47b823b 100644
--- a/dts/framework/remote_session/dpdk.py
+++ b/dts/framework/remote_session/dpdk.py
@@ -14,6 +14,7 @@
 from typing import ClassVar, Final
 
 from api.exception import ConfigurationError, RemoteFileNotFoundError
+from api.utils import MesonArgs, TarCompressionFormat
 from framework.config.test_run import (
     DPDKBuildConfiguration,
     DPDKBuildOptionsConfiguration,
@@ -33,7 +34,6 @@
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
index 6e2ecca080..52ef196f84 100644
--- a/dts/framework/testbed_model/cpu.py
+++ b/dts/framework/testbed_model/cpu.py
@@ -24,7 +24,7 @@
 from dataclasses import dataclass
 from enum import auto, unique
 
-from framework.utils import StrEnum, expand_range
+from api.utils import StrEnum, expand_range
 
 
 @unique
diff --git a/dts/framework/testbed_model/linux_session.py b/dts/framework/testbed_model/linux_session.py
index 88b6da1ae6..69b0923744 100644
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
index 2c267afed1..7bb339fab2 100644
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
index 22cd20dea9..2064703fcc 100644
--- a/dts/framework/testbed_model/traffic_generator/trex.py
+++ b/dts/framework/testbed_model/traffic_generator/trex.py
@@ -11,6 +11,7 @@
 
 from scapy.packet import Packet
 
+from api.utils import StrEnum
 from framework.config.node import OS, NodeConfiguration
 from framework.config.test_run import TrexTrafficGeneratorConfig
 from framework.parser import TextParser
@@ -23,7 +24,6 @@
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
diff --git a/dts/tests/TestSuite_pmd_rss.py b/dts/tests/TestSuite_pmd_rss.py
index 1e5a6860be..4df273e3e1 100644
--- a/dts/tests/TestSuite_pmd_rss.py
+++ b/dts/tests/TestSuite_pmd_rss.py
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
2.52.0

