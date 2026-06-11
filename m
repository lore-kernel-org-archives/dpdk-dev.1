Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0221CD98C7
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 21:23:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1AD5943419;
	Thu, 11 Jun 2026 23:21:44 +0200 (CEST)
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177]) by mails.dpdk.org (Postfix) with ESMTP id 2E2AA433FE
 for <dev@dpdk.org>; Thu, 11 Jun 2026 23:21:40 +0200 (CEST)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-304d8362a58so272255eec.1
 for <dev@dpdk.org>; Thu, 11 Jun 2026 14:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781212899;
 x=1781817699; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9qH2n3nnTkVykMc31cctxUYfwIMw+oX7goZ456FlmLk=;
 b=Kr0mIAMOIuHftGJ6y6mNP9oJ2gY34cluGrBB/ePvmFGYdA8+bAzTRRtQniMH4y6yMb
 YnXJpBcJ4Nva+I162U3DWk+vF24jITO4S+ytrgLVN1QJiAYCTd25CRto0GrZYPLklN9m
 HYViM6jApXU0RKNHHwBwrgVSBAHuANYJvEKZasGu9cGc+3sLcDBIpm4m4nHHq4YOTyRV
 gGpVgaLQhy5JyRvdFgfoKcgeBxs3xBLfWDOvhBYFcveFvRXAjpTipie1LsutG1TEa6ej
 3L8ybazWm4jLe059bF72EhFlwtkshcQBxSHPDK8QOf47hil5UWTIYG/44ZDr9EP9Q9uc
 YrYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781212899; x=1781817699;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9qH2n3nnTkVykMc31cctxUYfwIMw+oX7goZ456FlmLk=;
 b=Wvs8pfZ2A9GQEc+7rzbN0yeL42gDY0K2ogENWMmJqJZ0uNXoCZ9fWp6ipfTpjt1lyl
 TqrEzwtJFUxHD4Xo6sXJhLuom4/DJdLzmlwyU8TbwjoKGiaTGf+odLxCJ/Tc5AUmn0RQ
 GGDEJlBCOUjZ1WLwcgiTXLkV/A0dDfHhWebj+pc4V3kqX1KHwpBdHed6U2ubWeXYfUuN
 0hivmhTiMftqUun6JoJ/G4ZBm6IOkf4i2WKGtwQrbEIDjQUlSKnQX3fLBEaDnK9pH4l+
 +0m5AEThh/MweV2FjfCOPowtGxBH9OdVIUx1iDV2umzSs2C6i6FzqvEJdhU60qLlmDy4
 q6hQ==
X-Gm-Message-State: AOJu0YyfMtS6FKcwZMbABKbUfV7Ki1qk5XZbBfL1PiL0eR6fe8xUzPFM
 APzVcOmr8OhokSf7s4ilONf7J89coxAv2aSRwTi8F12rjsxsvTfaO6WQjhMAqmbejPlC5Jc8EiX
 zVT3/
X-Gm-Gg: Acq92OGMfepzSjuakJ0a7vivJ5QvmIjLWKa1+u32XttzMaYJfeXuOG46AKffVJOYtqX
 6xPlbX1S1tM7ONFv9YnOBsPfZIujD1eUm8vCxOciAq2nxIpFfjJ9au1kHrYEzKrGcjhU/2DGviZ
 CP/JU0TUlp0aCZMGnuadkMG1/rqp7UlOg/N2KAfPuwZc5UyHYIyc4WzEXEES4/gLWdH/WJxEEcY
 vjeVZyFczpJfQ4EJNmbizLZdhigmSUzwJJdV6Xqiy0t7eTn6zj/W92xGx4DMF4ZIzVrZCfzWJ4N
 Q69JpdVTvw5HLMo3ay37mdwpSV6HazS3jsqgTnVjYcjUF/jaK20RxI8+dsHgCJPsrfD0ta5w17g
 BnnSkSOfTp77LCRWXvlDv3eP0aq/JCq3b2WGIDiaH+knfWVoFS1YOWt1JxNt9BWemuvyveGk+3E
 p94nmnwI692e+2OLcjasSBKI1DjjGvf4gFBdeJGs5YfkT4/4tpAb2N6DPq4bQ/GA==
X-Received: by 2002:a05:7301:fa04:b0:2ed:a58c:942 with SMTP id
 5a478bee46e88-3081efc43c8mr252690eec.8.1781212898961; 
 Thu, 11 Jun 2026 14:21:38 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081eb95450sm546238eec.28.2026.06.11.14.21.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 14:21:38 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nicolas Chautru <nicolas.chautru@intel.com>,
 Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Radu Nicolau <radu.nicolau@intel.com>, Akhil Goyal <gakhil@marvell.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>,
 Rajesh Kumar <rajesh3.kumar@intel.com>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 John McNamara <john.mcnamara@intel.com>
