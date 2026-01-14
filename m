Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F7CD3CC82
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 22:27:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 54AA741148;
	Wed, 14 Jan 2026 23:25:51 +0100 (CET)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49]) by mails.dpdk.org (Postfix) with ESMTP id 056BB42792
 for <dev@dpdk.org>; Wed, 14 Jan 2026 23:25:50 +0100 (CET)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-47ee4338e01so1160175e9.2
 for <dev@dpdk.org>; Wed, 14 Jan 2026 14:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768429549;
 x=1769034349; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h7VUr7RYOChKWRcyhpoCaQ9Mj34R2lxCN4OkNrEdu+4=;
 b=cDwgwxNX3Zs5XQiVMQvq7cq+CtNXoNVAk6X8a4e7jxrgZiiNGd929vy3wzRn0ckfpI
 hBphxu/v9+Xr7KpzS7tNFMae2OGQDG5akF0Yvh7KRInh9ECA0bRfE5UWpaGYpddWWYAQ
 PnnOx4+JZjywImTr/1Qew3ii2520iMDjCFz+KBxxviVYJhAsDxx8VBRUfOhHlC+/bqYC
 4eZfvrkhZApEh4HeyFZCOBdbU7FPTEVFHsy/I0j+0LUO3BuhFGXrE3MhNgIDeVHSDdys
 fdH8oKweCy4W3XxJnonwEDNc7v93Ol0FFrv5Zz77YmLjouqpWUZEXmMbX33evnd7Ia1v
 KvTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768429549; x=1769034349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=h7VUr7RYOChKWRcyhpoCaQ9Mj34R2lxCN4OkNrEdu+4=;
 b=Od2dszPw9UYpL8ROAzTvoF4LlQA3mlH+flIi8N3U5gmJHPw3sa/iTb76E6uLrTcrU1
 7YZYl3R2Qu5Ix4c1gaVtJEbJ+APu/lsHS1RI0r1C4Xj3jX7VC4LSk7TeOmOklecIGSPM
 vkHKWg0aKlUmXiGY4AUl51p3f4tPgAezLPtoDAN+LKWFFW31lGjfu0+CJRxzm64oxKb9
 SIRZUw2e4O58r4Xi+SIsJwot3P36iG8KKB15rpJasamwYCQfW2g2FMFFFHlPmB7WA7f+
 qIN32OjF0b4IPbensqtT2zeFyuOzJezw0LJBx9NC7e3fAclF2vgjQKWW0YoMZVHbPOdo
 EGCA==
X-Gm-Message-State: AOJu0YyKbxpq92NWBvOgh6OhkQ90MnWz3qEJTvwdkzHbXHpT09cayX/o
 AkmUStLisPoRjq2rwNxSAP/V7q3nKLYuYMDjX+j1KJFfjZi4KG8mGgyCcPwdQjVRMwxG1+aDXml
 8Tv/l
X-Gm-Gg: AY/fxX4UxoAf+C4mN8jmUy+vptJGmQ79xVf31z/Rn5GHxzrbs17r0xypyfyFyYyHcCv
 L8eO2l48IgjDjNLw+4nx1oUbyiPPRhEu13CUVlg4qxy7jPkPxcESJ9J+07n8np4mYufGQuEpcrB
 8IN47Vk2GRGJBt1YzK9yU4eti/Cw1SPMiHzKz0UlhtrPvMS9TK3w31Vpl2UtPdU3JnXuXjnVGQ1
 wmI3/v+CDsXqBQdIJFWdLk/jrqTLyM0hbE1lrY/WWeegS7bvq6y4Jn/61EkHrmqN3cHW1oaZop8
 AbsJ2hl9DHeb7fumAP7QAW7kbQcGsnJ76Mt+8yxG6XQUyhuKhcMCEPSnSZ2mMGaX4gk1BpOshSY
 3MVnuRpMuWZFmJrEX6vjFYI2K/CTfwelC+7YaGYLDXkULwHAplQkp17X99ezLFMVLJ5ZqWImP+Z
 jkQGUkDvfaBHcdB5oYmC/pr9cuj1zZL9TIqIFi9xrHExbZ7Es2Sg==
