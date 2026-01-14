Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14AB9D3CC87
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 22:56:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B584F42790;
	Wed, 14 Jan 2026 23:56:15 +0100 (CET)
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65]) by mails.dpdk.org (Postfix) with ESMTP id D86A8427BB
 for <dev@dpdk.org>; Wed, 14 Jan 2026 23:56:13 +0100 (CET)
Received: by mail-wm1-f65.google.com with SMTP id
 5b1f17b1804b1-4779aa4f928so3358485e9.1
 for <dev@dpdk.org>; Wed, 14 Jan 2026 14:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768431373;
 x=1769036173; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yUHwqiLnIHaj1UiOlB0dLvN0zHM9x3nlPheurXjZYaY=;
 b=jSgDB084yubw9yrgD0/TvTTxocm9bdFeu21dy8Y+d+P0o6F8pU3WBR080CHf6H0Mrr
 /yt9TNIbtgLygIWFJjEULX5IXV3z4J8ZYLd8DDgrItz5fWOixs+UngeHqf5UHbtr3pJO
 /XFaM7VsIkMxJYRGiESEud3omBTz5ItpCiMJCrwMGDUdpfHKRL9CJa7vHsQDif6+JuQf
 bkQs9ns7YZsZpUo6PgRR8Oli72GshPndtC+o3B6F3T06mJxy3EqyDgpQvOGxEkpwxU09
 Xa7gPy02gyxABrJiyEBeZF9E+OQAgKjUu/OSEV9b3awHRrXuhnpiK06OfVRRZNd2x5r5
 odWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768431373; x=1769036173;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yUHwqiLnIHaj1UiOlB0dLvN0zHM9x3nlPheurXjZYaY=;
 b=OHzec46/xD1BcsAYVYogdHgcGDZ7JlMWo9hPVD1y3SC5x79YUK13fR6kmQPSfBrgPh
 K1XfU3UrrftNtOCbnE/r5L36V0ABWmAl0bb8vDOhec3RgViKkrxkL58cBneGR3HP5Kip
 tzvzktkqLEScKwoeA8mKc5CyFAYUD3GICZ72xf7Ob/LEB2E6NQtFeeXuHVL9JzmvijL4
 clwz0RKXhL3cE24/I07OKjsGSFMtGFAICzLmBvjKJFFcmlj0s10PWfHtcvFwuRmry9Cw
 P5ZAc6zlNtLshQcIcXbiOfbmO36dYhdwOimb/ohRC19pyRIM9+JpjSp2g/SoRXAV3GIt
 UIXg==
X-Gm-Message-State: AOJu0YwByTH83Zsi0VZxHY1s+TJ/qBjQ6t8n9QByCpqFpuXV9gANv5Nn
 SrAQuL61oJRVRUNu61RvEWe6M2uVbkFeNE/SoQIitRmULP7q0f4919beAaJDp/WEA+ItaqJlb0u
 R0rxB
X-Gm-Gg: AY/fxX7BH2VT4c+TDN4K5d9FdZPd5BjPrjj4UW9zvdRM/E9Y2Z/BRHRe0kBqIyOYxSu
 DD5dGxhjbB+JnmwZrOpu8WiubLLou2ed3ycmG8+DF3cGBwi7+nA2S/XL0yAZd+qhdGjfBdcn+vr
 stXln4mg/vKKyd4SQ+s7nD4qF37pEEbRbNNutZN0+BrOsv34kuCkZ44vtFn6nFWoz8aEaxgMaMt
 rK6GQ6ZjEYhwCqSxclt6xAkjndRRz65CU8zLfCyhjkMAvrSzNAUT3r/Ou+QjVtZPfWjhUX1MZST
 4Kp+HYyCbOez5o46Hmk8gqdKZ4UARqPufiVfCWy6E5qAECmVBQVIB2v7+SCn4VnecUXl/X9nkm8
 Jmv8zCCwnP/ZxNXtWaEwEwMBC4xdl0xNThEZbYYAzVEHenlwP7jFrh2iP/1ENPe6I+n7Mv7/UxO
 dF+13uRe5RXJuSml1cnByy68f1J0bk5PQcNOzl+4oeYB4DyXulOg==
X-Received: by 2002:a05:600c:c16a:b0:477:1af2:f40a with SMTP id
 5b1f17b1804b1-47ee334d0aemr57528095e9.17.1768431372973; 
 Wed, 14 Jan 2026 14:56:12 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f428af0c7sm12999125e9.4.2026.01.14.14.56.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 14:56:12 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 08/11] doc: improve patch submission guide readability
Date: Wed, 14 Jan 2026 14:54:12 -0800
Message-ID: <20260114225555.127448-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114225555.127448-1-stephen@networkplumber.org>
References: <20260114225555.127448-1-stephen@networkplumber.org>
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

Improve the patch submission documentation
- Converting passive voice to active voice throughout
- Using imperative mood for instructions
- Reorganizing content with clearer section headers
- Simplifying wordy constructions
- Removing redundant phrases

No technical content changes.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/contributing/patches.rst | 434 ++++++++++++++--------------
 1 file changed, 224 insertions(+), 210 deletions(-)

diff --git a/doc/guides/contributing/patches.rst b/doc/guides/contributing/patches.rst
index 069a18e4ec..129952dc76 100644
--- a/doc/guides/contributing/patches.rst
+++ b/doc/guides/contributing/patches.rst
@@ -6,55 +6,53 @@
 Contributing Code to DPDK
 =========================
 
-This document outlines the guidelines for submitting code to DPDK.
+This document provides guidelines for submitting code to DPDK.
 
