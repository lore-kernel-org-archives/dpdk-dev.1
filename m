Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEC1606A328
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Nov 2026 17:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iol.unh.edu header.i=@iol.unh.edu header.a=rsa-sha256 header.s=unh-iol header.b=J87cX/1R
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 00AE940E09;
	Thu,  5 Nov 2026 18:41:44 +0100 (CET)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com
 [209.85.222.182])
 by mails.dpdk.org (Postfix) with ESMTPS id 1BFF640E01
 for <dev@dpdk.org>; Thu,  5 Nov 2026 18:41:43 +0100 (CET)
Received: by mail-qk1-f182.google.com with SMTP id
 af79cd13be357-93e503815adso192434685a.1
 for <dev@dpdk.org>; Thu, 05 Nov 2026 09:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1793900502; x=1794505302; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=sPhtDUUbmCSUnQUGr1tIXWU1an5RyqXcS3JUgylQfo8=;
 b=J87cX/1RlK0Kefh1ZrERE79oa2i9U8VeXDc4WwNZIBJtzNg9Wp+2MOihQTB1abNas8
 6YGxo3RHyuwyyjZ7SXXYTIednNMLInpEZ57EhrNj1JVcJvqsjgCgSIjPQesBeWhVetfC
 GD+1CPqTuNnY+6vcqXkv7K99M23jRWpw4/G8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793900502; x=1794505302;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sPhtDUUbmCSUnQUGr1tIXWU1an5RyqXcS3JUgylQfo8=;
 b=0zETFqBEli+UhRSJKjJr+lZm+9p6CtEXDe006mQasgPPN4FQqmJ7qq6rzFLkcBTehi
 WTdLGt7UTqbrYx3Uxbar2dvmf6GbPV3rZArIiI9x7YHb3XwCNVzA9c6oPb5GOaZrSwED
 hJH592AkLWJZnaAZZyUkjPrv+1B60llSCbr0XCYz0TAIifbFfQ6WSI1elnlwSYXllo4G
 FB9HGIRERggBDrt426tKp6tGU/RzIYuzj6Tkn31IN8oQVCPc0j/EeERC7DxMLI1KJGiK
 glH21Lisj+iARePE+yCH73bODyLs0tSqxIcC0HVqp1wFGClZ11KEDxMdeX+fm71k49fm
 a83g==
X-Forwarded-Encrypted: i=1;
 AKwUvBxq2B38NqG6fA1Zgxsg9tPL5c+kHl2UkJ62NQ9/Vh1hdx+TgYOOP22v5H4KPPYEsOKN1XI=@dpdk.org
X-Gm-Message-State: APuU4Z+kmvWUs7AUxTDEotZZLu/wI7cYnMVWS36unhj+tT99Of7daN/x
 WsL+/DYE7tq6UfcmYiDDWeG046ZEDYI4GR+1psCrfLVcIm8w9WwkMS8inSng8JiRW4c=
X-Gm-Gg: AYBFou1SUTGiv+YNQ7tiqUSXTEXVUCbWer36tqzI/tf1x0/5hTgEqBn1B4k44ioI2H/
 b1xHjQrG14/ShG5xlXEqGo95Rk0i8DvaBkBa+PT8Sy3ZAoN3GKYumsisFGM13inov8v9Y6V/zhd
 +uNv0ObvP+T/6hYaZKYRbWVHeDb4a0MkwY+tphUWJRujj3z8I1IxTov8tRzs8VclRQPkhYdbykR
 3l/7X6dm8XZcntm6wlqs5LlyWJiXhOWsP7knZLXjmxZYrGV+mTzbXx6/6OgnI9EgU6vu9V1iyuV
 x/Eb3dbg7DhRpQhloJrYBWKl00mHQM+4qjSpyjAiOJLQ9HvygSIZoGYEQN7deBTAUITrrLzz6MB
 cJjzglDpGbTyhPbzIzXolQ3QMJFx6sPB4H1x+Yug3P3f8Iz3AH5C3wqlSEKzDnHw4niDRDyuhPk
 Xc0yfqBxBrZNv8Rl0jxYfkx+Hx4yaehSYr1DA6l+M0TP/QiTmWlWbF3dcREDU15oRdp1ogmuaG8
 DwAz+KNx+1/1Q/vn4ouwe19a1auQnaLFtvND+QqM0UT52bdQE23iWBmEsb5ascAMLg22W9WgbNn
 mmNWX+eHEZy1knGwckG9aApR4UlfLe6cxCHA/ug6ucOGTtIEUKJpbMujjEsQv8+PhsCSHFRAVFy
 BtgMohuJ/h7tHJeQ=
