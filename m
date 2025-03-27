Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 165AFC36011
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Mar 2025 13:38:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 96CA440E0A;
	Thu, 27 Mar 2025 14:38:39 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 2C7F040E0A
 for <dev@dpdk.org>; Thu, 27 Mar 2025 14:38:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743082717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vE6vB3JET0Z4qSTEo5b3T5sQMqrYDBw4yYwX9mQQYGU=;
 b=VAuoDonC34CfYka01nAhbJcMEzkNWgZhJsfKtfq8ipRF4B56qwAUm2XtDxrATlE4O7Mkad
 YjQhYIk1yd1dcfnu5f83ydE/WBbN0OfC8seO5Z3eQGF+BjG6/g7+5rFpRrC1jaw+mBVjvp
 RrygOkX2tc2kHOEkUtrq5Bm4+ILCsf8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-193-oBl5fq3dOgOk2FQkbGHKmw-1; Thu,
 27 Mar 2025 09:38:31 -0400
X-MC-Unique: oBl5fq3dOgOk2FQkbGHKmw-1
X-Mimecast-MFC-AGG-ID: oBl5fq3dOgOk2FQkbGHKmw_1743082709
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B5C3E180AF50; Thu, 27 Mar 2025 13:38:29 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.224.228])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0144019560AB; Thu, 27 Mar 2025 13:38:26 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, bruce.richardson@intel.com,
 andremue@linux.microsoft.com,
 Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Jasvinder Singh <jasvinder.singh@intel.com>
Subject: [PATCH v5 8/8] eal: rework function versioning macros
Date: Thu, 27 Mar 2025 14:36:28 +0100
Message-ID: <20250327133638.2983276-9-david.marchand@redhat.com>
In-Reply-To: <20250327133638.2983276-1-david.marchand@redhat.com>
References: <20250305212349.2036410-1-david.marchand@redhat.com>
 <20250327133638.2983276-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6SEsuT_BGs-cYAPlYOa_40OZEd65NJOWDwW257R1Biw_1743082709
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

For versioning symbols:
- MSVC uses pragmas on the symbol,
- GNU linker uses special asm directives,

To accommodate both GNU linker and MSVC linker, introduce new macros for
exporting and versioning symbols that will surround the whole function.

This has the advantage of hiding all the ugly details in the macros.
Now versioning a symbol is just a call to a single macro:
- RTE_VERSION_SYMBOL (resp. RTE_VERSION_EXPERIMENTAL_SYMBOL), for
  keeping an old implementation code under a versioned function (resp.
  experimental function),
- RTE_DEFAULT_SYMBOL, for declaring the new default versioned function,
  and handling the static link special case, instead of
  BIND_DEFAULT_SYMBOL + MAP_STATIC_SYMBOL,

This replaces the macros from rte_function_versioning.h that were
previously publicly exported.

Update lib/net accordingly.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
Changes since RFC v4:
- moved new macros to eal_symbol_exports.h and simply dropped legacy
  macros/header,
- added release notes update,

Changes since RFC v3:
- fixed documentation and simplified examples,

Changes since RFC v1:
- renamed and prefixed macros,
- reindented in prevision of second patch,

---
 buildtools/gen-version-map.py              |  15 +-
 devtools/check-symbol-change.py            |   8 +-
 doc/api/doxy-api-index.md                  |   1 -
 doc/guides/contributing/abi_versioning.rst | 192 ++++++---------------
 doc/guides/rel_notes/release_25_07.rst     |   2 +
 lib/eal/common/eal_symbol_exports.h        |  66 +++++++
 lib/eal/include/rte_function_versioning.h  |  99 -----------
 lib/net/net_crc.h                          |  15 --
 lib/net/rte_net_crc.c                      |  29 +---
 9 files changed, 135 insertions(+), 292 deletions(-)
 delete mode 100644 lib/eal/include/rte_function_versioning.h

diff --git a/buildtools/gen-version-map.py b/buildtools/gen-version-map.py
index c7dfc9b8c2..7ee80ec640 100755
--- a/buildtools/gen-version-map.py
+++ b/buildtools/gen-version-map.py
@@ -13,10 +13,9 @@
 export_exp_sym_regexp = re.compile(r"^RTE_EXPORT_EXPERIMENTAL_SYMBOL\(([^,]+), ([0-9]+.[0-9]+)\)")
 export_int_sym_regexp = re.compile(r"^RTE_EXPORT_INTERNAL_SYMBOL\(([^)]+)\)")
 export_sym_regexp = re.compile(r"^RTE_EXPORT_SYMBOL\(([^)]+)\)")
