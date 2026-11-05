Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A952606A31B
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Nov 2026 20:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iol.unh.edu header.i=@iol.unh.edu header.a=rsa-sha256 header.s=unh-iol header.b=NPOkc3OL
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AA12440E01;
	Thu,  5 Nov 2026 21:05:02 +0100 (CET)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com
 [209.85.219.46])
 by mails.dpdk.org (Postfix) with ESMTPS id 0C8ED40DD5
 for <dev@dpdk.org>; Thu,  5 Nov 2026 21:05:01 +0100 (CET)
Received: by mail-qv1-f46.google.com with SMTP id
 6a1803df08f44-91c9cfd8b1bso26201166d6.1
 for <dev@dpdk.org>; Thu, 05 Nov 2026 12:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1793909100; x=1794513900; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sPhtDUUbmCSUnQUGr1tIXWU1an5RyqXcS3JUgylQfo8=;
 b=NPOkc3OL78OuREczB1X2BTG5b6iNvEg/FP4QnC0iAaBnP3qSXF9RT8D0BIf7+cxawF
 pWXBqz0q24XHjE3rVzXOsenU3Cqx2HJs2TQlsknkkYQD44yP0uulHEReed22dPQUMpb8
 jPs3Pv6BO4r0NhJcRMQjeFymu9zcwW4Qcu+1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793909100; x=1794513900;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sPhtDUUbmCSUnQUGr1tIXWU1an5RyqXcS3JUgylQfo8=;
 b=u261WC6kdM+dFz0ICI3qlPALbenWwXrCt8obVBuie8T942GVgvw9or4p33ekCxiGk+
 XKZSqAhI2lhEKuqZSsIXhq2QUHP06teS52DARjEplRr2SZWx5aA5xHb557eGkg+9Kgch
 x5QIAf5o58W2pGZuImd1YRiVCPFjZPW74DbO5wC1xitBpsQAfYEwvAk14HuRlTqIMwnQ
 yzVQyMzQFbaHds5y2D9dwvF0lWXCwdPqAwzEi+tFXqoVZYHqjJx21QoqNKmsDNtLSb49
 sztwESGbInZA26SzjKwrsT8w0KdGC6NGm0mmUEhH5vlOLNvm7Ml9TeaOIt7CSS42QoPR
 ZjbA==
X-Gm-Message-State: APuU4Z+HK2aalRjZe9UMHw42NAlSnc6KqlSCPPXSQ5Ufm/YPjZEmyFK9
 IPaWM8Vj7yPaWl+ksQHTvNVLbJSe911t8dBpoJx1o18q9x/2VXTKISDBi5FFt+sXVAY=
X-Gm-Gg: AYBFou0DeanCs8dxXthc8CvZWebhUbslx4lqcu9wan1cbds5HqVKvRK3tmeSbw67VOr
 2xWaPo8VPer+uD+V09blE6+6+FF1JpNs9i7ap98owidlcNsiJ/+lGF0VT0V5nnx3LYKDDCZ2GRX
 xqz1M+tNDB5D2d/x1hlHEnZrQUulALbbtMlN10C9YUwwFtsKLPnnc8W5IOAKN8O5RBDN5l03L5e
 cJ+TOFlGW308sxNmt17kmd1v8XFv5VD1MsNQcRTO8OlvsCFm1yginfeq6EI+ay1M/pPzwoOglYH
 59ulhLhBonT1pgt650OlOxda37ge05jUHooqpDEemBRh6/QuwWNmErmSLLt6bup51leDFSsvCUT
 jbJyqlGnR8BkDPkULnw8Z1IiHnqRrnU/2EG80KekRHgW+V94YmtFkyHxULPG+RZzQC3fnfIUqFv
 S/vPNdVGfH3znzW6LX6ZkIfH+pR9ftkgGjjEgFm3pfMAXk8k6bDl89mBZ1iWJAp/1/c/hITWCIi
 qgzBoHpQoCMgUZ7ErrkZ1nGonDnWNsNi5WlfsaU3Ha+8xmGVseVbtSIzKNEXpN4IgDUPulapny9
 yN6Ewny6p+R6k4fj0ircB6XiTSFjZWolbog9N11digF8nkOGkn/zRnwbkJ0gJjh1iGjooQ==
X-Received: by 2002:a05:6214:590b:b0:91c:7c53:152d with SMTP id
 6a1803df08f44-91ea970cf80mr604666d6.29.1793909099570; 
 Thu, 05 Nov 2026 12:04:59 -0800 (PST)
Received: from X1-Gen-9.iol.unh.edu ([2606:4100:3880:1271:52c6:dd10:2790:6507])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91ea6a71bfesm3544646d6.25.2026.11.05.12.04.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 12:04:59 -0800 (PST)
From: Dillon Ladd <dladd@iol.unh.edu>
To: patrickrobb1997@gmail.com,
	luca.vizzarro@arm.com
Cc: dev@dpdk.org, knimoji@iol.unh.edu, abailey@iol.unh.edu,
 Dillon Ladd <dladd@iol.unh.edu>
Subject: [PATCH v2 1/2] dts: add eventdev API
Date: Thu,  5 Nov 2026 15:04:11 -0500
Message-ID: <20261105200413.513618-1-dladd@iol.unh.edu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261105174137.498850-1-dladd@iol.unh.edu>
References: <20261105174137.498850-1-dladd@iol.unh.edu>
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

