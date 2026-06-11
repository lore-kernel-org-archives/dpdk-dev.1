Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FEFCD98C7
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 21:22:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2A006433FE;
	Thu, 11 Jun 2026 23:21:41 +0200 (CEST)
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174]) by mails.dpdk.org (Postfix) with ESMTP id 95303433D3
 for <dev@dpdk.org>; Thu, 11 Jun 2026 23:21:37 +0200 (CEST)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-3074adb8fcaso906438eec.0
 for <dev@dpdk.org>; Thu, 11 Jun 2026 14:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781212897;
 x=1781817697; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o5VBoynNTAqeR7Dwres4TTGDTp7QBseuGSDWv0l5vi0=;
 b=PGMt7aoyRK6tmFuLqQ4fhPvcQAb1Jhy9/EekvckSZb4W62AFljodS6RBBV4m4CokTa
 steNR2CSwMCgSUYnb989QRQERPFYYIkSFjVW41EC1ddNtgZ6YoxbHoM9MJkCGCO0hgQL
 aOexIJRTchhV9hj9+nfP2Y7NrKoXlU1bn0rIfhP3l1t3W4ZhLaCkRjUZufOcBABrLX16
 nW0joRQid6O2tteDG3RGxcs4tlD+4ykteI1UsUxaEzzJrPOhMTZwkbLTceqAbBLM4sTl
 CdLjAEvtG2rQUIerfLVX3638DY2OEDVvNfG3QXirbfLTllF5Pzx7QXy06O7cKzNg68zY
 K+1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781212897; x=1781817697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=o5VBoynNTAqeR7Dwres4TTGDTp7QBseuGSDWv0l5vi0=;
 b=aTXazPaIetHB2aBhDCRKUKFoI3GoGImid9bIm26Yp6nocwYFG1MWUJe8NY50jQgjNU
 C/bRb3k0IecrtsEGYAabeO132yHAyPtyUnKLeykiRMIjcsteq0RxG2gyc8kg+bNSFR5S
 DvP3Dz3ZsVM/aZ151T2bJF0VOMutr1TSv+D3KNgM5V+82wsQvEoiVx9aGpE61ecIp3ct
 3vKqT3Qc4Ow22Qs3Iz0dDIQzSJIszdFIQQhzt5QfQtjJqxu9LkQnZ6VtXVAmNQURUI1s
 Hch3l9XjMOAu/EZ5wjAQgfRAeqy3Sn1Qia0EZC3CPTE3RbrR7wSOyN22BfjayQuHYP8B
 wYow==
X-Gm-Message-State: AOJu0YwArI6IqFwFyqVsFYLBfan0qmXgKqinmdBwWa6AoAdXshtu0aWN
 dHYy/AFWtbvrM7sKkG+XqYZUL2zduSWUmnFI8J8ZveYGeRw2b4axKLMrHVDyCi2pCpiPMhgz1T1
 aZbbI
X-Gm-Gg: Acq92OGXNpZnB78JwnFcL9ldMiM96nirlEA5gWOA3e9SSq2f1mZfWNadGq18ActBrTU
 rmzeanAWqP2aXmmxno7GwgYgQSNI40HSZ6Wn/gtHMVqjh6b6D1ECwiZ3o6YT7LOeSHgclqzMeqm
 nkhWzMlBOmIxrJ6vv6RfTtV6QW1Rz6xooSOqovJyd5WwMroQg3YmmUCDgpEv5FhcSkp0ObsP7+n
 gHtNHjhiQ5KEZOlRTpm5QaNxcK8xTwrvoqKI398pfAPOma07hQkpZPGXoJJlDqNqSexXVICMSSZ
 gwmGXBfeO2S7vCx/cFlMThQ8hPYmw/WAUGM6YKtFA6wIKV76qSC2kv2bUtveRkBP88rVfQlTBpQ
 UMU4ZJ1epTnEMHD+PbgFS4Cn8Gg1tedGm9uyic4ZLaALlbaB3I2vxUY/SlsCJw+mXniU3JiKY0a
 T7uPFECZHpJ29hoskuJSbxvSjAxWUNKOzBV3yFCxJhM2UuHk5TdNskHVNZ8KEAKw==
