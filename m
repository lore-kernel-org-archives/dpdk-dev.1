Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54978CD98C7
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 21:22:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BC633433F5;
	Thu, 11 Jun 2026 23:21:37 +0200 (CEST)
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179]) by mails.dpdk.org (Postfix) with ESMTP id D36A8433D1
 for <dev@dpdk.org>; Thu, 11 Jun 2026 23:21:33 +0200 (CEST)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-304cf518c9dso572133eec.1
 for <dev@dpdk.org>; Thu, 11 Jun 2026 14:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781212893;
 x=1781817693; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3IqtWlpj7N4JTnnXMe+WZjYim5L7SRQQHd0L6CjigwY=;
 b=Pa5sWoiI2vVdC//9Y78iNKw7N6IkzSs29NRLJJT7B5w7ZiDR9bOvV6rxfEEduTqYCU
 SDXJIZ8IK+jj9NOO7SkgxgHaPnIOv4xVb8QRf5iSXtD4fQ42RiLPxhkcVVItKmLPDHJk
 TaMYqMsYY1TDAgQ4rrGVl8uWAC7kKFNj0IlEN+3GvNZh3AbnxNcoqvzUku5sjfE/FE1P
 VQoSsczwe+lxYWt17TUIPninro7LVjmmTLxTJ34OVdnyslns3YlW0zd9aVQY5nTF8yWU
 c64Zt/zusIEdx7QDJWoNRNNelgVsRtVZfPVZvJItXC4g0LgmQNQKmXkSwJGpN5nE4vIo
 zthg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781212893; x=1781817693;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3IqtWlpj7N4JTnnXMe+WZjYim5L7SRQQHd0L6CjigwY=;
 b=kcOFvtbjY7oo1WLWnzDXtzhIH3cuvZFt2HncUjhRaZtmhD+bv3k6ZSIQC4qgrYWuYO
 s5y4YwbBvs3GnyOsAGQpiJzJ88bWgyr9rncmvouszHAtM/Li/dQS1E8ANgczhst6dAv8
 Me97jFR0MTC/15uk9R01Zf6gegkQYkZRX/oyvPWpcfL6ZYyKYMAOKtOcKWIWX53kiEx+
 K2k0GRqIZ6OWcbB92Uaj1iBEb4KilPAaSuXoTJM48x0czrhcOgnL8oOJwoNuomh9bOor
 6iEe2irHJyPNaXJdZS4gyLZ0RJQO+m4PCTqJOvhXet5+XUXHLYIawZocXbI8ckuX7si1
 ATHw==
X-Gm-Message-State: AOJu0YylU0lUfBNp2r64+ts/1zybACtKc/fxBhZy5X4Dnjo3qZxGhuqX
 85xCnuG786C9/Z0igct8zqlmOI31HVswal6HUoKXZTABfqY7i7igqYW9v/mHUWbtT4GXawiLKQV
 Dur0B
X-Gm-Gg: Acq92OEegr5Rc0Hq8zrOiUj3MKmMNALR8xMtJyo9u3ID9ZhFFr332TO9Ocy/AAh4xvv
 pJQCYvAJe6eKrnruFDo+KwgtH86caOCg09V4Jnkhx3sWCSniC60xVcP72lVV//04Xv7OFFf+dMU
 RlQJz0GOuOH06eJ1ptpv2H8mlIBXecT3EIlh6X8ANUjw9cWZKAss4h7mGEpWCDOiZuEnWepgZR/
 9Ml88zQZ04/jq6jviqsUbYg/uaUxSjWGaSmlw8fnLhbKdNRJTyxXJTd+Xr6NBSGbFQDQRp6NiPG
 nZAVfiV9Iih4bvxWf2QwVkDTI6Ws0aq3BBTtHev7ymIfKui8WUJVf+BnbAyW/Mqrp1PdjYTCNjs
 qV6daNmAvwWz9qPPEoWIeBDCq1Zb405yD6iwGob9ot4pXMj5ZKLO1AD84vK5zEx0Yali658uUKe
 dD43uq04vAHky6hjPkVIxLV+niGLwAmnemsImisOxR8ebZDCsZ428zCw3nFLIa2Q==
X-Received: by 2002:a05:7300:8cab:b0:304:ab8:f87c with SMTP id
 5a478bee46e88-3081ff7c07fmr48109eec.12.1781212892576; 
 Thu, 11 Jun 2026 14:21:32 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081eb95450sm546238eec.28.2026.06.11.14.21.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 14:21:32 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Tomasz Kantecki <tomasz.kantecki@intel.com>,
 Sunil Kumar Kori <skori@marvell.com>,
 Pavan Nikhilesh <pbhagavatula@marvell.com>,
 Akhil Goyal <gakhil@marvell.com>
