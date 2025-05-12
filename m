Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B14C3ABC3
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 May 2025 14:49:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B08C5402CA;
	Mon, 12 May 2025 16:49:16 +0200 (CEST)
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com
 [209.85.160.49]) by mails.dpdk.org (Postfix) with ESMTP id 1C14D402C9
 for <dev@dpdk.org>; Mon, 12 May 2025 16:49:15 +0200 (CEST)
Received: by mail-oa1-f49.google.com with SMTP id
 586e51a60fabf-2d4e91512b4so2914788fac.1
 for <dev@dpdk.org>; Mon, 12 May 2025 07:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747061354; x=1747666154; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zt1fHX/Dd7AL9i5Lsa24ykAxzP5qAbV/TC15hejCio0=;
 b=h7gkCEEaKo0bXDEm0sZfpSfRJvB9+DKF4GJMaqIoAyDBc8NeTYbDaUOvXiACVXXxJX
 VUYCQ/Z+6HkrE6TBjowXc5tQVMRi1MaY14159uvhi8vbRPt9KTZ1chyvEZp6+pS7kaXq
 tFgrxtdqwmywEYmqWzGN8Yfx6CdJKoO2ojJR8SO0hPbdkBAt8BAgsPrBACxPvzonOw5W
 bnjwEMwbZWTroBnQT9LTCGN60VKUQN+SgtYI66RHx9orAyejD4Hw9zvwE454mxrdPMZ3
 2CT6cz/x+fCtuVJH8bQWKUYRryDbSqBZMMO0Kp6xdeiEfWWB1SC6NDNKWQQw6HhNZAKF
 +dQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747061354; x=1747666154;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zt1fHX/Dd7AL9i5Lsa24ykAxzP5qAbV/TC15hejCio0=;
 b=p+i45rIqxLObVriM3Pu9V0LtUO0D8IR4aEEzKp2yI6ZcbzAswuRuIVz/McrD2jGiv4
 b9zr6aq5Vvq648glAFMjPy4D2nGaNJJyB1o6tEayULQEXJvJM5Huyf/1/E6cp/2egMik
 uLbCipRPZWAWZ9/NTg1yjkg6UQu/s1EhzyVLiYB/sZ4spY0DyLsM/lykCaKi8UL3DCO8
 pOXvuaHLV2FSeGTJ3JNZQFwT7VdLtlGXCmw/QsFWUcud3dQzYqponBMGBfdDqpaY2RtT
 +S6SjX1nl15FBV3Z9i2uNuIGIc/qctfZiQ3jpTsJEbB96ceNZR9q60SWsBcQUQ+xppkn
 r2JQ==
X-Gm-Message-State: AOJu0Yw8wyaCdzNLSMrGvQ9aN9RjZ55BZDHlTlwOotP1JNm932vAOUSJ
 qGCrDspr4VbhbGz5cDq3jYtNVcKYrYkRxB6Ddfq02Gd6FXo/YIyEyly9qDu2
X-Gm-Gg: ASbGncvqDBdVZs3G0Jctx+Fzfk9Pngtim+DYWwft819LGek6D9Uj2NZraDa1PnWmSKd
 B4iW8GKPr9/cNQ3lTZ2hWObwOWexDmVoNjp337ovkpJFf32HfIaERD0iSC1NRZYfDLe8RkeUZJz
 9qWjdyPQ81y/TUjJIURX65n3QdmHoaJ5CieFJ4TJ9/ojksvMMJjE5GF6wLO/dTEn7GDe6DaAVYW
 RTbd3p+wpaJFGOVgNbNRQlTAPMcK7d3fqb+LxvhNHv9n/ZLBTfmA5APgxoLFEVPfyDXLq8hDWYu
 SkPPar1yq12LMQVTycu+6fayOmgYGy99nWSjY+hXO3noT7mhqmbEfaPocL4ipGYDTo39kjV9D+y
 PTvDNumGyueo=
X-Google-Smtp-Source: AGHT+IGn4TSXxDXmz8WAJqsL4LFL2j6ibZBr0c4NG09rvucS8Oq8EKWMS/cK1lEuN/oQkNNnx/YNyQ==
X-Received: by 2002:a05:6870:8908:b0:2c2:5639:3a4d with SMTP id
 586e51a60fabf-2dba453cbbemr7565754fac.38.1747061353382; 
 Mon, 12 May 2025 07:49:13 -0700 (PDT)
