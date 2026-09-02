Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF17C624D3
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Sep 2026 18:14:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 97426410F6;
	Wed,  2 Sep 2026 20:13:55 +0200 (CEST)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com
 [209.85.160.181])
 by mails.dpdk.org (Postfix) with ESMTP id 7648E410D2
 for <dev@dpdk.org>; Wed,  2 Sep 2026 20:13:54 +0200 (CEST)
Received: by mail-qt1-f181.google.com with SMTP id
 d75a77b69052e-5218927884fso20921611cf.3
 for <dev@dpdk.org>; Wed, 02 Sep 2026 11:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1788372834; x=1788977634; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GSs3RdIkLaRWKPxBkrBtO8K8lUYcjsLzqevK1PVWFhE=;
 b=gZOheRNSgu8xppERmdP7WwT8sWfe+svMs+H8+7WH1Z4TyHL4/JQgz15SrubscUWKLH
 kZjJVxgwM32BsAhFOtz2hbMxIjUeCIzs6Ak7HlVl+iOoob4aAA6sxYWpunGTNRZJxIZR
 EvlaOJdj4dhQ+Q64sZHFADKXMUrqZX0RIQrHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788372834; x=1788977634;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GSs3RdIkLaRWKPxBkrBtO8K8lUYcjsLzqevK1PVWFhE=;
 b=rgWDJTCeJH/sM0GDQUAgihvSjFRX4rHyC6Ot2R3Ke7vwnqrudL6eQuppyggQUvnho/
 Pqr2R6nvK1FQFIogJB2oiiop1BTHswT3cVVaMzU/V1/3DvPRNQrphCU63WsX39f0xOBa
 e7btEqBm0kKfF9Z0d/v0TejQe+IDLPGdRmAjFFaxGi0skFOjC6xZGf2/LL3sjSSug1sw
 56S+vx7rCASqA4mUF1Ls7L5SSCIYU9ck4KMhkw6wvC4gTverfvMvumCuEYStKv4yGmbt
 nrNTmsWiYpGgfQhSvGCD3ecUPx77Rm4lHVyUIUbTHsJnti4RUZebZjEYPIJ98OPQkN5A
 tR/g==
X-Gm-Message-State: AFuF++mj2vz34vk4zvxQYlf3SuM8zG6dyfomf0Kb0obAXO/H6OvZ4wga
 9ah0FEPnApzzvcVardQV0lPUPLqkcjW5rLmYcxdfrDLak4+gnz+vnUoFfd2S1zShaiOj/GavAWO
 xB3aCKPFDOK/+fS2V8Y0N82Tb5n7V4piz2CYy4oBGXo9X/68jPFXlehon9te8fNiAVlo6F/3s2h
 uDuL2b0+cWlLav/RsFdHw8JV9X1OY=
X-Gm-Gg: AR+sD11iFRy0V2Psr/d4ngI/u2IJUYFcRAGlt4lq4/kzMLx6o191d2Hm3Y9O+tF1QU9
 ikFP/HMozTGCoA+5MC4s1l1no/i2xAp2T85BtvJT8fpHqDUrSoTkH+71y07rzycHozv+YuOLmYj
 Nuy29qUqXSdwxNnstLKFAeX++Ss6jjNTzxix+aWboVvRnLzchUOEROSkLmtgCF4Ghbhk4c/r4/h
 b2c5CB6UsCvr+b4mbRYJdK/HWSoqcvHe3TmZeTj0exidf+5FCamwagKq4kR5z1nj4rlKMQDHM18
 P/xCBhuZjnYeAcvMcGwuu3T3WaWmRwXQRp5VE3tukhlm4nzs4B8HBvw9ktRQlJavLuyYiyej5JC
 anaFiukYUQo4e5VLLd5QuLbCyi2GDclVPVQdR3orMUqKQPDLzvPG1KjaSWUI8Sqqv9PrVb6FL1v
 qood8qs05ZhAjPXWbyJD1tEkC9WhpuCVaHR+C0lG/r49o3Zzclm0a7uwka5zrNQiGTyed2UaZjH
 wU1y3P6jJI=
X-Received: by 2002:a05:622a:1a9b:b0:530:42e4:1b63 with SMTP id
 d75a77b69052e-53042e42019mr12466861cf.44.1788372833629; 
 Wed, 02 Sep 2026 11:13:53 -0700 (PDT)
Received: from d121029.iol.unh.edu ([2606:4100:3880:1210::219])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-530331d9cbcsm24660101cf.16.2026.09.02.11.13.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 11:13:52 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: dev@dpdk.org,
	luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: knimoji@iol.unh.edu, lylavoie@iol.unh.edu, dladd@iol.unh.edu,
 Andrew Bailey <abailey@iol.unh.edu>, Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v6 2/8] dts: move utils from framework to API
Date: Wed,  2 Sep 2026 14:13:26 -0400
Message-ID: <20260902181333.461556-3-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902181333.461556-1-abailey@iol.unh.edu>
References: <20260806135346.568766-1-abailey@iol.unh.edu>
 <20260902181333.461556-1-abailey@iol.unh.edu>
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

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
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
index 0b03772f74..e18765bfb1 100644
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
index c4681c32dc..ec3d65ecf9 100644
--- a/dts/framework/config/test_run.py
+++ b/dts/framework/config/test_run.py
@@ -28,7 +28,7 @@
 from typing_extensions import TYPE_CHECKING, Self
 
 from api.exception import InternalError
-from framework.utils import REGEX_FOR_PORT_LINK, StrEnum
+from api.utils import REGEX_FOR_PORT_LINK, StrEnum
 
 from .common import FrozenModel, load_fields_from_settings
 
diff --git a/dts/framework/remote_session/dpdk.py b/dts/framework/remote_session/dpdk.py
index 2dc3800054..8b85e118da 100644
--- a/dts/framework/remote_session/dpdk.py
+++ b/dts/framework/remote_session/dpdk.py
@@ -15,6 +15,7 @@
 
 from api.capabilities import LinkTopology
 from api.exception import ConfigurationError, RemoteFileNotFoundError
+from api.utils import MesonArgs, TarCompressionFormat
 from framework.config.test_run import (
     DPDKBuildConfiguration,
     DPDKBuildOptionsConfiguration,
@@ -35,7 +36,6 @@
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
index 4551c7fffe..85a3e36bf4 100644
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
index 12f8b58e32..ecefff74b4 100644
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
index 49d7cf5823..eea37ba1d6 100644
--- a/dts/framework/testbed_model/traffic_generator/trex.py
+++ b/dts/framework/testbed_model/traffic_generator/trex.py
@@ -13,6 +13,7 @@
 from scapy.packet import Packet
 
 from api.exception import SSHTimeoutError
+from api.utils import StrEnum
 from framework.config.node import OS, NodeConfiguration
 from framework.config.test_run import TrexTrafficGeneratorConfig
 from framework.parser import TextParser
@@ -25,7 +26,6 @@
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