-The DPDK development process is modeled (loosely) on the Linux Kernel development model so it is worth reading the
-Linux kernel guide on submitting patches:
+The DPDK development process is loosely based on the Linux Kernel development
+model. Review the Linux kernel's guide:
 `How to Get Your Change Into the Linux Kernel <https://www.kernel.org/doc/html/latest/process/submitting-patches.html>`_.
-The rationale for many of the DPDK guidelines is explained in greater detail in the kernel guidelines.
+Many of DPDK's submission guidelines draw from the kernel process,
+and the rationale behind them is often explained in greater depth there.
 
 
 The DPDK Development Process
 ----------------------------
 
-The DPDK development process has the following features:
+The DPDK development process includes the following key elements:
 
-* The code is hosted in a public git repository.
-* There is a mailing list where developers submit patches.
-* There are maintainers for hierarchical components.
-* Patches are reviewed publicly on the mailing list.
-* Successfully reviewed patches are merged to the repository.
-* Patches should be sent to the target repository or sub-tree, see below.
+* The project maintains code in a public Git repository.
+* Developers submit patches via a public mailing list.
+* A hierarchical structure assigns maintainers to different components.
+* The community reviews patches publicly on the mailing list.
+* Maintainers merge reviewed patches into the repository.
+* Contributors should send patches to the target repository or sub-tree (see below for details).
 
 The mailing list for DPDK development is `dev@dpdk.org <https://mails.dpdk.org/archives/dev/>`_.
-Contributors will need to `register for the mailing list <https://mails.dpdk.org/listinfo/dev>`_ in order to submit patches.
-It is also worth registering for the DPDK `Patchwork <https://patches.dpdk.org/project/dpdk/list/>`_
+Contributors must `register for the mailing list <https://mails.dpdk.org/listinfo/dev>`_ to submit patches.
+Register for DPDK `Patchwork <https://patches.dpdk.org/project/dpdk/list/>`_ as well.
 
-If you are using the GitHub service, pushing to a branch will trigger GitHub
-Actions to automatically build your changes and run unit tests and ABI checks.
+If you use GitHub, pushing to a branch triggers GitHub Actions,
+which builds your changes and runs unit tests and ABI checks.
 
-The development process requires some familiarity with the ``git`` version control system.
-Refer to the `Pro Git Book <http://www.git-scm.com/book/>`_ for further information.
+Contributing to DPDK requires a basic understanding of the Git version control system.
+For more information, refer to the `Pro Git Book <http://www.git-scm.com/book/>`_.
 
 Source License
 --------------
 
-The DPDK uses the Open Source BSD-3-Clause license for the core libraries and
-drivers. The kernel components are GPL-2.0 licensed. DPDK uses single line
-reference to Unique License Identifiers in source files as defined by the Linux
-Foundation's `SPDX project <http://spdx.org/>`_.
+DPDK uses the Open Source BSD-3-Clause license for its core libraries and
+drivers. Kernel components use the GPL-2.0 license.
+To identify licenses in source files, DPDK follows the SPDX standard
+developed by the Linux Foundation `SPDX project <http://spdx.org/>`_.
 
-DPDK uses first line of the file to be SPDX tag. In case of *#!* scripts, SPDX
-tag can be placed in 2nd line of the file.
+Use the SPDX tag on the first line of the file.
+For *#!* scripts, place the SPDX tag on the second line.
 
-For example, to label a file as subject to the BSD-3-Clause license,
-the following text would be used:
+For BSD-3-Clause:
 
 ``SPDX-License-Identifier: BSD-3-Clause``
 
-To label a file as dual-licensed with BSD-3-Clause and GPL-2.0 (e.g., for code
-that is shared between the kernel and userspace), the following text would be
-used:
+For dual-licensing with BSD-3-Clause and GPL-2.0 (e.g., shared kernel/user-space code):
 
 ``SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)``
 
@@ -63,11 +61,11 @@ Refer to ``licenses/README`` for more details.
 Maintainers and Sub-trees
 -------------------------
 
-The DPDK maintenance hierarchy is divided into a main repository ``dpdk`` and sub-repositories ``dpdk-next-*``.
+The DPDK maintenance hierarchy divides into a main repository ``dpdk`` and sub-repositories ``dpdk-next-*``.
 
-There are maintainers for the trees and for components within the tree.
+Maintainers exist for the trees and for components within the tree.
 
-Trees and maintainers are listed in the ``MAINTAINERS`` file. For example::
+The ``MAINTAINERS`` file lists trees and maintainers. For example::
 
     Crypto Drivers
     --------------
@@ -85,45 +83,49 @@ Where:
 * ``T`` is a repository tree.
 * ``F`` is a maintained file or directory.
 
-Additional details are given in the ``MAINTAINERS`` file.
+The ``MAINTAINERS`` file contains additional details.
 
-The role of the component maintainers is to:
+Component maintainers are responsible for:
 
-* Review patches for the component or delegate the review.
-  The review should be done, ideally, within 1 week of submission to the mailing list.
-* Add an ``acked-by`` to patches, or patchsets, that are ready for committing to a tree.
-* Reply to questions asked about the component.
+* Reviewing patches related to their component or delegating review to others.
+  Ideally, complete reviews within one week of mailing list submission.
+* Acknowledging patches by adding an ``acked-by`` tag to those deemed ready for merging.
+* Responding to questions regarding the component and offering guidance when needed.
 
-Component maintainers can be added or removed by submitting a patch to the ``MAINTAINERS`` file.
-Maintainers should have demonstrated a reasonable level of contributions or reviews to the component area.
-The maintainer should be confirmed by an ``ack`` from an established contributor.
-There can be more than one component maintainer if desired.
+Add or remove maintainers by submitting a patch to the ``MAINTAINERS`` file.
+New maintainers should have demonstrated consistent contributions or reviews to the component area.
+An established contributor must confirm their addition with an ``ack``.
+A single component may have multiple maintainers if needed.
 