-# From rte_function_versioning.h
-ver_sym_regexp = re.compile(r"^VERSION_SYMBOL\(([^,]+), [^,]+, ([^,]+)\)")
-ver_exp_sym_regexp = re.compile(r"^VERSION_SYMBOL_EXPERIMENTAL\([^,]+, ([^,]+)\)")
-default_sym_regexp = re.compile(r"^BIND_DEFAULT_SYMBOL\(([^,]+), [^,]+, ([^,]+)\)")
+ver_sym_regexp = re.compile(r"^RTE_VERSION_SYMBOL\(([^,]+), [^,]+, ([^,]+),")
+ver_exp_sym_regexp = re.compile(r"^RTE_VERSION_EXPERIMENTAL_SYMBOL\([^,]+, ([^,]+),")
+default_sym_regexp = re.compile(r"^RTE_DEFAULT_SYMBOL\(([^,]+), [^,]+, ([^,]+),")
 
 with open(abi_version_file) as f:
     abi = 'DPDK_{}'.format(re.match("([0-9]+).[0-9]", f.readline()).group(1))
@@ -40,14 +39,14 @@
                 node = abi
                 symbol = export_sym_regexp.match(ln).group(1)
             elif ver_sym_regexp.match(ln):
-                node = 'DPDK_{}'.format(ver_sym_regexp.match(ln).group(2))
-                symbol = ver_sym_regexp.match(ln).group(1)
+                node = 'DPDK_{}'.format(ver_sym_regexp.match(ln).group(1))
+                symbol = ver_sym_regexp.match(ln).group(2)
             elif ver_exp_sym_regexp.match(ln):
                 node = 'EXPERIMENTAL'
                 symbol = ver_exp_sym_regexp.match(ln).group(1)
             elif default_sym_regexp.match(ln):
-                node = 'DPDK_{}'.format(default_sym_regexp.match(ln).group(2))
-                symbol = default_sym_regexp.match(ln).group(1)
+                node = 'DPDK_{}'.format(default_sym_regexp.match(ln).group(1))
+                symbol = default_sym_regexp.match(ln).group(2)
 
             if not symbol:
                 continue
diff --git a/devtools/check-symbol-change.py b/devtools/check-symbol-change.py
index d522fbb1ec..d59ecaddd7 100755
--- a/devtools/check-symbol-change.py
+++ b/devtools/check-symbol-change.py
@@ -12,10 +12,10 @@
 export_exp_sym_regexp = re.compile(r"^.RTE_EXPORT_EXPERIMENTAL_SYMBOL\(([^,]+),")
 export_int_sym_regexp = re.compile(r"^.RTE_EXPORT_INTERNAL_SYMBOL\(([^)]+)\)")
 export_sym_regexp = re.compile(r"^.RTE_EXPORT_SYMBOL\(([^)]+)\)")
-# TODO, handle versioned symbols from rte_function_versioning.h
-# ver_sym_regexp = re.compile(r"^VERSION_SYMBOL\(([^,]+), [^,]+, ([^,]+)\)")
-# ver_exp_sym_regexp = re.compile(r"^VERSION_SYMBOL_EXPERIMENTAL\([^,]+, ([^,]+)\)")
-# default_sym_regexp = re.compile(r"^BIND_DEFAULT_SYMBOL\(([^,]+), [^,]+, ([^,]+)\)")
+# TODO, handle versioned symbols
+# ver_sym_regexp = re.compile(r"^.RTE_VERSION_SYMBOL\(([^,]+), [^,]+, ([^,]+),")
+# ver_exp_sym_regexp = re.compile(r"^.RTE_VERSION_EXPERIMENTAL_SYMBOL\([^,]+, ([^,]+),")
+# default_sym_regexp = re.compile(r"^.RTE_DEFAULT_SYMBOL\(([^,]+), [^,]+, ([^,]+),")
 
 symbols = {}
 
diff --git a/doc/api/doxy-api-index.md b/doc/api/doxy-api-index.md
index b2fc24b3e4..5c425a2cb9 100644
--- a/doc/api/doxy-api-index.md
+++ b/doc/api/doxy-api-index.md
@@ -248,7 +248,6 @@ The public API headers are grouped by topics:
   [EAL config](@ref rte_eal.h),
   [common](@ref rte_common.h),
   [experimental APIs](@ref rte_compat.h),
-  [ABI versioning](@ref rte_function_versioning.h),
   [version](@ref rte_version.h)
 
 - **tests**:
diff --git a/doc/guides/contributing/abi_versioning.rst b/doc/guides/contributing/abi_versioning.rst
index b6b6bf64d7..a0ce0ce1c9 100644
--- a/doc/guides/contributing/abi_versioning.rst
+++ b/doc/guides/contributing/abi_versioning.rst
@@ -132,32 +132,25 @@ functionality or behavior. When that occurs, it is may be required to allow for
 backward compatibility for a time with older binaries that are dynamically
 linked to the DPDK.
 
-To support backward compatibility the ``rte_function_versioning.h``
+To support backward compatibility the ``eal_symbol_exports.h``
 header file provides macros to use when updating exported functions. These
 macros allow multiple versions of a symbol to exist in a shared
 library so that older binaries need not be immediately recompiled.
 
-The macros exported are:
+The macros are:
 
-* ``VERSION_SYMBOL(b, e, n)``: Creates a symbol version table entry binding
-  versioned symbol ``b@DPDK_n`` to the internal function ``be``.
+* ``RTE_VERSION_SYMBOL(ver, type, name, args)``: Creates a symbol version table
+  entry binding symbol ``<name>@DPDK_<ver>`` to the internal function name
+  ``<name>_v<ver>``.
 
-* ``BIND_DEFAULT_SYMBOL(b, e, n)``: Creates a symbol version entry instructing
-  the linker to bind references to symbol ``b`` to the internal symbol
-  ``be``.
+* ``RTE_DEFAULT_SYMBOL(ver, type, name, args)``: Creates a symbol version entry
+  instructing the linker to bind references to symbol ``<name>`` to the internal
+  symbol ``<name>_v<ver>``.
 
-* ``MAP_STATIC_SYMBOL(f, p)``: Declare the prototype ``f``, and map it to the
-  fully qualified function ``p``, so that if a symbol becomes versioned, it
-  can still be mapped back to the public symbol name.
-
-* ``__vsym``:  Annotation to be used in a declaration of the internal symbol
-  ``be`` to signal that it is being used as an implementation of a particular
-  version of symbol ``b``.
-
-* ``VERSION_SYMBOL_EXPERIMENTAL(b, e)``: Creates a symbol version table entry
-  binding versioned symbol ``b@EXPERIMENTAL`` to the internal function ``be``.
-  The macro is used when a symbol matures to become part of the stable ABI, to
-  provide an alias to experimental until the next major ABI version.
+* ``RTE_VERSION_EXPERIMENTAL_SYMBOL(type, name, args)``:  Similar to RTE_VERSION_SYMBOL
+  but for experimental API symbols. The macro is used when a symbol matures
+  to become part of the stable ABI, to provide an alias to experimental
+  until the next major ABI version.
 
 .. _example_abi_macro_usage:
 
@@ -176,8 +169,8 @@ Assume we have a function as follows
   * manipulate
   */
  RTE_EXPORT_SYMBOL(rte_acl_create)
- struct rte_acl_ctx *
- rte_acl_create(const struct rte_acl_param *param)
+ int
+ rte_acl_create(struct rte_acl_param *param)
  {
         ...
  }
@@ -195,8 +188,8 @@ private, is safe), but it also requires modifying the code as follows
   * manipulate
   */
  RTE_EXPORT_SYMBOL(rte_acl_create)
- struct rte_acl_ctx *
- rte_acl_create(const struct rte_acl_param *param, int debug)
+ int
+ rte_acl_create(struct rte_acl_param *param, int debug)
  {
         ...
  }
@@ -215,87 +208,48 @@ application was linked to it.
 
 We need to specify in the code which function maps to the rte_acl_create
 symbol at which versions.  First, at the site of the initial symbol definition,
-we need to update the function so that it is uniquely named, and not in conflict
-with the public symbol name
+we wrap the function with ``RTE_VERSION_SYMBOL``, passing the current ABI version,
+the function return type, the function name and its arguments.
 
 .. code-block:: c
 
  -RTE_EXPORT_SYMBOL(rte_acl_create)