Received: from localhost.localdomain ([47.189.31.106])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2dba0625c93sm1932354fac.8.2025.05.12.07.49.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 07:49:13 -0700 (PDT)
From: Nandini Persad <nandinipersad361@gmail.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: dev@dpdk.org
Subject: [PATCH] doc: reword contributor's guidelines
Date: Mon, 12 May 2025 07:48:41 -0700
Message-Id: <20250512144842.29976-1-nandinipersad361@gmail.com>
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

I have revised sections 9-12 for grammar and clarity.

Signed-off-by: Nandini Persad <nandinipersad361@gmail.com>
---
 doc/guides/contributing/linux_uapi.rst    |  32 ++--
 doc/guides/contributing/patches.rst       | 177 +++++++++++-----------
 doc/guides/contributing/stable.rst        | 163 ++++++++------------
 doc/guides/contributing/vulnerability.rst |  59 ++++----
 4 files changed, 193 insertions(+), 238 deletions(-)

diff --git a/doc/guides/contributing/linux_uapi.rst b/doc/guides/contributing/linux_uapi.rst
index 79bedb478e..72abef2133 100644
--- a/doc/guides/contributing/linux_uapi.rst
+++ b/doc/guides/contributing/linux_uapi.rst
@@ -7,14 +7,14 @@ Linux uAPI header files
 Rationale
 ---------
 
-The system a DPDK library or driver is built on is not necessarily running the
-same Kernel version than the system that will run it.
-Importing Linux Kernel uAPI headers enable to build features that are not
-supported yet by the build system.
+The system used to build a DPDK library or driver may not be running the same kernel version
+as the target system where it will be deployed. To support features that are not yet available
+in the build system’s kernel, Linux kernel uAPI headers can be imported.
 
-For example, the build system runs upstream Kernel v5.19 and we would like to
-build a VDUSE application that will use VDUSE_IOTLB_GET_INFO ioctl() introduced
-in Linux Kernel v6.0.
+For example, if the build system runs upstream Kernel v5.19, but you need to build a VDUSE application
+that uses the VDUSE_IOTLB_GET_INFO ioctl introduced in Kernel v6.0, importing the relevant uAPI headers allows this.
+
+The Linux kernel's syscall license exception permits the inclusion of unmodified uAPI header files in such cases.
 
 `Linux Kernel licence exception regarding syscalls
 <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/LICENSES/exceptions/Linux-syscall-note>`_
@@ -23,20 +23,19 @@ enable importing unmodified Linux Kernel uAPI header files.
 Importing or updating an uAPI header file
 -----------------------------------------
 
-In order to ensure the imported uAPI headers are both unmodified and from a
-released version of the linux Kernel, a helper script is made available and
-MUST be used.
+To ensure that imported uAPI headers are unmodified and sourced from an official Linux
+kernel release, a helper script is provided and must be used.
 Below is an example to import ``linux/vduse.h`` file from Linux ``v6.10``:
 
 .. code-block:: console
 
    devtools/linux-uapi.sh -i linux/vduse.h -u v6.10
 
-Once imported, the header files should be committed without any other change.
-Note that all the imported headers will be updated to the requested version.
+Once imported, header files must be committed without any modifications. Note that all imported
+headers will be updated to match the specified kernel version.
 
-Updating imported headers to a newer released version should only be done on
-a need basis, it can be achieved using the same script:
+Updates to a newer released version should be performed only when necessary, and can be done
+using the same helper script.
 
 .. code-block:: console
 
@@ -60,8 +59,9 @@ Note that all the linux-uapi.sh script options can be combined. For example:
 Header inclusion into library or driver
 ---------------------------------------
 
-The library or driver willing to make use of imported uAPI headers needs to
-explicitly include the header file with ``uapi/`` prefix in C files.
+Libraries or drivers that rely on imported uAPI headers must explicitly include
+the relevant header using the ``uapi/`` prefix in their C source files.
+
 For example to include VDUSE uAPI:
 
 .. code-block:: c
diff --git a/doc/guides/contributing/patches.rst b/doc/guides/contributing/patches.rst
index d21ee288b2..88945b8f5d 100644
--- a/doc/guides/contributing/patches.rst
+++ b/doc/guides/contributing/patches.rst
@@ -5,56 +5,53 @@
 
 Contributing Code to DPDK
 =========================
