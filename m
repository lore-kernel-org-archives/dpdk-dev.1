Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B200C5AC7C
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 17:50:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1F2C640658;
	Thu,  6 Aug 2026 19:50:53 +0200 (CEST)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com
 [209.85.222.170])
 by mails.dpdk.org (Postfix) with ESMTP id 31CCD4064A
 for <dev@dpdk.org>; Thu,  6 Aug 2026 19:50:52 +0200 (CEST)
Received: by mail-qk1-f170.google.com with SMTP id
 af79cd13be357-934956bee57so229030185a.2
 for <dev@dpdk.org>; Thu, 06 Aug 2026 10:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1786038651; x=1786643451; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NFKPg9yUyy0JR2r1pKCcE60JdKz2HjhAqpupwaZeFcw=;
 b=OzWS3BTXmU8hmhBDw67/lxITDkrFtiUjQbHy2b4MVrSfhDpUhAJqQPcnR6CfwExH7S
 PM8NQANBvnos/F3mAn9GN1vqB7FC/WJBUovJal71mP+lYlLO2QdZBBjPtdwoxugVJeHv
 wK/dUF9YqkLvz/8c/wag0vFRGHz9nkKkKotWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786038651; x=1786643451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=NFKPg9yUyy0JR2r1pKCcE60JdKz2HjhAqpupwaZeFcw=;
 b=CrWk6grRgne2og13EP8HSWQlFHX+hC3Qx+Aldpdl8zrV3Ns6QuJ0IQIU1N7u6QZAim
 1Uedlwh4QnwsLdmCqNq9M49BaXRMT0sI55HK0elgL1yrfFgPzIF19nr3Fa0ZvcSfjk9N
 H91YIY6hom0xlldrW85uYj1klsOmKKrLw0+OC7U2gbAvs/ylkDR5kt+/DKtDJPPsyh43
 cRwY7TneKIpvjOo5xYJVCatnLm2Pw0VQaaqsqaO57V1qy+pAWmroQSgQPsKw2elQP2YN
 TnGuPGebDI8lpcEonKQLNs9vKN67/stBIH1m3bN1Y/T5ZmZ9/VihA+qrEkG6GBEmQ2cy
 9Ehg==
X-Gm-Message-State: AOJu0YzCNt5PZ4sb72re5gXPwXEwTWJ51HmLGNz6XgeN0bGXukG4z5Bi
 vIj/02VWiswF1aWuuDEUuvKvXPCKuo6XChvb1dSmRN16VEFv3M85zDIjd/2bG0mltnRPB4YeHtP
 u98JKRTw9QeFFw0kTYnQeavtCg8ezYw79AxLpERSN61iCtTO/cUf8evo9OBaF5q+f4Jvly9NByl
 u5brGCIKWSz2PVh8m37QZztT2dc9E=
X-Gm-Gg: AR+sD11cemAfW2mpN+CK4iCdCnUy8iEzMxRsO1gl/EHp44+d/SA3zp4VbYyFCM/lKCl
 KKRPjKDEf10gsK9iJQJJG2jN8EApwpUQ8aHz4m7HmhsWneJ3nMR4vX0ytZiN8nrY4J9QKCR0U64
 t2hDO3khSR3gVvighR3PXhAoRajPhJGdGrp0V6PEDVA9Mh72FYzA5VYigouujGHBpsKiWEMc/87
 s+1KWRsJGzliq3BeEsPj32nSOEf7FRzbXuReIZy8zyAyBxVTIidAxaymdaXqeLzt8ZxidBYoh0o
 fa4EkrJuXu5wih6eOwkFKgjZBt0gjJS/lW/wNoahsv1i+42hmkdPfn5mCDZY5fmLwuw63HQvo+O
 m/PMYd3P19RTnFNigjXlIDF8NYpzDYm9JyLl91rEmgbNrOU5KIRhmd0IirBg+fZSpTVJ04D+N2q
 TYnXs1gododHGaeDkkWpjRZVJzjdAre/InVAcu7S0VAhsyVNVmKdFq01/h7Vxp5u88fFqiGpWl9
 Rv1vjcs1c6+wRhBUDVeUQU+6/GqefD5YuxwcXsz
X-Received: by 2002:a05:620a:ab06:b0:920:4f78:3d7 with SMTP id
 af79cd13be357-9364901d521mr1691194285a.3.1786038651007; 
 Thu, 06 Aug 2026 10:50:51 -0700 (PDT)
