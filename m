Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F16CD98C7
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 21:22:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 32DB4433FF;
	Thu, 11 Jun 2026 23:21:40 +0200 (CEST)
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180]) by mails.dpdk.org (Postfix) with ESMTP id F1187433D3
 for <dev@dpdk.org>; Thu, 11 Jun 2026 23:21:35 +0200 (CEST)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-307d0405e07so507116eec.1
 for <dev@dpdk.org>; Thu, 11 Jun 2026 14:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781212895;
 x=1781817695; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qHC/hioDHh1g/4s7vl5QjhRyknxxKx2ge1mXQ9MqaHI=;
 b=XqwEBool9Bh8/xn1cdHK04gqylPbeqBkYftY246KGCDBj3pnNt/pN1/aDfSHorYh2r
 vOZDtFJzie1HLk7cPG1i/jb9bb5Qm9vyg/zhBiH9Ex5Eq0lMPVGHbRx3Vtd9FP9b0YEB
 n/HFci2U7sgvc9UISOHZliESGTJGt2x6v0PZY+7wZ+stbvyWGeL8tDuX5xG6TkAw6CxI
 1xgUy4lpaJdMgtT9toFPebGdQLI4EUGKyNrKvWzSsRLbLsPFzaamRI1Ec0ki17LHGKyH
 ak/0VdY6suIh4TZTGsputaQk9js/QgYNsOL7XvoRduwxCWQ5gVz/v7jdxpuFoB2lxWzd
 QF1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781212895; x=1781817695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qHC/hioDHh1g/4s7vl5QjhRyknxxKx2ge1mXQ9MqaHI=;
 b=iVPKJ+nvHNF1UdVM4k2m9C9545mu0zBefuVTUxYRklL/SH+UkcN1qSOt7eoOLah0ai
 WBI9IZkOwPNQdrNIn7vFlYcYqIEQDWCvcQBBEUclUYtb9ruZlVvTgNfliQJWwuFVve3n
 O4lR0dXjXalbNcC4Iil+W6gnyIyTWrJjFF4+nEMz4BFhTST3qkUJo1XbDkxOIguJUU8f
 rPp8/fLb19hF50/XsOKP3/UnOnX6xm2LMZnDI41fm1JOIvUxPLk9fqlqDJov/J4b9xS7
 k7r9gxO2+8MzKZ6d+Ti5LL4nqW+g/F67AmHKfr0WOdUhdNt6boH4ZbDQ0IR88EYX2RhZ
 ITcQ==
X-Gm-Message-State: AOJu0Yw8nWp2Z7cH2P1Gy2UjwYst9XdpfMaMI6y+J8UgIseXndj8sGhF
 pyU4jtXdkG9de61zfPnZh4jaKGnSeGbNb+jxO2KdU9cwOWwrizZHs2BOjLni4vl2lpIpdj2jBzn
 t2lN4
X-Gm-Gg: Acq92OHNhMMn6dI4nd9lnZ6uDUXNyMhMYp3hSgeLYeyqHsRjf+7zAznmtT7JnBc6V2P
 gezp4ZznVC8DXsvsWn97Z11V0wr+xRm3dSCmZp+c2ZD4J+WNYodFQjSQuKgOqvKEbft2BEOvUvM
 zq+bFP8HCU1EhbaDOQyLmC6gKoBygZ8+/YcNq9/yxgO7bFowzoP6uUbJjGoZrAu7Gx3/Ma04XgZ
 OxbuoPiXLdw5qgQ0k8ut4XOXNxnIq7hxHdindW7+Ei16uVMRFuKkZ/5EWn5+0DfPShls0ikQniM
 E7H+qJ/oca3gEXba+hB3lJkhZAByzGaN5Zf/UtfqrrWRPWzLNZg3nE3rQkQ4+8s1dR+WDy/hRUR
 2po/xJlChtLQyfnBOdt0BSbK3UVvLhIagL0WFw4ueHfaK6vFy1tFZK+aRVCyl8dv5I3N/OBHRDu
 O6e7/yVxUBSDBjtHkGpNkDdsoCCdVzH0ltYTPN7qYmS4d4HWE6paURyzDDaD/i/g==