+his document provides guidelines for submitting code to DPDK.
 
-This document outlines the guidelines for submitting code to DPDK.
-
-The DPDK development process is modeled (loosely) on the Linux Kernel development model so it is worth reading the
-Linux kernel guide on submitting patches:
+The DPDK development process is loosely based on the Linux Kernel development
+model. It is recommended to review the Linux kernel's guide:
 `How to Get Your Change Into the Linux Kernel <https://www.kernel.org/doc/html/latest/process/submitting-patches.html>`_.
-The rationale for many of the DPDK guidelines is explained in greater detail in the kernel guidelines.
+Many of DPDK's submissions guidelines draw from the kernel process,
+and the rationale behind them is often explained in greater depth there.
 
 
 The DPDK Development Process
 ----------------------------
 
-The DPDK development process has the following features:
+The DPDK development process includes the following key elements:
 
-* The code is hosted in a public git repository.
-* There is a mailing list where developers submit patches.
-* There are maintainers for hierarchical components.
+* Code is maintained in a public Git repository.
+* Developers submit patches via a public mailing list.
+* Maintainers are assigned to different components in a hierarchical structure.
 * Patches are reviewed publicly on the mailing list.
-* Successfully reviewed patches are merged to the repository.
-* Patches should be sent to the target repository or sub-tree, see below.
+* Once reviewed, patches are merged into the repository.
+* Patches should be sent to the target repository or sub-tree (see below for details).
 
 The mailing list for DPDK development is `dev@dpdk.org <https://mails.dpdk.org/archives/dev/>`_.
 Contributors will need to `register for the mailing list <https://mails.dpdk.org/listinfo/dev>`_ in order to submit patches.
-It is also worth registering for the DPDK `Patchwork <https://patches.dpdk.org/project/dpdk/list/>`_
+You should also register for DPDK `Patchwork <https://patches.dpdk.org/project/dpdk/list/>`_
 
-If you are using the GitHub service, pushing to a branch will trigger GitHub
-Actions to automatically build your changes and run unit tests and ABI checks.
+If you're using GitHub, pushing to a branch will trigger GitHub Actions
+which will build your changes and run unit tests and ABI checks.
 
-The development process requires some familiarity with the ``git`` version control system.
-Refer to the `Pro Git Book <http://www.git-scm.com/book/>`_ for further information.
+Contributing to DPDK requires a basic understanding of the Git control system.
+For more information, refer to the `Pro Git Book <http://www.git-scm.com/book/>`_.
 
 Source License
 --------------
 
-The DPDK uses the Open Source BSD-3-Clause license for the core libraries and
-drivers. The kernel components are GPL-2.0 licensed. DPDK uses single line
-reference to Unique License Identifiers in source files as defined by the Linux
-Foundation's `SPDX project <http://spdx.org/>`_.
+DPDK uses the Open Source BSD-3-Clause license for its core libraries and
+drivers. Kernel components are GPL-2.0 licensed.
+To identify licenses  in source files, DPDK follows the SPDX standard
+developed by the Linux Foundation `SPDX project <http://spdx.org/>`_.
 
-DPDK uses first line of the file to be SPDX tag. In case of *#!* scripts, SPDX
-tag can be placed in 2nd line of the file.
+The SPDX tag should by used on the first line of the file.
+In case of *#!* scripts, the SPDX tag should be placed on 2nd line.
 
-For example, to label a file as subject to the BSD-3-Clause license,
-the following text would be used:
+For BSD-3-Clause:
 
 ``SPDX-License-Identifier: BSD-3-Clause``
 
-To label a file as dual-licensed with BSD-3-Clause and GPL-2.0 (e.g., for code
-that is shared between the kernel and userspace), the following text would be
-used:
+For dual-licensing with BSD-3-Clause and GPL-2.0 (e.g.,shared kernel/user-space code):
 
 ``SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)``
 
@@ -87,37 +84,41 @@ Where:
 
 Additional details are given in the ``MAINTAINERS`` file.
 
-The role of the component maintainers is to:
+Component maintainers are responsible for the following:
 
-* Review patches for the component or delegate the review.
+* Reviewing patches related to their component or delegating the review to others.
   The review should be done, ideally, within 1 week of submission to the mailing list.