Subject: [PATCH 10/15] doc: enhance L2 forwarding sample application guides
Date: Thu, 11 Jun 2026 14:18:49 -0700
Message-ID: <20260611212119.1026721-11-stephen@networkplumber.org>
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

Improved documentation for L2 forwarding variants:

l2_forward_cat.rst:
- Enhanced Cache Allocation Technology descriptions
- Fixed command-line parameter formatting
- Improved clarity of CAT configuration steps

l2_forward_crypto.rst:
- Restructured cryptographic operation descriptions
- Improved cipher and authentication algorithm lists
- Enhanced command-line option explanations

l2_forward_event.rst:
- Clarified event-driven processing model
- Fixed formatting and terminology consistency

l2_forward_job_stats.rst:
- Improved job statistics collection descriptions
- Enhanced clarity of monitoring mechanisms

l2_forward_macsec.rst:
- Simplified MACsec configuration explanations
- Fixed formatting in security association setup

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/sample_app_ug/l2_forward_cat.rst   | 34 ++++-----
 .../sample_app_ug/l2_forward_crypto.rst       | 70 +++++++++----------
 doc/guides/sample_app_ug/l2_forward_event.rst | 20 +++---
 .../sample_app_ug/l2_forward_job_stats.rst    | 46 ++++++------
 .../sample_app_ug/l2_forward_macsec.rst       | 38 +++++-----
 5 files changed, 100 insertions(+), 108 deletions(-)

diff --git a/doc/guides/sample_app_ug/l2_forward_cat.rst b/doc/guides/sample_app_ug/l2_forward_cat.rst
index f96f789f75..9901a796e0 100644
--- a/doc/guides/sample_app_ug/l2_forward_cat.rst
+++ b/doc/guides/sample_app_ug/l2_forward_cat.rst
@@ -14,22 +14,22 @@ Overview
 
 This app is intended as a demonstration of the basic components
 of a DPDK forwarding application
-and use of the libpqos library to the program CAT.
+and the use of the libpqos library to program CAT.
 For more detailed implementations, see the L2 and L3 forwarding sample applications.
 
-CAT and Code Data Prioritization (CDP) features allow management of the CPU's
-last level cache. CAT introduces classes of service (COS) that are essentially
+The CAT and Code Data Prioritization (CDP) features allow management of the CPU's
+last level cache. CAT introduces Classes of Service (COS) that are essentially
 bitmasks. In current CAT implementations, a bit in a COS bitmask corresponds to
 one cache way in last level cache.
 
 A CPU core is always assigned to one of the CAT classes.
 By programming CPU core assignment and COS bitmasks, applications can be given
 exclusive, shared, or mixed access to the CPU's last level cache.
-CDP extends CAT so that there are two bitmasks per COS,
+The CDP feature extends CAT so that there are two bitmasks per COS,
 one for data and one for code.
 The number of classes and number of valid bits in a COS bitmask is CPU model
 specific and COS bitmasks need to be contiguous. Sample code calls this bitmask
-``cbm`` or capacity bitmask.
+a ``cbm`` or capacity bitmask.
 By default, after reset, all CPU cores are assigned to COS 0 and all classes
 are programmed to allow fill into all cache ways.
 CDP is off by default.
@@ -47,7 +47,7 @@ Compiling the Application
 
 .. note::
 
-    Requires ``libpqos`` from Intel's
+    Requires the ``libpqos`` library from Intel's
     `intel-cmt-cat software package <https://github.com/01org/intel-cmt-cat>`_
     hosted on GitHub repository. For installation notes, please see ``README`` file.
 
@@ -70,7 +70,7 @@ The application is located in the ``l2fwd-cat`` sub-directory.
 Running the Application
 -----------------------
 
-To run the example in a ``linux`` environment and enable CAT on cpus 0-2:
+To run the example in a Linux environment and enable CAT on CPUs 0-2:
 
 .. code-block:: console
 
@@ -87,7 +87,7 @@ If CDP is not supported, it will fail with following error message:
 .. code-block:: console
 
     PQOS: CDP requested but not supported.
-    PQOS: Requested CAT configuration is not valid!
+    PQOS: Requested CAT configuration is not valid.
     PQOS: Shutting down PQoS library...
     EAL: Error - exiting with code: 1
       Cause: PQOS: L3CA init failed!
