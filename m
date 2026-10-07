Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A84CA5FFF
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 21:42:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 84AD242DD6;
	Wed,  7 Oct 2026 23:41:36 +0200 (CEST)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mails.dpdk.org (Postfix) with ESMTP id F3C9342D91
 for <dev@dpdk.org>; Wed,  7 Oct 2026 23:41:33 +0200 (CEST)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2e4c080a472so21048725ad.3
 for <dev@dpdk.org>; Wed, 07 Oct 2026 14:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791409293;
 x=1792014093; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=l7htBFkytT60gIFTyJwrgCSQypqmA8dIXt/0q+rXBNY=;
 b=Egf0edKZ/V1sMAW3ZTPBX3EdFXDb9GSxK+ztv46z3zsq5p/0jp//Hv2M61ar+Dfd57
 7siXR2voCaT8U6bQXUFF3bqaofNM/+71Mpt4Ec4wg2Zhf3duErOPPb4KsNbPzA1lbfIr
 wOoaZ8W957v2ol+LOSLgZzFCR8pTsaMTKYO3FgIf8vtYZv+D+jwK30mEJClMzm1YJOUS
 QaIKCk2+3nOTjS8uop8gNrUlp7Midx57J4wZrjbHz2b53MEn4p8WawWnTXux98y74Tqv
 svBXRp2L8uVMagWdMhpjtI7FzGpt/779ZiBiRk3AaXNTvW6vHIkgEtXDelE8BT9kXAH8
 TzXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791409293; x=1792014093;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=l7htBFkytT60gIFTyJwrgCSQypqmA8dIXt/0q+rXBNY=;
 b=MotVs8GSU7GBily00v4xoR9QUvvT3KojLi8a0RfwTgNneY6q+2q+zyG0gFZ8ZuFc9B
 ZdfnQ12z321iGidxzYPw+LtPTEro3LOl9KXZ0BHrbtOI/JdD+Yoi8CT2uR5yh5tAlbJ7
 prp9Ga+wL5263pmVJsaOlde3GJ9OZIMtPxP/wPjcM/kxt4qeujR/E+ykpCwVH0FutLor
 rTlXWy6e8sPJSgdU4u/8+uAiJ/E5vFuodND03lBrSz/8+iGYcwq1PRzJjAxTPTZT74yF
 tJ9M6umlcDDX03D/l8y/kqB+6+0LB+aBwyMIP6lJ2Aa0n8A3KIDF6dJB3ZPFuRVOaNzi
 McnQ==
X-Gm-Message-State: AFq9FYIcX9F/WvDwM5ir5ekVhWYr978PFszYKUT7P+V/CNfGIq+7jPmV
 2JytdMywdTMo5VK2uWaGgbSqPjSOwE/KhP8Do7Vo2xdo1/LIa/HkkktcunKsXagSL1k1kYoTCKA
 XLF9csRs=
X-Gm-Gg: AYBFou2dRkCfPrjk2lRY+1xkONs6ha0FCet/LWOJzw8StPNevatVAo9p2RwXWZwMY84
 237Dcmchyo4DIMy+kTVb+z1xnQ51yg/L6qiJgR1zERk/xDf3d/ebjM30+uvCACo8rUVDlFQJPTD
 q/UzFXoZ0+EHkiX2JerYuwDYOee1z1S2EoVx+hI7XSwc/cmWGIGPRrFj/5FEzrdjBSnnvpW1U35
 ecSU2G+xN6dJcGB8hF7SSWX7nkyvstWXoKr9xR5G423wSUAT3pn/pbzC6O/GJ1sjVe1p2budEii
 yv/3nYEyBUmRUFceFSM8J5J7EDzTYqgm4sWAJRtAuUQg84F1A8Xkfca4oOVtwAm1hjAs9kcbl/y
 W1Jsz+l632ggB9WLl2MG8A15uQT8YKEgwXsR6YsgmrOJanLJx3JFIt1vlfJ0SPymqg3QN/2BFFL
 F+UZFnhSaywT4umsogg3y66GVyArnelP0DGpmBxgt7bMU2VG8C2bxhtBq8tclaEUTiTqwhDr9d/
 zFlYh0TooEnrRG49PDibcRSVV7dw1jFfPpG5A==
