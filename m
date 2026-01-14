Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8416AD3CC86
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 22:26:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 72EF5410DC;
	Wed, 14 Jan 2026 23:25:23 +0100 (CET)
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
 [209.85.128.66]) by mails.dpdk.org (Postfix) with ESMTP id 83297410DC
 for <dev@dpdk.org>; Wed, 14 Jan 2026 23:25:22 +0100 (CET)
Received: by mail-wm1-f66.google.com with SMTP id
 5b1f17b1804b1-47a95efd2ceso2676635e9.2
 for <dev@dpdk.org>; Wed, 14 Jan 2026 14:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768429522;
 x=1769034322; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wl7E/xJw9J2ZEAvthqdps963jAYHV7WZE8qWEIjlBoE=;
 b=I1VxFzr9GKKcYLV4Gf72wzPT0oSLrYBq+H8cT7JC1xlksPagCkIF3Up+hAbN+oIdE9
 Yruz6MUeUEiW7lYehseaqChGKYTeYimidUkqRlIgo7JteJqB/6orcoOOtomIKjZsLmtQ
 GZG3gN2/geW2nJpUa1/9ixtSrL+snu0Fo+eYj5m/kfqqEWN0m74FdQ4VNtddnJtTQyug
 CX/6xrEYeiexshg8DgyvY54DCe4cjfOHTMHqBt7Uj8QaWGkGRHAxeT5kAszdQNoiYwW8
 +mjC5J0eRXqr00pSZOPzFwF7QlX9XRFpxB8P/EQP8M5V+SotlUNMStcupew8EZbGhkdm
 Mbdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768429522; x=1769034322;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Wl7E/xJw9J2ZEAvthqdps963jAYHV7WZE8qWEIjlBoE=;
 b=lLmxxdwEIDNdsXeHzM4A/Ku6O2N6edohVbRlYq74eh0yQBMU55XTIaRLWcBIBsbx0T
 WKyWwT4+ECdsxNiYu8jLeyKZ9ui0hxNe3DKPSEEL/qwf69jR4evpAHWDMDdWHiZExSx4
 k4w/iwrgFTmj60GwjlLKx4CDqsyyudI3/q5FxGBOoQLVLoXgKniA8jrO17n3RJjlLpEG
 sAHi6L+s+kOls2h3CVPacMOPjf0NkuqW17eIwNpiEvJRu6oDegLB41YOKkvFc3nQ11XW
 RQyYpNT+5xirC2/SYI3zSu21jn1FaqiwTk3rmdH9OVkKFCp7E4Im5QTZaTalKZQepO7w
 Q5KA==
X-Gm-Message-State: AOJu0YzU+2+DvieltoZu8OydvJIYDonjjyQ0GFvfRWdamb7YMp/Z7V+u
 B0eS2K4iZe1O8vdrqnCr7r76sCjMc1QYZ7tch4sTse16g+LaMsBJutuUfZ+W4l5kzt3MMbIgiB+
 j9NjAj9g=
X-Gm-Gg: AY/fxX5/4Spn0dAnPoyP+xisjiXo74DeVFUX4GZWvnmegKe4qWAqEXg9t/MEwMVAcPh
 QAMN5Q3hcCzOWwcDQEyuJIBiCFs3S9IR5vlg6HyiGM/XCy1uSAW3TqueSoO7uTlrK+nRQ6k1u7c
 esxnJShiLlNM1ePK36zfUM6PGY7agpe26ZtkXdf2vWYTfH+5gM2JjtBm8QpTxxvi5jYblWqAz08
 CUaju58epo37+Mv5MAPbJCx88QZIxNR/a81HfTJx8+fkA+zLwuJOACXYXEPlF2nCtryzJhwJ/PQ
 F2Un1NnzFFzXDzc+peNTIG5/4zXabT2MTgO5hfZS2ypukc5ca4RAt6Ju86BZTYyMGgG4Bbejgtv
 kv3j4XA+JsUzDG+U2oPXxAFiYG8GozAwaGCyZ5T9+huPuAB7uhnLgg74YPxxYeOX3F4Dck+9B4+
 B6kAeKEjWXRoH1OrtIfdVsE46WBVvNcobs9sAW+PK9LC5m/xZOGQ==