@@ -99,7 +99,7 @@ The option to enable CAT is:
   where ``cbm`` stands for capacity bitmask and must be expressed in
   hexadecimal form.
 
-  ``common_cbm`` is a single mask, for a CDP enabled system, a group of two
+  ``common_cbm`` is a single mask; for a CDP-enabled system, a group of two
   masks (``code_cbm`` and ``data_cbm``) is used.
 
   ``(`` and ``)`` are necessary if it's a group.
@@ -125,7 +125,7 @@ The option to enable CAT is:
     data ways are not overlapping.
 
 
-Refer to *DPDK Getting Started Guide* for general information on running
+Refer to the *DPDK Getting Started Guide* for general information on running
 applications and the Environment Abstraction Layer (EAL) options.
 
 
@@ -133,7 +133,7 @@ To reset or list CAT configuration and control CDP please use ``pqos`` tool
 from Intel's
 `intel-cmt-cat software package <https://github.com/01org/intel-cmt-cat>`_.
 
-To enabled or disable CDP:
+To enable or disable CDP:
 
 .. code-block:: console
 
@@ -141,7 +141,7 @@ To enabled or disable CDP:
 
     sudo ./pqos -S cdp-off
 
-to reset CAT configuration:
+To reset CAT configuration:
 
 .. code-block:: console
 
@@ -193,11 +193,11 @@ function. The value returned is the number of parsed arguments:
     :end-before: >8 End of initialization of PQoS.
     :dedent: 1
 
-``cat_init()`` is a wrapper function which parses the command, validates
+The ``cat_init()`` function is a wrapper function which parses the command, validates
 the requested parameters and configures CAT accordingly.
 
-The parsing of command line arguments is done in ``parse_args(...)``.
-Libpqos is then initialized with the ``pqos_init(...)`` call.
+The parsing of command line arguments is done in the ``parse_args(...)`` function.
+The libpqos library is then initialized with the ``pqos_init(...)`` call.
 Next, libpqos is
 queried for system CPU information and L3CA capabilities via
 ``pqos_cap_get(...)`` and ``pqos_cap_get_type(..., PQOS_CAP_TYPE_L3CA, ...)``
@@ -207,6 +207,6 @@ for a sufficient number of un-associated COS. COS are selected and
 configured via the ``pqos_l3ca_set(...)`` call. Finally, COS are associated to
 relevant CPUs via ``pqos_l3ca_assoc_set(...)`` calls.
 
-``atexit(...)`` is used to register ``cat_exit(...)`` to be called on
-a clean exit. ``cat_exit(...)`` performs a simple CAT clean-up, by associating
+The ``atexit(...)`` function is used to register ``cat_exit(...)`` to be called on
+a clean exit. The ``cat_exit(...)`` function performs a simple CAT clean-up, by associating
 COS 0 to all involved CPUs via ``pqos_l3ca_assoc_set(...)`` calls.
diff --git a/doc/guides/sample_app_ug/l2_forward_crypto.rst b/doc/guides/sample_app_ug/l2_forward_crypto.rst
index ba38d9f22e..add535cd39 100644
--- a/doc/guides/sample_app_ug/l2_forward_crypto.rst
+++ b/doc/guides/sample_app_ug/l2_forward_crypto.rst
@@ -1,18 +1,18 @@
 ..  SPDX-License-Identifier: BSD-3-Clause
     Copyright(c) 2016-2017 Intel Corporation.
 
-L2 Forwarding with Crypto Sample Application
+L2 forwarding with crypto sample application
 ============================================
 
 The L2 Forwarding with Crypto (l2fwd-crypto) sample application
 is a simple example of packet processing
-using the Data Plane Development Kit (DPDK)
-in conjunction with the cryptodev library.
+using the Data Plane Development Kit (DPDK),
+in conjunction with the Cryptodev library.
 
 Overview
 --------
 
-The L2 Forwarding with Crypto sample application performs a crypto operation (cipher/hash)
+The L2 Forwarding with Crypto sample application performs crypto operations (cipher/hash)
 specified by the user from the command line (or using the default values),
 with a crypto device capable of doing that operation,
 for each packet that is received on an RX_PORT and performs L2 forwarding.
@@ -20,10 +20,9 @@ for each packet that is received on an RX_PORT and performs L2 forwarding.
 The destination port is the adjacent port from the enabled portmask.
 If the first four ports are enabled (portmask 0xf),
 ports 0 and 1 forward into each other, and ports 2 and 3 forward into each other.