X-Received: by 2002:a05:600c:3556:b0:475:dd8d:2f52 with SMTP id
 5b1f17b1804b1-47ee338be73mr46819585e9.32.1768429549526; 
 Wed, 14 Jan 2026 14:25:49 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f42907141sm12040355e9.9.2026.01.14.14.25.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 14:25:48 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 David Hunt <david.hunt@intel.com>,
 Sivaprasad Tummala <sivaprasad.tummala@amd.com>
Subject: [PATCH 26/29] doc/guides: improve VM power management sample app guide
Date: Wed, 14 Jan 2026 14:22:07 -0800
Message-ID: <20260114222458.87119-27-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114222458.87119-1-stephen@networkplumber.org>
References: <20260114222458.87119-1-stephen@networkplumber.org>
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

Improve the VM power management sample application documentation:
- add Overview section heading
- restructure sections as subsections for consistency
- clarify and simplify explanations
- fix "in relation CPU" to "in relation to CPU"
- improve grammar throughout

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 .../sample_app_ug/vm_power_management.rst     | 138 ++++++++----------
 1 file changed, 63 insertions(+), 75 deletions(-)

diff --git a/doc/guides/sample_app_ug/vm_power_management.rst b/doc/guides/sample_app_ug/vm_power_management.rst
index 1955140bb3..86231c619b 100644
--- a/doc/guides/sample_app_ug/vm_power_management.rst
+++ b/doc/guides/sample_app_ug/vm_power_management.rst
@@ -4,20 +4,21 @@
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
+Overview
+--------
+
+Applications in virtual environments have a limited view of the host hardware.
+They cannot see how virtual components map to physical hardware, including the
+pinning of virtual CPUs (vCPUs) to physical CPUs (pCPUs), which may change over time.
+Additionally, virtual machine operating systems cannot manage their own power policies,
+as the necessary Machine Specific Registers (MSRs) for controlling P-state transitions
+are not accessible.
+
+This sample application demonstrates how a DPDK application can communicate its
+processing needs using local VM information (like vCPU or lcore details) to a
+host-based VM Power Manager.
+
+The VM Power Manager is responsible for:
 
 - **Accepting requests for frequency changes for a vCPU**
 - **Translating the vCPU to a pCPU using libvirt**
@@ -84,77 +85,64 @@ in the host.
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
+event notifications via ``poll``, `select``, or ``epoll``. The host monitors
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
+which provides a simpler and more readable way to specify these configurations.
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
@@ -163,7 +151,7 @@ exist, and you cannot use CPU frequency-based power management. Refer to the
 relevant BIOS documentation to determine how to access these settings.
 
 Host Operating System
-~~~~~~~~~~~~~~~~~~~~~
+^^^^^^^^^^^^^^^^^^^^^
 
 The DPDK Power Management library can use either the ``acpi_cpufreq`` or
 the ``intel_pstate`` kernel driver for the management of core frequencies. In
@@ -183,7 +171,7 @@ On reboot, load the ``acpi_cpufreq`` module:
    ``modprobe acpi_cpufreq``
 
 Hypervisor Channel Configuration
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
 Configure ``virtio-serial`` channels using ``libvirt`` XML.
 The XML structure is as follows:
@@ -324,7 +312,7 @@ comma-separated list of channel numbers to add. Specifying the keyword
 
    set_query {vm_name} enable|disable
 
-Manual control and inspection can also be carried in relation CPU frequency scaling:
+Manual control and inspection can also be carried in relation to CPU frequency scaling:
 
   Get the current frequency for each core specified in the mask:
 
@@ -479,7 +467,7 @@ correct directory using the following find command:
    /usr/lib/i386-linux-gnu/pkgconfig
    /usr/lib/x86_64-linux-gnu/pkgconfig
 
-Then use:
+Then, use:
 
 .. code-block:: console
 
-- 
2.51.0

