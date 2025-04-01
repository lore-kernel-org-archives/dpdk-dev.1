Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF783C36010
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Apr 2025 23:45:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B02DD402B5;
	Wed,  2 Apr 2025 01:45:58 +0200 (CEST)
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com
 [209.85.161.49]) by mails.dpdk.org (Postfix) with ESMTP id DA7F04029A
 for <dev@dpdk.org>; Wed,  2 Apr 2025 01:45:56 +0200 (CEST)
Received: by mail-oo1-f49.google.com with SMTP id
 006d021491bc7-601a8b6c133so146187eaf.1
 for <dev@dpdk.org>; Tue, 01 Apr 2025 16:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743551156; x=1744155956; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Mtuzf6uAVW+0K+UN/NXsCB6NLpAbKq8AD49I6FJzJHQ=;
 b=Edj+L9raj4xR75CtMuQ64IkBkOY4LLTfJPyiExfm5KZVLDrjyYbV5siBm9DvsiMftp
 Dp+hJwCiFZObKr//Ba6rrTm8ObBcdNjqmAOay8UiAqMEwmT464BkuQ08R4Lm8aOl40n3
 hv/yykgq13kLVNu5yNenMYGHoCgBR2K6rlgBnI/qwJC2OMRgGiiFK3pe2Cu3KaTY//M+
 4WmwJY7UWDVE45fHeXgFlqvvdANSBcHbNpxEec8cl1OvPKtY1zGRjD//kB3d5TfQ5jjm
 7WCudHiuWu4QvaFtBT54ndjTZfPYTYhdfjQ92RnPoX3ojvP/y7GMhGihoTEPxUhTOWXH
 3Okw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743551156; x=1744155956;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Mtuzf6uAVW+0K+UN/NXsCB6NLpAbKq8AD49I6FJzJHQ=;
 b=vNUELIOGkpNgzDwoqQu6Jv59wbn79TWBhDOLECE3x3/lcrkccEelF0rMNWCMmCN8+e
 4C9/Jcb0rh5S2M3bMDoBRR8dkHLDG4q9SD0EaNbElv3BXd+NAS7poJPI4353UO7MWPHf
 8uG2AEps49Pg8vNhG2HWfv27/lMYOlNVgXoxqj/UBZgFkYKxrfLLbd08f8KdfN02AtKf
 LiLU6r+Zy7Y+6TMk9Y0MKWs9lMUGI2loZiJOp0mU2KQnH1V2e1IT/2j0wD+De7/EepiH
 nCYVnu85oEmISb05hhiNP0dqbSKFwqYwfeOCttM1r1CNvwTjRLCMc0rEQFU7oYnBTLik
 xm0A==
X-Gm-Message-State: AOJu0YwwPpZnfF6+cI3AaI4WeveuR2RS1/beQHk6dZ8ppdXEnx4c/Wzs
 5oCY3kIxSqHCmhJzMMy20mG83j0yCu7yQ60AqFM+1ai++l8BSOksYwrTFhqf
X-Gm-Gg: ASbGncsKU+rzU9pgC/veTjHJOOvndQV9hZtuC/R7iyS0dfts5mQ5a3eIL6AwkcpHr0s
 PPZPySu9V6KxkUNiH24KJsjROfOaMaJJsW9wQjxwy4ubUjqLgAyWoWQqD+ijirE4kTPuC0+H9gJ
 wlLz53fQ67PxWdeqKJYOGMrWm3oaK6yxSKt9iXzpJY/I9PkY2IYknzuWk/RRWfOndiHs9UAYRuE
 xdpPUX/DKcyed3m9RKhDrTy/Yr+Mk38PMJA3In+A3MV9At6xEud+Mw7NEDDWcbNGoKomPcyE8Qr
 5OoHb8SrrnFBL2Tr/S6xSmRWQjzzmivqnaXmRcjbriJDDREB7c7gRdHll2uJc5DLg10GCt8WSI7
 AS80R6MlIx6JG6PY=
