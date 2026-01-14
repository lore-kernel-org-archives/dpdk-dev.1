Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2045BD3CC82
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 22:28:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 61EE240FDE;
	Wed, 14 Jan 2026 23:28:35 +0100 (CET)
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
 [209.85.128.68]) by mails.dpdk.org (Postfix) with ESMTP id B91AE41132
 for <dev@dpdk.org>; Wed, 14 Jan 2026 23:28:33 +0100 (CET)
Received: by mail-wm1-f68.google.com with SMTP id
 5b1f17b1804b1-47ee974e230so2754745e9.2
 for <dev@dpdk.org>; Wed, 14 Jan 2026 14:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768429713;
 x=1769034513; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I0Tgqf3ahbjsgVobNUz3qozvojCla7ueL+/CBVcgA8E=;
 b=wRjSNICPOhwqsfBf22gnQvWdLeVP4+pye9M5ok8oqKKFL4NXu5u+wEoz4sP8VYwZNu
 +Rr5nurwG2D/CbuXQjs0HIafbuHOHJ1758Gxe9xztXIeXP6cwMlZssfsKS7vhCci11UG
 IWQBMQa7V75kb7PVOqxe0YFxjlecXy7p4Qkfx33UmkIJO4tT4TPQn84XhkWEgg76cTzJ
 5qtMYerhqP5fWfMzOe/G24CRMldeRasucNVanNal2c1mrIYJAtcIKSHWkTM6MWRGy0OR
 JwH0gKW1ogimGZ7VMurX+lZT3cmIu4/lSx0IQqPksNg9hq2PVha3pzTFEdy7zht3xPQa
 hWlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768429713; x=1769034513;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=I0Tgqf3ahbjsgVobNUz3qozvojCla7ueL+/CBVcgA8E=;
 b=ADD7xTPlomz8OgdrP32tyj5xNEQ77lbt8pkGsAjzIiY7GEQMga5rldfn/jW0ka4/i2
 fkfkhyNGnqfmuT+2FjOACfIM9zRcmgF+A1vwsEHD0l3PZ1G/sBCMOjZlaD6F2W+MfNV4
 yN/53Y0tN6mOkENVK4HXY8tfeuFUY0UUgGFZMQU8NbQQ1t75niGZVX5+LnJbadkwJbEH
 F6/MDYUwHdaif/TXmpuYLuUlcUDhWX3TiL1mnkfGn0+mscBGFQNl9VIQl7nWvwPryREH
 f8NuW1yKiTUiQgy42yNPFgpoMss8C8TADGb/1C8GWFCMX1Vy9VLPzuPzPn8pTjRWNm9O
 /c/A==
X-Gm-Message-State: AOJu0Yy8Ll8AHTrbhWVwZLuebViluI+i76xIHKt2w0hqMNIkMlCwfoMQ
 iqkrqT+rKxrOIDGJoigU1XA0otFSnuCOQUStTPC+ljNqZ2tB/+ukY9dhPFhSyV/QsCnOecwxd/l
 We42v
X-Gm-Gg: AY/fxX43SsG5YsfSnh6dWho5ulHNHEff+YM2Y9GGqvsztNrqBC+Zdme3qklzyUrtHqa
 nzs90Vuh6lowaWnd3Ok+/9xxt486olnKLSRq1vfGOMqEUkjUzEBVBDgyZZRpN2VEn+1yJrWkT0s
 dYtdVV9UOkKHO5FnGB3U23O7smXJyqGEgu65pjRkQ/dU1p9M7RR5wMvcswNsj2gQ/NOSvcqJOVA
 QJMSiV+8+B64TPgWhWILZDPYgMkD7TS6pgG1uvGWzFY7+wYi6xinV8jd+NtXJJjIkFvBV8tzTPE
 8D0+q/sTj0d43kl2Y3ENrXQ5bKrHw4aQSCFNEgyjHd9DUzSEo6nQIue2HcQv5LzviW3jMVI0rB+
 6gum1o8VroIo9MFeveQ7w3z85K7xsr1TOTG/R8h6WoaVUkJy4qe5HTZWK1bUAK5cDBkvnyfulI7
 GWhUpHVuz8pgGpdVFl1b0z75kvFniJ9IIm9I0DQw++G6SvhhJG8xh4aRr/PnE3
X-Received: by 2002:a05:6000:2601:b0:432:84ee:186f with SMTP id
 ffacd0b85a97d-4342c535cd1mr4762908f8f.33.1768429713205; 
 Wed, 14 Jan 2026 14:28:33 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-434af653632sm1757198f8f.11.2026.01.14.14.28.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 14:28:32 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nandini Persad <nandinipersad361@gmail.com>
Subject: [PATCH v4 03/11] doc: correct grammar and typos in design guide
Date: Wed, 14 Jan 2026 14:26:55 -0800
Message-ID: <20260114222821.87920-4-stephen@networkplumber.org>
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

