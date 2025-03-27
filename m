Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 441F8C3600B
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Mar 2025 13:37:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0422B40DCA;
	Thu, 27 Mar 2025 14:37:08 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 4D39240DC9
 for <dev@dpdk.org>; Thu, 27 Mar 2025 14:37:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743082625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BkyO4fK9edUvvPpFkv8X9DTIDLA8kZn2HAMosOEJTaQ=;
 b=hfd5/dItltl8Mt0S4TuE3DqzkvcNYm63GYhmlaUUR9xoiGr80s5SeNsCWFE9vnCuimKFUH
 BnSRDYntM8PAaWka9dA7lo5t319Mm9KJESO+ziy66dDGQ+ROtDcGRrxxpXOCGiJWQDvLjE
 9ey51W5xjF2Z1njgCyKQBGHgV5WjS/I=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-FGIgA-JMNTKxtddcVPVMJA-1; Thu,
 27 Mar 2025 09:37:02 -0400
X-MC-Unique: FGIgA-JMNTKxtddcVPVMJA-1
X-Mimecast-MFC-AGG-ID: FGIgA-JMNTKxtddcVPVMJA_1743082620
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2C82018004A9; Thu, 27 Mar 2025 13:37:00 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.224.228])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1AF35180B487; Thu, 27 Mar 2025 13:36:54 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, bruce.richardson@intel.com,
 andremue@linux.microsoft.com, Jerin Jacob <jerinj@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>,
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Anoob Joseph <anoobj@marvell.com>, Volodymyr Fialko <vfialko@marvell.com>,
 Ori Kam <orika@nvidia.com>, Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH v5 1/8] lib: remove incorrect exported symbols
Date: Thu, 27 Mar 2025 14:36:21 +0100
Message-ID: <20250327133638.2983276-2-david.marchand@redhat.com>
In-Reply-To: <20250327133638.2983276-1-david.marchand@redhat.com>
References: <20250305212349.2036410-1-david.marchand@redhat.com>
 <20250327133638.2983276-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: K_Z-iJUdstsOgsDEnPs0a26kY6sZvdxJl6xlC4UYbN0_1743082620
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

Declaring inline helpers in version.map is unnecessary.
There is no exported symbol and this will probably be treated as an
error by MSVC linker.

eal_log_journal has no implementation and can be removed.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 lib/eventdev/version.map | 12 ------------
 lib/graph/version.map    | 17 -----------------
 lib/ipsec/version.map    |  4 ----
 lib/log/log_internal.h   |  3 ---
 lib/log/version.map      |  1 -
 lib/pdcp/version.map     |  4 ----
 lib/regexdev/version.map |  2 --
 lib/vhost/version.map    |  1 -
 8 files changed, 44 deletions(-)

