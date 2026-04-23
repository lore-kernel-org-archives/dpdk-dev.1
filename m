Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4650FDEE45
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Apr 2026 19:04:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6014340666;
	Thu, 23 Apr 2026 21:04:33 +0200 (CEST)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com
 [209.85.160.171])
 by mails.dpdk.org (Postfix) with ESMTP id 3F67A40650
 for <dev@dpdk.org>; Thu, 23 Apr 2026 21:04:30 +0200 (CEST)
Received: by mail-qt1-f171.google.com with SMTP id
 d75a77b69052e-506aa68065eso51970341cf.1
 for <dev@dpdk.org>; Thu, 23 Apr 2026 12:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1776971069; x=1777575869; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U3Id3KRnh1xWpV0X+r0tfmDFsBRIa8yDSdbLcHigUR0=;
 b=eRyMaVCE9fAPj0jE7f7/0Ol5cWphj0yg+6hap0tRrtcFeFlQItBQydRv1pyZTGV6vm
 ojjGxgv1DakihCVh8wcaf7duegkhyrsXZC9pdWiHVyCT3YpHDQu00I3enIUoFom4XvSg
 2bhD2m67PBC2eq2qGwBNAEInlSIcWFxp7g8Ws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776971069; x=1777575869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=U3Id3KRnh1xWpV0X+r0tfmDFsBRIa8yDSdbLcHigUR0=;
 b=A1/F6l5vsjajn0aZNfznTQOiLTL5Wa2kbd+SPxsDHC36B84Tg3KoGHh0qdtfGvJDLi
 GnKJm5EkNMmaVsLJXMvatIQmZPX1t5E1AIlnfIPsDqmUxNv6zZ2ncfwaHZWpFYcpZOZw
 uK+QRc4AaOBPaSg4MoUOzYATTUO2T2JBx4SHCuvClGpiElH6YvBs+7QPssBphIQPcpkA
 fSpkwJ1JXA6ScsfPTsahkd1uQpyIkpbmQTDciL+/tCXX8iYugeWZwwPXXY1XR/yr7O+K
 Sp9LZpjKEYuBm6qrnTyGvTPpNs7h4DCVP+TlRi2FiwvUduFjEJONwGjD9QfP7/ICXwg7
 2ACg==
X-Gm-Message-State: AOJu0YyLPSOrc7w44u/SODgjcM+9ZV133DNGsCu5XFpSAsB2KQCtdjJW
 JkLxaPfm0gdSij3659azVoGJviCIRnfemmi4iuJStw3oJZStP1x0ynCFeXb4HLVBgHE=
X-Gm-Gg: AeBDiessnuYUkkZMP09OQdUjIzLr2Ru0F0ojeBa9k1p3AHGpj3Ch/74MNuqwfQJMv4O
 FVcSq8dqaYysOGMLYHlTBZx0Pef9NubY3psjvkegw1RgVWLEy5MNgFnVZNmhyu393hjKWaEN7jS
 ABYXY+askB7ozwpXPivZxlcSetqtf7YjKL3DqedGO3knDLNjE+eSTtz48gplPH/rxL+3dwCZh/I
 CT1jUIdQacZFArk1rjukxvZV/4coByRula1RqTwbD4TIP725Cf6a38iM6mCQCCYS9lBWPC1sGo+
 gFRC39TRpLwCEpiFikUfxizFlj8+49jz4Nv3qaZht/sZJpuQZ3OIK7MhbCCj1DFIQPOi83c9gck
 Yy6gpq3TEeS/cEWOTAw0CPn8x4zg3PPTLMhXKDlxHCzQB+MkNThF3ieze+6Q6j6Vr5BEdSDrzuD
 pxuFIuTSyZMqdQitSPCoKD4dXbDdA5/VGyMfoeTn1kVILh0CtXbH9YyWccJGIkSnbp1EEfzXwu