-* Add an ``acked-by`` to patches, or patchsets, that are ready for committing to a tree.
-* Reply to questions asked about the component.
+* Acknowledging patches by adding an ``acked-by`` tag to those deemed ready for merging.
+* Responding to questions regarding the component and offering guidance when needed.
+
+Maintainers can be added or removed by submitting a patch to the ``MAINTAINERS`` file.
+New maintainers should have demonstrated consistent contributions or reviews to the component area.
+Their addition should be confirmed by an ``ack`` from an established contributor.
+Multiple maintainers may be assigned to a single component, if needed.
+
+Tree Maintainer Responsibilities:
+
+Tree maintainers are responsible for ensuring the overall quality and integrity of their tree.
+Their duties include:
+
+* Conducting additional reviews, compilation checks, or other tests as needed.
+* Committing patches that have been sufficiently reviewed by component maintainers or other contributors.
+* Ensuring timely review of submitted patches.
+* Preparing the tree for integration.
+* Appointing a designated backup maintainer and coordinating handovers when unavailable.
 
-Component maintainers can be added or removed by submitting a patch to the ``MAINTAINERS`` file.
-Maintainers should have demonstrated a reasonable level of contributions or reviews to the component area.
-The maintainer should be confirmed by an ``ack`` from an established contributor.
-There can be more than one component maintainer if desired.
+Maintainer Changes:
 
-The role of the tree maintainers is to:
+Tree maintainers can be added or removed by submitting a patch to the MAINTAINERS file.
+Proposals must justify the creation of a new sub-tree and demonstrate a significant contribution
+to the relevant area. An ack from an existing tree maintainer is required.
 
-* Maintain the overall quality of their tree.
-  This can entail additional review, compilation checks or other tests deemed necessary by the maintainer.
-* Commit patches that have been reviewed by component maintainers and/or other contributors.
-  The tree maintainer should determine if patches have been reviewed sufficiently.
-* Ensure that patches are reviewed in a timely manner.
-* Prepare the tree for integration.
-* Ensure that there is a designated back-up maintainer and coordinate a handover for periods where the
-  tree maintainer can't perform their role.
+In case of disputes regarding trees or maintainers, issues may be escalated to the Technical Board.
 
-Tree maintainers can be added or removed by submitting a patch to the ``MAINTAINERS`` file.
-The proposer should justify the need for a new sub-tree and should have demonstrated a sufficient level of contributions in the area or to a similar area.
-The maintainer should be confirmed by an ``ack`` from an existing tree maintainer.
-Disagreements on trees or maintainers can be brought to the Technical Board.
+Backup Maintainers:
 
-The backup maintainer for the main tree should be selected
-from the existing sub-tree maintainers of the project.
-The backup maintainer for a sub-tree should be selected from among the component maintainers within that sub-tree.
+* The main tree's backup maintainer should be chosen from among existing sub-tree maintainers.
+* A sub-tree's backup should come from the component maintainers within that sub-tree.
 
 
 Getting the Source Code
@@ -135,63 +136,57 @@ sub-repositories (`list <https://git.dpdk.org/next>`_)::
     git clone git://dpdk.org/next/dpdk-next-*
     git clone https://dpdk.org/git/next/dpdk-next-*
 
-Make your Changes
------------------
 
-Make your planned changes in the cloned ``dpdk`` repo. Here are some guidelines and requirements:
 
-* Follow the :ref:`coding_style` guidelines.
+Make Changes
+------------
+
+Once you've cloned the DPDK repository, make your planned changes while following
+these key guidelines and requirements:
 
-* If you are a new contributor, or if your mail address changed,
-  you may update the ``.mailmap`` file.
-  Otherwise the new name or address will be added by a maintainer.
-  Keeping this file up-to-date will help when someone wants to contact you
-  about the changes you contributed to.
+* Follow the :ref:`coding_style` guidelines.
+* Update ``.mailmap`` if you’re a new contributor or have changed your email address.
+  Maintainers may also handle this, but keeping it current ensures others can contact you about your contributions.
+* Update ``MAINTAINERS`` if you add new files or directories, by adding your name under the appropriate section.
 
-* If you add new files or directories you should add your name to the ``MAINTAINERS`` file.
+PMD Submissions
+~~~~~~~~~~~~~~~
 
-* Initial submission of new PMDs should be prepared against a corresponding repo.
+Submit new PMDs to the appropriate next repo:
 
-  * Thus, for example, initial submission of a new network PMD should be
-    prepared against dpdk-next-net repo.
+* New network PMDs → dpdk-next-net
 
