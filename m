Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E49CD13D3
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Apr 2026 22:07:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A3C5B40A76;
	Fri,  1 May 2026 00:06:52 +0200 (CEST)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com
 [209.85.160.180])
 by mails.dpdk.org (Postfix) with ESMTP id EF84840669
 for <dev@dpdk.org>; Fri,  1 May 2026 00:06:48 +0200 (CEST)
Received: by mail-qt1-f180.google.com with SMTP id
 d75a77b69052e-50fae4d1f85so17177951cf.3
 for <dev@dpdk.org>; Thu, 30 Apr 2026 15:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1777586808; x=1778191608; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=28A7OW6CKFU9vNYCCE72QJSH7Y4pRJycU3RUl/7ofIY=;
 b=LYK1XXCemHKL7b4nG3cZH+E7OoPYa4TCMrl2NTGFvJakvY7ZLTySOOiVNhTnPa/kH3
 SrIFE5E0MtMydju6dswOK1L2igo2VOHf+1wRqy2XjfoFMxhItzeDjkvn4AvyOZfSIO23
 LdyzsdOzSPABUWl2ZsBpjgu75TMizzvkOzQo0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777586808; x=1778191608;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=28A7OW6CKFU9vNYCCE72QJSH7Y4pRJycU3RUl/7ofIY=;
 b=RqZ6HhFiENUtGiHzxbs5gJEckhXDaCroxgB+JV8FOQt/di+U4JseYoI7tFk/hrhRLc
 S3grrEVn/vAqkC46X1fRMtJBu/hxFEQoiQIqxFMTqaZWe5bKuLA3Q6zhgTtbGvLiubVU
 pogaaRrwFyZpahAdEnyGK2HZvz0hyaQ4hA7REOSRPCPtob0KJMnmyMPE7F/6nkcdYJfs
 QI9nKIcg4/fXkyuK3nXTR6onfxdLaocG0yWsyQePrc1HNHsXd3In0eARdhAEJDtbHQRb
 cpKQ6VdZ+a/zv3uOVbsp6cHygi1nXrLoJGMEiSk6EstAvJu1fsAdmgosIEpnwvYVUwtp
 x8VQ==
X-Gm-Message-State: AOJu0YxT+W+uuqDaPRTJfcwuePayPC8oKlWutTO6q16/ceBuhjnNSXTU
 /XMXy7PvJEUZPirDaDqoxBLtguvzYYUCEuyRo0PEkKhPbwQaGjxBLyeOyBgQgChr8U0=
X-Gm-Gg: AeBDieuYcGiLdlbi1KzpQwl5C5FB2EDsFxhcTOHyaF5FDW2Wk5lWMGQrEGxhZUKyJq6
 KFGtqGregGL0F5TsI5xBayPOwBS+2w5BOHlxFUVo2oFPLyVrFp2X1sdFb9BFuajGui/CKGNBFqd
 GCTWfaRnWZTwMCrzvWWI+dBVrzH2zfwdB8gWpnB2vW7G35xMGcwxiQ5ZLop2Kkmd1wGHUM1Gqn+
 +CYU3kSNChb0eShrz9zHJdNvesd3QXniURH4sz1WbEFzAgWoIB99fwRvvUpmK6NYvqXT+QBG55M
 7FTPMTbuJAhvk8ahxMFDDsFTzfoLYKYvnZpXjvA/lKYi05eFf2cc6qrinQpMeAhmO21TgUCRp4N
 I22KP3RYn9xhBARKU2XHjaj3/cNM3Ybzpk8O8QUAr+Q/Fohw4VwW8H6YEgTb1L3QZ2i/VOJJZeK
 4/wUeq1PPTP4BKN7xuMUBpN0hmQz2zDMNNS+Ibk7F02joX9KxyrX2ONc1yBM0Q6TGGOieheqO3f
 WY43tNzb38=