Subject: [PATCH 15/15] doc: correct grammar and punctuation consistency issues
Date: Thu, 11 Jun 2026 14:18:54 -0700
Message-ID: <20260611212119.1026721-16-stephen@networkplumber.org>
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

Correct grammar and punctuation issues across sample application guides:
- Added missing comma after "To compile the sample application" in 11 files
- Added missing period in cmd_line.rst compilation instruction
- Fixed capitalization of "Linux" (was lowercase "linux") in 4 files
- Fixed capitalization of "Ethernet" (was lowercase "ethernet") in 2 files
- Fixed "then" to "than" in comparison contexts (2 instances)
- Fixed subject-verb agreement: "specify" to "specifies"

These changes ensure consistency with the style used in other documentation
files and improve overall readability.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/sample_app_ug/bbdev_app.rst        |  4 ++--
 doc/guides/sample_app_ug/cmd_line.rst         |  2 +-
 doc/guides/sample_app_ug/ethtool.rst          |  2 +-
 doc/guides/sample_app_ug/fips_validation.rst  |  2 +-
 doc/guides/sample_app_ug/hello_world.rst      |  2 +-
 doc/guides/sample_app_ug/ipsec_secgw.rst      | 20 +++++++++----------
 .../sample_app_ug/l2_forward_real_virtual.rst |  4 ++--
 doc/guides/sample_app_ug/link_status_intr.rst |  2 +-
 doc/guides/sample_app_ug/multi_process.rst    |  2 +-
 doc/guides/sample_app_ug/ntb.rst              |  2 +-
 doc/guides/sample_app_ug/ptp_tap_relay_sw.rst |  2 +-
 doc/guides/sample_app_ug/ptpclient.rst        |  2 +-
 doc/guides/sample_app_ug/qos_metering.rst     |  2 +-
 doc/guides/sample_app_ug/rxtx_callbacks.rst   |  2 +-
 14 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/doc/guides/sample_app_ug/bbdev_app.rst b/doc/guides/sample_app_ug/bbdev_app.rst
index 00bbd1aa27..58deb6d90f 100644
--- a/doc/guides/sample_app_ug/bbdev_app.rst
+++ b/doc/guides/sample_app_ug/bbdev_app.rst
@@ -25,7 +25,7 @@ The MAC header is preserved in the packet throughout the loop-back operation.
 Limitations
 -----------
 
-* Only one baseband device and one ethernet port can be used.
+* Only one baseband device and one Ethernet port can be used.
 
 Compiling the Application
 -------------------------
@@ -34,7 +34,7 @@ DPDK needs to be built with ``baseband_turbo_sw`` PMD enabled along
 with ``FLEXRAN SDK`` Libraries. Refer to *SW Turbo Poll Mode Driver*
 documentation for more details.
 
-To compile the sample application see :doc:`compiling`.
+To compile the sample application, see :doc:`compiling`.
 
 
 Running the Application
diff --git a/doc/guides/sample_app_ug/cmd_line.rst b/doc/guides/sample_app_ug/cmd_line.rst
index 5b192bc615..072e4850b4 100644
--- a/doc/guides/sample_app_ug/cmd_line.rst
+++ b/doc/guides/sample_app_ug/cmd_line.rst
@@ -47,7 +47,7 @@ There are three simple commands:
 Compiling the Application
 -------------------------
 
-To compile the sample application see :doc:`compiling`
+To compile the sample application, see :doc:`compiling`.
 
 The application is located in the ``cmd_line`` sub-directory.
 
diff --git a/doc/guides/sample_app_ug/ethtool.rst b/doc/guides/sample_app_ug/ethtool.rst
index 68bcf25b1f..4f740b09a7 100644
--- a/doc/guides/sample_app_ug/ethtool.rst
+++ b/doc/guides/sample_app_ug/ethtool.rst
@@ -18,7 +18,7 @@ is based upon a simple L2 frame reflector.
 Compiling the Application
 -------------------------
 
-To compile the sample application see :doc:`compiling`.
+To compile the sample application, see :doc:`compiling`.
 
 The application is located in the ``ethtool`` subdirectory.
 
diff --git a/doc/guides/sample_app_ug/fips_validation.rst b/doc/guides/sample_app_ug/fips_validation.rst
index 732f47212a..ad51beb4f4 100644
--- a/doc/guides/sample_app_ug/fips_validation.rst
+++ b/doc/guides/sample_app_ug/fips_validation.rst
@@ -96,7 +96,7 @@ Compiling the Application
 
 * Compile Application
 
-    To compile the sample application see :doc:`compiling`.
+    To compile the sample application, see :doc:`compiling`.
 
 *  Run ``dos2unix`` on the request files
 