-  * Likewise, initial submission of a new crypto or compression PMD should be
-    prepared against dpdk-next-crypto repo.
+* New crypto or compression PMDs → dpdk-next-crypto
 
-  * For other PMDs and more info, refer to the ``MAINTAINERS`` file.
+* For other PMD types, refer to the MAINTAINERS file.
 
-* New external functions should be added to the local ``version.map`` file. See
-  the :doc:`ABI policy <abi_policy>` and :ref:`ABI versioning <abi_versioning>`
-  guides. New external functions should also be added in alphabetical order.
+API and ABI Guidelines
+~~~~~~~~~~~~~~~~~~~~~~
 
-* Any new API function should be used in ``/app`` test directory.
+* Add any new external functions to the relevant ``version.map`` file in alphabetical order.
+  Refer to the ABI policy and ABI versioning documentation.
 
-* When introducing a new device API, at least one driver should implement it.
+* New API functions should be accompanied by a corresponding test in the /app/test directory.
 
-* Important changes will require an addition to the release notes in ``doc/guides/rel_notes/``.
-  See the :ref:`Release Notes section of the Documentation Guidelines <doc_guidelines>` for details.
+* When adding a new device API, ensure that at least one driver implements it.
 
-* Test the compilation works with different targets, compilers and options, see :ref:`contrib_check_compilation`.
+Documentation and Release Notes
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-* Don't break compilation between commits with forward dependencies in a patchset.
-  Each commit should compile on its own to allow for ``git bisect`` and continuous integration testing.
+* Document new APIs using Doxygen-style comments.
 
-* Add tests to the ``app/test`` unit test framework where possible.
+* If needed, provide user-facing documentation in reStructuredText (RST) format, following the Documentation Guidelines.
 
-* Add documentation, if relevant, in the form of Doxygen comments or a User Guide in RST format.
-  See the :ref:`Documentation Guidelines <doc_guidelines>`.
+* For major changes, add an entry to the release notes under doc/guides/rel_notes/.
 
-* Code and related documentation must be updated atomically in the same patch.
+Compilation and Testing
+~~~~~~~~~~~~~~~~~~~~~~~
 
-Once the changes have been made you should commit them to your local repo.
+* Test compilation across different targets, compilers, and build options (see Checking Compilation :ref:`contrib_check_compilation`.).
 
-For small changes, that do not require specific explanations, it is better to keep things together in the
-same patch.
-Larger changes that require different explanations should be separated into logical patches in a patchset.
-A good way of thinking about whether a patch should be split is to consider whether the change could be
-applied without dependencies as a backport.
+* Each commit in a patchset must compile independently to support git bisect and CI testing.
 
-As a guide to how patches should be structured run ``git log`` on similar files.
+* Include unit tests in the app/test framework wherever applicable.
 
 
 Commit Messages: Subject Line
@@ -229,7 +224,7 @@ It is intended as a way of getting early feedback.
 Commit Messages: Body
 ---------------------
 
-Here are some guidelines for the body of a commit message:
+Here are guidelines for the body of a commit message:
 
 * The body of the message should describe the issue being fixed or the feature being added.
   It is important to provide enough information to allow a reviewer to understand the purpose of the patch.
@@ -566,6 +561,10 @@ Script ``get-maintainer.sh`` can be used to select maintainers automatically::
 
   git send-email --to-cmd ./devtools/get-maintainer.sh --cc dev@dpdk.org 000*.patch
 
+New additions can be sent without a maintainer::
+
+   git send-email --to dev@dpdk.org 000*.patch
+
 You can test the emails by sending it to yourself or with the ``--dry-run`` option.
 
 If the patch is in relation to a previous email thread you can add it to the same thread using the Message ID::
diff --git a/doc/guides/contributing/stable.rst b/doc/guides/contributing/stable.rst
index 808e7fa779..9e8b6d4f62 100644
--- a/doc/guides/contributing/stable.rst
+++ b/doc/guides/contributing/stable.rst
@@ -6,154 +6,117 @@
 DPDK Stable Releases and Long Term Support
 ==========================================
 
-This section sets out the guidelines for the DPDK Stable Releases and the DPDK
-Long Term Support releases (LTS).
 
+This section outlines the guidelines for DPDK Stable Releases and Long Term Support (LTS) Releases.
 
 Introduction
 ------------
 