X-Received: by 2002:a05:7300:5341:b0:2fc:9ae6:e5a8 with SMTP id
 5a478bee46e88-3082009c394mr13875eec.20.1781212896297; 
 Thu, 11 Jun 2026 14:21:36 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081eb95450sm546238eec.28.2026.06.11.14.21.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 14:21:35 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 John McNamara <john.mcnamara@intel.com>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Erik Gabriel Carrillo <erik.g.carrillo@intel.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH 13/15] doc: enhance skeleton, pipeline, timer, and vhost guides
Date: Thu, 11 Jun 2026 14:18:52 -0700
Message-ID: <20260611212119.1026721-14-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260611212119.1026721-1-stephen@networkplumber.org>
References: <20250216230903.124496-1-nandinipersad361@gmail.com>
 <20260611212119.1026721-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Improved documentation for core sample applications:

skeleton.rst:
- Simplified basic forwarding example descriptions
- Fixed formatting consistency

test_pipeline.rst:
- Enhanced pipeline testing methodology descriptions
- Improved command-line parameter documentation

timer.rst:
- Clarified timer management mechanisms
- Improved periodic timer explanations

vdpa.rst:
- Enhanced vDPA device configuration descriptions
- Improved live migration support explanations

vhost.rst:
- Restructured vhost-user implementation sections
- Improved virtio device emulation descriptions
- Enhanced performance tuning recommendations

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/sample_app_ug/skeleton.rst      |   8 +-
 doc/guides/sample_app_ug/test_pipeline.rst |  17 +-
 doc/guides/sample_app_ug/timer.rst         |  19 +--
 doc/guides/sample_app_ug/vdpa.rst          |  51 +++---
 doc/guides/sample_app_ug/vhost.rst         | 178 +++++++++++----------
 5 files changed, 143 insertions(+), 130 deletions(-)

diff --git a/doc/guides/sample_app_ug/skeleton.rst b/doc/guides/sample_app_ug/skeleton.rst
index 5f7f18dbc2..b1cd4e12f5 100644
--- a/doc/guides/sample_app_ug/skeleton.rst
+++ b/doc/guides/sample_app_ug/skeleton.rst
@@ -73,7 +73,7 @@ Mbufs are the packet buffer structure used by DPDK. They are explained in
 detail in the "Mbuf Library" section of the *DPDK Programmer's Guide*.
 
 The ``main()`` function also initializes all the ports using the user defined
-``port_init()`` function which is explained in the next section:
+``port_init()`` function, which is explained in the next section:
 
 .. literalinclude:: ../../../examples/skeleton/basicfwd.c
     :language: c
@@ -129,10 +129,10 @@ Finally, the Rx port is set in promiscuous mode:
         :dedent: 1
 
 
-The Lcores Main
+The Lcore Main
 ~~~~~~~~~~~~~~~
 
-As we saw above, the ``main()`` function calls an application function
+As shown above, the ``main()`` function calls an application function
 on the available lcores.
 For the basic forwarding application, the lcore function
 looks like the following:
@@ -152,7 +152,7 @@ The main work of the application is done within the loop:
 
 Packets are received in bursts on the RX ports and transmitted in bursts on
 the TX ports. The ports are grouped in pairs with a simple mapping scheme
-using the an XOR on the port number::
+using XOR on the port number::
 
     0 -> 1
     1 -> 0
diff --git a/doc/guides/sample_app_ug/test_pipeline.rst b/doc/guides/sample_app_ug/test_pipeline.rst
index 818be93cd6..c18326105d 100644
--- a/doc/guides/sample_app_ug/test_pipeline.rst
+++ b/doc/guides/sample_app_ug/test_pipeline.rst
@@ -30,7 +30,7 @@ The application uses three CPU cores:
 
 Compiling the Application
 -------------------------
