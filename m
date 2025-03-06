Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F09E2C282D1
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Mar 2025 12:50:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BD90040430;
	Thu,  6 Mar 2025 13:50:31 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 953794029E
 for <dev@dpdk.org>; Thu,  6 Mar 2025 13:50:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741265430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AvIX72qzlWD6xnUqt86Z9FR+k6MmFMtCkmJL/nQLM/w=;
 b=NnM+Ix8Z13tJfPTC7qEiHTSGreiv6vr/MXyS99czVlujUnqKKpL0MgqN9/Ay7aSpGn9VSk
 LMm+JMuDkK51e01cPll21DZ7+paPJ5ddQWhmyqKc6bfBiW4aDQsuZ2h/r4qDyaEVzbsPc0
 tAhmhAKR4p/bEoUuBP+KSSrBix5Y0o4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-jmhbB_XXPjqUkwi7F-O4vw-1; Thu,
 06 Mar 2025 07:50:28 -0500
X-MC-Unique: jmhbB_XXPjqUkwi7F-O4vw-1
X-Mimecast-MFC-AGG-ID: jmhbB_XXPjqUkwi7F-O4vw_1741265427
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1520B1956050; Thu,  6 Mar 2025 12:50:27 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.224.74])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9A4701800373; Thu,  6 Mar 2025 12:50:24 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, bruce.richardson@intel.com,
 andremue@linux.microsoft.com,
 Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Jasvinder Singh <jasvinder.singh@intel.com>
Subject: [RFC v2 1/2] eal: add new function versioning macros
Date: Thu,  6 Mar 2025 13:50:20 +0100
Message-ID: <20250306125021.2231121-1-david.marchand@redhat.com>
In-Reply-To: <20250305212349.2036410-1-david.marchand@redhat.com>
References: <20250305212349.2036410-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: suNUQUiEqObshFHddVrx4BFfYedBzzhQozOX1--QjBQ_1741265427
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

Documentation has been updated though it needs some polishing.
The experimental macro has not been tested.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
Changes since RFC v1:
- renamed and prefixed macros,
- reindented in prevision of second patch,

---
 doc/guides/contributing/abi_versioning.rst | 130 ++++-----------------
 lib/eal/include/rte_function_versioning.h  |  27 +++++
 lib/net/rte_net_crc.c                      |  30 ++---
 3 files changed, 57 insertions(+), 130 deletions(-)

diff --git a/doc/guides/contributing/abi_versioning.rst b/doc/guides/contributing/abi_versioning.rst
index 7afd1c1886..c4baf6433a 100644
--- a/doc/guides/contributing/abi_versioning.rst
+++ b/doc/guides/contributing/abi_versioning.rst
@@ -277,86 +277,49 @@ list of exported symbols when DPDK is compiled as a shared library.
 
 Next, we need to specify in the code which function maps to the rte_acl_create
 symbol at which versions.  First, at the site of the initial symbol definition,
-we need to update the function so that it is uniquely named, and not in conflict
-with the public symbol name
+we wrap the function with ``RTE_VERSION_SYMBOL``, passing the current ABI version,
+the function return type, and the function name, then the full implementation of the
+function.
 
 .. code-block:: c
 
  -struct rte_acl_ctx *
  -rte_acl_create(const struct rte_acl_param *param)
- +struct rte_acl_ctx * __vsym
- +rte_acl_create_v21(const struct rte_acl_param *param)
+ +RTE_VERSION_SYMBOL(21, struct rte_acl_ctx *, rte_acl_create, (const struct rte_acl_param *param)
  {
         size_t sz;
         struct rte_acl_ctx *ctx;
         ...
-
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
+ -}
+ +})
 
 Remembering to also add the rte_function_versioning.h header to the requisite c
 file where these changes are being made. The macro instructs the linker to
 create a new symbol ``rte_acl_create@DPDK_21``, which matches the symbol created
