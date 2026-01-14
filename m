Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F11AD3CC86
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 22:27:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9B59442794;
	Wed, 14 Jan 2026 23:25:47 +0100 (CET)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52]) by mails.dpdk.org (Postfix) with ESMTP id AA2964278D
 for <dev@dpdk.org>; Wed, 14 Jan 2026 23:25:45 +0100 (CET)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-47fedb7c68dso606905e9.2
 for <dev@dpdk.org>; Wed, 14 Jan 2026 14:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768429545;
 x=1769034345; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TAEXcmP9kDYnQ8q2jtln/5LbTwQIGaCVomP10791MRE=;
 b=TfnuGdfLDTaWgc6IXZwd3pSFO38ePJU4ayqYJbFx1R936FQ7IBiOVVyIFs7tUiTcjS
 MtEAatvH86bZaNX3uLcyOGl6IDlBACUzrrw7gMjHyUweH7CQHSSCpYEcphUQLoFMK8v2
 YLMrxBFdmH8wuJTLOdwroesqp+6l6OnmAD1m75CbaJihGI8PliMB1AiHjN0gkA+LO8J6
 SVUEkZ5pwaILHzkcNF4em09dPn25RHHjFLvp7ksiVbHPJ4SO+n8S2w8mBk+WpVgLeRfc
 LyLnHSiEv+0zLCZpSb0t6E/XXtEkSRWZL0AlWo+dDrEtSqNhDZdgAMXuvTiZK9eK7fq+
 QdkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768429545; x=1769034345;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TAEXcmP9kDYnQ8q2jtln/5LbTwQIGaCVomP10791MRE=;
 b=qJcqQCYII5AtL5yNprzipOcKxbGzNJ/mcsNVsxGeCxbSqchbd/biGek5VOCFvMAs9z
 lknjUTYgqHS3Ee/KSJEmHZ2faKSpbMYpZ8ehXzMyoMmBnEwsKQAf9y3pg/XmGWr2IIf0
 W0ETlc6x9zg2RlxqkIiRvxYAgOz/zenCeRVrGVa/NaBGpA3cG0XjGTW+nucrjI69lQoh
 a+zHs7rypix7sCj1M3JxkOF/vZQFJvgzOZ9jiGCTiLyK+yXuZJ3Mxrh+QM1wIVGW4V9v
 Z9XlNGB/EfuQ//q32ha8QikH0sW42VW8lRwYZWcw8SekQYm+tRf7e3qb+uzMlP2U/9tV
 qTFg==
X-Gm-Message-State: AOJu0YxR5M+g7rXgO/1KJeWphyO6PWJAdZDfxS3J7Yo4fJzO0P5cpacG
 sGgRReuFph1s1DRl5f6PO2px+oGCdRA/yLw3tJaSW2ubzR88lBg9igiwXOUVn/yNS5d5Gy+HBK2
 o81++
X-Gm-Gg: AY/fxX6/U9FWMv0MV5koRt9ic+3Afd3j+kdt0FoePOJy69nBhxk6uXvJy6X1coqvVJG
 3sqmmjeU/UJZv/fGiZK3QOJQvdAQq0uo1ZY7DHX41pQqv325VJ+lKYWXQV5O9GuNVGbPBMaUOi5
 XH5wZS/pF+/b2c3n91KJDLqzFjsoxKhVdpPIIdIRSFzTE5MD/Icudh0k0vYzqH1K04gjw8Dgm3Y
 8umIYlMaCtRh4gPYLfF4oW4/i8WDuUxF8pPFUU3FvqZ1/iqBsPrf8tpZBew2OvHJdZLMxMzqp3s
 Mw7Ix94A/o8xlcX57kyalWnEuvAxZs/VSmBnH0I4cY0vsVI5+Iv0Wmvr1dVHdAsCQJ3gAlDP41T
 akr8cAnbGX+FUTLl1yIxXu52vXlp62jxNypgwh6geSGTBg8MWWPvAr20txFQS5VD/Sz3nGTp9eb
 9zXIxjudhBPoJ7YZE4eeQQsdbFNANMM4XOTcmWRASV7vWlq4e85g==
X-Received: by 2002:a05:600c:8705:b0:456:1a69:94fa with SMTP id
 5b1f17b1804b1-47ee3345cc1mr42227595e9.13.1768429545283; 
 Wed, 14 Jan 2026 14:25:45 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f42907141sm12040355e9.9.2026.01.14.14.25.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 14:25:44 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH 24/29] doc/guides: improve multi-process sample app guide