-To compile the sample application see :doc:`compiling`
+To compile the sample application, see :doc:`compiling`
 
 The application is located in the ``dpdk/<build_dir>/app`` directory.
 
@@ -95,7 +95,7 @@ For hash tables, the following parameters can be selected:
    |       |                        |                                                          | [4-byte index, 4 bytes of 0]                          |
    |       |                        |                                                          |                                                       |
    |       |                        |                                                          | The action configured for all table entries is        |
-   |       |                        |                                                          | "Sendto output port", with the output port index      |
+   |       |                        |                                                          | "send to output port", with the output port index     |
    |       |                        |                                                          | uniformly distributed for the range of output ports.  |
    |       |                        |                                                          |                                                       |
    |       |                        |                                                          | The default table rule (used in the case of a lookup  |
@@ -118,7 +118,7 @@ For hash tables, the following parameters can be selected:
    |       |                        |                                                          | [4-byte index, 12 bytes of 0]                         |
    |       |                        |                                                          |                                                       |
    |       |                        |                                                          | The action configured for all table entries is        |
-   |       |                        |                                                          | "Send to output port", with the output port index     |
+   |       |                        |                                                          | "send to output port", with the output port index     |
    |       |                        |                                                          | uniformly distributed for the range of output ports.  |
    |       |                        |                                                          |                                                       |
    |       |                        |                                                          | The default table rule (used in the case of a lookup  |
@@ -141,7 +141,7 @@ For hash tables, the following parameters can be selected:
    |       |                        |                                                          | [4-byte index, 28 bytes of 0].                        |
    |       |                        |                                                          |                                                       |
    |       |                        |                                                          | The action configured for all table entries is        |
-   |       |                        |                                                          | "Send to output port", with the output port index     |
+   |       |                        |                                                          | "send to output port", with the output port index     |
    |       |                        |                                                          | uniformly distributed for the range of output ports.  |
    |       |                        |                                                          |                                                       |
    |       |                        |                                                          | The default table rule (used in the case of a lookup  |
@@ -149,7 +149,7 @@ For hash tables, the following parameters can be selected:
    |       |                        |                                                          |                                                       |
    |       |                        |                                                          | At run time, core A is creating the following lookup  |
    |       |                        |                                                          | key and storing it into the packet meta data for      |
-   |       |                        |                                                          | Lpmcore B to use for table lookup:                    |
+   |       |                        |                                                          | core B to use for table lookup:                       |
    |       |                        |                                                          |                                                       |
    |       |                        |                                                          | [destination IPv4 address, 28 bytes of 0]             |
    |       |                        |                                                          |                                                       |
@@ -177,8 +177,8 @@ For hash tables, the following parameters can be selected:
    |       |                        |                                                          | [0.192.0.0/10 => send to output port 3]               |
    |       |                        |                                                          |                                                       |
    |       |                        |                                                          | The default table rule (used in the case of a lookup  |
-   |       |                        |                                                          | miss) is to drop the packet.                          |
    |       |                        |                                                          |                                                       |
+   |       |                        |                                                          | miss) is to drop the packet.                          |
    |       |                        |                                                          | At run time, core A is storing the IPv4 destination   |
    |       |                        |                                                          | within the packet meta data to be later used by core  |
    |       |                        |                                                          | B as the lookup key.                                  |
@@ -201,11 +201,9 @@ For hash tables, the following parameters can be selected:
    |       |                        |                                                          |                                                       |
    |       |                        |                                                          | => send to output port 0]                             |
    |       |                        |                                                          |                                                       |
-   |       |                        |                                                          |                                                       |
    |       |                        |                                                          | [priority = 0 (highest),                              |
    |       |                        |                                                          |                                                       |
    |       |                        |                                                          | IPv4 source = ANY,                                    |
-   |       |                        |                                                          |                                                       |
    |       |                        |                                                          | IPv4 destination = 0.128.0.0/9,                       |
    |       |                        |                                                          |                                                       |
    |       |                        |                                                          | L4 protocol = ANY,                                    |
@@ -214,8 +212,7 @@ For hash tables, the following parameters can be selected:
    |       |                        |                                                          |                                                       |
    |       |                        |                                                          | TCP destination port = ANY                            |
    |       |                        |                                                          |                                                       |
-   |       |                        |                                                          | => send to output port 0].                            |
-   |       |                        |                                                          |                                                       |
+   |       |                        |                                                          | => send to output port 1]                             |
    |       |                        |                                                          |                                                       |
    |       |                        |                                                          | The default table rule (used in the case of a lookup  |
    |       |                        |                                                          | miss) is to drop the packet.                          |
