Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79549C61DD3
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Sep 2026 20:33:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 433B340E43;
	Tue,  1 Sep 2026 22:33:09 +0200 (CEST)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by mails.dpdk.org (Postfix) with ESMTP id 0268940B99
 for <dev@dpdk.org>; Tue,  1 Sep 2026 22:33:08 +0200 (CEST)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-853f8c34ba4so443521b3a.0
 for <dev@dpdk.org>; Tue, 01 Sep 2026 13:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788294787;
 x=1788899587; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VTVYtswRmuKSvnFEUhDcqJIy6c7zdj/dX58eUxR53A0=;
 b=jjK6d7cb/7r6nRdB2nS+ExgzFQ/8CoPMdRzptHpFArwULPoKAqHNeVtme2v/3F1fbt
 +z2GQrY4HXBpc3m9SAzpoFK8uAr5uelSEl7Qthxg8CaIIYb8NgW2Tcw4Kcl1rxsSnV1b
 fXpCWiyvPU0cbJu3V1zgBbqXAMKky1PrkJ/hqWbX9+d6NZnc1wBcz/IpzR9fAR735Nip
 nZj0KyB9AS24eAM9JgVchFaGbpTlV1Mfoy2AddlR9OhBTJfVlHgH1OuI7SrNG8RVH6uF
 W/N6MYRw2pbKaLBt3BY5V7KxChLvb9QcrTe6l3tp4gIDNH9WdkE6YLUiaCjAm0K8le4+
 ld6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788294787; x=1788899587;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VTVYtswRmuKSvnFEUhDcqJIy6c7zdj/dX58eUxR53A0=;
 b=jN5YX3mM3A/TMzmyb0k+cNcC10ImZ0furTRBobZ7sU2RDuoeVU0Dkybeub0Fte8s73
 8bdy8xGcuNYRaqfASGIsjoQkYZLMqCq3gGY5vnagWRkvGF2ZU1EQy5ENhSYrNetZYnGQ
 LOV6pjmLdOExkuoNWN+qDp0eIpnZdjxduzkuHzafdehhsT3WvKpZ9ek0TnpeH2GnkUjf
 zNAfC+0E8Np8fOoxJjhEPbIC8dNci10E7+xe+j7a09HJrJiCg3nppn4IJ2OGzFEnZ413
 fNzlZ0X/Q1tQcgZ2nf0pDEhv4XlHtY7rFhgkzX1LoEP04gsV9s/fvI3gdUGs2stO2vWI
 VVYg==
X-Gm-Message-State: AFuF++l58wJ5TCTXHhHhPqzJsmH2dPqA408HSsg7WEjwLAKHOXkjZqei
 hruud07xgyr7pdm509I7SEPL18+AByrSsCiFoWJA1/u8tXf02lI8tuxsxTle7EN6BiayF0QZHJ2
 nCr3g
X-Gm-Gg: AR+sD13VTHrFVqVrIuBeI8Chndivnc1Y+PgVYi3dnK4N1fvBSALCUS8/ICjYshGmg5m
 QeNy9pdq3umasdPFSZ5EdOtbizw5VgpAzCrnQGZyLsl3HVBZXYoRDPuv2n+qM9xmNGpa9gWeyML
 pKwlhofyNcPlSFx2KVN4XtMXMw5yXbeHUevntzYNIT2medrgJO+/6nOxt1BKSVnx0ThVpo2dpmE
 8PhDDt5mIuTwID/ov5fcJ8nZ9Xh9u7zOpt+Xd7vhURQkfbADURL8X0JBJQ9Ts81Z2tpm54UsKSH
 FyTMpavTOPLQkEGXA3lMCrW0Q+4JuZ5PPyronuRZ+ddGXFFk796ULx/777gu/CbZqMSHmjPJdC3
 hSxUVvXxmm30/LtH8Kbdp5/R7suaFo6KYnsZUq/XCY8mMx7uEQwy/xCZMaxHbIV/f9DeXJBds17
 4kQikR0vXNy96mzSCrcWbjI/3ajN762+WlNfOOw/BiPpxYFKaaUopJnO+aNKFcWPXuSmIoyEe57
 hzMbnv8FY4rPXtaLA8rwCJUj7K77+o2KK6Qzg==
X-Received: by 2002:a05:6a00:340a:b0:84e:7ec:aa42 with SMTP id
 d2e1a72fcca58-85ed22e9b38mr684924b3a.10.1788294787159; 
 Tue, 01 Sep 2026 13:33:07 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-85dc0bffbc1sm323980b3a.48.2026.09.01.13.33.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 13:33:06 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, Ori Kam <orika@nvidia.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH 10/22] ethdev: promote indirect action API to stable
Date: Tue,  1 Sep 2026 13:23:09 -0700
Message-ID: <20260901203217.1485915-11-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901203217.1485915-1-stephen@networkplumber.org>
References: <20260901203217.1485915-1-stephen@networkplumber.org>
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

