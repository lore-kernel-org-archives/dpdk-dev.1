Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED84FDEE27
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Apr 2026 17:04:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EC05440662;
	Thu, 23 Apr 2026 19:03:42 +0200 (CEST)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com
 [209.85.222.180])
 by mails.dpdk.org (Postfix) with ESMTP id 2211140649
 for <dev@dpdk.org>; Thu, 23 Apr 2026 19:03:39 +0200 (CEST)
Received: by mail-qk1-f180.google.com with SMTP id
 af79cd13be357-8c70b5594f4so757564485a.1
 for <dev@dpdk.org>; Thu, 23 Apr 2026 10:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1776963818; x=1777568618; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0xh1A+kSzq9yqZu+seBo9gglsQT7aNDbof/YF49RSvg=;
 b=Pa0seynHqnsOjEKDJvFhs7poctLOnZa8weBv93kbcRYmlkmuCGf7N0n3MTMhyHbYeu
 mFMu27DTt3pFwk8CpLJnRX89Zb6tqaYZLT1i3zgLbs9Ry0V6OCXVtRpEDqmuxNEqnkZD
 JbI29ae4b8W4xnTEEGW8fRf2H5QelKzcf1ifU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776963818; x=1777568618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0xh1A+kSzq9yqZu+seBo9gglsQT7aNDbof/YF49RSvg=;
 b=YQhvkrR4dClongHYTBsZF89O7IO6RcQqbgYXhFsf6G5/b1KlwqUTvK1HTCFNXopxEq
 QFjLaQe7MFmbqQYiwZ9LZEo2SQ5acVMggNY29VHplzQQXEy/bkLhLe2A/AP2Bm0hpPrw
 0MxPPFk2obLT/TOzkNdiiT4y6FSb3Xlz0vbH2QzJNMTBi6BzRvrv3DLLRPchNeo0ftHy
 nkFHrSOO9f7lZ1snjh6pt5fdJCTb6XB/9eC2nI95ulSjueP5adT3/EW9g8MtX7lqD9SL
 kCIwRiwFFOziSI9ERtsgIVLjd44x3Nm1zgNnaIU1yKE/J0ZOqCvvA8aFm6CBHovU74DY
 sK6Q==
X-Gm-Message-State: AOJu0Yx9VQZYcalSmezYdBocE00d5x0am4pEHJ01VTOLCEAUUsZMP0Of
 SEzzZDltYtXOFYtmFhOEQfNqUludda+AW8GjTTf6Cv7BhbGv9QLWcsQ9MIjAInyMQBY=
X-Gm-Gg: AeBDietkUgxQRni5v8GPuShMy7vJb0Y4o+o8sbj/C/0KfQ0G1PtlEQ8TYcCeZR6ec+o
 0DaEuLCsmUyCRtf64VnaF6/UPzFOIU0b0DgQhCHRwe5Lc9eD1MPiVKoc8YbpYvsRVRk+fY1T+bx
 wd1doVFRakisXlQGKhHP9W+K1HlsbZM302fVS9Ph9kLkhF+F1EPZOTmT6gOqOKPaC+bB9UVR0uv
 eOBjwacf3RxMgGfWreuXiSmrlckanZNqZTZgiheXys+l2fTVXDLe2syuTejNfajGaL8u14h33IP
 0eF2X3pKUiJhKs/RTNjflW7vnpNWkTw0oq6LGMW9HsLa8hv3wTHj3vaKs/YptdZV4pl6VU5KMv+
 KWhaeNZTfpAiI2TkJVZnK7goTp6z4818+yW9IBAcKpOWh6fElOBRXVTs97lYCUTsldiKWU/9Me9
 uW1QT5RBOuhm4sJuznGX4o6CqwJpkAD5asawu7vZRPN6u/OPi6HQUMkChRWymtisfAy4+jwxFM
X-Received: by 2002:a05:620a:7010:b0:8dd:a1f:883b with SMTP id
 af79cd13be357-8e78bdeb09cmr3452631885a.22.1776963818328; 
 Thu, 23 Apr 2026 10:03:38 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:ac5d:4186:4dc6:47eb])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8e7d8edb734sm1869831585a.29.2026.04.23.10.03.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 10:03:37 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: patrickrobb1997@gmail.com, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v1 4/8] dts: move utils from framework to API
Date: Thu, 23 Apr 2026 13:03:16 -0400
Message-ID: <20260423170331.33193-5-dmarx@iol.unh.edu>
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

The utils module is used to generate a set of random
packets in certain test suites. Move this to the API.

Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
---
 dts/api/cryptodev/config.py          | 2 +-
 dts/api/packet.py                    | 2 +-
 dts/api/test_suite.py                | 2 +-
 dts/api/testpmd/config.py            | 2 +-
 dts/api/testpmd/types.py             | 2 +-
 dts/{framework => api}/utils.py      | 0
 dts/framework/config/node.py         | 2 +-
 dts/framework/config/test_run.py     | 2 +-
 dts/framework/remote_session/dpdk.py | 2 +-
 dts/tests/TestSuite_l2fwd.py         | 2 +-
 dts/tests/TestSuite_pmd_rss.py       | 2 +-
 dts/tests/TestSuite_smoke_tests.py   | 2 +-
 dts/tests/TestSuite_softnic.py       | 2 +-
 13 files changed, 12 insertions(+), 12 deletions(-)
 rename dts/{framework => api}/utils.py (100%)

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
index 2bf31aa753..2be00ad48a 100644
--- a/dts/api/packet.py
+++ b/dts/api/packet.py
@@ -35,8 +35,8 @@
 from api.testbed_model.traffic_generator.performance_traffic_generator import (
     PerformanceTrafficStats,
 )