-If the MAC addresses updating is enabled, the MAC addresses are affected as follows:
+If MAC address updating is enabled, the MAC addresses are affected as follows:
 
 *   The source MAC address is replaced by the TX_PORT MAC address
-
 *   The destination MAC address is replaced by  02:00:00:00:00:TX_PORT_ID
 
 Compiling the Application
@@ -40,17 +39,17 @@ The application requires a number of command line options:
 
 .. code-block:: console
 
-    ./<build_dir>/examples/dpdk-l2fwd-crypto [EAL options] -- [-p PORTMASK] [-q NQ] [-s] [-T PERIOD] /
-    [--cdev_type HW/SW/ANY] [--chain HASH_CIPHER/CIPHER_HASH/CIPHER_ONLY/HASH_ONLY/AEAD] /
-    [--cipher_algo ALGO] [--cipher_op ENCRYPT/DECRYPT] [--cipher_dataunit_len SIZE] /
-    [--cipher_key KEY] [--cipher_key_random_size SIZE] [--cipher_iv IV] /
-    [--cipher_iv_random_size SIZE] /
-    [--auth_algo ALGO] [--auth_op GENERATE/VERIFY] [--auth_key KEY] /
-    [--auth_key_random_size SIZE] [--auth_iv IV] [--auth_iv_random_size SIZE] /
-    [--aead_algo ALGO] [--aead_op ENCRYPT/DECRYPT] [--aead_key KEY] /
-    [--aead_key_random_size SIZE] [--aead_iv] [--aead_iv_random_size SIZE] /
-    [--aad AAD] [--aad_random_size SIZE] /
-    [--digest size SIZE] [--sessionless] [--cryptodev_mask MASK] /
+    ./<build_dir>/examples/dpdk-l2fwd-crypto [EAL options] -- [-p PORTMASK] [-q NQ] [-s] [-T PERIOD] \
+    [--cdev_type HW/SW/ANY] [--chain HASH_CIPHER/CIPHER_HASH/CIPHER_ONLY/HASH_ONLY/AEAD] \
+    [--cipher_algo ALGO] [--cipher_op ENCRYPT/DECRYPT] [--cipher_dataunit_len SIZE] \
+    [--cipher_key KEY] [--cipher_key_random_size SIZE] [--cipher_iv IV] \
+    [--cipher_iv_random_size SIZE] \
+    [--auth_algo ALGO] [--auth_op GENERATE/VERIFY] [--auth_key KEY] \
+    [--auth_key_random_size SIZE] [--auth_iv IV] [--auth_iv_random_size SIZE] \
+    [--aead_algo ALGO] [--aead_op ENCRYPT/DECRYPT] [--aead_key KEY] \
+    [--aead_key_random_size SIZE] [--aead_iv] [--aead_iv_random_size SIZE] \
+    [--aad AAD] [--aad_random_size SIZE] \
+    [--digest size SIZE] [--sessionless] [--cryptodev_mask MASK] \
     [--mac-updating] [--no-mac-updating]
 
 where,
@@ -143,7 +142,7 @@ where,
 
 *   aad_random_size: set the size of the AAD, which will be generated randomly.
 
-    Note that if --aad is used, this will be ignored.
+    Note that if ``--aad`` is used, this will be ignored.
 
 *   digest_size: set the size of the digest to be generated/verified.
 
@@ -159,10 +158,10 @@ where,
 
 The application requires that crypto devices capable of performing
 the specified crypto operation are available on application initialization.
-This means that HW crypto device/s must be bound to a DPDK driver or
+This means that HW crypto devices must be bound to a DPDK driver or
 a SW crypto device/s (virtual crypto PMD) must be created (using --vdev).
 
-To run the application in Linux environment with 2 lcores, 2 ports and 2 crypto devices, issue the command:
+To run the application in the Linux environment with 2 lcores, 2 ports and 2 crypto devices, issue the command:
 
 .. code-block:: console
 
@@ -178,7 +177,7 @@ and the Environment Abstraction Layer (EAL) options.
 
 .. Note::
 
-    * The ``l2fwd-crypto`` sample application requires IPv4 packets for crypto operation.
+    * The ``l2fwd-crypto`` sample application requires IPv4 packets for crypto operations.
 
     * If multiple Ethernet ports are passed, then equal number of crypto devices are to be passed.
 
@@ -200,17 +199,15 @@ from reception until transmission.
    Encryption flow through the L2 Forwarding with Crypto Application
 
 
