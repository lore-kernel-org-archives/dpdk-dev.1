Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4085FF885A
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Apr 2026 18:08:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 50EA640661;
	Tue, 28 Apr 2026 20:08:48 +0200 (CEST)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com
 [209.85.160.173])
 by mails.dpdk.org (Postfix) with ESMTP id B4E7F40655
 for <dev@dpdk.org>; Tue, 28 Apr 2026 20:08:45 +0200 (CEST)
Received: by mail-qt1-f173.google.com with SMTP id
 d75a77b69052e-50fb1932b62so65874161cf.2
 for <dev@dpdk.org>; Tue, 28 Apr 2026 11:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1777399725; x=1778004525; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nqelhjKXQDHo2Ew7hTlmEv6tpCEteN62xOKfrKwljPE=;
 b=hgUM5iqrNccOXzPzBm7oPCB0Yf9k3s9MOpwFr3Zogz5vjVtL8PSJK2F1J1kCdY2BQ4
 g1ksMCxM97wX+Vn0FtcZpEjorfAzejyiRmAsdzaWApUhYqrsQjTrUYZRZ51MpNQII04J
 8kcFoGZwL0LUpt2iScI6t7XcqsnLci13QjwkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777399725; x=1778004525;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nqelhjKXQDHo2Ew7hTlmEv6tpCEteN62xOKfrKwljPE=;
 b=sLCzm/toYhkcI4bmslBVIouavb+czPOBfYGNiOcNRLlJ1ZlTE7+w1NqaiNizohR86S
 a/79uM2wyal1GhPQ4GzBryWBf2RLq54o96IkAKTSe2W6s1BM7FLYGpVu68LUolqakCLb
 gY/lvu7onWxXVyAQcQHIEPc5nWHQzexa1qCj650f5UmTmdu0uazrz+NuUPXgFhMtsaCN
 j5u5DzE87EfCFgaQfjz+xlEVA8VB9kP0ZcjyCb1ISSxA+TezD+TsKEoWjXO8JLBjqMP+
 IQ/kQmRXZRIKhk/DOQvTRpGP9dyjkA5q00EenVsbtm/u2yIqUJ9GD/7ThHFKijXhVR/c
 ODRg==
X-Gm-Message-State: AOJu0YwLXAQf40vKnL3ruxpCtaj4F/rOesw+gfzCMWzc6kagR4b7fPwl
 Cmae+WUzOnX+p/6Hd/V0p9JQBxItmJ3h65UV2S4RzZHOywJ8RxmivesQvgDsgoa23Is=
X-Gm-Gg: AeBDiesQ5q0a6SMLNzyxDEpYxrSDiiNQlCMkg17OJ1yDIjmxY/MYfEUgg9YvNjTNLsw
 HkksAecOjRwAcdJe2DG1RAPju4E1JarGPgJrJkZJIpvALKobn2aJG7cRoJHs4jriUGo4GSbLMhg
 MrmoKn9lc3VgD9jj61bepvya7mbJYCcQTZbgi2xMXUX3kwZ/VGrINPtTevJooukkuLrKEoG6J7A
 7gfnR8+QmkPHYXNE/p+QFSZM6S99soJGo2i+nlHOJ3s0vSsd565MG7DkU/RpyjYeMV5UvBxulDO
 5SIa8ZPxkAXKBYye/6gecPgzttE+UMYTQH4aWMFyqTDyAP62aC/MmLzD3PaHmIBBDRhYO78IoiO
 Nm71ndenx93EILXvBA9qUitMQRACMG5z5Vh0GlMzBQi5G4BN+dzulAoq8vYg7wMbESmbnIszXN+
 6GorkFZs0QPTYw25HshjTPxjsMmVXbvNlvQqcA6hsvFXPi2rJMIkJmH4Md91iVSDIYiO67w5aD
X-Received: by 2002:ac8:5fc9:0:b0:509:23ee:b9a5 with SMTP id
 d75a77b69052e-5100e0f3854mr57331951cf.5.1777399724846; 
 Tue, 28 Apr 2026 11:08:44 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:ac5d:4186:4dc6:47eb])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5100fbfc73bsm19792351cf.12.2026.04.28.11.08.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 11:08:44 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: patrickrobb1997@gmail.com, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v4 1/7] dts: move exception module from framework to API
