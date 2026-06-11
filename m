Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AADACCD98C7
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 21:21:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DD3FF433C0;
	Thu, 11 Jun 2026 23:21:27 +0200 (CEST)
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175]) by mails.dpdk.org (Postfix) with ESMTP id 79EE84025F
 for <dev@dpdk.org>; Thu, 11 Jun 2026 23:21:25 +0200 (CEST)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-3074adb8fcaso906034eec.0
 for <dev@dpdk.org>; Thu, 11 Jun 2026 14:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781212884;
 x=1781817684; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QIS4GLdkDOoRC7bYXQddOnpjLiz0oSIWtAlCfbFFWlk=;
 b=xlJuDQ7c/Dx7jr6kigKZ5xgl70OmGiHYlf+Gm15khBSMEMKGYhgVkmM/OpsH0Yrc6s
 Fqxph/KM1XwcmTfqWrbt7Jhyn8BgDDy5HUQcP8KI3jf+CvzwP9J5t080symhwzNCsiJk
 KW/8lBhkAAxnG4qZA1pWwiltqbFBMYBr92+8EuXdBCHGSAKEK3SQCVUZ3t2zTeyy4vMg
 XsAkW2gmVfOS7pKnU5yp0jVE91ZZ2prUCKYuz3Z+vz16gsrrAk7uoLeO3tuCC/sAkJDv
 ab0F/lTG+3N8D+OTXMeOTaTIFWntQMNud1xB8bjkQRTdcdqfIEK/8VcVTTckRbj0bNEF
 wJhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781212884; x=1781817684;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QIS4GLdkDOoRC7bYXQddOnpjLiz0oSIWtAlCfbFFWlk=;
 b=JpLbLjFuKA55BxXxoY6zjG3CfW6EIQPARqUQTQT4eXhyCkJI8XBwREz1+YH7s8hPXS
 Ish0TUtJt6RM9d6QajCiM/lcOUhUhQZ731wLBFPB6eBPZuxEY2I+jfmNNPr/Hoz0hnKp
 1qLarGvdlAY2i3XsSdGlj+6zZatBHProGz5eJjsPEl2frsB9/6FyyGhvAbax9ZDwfLMc
 1OmniPXC3P/F733byHeappQDkMpB/I89ZwQgjWNXDIQOO4CIq6Ga+pkYHZggQp7Y8q1z
 YHNlLgCGq5Va408WrgTDYt5ZM4ZyvP53E9MzBE3luS5T21NnsznQaWwZKyCLDyOgb8IM
 JNhQ==
X-Gm-Message-State: AOJu0YxAraERp/rcgFtgQvzk/mViCO+TbtqkSzw70uh33MNH+dHUGoxR
 +As77E4yRS5PDI8Zqhh1QUkcbRE4A3SO4tk5NcTxyYefBa1ciWeJFOMahxu5lyKizjYDnJWHF8m
 nsPV2
X-Gm-Gg: Acq92OGCuulFpUqvCRWtiQKK+hgemwpFuc1ypSbHQfrKKdtsgrUq+0DfXQo/KxHGXVF
 MkDXRtzGv8y85isQMc2qFq5Uxivj0Z9eek/ZKISFfHRROCgGjyffBqQcfkzrrAq/WWTiEFhuGsr
 j5QRYPe6Kbfqy8GW18kJXhYuE8N9vdyGLhdyRinv9uu3cwbEgWRUj38al4BwgXrokQ71uzh6MhT
 IqmpTEQcQyc9xCCCy7k4aWhCT8YNt/vgPoSIqjIUeu+/Eh1n8OwHDaCvEJB9JaTLqAkbiOT8So5
 82+FYLnwCE3495wsSc7DJSZrw+ygt/um9clSTn6/9YBATxa9POtNCKtZuV15Hkt4Z/YHmLXtikE
 p5RHcfPqKYN8Xd+iZO3gCz+bY5pFIlL1FnnlRwj6Kc52DctornWaQ2+Spnm/VOIpR5yL6+r50PS
 d68f9nYkAyz9CMexOxxBW4+K+3LQfiJvVd0sVwW/KC2ugO7yLsOJuM5b4vANe/Lw==
X-Received: by 2002:a05:7300:2148:b0:2f5:5dd3:1fcf with SMTP id
 5a478bee46e88-3081ff97b78mr40960eec.10.1781212884326; 
 Thu, 11 Jun 2026 14:21:24 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081eb95450sm546238eec.28.2026.06.11.14.21.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 14:21:23 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 02/15] doc: cleanup cmd_line example documentation