-The following sections provide explanation of the application.
+The following sections provide an explanation of the application.
 
 Crypto operation specification
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 All the packets received in all the ports get transformed by the crypto devices
 (ciphering and/or authentication).
-The crypto operation to be performed on the packet is parsed from the command line.
-(Go to "Running the Application" section for all the options.)
-
-If no parameter is passed, the default crypto operation is:
+The crypto operation to be performed on the packet is parsed from the command line (see "Running the Application" for all options).
+If no parameters are passed, the default crypto operation is:
 
 * Encryption with AES-CBC with 128 bit key.
 
@@ -218,7 +215,7 @@ If no parameter is passed, the default crypto operation is:
 
 * Keys, IV and AAD are generated randomly.
 
-There are two methods to pass keys, IV and ADD from the command line:
+There are two methods to pass keys, IV and AAD from the command line:
 
 * Passing the full key, separated bytes by ":"::
 
@@ -236,7 +233,7 @@ The size of these keys are checked (regardless of the method) before starting th
 to make sure that it is supported by the crypto devices.
 
 Crypto device initialization
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 Once the encryption operation is defined, the crypto devices are initialized.
 The crypto devices must be either bound to a DPDK driver (if they are physical devices)
@@ -245,9 +242,9 @@ when running the application.
 
 The initialize_cryptodevs() function performs the device initialization.
 It iterates through the list of the available crypto devices and
-checks which ones are capable of performing the operation.
-Each device has a set of capabilities associated with it,
-which are stored in the device info structure, so the function checks if the operation
+checks which are capable of performing the operation.
+Each device has a set of capabilities associated with it
+that are stored in the device info structure, so the function checks if the operation
 is within the structure of each device.
 
 The following code checks if the device supports the specified cipher algorithm
@@ -273,14 +270,15 @@ crypto device list.
 
 **Note**:
    The number of crypto devices that supports the specified crypto operation
-   must be at least the number of ports to be used.
+   must be at least equal to the number of Ethernet ports in use. If using
+   multiple Ethernet ports, an equal number of crypto devices must be provided.
 
 Session creation
 ~~~~~~~~~~~~~~~~
 
 The crypto operation has a crypto session associated to it, which contains
-information such as the transform chain to perform (e.g. ciphering then hashing)
-pointers to the keys, lengths... etc.
+information such as the transform chain to perform (e.g. ciphering then hashing),
+pointers to the keys, lengths, etc.
 
 This session is created and is later attached to the crypto operation:
 
@@ -306,7 +304,7 @@ the mbuf which will be transformed is attached to it::
 
    op->sym->m_src = m;
 
-Since no destination mbuf is set, the source mbuf will be overwritten
+Since no destination mbuf is set, the source mbuf is overwritten
 after the operation is done (in-place).
 
 Crypto operation enqueuing/dequeuing
@@ -315,7 +313,7 @@ Crypto operation enqueuing/dequeuing
 Once the operation has been created, it has to be enqueued in one of the crypto devices.
 Before doing so, for performance reasons, the operation stays in a buffer.
 When the buffer has enough operations (MAX_PKT_BURST), they are enqueued in the device,
-which will perform the operation at that moment:
+which performs the operation at that moment:
 
 .. literalinclude:: ../../../examples/l2fwd-crypto/main.c
     :language: c
diff --git a/doc/guides/sample_app_ug/l2_forward_event.rst b/doc/guides/sample_app_ug/l2_forward_event.rst
index 1d52211b9a..c4329d0036 100644
--- a/doc/guides/sample_app_ug/l2_forward_event.rst
+++ b/doc/guides/sample_app_ug/l2_forward_event.rst
@@ -17,7 +17,7 @@ The destination port is the adjacent port from the enabled portmask.
 If the first four ports are enabled (portmask=0x0f),
 ports 1 and 2 forward into each other,
 and ports 3 and 4 forward into each other.
-Also, if MAC address updating is enabled,
+Also, if MAC addresses updating is enabled,
 the MAC addresses are affected as follows:
 
 *   The source MAC address is replaced by the Tx port MAC address
@@ -26,7 +26,7 @@ the MAC addresses are affected as follows:
 Application receives packets from Rx port using these methods:
 
 *   Poll mode
-*   Eventdev mode (default)
+*   Eventdev mode (by default)
 
 This application can be used to benchmark performance using a traffic-generator,
 as shown in the :numref:`figure_l2fwd_event_benchmark_setup`.