Indirect (shared) flow actions were introduced in v21.05 and have
been extended twice since, without any change to the original
prototypes:

  21.05  rte_flow_action_handle_create, _destroy, _update, _query
  23.03  rte_flow_action_handle_query_update
  23.07  rte_flow_action_list_handle_create, _destroy,
         _query_update

The synchronous side of the interface is promoted here; the
matching rte_flow_async_action_handle_* calls belong to the async
flow API and are promoted with it.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_11.rst |  1 +
 lib/ethdev/rte_flow.c                  | 16 ++++++------
 lib/ethdev/rte_flow.h                  | 35 --------------------------
 3 files changed, 9 insertions(+), 43 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 6956417ad9..bc33582126 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -115,6 +115,7 @@ API Changes
     ``rte_flow_tunnel_action_decap_release`` and
     ``rte_flow_get_restore_info``
   * flow age: ``rte_flow_get_aged_flows`` and ``rte_flow_get_q_aged_flows``
+  * flow action: ``rte_flow_action_handle_*`` and ``rte_flow_action_list_handle_*``
 
 
 ABI Changes
diff --git a/lib/ethdev/rte_flow.c b/lib/ethdev/rte_flow.c
index e90f93ebcd..aa6f198b65 100644
--- a/lib/ethdev/rte_flow.c
+++ b/lib/ethdev/rte_flow.c
@@ -1322,7 +1322,7 @@ rte_flow_get_q_aged_flows(uint16_t port_id, uint32_t queue_id, void **contexts,
 				  NULL, rte_strerror(ENOTSUP));
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_action_handle_create, 21.05)
+RTE_EXPORT_SYMBOL(rte_flow_action_handle_create)
 struct rte_flow_action_handle *
 rte_flow_action_handle_create(uint16_t port_id,
 			      const struct rte_flow_indir_action_conf *conf,
@@ -1350,7 +1350,7 @@ rte_flow_action_handle_create(uint16_t port_id,
 	return handle;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_action_handle_destroy, 21.05)
+RTE_EXPORT_SYMBOL(rte_flow_action_handle_destroy)
 int
 rte_flow_action_handle_destroy(uint16_t port_id,
 			       struct rte_flow_action_handle *handle,
@@ -1374,7 +1374,7 @@ rte_flow_action_handle_destroy(uint16_t port_id,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_action_handle_update, 21.05)
+RTE_EXPORT_SYMBOL(rte_flow_action_handle_update)
 int
 rte_flow_action_handle_update(uint16_t port_id,
 			      struct rte_flow_action_handle *handle,
@@ -1399,7 +1399,7 @@ rte_flow_action_handle_update(uint16_t port_id,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_action_handle_query, 21.05)
+RTE_EXPORT_SYMBOL(rte_flow_action_handle_query)
 int
 rte_flow_action_handle_query(uint16_t port_id,
 			     const struct rte_flow_action_handle *handle,
@@ -2460,7 +2460,7 @@ rte_flow_async_action_handle_query(uint16_t port_id,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_action_handle_query_update, 23.03)
+RTE_EXPORT_SYMBOL(rte_flow_action_handle_query_update)
 int
 rte_flow_action_handle_query_update(uint16_t port_id,
 				    struct rte_flow_action_handle *handle,
@@ -2513,7 +2513,7 @@ rte_flow_async_action_handle_query_update(uint16_t port_id, uint32_t queue_id,
 								  user_data, error);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_action_list_handle_create, 23.07)
+RTE_EXPORT_SYMBOL(rte_flow_action_list_handle_create)
 struct rte_flow_action_list_handle *
 rte_flow_action_list_handle_create(uint16_t port_id,
 				   const
@@ -2541,7 +2541,7 @@ rte_flow_action_list_handle_create(uint16_t port_id,
 	return handle;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_action_list_handle_destroy, 23.07)
+RTE_EXPORT_SYMBOL(rte_flow_action_list_handle_destroy)
 int
 rte_flow_action_list_handle_destroy(uint16_t port_id,
 				    struct rte_flow_action_list_handle *handle,
@@ -2629,7 +2629,7 @@ rte_flow_async_action_list_handle_destroy(uint16_t port_id, uint32_t queue_id,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_action_list_handle_query_update, 23.07)
+RTE_EXPORT_SYMBOL(rte_flow_action_list_handle_query_update)
 int
 rte_flow_action_list_handle_query_update(uint16_t port_id,
 			 const struct rte_flow_action_list_handle *handle,
diff --git a/lib/ethdev/rte_flow.h b/lib/ethdev/rte_flow.h
index c8194199d6..924005ad4b 100644
--- a/lib/ethdev/rte_flow.h
+++ b/lib/ethdev/rte_flow.h
@@ -5046,9 +5046,6 @@ struct rte_flow_indir_action_conf {
 };
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Create an indirect action object that can be used in flow rules
  * via its handle.
  * The created object handle has single state and configuration
@@ -5072,7 +5069,6 @@ struct rte_flow_indir_action_conf {
  *   - (EINVAL) if *action* invalid.
  *   - (ENOTSUP) if *action* valid but unsupported.
  */
-__rte_experimental
 struct rte_flow_action_handle *
 rte_flow_action_handle_create(uint16_t port_id,
 			      const struct rte_flow_indir_action_conf *conf,
@@ -5080,9 +5076,6 @@ rte_flow_action_handle_create(uint16_t port_id,
 			      struct rte_flow_error *error);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Destroy indirect action by handle.
  *
  * @param[in] port_id
@@ -5101,16 +5094,12 @@ rte_flow_action_handle_create(uint16_t port_id,
  *   - (-EBUSY) if action pointed by *action* handle still used by some rules
  *   rte_errno is also set.
  */
-__rte_experimental
 int
 rte_flow_action_handle_destroy(uint16_t port_id,
 			       struct rte_flow_action_handle *handle,
 			       struct rte_flow_error *error);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Update in-place the action configuration and / or state pointed
  * by action *handle* with the configuration provided as *update* argument.
  * The update of the action configuration effects all flow rules reusing
@@ -5140,7 +5129,6 @@ rte_flow_action_handle_destroy(uint16_t port_id,
  *   - (-ENOENT) if indirect action object pointed by *handle* was not found.
  *   rte_errno is also set.
  */
-__rte_experimental
 int
 rte_flow_action_handle_update(uint16_t port_id,
 			      struct rte_flow_action_handle *handle,
@@ -5148,9 +5136,6 @@ rte_flow_action_handle_update(uint16_t port_id,
 			      struct rte_flow_error *error);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Query the direct action by corresponding indirect action object handle.
  *
  * Retrieve action-specific data such as counters.
@@ -5172,7 +5157,6 @@ rte_flow_action_handle_update(uint16_t port_id,
  * @return
  *   0 on success, a negative errno value otherwise and rte_errno is set.
  */
-__rte_experimental
 int
 rte_flow_action_handle_query(uint16_t port_id,
 			     const struct rte_flow_action_handle *handle,
@@ -6562,9 +6546,6 @@ rte_flow_async_action_handle_query(uint16_t port_id,
 		struct rte_flow_error *error);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Query and update operational mode.
  *
  * @see rte_flow_action_handle_query_update()
@@ -6576,9 +6557,6 @@ enum rte_flow_query_update_mode {
 };
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Query and/or update indirect flow action.
  * If both query and update not NULL, the function atomically
  * queries and updates indirect action. Query and update are carried in order
@@ -6608,7 +6586,6 @@ enum rte_flow_query_update_mode {
  * - (-EINVAL) if *handle* or *mode* invalid or
  *             both *query* and *update* are NULL.
  */
-__rte_experimental
 int
 rte_flow_action_handle_query_update(uint16_t port_id,
 				    struct rte_flow_action_handle *handle,
@@ -6686,9 +6663,6 @@ struct rte_flow_action_indirect_list {
 };
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Create an indirect flow action object from flow actions list.
  * The object is identified by a unique handle.
  * The handle has single state and configuration
@@ -6712,7 +6686,6 @@ struct rte_flow_action_indirect_list {
  *   - (-EINVAL) if *actions* list invalid.
  *   - (-ENOTSUP) if *action* list element valid but unsupported.
  */
-__rte_experimental
 struct rte_flow_action_list_handle *
 rte_flow_action_list_handle_create(uint16_t port_id,
 				   const
@@ -6764,9 +6737,6 @@ rte_flow_async_action_list_handle_create(uint16_t port_id, uint32_t queue_id,
 					 struct rte_flow_error *error);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Destroy indirect actions list by handle.
  *
  * @param[in] port_id
@@ -6784,7 +6754,6 @@ rte_flow_async_action_list_handle_create(uint16_t port_id, uint32_t queue_id,
  *   - (-ENOENT) if actions list pointed by *action* handle was not found.
  *   - (-EBUSY) if actions list pointed by *action* handle still used
  */
-__rte_experimental
 int
 rte_flow_action_list_handle_destroy(uint16_t port_id,
 				    struct rte_flow_action_list_handle *handle,
@@ -6829,9 +6798,6 @@ rte_flow_async_action_list_handle_destroy
 		 void *user_data, struct rte_flow_error *error);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Query and/or update indirect flow actions list.
  * If both query and update not NULL, the function atomically
  * queries and updates indirect action. Query and update are carried in order
@@ -6864,7 +6830,6 @@ rte_flow_async_action_list_handle_destroy
  * - (-EINVAL) if *handle* or *mode* invalid or
  *             both *query* and *update* are NULL.
  */
-__rte_experimental
 int
 rte_flow_action_list_handle_query_update(uint16_t port_id,
 					 const struct rte_flow_action_list_handle *handle,
-- 
2.53.0