-The role of the tree maintainers is to:
+Tree Maintainer Responsibilities:
 
-* Maintain the overall quality of their tree.
-  This can entail additional review, compilation checks or other tests deemed necessary by the maintainer.
-* Commit patches that have been reviewed by component maintainers and/or other contributors.
-  The tree maintainer should determine if patches have been reviewed sufficiently.
-* Ensure that patches are reviewed in a timely manner.
-* Prepare the tree for integration.
-* Ensure that there is a designated back-up maintainer and coordinate a handover for periods where the
-  tree maintainer can't perform their role.
+Tree maintainers ensure the overall quality and integrity of their tree.
+Their duties include:
 
-Tree maintainers can be added or removed by submitting a patch to the ``MAINTAINERS`` file.
-The proposer should justify the need for a new sub-tree and should have demonstrated a sufficient level of contributions in the area or to a similar area.
-The maintainer should be confirmed by an ``ack`` from an existing tree maintainer.
-Disagreements on trees or maintainers can be brought to the Technical Board.
+* Conducting additional reviews, compilation checks, or other tests as needed.
+* Committing patches that component maintainers or other contributors have sufficiently reviewed.
+* Ensuring timely review of submitted patches.
+* Preparing the tree for integration.
+* Appointing a designated backup maintainer and coordinating handovers when unavailable.
 
-The backup maintainer for the main tree should be selected
-from the existing sub-tree maintainers of the project.
-The backup maintainer for a sub-tree should be selected from among the component maintainers within that sub-tree.
+Maintainer Changes:
+
+Add or remove tree maintainers by submitting a patch to the MAINTAINERS file.
+Proposals must justify the creation of a new sub-tree and demonstrate significant contribution
+to the relevant area. An existing tree maintainer must ack the proposal.
+
+Escalate disputes regarding trees or maintainers to the Technical Board.
+
+Backup Maintainers:
+
+* Choose the main tree's backup maintainer from among existing sub-tree maintainers.
+* Choose a sub-tree's backup from the component maintainers within that sub-tree.
 
 
 Getting the Source Code
 -----------------------
 
-The source code can be cloned using either of the following:
+Clone the source code using either of the following:
 
 main repository::
 
@@ -135,63 +137,72 @@ sub-repositories (`list <https://git.dpdk.org/next>`_)::
     git clone git://dpdk.org/next/dpdk-next-*
     git clone https://dpdk.org/git/next/dpdk-next-*
 
-Make your Changes
------------------
+Make Changes
+------------
 
-Make your planned changes in the cloned ``dpdk`` repo. Here are some guidelines and requirements:
+After cloning the DPDK repository, make your planned changes while following
+these key guidelines and requirements:
 
 * Follow the :ref:`coding_style` guidelines.
 
 * If you are a new contributor, or if your mail address changed,
   you may update the ``.mailmap`` file.
-  Otherwise the new name or address will be added by a maintainer.
-  Keeping this file up-to-date will help when someone wants to contact you
-  about the changes you contributed to.
+  Otherwise a maintainer will add the new name or address.
+  Keeping this file up-to-date helps when someone wants to contact you
+  about the changes you contributed.
+
+* If you add new files or directories, add your name to the ``MAINTAINERS`` file.
 
-* If you add new files or directories you should add your name to the ``MAINTAINERS`` file.
+PMD Submissions
+~~~~~~~~~~~~~~~
 
-* Initial submission of new PMDs should be prepared against a corresponding repo.
+* Prepare initial submissions of new PMDs against the corresponding repo.
 
-  * Thus, for example, initial submission of a new network PMD should be
-    prepared against dpdk-next-net repo.
+  * For example, prepare initial submission of a new network PMD
+    against the dpdk-next-net repo.
 
-  * Likewise, initial submission of a new crypto or compression PMD should be
-    prepared against dpdk-next-crypto repo.
+  * Likewise, prepare initial submission of a new crypto or compression PMD
+    against the dpdk-next-crypto repo.
 
   * For other PMDs and more info, refer to the ``MAINTAINERS`` file.
 
-* New external functions should be exported.
+* Export new external functions.
   See the :doc:`ABI policy <abi_policy>` and :ref:`ABI versioning <abi_versioning>`
   guides.
 
-* Any new API function should be used in ``/app`` test directory.
+API and ABI Guidelines
+~~~~~~~~~~~~~~~~~~~~~~
+
+* Use any new API function in the ``/app`` test directory.
 
 * When introducing a new device API, at least one driver should implement it.
 
-* Important changes will require an addition to the release notes in ``doc/guides/rel_notes/``.
+Documentation and Release Notes
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+* Important changes require an addition to the release notes in ``doc/guides/rel_notes/``.
   See the :ref:`Release Notes section of the Documentation Guidelines <doc_guidelines>` for details.
 
-* Test the compilation works with different targets, compilers and options, see :ref:`contrib_check_compilation`.
+* Test compilation with different targets, compilers, and options; see :ref:`contrib_check_compilation`.
 
-* Don't break compilation between commits with forward dependencies in a patchset.
-  Each commit should compile on its own to allow for ``git bisect`` and continuous integration testing.
+* Do not break compilation between commits with forward dependencies in a patch set.
+  Each commit should compile on its own to allow ``git bisect`` and continuous integration testing.
 
 * Add tests to the ``app/test`` unit test framework where possible.
 
 * Add documentation, if relevant, in the form of Doxygen comments or a User Guide in RST format.
   See the :ref:`Documentation Guidelines <doc_guidelines>`.
 
