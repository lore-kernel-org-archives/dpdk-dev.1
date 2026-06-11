Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF17CD98C7
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 21:23:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C30734340F;
	Thu, 11 Jun 2026 23:21:42 +0200 (CEST)
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
 by mails.dpdk.org (Postfix) with ESMTP id 2FD9A433F0
 for <dev@dpdk.org>; Thu, 11 Jun 2026 23:21:39 +0200 (CEST)
Received: by mail-dl1-f52.google.com with SMTP id
 a92af1059eb24-13809223fd4so348446c88.1
 for <dev@dpdk.org>; Thu, 11 Jun 2026 14:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781212898;
 x=1781817698; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FIwPQjJq+gTs3chAQ9na/ZgKTWPKaknhWnBn9hzaFG0=;
 b=uoTX+GeTZ2sT5FJDLqbmeL5KxFDYcBXRjWFKzVr8kZLVNtWKdUa1cbhZeQ+p164Yrx
 5r836dkwRGrsWvE6VAQjpUdbMhCvV5dPoZtx7VOqYeLSomqBqVZklNWJjzXmd+tkV1W6
 2yqmslCCEUttSi3tc3Q2pQvtUz1BT1PA46qDB/TPCToKedgqOuzaP1MsjEDN8bfJroHf
 oO+V/khe+vt/heNcpUPJPV8jTT6mpa3oH2CQYZ4u2Unv9LN4VCaw3+n9qoWyrJy6EuA9
 nl6+WS9w9lO2rox+eaqDwsfqe4IlN7Xtedx0OE1OEcZ80O01xr6ajf5OdyEwufIX/dgN
 AY3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781212898; x=1781817698;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FIwPQjJq+gTs3chAQ9na/ZgKTWPKaknhWnBn9hzaFG0=;
 b=aJmDWMgH845WBKKNLJ882RnL5ouq58jn3qSU5b10R6FcH0zMa2Hy//oxox6iMEGP5i
 6YtHjKrHZVtjaX+M4/EIWJEGS4VZgEiGjEfBd3mtbR7VksZAWX6eyk3E30i8irKiDyTR
 LaqVZP4g54gyNuzImHI9dQxYq9I+fWzOApnqyl8FQjw6jH9WlJ9BoUKL2z0uGMJhgF+f
 CJSJ3fT/05oeJzq40xVLWZSbFRiBuhKAe9Sq6pNcWKUb50npb1yQxM+/pUlSvYnUq/w1
 1T5NkqIE9cdpIMRVY5rS/zJaiT7RUjzARTLPPsoepTv9SoTs/9fEY15HvrgaVjxkOvE8
 yd+w==
X-Gm-Message-State: AOJu0Yxh25YYeI5P1ii0BpGd+2Ij9+on0OMYzFqzfTX7o9+rCRixV16X
 fZFq2dABv8tXS/JaBhK0Uk+YPMU2gMtgWbNHzxFV/URrlNMkYNqLB/dArDTMkhn/8t5F7/u6SCt
 VUjw2
X-Gm-Gg: Acq92OGKPUsmFMNTN+/nFQpZ3PnzQKynRYmUF+dw7q5ObJpbCJJMHth8j6XM+ta5Nl8
 sDdK3cDpT+BoSW6ovP9VRNhecVWHOVARP/kVxP8xExDxoeqIVEL/6zxjyZjI8npLEF/IORwR4o8
 i5qhpud+DXflK1gixL5ch1lJnype13ZFz7PcuoHGmjlffXp4jgpeUtfSmYRBJ82e0cegsp6r563
 eKRs9/CECHKT24hLIqIqG+HWemGNefiay2IUfsc2YvT4pLIwcxVxpdbgM9Qg7braN+9/t1vm1Fc
 03eDNJ2sapZGx6YAV2InUrH3HgTSDD58MHEBjkpjdDMmRXRgGjuVAwBoJtlZYiipvd74ZPyoe7o
 YbxKkhn96GqMceuIAMYGXxflKeQpQJ6NqqDL3KJuYyqd0gwleS2h1bx7kEZolfYCLD6uYlO/gYW
 aNh6fdaStXww8k/bnNt4JCBJEgHEDed+Z2M/6ztd6BSDdhbttOB6SZ3LLUTzhlrQ==
X-Received: by 2002:a05:7301:9c83:b0:304:8870:2ac5 with SMTP id
 5a478bee46e88-3081ff415bfmr51387eec.6.1781212897533; 
 Thu, 11 Jun 2026 14:21:37 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081eb95450sm546238eec.28.2026.06.11.14.21.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 14:21:37 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Sivaprasad Tummala <sivaprasad.tummala@amd.com>
Subject: [PATCH 14/15] doc: improve vhost, VM power, and VMDq sample guides
Date: Thu, 11 Jun 2026 14:18:53 -0700
Message-ID: <20260611212119.1026721-15-stephen@networkplumber.org>
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

Enhanced documentation for virtualization-related samples:

vhost_blk.rst:
- Improved vhost block device descriptions
- Enhanced SCSI target configuration explanations
- Fixed formatting consistency

vhost_crypto.rst:
- Clarified cryptographic backend setup
- Improved virtio-crypto device descriptions
- Enhanced command-line examples

vm_power_management.rst:
- Restructured power management policy sections
- Improved guest-host communication descriptions
- Enhanced frequency scaling explanations
- Clarified branch ratio monitoring

vmdq_dcb_forwarding.rst:
- Enhanced VMDq and DCB configuration descriptions
- Improved traffic class explanations
- Fixed formatting in configuration examples

vmdq_forwarding.rst:
- Simplified VMDq pool configuration descriptions
- Improved MAC address filtering explanations

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/sample_app_ug/vhost_blk.rst        |  66 +++--
 doc/guides/sample_app_ug/vhost_crypto.rst     |  64 ++---
 .../sample_app_ug/vm_power_management.rst     | 262 ++++++++----------
 .../sample_app_ug/vmdq_dcb_forwarding.rst     | 101 ++++---
 doc/guides/sample_app_ug/vmdq_forwarding.rst  |  38 ++-
 5 files changed, 251 insertions(+), 280 deletions(-)