X-Google-Smtp-Source: AGHT+IEMuOGiy7kvNx2bpKiC2u9AUip+9B5G588nJlLYZWEzPE0EWJLSaJcmf/z9pCqziGQGNJvDjQ==
X-Received: by 2002:a4a:bb0b:0:b0:601:acdc:8f84 with SMTP id
 006d021491bc7-60402565280mr16273eaf.0.1743551155344; 
 Tue, 01 Apr 2025 16:45:55 -0700 (PDT)
Received: from localhost.localdomain ([47.189.31.106])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6028461963asm1990408eaf.33.2025.04.01.16.45.54
 for <dev@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 16:45:54 -0700 (PDT)
From: Nandini Persad <nandinipersad361@gmail.com>
To: 
Cc: dev@dpdk.org
Subject: [PATCH] doc: reword contributor's guide for grammar/clarity
Date: Tue,  1 Apr 2025 16:45:45 -0700
Message-Id: <20250401234545.32515-1-nandinipersad361@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

I'm reviewing the Contributor's Guidelines to be more
clear and concise where necessary.

Signed-off-by: Nandini Persad <nandinipersad361@gmail.com>
---
 doc/guides/contributing/coding_style.rst | 105 +++++++++++------------
 doc/guides/contributing/design.rst       |   9 +-
 doc/guides/contributing/new_library.rst  |  31 ++++---
 3 files changed, 77 insertions(+), 68 deletions(-)

diff --git a/doc/guides/contributing/coding_style.rst b/doc/guides/contributing/coding_style.rst
index 1ebc79ca3c..c465bd0f1f 100644
--- a/doc/guides/contributing/coding_style.rst
+++ b/doc/guides/contributing/coding_style.rst
@@ -15,14 +15,13 @@ It is based on the Linux Kernel coding guidelines and the FreeBSD 7.2 Kernel Dev
 General Guidelines
 ------------------
 
-The rules and guidelines given in this document cannot cover every situation, so the following general guidelines should be used as a fallback:
+This document's rules and guidelines cannot cover every scenario, so the following general principles
+should be used as a fallback.
 
-* The code style should be consistent within each individual file.
-* In the case of creating new files, the style should be consistent within each file in a given directory or module.
-* The primary reason for coding standards is to increase code readability and comprehensibility, therefore always use whatever option will make the code easiest to read.
-
-Line length is recommended to be not more than 80 characters, including comments.
-[Tab stop size should be assumed to be 8-characters wide].
+* Maintain a consistent coding style within each file.
+* When creating new files, ensure consistency with other files in the same directory or module.
+* Prioritize readability and clarity. Choose the style that makes the code easiest to read.
+* Keep line length within 80 characters, including comments. Assume a tab stop size of 8 characters.
 
 .. note::
 
@@ -36,7 +35,7 @@ Usual Comments
 ~~~~~~~~~~~~~~
 
 These comments should be used in normal cases.
-To document a public API, a doxygen-like format must be used: refer to :ref:`doxygen_guidelines`.
+To document a public API, a Doxygen-like format must be used. Refer to the :ref:`doxygen_guidelines`.
 
 .. code-block:: c
 
@@ -110,15 +109,19 @@ Headers should be protected against multiple inclusion with the usual:
 Macros
 ~~~~~~
 
-Do not ``#define`` or declare names except with the standard DPDK prefix: ``RTE_``.
-This is to ensure there are no collisions with definitions in the application itself.
+Use only the standard DPDK prefix (RTE_) when defining or declaring names
+to prevent conflicts with application definitions.
+
+Macro Naming:
 
-The names of "unsafe" macros (ones that have side effects), and the names of macros for manifest constants, are all in uppercase.
+* "Unsafe" macros (those with side effects) and macros for manifest constants must be in uppercase.
+* Expression-like macros should either expand to a single token or be enclosed in outer parentheses.
+* If a macro inlines a function, use the lowercase function name and an uppercase macro name.
 
-The expansions of expression-like macros are either a single token or have outer parentheses.
-If a macro is an inline expansion of a function, the function name is all in lowercase and the macro has the same name all in uppercase.
-If the macro encapsulates a compound statement, enclose it in a do-while loop, so that it can be used safely in if statements.
-Any final statement-terminating semicolon should be supplied by the macro invocation rather than the macro, to make parsing easier for pretty-printers and editors.
+Encapsulation:
+
+* Macros that wrap compound statements should be enclosed in a do while loop to ensure safe use in "if" statements.
+* The semicolon terminating a statement should be provided by the macro invocation, not the macro itself, to improve readability for formatters and editors.
 
 For example:
 