diff --git a/doc/guides/sample_app_ug/timer.rst b/doc/guides/sample_app_ug/timer.rst
index 7af35d3d67..e6b821d7fd 100644
--- a/doc/guides/sample_app_ug/timer.rst
+++ b/doc/guides/sample_app_ug/timer.rst
@@ -4,20 +4,23 @@
 Timer Sample Application
 ========================
 
-The Timer sample application is a simple application that demonstrates the use of a timer in a DPDK application.
-This application prints some messages from different lcores regularly, demonstrating the use of timers.
+Overview
+--------
+
+The Timer sample application demonstrates the use of a timer in a DPDK application.
+This application prints messages from different lcores regularly using timers.
 
 Compiling the Application
 -------------------------
 
-To compile the sample application see :doc:`compiling`.
+To compile the sample application, see :doc:`compiling`.
 
 The application is located in the ``timer`` sub-directory.
 
 Running the Application
 -----------------------
 
-To run the example in linux environment:
+To run the example in a Linux environment:
 
 .. code-block:: console
 
@@ -29,8 +32,6 @@ the Environment Abstraction Layer (EAL) options.
 Explanation
 -----------
 
-The following sections provide some explanation of the code.
-
 Initialization and Main Loop
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
@@ -44,7 +45,7 @@ In addition to EAL initialization, the timer subsystem must be initialized, by c
 
 After timer creation (see the next paragraph), the main loop is
 executed on each worker lcore using the well-known
-rte_eal_remote_launch() and also on the main.
+rte_eal_remote_launch() and also on the main lcore.
 
 .. literalinclude:: ../../../examples/timer/main.c
     :language: c
@@ -76,13 +77,13 @@ This call to rte_timer_init() is necessary before doing any other operation on t
     :end-before: >8 End of init timer structures.
     :dedent: 1
 
-Then, the two timers are configured:
+Next, the two timers are configured:
 
 *   The first timer (timer0) is loaded on the main lcore and expires every second.
     Since the PERIODICAL flag is provided, the timer is reloaded automatically by the timer subsystem.
     The callback function is timer0_cb().
 
-*   The second timer (timer1) is loaded on the next available lcore every 333 ms.
+*   The second timer (timer1) is loaded on a next available lcore every 333 ms.
     The SINGLE flag means that the timer expires only once and must be reloaded manually if required.
     The callback function is timer1_cb().
 
diff --git a/doc/guides/sample_app_ug/vdpa.rst b/doc/guides/sample_app_ug/vdpa.rst
index 873efbf7c7..ed4c9676d6 100644
--- a/doc/guides/sample_app_ug/vdpa.rst
+++ b/doc/guides/sample_app_ug/vdpa.rst
@@ -4,27 +4,30 @@
 Vdpa Sample Application
 =======================
 
-The vdpa sample application creates vhost-user sockets by using the
-vDPA backend. vDPA stands for vhost Data Path Acceleration which utilizes
-virtio ring compatible devices to serve virtio driver directly to enable
-datapath acceleration. As vDPA driver can help to set up vhost datapath,
-this application doesn't need to launch dedicated worker threads for vhost
+Overview
+--------
+
+The vDPA sample application creates vhost-user sockets by using the
+vDPA backend. vDPA (vhost Data Path Acceleration) utilizes
+virtio ring-compatible devices to serve a virtio driver directly to enable
+datapath acceleration. A vDPA driver can help to set up the vhost datapath.
+This application does not need to launch dedicated worker threads for vhost
 enqueue/dequeue operations.
 