X-Received: by 2002:a05:600c:4e42:b0:47e:c562:a41f with SMTP id
 5b1f17b1804b1-47ee481a353mr42826275e9.18.1768429521858; 
 Wed, 14 Jan 2026 14:25:21 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f42907141sm12040355e9.9.2026.01.14.14.25.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 14:25:21 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>
Subject: [PATCH 11/29] examples/qos: improve sample application documentation
Date: Wed, 14 Jan 2026 14:21:52 -0800
Message-ID: <20260114222458.87119-12-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114222458.87119-1-stephen@networkplumber.org>
References: <20260114222458.87119-1-stephen@networkplumber.org>
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

Rewrite the QoS metering and QoS scheduler documentation for clarity
and correctness.

Changes to qos_metering.rst:
- Correct duplicate "srTCM" entries to "trTCM" in the mode list
- Simplify and clarify introductory text
- Use imperative mood for instructions
- Add Oxford commas for consistency
- Remove unnecessary empty rows in tables

Changes to qos_sched.rst:
- Rewrite command descriptions for clarity
- Improve formatting of command syntax using inline literals
- Streamline bullet point structure
- Remove unnecessary empty rows in tables
- Make language more concise throughout

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/sample_app_ug/qos_metering.rst  |  95 ++++-----
 doc/guides/sample_app_ug/qos_scheduler.rst | 214 +++++++++++----------
 2 files changed, 158 insertions(+), 151 deletions(-)

diff --git a/doc/guides/sample_app_ug/qos_metering.rst b/doc/guides/sample_app_ug/qos_metering.rst
index e7101559aa..c6ab8f78ab 100644
--- a/doc/guides/sample_app_ug/qos_metering.rst
+++ b/doc/guides/sample_app_ug/qos_metering.rst
@@ -4,19 +4,22 @@
 QoS Metering Sample Application
 ===============================
 
-The QoS meter sample application is an example that demonstrates the use of DPDK to provide QoS marking and metering,
-as defined by RFC2697 for Single Rate Three Color Marker (srTCM) and RFC 2698 for Two Rate Three Color Marker (trTCM) algorithm.
+The QoS meter sample application demonstrates DPDK QoS marking and metering
+using the Single Rate Three Color Marker (srTCM) algorithm defined in RFC 2697
+and the Two Rate Three Color Marker (trTCM) algorithm defined in RFC 2698.
 
 Overview
 --------
 
-The application uses a single thread for reading the packets from the RX port,
-metering, marking them with the appropriate color (green, yellow or red) and writing them to the TX port.
+The application uses a single thread to read packets from the RX port,
+meter them, mark them with the appropriate color (green, yellow, or red),
+and write them to the TX port.
 
-A policing scheme can be applied before writing the packets to the TX port by dropping or
-changing the color of the packet in a static manner depending on both the input and output colors of the packets that are processed by the meter.
+A policing scheme can apply before writing packets to the TX port by dropping
+or changing the packet color statically. The scheme depends on both the input
+and output colors of packets processed by the meter.
 
-The operation mode can be selected as compile time out of the following options:
+Select the operation mode at compile time from the following options:
 
 *   Simple forwarding
 
@@ -24,60 +27,64 @@ The operation mode can be selected as compile time out of the following options:
 
 *   srTCM color aware
 
-*   srTCM color blind
+*   trTCM color blind
 
-*   srTCM color aware
+*   trTCM color aware
 
-Please refer to RFC2697 and RFC2698 for details about the srTCM and trTCM configurable parameters
-(CIR, CBS and EBS for srTCM; CIR, PIR, CBS and PBS for trTCM).
+See RFC 2697 and RFC 2698 for details about the srTCM and trTCM configurable
+parameters (CIR, CBS, and EBS for srTCM; CIR, PIR, CBS, and PBS for trTCM).
 
-The color blind modes are functionally equivalent with the color-aware modes when
-all the incoming packets are colored as green.
+The color blind modes function equivalently to the color aware modes when
+all incoming packets are green.
 
 Compiling the Application
 -------------------------
 
-To compile the sample application see :doc:`compiling`.
+To compile the sample application, see :doc:`compiling`.
 
