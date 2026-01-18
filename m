Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D57C9832F
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Jan 2026 19:14:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B5A3840A6E;
	Sun, 18 Jan 2026 20:13:39 +0100 (CET)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com
 [209.85.208.53]) by mails.dpdk.org (Postfix) with ESMTP id 7F30840673
 for <dev@dpdk.org>; Sun, 18 Jan 2026 20:13:37 +0100 (CET)
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-64b7318f1b0so5514754a12.2
 for <dev@dpdk.org>; Sun, 18 Jan 2026 11:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768763617;
 x=1769368417; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YhwsAym118Z50j373nLJHxbO/t+7/JkSGBVItsu22HE=;
 b=0f690gpRSb46bxICVw0NsLVRZQL7Jf7nEgbX9arKdxZw07bpT6lF5Ki9JCRIK1njNi
 L8+yA7us5D6oGkm+MP0IF4F2CgIydRCQ6JIb0xRMe+iSkTnO+qV8ZnIeX9e7Cj36OK7E
 yaps4B0CFOum1Mqe68Q24ECUgW7kS8ak0EB/rY5ahC7FDL9Pn9JoCFl1Xv1ziMeom1wb
 E3XlM3mYxJeX5SIsFXz1oWDV7q4QfVKo1NwFV7b8KtJRN0RNu72qSYTJFF76NympydwO
 iFb7f2Mzg593LYFK7Ir4ikPMNdjKqTNG56W+Gei8Fc1WbwWl6u7FR12yzyCLSmQeY3n4
 t10g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768763617; x=1769368417;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YhwsAym118Z50j373nLJHxbO/t+7/JkSGBVItsu22HE=;
 b=nX1dyrd0lhcuyl+yMWXwPPNYP/JkroQT+y+edafxu8QCzZUJ21Cvd3X2Nq8fkkdPs/
 Ylvq0Krd+1aJUZmrKKsOu945oUMw8pVD5/1eFXaDkLmLEB5dVJ7iTclQtKta/35rzBTG
 +1GcjSwqdZ1pKsqjS3VTYmcaikWuvCZK1F2usRE8iLN57yL+jViU2mqZAXYUOdgeFroW
 7w3jb6QJbyr5LeXWxt9QOEkrx5LANuHEO8AQHGyvX+PfHSfJ6kHrECf+mG1NE58NBBft
 Dyf8SGcXv7rURlDTsYEvmADGv4E2HTBoABGBL8N+YEGucmxRrr6jrgM2himy72I4gVaU
 NFpQ==
X-Gm-Message-State: AOJu0YxUIUsGRerLG7UmoFYS/9yU/IJgLX/nXvuEJ3g+tTy9J0UH6dtm
 sxtHBWpmubVr7UqgRBHU0QkKO7mux4EKNS90OSTY9zSY+R3spPnN/l9DPclmsFDltE1fk2OQxCp
 MnSs0
X-Gm-Gg: AY/fxX7KJrbF9DgPjBidMx8BPIDJhah1tmEex+8aZk7L0qS3NkzvQk91R6AoSAsGuJP
 C2k2YE2rDsH/9loSQkERB5F0RczNr78qXyyftRJ/89WsVyBessxAi23GTYYB3YbYjCWCUqEOr15
 GTj0c6XCZyOel2oXvTcfCiXICGU5fWYPFl/16Qm5ey5Hj44J6qqoYI/jVe36GO/v3IFC5u/T25L
 LONJy3Wfxg+UMdeLPKG1CdqhQBxxwnJMGrzw5CC39Nclm+av2Y8GkQrbyFSL73xrBQg6u0L0lpJ
 33ihBQZ9KrLCZgrMWDEP+mLzm+WnPBKTiRdvDo3cyy92S5GFtRPqRseBrvPjjYNbIUyT/GzWb7u
 V3MCr1cOe5MgC65mOAESN2HTxJ9LxijbEitns5JItaKmOHBoA0lIKwJLA8W5Aa8rzcivYe1Apx6
 Pc0OoG4Pgfr6vDI53ocQKWu2CrV+kg7bQfOgw94s1BZChgMnk9Pg==
X-Received: by 2002:a17:907:d0b:b0:b6d:73f8:3168 with SMTP id
 a640c23a62f3a-b87968b6a8dmr773001166b.3.1768763616985; 
 Sun, 18 Jan 2026 11:13:36 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87959c9f8dsm886287166b.36.2026.01.18.11.13.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 11:13:36 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nandini Persad <nandinipersad361@gmail.com>
Subject: [PATCH v5 05/54] doc: correct errors in command-line library guide
Date: Sun, 18 Jan 2026 11:10:08 -0800
Message-ID: <20260118191323.241013-6-stephen@networkplumber.org>
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

Change several errors in the cmdline library documentation:

- Change function name typo: cmdline_new_stdin -> cmdline_stdin_new
- Change type name: cmdline_parse_t -> cmdline_parse_inst_t
- Change grammar: "that others" -> "than others"
- Change spelling: "boiler plate" -> "boilerplate"
- Clarify wording: "multiplex" -> "direct" for command routing
- Change misleading phrase: "call a separate function" -> "call a single
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