-The purpose of the DPDK Stable Releases is to maintain releases of DPDK with
-backported fixes over an extended period of time. This provides downstream
-consumers of DPDK with a stable target on which to base applications or
-packages.
+The purpose of DPDK Stable Releases is to maintain DPDK versions with backported
+fixes over an extended period. This allows downstream users to base applications
+or packages on a stable, well-maintained version of DPDK.
 
-The primary characteristics of stable releases is that they attempt to
-fix issues and not introduce any new regressions while keeping backwards
-compatibility with the initial release of the stable version.
-
-The Long Term Support release (LTS) is a designation applied to a Stable
-Release to indicate longer term support.
+The primary goal of stable releases is to fix issues without introducing regressions,
+while preserving backward compatibility with the original version.
 
+LTS (Long Term Support) is a designation given to specific stable releases to indicate
+extended support duration.
 
 Stable Releases
 ---------------
 
-Any release of DPDK can be designated as a Stable Release if a
-maintainer volunteers to maintain it and there is a commitment from major
-contributors to validate it before releases.
-If a version is to be a "Stable Release", it should be designated as such
-within one month of that version being initially released.
-
-A Stable Release is used to backport fixes from an ``N`` release back to an
-``N-1`` release, for example, from 16.11 to 16.07.
-
-The duration of a stable is one complete release cycle (4 months). It can be
-longer, up to 1 year, if a maintainer continues to support the stable branch,
-or if users supply backported fixes, however the explicit commitment should be
-for one release cycle.
-
-The release cadence is determined by the maintainer based on the number of
-bugfixes and the criticality of the bugs. Releases should be coordinated with
-the validation engineers to ensure that a tagged release has been tested.
+Any DPDK release may become a Stable Release if a maintainer volunteers to support it
+and major contributors commit to validating it before each release. This designation
+should ideally be made within one month of the version’s initial release.
 
+Stable Releases are typically used to backport fixes from an N release to an N-1 release.
+For example: from version 16.11 to 16.07.
 
-LTS Release
------------
+- The standard support duration is one full release cycle (4 months).
+- This may extend up to one year if the maintainer continues support or if users provide backported fixes.
+- The release cadence is determined by the maintainer based on the volume and criticality of fixes.
+- Releases must be coordinated with validation engineers to ensure proper testing before tagging.
 
-A stable release can be designated as an LTS release based on community
-agreement and a commitment from a maintainer. The current policy is that each
-year's November (X.11) release will be maintained as an LTS for 3 years,
-however that is dependent on continued community support for validation.
+LTS Releases
+------------
 
-After the X.11 release, an LTS branch will be created for it at
-https://git.dpdk.org/dpdk-stable where bugfixes will be backported to.
+A Stable Release can be promoted to an LTS Release through community agreement and a maintainer’s commitment.
 
-A LTS release may align with the declaration of a new major ABI version,
-please read the :doc:`abi_policy` for more information.
+- The current policy designates each November release (X.11) as an LTS and maintains it for 3 years,
+  contingent on community validation support.
+- After release, an LTS branch is created at: https://git.dpdk.org/dpdk-stable
+- Fixes are backported to this branch.
+- LTS Releases may coincide with the declaration of a new major ABI version. Refer to the :ref:`abi_policy` for details.
 
-It is anticipated that there will be at least 3 releases per year of the LTS
-or approximately 1 every 4 months. This is done to align with the DPDK main
-branch releases so that fixes have already gone through validation as part of
-the DPDK main branch release validation. However, the cadence can be shorter or
-longer depending on the number and criticality of the backported
-fixes. Releases should be coordinated with the validation engineers to ensure
-that a tagged release has been tested.
+Release Cadence:
 
-For a list of the currently maintained stable/LTS branches please see
-the latest `stable roadmap <https://core.dpdk.org/roadmap/#stable>`_.
+- At least three LTS updates per year (roughly one every four months).
+- Aligned with main DPDK releases to leverage shared validation.
+- Frequency may vary depending on the urgency and volume of fixes.
+- As with stable releases, validation must be coordinated with test engineers.
 
-At the end of the 3 years, a final X.11.N release will be made and at that
-point the LTS branch will no longer be maintained with no further releases.
+For the latest list of supported Stable/LTS branches, refer to the current stable roadmap.
 
+At the end of the 3-year period, a final `X.11.N` release will be made, after which the LTS branch will no longer be maintained.
 