X-Received: by 2002:a17:903:3c4b:b0:2e5:da30:39cc with SMTP id
 d9443c01a7336-2e6003c02dbmr33639255ad.26.1791409293060; 
 Wed, 07 Oct 2026 14:41:33 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e60484ca89sm16573335ad.57.2026.10.07.14.41.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 14:41:32 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>
Subject: [PATCH 14/20] dispatcher: promote API to stable
Date: Wed,  7 Oct 2026 14:39:44 -0700
Message-ID: <20261007214115.3092715-15-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261007214115.3092715-1-stephen@networkplumber.org>
References: <20261007214115.3092715-1-stephen@networkplumber.org>
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

The dispatcher library was added in 23.11 and none of its functions
have changed since. It has been experimental for two years, which is
long enough to call the interface settled.

Promote all of it: the whole library is covered by a single file level
experimental warning in the header, so there is nothing left to keep
experimental once the symbols are promoted.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_11.rst |  4 ++++
 lib/dispatcher/rte_dispatcher.c        | 26 +++++++++++++-------------
 lib/dispatcher/rte_dispatcher.h        | 18 ------------------
 3 files changed, 17 insertions(+), 31 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 790b8943c2..5b60203afd 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -223,6 +223,10 @@ API Changes
 
 * cmdline: Promoted ``cmdline_token_bool_ops`` from experimental to stable.
 
+* dispatcher: Promoted the whole library API from experimental to stable.
+  The ``rte_dispatcher_*`` functions are unchanged since the library was
+  added in 23.11.
+
 * eal: Improved pointer arithmetic macros.
 
   * ``RTE_PTR_ADD``, ``RTE_PTR_SUB``, ``RTE_PTR_ALIGN``, ``RTE_PTR_ALIGN_CEIL``,
diff --git a/lib/dispatcher/rte_dispatcher.c b/lib/dispatcher/rte_dispatcher.c
index a35967f7b7..2e8e121ed8 100644
--- a/lib/dispatcher/rte_dispatcher.c
+++ b/lib/dispatcher/rte_dispatcher.c
@@ -267,7 +267,7 @@ evd_service_unregister(struct rte_dispatcher *dispatcher)
 	return rc;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_dispatcher_create, 23.11)
+RTE_EXPORT_SYMBOL(rte_dispatcher_create)
 struct rte_dispatcher *
 rte_dispatcher_create(uint8_t event_dev_id)
 {
@@ -302,7 +302,7 @@ rte_dispatcher_create(uint8_t event_dev_id)
 	return dispatcher;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_dispatcher_free, 23.11)
