Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A06DC982C0
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 20:17:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4807742E93;
	Fri, 16 Jan 2026 21:17:50 +0100 (CET)
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com
 [209.85.218.68]) by mails.dpdk.org (Postfix) with ESMTP id DA54A42E7B
 for <dev@dpdk.org>; Fri, 16 Jan 2026 21:17:47 +0100 (CET)
Received: by mail-ej1-f68.google.com with SMTP id
 a640c23a62f3a-b8710c9cddbso326359066b.2
 for <dev@dpdk.org>; Fri, 16 Jan 2026 12:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768594667;
 x=1769199467; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Tt0CKDCkSxxCdx9pR/gLD2caFiiW+PcQlmNvmMxiJo=;
 b=brCKgoZeDQH5bnDyBhzqby8coSMNYi4uInpsb/Vx1uzJXSOZ3UAG+BV6zhx2qf+FqF
 sSbhb0Guq6v1ewUMdsNM0IYBWQx0Wdf4vlkibP4303jVlMPObjdVWdLIFzLUxu7cBEeY
 BqiPr+OwfOCux/eez03GWagf8QNSHd8BfpOntJRjo+JBC/yEesqiqL61o14n38TK+oOy
 I7VEeGcMjXot8ZeLbi5PDetugOxGU5kWKqkbAzXxTEJWAC3ccli/YyUFdNKTLpV8Lh4k
 W8a5xzL1eGiZB/kTMduXXsIAxIlVl7S4kUjmhoQM+34XHMaClAaefB1Wqlfmzf9C1G1w
 IOIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768594667; x=1769199467;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1Tt0CKDCkSxxCdx9pR/gLD2caFiiW+PcQlmNvmMxiJo=;
 b=isYxiKUy4wetg7myRjSVxi0wN4LnpqTZ12y8D218uUgDvXBe9l6W1JaP7sFQJseqTy
 GziGt2yOiCI3isr76Pbjf5M6uD6V83wOkuVho24eXY6Uzg7QoVn99RG8an0e27tKVFU9
 IRUFbe0HrO7J6qSI3HcWrCDk7zqILdtVc/FPYF71pvTjmQq2vP35wndQ2bpxFVyd8dtb
 KJsYzXck9vBEkQK2v4+Mx3oo5zTSkhZ+Im5YZwlrqPEijFA9C/tgwIohsgGelDzv9YDj
 dJ8No+1at/vnUHGB+BEs4TzYw+h58lfZ/lwqhmS74k2Sg1DzXyd6BqgW+XXxVSxpWwPb
 7c7g==
X-Gm-Message-State: AOJu0Yzo9EPFSx59ozWdUP5qm04mJQx1A3Cw6zvUncTaDcBbye72I1qc
 UMnZNpbaW9AvNyEuHu8qMdGPHfI4Cvy3GXQn1kYus62lDmV266NJA0pB1hzoZG0d4IEZeNPrJGv
 p9DWR2Sw=
X-Gm-Gg: AY/fxX4AS5Bswzs0r7ukEmUenqVvAVNurMwLzjyYf/UiTUW9eOUhLJqyMV1fzMGepfL
 aPjHXoCfn50xgiP4zkq6eMnsbq6ACz3U6Lk6KHIeK7jdZVl8cTFJMyghiLTR9sxcP5bd54aGAAI
 IG26l9Ja98FJqTBeuvYvpzLVXm/YSc6TMEvFnyExr6XFPkVW3v24OGblQpePdQJBpFvm3rjWedC
 1I8uONEMuBojT66A+6GOtku5NBdNfXL17tWe1ZWn9kHjeP6OpVaVcVaNXqUU5OVY1etHfTPbjST
 1UxuoiHWzwGJbl88HOheAaZU8CHm63Wk0WzdN6E5BIm2h2CZPB3xZQDdgJ5CKoAGl3uns/JyeAu
 OgEb9tW/bVPIN+vxzza2u6Fb8PzsGHzUYUFnMNc/3tp151moQT5mqRiZp7UfR0sn6fF/VnVZqb7
 5waZq0DltEgkt1MC+gkr1SyT2mNG1lYOItsizAlKjc4Z2MYStCnw==
X-Received: by 2002:a17:907:1c0b:b0:b87:7938:7b77 with SMTP id
 a640c23a62f3a-b8796afd56amr307154366b.30.1768594667117; 
 Fri, 16 Jan 2026 12:17:47 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8795169f10sm338631466b.26.2026.01.16.12.17.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 12:17:46 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 02/12] doc: improve ABI policy documentation style