X-Received: by 2002:a05:622a:14d1:b0:50d:71aa:6b67 with SMTP id
 d75a77b69052e-5102ae171admr72521121cf.53.1777586808049; 
 Thu, 30 Apr 2026 15:06:48 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:ac5d:4186:4dc6:47eb])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b53d83114fsm3146136d6.48.2026.04.30.15.06.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 15:06:47 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: patrickrobb1997@gmail.com, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v4 6/7] dts: move params directory from framework to API
Date: Thu, 30 Apr 2026 18:06:37 -0400
Message-ID: <20260430220638.30666-7-dmarx@iol.unh.edu>
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

The params directory is imported in test suites such as
packet capture to use as a base class for dumpcap.
Move this to the API.

Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
---
 .../dts/{framework.params.eal.rst => api.params.eal.rst}  | 2 +-
 doc/api/dts/{framework.params.rst => api.params.rst}      | 6 +++---
 .../{framework.params.types.rst => api.params.types.rst}  | 2 +-
 doc/api/dts/index.rst                                     | 2 +-
 dts/api/cryptodev/__init__.py                             | 2 +-
 dts/api/cryptodev/config.py                               | 4 ++--
 dts/{framework => api}/params/__init__.py                 | 0
 dts/{framework => api}/params/eal.py                      | 2 +-
 dts/{framework => api}/params/types.py                    | 8 ++++++--
 dts/api/testpmd/__init__.py                               | 7 ++++++-
 dts/api/testpmd/config.py                                 | 6 +++---
 dts/framework/remote_session/blocking_app.py              | 4 ++--
 dts/framework/remote_session/dpdk.py                      | 2 +-
 dts/framework/remote_session/dpdk_shell.py                | 2 +-
 dts/framework/remote_session/interactive_shell.py         | 2 +-
 dts/tests/TestSuite_packet_capture.py                     | 2 +-
 dts/tests/TestSuite_single_core_forward_perf.py           | 2 +-
 17 files changed, 32 insertions(+), 23 deletions(-)
 rename doc/api/dts/{framework.params.eal.rst => api.params.eal.rst} (79%)
 rename doc/api/dts/{framework.params.rst => api.params.rst} (71%)
 rename doc/api/dts/{framework.params.types.rst => api.params.types.rst} (80%)
 rename dts/{framework => api}/params/__init__.py (100%)
 rename dts/{framework => api}/params/eal.py (97%)
 rename dts/{framework => api}/params/types.py (97%)

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
index 1ba8e0d977..bbfe3622c2 100644
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
similarity index 97%
rename from dts/framework/params/types.py
rename to dts/api/params/types.py
index f2fa69f8b8..2c215cfe54 100644
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
@@ -56,7 +58,9 @@ def create_testpmd(**kwargs: Unpack[TestPmdParamsDict]):
     TXRingParams,
     TxUDPPortPair,
 )
-from framework.params import Switch, YesNoSwitch
+
+if TYPE_CHECKING:
+    from api.params import Switch, YesNoSwitch
 
 
 class EalParamsDict(TypedDict, total=False):
diff --git a/dts/api/testpmd/__init__.py b/dts/api/testpmd/__init__.py
index 9f47a15433..85ebe2ea65 100644
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
index 8b688834ee..96fe5e79fb 100644
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
@@ -24,7 +23,8 @@
     modify_str,
     str_from_flag_value,
 )
-from framework.params.eal import EalParams
+from api.params.eal import EalParams
+from api.utils import StrEnum
 
 
 class PortTopology(StrEnum):
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
index 713a564d25..afdf7526d9 100644
--- a/dts/framework/remote_session/dpdk.py
+++ b/dts/framework/remote_session/dpdk.py
@@ -15,6 +15,7 @@
 
 from api.context import get_ctx
 from api.exception import ConfigurationError, RemoteFileNotFoundError
+from api.params.eal import EalParams
 from api.testbed_model.cpu import LogicalCore, LogicalCoreCount, LogicalCoreList, lcore_filter
 from api.testbed_model.node import Node
 from api.testbed_model.os_session import OSSession
@@ -32,7 +33,6 @@
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
index ec539bad95..f7f0669eea 100644
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
index f1eb435759..24f2cebf17 100644
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
2.52.0

