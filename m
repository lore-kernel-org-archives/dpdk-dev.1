Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D39E8C9832F
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Jan 2026 19:13:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AAD8940684;
	Sun, 18 Jan 2026 20:13:38 +0100 (CET)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com
 [209.85.218.47]) by mails.dpdk.org (Postfix) with ESMTP id E4040406BA
 for <dev@dpdk.org>; Sun, 18 Jan 2026 20:13:35 +0100 (CET)
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-b870732cce2so554591266b.3
 for <dev@dpdk.org>; Sun, 18 Jan 2026 11:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768763615;
 x=1769368415; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WNyUkCMe9MZzwrstbShxbdJ4CyXmJCX9c8DBPjb/O84=;
 b=hwPzaBxRO06lEhPCIDTVmB/h6rIeeXgz8oi909uUXDL6IgqpCmnBBzLQRlOV7Ooyv1
 sJikCmupEqksr3bQl/iwOTVw0bvho7zJrx4mf6PHs/W+wWWcmCY18vDav8cTl9GymM2Y
 1tLS7TYIOMSzwaPOisiqFvHB8bD/IHs5znichJg/A2Z7mLTEGkzaStreizxDF1iBf0ZD
 GVzyMRQT/UjFC1VEojD+AEXOKjPKTRlfwlB/jmNkMZseLMX1gljePJTVMoQaiWabcVV5
 ftZsVo+t6Yucxu7hl3nmShuXX9G428KBLXHdwsMBjhf3cMsyP2Qfa1eynED/2yCjzUrL
 aX0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768763615; x=1769368415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WNyUkCMe9MZzwrstbShxbdJ4CyXmJCX9c8DBPjb/O84=;
 b=F1MlP9uCRzPAew54OWQQVj3/UecXcrZecXdh9QZZKo0VyCAvnStuYyT3UASj4fvGQg
 QrknG/IcQLUbYViMgosnaB0bPlpjpZNTS9MqO02sdbcYvTBbfnXSieTcgl5iGaB8ERR6
 1tI0AMKEVlDK/V3Rw21PuOavtZx/7WOuJfXHzXv10r6OBMHlu1DFZlw6IhLmFsXpSLJM
 aIW4Je1ifBEQOyQ6N3ltb5ep8IFM+dpkN/9dkPWY6R+t2gFMyaU3ARjOQo6WXvzIAp+j
 PZ9fTqBCuahRYIQbQBt5Ujd5BVywRSseAom+7U6iJtzWN22Maz23aHJS3m7jiSPA3wJ8
 rsGQ==
X-Gm-Message-State: AOJu0YwPfX9Otd8mzY+4o0Jxtu9nmgf2fiT9qIFS/i/x3zwj6AI7i7AR
 LTNJ9wYZYj3N1gfi5HKdr9csoqJYos2wYIJ4JgQE2igQEXdlL9+JG31RZa89IDzI0HfjbqmfsTU
 GjHVg
X-Gm-Gg: AY/fxX5MfQHjiOVoYvenWZO2/VY7UbeYQ+Jmbgj5WMfY+oX8u94oe3WHbOG9WCBrGKM
 otvpDRc7XWYOdbydiKDRD6gzEpoVKT2zDhO05/cfmjiNIA3AMuQ849kLVYvftyARFEiGGXOVAVc
 kpjdwt2chuC3+h+K/oFhL8HY4nW1+FgrhB+KyuFJWMHEHNT8p50hObGFo8X9AA3v56JbvxzxO9v
 ain7v72aj9sXUi8yvEdtiyO0OahjcgXtWNYd4edxAQioTH24lAMagEZSdxzl3mCvuWTvvHbaAb1
 pa6rJ171Hq5qCLi3yzUuOR+d9EJmeOoyGHGX8k5JH9pZiPSvmsVXuuLP7r0K55M4u9irhwyS6n3
 p7XxJB2fVagsavASt+45DirjU8CqKCwUY9t3pQ09WGXwcBFQNOKrgO7/blFQjRr5wPmOvPraRVu
 w3TI0+5DTHLIvXOHMhlamoSiKqz+Arvvv1VTaJfkzXM2yfSOCcfQ==
X-Received: by 2002:a17:907:868f:b0:b76:8164:88b5 with SMTP id
 a640c23a62f3a-b8796b40ddbmr658985466b.46.1768763615287; 
 Sun, 18 Jan 2026 11:13:35 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87959c9f8dsm886287166b.36.2026.01.18.11.13.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 11:13:34 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nandini Persad <nandinipersad361@gmail.com>
Subject: [PATCH v5 04/54] doc: correct typos in log library guide
Date: Sun, 18 Jan 2026 11:10:07 -0800
Message-ID: <20260118191323.241013-5-stephen@networkplumber.org>
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

Changes:
- Change spelling errors (stystem -> system, acheived -> achieved)
- Change sentence structure for rte_log() parameter description
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

