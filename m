Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB7DD30CEE
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 23:01:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 24DC040A6D;
	Wed, 14 Jan 2026 00:01:15 +0100 (CET)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43]) by mails.dpdk.org (Postfix) with ESMTP id 7CDBC40697
 for <dev@dpdk.org>; Wed, 14 Jan 2026 00:01:14 +0100 (CET)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-432da746749so2384439f8f.0
 for <dev@dpdk.org>; Tue, 13 Jan 2026 15:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768345274;
 x=1768950074; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yLqB5saw6G5/3j6ymenr6G/Pt3SQyYJmMvT5SbiFpD0=;
 b=XB98SRgUyfdtV7sUAEaHQz6SrQSQl2ca80Ah3tS6Q117qbeKBIznLePBmrwHcZq01Y
 1dpYTM+yqQlgYM9jN7ggJdfZpPpExZeV2HG5s0S5AWwSn1DrAAYvk6FA8VeXu0sS4bb9
 4nnANzVI8gFdMRgWNb7kxCtxr962Pom/zL9rU+x4ZwOMtM6Q/zV7wJyw+aHu5eAtSmBW
 Y8qgg19ds3t94mFP75g41QDHWGQdwpjVotuoJ0ruUx6fzmMjWwAO7zMxV9gKPyhf+GCt
 ZExmaJQI7O7j52re3shrZYEMyQGV4STbdlIB+g1NKlDMBdEcLaE4ESvyhluPxfQY2Mat
 qXVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768345274; x=1768950074;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yLqB5saw6G5/3j6ymenr6G/Pt3SQyYJmMvT5SbiFpD0=;
 b=JVFl45CaUUYi20eC10Kbp+UoVnHtDx27Y7usxRyEqtuyockHQMeCHlVZIBDDRFGisk
 ATZ69+tBhUiKeEJL1YILRxXQgNtnc9vB4gGGh2A3D0gabx2wI8COmJZudiY90t66qZmx
 pbIGGcaTVsac6awD/P7rXOsWJJd05IRaJ7VX8GLEstZg90eO0JAOqHa1z9QXpjkNzcyb
 JiJTopdQLqwJlB4tVP1LCltUUc+RZ2scEwTWEHimWK+nkvzxFuAzKPS0l7ZdRuykwNrh
 W4tyXc+4KmVYcH4BiXvZIGK9CcVf6tG9IFuivxsTLpsiFwAKIy2TpgOf8Ysy/CHLLN7N
 d+mw==
X-Gm-Message-State: AOJu0Yz45XCwoSRVhM1+BCi6dpa7u/tPapNN2nAhG8+Vt0HZyLEZShoE
 VZ5MriBZTJ5pKy7a+L2+FOk2sofmQYOgkvO+S0LgpDKIhdBKRCPNV6/UtxwlQrjt/78IBRdkoCB
 ZpSdi
X-Gm-Gg: AY/fxX6xPfTYQEx7c64pqjc/+5C0I8Qgh1ivC1UJyYooVPZyEifW9o/Z+rYXbPVf9Fq
 v+xSq6WEtKz2jaP6n2ARYbZLgY9ZMj0bNM54IIHdYTbpm6h3fDKLSyiZ4qAWjkrDU6k/6UIkDus
 EXEOt6nymiXNy44Zu2jNAnmPzSkJGLfuOMAOXAplnuBQHPTWylkn4DW9mUrJ7+H5w25wcusovuG
 nFi6sUXBKLDNZJhrNBObFhBuLOk5fBHFnQm+f+tJqpgvgb5nCLqnVbmE5RC7dng6vcv76PfkVo2
 69ZRB4kwFOVwGkPuG6HLGC01llRv+3ttruUYqPhQIjiSIPm2bKKrw6FyG5oR680GEm3xcmcY+ZR
 zin+5DyZPOWfCm4FEjAfQPPGSdkNDxKbji92L7r/1vIJB28JznrSwH2+WJZM9l2J0vfEBCFyMHL
 4Jhcq8NHcHJ6MMSj2u3ZokNLZgDti1k1s81GW/M9L54FD9hUekMw==