@@ -138,38 +141,34 @@ Conditional Compilation
 
 .. note::
 
-   Conditional compilation should be used only when absolutely necessary,
-   as it increases the number of target binaries that need to be built and tested.
-   See below for details of some utility macros/defines available
-   to allow ifdefs/macros to be replaced by C conditional in some cases.
-
-Some high-level guidelines on the use of conditional compilation:
-
-* If code can compile on all platforms/systems,
-  but cannot run on some due to lack of support,
-  then regular C conditionals, as described in the next section,
-  should be used instead of conditional compilation.
-* If the code in question cannot compile on all systems,
-  but constitutes only a small fragment of a file,
-  then conditional compilation should be used, as described in this section.
-* If the code for conditional compilation implements an interface in an OS
-  or platform-specific way, then create a file for each OS or platform
-  and select the appropriate file using the Meson build system.
-  In most cases, these environment-specific files should be created inside the EAL library,
-  rather than having each library implement its own abstraction layer.
-
-Additional style guidance for the use of conditional compilation macros:
-
-* When code is conditionally compiled using ``#ifdef`` or ``#if``, a comment may be added following the matching
-  ``#endif`` or ``#else`` to permit the reader to easily discern where conditionally compiled code regions end.
-* This comment should be used only for (subjectively) long regions, regions greater than 20 lines, or where a series of nested ``#ifdef``'s may be confusing to the reader.
-  Exceptions may be made for cases where code is conditionally not compiled for the purposes of lint(1), or other tools, even though the uncompiled region may be small.
-* The comment should be separated from the ``#endif`` or ``#else`` by a single space.
-* For short conditionally compiled regions, a closing comment should not be used.
-* The comment for ``#endif`` should match the expression used in the corresponding ``#if`` or ``#ifdef``.
-* The comment for ``#else`` and ``#elif`` should match the inverse of the expression(s) used in the preceding ``#if`` and/or ``#elif`` statements.
-* In the comments, the subexpression ``defined(FOO)`` is abbreviated as "FOO".
-  For the purposes of comments, ``#ifndef FOO`` is treated as ``#if !defined(FOO)``.
+   Use conditional compilation only when absolutely necessary
+   as it increases the number of binaries that must be built and tested.
+   Whenever possible, replace #ifdef macros with regular C conditionals
+   using the available utility macros and defines (see below for more details).
+  
+Guidelines for Conditional Compilation:
+
+* If code can compile on all platforms but lacks runtime support on some,
+  use regular C conditionals instead of ``#ifdef`` or ``#if``.
+
+* If code cannot compile on all platforms but affects only a small fragment
+  of a file, use conditional compilation.
+
+* For platform specific implementations, create separate files for
+  each OS or platform and use Meson to select the appropriate one.
+  These files should generally reside in the EAL library to avoid
+  redundant abstraction layers in individual libraries.
+
+Style Guidelines for Conditional Compilation Macros:
+
+* For long or nested conditional compilation blocks (generally over 20 lines), add a comment
+  after ``#endif`` or ``#else`` to clarify where the block ends.
+* This is not necessary for short, straightforward sections.
+* The ``#endif`` comment should match the original ``#ifdef`` or ``#if`` condition.
+* The ``#else`` and ``#elif`` comments should indicate the inverse of the preceding condition.
+* In comments, ``defined(FOO)`` can be abbreviated as "FOO". Treat ``#ifndef FOO``
+  as ``#if !defined(FOO)``
+* Separate the comment from ``#endif`` or ``else`` with a single space.
 
 .. code-block:: c
 
@@ -850,13 +849,13 @@ Examples:
 Specializations
 ~~~~~~~~~~~~~~~
 
-In addition to the above logging topic, any PMD or library can further split
-logging output by using "specializations". A specialization could be the
-difference between initialization code, and logs of events that occur at runtime.
+In addition to standard logging, PMDs and libraries can further categorize log
+output using specializations. Specializations help distinguish between different
+types of logs, such as initialization messages and runtime events.
 