diff --git a/lib/eventdev/version.map b/lib/eventdev/version.map
index 44687255cb..bff08d6a62 100644
--- a/lib/eventdev/version.map
+++ b/lib/eventdev/version.map
@@ -102,9 +102,6 @@ DPDK_25 {
 	rte_event_timer_adapter_stats_get;
 	rte_event_timer_adapter_stats_reset;
 	rte_event_timer_adapter_stop;
-	rte_event_timer_arm_burst;
-	rte_event_timer_arm_tmo_tick_burst;
-	rte_event_timer_cancel_burst;
 	rte_event_vector_pool_create;
 
 	local: *;
@@ -149,9 +146,7 @@ EXPERIMENTAL {
 	__rte_eventdev_trace_port_profile_switch;
 
 	# added in 24.11
-	rte_event_port_preschedule_modify;
 	__rte_eventdev_trace_port_preschedule_modify;
-	rte_event_port_preschedule;
 	__rte_eventdev_trace_port_preschedule;
 
 	# added in 25.03
@@ -166,14 +161,7 @@ INTERNAL {
 	event_dev_probing_finish;
 	rte_event_logtype;
 	rte_event_pmd_allocate;
-	rte_event_pmd_get_named_dev;
-	rte_event_pmd_is_valid_dev;
-	rte_event_pmd_pci_probe;
-	rte_event_pmd_pci_probe_named;
-	rte_event_pmd_pci_remove;
 	rte_event_pmd_release;
 	rte_event_pmd_selftest_seqn_dynfield_offset;
-	rte_event_pmd_vdev_init;
-	rte_event_pmd_vdev_uninit;
 	rte_eventdevs;
 };
diff --git a/lib/graph/version.map b/lib/graph/version.map
index 44fadc00fd..d03d44434d 100644
--- a/lib/graph/version.map
+++ b/lib/graph/version.map
@@ -27,9 +27,7 @@ DPDK_25 {
 	rte_graph_node_get;
 	rte_graph_node_get_by_name;
 	rte_graph_obj_dump;
-	rte_graph_walk;
 	rte_graph_worker_model_get;
-	rte_graph_worker_model_no_check_get;
 	rte_graph_worker_model_set;
 	rte_node_clone;
 	rte_node_dump;
@@ -37,25 +35,10 @@ DPDK_25 {
 	rte_node_edge_get;
 	rte_node_edge_shrink;
 	rte_node_edge_update;
-	rte_node_enqueue;
-	rte_node_enqueue_next;
-	rte_node_enqueue_x1;
-	rte_node_enqueue_x2;
-	rte_node_enqueue_x4;
 	rte_node_from_name;
 	rte_node_id_to_name;
 	rte_node_list_dump;
 	rte_node_max_count;
-	rte_node_next_stream_get;
-	rte_node_next_stream_move;
-	rte_node_next_stream_put;
 
 	local: *;
 };
-
-EXPERIMENTAL {
-	global:
-
-	# added in 24.11
-	rte_node_xstat_increment;
-};
diff --git a/lib/ipsec/version.map b/lib/ipsec/version.map
index 308f9d2e0d..47e3df5bb6 100644
--- a/lib/ipsec/version.map
+++ b/lib/ipsec/version.map
@@ -1,9 +1,6 @@
 DPDK_25 {
 	global:
 
-	rte_ipsec_pkt_crypto_group;
-	rte_ipsec_pkt_crypto_prepare;
-	rte_ipsec_pkt_process;
 	rte_ipsec_sa_fini;
 	rte_ipsec_sa_init;
 	rte_ipsec_sa_size;
@@ -14,7 +11,6 @@ DPDK_25 {
 	rte_ipsec_sad_destroy;
 	rte_ipsec_sad_find_existing;
 	rte_ipsec_sad_lookup;
-	rte_ipsec_ses_from_crypto;
 	rte_ipsec_session_prepare;
 	rte_ipsec_telemetry_sa_add;
 	rte_ipsec_telemetry_sa_del;
diff --git a/lib/log/log_internal.h b/lib/log/log_internal.h
index bba7041ea3..525e1397fd 100644
--- a/lib/log/log_internal.h
+++ b/lib/log/log_internal.h
@@ -29,9 +29,6 @@ int eal_log_save_pattern(const char *pattern, uint32_t level);
 __rte_internal
 int eal_log_syslog(const char *name);
 
-__rte_internal
-int eal_log_journal(const char *opt);
-
 /*
  * Convert log level to string.
  */
diff --git a/lib/log/version.map b/lib/log/version.map
index 09d8a4289b..603be493b3 100644
--- a/lib/log/version.map
+++ b/lib/log/version.map
@@ -27,7 +27,6 @@ INTERNAL {
 
 	eal_log_color;
 	eal_log_init;
-	eal_log_journal; # WINDOWS_NO_EXPORT
 	eal_log_level2str;
 	eal_log_save_pattern;
 	eal_log_save_regexp;
diff --git a/lib/pdcp/version.map b/lib/pdcp/version.map
index 9c02303c45..72b2d4729b 100644
--- a/lib/pdcp/version.map
+++ b/lib/pdcp/version.map
@@ -3,13 +3,9 @@ EXPERIMENTAL {
 
 	# added in 23.07
 	rte_pdcp_control_pdu_create;
-	rte_pdcp_en_from_cop;
 	rte_pdcp_entity_establish;
 	rte_pdcp_entity_release;
 	rte_pdcp_entity_suspend;
-	rte_pdcp_pkt_post_process;
-	rte_pdcp_pkt_pre_process;
-	rte_pdcp_pkt_crypto_group;
 	rte_pdcp_t_reordering_expiry_handle;
 
 	local: *;
diff --git a/lib/regexdev/version.map b/lib/regexdev/version.map
index 4c0435180c..713a800ca4 100644
--- a/lib/regexdev/version.map
+++ b/lib/regexdev/version.map
@@ -7,9 +7,7 @@ EXPERIMENTAL {
 	rte_regexdev_close;
 	rte_regexdev_configure;
 	rte_regexdev_count;
-	rte_regexdev_dequeue_burst;
 	rte_regexdev_dump;
-	rte_regexdev_enqueue_burst;
 	rte_regexdev_get_dev_id;
 	rte_regexdev_info_get;
 	rte_regexdev_queue_pair_setup;
diff --git a/lib/vhost/version.map b/lib/vhost/version.map
index 8333e100ed..c044bb714e 100644
--- a/lib/vhost/version.map
+++ b/lib/vhost/version.map
@@ -61,7 +61,6 @@ DPDK_25 {
 	rte_vhost_set_last_inflight_io_packed;
 	rte_vhost_set_last_inflight_io_split;
 	rte_vhost_set_vring_base;
-	rte_vhost_va_from_guest_pa;
 	rte_vhost_vring_call;
 	rte_vhost_vring_call_nonblock;
 	rte_vhost_vring_stats_get;
-- 
2.48.1