diff --git a/doc/guides/sample_app_ug/vhost_blk.rst b/doc/guides/sample_app_ug/vhost_blk.rst
index 788eef0d5f..7a3421302d 100644
--- a/doc/guides/sample_app_ug/vhost_blk.rst
+++ b/doc/guides/sample_app_ug/vhost_blk.rst
@@ -4,34 +4,37 @@
 Vhost_blk Sample Application
 =============================
 
-The vhost_blk sample application implemented a simple block device,
-which used as the  backend of Qemu vhost-user-blk device. Users can extend
-the exist example to use other type of block device(e.g. AIO) besides
-memory based block device. Similar with vhost-user-net device, the sample
-application used domain socket to communicate with Qemu, and the virtio
-ring (split or packed format) was processed by vhost_blk sample application.
-
-The sample application reuse lots codes from SPDK(Storage Performance
-Development Kit, https://github.com/spdk/spdk) vhost-user-blk target,
-for DPDK vhost library used in storage area, user can take SPDK as
-reference as well.
-
-Testing steps
--------------
-
-This section shows the steps how to start a VM with the block device as
+Overview
+--------
+
+The vhost_blk sample application implements a simple block device,
+which serves as the backend for the QEMU vhost-user-blk device. Users can
+extend the existing example to use other types of block devices (e.g., AIO)
+besides memory-based block devices. Similar to the vhost-user-net device,
+the sample application uses a Unix domain socket to communicate with QEMU
+and processes the virtio ring (split or packed format).
+
+The sample application reuses code from SPDK (Storage Performance
+Development Kit, https://github.com/spdk/spdk) vhost-user-blk target.
+For DPDK vhost library usage in storage applications, users can refer
+to SPDK as well.
+
+This section shows how to start a VM with the block device as
 fast data path for critical application.
 
 Compiling the Application
 -------------------------
 
-To compile the sample application see :doc:`compiling`.
+To compile the sample application, see :doc:`compiling`.
 
-The application is located in the ``examples`` sub-directory.
+The application is located in the ``examples/vhost_blk`` directory.
 
-You will also need to build DPDK both on the host and inside the guest
+You will need to build DPDK both on the host and inside the guest.
 
-Start the vhost_blk example
+Running the Application
+-----------------------
+
+Start the vhost_blk application
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 .. code-block:: console
@@ -54,12 +57,17 @@ Start the VM
         -device vhost-user-blk-pci,packed=on,chardev=char0,num-queues=1 \
         ...
 
-.. note::
-    You must check whether your Qemu can support "vhost-user-blk" or not,
-    Qemu v4.0 or newer version is required.
-    reconnect=1 means live recovery support that qemu can reconnect vhost_blk
-    after we restart vhost_blk example.
-    packed=on means the device support packed ring but need the guest kernel
-    version >= 5.0.
-    Now Qemu commit 9bb73502321d46f4d320fa17aa38201445783fc4 both support the
-    vhost-blk reconnect and packed ring.
+QEMU Options
+^^^^^^^^^^^^
+
+QEMU v4.0 or newer is required for vhost-user-blk support.
+
+reconnect=1
+   Enables live recovery support, allowing QEMU to reconnect to the
+   vhost_blk application after it restarts.
+
+packed=on
+   Enables packed virtqueue support. Requires guest kernel version 5.0
+   or newer.
+
+QEMU commit 9bb73502321d supports both vhost-blk reconnect and packed ring.
diff --git a/doc/guides/sample_app_ug/vhost_crypto.rst b/doc/guides/sample_app_ug/vhost_crypto.rst
index 5c4475342c..9f8e71b1b7 100644
--- a/doc/guides/sample_app_ug/vhost_crypto.rst
+++ b/doc/guides/sample_app_ug/vhost_crypto.rst
@@ -4,25 +4,25 @@
 Vhost_Crypto Sample Application
 ===============================
 
-The vhost_crypto sample application implemented a simple Crypto device,
-which used as the  backend of Qemu vhost-user-crypto device. Similar with
-vhost-user-net and vhost-user-scsi device, the sample application used
-domain socket to communicate with Qemu, and the virtio ring was processed
-by vhost_crypto sample application.
+The vhost_crypto sample application implements a Crypto device,
+which serves as the backend for the QEMU vhost-user-crypto device.
+Similar to vhost-user-net and vhost-user-scsi devices, the application uses
+a domain socket to communicate with QEMU, and processes the virtio rings
+to provide cryptographic services to the guest.
 
-Testing steps
--------------
-
-This section shows the steps how to start a VM with the crypto device as
+This section shows the steps to start a VM with the crypto device as
 fast data path for critical application.
 
 Compiling the Application
 -------------------------
 
-To compile the sample application see :doc:`compiling`.
+To compile the sample application, see :doc:`compiling`.
 
 The application is located in the ``examples`` sub-directory.
 
+Running the Application
+-----------------------
+
 Start the vhost_crypto example
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
@@ -37,33 +37,35 @@ Start the vhost_crypto example
 
 where,
 
-* config (lcore,cdev-id,queue-id): build the lcore-cryptodev id-queue id
-  connection. Once specified, the specified lcore will only work with
-  specified cryptodev's queue.
+* config (lcore,cdev-id,queue-id): builds the lcore-cryptodev id-queue id
+  connection. When specified, the lcore only works with the
+  specified cryptodev queue.
 
-* socket-file lcore,PATH: the path of UNIX socket file to be created and
-  the lcore id that will deal with the all workloads of the socket. Multiple
-  instances of this config item is supported and one lcore supports processing
+* socket-file lcore,PATH: specifies the path of the UNIX socket file to be created and
+  the lcore id that handles all workloads of the socket. Multiple
+  instances of this config item are supported and one lcore can process
   multiple sockets.
 
-* zero-copy: the presence of this item means the ZERO-COPY feature will be
-  enabled. Otherwise it is disabled. PLEASE NOTE the ZERO-COPY feature is still
-  in experimental stage and may cause the problem like segmentation fault. If
-  the user wants to use LKCF in the guest, this feature shall be turned off.
+* zero-copy: when present, indicates the zero-copy feature will be
+  enabled. Otherwise it is disabled.
 
-* guest-polling: the presence of this item means the application assumes the
-  guest works in polling mode, thus will NOT notify the guest completion of
+* guest-polling: when present, assumes the guest works in polling
+  mode and does not notify the guest upon completion of
   processing.
 
-* asymmetric-crypto: the presence of this item means
-  the application can handle the asymmetric crypto requests.
-  When this option is used,
-  symmetric crypto requests can not be handled by the application.
+* asymmetric-crypto: when present, indicates the application handles
+  asymmetric crypto requests. When this option is used, the application
+  cannot handle symmetric crypto requests.
 
-The application requires that crypto devices capable of performing
-the specified crypto operation are available on application initialization.
-This means that HW crypto device/s must be bound to a DPDK driver or
-a SW crypto device/s (virtual crypto PMD) must be created (using --vdev).
+.. note::
+   The zero-copy feature is experimental and may cause segmentation faults.
+   If you want to use LKCF in the guest, disable this feature.
+
+.. note::
+   The application requires that crypto devices capable of performing
+   the specified crypto operation are available on application initialization.
+   HW crypto devices must be bound to a DPDK driver or an SW crypto device
+   (virtual crypto PMD) must be created using --vdev.
 
 .. _vhost_crypto_app_run_vm:
 
@@ -83,4 +85,4 @@ Start the VM
         ...
 
 .. note::
-    You must check whether your Qemu can support "vhost-user-crypto" or not.
+   You must verify that your QEMU supports vhost-user-crypto.
diff --git a/doc/guides/sample_app_ug/vm_power_management.rst b/doc/guides/sample_app_ug/vm_power_management.rst
index 1955140bb3..590078dbd7 100644
--- a/doc/guides/sample_app_ug/vm_power_management.rst
+++ b/doc/guides/sample_app_ug/vm_power_management.rst
@@ -4,38 +4,37 @@
 Virtual Machine Power Management Application
 ============================================
 
-Applications running in virtual environments have an abstract view of
-the underlying hardware on the host. Specifically, applications cannot
-see the binding of virtual components to physical hardware. When looking
-at CPU resourcing, the pinning of Virtual CPUs (vCPUs) to Physical CPUs
-(pCPUs) on the host is not apparent to an application and this pinning
-may change over time. In addition, operating systems on Virtual Machines
-(VMs) do not have the ability to govern their own power policy. The
-Machine Specific Registers (MSRs) for enabling P-state transitions are
-not exposed to the operating systems running on the VMs.
-
-The solution demonstrated in this sample application shows an example of
-how a DPDK application can indicate its processing requirements using
-VM-local only information (vCPU/lcore, and so on) to a host resident VM
-Power Manager. The VM Power Manager is responsible for:
-
-- **Accepting requests for frequency changes for a vCPU**
-- **Translating the vCPU to a pCPU using libvirt**
-- **Performing the change in frequency**
+Overview
+--------
+
+Applications in virtual environments have a limited view of the host hardware.
+They cannot see how virtual components map to physical hardware, including the
+pinning of virtual CPUs (vCPUs) to physical CPUs (pCPUs), which may change over time.
+Additionally, virtual machine operating systems cannot manage their own power policies,
+as the necessary Machine Specific Registers (MSRs) for controlling P-state transitions
+is not available to them.
+
+This sample application demonstrates how a DPDK application can communicate its
+processing needs using local VM information (like vCPU or lcore details) to a
+host-based VM Power Manager.
+
+The VM Power Manager is responsible for:
+
+- Accepting requests for frequency changes for a vCPU
+- Translating the vCPU to a pCPU using libvirt
+- Performing the change in frequency
 
 This application demonstrates the following features:
 
-- **The handling of VM application requests to change frequency.**
+- **Handling of VM application requests to change frequency.**
   VM applications can request frequency changes for a vCPU. The VM
-  Power Management Application uses libvirt to translate that
+  Power Management application uses libvirt to translate that
   virtual CPU (vCPU) request to a physical CPU (pCPU) request and
   performs the frequency change.
 
-- **The acceptance of power management policies from VM applications.**
+- **Acceptance of power management policies from VM applications.**
   A VM application can send a policy to the host application. The
-  policy contains rules that define the power management behaviour
-  of the VM. The host application then applies the rules of the
-  policy independent of the VM application. For example, the
+  policy contains rules that define the power management behavior of the VM, which the host application then applies independent of the VM. For example, the
   policy can contain time-of-day information for busy/quiet
   periods, and the host application can scale up/down the relevant
   cores when required. See :ref:`sending_policy` for information on
@@ -51,7 +50,7 @@ This application demonstrates the following features:
 In addition to the ``librte_power`` library used on the host, the
 application uses a special version of ``librte_power`` on each VM, which
 directs frequency changes and policies to the host monitor rather than
-the APCI ``cpufreq`` ``sysfs`` interface used on the host in non-virtualised
+the ACPI ``cpufreq`` ``sysfs`` interface used on the host in non-virtualised
 environments.
 
 .. _figure_vm_power_mgr_highlevel:
@@ -84,77 +83,64 @@ in the host.
   state, manually altering CPU frequency. Also allows for the changings
   of vCPU to pCPU pinning
 
-Sample Application Architecture Overview
-----------------------------------------
-
-The VM power management solution employs ``qemu-kvm`` to provide
-communications channels between the host and VMs in the form of a
-``virtio-serial`` connection that appears as a para-virtualised serial
-device on a VM and can be configured to use various backends on the
-host. For this example, the configuration of each ``virtio-serial`` endpoint
-on the host as an ``AF_UNIX`` file socket, supporting poll/select and
-``epoll`` for event notification. In this example, each channel endpoint on
-the host is monitored for ``EPOLLIN`` events using ``epoll``. Each channel
-is specified as ``qemu-kvm`` arguments or as ``libvirt`` XML for each VM,
-where each VM can have several channels up to a maximum of 64 per VM. In this
-example, each DPDK lcore on a VM has exclusive access to a channel.
-
-To enable frequency changes from within a VM, the VM forwards a
-``librte_power`` request over the ``virtio-serial`` channel to the host. Each
-request contains the vCPU and power command (scale up/down/min/max). The
-API for the host ``librte_power`` and guest ``librte_power`` is consistent
-across environments, with the selection of VM or host implementation
-determined automatically at runtime based on the environment. On
-receiving a request, the host translates the vCPU to a pCPU using the
-libvirt API before forwarding it to the host ``librte_power``.
+Sample Application Architecture
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
+The VM power management solution uses ``qemu-kvm`` to create communication
+channels between the host and VMs through a ``virtio-serial`` connection.
+This connection appears as a para-virtualized serial device on the VM
+and can use various backends on the host. In this example, each ``virtio-serial``
+endpoint is configured as an ``AF_UNIX`` file socket on the host, supporting
+event notifications via ``poll``, ``select``, or ``epoll``. The host monitors
+each channel for ``EPOLLIN`` events using ``epoll``, with up to 64 channels per VM.
+Each DPDK lcore on a VM has exclusive access to a channel.
+
+To enable frequency scaling from within a VM, the VM sends a ``librte_power``
+request over the ``virtio-serial`` channel to the host. The request specifies
+the vCPU and desired power action (e.g., scale up, scale down, set to min/max).
+The ``librte_power`` API is consistent across environments, automatically selecting
+the appropriate VM or host implementation at runtime. Upon receiving a request,
+the host maps the vCPU to a pCPU using the libvirt API and forwards the command
+to the host’s ``librte_power`` for execution.
 
 .. _figure_vm_power_mgr_vm_request_seq:
 
 .. figure:: img/vm_power_mgr_vm_request_seq.*
 
-In addition to the ability to send power management requests to the
-host, a VM can send a power management policy to the host. In some
-cases, using a power management policy is a preferred option because it
-can eliminate possible latency issues that can occur when sending power
-management requests. Once the VM sends the policy to the host, the VM no
-longer needs to worry about power management, because the host now
-manages the power for the VM based on the policy. The policy can specify
-power behavior that is based on incoming traffic rates or time-of-day
-power adjustment (busy/quiet hour power adjustment for example). See
-:ref:`sending_policy` for more information.
-
-One method of power management is to sense how busy a core is when
-processing packets and adjusting power accordingly. One technique for
-doing this is to monitor the ratio of the branch miss to branch hits
-counters and scale the core power accordingly. This technique is based
-on the premise that when a core is not processing packets, the ratio of
-branch misses to branch hits is very low, but when the core is
-processing packets, it is measurably higher. The implementation of this
-capability is as a policy of type ``BRANCH_RATIO``.
-See :ref:`sending_policy` for more information on using the
-BRANCH_RATIO policy option.
-
-A JSON interface enables the specification of power management requests
-and policies in JSON format. The JSON interfaces provide a more
-convenient and more easily interpreted interface for the specification
-of requests and policies. See :ref:`power_man_requests` for more information.
+In addition to sending power management requests to the
+host, a VM can send a power management policy to the host.
+Using a policy is often preferred as it avoids potential
+latency issues from frequent requests. Once the policy is
+sent, the host manages the VM's power based on the policy,
+freeing the VM from further involvement. Policies can include
+rules like adjusting power based on traffic rates or setting
+power levels for busy and quiet hours. See :ref:`sending_policy`
+for more information.
+
+One power management method monitors core activity by tracking
+the ratio of branch misses to branch hits. When a core is idle,
+this ratio is low; when it’s busy processing packets, the ratio increases.
+This technique, implemented as a ``BRANCH_RATIO`` policy, adjusts core power
+dynamically based on workload. See :ref:`sending_policy` for more information
+on using the BRANCH_RATIO policy option.
+
+Power management requests and policies can also be defined using a JSON interface,
+which provides a simpler and more readable way to specify configurations. See
+For more details, see :ref:`power_man_requests` for more information.
 
 Performance Considerations
 ~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-While the Haswell microarchitecture allows for independent power control
-for each core, earlier microarchitectures do not offer such fine-grained
-control. When deploying on pre-Haswell platforms, greater care must be
-taken when selecting which cores are assigned to a VM, for example, a
-core does not scale down in frequency until all of its siblings are
-similarly scaled down.
+The Haswell microarchitecture enables independent power control for each core,
+but earlier microarchitectures lack this level of precision. On pre-Haswell platforms,
+careful consideration is needed when assigning cores to a VM. For instance, a core cannot
+scale down its frequency until all its sibling cores are also scaled down.
 
 Configuration
--------------
+~~~~~~~~~~~~~
 
 BIOS
-~~~~
+^^^^
 
 To use the power management features of the DPDK, you must enable
 Enhanced Intel SpeedStep® Technology in the platform BIOS. Otherwise,
@@ -163,7 +149,7 @@ exist, and you cannot use CPU frequency-based power management. Refer to the
 relevant BIOS documentation to determine how to access these settings.
 
 Host Operating System
-~~~~~~~~~~~~~~~~~~~~~
+^^^^^^^^^^^^^^^^^^^^^
 
 The DPDK Power Management library can use either the ``acpi_cpufreq`` or
 the ``intel_pstate`` kernel driver for the management of core frequencies. In
@@ -180,10 +166,12 @@ Linux command line:
 
 On reboot, load the ``acpi_cpufreq`` module:
 
+.. code-block:: console
+
    ``modprobe acpi_cpufreq``
 
 Hypervisor Channel Configuration
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
 Configure ``virtio-serial`` channels using ``libvirt`` XML.
 The XML structure is as follows:
@@ -202,7 +190,7 @@ The XML structure is as follows:
 
 Where a single controller of type ``virtio-serial`` is created, up to 32
 channels can be associated with a single controller, and multiple
-controllers can be specified. The convention is to use the name of the
+controllers can be specified. The convention is to use the VM name in the
 VM in the host path ``{vm_name}`` and to increment ``{channel_num}`` for each
 channel. Likewise, the port value ``{N}`` must be incremented for each
 channel.
@@ -271,11 +259,11 @@ than the EAL options:
 
 .. code-block:: console
 
-   ./<build_dir>/examples/dpdk-vm_power_mgr [EAL options]
+   ./<build_dir>/examples/dpdk-vm_power_manager [EAL options]
 
 The application requires exactly two cores to run. One core for the CLI
 and the other for the channel endpoint monitor. For example, to run on
-cores 0 and 1 on a system, issue the command:
+cores 0 and 1, issue the command:
 
 .. code-block:: console
 
@@ -308,83 +296,50 @@ Manager using the command:
 
    rm_vm {vm_name}
 
-Add communication channels for the specified VM using the following
-command. The ``virtio`` channels must be enabled in the VM configuration
-(``qemu/libvirt``) and the associated VM must be active. ``{list}`` is a
-comma-separated list of channel numbers to add. Specifying the keyword
-``all`` attempts to add all channels for the VM:
-
-.. code-block:: console
-
-   set_pcpu {vm_name} {vcpu} {pcpu}
-
-  Enable query of physical core information from a VM:
-
-.. code-block:: console
-
-   set_query {vm_name} enable|disable
-
-Manual control and inspection can also be carried in relation CPU frequency scaling:
-
-  Get the current frequency for each core specified in the mask:
-
-.. code-block:: console
-
-   show_cpu_freq_mask {mask}
-
-  Set the current frequency for the cores specified in {core_mask} by scaling each up/down/min/max:
+Add communication channels for the specified VM using the following command.
+The ``virtio`` channels must be enabled in the VM configuration
+(``qemu/libvirt``) and the associated VM must be active.
+``{list}`` is a comma-separated list of channel numbers to add.
+Specifying the keyword ``all`` attempts to add all channels for the VM:
 
 .. code-block:: console
 
    add_channels {vm_name} {list}|all
 
 Enable or disable the communication channels in ``{list}`` (comma-separated)
-for the specified VM. Alternatively, replace ``list`` with the keyword
-``all``. Disabled channels receive packets on the host. However, the commands
-they specify are ignored. Set the status to enabled to begin processing
-requests again:
+for the specified VM. Alternatively, replace ``{list}`` with the keyword
+``all``. Disabled channels still receive packets on the host, however the
+commands they specify are ignored. Set the status to enabled to begin
+processing requests again:
 
 .. code-block:: console
 
    set_channel_status {vm_name} {list}|all enabled|disabled
 
-Print to the CLI information on the specified VM. The information lists
-the number of vCPUs, the pinning to pCPU(s) as a bit mask, along with
-any communication channels associated with each VM, and the status of
-each channel:
+Enable or disable a VM's ability to query physical core information from the
+host:
 
 .. code-block:: console
 
-   show_vm {vm_name}
+   set_query {vm_name} enable|disable
 
-Set the binding of a virtual CPU on a VM with name ``{vm_name}`` to the
-physical CPU mask:
+Print to the CLI the information on the specified VM. The information lists
+the number of vCPUs, the pinning to pCPU(s) as a bit mask, along with any
+communication channels associated with each VM, and the status of each
+channel:
 
 .. code-block:: console
 
-   set_pcpu_mask {vm_name} {vcpu} {pcpu}
-
-Set the binding of the virtual CPU on the VM to the physical CPU:
-
-  .. code-block:: console
-
-   set_pcpu {vm_name} {vcpu} {pcpu}
-
-It is also possible to perform manual control and inspection in relation
-to CPU frequency scaling.
+   show_vm {vm_name}
 
-Get the current frequency for each core specified in the mask:
+Set the binding of a virtual CPU on the VM with name ``{vm_name}`` to a
+physical CPU:
 
 .. code-block:: console
 
-   show_cpu_freq_mask {mask}
-
-Set the current frequency for the cores specified in ``{core_mask}`` by
-scaling each up/down/min/max:
-
-.. code-block:: console
+   set_pcpu {vm_name} {vcpu} {pcpu}
 
-   set_cpu_freq {core_mask} up|down|min|max
+Manual control and inspection of host CPU frequency scaling is also available.
 
 Get the current frequency for the specified core:
 
@@ -392,11 +347,12 @@ Get the current frequency for the specified core:
 
    show_cpu_freq {core_num}
 
-Set the current frequency for the specified core by scaling up/down/min/max:
+Set the current frequency for the specified core by scaling it up, down, to
+min or to max:
 
 .. code-block:: console
 
-   set_cpu_freq {core_num} up|down|min|max
+   set_cpu_freq {core_num} up|down|min|max|enable_turbo|disable_turbo
 
 .. _enabling_out_of_band:
 
@@ -404,7 +360,7 @@ Command Line Options for Enabling Out-of-band Branch Ratio Monitoring
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 There are a couple of command line parameters for enabling the out-of-band
-monitoring of branch ratios on cores doing busy polling using PMDs as
+monitoring of branch ratios on cores doing busy polling using PMDs,
 described below:
 
 ``--core-branch-ratio {list of cores}:{branch ratio for listed cores}``
@@ -415,15 +371,14 @@ described below:
    causing the branch ratio to increase. When the ratio goes above
    the ratio threshold, the core frequency scales up to the maximum
    allowed value. The specified branch-ratio is a floating point number
-   that identifies the threshold at which to scale up or down for the
-   elements of the core-list. If not included the default branch ratio of
-   0.01 but will need adjustment for different workloads
+   that identifies the threshold at which to scale up or down. If not
+   included, the default branch ratio of 0.01 is used, but this may need
+   adjustment for different workloads.
 
    This parameter can be used multiple times for different sets of cores.
    The branch ratio mechanism can also be useful for non-PMD cores and
    hyper-threaded environments where C-States are disabled.
 
-
 Compiling and Running the Guest Applications
 --------------------------------------------
 
@@ -479,7 +434,7 @@ correct directory using the following find command:
    /usr/lib/i386-linux-gnu/pkgconfig
    /usr/lib/x86_64-linux-gnu/pkgconfig
 
-Then use:
+Then, use:
 
 .. code-block:: console
 
@@ -683,7 +638,7 @@ The following is an example JSON string for a power management request.
 
 To query the available frequencies of an lcore, use the query_cpu_freq command.
 Where {core_num} is the lcore to query.
-Before using this command, please enable responses via the set_query command on the host.
+Before using this command, enable responses via the set_query command on the host:
 
 .. code-block:: console
 
@@ -851,7 +806,6 @@ policy_type
 
 Description
    The type of policy to apply.
-   See the ``--policy`` option description for more information.
 Type
    string
 Values
@@ -864,9 +818,9 @@ Values
    - WORKLOAD: Determine how heavily loaded the cores are
      and scale up and down accordingly.
    - BRANCH_RATIO: An out-of-band policy that looks at the ratio
-     between branch hits and misses on a core
-     and uses that information to determine how much packet processing
-     a core is doing.
+     between branch hits and misses on a core and uses that information
+     to determine how much packet processing a core is doing.
+
 
 Required
    For ``CREATE`` and ``DESTROY`` policy requests only.
diff --git a/doc/guides/sample_app_ug/vmdq_dcb_forwarding.rst b/doc/guides/sample_app_ug/vmdq_dcb_forwarding.rst
index efb133c11c..98a234fe15 100644
--- a/doc/guides/sample_app_ug/vmdq_dcb_forwarding.rst
+++ b/doc/guides/sample_app_ug/vmdq_dcb_forwarding.rst
@@ -4,37 +4,45 @@
 VMDQ and DCB Forwarding Sample Application
 ==========================================
 
-The VMDQ and DCB Forwarding sample application is a simple example of packet processing using the DPDK.
-The application performs L2 forwarding using VMDQ and DCB to divide the incoming traffic into queues.
-The traffic splitting is performed in hardware by the VMDQ and DCB features of the Intel® 82599 and X710/XL710 Ethernet Controllers.
+The VMDQ and DCB Forwarding sample application demonstrates L2 forwarding packet processing
+using VMDQ and DCB.
+It divides the incoming traffic into queues, which is performed in hardware
+by the VMDQ and DCB features of the Intel 82599 and X710/XL710 Ethernet Controllers.
 
 Overview
 --------
 
-This sample application can be used as a starting point for developing a new application that is based on the DPDK and
-uses VMDQ and DCB for traffic partitioning.
+This sample application can be used as a starting point for developing a new application
+that is based on the DPDK and uses VMDQ and DCB for traffic partitioning.
 
-The VMDQ and DCB filters work on MAC and VLAN traffic to divide the traffic into input queues on the basis of the Destination MAC
-address, VLAN ID and VLAN user priority fields.
-VMDQ filters split the traffic into 16 or 32 groups based on the Destination MAC and VLAN ID.
-Then, DCB places each packet into one of queues within that group, based upon the VLAN user priority field.
+The VMDQ and DCB filters work on MAC and VLAN traffic to divide the traffic into input queues
+on the basis of the Destination MAC address, VLAN ID and VLAN user priority fields.
 
-All traffic is read from a single incoming port (port 0) and output on port 1, without any processing being performed.
-With Intel® 82599 NIC, for example, the traffic is split into 128 queues on input, where each thread of the application reads from
-multiple queues. When run with 8 threads, that is, with the -c FF option, each thread receives and forwards packets from 16 queues.
+VMDQ filters
+   Split the traffic into 16 or 32 groups based on the Destination MAC and VLAN ID.
+
+DCB (Data Center Bridging)
+   Place each packet into one of the queues within that group, based upon the VLAN user priority field.
+
+All traffic is read from a single incoming port (port 0) and output on port 1.
+No packet processing is performed.
+
+Using Intel® 82599 NIC, the traffic is split into 128 queues on input, where each thread of the application reads from
+multiple queues. When run with 8 threads (with the -c FF option), each thread receives and forwards packets from 16 queues.
 
 As supplied, the sample application configures the VMDQ feature to have 32 pools with 4 queues each as indicated in :numref:`figure_vmdq_dcb_example`.
-The Intel® 82599 10 Gigabit Ethernet Controller NIC also supports the splitting of traffic into 16 pools of 8 queues. While the
-Intel® X710 or XL710 Ethernet Controller NICs support many configurations of VMDQ pools of 4 or 8 queues each. For simplicity, only 16
-or 32 pools is supported in this sample. And queues numbers for each VMDQ pool can be changed by setting RTE_LIBRTE_I40E_QUEUE_NUM_PER_VM
-in config/rte_config.h file.
-The nb-pools, nb-tcs and enable-rss parameters can be passed on the command line, after the EAL parameters:
+The Intel 82599 10 Gigabit Ethernet Controller NIC also supports the splitting of traffic into 16 pools of 8 queues.
+The Intel X710 or XL710 Ethernet Controller NICs support many configurations of VMDQ pools of 4 or 8 queues each.
+
+For simplicity, only 16 or 32 pools are supported in this sample. Queues numbers for each VMDQ pool
+can be changed by setting RTE_LIBRTE_I40E_QUEUE_NUM_PER_VM in config/rte_config.h file.
+The nb-pools, nb-tcs and enable-rss parameters can be passed on the command line after the EAL parameters:
 
 .. code-block:: console
 
     ./<build_dir>/examples/dpdk-vmdq_dcb [EAL options] -- -p PORTMASK --nb-pools NP --nb-tcs TC --enable-rss
 
-where, NP can be 16 or 32, TC can be 4 or 8, rss is disabled by default.
+where NP can be 16 or 32, TC can be 4 or 8, and RSS is disabled by default.
 
 .. _figure_vmdq_dcb_example:
 
@@ -43,10 +51,10 @@ where, NP can be 16 or 32, TC can be 4 or 8, rss is disabled by default.
    Packet Flow Through the VMDQ and DCB Sample Application
 
 
-In Linux* user space, the application can display statistics with the number of packets received on each queue.
-To have the application display the statistics, send a SIGHUP signal to the running application process.
+In Linux user space, the application can display statistics with the number of packets received on each queue.
+To have the application display statistics, send a SIGHUP signal to the running application process.
 
-The VMDQ and DCB Forwarding sample application is in many ways simpler than the L2 Forwarding application
+This sample application is in many ways simpler than the L2 Forwarding application
 (see :doc:`l2_forward_real_virtual`)
 as it performs unidirectional L2 forwarding of packets from one port to a second port.
 No command-line options are taken by this application apart from the standard EAL command-line options.
@@ -54,25 +62,23 @@ No command-line options are taken by this application apart from the standard EA
 .. note::
 
     Since VMD queues are being used for VMM, this application works correctly
-    when VTd is disabled in the BIOS or Linux* kernel (intel_iommu=off).
+    when VTd is disabled in the BIOS or Linux kernel (intel_iommu=off).
 
 Compiling the Application
 -------------------------
 
-
-
-To compile the sample application see :doc:`compiling`.
+To compile the sample application, see :doc:`compiling`.
 
 The application is located in the ``vmdq_dcb`` sub-directory.
 
 Running the Application
 -----------------------
 
-To run the example in a linux environment:
+To run the example in a Linux environment:
 
 .. code-block:: console
 
-    user@target:~$ ./<build_dir>/examples/dpdk-vmdq_dcb -l 0-3 -- -p 0x3 --nb-pools 32 --nb-tcs 4
+    user@host:~$ ./<build_dir>/examples/dpdk-vmdq_dcb -l 0-3 -- -p 0x3 --nb-pools 32 --nb-tcs 4
 
 Refer to the *DPDK Getting Started Guide* for general information on running applications and
 the Environment Abstraction Layer (EAL) options.
@@ -80,20 +86,20 @@ the Environment Abstraction Layer (EAL) options.
 Explanation
 -----------
 
-The following sections provide some explanation of the code.
+The following sections provide explanation of the code.
 
 Initialization
 ~~~~~~~~~~~~~~
 
 The EAL, driver and PCI configuration is performed largely as in the L2 Forwarding sample application,
 as is the creation of the mbuf pool.
-See :doc:`l2_forward_real_virtual`.
-Where this example application differs is in the configuration of the NIC port for RX.
+
+See :doc:`l2_forward_real_virtual`. This example application differs in the configuration of the NIC port for Rx.
 
 The VMDQ and DCB hardware feature is configured at port initialization time by setting the appropriate values in the
 rte_eth_conf structure passed to the rte_eth_dev_configure() API.
-Initially in the application,
-a default structure is provided for VMDQ and DCB configuration to be filled in later by the application.
+
+Initially in the application, a default structure is provided for VMDQ and DCB configuration to be filled in later by the application.
 
 .. literalinclude:: ../../../examples/vmdq_dcb/main.c
     :language: c
@@ -101,18 +107,21 @@ a default structure is provided for VMDQ and DCB configuration to be filled in l
     :end-before: >8 End of empty vmdq+dcb configuration structure.
 
 The get_eth_conf() function fills in an rte_eth_conf structure with the appropriate values,
-based on the global vlan_tags array,
-and dividing up the possible user priority values equally among the individual queues
-(also referred to as traffic classes) within each pool. With Intel® 82599 NIC,
-if the number of pools is 32, then the user priority fields are allocated 2 to a queue.
+based on the global vlan_tags array, and divides up the possible user priority values equally
+among the individual queues (also referred to as traffic classes) within each pool.
+
+With Intel 82599 NIC, if the number of pools is 32, then the user priority fields are allocated 2 to a queue.
 If 16 pools are used, then each of the 8 user priority fields is allocated to its own queue within the pool.
-With Intel® X710/XL710 NICs, if number of tcs is 4, and number of queues in pool is 8,
-then the user priority fields are allocated 2 to one tc, and a tc has 2 queues mapping to it, then
-RSS will determine the destination queue in 2.
-For the VLAN IDs, each one can be allocated to possibly multiple pools of queues,
-so the pools parameter in the rte_eth_vmdq_dcb_conf structure is specified as a bitmask value.
+
+With Intel X710/XL710 NICs, if the number of tcs is 4, and number of queues in pool is 8,
+then the user priority fields are allocated 2 to one tc.
+
+If the tc has 2 queues mapping to it, then RSS will determine the destination queue in 2.
+For the VLAN IDs, each one can be allocated to multiple pools of queues,
+so the ``pools`` parameter in the ``rte_eth_vmdq_dcb_conf`` structure is specified as a bitmask value.
+
 For destination MAC, each VMDQ pool will be assigned with a MAC address. In this sample, each VMDQ pool
-is assigned to the MAC like 52:54:00:12:<port_id>:<pool_id>, that is,
+is assigned to the MAC like 52:54:00:12:<port_id>:<pool_id>, and
 the MAC of VMDQ pool 2 on port 1 is 52:54:00:12:01:02.
 
 .. literalinclude:: ../../../examples/vmdq_dcb/main.c
@@ -134,8 +143,8 @@ See :doc:`l2_forward_real_virtual` for more information.
 Statistics Display
 ~~~~~~~~~~~~~~~~~~
 
-When run in a linux environment,
-the VMDQ and DCB Forwarding sample application can display statistics showing the number of packets read from each RX queue.
+When run in a Linux environment, the VMDQ and DCB Forwarding sample application can display
+statistics showing the number of packets read from each Rx queue.
 This is provided by way of a signal handler for the SIGHUP signal,
 which simply prints to standard output the packet counts in grid form.
 Each row of the output is a single pool with the columns being the queue number within that pool.
@@ -144,7 +153,7 @@ To generate the statistics output, use the following command:
 
 .. code-block:: console
 
-    user@host$ sudo killall -HUP vmdq_dcb_app
+    user@host$ sudo killall -HUP dpdk-vmdq_dcb
 
-Please note that the statistics output will appear on the terminal where the vmdq_dcb_app is running,
+Please note that the statistics output will appear on the terminal where the dpdk-vmdq_dcb is running,
 rather than the terminal from which the HUP signal was sent.
diff --git a/doc/guides/sample_app_ug/vmdq_forwarding.rst b/doc/guides/sample_app_ug/vmdq_forwarding.rst
index c998a5a223..3124483f79 100644
--- a/doc/guides/sample_app_ug/vmdq_forwarding.rst
+++ b/doc/guides/sample_app_ug/vmdq_forwarding.rst
@@ -2,9 +2,9 @@
     Copyright(c) 2020 Intel Corporation.
 
 VMDq Forwarding Sample Application
-==========================================
+==================================
 
-The VMDq Forwarding sample application is a simple example of packet processing using the DPDK.
+The VMDq Forwarding sample application is an example of packet processing using the DPDK.
 The application performs L2 forwarding using VMDq to divide the incoming traffic into queues.
 The traffic splitting is performed in hardware by the VMDq feature of the Intel® 82599 and X710/XL710 Ethernet Controllers.
 
@@ -14,28 +14,28 @@ Overview
 This sample application can be used as a starting point for developing a new application that is based on the DPDK and
 uses VMDq for traffic partitioning.
 
-VMDq filters split the incoming packets up into different "pools" - each with its own set of RX queues - based upon
+VMDq filtering splits incoming packets into different "pools" (each with its own set of Rx queues) based on
 the MAC address and VLAN ID within the VLAN tag of the packet.
 
 All traffic is read from a single incoming port and output on another port, without any processing being performed.
-With Intel® 82599 NIC, for example, the traffic is split into 128 queues on input, where each thread of the application reads from
-multiple queues. When run with 8 threads, that is, with the -c FF option, each thread receives and forwards packets from 16 queues.
+With the Intel® 82599 NIC, for example, traffic is split into 128 queues on input, where each thread of the application reads from
+multiple queues. When run with 8 threads with the -c FF option, each thread receives and forwards packets from 16 queues.
 
-As supplied, the sample application configures the VMDq feature to have 32 pools with 4 queues each.
+As supplied, the sample application configures the VMDq feature to have 32 pools, with 4 queues each.
 The Intel® 82599 10 Gigabit Ethernet Controller NIC also supports the splitting of traffic into 16 pools of 2 queues.
 While the Intel® X710 or XL710 Ethernet Controller NICs support many configurations of VMDq pools of 4 or 8 queues each.
 And queues numbers for each VMDq pool can be changed by setting RTE_LIBRTE_I40E_QUEUE_NUM_PER_VM
 in config/rte_config.h file.
-The nb-pools and enable-rss parameters can be passed on the command line, after the EAL parameters:
+The ``--nb-pools`` and ``--enable-rss`` parameters can be passed on the command line, after the EAL parameters:
 
 .. code-block:: console
 
     ./<build_dir>/examples/dpdk-vmdq [EAL options] -- -p PORTMASK --nb-pools NP --enable-rss
 
-where, NP can be 8, 16 or 32, rss is disabled by default.
+where NP can be 8, 16 or 32. RSS is disabled by default.
 
-In Linux* user space, the application can display statistics with the number of packets received on each queue.
-To have the application display the statistics, send a SIGHUP signal to the running application process.
+In a Linux user space, the application can display statistics on standard output showing the number of packets received on each queue.
+To have the application display statistics, send a SIGHUP signal to the running application process.
 
 The VMDq Forwarding sample application is in many ways simpler than the L2 Forwarding application
 (see :doc:`l2_forward_real_virtual`)
@@ -45,7 +45,7 @@ No command-line options are taken by this application apart from the standard EA
 Compiling the Application
 -------------------------
 
-To compile the sample application see :doc:`compiling`.
+To compile the sample application, see :doc:`compiling`.
 
 The application is located in the ``vmdq`` sub-directory.
 
@@ -64,20 +64,18 @@ the Environment Abstraction Layer (EAL) options.
 Explanation
 -----------
 
-The following sections provide some explanation of the code.
+The following sections provide explanation of the code.
 
 Initialization
 ~~~~~~~~~~~~~~
 
 The EAL, driver and PCI configuration is performed largely as in the L2 Forwarding sample application,
-as is the creation of the mbuf pool.
-See :doc:`l2_forward_real_virtual`.
-Where this example application differs is in the configuration of the NIC port for RX.
+as is the creation of the mbuf pool. See :doc:`l2_forward_real_virtual`.
+This example application differs in the configuration of the NIC port for Rx.
 
 The VMDq hardware feature is configured at port initialization time by setting the appropriate values in the
 rte_eth_conf structure passed to the rte_eth_dev_configure() API.
-Initially in the application,
-a default structure is provided for VMDq configuration to be filled in later by the application.
+Initially in the application, a default structure is provided for VMDq configuration to be filled in later by the application.
 
 .. literalinclude:: ../../../examples/vmdq/main.c
     :language: c
@@ -88,8 +86,8 @@ The get_eth_conf() function fills in an rte_eth_conf structure with the appropri
 based on the global vlan_tags array.
 For the VLAN IDs, each one can be allocated to possibly multiple pools of queues.
 For destination MAC, each VMDq pool will be assigned with a MAC address. In this sample, each VMDq pool
-is assigned to the MAC like 52:54:00:12:<port_id>:<pool_id>, that is,
-the MAC of VMDq pool 2 on port 1 is 52:54:00:12:01:02.
+is assigned to the MAC like 52:54:00:12:<port_id>:<pool_id>.
+The MAC of VMDq pool 2 on port 1 is 52:54:00:12:01:02.
 
 .. literalinclude:: ../../../examples/vmdq/main.c
     :language: c
@@ -126,5 +124,5 @@ To generate the statistics output, use the following command:
 
     user@host$ sudo killall -HUP vmdq_app
 
-Please note that the statistics output will appear on the terminal where the vmdq_app is running,
+Please note that the statistics output will appear on the terminal where the application is running,
 rather than the terminal from which the HUP signal was sent.
-- 
2.53.0