-The application is located in the ``qos_meter`` sub-directory.
+The application source resides in the ``qos_meter`` sub-directory.
 
 Running the Application
 -----------------------
 
-The application execution command line is as below:
+Run the application with the following command line:
 
 .. code-block:: console
 
     ./dpdk-qos_meter [EAL options] -- -p PORTMASK
 
-The application is constrained to use a single core in the EAL core mask and 2 ports only in the application port mask
-(first port from the port mask is used for RX and the other port in the core mask is used for TX).
+The application requires a single core in the EAL core mask and exactly
+two ports in the application port mask. The first port in the mask handles RX;
+the second port handles TX.
 
-Refer to *DPDK Getting Started Guide* for general information on running applications and
-the Environment Abstraction Layer (EAL) options.
+Refer to the *DPDK Getting Started Guide* for general information on running
+applications and the Environment Abstraction Layer (EAL) options.
 
 Explanation
 -----------
 
-Selecting one of the metering modes is done with these defines:
+Select the metering mode with these defines:
 
 .. literalinclude:: ../../../examples/qos_meter/main.c
         :language: c
         :start-after: Traffic metering configuration. 8<
         :end-before: >8 End of traffic metering configuration.
 
-To simplify debugging (for example, by using the traffic generator RX side MAC address based packet filtering feature),
-the color is defined as the LSB byte of the destination MAC address.
+To simplify debugging (for example, when using the traffic generator's
+MAC address-based packet filtering on the RX side), the application encodes
+the color in the LSB of the destination MAC address.
 
-The traffic meter parameters are configured in the application source code with following default values:
+The application source code configures traffic meter parameters with the
+following default values:
 
 .. literalinclude:: ../../../examples/qos_meter/main.c
         :language: c
         :start-after: Traffic meter parameters are configured in the application. 8<
         :end-before: >8 End of traffic meter parameters are configured in the application.
 
-Assuming the input traffic is generated at line rate and all packets are 64 bytes Ethernet frames (IPv4 packet size of 46 bytes)
-and green, the expected output traffic should be marked as shown in the following table:
+Assuming the input traffic arrives at line rate with all packets as
+64-byte Ethernet frames (46-byte IPv4 payload) colored green, the meter
+marks the output traffic as shown in the following table:
 
 .. _table_qos_metering_1:
 
@@ -85,53 +92,49 @@ and green, the expected output traffic should be marked as shown in the followin
 
    +-------------+------------------+-------------------+----------------+
    | **Mode**    | **Green (Mpps)** | **Yellow (Mpps)** | **Red (Mpps)** |
-   |             |                  |                   |                |
    +=============+==================+===================+================+
    | srTCM blind | 1                | 1                 | 12.88          |
-   |             |                  |                   |                |
    +-------------+------------------+-------------------+----------------+
    | srTCM color | 1                | 1                 | 12.88          |
-   |             |                  |                   |                |
    +-------------+------------------+-------------------+----------------+
    | trTCM blind | 1                | 0.5               | 13.38          |
-   |             |                  |                   |                |
    +-------------+------------------+-------------------+----------------+
    | trTCM color | 1                | 0.5               | 13.38          |
-   |             |                  |                   |                |
    +-------------+------------------+-------------------+----------------+
    | FWD         | 14.88            | 0                 | 0              |
-   |             |                  |                   |                |
    +-------------+------------------+-------------------+----------------+
 
-To set up the policing scheme as desired, it is necessary to modify the main.h source file,
-where this policy is implemented as a static structure, as follows:
+To configure the policing scheme, modify the static structure in the main.h
+source file:
 
 .. literalinclude:: ../../../examples/qos_meter/main.h
         :language: c
         :start-after: Policy implemented as a static structure. 8<
         :end-before: >8 End of policy implemented as a static structure.
 
-Where rows indicate the input color, columns indicate the output color,
-and the value that is stored in the table indicates the action to be taken for that particular case.
+Rows indicate the input color, columns indicate the output color, and each
+table entry specifies the action for that combination.
 
-There are four different actions:
+The four available actions are:
 
-*   GREEN: The packet's color is changed to green.
+*   GREEN: Change the packet color to green.
 