X-Received: by 2002:a05:620a:480b:b0:93e:5fff:db07 with SMTP id
 af79cd13be357-9442175c1bemr3508455185a.40.1793900501743; 
 Thu, 05 Nov 2026 09:41:41 -0800 (PST)
Received: from X1-Gen-9.iol.unh.edu ([2606:4100:3880:1271:980d:bd8a:336d:5c24])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-945d4852ba3sm509329785a.31.2026.11.05.09.41.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 09:41:40 -0800 (PST)
From: Dillon Ladd <dladd@iol.unh.edu>
To: luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com,
	dev@dpdk.org
Cc: knimoji@iol.unh.edu, abailey@iol.unh.edu, Dillon Ladd <dladd@iol.unh.edu>
Subject: [PATCH v1 1/2] dts: add eventdev API
Date: Thu,  5 Nov 2026 12:41:36 -0500
Message-ID: <20261105174137.498850-1-dladd@iol.unh.edu>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add an API for the dpdk-test-eventdev application, run as a
blocking app with the topology's Ethernet ports as event
producers. Only the event_sw virtual device is currently supported, with
its scheduler on a dedicated service core. Eventdev testing existed on old-dts but not new-dts. This API was written so the eventdev performance testsuite from old dts can be ported over.

Signed-off-by: Dillon Ladd <dladd@iol.unh.edu>
---
 dts/api/eventdev/__init__.py | 95 ++++++++++++++++++++++++++++++++++++
 dts/api/eventdev/config.py   | 41 ++++++++++++++++
 dts/api/params/types.py      | 11 +++++
 3 files changed, 147 insertions(+)
 create mode 100644 dts/api/eventdev/__init__.py
 create mode 100644 dts/api/eventdev/config.py