-An example could be the initialization log messages getting one
-specialization, while another specialization handles mailbox command logging.
-Each PMD, library or component can create as many specializations as required.
+For example, one specialization might handle initialization logs, while another is
+used for mailbox command logging. Each PMD, library, or component can define as many
+specializations as needed.
 
 A specialization looks like this:
 
diff --git a/doc/guides/contributing/design.rst b/doc/guides/contributing/design.rst
index b724177ba1..7bf11ec2b6 100644
--- a/doc/guides/contributing/design.rst
+++ b/doc/guides/contributing/design.rst
@@ -72,17 +72,16 @@ like (non exhaustive): wide usage, performance, size.
 Runtime Information - Logging, Tracing and Telemetry
 ----------------------------------------------------
 
-It is often desirable to provide information to the end-user
-as to what is happening to the application at runtime.
-DPDK provides a number of built-in mechanisms to provide this introspection:
+Providing runtime information to end-users is often necessary to understand the
+application’s behavior. DPDK offers several mechanisms for this introspection:
 
 * :ref:`Logging <dynamic_logging>`
 * :doc:`Tracing <../prog_guide/trace_lib>`
 * :doc:`Telemetry <../prog_guide/telemetry_lib>`
 
-Each of these has its own strengths and suitabilities for use within DPDK components.
+Each of these mechanisms has its strengths and is suited for specific use cases within DPDK components.
 
-Below are some guidelines for when each should be used:
+Below are guidelines for when each should be used:
 
 * For reporting error conditions, or other abnormal runtime issues, *logging* should be used.
   Depending on the severity of the issue, the appropriate log level, for example,
diff --git a/doc/guides/contributing/new_library.rst b/doc/guides/contributing/new_library.rst
index 99890beb29..17ce30f2aa 100644
--- a/doc/guides/contributing/new_library.rst
+++ b/doc/guides/contributing/new_library.rst
@@ -10,26 +10,34 @@ Process for approval in principle
 Rationale
 ~~~~~~~~~
 
-Adding a new library to DPDK with proper RFC and then full patch-sets is a significant work.
-In order to save effort, developers should get an early approval in principle,
-or an early feedback in case the library is not suitable for various reasons.
+Adding a new library to DPDK, including the necessary RFC and full patch sets, is a substantial
+effort. To save time and resources, developers should seek early approval or feedback to determine
+if the library is suitable, especially if there are concerns about its compatibility or relevance.
+
 
 Process
 ~~~~~~~
 
 #. When a contributor would like to add a new library to DPDK code base,
-   the contributor must send the following items to DPDK mailing list
-   for Technical Board approval-in-principle.
+   the contributor must send the following items to the DPDK mailing list
+   for Technical Board approval-in-principle:
+
 
    * Purpose of the library.
+
    * Scope of work: outline the various additional tasks planned for this library,
      such as developing new test applications, adding new drivers,
      and updating existing applications.
+
    * Expected usage models of the library.
+
    * Any licensing constraints.
+
    * Justification for adding to DPDK.
+
    * Any other implementations of the same functionality in other libraries/projects
      and how this version differs.
+
    * Public API specification header file as RFC.
 
      * Optional and good to have.
@@ -38,19 +46,22 @@ Process
 
    * Any new library dependencies to DPDK.
 
-#. Technical Board to schedule discussion on this in upcoming Technical Board meeting
-   along with author.
-   Based on the Technical Board schedule and/or author availability,
-   Technical Board may need a maximum of **five** Technical Board meeting slots.
+
+#. The Technical Board will schedule a discussion on this in 
+   an upcoming Technical Board meeting along with the author.
+   Based on the Technical Board schedule and/or the author availability,
+   the Technical Board may need a maximum of **five** Technical Board meeting slots.
+
 
 #. Based on mailing list and Technical Board meeting discussions,
-   Technical Board to vote and share the decision in the mailing list.
+   Technical Board will vote and share the decision in the mailing list.
    The decision outcome can be any of the following:
 
    * Approved in principle
    * Not approved
    * Further information needed
 
+
 #. Once the Technical Board approves the library in principle,
    it is safe to start working on the implementation.
    However, the patches will need to meet the usual quality criteria
-- 
2.34.1