Date: Tue, 28 Apr 2026 14:08:34 -0400
Message-ID: <20260428180840.18596-2-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260428180840.18596-1-dmarx@iol.unh.edu>
References: <20260424170139.20592-1-dmarx@iol.unh.edu>
 <20260428180840.18596-1-dmarx@iol.unh.edu>
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

Multiple test suites currently import the exception module
from the framework in order to catch certain errors during
test execution. Move this to the API.

Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
---
 .../dts/{framework.exception.rst => api.exception.rst} |  2 +-
 doc/api/dts/index.rst                                  |  2 +-
 dts/api/artifact.py                                    |  2 +-
 dts/api/cryptodev/__init__.py                          |  2 +-
 dts/{framework => api}/exception.py                    |  0
 dts/api/packet.py                                      |  2 +-
 dts/api/test.py                                        |  2 +-
 dts/api/testpmd/__init__.py                            |  2 +-
 dts/framework/config/__init__.py                       |  2 +-
 dts/framework/config/test_run.py                       |  2 +-
 dts/framework/context.py                               |  2 +-
 dts/framework/parser.py                                |  2 +-
 dts/framework/remote_session/dpdk.py                   |  2 +-
 .../remote_session/interactive_remote_session.py       |  2 +-
 dts/framework/remote_session/interactive_shell.py      |  4 ++--
 dts/framework/remote_session/remote_session.py         |  4 ++--
 dts/framework/runner.py                                |  2 +-
 dts/framework/test_result.py                           |  3 +--
 dts/framework/test_run.py                              |  4 ++--
 dts/framework/test_suite.py                            |  2 +-
 dts/framework/testbed_model/capability.py              |  2 +-
 dts/framework/testbed_model/linux_session.py           |  2 +-
 dts/framework/testbed_model/node.py                    |  2 +-
 dts/framework/testbed_model/port.py                    |  2 +-
 dts/framework/testbed_model/posix_session.py           |  2 +-
 dts/framework/testbed_model/topology.py                |  2 +-
 .../testbed_model/traffic_generator/__init__.py        |  2 +-
 dts/framework/testbed_model/traffic_generator/scapy.py |  2 +-
 dts/framework/utils.py                                 |  2 +-
 dts/tests/TestSuite_cryptodev_throughput.py            |  2 +-
 dts/tests/TestSuite_dynamic_queue_conf.py              |  2 +-
 dts/tests/TestSuite_mac_filter.py                      |  2 +-
 dts/tests/TestSuite_pmd_rss.py                         |  2 +-
 dts/tests/TestSuite_rte_flow.py                        | 10 +++++-----
 34 files changed, 40 insertions(+), 41 deletions(-)
 rename doc/api/dts/{framework.exception.rst => api.exception.rst} (77%)
 rename dts/{framework => api}/exception.py (100%)

diff --git a/doc/api/dts/framework.exception.rst b/doc/api/dts/api.exception.rst
similarity index 77%
rename from doc/api/dts/framework.exception.rst
rename to doc/api/dts/api.exception.rst
index efb47dc5ae..8e6bff5ee7 100644
--- a/doc/api/dts/framework.exception.rst
+++ b/doc/api/dts/api.exception.rst
@@ -3,6 +3,6 @@
 exception - Exceptions
 ======================
 
-.. automodule:: framework.exception
+.. automodule:: api.exception
    :members:
    :show-inheritance:
diff --git a/doc/api/dts/index.rst b/doc/api/dts/index.rst
index c719297c11..01f630e7cd 100644
--- a/doc/api/dts/index.rst
+++ b/doc/api/dts/index.rst
@@ -36,7 +36,7 @@ Modules
    framework.logger
    framework.parser
    framework.utils
-   framework.exception
+   api.exception
 
 
 Indices and tables
diff --git a/dts/api/artifact.py b/dts/api/artifact.py
index 24a2b05063..7d04c7ab49 100644
--- a/dts/api/artifact.py
+++ b/dts/api/artifact.py
@@ -47,7 +47,7 @@
 from paramiko import SFTPClient, SFTPFile
 from typing_extensions import Buffer
 