X-Received: by 2002:a05:622a:409:b0:50e:89e6:669c with SMTP id
 d75a77b69052e-50e89e6697dmr246412661cf.37.1776971069405; 
 Thu, 23 Apr 2026 12:04:29 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:ac5d:4186:4dc6:47eb])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50fc9715610sm34624441cf.10.2026.04.23.12.04.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 12:04:29 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: patrickrobb1997@gmail.com, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v2 3/7] dts: move exception module from framework to API
Date: Thu, 23 Apr 2026 15:04:18 -0400
Message-ID: <20260423190424.41619-4-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260423190424.41619-1-dmarx@iol.unh.edu>
References: <20260423170331.33193-1-dmarx@iol.unh.edu>
 <20260423190424.41619-1-dmarx@iol.unh.edu>
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
 dts/api/test_suite.py                                  |  2 +-
 dts/api/testpmd/__init__.py                            |  2 +-
 dts/framework/config/__init__.py                       |  2 +-
 dts/framework/config/test_run.py                       |  2 +-
 dts/framework/context.py                               |  2 +-
 dts/framework/parser.py                                |  2 +-
 dts/framework/remote_session/dpdk.py                   |  2 +-
 .../remote_session/interactive_remote_session.py       |  2 +-
 dts/framework/remote_session/interactive_shell.py      |  6 +++---
 dts/framework/remote_session/remote_session.py         |  4 ++--
 dts/framework/runner.py                                |  2 +-
 dts/framework/test_result.py                           |  3 +--
 dts/framework/test_run.py                              |  4 ++--
 dts/framework/utils.py                                 |  2 +-
 dts/tests/TestSuite_cryptodev_throughput.py            |  2 +-
 dts/tests/TestSuite_dynamic_queue_conf.py              |  2 +-
 dts/tests/TestSuite_mac_filter.py                      |  2 +-
 dts/tests/TestSuite_pmd_rss.py                         |  2 +-
 dts/tests/TestSuite_rte_flow.py                        | 10 +++++-----
 26 files changed, 33 insertions(+), 34 deletions(-)
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
index 527cc8ce53..3b9ffab4ce 100644
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
index 025c87bbfa..02d807241f 100644
--- a/dts/api/artifact.py
+++ b/dts/api/artifact.py
@@ -47,8 +47,8 @@
 from paramiko import SFTPClient, SFTPFile
 from typing_extensions import Buffer
 
+from api.exception import InternalError
 from api.testbed_model.node import Node, NodeIdentifier, get_node
-from framework.exception import InternalError
 from framework.logger import DTSLogger, get_dts_logger
 from framework.settings import SETTINGS
 
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
index d30d455485..2bf31aa753 100644
--- a/dts/api/packet.py
+++ b/dts/api/packet.py
@@ -27,6 +27,7 @@
 from scapy.layers.l2 import Ether
 from scapy.packet import Packet, Padding, raw
 
+from api.exception import InternalError
 from api.test import fail, log_debug
 from api.testbed_model.traffic_generator.capturing_traffic_generator import (
     PacketFilteringConfig,
@@ -35,7 +36,6 @@
     PerformanceTrafficStats,
 )
 from framework.context import get_ctx
-from framework.exception import InternalError
 from framework.utils import get_packet_summaries
 
 
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
 
 
diff --git a/dts/api/test_suite.py b/dts/api/test_suite.py
index ebb07a9cae..be13485f9b 100644
--- a/dts/api/test_suite.py
+++ b/dts/api/test_suite.py
@@ -29,10 +29,10 @@
 from scapy.packet import Packet
 from typing_extensions import Self
 
+from api.exception import ConfigurationError, InternalError
 from api.testbed_model.capability import TestProtocol
 from api.testbed_model.topology import Topology
 from framework.config.common import FrozenModel