diff --git a/dts/api/eventdev/__init__.py b/dts/api/eventdev/__init__.py
new file mode 100644
index 0000000000..202ddcb77c
--- /dev/null
+++ b/dts/api/eventdev/__init__.py
@@ -0,0 +1,95 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2026 University of New Hampshire
+
+"""dpdk-test-eventdev application.
+
+Typical usage example in a TestSuite::
+
+    with Eventdev(num_workers=2, stlist="a"):
+        stats = assess_performance_by_packet(packet=packet, duration=5)
+"""
+
+from typing import TYPE_CHECKING
+
+from typing_extensions import Self, Unpack
+
+from api.context import get_ctx
+from api.eventdev.config import EventdevParams
+from api.exception import (
+    InteractiveCommandExecutionError,
+    SkippedTestException,
+)
+from api.params import Params
+from api.testbed_model.cpu import LogicalCoreCount, LogicalCoreList
+from api.testbed_model.virtual_device import VirtualDevice
+from framework.remote_session.blocking_app import BlockingApp
+from framework.remote_session.dpdk_shell import compute_eal_params
+
+if TYPE_CHECKING:
+    from api.params.types import EventdevParamsDict
+
+
+class Eventdev(BlockingApp[EventdevParams]):
+    """Blocking dpdk-test-eventdev application.
+
+    Attributes:
+        _app_params: app parameters to pass to dpdk-test-eventdev application
+    """
+
+    _app_params: EventdevParams
+
+    def __init__(self, num_workers: int = 1, **app_params: Unpack["EventdevParamsDict"]) -> None:
+        """Initialize the eventdev application.
+
+        Args:
+            num_workers: number of worker cores to run the application with.
+            app_params: The application parameters as keyword arguments.
+
+        Raises:
+            ValueError: if the build environment is `None`
+            SkippedTestException: if there are not enough cores on one socket
+        """
+        ctx = get_ctx()
+        dpdk = ctx.dpdk.build
+        if dpdk is None:
+            raise ValueError("No DPDK build environment exists.")
+        self._app_path = dpdk.get_app("test-eventdev")
+
+        # One main lcore, one service lcore for the software event scheduler, and the workers.
+        num_lcores = num_workers + 2
+        try:
+            lcores = ctx.dpdk.filter_lcores(
+                LogicalCoreCount(cores_per_socket=num_lcores), ctx.local.ascending_cores
+            )
+        except ValueError as e:
+            raise SkippedTestException(
+                f"dpdk-test-eventdev needs {num_lcores} cores on one socket: {e}"
+            )
+
+        main, service, *workers = lcores
+        app_params.setdefault("other_eal_param", Params.from_str(f"-S {service.lcore}"))
+        app_params.setdefault("vdevs", [VirtualDevice("event_sw0")])
+        app_params.setdefault("lcore_list", LogicalCoreList(lcores))
+        app_params.setdefault("wlcores", str(LogicalCoreList(workers)))
+        app_params.setdefault("prod_type_ethdev", True)
+        params = EventdevParams(**app_params)
+        compute_eal_params(params)
+        self._num_eth_ports = len(params.allowed_ports or [])
+        super().__init__(ctx.sut_node, self._app_path, app_params=params, privileged=True)
+
+    def __enter__(self) -> Self:
+        """Start the application and wait until ready.
+
+        Raises:
+            InteractiveCommandExecutionError: If there is an error starting the application.
+
+        Returns:
+            The started application.
+        """
+        last_port = self._num_eth_ports - 1
+        try:
+            return self.wait_until_ready(
+                f"Port[{last_port}] using Tx adapter[{last_port}] Configured\x1b[0m"
+            )
+        except InteractiveCommandExecutionError as e:
+            raise e
diff --git a/dts/api/eventdev/config.py b/dts/api/eventdev/config.py
new file mode 100644
index 0000000000..acdbc88743
--- /dev/null
+++ b/dts/api/eventdev/config.py
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2026 University of New Hampshire
+
+"""Module containing types and parameter classes for the dpdk-test-eventdev application."""
+
+from dataclasses import dataclass, field
+
+from api.params import Params, Switch
+from api.params.eal import EalParams
+
+
+@dataclass(slots=True, kw_only=True)
+class EventdevParams(EalParams):
+    """Parameters for the dpdk-test-eventdev application.
+
+    Attributes:
+        test: Name of the test to run.
+        wlcores: List of worker lcores.
+        stlist: List of scheduled types of the pipeline stages.
+        pool_sz: Size of the mbuf mempool.
+        nb_eth_queues: Number of Ethernet Rx queues.
+        prod_type_ethdev: Use an Ethernet device as the event producer.
+    """
+
+    test: str = field(default="pipeline_queue", metadata=Params.long("test"))
+    wlcores: str | None = field(default=None, metadata=Params.long("wlcores"))
+    stlist: str | None = field(default=None, metadata=Params.long("stlist"))
+    pool_sz: int | None = field(default=None, metadata=Params.long("pool_sz"))
+    nb_eth_queues: int | None = field(default=None, metadata=Params.long("nb_eth_queues"))
+    prod_type_ethdev: Switch = field(default=None, metadata=Params.long("prod_type_ethdev"))
+
+    def __str__(self) -> str:
+        """Convert the parameters to a command line string.
+
+        Returns:
+            The command line arguments, with underscored option names as the application expects.
+        """
+        params = Params.__str__(self)
+        for name in ("pool_sz", "nb_eth_queues", "prod_type_ethdev"):
+            params = params.replace(f"--{name.replace('_', '-')}", f"--{name}")
+        return params
diff --git a/dts/api/params/types.py b/dts/api/params/types.py
index c4b718eebe..1ba7e9bf52 100644
--- a/dts/api/params/types.py
+++ b/dts/api/params/types.py
@@ -203,3 +203,14 @@ class TestPmdParamsDict(EalParamsDict, total=False):
     mempool_allocation_mode: SimpleMempoolAllocationMode | AnonMempoolAllocationMode | None
     record_core_cycles: Switch
     record_burst_status: Switch
+
+
+class EventdevParamsDict(EalParamsDict, total=False):
+    """:class:`TypedDict` equivalent of :class:`~.eventdev.config.EventdevParams`."""
+
+    test: str
+    wlcores: str | None
+    stlist: str | None
+    pool_sz: int | None
+    nb_eth_queues: int | None
+    prod_type_ethdev: Switch
-- 
2.53.0