@@ -64,7 +64,7 @@ where,
 
 *   q NQ: Maximum number of queues per lcore (default is 1)
 
-*   --[no-]mac-updating: Enable or disable MAC addresses updating (enabled by default).
+*   --[no-]mac-updating: Enable or disable MAC addresses updating (enabled by default)
 
 *   --mode=MODE: Packet transfer mode for I/O, poll or eventdev. Eventdev by default.
 
@@ -374,9 +374,9 @@ is assigned that is either the next or previous enabled port from the portmask.
 If the number of ports are odd in portmask, then the packet from the last port will be
 forwarded to first port i.e. if portmask=0x07, then forwarding will take place
 like p0--->p1, p1--->p2, p2--->p0.
+If MAC address updating is enabled, the source and destination MAC addresses are updated.
 
-Also, to optimize enqueue operation, ``l2fwd_simple_forward()`` stores incoming mbufs
-up to ``MAX_PKT_BURST``.
+To optimize enqueue operation, ``l2fwd_simple_forward()`` stores incoming mbufs up to ``MAX_PKT_BURST``.
 Once it reaches the limit, all packets are transmitted to destination ports.
 
 .. literalinclude:: ../../../examples/l2fwd/main.c
@@ -420,15 +420,15 @@ to ensure the correct allowed deq length by the eventdev.
 The ``rte_event_dequeue_burst()`` function writes the mbuf pointers in a local table
 and returns the number of available mbufs in the table.
 
-Then, each mbuf in the table is processed by the ``l2fwd_eventdev_forward()``
-function. The processing is very simple: process the TX port from the RX port,
-then replace the source and destination MAC addresses if MAC address updating
-is enabled.
+Then, each mbuf in the table is processed by the ``l2fwd_eventdev_forward()`` function.
+The processing is very simple: determine the TX port from the RX port,
+then replace the source and destination MAC addresses if MAC addresses updating is enabled.
 
 During the initialization process, a static array of destination ports
 (``l2fwd_dst_ports[]``) is filled so that for each source port, a destination port
 is assigned that is either the next or previous enabled port from the portmask.
-If number of ports are odd in portmask then packet from last port will be
+If the number of ports are odd in portmask,
+then the packet from the last port will be
 forwarded to first port i.e. if portmask=0x07, then forwarding will take place
 like p0--->p1, p1--->p2, p2--->p0.
 
diff --git a/doc/guides/sample_app_ug/l2_forward_job_stats.rst b/doc/guides/sample_app_ug/l2_forward_job_stats.rst
index 23448f23a4..6b8f8dda3e 100644
--- a/doc/guides/sample_app_ug/l2_forward_job_stats.rst
+++ b/doc/guides/sample_app_ug/l2_forward_job_stats.rst
@@ -10,8 +10,8 @@ also takes advantage of Single Root I/O Virtualization (SR-IOV) features in a vi
 
 .. note::
 
-    This application is a variation of L2 Forwarding sample application. It demonstrate possible
-    scheme of job stats library usage therefore some parts of this document is identical with original
+    This application is a variation of the L2 Forwarding sample application. It demonstrates a possible
+    scheme of job stats library usage therefore some parts of this document are identical with the original
     L2 forwarding application.
 
 Overview
@@ -92,7 +92,7 @@ where,
 
 *   q NQ: Maximum number of queues per lcore (default is 1)
 
-*   l: Use locale thousands separator when formatting big numbers.
+*   l: Use a locale thousands separator when formatting big numbers.
 
 To run the application in a Linux environment with 4 lcores, 16 ports, 8 RX queues per lcore
 and thousands separator printing, issue the command:
@@ -157,14 +157,14 @@ but it is possible to extend this code to allocate one mbuf pool per socket.
 The ``rte_pktmbuf_pool_create()`` function uses the default mbuf pool and mbuf
 initializers, respectively ``rte_pktmbuf_pool_init()`` and ``rte_pktmbuf_init()``.
 An advanced application may want to use the mempool API to create the
-mbuf pool with more control.
+mbuf pool with greater control.
 
 Driver Initialization
 ~~~~~~~~~~~~~~~~~~~~~
 
 The main part of the code in the ``main()`` function relates to the initialization of the driver.
 To fully understand this code, it is recommended to study the chapters that related to the Poll Mode Driver
-in the *DPDK Programmer's Guide* and the *DPDK API Reference*.
+To fully understand this code, it is recommended to study the chapters related to the Poll Mode Driver in the *DPDK Programmer's Guide* and the *DPDK API Reference*.
 
 .. literalinclude:: ../../../examples/l2fwd-jobstats/main.c
     :language: c