Fixes:
- Use "execution environment" consistently (not "executive environment")
- Fix FreeBSD capitalization
- Use plural "these execution environments" to match multiple options
- Add hyphen to "non-exhaustive"
- Add missing comma before *telemetry*
- Remove double space
- Minor rewording for clarity

Signed-off-by: Nandini Persad <nandinipersad361@gmail.com>
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/contributing/design.rst | 71 ++++++++++++++++--------------
 1 file changed, 39 insertions(+), 32 deletions(-)

diff --git a/doc/guides/contributing/design.rst b/doc/guides/contributing/design.rst
index 5517613424..a966da2ddd 100644
--- a/doc/guides/contributing/design.rst
+++ b/doc/guides/contributing/design.rst
@@ -1,6 +1,7 @@
 ..  SPDX-License-Identifier: BSD-3-Clause
     Copyright 2018 The DPDK contributors
 
+
 Design
 ======
 
@@ -8,22 +9,26 @@ Design
 Environment or Architecture-specific Sources
 --------------------------------------------
 
-In DPDK and DPDK applications, some code is specific to an architecture (i686, x86_64) or to an executive environment (freebsd or linux) and so on.
-As far as is possible, all such instances of architecture or env-specific code should be provided via standard APIs in the EAL.
+In DPDK and DPDK applications, some code is architecture-specific (i686, x86_64) or environment-specific (FreeBSD or Linux, etc.).
+When feasible, such instances of architecture or env-specific code should be provided via standard APIs in the EAL.
+
+By convention, a file is specific if the directory is indicated. Otherwise, it is common.
+
+For example:
 
-By convention, a file is common if it is not located in a directory indicating that it is specific.
-For instance, a file located in a subdir of "x86_64" directory is specific to this architecture.
+A file located in a subdir of "x86_64" directory is specific to this architecture.
 A file located in a subdir of "linux" is specific to this execution environment.
 
 .. note::
 
    Code in DPDK libraries and applications should be generic.
-   The correct location for architecture or executive environment specific code is in the EAL.
+   The correct location for architecture or execution environment-specific code is in the EAL.
 
-When absolutely necessary, there are several ways to handle specific code:
+When necessary, there are several ways to handle specific code:
+
+
+* When the differences are small and they can be embedded in the same C file, use a ``#ifdef`` with a build definition macro in the C code.
 
-* Use a ``#ifdef`` with a build definition macro in the C code.
-  This can be done when the differences are small and they can be embedded in the same C file:
 
   .. code-block:: c
 
@@ -33,9 +38,9 @@ When absolutely necessary, there are several ways to handle specific code:
      titi();
      #endif
 
-* Use build definition macros and conditions in the Meson build file. This is done when the differences are more significant.
-  In this case, the code is split into two separate files that are architecture or environment specific.
-  This should only apply inside the EAL library.
+
+* When the differences are more significant, use build definition macros and conditions in the Meson build file. In this case, the code is split into two separate files that are architecture or environment specific. This should only apply inside the EAL library.
+
 
 Per Architecture Sources
 ~~~~~~~~~~~~~~~~~~~~~~~~
@@ -43,15 +48,16 @@ Per Architecture Sources
 The following macro options can be used:
 
 * ``RTE_ARCH`` is a string that contains the name of the architecture.
-* ``RTE_ARCH_I686``, ``RTE_ARCH_X86_64``, ``RTE_ARCH_X86_X32``, ``RTE_ARCH_PPC_64``, ``RTE_ARCH_RISCV``, ``RTE_ARCH_LOONGARCH``, ``RTE_ARCH_ARM``, ``RTE_ARCH_ARMv7`` or ``RTE_ARCH_ARM64`` are defined only if we are building for those architectures.
+* ``RTE_ARCH_I686``, ``RTE_ARCH_X86_64``, ``RTE_ARCH_X86_X32``, ``RTE_ARCH_PPC_64``, ``RTE_ARCH_RISCV``, ``RTE_ARCH_LOONGARCH``, ``RTE_ARCH_ARM``, ``RTE_ARCH_ARMv7`` or ``RTE_ARCH_ARM64`` are defined when building for these architectures.
+
 
 Per Execution Environment Sources
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 The following macro options can be used:
 
-* ``RTE_EXEC_ENV_NAME`` is a string that contains the name of the executive environment.
-* ``RTE_EXEC_ENV_FREEBSD``, ``RTE_EXEC_ENV_LINUX`` or ``RTE_EXEC_ENV_WINDOWS`` are defined only if we are building for this execution environment.
+* ``RTE_EXEC_ENV_NAME`` is a string that contains the name of the execution environment.
+* ``RTE_EXEC_ENV_FREEBSD``, ``RTE_EXEC_ENV_LINUX`` or ``RTE_EXEC_ENV_WINDOWS`` are defined only if we are building for these execution environments.
 
 Mbuf features
 -------------
