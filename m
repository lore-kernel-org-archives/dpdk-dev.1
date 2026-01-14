Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00AC7D3CC86
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 22:25:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 69E2240ED0;
	Wed, 14 Jan 2026 23:25:15 +0100 (CET)
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
 [209.85.128.67]) by mails.dpdk.org (Postfix) with ESMTP id 28E4D40E4F
 for <dev@dpdk.org>; Wed, 14 Jan 2026 23:25:14 +0100 (CET)
Received: by mail-wm1-f67.google.com with SMTP id
 5b1f17b1804b1-47d5e021a53so2355025e9.3
 for <dev@dpdk.org>; Wed, 14 Jan 2026 14:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768429514;
 x=1769034314; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5R11+nBLcUHkxTD36Ny677WyNcXMA2/+22wTc8ZU9Dk=;
 b=a67UfsLUZJbZuX0WeDK/C2899ImiH6ppo9ctpHkN7+w96PEgbg0UhWr66v0nIIpuGz
 +vv/0opyaQ+h0oIp/oj3gWDQSDrYiJnC+oOWJqcdSxJhEo1SPK/04MBiaXRD1RwojsWA
 GBJ9Qd1rqPmxCJ6iA2bQhKwLJzKBVdoVHbIC2fdZoxUPNOYo0jFpGfGNl/6pFXqRa8fc
 2gDutBiwCa3QXGIvUu04+07JXIYhIswgAqgbqZrL8UYTT5jUDpFC13i2p7jEAcE7k7V2
 TM69/QjLlEPEAYqf4dEzt3Lxtdnli+x1c4g3ONAanmjal2HG3puKB8XvUSBnCU6s7iDg
 c7kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768429514; x=1769034314;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5R11+nBLcUHkxTD36Ny677WyNcXMA2/+22wTc8ZU9Dk=;
 b=LYjMIMZZDBTljIQMmakUDLTh8yah/lLD1XZpEL7wA6VhJXL91Phe8K3EK9RmKiEAmB
 7qww5054ZExNRgKT0KxK384EVpoEBrjiod/In9T457feF7yuytcXJbSycrngk2mTrwle
 DF6NDPcdYb0T3T2dZNymBPFlXDjcLQUWwLQ0tWRTfVxYFnShSPuP65ldFBixlAtnzv7W
 4IP6TKp+kjRGc5Um1waJ5qy7bglYaiCKgewYSe2Ivrwu6Ebo4b1kin3+iR7ipnJ0XKhl
 1q9EcDaTFhquTSpcrc/+4+nzbuObmiabUPO9Gidm2bBPtzXpfqjgGSDgSX+sUR2cUUKc
 HVVw==
X-Gm-Message-State: AOJu0YzmfbkU/+082+i5eysQDQ4xl5uXcsRs+ps7p/+Dz9os9pW5bh21
 Fpyod8TmngcK9BNSsTnORBgAVfmMg8UsohL9q5Lx3BQmK5gsCUXMBj4pIAyc4EKyoJc/D6repFr
 ameT3fK8=
X-Gm-Gg: AY/fxX6FV9YKfcp+/OnAO7BjH8Qu7c+FcfZBxdQieh6dckvHZ5uPiti6XABcSvG6X/U
 W6bKyYRfxXG9qbAMS/dau20rWkYL1Upv5+Gg5EUi1pRM/l/6kI3ICfZ/VlX3WJL+E/zFuO1wbN9
 s+Pwr53md8OvMCfUjgnnIwUgdb4t7notbqEWTQRMcqtPJKulqc7ePIMJ/gWYxBvCNYOoRh/aaco
 CSpUiwgU3/xGArLnoob4iYD9G/Z0OJBvHxgdO4E+mShPUUUqRqM229skIvRkQrJsrjBSQvoL7FD
 KnmfYR1n+ZzsoUPjp23vjM7OPif90npGCSA9BQC+3l8HX/ccn6QbpvpScuYvMocBr6cJT+GRCns
 vvTGXIHBSF3cncfKlio9hZhsnSGpz6QBb2ca0DKyJP/60PQ6LXaFAKu7yR5ApGQkz+w54iDC9Yh
 Qqho0G+7clyYuqCRE9C4tyacZP1aFD00zUN8x/ACLKhnKnB4BcaQ==