Received: from syn-2603-7083-bff0-a0d0-0000-0000-0000-1a64.res6.spectrum.com
 ([2606:4100:3880:1257::1039]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93657688090sm317311285a.27.2026.08.06.10.50.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 10:50:50 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: dev@dpdk.org,
	luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: knimoji@iol.unh.edu, lylavoie@iol.unh.edu, dladd@iol.unh.edu,
 Andrew Bailey <abailey@iol.unh.edu>, Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v6 1/7] dts: move exception module from framework to API
Date: Thu,  6 Aug 2026 13:50:18 -0400
Message-ID: <20260806175024.13655-2-abailey@iol.unh.edu>
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

Multiple test suites currently import the exception module
from the framework in order to catch certain errors during
test execution. Move this to the API.

Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
---
 ...mework.exception.rst => api.exception.rst} |  2 +-
 doc/api/dts/index.rst                         |  2 +-
 dts/api/artifact.py                           |  2 +-
 dts/api/cryptodev/__init__.py                 |  2 +-
 dts/{framework => api}/exception.py           |  0
 dts/api/packet.py                             |  2 +-
 dts/api/test.py                               |  2 +-
 dts/api/testpmd/__init__.py                   |  2 +-
 dts/framework/config/__init__.py              |  2 +-
 dts/framework/config/test_run.py              |  2 +-
 dts/framework/context.py                      |  2 +-
 dts/framework/parser.py                       |  2 +-
 dts/framework/remote_session/dpdk.py          |  2 +-
 .../interactive_remote_session.py             |  2 +-
 .../remote_session/interactive_shell.py       |  4 +-
 .../remote_session/remote_session.py          |  4 +-
 dts/framework/runner.py                       |  2 +-
 dts/framework/test_result.py                  |  3 +-
 dts/framework/test_run.py                     |  4 +-
 dts/framework/test_suite.py                   |  2 +-
 dts/framework/testbed_model/capability.py     |  2 +-
 dts/framework/testbed_model/linux_session.py  |  2 +-
 dts/framework/testbed_model/node.py           |  2 +-
 dts/framework/testbed_model/port.py           |  2 +-
 dts/framework/testbed_model/posix_session.py  |  2 +-
 dts/framework/testbed_model/topology.py       |  2 +-
 .../traffic_generator/__init__.py             |  2 +-
 .../testbed_model/traffic_generator/scapy.py  |  2 +-
 .../testbed_model/traffic_generator/trex.py   |  2 +-
 dts/framework/utils.py                        |  2 +-
 dts/tests/TestSuite_cryptodev_throughput.py   | 83 ++++---------------
 dts/tests/TestSuite_dynamic_queue_conf.py     |  2 +-
 dts/tests/TestSuite_flow_offload.py           | 10 +--
 dts/tests/TestSuite_mac_filter.py             |  2 +-
 dts/tests/TestSuite_rss.py                    |  2 +-
 dts/tests/TestSuite_rx_split.py               |  2 +-
 36 files changed, 58 insertions(+), 108 deletions(-)
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
index 15cffcb409..335b811620 100644
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
index 3dda18e781..eaecf205f7 100644
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
index 7947c407d2..29d6842111 100644
--- a/dts/api/test.py
+++ b/dts/api/test.py
@@ -11,8 +11,8 @@
 
 from api.artifact import Artifact
 from api.capabilities import LinkTopology
+from api.exception import InternalError, SkippedTestException, TestCaseVerifyError
 from framework.context import get_ctx
-from framework.exception import InternalError, SkippedTestException, TestCaseVerifyError
 from framework.logger import DTSLogger
 
 
diff --git a/dts/api/testpmd/__init__.py b/dts/api/testpmd/__init__.py
index b41a21300e..fef7430cb8 100644
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
index 573f55471a..e24a351ecf 100644
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
index 81630df77d..9aa0938d4e 100644
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
index b1c36f90a6..709b99421e 100644
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
index e43e1f2123..0618855fc5 100644
--- a/dts/framework/remote_session/dpdk.py
+++ b/dts/framework/remote_session/dpdk.py
@@ -14,6 +14,7 @@
 from typing import ClassVar, Final
 
 from api.capabilities import LinkTopology
+from api.exception import ConfigurationError, RemoteFileNotFoundError
 from framework.config.test_run import (
     DPDKBuildConfiguration,
     DPDKBuildOptionsConfiguration,
@@ -26,7 +27,6 @@
     RemoteDPDKTreeLocation,
 )
 from framework.context import get_ctx
-from framework.exception import ConfigurationError, RemoteFileNotFoundError
 from framework.logger import DTSLogger, get_dts_logger
 from framework.params.eal import EalParams
 from framework.remote_session.remote_session import CommandResult