-Testing steps
--------------
-
-This section shows the steps of how to start VMs with vDPA vhost-user
+The following shows how to start VMs with vDPA vhost-user
 backend and verify network connection & live migration.
 
-Build
-~~~~~
+Compiling the Application
+-------------------------
 
-To compile the sample application see :doc:`compiling`.
+To compile the sample application, see :doc:`compiling`.
 
 The application is located in the ``vdpa`` sub-directory.
 
-Start the vdpa example
+Running the Application
+-----------------------
+
+Start the vDPA example
 ~~~~~~~~~~~~~~~~~~~~~~
 
 .. code-block:: console
@@ -40,7 +43,7 @@ where
   (n starts from 0).
 * --interactive means run the vDPA sample in interactive mode:
 
-  #. help: show help message
+  #. help: show the help message
 
   #. list: list all available vDPA devices
 
@@ -50,7 +53,7 @@ where
 
   #. quit: unregister vhost driver and exit the application
 
-Take IFCVF driver for example:
+Take IFCVF driver, for example:
 
 .. code-block:: console
 
@@ -62,10 +65,11 @@ Take IFCVF driver for example:
     Here 0000:06:00.3 and 0000:06:00.4 refer to virtio ring compatible devices,
     and we need to bind vfio-pci to them before running vdpa sample.
 
-    * modprobe vfio-pci
-    * ./usertools/dpdk-devbind.py -b vfio-pci 06:00.3 06:00.4
+    .. code-block:: console
 
-Then we can create 2 vdpa ports in interactive cmdline.
+        modprobe vfio-pci
+        ./usertools/dpdk-devbind.py -b vfio-pci 06:00.3 06:00.4
+Then, we can create 2 vdpa ports in interactive cmdline.
 
 .. code-block:: console
 
@@ -92,7 +96,7 @@ Start the VMs
        -netdev type=vhost-user,id=vdpa,chardev=char0 \
        -device virtio-net-pci,netdev=vdpa,mac=00:aa:bb:cc:dd:ee,page-per-vq=on \
 
-After the VMs launches, we can login the VMs and configure the ip, verify the
+After the VMs launch, we can log into the VMs and configure the IP, verify the
 network connection via ping or netperf.
 
 .. note::
@@ -100,11 +104,12 @@ network connection via ping or netperf.
 
 Live Migration
 ~~~~~~~~~~~~~~
-vDPA supports cross-backend live migration, user can migrate SW vhost backend
-VM to vDPA backend VM and vice versa. Here are the detailed steps. Assume A is
-the source host with SW vhost VM and B is the destination host with vDPA.
+vDPA supports cross-backend live migration. A user can migrate SW vhost backend
+VM to vDPA backend VM and vice versa. Here are the detailed steps.
+Assume A is the source host with SW vhost VM and B is the destination host with vDPA.
 
-#. Start vdpa sample and launch a VM with exact same parameters as the VM on A,
+#. On the destination host (B), start the vdpa sample application and launch a VM
+   with the exact same parameters as the VM on A,
    in migration-listen mode:
 
    .. code-block:: console
diff --git a/doc/guides/sample_app_ug/vhost.rst b/doc/guides/sample_app_ug/vhost.rst
index 4c944a844a..257985c430 100644
--- a/doc/guides/sample_app_ug/vhost.rst
+++ b/doc/guides/sample_app_ug/vhost.rst
@@ -4,36 +4,39 @@
 Vhost Sample Application
 ========================
 