-from framework.exception import InternalError
+from api.exception import InternalError
 from framework.logger import DTSLogger, get_dts_logger
 from framework.settings import SETTINGS
 from framework.testbed_model.node import Node, NodeIdentifier, get_node
diff --git a/dts/api/cryptodev/__init__.py b/dts/api/cryptodev/__init__.py
index a4fafc3713..c6a220dced 100644
--- a/dts/api/cryptodev/__init__.py
+++ b/dts/api/cryptodev/__init__.py
@@ -22,8 +22,8 @@
     ThroughputResults,
     VerifyResults,
 )
+from api.exception import RemoteCommandExecutionError, SkippedTestException
 from framework.context import get_ctx
-from framework.exception import RemoteCommandExecutionError, SkippedTestException
 from framework.remote_session.dpdk_shell import compute_eal_params
 
 if TYPE_CHECKING:
diff --git a/dts/framework/exception.py b/dts/api/exception.py
similarity index 100%
rename from dts/framework/exception.py
rename to dts/api/exception.py
diff --git a/dts/api/packet.py b/dts/api/packet.py
index 094a1b7a9d..cabb39a8dd 100644
--- a/dts/api/packet.py
+++ b/dts/api/packet.py
@@ -27,9 +27,9 @@
 from scapy.layers.l2 import Ether
 from scapy.packet import Packet, Padding, raw
 
+from api.exception import InternalError
 from api.test import fail, log_debug
 from framework.context import get_ctx
-from framework.exception import InternalError
 from framework.testbed_model.traffic_generator.capturing_traffic_generator import (
     PacketFilteringConfig,
 )
diff --git a/dts/api/test.py b/dts/api/test.py
index e17babe0ca..9cad9a9495 100644
--- a/dts/api/test.py
+++ b/dts/api/test.py
@@ -10,8 +10,8 @@
 from datetime import datetime
 
 from api.artifact import Artifact
+from api.exception import InternalError, SkippedTestException, TestCaseVerifyError
 from framework.context import get_ctx
-from framework.exception import InternalError, SkippedTestException, TestCaseVerifyError
 from framework.logger import DTSLogger
 
 
diff --git a/dts/api/testpmd/__init__.py b/dts/api/testpmd/__init__.py
index e9187440bb..9498d723d5 100644
--- a/dts/api/testpmd/__init__.py
+++ b/dts/api/testpmd/__init__.py
@@ -32,6 +32,7 @@
 from typing_extensions import Unpack
 
 from api.capabilities import LinkTopology, NicCapability
+from api.exception import InteractiveCommandExecutionError, InternalError
 from api.testpmd.config import PortTopology, SimpleForwardingModes, TestPmdParams
 from api.testpmd.types import (
     ChecksumOffloadOptions,
@@ -55,7 +56,6 @@
     VLANOffloadFlag,
 )
 from framework.context import get_ctx
-from framework.exception import InteractiveCommandExecutionError, InternalError
 from framework.params.types import TestPmdParamsDict
 from framework.remote_session.dpdk_shell import DPDKShell
 from framework.remote_session.interactive_shell import only_active
diff --git a/dts/framework/config/__init__.py b/dts/framework/config/__init__.py
index d2f0138e4a..566dc7c4a2 100644
--- a/dts/framework/config/__init__.py
+++ b/dts/framework/config/__init__.py
@@ -35,7 +35,7 @@
 from pydantic import Field, TypeAdapter, ValidationError, model_validator
 from typing_extensions import Self
 
-from framework.exception import ConfigurationError
+from api.exception import ConfigurationError
 
 from .common import FrozenModel, ValidationContext
 from .node import NodeConfiguration
diff --git a/dts/framework/config/test_run.py b/dts/framework/config/test_run.py
index 76e24d1785..62aaba033a 100644
--- a/dts/framework/config/test_run.py
+++ b/dts/framework/config/test_run.py
@@ -27,7 +27,7 @@
 )
 from typing_extensions import TYPE_CHECKING, Self
 
-from framework.exception import InternalError
+from api.exception import InternalError
 from framework.utils import REGEX_FOR_PORT_LINK, StrEnum
 
 from .common import FrozenModel, load_fields_from_settings