-* Code and related documentation must be updated atomically in the same patch.
+* Update code and related documentation atomically in the same patch.
 
-Once the changes have been made you should commit them to your local repo.
+Commit your changes to your local repo after making them.
 
-For small changes, that do not require specific explanations, it is better to keep things together in the
-same patch.
-Larger changes that require different explanations should be separated into logical patches in a patchset.
-A good way of thinking about whether a patch should be split is to consider whether the change could be
-applied without dependencies as a backport.
+Keep small changes that do not require specific explanations in a single patch.
+Separate larger changes that require different explanations into logical patches in a patch set.
+Consider whether the change could be applied without dependencies as a backport
+when deciding whether to split a patch.
 
-As a guide to how patches should be structured run ``git log`` on similar files.
+Run ``git log`` on similar files as a guide to how patches should be structured.
 
 
 Commit Messages: Subject Line
@@ -206,7 +217,7 @@ Here are some guidelines for the summary line:
 
 * The summary line should be lowercase apart from acronyms.
 
-* It should be prefixed with the component name (use git log to check existing components).
+* Prefix with the component name (use git log to check existing components).
   For example::
 
      ixgbe: fix offload config option name
@@ -215,54 +226,54 @@ Here are some guidelines for the summary line:
 
 * Use the imperative of the verb (like instructions to the code base).
 
-* Don't add a period/full stop to the subject line or you will end up two in the patch name: ``dpdk_description..patch``.
+* Do not add a period/full stop to the subject line or you will end up with two in the patch name: ``dpdk_description..patch``.
 
 The actual email subject line should be prefixed by ``[PATCH]`` and the version, if greater than v1,
 for example: ``PATCH v2``.
-The is generally added by ``git send-email`` or ``git format-patch``, see below.
+``git send-email`` or ``git format-patch`` generally adds this prefix; see below.
 
-If you are submitting an RFC draft of a feature you can use ``[RFC]`` instead of ``[PATCH]``.
-An RFC patch doesn't have to be complete.
+If you are submitting an RFC draft of a feature, use ``[RFC]`` instead of ``[PATCH]``.
+An RFC patch does not have to be complete.
 It is intended as a way of getting early feedback.
 
 
 Commit Messages: Body
 ---------------------
 
-Here are some guidelines for the body of a commit message:
+Here are guidelines for the body of a commit message:
 
 * The body of the message should describe the issue being fixed or the feature being added.
-  It is important to provide enough information to allow a reviewer to understand the purpose of the patch.
+  Provide enough information to allow a reviewer to understand the purpose of the patch.
 
-* When the change is obvious the body can be blank, apart from the signoff.
+* When the change is obvious, the body can be blank apart from the signoff.
 
-* The commit message must end with a ``Signed-off-by:`` line which is added using::
+* The commit message must end with a ``Signed-off-by:`` line, added using::
 
       git commit --signoff # or -s
 
-  The purpose of the signoff is explained in the
+  The
   `Developer's Certificate of Origin <https://www.kernel.org/doc/html/latest/process/submitting-patches.html#developer-s-certificate-of-origin-1-1>`_
-  section of the Linux kernel guidelines.
+  section of the Linux kernel guidelines explains the purpose of the signoff.
 
   .. Note::
 
-     All developers must ensure that they have read and understood the
+     All developers must read and understand the
      Developer's Certificate of Origin section of the documentation prior
      to applying the signoff and submitting a patch.
 
 * The signoff must be a real name and not an alias or nickname.
   More than one signoff is allowed.
 
-* The text of the commit message should be wrapped at 72 characters.
+* Wrap the text of the commit message at 72 characters.
 
-* When fixing a regression, it is required to reference the id of the commit
+* When fixing a regression, reference the id of the commit
   which introduced the bug, and put the original author of that commit on CC.
-  You can generate the required lines using the following git alias, which prints
+  Generate the required lines using the following git alias, which prints
   the commit SHA and the author of the original code::
 
      git config alias.fixline "log -1 --abbrev=12 --format='Fixes: %h (\"%s\")%nCc: %ae'"
 
-  The output of ``git fixline <SHA>`` must then be added to the commit message::
+  Add the output of ``git fixline <SHA>`` to the commit message::
 
      doc: fix some parameter description
 
@@ -274,12 +285,12 @@ Here are some guidelines for the body of a commit message:
      ---
      Cc: author@example.com
 
-* When fixing an error or warning it is useful to add the error message and instructions on how to reproduce it.
+* When fixing an error or warning, include the error message and instructions on how to reproduce it.
 
-* Use correct capitalization, punctuation and spelling.
+* Use correct capitalization, punctuation, and spelling.
 
-In addition to the ``Signed-off-by:`` name the commit messages can also have
-tags for who reported, suggested, tested and reviewed the patch being
+In addition to the ``Signed-off-by:`` name, commit messages can also have
+tags for who reported, suggested, tested, and reviewed the patch being
 posted. Please refer to the `Tested, Acked and Reviewed by`_ section.
 
 Patch Fix Related Issues
@@ -287,7 +298,7 @@ Patch Fix Related Issues
 
 `Coverity <https://scan.coverity.com/projects/dpdk-data-plane-development-kit>`_
 is a tool for static code analysis.
-It is used as a cloud-based service used to scan the DPDK source code,
+It is used as a cloud-based service to scan the DPDK source code
 and alert developers of any potential defects in the source code.
 When fixing an issue found by Coverity, the patch must contain a Coverity issue ID
 in the body of the commit message. For example::
@@ -308,7 +319,7 @@ in the body of the commit message. For example::
 `Bugzilla <https://bugs.dpdk.org>`_
 is a bug- or issue-tracking system.
 Bug-tracking systems allow individual or groups of developers