-What changes should be backported
+What Changes Should Be Backported
 ---------------------------------
 
-Backporting should be limited to bug fixes. All patches accepted on the main
-branch with a Fixes: tag should be backported to the relevant stable/LTS
-branches, unless the submitter indicates otherwise. If there are exceptions,
-they will be discussed on the mailing lists.
-
-Fixes suitable for backport should have a ``Cc: stable@dpdk.org`` tag in the
-commit message body as follows::
-
-     doc: fix some parameter description
+Backports should be limited to **bug fixes**.
 
-     Update the docs, fixing description of some parameter.
+All main-branch patches with a ``Fixes:`` tag should be considered for backport unless the
+submitter indicates otherwise. These patches must include a ``Cc: stable@dpdk.org`` tag in the commit message:
 
-     Fixes: abcdefgh1234 ("doc: add some parameter")
-     Cc: stable@dpdk.org
+.. code-block:: none
 
-     Signed-off-by: Alex Smith <alex.smith@example.com>
+   doc: fix parameter description
 
+   Update the docs to fix the description of a parameter.
 
-Fixes not suitable for backport should not include the ``Cc: stable@dpdk.org`` tag.
+   Fixes: abcdefgh1234 ("doc: add some parameter")
+   Cc: stable@dpdk.org
 
-To support the goal of stability and not introducing regressions,
-new code being introduced is limited to bug fixes.
-New features should not be backported to stable releases.
+   Signed-off-by: Alex Smith <alex.smith@example.com>
 
-In some limited cases, it may be acceptable to backport a new feature
-to a stable release. Some of the factors which impact the decision by
-stable maintainers are as follows:
+Patches **not** suitable for backport should omit the ``Cc: stable@dpdk.org`` tag.
 
-* Does the feature break API/ABI?
-* Does the feature break backwards compatibility?
-* Is it for the latest LTS release (to avoid LTS upgrade issues)?
-* Is there a commitment from the proposer or affiliation to validate the feature
-  and check for regressions in related functionality?
-* Is there a track record of the proposer or affiliation validating stable releases?
-* Is it obvious that the feature will not impact existing functionality?
-* How intrusive is the code change?
-* What is the scope of the code change?
-* Does it impact common components or vendor specific?
-* Is there a justifiable use case (a clear user need)?
-* Is there a community consensus about the backport?
+Backports must avoid introducing new features. However, in limited cases, a new feature may be allowed if:
 
-Performance improvements are generally not considered to be fixes,
-but may be considered in some cases where:
+- It does **not** break API or ABI.
+- It preserves **backward compatibility**.
+- It targets the latest LTS release (to help with upgrade paths).
+- The proposer commits to testing the feature and monitoring regressions.
+- The proposer or their organization has a strong track record of validating stable releases.
+- It clearly does not impact existing functionality.
+- The change is minimally invasive and scoped.
+- It affects vendor-specific components rather than common ones.
+- There is a compelling use case.
+- There is broad community support.
 
-* It is fixing a performance regression that occurred previously.
-* An existing feature in LTS is not usable as intended without it.
+Performance enhancements are generally not considered bug fixes, unless:
 
-APIs marked as ``experimental`` are not considered part of the ABI version
-and can be changed without prior notice. This is necessary for the API to be
-improved and stabilized and become part of the ABI version in the future.
+- They resolve a performance regression.
+- They are necessary to make an existing feature usable.
 
-However, in LTS releases ``experimental`` API should not be changed as there
-will not be a future ABI version on the branch and compatibility with previous
-release of an LTS version is of the highest importance.
+**Experimental APIs** are excluded from the ABI versioning and may be changed in mainline development.
+However, **experimental APIs must not be modified in LTS branches**, where stability and compatibility are paramount.
 
 The Stable Mailing List
 -----------------------
 
-The Stable and LTS release are coordinated on the stable@dpdk.org mailing
-list.
+Coordination for all Stable and LTS releases occurs on the ``stable@dpdk.org`` mailing list.
 
-All fix patches to the main branch that are candidates for backporting
-should also be CCed to the `stable@dpdk.org <https://mails.dpdk.org/listinfo/stable>`_
-mailing list.
+All fix patches intended for backporting should be CCed to this list when sent to the main branch.
 
 
 Releasing
 ---------
 