diff --git a/dts/framework/context.py b/dts/framework/context.py
index 8f1021dc96..7e61c85998 100644
--- a/dts/framework/context.py
+++ b/dts/framework/context.py
@@ -8,7 +8,7 @@
 from dataclasses import MISSING, dataclass, field, fields
 from typing import TYPE_CHECKING, Any, Optional, ParamSpec, Union
 
-from framework.exception import InternalError
+from api.exception import InternalError
 from framework.remote_session.shell_pool import ShellPool
 from framework.settings import SETTINGS
 from framework.testbed_model.cpu import LogicalCoreCount, LogicalCoreList
diff --git a/dts/framework/parser.py b/dts/framework/parser.py
index 3075c36857..ebf470ad30 100644
--- a/dts/framework/parser.py
+++ b/dts/framework/parser.py
@@ -15,7 +15,7 @@
 
 from typing_extensions import Self
 
-from framework.exception import InternalError
+from api.exception import InternalError
 
 
 class ParserFn(TypedDict):
diff --git a/dts/framework/remote_session/dpdk.py b/dts/framework/remote_session/dpdk.py
index c3575cfcaf..d803a9e4bd 100644
--- a/dts/framework/remote_session/dpdk.py
+++ b/dts/framework/remote_session/dpdk.py
@@ -13,6 +13,7 @@
 from pathlib import Path, PurePath
 from typing import ClassVar, Final
 
+from api.exception import ConfigurationError, RemoteFileNotFoundError
 from framework.config.test_run import (
     DPDKBuildConfiguration,
     DPDKBuildOptionsConfiguration,
@@ -25,7 +26,6 @@
     RemoteDPDKTreeLocation,
 )
 from framework.context import get_ctx
-from framework.exception import ConfigurationError, RemoteFileNotFoundError
 from framework.logger import DTSLogger, get_dts_logger
 from framework.params.eal import EalParams
 from framework.remote_session.remote_session import CommandResult
diff --git a/dts/framework/remote_session/interactive_remote_session.py b/dts/framework/remote_session/interactive_remote_session.py
index c8156b4345..04f45e0df8 100644
--- a/dts/framework/remote_session/interactive_remote_session.py
+++ b/dts/framework/remote_session/interactive_remote_session.py
@@ -15,8 +15,8 @@
     SSHException,
 )
 
+from api.exception import SSHConnectionError
 from framework.config.node import NodeConfiguration
-from framework.exception import SSHConnectionError
 from framework.logger import DTSLogger
 
 
diff --git a/dts/framework/remote_session/interactive_shell.py b/dts/framework/remote_session/interactive_shell.py
index a65cbce209..fdd074be3a 100644
--- a/dts/framework/remote_session/interactive_shell.py
+++ b/dts/framework/remote_session/interactive_shell.py
@@ -29,12 +29,12 @@
 from paramiko import Channel, channel
 from typing_extensions import Self
 
-from framework.context import get_ctx
-from framework.exception import (
+from api.exception import (
     InteractiveCommandExecutionError,
     InteractiveSSHSessionDeadError,
     InteractiveSSHTimeoutError,
 )
+from framework.context import get_ctx
 from framework.logger import DTSLogger, get_dts_logger
 from framework.params import Params
 from framework.settings import SETTINGS
diff --git a/dts/framework/remote_session/remote_session.py b/dts/framework/remote_session/remote_session.py
index 158325bb7f..f49966070f 100644
--- a/dts/framework/remote_session/remote_session.py
+++ b/dts/framework/remote_session/remote_session.py
@@ -24,13 +24,13 @@
     SSHException,
 )
 
-from framework.config.node import NodeConfiguration
-from framework.exception import (
+from api.exception import (
     RemoteCommandExecutionError,
     SSHConnectionError,
     SSHSessionDeadError,
     SSHTimeoutError,
 )
+from framework.config.node import NodeConfiguration
 from framework.logger import DTSLogger
 from framework.settings import SETTINGS
 
diff --git a/dts/framework/runner.py b/dts/framework/runner.py
index 6ea4749ff4..a0d8039a04 100644
--- a/dts/framework/runner.py
+++ b/dts/framework/runner.py
@@ -12,8 +12,8 @@
 import sys
 import textwrap
 
+from api.exception import ConfigurationError
 from framework.config.common import ValidationContext
-from framework.exception import ConfigurationError
 from framework.test_run import TestRun
 from framework.testbed_model.node import Node
 
diff --git a/dts/framework/test_result.py b/dts/framework/test_result.py
index 21faa55dc1..3cecb928ca 100644
--- a/dts/framework/test_result.py
+++ b/dts/framework/test_result.py
@@ -35,12 +35,11 @@
 )
 from typing_extensions import OrderedDict
 
