Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8219C9830C
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Jan 2026 19:17:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 87A8742DB0;
	Sun, 18 Jan 2026 20:14:29 +0100 (CET)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com
 [209.85.208.49]) by mails.dpdk.org (Postfix) with ESMTP id 86C2C42D7A
 for <dev@dpdk.org>; Sun, 18 Jan 2026 20:14:26 +0100 (CET)
Received: by mail-ed1-f49.google.com with SMTP id
 4fb4d7f45d1cf-64dfb22c7e4so8118431a12.1
 for <dev@dpdk.org>; Sun, 18 Jan 2026 11:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768763666;
 x=1769368466; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tMYt2u2HMPrrXfzQCiHJBNxhCq1lRa+Qv4diDos9R+I=;
 b=Ef83QTKTYL8DJEQNESjandjasaq+QOsKmqESxUMLjyJ/V1RZOuX1ssGzMDuSiPMzBK
 H6jlTYZ4Sy+HnnmUDn54ty7aafz0+fzzCDml2T8nqcUSEcK2/Mh1MU9ogw9WQy4SqTso
 OXP9ieJXxdm2BL1EiG3WpR/4gM98LtX9cv8oC85kfdqVrZtDmvA6WJKtadez2TwMYvZY
 jfYFuNhGxaZnBZ0pAqk/0vgEdZCjqeS6yvbRsx3U8ga9kCcKUuF/nas8rSYf3t0tZECl
 0Y2InSLe4uyRQXzeEK/icx1/5FmHU7/E4FzzzgyWOdy5rQl29tXGYTY4+NkR0cLn623s
 RvQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768763666; x=1769368466;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tMYt2u2HMPrrXfzQCiHJBNxhCq1lRa+Qv4diDos9R+I=;
 b=bBE2W4z5+p7fa4KdK94Qaob+qmuCK3OQDJO3mV+O6ABMWlhc7xNDNyBQ0xNFH7B+V+
 28cQwrYkrXl0F+vndeOMN9ZscRcOoZnvQIELzUOA9FoGkgf81nEv0RcV7aubIS4V+Xo1
 fGTcG1q7FdDApSaZgXTbIq51+p0rBLIkd7RTIIy1/D/xNaKBEdxmMnnh6iV7iE+b4I2v
 AFlHitOL/aGq6ST1gdxFwqKDyoe/NIj+tYOzRvT87hi+slqge0R+u7N3Ur63Fa+iTTkB
 lDKytJsInj1BA0T67CopZCwwShv2kw4u6kXctxbNaBLsoAWNbKj8JlnopgC+H87IHiWw
 N//g==
X-Gm-Message-State: AOJu0Ywnh4lmfaiXctaFLJ10J/fIkPgFleIWht4hASnxNcUYDCeHyV2h
 9oWoKHZq5JEQmOC8s6AFAhFAexofbH326oUz31AyscQs89HXLSJBDaIWDSmf5VJ/VHRDd5jw7X2
 T+xWj
X-Gm-Gg: AY/fxX41DIS++mdHBMioWBzerRpl+biUStvBcg3EAfqgZOucQyIYglYjaJsim9IpxR/
 dCmulCriabWfk6T0F6Uozl/XqYVEhI9aR9WFS2Nf/xWAufX2UDeREwMC3z1JtVE4YNSJKmPBSv+
 Y9YERXaiTHRXurwjZqxB7EcbzxCDTF5MgPnmPV/7XF3lP48Di6YUjL4qZ9VimQqnmWSrx61PADg
 lE7Dzu2h5GbVkkxvpXKQKzuguz+3/CinYxKfAYToCQVFgtZLhlLhxXB/9lFC7SceRF/Hf2odIh3
 iFVDSq9DehvfdDQagalvf70hERwVW3jHWxqw6Q80fKVRizHQiDtlW0bMzwm6tk9HHIsTj6gsLSw
 L46HsErLPuFXs/U7fMrZ0HmX33hxxFH9pm2OiotJPJaA3VAEP4eWc7TId57LSnfzqJMzHEDoYgf
 fY/hhdVNrEfn3sNxtEOvCgCWMCK/Y1Gvi2TOyyQZ2J3rQmiUcqKw==
X-Received: by 2002:a17:907:7b89:b0:b84:3fab:4251 with SMTP id
 a640c23a62f3a-b87939d9b4emr1038683966b.15.1768763665965; 
 Sun, 18 Jan 2026 11:14:25 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87959c9f8dsm886287166b.36.2026.01.18.11.14.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 11:14:25 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 37/54] doc: correct grammar in multi-process guide
Date: Sun, 18 Jan 2026 11:10:40 -0800
Message-ID: <20260118191323.241013-38-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118191323.241013-1-stephen@networkplumber.org>
References: <20240513155911.31872-1-nandinipersad361@gmail.com>
 <20260118191323.241013-1-stephen@networkplumber.org>
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

Correct various grammar and style issues in the multi-process support
documentation:

- remove spurious spaces in hyphenated words (pre-initialized,
  Multi-process, side-by-side)
- add missing article "the" before "same DPDK version"
- fix subject-verb agreement in multiple places
- correct book title from "Application's" to "Applications"
- remove duplicate word "process" in startup description
- fix typo "pass long" to "pass along"
- add missing past participle "triggered"
- expand abbreviation "Misc" to "Miscellaneous"

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/prog_guide/multi_proc_support.rst | 28 ++++++++++----------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/doc/guides/prog_guide/multi_proc_support.rst b/doc/guides/prog_guide/multi_proc_support.rst
index a73918a5da..722506e385 100644
--- a/doc/guides/prog_guide/multi_proc_support.rst
+++ b/doc/guides/prog_guide/multi_proc_support.rst
@@ -17,7 +17,7 @@ For now, there are two types of process specified:
 *   primary processes, which can initialize and which have full permissions on shared memory
 
 *   secondary processes, which cannot initialize shared memory,
