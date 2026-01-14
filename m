Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292A7D3CC86
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 22:26:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0AA93410FC;
	Wed, 14 Jan 2026 23:25:31 +0100 (CET)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52]) by mails.dpdk.org (Postfix) with ESMTP id 60F92410D4
 for <dev@dpdk.org>; Wed, 14 Jan 2026 23:25:29 +0100 (CET)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-47796a837c7so1877815e9.0
 for <dev@dpdk.org>; Wed, 14 Jan 2026 14:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768429529;
 x=1769034329; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eXb/JIfjGJE9bdvuQLoNpu+eSJuB0XURAJV/m48HEd8=;
 b=tz4asxhjcpaDsL1cuU0CbVMMIjBasXU7cjh/hZiYnNC9ZQLmI21LV0YNaq2FLRNVci
 hLnBK/GlB+QhB9QL3Vk5CwTF48/A5MFH3D4ZG5TaCFP1A9rX2uCSmhf48vYVFKC5JrcF
 k87JcBYpyx80lXprZ9ZFTvMcAhdfYWOXO3sRJE8qUSO8q0nIt665bjw7EDno9/wnymlG
 +ZCF/+9QOUJSS2lNBvSCqeKmkvca1G8pGvKemVsCHU40TsLdMplD3nuQYtRwSOM3WIXX
 +yiyHYO8bvx9YfMdmHlcpYo42UvAp3dHhQeKetpUjcrsBOakpQlevO/L7F1mI2fn4DpV
 M7zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768429529; x=1769034329;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eXb/JIfjGJE9bdvuQLoNpu+eSJuB0XURAJV/m48HEd8=;
 b=JlEvuUlTrGBqaIGqolhbo1fY2DmQprD7T2XDNpnxKtJsY7glPE5snMRewsD91GCooy
 tqlY4EmT3ThGZjizCot0K1QoI17JJTmOPLu5GSpPUpBDrGDYQRU817PUgvo6X673HYhi
 je4FcXH/QsqDlx1XHgJqI+xj8r5du81gUhGxyHtt14Z4g3jrhPn7QUMcuphrFDGaPWCz
 T4SeAVErLouL7+Wy4R2L50ScbpmtI7JUtg6h4T0g8x5uk+yIl80TfELyHPe0ls2asnYf
 vfgT1GlcCohKnVhIOBrgNRr/No0nNerY7+DGYuWxa9vf7bltf94aPq4tzILyXFZfg/I1
 XDAw==
X-Gm-Message-State: AOJu0YxOof09Qlsi8Xk5fWhjMtac5TUZWW9rx1lxAZG5GJuVzzY5pUzZ
 Z1FeRHMHX5++7TKM1Q26uwYycGxp0mRVcU/X3C/6J/u4l1bIAwzigRH+TDiVUMMt6VY6SdyJ5kd
 2P+fY
X-Gm-Gg: AY/fxX7j3oQbalHSPRP5rtV7jFE2NcHJRhpesJUzzPT/CKavCdZKtqKGpe0TcZGm/fp
 A8cBrlv6aucfdtvTIK+g2eZmqoSdPT3MpfU93S09GZ7jpTAll/PjDU2LrlS/IrV6DtBff/xJM3u
 L2HK8Y9LZ0BCytiT/EQqQ13S5DCWuj4IbCaBk3SNsk7IiQhteFJ6K3hJAf/B6+Me2iRpwsDH/BV
 IoWtiAulgxY2hP3Eg7IwoA1gqKJ3RUneeRRPwDobUxYuLdiQ/odDEXML3TGEr6SofItmM5Tm8lc
 DGKaPqOupFvEOKXYwv7Tc0keSS5Ku7tBFe2jJD2+LS76GQvK/hFlX7scv/nWuilgC4xhlw/eTVr
 f1xOrQZxF8ePEAobF/p7GssGpUPKlxICQSl2UuBPnYgRSg2H0jC1kcpxCiY99436HGCKNKByRPh
 1aXkVCNHkc6vFw/pxHs4hESf6X039ovkmGPDFPYiiEiLQP9RwMHg==