diff --git a/dts/framework/remote_session/interactive_remote_session.py b/dts/framework/remote_session/interactive_remote_session.py
index fc42e862bc..3c1f00aab2 100644
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
index 6bba58a4f6..367a01714d 100644
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
index fb5f6fedf5..95515c9ee2 100644
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
index fa4f06844e..cb137fbf7b 100644
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
index c20a0fa885..75d82c1104 100644
--- a/dts/framework/test_run.py
+++ b/dts/framework/test_run.py
@@ -108,9 +108,9 @@
 from typing import ClassVar, Protocol, Union
 
 from api.capabilities import LinkTopology
+from api.exception import InternalError, SkippedTestException, TestCaseVerifyError
 from framework.config.test_run import TestRunConfiguration
 from framework.context import Context, init_ctx
-from framework.exception import InternalError, SkippedTestException, TestCaseVerifyError
 from framework.logger import DTSLogger, get_dts_logger
 from framework.remote_session.dpdk import DPDKBuildEnvironment, DPDKRuntimeEnvironment
 from framework.settings import SETTINGS
@@ -138,7 +138,7 @@ class TestRun:
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
index b10799ea4b..00b40a3b1e 100644
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
index c118f803b6..4495ae35cf 100644
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
index 1db444fc01..002faf0b7f 100644
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
index 62853a34e4..70856cc1f0 100644
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
diff --git a/dts/framework/testbed_model/traffic_generator/trex.py b/dts/framework/testbed_model/traffic_generator/trex.py
index d53791b0a6..2c3beebc59 100644
--- a/dts/framework/testbed_model/traffic_generator/trex.py
+++ b/dts/framework/testbed_model/traffic_generator/trex.py
@@ -11,9 +11,9 @@
 
 from scapy.packet import Packet
 
+from api.exception import SSHTimeoutError
 from framework.config.node import OS, NodeConfiguration
 from framework.config.test_run import TrexTrafficGeneratorConfig
-from framework.exception import SSHTimeoutError
 from framework.parser import TextParser
 from framework.remote_session.blocking_app import BlockingApp
 from framework.remote_session.python_shell import PythonShell
diff --git a/dts/framework/utils.py b/dts/framework/utils.py
index 5753c1b7fe..235f4bf426 100644
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
index 2fc0d8779a..53682f35fa 100644
--- a/dts/tests/TestSuite_cryptodev_throughput.py
+++ b/dts/tests/TestSuite_cryptodev_throughput.py
@@ -29,9 +29,8 @@
 from api.cryptodev.types import (
     CryptodevResults,
 )
-from api.test import verify
+from api.test import skip, verify
 from framework.context import get_ctx
-from framework.exception import SkippedTestException
 from framework.test_suite import BaseConfig, TestSuite, crypto_test
 from framework.testbed_model.virtual_device import VirtualDevice
 
@@ -153,12 +152,9 @@ def aes_cbc(self) -> None:
             * Create a cryptodev instance with provided device type and buffer sizes.
         Verify:
             * The resulting Gbps is greater than expected_gbps*(1-delta_tolerance).
-
-        Raises:
-            SkippedTestException: When configuration is not provided.
         """
         if "aes_cbc" not in self.throughput_test_parameters:
-            raise SkippedTestException("test not configured")
+            skip("test not configured")
         app = Cryptodev(
             ptest=TestType.throughput,
             devtype=self.device_type,
@@ -183,12 +179,9 @@ def aes_cbc_sha1(self) -> None:
             * Create a cryptodev instance with provided device type and buffer sizes.
         Verify:
             * The resulting Gbps is greater than expected_gbps*(1-delta_tolerance).
-
-        Raises:
-            SkippedTestException: When configuration is not provided.
         """
         if "aes_cbc_sha1" not in self.throughput_test_parameters:
-            raise SkippedTestException("test not configured")
+            skip("test not configured")
         app = Cryptodev(
             ptest=TestType.throughput,
             devtype=self.device_type,
@@ -218,12 +211,9 @@ def aes_cbc_sha2(self) -> None:
             * Create a cryptodev instance with provided device type and buffer sizes.
         Verify:
             * The resulting Gbps is greater than expected_gbps*(1-delta_tolerance).
-
-        Raises:
-            SkippedTestException: When configuration is not provided.
         """
         if "aes_cbc_sha2" not in self.throughput_test_parameters:
-            raise SkippedTestException("test not configured")
+            skip("test not configured")
         app = Cryptodev(
             ptest=TestType.throughput,
             devtype=self.device_type,
@@ -252,12 +242,9 @@ def aes_cbc_sha2_digest_16(self) -> None:
             * Create a cryptodev instance with provided device type and buffer sizes.
         Verify:
             * The resulting Gbps is greater than expected_gbps*(1-delta_tolerance).
-
-        Raises:
-            SkippedTestException: When configuration is not provided.
         """
         if "aes_cbc_sha2_digest_16" not in self.throughput_test_parameters:
-            raise SkippedTestException("test not configured")
+            skip("test not configured")
         app = Cryptodev(
             ptest=TestType.throughput,
             devtype=self.device_type,
@@ -286,12 +273,9 @@ def aead_aes_gcm(self) -> None:
             * Create a cryptodev instance with provided device type and buffer sizes.
         Verify:
             * The resulting Gbps is greater than expected_gbps*(1-delta_tolerance).
-
-        Raises:
-            SkippedTestException: When configuration is not provided.
         """
         if "aead_aes_gcm" not in self.throughput_test_parameters:
-            raise SkippedTestException("test not configured")
+            skip("test not configured")
         app = Cryptodev(
             ptest=TestType.throughput,
             devtype=self.device_type,
@@ -318,12 +302,9 @@ def aes_docsisbpi(self) -> None:
             * Create a cryptodev instance with provided device type and buffer sizes.
         Verify:
             * The resulting Gbps is greater than expected_gbps*(1-delta_tolerance).
-
-        Raises:
-            SkippedTestException: When configuration is not provided.
         """
         if "aes_docsisbpi" not in self.throughput_test_parameters:
-            raise SkippedTestException("test not configured")
+            skip("test not configured")
         app = Cryptodev(
             ptest=TestType.throughput,
             devtype=self.device_type,
@@ -348,12 +329,9 @@ def sha1_hmac(self) -> None:
             * Create a cryptodev instance with provided device type and buffer sizes.
         Verify:
             * The resulting Gbps is greater than expected_gbps*(1-delta_tolerance).
-
-        Raises:
-            SkippedTestException: When configuration is not provided.
         """
         if "sha1_hmac" not in self.throughput_test_parameters:
-            raise SkippedTestException("test not configured")
+            skip("test not configured")
         app = Cryptodev(
             ptest=TestType.throughput,
             devtype=self.device_type,
@@ -379,12 +357,9 @@ def snow3g_uea2_snow3g_uia2(self) -> None:
             * Create a cryptodev instance with provided device type and buffer sizes.
         Verify:
             * The resulting Gbps is greater than expected_gbps*(1-delta_tolerance).
-
-        Raises:
-            SkippedTestException: When configuration is not provided.
         """
         if "snow3g_uea2_snow3g_uia2" not in self.throughput_test_parameters:
-            raise SkippedTestException("test not configured")
+            skip("test not configured")
         app = Cryptodev(
             ptest=TestType.throughput,
             devtype=self.device_type,
@@ -414,12 +389,9 @@ def zuc_eea3_zuc_eia3(self) -> None:
             * Create a cryptodev instance with provided device type and buffer sizes.
         Verify:
             * The resulting Gbps is greater than expected_gbps*(1-delta_tolerance).
-
-        Raises:
-            SkippedTestException: When configuration is not provided.
         """
         if "zuc_eea3_zuc_eia3" not in self.throughput_test_parameters:
-            raise SkippedTestException("test not configured")
+            skip("test not configured")
         app = Cryptodev(
             ptest=TestType.throughput,
             devtype=self.device_type,
@@ -449,12 +421,9 @@ def kasumi_f8_kasumi_f9(self) -> None:
             * Create a cryptodev instance with provided device type and buffer sizes.
         Verify:
             * The resulting Gbps is greater than expected_gbps*(1-delta_tolerance).
-
-        Raises:
-            SkippedTestException: When configuration is not provided.
         """
         if "kasumi_f8_kasumi_f9" not in self.throughput_test_parameters:
-            raise SkippedTestException("test not configured")
+            skip("test not configured")
         app = Cryptodev(
             ptest=TestType.throughput,
             devtype=self.device_type,
@@ -486,12 +455,9 @@ def aesni_mb_vdev(self) -> None:
             * Create a cryptodev instance with crypto_aesni_mb and supplied buffer sizes.
         Verify:
             * The resulting Gbps is greater than expected_gbps*(1-delta_tolerance).
-
-        Raises:
-            SkippedTestException: When configuration is not provided.
         """
         if "aesni_mb_vdev" not in self.throughput_test_parameters:
-            raise SkippedTestException("test not configured")
+            skip("test not configured")
         app = Cryptodev(
             ptest=TestType.throughput,
             vdevs=[VirtualDevice("crypto_aesni_mb0")],
@@ -523,12 +489,9 @@ def aesni_gcm_vdev(self):
             * Create a cryptodev instance with crypto_aesni_gcm and supplied buffer sizes.
         Verify:
             * The resulting Gbps is greater than expected_gbps*(1-delta_tolerance).
-
-        Raises:
-            SkippedTestException: When configuration is not provided.
         """
         if "aesni_gcm_vdev" not in self.throughput_test_parameters:
-            raise SkippedTestException("test not configured")
+            skip("test not configured")
         app = Cryptodev(
             ptest=TestType.throughput,
             vdevs=[VirtualDevice("crypto_aesni_gcm0")],
@@ -556,12 +519,9 @@ def kasumi_vdev(self) -> None:
             * Create a cryptodev instance with crypto_kasumi and supplied buffer sizes.
         Verify:
             * The resulting Gbps is greater than expected_gbps*(1-delta_tolerance).
-
-        Raises:
-            SkippedTestException: When configuration is not provided.
         """
         if "kasumi_vdev" not in self.throughput_test_parameters:
-            raise SkippedTestException("test not configured")
+            skip("test not configured")
         app = Cryptodev(
             vdevs=[VirtualDevice("crypto_kasumi0")],
             ptest=TestType.throughput,
@@ -592,12 +552,9 @@ def snow3g_vdev(self) -> None:
             * Create a cryptodev instance with crypto_snow3g and supplied buffer sizes.
         Verify:
             * The resulting Gbps is greater than expected_gbps*(1-delta_tolerance).
-
-        Raises:
-            SkippedTestException: When configuration is not provided.
         """
         if "snow3g_vdev" not in self.throughput_test_parameters:
-            raise SkippedTestException("test not configured")
+            skip("test not configured")
         app = Cryptodev(
             ptest=TestType.throughput,
             vdevs=[VirtualDevice("crypto_snow3g0")],
@@ -629,12 +586,9 @@ def zuc_vdev(self) -> None:
             * Create a cryptodev instance with crypto_zuc and supplied buffer sizes.
         Verify:
             * The resulting Gbps is greater than expected_gbps*(1-delta_tolerance).
-
-        Raises:
-            SkippedTestException: When configuration is not provided.
         """
         if "zuc_vdev" not in self.throughput_test_parameters:
-            raise SkippedTestException("test not configured")
+            skip("test not configured")
         app = Cryptodev(
             ptest=TestType.throughput,
             vdevs=[VirtualDevice("crypto_zuc0")],
@@ -666,12 +620,9 @@ def open_ssl_vdev(self) -> None:
             * Create a cryptodev instance with provided device type and buffer sizes.
         Verify:
             * The resulting Gbps is greater than expected_gbps*(1-delta_tolerance).
-
-        Raises:
-            SkippedTestException: When configuration is not provided.
         """
         if "open_ssl_vdev" not in self.throughput_test_parameters:
-            raise SkippedTestException("test not configured")
+            skip("test not configured")
         app = Cryptodev(
             ptest=TestType.throughput,
             vdevs=[VirtualDevice("crypto_openssl0")],
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
 
 
diff --git a/dts/tests/TestSuite_flow_offload.py b/dts/tests/TestSuite_flow_offload.py
index be11d09875..5902406a8e 100644
--- a/dts/tests/TestSuite_flow_offload.py
+++ b/dts/tests/TestSuite_flow_offload.py
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
 
 
diff --git a/dts/tests/TestSuite_rss.py b/dts/tests/TestSuite_rss.py
index 2747c8a36c..1af0782ffc 100644
--- a/dts/tests/TestSuite_rss.py
+++ b/dts/tests/TestSuite_rss.py
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
 
diff --git a/dts/tests/TestSuite_rx_split.py b/dts/tests/TestSuite_rx_split.py
index 5117a569e2..470e48d0d3 100644
--- a/dts/tests/TestSuite_rx_split.py
+++ b/dts/tests/TestSuite_rx_split.py
@@ -18,12 +18,12 @@
     NicCapability,
     requires_nic_capability,
 )
+from api.exception import InteractiveCommandExecutionError
 from api.packet import adjust_addresses, send_packet_and_capture
 from api.test import fail, verify
 from api.testpmd import TestPmd
 from api.testpmd.config import SimpleForwardingModes
 from api.testpmd.types import RxOffloadCapability, TxOffloadCapability
-from framework.exception import InteractiveCommandExecutionError
 from framework.test_suite import TestSuite, func_test
 
 PAYLOAD = bytes(range(256))
-- 
2.55.0