X-Received: by 2002:a05:600c:5248:b0:477:63b5:6f76 with SMTP id
 5b1f17b1804b1-47ee4825eb3mr44167145e9.25.1768429513514; 
 Wed, 14 Jan 2026 14:25:13 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f42907141sm12040355e9.9.2026.01.14.14.25.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 14:25:13 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 06/29] examples/eventdev_pipeline: correct documentation errors
Date: Wed, 14 Jan 2026 14:21:47 -0800
Message-ID: <20260114222458.87119-7-stephen@networkplumber.org>
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

Address minor issues in eventdev pipeline sample documentation:
- Add missing word: "various numbers worker cores" to
  "various numbers of worker cores"
- Correct punctuation: "(e.g.;" to "(e.g.,"

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 .../sample_app_ug/eventdev_pipeline.rst       | 22 +++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/doc/guides/sample_app_ug/eventdev_pipeline.rst b/doc/guides/sample_app_ug/eventdev_pipeline.rst
index 19ff53803e..c243fa5160 100644
--- a/doc/guides/sample_app_ug/eventdev_pipeline.rst
+++ b/doc/guides/sample_app_ug/eventdev_pipeline.rst
@@ -10,7 +10,7 @@ application can configure a pipeline and assign a set of worker cores to
 perform the processing required.
 
 The application has a range of command line arguments allowing it to be
-configured for various numbers worker cores, stages,queue depths and cycles per
+configured for various numbers of worker cores, stages, queue depths and cycles per
 stage of work. This is useful for performance testing as well as quickly testing
 a particular pipeline configuration.
 
@@ -18,7 +18,7 @@ a particular pipeline configuration.
 Compiling the Application
 -------------------------
 
-To compile the sample application see :doc:`compiling`.
+To compile the sample application, see :doc:`compiling`.
 
 The application is located in the ``examples`` sub-directory.
 
@@ -51,7 +51,7 @@ these settings is shown below:
     -- -r1 -t1 -e4 -w FF00 -s4 -n0 -c32 -W1000 -D
 
 The application has some sanity checking built-in, so if there is a function
-(e.g.; the RX core) which doesn't have a cpu core mask assigned, the application
+(e.g., the RX core) which doesn't have a cpu core mask assigned, the application
 will print an error message:
 
 .. code-block:: console
@@ -61,21 +61,21 @@ will print an error message:
           rx: 0
           tx: 1
 
-Configuration of the eventdev is covered in detail in the programmers guide,
-see the Event Device Library section.
+Configuration of the eventdev is covered in detail in the programmers guide.
+See the Event Device Library section.
 
 
 Observing the Application
--------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~
 
-At runtime the eventdev pipeline application prints out a summary of the
-configuration, and some runtime statistics like packets per second. On exit the
+At runtime, the eventdev pipeline application prints out a summary of the
+configuration, and some runtime statistics like packets per second. On exit, the
 worker statistics are printed, along with a full dump of the PMD statistics if
 required. The following sections show sample output for each of the output
 types.
 
 Configuration
-~~~~~~~~~~~~~
+^^^^^^^^^^^^^
 
 This provides an overview of the pipeline,
 scheduling type at each stage, and parameters to options such as how many
@@ -101,7 +101,7 @@ for details:
         Stage 3, Type Atomic    Priority = 128
 
 Runtime
-~~~~~~~
+^^^^^^^
 
 At runtime, the statistics of the consumer are printed, stating the number of
 packets received, runtime in milliseconds, average mpps, and current mpps.
@@ -111,7 +111,7 @@ packets received, runtime in milliseconds, average mpps, and current mpps.
   # consumer RX= xxxxxxx, time yyyy ms, avg z.zzz mpps [current w.www mpps]
 
 Shutdown
-~~~~~~~~
+^^^^^^^^
 
 At shutdown, the application prints the number of packets received and
 transmitted, and an overview of the distribution of work across worker cores.
-- 
2.51.0