X-Received: by 2002:a05:600c:c0ca:b0:47e:e4ff:e2ac with SMTP id
 5b1f17b1804b1-47ee4ffe4d4mr27980025e9.33.1768429528981; 
 Wed, 14 Jan 2026 14:25:28 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f42907141sm12040355e9.9.2026.01.14.14.25.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 14:25:28 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 15/29] doc/guides: improve command line sample app guide
Date: Wed, 14 Jan 2026 14:21:56 -0800
Message-ID: <20260114222458.87119-16-stephen@networkplumber.org>
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

Improve the command line sample application documentation:
- remove trademark asterisks from Linux and Ethernet
- use code formatting for command examples
- add Oxford commas and fix punctuation
- add missing articles

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/sample_app_ug/cmd_line.rst | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/doc/guides/sample_app_ug/cmd_line.rst b/doc/guides/sample_app_ug/cmd_line.rst
index e038667bd5..f2e506f8f1 100644
--- a/doc/guides/sample_app_ug/cmd_line.rst
+++ b/doc/guides/sample_app_ug/cmd_line.rst
@@ -13,7 +13,7 @@ Overview
 The Command Line sample application is a simple application that
 demonstrates the use of the command line interface in the DPDK.
 This application is a readline-like interface that can be used
-to debug a DPDK application in a Linux* application environment.
+to debug a DPDK application in a Linux application environment.
 
 .. note::
 
@@ -23,7 +23,7 @@ to debug a DPDK application in a Linux* application environment.
     in the "Known Issues" section of the Release Notes.
 
 The Command Line sample application supports some of the features of the GNU readline library
-such as completion, cut/paste and other special bindings
+such as completion, cut/paste, and other special bindings
 that make configuration and debug faster and easier.
 
 The application shows how the ``cmdline`` library can be extended
@@ -31,11 +31,11 @@ to handle a list of objects.
 
 There are three simple commands:
 
-*   add obj_name IP: Add a new object with an IP/IPv6 address associated to it.
+*   ``add obj_name IP``: Add a new object with an IP/IPv6 address associated to it.
 
-*   del obj_name: Delete the specified object.
+*   ``del obj_name``: Delete the specified object.
 
-*   show obj_name: Show the IP associated with the specified object.
+*   ``show obj_name``: Show the IP associated with the specified object.
 
 .. note::
 
@@ -44,7 +44,7 @@ There are three simple commands:
 Compiling the Application
 -------------------------
 
-To compile the sample application see :doc:`compiling`
+To compile the sample application, see :doc:`compiling`.
 
 The application is located in the ``cmd_line`` sub-directory.
 
@@ -63,7 +63,7 @@ and the Environment Abstraction Layer (EAL) options.
 Explanation
 -----------
 
-The following sections provide explanation of the code.
+The following sections provide an explanation of the code.
 
 EAL Initialization and cmdline Start
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -100,17 +100,17 @@ For example:
 
 Each command (of type cmdline_parse_inst_t) is defined statically.
 It contains a pointer to a callback function that is executed when the command is parsed,
-an opaque pointer, a help string and a list of tokens in a NULL-terminated table.
+an opaque pointer, a help string, and a list of tokens in a NULL-terminated table.
 
 The rte_cmdline application provides a list of pre-defined token types:
 
-*   String Token: Match a static string, a list of static strings or any string.
+*   String Token: Match a static string, a list of static strings, or any string.
 
 *   Number Token: Match a number that can be signed or unsigned, from 8-bit to 32-bit.
 
 *   IP Address Token: Match an IPv4 or IPv6 address or network.
 
-*   Ethernet* Address Token: Match a MAC address.
+*   Ethernet Address Token: Match a MAC address.
 
 In this example, a new token type obj_list is defined and implemented
 in the parse_obj_list.c and parse_obj_list.h files.
-- 
2.51.0