-in older builds, but now points to the above newly named function. We have now
-mapped the original rte_acl_create symbol to the original function (but with a
-new name).
+in older builds, but now points to the above newly named function ``rte_acl_create_v21``.
+We have now mapped the original rte_acl_create symbol to the original function
+(but with a new name).
 
 Please see the section :ref:`Enabling versioning macros
 <enabling_versioning_macros>` to enable this macro in the meson/ninja build.
-Next, we need to create the new ``v22`` version of the symbol. We create a new
-function name, with the ``v22`` suffix, and implement it appropriately.
+Next, we need to create the new version of the symbol. We create a new
+function name and implement it appropriately, then wrap it in a call to ``RTE_DEFAULT_SYMBOL``.
 
 .. code-block:: c
 
-   struct rte_acl_ctx * __vsym
-   rte_acl_create_v22(const struct rte_acl_param *param, int debug);
+   RTE_DEFAULT_SYMBOL(22, struct rte_acl_ctx *, rte_acl_create, (const struct rte_acl_param *param,
+        int debug);
    {
         struct rte_acl_ctx *ctx = rte_acl_create_v21(param);
 
         ctx->debug = debug;
 
         return ctx;
-   }
-
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
+   })
 
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
 
 And that's it, on the next shared library rebuild, there will be two versions of
 rte_acl_create, an old DPDK_21 version, used by previously built applications,
@@ -365,43 +328,10 @@ and a new DPDK_22 version, used by future built applications.
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
@@ -519,26 +449,17 @@ and ``DPDK_22`` version nodes.
     * Create an acl context object for apps to
     * manipulate
     */
-   struct rte_acl_ctx *
-   rte_acl_create(const struct rte_acl_param *param)
+   RTE_DEFAULT_SYMBOL(22, struct rte_acl_ctx *, rte_acl_create,
+        (const struct rte_acl_param *param)
    {
    ...
-   }
+   })
 
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
+   RTE_VERSION_EXPERIMENTAL_SYMBOL(struct rte_acl_ctx *, rte_acl_create,
+        (const struct rte_acl_param *param)
    {
       return rte_acl_create(param);
-   }
-   BIND_DEFAULT_SYMBOL(rte_acl_create, _v22, 22);
+   })
 
 In the map file, we map the symbol to both the ``EXPERIMENTAL``
 and ``DPDK_22`` version nodes.
@@ -564,13 +485,6 @@ and ``DPDK_22`` version nodes.
         rte_acl_create;
    };
 
-.. note::
-
-   Please note, similar to :ref:`symbol versioning <example_abi_macro_usage>`,
-   when aliasing to experimental you will also need to take care of
-   :ref:`mapping static symbols <mapping_static_symbols>`.
-
-
 .. _abi_deprecation:
 
 Deprecating part of a public API
diff --git a/lib/eal/include/rte_function_versioning.h b/lib/eal/include/rte_function_versioning.h
index eb6dd2bc17..259b960ef5 100644
--- a/lib/eal/include/rte_function_versioning.h
+++ b/lib/eal/include/rte_function_versioning.h
@@ -96,4 +96,31 @@
  */
 #endif
 
+#ifdef RTE_BUILD_SHARED_LIB
+
+#define RTE_VERSION_SYMBOL(ver, type, name, ...) \
+__rte_used type name ## _v ## ver __VA_ARGS__ \
+__asm__(".symver " RTE_STR(name) "_v" RTE_STR(ver) ", " RTE_STR(name) "@DPDK_" RTE_STR(ver));
+
+#define RTE_VERSION_EXPERIMENTAL_SYMBOL(type, name, ...) \
+__rte_used type name ## _exp __VA_ARGS__ \
+__asm__(".symver " RTE_STR(name) "_exp, " RTE_STR(name) "@EXPERIMENTAL")
+
+#define RTE_DEFAULT_SYMBOL(ver, type, name, ...) \
+__rte_used type name ## _v ## ver __VA_ARGS__ \
+__asm__(".symver " RTE_STR(name) "_v" RTE_STR(ver) ", " RTE_STR(name) "@@DPDK_" RTE_STR(ver));
+
+#else /* !RTE_BUILD_SHARED_LIB */
+
+#define RTE_VERSION_SYMBOL(ver, type, name, ...) \
+type name ## _v ## ver __VA_ARGS__
+
+#define RTE_VERSION_EXPERIMENTAL_SYMBOL(type, name, ...) \
+type name ## _exp __VA_ARGS__
+
+#define RTE_DEFAULT_SYMBOL(ver, type, name, ...) \
+type name __VA_ARGS__
+
+#endif /* RTE_BUILD_SHARED_LIB */
+
 #endif /* _RTE_FUNCTION_VERSIONING_H_ */