+RTE_EXPORT_SYMBOL(rte_dispatcher_free)
 int
 rte_dispatcher_free(struct rte_dispatcher *dispatcher)
 {
@@ -320,7 +320,7 @@ rte_dispatcher_free(struct rte_dispatcher *dispatcher)
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_dispatcher_service_id_get, 23.11)
+RTE_EXPORT_SYMBOL(rte_dispatcher_service_id_get)
 uint32_t
 rte_dispatcher_service_id_get(const struct rte_dispatcher *dispatcher)
 {
@@ -344,7 +344,7 @@ lcore_port_index(struct rte_dispatcher_lcore *lcore,
 	return -1;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_dispatcher_bind_port_to_lcore, 23.11)
+RTE_EXPORT_SYMBOL(rte_dispatcher_bind_port_to_lcore)
 int
 rte_dispatcher_bind_port_to_lcore(struct rte_dispatcher *dispatcher,
 	uint8_t event_port_id, uint16_t batch_size, uint64_t timeout,
@@ -374,7 +374,7 @@ rte_dispatcher_bind_port_to_lcore(struct rte_dispatcher *dispatcher,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_dispatcher_unbind_port_from_lcore, 23.11)
+RTE_EXPORT_SYMBOL(rte_dispatcher_unbind_port_from_lcore)
 int
 rte_dispatcher_unbind_port_from_lcore(struct rte_dispatcher *dispatcher,
 	uint8_t event_port_id, unsigned int lcore_id)
@@ -457,7 +457,7 @@ evd_install_handler(struct rte_dispatcher *dispatcher,
 	}
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_dispatcher_register, 23.11)
+RTE_EXPORT_SYMBOL(rte_dispatcher_register)
 int
 rte_dispatcher_register(struct rte_dispatcher *dispatcher,
 	rte_dispatcher_match_t match_fun, void *match_data,
@@ -529,7 +529,7 @@ evd_uninstall_handler(struct rte_dispatcher *dispatcher, int handler_id)
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_dispatcher_unregister, 23.11)
+RTE_EXPORT_SYMBOL(rte_dispatcher_unregister)
 int
 rte_dispatcher_unregister(struct rte_dispatcher *dispatcher, int handler_id)
 {
@@ -583,7 +583,7 @@ evd_alloc_finalizer(struct rte_dispatcher *dispatcher)
 	return finalizer;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_dispatcher_finalize_register, 23.11)
+RTE_EXPORT_SYMBOL(rte_dispatcher_finalize_register)
 int
 rte_dispatcher_finalize_register(struct rte_dispatcher *dispatcher,
 	rte_dispatcher_finalize_t finalize_fun, void *finalize_data)
@@ -601,7 +601,7 @@ rte_dispatcher_finalize_register(struct rte_dispatcher *dispatcher,
 	return finalizer->id;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_dispatcher_finalize_unregister, 23.11)
+RTE_EXPORT_SYMBOL(rte_dispatcher_finalize_unregister)
 int
 rte_dispatcher_finalize_unregister(struct rte_dispatcher *dispatcher,
 	int finalizer_id)
@@ -653,14 +653,14 @@ evd_set_service_runstate(struct rte_dispatcher *dispatcher, int state)
 	RTE_VERIFY(rc == 0);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_dispatcher_start, 23.11)
+RTE_EXPORT_SYMBOL(rte_dispatcher_start)
 void
 rte_dispatcher_start(struct rte_dispatcher *dispatcher)
 {
 	evd_set_service_runstate(dispatcher, 1);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_dispatcher_stop, 23.11)