Date: Wed, 14 Jan 2026 14:22:05 -0800
Message-ID: <20260114222458.87119-25-stephen@networkplumber.org>
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

Improve the multi-process sample application documentation:
- fix section heading levels for consistency
- fix hyphenation of "packet-processing"
- improve grammar and sentence structure
- fix "gets the port information and exported" grammar

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/sample_app_ug/multi_process.rst | 27 +++++++++++-----------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/doc/guides/sample_app_ug/multi_process.rst b/doc/guides/sample_app_ug/multi_process.rst
index 1bd858bfb5..19e49669ad 100644
--- a/doc/guides/sample_app_ug/multi_process.rst
+++ b/doc/guides/sample_app_ug/multi_process.rst
@@ -42,9 +42,10 @@ passing at least two cores in the corelist:
 
     ./<build_dir>/examples/dpdk-simple_mp -l 0-1 --proc-type=primary
 
-For the first DPDK process run, the proc-type flag can be omitted or set to auto,
-since all DPDK processes will default to being a primary instance,
-meaning they have control over the hugepage shared memory regions.
+For the first DPDK process run, the proc-type flag can be omitted or set to auto
+since all DPDK processes will default to being a primary instance
+(meaning, they have control over the hugepage shared memory regions).
+
 The process should start successfully and display a command prompt as follows:
 
 .. code-block:: console
@@ -99,7 +100,7 @@ At any stage, either process can be terminated using the quit command.
     The secondary process can be stopped and restarted without affecting the primary process.
 
 How the Application Works
-^^^^^^^^^^^^^^^^^^^^^^^^^
+~~~~~~~~~~~~~~~~~~~~~~~~~
 
 This application uses two queues and a single memory pool created in the primary process.
 The secondary process then uses lookup functions to attach to these objects.
@@ -124,7 +125,7 @@ Symmetric Multi-process Example
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 The symmetric multi process example demonstrates how a set of processes can run in parallel,
-with each process performing the same set of packet- processing operations.
+with each process performing the same set of packet-processing operations.
 The following diagram shows the data-flow through the application, using two processes.
 
 .. _figure_sym_multi_proc_app:
@@ -173,7 +174,7 @@ Example:
    In the above example, ``auto`` is used so the first instance becomes the primary process.
 
 How the Application Works
-^^^^^^^^^^^^^^^^^^^^^^^^^
+~~~~~~~~~~~~~~~~~~~~~~~~~
 
 The primary instance creates the memory pool and initializes the network ports.
 
@@ -183,7 +184,7 @@ The primary instance creates the memory pool and initializes the network ports.
         :end-before: >8 End of primary instance initialization.
         :dedent: 1
 
-The secondary instance gets the port information and exported by the primary process.
+The secondary instance gets the port information exported by the primary process.
 The memory pool is accessed by doing a lookup for it by name:
 
 .. code-block:: c
@@ -198,7 +199,7 @@ Each process reads from each port using the queue corresponding to its proc-id p
 and writes to the corresponding transmit queue on the output port.
 
 Client-Server Multi-process Example
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+-----------------------------------
 
 The example multi-process application demonstrates a client-server type multi-process design.
 A single server process receives a set of packets from the ports
@@ -216,7 +217,7 @@ The following diagram shows the data-flow through the application, using two cli
 
 
 Running the Application
-^^^^^^^^^^^^^^^^^^^^^^^
+~~~~~~~~~~~~~~~~~~~~~~~
 
 The server process must be run as the primary process to set up all memory structures.
 In addition to the EAL parameters, the application-specific parameters are:
@@ -229,9 +230,9 @@ In addition to the EAL parameters, the application-specific parameters are:
 
 .. note::
 
-   In the server process, has a single thread using the lowest numbered lcore
-   in the corelist, performs all packet I/O.
-   If corelist parameter specifies with more than a single lcore,
+   In the server process, a single thread using the lowest numbered lcore
+   in the corelist performs all packet I/O.
+   If the corelist parameter specifies more than a single lcore,
    an additional lcore will be used for a thread to print packet count periodically.
 
 The server application stores configuration data in shared memory,
@@ -254,7 +255,7 @@ the commands are:
     Any client processes that need restarting can be restarted without affecting the server process.
 
 How the Application Works
-^^^^^^^^^^^^^^^^^^^^^^^^^
+~~~~~~~~~~~~~~~~~~~~~~~~~
 
 The server (primary) process performs the initialization of network port and data structure
 and stores its port configuration data in a memory zone in hugepage shared memory.
-- 
2.51.0