@@ -211,7 +211,7 @@ Values of struct lcore_queue_conf:
 *   n_rx_port and rx_port_list[] are used in the main packet processing loop
     (see Section `Receive, Process and Transmit Packets`_ later in this chapter).
 
-*   rx_timers and flush_timer are used to ensure forced TX on low packet rate.
+*   rx_timers and flush_timer are used to force TX on low packet rate.
 
 *   flush_job, idle_job and jobs_context are librte_jobstats objects used for managing l2fwd jobs.
 
@@ -228,9 +228,9 @@ Each lcore should be able to transmit on any port. For every port, a single TX q
     :end-before: >8 End of init one TX queue on each port.
     :dedent: 2
 
-Jobs statistics initialization
+Job Statistics Initialization
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-There are several statistics objects available:
+Several statistics objects are available:
 
 *   Flush job statistics
 
@@ -260,7 +260,7 @@ Main loop
 ~~~~~~~~~
 
 The forwarding path is reworked comparing to original L2 Forwarding application.
-In the ``l2fwd_main_loop()`` function, three loops are placed.
+In the ``l2fwd_main_loop()`` function, three loop iterations are used.
 
 .. literalinclude:: ../../../examples/l2fwd-jobstats/main.c
     :language: c
@@ -268,13 +268,13 @@ In the ``l2fwd_main_loop()`` function, three loops are placed.
     :end-before: >8 End of minimize impact of stats reading.
     :dedent: 1
 
-The first infinite for loop is to minimize impact of stats reading.
+The first infinite loop minimizes the impact of statistics reading.
 Lock is only locked/unlocked when asked.
 
-Second inner while loop do the whole jobs management.
-When any job is ready, the use ``rte_timer_manage()`` is used to call the job handler.
+The second inner while loop performs the whole jobs management.
+When any job is ready, ``rte_timer_manage()`` is used to call the job handler.
 
-In this place, functions ``l2fwd_fwd_job()`` and ``l2fwd_flush_job()`` are called when needed.
+At this point, functions ``l2fwd_fwd_job()`` and ``l2fwd_flush_job()`` are called when needed.
 Then, ``rte_jobstats_context_finish()`` is called to mark loop end -
 no other jobs are ready to execute.
 By this time, stats are ready to be read
@@ -283,11 +283,11 @@ and if stats_read_pending is set, loop breaks allowing stats to be read.
 Third do-while loop is the idle job (idle stats counter).
 Its only purpose is monitoring if any job is ready
 or stats job read is pending for this lcore.
-Statistics from this part of the code is considered as
+Statistics from this part of the code are considered as
 the headroom available for additional processing.
 
-Receive, Process and Transmit Packets
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Receive, Process, and Transmit Packets
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 The main task of ``l2fwd_fwd_job()`` function is to read ingress packets
 from the Rx queue of particular port and forward it.
@@ -354,18 +354,12 @@ However, in real-life applications (such as, L3 routing),
 packet N is not necessarily forwarded on the same port as packet N-1.
 The application is implemented to illustrate that, so the same approach can be reused in a more complex application.
 
-The ``l2fwd_send_packet()`` function stores the packet in a per-lcore and per-txport table.
-If the table is full, the whole packets table is transmitted
-using the ``l2fwd_send_burst()`` function:
+The ``l2fwd_simple_forward()`` function uses ``rte_eth_tx_buffer()`` to buffer packets
+for transmission. When the buffer is full, packets are automatically transmitted.
 
-.. literalinclude:: ../../../examples/l2fwd-crypto/main.c
-    :language: c
-    :start-after: Enqueue packets for TX and prepare them to be sent. 8<
-    :end-before: >8 End of Enqueuing packets for TX.
-
-To ensure that no packets remain in the tables, the flush job exists.
+To ensure that no packets remain in the buffers, the flush job exists.
 The ``l2fwd_flush_job()``
-is called periodically to for each lcore draining TX queue of each port.
+is called periodically for each lcore to drain the TX queue of each port.
 This technique introduces some latency when there are not many packets to send,
 however it improves performance:
 
diff --git a/doc/guides/sample_app_ug/l2_forward_macsec.rst b/doc/guides/sample_app_ug/l2_forward_macsec.rst
index 7e6c971465..c0452992e8 100644
--- a/doc/guides/sample_app_ug/l2_forward_macsec.rst
+++ b/doc/guides/sample_app_ug/l2_forward_macsec.rst
@@ -15,7 +15,7 @@ The L2 forwarding MACsec application performs L2 forwarding for each packet
 that is received on an Rx port after encrypting/decrypting the packets
 based on rte_security sessions using inline protocol mode.
 