+from api.utils import get_packet_summaries
 from framework.context import get_ctx
-from framework.utils import get_packet_summaries
 
 
 def send_packet_and_capture(
diff --git a/dts/api/test_suite.py b/dts/api/test_suite.py
index be13485f9b..7feb35a9f8 100644
--- a/dts/api/test_suite.py
+++ b/dts/api/test_suite.py
@@ -32,9 +32,9 @@
 from api.exception import ConfigurationError, InternalError
 from api.testbed_model.capability import TestProtocol
 from api.testbed_model.topology import Topology
+from api.utils import to_pascal_case
 from framework.config.common import FrozenModel
 from framework.logger import DTSLogger, get_dts_logger
-from framework.utils import to_pascal_case
 
 if TYPE_CHECKING:
     from framework.context import Context
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
index 63062a31b5..d7122d13d8 100644
--- a/dts/framework/config/node.py
+++ b/dts/framework/config/node.py
@@ -14,7 +14,7 @@
 from pydantic import Field, model_validator
 from typing_extensions import Self
 
-from framework.utils import REGEX_FOR_IDENTIFIER, REGEX_FOR_PCI_ADDRESS, StrEnum
+from api.utils import REGEX_FOR_IDENTIFIER, REGEX_FOR_PCI_ADDRESS, StrEnum
 
 from .common import FrozenModel
 
diff --git a/dts/framework/config/test_run.py b/dts/framework/config/test_run.py
index 1b051fbadf..10901c740d 100644
--- a/dts/framework/config/test_run.py
+++ b/dts/framework/config/test_run.py
@@ -28,7 +28,7 @@
 from typing_extensions import TYPE_CHECKING, Self
 
 from api.exception import InternalError
-from framework.utils import REGEX_FOR_PORT_LINK, StrEnum
+from api.utils import REGEX_FOR_PORT_LINK, StrEnum
 
 from .common import FrozenModel, load_fields_from_settings
 
diff --git a/dts/framework/remote_session/dpdk.py b/dts/framework/remote_session/dpdk.py
index 91173e0796..1a4fec8ec9 100644
--- a/dts/framework/remote_session/dpdk.py
+++ b/dts/framework/remote_session/dpdk.py
@@ -18,6 +18,7 @@
 from api.testbed_model.node import Node
 from api.testbed_model.os_session import OSSession
 from api.testbed_model.virtual_device import VirtualDevice
+from api.utils import MesonArgs, TarCompressionFormat
 from framework.config.test_run import (
     DPDKBuildConfiguration,
     DPDKBuildOptionsConfiguration,
@@ -33,7 +34,6 @@
 from framework.logger import DTSLogger, get_dts_logger
 from framework.params.eal import EalParams
 from framework.remote_session.remote_session import CommandResult
-from framework.utils import MesonArgs, TarCompressionFormat
 
 
 @dataclass(slots=True, frozen=True)
diff --git a/dts/tests/TestSuite_l2fwd.py b/dts/tests/TestSuite_l2fwd.py
index 63f771d594..0b0b7bc931 100644
--- a/dts/tests/TestSuite_l2fwd.py
+++ b/dts/tests/TestSuite_l2fwd.py
@@ -22,8 +22,8 @@
 from api.testbed_model.cpu import LogicalCoreCount
 from api.testpmd import TestPmd
 from api.testpmd.config import EthPeer, SimpleForwardingModes
+from api.utils import generate_random_packets
 from framework.context import filter_cores
-from framework.utils import generate_random_packets
 
 
 @requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
diff --git a/dts/tests/TestSuite_pmd_rss.py b/dts/tests/TestSuite_pmd_rss.py
index dae90ee2d5..162e08ccbc 100644
--- a/dts/tests/TestSuite_pmd_rss.py
+++ b/dts/tests/TestSuite_pmd_rss.py
@@ -31,7 +31,7 @@
     RSSOffloadTypesFlag,
     TestPmdVerbosePacket,
 )
-from framework.utils import StrEnum
+from api.utils import StrEnum
 
 
 class Config(BaseConfig):
diff --git a/dts/tests/TestSuite_smoke_tests.py b/dts/tests/TestSuite_smoke_tests.py
index 157dec7585..b3eb325fc0 100644
--- a/dts/tests/TestSuite_smoke_tests.py
+++ b/dts/tests/TestSuite_smoke_tests.py
@@ -22,9 +22,9 @@
 from api.test_suite import TestSuite, func_test
 from api.testbed_model.linux_session import LinuxSession
 from api.testpmd import TestPmd
+from api.utils import REGEX_FOR_PCI_ADDRESS
 from framework.config.node import PortConfig
 from framework.settings import SETTINGS
-from framework.utils import REGEX_FOR_PCI_ADDRESS
 
 
 @requires_link_topology(LinkTopology.NO_LINK)
diff --git a/dts/tests/TestSuite_softnic.py b/dts/tests/TestSuite_softnic.py
index 0696933053..05a6d3aa18 100644
--- a/dts/tests/TestSuite_softnic.py
+++ b/dts/tests/TestSuite_softnic.py
@@ -22,7 +22,7 @@
 from api.testbed_model.virtual_device import VirtualDevice
 from api.testpmd import TestPmd
 from api.testpmd.config import EthPeer
-from framework.utils import generate_random_packets
+from api.utils import generate_random_packets
 
 
 @requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
-- 
2.52.0