+from api.exception import DTSError, ErrorSeverity, InternalError
 from framework.remote_session.dpdk import DPDKBuildInfo
 from framework.settings import SETTINGS
 from framework.testbed_model.os_session import OSSessionInfo
 
-from .exception import DTSError, ErrorSeverity, InternalError
-
 
 class Result(IntEnum):
     """The possible states that a setup, a teardown or a test case may end up in."""
diff --git a/dts/framework/test_run.py b/dts/framework/test_run.py
index 94dc6023a7..bbaf4f1fdf 100644
--- a/dts/framework/test_run.py
+++ b/dts/framework/test_run.py
@@ -106,9 +106,9 @@
 from types import MethodType
 from typing import ClassVar, Protocol, Union
 
+from api.exception import InternalError, SkippedTestException, TestCaseVerifyError
 from framework.config.test_run import TestRunConfiguration
 from framework.context import Context, init_ctx
-from framework.exception import InternalError, SkippedTestException, TestCaseVerifyError
 from framework.logger import DTSLogger, get_dts_logger
 from framework.remote_session.dpdk import DPDKBuildEnvironment, DPDKRuntimeEnvironment
 from framework.settings import SETTINGS
@@ -136,7 +136,7 @@ class TestRun:
     If an error occurs, the current stage is aborted, the error is recorded, everything in
     the inner stages is marked as blocked and the run continues in the next iteration
     of the same stage. The return code is the highest `severity` of all
-    :class:`~.framework.exception.DTSError`\s.
+    :class:`~.api.exception.DTSError`\s.
 
     Example:
         An error occurs in a test suite setup. The current test suite is aborted,
diff --git a/dts/framework/test_suite.py b/dts/framework/test_suite.py
index 69ce26040a..e06fdd28b9 100644
--- a/dts/framework/test_suite.py
+++ b/dts/framework/test_suite.py
@@ -29,11 +29,11 @@
 from scapy.packet import Packet
 from typing_extensions import Self
 
+from api.exception import ConfigurationError, InternalError
 from framework.config.common import FrozenModel
 from framework.testbed_model.capability import TestProtocol
 from framework.testbed_model.topology import Topology
 
-from .exception import ConfigurationError, InternalError
 from .logger import DTSLogger, get_dts_logger
 from .utils import to_pascal_case
 
diff --git a/dts/framework/testbed_model/capability.py b/dts/framework/testbed_model/capability.py
index 960370fc72..001b65994c 100644
--- a/dts/framework/testbed_model/capability.py
+++ b/dts/framework/testbed_model/capability.py
@@ -64,7 +64,7 @@ def test_scatter_mbuf_2048(self):
 from typing_extensions import Self
 
 from api.capabilities import LinkTopology, NicCapability
-from framework.exception import ConfigurationError, InternalError, SkippedTestException
+from api.exception import ConfigurationError, InternalError, SkippedTestException
 from framework.logger import get_dts_logger
 from framework.testbed_model.node import Node
 from framework.testbed_model.port import DriverKind
diff --git a/dts/framework/testbed_model/linux_session.py b/dts/framework/testbed_model/linux_session.py
index ee943462c2..88b6da1ae6 100644
--- a/dts/framework/testbed_model/linux_session.py
+++ b/dts/framework/testbed_model/linux_session.py
@@ -18,7 +18,7 @@
 
 from typing_extensions import NotRequired
 
