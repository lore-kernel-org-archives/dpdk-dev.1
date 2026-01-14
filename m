Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1049D3CC86
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 22:29:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B7CC941132;
	Wed, 14 Jan 2026 23:28:42 +0100 (CET)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id 78B6B42797
 for <dev@dpdk.org>; Wed, 14 Jan 2026 23:28:41 +0100 (CET)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-477a2ab455fso3356645e9.3
 for <dev@dpdk.org>; Wed, 14 Jan 2026 14:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768429721;
 x=1769034521; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ix5z1FPIKUBGt71tovFfgMnYXuw07vmulO/sIjGh1ik=;
 b=vT/zjcgxcCncqisff9N0PmqzLoqtB7EDg88juLDcmjRFINGT3kcL5wR4wr6z2AuEdB
 zLdN7Yn8mnKj7AC4mGNWqgTid44p3uSGKsiT7BfKm5T1GkFABVh90HB1MPrHBP2+GvdK
 U7cuzqpemXiflkl7uK3/3FHQUCytMHJSXHVJTXn94u0/kXUj6t7WNsRW4EI/eczs73GP
 B/8546mU4pESRlm9PGVQKjZdTXlBhMh3JE327Vo+K3B9gIA3/Ro8noJFtOTJPWI6vkgu
 tY2ywTK1urDWRYzzMv6DG1D8P9ouF7kd9VJRaq0PDa4bvOX4I3vMOxa99MxoVzYZyo9y
 OHFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768429721; x=1769034521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ix5z1FPIKUBGt71tovFfgMnYXuw07vmulO/sIjGh1ik=;
 b=AEcRsH6nTIh+D4f0FrCiXF1sv3yVkwENvnOordWGbZ5pDOTE7F5VgDia6UFCeBvqkf
 UMtb2BVc4wqtqCA1bCnnlCgbsmVw/Y3ekpBQatD/ZUMe+wNfX+NCklmGP126Qebt0eh+
 e1pSQ+4G/bbjnDERXu46sdulqtLS8U86dSKaf1kgZcmk9jNfbr29VR/NYvuSq8AOtBMp
 jSs5cBGkRVcOyFGqORaRDBIZaePxKiH84YgUa4wkpXHx3xSZ2cHQqZ2Oa0n0J7uhPKmo
 iRDyflksnddkkV6suFW7M3/VxYYHQGzpz+IzDuni6nj6ux0aNvHrxa+O+35AL3XWSy7A
 jN7w==
X-Gm-Message-State: AOJu0YwFpHMPGaRtjgkEq520e10RCpGnhXZG86I4vdmBcyi48UzEHjz7
 zfK7mnq45bsDgwSbG+CAU17QdxjwXpHaqFfxxDPCjhOuPpcd/cdrP+rDoAmw2x6ROyLAreyitTg
 EvfTU
X-Gm-Gg: AY/fxX7QCoG8fRkW/vDWAE1je/ISXlq6Ru8wA4FZzEL0lF4i4Vw+IfczZPR15z9ZNRy
 BdDivphydFgSYEUZpELR8zAO2VqRa73ScGTFUme3WnNwMOcS75LkVMpKnUyjgDZttUt66jzx054
 8UyDrc0NWy5Py1B6UjYcBNtV3BpeXzPNGALRSv47prFZgXiU43PpCsIYB3jcYgcK1wiVsbEbL7M
 IjRfYpeYNaZY/nj15CKBVR9FVs8nZZunBTKHFnw0os64jhFdFszDB8SpvLuJbrV+D5vG/PbxTa5
 +f6LiVEa4CWmhlJQRU4RjsROo5sPUSXQjcpp38tLFSBJ8YMgz3pYugKeW0kHXOHqtCK5uv5C0NF
 5lEgqIX2npf7ueLjzko2++YhGzpYt/Tcp55ZtUUjVaoj8BUa/PKsuxLxfCugIZ3f6O5OgB/o+IM
 PnZ+aJy2pJJ+1ohBeHD5dSEjlUUeNjfJHlpubV2lTslYUivBaXvg==
X-Received: by 2002:a05:600c:35c6:b0:47d:900e:c646 with SMTP id
 5b1f17b1804b1-47ee32e9818mr62598635e9.8.1768429721023; 
 Wed, 14 Jan 2026 14:28:41 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-434af653632sm1757198f8f.11.2026.01.14.14.28.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 14:28:40 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nandini Persad <nandinipersad361@gmail.com>
Subject: [PATCH v4 07/11] doc: correct typos in log library guide
Date: Wed, 14 Jan 2026 14:26:59 -0800
Message-ID: <20260114222821.87920-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114222821.87920-1-stephen@networkplumber.org>
References: <20240513155911.31872-1-nandinipersad361@gmail.com>
 <20260114222821.87920-1-stephen@networkplumber.org>
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

Changes:
- Fix spelling errors (stystem -> system, acheived -> achieved)
- Fix sentence structure for rte_log() parameter description
- Use consistent spelling "timestamp" (one word)