- -struct rte_acl_ctx *
- -rte_acl_create(const struct rte_acl_param *param)
- +struct rte_acl_ctx * __vsym
- +rte_acl_create_v21(const struct rte_acl_param *param)
+ -int
+ -rte_acl_create(struct rte_acl_param *param)
+ +RTE_VERSION_SYMBOL(21, int, rte_acl_create, (struct rte_acl_param *param))
  {
         size_t sz;
         struct rte_acl_ctx *ctx;
         ...
 
-Note that the base name of the symbol was kept intact, as this is conducive to
-the macros used for versioning symbols and we have annotated the function as
-``__vsym``, an implementation of a versioned symbol . That is our next step,
-mapping this new symbol name to the initial symbol name at version node 21.
-Immediately after the function, we add the VERSION_SYMBOL macro.
-
-.. code-block:: c
-
-   #include <rte_function_versioning.h>
-
-   ...
-   VERSION_SYMBOL(rte_acl_create, _v21, 21);
-
-Remembering to also add the rte_function_versioning.h header to the requisite c
-file where these changes are being made. The macro instructs the linker to
-create a new symbol ``rte_acl_create@DPDK_21``, which matches the symbol created
-in older builds, but now points to the above newly named function. We have now
-mapped the original rte_acl_create symbol to the original function (but with a
-new name).
+The macro instructs the linker to create a new symbol ``rte_acl_create@DPDK_21``,
+which matches the symbol created in older builds,
+but now points to the above newly named function ``rte_acl_create_v21``.
+We have now mapped the original rte_acl_create symbol to the original function
+(but with a new name).
 
 Please see the section :ref:`Enabling versioning macros
 <enabling_versioning_macros>` to enable this macro in the meson/ninja build.
-Next, we need to create the new ``v22`` version of the symbol. We create a new
-function name, with the ``v22`` suffix, and implement it appropriately.
+
+Next, we need to create the new version of the symbol. We create a new
+function name and implement it appropriately, then wrap it in a call to ``RTE_DEFAULT_SYMBOL``.
 
 .. code-block:: c
 
-   struct rte_acl_ctx * __vsym
-   rte_acl_create_v22(const struct rte_acl_param *param, int debug);
+   RTE_DEFAULT_SYMBOL(22, int, rte_acl_create, (struct rte_acl_param *param, int debug))
    {
-        struct rte_acl_ctx *ctx = rte_acl_create_v21(param);
+        int ret = rte_acl_create_v21(param);
 
-        ctx->debug = debug;
+        if (debug) {
+        ...
+        }
 
-        return ctx;
+        return ret;
    }
 
-This code serves as our new API call. Its the same as our old call, but adds the
-new parameter in place. Next we need to map this function to the new default
-symbol ``rte_acl_create@DPDK_22``. To do this, immediately after the function,
-we add the BIND_DEFAULT_SYMBOL macro.
-
-.. code-block:: c
-
-   #include <rte_function_versioning.h>
-
-   ...
-   BIND_DEFAULT_SYMBOL(rte_acl_create, _v22, 22);
-
 The macro instructs the linker to create the new default symbol
-``rte_acl_create@DPDK_22``, which points to the above newly named function.
-
-We finally modify the prototype of the call in the public header file,
-such that it contains both versions of the symbol and the public API.
-
-.. code-block:: c
-
-   struct rte_acl_ctx *
-   rte_acl_create(const struct rte_acl_param *param);
-
-   struct rte_acl_ctx * __vsym
-   rte_acl_create_v21(const struct rte_acl_param *param);
-
-   struct rte_acl_ctx * __vsym
-   rte_acl_create_v22(const struct rte_acl_param *param, int debug);
-
+``rte_acl_create@DPDK_22``, which points to the function named ``rte_acl_create_v22``
+(declared by the macro).
 
 And that's it. On the next shared library rebuild, there will be two versions of rte_acl_create,
 an old DPDK_21 version, used by previously built applications, and a new DPDK_22 version,
@@ -304,43 +258,10 @@ used by newly built applications.
 .. note::
 
    **Before you leave**, please take care reviewing the sections on
-   :ref:`mapping static symbols <mapping_static_symbols>`,
    :ref:`enabling versioning macros <enabling_versioning_macros>`,
    and :ref:`ABI deprecation <abi_deprecation>`.
 
 
-.. _mapping_static_symbols:
-
-Mapping static symbols
-______________________
-
-Now we've taken what was a public symbol, and duplicated it into two uniquely
-and differently named symbols. We've then mapped each of those back to the
-public symbol ``rte_acl_create`` with different version tags. This only applies
-to dynamic linking, as static linking has no notion of versioning. That leaves
-this code in a position of no longer having a symbol simply named
-``rte_acl_create`` and a static build will fail on that missing symbol.
-
-To correct this, we can simply map a function of our choosing back to the public
-symbol in the static build with the ``MAP_STATIC_SYMBOL`` macro.  Generally the
-assumption is that the most recent version of the symbol is the one you want to
-map.  So, back in the C file where, immediately after ``rte_acl_create_v22`` is
-defined, we add this
-
-
-.. code-block:: c
-
-   struct rte_acl_ctx * __vsym
-   rte_acl_create_v22(const struct rte_acl_param *param, int debug)
-   {
-        ...
-   }
-   MAP_STATIC_SYMBOL(struct rte_acl_ctx *rte_acl_create(const struct rte_acl_param *param, int debug), rte_acl_create_v22);
-
-That tells the compiler that, when building a static library, any calls to the
-symbol ``rte_acl_create`` should be linked to ``rte_acl_create_v22``
-
-
 .. _enabling_versioning_macros:
 
 Enabling versioning macros
@@ -384,8 +305,8 @@ Assume we have an experimental function ``rte_acl_create`` as follows:
     */
    RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_acl_create)
    __rte_experimental