@@ -66,7 +72,7 @@ The "dynamic" area is eating the remaining space in mbuf,
 and some existing "static" fields may need to become "dynamic".
 
 Adding a new static field or flag must be an exception matching many criteria
-like (non exhaustive): wide usage, performance, size.
+like (non-exhaustive): wide usage, performance, size.
 
 
 Runtime Information - Logging, Tracing and Telemetry
@@ -82,11 +88,11 @@ DPDK provides a number of built-in mechanisms to provide this introspection:
 
 Each of these has its own strengths and suitabilities for use within DPDK components.
 
-Below are some guidelines for when each should be used:
+Here are guidelines for when each mechanism should be used:
 
 * For reporting error conditions, or other abnormal runtime issues, *logging* should be used.
-  Depending on the severity of the issue, the appropriate log level, for example,
-  ``ERROR``, ``WARNING`` or ``NOTICE``, should be used.
+  For example, depending on the severity of the issue, the appropriate log level,
+  ``ERROR``, ``WARNING`` or ``NOTICE`` should be used.
 
 .. note::
 
@@ -96,24 +102,24 @@ Below are some guidelines for when each should be used:
 
 * For component initialization, or other cases where a path through the code
   is only likely to be taken once,
-  either *logging* at ``DEBUG`` level or *tracing* may be used, or potentially both.
+  either *logging* at ``DEBUG`` level or *tracing* may be used, or both.
   In the latter case, tracing can provide basic information as to the code path taken,
   with debug-level logging providing additional details on internal state,
-  not possible to emit via tracing.
+  which is not possible to emit via tracing.
 
 * For a component's data-path, where a path is to be taken multiple times within a short timeframe,
   *tracing* should be used.
   Since DPDK tracing uses `Common Trace Format <https://diamon.org/ctf/>`_ for its tracing logs,
   post-analysis can be done using a range of external tools.
 
-* For numerical or statistical data generated by a component, for example, per-packet statistics,
+* For numerical or statistical data generated by a component, such as per-packet statistics,
   *telemetry* should be used.
 
-* For any data where the data may need to be gathered at any point in the execution
-  to help assess the state of the application component,
-  for example, core configuration, device information, *telemetry* should be used.
+* For any data that may need to be gathered at any point during the execution
+  to help assess the state of the application component (for example, core configuration, device information), *telemetry* should be used.
   Telemetry callbacks should not modify any program state, but be "read-only".
 
+
 Many libraries also include a ``rte_<libname>_dump()`` function as part of their API,
 writing verbose internal details to a given file-handle.
 New libraries are encouraged to provide such functions where it makes sense to do so,
@@ -135,13 +141,12 @@ requirements for preventing ABI changes when implementing statistics.
 Mechanism to allow the application to turn library statistics on and off
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-Having runtime support for enabling/disabling library statistics is recommended,
-as build-time options should be avoided. However, if build-time options are used,
-for example as in the table library, the options can be set using c_args.
-When this flag is set, all the counters supported by current library are
+Having runtime support for enabling/disabling library statistics is recommended
+as build-time options should be avoided. However, if build-time options are used, as in the table library, the options can be set using c_args.
+When this flag is set, all the counters supported by the current library are
 collected for all the instances of every object type provided by the library.
 When this flag is cleared, none of the counters supported by the current library
-are collected for any instance of any object type provided by the library:
+are collected for any instance of any object type provided by the library.
 
 
 Prevention of ABI changes due to library statistics support
@@ -165,8 +170,8 @@ Motivation to allow the application to turn library statistics on and off
 
 It is highly recommended that each library provides statistics counters to allow
 an application to monitor the library-level run-time events. Typical counters
-are: number of packets received/dropped/transmitted, number of buffers
-allocated/freed, number of occurrences for specific events, etc.
+are: the number of packets received/dropped/transmitted, the number of buffers
+allocated/freed, the number of occurrences for specific events, etc.
 
 However, the resources consumed for library-level statistics counter collection
 have to be spent out of the application budget and the counters collected by
@@ -198,6 +203,7 @@ applications:
   the application may decide to turn the collection of statistics counters off for
   Library X and on for Library Y.
 
+
 The statistics collection consumes a certain amount of CPU resources (cycles,
 cache bandwidth, memory bandwidth, etc) that depends on:
 
@@ -218,6 +224,7 @@ cache bandwidth, memory bandwidth, etc) that depends on:
   validated for header integrity, counting the number of bits set in a bitmask
   might be needed.
 
+
 PF and VF Considerations
 ------------------------
 
@@ -229,5 +236,5 @@ Developers should work with the Linux Kernel community to get the required
 functionality upstream. PF functionality should only be added to DPDK for
 testing and prototyping purposes while the kernel work is ongoing. It should
 also be marked with an "EXPERIMENTAL" tag. If the functionality isn't
-upstreamable then a case can be made to maintain the PF functionality in DPDK
+upstreamable, then a case can be made to maintain the PF functionality in DPDK
 without the EXPERIMENTAL tag.
-- 
2.51.0