X-Received: by 2002:a05:6000:1847:b0:430:f97a:6f42 with SMTP id
 ffacd0b85a97d-4342c572456mr471014f8f.54.1768345272832; 
 Tue, 13 Jan 2026 15:01:12 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5df8besm44977200f8f.26.2026.01.13.15.01.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 15:01:12 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nandini Persad <nandinipersad361@gmail.com>
Subject: [PATCH v3 08/11] doc: correct errors in command-line library guide
Date: Tue, 13 Jan 2026 14:51:10 -0800
Message-ID: <20260113230052.54435-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260113230052.54435-1-stephen@networkplumber.org>
References: <20240513155911.31872-1-nandinipersad361@gmail.com>
 <20260113230052.54435-1-stephen@networkplumber.org>
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

Fix several errors in the cmdline library documentation:

- Fix function name typo: cmdline_new_stdin -> cmdline_stdin_new
- Fix type name: cmdline_parse_t -> cmdline_parse_inst_t
- Fix grammar: "that others" -> "than others"
- Fix spelling: "boiler plate" -> "boilerplate"
- Clarify wording: "multiplex" -> "direct" for command routing
- Fix misleading phrase: "call a separate function" -> "call a single
  function" (multiplexing routes multiple commands to one callback)

Signed-off-by: Nandini Persad <nandinipersad361@gmail.com>
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/prog_guide/cmdline.rst | 42 +++++++++++++++----------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/doc/guides/prog_guide/cmdline.rst b/doc/guides/prog_guide/cmdline.rst
index e20281ceb5..c794ec826f 100644
--- a/doc/guides/prog_guide/cmdline.rst
+++ b/doc/guides/prog_guide/cmdline.rst
@@ -4,9 +4,9 @@
 Command-line Library
 ====================
 
-Since its earliest versions, DPDK has included a command-line library -
-primarily for internal use by, for example, ``dpdk-testpmd`` and the ``dpdk-test`` binaries,
-but the library is also exported on install and can be used by any end application.
+Since its earliest versions, DPDK has included a command-line library,
+primarily for internal use by, for example, ``dpdk-testpmd`` and the ``dpdk-test`` binaries.
+However, the library is also exported on install and can be used by any end application.
 This chapter covers the basics of the command-line library and how to use it in an application.
 
 Library Features
@@ -18,14 +18,14 @@ The DPDK command-line library supports the following features:
 
 * Ability to read and process commands taken from an input file, e.g. startup script
 
-* Parameterized commands able to take multiple parameters with different datatypes:
+* Parameterized commands that can take multiple parameters with different datatypes:
 
    * Strings
    * Signed/unsigned 16/32/64-bit integers
    * IP Addresses
    * Ethernet Addresses
 
-* Ability to multiplex multiple commands to a single callback function
+* Ability to direct multiple commands to a single callback function
 
 Adding Command-line to an Application
 -------------------------------------
@@ -46,7 +46,7 @@ Adding a command-line instance to an application involves a number of coding ste
 
 Many of these steps can be automated using the script ``dpdk-cmdline-gen.py`` installed by DPDK,
 and found in the ``buildtools`` folder in the source tree.
-This section covers adding a command-line using this script to generate the boiler plate,
+This section covers adding a command-line using this script to generate the boilerplate,
 while the following section,
 `Worked Example of Adding Command-line to an Application`_ covers the steps to do so manually.
 
@@ -56,7 +56,7 @@ Creating a Command List File
 The ``dpdk-cmdline-gen.py`` script takes as input a list of commands to be used by the application.
 While these can be piped to it via standard input, using a list file is probably best.
 
-The format of the list file must be:
+The format of the list file must follow these requirements:
 
 * Comment lines start with '#' as first non-whitespace character
 
@@ -75,7 +75,7 @@ The format of the list file must be:
   * ``<IPv6>dst_ip6``
 
 * Variable fields, which take their values from a list of options,
-  have the comma-separated option list placed in braces, rather than a the type name.
+  have the comma-separated option list placed in braces, rather than by the type name.
   For example,
 
   * ``<(rx,tx,rxtx)>mode``
