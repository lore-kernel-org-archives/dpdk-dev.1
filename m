Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A9FC2A09B
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Aug 2026 16:17:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D6DA140DDB;
	Fri,  7 Aug 2026 18:17:15 +0200 (CEST)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com
 [209.85.222.171])
 by mails.dpdk.org (Postfix) with ESMTP id 54AC040E32
 for <dev@dpdk.org>; Fri,  7 Aug 2026 18:17:13 +0200 (CEST)
Received: by mail-qk1-f171.google.com with SMTP id
 af79cd13be357-92e54f8c051so189560785a.3
 for <dev@dpdk.org>; Fri, 07 Aug 2026 09:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1786119433; x=1786724233; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=L7u6HXvaIZsIFgoNNDQj3GXqFxp5Fi4MU4j2VPQ5pSI=;
 b=JY1r3Nx7o9yDiA26R9VlCiIGjhXVO+sECk9A0RdKB67qSUz5fnOjL7nhIoGldpCRe3
 onihhjRrK/2ThzctwQTTF8bCJ1npz18zu7rz4Jqe/EKCdVjNtBqSIeZ8nUMgDg439UJR
 zZZ7WRWrUbCpikkm1wwDb/ZuzUzZAbMtSovSo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786119433; x=1786724233;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=L7u6HXvaIZsIFgoNNDQj3GXqFxp5Fi4MU4j2VPQ5pSI=;
 b=Sldw0LWRRQ4mjW8CQ3Fci9DvwQgR4fcGuWHph4q9w764UQAzz8O/ZLU420F2aN90dB
 B5jAJYNRsQW+gFZ/Dsxf+TBQbxIwGoCkx4z71wEf+NhlSmqyTnZ4lgA99rlush++NGrp
 KlUTOiNV9kXH1/lYr0tYjNGIcuW3h+mEfeVur3dkJqg335zaD0zfU1eRlwd/TF0a58ow
 6V80ZwzdD8XNzGiDmo0aANWpuhnYbw3z3BjXAH8u2aQQXXmVapYpzZMtcn6bHuZz9E9h
 3+46MqBC7pl5fXRty8DyQKmNbkQkk5H64SpWE3xjbTtubT6hIeNBB8hW2vPLXSrd7tCl
 gFqQ==
X-Gm-Message-State: AOJu0YxlPVg7x+ycM5fG1raaCOSA7sEIOzEDmmLR/Vt+gwUWNTxYYzsR
 6mAMvMjexGY3H5NCV+u1A7yS40NDvNojEERIe3JtkNzLPcMsQrxKzmcQub48bnOlnD/2xwosz5D
 RkC5hgI12J5KNsPwdbrBnHtKUh2x6a9Bxx0XeFJfk8LsK4mXy2RD56LNq7tNfA2rzhNDUlsi958
 zhQlruaiO9bdfJ4LWG36B7xqUUTYc=
X-Gm-Gg: AR+sD12o8Np1XSvwF4a4goKL2qvKyksva/X4lMtO2DlkkGOexid35uB5yN3jMDK8cnj
 3wk1A59XoNiwoJJO+8Vblwp/iXUomSMB1gXhIdtlWpN9YxnnMOyU3WTHw7hBgrvVUTmod5GxSeb
 I3n2+d4lDnStmgszN1FBRGFYnp8ZObIWSjn93WxSWnLcIKkkUpFecA9fcQXhVaS/5nBYJdQri4E
 e8EeSZoi1zm4x0DC8CsM1ctPyyKwpsj/W65kLO4GzVemGGVm8D1YYIB0qOz+kVsgQJVWk2+V/8n
 KrgA9fj7KVqQDvVmDJc/4GiTC2K4mRan1RFlHP8I9EdSO1g8zJ6YlWUcCPv0cLai83dI3SYO1pr
 kAyGQ5vPW9oW7ZMHgVj4ou1KuTJUte0POm600sXbx1snNJucKINzCDForsJnd7T6Npj39KNt570
 JcrOWlE/8O2Q6g1f5vraS0f5G0G/esDtxqlT03jzFK8catb7FZs17kLGWJhgmFJAGsKAJCXcu6E
 tQk77xXpro=
X-Received: by 2002:a05:620a:2a13:b0:92e:bbd0:260c with SMTP id
 af79cd13be357-9364914e1d5mr2113243785a.36.1786119432522; 
 Fri, 07 Aug 2026 09:17:12 -0700 (PDT)
Received: from d121029.iol.unh.edu ([2606:4100:3880:1210::219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9366e09dc07sm181798585a.15.2026.08.07.09.17.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 09:17:11 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: dev@dpdk.org,
	luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: knimoji@iol.unh.edu, lylavoie@iol.unh.edu, dladd@iol.unh.edu,
 Andrew Bailey <abailey@iol.unh.edu>, Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v7 6/7] dts: move params directory from framework to API
Date: Fri,  7 Aug 2026 12:16:41 -0400
Message-ID: <20260807161642.122310-7-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260807161642.122310-1-abailey@iol.unh.edu>
References: <20260806135346.568766-1-abailey@iol.unh.edu>
 <20260807161642.122310-1-abailey@iol.unh.edu>
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