Signed-off-by: Nandini Persad <nandinipersad361@gmail.com>
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/prog_guide/log_lib.rst | 32 +++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/doc/guides/prog_guide/log_lib.rst b/doc/guides/prog_guide/log_lib.rst
index 3e888b8965..a3d6104e72 100644
--- a/doc/guides/prog_guide/log_lib.rst
+++ b/doc/guides/prog_guide/log_lib.rst
@@ -6,7 +6,7 @@ Log Library
 
 The DPDK Log library provides the logging functionality for other DPDK libraries and drivers.
 By default, logs are sent only to standard error output of the process.
-The syslog EAL option can be used to redirect to the stystem logger on Linux and FreeBSD.
+The syslog EAL option can be used to redirect to the system logger on Linux and FreeBSD.
 In addition, the log can be redirected to a different stdio file stream.
 
 Log Levels
@@ -26,14 +26,14 @@ These levels, specified in ``rte_log.h`` are (from most to least important):
 
 At runtime, only messages of a configured level or above (i.e. of higher importance)
 will be emitted by the application to the log output.
-That level can be configured either by the application calling the relevant APIs from the logging library,
+That level can be configured either by the application calling relevant APIs from the logging library,
 or by the user passing the ``--log-level`` parameter to the EAL via the application.
 
 Setting Global Log Level
 ~~~~~~~~~~~~~~~~~~~~~~~~
 
 To adjust the global log level for an application,
-just pass a numeric level or a level name to the ``--log-level`` EAL parameter.
+pass a numeric level or a level name to the ``--log-level`` EAL parameter.
 For example::
 
 	/path/to/app --log-level=error
@@ -47,9 +47,9 @@ Within an application, the log level can be similarly set using the ``rte_log_se
 Setting Log Level for a Component
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-In some cases, for example, for debugging purposes,
-it may be desirable to increase or decrease the log level for only a specific component, or set of components.
-To facilitate this, the ``--log-level`` argument also accepts an, optionally wildcarded, component name,
+In some cases (such as debugging purposes),
+you may want to increase or decrease the log level for only a specific component or set of components.
+To facilitate this, the ``--log-level`` argument also accepts an optionally wildcarded component name,
 along with the desired level for that component.
 For example::
 
@@ -57,13 +57,13 @@ For example::
 
 	/path/to/app --log-level=lib.*:warning
 
-Within an application, the same result can be got using the ``rte_log_set_level_pattern()`` or ``rte_log_set_level_regex()`` APIs.
+Within an application, the same result can be achieved by using the ``rte_log_set_level_pattern()`` or ``rte_log_set_level_regex()`` APIs.
 
 
 Using Logging APIs to Generate Log Messages
 -------------------------------------------
 
-To output log messages, ``rte_log()`` API function should be used.
+To output log messages, the ``rte_log()`` API function should be used.
 As well as the log message, ``rte_log()`` takes two additional parameters:
 
 * The log level
@@ -74,16 +74,16 @@ The component type is a unique id that identifies the particular DPDK component
 To get this id, each component needs to register itself at startup,
 using the macro ``RTE_LOG_REGISTER_DEFAULT``.
 This macro takes two parameters, with the second being the default log level for the component.
-The first parameter, called "type", the name of the "logtype", or "component type" variable used in the component.
-This variable will be defined by the macro, and should be passed as the second parameter in calls to ``rte_log()``.
+The first parameter, called "type", is the name of the "logtype", or "component type" variable used in the component.
+This variable will be defined by the macro and should be passed as the second parameter in calls to ``rte_log()``.
 In general, most DPDK components define their own logging macros to simplify the calls to the log APIs.
 They do this by:
 
 * Hiding the component type parameter inside the macro so it never needs to be passed explicitly.
 * Using the log-level definitions given in ``rte_log.h`` to allow short textual names to be used in
-  place of the numeric log levels.
+  place of numeric log levels.
 
-The following code is taken from ``rte_cfgfile.c`` and shows the log registration,
+The following code is taken from ``rte_cfgfile.c`` and shows the log registration
 and subsequent definition of a shortcut logging macro.
 It can be used as a template for any new components using DPDK logging.
 
@@ -98,10 +98,10 @@ It can be used as a template for any new components using DPDK logging.
 	it should be placed near the top of the C file using it.
 	If not, the logtype variable should be defined as an "extern int" near the top of the file.
 
-	Similarly, if logging is to be done by multiple files in a component,
-	only one file should register the logtype via the macro,
+	Similarly, if logging will be done by multiple files in a component,
+	only one file should register the logtype via the macro
 	and the logtype should be defined as an "extern int" in a common header file.
-	Any component-specific logging macro should similarly be defined in that header.
+	Any component-specific logging macro should be similarly defined in that header.
 
 Throughout the cfgfile library, all logging calls are therefore of the form:
 
@@ -122,7 +122,7 @@ For example::
 
 Multiple alternative timestamp formats are available:
 
-.. csv-table:: Log time stamp format
+.. csv-table:: Log timestamp format
    :header: "Format", "Description", "Example"
    :widths: 6, 30, 32
 
-- 
2.51.0