Date: Fri, 16 Jan 2026 12:14:20 -0800
Message-ID: <20260116201738.74578-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260116201738.74578-1-stephen@networkplumber.org>
References: <20260114225555.127448-1-stephen@networkplumber.org>
 <20260116201738.74578-1-stephen@networkplumber.org>
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

Improve readability of the ABI policy documentation
- Converting passive voice to active voice
- Removing redundant phrases like "Please note that" and "Note that"
- Simplifying wordy constructions
- Using imperative mood for guidelines
- Fixing punctuation and grammar issues

No technical content changes.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/contributing/abi_policy.rst | 194 ++++++++++++-------------
 1 file changed, 96 insertions(+), 98 deletions(-)

diff --git a/doc/guides/contributing/abi_policy.rst b/doc/guides/contributing/abi_policy.rst
index f03a7467ac..2d1c17963d 100644
--- a/doc/guides/contributing/abi_policy.rst
+++ b/doc/guides/contributing/abi_policy.rst
@@ -7,7 +7,7 @@ ABI Policy
 Description
 -----------
 
-This document details the management policy that ensures the long-term stability
+This document details the management policy for ensuring long-term stability
 of the DPDK ABI and API.
 
 General Guidelines
@@ -16,28 +16,27 @@ General Guidelines
 #. Major ABI versions are declared no more frequently than yearly. Compatibility
    with the major ABI version is mandatory in subsequent releases until a
    :ref:`new major ABI version <new_abi_version>` is declared.
-#. Major ABI versions are usually but not always declared aligned with a
+#. Major ABI versions usually, but not always, align with a
    :ref:`LTS release <stable_lts_releases>`.
-#. The ABI version is managed at a project level in DPDK, and is reflected in
-   all non-experimental :ref:`library's soname <what_is_soname>`.
-#. The ABI should be preserved and not changed lightly. ABI changes must follow
+#. DPDK manages the ABI version at a project level, reflecting it
+   in all non-experimental :ref:`library sonames <what_is_soname>`.
+#. Preserve the ABI and avoid changing it lightly. ABI changes must follow
    the outlined :ref:`deprecation process <abi_changes>`.
-#. The addition of symbols is generally not problematic. The modification of
-   symbols is managed with :ref:`ABI Versioning <abi_versioning>`.
-#. The removal of symbols is considered an :ref:`ABI breakage <abi_breakages>`,
-   once approved these will form part of the next ABI version.
+#. Adding symbols is generally not problematic. Manage modification of
+   symbols with :ref:`ABI Versioning <abi_versioning>`.
+#. Removing symbols is considered an :ref:`ABI breakage <abi_breakages>`;
+   once approved, these removals form part of the next ABI version.
 #. Libraries or APIs marked as :ref:`experimental <experimental_apis>`
    may be changed or removed without prior notice,
    as they are not considered part of an ABI version.
    The :ref:`experimental <experimental_apis>` status of an API
    is not an indefinite state.
-#. Updates to the :ref:`minimum hardware requirements <hw_rqmts>`, which drop
-   support for hardware which was previously supported, should be treated as an
-   ABI change.
+#. Treat updates to the :ref:`minimum hardware requirements <hw_rqmts>`, which drop
+   support for previously supported hardware, as an ABI change.
 
 .. note::
 
-   Please note that this policy does not currently apply to the
+   This policy does not currently apply to the
    :doc:`Windows build <../windows_gsg/intro>`.
 
 What is an ABI?
@@ -45,13 +44,12 @@ What is an ABI?
 
 An ABI (Application Binary Interface) is the set of runtime interfaces exposed
 by a library. It is similar to an API (Application Programming Interface) but
-is the result of compilation.  It is also effectively cloned when applications
-link to dynamic libraries.  That is to say when an application is compiled to
-link against dynamic libraries, it is assumed that the ABI remains constant
-between the time the application is compiled/linked, and the time that it runs.
-Therefore, in the case of dynamic linking, it is critical that an ABI is
-preserved, or (when modified), done in such a way that the application is unable
-to behave improperly or in an unexpected fashion.
+is the result of compilation. Applications effectively clone the ABI when
+linking to dynamic libraries. When an application compiles and links against
+dynamic libraries, the ABI must remain constant between compile/link time
+and runtime. Therefore, in the case of dynamic linking, it is critical to
+preserve the ABI, or (when modifying it) to do so in a way that prevents
+the application from behaving improperly or unexpectedly.
 
 .. _figure_what_is_an_abi:
 