-The destination port is the adjacent port from the enabled portmask
+The destination port is the adjacent port from the enabled portmask,
 if the first four ports are enabled (portmask ``0xf``),
 ports 1 and 2 forward into each other, and ports 3 and 4 forward into each other.
 
@@ -43,44 +43,44 @@ The application requires a number of command line options:
        [--portmap="(port, port)[,(port, port)]"]
        [-T STAT_INTERVAL]
 
-where,
+where:
 
-``p PORTMASK``
-  Hexadecimal bitmask of the ports to configure.
+``-p PORTMASK``
+   Hexadecimal bitmask of the ports to configure.
 
-``q NQ``
-  Number of queues (=ports) per lcore (default is 1).
+``-q NQ``
+   Number of queues (=ports) per lcore (default is 1).
 
-``T STAT_INTERVAL``
-  Time interval in seconds for refreshing the stats (default is 1 sec).
-  Value 0 disables stats display.
+``-T STAT_INTERVAL``
+   Time interval in seconds for refreshing the stats (default is 1).
+   Value 0 disables stats display.
 
 ``--mcs-tx-portmask OUTBOUND_PORTMASK``
-  Hexadecimal bitmask of the ports to configure encryption flows.
+   Hexadecimal bitmask of the ports to configure encryption flows.
 
 ``--mcs-rx-portmask INBOUND_PORTMASK``
-  Hexadecimal bitmask of the ports to configure decryption flows.
+   Hexadecimal bitmask of the ports to configure decryption flows.
 
-``--mcs-port-config '(port,src_mac,dst_mac)[,(port,src_mac,dst_mac)]'``
-  Source and destination MAC addresses of incoming packets
-  on a port for which MACsec processing is to be done.
+``--mcs-port-config "(port,src_mac,dst_mac)[,(port,src_mac,dst_mac)]"``
+   Source and destination MAC addresses of incoming packets
+   on a port for which MACsec processing is to be done.
 
 ``--portmap="(port,port)[,(port,port)]"``
   Forwarding ports mapping.
 
 To run the application in Linux environment with 4 lcores,
-4 ports with 2 ports for outbound and 2 ports for outbound,
+4 ports with 2 ports for outbound and 2 ports for inbound,
 issue the command:
 
 .. code-block:: console
 
    $ ./<build_dir>/examples/dpdk-l2fwd-macsec -a 0002:04:00.0 -a 0002:05:00.0 \
        -a 0002:06:00.0 -a 0002:07:00.0 -l 1-4 -- -p 0xf                      \
-       --mcs-tx-portmask 0x5 --mcs-rx-portmask 0xA                            \
-       --mcs-port-config '(0,02:03:04:05:06:07,01:02:03:04:05:06),            \
+       --mcs-tx-portmask 0x5 --mcs-rx-portmask 0xa                            \
+       --mcs-port-config="(0,02:03:04:05:06:07,01:02:03:04:05:06),            \
        (1,02:03:04:05:06:17,01:02:03:04:05:16),                               \
        (2,02:03:04:05:06:27,01:02:03:04:05:26),                               \
-       (3,02:03:04:05:06:37,01:02:03:04:05:36)' -T 10
+       (3,02:03:04:05:06:37,01:02:03:04:05:36)" -T 10
 
 To run the application in Linux environment with 4 lcores, 4 ports,
 to forward Rx traffic of ports 0 & 1 on ports 2 & 3 respectively and vice versa,
@@ -90,7 +90,7 @@ issue the command:
 
    $ ./<build_dir>/examples/dpdk-l2fwd-macsec -a 0002:04:00.0 -a 0002:05:00.0 \
        -a 0002:06:00.0 -a 0002:07:00.0 -l 1-4 -- -p 0xf                      \
-       --mcs-tx-portmask 0x5 --mcs-rx-portmask 0xA                            \
+       --mcs-tx-portmask 0x5 --mcs-rx-portmask 0xa                            \
        --mcs-port-config="(0,02:03:04:05:06:07,01:02:03:04:05:06),            \
        (1,02:03:04:05:06:17,01:02:03:04:05:16),                               \
        (2,02:03:04:05:06:27,01:02:03:04:05:26),                               \
-- 
2.53.0