-effectively to keep track of outstanding problems with their product.
+to effectively track outstanding problems with their product.
 When fixing an issue raised in Bugzilla, the patch must contain
 a Bugzilla issue ID in the body of the commit message.
 For example::
@@ -327,10 +338,10 @@ For example::
 Patch for Stable Releases
 ~~~~~~~~~~~~~~~~~~~~~~~~~
 
-All fix patches to the main branch that are candidates for backporting
-should also be CCed to the `stable@dpdk.org <https://mails.dpdk.org/listinfo/stable>`_
+CC all fix patches to the main branch that are candidates for backporting
+to the `stable@dpdk.org <https://mails.dpdk.org/listinfo/stable>`_
 mailing list.
-In the commit message body the Cc: stable@dpdk.org should be inserted as follows::
+In the commit message body, insert ``Cc: stable@dpdk.org`` as follows::
 
      doc: fix some parameter description
 
@@ -341,19 +352,19 @@ In the commit message body the Cc: stable@dpdk.org should be inserted as follows
 
      Signed-off-by: Alex Smith <alex.smith@example.com>
 
-For further information on stable contribution you can go to
+For further information on stable contribution, see
 :doc:`Stable Contribution Guide <stable>`.
 
 Patch Dependencies
 ~~~~~~~~~~~~~~~~~~
 
-Sometimes a patch or patchset can depend on another one.
-To help the maintainers and automation tasks, please document this dependency in commit log or cover letter
+Sometimes a patch or patch set depends on another one.
+To help the maintainers and automation tasks, document this dependency in the commit log or cover letter
 with the following syntax:
 
 ``Depends-on: series-NNNNN ("Title of the series")`` or ``Depends-on: patch-NNNNN ("Title of the patch")``
 
-Where ``NNNNN`` is patchwork ID for patch or series::
+Where ``NNNNN`` is the patchwork ID for the patch or series::
 
      doc: fix some parameter description
 
@@ -366,7 +377,7 @@ Where ``NNNNN`` is patchwork ID for patch or series::
 Tag order
 ~~~~~~~~~
 
-There is a pattern indicating how certain tags should relate to each other.
+A pattern indicates how certain tags should relate to each other.
 
 Example of proper tag sequence::
 
@@ -382,22 +393,22 @@ Example of proper tag sequence::
      Reviewed-by:
      Tested-by:
 
-Between first and second tag section there is and empty line.
+An empty line separates the first and second tag sections.
 
-While ``Signed-off-by:`` is an obligatory tag and must exist in each commit,
+While ``Signed-off-by:`` is obligatory and must exist in each commit,
 all other tags are optional.
-Any tag, as long as it is in proper location to other adjacent tags (if present),
+Any tag, as long as it is in proper location relative to other adjacent tags (if present),
 may occur multiple times.
 
-Tags after the first occurrence of ``Signed-off-by:`` shall be laid out
-in a chronological order.
+Place tags after the first occurrence of ``Signed-off-by:``
+in chronological order.
 
 
 Creating Patches
 ----------------
 
-It is possible to send patches directly from git but for new contributors it is recommended to generate the
-patches with ``git format-patch`` and then when everything looks okay, and the patches have been checked, to
+You can send patches directly from git, but for new contributors it is recommended to generate the
+patches with ``git format-patch`` and then, when everything looks okay and the patches have been checked,
 send them with ``git send-email``.
 
 Here are some examples of using ``git format-patch`` to generate patches:
@@ -413,15 +424,15 @@ Here are some examples of using ``git format-patch`` to generate patches:
    # Generate the patches in a directory.
    git format-patch -3 -o ~/patch/
 
-   # Add a cover letter to explain a patchset.
+   # Add a cover letter to explain a patch set.
    git format-patch -3 -o ~/patch/ --cover-letter
 
    # Add a prefix with a version number.
    git format-patch -3 -o ~/patch/ -v 2
 
 
-Cover letters are useful for explaining a patchset and help to generate a logical threading to the patches.
-Smaller notes can be put inline in the patch after the ``---`` separator, for example::
+Cover letters are useful for explaining a patch set and help generate logical threading to the patches.
+Put smaller notes inline in the patch after the ``---`` separator, for example::
 
    Subject: [PATCH] fm10k/base: add FM10420 device ids
 
@@ -438,8 +449,8 @@ Smaller notes can be put inline in the patch after the ``---`` separator, for ex
     2 files changed, 12 insertions(+)
    ...
 
-Version 2 and later of a patchset should also include a short log of the changes so the reviewer knows what has changed.
-This can be added to the cover letter or the annotations.
+Version 2 and later of a patch set should also include a short log of the changes so the reviewer knows what has changed.
+Add this to the cover letter or the annotations.
 For example::
 
    ---
@@ -457,32 +468,32 @@ For example::
 Checking the Patches
 --------------------
 
-Patches should be checked for formatting and syntax issues using the ``checkpatches.sh`` script in the ``devtools``
+Check patches for formatting and syntax issues using the ``checkpatches.sh`` script in the ``devtools``
 directory of the DPDK repo.
-This uses the Linux kernel development tool ``checkpatch.pl`` which  can be obtained by cloning, and periodically,
-updating the Linux kernel sources.
+This uses the Linux kernel development tool ``checkpatch.pl``, which can be obtained by cloning, and periodically
+updating, the Linux kernel sources.
 
-The path to the original Linux script must be set in the environment variable ``DPDK_CHECKPATCH_PATH``.
+Set the path to the original Linux script in the environment variable ``DPDK_CHECKPATCH_PATH``.
 
 Spell checking of commonly misspelled words is enabled
 by default if installed in ``/usr/share/codespell/dictionary.txt``.