+RTE_EXPORT_SYMBOL(rte_dispatcher_stop)
 void
 rte_dispatcher_stop(struct rte_dispatcher *dispatcher)
 {
@@ -677,7 +677,7 @@ evd_aggregate_stats(struct rte_dispatcher_stats *result,
 	result->ev_drop_count += part->ev_drop_count;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_dispatcher_stats_get, 23.11)
+RTE_EXPORT_SYMBOL(rte_dispatcher_stats_get)
 void
 rte_dispatcher_stats_get(const struct rte_dispatcher *dispatcher,
 	struct rte_dispatcher_stats *stats)
@@ -694,7 +694,7 @@ rte_dispatcher_stats_get(const struct rte_dispatcher *dispatcher,
 	}
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_dispatcher_stats_reset, 23.11)
+RTE_EXPORT_SYMBOL(rte_dispatcher_stats_reset)
 void
 rte_dispatcher_stats_reset(struct rte_dispatcher *dispatcher)
 {
diff --git a/lib/dispatcher/rte_dispatcher.h b/lib/dispatcher/rte_dispatcher.h
index ba2c353073..9f080be249 100644
--- a/lib/dispatcher/rte_dispatcher.h
+++ b/lib/dispatcher/rte_dispatcher.h
@@ -10,10 +10,6 @@
  *
  * RTE Dispatcher
  *
- * @warning
- * @b EXPERIMENTAL:
- * All functions in this file may be changed or removed without prior notice.
- *
  * The purpose of the dispatcher is to help decouple different parts
  * of an application (e.g., modules), sharing the same underlying
  * event device.
@@ -22,7 +18,6 @@
 #include <stdbool.h>
 #include <stdint.h>
 
-#include <rte_compat.h>
 #include <rte_eventdev.h>
 
 #ifdef __cplusplus
@@ -127,7 +122,6 @@ struct rte_dispatcher_stats {
  *   A pointer to a new dispatcher instance, or NULL on failure, in which
  *   case rte_errno is set.
  */
-__rte_experimental
 struct rte_dispatcher *
 rte_dispatcher_create(uint8_t event_dev_id);
 
@@ -141,7 +135,6 @@ rte_dispatcher_create(uint8_t event_dev_id);
  *  - 0: Success
  *  - <0: Error code on failure
  */
-__rte_experimental
 int
 rte_dispatcher_free(struct rte_dispatcher *dispatcher);
 
@@ -154,7 +147,6 @@ rte_dispatcher_free(struct rte_dispatcher *dispatcher);
  * @return
  *  The dispatcher service's id.
  */
-__rte_experimental
 uint32_t
 rte_dispatcher_service_id_get(const struct rte_dispatcher *dispatcher);
 
@@ -199,7 +191,6 @@ rte_dispatcher_service_id_get(const struct rte_dispatcher *dispatcher);
  *  - -EEXISTS: Event port is already configured.
  *  - -EINVAL: Invalid arguments.
  */
-__rte_experimental
 int
 rte_dispatcher_bind_port_to_lcore(struct rte_dispatcher *dispatcher,
 	uint8_t event_port_id, uint16_t batch_size, uint64_t timeout,
@@ -225,7 +216,6 @@ rte_dispatcher_bind_port_to_lcore(struct rte_dispatcher *dispatcher,
  *  - 0: Success
  *  - -ENOENT: Event port id not bound to this @c lcore_id.
  */
-__rte_experimental
 int
 rte_dispatcher_unbind_port_from_lcore(struct rte_dispatcher *dispatcher,
 	uint8_t event_port_id, unsigned int lcore_id);
@@ -289,7 +279,6 @@ rte_dispatcher_unbind_port_from_lcore(struct rte_dispatcher *dispatcher,
  *  - >= 0: The identifier for this registration.
  *  - -ENOMEM: Unable to allocate sufficient resources.
  */
-__rte_experimental
 int
 rte_dispatcher_register(struct rte_dispatcher *dispatcher,
 	rte_dispatcher_match_t match_fun, void *match_cb_data,
@@ -313,7 +302,6 @@ rte_dispatcher_register(struct rte_dispatcher *dispatcher,
  *  - 0: Success
  *  - -EINVAL: The @c handler_id parameter was invalid.
  */
-__rte_experimental
 int
 rte_dispatcher_unregister(struct rte_dispatcher *dispatcher, int handler_id);
 
@@ -355,7 +343,6 @@ rte_dispatcher_unregister(struct rte_dispatcher *dispatcher, int handler_id);
  *  - >= 0: The identifier for this registration.
  *  - -ENOMEM: Unable to allocate sufficient resources.
  */
-__rte_experimental
 int
 rte_dispatcher_finalize_register(struct rte_dispatcher *dispatcher,
 	rte_dispatcher_finalize_t finalize_fun, void *finalize_data);
@@ -378,7 +365,6 @@ rte_dispatcher_finalize_register(struct rte_dispatcher *dispatcher,
  *  - 0: Success
  *  - -EINVAL: The @c reg_id parameter was invalid.
  */
-__rte_experimental
 int
 rte_dispatcher_finalize_unregister(struct rte_dispatcher *dispatcher, int reg_id);
 
@@ -403,7 +389,6 @@ rte_dispatcher_finalize_unregister(struct rte_dispatcher *dispatcher, int reg_id
  * @param dispatcher
  *  The dispatcher instance.
  */
-__rte_experimental
 void
 rte_dispatcher_start(struct rte_dispatcher *dispatcher);
 
@@ -415,7 +400,6 @@ rte_dispatcher_start(struct rte_dispatcher *dispatcher);
  * @param dispatcher
  *  The dispatcher instance.
  */
-__rte_experimental
 void
 rte_dispatcher_stop(struct rte_dispatcher *dispatcher);
 
@@ -430,7 +414,6 @@ rte_dispatcher_stop(struct rte_dispatcher *dispatcher);
  * @param[out] stats
  *   A pointer to a structure to fill with statistics.
  */
-__rte_experimental
 void
 rte_dispatcher_stats_get(const struct rte_dispatcher *dispatcher,
 	struct rte_dispatcher_stats *stats);
@@ -445,7 +428,6 @@ rte_dispatcher_stats_get(const struct rte_dispatcher *dispatcher,
  * @param dispatcher
  *  The dispatcher instance.
  */
-__rte_experimental
 void
 rte_dispatcher_stats_reset(struct rte_dispatcher *dispatcher);
 
-- 
2.53.0