-   struct rte_acl_ctx *
-   rte_acl_create(const struct rte_acl_param *param)
+   int
+   rte_acl_create(struct rte_acl_param *param)
    {
    ...
    }
@@ -400,8 +321,8 @@ When we promote the symbol to the stable ABI, we simply strip the
     * manipulate
     */
    RTE_EXPORT_SYMBOL(rte_acl_create)
-   struct rte_acl_ctx *
-   rte_acl_create(const struct rte_acl_param *param)
+   int
+   rte_acl_create(struct rte_acl_param *param)
    {
           ...
    }
@@ -416,33 +337,20 @@ and ``DPDK_22`` version nodes.
 .. code-block:: c
 
    #include <rte_compat.h>;
-   #include <rte_function_versioning.h>
 
    /*
     * Create an acl context object for apps to
     * manipulate
     */
-   RTE_EXPORT_SYMBOL(rte_acl_create)
-   struct rte_acl_ctx *
-   rte_acl_create(const struct rte_acl_param *param)
+   RTE_DEFAULT_SYMBOL(22, int, rte_acl_create, (struct rte_acl_param *param))
    {
    ...
    }
 
-   __rte_experimental
-   struct rte_acl_ctx *
-   rte_acl_create_e(const struct rte_acl_param *param)
-   {
-      return rte_acl_create(param);
-   }
-   VERSION_SYMBOL_EXPERIMENTAL(rte_acl_create, _e);
-
-   struct rte_acl_ctx *
-   rte_acl_create_v22(const struct rte_acl_param *param)
+   RTE_VERSION_EXPERIMENTAL_SYMBOL(int, rte_acl_create, (struct rte_acl_param *param))
    {
       return rte_acl_create(param);
    }
-   BIND_DEFAULT_SYMBOL(rte_acl_create, _v22, 22);
 
 .. _abi_deprecation:
 
@@ -458,10 +366,10 @@ Next remove the corresponding versioned export.
 
 .. code-block:: c
 
- -VERSION_SYMBOL(rte_acl_create, _v21, 21);
+ -RTE_VERSION_SYMBOL(21, int, rte_acl_create, (struct rte_acl_param *param))
 
 
-Note that the internal function definition could also be removed, but its used
+Note that the internal function definition must also be removed, but it is used
 in our example by the newer version ``v22``, so we leave it in place and declare
 it as static. This is a coding style choice.
 
@@ -476,18 +384,16 @@ of a major ABI version. If a version node completely specifies an API, then
 removing part of it, typically makes it incomplete. In those cases it is better
 to remove the entire node.
 
- };
-
-Any uses of BIND_DEFAULT_SYMBOL that pointed to the old node should be
+Any uses of RTE_DEFAULT_SYMBOL that pointed to the old node should be
 updated to point to the new version node in any header files for all affected
 symbols.
 
 .. code-block:: c
 
- -BIND_DEFAULT_SYMBOL(rte_acl_create, _v21, 21);
- +BIND_DEFAULT_SYMBOL(rte_acl_create, _v22, 22);
+ -RTE_DEFAULT_SYMBOL(21, int, rte_acl_create, (struct rte_acl_param *param, int debug))
+ +RTE_DEFAULT_SYMBOL(22, int, rte_acl_create, (struct rte_acl_param *param, int debug))
 
-Lastly, any VERSION_SYMBOL macros that point to the old version nodes
+Lastly, any RTE_VERSION_SYMBOL macros that point to the old version nodes
 should be removed, taking care to preserve any code that is shared
 with the new version node.
 
diff --git a/doc/guides/rel_notes/release_25_07.rst b/doc/guides/rel_notes/release_25_07.rst
index cd1025aac0..093b85d206 100644
--- a/doc/guides/rel_notes/release_25_07.rst
+++ b/doc/guides/rel_notes/release_25_07.rst
@@ -68,6 +68,8 @@ Removed Items
    Also, make sure to start the actual text at the margin.
    =======================================================
 
