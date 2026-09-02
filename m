Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E820FC61DD6
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Sep 2026 18:14:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8D4EB427A0;
	Wed,  2 Sep 2026 20:14:03 +0200 (CEST)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com
 [209.85.160.174])
 by mails.dpdk.org (Postfix) with ESMTP id 066FB4275B
 for <dev@dpdk.org>; Wed,  2 Sep 2026 20:14:02 +0200 (CEST)
Received: by mail-qt1-f174.google.com with SMTP id
 d75a77b69052e-52d7a3defe8so13918071cf.0
 for <dev@dpdk.org>; Wed, 02 Sep 2026 11:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1788372841; x=1788977641; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=V1ywzuxBPSgN+K1vFDkomN+B9UsYPvmOlOYyE4gK6do=;
 b=WX/Cvjk90TFkE9boPty23h6hJ0MQrkFy7lKGKUJ9pZEfE7aHkUrT9oQd3Hq7cxXXru
 iCWcBvOfCEP+La63vvCsoar+Bi6RHQciZRf9JC3IBQaDflVSqvCpsUa5PGsXEeFpXmEA
 gl5VrDaGWsmrSw1v2wS+/6r7sX+QZIgMJ4haM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788372841; x=1788977641;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=V1ywzuxBPSgN+K1vFDkomN+B9UsYPvmOlOYyE4gK6do=;
 b=fU7oZqUK/1r6+nCtVcGZFQOWEIochKKkG5GwrFchmnROkHiZ/bN2PoiwZXdauzY2Yb
 YyZLZ+mwomQ2WywTFANdb/ennX2v3qZloNc9j+PsbytmsgWVyN2dJ6SiXudFe2AetmBj
 GSc0bc3Nb1z+ZlMvnipyaUGV31bZmkS3o4BF1V+eib1+pwworyqOWcf7PnkatT3DinfQ
 i3kUGs13vM9NqWESuFCqm4UgJIHSQF9r90TqoVUszxWed8wRRl5H1uYNAnSUyomjAiXt
 3iwQWYwhPs+ViDPfv6K7NagPTJej/GMENVZ1ZZEFUWWzHSY9heuEWEwWJ5KcnMt2fLcc
 KpFg==
X-Gm-Message-State: AFuF++mJVwda/NrPHmzDDCdMs6tDGj1Qjzz1ty2o8D9mN0Ytj6VYERxH
 d8Gdg70zOhDSvdjsM6hCiWRYH03JoCAMQccSQGnMA1HrsWfIFKQE2AbHxyKxLzgfps7Yx2Q9Ole
 r5Cwk/sj/8B7L6zPk92HyUFWqZ46NVkxmlRrfvSum0bcSITNHjurJKQueBET/Z8GazJjryRmgl0
 RXrgK0VgL+VLviNUbsFB360WRo1M4=
X-Gm-Gg: AYBFou2J9vNNJJc/Gk09fwYsU+GJQTpqt6MxjZjwfqK5QX8pILkIZMo+ELxoIBxIftK
 eGtrR8YRSTokU6+I+kczZbEzwrNh0mSZ8NR1/wFbu0GP1e9+Mvcjs54qrYyZceMzXsoQgeNgS2T
 4VhioojufvOKuyY32aruioHJFJC2iMAoojWC6lAmD0u35gBU4Zk9S1X7nr4Rc9hpOzB/xdPuj2z
 YW0BBHdRGE81ASI7SVY99sikEFfw06yzqnPWCCg0lE4LycE/U8U6rSCZp0zD7H5Sqt3mjqkh4Za
 8HrBeNtFTVpdg/KB12lTFOvw2uJXanpuqqiiGHqvxy+bl9MOQ/CjXtGNe/eeEdGNHoT2D4u9ckH
 ZeYUkPOfFYf4UYqKJ0WirQcMgYI/BtyV6J0PBD9A71+yT5/ssPJroG78gR/lbj4NHn07YXWb6Fz
 whCBrnc5S5ppRN571DM40CMgIspaqnLr6qz1VxgbgMQxDSRIQ0cgNg2Q89CQCiYpPU39qUlBdz9
 hf6f99734E=
