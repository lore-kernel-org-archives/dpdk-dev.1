Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE00C61DD6
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Sep 2026 20:33:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 70F2E40E4B;
	Tue,  1 Sep 2026 22:33:14 +0200 (CEST)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com
 [209.85.210.174])
 by mails.dpdk.org (Postfix) with ESMTP id 5A64940B99
 for <dev@dpdk.org>; Tue,  1 Sep 2026 22:33:12 +0200 (CEST)
Received: by mail-pf1-f174.google.com with SMTP id
 d2e1a72fcca58-8568e3ed034so254905b3a.0
 for <dev@dpdk.org>; Tue, 01 Sep 2026 13:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788294791;
 x=1788899591; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tNAfvclBWCm7g2UDssfn6Qw6YF12FW9EOUEgR/6lwVA=;
 b=o8hvvlUohsPRrN4M3gWTend/rsqEQXAbeZ5sj7Dsu+Y8RjjKqtpwGzuijRxLQ2RUAN
 p2FnN6tuo5GkzFR7xIOw4qLPTSNLEgXsK01vDqd5L1DB39kBMTnG4A6qAhwVkplYKbUc
 TsGcBZBTG1zjSYL5u0XPKYfEfVctqVUeyWs0cbfY7wK++dCR3zusLKQItsLNvC2FvY48
 2SM3gHhmarpcKqUxa4K/5s+mT8A6Zw6qjgB3LjZ9vn8poDYVkziVQghhwEz+sr9aKKKz
 wiETCROFprDV/yUJf47UJmwuKwB5KgCikg5hhUL85dahoNuln+LqVXgdc2+0dmCNg4j6
 tCbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788294791; x=1788899591;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tNAfvclBWCm7g2UDssfn6Qw6YF12FW9EOUEgR/6lwVA=;
 b=pTCQLyDm1ITqafWA+eeD27LIMIkwNPGfXxbKgJ0WX8oda5d96fEeQHIEKnZmbsPoHZ
 NpGscAJAPOst5SeWH++pa7YRp2IG+vC7LYNxTZAewEOuXBRZXDBIjzswQR7ItwYGAA7j
 qgia0ZxJGbXAnmIoB1tzUNzBi+7GVZ9df0Dpz4Ec1DYGb6S8cHDoLhZR8z4ryMx+WzXn
 qrKgwXGq1dnHeXawK69Q2pJHCEm2B+KtZoJJ9MzLQeVTIOhFAWxjmXfIzEEQBti77PXu
 o71zGTBJo3gBHjsFQOp54hGKRAJgysPY/m6l/qoQUxI/CH2lcGdLjbl+4LKIRQ1u+Yq5
 2Zbw==
X-Gm-Message-State: AFuF++mjpmoAQqbMeS2ETnDd5V4VCQL4YuDvF1TOhpSsJeJUgjgmS/s2
 Nuc2b575JqwilMuz2w2GO04dkHsynovI6FcFefIYljP+nFdLWuV7X0itjLSBtbfwMhAZwUDIBSG
 IM7ud
X-Gm-Gg: AR+sD13fI+FMN6KdD4g3/t1VQkTOfPdfHj8+Y0xRLHwlr6HouAnttwqtMhMVGfVlbaC
 33BSeEKizgd1yXdt/lwTdqUDfK4vwNzMF0+IMMnZ3JZoqrspGSaHpxwiuaAr83FRhhPvwwjAYXd
 CH4bB8FILkDpxkkvwYBwim8wbZOTkmKNIt4pNWQENbebKCA7jkJKz56ey0VbW9s09S8Q8kKgDTZ
 lZRZeXhi6P9woRq4IFz3yT2p7WrmZjK88Tu1O/oaOdbXLPLDlymWb1PtjE40pwmEp7KJSy2kcRu
 Pb22p8SfDZ8LFt7K+tqHsDPvW/Vbyu4PxlxW4/px1kw94sqSVFkM5hPpW8QhE+q7tO7UvxXanmA
 Ivv8Hdlsjf00ABD6KtoaQHzPrACjDLF2H9/fPC198SssmTHD5i7/Cmk75z1e9SF/MPerhLWk0yo
 mm+r+jIneFH7r43ZiolwMccYXdCAitlc8wQKG0b9dqotdAq5TwLzeyE0u1kabYlPS0S+H+8xswt
 CTsOB3goaa99yZXBsCeAsyhRrT15Z2boiI7hQ==