-A different dictionary path can be specified
+Specify a different dictionary path
 in the environment variable ``DPDK_CHECKPATCH_CODESPELL``.
 
-There is a DPDK script to build an adjusted dictionary
+A DPDK script builds an adjusted dictionary
 from the multiple codespell dictionaries::
 
    git clone https://github.com/codespell-project/codespell.git
    devtools/build-dict.sh codespell/ > codespell-dpdk.txt
 
-Environment variables required by the development tools,
-are loaded from the following files, in order of preference::
+The development tools load environment variables
+from the following files, in order of preference::
 
    .develconfig
    ~/.config/dpdk/devel.config
    /etc/dpdk/devel.config.
 
-Once the environment variable is set, the script can be run as follows::
+Once the environment variable is set, run the script as follows::
 
    devtools/checkpatches.sh ~/patch/
 
@@ -490,34 +501,34 @@ The script usage is::
 
    checkpatches.sh [-h] [-q] [-v] [-nX|-r range|patch1 [patch2] ...]
 
-Then the git logs should be checked using the ``check-git-log.sh`` script.
+Then check the git logs using the ``check-git-log.sh`` script.
 
 The script usage is::
 
    check-git-log.sh [-h] [-nX|-r range]
 
-For both of the above scripts, the -n option is used to specify a number of commits from HEAD,
-and the -r option allows the user specify a ``git log`` range.
+For both scripts, the -n option specifies a number of commits from HEAD,
+and the -r option specifies a ``git log`` range.
 
-Additionally, when contributing to the DTS tool, patches should also be checked using
+Additionally, when contributing to the DTS tool, check patches using
 the ``dts-check-format.sh`` script in the ``devtools`` directory of the DPDK repo.
-To run the script, extra :ref:`Python dependencies <dts_deps>` are needed.
+Running the script requires extra :ref:`Python dependencies <dts_deps>`.
 
 .. _contrib_check_compilation:
 
 Checking Compilation
 --------------------
 
-Compilation of patches is to be tested with ``devtools/test-meson-builds.sh`` script.
+Test compilation of patches with the ``devtools/test-meson-builds.sh`` script.
 
 The script internally checks for dependencies, then builds for several
 combinations of compilation configuration.
-By default, each build will be put in a subfolder of the current working directory.
-However, if it is preferred to place the builds in a different location,
-the environment variable ``DPDK_BUILD_TEST_DIR`` can be set to that desired location.
-For example, setting ``DPDK_BUILD_TEST_DIR=__builds`` will put all builds
+By default, each build goes in a subfolder of the current working directory.
+However, to place the builds in a different location,
+set the environment variable ``DPDK_BUILD_TEST_DIR`` to that desired location.
+For example, setting ``DPDK_BUILD_TEST_DIR=__builds`` puts all builds
 in a single subfolder called "__builds" created in the current directory.
-Setting ``DPDK_BUILD_TEST_DIR`` to an absolute directory path e.g. ``/tmp`` is also supported.
+Setting ``DPDK_BUILD_TEST_DIR`` to an absolute directory path (e.g., ``/tmp``) is also supported.
 
 
 .. _integrated_abi_check:
@@ -527,15 +538,15 @@ Checking ABI compatibility
 
 By default, ABI compatibility checks are disabled.
 
-To enable them, a reference version must be selected via the environment
+To enable them, select a reference version via the environment
 variable ``DPDK_ABI_REF_VERSION``. Contributors should ordinarily reference the
 git tag of the most recent release of DPDK in ``DPDK_ABI_REF_VERSION``.
 
-The ``devtools/test-meson-builds.sh`` script then build this reference version
-in a temporary directory and store the results in a subfolder of the current
+The ``devtools/test-meson-builds.sh`` script then builds this reference version
+in a temporary directory and stores the results in a subfolder of the current
 working directory.
-The environment variable ``DPDK_ABI_REF_DIR`` can be set so that the results go
-to a different location.
+Set the environment variable ``DPDK_ABI_REF_DIR`` to place the results in
+a different location.
 
 Sample::
 
@@ -545,8 +556,8 @@ Sample::
 Sending Patches
 ---------------
 
-Patches should be sent to the mailing list using ``git send-email``.
-You can configure an external SMTP with something like the following::
+Send patches to the mailing list using ``git send-email``.
+Configure an external SMTP with something like the following::
 
    [sendemail]
        smtpuser = name@domain.com
@@ -556,27 +567,31 @@ You can configure an external SMTP with something like the following::
 
 See the `Git send-email <https://git-scm.com/docs/git-send-email>`_ documentation for more details.
 
-The patches should be sent to ``dev@dpdk.org``.
-If the patches are a change to existing files then you should send them TO the maintainer(s) and CC ``dev@dpdk.org``.
-The appropriate maintainer can be found in the ``MAINTAINERS`` file::
+Send patches to ``dev@dpdk.org``.
+If the patches change existing files, send them TO the maintainer(s) and CC ``dev@dpdk.org``.
+Find the appropriate maintainer in the ``MAINTAINERS`` file::
 
    git send-email --to maintainer@some.org --cc dev@dpdk.org 000*.patch
 
-Script ``get-maintainer.sh`` can be used to select maintainers automatically::
+The script ``get-maintainer.sh`` can select maintainers automatically::
 
   git send-email --to-cmd ./devtools/get-maintainer.sh --cc dev@dpdk.org 000*.patch
 
-You can test the emails by sending it to yourself or with the ``--dry-run`` option.
+Send new additions without a maintainer::
+
+   git send-email --to dev@dpdk.org 000*.patch
+
+Test the emails by sending them to yourself or with the ``--dry-run`` option.
 