-The vhost sample application demonstrates integration of the Data Plane
-Development Kit (DPDK) with the Linux* KVM hypervisor by implementing the
-vhost-net offload API. The sample application performs simple packet
-switching between virtual machines based on Media Access Control (MAC)
-address or Virtual Local Area Network (VLAN) tag. The splitting of Ethernet
-traffic from an external switch is performed in hardware by the Virtual
-Machine Device Queues (VMDQ) and Data Center Bridging (DCB) features of
-the Intel® 82599 10 Gigabit Ethernet Controller.
+Overview
+--------
+
+The vhost sample application demonstrates integration of DPDK with the
+Linux KVM hypervisor by implementing the vhost-user protocol. The
+application performs packet switching between virtual machines and
+physical network interfaces. Packets are switched based on Media Access
+Control (MAC) address or Virtual Local Area Network (VLAN) tag. When
+using supported NICs, the splitting of Ethernet traffic can be performed
+in hardware by Virtual Machine Device Queues (VMDQ) and Data Center
+Bridging (DCB) features.
 
 Testing steps
--------------
+~~~~~~~~~~~~~
 
-This section shows the steps how to test a typical PVP case with this
-dpdk-vhost sample, whereas packets are received from the physical NIC
+This section shows the steps to test a typical PVP (physical-virtual-physical)
+case with this dpdk-vhost sample. Packets are received from the physical NIC
 port first and enqueued to the VM's Rx queue. Through the guest testpmd's
 default forwarding mode (io forward), those packets will be put into
 the Tx queue. The dpdk-vhost example, in turn, gets the packets and
 puts back to the same physical NIC port.
 
-Build
-~~~~~
+Compiling the Application
+-------------------------
 
-To compile the sample application see :doc:`compiling`.
+To compile the sample application, see :doc:`compiling`.
 
 The application is located in the ``vhost`` sub-directory.
 
 .. note::
-   In this example, you need build DPDK both on the host and inside guest.
+   In this example, you need to build DPDK both on the host and inside the guest.
 
-. _vhost_app_run_vm:
+.. _vhost_app_run_vm:
 
 Start the VM
 ~~~~~~~~~~~~
@@ -51,8 +54,8 @@ Start the VM
 
 .. note::
     For basic vhost-user support, QEMU 2.2 (or above) is required. For
-    some specific features, a higher version might be need. Such as
-    QEMU 2.7 (or above) for the reconnect feature.
+    some specific features, a higher version might be needed. For example,
+    QEMU 2.7 or above is required for the reconnect feature.
 
 
 Start the vswitch example
@@ -64,132 +67,139 @@ Start the vswitch example
              -- --socket-file /tmp/sock0 --client \
              ...
 
-Check the `Parameters`_ section for the explanations on what do those
+Check the `Parameters`_ section for the explanations on what the
 parameters mean.
 
+Running the Application
+-----------------------
+
 .. _vhost_app_run_dpdk_inside_guest:
 
 Run testpmd inside guest
 ~~~~~~~~~~~~~~~~~~~~~~~~
 
-Make sure you have DPDK built inside the guest. Also make sure the
-corresponding virtio-net PCI device is bond to a UIO driver, which
-could be done by:
+Ensure DPDK is built inside the guest and that the
+corresponding virtio-net PCI device is bound to a UIO driver, which
+can be done by:
 
 .. code-block:: console
 
    modprobe vfio-pci
    dpdk/usertools/dpdk-devbind.py -b vfio-pci 0000:00:04.0
 
-Then start testpmd for packet forwarding testing.
+Then, start testpmd for packet forwarding testing.
 
 .. code-block:: console
 
     ./<build_dir>/app/dpdk-testpmd -l 0-1 -- -i
     > start tx_first
 
-For more information about vIOMMU and NO-IOMMU and VFIO please refer to
-:doc:`/../linux_gsg/linux_drivers` section of the DPDK Getting started guide.
+For more information about vIOMMU, NO-IOMMU, and VFIO, refer to the
+:doc:`../linux_gsg/linux_drivers` section of the DPDK Getting started guide.
+
+Explanation
+-----------
 
 Inject packets
---------------
+~~~~~~~~~~~~~~
 