+* eal: Removed the ``rte_function_versioning.h`` header from the exported headers.
+
 
 API Changes
 -----------
diff --git a/lib/eal/common/eal_symbol_exports.h b/lib/eal/common/eal_symbol_exports.h
index b3033dd336..b66ca8fa68 100644
--- a/lib/eal/common/eal_symbol_exports.h
+++ b/lib/eal/common/eal_symbol_exports.h
@@ -5,6 +5,8 @@
 #ifndef EAL_SYMBOL_EXPORTS_H
 #define EAL_SYMBOL_EXPORTS_H
 
+#include <rte_common.h>
+
 /* Internal macros for exporting symbols, used by the build system.
  * For RTE_EXPORT_EXPERIMENTAL_SYMBOL, ver indicates the
  * version this symbol was introduced in.
@@ -13,4 +15,68 @@
 #define RTE_EXPORT_INTERNAL_SYMBOL(a)
 #define RTE_EXPORT_SYMBOL(a)
 
+#if !defined(RTE_USE_FUNCTION_VERSIONING) && (defined(RTE_CC_GCC) || defined(RTE_CC_CLANG))
+#define VERSIONING_WARN RTE_PRAGMA_WARNING(Use of function versioning disabled. \
+	Is "use_function_versioning=true" in meson.build?)
+#else
+#define VERSIONING_WARN
+#endif
+
+/*
+ * Provides backwards compatibility when updating exported functions.
+ * When a symbol is exported from a library to provide an API, it also provides a
+ * calling convention (ABI) that is embodied in its name, return type,
+ * arguments, etc.  On occasion that function may need to change to accommodate
+ * new functionality, behavior, etc.  When that occurs, it is desirable to
+ * allow for backwards compatibility for a time with older binaries that are
+ * dynamically linked to the dpdk.
+ */
+
+#ifdef RTE_BUILD_SHARED_LIB
+
+/*
+ * RTE_VERSION_SYMBOL
+ * Creates a symbol version table entry binding symbol <name>@DPDK_<ver> to the internal
+ * function name <name>_v<ver>.
+ */
+#define RTE_VERSION_SYMBOL(ver, type, name, args) VERSIONING_WARN \
+__asm__(".symver " RTE_STR(name) "_v" RTE_STR(ver) ", " RTE_STR(name) "@DPDK_" RTE_STR(ver)); \
+__rte_used type name ## _v ## ver args; \
+type name ## _v ## ver args
+
+/*
+ * RTE_VERSION_EXPERIMENTAL_SYMBOL
+ * Similar to RTE_VERSION_SYMBOL but for experimental API symbols.
+ * This is mainly used for keeping compatibility for symbols that get promoted to stable ABI.
+ */
+#define RTE_VERSION_EXPERIMENTAL_SYMBOL(type, name, args) VERSIONING_WARN \
+__asm__(".symver " RTE_STR(name) "_exp, " RTE_STR(name) "@EXPERIMENTAL") \
+__rte_used type name ## _exp args; \
+type name ## _exp args
+
+/*
+ * RTE_DEFAULT_SYMBOL
+ * Creates a symbol version entry instructing the linker to bind references to
+ * symbol <name> to the internal symbol <name>_v<ver>.
+ */
+#define RTE_DEFAULT_SYMBOL(ver, type, name, args) VERSIONING_WARN \
+__asm__(".symver " RTE_STR(name) "_v" RTE_STR(ver) ", " RTE_STR(name) "@@DPDK_" RTE_STR(ver)); \
+__rte_used type name ## _v ## ver args; \
+type name ## _v ## ver args
+
+#else /* !RTE_BUILD_SHARED_LIB */
+
+#define RTE_VERSION_SYMBOL(ver, type, name, args) VERSIONING_WARN \
+type name ## _v ## ver args; \
+type name ## _v ## ver args
+
+#define RTE_VERSION_EXPERIMENTAL_SYMBOL(type, name, args) VERSIONING_WARN \
+type name ## _exp args; \
+type name ## _exp args
+
+#define RTE_DEFAULT_SYMBOL(ver, type, name, args) VERSIONING_WARN \
+type name args
+
+#endif /* RTE_BUILD_SHARED_LIB */
+
 #endif /* EAL_SYMBOL_EXPORTS_H */