@@ -64,12 +62,12 @@ What is an ABI version?
 ~~~~~~~~~~~~~~~~~~~~~~~
 
 An ABI version is an instance of a library's ABI at a specific release. Certain
-releases are considered to be milestone releases, the yearly LTS release for
+releases are considered milestone releases, the yearly LTS release for
 example. The ABI of a milestone release may be declared as a 'major ABI
 version', where this ABI version is then supported for some number of subsequent
 releases and is annotated in the library's :ref:`soname<what_is_soname>`.
 
-ABI version support in subsequent releases facilitates application upgrades, by
+ABI version support in subsequent releases facilitates application upgrades by
 enabling applications built against the milestone release to upgrade to
 subsequent releases of a library without a rebuild.
 
@@ -80,14 +78,14 @@ The DPDK ABI policy
 -------------------
 
 A new major ABI version is declared no more frequently than yearly, with
-declarations usually aligning with a LTS release, e.g. ABI 21 for DPDK 20.11.
+declarations usually aligning with an LTS release, e.g., ABI 21 for DPDK 20.11.
 Compatibility with the major ABI version is then mandatory in subsequent
-releases until the next major ABI version is declared, e.g. ABI 22 for DPDK
+releases until the next major ABI version is declared, e.g., ABI 22 for DPDK
 21.11.
 
 At the declaration of a major ABI version, major version numbers encoded in
 libraries' sonames are bumped to indicate the new version, with the minor
-version reset to ``0``. An example would be ``librte_eal.so.21.3`` would become
+version reset to ``0``. For example, ``librte_eal.so.21.3`` becomes
 ``librte_eal.so.22.0``.
 
 The ABI may then change multiple times, without warning, between the last major
@@ -96,12 +94,12 @@ that ABI compatibility with the major ABI version is preserved and therefore
 sonames do not change.
 
 Minor versions are incremented to indicate the release of a new ABI compatible
-DPDK release, typically the DPDK quarterly releases. An example of this, might
-be that ``librte_eal.so.21.1`` would indicate the first ABI compatible DPDK
-release, following the declaration of the new major ABI version ``21``.
+DPDK release, typically the DPDK quarterly releases. For example,
+``librte_eal.so.21.1`` indicates the first ABI compatible DPDK
+release following the declaration of the new major ABI version ``21``.
 
 An ABI version is supported in all new releases until the next major ABI version
-is declared. When changing the major ABI version, the release notes will detail
+is declared. When changing the major ABI version, the release notes detail
 all ABI changes.
 
 .. _figure_abi_stability_policy:
@@ -116,37 +114,37 @@ all ABI changes.
 ABI Changes
 ~~~~~~~~~~~
 
-The ABI may still change after the declaration of a major ABI version, that is
-new APIs may be still added or existing APIs may be modified.
+The ABI may still change after declaring a major ABI version—new APIs may be
+added or existing APIs modified.
 
 .. Warning::
 
-   Note that, this policy details the method by which the ABI may be changed,
+   This policy details the method by which the ABI may be changed,
    with due regard to preserving compatibility and observing deprecation
-   notices. This process however should not be undertaken lightly, as a general
-   rule ABI stability is extremely important for downstream consumers of DPDK.
-   The API should only be changed for significant reasons, such as performance
-   enhancements. API breakages due to changes such as reorganizing public
-   structure fields for aesthetic or readability purposes should be avoided.
+   notices. However, do not undertake this process lightly; as a general
+   rule, ABI stability is extremely important for downstream consumers of DPDK.
+   Change the API only for significant reasons, such as performance
+   enhancements. Avoid API breakages due to changes such as reorganizing public
+   structure fields for aesthetic or readability purposes.
 
 The requirements for changing the ABI are:
 
 #. At least 3 acknowledgments of the need to do so must be made on the
    dpdk.org mailing list.
 
-   - The acknowledgment of the maintainer of the component is mandatory, or if
+   - The component maintainer must acknowledge the change, or if
      no maintainer is available for the component, the tree/sub-tree maintainer
      for that component must acknowledge the ABI change instead.
 