@@ -127,13 +127,13 @@ and the callback stubs will be written to an equivalent ".c" file.
 Providing the Function Callbacks
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-As discussed above, the script output is a header file, containing structure definitions,
-but the callback functions themselves obviously have to be provided by the user.
-These callback functions must be provided as non-static functions in a C file,
+As discussed above, the script output is a header file containing structure definitions,
+but the callback functions must be provided by the user.
+These callback functions must be provided as non-static functions in a C file
 and named ``cmd_<cmdname>_parsed``.
 The function prototypes can be seen in the generated output header.
 
-The "cmdname" part of the function name is built up by combining the non-variable initial tokens in the command.
+The "cmdname" part of the function name is built by combining the non-variable initial tokens in the command.
 So, given the commands in our worked example below: ``quit`` and ``show port stats <n>``,
 the callback functions would be:
 
@@ -151,11 +151,11 @@ the callback functions would be:
         ...
    }
 
-These functions must be provided by the developer, but, as stated above,
+These functions must be provided by the developer. However, as stated above,
 stub functions may be generated by the script automatically using the ``--stubs`` parameter.
 
 The same "cmdname" stem is used in the naming of the generated structures too.
-To get at the results structure for each command above,
+To get to the results structure for each command above,
 the ``parsed_result`` parameter should be cast to ``struct cmd_quit_result``
 or ``struct cmd_show_port_stats_result`` respectively.
 
@@ -179,7 +179,7 @@ To integrate the script output with the application,
 we must ``#include`` the generated header into our applications C file,
 and then have the command-line created via either ``cmdline_new`` or ``cmdline_stdin_new``.
 The first parameter to the function call should be the context array in the generated header file,
-``ctx`` by default. (Modifiable via script parameter).
+``ctx`` by default (Modifiable via script parameter).
 
 The callback functions may be in this same file, or in a separate one -
 they just need to be available to the linker at build-time.
@@ -190,7 +190,7 @@ Limitations of the Script Approach
 The script approach works for most commands that a user may wish to add to an application.
 However, it does not support the full range of functions possible with the DPDK command-line library.
 For example,
-it is not possible using the script to multiplex multiple commands into a single callback function.
+it is not possible using the script to direct multiple commands to a single callback function.
 To use this functionality, the user should follow the instructions in the next section
 `Worked Example of Adding Command-line to an Application`_ to manually configure a command-line instance.
 
@@ -416,7 +416,7 @@ Once we have our ``ctx`` variable defined,
 we now just need to call the API to create the new command-line instance in our application.
 The basic API is ``cmdline_new`` which will create an interactive command-line with all commands available.
 However, if additional features for interactive use - such as tab-completion -
-are desired, it is recommended that ``cmdline_new_stdin`` be used instead.
+are desired, it is recommended that ``cmdline_stdin_new`` be used instead.
 
 A pattern that can be used in applications is to use ``cmdline_new`` for processing any startup commands,
 either from file or from the environment (as is done in the "dpdk-test" application),
@@ -449,8 +449,8 @@ For example, to handle a startup file and then provide an interactive prompt:
 Multiplexing Multiple Commands to a Single Function
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-To reduce the amount of boiler-plate code needed when creating a command-line for an application,
-it is possible to merge a number of commands together to have them call a separate function.
+To reduce the amount of boilerplate code needed when creating a command-line for an application,
+it is possible to merge a number of commands together to have them call a single function.
 This can be done in a number of different ways:
 
 * A callback function can be used as the target for a number of different commands.
@@ -463,7 +463,7 @@ This can be done in a number of different ways:
 
 As a concrete example,
 these two techniques are used in the DPDK unit test application ``dpdk-test``,
-where a single command ``cmdline_parse_t`` instance is used for all the "dump_<item>" test cases.
+where a single ``cmdline_parse_inst_t`` instance is used for all the "dump_<item>" test cases.
 
 .. literalinclude:: ../../../app/test/commands.c
     :language: c
@@ -481,7 +481,7 @@ the following DPDK files can be consulted for examples of command-line use.
 
    This is not an exhaustive list of examples of command-line use in DPDK.
    It is simply a list of a few files that may be of use to the application developer.
-   Some of these referenced files contain more complex examples of use that others.
+   Some of these referenced files contain more complex examples of use than others.
 
 * ``commands.c/.h`` in ``examples/cmdline``
 
-- 
2.51.0