-While a virtio-net is connected to dpdk-vhost, a VLAN tag starts with
-1000 is assigned to it. So make sure configure your packet generator
-with the right MAC and VLAN tag, you should be able to see following
-log from the dpdk-vhost console. It means you get it work::
+When a virtio-net device is connected to dpdk-vhost, a VLAN tag starting
+from 1000 is assigned to it. Therefore, configure your packet generator
+with the correct MAC address and VLAN tag. You should see the following
+log from the dpdk-vhost console::
 
     VHOST_DATA: (0) mac 52:54:00:00:00:14 and vlan 1000 registered
 
 
+
 .. _vhost_app_parameters:
 
 Parameters
-----------
+~~~~~~~~~~
 
 **--socket-file path**
-Specifies the vhost-user socket file path.
+   Specifies the vhost-user socket file path.
 
 **--client**
-DPDK vhost-user will act as the client mode when such option is given.
-In the client mode, QEMU will create the socket file. Otherwise, DPDK
-will create it. Put simply, it's the server to create the socket file.
+   DPDK vhost-user will act in client mode when this option is given.
+   In client mode, QEMU creates the socket file. Otherwise, DPDK creates
+   it. In other words, the server creates the socket file.
 
 
 **--vm2vm mode**
-The vm2vm parameter sets the mode of packet switching between guests in
-the host.
+   Sets the mode of packet switching between guests on the host:
 
-- 0 disables vm2vm, implying that VM's packets will always go to the NIC port.
-- 1 means a normal mac lookup packet routing.
-- 2 means hardware mode packet forwarding between guests, it allows packets
-  go to the NIC port, hardware L2 switch will determine which guest the
-  packet should forward to or need send to external, which bases on the
-  packet destination MAC address and VLAN tag.
+   - 0 disables vm2vm, meaning VM packets always go to the NIC port.
+   - 1 enables normal MAC lookup packet routing.
+   - 2 enables hardware mode packet forwarding between guests. Packets can
+     go to the NIC port, and the hardware L2 switch determines which guest
+     receives the packet or whether to send it externally, based on the
+     destination MAC address and VLAN tag.
 
 **--mergeable 0|1**
-Set 0/1 to disable/enable the mergeable Rx feature. It's disabled by default.
+   Set to 0 or 1 to disable or enable the mergeable Rx feature. Disabled by default.
 
 **--stats interval**
-The stats parameter controls the printing of virtio-net device statistics.
-The parameter specifies an interval (in unit of seconds) to print statistics,
-with an interval of 0 seconds disabling statistics.
+   Controls printing of virtio-net device statistics. Specifies the interval
+   (in seconds) to print statistics. Setting the interval to 0 disables statistics.
 
 **--rx-retry 0|1**
-The rx-retry option enables/disables enqueue retries when the guests Rx queue
-is full. This feature resolves a packet loss that is observed at high data
-rates, by allowing it to delay and retry in the receive path. This option is
-enabled by default.
+   Enables or disables enqueue retries when the guest Rx queue is full. This
+   feature resolves packet loss observed at high data rates by allowing delays
+   and retries in the receive path. Enabled by default.
 
 **--rx-retry-num num**
-The rx-retry-num option specifies the number of retries on an Rx burst, it
-takes effect only when rx retry is enabled.  The default value is 4.
+   Specifies the number of retries on an Rx burst. Takes effect only when
+   rx-retry is enabled. Default value is 4.
 
 **--rx-retry-delay msec**
-The rx-retry-delay option specifies the timeout (in micro seconds) between
-retries on an RX burst, it takes effect only when rx retry is enabled. The
-default value is 15.
+   Specifies the timeout (in microseconds) between retries on an Rx burst.
+   Takes effect only when rx-retry is enabled. Default value is 15.
 
 **--builtin-net-driver**
-A very simple vhost-user net driver which demonstrates how to use the generic
-vhost APIs will be used when this option is given. It is disabled by default.
+   Uses a simple built-in vhost-user net driver that demonstrates how to use
+   the generic vhost APIs. Disabled by default.
 
 **--dmas**
