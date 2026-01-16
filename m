Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6AF5C982FE
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 20:19:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2344942EDE;
	Fri, 16 Jan 2026 21:18:06 +0100 (CET)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com
 [209.85.218.48]) by mails.dpdk.org (Postfix) with ESMTP id 3C44A42EDB
 for <dev@dpdk.org>; Fri, 16 Jan 2026 21:18:04 +0100 (CET)
Received: by mail-ej1-f48.google.com with SMTP id
 a640c23a62f3a-b872de50c91so381019966b.2
 for <dev@dpdk.org>; Fri, 16 Jan 2026 12:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768594684;
 x=1769199484; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7H2uCSSBx1MjdYakAnLLYEk9lKEQ0FOEexOq83Nn39o=;
 b=vgkRb9St/IE1E3rice7x/tB2IyUXZSJEOnMhCKtzl3/C3bx7V0uIA1+7mF/QntEA33
 Rx/MgFNYqjNTUaUxi1Sv39UTtxY29jhDivPYnw4XJZPuYjo9HGMfYFhnj3ptkQJNV99Y
 Nb5Vd6hqKhi23Wjsw6DhwdB4EeAGUaKHqxyAluNw+4QXDqFkBx8mflBi5xmyH8/emzj6
 XeZdhelqb/z4zEyrkkna6OXPkKiw9Shi7oVL+KTsWZE/zCJVXjthrSZcyjbYbo+tuHGW
 UY6Rm4FXOxX2vQgPrRXzW3N2RTV/WAR+HCoFbo4inl0HcLxYpjBQmhjESeCppmJ5N8EI
 hpkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768594684; x=1769199484;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7H2uCSSBx1MjdYakAnLLYEk9lKEQ0FOEexOq83Nn39o=;
 b=ZzKrMrrltcoWKcpxTJaKjMZxbIbLwqajN0SQqo6Kt5qmv0BFZrDxY0Y1V9jHVONlM4
 FIlGgs9mv47COVnzHT1n5A0bKUSScnVOTWvkp/xvJi5phf4ZumlgnpLB4MwXx6y5Amp4
 LnhAgDCYuzuYk6k+hEgNJyVPTAr1xQvhvDhRchLHbYB1jzTSRURvAg9eZE1EAe1ic9j3
 /+cjOZGM017Xu4f9ya0Q/1mC8x+g4gBQwnZ9pjTopU8bEbCb5Ru+7jwqgZelrekWu3PF
 3uzCQUyT7S+/y48vaS2IqmntXAtIa0xq2I2scbHMSK7RlsYI/LZz6PXQsKpVG7+RZEBz
 EWow==
X-Gm-Message-State: AOJu0YwbAOsCz6UFlvXvpTE7WAuIGm3xhLbd/hyTRQ1B6szzDWBulAPp
 e7Ngn8ENBxJeLUnyJT2GmVy0lVnsgD+LS5uRJ5vXDRlR3HJXddxzi+jmAn2Ybyqjcgf7wLKSlwu
 BZLiz
X-Gm-Gg: AY/fxX4mfSASjd8COdppSZAVMnpYaunzP9fJe27GWU7QkAdxLxJ2Zcp/xLJxLdz1Chj
 9zfNo8VUOCB26Hiv6PQew/BSSwvhiDczBeXUnv7w7YA0PLFYo9w6cxPuqqtTitBhHXbattTt6ZZ
 CUDUK5VwlrN/E2O4VcpEz9ruyeHZVR9dyMHOW8yTVWqGA/BnZ7SkLV8UcwjqYbf3/rAcG6LPoI1
 UTbumVUpQ2W12ZHJuRF5AGCh0cbsQ5JFtU33f/cDzi32vNEmSj1wbKE2RNAF8lJFdGHNKhWXzLQ
 G+q/tquqkwXPYeRVjPEJu6h6QmBtOL8lZDvlu8zb/NGeTW/MqlBf1KWaFrKamPwDY90S/K0S6/u
 euTkRhCsJFf4KbpZChGtiNGXiOuNqkCCwHkmhmHDR/Y8BNIopghKAntQTqsk8en+CCU462A8lkZ
 DBcOsHVv+U4GI/XyHV6ls3KmfYxQ4jy1DCQIeyQxM6hVO4+Fr32IZx3oqlf85m
X-Received: by 2002:a17:907:3f04:b0:b87:1669:de1a with SMTP id
 a640c23a62f3a-b879326fcfbmr312815166b.64.1768594683642; 
 Fri, 16 Jan 2026 12:18:03 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8795169f10sm338631466b.26.2026.01.16.12.18.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 12:18:03 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 12/12] doc: fix grammar and style in ABI versioning guide
Date: Fri, 16 Jan 2026 12:14:30 -0800
Message-ID: <20260116201738.74578-13-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260116201738.74578-1-stephen@networkplumber.org>
References: <20260114225555.127448-1-stephen@networkplumber.org>
 <20260116201738.74578-1-stephen@networkplumber.org>
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

Fix several issues in the ABI versioning documentation:

- Remove extra period after soname Wikipedia link
- Fix "it's" to "its" for possessive form
- Add missing "be" in "need to be carefully planned"
- Remove erroneous "is" in "it is may be required"
- Add missing "and" and "for" in ABI version support sentence
- Fix "Lets" to "Let's" contraction
- Remove stray semicolon in #include directive example
- Replace "comprised of" with "consists of"
- Fix missing period after "e.g" abbreviation
- Add missing apostrophe in "application's dependencies"
- Remove redundant "of the head" phrase
- Clarify "alias to experimental" wording

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/contributing/abi_versioning.rst | 32 +++++++++++-----------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/doc/guides/contributing/abi_versioning.rst b/doc/guides/contributing/abi_versioning.rst
index 2fa2b15edc..086f3d6016 100644
--- a/doc/guides/contributing/abi_versioning.rst
+++ b/doc/guides/contributing/abi_versioning.rst
@@ -17,19 +17,19 @@ System libraries usually adopt the familiar major and minor version naming
 convention, where major versions (e.g. ``librte_eal 21.x, 22.x``) are presumed
 to be ABI incompatible with each other and minor versions (e.g. ``librte_eal
 21.1, 21.2``) are presumed to be ABI compatible. A library's `soname
-<https://en.wikipedia.org/wiki/Soname>`_. is typically used to provide backward
+<https://en.wikipedia.org/wiki/Soname>`_ is typically used to provide backward
 compatibility information about a given library, describing the lowest common
 denominator ABI supported by the library. The soname or logical name for the
-library, is typically comprised of the library's name and major version e.g.
+library typically consists of the library's name and major version e.g.
 ``librte_eal.so.21``.
 
 During an application's build process, a library's soname is noted as a runtime
 dependency of the application. This information is then used by the `dynamic
 linker <https://en.wikipedia.org/wiki/Dynamic_linker>`_ when resolving the
-applications dependencies at runtime, to load a library supporting the correct
+application's dependencies at runtime, to load a library supporting the correct
 ABI version. The library loaded at runtime therefore, may be a minor revision
 supporting the same major ABI version (e.g. ``librte_eal.21.2``), as the library
-used to link the application (e.g ``librte_eal.21.0``).
+used to link the application (e.g. ``librte_eal.21.0``).
 
 .. _major_abi_versions:
 
@@ -37,7 +37,7 @@ Major ABI versions
 ------------------
 
 An ABI version change to a given library, especially in core libraries such as
-``librte_mbuf``, may cause an implicit ripple effect on the ABI of it's
+``librte_mbuf``, may cause an implicit ripple effect on the ABI of its
 consuming libraries, causing ABI breakages. There may however be no explicit
 reason to bump a dependent library's ABI version, as there may have been no
 obvious change to the dependent library's API, even though the library's ABI
@@ -47,11 +47,11 @@ This interdependence of DPDK libraries, means that ABI versioning of libraries
 is more manageable at a project level, with all project libraries sharing a
 **single ABI version**. In addition, the need to maintain a stable ABI for some
 number of releases as described in the section :doc:`abi_policy`, means
-that ABI version increments need to carefully planned and managed at a project
+that ABI version increments need to be carefully planned and managed at a project
 level.
 
 Major ABI versions are therefore declared typically aligned with an LTS release
-and is then supported some number of subsequent releases, shared across all
+and are then supported for some number of subsequent releases, shared across all
 libraries. This means that a single project level ABI version, reflected in all
 individual library's soname, library filenames and associated version maps
 persists over multiple releases.
@@ -128,7 +128,7 @@ Versioning Macros
 When a symbol is exported from a library to provide an API, it also provides a
 calling convention (ABI) that is embodied in its name, return type and
 arguments. Occasionally that function may need to change to accommodate new
-functionality or behavior. When that occurs, it is may be required to allow for
+functionality or behavior. When that occurs, it may be required to allow for
 backward compatibility for a time with older binaries that are dynamically
 linked to the DPDK.
 
@@ -140,16 +140,16 @@ library so that older binaries need not be immediately recompiled.
 The macros are:
 
 * ``RTE_VERSION_SYMBOL(ver, type, name, args)``: Creates a symbol version table
-  entry binding symbol ``<name>@DPDK_<ver>`` to the internal function name
-  ``<name>_v<ver>``.
+  entry binding symbol ``<n>@DPDK_<ver>`` to the internal function name
+  ``<n>_v<ver>``.
 
 * ``RTE_DEFAULT_SYMBOL(ver, type, name, args)``: Creates a symbol version entry
-  instructing the linker to bind references to symbol ``<name>`` to the internal
-  symbol ``<name>_v<ver>``.
+  instructing the linker to bind references to symbol ``<n>`` to the internal
+  symbol ``<n>_v<ver>``.
 
 * ``RTE_VERSION_EXPERIMENTAL_SYMBOL(type, name, args)``:  Similar to RTE_VERSION_SYMBOL
   but for experimental API symbols. The macro is used when a symbol matures
-  to become part of the stable ABI, to provide an alias to experimental
+  to become part of the stable ABI, to provide an alias to the experimental version
   until the next major ABI version.
 
 .. _example_abi_macro_usage:
@@ -276,7 +276,7 @@ versioning, in the ``meson.build`` file we add the following
 
    use_function_versioning = true
 
-at the start of the head of the file. This will indicate to the tool-chain to
+at the start of the file. This will indicate to the tool-chain to
 enable the function version macros when building.
 
 
@@ -336,7 +336,7 @@ and ``DPDK_22`` version nodes.
 
 .. code-block:: c
 
-   #include <rte_compat.h>;
+   #include <rte_compat.h>
 
    /*
     * Create an acl context object for apps to
@@ -357,7 +357,7 @@ and ``DPDK_22`` version nodes.
 Deprecating part of a public API
 ________________________________
 
-Lets assume that you've done the above updates, and in preparation for the next
+Let's assume that you've done the above updates, and in preparation for the next
 major ABI version you decide you would like to retire the old version of the
 function. After having gone through the ABI deprecation announcement process,
 removal is easy.
-- 
2.51.0

