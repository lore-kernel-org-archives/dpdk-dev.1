Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC3ABC5AC7C
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 17:51:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7540540658;
	Thu,  6 Aug 2026 19:51:25 +0200 (CEST)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com
 [209.85.222.169])
 by mails.dpdk.org (Postfix) with ESMTP id 582F6402D0
 for <dev@dpdk.org>; Thu,  6 Aug 2026 19:51:24 +0200 (CEST)
Received: by mail-qk1-f169.google.com with SMTP id
 af79cd13be357-92ed3993c1eso137083785a.1
 for <dev@dpdk.org>; Thu, 06 Aug 2026 10:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1786038684; x=1786643484; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=L7u6HXvaIZsIFgoNNDQj3GXqFxp5Fi4MU4j2VPQ5pSI=;
 b=btzHUuN/XmfUkflg0tqApSQzIphXh5EGe2MGtO1+D6WLAVRb3tAuDHA4ehLOrNuuxu
 Mru6AitifJRAjjON/Tuvfjxy2FUb1CTzPebX+llZcRYT783lY1jZhuaBNYOCXQcFH4P0
 GdBdQxPt80O/BUGvZuB7n//zoVVXYx6wBfiZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786038684; x=1786643484;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=L7u6HXvaIZsIFgoNNDQj3GXqFxp5Fi4MU4j2VPQ5pSI=;
 b=h0CDCRwjj9/zgri3V8+09vMjZHQnWa+5Dt7axZNyHHQNfcITOY0fZjkez0z30WGN66
 DltIwqH5zvxZjG+HJ/NfKCe+AP74XCLttMzjTdRGudOHcULSjYmrhRlEuAAS7pp03/8O
 a6P1IuKv79i3mGfsQ/8jWNAK+FTU+IfFcHJI5Q1baugd6WX18L7p13rSVsbCOhre+3sz
 ZlJCex0x68jJf/yRuFpeOtL4xVv5ZAyoqdwtCmmkE9qFSE66sulueWXerZQAyzpPfN6t
 H76Jl83O5FuNHqAzc+9tfRwm364vESNsKmHAaHxua6m6+R87vyIebAeSWkKf3Ww4NN5/
 +UBQ==
X-Gm-Message-State: AOJu0YyaP6uPuZquJu3N1TGsXtIb2iRpetDGbimVieA2nEJ9jcgkhDSs
 FEu0sSowdBgYq5cOwPPd+94bl+mTAcBCoOcqA7tk0aE6CduOSdgBHK8u8sbA9b9QEX9l07ZQbbf
 XAS8kEWjm25x+0zD3jisV4vKps5tgKsZ6z4honLk57hIqahmqkXtt3KzWUb7t5cf2LLwFLC7f2B
 X0So3ufQthA0yhNwuPD93xcQ21E38=
X-Gm-Gg: AR+sD12olfoax5cjmdz5aZmo3Y6fH2vbSbHaoLkhH/1PGV044L7Ckfi6Fg48i1Ff5rj
 Nf+Mf+fcS2eAiMJ/9SH8COMOeUAqb73GF+nM2pPc5bW/dgaQc8qRY3zXF6pl0udhXiMYN24xw6g
 CD8NXKeLyM9wV8v8jUGtoMscUFgPhijNPxBoBOOMz8ha5ewzBF3I9U69ZNufjiIlVRLiFm1cGXL
 y+ZKOvHMFmVHRF7VUuOtIt9gKf2lLmrMwWclAEcDZJyn1vqZJai2D+kgoXdzxQQx/+nAVIEsGN6
 fbHE9H2PhasC/UmHxccI8Py1z5345OWKAiJl6AX4goeV2G0YFolo5Jm0mQ2zbxxdF/PkZ324HFc
 2Yo/T+H/wlhzFYx5UkCxvWX2wm5YA2YmGxzKpwLl8y/d8SnzcRhXaxOKECiDnMpAOvKGRqmtccw
 0pAFVdzUmvfEuRPm3G1yGatwX4kbL9JVS0Itp+hm10rQR5xaopRGEDvDj+x4SC6Z5ArUl02+jby
 u22eFotFxns6ECFmU5Zw9aAz69ils1Y7r6021b0bpTlYHbcqNDRsLX62Z/PQAg=
X-Received: by 2002:a05:620a:241a:10b0:92e:6533:26eb with SMTP id
 af79cd13be357-9364911977fmr1404839885a.6.1786038683519; 
 Thu, 06 Aug 2026 10:51:23 -0700 (PDT)
Received: from syn-2603-7083-bff0-a0d0-0000-0000-0000-1a64.res6.spectrum.com
 ([2606:4100:3880:1257::1039]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93657688090sm317311285a.27.2026.08.06.10.51.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 10:51:22 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: dev@dpdk.org,
	luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: knimoji@iol.unh.edu, lylavoie@iol.unh.edu, dladd@iol.unh.edu,
 Andrew Bailey <abailey@iol.unh.edu>, Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v6 6/7] dts: move params directory from framework to API