Date: Thu, 11 Jun 2026 14:18:41 -0700
Message-ID: <20260611212119.1026721-3-stephen@networkplumber.org>
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

Semi-automated review of sample application for cmd_line.

Enhanced the command line sample application guide:
- Simplified the production code warning note for clarity
- Converted command descriptions to definition list format
- Fixed typo in "Ethernet Address Token" description
- Clarified the parsing and callback mechanism description
- Improved overall readability and consistency

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/sample_app_ug/cmd_line.rst | 35 +++++++++++++++------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/doc/guides/sample_app_ug/cmd_line.rst b/doc/guides/sample_app_ug/cmd_line.rst
index e038667bd5..5b192bc615 100644
--- a/doc/guides/sample_app_ug/cmd_line.rst
+++ b/doc/guides/sample_app_ug/cmd_line.rst
@@ -13,29 +13,32 @@ Overview
 The Command Line sample application is a simple application that
 demonstrates the use of the command line interface in the DPDK.
 This application is a readline-like interface that can be used
-to debug a DPDK application in a Linux* application environment.
+to debug DPDK applications in a Linux application environment.
 
 .. note::
 
     The rte_cmdline library should not be used in production code since
     it is not validated to the same standard as other DPDK libraries.
-    See also the "rte_cmdline library should not be used in production code due to limited testing" item
-    in the "Known Issues" section of the Release Notes.
+    See also the Known Issues section of the Release Notes for the item
+    regarding limited testing of the rte_cmdline library.
 
 The Command Line sample application supports some of the features of the GNU readline library
 such as completion, cut/paste and other special bindings
-that make configuration and debug faster and easier.
+that make configuration and debugging faster and easier.
 
-The application shows how the ``cmdline`` library can be extended
+The application demonstrates how the ``cmdline`` library can be extended
 to handle a list of objects.
 
 There are three simple commands:
 
-*   add obj_name IP: Add a new object with an IP/IPv6 address associated to it.
+``add obj_name IP``
+   Add a new object with an IP/IPv6 address associated with it.
 
-*   del obj_name: Delete the specified object.
+``del obj_name``
+   Delete the specified object.
 
-*   show obj_name: Show the IP associated with the specified object.
+``show obj_name``
+   Show the IP associated with the specified object.
 
 .. note::
 
@@ -63,7 +66,7 @@ and the Environment Abstraction Layer (EAL) options.
 Explanation
 -----------
 
-The following sections provide explanation of the code.
+The following sections provide an explanation of the code.
 
 EAL Initialization and cmdline Start
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -84,7 +87,7 @@ Then, a new command line object is created and starts to interact with the user
     :end-before: >8 End of creating a new command line object.
     :dedent: 1
 
-The ``cmdline_interact()`` function returns when the user types **Ctrl-d** and,
+The ``cmdline_interact()`` function returns when the user types **Ctrl-d**, and
 in this case, the application exits.
 
 Defining a cmdline Context
@@ -102,15 +105,15 @@ Each command (of type cmdline_parse_inst_t) is defined statically.
 It contains a pointer to a callback function that is executed when the command is parsed,
 an opaque pointer, a help string and a list of tokens in a NULL-terminated table.
 
-The rte_cmdline application provides a list of pre-defined token types:
+The rte_cmdline library provides a list of predefined token types:
 
-*   String Token: Match a static string, a list of static strings or any string.
+*   String Token: Match a static string, a list of static strings, or any string.
 
-*   Number Token: Match a number that can be signed or unsigned, from 8-bit to 32-bit.
+*   Number Token: Match a number that can be signed or unsigned, from 8 bits to 32 bits.
 
 *   IP Address Token: Match an IPv4 or IPv6 address or network.
 
-*   Ethernet* Address Token: Match a MAC address.
+*   Ethernet Address Token: Match a MAC address.
 
 In this example, a new token type obj_list is defined and implemented
 in the parse_obj_list.c and parse_obj_list.h files.
@@ -128,5 +131,5 @@ This command is composed of two tokens:
 
 *   The second token is an object that was previously added using the add command in the global_obj_list variable.
 
-Once the command is parsed, the rte_cmdline application fills a cmd_obj_del_show_result structure.
-A pointer to this structure is given as an argument to the callback function and can be used in the body of this function.
+Once the command is parsed, the rte_cmdline library fills a cmd_obj_del_show_result structure
+and passes a pointer to it as an argument to the callback function.
-- 
2.53.0