diff --git a/lib/net/rte_net_crc.c b/lib/net/rte_net_crc.c
index 2fb3eec231..dd93d43c2e 100644
--- a/lib/net/rte_net_crc.c
+++ b/lib/net/rte_net_crc.c
@@ -345,8 +345,7 @@ handlers_init(enum rte_net_crc_alg alg)
 
 /* Public API */
 
-void
-rte_net_crc_set_alg_v25(enum rte_net_crc_alg alg)
+RTE_VERSION_SYMBOL(25, void, rte_net_crc_set_alg, (enum rte_net_crc_alg alg)
 {
 	handlers = NULL;
 	if (max_simd_bitwidth == 0)
@@ -372,10 +371,9 @@ rte_net_crc_set_alg_v25(enum rte_net_crc_alg alg)
 
 	if (handlers == NULL)
 		handlers = handlers_scalar;
-}
-VERSION_SYMBOL(rte_net_crc_set_alg, _v25, 25);
+})
 
-struct rte_net_crc *rte_net_crc_set_alg_v26(enum rte_net_crc_alg alg,
+RTE_DEFAULT_SYMBOL(26, struct rte_net_crc *, rte_net_crc_set_alg, (enum rte_net_crc_alg alg,
 	enum rte_net_crc_type type)
 {
 	uint16_t max_simd_bitwidth;
@@ -413,20 +411,14 @@ struct rte_net_crc *rte_net_crc_set_alg_v26(enum rte_net_crc_alg alg,
 		break;
 	}
 	return crc;
-}
-BIND_DEFAULT_SYMBOL(rte_net_crc_set_alg, _v26, 26);
-MAP_STATIC_SYMBOL(struct rte_net_crc *rte_net_crc_set_alg(
-	enum rte_net_crc_alg alg, enum rte_net_crc_type type),
-	rte_net_crc_set_alg_v26);
+})
 
 void rte_net_crc_free(struct rte_net_crc *crc)
 {
 	rte_free(crc);
 }
 
-uint32_t
-rte_net_crc_calc_v25(const void *data,
-	uint32_t data_len,
+RTE_VERSION_SYMBOL(25, uint32_t, rte_net_crc_calc, (const void *data, uint32_t data_len,
 	enum rte_net_crc_type type)
 {
 	uint32_t ret;
@@ -436,19 +428,13 @@ rte_net_crc_calc_v25(const void *data,
 	ret = f_handle(data, data_len);
 
 	return ret;
-}
-VERSION_SYMBOL(rte_net_crc_calc, _v25, 25);
+})
 
-uint32_t
-rte_net_crc_calc_v26(const struct rte_net_crc *ctx,
+RTE_DEFAULT_SYMBOL(26, uint32_t, rte_net_crc_calc, (const struct rte_net_crc *ctx,
 	const void *data, const uint32_t data_len)
 {
 	return handlers_dpdk26[ctx->alg].f[ctx->type](data, data_len);
-}
-BIND_DEFAULT_SYMBOL(rte_net_crc_calc, _v26, 26);
-MAP_STATIC_SYMBOL(uint32_t rte_net_crc_calc(const struct rte_net_crc *ctx,
-	const void *data, const uint32_t data_len),
-	rte_net_crc_calc_v26);
+})
 
 /* Call initialisation helpers for all crc algorithm handlers */
 RTE_INIT(rte_net_crc_init)
-- 
2.48.1