-from framework.exception import (
+from api.exception import (
     ConfigurationError,
     InternalError,
     RemoteCommandExecutionError,
diff --git a/dts/framework/testbed_model/node.py b/dts/framework/testbed_model/node.py
index 67a96ef4e5..4f42bf6aeb 100644
--- a/dts/framework/testbed_model/node.py
+++ b/dts/framework/testbed_model/node.py
@@ -17,11 +17,11 @@
 from pathlib import PurePath
 from typing import Literal, TypeAlias
 
+from api.exception import ConfigurationError, InternalError
 from framework.config.node import (
     OS,
     NodeConfiguration,
 )
-from framework.exception import ConfigurationError, InternalError
 from framework.logger import DTSLogger, get_dts_logger
 
 from .cpu import Architecture, LogicalCore
diff --git a/dts/framework/testbed_model/port.py b/dts/framework/testbed_model/port.py
index d81bc4cda0..aea3e59c25 100644
--- a/dts/framework/testbed_model/port.py
+++ b/dts/framework/testbed_model/port.py
@@ -12,8 +12,8 @@
 from functools import cached_property
 from typing import TYPE_CHECKING, Any, Final, Literal, NamedTuple
 
+from api.exception import InternalError
 from framework.config.node import PortConfig
-from framework.exception import InternalError
 
 if TYPE_CHECKING:
     from .node import Node
diff --git a/dts/framework/testbed_model/posix_session.py b/dts/framework/testbed_model/posix_session.py
index dec952685a..db2c3c0c40 100644
--- a/dts/framework/testbed_model/posix_session.py
+++ b/dts/framework/testbed_model/posix_session.py
@@ -16,7 +16,7 @@
 from collections.abc import Iterable
 from pathlib import Path, PurePath, PurePosixPath
 
-from framework.exception import DPDKBuildError, RemoteCommandExecutionError
+from api.exception import DPDKBuildError, RemoteCommandExecutionError
 from framework.settings import SETTINGS
 from framework.utils import (
     MesonArgs,
diff --git a/dts/framework/testbed_model/topology.py b/dts/framework/testbed_model/topology.py
index 34862c4d2e..805a762c19 100644
--- a/dts/framework/testbed_model/topology.py
+++ b/dts/framework/testbed_model/topology.py
@@ -18,7 +18,7 @@
 from typing_extensions import Self
 
 from api.capabilities import LinkTopology
-from framework.exception import ConfigurationError, InternalError
+from api.exception import ConfigurationError, InternalError
 from framework.testbed_model.linux_session import LinuxSession
 from framework.testbed_model.node import Node, NodeIdentifier
 
diff --git a/dts/framework/testbed_model/traffic_generator/__init__.py b/dts/framework/testbed_model/traffic_generator/__init__.py
index fca251f534..324b5e88f3 100644
--- a/dts/framework/testbed_model/traffic_generator/__init__.py
+++ b/dts/framework/testbed_model/traffic_generator/__init__.py
@@ -14,12 +14,12 @@
 and a capturing traffic generator is required.
 """
 
+from api.exception import ConfigurationError
 from framework.config.test_run import (
     ScapyTrafficGeneratorConfig,
     TrafficGeneratorConfig,
     TrexTrafficGeneratorConfig,
 )
-from framework.exception import ConfigurationError
 from framework.testbed_model.node import Node
 
 from .scapy import ScapyTrafficGenerator
diff --git a/dts/framework/testbed_model/traffic_generator/scapy.py b/dts/framework/testbed_model/traffic_generator/scapy.py
index c6e9006205..e983443548 100644
--- a/dts/framework/testbed_model/traffic_generator/scapy.py
+++ b/dts/framework/testbed_model/traffic_generator/scapy.py
@@ -25,9 +25,9 @@
 from scapy.layers.l2 import Ether
 from scapy.packet import Packet
 
+from api.exception import InteractiveSSHSessionDeadError, InternalError
 from framework.config.node import OS
 from framework.config.test_run import ScapyTrafficGeneratorConfig
-from framework.exception import InteractiveSSHSessionDeadError, InternalError
 from framework.remote_session.python_shell import PythonShell
 from framework.testbed_model.node import Node
 from framework.testbed_model.port import Port
diff --git a/dts/framework/utils.py b/dts/framework/utils.py
index 9917ffbfaa..28e344871a 100644
--- a/dts/framework/utils.py
+++ b/dts/framework/utils.py
@@ -26,7 +26,7 @@
 from scapy.layers.inet import IP, TCP, UDP, Ether
 from scapy.packet import Packet
 
-from .exception import InternalError
+from api.exception import InternalError
 
 REGEX_FOR_PCI_ADDRESS: str = r"[0-9a-fA-F]{4}:[0-9a-fA-F]{2}:[0-9a-fA-F]{2}.[0-9]{1}"
 _REGEX_FOR_COLON_OR_HYPHEN_SEP_MAC: str = r"(?:[\da-fA-F]{2}[:-]){5}[\da-fA-F]{2}"
diff --git a/dts/tests/TestSuite_cryptodev_throughput.py b/dts/tests/TestSuite_cryptodev_throughput.py
index af0a5680ab..f36b48a153 100644
--- a/dts/tests/TestSuite_cryptodev_throughput.py
+++ b/dts/tests/TestSuite_cryptodev_throughput.py
@@ -29,9 +29,9 @@
 from api.cryptodev.types import (
     CryptodevResults,
 )
+from api.exception import SkippedTestException
 from api.test import verify
 from framework.context import get_ctx
-from framework.exception import SkippedTestException
 from framework.test_suite import BaseConfig, TestSuite, crypto_test
 from framework.testbed_model.virtual_device import VirtualDevice
 
diff --git a/dts/tests/TestSuite_dynamic_queue_conf.py b/dts/tests/TestSuite_dynamic_queue_conf.py
index 5ac85bee7d..b62efa2b42 100644
--- a/dts/tests/TestSuite_dynamic_queue_conf.py
+++ b/dts/tests/TestSuite_dynamic_queue_conf.py
@@ -35,11 +35,11 @@
     NicCapability,
     requires_nic_capability,
 )
+from api.exception import InteractiveCommandExecutionError
 from api.packet import send_packets
 from api.test import fail, verify
 from api.testpmd import TestPmd
 from api.testpmd.config import PortTopology, SimpleForwardingModes
-from framework.exception import InteractiveCommandExecutionError
 from framework.test_suite import TestSuite, func_test
 
 
diff --git a/dts/tests/TestSuite_mac_filter.py b/dts/tests/TestSuite_mac_filter.py
index a7e24b37d5..b44822d31c 100644
--- a/dts/tests/TestSuite_mac_filter.py
+++ b/dts/tests/TestSuite_mac_filter.py
@@ -23,10 +23,10 @@
     NicCapability,
     requires_nic_capability,
 )
+from api.exception import InteractiveCommandExecutionError
 from api.packet import send_packet_and_capture
 from api.test import fail, verify
 from api.testpmd import TestPmd
-from framework.exception import InteractiveCommandExecutionError
 from framework.test_suite import TestSuite, func_test
 
 
diff --git a/dts/tests/TestSuite_pmd_rss.py b/dts/tests/TestSuite_pmd_rss.py
index f6adf262c3..1e5a6860be 100644
--- a/dts/tests/TestSuite_pmd_rss.py
+++ b/dts/tests/TestSuite_pmd_rss.py
@@ -20,6 +20,7 @@
     requires_link_topology,
     requires_nic_capability,
 )
+from api.exception import InteractiveCommandExecutionError
 from api.packet import send_packets_and_capture
 from api.test import verify
 from api.testpmd import TestPmd
@@ -29,7 +30,6 @@
     RSSOffloadTypesFlag,
     TestPmdVerbosePacket,
 )
-from framework.exception import InteractiveCommandExecutionError
 from framework.test_suite import BaseConfig, TestSuite, func_test
 from framework.utils import StrEnum
 
diff --git a/dts/tests/TestSuite_rte_flow.py b/dts/tests/TestSuite_rte_flow.py
index 6255e4c36d..7e50a075ac 100644
--- a/dts/tests/TestSuite_rte_flow.py
+++ b/dts/tests/TestSuite_rte_flow.py
@@ -21,15 +21,15 @@
 from scapy.packet import Packet, Raw
 
 from api.capabilities import NicCapability, requires_nic_capability
-from api.packet import send_packet_and_capture
-from api.test import fail, log, verify
-from api.testpmd import TestPmd
-from api.testpmd.types import FlowRule
-from framework.exception import (
+from api.exception import (
     InteractiveCommandExecutionError,
     SkippedTestException,
     TestCaseVerifyError,
 )
+from api.packet import send_packet_and_capture
+from api.test import fail, log, verify
+from api.testpmd import TestPmd
+from api.testpmd.types import FlowRule
 from framework.test_suite import TestSuite, func_test
 
 
-- 
2.52.0