diff --git a/lib/eal/include/rte_function_versioning.h b/lib/eal/include/rte_function_versioning.h
deleted file mode 100644
index eb6dd2bc17..0000000000
--- a/lib/eal/include/rte_function_versioning.h
+++ /dev/null
@@ -1,99 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2015 Neil Horman <nhorman@tuxdriver.com>.
- * All rights reserved.
- */
-
-#ifndef _RTE_FUNCTION_VERSIONING_H_
-#define _RTE_FUNCTION_VERSIONING_H_
-#include <rte_common.h>
-
-#ifndef RTE_USE_FUNCTION_VERSIONING
-#error Use of function versioning disabled, is "use_function_versioning=true" in meson.build?
-#endif
-
-#ifdef RTE_BUILD_SHARED_LIB
-
-/*
- * Provides backwards compatibility when updating exported functions.
- * When a symbol is exported from a library to provide an API, it also provides a
- * calling convention (ABI) that is embodied in its name, return type,
- * arguments, etc.  On occasion that function may need to change to accommodate
- * new functionality, behavior, etc.  When that occurs, it is desirable to
- * allow for backwards compatibility for a time with older binaries that are
- * dynamically linked to the dpdk.  To support that, the __vsym and
- * VERSION_SYMBOL macros are created.  They, in conjunction with the
- * version.map file for a given library allow for multiple versions of
- * a symbol to exist in a shared library so that older binaries need not be
- * immediately recompiled.
- *
- * Refer to the guidelines document in the docs subdirectory for details on the
- * use of these macros
- */
-
-/*
- * Macro Parameters:
- * b - function base name
- * e - function version extension, to be concatenated with base name
- * n - function symbol version string to be applied
- * f - function prototype
- * p - full function symbol name
- */
-
-/*
- * VERSION_SYMBOL
- * Creates a symbol version table entry binding symbol <b>@DPDK_<n> to the internal
- * function name <b><e>
- */
-#define VERSION_SYMBOL(b, e, n) __asm__(".symver " RTE_STR(b) RTE_STR(e) ", " RTE_STR(b) "@DPDK_" RTE_STR(n))
-
-/*
- * VERSION_SYMBOL_EXPERIMENTAL
- * Creates a symbol version table entry binding the symbol <b>@EXPERIMENTAL to the internal
- * function name <b><e>. The macro is used when a symbol matures to become part of the stable ABI,
- * to provide an alias to experimental for some time.
- */
-#define VERSION_SYMBOL_EXPERIMENTAL(b, e) __asm__(".symver " RTE_STR(b) RTE_STR(e) ", " RTE_STR(b) "@EXPERIMENTAL")
-
-/*
- * BIND_DEFAULT_SYMBOL
- * Creates a symbol version entry instructing the linker to bind references to
- * symbol <b> to the internal symbol <b><e>
- */
-#define BIND_DEFAULT_SYMBOL(b, e, n) __asm__(".symver " RTE_STR(b) RTE_STR(e) ", " RTE_STR(b) "@@DPDK_" RTE_STR(n))
-
-/*
- * __vsym
- * Annotation to be used in declaration of the internal symbol <b><e> to signal
- * that it is being used as an implementation of a particular version of symbol
- * <b>.
- */
-#define __vsym __rte_used
-
-/*
- * MAP_STATIC_SYMBOL
- * If a function has been bifurcated into multiple versions, none of which
- * are defined as the exported symbol name in the map file, this macro can be
- * used to alias a specific version of the symbol to its exported name.  For
- * example, if you have 2 versions of a function foo_v1 and foo_v2, where the
- * former is mapped to foo@DPDK_1 and the latter is mapped to foo@DPDK_2 when
- * building a shared library, this macro can be used to map either foo_v1 or
- * foo_v2 to the symbol foo when building a static library, e.g.:
- * MAP_STATIC_SYMBOL(void foo(), foo_v2);
- */
-#define MAP_STATIC_SYMBOL(f, p)
-
-#else
-/*
- * No symbol versioning in use
- */
-#define VERSION_SYMBOL(b, e, n)
-#define VERSION_SYMBOL_EXPERIMENTAL(b, e)
-#define __vsym
-#define BIND_DEFAULT_SYMBOL(b, e, n)
-#define MAP_STATIC_SYMBOL(f, p) f __attribute__((alias(RTE_STR(p))))
-/*
- * RTE_BUILD_SHARED_LIB=n
- */
-#endif
-
-#endif /* _RTE_FUNCTION_VERSIONING_H_ */
diff --git a/lib/net/net_crc.h b/lib/net/net_crc.h
index 4930e2f0b3..320b0edca8 100644
--- a/lib/net/net_crc.h
+++ b/lib/net/net_crc.h
@@ -7,21 +7,6 @@
 
 #include "rte_net_crc.h"
 