X-Received: by 2002:a05:622a:164f:b0:52d:3ccc:968b with SMTP id
 d75a77b69052e-53036c0647amr72034761cf.9.1788372841013; 
 Wed, 02 Sep 2026 11:14:01 -0700 (PDT)
Received: from d121029.iol.unh.edu ([2606:4100:3880:1210::219])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-530331d9cbcsm24660101cf.16.2026.09.02.11.13.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 11:14:00 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: dev@dpdk.org,
	luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: knimoji@iol.unh.edu, lylavoie@iol.unh.edu, dladd@iol.unh.edu,
 Andrew Bailey <abailey@iol.unh.edu>, Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v6 8/8] dts: move params directory from framework to API
Date: Wed,  2 Sep 2026 14:13:32 -0400
Message-ID: <20260902181333.461556-9-abailey@iol.unh.edu>
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

The params directory is imported in test suites such as
packet capture to use as a base class for dumpcap.
Move this to the API.

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
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
index 408946683d..6d3da8aa44 100644
--- a/doc/api/dts/index.rst
+++ b/doc/api/dts/index.rst
@@ -17,9 +17,9 @@ Packages
    tests
    api
    api.testbed_model
+   api.params
    framework.testbed_model
    framework.remote_session
-   framework.params
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
index d8985e429b..2713737360 100644
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
index 07db6dfeb0..de86781e2f 100644
--- a/dts/framework/remote_session/blocking_app.py
+++ b/dts/framework/remote_session/blocking_app.py
@@ -31,8 +31,8 @@
 from typing_extensions import Self
 
 from api.context import get_ctx
-from framework.params import Params
-from framework.params.eal import EalParams
+from api.params import Params
+from api.params.eal import EalParams
 from framework.remote_session.dpdk_shell import compute_eal_params
 from framework.remote_session.interactive_shell import InteractiveShell
 from framework.testbed_model.node import Node
diff --git a/dts/framework/remote_session/dpdk.py b/dts/framework/remote_session/dpdk.py
index 999cfcc056..dc22b74658 100644
--- a/dts/framework/remote_session/dpdk.py
+++ b/dts/framework/remote_session/dpdk.py
@@ -16,6 +16,7 @@
 from api.capabilities import LinkTopology
 from api.context import get_ctx
 from api.exception import ConfigurationError, RemoteFileNotFoundError
+from api.params.eal import EalParams
 from api.testbed_model.virtual_device import VirtualDevice
 from api.utils import MesonArgs, TarCompressionFormat
 from framework.config.test_run import (
@@ -30,7 +31,6 @@
     RemoteDPDKTreeLocation,
 )
 from framework.logger import DTSLogger, get_dts_logger
-from framework.params.eal import EalParams
 from framework.remote_session.remote_session import CommandResult
 from framework.settings import SETTINGS
 from framework.testbed_model.cpu import LogicalCore, LogicalCoreCount, LogicalCoreList, lcore_filter
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
index 362bc2a352..3186fca64d 100644
--- a/dts/framework/remote_session/interactive_shell.py
+++ b/dts/framework/remote_session/interactive_shell.py
@@ -35,8 +35,8 @@
     InteractiveSSHSessionDeadError,
     InteractiveSSHTimeoutError,
 )
+from api.params import Params
 from framework.logger import DTSLogger, get_dts_logger
-from framework.params import Params
 from framework.settings import SETTINGS
 from framework.testbed_model.node import Node
 
diff --git a/dts/tests/TestSuite_packet_capture.py b/dts/tests/TestSuite_packet_capture.py
index b994c7cc74..07bfabb30b 100644
--- a/dts/tests/TestSuite_packet_capture.py
+++ b/dts/tests/TestSuite_packet_capture.py
@@ -35,12 +35,12 @@
     match_all_packets,
     send_packets_and_capture,
 )
+from api.params import Params
 from api.test import verify
 from api.test_suite import TestSuite, func_test
 from api.testbed_model.cpu import LogicalCoreList
 from api.testbed_model.traffic_generator.capturing_traffic_generator import PacketFilteringConfig
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