X-Received: by 2002:a05:7300:7496:b0:2da:a813:a5fd with SMTP id
 5a478bee46e88-30820086f78mr28083eec.22.1781212894805; 
 Thu, 11 Jun 2026 14:21:34 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081eb95450sm546238eec.28.2026.06.11.14.21.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 14:21:34 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 John McNamara <john.mcnamara@intel.com>,
 Yipeng Wang <yipeng1.wang@intel.com>
Subject: [PATCH 12/15] doc: improve QoS, callbacks, EFD,
 and service cores guides
Date: Thu, 11 Jun 2026 14:18:51 -0700
Message-ID: <20260611212119.1026721-13-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260611212119.1026721-1-stephen@networkplumber.org>
References: <20250216230903.124496-1-nandinipersad361@gmail.com>
 <20260611212119.1026721-1-stephen@networkplumber.org>
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

Enhanced documentation for QoS and service applications:

qos_metering.rst:
- Improved traffic metering algorithm descriptions
- Fixed formatting consistency

qos_scheduler.rst:
- Enhanced hierarchical scheduler explanations
- Improved traffic class descriptions

rxtx_callbacks.rst:
- Clarified callback mechanism usage
- Fixed formatting in code examples

server_node_efd.rst:
- Minor formatting improvements

service_cores.rst:
- Restructured service core architecture descriptions
- Improved service mapping explanations
- Enhanced clarity of multi-service configurations

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/sample_app_ug/qos_metering.rst    |  9 +--
 doc/guides/sample_app_ug/qos_scheduler.rst   | 16 +++--
 doc/guides/sample_app_ug/rxtx_callbacks.rst  |  9 ++-
 doc/guides/sample_app_ug/server_node_efd.rst |  4 +-
 doc/guides/sample_app_ug/service_cores.rst   | 67 +++++++++++---------
 5 files changed, 56 insertions(+), 49 deletions(-)

diff --git a/doc/guides/sample_app_ug/qos_metering.rst b/doc/guides/sample_app_ug/qos_metering.rst
index e7101559aa..b317d4079d 100644
--- a/doc/guides/sample_app_ug/qos_metering.rst
+++ b/doc/guides/sample_app_ug/qos_metering.rst
@@ -4,7 +4,7 @@
 QoS Metering Sample Application
 ===============================
 
-The QoS meter sample application is an example that demonstrates the use of DPDK to provide QoS marking and metering,
+The QoS meter sample application demonstrates the use of DPDK to provide QoS marking and metering,
 as defined by RFC2697 for Single Rate Three Color Marker (srTCM) and RFC 2698 for Two Rate Three Color Marker (trTCM) algorithm.
 
 Overview
@@ -14,7 +14,8 @@ The application uses a single thread for reading the packets from the RX port,
 metering, marking them with the appropriate color (green, yellow or red) and writing them to the TX port.
 
 A policing scheme can be applied before writing the packets to the TX port by dropping or
-changing the color of the packet in a static manner depending on both the input and output colors of the packets that are processed by the meter.
+changing the color of the packet in a static manner. This would depend on both the input and output colors
+of the packets that are processed by the meter.
 
 The operation mode can be selected as compile time out of the following options:
 
@@ -126,9 +127,9 @@ There are four different actions:
 
 In this particular case:
 
-*   Every packet which input and output color are the same, keeps the same color.
+*   For every packet where the input and output color are the same, keep the same color.
 