diff --git a/doc/guides/sample_app_ug/hello_world.rst b/doc/guides/sample_app_ug/hello_world.rst
index 603a1d8767..feee6b52ae 100644
--- a/doc/guides/sample_app_ug/hello_world.rst
+++ b/doc/guides/sample_app_ug/hello_world.rst
@@ -14,7 +14,7 @@ The application simply prints a "helloworld" message on every enabled lcore.
 Compiling the Application
 -------------------------
 
-To compile the sample application see :doc:`compiling`.
+To compile the sample application, see :doc:`compiling`.
 
 The application is located in the ``helloworld`` sub-directory.
 
diff --git a/doc/guides/sample_app_ug/ipsec_secgw.rst b/doc/guides/sample_app_ug/ipsec_secgw.rst
index 8826ffb286..1f172fd4b6 100644
--- a/doc/guides/sample_app_ug/ipsec_secgw.rst
+++ b/doc/guides/sample_app_ug/ipsec_secgw.rst
@@ -89,7 +89,7 @@ The application supports two modes of operation: poll mode and event mode.
   **Currently the application provides non-burst, internal port worker threads.**
   It also provides infrastructure for non-internal ports but does not define any worker threads.
 
-  Event mode also supports event vectorization. The event devices, ethernet device
+  Event mode also supports event vectorization. The event devices, Ethernet device
   pairs which support the capability ``RTE_EVENT_ETH_RX_ADAPTER_CAP_EVENT_VECTOR`` can
   aggregate packets based on flow characteristics and generate a ``rte_event``
   containing ``rte_event_vector``.
@@ -245,9 +245,9 @@ Where:
     Zero value disables reassembly functionality.
     Default value: 0.
 
-*   ``--mtu MTU``: MTU value (in bytes) on all attached ethernet ports.
-    Outgoing packets with length bigger then MTU will be fragmented.
-    Incoming packets with length bigger then MTU will be discarded.
+*   ``--mtu MTU``: MTU value (in bytes) on all attached Ethernet ports.
+    Outgoing packets with length bigger than MTU will be fragmented.
+    Incoming packets with length bigger than MTU will be discarded.
     Default value: 1500.
 
 *   ``--frag-ttl FRAG_TTL_NS``: fragment lifetime (in nanoseconds).
@@ -694,10 +694,10 @@ where each options means:
 
 ``<type>``
 
- * Action type to specify the security action. This option specify
+ * Action type to specify the security action. This option specifies
    the SA to be performed with look aside protocol offload to HW
-   accelerator or protocol offload on ethernet device or inline
-   crypto processing on the ethernet device during transmission.
+   accelerator or protocol offload on Ethernet device or inline
+   crypto processing on the Ethernet device during transmission.
 
  * Optional: Yes, default type *no-offload*
 
@@ -1083,7 +1083,7 @@ The test directory contains scripts for testing the various encryption
 algorithms.
 
 The purpose of the scripts is to automate ipsec-secgw testing
-using another system running linux as a DUT.
+using another system running Linux as a DUT.
 
 The user must setup the following environment variables:
 
@@ -1127,11 +1127,11 @@ key to the DUT. It will ask for credentials so that it can upload the public key
 
 The SUT and DUT are connected through at least 2 NIC ports.
 
-One NIC port is expected to be managed by linux on both machines and will be
+One NIC port is expected to be managed by Linux on both machines and will be
 used as a control path.
 
 The second NIC port (test-port) should be bound to DPDK on the SUT, and should
-be managed by linux on the DUT.
+be managed by Linux on the DUT.
 
 The script starts ``ipsec-secgw`` with 2 NIC devices: ``test-port`` and
 ``tap vdev``.
diff --git a/doc/guides/sample_app_ug/l2_forward_real_virtual.rst b/doc/guides/sample_app_ug/l2_forward_real_virtual.rst
index dbe880e1b3..e31dd98ae5 100644
--- a/doc/guides/sample_app_ug/l2_forward_real_virtual.rst
+++ b/doc/guides/sample_app_ug/l2_forward_real_virtual.rst
@@ -111,14 +111,14 @@ where,
 
 *   --portmap="(port,port)[,(port,port)]": Determines forwarding ports mapping.
 
-To run the application in linux environment with 4 lcores, 16 ports and 8 RX queues per lcore and MAC address
+To run the application in Linux environment with 4 lcores, 16 ports and 8 RX queues per lcore and MAC address
 updating enabled, issue the command:
 
 .. code-block:: console
 
     $ ./<build_dir>/examples/dpdk-l2fwd -l 0-3 -- -q 8 -p ffff
 
-To run the application in linux environment with 4 lcores, 4 ports, 8 RX queues
+To run the application in Linux environment with 4 lcores, 4 ports, 8 RX queues
 per lcore, to forward RX traffic of ports 0 & 1 on ports 2 & 3 respectively and
 vice versa, issue the command:
 