-from framework.exception import ConfigurationError, InternalError
 from framework.logger import DTSLogger, get_dts_logger
 from framework.utils import to_pascal_case
 
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
index 6f4f9d82f8..3a3580aaf7 100644
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
index 2c16a712eb..1b051fbadf 100644
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
index 618eb3dda7..7ed4cc5665 100644
--- a/dts/framework/context.py
+++ b/dts/framework/context.py
@@ -8,10 +8,10 @@
 from dataclasses import MISSING, dataclass, field, fields
 from typing import TYPE_CHECKING, Any, Optional, ParamSpec, Union
 
+from api.exception import InternalError
 from api.testbed_model.cpu import LogicalCoreCount, LogicalCoreList
 from api.testbed_model.node import Node
 from api.testbed_model.topology import Topology
-from framework.exception import InternalError
 from framework.remote_session.shell_pool import ShellPool
 from framework.settings import SETTINGS
 
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
index c955f4def2..91173e0796 100644
--- a/dts/framework/remote_session/dpdk.py
+++ b/dts/framework/remote_session/dpdk.py
@@ -13,6 +13,7 @@
 from pathlib import Path, PurePath
 from typing import ClassVar, Final
 
+from api.exception import ConfigurationError, RemoteFileNotFoundError
 from api.testbed_model.cpu import LogicalCore, LogicalCoreCount, LogicalCoreList, lcore_filter
 from api.testbed_model.node import Node
 from api.testbed_model.os_session import OSSession
@@ -29,7 +30,6 @@
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
index 23d05fbdff..15743949e7 100644
--- a/dts/framework/remote_session/interactive_shell.py
+++ b/dts/framework/remote_session/interactive_shell.py
@@ -29,13 +29,13 @@
 from paramiko import Channel, channel
 from typing_extensions import Self
 
-from api.testbed_model.node import Node
-from framework.context import get_ctx
-from framework.exception import (
+from api.exception import (
     InteractiveCommandExecutionError,
     InteractiveSSHSessionDeadError,
     InteractiveSSHTimeoutError,
 )
+from api.testbed_model.node import Node
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
index 0e245a515b..29be7b80fe 100644
--- a/dts/framework/runner.py
+++ b/dts/framework/runner.py
@@ -12,9 +12,9 @@
 import sys
 import textwrap
 
+from api.exception import ConfigurationError
 from api.testbed_model.node import Node
 from framework.config.common import ValidationContext
-from framework.exception import ConfigurationError
 from framework.test_run import TestRun
 
 from .config import Configuration, load_config
diff --git a/dts/framework/test_result.py b/dts/framework/test_result.py
index e2efff8681..5f945163ce 100644
--- a/dts/framework/test_result.py
+++ b/dts/framework/test_result.py
@@ -35,12 +35,11 @@
 )
 from typing_extensions import OrderedDict
 
+from api.exception import DTSError, ErrorSeverity, InternalError
 from api.testbed_model.os_session import OSSessionInfo
 from framework.remote_session.dpdk import DPDKBuildInfo
 from framework.settings import SETTINGS
 
-from .exception import DTSError, ErrorSeverity, InternalError
-
 
 class Result(IntEnum):
     """The possible states that a setup, a teardown or a test case may end up in."""
diff --git a/dts/framework/test_run.py b/dts/framework/test_run.py
index 14c04d1ce0..9972d26b04 100644
--- a/dts/framework/test_run.py
+++ b/dts/framework/test_run.py
@@ -106,6 +106,7 @@
 from types import MethodType
 from typing import ClassVar, Protocol, Union
 