Date: Thu,  6 Aug 2026 13:50:23 -0400
Message-ID: <20260806175024.13655-7-abailey@iol.unh.edu>
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

The params directory is imported in test suites such as
packet capture to use as a base class for dumpcap.
Move this to the API.

Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
---
 .../{framework.params.eal.rst => api.params.eal.rst}   |  2 +-
 doc/api/dts/{framework.params.rst => api.params.rst}   |  6 +++---
 ...framework.params.types.rst => api.params.types.rst} |  2 +-
 doc/api/dts/index.rst                                  |  2 +-
 dts/api/cryptodev/__init__.py                          |  2 +-
 dts/api/cryptodev/config.py                            |  4 ++--
 dts/{framework => api}/params/__init__.py              |  0
 dts/{framework => api}/params/eal.py                   |  2 +-
 dts/{framework => api}/params/types.py                 | 10 +++++++---
 dts/api/testpmd/__init__.py                            |  7 ++++++-
 dts/api/testpmd/config.py                              |  6 +++---
 dts/framework/remote_session/blocking_app.py           |  4 ++--
 dts/framework/remote_session/dpdk.py                   |  2 +-
 dts/framework/remote_session/dpdk_shell.py             |  2 +-
 dts/framework/remote_session/interactive_shell.py      |  2 +-
 dts/tests/TestSuite_packet_capture.py                  |  2 +-
 dts/tests/TestSuite_single_core_forward_perf.py        |  2 +-
 17 files changed, 33 insertions(+), 24 deletions(-)
 rename doc/api/dts/{framework.params.eal.rst => api.params.eal.rst} (79%)
 rename doc/api/dts/{framework.params.rst => api.params.rst} (71%)
 rename doc/api/dts/{framework.params.types.rst => api.params.types.rst} (80%)
 rename dts/{framework => api}/params/__init__.py (100%)
 rename dts/{framework => api}/params/eal.py (97%)
 rename dts/{framework => api}/params/types.py (96%)

diff --git a/doc/api/dts/framework.params.eal.rst b/doc/api/dts/api.params.eal.rst
similarity index 79%
rename from doc/api/dts/framework.params.eal.rst
rename to doc/api/dts/api.params.eal.rst
index 6999b00233..4531cb1fe1 100644
--- a/doc/api/dts/framework.params.eal.rst
+++ b/doc/api/dts/api.params.eal.rst
@@ -3,6 +3,6 @@
 eal - EAL Parameters Modelling
 ==============================
 
-.. automodule:: framework.params.eal
+.. automodule:: api.params.eal
    :members:
    :show-inheritance:
diff --git a/doc/api/dts/framework.params.rst b/doc/api/dts/api.params.rst
similarity index 71%
rename from doc/api/dts/framework.params.rst
rename to doc/api/dts/api.params.rst
index d8c6af9667..3ea7f9215e 100644
--- a/doc/api/dts/framework.params.rst
+++ b/doc/api/dts/api.params.rst
@@ -3,7 +3,7 @@
 params - Command Line Parameters Modelling
 ==========================================
 
-.. automodule:: framework.params
+.. automodule:: api.params
    :members:
    :show-inheritance:
 
@@ -11,5 +11,5 @@ params - Command Line Parameters Modelling
    :hidden:
    :maxdepth: 1
 
-   framework.params.eal
-   framework.params.types
+   api.params.eal
+   api.params.types
diff --git a/doc/api/dts/framework.params.types.rst b/doc/api/dts/api.params.types.rst
similarity index 80%
rename from doc/api/dts/framework.params.types.rst
rename to doc/api/dts/api.params.types.rst
index 6d609038be..4754b3a665 100644
--- a/doc/api/dts/framework.params.types.rst
+++ b/doc/api/dts/api.params.types.rst
@@ -3,6 +3,6 @@
 params.types - Parameters Modelling Types
 =========================================
 
-.. automodule:: framework.params.types
+.. automodule:: api.params.types
    :members:
    :show-inheritance:
diff --git a/doc/api/dts/index.rst b/doc/api/dts/index.rst
index 7c282bbba1..e89e782ac0 100644
--- a/doc/api/dts/index.rst
+++ b/doc/api/dts/index.rst
@@ -18,7 +18,7 @@ Packages
    api
    api.testbed_model
    framework.remote_session
-   framework.params
+   api.params
    framework.config
 
 Modules