-*   YELLOW: The packet's color is changed to yellow.
+*   YELLOW: Change the packet color to yellow.
 
-*   RED: The packet's color is changed to red.
+*   RED: Change the packet color to red.
 
-*   DROP: The packet is dropped.
+*   DROP: Drop the packet.
 
 In this particular case:
 
-*   Every packet which input and output color are the same, keeps the same color.
+*   When input and output colors match, keep the same color.
 
-*   Every packet which color has improved is dropped (this particular case can't happen, so these values will not be used).
+*   When the color improves (output greener than input), drop the packet.
+    This case cannot occur in practice, so these values go unused.
 
-*   For the rest of the cases, the color is changed to red.
+*   For all other cases, change the color to red.
 
 .. note::
-    * In color blind mode, first row GREEN color is only valid.
-    * To drop the packet, policer_table action has to be set to DROP.
+
+   In color blind mode, only the GREEN input row applies.
+   To drop packets, set the policer_table action to DROP.
diff --git a/doc/guides/sample_app_ug/qos_scheduler.rst b/doc/guides/sample_app_ug/qos_scheduler.rst
index cd33beecb0..caa2fb84cb 100644
--- a/doc/guides/sample_app_ug/qos_scheduler.rst
+++ b/doc/guides/sample_app_ug/qos_scheduler.rst
@@ -4,12 +4,12 @@
 QoS Scheduler Sample Application
 ================================
 
-The QoS sample application demonstrates the use of the DPDK to provide QoS scheduling.
+The QoS sample application demonstrates DPDK QoS scheduling.
 
 Overview
 --------
 
-The architecture of the QoS scheduler application is shown in the following figure.
+The following figure shows the architecture of the QoS scheduler application.
 
 .. _figure_qos_sched_app_arch:
 
@@ -18,110 +18,113 @@ The architecture of the QoS scheduler application is shown in the following figu
    QoS Scheduler Application Architecture
 
 
-There are two flavors of the runtime execution for this application,
-with two or three threads per each packet flow configuration being used.
-The RX thread reads packets from the RX port,
-classifies the packets based on the double VLAN (outer and inner) and
-the lower byte of the IP destination address and puts them into the ring queue.
-The worker thread dequeues the packets from the ring and calls the QoS scheduler enqueue/dequeue functions.
-If a separate TX core is used, these are sent to the TX ring.
-Otherwise, they are sent directly to the TX port.
-The TX thread, if present, reads from the TX ring and write the packets to the TX port.
+The application supports two runtime configurations: two or three threads
+per packet flow.
+
+The RX thread reads packets from the RX port, classifies them based on
+double VLAN tags (outer and inner) and the lower byte of the IP destination
+address, then enqueues them to the ring.
+
+The worker thread dequeues packets from the ring and calls the QoS scheduler
+enqueue/dequeue functions. With a separate TX core, the worker sends packets
+to the TX ring. Otherwise, it sends them directly to the TX port.
+The TX thread, when present, reads from the TX ring and writes packets to
+the TX port.
 
 Compiling the Application
 -------------------------
 
-To compile the sample application see :doc:`compiling`.
+To compile the sample application, see :doc:`compiling`.
 
-The application is located in the ``qos_sched`` sub-directory.
+The application source resides in the ``qos_sched`` sub-directory.
 
-    .. note::
+.. note::
 
-        This application is intended as a linux only.
+   This application supports Linux only.
 
 .. note::
 
-    Number of grinders is currently set to 8.
-    This can be modified by specifying RTE_SCHED_PORT_N_GRINDERS=N
-    in CFLAGS, where N is number of grinders.
+   The number of grinders defaults to 8. Modify this value by specifying
+   ``RTE_SCHED_PORT_N_GRINDERS=N`` in CFLAGS, where N is the desired count.
 
 Running the Application
 -----------------------
 
 .. note::
 
-    In order to run the application, a total of at least 4
-    G of huge pages must be set up for each of the used sockets (depending on the cores in use).
+   The application requires at least 4 GB of huge pages per socket
+   (depending on which cores are in use).
 
-The application has a number of command line options:
+The application accepts the following command line options:
 
 .. code-block:: console
 
     ./<build_dir>/examples/dpdk-qos_sched [EAL options] -- <APP PARAMS>
 
-Mandatory application parameters include:
+Mandatory application parameters:
 
-*   --pfc "RX PORT, TX PORT, RX LCORE, WT LCORE, TX CORE": Packet flow configuration.
-    Multiple pfc entities can be configured in the command line,
-    having 4 or 5 items (if TX core defined or not).
+*   ``--pfc "RX PORT, TX PORT, RX LCORE, WT LCORE, TX CORE"``: Packet flow
+    configuration. Specify multiple pfc entries on the command line with
+    4 or 5 items (depending on whether a TX core is defined).
 
-Optional application parameters include:
+Optional application parameters:
 
-*   -i: It makes the application to start in the interactive mode.
-    In this mode, the application shows a command line that can be used for obtaining statistics while
-    scheduling is taking place (see interactive mode below for more information).
+*   ``-i``: Start the application in interactive mode. This mode displays
+    a command line for obtaining statistics while scheduling runs
+    (see `Interactive mode`_ for details).
 
-*   --mnc n: Main core index (the default value is 1).
+*   ``--mnc n``: Main core index (default: 1).
 
-*   --rsz "A, B, C": Ring sizes:
+*   ``--rsz "A, B, C"``: Ring sizes:
 
-*   A = Size (in number of buffer descriptors) of each of the NIC RX rings read
-    by the I/O RX lcores (the default value is 128).
+    *   A = Size (in buffer descriptors) of each NIC RX ring read by I/O RX
+        lcores (default: 128).
 
-*   B = Size (in number of elements) of each of the software rings used
-    by the I/O RX lcores to send packets to worker lcores (the default value is 8192).
+    *   B = Size (in elements) of each software ring that I/O RX lcores use
+        to send packets to worker lcores (default: 8192).
 
-*   C = Size (in number of buffer descriptors) of each of the NIC TX rings written
-    by worker lcores (the default value is 256)
+    *   C = Size (in buffer descriptors) of each NIC TX ring written by
+        worker lcores (default: 256).
 
-*   --bsz "A, B, C, D": Burst sizes
+*   ``--bsz "A, B, C, D"``: Burst sizes:
 
-*   A = I/O RX lcore read burst size from the NIC RX (the default value is 64)
+    *   A = I/O RX lcore read burst size from NIC RX (default: 64).
 
-*   B = I/O RX lcore write burst size to the output software rings,
-    worker lcore read burst size from input software rings,QoS enqueue size (the default value is 64)
+    *   B = I/O RX lcore write burst size to output software rings, worker
+        lcore read burst size from input software rings, and QoS enqueue
+        size (default: 64).
 
-*   C = QoS dequeue size (the default value is 63)
+    *   C = QoS dequeue size (default: 63).
 
-*   D = Worker lcore write burst size to the NIC TX (the default value is 64)
+    *   D = Worker lcore write burst size to NIC TX (default: 64).
 
-*   --msz M: Mempool size (in number of mbufs) for each pfc (default 2097152)
+*   ``--msz M``: Mempool size (in mbufs) for each pfc (default: 2097152).
 
-*   --rth "A, B, C": The RX queue threshold parameters
+*   ``--rth "A, B, C"``: RX queue threshold parameters:
 
-*   A = RX prefetch threshold (the default value is 8)
+    *   A = RX prefetch threshold (default: 8).
 
-*   B = RX host threshold (the default value is 8)
+    *   B = RX host threshold (default: 8).
 
-*   C = RX write-back threshold (the default value is 4)
+    *   C = RX write-back threshold (default: 4).
 
-*   --tth "A, B, C": TX queue threshold parameters
+*   ``--tth "A, B, C"``: TX queue threshold parameters:
 
-*   A = TX prefetch threshold (the default value is 36)
+    *   A = TX prefetch threshold (default: 36).
 
-*   B = TX host threshold (the default value is 0)
+    *   B = TX host threshold (default: 0).
 
-*   C = TX write-back threshold (the default value is 0)
+    *   C = TX write-back threshold (default: 0).
 
-*   --cfg FILE: Profile configuration to load
+*   ``--cfg FILE``: Profile configuration file to load.
 
-Refer to *DPDK Getting Started Guide* for general information on running applications and
-the Environment Abstraction Layer (EAL) options.
+Refer to the *DPDK Getting Started Guide* for general information on running
+applications and the Environment Abstraction Layer (EAL) options.
 
-The profile configuration file defines all the port/subport/pipe/traffic class/queue parameters
-needed for the QoS scheduler configuration.
+The profile configuration file defines all port/subport/pipe/traffic class/queue
+parameters for the QoS scheduler.
 
-The profile file has the following format:
+The profile file uses the following format:
 
 .. literalinclude:: ../../../examples/qos_sched/profile.cfg
     :start-after: Data Plane Development Kit (DPDK) Programmer's Guide
@@ -129,89 +132,94 @@ The profile file has the following format:
 Interactive mode
 ~~~~~~~~~~~~~~~~
 
-These are the commands that are currently working under the command line interface:
-
-*   Control Commands
+The interactive mode supports these commands:
 
-*   --quit: Quits the application.
+*   Control commands:
 
-*   General Statistics
+    *   ``quit``: Exit the application.
 
-    *   stats app: Shows a table with in-app calculated statistics.
+*   General statistics:
 
-    *   stats port X subport Y: For a specific subport, it shows the number of packets that
-        went through the scheduler properly and the number of packets that were dropped.
-        The same information is shown in bytes.
-        The information is displayed in a table separating it in different traffic classes.
+    *   ``stats app``: Display a table of in-application statistics.
 
-    *   stats port X subport Y pipe Z: For a specific pipe, it shows the number of packets that
-        went through the scheduler properly and the number of packets that were dropped.
-        The same information is shown in bytes.
-        This information is displayed in a table separating it in individual queues.
+    *   ``stats port X subport Y``: For a specific subport, display the number
+        of packets (and bytes) that passed through the scheduler and the
+        number dropped. The table separates results by traffic class.
 
-*   Average queue size
+    *   ``stats port X subport Y pipe Z``: For a specific pipe, display the
+        number of packets (and bytes) that passed through the scheduler and
+        the number dropped. The table separates results by queue.
 
-All of these commands work the same way, averaging the number of packets throughout a specific subset of queues.
+*   Average queue size:
 
-Two parameters can be configured for this prior to calling any of these commands:
+    These commands average packet counts across a subset of queues.
+    Configure two parameters before using these commands:
 
-    *   qavg n X: n is the number of times that the calculation will take place.
-        Bigger numbers provide higher accuracy. The default value is 10.
+    *   ``qavg n X``: Set the number of calculation iterations. Higher values
+        improve accuracy (default: 10).
 
-    *   qavg period X: period is the number of microseconds that will be allowed between each calculation.
-        The default value is 100.
+    *   ``qavg period X``: Set the interval in microseconds between
+        calculations (default: 100).
 
-The commands that can be used for measuring average queue size are:
+    The queue size measurement commands are:
 
-*   qavg port X subport Y: Show average queue size per subport.
+    *   ``qavg port X subport Y``: Display average queue size per subport.
 
-*   qavg port X subport Y tc Z: Show average queue size per subport for a specific traffic class.
+    *   ``qavg port X subport Y tc Z``: Display average queue size per subport
+        for a specific traffic class.
 
-*   qavg port X subport Y pipe Z: Show average queue size per pipe.
+    *   ``qavg port X subport Y pipe Z``: Display average queue size per pipe.
 
-*   qavg port X subport Y pipe Z tc A: Show average queue size per pipe for a specific traffic class.
+    *   ``qavg port X subport Y pipe Z tc A``: Display average queue size per
+        pipe for a specific traffic class.
 
-*   qavg port X subport Y pipe Z tc A q B: Show average queue size of a specific queue.
+    *   ``qavg port X subport Y pipe Z tc A q B``: Display average queue size
+        for a specific queue.
 
 Example
 ~~~~~~~
 
-The following is an example command with a single packet flow configuration:
+The following command configures a single packet flow:
 
 .. code-block:: console
 
     ./<build_dir>/examples/dpdk-qos_sched -l 1,5,7 -- --pfc "3,2,5,7" --cfg ./profile.cfg
 
-This example uses a single packet flow configuration which creates one RX thread on lcore 5 reading
-from port 3 and a worker thread on lcore 7 writing to port 2.
+This example creates one RX thread on lcore 5 reading from port 3 and a
+worker thread on lcore 7 writing to port 2.
 
-Another example with 2 packet flow configurations using different ports but sharing the same core for QoS scheduler is given below:
+The following command configures two packet flows using different ports but
+sharing the same QoS scheduler core:
 
 .. code-block:: console
 
    ./<build_dir>/examples/dpdk-qos_sched -l 1,2,6,7 -- --pfc "3,2,2,6,7" --pfc "1,0,2,6,7" --cfg ./profile.cfg
 
-Note that independent cores for the packet flow configurations for each of the RX, WT and TX thread are also supported,
-providing flexibility to balance the work.
+The application also supports independent cores for RX, WT, and TX threads
+in each packet flow configuration, providing flexibility to balance workloads.
 
-The EAL corelist is constrained to contain the default main core 1 and the RX, WT and TX cores only.
+The EAL corelist must contain only the default main core 1 plus the RX, WT,
+and TX cores.
 
 Explanation
 -----------
 
-The Port/Subport/Pipe/Traffic Class/Queue are the hierarchical entities in a typical QoS application:
+The Port/Subport/Pipe/Traffic Class/Queue hierarchy represents entities in
+a typical QoS application:
 
 *   A subport represents a predefined group of users.
 
-*   A pipe represents an individual user/subscriber.
+*   A pipe represents an individual user or subscriber.
 
-*   A traffic class is the representation of a different traffic type with a specific loss rate,
-    delay and jitter requirements; such as data voice, video or data transfers.
+*   A traffic class represents a traffic type with specific loss rate, delay,
+    and jitter requirements, such as voice, video, or data transfers.
 
-*   A queue hosts packets from one or multiple connections of the same type belonging to the same user.
+*   A queue hosts packets from one or more connections of the same type
+    belonging to the same user.
 
-The traffic flows that need to be configured are application dependent.
-This application classifies based on the QinQ double VLAN tags and the IP destination address as indicated in the following table.
+Traffic flow configuration depends on the application. This application
+classifies packets based on QinQ double VLAN tags and IP destination address
+as shown in the following table.
 
 .. _table_qos_scheduler_1:
 
@@ -219,22 +227,18 @@ This application classifies based on the QinQ double VLAN tags and the IP destin
 
    +----------------+-------------------------+--------------------------------------------------+----------------------------------+
    | **Level Name** | **Siblings per Parent** | **QoS Functional Description**                   | **Selected By**                  |
-   |                |                         |                                                  |                                  |
    +================+=========================+==================================================+==================================+
    | Port           | -                       | Ethernet port                                    | Physical port                    |
-   |                |                         |                                                  |                                  |
    +----------------+-------------------------+--------------------------------------------------+----------------------------------+
    | Subport        | Config (8)              | Traffic shaped (token bucket)                    | Outer VLAN tag                   |
-   |                |                         |                                                  |                                  |
    +----------------+-------------------------+--------------------------------------------------+----------------------------------+
    | Pipe           | Config (4k)             | Traffic shaped (token bucket)                    | Inner VLAN tag                   |
-   |                |                         |                                                  |                                  |
    +----------------+-------------------------+--------------------------------------------------+----------------------------------+
    | Traffic Class  | 13                      | TCs of the same pipe services in strict priority | Destination IP address (0.0.0.X) |
-   |                |                         |                                                  |                                  |
    +----------------+-------------------------+--------------------------------------------------+----------------------------------+
    | Queue          | High Priority TC: 1,    | Queue of lowest priority traffic                 | Destination IP address (0.0.0.X) |
    |                | Lowest Priority TC: 4   | class (Best effort) serviced in WRR              |                                  |
    +----------------+-------------------------+--------------------------------------------------+----------------------------------+
 
-Please refer to the "QoS Scheduler" chapter in the *DPDK Programmer's Guide* for more information about these parameters.
+For more information about these parameters, see the "QoS Scheduler" chapter
+in the *DPDK Programmer's Guide*.
-- 
2.51.0