-If the patch is in relation to a previous email thread you can add it to the same thread using the Message ID::
+If the patch relates to a previous email thread, add it to the same thread using the Message ID::
 
    git send-email --to dev@dpdk.org --in-reply-to <1234-foo@bar.com> 000*.patch
 
-The Message ID can be found in the raw text of emails or at the top of each Patchwork patch,
+Find the Message ID in the raw text of emails or at the top of each Patchwork patch,
 `for example <https://patches.dpdk.org/patch/7646/>`_.
 Shallow threading (``--thread --no-chain-reply-to``) is preferred for a patch series.
 
-Once submitted your patches will appear on the mailing list and in Patchwork.
+Once submitted, your patches appear on the mailing list and in Patchwork.
 
 Experienced committers may send patches directly with ``git send-email`` without the ``git format-patch`` step.
 The options ``--annotate`` and ``confirm = always`` are recommended for checking patches before sending.
@@ -587,11 +602,11 @@ Backporting patches for Stable Releases
 
 Sometimes a maintainer or contributor wishes, or can be asked, to send a patch
 for a stable release rather than mainline.
-In this case the patch(es) should be sent to ``stable@dpdk.org``,
+In this case, send the patch(es) to ``stable@dpdk.org``,
 not to ``dev@dpdk.org``.
 
-Given that there are multiple stable releases being maintained at the same time,
-please specify exactly which branch(es) the patch is for
+Given that multiple stable releases are maintained simultaneously,
+specify exactly which branch(es) the patch is for
 using ``git send-email --subject-prefix='PATCH 16.11' ...``
 and also optionally in the cover letter or in the annotation.
 
@@ -599,7 +614,7 @@ and also optionally in the cover letter or in the annotation.
 The Review Process
 ------------------
 
-Patches are reviewed by the community, relying on the experience and
+The community reviews patches, relying on the experience and
 collaboration of the members to double-check each other's work. There are a
 number of ways to indicate that you have checked a patch on the mailing list.
 
@@ -607,8 +622,8 @@ number of ways to indicate that you have checked a patch on the mailing list.
 Tested, Acked and Reviewed by
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-To indicate that you have interacted with a patch on the mailing list you
-should respond to the patch in an email with one of the following tags:
+To indicate that you have interacted with a patch on the mailing list,
+respond to the patch in an email with one of the following tags:
 
  * Reviewed-by:
  * Acked-by:
@@ -626,36 +641,35 @@ tag is given here for reference:
 
 .. _statement: https://www.kernel.org/doc/html/latest/process/submitting-patches.html#reviewer-s-statement-of-oversight
 
-``Reviewed-by:`` is a strong statement_ that the patch is an appropriate state
+``Reviewed-by:`` is a strong statement_ that the patch is in an appropriate state
 for merging without any remaining serious technical issues. Reviews from
-community members who are known to understand the subject area and to perform
-thorough reviews will increase the likelihood of the patch getting merged.
+community members who understand the subject area and perform
+thorough reviews increase the likelihood of the patch getting merged.
 
-``Acked-by:`` is a record that the person named was not directly involved in
-the preparation of the patch but wishes to signify and record their acceptance
+``Acked-by:`` records that the person named was not directly involved in
+preparing the patch but wishes to signify and record their acceptance
 and approval of it.
 
-``Tested-by:`` indicates that the patch has been successfully tested (in some
-environment) by the person named.
+``Tested-by:`` indicates that the person named has successfully tested the patch
+(in some environment).
 
-``Reported-by:`` is used to acknowledge person who found or reported the bug.
+``Reported-by:`` acknowledges the person who found or reported the bug.
 
-``Suggested-by:`` indicates that the patch idea was suggested by the named
-person.
+``Suggested-by:`` indicates that the named person suggested the patch idea.
 
 
 Frequency and volume of patches
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-Please allow at least 24 hours to pass between posting patch revisions.
+Allow at least 24 hours between posting patch revisions.
 This ensures reviewers from different geographical regions have time to provide feedback.
-Additionally, please do not wait too long (read: weeks) between revisions
+Additionally, do not wait too long (i.e., weeks) between revisions
 as this makes it harder for reviewers and maintainers
 to recall the context of the previous posting.
 If you have not received any feedback within a week,
 it is appropriate to send a ping to the mailing list.
 
-Please do not post new revisions without addressing all feedback.
+Do not post new revisions without addressing all feedback.
 Make sure that all outstanding items have been addressed
 before posting a new revision for review
 (this should involve replying to all the feedback).
@@ -671,18 +685,18 @@ Your changes are expected to pass on an x86/x86-64 Linux system.
 The infrastructure running the tests is a shared resource among all developers on the project,
 and many frequent reposts will result in delays for all developers.
 We do our best to include CI and self-test infrastructure
-that can be used on an individual developer basis.
+that developers can use individually.
 
 For details on running the unit tests, see :doc:`unit_test`.
 It is also recommended to run the :doc:`DTS <../tools/dts>` comprehensive tests.
 Finally, you can also push to a branch on the GitHub service
 to trigger a comprehensive set of compile and unit test runs.
 
-Please keep all patch sets to a reasonable length.
-Too many or too large patches and series can quickly become very difficult
-for a reasonable review.
-It is recommended to appropriately split patches and series
-to groups of digestible logical changes.
+Keep all patch sets to a reasonable length.
+Too many or too large patches and series can quickly become difficult
+to review reasonably.
+Appropriately split patches and series
+into groups of digestible logical changes.
 
 
 Steps to getting your patch merged
@@ -695,39 +709,39 @@ patch accepted. The general cycle for patch review and acceptance is:
 
 #. Check the automatic test reports in the coming hours.
 