-    but can attach to pre- initialized shared memory and create objects in it.
+    but can attach to pre-initialized shared memory and create objects in it.
 
 Standalone DPDK processes are primary processes,
 while secondary processes can only run alongside a primary process or
@@ -25,9 +25,9 @@ after a primary process has already configured the hugepage shared memory for th
 
 .. note::
 
-    Secondary processes should run alongside primary process with same DPDK version.
+    Secondary processes should run alongside primary process with the same DPDK version.
 
-    Secondary processes which requires access to physical devices in Primary process, must
+    Secondary processes which require access to physical devices in Primary process, must
     be passed with the same allow and block options.
 
 To support these two process types, and other multi-process setups described later,
@@ -38,8 +38,8 @@ two additional command-line parameters are available to the EAL:
 *   ``--file-prefix:`` to allow processes that do not want to co-operate to have different memory regions
 
 A number of example applications are provided that demonstrate how multiple DPDK processes can be used together.
-These are more fully documented in the "Multi- process Sample Application" chapter
-in the *DPDK Sample Application's User Guide*.
+These are more fully documented in the "Multi-process Sample Application" chapter
+in the *DPDK Sample Applications User Guide*.
 
 Memory Sharing
 --------------
@@ -47,7 +47,7 @@ Memory Sharing
 The key element in getting a multi-process application working using the DPDK is to ensure that
 memory resources are properly shared among the processes making up the multi-process application.
 Once there are blocks of shared memory available that can be accessed by multiple processes,
-then issues such as inter-process communication (IPC) becomes much simpler.
+then issues such as inter-process communication (IPC) become much simpler.
 
 On application start-up in a primary or standalone process,
 the DPDK records to memory-mapped files the details of the memory configuration it is using - hugepages in use,
@@ -88,7 +88,7 @@ In this model, the first of the processes spawned should be spawned using the ``
 while all subsequent instances should be spawned using the ``--proc-type=secondary`` flag.
 
 The simple_mp and symmetric_mp sample applications demonstrate this usage model.
-They are described in the "Multi-process Sample Application" chapter in the *DPDK Sample Application's User Guide*.
+They are described in the "Multi-process Sample Application" chapter in the *DPDK Sample Applications User Guide*.
 
 Asymmetric/Non-Peer Processes
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -99,7 +99,7 @@ server distributing received packets among worker or client threads, which are r
 In this case, extensive use of rte_ring objects is made, which are located in shared hugepage memory.
 
 The client_server_mp sample application shows this usage model.
-It is described in the "Multi-process Sample Application" chapter in the *DPDK Sample Application's User Guide*.
+It is described in the "Multi-process Sample Application" chapter in the *DPDK Sample Applications User Guide*.
 
 Running Multiple Independent DPDK Applications
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -138,7 +138,7 @@ can use).
 Running Multiple Independent Groups of DPDK Applications
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-In the same way that it is possible to run independent DPDK applications side- by-side on a single system,
+In the same way that it is possible to run independent DPDK applications side-by-side on a single system,
 this can be trivially extended to multi-process groups of DPDK applications running side-by-side.
 In this case, the secondary processes must use the same ``--file-prefix`` parameter
 as the primary process whose shared memory they are connecting to.
@@ -155,7 +155,7 @@ There are a number of limitations to what can be done when running DPDK multi-pr
 Some of these are documented below:
 
 *   The multi-process feature requires that the exact same hugepage memory mappings be present in all applications.
-    This makes secondary process startup process generally unreliable. Disabling
+    This makes secondary process startup generally unreliable. Disabling
     Linux security feature - Address-Space Layout Randomization (ASLR) may
     help getting more consistent mappings, but not necessarily more reliable -
     if the mappings are wrong, they will be consistently wrong!
@@ -247,7 +247,7 @@ of fields to be populated are as follows:
 * ``name`` - message name. This name must match receivers' callback name.
 * ``param`` - message data (up to 256 bytes).
 * ``len_param`` - length of message data.
-* ``fds`` - file descriptors to pass long with the data (up to 8 fd's).
+* ``fds`` - file descriptors to pass along with the data (up to 8 fd's).
 * ``num_fds`` - number of file descriptors to send.
 
 Once the structure is populated, calling ``rte_mp_sendmsg()`` will send the
@@ -301,7 +301,7 @@ Receiving and responding to messages
 To receive a message, a name callback must be registered using the
 ``rte_mp_action_register()`` function. The name of the callback must match the
 ``name`` field in sender's ``rte_mp_msg`` message descriptor in order for this
-message to be delivered and for the callback to be trigger.
+message to be delivered and for the callback to be triggered.
 
 The callback's definition is ``rte_mp_t``, and consists of the incoming message
 pointer ``msg``, and an opaque pointer ``peer``. Contents of ``msg`` will be
@@ -318,8 +318,8 @@ pointer. The resulting response will then be delivered to the correct requestor.
     there is no built-in way to indicate success or error for a request. Failing
     to do so will cause the requestor to time out while waiting on a response.
 
-Misc considerations
-~~~~~~~~~~~~~~~~~~~~~~~~
+Miscellaneous considerations
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 Due to the underlying IPC implementation being single-threaded, recursive
 requests (i.e. sending a request while responding to another request) is not
-- 
2.51.0