X-Received: by 2002:a05:6a00:2788:b0:845:dfef:75b8 with SMTP id
 d2e1a72fcca58-85ed3c7d3b0mr605249b3a.15.1788294791115; 
 Tue, 01 Sep 2026 13:33:11 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-85dc0bffbc1sm323980b3a.48.2026.09.01.13.33.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 13:33:10 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, Ori Kam <orika@nvidia.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH 11/22] ethdev: promote asynchronous flow API to stable
Date: Tue,  1 Sep 2026 13:23:10 -0700
Message-ID: <20260901203217.1485915-12-stephen@networkplumber.org>
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

The template based, queue oriented flow API was introduced in v22.03
and completed over the following releases:

  22.03  rte_flow_configure, rte_flow_info_get,
         rte_flow_pattern_template_create/destroy,
         rte_flow_actions_template_create/destroy,
         rte_flow_template_table_create/destroy,
         rte_flow_async_create, rte_flow_async_destroy,
         rte_flow_push, rte_flow_pull,
         rte_flow_async_action_handle_create/destroy/update
  22.11  rte_flow_async_action_handle_query
  23.03  rte_flow_async_action_handle_query_update,
         rte_flow_async_create_by_index
  23.07  rte_flow_async_actions_update,
         rte_flow_async_action_list_handle_create/destroy/
         query_update
  24.03  rte_flow_template_table_resizable/resize/resize_complete,
         rte_flow_async_update_resized
  24.11  rte_flow_async_create_by_index_with_pattern

No new symbol has been added to this API since 24.11 and no
prototype has changed, so the interface has settled. It is
implemented by mlx5 and several other PMDs and is the recommended
flow offload path, so promote it as one unit.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_11.rst |   7 ++
 lib/ethdev/rte_flow.c                  |  54 +++++------
 lib/ethdev/rte_flow.h                  | 129 -------------------------
 3 files changed, 34 insertions(+), 156 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index bc33582126..0f819b7013 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -116,6 +116,13 @@ API Changes
     ``rte_flow_get_restore_info``
   * flow age: ``rte_flow_get_aged_flows`` and ``rte_flow_get_q_aged_flows``
   * flow action: ``rte_flow_action_handle_*`` and ``rte_flow_action_list_handle_*``
+  * flow template:
+    ``rte_flow_configure``, ``rte_flow_info_get``,
+    ``rte_flow_pattern_*``,
+    ``rte_flow_actions_*``,
+    ``rte_flow_template_*``,
+    ``rte_flow_async_*``,
+    ``rte_flow_push``, ``rte_flow_pull``
 
 
 ABI Changes