-This parameter is used to specify the assigned DMA device of a vhost device.
-Async vhost-user net driver will be used if --dmas is set. For example
---dmas [txd0@00:04.0,txd1@00:04.1,rxd0@00:04.2,rxd1@00:04.3] means use
+   Specifies the assigned DMA device for a vhost device. The async vhost-user
+   net driver will be used if --dmas is set.
+
+   For example::
+
+      --dmas [txd0@00:04.0,txd1@00:04.1,rxd0@00:04.2,rxd1@00:04.3]
+
+   This means use
 DMA channel 00:04.0/00:04.2 for vhost device 0 enqueue/dequeue operation
 and use DMA channel 00:04.1/00:04.3 for vhost device 1 enqueue/dequeue
 operation. The index of the device corresponds to the socket file in order,
 that means vhost device 0 is created through the first socket file, vhost
 device 1 is created through the second socket file, and so on.
 
-**--total-num-mbufs 0-N**
-This parameter sets the number of mbufs to be allocated in mbuf pools,
-the default value is 147456. This is can be used if launch of a port fails
-due to shortage of mbufs.
+**--total-num-mbufs N**
+   Sets the number of mbufs to allocate in mbuf pools. Default value is 147456.
+   Use this option if port startup fails due to mbuf shortage.
 
 **--tso 0|1**
-Disables/enables TCP segment offload.
+   Disables or enables TCP segment offload.
 
 **--tx-csum 0|1**
-Disables/enables TX checksum offload.
+   Disables or enables TX checksum offload.
 
 **-p mask**
-Port mask which specifies the ports to be used
+   Port mask specifying which ports to use.
 
 Common Issues
--------------
+~~~~~~~~~~~~~
 
-* QEMU fails to allocate memory on hugetlbfs, with an error like the
+* QEMU fails to allocate memory on hugetlbfs and shows an error like the
   following::
 
       file_ram_alloc: can't mmap RAM pages: Cannot allocate memory
 
-  When running QEMU the above error indicates that it has failed to allocate
-  memory for the Virtual Machine on the hugetlbfs. This is typically due to
+  When running QEMU, the above error indicates that it has failed to allocate
+  memory for the virtual machine on hugetlbfs. This is typically due to
   insufficient hugepages being free to support the allocation request. The
-  number of free hugepages can be checked as follows:
+  number of free hugepages can be checked with:
 
   .. code-block:: console
 
@@ -200,23 +210,23 @@ Common Issues
 
 * Failed to build DPDK in VM
 
-  Make sure "-cpu host" QEMU option is given.
+  Make sure the "-cpu host" QEMU option is given.
 
-* Device start fails if NIC's max queues > the default number of 128
+* Device start fails if the NIC's max queues exceeds the default number of 128
 
-  mbuf pool size is dependent on the MAX_QUEUES configuration, if NIC's
-  max queue number is larger than 128, device start will fail due to
-  insufficient mbuf. This can be adjusted using ``--total-num-mbufs``
-  parameter.
+  The mbuf pool size is dependent on the MAX_QUEUES configuration.
+  If the NIC's maximum queue count is larger than 128,
+  then the device start will fail due to insufficient mbufs.
+  Adjust this using the ``--total-num-mbufs`` parameter.
 
 * Option "builtin-net-driver" is incompatible with QEMU
 
-  QEMU vhost net device start will fail if protocol feature is not negotiated.
-  DPDK virtio-user PMD can be the replacement of QEMU.
+  QEMU vhost-net device start will fail if the protocol feature is not negotiated.
+  The DPDK virtio-user PMD can replace QEMU.
 
 * Device start fails when enabling "builtin-net-driver" without memory
   pre-allocation
 
-  The builtin example doesn't support dynamic memory allocation. When vhost
-  backend enables "builtin-net-driver", "--numa-mem" option should be
-  added at virtio-user PMD side as a startup item.
+  The builtin example does not support dynamic memory allocation.
+  When vhost backend enables "builtin-net-driver", the "--numa-mem" option should
+  be added on the virtio-user PMD side as a startup parameter.
-- 
2.53.0