-   - The acknowledgment of three members of the technical board, as delegates
-     of the `technical board <https://core.dpdk.org/techboard/>`_ acknowledging
-     the need for the ABI change, is also mandatory.
+   - Three members of the technical board, as delegates
+     of the `technical board <https://core.dpdk.org/techboard/>`_, must also
+     acknowledge the need for the ABI change.
 
-   - It is also recommended that acknowledgments from different "areas of
-     interest" be sought for each deprecation, for example: from NIC vendors,
+   - Seek acknowledgments from different "areas of
+     interest" for each deprecation, for example: from NIC vendors,
      CPU vendors, end-users, etc.
 
-#. Backward compatibility with the major ABI version must be maintained through
+#. Maintain backward compatibility with the major ABI version through
    :ref:`abi_versioning`, with :ref:`forward-only <forward-only>` compatibility
    offered for any ABI changes that are indicated to be part of the next ABI
    version.
@@ -159,7 +157,7 @@ The requirements for changing the ABI are:
      and Libraries <experimental_apis>`.
 
    - In situations in which an ``experimental`` symbol has been stable for some
-     time. When promoting the symbol to become part of the next ABI version, the
+     time, when promoting the symbol to become part of the next ABI version, the
      maintainer may choose to provide an alias to the ``experimental`` tag, so
      as not to break consuming applications.
 
@@ -167,56 +165,56 @@ The requirements for changing the ABI are:
    API becomes non-experimental, then the old one is marked with
    ``__rte_deprecated``.
 
-    - The deprecated API should follow the notification process to be removed,
-      see  :ref:`deprecation_notices`.
+    - The deprecated API should follow the notification process to be removed;
+      see :ref:`deprecation_notices`.
 
     - At the declaration of the next major ABI version, those ABI changes then
       become a formal part of the new ABI and the requirement to preserve ABI
-      compatibility with the last major ABI version is then dropped.
+      compatibility with the last major ABI version is dropped.
 
-    - The responsibility for removing redundant ABI compatibility code rests
-      with the original contributor of the ABI changes, failing that, then with
-      the contributor's company and then finally with the maintainer.
+    - The original contributor of the ABI changes is responsible for removing
+      redundant ABI compatibility code; failing that, the contributor's company,
+      and then finally the maintainer.
 
 .. _forward-only:
 
 .. Note::
 
-   Note that forward-only compatibility is offered for those changes made
+   Forward-only compatibility is offered for changes made
    between major ABI versions. As a library's soname can only describe
    compatibility with the last major ABI version, until the next major ABI
-   version is declared, these changes therefore cannot be resolved as a runtime
-   dependency through the soname. Therefore any application wishing to make use
-   of these ABI changes can only ensure that its runtime dependencies are met
+   version is declared, these changes cannot be resolved as a runtime
+   dependency through the soname. Therefore, any application wishing to use
+   these ABI changes can only ensure that its runtime dependencies are met
    through Operating System package versioning.
 
 .. _hw_rqmts:
 
 .. Note::
 
-   Updates to the minimum hardware requirements, which drop support for hardware
-   which was previously supported, should be treated as an ABI change, and
+   Treat updates to the minimum hardware requirements, which drop support for
+   previously supported hardware, as an ABI change, and
    follow the relevant deprecation policy procedures as above: 3 acks, technical
-   board approval and announcement at least one release in advance.
+   board approval, and announcement at least one release in advance.
 
 .. _abi_breakages:
 
 ABI Breakages
 ~~~~~~~~~~~~~
 
-For those ABI changes that are too significant to reasonably maintain multiple
-symbol versions, there is an amended process. In these cases, ABIs may be
-updated without the requirement of backward compatibility being provided. These
-changes must follow the same process :ref:`described above <abi_changes>` as non-breaking
-changes, however with the following additional requirements:
+An amended process exists for ABI changes too significant to reasonably maintain
+multiple symbol versions. In these cases, ABIs may be updated without providing
+backward compatibility. These changes must follow the same process
+:ref:`described above <abi_changes>` as non-breaking changes, with the following
+additional requirements:
 
 #. ABI breaking changes (including an alternative map file) can be included with
-   deprecation notice, in wrapped way by the ``RTE_NEXT_ABI`` option, to provide
-   more details about oncoming changes. ``RTE_NEXT_ABI`` wrapper will be removed
+   the deprecation notice, wrapped by the ``RTE_NEXT_ABI`` option, to provide
+   more details about upcoming changes. The ``RTE_NEXT_ABI`` wrapper is removed
    at the declaration of the next major ABI version.
 
-#. Once approved, and after the deprecation notice has been observed these
-   changes will form part of the next declared major ABI version.
+#. Once approved, and after the deprecation notice has been observed, these
+   changes form part of the next declared major ABI version.
 
 Examples of ABI Changes
 ~~~~~~~~~~~~~~~~~~~~~~~
@@ -224,7 +222,7 @@ Examples of ABI Changes
 The following are examples of allowable ABI changes occurring between
 declarations of major ABI versions.
 
-* DPDK 20.11 release defines the function ``rte_foo()`` ; ``rte_foo()``
+* DPDK 20.11 release defines the function ``rte_foo()``; ``rte_foo()``
   is part of the major ABI version ``21``.
 
 * DPDK 21.02 release defines a new function ``rte_foo(uint8_t bar)``.
@@ -235,23 +233,23 @@ declarations of major ABI versions.
     number of releases, as described in the section :ref:`experimental_apis`.
 
   - Once ``rte_foo(uint8_t bar)`` becomes non-experimental, ``rte_foo()`` is
-    declared as ``__rte_deprecated`` and an deprecation notice is provided.
+    declared as ``__rte_deprecated`` and a deprecation notice is provided.
 
-* DPDK 20.11 is not re-released to include ``rte_foo(uint8_t bar)``, the new
+* DPDK 20.11 is not re-released to include ``rte_foo(uint8_t bar)``; the new
   version of ``rte_foo`` only exists from DPDK 21.02 onwards as described in the
   :ref:`note on forward-only compatibility<forward-only>`.
 
 * DPDK 21.02 release defines the experimental function ``__rte_experimental
   rte_baz()``. This function may or may not exist in the DPDK 21.05 release.
 
-* An application ``dPacket`` wishes to use ``rte_foo(uint8_t bar)``, before the
+* An application ``dPacket`` wishes to use ``rte_foo(uint8_t bar)`` before the
   declaration of the DPDK ``22`` major ABI version. The application can only
   ensure its runtime dependencies are met by specifying ``DPDK (>= 21.2)`` as
   an explicit package dependency, as the soname can only indicate the
   supported major ABI version.
 
 * At the release of DPDK 21.11, the function ``rte_foo(uint8_t bar)`` becomes
-  formally part of then new major ABI version DPDK ``22`` and ``rte_foo()`` may be
+  formally part of the new major ABI version DPDK ``22`` and ``rte_foo()`` may be
   removed.
 
 .. _deprecation_notices:
@@ -259,19 +257,19 @@ declarations of major ABI versions.
 Examples of Deprecation Notices
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-The following are some examples of ABI deprecation notices which would be
-added to the Release Notes:
+The following are some examples of ABI deprecation notices to add
+to the Release Notes:
 
 * The Macro ``#RTE_FOO`` is deprecated and will be removed with ABI version
   22, to be replaced with the inline function ``rte_foo()``.
 
 * The function ``rte_mbuf_grok()`` has been updated to include a new parameter
-  in version 21.2. Backwards compatibility will be maintained for this function
+  in version 21.2. Backward compatibility will be maintained for this function
   until the release of the new DPDK major ABI version 22, in DPDK version
   21.11.
 
 * The members of ``struct rte_foo`` have been reorganized in DPDK 21.02 for
-  performance reasons. Existing binary applications will have backwards
+  performance reasons. Existing binary applications will have backward
   compatibility in release 21.02, while newly built binaries will need to
   reference the new structure variant ``struct rte_foo2``. Compatibility will be
   removed in release 21.11, and all applications will require updating and
@@ -280,7 +278,7 @@ added to the Release Notes:
 
 * Significant ABI changes are planned for the ``librte_dostuff`` library. The
   upcoming release 21.02 will not contain these changes, but release 21.11 will,
-  and no backwards compatibility is planned due to the extensive nature of
+  and no backward compatibility is planned due to the extensive nature of
   these changes. Binaries using this library built prior to ABI version 22 will
   require updating and recompilation.
 
@@ -297,11 +295,11 @@ This is commonly known as the *ABI breakage window*,
 and some amended rules apply during this cycle:
 
  * The requirement to preserve compatibility with the previous major ABI
-   version, as described in the section :ref:`abi_changes` does not apply.
- * Contributors of compatibility preserving code in previous releases,
+   version, as described in the section :ref:`abi_changes`, does not apply.
+ * Contributors of compatibility preserving code in previous releases
    are now required to remove this compatibility code,
    as described in the section :ref:`abi_changes`.
- * Symbol versioning references to the old ABI version are updated
+ * Update symbol versioning references to the old ABI version
    to reference the new ABI version,
    as described in the section :ref:`deprecating_entire_abi`.
  * Contributors of aliases to experimental in previous releases,
@@ -309,9 +307,9 @@ and some amended rules apply during this cycle:
    are now required to remove these aliases.
  * Finally, the *ABI breakage window* is *not* permission to circumvent
    the other aspects of the procedures to make ABI changes
-   described in :ref:`abi_changes`, that is, 3 ACKs of the requirement
+   described in :ref:`abi_changes`; that is, 3 ACKs of the requirement
    to break the ABI and the observance of a deprecation notice
-   are still considered mandatory.
+   are still mandatory.
 
 .. _experimental_apis:
 
@@ -324,31 +322,31 @@ APIs
 APIs marked as ``experimental`` are not considered part of an ABI version and
 may be changed or removed without prior notice. Since changes to APIs are most likely
 immediately after their introduction, as users begin to take advantage of those
-new APIs and start finding issues with them, new DPDK APIs will be automatically
+new APIs and start finding issues with them, new DPDK APIs are automatically
 marked as ``experimental`` to allow for a period of stabilization before they
 become part of a tracked ABI version.
 
-Note that marking an API as experimental is a multi step process.
-To mark an API as experimental, the symbols which are desired to be exported
-must be annotated with a RTE_EXPORT_EXPERIMENTAL_SYMBOL call in the corresponding libraries'
+Note that marking an API as experimental is a multi-step process.
+To mark an API as experimental, annotate the symbols to be exported
+with a RTE_EXPORT_EXPERIMENTAL_SYMBOL call in the corresponding libraries'
 sources.
-Experimental symbols must be commented so that it is clear in which DPDK
+Comment experimental symbols so that it is clear in which DPDK
 version they were introduced.
 
-Secondly, the corresponding prototypes of those exported functions (in the
-development header files), must be marked with the ``__rte_experimental`` tag
+Secondly, mark the corresponding prototypes of those exported functions (in the
+development header files) with the ``__rte_experimental`` tag
 (see ``rte_compat.h``).
 
 In addition to tagging the code with ``__rte_experimental``,
 the doxygen markup must also contain the EXPERIMENTAL string,
 and the MAINTAINERS file should note the EXPERIMENTAL libraries.
 
-For removing the experimental tag associated with an API, deprecation notice is
-not required. Though, an API should remain in experimental state for at least
-one release. Thereafter, the normal process of posting patch for review to
+For removing the experimental tag associated with an API, a deprecation notice is
+not required. However, an API should remain in experimental state for at least
+one release. Thereafter, the normal process of posting a patch for review to the
 mailing list can be followed.
 
-After the experimental tag has been formally removed, a tree/sub-tree maintainer
+After formally removing the experimental tag, a tree/sub-tree maintainer
 may choose to offer an alias to the experimental tag so as not to break
 applications using the symbol. The alias is then dropped at the declaration of
 next major ABI version.
@@ -363,16 +361,16 @@ All functions in such libraries may be changed or removed without prior notice.
 Promotion to stable
 ~~~~~~~~~~~~~~~~~~~
 
-An API's ``experimental`` status should be reviewed annually,
+Review an API's ``experimental`` status annually,
 by both the maintainer and/or the original contributor.
-Ordinarily APIs marked as ``experimental`` will be promoted to the stable ABI
-once a maintainer has become satisfied that the API is mature
+Ordinarily, promote APIs marked as ``experimental`` to the stable ABI
+once a maintainer is satisfied that the API is mature
 and is unlikely to change.
 
 In exceptional circumstances, should an API still be classified
 as ``experimental`` after two years
-and is without any prospect of becoming part of the stable API.
-The API will then become a candidate for removal,
+and be without any prospect of becoming part of the stable API,
+the API will then become a candidate for removal,
 to avoid the accumulation of abandoned symbols.
 
 Should an ABI change, usually due to a direct change to the API's signature,
-- 
2.51.0