-#. Wait for review comments. While you are waiting review some other patches.
+#. Wait for review comments. While you are waiting, review some other patches.
 
-#. Fix the review comments and submit a ``v n+1`` patchset::
+#. Fix the review comments and submit a ``v n+1`` patch set::
 
       git format-patch -3 -v 2
 
 #. Update Patchwork to mark your previous patches as "Superseded".
 
-#. If the patch is deemed suitable for merging by the relevant maintainer(s) or other developers they will ``ack``
+#. If the relevant maintainer(s) or other developers deem the patch suitable for merging, they will ``ack``
    the patch with an email that includes something like::
 
       Acked-by: Alex Smith <alex.smith@example.com>
 
-   **Note**: When acking patches please remove as much of the text of the patch email as possible.
+   **Note**: When acking patches, remove as much of the text of the patch email as possible.
    It is generally best to delete everything after the ``Signed-off-by:`` line.
 
 #. Having the patch ``Reviewed-by:`` and/or ``Tested-by:`` will also help the patch to be accepted.
 
-#. If the patch isn't deemed suitable based on being out of scope or conflicting with existing functionality
+#. If the patch is deemed unsuitable based on being out of scope or conflicting with existing functionality,
    it may receive a ``nack``.
    In this case you will need to make a more convincing technical argument in favor of your patches.
 
-#. In addition a patch will not be accepted if it doesn't address comments from a previous version with fixes or
+#. In addition, a patch will not be accepted if it does not address comments from a previous version with fixes or
    valid arguments.
 
-#. It is the responsibility of a maintainer to ensure that patches are reviewed and to provide an ``ack`` or
+#. Maintainers are responsible for ensuring that patches are reviewed and for providing an ``ack`` or
    ``nack`` of those patches as appropriate.
 
-#. Once a patch has been acked by the relevant maintainer, reviewers may still comment on it for a further
+#. Once the relevant maintainer has acked a patch, reviewers may still comment on it for a further
    two weeks. After that time, the patch should be merged into the relevant git tree for the next release.
    Additional notes and restrictions:
 
-   * Patches should be acked by a maintainer at least two days before the release merge
+   * Maintainers should ack patches at least two days before the release merge
      deadline, in order to make that release.
    * For patches acked with less than two weeks to go to the merge deadline, all additional
      comments should be made no later than two days before the merge deadline.
@@ -742,11 +756,11 @@ patch accepted. The general cycle for patch review and acceptance is:
 Milestones definition
 ---------------------
 
-Each DPDK release has milestones that help everyone to converge to the release date.
+Each DPDK release has milestones that help everyone converge to the release date.
 The following is a list of these milestones together with
 concrete definitions and expectations for a typical release cycle.
-An average cycle lasts 3 months and have 4 release candidates in the last month.
-Test reports are expected to be received after each release candidate.
+An average cycle lasts 3 months and has 4 release candidates in the last month.
+Test reports are expected after each release candidate.
 The number and expectations of release candidates might vary slightly.
 The schedule is updated in the `roadmap <https://core.dpdk.org/roadmap/#dates>`_.
 
@@ -759,14 +773,14 @@ Roadmap
 ~~~~~~~
 
 * Announce new features in libraries, drivers, applications, and examples.
-* To be published before the previous release.
+* Publish before the previous release.
 
 Proposal Deadline
 ~~~~~~~~~~~~~~~~~
 
-* Must send an RFC (Request For Comments) or a complete patch of new features.
+* Send an RFC (Request For Comments) or a complete patch of new features.
 * Early RFC gives time for design review before complete implementation.
-* Should include at least the API changes in libraries and applications.
+* Include at least the API changes in libraries and applications.
 * Library code should be quite complete at the deadline.
 * Nice to have: driver implementation, example code, and documentation.
 
@@ -774,15 +788,15 @@ rc1
 ~~~
 
 * Priority: libraries. No library feature should be accepted after -rc1.
-* API changes or additions must be implemented in libraries.
+* Implement API changes or additions in libraries.
 * The API must include Doxygen documentation
   and be part of the relevant .rst files (library-specific and release notes).
-* API should be used in a test application (``/app``).
+* Use the API in a test application (``/app``).
 * At least one PMD should implement the API.
   It may be a draft sent in a separate series.
-* The above should be sent to the mailing list at least 2 weeks before -rc1
-  to give time for review and maintainers approval.
-* If no review after 10 days, a reminder should be sent.
+* Send the above to the mailing list at least 2 weeks before -rc1
+  to give time for review and maintainer approval.
+* If no review after 10 days, send a reminder.
 * Nice to have: example code (``/examples``)
 
 rc2
@@ -791,17 +805,17 @@ rc2
 * Priority: drivers. No driver feature should be accepted after -rc2.
 * A driver change must include documentation
   in the relevant .rst files (driver-specific and release notes).
-* Driver changes should be sent to the mailing list before -rc1 is released.
+* Send driver changes to the mailing list before -rc1 is released.
 
 rc3
 ~~~
 
 * Priority: applications. No application feature should be accepted after -rc3.
-* New functionality that does not depend on libraries update
+* New functionality that does not depend on library updates
   can be integrated as part of -rc3.
 * The application change must include documentation in the relevant .rst files
   (application-specific and release notes if significant).
-* Libraries and drivers cleanup are allowed.
+* Library and driver cleanup is allowed.
 * Small driver reworks.
 
 rc4
@@ -811,4 +825,4 @@ rc4
 * Critical bug fixes only.
 
 .. note::
-   Bug fixes are integrated as early as possible at any stage.
+   Integrate bug fixes as early as possible at any stage.
-- 
2.51.0