diff --git a/dts/api/cryptodev/__init__.py b/dts/api/cryptodev/__init__.py
index 198607696f..496079c2af 100644
--- a/dts/api/cryptodev/__init__.py
+++ b/dts/api/cryptodev/__init__.py
@@ -27,7 +27,7 @@
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
similarity index 96%
rename from dts/framework/params/types.py
rename to dts/api/params/types.py
index f9a51963a2..c4b718eebe 100644
--- a/dts/framework/params/types.py
+++ b/dts/api/params/types.py
@@ -12,8 +12,10 @@ def create_testpmd(**kwargs: Unpack[TestPmdParamsDict]):
             params = TestPmdParams(**kwargs)
 """
 
+from __future__ import annotations
+
 from pathlib import PurePath
-from typing import TypedDict
+from typing import TYPE_CHECKING, TypedDict
 
 from api.cryptodev.config import (
     AeadAlgName,
@@ -56,8 +58,10 @@ def create_testpmd(**kwargs: Unpack[TestPmdParamsDict]):
     TXRingParams,
     TxUDPPortPair,
 )
-from api.testpmd.types import RxOffloadCapability, TxOffloadCapability
-from framework.params import Switch, YesNoSwitch
+
+if TYPE_CHECKING:
+    from api.testpmd.types import RxOffloadCapability, TxOffloadCapability
+from api.params import Switch, YesNoSwitch
 
 
 class EalParamsDict(TypedDict, total=False):
diff --git a/dts/api/testpmd/__init__.py b/dts/api/testpmd/__init__.py
index ce41408eb6..33504640e3 100644
--- a/dts/api/testpmd/__init__.py
+++ b/dts/api/testpmd/__init__.py
@@ -14,6 +14,8 @@
     testpmd.close()
 """
 
+from __future__ import annotations
+
 import functools
 import re
 import time
@@ -21,6 +23,7 @@
 from enum import Flag
 from pathlib import PurePath
 from typing import (
+    TYPE_CHECKING,
     Any,
     Callable,
     ClassVar,
@@ -56,7 +59,9 @@
     TxOffloadConfiguration,
     VLANOffloadFlag,
 )
-from framework.params.types import TestPmdParamsDict
+
+if TYPE_CHECKING:
+    from api.params.types import TestPmdParamsDict
 from framework.remote_session.dpdk_shell import DPDKShell
 from framework.remote_session.interactive_shell import only_active
 from framework.settings import SETTINGS
diff --git a/dts/api/testpmd/config.py b/dts/api/testpmd/config.py
index 3850a4eb8a..c72c1b2c90 100644
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
@@ -25,7 +24,8 @@
     modify_str,
     str_from_flag_value,
 )
-from framework.params.eal import EalParams
+from api.params.eal import EalParams
+from api.utils import StrEnum
 
 from .types import RxOffloadCapability, TxOffloadCapability
 
diff --git a/dts/framework/remote_session/blocking_app.py b/dts/framework/remote_session/blocking_app.py
index 84db3974b1..537d937eca 100644
--- a/dts/framework/remote_session/blocking_app.py
+++ b/dts/framework/remote_session/blocking_app.py
@@ -31,9 +31,9 @@
 from typing_extensions import Self
 
 from api.context import get_ctx
+from api.params import Params
+from api.params.eal import EalParams
 from api.testbed_model.node import Node
-from framework.params import Params
-from framework.params.eal import EalParams
 from framework.remote_session.dpdk_shell import compute_eal_params
 from framework.remote_session.interactive_shell import InteractiveShell
 
diff --git a/dts/framework/remote_session/dpdk.py b/dts/framework/remote_session/dpdk.py
index c02c68af77..4de61ece68 100644
--- a/dts/framework/remote_session/dpdk.py
+++ b/dts/framework/remote_session/dpdk.py
@@ -16,6 +16,7 @@
 from api.capabilities import LinkTopology
 from api.context import get_ctx
 from api.exception import ConfigurationError, RemoteFileNotFoundError
+from api.params.eal import EalParams
 from api.testbed_model.cpu import LogicalCore, LogicalCoreCount, LogicalCoreList, lcore_filter
 from api.testbed_model.node import Node
 from api.testbed_model.os_session import OSSession
@@ -33,7 +34,6 @@
     RemoteDPDKTreeLocation,
 )
 from framework.logger import DTSLogger, get_dts_logger
-from framework.params.eal import EalParams
 from framework.remote_session.remote_session import CommandResult
 
 
diff --git a/dts/framework/remote_session/dpdk_shell.py b/dts/framework/remote_session/dpdk_shell.py
index b807f9bdae..61cc4687f3 100644
--- a/dts/framework/remote_session/dpdk_shell.py
+++ b/dts/framework/remote_session/dpdk_shell.py
@@ -11,8 +11,8 @@
 from pathlib import PurePath
 
 from api.context import get_ctx
+from api.params.eal import EalParams
 from api.testbed_model.cpu import LogicalCoreList
-from framework.params.eal import EalParams
 from framework.remote_session.interactive_shell import (
     InteractiveShell,
     only_active,
diff --git a/dts/framework/remote_session/interactive_shell.py b/dts/framework/remote_session/interactive_shell.py
index 831861a9ac..f9b7a7720d 100644
--- a/dts/framework/remote_session/interactive_shell.py
+++ b/dts/framework/remote_session/interactive_shell.py
@@ -35,9 +35,9 @@
     InteractiveSSHSessionDeadError,
     InteractiveSSHTimeoutError,
 )
+from api.params import Params
 from api.testbed_model.node import Node
 from framework.logger import DTSLogger, get_dts_logger
-from framework.params import Params
 from framework.settings import SETTINGS
 
 P = ParamSpec("P")
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
index f51ff76c4c..4b22c5d091 100644
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
2.55.0