-void
-rte_net_crc_set_alg_v25(enum rte_net_crc_alg alg);
-
-struct rte_net_crc *
-rte_net_crc_set_alg_v26(enum rte_net_crc_alg alg,
-	enum rte_net_crc_type type);
-
-uint32_t
-rte_net_crc_calc_v25(const void *data,
-	uint32_t data_len, enum rte_net_crc_type type);
-
-uint32_t
-rte_net_crc_calc_v26(const struct rte_net_crc *ctx,
-	const void *data, const uint32_t data_len);
-
 /*
  * Different implementations of CRC
  */
diff --git a/lib/net/rte_net_crc.c b/lib/net/rte_net_crc.c
index 4efb095bc4..e769c7e22e 100644
--- a/lib/net/rte_net_crc.c
+++ b/lib/net/rte_net_crc.c
@@ -11,7 +11,6 @@
 #include <rte_net_crc.h>
 #include <rte_log.h>
 #include <rte_vect.h>
-#include <rte_function_versioning.h>
 #include <rte_malloc.h>
 
 #include "net_crc.h"
@@ -346,8 +345,7 @@ handlers_init(enum rte_net_crc_alg alg)
 
 /* Public API */
 
-void
-rte_net_crc_set_alg_v25(enum rte_net_crc_alg alg)
+RTE_VERSION_SYMBOL(25, void, rte_net_crc_set_alg, (enum rte_net_crc_alg alg))
 {
 	handlers = NULL;
 	if (max_simd_bitwidth == 0)
@@ -374,10 +372,9 @@ rte_net_crc_set_alg_v25(enum rte_net_crc_alg alg)
 	if (handlers == NULL)
 		handlers = handlers_scalar;
 }
-VERSION_SYMBOL(rte_net_crc_set_alg, _v25, 25);
 
-struct rte_net_crc *rte_net_crc_set_alg_v26(enum rte_net_crc_alg alg,
-	enum rte_net_crc_type type)
+RTE_DEFAULT_SYMBOL(26, struct rte_net_crc *, rte_net_crc_set_alg, (enum rte_net_crc_alg alg,
+	enum rte_net_crc_type type))
 {
 	uint16_t max_simd_bitwidth;
 	struct rte_net_crc *crc;
@@ -415,10 +412,6 @@ struct rte_net_crc *rte_net_crc_set_alg_v26(enum rte_net_crc_alg alg,
 	}
 	return crc;
 }
-BIND_DEFAULT_SYMBOL(rte_net_crc_set_alg, _v26, 26);
-MAP_STATIC_SYMBOL(struct rte_net_crc *rte_net_crc_set_alg(
-	enum rte_net_crc_alg alg, enum rte_net_crc_type type),
-	rte_net_crc_set_alg_v26);
 
 RTE_EXPORT_SYMBOL(rte_net_crc_free)
 void rte_net_crc_free(struct rte_net_crc *crc)
@@ -426,10 +419,8 @@ void rte_net_crc_free(struct rte_net_crc *crc)
 	rte_free(crc);
 }
 
-uint32_t
-rte_net_crc_calc_v25(const void *data,
-	uint32_t data_len,
-	enum rte_net_crc_type type)
+RTE_VERSION_SYMBOL(25, uint32_t, rte_net_crc_calc, (const void *data, uint32_t data_len,
+	enum rte_net_crc_type type))
 {
 	uint32_t ret;
 	rte_net_crc_handler f_handle;
@@ -439,18 +430,12 @@ rte_net_crc_calc_v25(const void *data,
 
 	return ret;
 }
-VERSION_SYMBOL(rte_net_crc_calc, _v25, 25);
 
-uint32_t
-rte_net_crc_calc_v26(const struct rte_net_crc *ctx,
-	const void *data, const uint32_t data_len)
+RTE_DEFAULT_SYMBOL(26, uint32_t, rte_net_crc_calc, (const struct rte_net_crc *ctx,
+	const void *data, const uint32_t data_len))
 {
 	return handlers_dpdk26[ctx->alg].f[ctx->type](data, data_len);
 }
-BIND_DEFAULT_SYMBOL(rte_net_crc_calc, _v26, 26);
-MAP_STATIC_SYMBOL(uint32_t rte_net_crc_calc(const struct rte_net_crc *ctx,
-	const void *data, const uint32_t data_len),
-	rte_net_crc_calc_v26);
 
 /* Call initialisation helpers for all crc algorithm handlers */
 RTE_INIT(rte_net_crc_init)
-- 
2.48.1