+from api.exception import InternalError, SkippedTestException, TestCaseVerifyError
 from api.test_suite import BaseConfig, TestCase, TestCaseType, TestSuite
 from api.testbed_model.capability import (
     Capability,
@@ -117,7 +118,6 @@
 from api.testbed_model.traffic_generator import create_traffic_generator
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
index 83ce94d4df..fb6fda3bac 100644
--- a/dts/tests/TestSuite_cryptodev_throughput.py
+++ b/dts/tests/TestSuite_cryptodev_throughput.py
@@ -29,11 +29,11 @@
 from api.cryptodev.types import (
     CryptodevResults,
 )
+from api.exception import SkippedTestException
 from api.test import verify
 from api.test_suite import BaseConfig, TestSuite, crypto_test
 from api.testbed_model.virtual_device import VirtualDevice
 from framework.context import get_ctx
-from framework.exception import SkippedTestException
 
 config_list: list[dict[str, int | float | str]] = [
     {"buff_size": 64, "Gbps": 1.00},
diff --git a/dts/tests/TestSuite_dynamic_queue_conf.py b/dts/tests/TestSuite_dynamic_queue_conf.py
index e0ef1f447a..24584c7d60 100644
--- a/dts/tests/TestSuite_dynamic_queue_conf.py
+++ b/dts/tests/TestSuite_dynamic_queue_conf.py
@@ -35,12 +35,12 @@
     NicCapability,
     requires_nic_capability,
 )
+from api.exception import InteractiveCommandExecutionError
 from api.packet import send_packets
 from api.test import fail, verify
 from api.test_suite import TestSuite, func_test
 from api.testpmd import TestPmd
 from api.testpmd.config import PortTopology, SimpleForwardingModes
-from framework.exception import InteractiveCommandExecutionError
 
 
 def setup_and_teardown_test(
diff --git a/dts/tests/TestSuite_mac_filter.py b/dts/tests/TestSuite_mac_filter.py
index 98c12459f6..eb1413f336 100644
--- a/dts/tests/TestSuite_mac_filter.py
+++ b/dts/tests/TestSuite_mac_filter.py
@@ -23,11 +23,11 @@
     NicCapability,
     requires_nic_capability,
 )
+from api.exception import InteractiveCommandExecutionError
 from api.packet import send_packet_and_capture
 from api.test import fail, verify
 from api.test_suite import TestSuite, func_test
 from api.testpmd import TestPmd
-from framework.exception import InteractiveCommandExecutionError
 
 
 @requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
diff --git a/dts/tests/TestSuite_pmd_rss.py b/dts/tests/TestSuite_pmd_rss.py
index 8777d446cd..dae90ee2d5 100644
--- a/dts/tests/TestSuite_pmd_rss.py
+++ b/dts/tests/TestSuite_pmd_rss.py
@@ -20,6 +20,7 @@
     requires_link_topology,
     requires_nic_capability,
 )
+from api.exception import InteractiveCommandExecutionError
 from api.packet import send_packets_and_capture
 from api.test import verify
 from api.test_suite import BaseConfig, TestSuite, func_test
@@ -30,7 +31,6 @@
     RSSOffloadTypesFlag,
     TestPmdVerbosePacket,
 )
-from framework.exception import InteractiveCommandExecutionError
 from framework.utils import StrEnum
 
 
diff --git a/dts/tests/TestSuite_rte_flow.py b/dts/tests/TestSuite_rte_flow.py
index 3d74decb11..8c5c59edec 100644
--- a/dts/tests/TestSuite_rte_flow.py
+++ b/dts/tests/TestSuite_rte_flow.py
@@ -21,16 +21,16 @@
 from scapy.packet import Packet, Raw
 
 from api.capabilities import NicCapability, requires_nic_capability
+from api.exception import (
+    InteractiveCommandExecutionError,
+    SkippedTestException,
+    TestCaseVerifyError,
+)
 from api.packet import send_packet_and_capture
 from api.test import fail, log, verify
 from api.test_suite import TestSuite, func_test
 from api.testpmd import TestPmd
 from api.testpmd.types import FlowRule
-from framework.exception import (
-    InteractiveCommandExecutionError,
-    SkippedTestException,
-    TestCaseVerifyError,
-)
 
 
 @dataclass
-- 
2.52.0