-*   Every packet which color has improved is dropped (this particular case can't happen, so these values will not be used).
+*   For every packet where the color has improved is dropped (this particular case can't happen, so these values will not be used).
 
 *   For the rest of the cases, the color is changed to red.
 
diff --git a/doc/guides/sample_app_ug/qos_scheduler.rst b/doc/guides/sample_app_ug/qos_scheduler.rst
index cd33beecb0..645f134e7f 100644
--- a/doc/guides/sample_app_ug/qos_scheduler.rst
+++ b/doc/guides/sample_app_ug/qos_scheduler.rst
@@ -20,24 +20,26 @@ The architecture of the QoS scheduler application is shown in the following figu
 
 There are two flavors of the runtime execution for this application,
 with two or three threads per each packet flow configuration being used.
-The RX thread reads packets from the RX port,
+
+The RX thread reads packets from the RX port and
 classifies the packets based on the double VLAN (outer and inner) and
-the lower byte of the IP destination address and puts them into the ring queue.
+the lower byte of the IP destination address. It then puts them into the ring queue.
+
 The worker thread dequeues the packets from the ring and calls the QoS scheduler enqueue/dequeue functions.
 If a separate TX core is used, these are sent to the TX ring.
 Otherwise, they are sent directly to the TX port.
-The TX thread, if present, reads from the TX ring and write the packets to the TX port.
+The TX thread, if present, reads from the TX ring and writes the packets to the TX port.
 
 Compiling the Application
 -------------------------
 
-To compile the sample application see :doc:`compiling`.
+To compile the sample application, see :doc:`compiling`.
 
 The application is located in the ``qos_sched`` sub-directory.
 
     .. note::
 
-        This application is intended as a linux only.
+        This application is intended for Linux only.
 
 .. note::
 
@@ -63,7 +65,7 @@ Mandatory application parameters include:
 
 *   --pfc "RX PORT, TX PORT, RX LCORE, WT LCORE, TX CORE": Packet flow configuration.
     Multiple pfc entities can be configured in the command line,
-    having 4 or 5 items (if TX core defined or not).
+    with 4 or 5 items (depending on whether a TX core is defined).
 
 Optional application parameters include:
 
@@ -153,7 +155,7 @@ These are the commands that are currently working under the command line interfa
 
 All of these commands work the same way, averaging the number of packets throughout a specific subset of queues.
 
-Two parameters can be configured for this prior to calling any of these commands:
+Two parameters can be configured prior to calling any of these commands:
 
     *   qavg n X: n is the number of times that the calculation will take place.
         Bigger numbers provide higher accuracy. The default value is 10.
diff --git a/doc/guides/sample_app_ug/rxtx_callbacks.rst b/doc/guides/sample_app_ug/rxtx_callbacks.rst
index cd6512508b..7dfcab5d65 100644
--- a/doc/guides/sample_app_ug/rxtx_callbacks.rst
+++ b/doc/guides/sample_app_ug/rxtx_callbacks.rst
@@ -18,10 +18,9 @@ prior to transmission to calculate the elapsed time in CPU cycles.
 
 If hardware timestamping is supported by the NIC, the sample application will
 also display the average latency.
-The packet was timestamped in hardware
-on top of the latency since the packet was received and processed by the RX
-callback.
-
+This shows the additional hardware timestamping latency on top of the
+software latency measured since the packet was received and processed by
+the RX callback.
 
 Compiling the Application
 -------------------------
@@ -72,7 +71,7 @@ callbacks are added. This is explained in the next section:
 
 
 The Port Initialization Function
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 The main functional part of the port initialization is shown below with
 comments:
diff --git a/doc/guides/sample_app_ug/server_node_efd.rst b/doc/guides/sample_app_ug/server_node_efd.rst
index c90d74ae1c..d543148328 100644
--- a/doc/guides/sample_app_ug/server_node_efd.rst
+++ b/doc/guides/sample_app_ug/server_node_efd.rst
@@ -9,7 +9,7 @@ load balancer. For more information about the EFD Library, please refer to the
 DPDK programmer's guide.
 
 This sample application is a variant of the :doc:`multi_process`
-where a specific target node is specified for every and each flow
+where a specific target node is specified for each flow
 (not in a round-robin fashion as the original load balancing sample application).
 
 Overview
@@ -192,7 +192,7 @@ flow is not handled by the node.
     :start-after: Packets dequeued from the shared ring. 8<
     :end-before: >8 End of packets dequeuing.
 
-Finally, note that both processes updates statistics, such as transmitted, received
+Finally, note that both processes update statistics, such as transmitted, received
 and dropped packets, which are shown and refreshed by the server app.
 
 .. literalinclude:: ../../../examples/server_node_efd/efd_server/main.c
diff --git a/doc/guides/sample_app_ug/service_cores.rst b/doc/guides/sample_app_ug/service_cores.rst
index 307a6c5fbb..11b6ebde1e 100644
--- a/doc/guides/sample_app_ug/service_cores.rst
+++ b/doc/guides/sample_app_ug/service_cores.rst
@@ -4,31 +4,34 @@
 Service Cores Sample Application
 ================================
 
-The service cores sample application demonstrates the service cores capabilities
-of DPDK. The service cores infrastructure is part of the DPDK EAL, and allows
-any DPDK component to register a service. A service is a work item or task, that
+Overview
+--------
+
+This sample application demonstrates the service cores API of DPDK.
+The service cores infrastructure is part of the DPDK EAL and allows any
+DPDK component to register a service. A service is a work item or task that
 requires CPU time to perform its duty.
 
-This sample application registers 5 dummy services. These 5 services are used
-to show how the service_cores API can be used to orchestrate these services to
-run on different service lcores. This orchestration is done by calling the
-service cores APIs, however the sample application introduces a "profile"
-concept to contain the service mapping details. Note that the profile concept
-is application specific, and not a part of the service cores API.
+This sample application registers 5 dummy services to demonstrate how the
+service cores API can orchestrate these services to run on different service
+lcores. The orchestration is performed by calling the service cores APIs.
+The sample application introduces a "profile" concept to group service-to-core
+mapping configurations. Note that profiles are application-specific and not
+part of the service cores API itself.
 
 
 Compiling the Application
 -------------------------
 
-To compile the sample application see :doc:`compiling`.
+See :doc:`compiling`.
 
 The application is located in the ``service_cores`` sub-directory.
 
 Running the Application
 -----------------------
 
-To run the example, just execute the binary. Since the application dynamically
-adds service cores in the application code itself, there is no requirement to
+To run the example, execute the binary. Since the application dynamically
+adds service cores at runtime, there is no requirement to
 pass a service core-mask as an EAL argument at startup time.
 
 .. code-block:: console
@@ -39,19 +42,19 @@ pass a service core-mask as an EAL argument at startup time.
 Explanation
 -----------
 
-The following sections provide some explanation of code focusing on
-registering applications from an applications point of view, and modifying the
-service core counts and mappings at runtime.
+The following sections explain the application code, focusing on registering
+services from an application's perspective and modifying service core counts
+and mappings at runtime.
 
 
 Registering a Service
 ~~~~~~~~~~~~~~~~~~~~~
 
 The following code section shows how to register a service as an application.
-Note that the service component header must be included by the application in
-order to register services: ``rte_service_component.h``, in addition
-to the ordinary service cores header ``rte_service.h`` which provides
-the runtime functions to add, remove and remap service cores.
+Note: The service component header must be included by the application in
+order to register services: ``rte_service_component.h``. In addition, the
+service cores header ``rte_service.h`` provides the runtime functions to add,
+remove, and remap service cores.
 
 .. literalinclude:: ../../../examples/service_cores/main.c
     :language: c
@@ -63,9 +66,9 @@ the runtime functions to add, remove and remap service cores.
 Controlling A Service Core
 ~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-This section demonstrates how to add a service core. The ``rte_service.h``
-header file provides the functions for dynamically adding and removing cores.
-The APIs to add and remove cores use lcore IDs similar to existing DPDK
+This section demonstrates how to add a service core and assign a service to it.
+The ``rte_service.h`` header file provides functions for dynamically adding
+and removing cores. These APIs use lcore IDs similar to existing DPDK
 functions.
 
 These are the functions to start a service core, and have it run a service:
@@ -79,18 +82,20 @@ These are the functions to start a service core, and have it run a service:
 Removing A Service Core
 ~~~~~~~~~~~~~~~~~~~~~~~
 
-To remove a service core, the steps are similar to adding but in reverse order.
-Note that it is not allowed to remove a service core if the service is running,
-and the service-core is the only core running that service (see documentation
+To remove a service core, perform the adding steps in reverse order.
+Note: Removing a service core is not allowed if a service is running and
+the service core is the only core running that service (see documentation
 for ``rte_service_lcore_stop`` function for details).
 
 
 Conclusion
 ~~~~~~~~~~
 
-The service cores infrastructure provides DPDK with two main features. The first
-is to abstract away hardware differences: the service core can CPU cycles to
-a software fallback implementation, allowing the application to be abstracted
-from the difference in HW / SW availability. The second feature is a flexible
-method of registering functions to be run, allowing the running of the
-functions to be scaled across multiple CPUs.
+The service cores infrastructure provides DPDK with two main features.
+
+First, it abstracts hardware differences: service cores can provide CPU cycles
+to software fallback implementations, allowing applications to be abstracted
+from hardware and software availability differences.
+
+Second, it provides a flexible method for registering functions to run,
+allowing function execution to scale across multiple CPUs.
-- 
2.53.0