diff --git a/lib/ethdev/rte_flow.c b/lib/ethdev/rte_flow.c
index aa6f198b65..edbf8a8bce 100644
--- a/lib/ethdev/rte_flow.c
+++ b/lib/ethdev/rte_flow.c
@@ -1675,7 +1675,7 @@ rte_flow_flex_item_release(uint16_t port_id,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_info_get, 22.03)
+RTE_EXPORT_SYMBOL(rte_flow_info_get)
 int
 rte_flow_info_get(uint16_t port_id,
 		  struct rte_flow_port_info *port_info,
@@ -1712,7 +1712,7 @@ rte_flow_info_get(uint16_t port_id,
 				  NULL, rte_strerror(ENOTSUP));
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_configure, 22.03)
+RTE_EXPORT_SYMBOL(rte_flow_configure)
 int
 rte_flow_configure(uint16_t port_id,
 		   const struct rte_flow_port_attr *port_attr,
@@ -1771,7 +1771,7 @@ rte_flow_configure(uint16_t port_id,
 				  NULL, rte_strerror(EINVAL));
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_pattern_template_create, 22.03)
+RTE_EXPORT_SYMBOL(rte_flow_pattern_template_create)
 struct rte_flow_pattern_template *
 rte_flow_pattern_template_create(uint16_t port_id,
 		const struct rte_flow_pattern_template_attr *template_attr,
@@ -1828,7 +1828,7 @@ rte_flow_pattern_template_create(uint16_t port_id,
 	return NULL;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_pattern_template_destroy, 22.03)
+RTE_EXPORT_SYMBOL(rte_flow_pattern_template_destroy)
 int
 rte_flow_pattern_template_destroy(uint16_t port_id,
 		struct rte_flow_pattern_template *pattern_template,
@@ -1859,7 +1859,7 @@ rte_flow_pattern_template_destroy(uint16_t port_id,
 				  NULL, rte_strerror(ENOTSUP));
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_actions_template_create, 22.03)
+RTE_EXPORT_SYMBOL(rte_flow_actions_template_create)
 struct rte_flow_actions_template *
 rte_flow_actions_template_create(uint16_t port_id,
 			const struct rte_flow_actions_template_attr *template_attr,
@@ -1926,7 +1926,7 @@ rte_flow_actions_template_create(uint16_t port_id,
 	return NULL;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_actions_template_destroy, 22.03)
+RTE_EXPORT_SYMBOL(rte_flow_actions_template_destroy)
 int
 rte_flow_actions_template_destroy(uint16_t port_id,
 			struct rte_flow_actions_template *actions_template,
@@ -1957,7 +1957,7 @@ rte_flow_actions_template_destroy(uint16_t port_id,
 				  NULL, rte_strerror(ENOTSUP));
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_template_table_create, 22.03)
+RTE_EXPORT_SYMBOL(rte_flow_template_table_create)
 struct rte_flow_template_table *
 rte_flow_template_table_create(uint16_t port_id,
 			const struct rte_flow_template_table_attr *table_attr,
@@ -2031,7 +2031,7 @@ rte_flow_template_table_create(uint16_t port_id,
 	return NULL;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_template_table_destroy, 22.03)
+RTE_EXPORT_SYMBOL(rte_flow_template_table_destroy)
 int
 rte_flow_template_table_destroy(uint16_t port_id,
 				struct rte_flow_template_table *template_table,
@@ -2085,7 +2085,7 @@ rte_flow_group_set_miss_actions(uint16_t port_id,
 				  NULL, rte_strerror(ENOTSUP));
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_async_create, 22.03)
+RTE_EXPORT_SYMBOL(rte_flow_async_create)
 struct rte_flow *
 rte_flow_async_create(uint16_t port_id,
 		      uint32_t queue_id,
@@ -2127,7 +2127,7 @@ rte_flow_async_create(uint16_t port_id,
 	return flow;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_async_create_by_index, 23.03)
+RTE_EXPORT_SYMBOL(rte_flow_async_create_by_index)
 struct rte_flow *
 rte_flow_async_create_by_index(uint16_t port_id,
 			       uint32_t queue_id,
@@ -2166,7 +2166,7 @@ rte_flow_async_create_by_index(uint16_t port_id,
 	return flow;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_async_create_by_index_with_pattern, 24.11)
+RTE_EXPORT_SYMBOL(rte_flow_async_create_by_index_with_pattern)
 struct rte_flow *
 rte_flow_async_create_by_index_with_pattern(uint16_t port_id,
 					    uint32_t queue_id,
@@ -2211,7 +2211,7 @@ rte_flow_async_create_by_index_with_pattern(uint16_t port_id,
 	return flow;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_async_destroy, 22.03)
+RTE_EXPORT_SYMBOL(rte_flow_async_destroy)
 int
 rte_flow_async_destroy(uint16_t port_id,
 		       uint32_t queue_id,
@@ -2242,7 +2242,7 @@ rte_flow_async_destroy(uint16_t port_id,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_async_actions_update, 23.07)
+RTE_EXPORT_SYMBOL(rte_flow_async_actions_update)
 int
 rte_flow_async_actions_update(uint16_t port_id,
 			      uint32_t queue_id,
@@ -2277,7 +2277,7 @@ rte_flow_async_actions_update(uint16_t port_id,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_push, 22.03)
+RTE_EXPORT_SYMBOL(rte_flow_push)
 int
 rte_flow_push(uint16_t port_id,
 	      uint32_t queue_id,
@@ -2302,7 +2302,7 @@ rte_flow_push(uint16_t port_id,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_pull, 22.03)
+RTE_EXPORT_SYMBOL(rte_flow_pull)
 int
 rte_flow_pull(uint16_t port_id,
 	      uint32_t queue_id,
@@ -2329,7 +2329,7 @@ rte_flow_pull(uint16_t port_id,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_async_action_handle_create, 22.03)
+RTE_EXPORT_SYMBOL(rte_flow_async_action_handle_create)
 struct rte_flow_action_handle *
 rte_flow_async_action_handle_create(uint16_t port_id,
 		uint32_t queue_id,
@@ -2366,7 +2366,7 @@ rte_flow_async_action_handle_create(uint16_t port_id,
 	return handle;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_async_action_handle_destroy, 22.03)
+RTE_EXPORT_SYMBOL(rte_flow_async_action_handle_destroy)
 int
 rte_flow_async_action_handle_destroy(uint16_t port_id,
 		uint32_t queue_id,
@@ -2396,7 +2396,7 @@ rte_flow_async_action_handle_destroy(uint16_t port_id,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_async_action_handle_update, 22.03)
+RTE_EXPORT_SYMBOL(rte_flow_async_action_handle_update)
 int
 rte_flow_async_action_handle_update(uint16_t port_id,
 		uint32_t queue_id,
@@ -2428,7 +2428,7 @@ rte_flow_async_action_handle_update(uint16_t port_id,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_async_action_handle_query, 22.11)
+RTE_EXPORT_SYMBOL(rte_flow_async_action_handle_query)
 int
 rte_flow_async_action_handle_query(uint16_t port_id,
 		uint32_t queue_id,
@@ -2486,7 +2486,7 @@ rte_flow_action_handle_query_update(uint16_t port_id,
 	return flow_err(port_id, ret, error);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_async_action_handle_query_update, 23.03)
+RTE_EXPORT_SYMBOL(rte_flow_async_action_handle_query_update)
 int
 rte_flow_async_action_handle_query_update(uint16_t port_id, uint32_t queue_id,
 					  const struct rte_flow_op_attr *attr,
@@ -2564,7 +2564,7 @@ rte_flow_action_list_handle_destroy(uint16_t port_id,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_async_action_list_handle_create, 23.07)
+RTE_EXPORT_SYMBOL(rte_flow_async_action_list_handle_create)
 struct rte_flow_action_list_handle *
 rte_flow_async_action_list_handle_create(uint16_t port_id, uint32_t queue_id,
 					 const struct rte_flow_op_attr *attr,
@@ -2601,7 +2601,7 @@ rte_flow_async_action_list_handle_create(uint16_t port_id, uint32_t queue_id,
 	return handle;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_async_action_list_handle_destroy, 23.07)
+RTE_EXPORT_SYMBOL(rte_flow_async_action_list_handle_destroy)
 int
 rte_flow_async_action_list_handle_destroy(uint16_t port_id, uint32_t queue_id,
 				 const struct rte_flow_op_attr *op_attr,
@@ -2656,7 +2656,7 @@ rte_flow_action_list_handle_query_update(uint16_t port_id,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_async_action_list_handle_query_update, 23.07)
+RTE_EXPORT_SYMBOL(rte_flow_async_action_list_handle_query_update)
 int
 rte_flow_async_action_list_handle_query_update(uint16_t port_id, uint32_t queue_id,
 			 const struct rte_flow_op_attr *attr,
@@ -2743,7 +2743,7 @@ rte_flow_calc_encap_hash(uint16_t port_id, const struct rte_flow_item pattern[],
 	return flow_err(port_id, ret, error);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_template_table_resizable, 24.03)
+RTE_EXPORT_SYMBOL(rte_flow_template_table_resizable)
 bool
 rte_flow_template_table_resizable(__rte_unused uint16_t port_id,
 				  const struct rte_flow_template_table_attr *tbl_attr)
@@ -2752,7 +2752,7 @@ rte_flow_template_table_resizable(__rte_unused uint16_t port_id,
 		RTE_FLOW_TABLE_SPECIALIZE_RESIZABLE) != 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_template_table_resize, 24.03)
+RTE_EXPORT_SYMBOL(rte_flow_template_table_resize)
 int
 rte_flow_template_table_resize(uint16_t port_id,
 			       struct rte_flow_template_table *table,
@@ -2776,7 +2776,7 @@ rte_flow_template_table_resize(uint16_t port_id,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_async_update_resized, 24.03)
+RTE_EXPORT_SYMBOL(rte_flow_async_update_resized)
 int
 rte_flow_async_update_resized(uint16_t port_id, uint32_t queue,
 			      const struct rte_flow_op_attr *attr,
@@ -2801,7 +2801,7 @@ rte_flow_async_update_resized(uint16_t port_id, uint32_t queue,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_template_table_resize_complete, 24.03)
+RTE_EXPORT_SYMBOL(rte_flow_template_table_resize_complete)
 int
 rte_flow_template_table_resize_complete(uint16_t port_id,
 					struct rte_flow_template_table *table,
diff --git a/lib/ethdev/rte_flow.h b/lib/ethdev/rte_flow.h
index 924005ad4b..16645207c3 100644
--- a/lib/ethdev/rte_flow.h
+++ b/lib/ethdev/rte_flow.h
@@ -5459,9 +5459,6 @@ rte_flow_flex_item_release(uint16_t port_id,
 #define RTE_FLOW_PORT_FLAG_SHARE_INDIRECT RTE_BIT32(1)
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Information about flow engine resources.
  * The zero value means a resource is not supported.
  */
@@ -5502,9 +5499,6 @@ struct rte_flow_port_info {
 };
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Information about flow engine asynchronous queues.
  * The value only valid if @p port_attr.max_nb_queues is not zero.
  */
@@ -5516,9 +5510,6 @@ struct rte_flow_queue_info {
 };
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Get information about flow engine resources.
  *
  * @param port_id
@@ -5536,7 +5527,6 @@ struct rte_flow_queue_info {
  * @return
  *   0 on success, a negative errno value otherwise and rte_errno is set.
  */
-__rte_experimental
 int
 rte_flow_info_get(uint16_t port_id,
 		  struct rte_flow_port_info *port_info,
@@ -5544,9 +5534,6 @@ rte_flow_info_get(uint16_t port_id,
 		  struct rte_flow_error *error);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Flow engine resources settings.
  * The zero value means on demand resource allocations only.
  */
@@ -5587,9 +5574,6 @@ struct rte_flow_port_attr {
 };
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Flow engine asynchronous queues settings.
  * The value means default value picked by PMD.
  */
@@ -5601,9 +5585,6 @@ struct rte_flow_queue_attr {
 };
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Configure the port's flow API engine.
  *
  * This API can only be invoked before the application
@@ -5631,7 +5612,6 @@ struct rte_flow_queue_attr {
  * @return
  *   0 on success, a negative errno value otherwise and rte_errno is set.
  */
-__rte_experimental
 int
 rte_flow_configure(uint16_t port_id,
 		   const struct rte_flow_port_attr *port_attr,
@@ -5674,9 +5654,6 @@ struct rte_flow_pattern_template_attr {
 };
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Create flow pattern template.
  *
  * The pattern template defines common matching fields without values.
@@ -5700,7 +5677,6 @@ struct rte_flow_pattern_template_attr {
  * @return
  *   Handle on success, NULL otherwise and rte_errno is set.
  */
-__rte_experimental
 struct rte_flow_pattern_template *
 rte_flow_pattern_template_create(uint16_t port_id,
 		const struct rte_flow_pattern_template_attr *template_attr,
@@ -5708,9 +5684,6 @@ rte_flow_pattern_template_create(uint16_t port_id,
 		struct rte_flow_error *error);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Destroy flow pattern template.
  *
  * This function may be called only when
@@ -5727,7 +5700,6 @@ rte_flow_pattern_template_create(uint16_t port_id,
  * @return
  *   0 on success, a negative errno value otherwise and rte_errno is set.
  */
-__rte_experimental
 int
 rte_flow_pattern_template_destroy(uint16_t port_id,
 		struct rte_flow_pattern_template *pattern_template,
@@ -5760,9 +5732,6 @@ struct rte_flow_actions_template_attr {
 };
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Create flow actions template.
  *
  * The actions template holds a list of action types without values.
@@ -5794,7 +5763,6 @@ struct rte_flow_actions_template_attr {
  * @return
  *   Handle on success, NULL otherwise and rte_errno is set.
  */
-__rte_experimental
 struct rte_flow_actions_template *
 rte_flow_actions_template_create(uint16_t port_id,
 		const struct rte_flow_actions_template_attr *template_attr,
@@ -5803,9 +5771,6 @@ rte_flow_actions_template_create(uint16_t port_id,
 		struct rte_flow_error *error);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Destroy flow actions template.
  *
  * This function may be called only when
@@ -5822,7 +5787,6 @@ rte_flow_actions_template_create(uint16_t port_id,
  * @return
  *   0 on success, a negative errno value otherwise and rte_errno is set.
  */
-__rte_experimental
 int
 rte_flow_actions_template_destroy(uint16_t port_id,
 		struct rte_flow_actions_template *actions_template,
@@ -5863,9 +5827,6 @@ struct rte_flow_template_table;
 /**@}*/
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Template table flow rules insertion type.
  */
 enum rte_flow_table_insertion_type {
@@ -5884,9 +5845,6 @@ enum rte_flow_table_insertion_type {
 };
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Template table hash index calculation function.
  */
 enum rte_flow_table_hash_func {
@@ -5909,9 +5867,6 @@ enum rte_flow_table_hash_func {
 };
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Table attributes.
  */
 struct rte_flow_template_table_attr {
@@ -5943,9 +5898,6 @@ struct rte_flow_template_table_attr {
 };
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Query whether a table can be resized.
  *
  * @param port_id
@@ -5956,15 +5908,11 @@ struct rte_flow_template_table_attr {
  * @return
  *   True if the table can be resized.
  */
-__rte_experimental
 bool
 rte_flow_template_table_resizable(__rte_unused uint16_t port_id,
 		const struct rte_flow_template_table_attr *tbl_attr);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Create flow template table.
  *
  * A template table consists of multiple pattern templates and actions
@@ -5993,7 +5941,6 @@ rte_flow_template_table_resizable(__rte_unused uint16_t port_id,
  * @return
  *   Handle on success, NULL otherwise and rte_errno is set.
  */
-__rte_experimental
 struct rte_flow_template_table *
 rte_flow_template_table_create(uint16_t port_id,
 		const struct rte_flow_template_table_attr *table_attr,
@@ -6004,9 +5951,6 @@ rte_flow_template_table_create(uint16_t port_id,
 		struct rte_flow_error *error);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Destroy flow template table.
  *
  * This function may be called only when
@@ -6023,7 +5967,6 @@ rte_flow_template_table_create(uint16_t port_id,
  * @return
  *   0 on success, a negative errno value otherwise and rte_errno is set.
  */
-__rte_experimental
 int
 rte_flow_template_table_destroy(uint16_t port_id,
 		struct rte_flow_template_table *template_table,
@@ -6074,9 +6017,6 @@ struct rte_flow_op_attr {
 };
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Enqueue rule creation operation.
  *
  * @param port_id
@@ -6109,7 +6049,6 @@ struct rte_flow_op_attr {
  *   The rule handle doesn't mean that the rule has been populated.
  *   Only completion result indicates that if there was success or failure.
  */
-__rte_experimental
 struct rte_flow *
 rte_flow_async_create(uint16_t port_id,
 		      uint32_t queue_id,
@@ -6123,9 +6062,6 @@ rte_flow_async_create(uint16_t port_id,
 		      struct rte_flow_error *error);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Enqueue rule creation operation.
  *
  * @param port_id
@@ -6154,7 +6090,6 @@ rte_flow_async_create(uint16_t port_id,
  *   The rule handle doesn't mean that the rule has been populated.
  *   Only completion result indicates that if there was success or failure.
  */
-__rte_experimental
 struct rte_flow *
 rte_flow_async_create_by_index(uint16_t port_id,
 			       uint32_t queue_id,
@@ -6167,9 +6102,6 @@ rte_flow_async_create_by_index(uint16_t port_id,
 			       struct rte_flow_error *error);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Enqueue rule creation by index with pattern operation.
  * Packets are only matched if there is a rule inserted at the index.
  *
@@ -6206,7 +6138,6 @@ rte_flow_async_create_by_index(uint16_t port_id,
  *   The rule handle doesn't mean that the rule has been populated.
  *   Only completion result indicates that if there was success or failure.
  */
-__rte_experimental
 struct rte_flow *
 rte_flow_async_create_by_index_with_pattern(uint16_t port_id,
 					    uint32_t queue_id,
@@ -6221,9 +6152,6 @@ rte_flow_async_create_by_index_with_pattern(uint16_t port_id,
 					    struct rte_flow_error *error);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Enqueue rule destruction operation.
  *
  * This function enqueues a destruction operation on the queue.
@@ -6249,7 +6177,6 @@ rte_flow_async_create_by_index_with_pattern(uint16_t port_id,
  * @return
  *   0 on success, a negative errno value otherwise and rte_errno is set.
  */
-__rte_experimental
 int
 rte_flow_async_destroy(uint16_t port_id,
 		       uint32_t queue_id,
@@ -6259,9 +6186,6 @@ rte_flow_async_destroy(uint16_t port_id,
 		       struct rte_flow_error *error);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Enqueue rule update operation.
  *
  * @param port_id
@@ -6286,7 +6210,6 @@ rte_flow_async_destroy(uint16_t port_id,
  * @return
  *   0 on success, a negative errno value otherwise and rte_errno is set.
  */
-__rte_experimental
 int
 rte_flow_async_actions_update(uint16_t port_id,
 			      uint32_t queue_id,
@@ -6298,9 +6221,6 @@ rte_flow_async_actions_update(uint16_t port_id,
 			      struct rte_flow_error *error);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Push all internally stored rules to the HW.
  * Postponed rules are rules that were inserted with the postpone flag set.
  * Can be used to notify the HW about batch of rules prepared by the SW to
@@ -6317,7 +6237,6 @@ rte_flow_async_actions_update(uint16_t port_id,
  * @return
  *   0 on success, a negative errno value otherwise and rte_errno is set.
  */
-__rte_experimental
 int
 rte_flow_push(uint16_t port_id,
 	      uint32_t queue_id,
@@ -6359,9 +6278,6 @@ struct rte_flow_op_result {
 };
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Pull a rte flow operation.
  * The application must invoke this function in order to complete
  * the flow rule offloading and to retrieve the flow rule operation status.
@@ -6383,7 +6299,6 @@ struct rte_flow_op_result {
  *   Number of results that were pulled,
  *   a negative errno value otherwise and rte_errno is set.
  */
-__rte_experimental
 int
 rte_flow_pull(uint16_t port_id,
 	      uint32_t queue_id,
@@ -6392,9 +6307,6 @@ rte_flow_pull(uint16_t port_id,
 	      struct rte_flow_error *error);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Enqueue indirect action creation operation.
  * @see rte_flow_action_handle_create
  *
@@ -6417,7 +6329,6 @@ rte_flow_pull(uint16_t port_id,
  * @return
  *   A valid handle in case of success, NULL otherwise and rte_errno is set.
  */
-__rte_experimental
 struct rte_flow_action_handle *
 rte_flow_async_action_handle_create(uint16_t port_id,
 		uint32_t queue_id,
@@ -6428,9 +6339,6 @@ rte_flow_async_action_handle_create(uint16_t port_id,
 		struct rte_flow_error *error);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Enqueue indirect action destruction operation.
  * The destroy queue must be the same
  * as the queue on which the action was created.
@@ -6452,7 +6360,6 @@ rte_flow_async_action_handle_create(uint16_t port_id,
  * @return
  *   0 on success, a negative errno value otherwise and rte_errno is set.
  */
-__rte_experimental
 int
 rte_flow_async_action_handle_destroy(uint16_t port_id,
 		uint32_t queue_id,
@@ -6462,9 +6369,6 @@ rte_flow_async_action_handle_destroy(uint16_t port_id,
 		struct rte_flow_error *error);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Enqueue indirect action update operation.
  * @see rte_flow_action_handle_create
  *
@@ -6491,7 +6395,6 @@ rte_flow_async_action_handle_destroy(uint16_t port_id,
  * @return
  *   0 on success, a negative errno value otherwise and rte_errno is set.
  */
-__rte_experimental
 int
 rte_flow_async_action_handle_update(uint16_t port_id,
 		uint32_t queue_id,
@@ -6502,9 +6405,6 @@ rte_flow_async_action_handle_update(uint16_t port_id,
 		struct rte_flow_error *error);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Enqueue indirect action query operation.
  *
  * Retrieve action-specific data such as counters.
@@ -6535,7 +6435,6 @@ rte_flow_async_action_handle_update(uint16_t port_id,
  * @return
  *   0 on success, a negative errno value otherwise and rte_errno is set.
  */
-__rte_experimental
 int
 rte_flow_async_action_handle_query(uint16_t port_id,
 		uint32_t queue_id,
@@ -6594,9 +6493,6 @@ rte_flow_action_handle_query_update(uint16_t port_id,
 				    struct rte_flow_error *error);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Enqueue async indirect flow action query and/or update
  *
  * @param port_id
@@ -6628,7 +6524,6 @@ rte_flow_action_handle_query_update(uint16_t port_id,
  * - (-EINVAL) if *handle* or *mode* invalid or
  *             both *update* and *query* are NULL.
  */
-__rte_experimental
 int
 rte_flow_async_action_handle_query_update(uint16_t port_id, uint32_t queue_id,
 					  const struct rte_flow_op_attr *attr,
@@ -6694,9 +6589,6 @@ rte_flow_action_list_handle_create(uint16_t port_id,
 				   struct rte_flow_error *error);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Async function call to create an indirect flow action object
  * from flow actions list.
  * The object is identified by a unique handle.
@@ -6727,7 +6619,6 @@ rte_flow_action_list_handle_create(uint16_t port_id,
  *   - (-EINVAL) if *actions* list invalid.
  *   - (-ENOTSUP) if *action* list element valid but unsupported.
  */
-__rte_experimental
 struct rte_flow_action_list_handle *
 rte_flow_async_action_list_handle_create(uint16_t port_id, uint32_t queue_id,
 					 const struct rte_flow_op_attr *attr,
@@ -6760,9 +6651,6 @@ rte_flow_action_list_handle_destroy(uint16_t port_id,
 				    struct rte_flow_error *error);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Enqueue indirect action list destruction operation.
  * The destroy queue must be the same
  * as the queue on which the action was created.
@@ -6789,7 +6677,6 @@ rte_flow_action_list_handle_destroy(uint16_t port_id,
  *   - (-ENOENT) if actions list pointed by *action* handle was not found.
  *   - (-EBUSY) if actions list pointed by *action* handle still used
  */
-__rte_experimental
 int
 rte_flow_async_action_list_handle_destroy
 		(uint16_t port_id, uint32_t queue_id,
@@ -6838,9 +6725,6 @@ rte_flow_action_list_handle_query_update(uint16_t port_id,
 					 struct rte_flow_error *error);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Enqueue async indirect flow actions list query and/or update
  * If both query and update not NULL, the function atomically
  * queries and updates indirect action. Query and update are carried in order
@@ -6880,7 +6764,6 @@ rte_flow_action_list_handle_query_update(uint16_t port_id,
  * - (-EINVAL) if *handle* or *mode* invalid or
  *             both *update* and *query* are NULL.
  */
-__rte_experimental
 int
 rte_flow_async_action_list_handle_query_update(uint16_t port_id, uint32_t queue_id,
 					  const struct rte_flow_op_attr *attr,
@@ -6976,9 +6859,6 @@ rte_flow_calc_encap_hash(uint16_t port_id, const struct rte_flow_item pattern[],
 			 uint8_t *hash, struct rte_flow_error *error);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Update template table for new flow rules capacity.
  *
  * @param port_id
@@ -6999,16 +6879,12 @@ rte_flow_calc_encap_hash(uint16_t port_id, const struct rte_flow_item pattern[],
  *               *table* resize to *nb_rules* is not supported or
  *               unrecoverable *table* error.
  */
-__rte_experimental
 int
 rte_flow_template_table_resize(uint16_t port_id,
 			       struct rte_flow_template_table *table,
 			       uint32_t nb_rules,
 			       struct rte_flow_error *error);
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Update *rule* for the new *table* configuration after table resize.
  * Must be called for each *rule* created before *table* resize.
  * If called for *rule* created after *table* resize returns success.
@@ -7035,7 +6911,6 @@ rte_flow_template_table_resize(uint16_t port_id,
  *               If *rule* cannot be updated after *table* resize,
  *               unrecoverable *table* error.
  */
-__rte_experimental
 int
 rte_flow_async_update_resized(uint16_t port_id, uint32_t queue,
 			      const struct rte_flow_op_attr *attr,
@@ -7043,9 +6918,6 @@ rte_flow_async_update_resized(uint16_t port_id, uint32_t queue,
 			      struct rte_flow_error *error);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Resume normal operational mode after table was resized and
  * table rules were updated for the new table configuration.
  *
@@ -7065,7 +6937,6 @@ rte_flow_async_update_resized(uint16_t port_id, uint32_t queue,
  *   - (-EINVAL) if *table* cannot complete table resize,
  *               unrecoverable error.
  */
-__rte_experimental
 int
 rte_flow_template_table_resize_complete(uint16_t port_id,
 					struct rte_flow_template_table *table,
-- 
2.53.0