diff --git a/doc/guides/sample_app_ug/link_status_intr.rst b/doc/guides/sample_app_ug/link_status_intr.rst
index fd4e32560c..d1021df5c8 100644
--- a/doc/guides/sample_app_ug/link_status_intr.rst
+++ b/doc/guides/sample_app_ug/link_status_intr.rst
@@ -50,7 +50,7 @@ where,
 
 *   -T PERIOD: statistics will be refreshed each PERIOD seconds (0 to disable, 10 default)
 
-To run the application in a linux environment with 4 lcores, 16 ports and 8 RX queues per lcore,
+To run the application in a Linux environment with 4 lcores, 16 ports and 8 RX queues per lcore,
 issue the command:
 
 .. code-block:: console
diff --git a/doc/guides/sample_app_ug/multi_process.rst b/doc/guides/sample_app_ug/multi_process.rst
index e9e5809a92..f1ec980e20 100644
--- a/doc/guides/sample_app_ug/multi_process.rst
+++ b/doc/guides/sample_app_ug/multi_process.rst
@@ -16,7 +16,7 @@ The multi-process example applications are built the same way as other sample ap
 and as documented in the *DPDK Getting Started Guide*.
 
 
-To compile the sample application see :doc:`compiling`.
+To compile the sample application, see :doc:`compiling`.
 
 The applications are located in the ``multi_process`` sub-directory.
 
diff --git a/doc/guides/sample_app_ug/ntb.rst b/doc/guides/sample_app_ug/ntb.rst
index ca0ff54757..8557b73042 100644
--- a/doc/guides/sample_app_ug/ntb.rst
+++ b/doc/guides/sample_app_ug/ntb.rst
@@ -20,7 +20,7 @@ This sample supports 4 types of packet forwarding mode.
 Compiling the Application
 -------------------------
 
-To compile the sample application see :doc:`compiling`.
+To compile the sample application, see :doc:`compiling`.
 
 The application is located in the ``ntb`` sub-directory.
 
diff --git a/doc/guides/sample_app_ug/ptp_tap_relay_sw.rst b/doc/guides/sample_app_ug/ptp_tap_relay_sw.rst
index 466879cd46..a880a1295a 100644
--- a/doc/guides/sample_app_ug/ptp_tap_relay_sw.rst
+++ b/doc/guides/sample_app_ug/ptp_tap_relay_sw.rst
@@ -75,7 +75,7 @@ This minimises the gap between the measured timestamp and the actual wire egress
 Compiling the Application
 -------------------------
 
-To compile the sample application see :doc:`compiling`.
+To compile the sample application, see :doc:`compiling`.
 
 The application is located in the ``ptp_tap_relay_sw`` sub-directory.
 
diff --git a/doc/guides/sample_app_ug/ptpclient.rst b/doc/guides/sample_app_ug/ptpclient.rst
index 28007604a0..b842f5e0b8 100644
--- a/doc/guides/sample_app_ug/ptpclient.rst
+++ b/doc/guides/sample_app_ug/ptpclient.rst
@@ -58,7 +58,7 @@ synchronizes the PTP PHC clock with the Linux kernel clock.
 Compiling the Application
 -------------------------
 
-To compile the sample application see :doc:`compiling`.
+To compile the sample application, see :doc:`compiling`.
 
 The application is located in the ``ptpclient`` sub-directory.
 
diff --git a/doc/guides/sample_app_ug/qos_metering.rst b/doc/guides/sample_app_ug/qos_metering.rst
index b317d4079d..e8f3c6af19 100644
--- a/doc/guides/sample_app_ug/qos_metering.rst
+++ b/doc/guides/sample_app_ug/qos_metering.rst
@@ -38,7 +38,7 @@ all the incoming packets are colored as green.
 Compiling the Application
 -------------------------
 
-To compile the sample application see :doc:`compiling`.
+To compile the sample application, see :doc:`compiling`.
 
 The application is located in the ``qos_meter`` sub-directory.
 
diff --git a/doc/guides/sample_app_ug/rxtx_callbacks.rst b/doc/guides/sample_app_ug/rxtx_callbacks.rst
index 7dfcab5d65..31e2e5c811 100644
--- a/doc/guides/sample_app_ug/rxtx_callbacks.rst
+++ b/doc/guides/sample_app_ug/rxtx_callbacks.rst
@@ -33,7 +33,7 @@ The application is located in the ``rxtx_callbacks`` sub-directory.
 Running the Application
 -----------------------
 
-To run the example in a ``linux`` environment:
+To run the example in a ``Linux`` environment:
 
 .. code-block:: console
 
-- 
2.53.0