-A Stable Release will be released by:
+A Stable Release will be occur by:
 
 * Tagging the release with YY.MM.n (year, month, number).
 * Uploading a tarball of the release to dpdk.org.
 * Sending an announcement to the `announce@dpdk.org <https://mails.dpdk.org/listinfo/announce>`_
   list.
 
-Stable releases are available on the `dpdk.org download page <https://core.dpdk.org/download/>`_.
+Stable releases are available on the `dpdk.org download page <https://core.dpdk.org/download/>`_.
\ No newline at end of file
diff --git a/doc/guides/contributing/vulnerability.rst b/doc/guides/contributing/vulnerability.rst
index fc60e02e37..aee618f6ec 100644
--- a/doc/guides/contributing/vulnerability.rst
+++ b/doc/guides/contributing/vulnerability.rst
@@ -23,41 +23,33 @@ If in doubt, please consider the vulnerability as security sensitive.
 At worst, the response will be to report the bug through the usual channels.
 
 
-Finding
--------
+Finding Security Issues
+-----------------------
 
 There is no pro-active security engineering effort at the moment.
 
 Please report any security issue you find in DPDK as described below.
 
 
-Report
-------
+Reporting Security Issues
+-------------------------
 
-Do not use Bugzilla (unsecured).
-Instead, send GPG-encrypted emails
-to `security@dpdk.org <https://core.dpdk.org/security#contact>`_.
-Anyone can post to this list.
-In order to reduce the disclosure of a vulnerability in the early stages,
-membership of this list is intentionally limited to a `small number of people
-<https://mails.dpdk.org/roster/security>`_.
+Do not use Bugzilla to report security vulnerabilities, as it is not secured for such communication.
+Instead, send a GPG-encrypted email to `security@dpdk.org <https://core.dpdk.org/security#contact>`_.
+This address is open to all, but access to its inbox is intentionally limited to a small group
+to minimize the risk of early disclosure.
 
-It is additionally encouraged to GPG-sign one-on-one conversations
-as part of the security process.
+It is strongly recommended to GPG-sign any one-on-one correspondence related to the vulnerability
+report as part of maintaining a secure communication process.
 
-As it is with any bug, the more information provided,
-the easier it will be to diagnose and fix.
-If you already have a fix, please include it with your report,
-as that can speed up the process considerably.
+As with any bug report, detailed information greatly aids in diagnosing and resolving the issue.
+If you have already developed a fix, please include it in your submission to help accelerate resolution.
 
-In the report, please note how you would like to be credited
-for discovering the issue
-and the details of any embargo you would like to impose.
+In your report, specify how you would like to be credited for the discovery and mention any embargo
+period you wish to impose.
 
-If the vulnerability is not public yet,
-no patch or information should be disclosed publicly.
-If a fix is already published,
-the reporting process must be followed anyway, as described below.
+If the vulnerability has not yet been made public, do not disclose patches or related information
+publicly. Even if a fix has already been published, the proper reporting process outlined here must still be followed.
 
 
 Confirmation
@@ -91,7 +83,7 @@ using the standard patch process, once a CVE number has been assigned.
 
 The confirmation mail should be sent within **3 business days**.
 
-Following information must be included in the mail:
+The following information must be included in the mail:
 
 * Confirmation
 * CVSS severity and score
@@ -275,17 +267,18 @@ Private Disclosure Mail Template
 Public Disclosure
 -----------------
 
-On embargo expiration, following tasks will be done simultaneously:
+When the embargo expires, the following actions will be carried out simultaneously:
 
-* The assigned bug is filled by a member of the security team,
-  with all relevant information, and it is made public.
-* The patches are pushed to the appropriate branches.
-* For long and short term stable branches fixed,
-  new versions should be released.
+* A member of the security team files the assigned bug with all relevant details and makes it publicly accessible.
 
-Releases on Monday to Wednesday are preferred, so that system administrators
-do not have to deal with security updates over the weekend.
+* The associated patches are pushed to the appropriate branches.
 
+* Updated versions are released for all affected stable branches, both short-term and long-term.
+
+To ease adoption by system administrators, security releases are preferably
+scheduled between Monday and Wednesday, avoiding weekends.
+
+A security advisory is sent to announce@dpdk.org and the public OSS Security mailing list as soon as the patches are published.
 The security advisory is posted
 to `announce@dpdk.org <mailto:announce@dpdk.org>`_ and to `the public OSS-security
 mailing list <mailto:oss-security@lists.openwall.com>` as soon as the patches
-- 
2.34.1

