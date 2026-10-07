Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 504ADCA5FFF
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 21:42:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E146A42D89;
	Wed,  7 Oct 2026 23:41:33 +0200 (CEST)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by mails.dpdk.org (Postfix) with ESMTP id 5A24E427E2
 for <dev@dpdk.org>; Wed,  7 Oct 2026 23:41:31 +0200 (CEST)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2e2c837fa12so11570995ad.1
 for <dev@dpdk.org>; Wed, 07 Oct 2026 14:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791409290;
 x=1792014090; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rJx3x98kidiE7ZmM7WKDJBCW1UvqgDbFPNyVYP6w4Dw=;
 b=mi6A2uirZlXv+g51/NTK6k/FMvyjbfFL3L88+WJlFIl+cCNKHxB4i9U3jES3ZsqRnR
 oCtlgaz1L4GEXd4BjM32Gk0+LlktOQwpkJGFFM84MhkSXgsPtdfgzdgZUjy0/kmkFl6F
 n8e0ASmb6RUPzYie8fOlvaZXn4d/qAGa66HMdYB+Sg6deztd2BzWEhntK5YO1YA2FLW1
 x3ysnUR0Od5TNPt3YTVltLxgqDzE/u3W/YzmaaNB+A3KlgfN0AH2gbCD4CI2a+8IbxcQ
 gAD9CQwkpEsUOXDOAlH0DbSYTiszZsp5V1Bly7LOsKcblSR6P39a9r7U+sq70668lx+d
 YprA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791409290; x=1792014090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rJx3x98kidiE7ZmM7WKDJBCW1UvqgDbFPNyVYP6w4Dw=;
 b=SnKXsEndgveVUBZcz6Nw73OyPx83Am44eBDzyct31sWxARBfd/D9QWHfrpdoCgwnmV
 9JaRlgiyOs580LnD7RFLVY7M2GBg1BbErdY9vOfuMs81NtOEr1S0cvddHP58pCz9odjl
 MTjAaV7WeaS+yVcb1Pj/ScZ/UpJvOE265KGFDusNrvRAgEnr0DGs/CgTQWepEikjfOn3
 dWjzfZ3PueUsPMuLhfpMlM078YQO+I4K31IkPkUvYvpzcZmlbqMBAd54CqdBll3xxRAb
 LC6k/DtJ7Dc9DpLM7EozFtoBODiS/CEOgjGTohAD2km9dm2ttKc73v+uY9J9Bw/RbsS9
 mLPw==
X-Gm-Message-State: AFq9FYLNJBLGVllQI5cSjlrs616k3jV+JzxHpXemS5bNXDR7KBSABOnG
 s3V/xiBqkqITm1hRFNjqmepEMwyUNmuJ8DQECjpvPFWZobCnUdAvNiEX/5Y00j1TIFMUL/4+qpD
 7+1/Wae0=
X-Gm-Gg: AYBFou2717TKHenwkVwyD1R9MF1a+PkOX410ASVCed/JsZlKt6Nn9B30M4H0J44ifTm
 JF9CDETU0Dqen6G++/lOzzNnRdUAtHoyQJo1JsXlBT6mX2O7v/bGgkKOxgqk5AVp9II24Z3gER+
 7afXaywKg6FBFp3MI+sc+zk8sYJkij4I8z4DBGKd0bVry1Jfa9GVpoa/F2gyG11kmEoHhd6No/+
 thmzkNzLXt+jC1Qg7MFjdFRy4JD42AIiOMknCCsE/U5ZfDlho80010mtyfEZ9Di+iP0v7IXl5FY
 BWCPuxk7ZSkaEtPyEgudehxbeIXPj0GXRebA8Y3ffntpheD9tQ50wJti8F5s2ziMXo1uEL3S2c1
 msZ2eXdAWu0yB8CD1I7PwwuNynoJxAXc3U7PMCnjvBTiHNWupt+jr8rOlIcAQkXpeJ07QiirBfI
 rBC9+262AR/RDnIuPkNRR2ALFUvMfk5XDoLG5BJFmQUaz3A7spXKmXhGNm0IekIMvebGowJz+Iq
 rCNgEi8Cx2r+sbqohVGbrK9S5k21R9L5rcdZQ==
X-Received: by 2002:a17:903:2a84:b0:2e1:2ed2:7cee with SMTP id
 d9443c01a7336-2e600540d3bmr25116075ad.52.1791409290128; 
 Wed, 07 Oct 2026 14:41:30 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e60484ca89sm16573335ad.57.2026.10.07.14.41.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 14:41:29 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>
Subject: [PATCH 11/20] pipeline: promote SWX pipeline and control API to stable
Date: Wed,  7 Oct 2026 14:39:41 -0700
Message-ID: <20261007214115.3092715-12-stephen@networkplumber.org>
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

The rte_swx_pipeline_* symbols date from 20.11, with later additions for
the register and meter arrays (21.05), selector (21.08), learner (21.11),
hash function registration (22.07), pipeline lookup and code generation
(22.11) and RSS (23.03). The rte_swx_ctl_* control plane symbols span the
same range of releases.

The API has been in use unchanged for several releases and is the only
pipeline API remaining now that the legacy rte_pipeline_* API has been
removed, so promote it to stable.

The pipeline and control parts are promoted together because they cannot
be separated: rte_swx_ctl.h declares symbols defined in both
rte_swx_ctl.c and rte_swx_pipeline.c, so dropping __rte_experimental from
that header requires updating the exports in both files at once.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_11.rst |   5 +
 lib/pipeline/rte_swx_ctl.c             |  34 +++---
 lib/pipeline/rte_swx_ctl.h             |  61 -----------
 lib/pipeline/rte_swx_pipeline.c        | 146 ++++++++++++-------------
 lib/pipeline/rte_swx_pipeline.h        |  32 ------
 5 files changed, 95 insertions(+), 183 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index ac8ce1d9a5..fad1a53e04 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -343,6 +343,11 @@ API Changes
     ``rte_event_port_profile_links_get`` and
     ``rte_event_port_profile_unlink``
 
+* pipeline: Promoted the SWX API from experimental to stable:
+  the ``rte_swx_pipeline_*``, ``rte_swx_ctl_*`` and ``rte_swx_ipsec_*``
+  functions in pipeline, the ``rte_swx_table_*`` symbols in table and
+  the ``rte_swx_port_*`` symbols in port.
+
 * reorder: Promoted the following API from experimental to stable:
   ``rte_reorder_seqn``, ``rte_reorder_drain_up_to_seqn``,
   ``rte_reorder_min_seqn_set`` and ``rte_reorder_memory_footprint_get``.
diff --git a/lib/pipeline/rte_swx_ctl.c b/lib/pipeline/rte_swx_ctl.c
index d24764cbbe..eaa8b7bb28 100644
--- a/lib/pipeline/rte_swx_ctl.c
+++ b/lib/pipeline/rte_swx_ctl.c
@@ -1170,7 +1170,7 @@ static struct rte_tailq_elem rte_swx_ctl_pipeline_tailq = {
 
 EAL_REGISTER_TAILQ(rte_swx_ctl_pipeline_tailq)
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_find, 22.11)
+RTE_EXPORT_SYMBOL(rte_swx_ctl_pipeline_find)
 struct rte_swx_ctl_pipeline *
 rte_swx_ctl_pipeline_find(const char *name)
 {
@@ -1250,7 +1250,7 @@ ctl_unregister(struct rte_swx_ctl_pipeline *ctl)
 	rte_mcfg_tailq_write_unlock();
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_free, 20.11)
+RTE_EXPORT_SYMBOL(rte_swx_ctl_pipeline_free)
 void
 rte_swx_ctl_pipeline_free(struct rte_swx_ctl_pipeline *ctl)
 {
@@ -1273,7 +1273,7 @@ rte_swx_ctl_pipeline_free(struct rte_swx_ctl_pipeline *ctl)
 	free(ctl);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_create, 20.11)
+RTE_EXPORT_SYMBOL(rte_swx_ctl_pipeline_create)
 struct rte_swx_ctl_pipeline *
 rte_swx_ctl_pipeline_create(struct rte_swx_pipeline *p)
 {
@@ -1552,7 +1552,7 @@ rte_swx_ctl_pipeline_create(struct rte_swx_pipeline *p)
 	return NULL;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_table_entry_add, 20.11)
+RTE_EXPORT_SYMBOL(rte_swx_ctl_pipeline_table_entry_add)
 int
 rte_swx_ctl_pipeline_table_entry_add(struct rte_swx_ctl_pipeline *ctl,
 				     const char *table_name,
@@ -1667,7 +1667,7 @@ rte_swx_ctl_pipeline_table_entry_add(struct rte_swx_ctl_pipeline *ctl,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_table_entry_delete, 20.11)
+RTE_EXPORT_SYMBOL(rte_swx_ctl_pipeline_table_entry_delete)
 int
 rte_swx_ctl_pipeline_table_entry_delete(struct rte_swx_ctl_pipeline *ctl,
 					const char *table_name,
@@ -1758,7 +1758,7 @@ rte_swx_ctl_pipeline_table_entry_delete(struct rte_swx_ctl_pipeline *ctl,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_table_default_entry_add, 20.11)
+RTE_EXPORT_SYMBOL(rte_swx_ctl_pipeline_table_default_entry_add)
 int
 rte_swx_ctl_pipeline_table_default_entry_add(struct rte_swx_ctl_pipeline *ctl,
 					     const char *table_name,
@@ -2096,7 +2096,7 @@ table_abort(struct rte_swx_ctl_pipeline *ctl, uint32_t table_id)
 	table_pending_default_free(table);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_selector_group_add, 21.08)
+RTE_EXPORT_SYMBOL(rte_swx_ctl_pipeline_selector_group_add)
 int
 rte_swx_ctl_pipeline_selector_group_add(struct rte_swx_ctl_pipeline *ctl,
 					const char *selector_name,
@@ -2124,7 +2124,7 @@ rte_swx_ctl_pipeline_selector_group_add(struct rte_swx_ctl_pipeline *ctl,
 	return -ENOSPC;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_selector_group_delete, 21.08)
+RTE_EXPORT_SYMBOL(rte_swx_ctl_pipeline_selector_group_delete)
 int
 rte_swx_ctl_pipeline_selector_group_delete(struct rte_swx_ctl_pipeline *ctl,
 					   const char *selector_name,
@@ -2176,7 +2176,7 @@ rte_swx_ctl_pipeline_selector_group_delete(struct rte_swx_ctl_pipeline *ctl,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_selector_group_member_add, 21.08)
+RTE_EXPORT_SYMBOL(rte_swx_ctl_pipeline_selector_group_member_add)
 int
 rte_swx_ctl_pipeline_selector_group_member_add(struct rte_swx_ctl_pipeline *ctl,
 					       const char *selector_name,
@@ -2236,7 +2236,7 @@ rte_swx_ctl_pipeline_selector_group_member_add(struct rte_swx_ctl_pipeline *ctl,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_selector_group_member_delete, 21.08)
+RTE_EXPORT_SYMBOL(rte_swx_ctl_pipeline_selector_group_member_delete)
 int
 rte_swx_ctl_pipeline_selector_group_member_delete(struct rte_swx_ctl_pipeline *ctl,
 						  const char *selector_name,
@@ -2490,7 +2490,7 @@ learner_default_entry_duplicate(struct rte_swx_ctl_pipeline *ctl,
 	return NULL;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_learner_default_entry_add, 21.11)
+RTE_EXPORT_SYMBOL(rte_swx_ctl_pipeline_learner_default_entry_add)
 int
 rte_swx_ctl_pipeline_learner_default_entry_add(struct rte_swx_ctl_pipeline *ctl,
 					       const char *learner_name,
@@ -2564,7 +2564,7 @@ learner_abort(struct rte_swx_ctl_pipeline *ctl, uint32_t learner_id)
 	learner_pending_default_free(l);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_commit, 20.11)
+RTE_EXPORT_SYMBOL(rte_swx_ctl_pipeline_commit)
 int
 rte_swx_ctl_pipeline_commit(struct rte_swx_ctl_pipeline *ctl, int abort_on_fail)
 {
@@ -2651,7 +2651,7 @@ rte_swx_ctl_pipeline_commit(struct rte_swx_ctl_pipeline *ctl, int abort_on_fail)
 	return status;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_abort, 20.11)
+RTE_EXPORT_SYMBOL(rte_swx_ctl_pipeline_abort)
 void
 rte_swx_ctl_pipeline_abort(struct rte_swx_ctl_pipeline *ctl)
 {
@@ -2986,7 +2986,7 @@ token_is_comment(const char *token)
 
 #define RTE_SWX_CTL_ENTRY_TOKENS_MAX 256
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_table_entry_read, 20.11)
+RTE_EXPORT_SYMBOL(rte_swx_ctl_pipeline_table_entry_read)
 struct rte_swx_table_entry *
 rte_swx_ctl_pipeline_table_entry_read(struct rte_swx_ctl_pipeline *ctl,
 				      const char *table_name,
@@ -3186,7 +3186,7 @@ rte_swx_ctl_pipeline_table_entry_read(struct rte_swx_ctl_pipeline *ctl,
 	return NULL;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_learner_default_entry_read, 21.11)
+RTE_EXPORT_SYMBOL(rte_swx_ctl_pipeline_learner_default_entry_read)
 struct rte_swx_table_entry *
 rte_swx_ctl_pipeline_learner_default_entry_read(struct rte_swx_ctl_pipeline *ctl,
 						const char *learner_name,
@@ -3339,7 +3339,7 @@ table_entry_printf(FILE *f,
 	fprintf(f, "\n");
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_table_fprintf, 20.11)
+RTE_EXPORT_SYMBOL(rte_swx_ctl_pipeline_table_fprintf)
 int
 rte_swx_ctl_pipeline_table_fprintf(FILE *f,
 				   struct rte_swx_ctl_pipeline *ctl,
@@ -3390,7 +3390,7 @@ rte_swx_ctl_pipeline_table_fprintf(FILE *f,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_selector_fprintf, 21.08)
+RTE_EXPORT_SYMBOL(rte_swx_ctl_pipeline_selector_fprintf)
 int
 rte_swx_ctl_pipeline_selector_fprintf(FILE *f,
 				      struct rte_swx_ctl_pipeline *ctl,
diff --git a/lib/pipeline/rte_swx_ctl.h b/lib/pipeline/rte_swx_ctl.h
index c4e63753f5..ee85eea852 100644
--- a/lib/pipeline/rte_swx_ctl.h
+++ b/lib/pipeline/rte_swx_ctl.h
@@ -12,7 +12,6 @@
 #include <stdint.h>
 #include <stdio.h>
 
-#include <rte_compat.h>
 #include <rte_meter.h>
 
 #include "rte_swx_port.h"
@@ -83,7 +82,6 @@ struct rte_swx_ctl_pipeline_info {
  *   0 on success or the following error codes otherwise:
  *   -EINVAL: Invalid argument.
  */
-__rte_experimental
 int
 rte_swx_ctl_pipeline_info_get(struct rte_swx_pipeline *p,
 			      struct rte_swx_ctl_pipeline_info *pipeline);
@@ -99,7 +97,6 @@ rte_swx_ctl_pipeline_info_get(struct rte_swx_pipeline *p,
  *   0 on success or the following error codes otherwise:
  *   -EINVAL: Invalid argument.
  */
-__rte_experimental
 int
 rte_swx_ctl_pipeline_numa_node_get(struct rte_swx_pipeline *p,
 				   int *numa_node);
@@ -121,7 +118,6 @@ rte_swx_ctl_pipeline_numa_node_get(struct rte_swx_pipeline *p,
  *   0 on success or the following error codes otherwise:
  *   -EINVAL: Invalid argument.
  */
-__rte_experimental
 int
 rte_swx_ctl_pipeline_port_in_stats_read(struct rte_swx_pipeline *p,
 					uint32_t port_id,
@@ -140,7 +136,6 @@ rte_swx_ctl_pipeline_port_in_stats_read(struct rte_swx_pipeline *p,
  *   0 on success or the following error codes otherwise:
  *   -EINVAL: Invalid argument.
  */
-__rte_experimental
 int
 rte_swx_ctl_pipeline_port_out_stats_read(struct rte_swx_pipeline *p,
 					 uint32_t port_id,
@@ -172,7 +167,6 @@ struct rte_swx_ctl_action_info {
  *   0 on success or the following error codes otherwise:
  *   -EINVAL: Invalid argument.
  */
-__rte_experimental
 int
 rte_swx_ctl_action_info_get(struct rte_swx_pipeline *p,
 			    uint32_t action_id,
@@ -208,7 +202,6 @@ struct rte_swx_ctl_action_arg_info {
  *   0 on success or the following error codes otherwise:
  *   -EINVAL: Invalid argument.
  */
-__rte_experimental
 int
 rte_swx_ctl_action_arg_info_get(struct rte_swx_pipeline *p,
 				uint32_t action_id,
@@ -259,7 +252,6 @@ struct rte_swx_ctl_table_info {
  *   0 on success or the following error codes otherwise:
  *   -EINVAL: Invalid argument.
  */
-__rte_experimental
 int
 rte_swx_ctl_table_info_get(struct rte_swx_pipeline *p,
 			   uint32_t table_id,
@@ -303,7 +295,6 @@ struct rte_swx_ctl_table_match_field_info {
  *   0 on success or the following error codes otherwise:
  *   -EINVAL: Invalid argument.
  */
-__rte_experimental
 int
 rte_swx_ctl_table_match_field_info_get(struct rte_swx_pipeline *p,
 	uint32_t table_id,
@@ -340,7 +331,6 @@ struct rte_swx_ctl_table_action_info {
  *   0 on success or the following error codes otherwise:
  *   -EINVAL: Invalid argument.
  */
-__rte_experimental
 int
 rte_swx_ctl_table_action_info_get(struct rte_swx_pipeline *p,
 	uint32_t table_id,
@@ -366,7 +356,6 @@ rte_swx_ctl_table_action_info_get(struct rte_swx_pipeline *p,
  *   0 on success or the following error codes otherwise:
  *   -EINVAL: Invalid argument.
  */
-__rte_experimental
 int
 rte_swx_ctl_table_ops_get(struct rte_swx_pipeline *p,
 			  uint32_t table_id,
@@ -405,7 +394,6 @@ struct rte_swx_table_stats {
  *   0 on success or the following error codes otherwise:
  *   -EINVAL: Invalid argument.
  */
-__rte_experimental
 int
 rte_swx_ctl_pipeline_table_stats_read(struct rte_swx_pipeline *p,
 				      const char *table_name,
@@ -443,7 +431,6 @@ struct rte_swx_ctl_selector_info {
  *   0 on success or the following error codes otherwise:
  *   -EINVAL: Invalid argument.
  */
-__rte_experimental
 int
 rte_swx_ctl_selector_info_get(struct rte_swx_pipeline *p,
 			      uint32_t selector_id,
@@ -462,7 +449,6 @@ rte_swx_ctl_selector_info_get(struct rte_swx_pipeline *p,
  *   0 on success or the following error codes otherwise:
  *   -EINVAL: Invalid argument.
  */
-__rte_experimental
 int
 rte_swx_ctl_selector_group_id_field_info_get(struct rte_swx_pipeline *p,
 					     uint32_t selector_id,
@@ -483,7 +469,6 @@ rte_swx_ctl_selector_group_id_field_info_get(struct rte_swx_pipeline *p,
  *   0 on success or the following error codes otherwise:
  *   -EINVAL: Invalid argument.
  */
-__rte_experimental
 int
 rte_swx_ctl_selector_field_info_get(struct rte_swx_pipeline *p,
 				    uint32_t selector_id,
@@ -503,7 +488,6 @@ rte_swx_ctl_selector_field_info_get(struct rte_swx_pipeline *p,
  *   0 on success or the following error codes otherwise:
  *   -EINVAL: Invalid argument.
  */
-__rte_experimental
 int
 rte_swx_ctl_selector_member_id_field_info_get(struct rte_swx_pipeline *p,
 					      uint32_t selector_id,
@@ -528,7 +512,6 @@ struct rte_swx_pipeline_selector_stats {
  *   0 on success or the following error codes otherwise:
  *   -EINVAL: Invalid argument.
  */
-__rte_experimental
 int
 rte_swx_ctl_pipeline_selector_stats_read(struct rte_swx_pipeline *p,
 					 const char *selector_name,
@@ -575,7 +558,6 @@ struct rte_swx_ctl_learner_info {
  *   0 on success or the following error codes otherwise:
  *   -EINVAL: Invalid argument.
  */
-__rte_experimental
 int
 rte_swx_ctl_learner_info_get(struct rte_swx_pipeline *p,
 			     uint32_t learner_id,
@@ -596,7 +578,6 @@ rte_swx_ctl_learner_info_get(struct rte_swx_pipeline *p,
  *   0 on success or the following error codes otherwise:
  *   -EINVAL: Invalid argument.
  */
-__rte_experimental
 int
 rte_swx_ctl_learner_match_field_info_get(struct rte_swx_pipeline *p,
 					 uint32_t learner_id,
@@ -620,7 +601,6 @@ rte_swx_ctl_learner_match_field_info_get(struct rte_swx_pipeline *p,
  *   0 on success or the following error codes otherwise:
  *   -EINVAL: Invalid argument.
  */
-__rte_experimental
 int
 rte_swx_ctl_learner_action_info_get(struct rte_swx_pipeline *p,
 				    uint32_t learner_id,
@@ -642,7 +622,6 @@ rte_swx_ctl_learner_action_info_get(struct rte_swx_pipeline *p,
  *   0 on success or the following error codes otherwise:
  *   -EINVAL: Invalid argument.
  */
-__rte_experimental
 int
 rte_swx_ctl_pipeline_learner_timeout_get(struct rte_swx_pipeline *p,
 					 uint32_t learner_id,
@@ -664,7 +643,6 @@ rte_swx_ctl_pipeline_learner_timeout_get(struct rte_swx_pipeline *p,
  *   0 on success or the following error codes otherwise:
  *   -EINVAL: Invalid argument.
  */
-__rte_experimental
 int
 rte_swx_ctl_pipeline_learner_timeout_set(struct rte_swx_pipeline *p,
 					 uint32_t learner_id,
@@ -714,7 +692,6 @@ struct rte_swx_learner_stats {
  *   0 on success or the following error codes otherwise:
  *   -EINVAL: Invalid argument.
  */
-__rte_experimental
 int
 rte_swx_ctl_pipeline_learner_stats_read(struct rte_swx_pipeline *p,
 				      const char *learner_name,
@@ -750,7 +727,6 @@ struct rte_swx_pipeline_mirroring_session_params {
  *   -EINVAL: Invalid argument;
  *   -EEXIST: Pipeline was already built successfully.
  */
-__rte_experimental
 int
 rte_swx_ctl_pipeline_mirroring_session_set(struct rte_swx_pipeline *p,
 	uint32_t session_id,
@@ -790,7 +766,6 @@ struct rte_swx_table_state {
  *   0 on success or the following error codes otherwise:
  *   -EINVAL: Invalid argument.
  */
-__rte_experimental
 int
 rte_swx_pipeline_table_state_get(struct rte_swx_pipeline *p,
 				 struct rte_swx_table_state **table_state);
@@ -809,7 +784,6 @@ rte_swx_pipeline_table_state_get(struct rte_swx_pipeline *p,
  *   0 on success or the following error codes otherwise:
  *   -EINVAL: Invalid argument.
  */
-__rte_experimental
 int
 rte_swx_pipeline_table_state_set(struct rte_swx_pipeline *p,
 				 struct rte_swx_table_state *table_state);
@@ -829,7 +803,6 @@ struct rte_swx_ctl_pipeline;
  * @return
  *   Valid pipeline control handle if found or NULL otherwise.
  */
-__rte_experimental
 struct rte_swx_ctl_pipeline *
 rte_swx_ctl_pipeline_find(const char *name);
 
@@ -841,7 +814,6 @@ rte_swx_ctl_pipeline_find(const char *name);
  * @return
  *   Pipeline control handle, on success, or NULL, on error.
  */
-__rte_experimental
 struct rte_swx_ctl_pipeline *
 rte_swx_ctl_pipeline_create(struct rte_swx_pipeline *p);
 
@@ -861,7 +833,6 @@ rte_swx_ctl_pipeline_create(struct rte_swx_pipeline *p);
  *   0 on success or the following error codes otherwise:
  *   -EINVAL: Invalid argument.
  */
-__rte_experimental
 int
 rte_swx_ctl_pipeline_table_entry_add(struct rte_swx_ctl_pipeline *ctl,
 				     const char *table_name,
@@ -883,7 +854,6 @@ rte_swx_ctl_pipeline_table_entry_add(struct rte_swx_ctl_pipeline *ctl,
  *   0 on success or the following error codes otherwise:
  *   -EINVAL: Invalid argument.
  */
-__rte_experimental
 int
 rte_swx_ctl_pipeline_table_default_entry_add(struct rte_swx_ctl_pipeline *ctl,
 					     const char *table_name,
@@ -906,7 +876,6 @@ rte_swx_ctl_pipeline_table_default_entry_add(struct rte_swx_ctl_pipeline *ctl,
  *   0 on success or the following error codes otherwise:
  *   -EINVAL: Invalid argument.
  */
-__rte_experimental
 int
 rte_swx_ctl_pipeline_table_entry_delete(struct rte_swx_ctl_pipeline *ctl,
 					const char *table_name,
@@ -931,7 +900,6 @@ rte_swx_ctl_pipeline_table_entry_delete(struct rte_swx_ctl_pipeline *ctl,
  *   -EINVAL: Invalid argument;
  *   -ENOSPC: All groups are currently in use, no group available.
  */
-__rte_experimental
 int
 rte_swx_ctl_pipeline_selector_group_add(struct rte_swx_ctl_pipeline *ctl,
 					const char *selector_name,
@@ -954,7 +922,6 @@ rte_swx_ctl_pipeline_selector_group_add(struct rte_swx_ctl_pipeline *ctl,
  *   -EINVAL: Invalid argument;
  *   -ENOMEM: Not enough memory.
  */
-__rte_experimental
 int
 rte_swx_ctl_pipeline_selector_group_delete(struct rte_swx_ctl_pipeline *ctl,
 					   const char *selector_name,
@@ -984,7 +951,6 @@ rte_swx_ctl_pipeline_selector_group_delete(struct rte_swx_ctl_pipeline *ctl,
  *   -ENOMEM: Not enough memory;
  *   -ENOSPC: The group is full.
  */
-__rte_experimental
 int
 rte_swx_ctl_pipeline_selector_group_member_add(struct rte_swx_ctl_pipeline *ctl,
 					       const char *selector_name,
@@ -1010,7 +976,6 @@ rte_swx_ctl_pipeline_selector_group_member_add(struct rte_swx_ctl_pipeline *ctl,
  *   0 on success or the following error codes otherwise:
  *   -EINVAL: Invalid argument.
  */
-__rte_experimental
 int
 rte_swx_ctl_pipeline_selector_group_member_delete(struct rte_swx_ctl_pipeline *ctl,
 						  const char *selector_name,
@@ -1032,7 +997,6 @@ rte_swx_ctl_pipeline_selector_group_member_delete(struct rte_swx_ctl_pipeline *c
  *   0 on success or the following error codes otherwise:
  *   -EINVAL: Invalid argument.
  */
-__rte_experimental
 int
 rte_swx_ctl_pipeline_learner_default_entry_add(struct rte_swx_ctl_pipeline *ctl,
 					       const char *learner_name,
@@ -1053,7 +1017,6 @@ rte_swx_ctl_pipeline_learner_default_entry_add(struct rte_swx_ctl_pipeline *ctl,
  *   0 on success or the following error codes otherwise:
  *   -EINVAL: Invalid argument.
  */
-__rte_experimental
 int
 rte_swx_ctl_pipeline_commit(struct rte_swx_ctl_pipeline *ctl,
 			    int abort_on_fail);
@@ -1066,7 +1029,6 @@ rte_swx_ctl_pipeline_commit(struct rte_swx_ctl_pipeline *ctl,
  * @param[in] ctl
  *   Pipeline control handle.
  */
-__rte_experimental
 void
 rte_swx_ctl_pipeline_abort(struct rte_swx_ctl_pipeline *ctl);
 
@@ -1089,7 +1051,6 @@ rte_swx_ctl_pipeline_abort(struct rte_swx_ctl_pipeline *ctl);
  *   0 on success or the following error codes otherwise:
  *   -EINVAL: Invalid argument.
  */
-__rte_experimental
 struct rte_swx_table_entry *
 rte_swx_ctl_pipeline_table_entry_read(struct rte_swx_ctl_pipeline *ctl,
 				      const char *table_name,
@@ -1115,7 +1076,6 @@ rte_swx_ctl_pipeline_table_entry_read(struct rte_swx_ctl_pipeline *ctl,
  *   0 on success or the following error codes otherwise:
  *   -EINVAL: Invalid argument.
  */
-__rte_experimental
 struct rte_swx_table_entry *
 rte_swx_ctl_pipeline_learner_default_entry_read(struct rte_swx_ctl_pipeline *ctl,
 						const char *learner_name,
@@ -1137,7 +1097,6 @@ rte_swx_ctl_pipeline_learner_default_entry_read(struct rte_swx_ctl_pipeline *ctl
  *   0 on success or the following error codes otherwise:
  *   -EINVAL: Invalid argument.
  */
-__rte_experimental
 int
 rte_swx_ctl_pipeline_table_fprintf(FILE *f,
 				   struct rte_swx_ctl_pipeline *ctl,
@@ -1158,7 +1117,6 @@ rte_swx_ctl_pipeline_table_fprintf(FILE *f,
  *   0 on success or the following error codes otherwise:
  *   -EINVAL: Invalid argument.
  */
-__rte_experimental
 int
 rte_swx_ctl_pipeline_selector_fprintf(FILE *f,
 				      struct rte_swx_ctl_pipeline *ctl,
@@ -1190,7 +1148,6 @@ struct rte_swx_ctl_regarray_info {
  *   0 on success or the following error codes otherwise:
  *   -EINVAL: Invalid argument.
  */
-__rte_experimental
 int
 rte_swx_ctl_regarray_info_get(struct rte_swx_pipeline *p,
 			      uint32_t regarray_id,
@@ -1211,7 +1168,6 @@ rte_swx_ctl_regarray_info_get(struct rte_swx_pipeline *p,
  *   0 on success or the following error codes otherwise:
  *   -EINVAL: Invalid argument.
  */
-__rte_experimental
 int
 rte_swx_ctl_pipeline_regarray_read(struct rte_swx_pipeline *p,
 				   const char *regarray_name,
@@ -1233,7 +1189,6 @@ rte_swx_ctl_pipeline_regarray_read(struct rte_swx_pipeline *p,
  *   0 on success or the following error codes otherwise:
  *   -EINVAL: Invalid argument.
  */
-__rte_experimental
 int
 rte_swx_ctl_pipeline_regarray_write(struct rte_swx_pipeline *p,
 				   const char *regarray_name,
@@ -1258,7 +1213,6 @@ rte_swx_ctl_pipeline_regarray_write(struct rte_swx_pipeline *p,
  *   -EINVAL: Invalid argument;
  *   -ENOMEM: Not enough memory.
  */
-__rte_experimental
 int
 rte_swx_ctl_pipeline_regarray_read_with_key(struct rte_swx_pipeline *p,
 					    const char *regarray_name,
@@ -1284,7 +1238,6 @@ rte_swx_ctl_pipeline_regarray_read_with_key(struct rte_swx_pipeline *p,
  *   -EINVAL: Invalid argument;
  *   -ENOMEM: Not enough memory.
  */
-__rte_experimental
 int
 rte_swx_ctl_pipeline_regarray_write_with_key(struct rte_swx_pipeline *p,
 					     const char *regarray_name,
@@ -1318,7 +1271,6 @@ struct rte_swx_ctl_metarray_info {
  *   0 on success or the following error codes otherwise:
  *   -EINVAL: Invalid argument.
  */
-__rte_experimental
 int
 rte_swx_ctl_metarray_info_get(struct rte_swx_pipeline *p,
 			      uint32_t metarray_id,
@@ -1339,7 +1291,6 @@ rte_swx_ctl_metarray_info_get(struct rte_swx_pipeline *p,
  *   -ENOMEM: Not enough space/cannot allocate memory;
  *   -EEXIST: Meter profile with this name already exists.
  */
-__rte_experimental
 int
 rte_swx_ctl_meter_profile_add(struct rte_swx_pipeline *p,
 			      const char *name,
@@ -1357,7 +1308,6 @@ rte_swx_ctl_meter_profile_add(struct rte_swx_pipeline *p,
  *   -EINVAL: Invalid argument;
  *   -EBUSY: Meter profile is currently in use.
  */
-__rte_experimental
 int
 rte_swx_ctl_meter_profile_delete(struct rte_swx_pipeline *p,
 				 const char *name);
@@ -1380,7 +1330,6 @@ rte_swx_ctl_meter_profile_delete(struct rte_swx_pipeline *p,
  *   0 on success or the following error codes otherwise:
  *   -EINVAL: Invalid argument.
  */
-__rte_experimental
 int
 rte_swx_ctl_meter_reset(struct rte_swx_pipeline *p,
 			const char *metarray_name,
@@ -1405,7 +1354,6 @@ rte_swx_ctl_meter_reset(struct rte_swx_pipeline *p,
  *   0 on success or the following error codes otherwise:
  *   -EINVAL: Invalid argument.
  */
-__rte_experimental
 int
 rte_swx_ctl_meter_set(struct rte_swx_pipeline *p,
 		      const char *metarray_name,
@@ -1436,7 +1384,6 @@ struct rte_swx_ctl_meter_stats {
  *   0 on success or the following error codes otherwise:
  *   -EINVAL: Invalid argument.
  */
-__rte_experimental
 int
 rte_swx_ctl_meter_stats_read(struct rte_swx_pipeline *p,
 			     const char *metarray_name,
@@ -1463,7 +1410,6 @@ rte_swx_ctl_meter_stats_read(struct rte_swx_pipeline *p,
  *   0 on success or the following error codes otherwise:
  *   -EINVAL: Invalid argument.
  */
-__rte_experimental
 int
 rte_swx_ctl_meter_reset_with_key(struct rte_swx_pipeline *p,
 				 const char *metarray_name,
@@ -1491,7 +1437,6 @@ rte_swx_ctl_meter_reset_with_key(struct rte_swx_pipeline *p,
  *   0 on success or the following error codes otherwise:
  *   -EINVAL: Invalid argument.
  */
-__rte_experimental
 int
 rte_swx_ctl_meter_set_with_key(struct rte_swx_pipeline *p,
 			       const char *metarray_name,
@@ -1516,7 +1461,6 @@ rte_swx_ctl_meter_set_with_key(struct rte_swx_pipeline *p,
  *   0 on success or the following error codes otherwise:
  *   -EINVAL: Invalid argument.
  */
-__rte_experimental
 int
 rte_swx_ctl_meter_stats_read_with_key(struct rte_swx_pipeline *p,
 				      const char *metarray_name,
@@ -1547,7 +1491,6 @@ struct rte_swx_ctl_rss_info {
  *   0 on success or the following error codes otherwise:
  *   -EINVAL: Invalid argument.
  */
-__rte_experimental
 int
 rte_swx_ctl_rss_info_get(struct rte_swx_pipeline *p,
 			 uint32_t rss_obj_id,
@@ -1566,7 +1509,6 @@ rte_swx_ctl_rss_info_get(struct rte_swx_pipeline *p,
  *   0 on success or the following error codes otherwise:
  *   -EINVAL: Invalid argument.
  */
-__rte_experimental
 int
 rte_swx_ctl_pipeline_rss_key_size_read(struct rte_swx_pipeline *p,
 				       const char *rss_obj_name,
@@ -1585,7 +1527,6 @@ rte_swx_ctl_pipeline_rss_key_size_read(struct rte_swx_pipeline *p,
  *   0 on success or the following error codes otherwise:
  *   -EINVAL: Invalid argument.
  */
-__rte_experimental
 int
 rte_swx_ctl_pipeline_rss_key_read(struct rte_swx_pipeline *p,
 				  const char *rss_obj_name,
@@ -1606,7 +1547,6 @@ rte_swx_ctl_pipeline_rss_key_read(struct rte_swx_pipeline *p,
  *   0 on success or the following error codes otherwise:
  *   -EINVAL: Invalid argument.
  */
-__rte_experimental
 int
 rte_swx_ctl_pipeline_rss_key_write(struct rte_swx_pipeline *p,
 				   const char *rss_obj_name,
@@ -1620,7 +1560,6 @@ rte_swx_ctl_pipeline_rss_key_write(struct rte_swx_pipeline *p,
  *   Pipeline control handle.
  *   If ctl is NULL, no operation is performed.
  */
-__rte_experimental
 void
 rte_swx_ctl_pipeline_free(struct rte_swx_ctl_pipeline *ctl);
 
diff --git a/lib/pipeline/rte_swx_pipeline.c b/lib/pipeline/rte_swx_pipeline.c
index 8ceb1fe88d..5263fa642e 100644
--- a/lib/pipeline/rte_swx_pipeline.c
+++ b/lib/pipeline/rte_swx_pipeline.c
@@ -122,7 +122,7 @@ struct_type_field_find(struct struct_type *st, const char *name)
 	return NULL;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_struct_type_register, 20.11)
+RTE_EXPORT_SYMBOL(rte_swx_pipeline_struct_type_register)
 int
 rte_swx_pipeline_struct_type_register(struct rte_swx_pipeline *p,
 				      const char *name,
@@ -254,7 +254,7 @@ port_in_type_find(struct rte_swx_pipeline *p, const char *name)
 	return NULL;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_port_in_type_register, 20.11)
+RTE_EXPORT_SYMBOL(rte_swx_pipeline_port_in_type_register)
 int
 rte_swx_pipeline_port_in_type_register(struct rte_swx_pipeline *p,
 				       const char *name,
@@ -298,7 +298,7 @@ port_in_find(struct rte_swx_pipeline *p, uint32_t port_id)
 	return NULL;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_port_in_config, 20.11)
+RTE_EXPORT_SYMBOL(rte_swx_pipeline_port_in_config)
 int
 rte_swx_pipeline_port_in_config(struct rte_swx_pipeline *p,
 				uint32_t port_id,
@@ -417,7 +417,7 @@ port_out_type_find(struct rte_swx_pipeline *p, const char *name)
 	return NULL;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_port_out_type_register, 20.11)
+RTE_EXPORT_SYMBOL(rte_swx_pipeline_port_out_type_register)
 int
 rte_swx_pipeline_port_out_type_register(struct rte_swx_pipeline *p,
 					const char *name,
@@ -463,7 +463,7 @@ port_out_find(struct rte_swx_pipeline *p, uint32_t port_id)
 	return NULL;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_port_out_config, 20.11)
+RTE_EXPORT_SYMBOL(rte_swx_pipeline_port_out_config)
 int
 rte_swx_pipeline_port_out_config(struct rte_swx_pipeline *p,
 				 uint32_t port_id,
@@ -570,7 +570,7 @@ port_out_free(struct rte_swx_pipeline *p)
 /*
  * Packet mirroring.
  */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_mirroring_config, 20.11)
+RTE_EXPORT_SYMBOL(rte_swx_pipeline_mirroring_config)
 int
 rte_swx_pipeline_mirroring_config(struct rte_swx_pipeline *p,
 				  struct rte_swx_pipeline_mirroring_params *params)
@@ -767,7 +767,7 @@ extern_obj_mailbox_field_parse(struct rte_swx_pipeline *p,
 	return f;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_extern_type_register, 20.11)
+RTE_EXPORT_SYMBOL(rte_swx_pipeline_extern_type_register)
 int
 rte_swx_pipeline_extern_type_register(struct rte_swx_pipeline *p,
 	const char *name,
@@ -808,7 +808,7 @@ rte_swx_pipeline_extern_type_register(struct rte_swx_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_extern_type_member_func_register, 20.11)
+RTE_EXPORT_SYMBOL(rte_swx_pipeline_extern_type_member_func_register)
 int
 rte_swx_pipeline_extern_type_member_func_register(struct rte_swx_pipeline *p,
 	const char *extern_type_name,
@@ -846,7 +846,7 @@ rte_swx_pipeline_extern_type_member_func_register(struct rte_swx_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_extern_object_config, 20.11)
+RTE_EXPORT_SYMBOL(rte_swx_pipeline_extern_object_config)
 int
 rte_swx_pipeline_extern_object_config(struct rte_swx_pipeline *p,
 				      const char *extern_type_name,
@@ -1063,7 +1063,7 @@ extern_func_mailbox_field_parse(struct rte_swx_pipeline *p,
 	return f;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_extern_func_register, 20.11)
+RTE_EXPORT_SYMBOL(rte_swx_pipeline_extern_func_register)
 int
 rte_swx_pipeline_extern_func_register(struct rte_swx_pipeline *p,
 				      const char *name,
@@ -1192,7 +1192,7 @@ hash_func_find(struct rte_swx_pipeline *p, const char *name)
 	return NULL;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_hash_func_register, 22.07)
+RTE_EXPORT_SYMBOL(rte_swx_pipeline_hash_func_register)
 int
 rte_swx_pipeline_hash_func_register(struct rte_swx_pipeline *p,
 				    const char *name,
@@ -1293,7 +1293,7 @@ rss_find_by_id(struct rte_swx_pipeline *p, uint32_t rss_obj_id)
 	return NULL;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_rss_config, 23.03)
+RTE_EXPORT_SYMBOL(rte_swx_pipeline_rss_config)
 int
 rte_swx_pipeline_rss_config(struct rte_swx_pipeline *p, const char *name)
 {
@@ -1471,7 +1471,7 @@ header_field_parse(struct rte_swx_pipeline *p,
 	return f;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_packet_header_register, 20.11)
+RTE_EXPORT_SYMBOL(rte_swx_pipeline_packet_header_register)
 int
 rte_swx_pipeline_packet_header_register(struct rte_swx_pipeline *p,
 					const char *name,
@@ -1610,7 +1610,7 @@ metadata_field_parse(struct rte_swx_pipeline *p, const char *name)
 	return struct_type_field_find(p->metadata_st, &name[2]);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_packet_metadata_register, 20.11)
+RTE_EXPORT_SYMBOL(rte_swx_pipeline_packet_metadata_register)
 int
 rte_swx_pipeline_packet_metadata_register(struct rte_swx_pipeline *p,
 					  const char *struct_type_name)
@@ -7870,7 +7870,7 @@ action_does_learning(struct action *a)
 	return 0; /* FALSE */
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_action_config, 20.11)
+RTE_EXPORT_SYMBOL(rte_swx_pipeline_action_config)
 int
 rte_swx_pipeline_action_config(struct rte_swx_pipeline *p,
 			       const char *name,
@@ -8235,7 +8235,7 @@ table_find_by_id(struct rte_swx_pipeline *p, uint32_t id)
 	return NULL;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_table_type_register, 20.11)
+RTE_EXPORT_SYMBOL(rte_swx_pipeline_table_type_register)
 int
 rte_swx_pipeline_table_type_register(struct rte_swx_pipeline *p,
 				     const char *name,
@@ -8405,7 +8405,7 @@ table_match_fields_check(struct rte_swx_pipeline *p,
 	return status;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_table_config, 20.11)
+RTE_EXPORT_SYMBOL(rte_swx_pipeline_table_config)
 int
 rte_swx_pipeline_table_config(struct rte_swx_pipeline *p,
 			      const char *name,
@@ -8909,7 +8909,7 @@ selector_fields_check(struct rte_swx_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_selector_config, 21.08)
+RTE_EXPORT_SYMBOL(rte_swx_pipeline_selector_config)
 int
 rte_swx_pipeline_selector_config(struct rte_swx_pipeline *p,
 				 const char *name,
@@ -9382,7 +9382,7 @@ learner_action_learning_check(struct rte_swx_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_learner_config, 21.11)
+RTE_EXPORT_SYMBOL(rte_swx_pipeline_learner_config)
 int
 rte_swx_pipeline_learner_config(struct rte_swx_pipeline *p,
 			      const char *name,
@@ -9956,7 +9956,7 @@ regarray_find_by_id(struct rte_swx_pipeline *p, uint32_t id)
 	return NULL;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_regarray_config, 21.05)
+RTE_EXPORT_SYMBOL(rte_swx_pipeline_regarray_config)
 int
 rte_swx_pipeline_regarray_config(struct rte_swx_pipeline *p,
 			      const char *name,
@@ -10095,7 +10095,7 @@ metarray_find_by_id(struct rte_swx_pipeline *p, uint32_t id)
 	return NULL;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_metarray_config, 21.05)
+RTE_EXPORT_SYMBOL(rte_swx_pipeline_metarray_config)
 int
 rte_swx_pipeline_metarray_config(struct rte_swx_pipeline *p,
 				 const char *name,
@@ -10246,7 +10246,7 @@ static struct rte_tailq_elem rte_swx_pipeline_tailq = {
 
 EAL_REGISTER_TAILQ(rte_swx_pipeline_tailq)
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_find, 22.11)
+RTE_EXPORT_SYMBOL(rte_swx_pipeline_find)
 struct rte_swx_pipeline *
 rte_swx_pipeline_find(const char *name)
 {
@@ -10326,7 +10326,7 @@ pipeline_unregister(struct rte_swx_pipeline *p)
 	rte_mcfg_tailq_write_unlock();
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_free, 20.11)
+RTE_EXPORT_SYMBOL(rte_swx_pipeline_free)
 void
 rte_swx_pipeline_free(struct rte_swx_pipeline *p)
 {
@@ -10472,7 +10472,7 @@ hash_funcs_register(struct rte_swx_pipeline *p)
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_config, 20.11)
+RTE_EXPORT_SYMBOL(rte_swx_pipeline_config)
 int
 rte_swx_pipeline_config(struct rte_swx_pipeline **p, const char *name, int numa_node)
 {
@@ -10549,7 +10549,7 @@ rte_swx_pipeline_config(struct rte_swx_pipeline **p, const char *name, int numa_
 	return status;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_instructions_config, 20.11)
+RTE_EXPORT_SYMBOL(rte_swx_pipeline_instructions_config)
 int
 rte_swx_pipeline_instructions_config(struct rte_swx_pipeline *p,
 				     const char **instructions,
@@ -10572,7 +10572,7 @@ rte_swx_pipeline_instructions_config(struct rte_swx_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_build, 20.11)
+RTE_EXPORT_SYMBOL(rte_swx_pipeline_build)
 int
 rte_swx_pipeline_build(struct rte_swx_pipeline *p)
 {
@@ -10691,7 +10691,7 @@ rte_swx_pipeline_build(struct rte_swx_pipeline *p)
 	return status;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_run, 20.11)
+RTE_EXPORT_SYMBOL(rte_swx_pipeline_run)
 void
 rte_swx_pipeline_run(struct rte_swx_pipeline *p, uint32_t n_instructions)
 {
@@ -10701,7 +10701,7 @@ rte_swx_pipeline_run(struct rte_swx_pipeline *p, uint32_t n_instructions)
 		instr_exec(p);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_flush, 20.11)
+RTE_EXPORT_SYMBOL(rte_swx_pipeline_flush)
 void
 rte_swx_pipeline_flush(struct rte_swx_pipeline *p)
 {
@@ -10718,7 +10718,7 @@ rte_swx_pipeline_flush(struct rte_swx_pipeline *p)
 /*
  * Control.
  */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_info_get, 20.11)
+RTE_EXPORT_SYMBOL(rte_swx_ctl_pipeline_info_get)
 int
 rte_swx_ctl_pipeline_info_get(struct rte_swx_pipeline *p,
 			      struct rte_swx_ctl_pipeline_info *pipeline)
@@ -10752,7 +10752,7 @@ rte_swx_ctl_pipeline_info_get(struct rte_swx_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_numa_node_get, 20.11)
+RTE_EXPORT_SYMBOL(rte_swx_ctl_pipeline_numa_node_get)
 int
 rte_swx_ctl_pipeline_numa_node_get(struct rte_swx_pipeline *p, int *numa_node)
 {
@@ -10763,7 +10763,7 @@ rte_swx_ctl_pipeline_numa_node_get(struct rte_swx_pipeline *p, int *numa_node)
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_action_info_get, 20.11)
+RTE_EXPORT_SYMBOL(rte_swx_ctl_action_info_get)
 int
 rte_swx_ctl_action_info_get(struct rte_swx_pipeline *p,
 			    uint32_t action_id,
@@ -10783,7 +10783,7 @@ rte_swx_ctl_action_info_get(struct rte_swx_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_action_arg_info_get, 20.11)
+RTE_EXPORT_SYMBOL(rte_swx_ctl_action_arg_info_get)
 int
 rte_swx_ctl_action_arg_info_get(struct rte_swx_pipeline *p,
 				uint32_t action_id,
@@ -10808,7 +10808,7 @@ rte_swx_ctl_action_arg_info_get(struct rte_swx_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_table_info_get, 20.11)
+RTE_EXPORT_SYMBOL(rte_swx_ctl_table_info_get)
 int
 rte_swx_ctl_table_info_get(struct rte_swx_pipeline *p,
 			   uint32_t table_id,
@@ -10833,7 +10833,7 @@ rte_swx_ctl_table_info_get(struct rte_swx_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_table_match_field_info_get, 20.11)
+RTE_EXPORT_SYMBOL(rte_swx_ctl_table_match_field_info_get)
 int
 rte_swx_ctl_table_match_field_info_get(struct rte_swx_pipeline *p,
 	uint32_t table_id,
@@ -10859,7 +10859,7 @@ rte_swx_ctl_table_match_field_info_get(struct rte_swx_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_table_action_info_get, 20.11)
+RTE_EXPORT_SYMBOL(rte_swx_ctl_table_action_info_get)
 int
 rte_swx_ctl_table_action_info_get(struct rte_swx_pipeline *p,
 	uint32_t table_id,
@@ -10883,7 +10883,7 @@ rte_swx_ctl_table_action_info_get(struct rte_swx_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_table_ops_get, 20.11)
+RTE_EXPORT_SYMBOL(rte_swx_ctl_table_ops_get)
 int
 rte_swx_ctl_table_ops_get(struct rte_swx_pipeline *p,
 			  uint32_t table_id,
@@ -10910,7 +10910,7 @@ rte_swx_ctl_table_ops_get(struct rte_swx_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_selector_info_get, 21.08)
+RTE_EXPORT_SYMBOL(rte_swx_ctl_selector_info_get)
 int
 rte_swx_ctl_selector_info_get(struct rte_swx_pipeline *p,
 			      uint32_t selector_id,
@@ -10934,7 +10934,7 @@ rte_swx_ctl_selector_info_get(struct rte_swx_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_selector_group_id_field_info_get, 21.08)
+RTE_EXPORT_SYMBOL(rte_swx_ctl_selector_group_id_field_info_get)
 int
 rte_swx_ctl_selector_group_id_field_info_get(struct rte_swx_pipeline *p,
 	 uint32_t selector_id,
@@ -10957,7 +10957,7 @@ rte_swx_ctl_selector_group_id_field_info_get(struct rte_swx_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_selector_field_info_get, 21.08)
+RTE_EXPORT_SYMBOL(rte_swx_ctl_selector_field_info_get)
 int
 rte_swx_ctl_selector_field_info_get(struct rte_swx_pipeline *p,
 	 uint32_t selector_id,
@@ -10983,7 +10983,7 @@ rte_swx_ctl_selector_field_info_get(struct rte_swx_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_selector_member_id_field_info_get, 21.08)
+RTE_EXPORT_SYMBOL(rte_swx_ctl_selector_member_id_field_info_get)
 int
 rte_swx_ctl_selector_member_id_field_info_get(struct rte_swx_pipeline *p,
 	 uint32_t selector_id,
@@ -11006,7 +11006,7 @@ rte_swx_ctl_selector_member_id_field_info_get(struct rte_swx_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_learner_info_get, 21.11)
+RTE_EXPORT_SYMBOL(rte_swx_ctl_learner_info_get)
 int
 rte_swx_ctl_learner_info_get(struct rte_swx_pipeline *p,
 			     uint32_t learner_id,
@@ -11032,7 +11032,7 @@ rte_swx_ctl_learner_info_get(struct rte_swx_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_learner_match_field_info_get, 21.11)
+RTE_EXPORT_SYMBOL(rte_swx_ctl_learner_match_field_info_get)
 int
 rte_swx_ctl_learner_match_field_info_get(struct rte_swx_pipeline *p,
 					 uint32_t learner_id,
@@ -11058,7 +11058,7 @@ rte_swx_ctl_learner_match_field_info_get(struct rte_swx_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_learner_action_info_get, 21.11)
+RTE_EXPORT_SYMBOL(rte_swx_ctl_learner_action_info_get)
 int
 rte_swx_ctl_learner_action_info_get(struct rte_swx_pipeline *p,
 				    uint32_t learner_id,
@@ -11085,7 +11085,7 @@ rte_swx_ctl_learner_action_info_get(struct rte_swx_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_learner_timeout_get, 22.07)
+RTE_EXPORT_SYMBOL(rte_swx_ctl_pipeline_learner_timeout_get)
 int
 rte_swx_ctl_pipeline_learner_timeout_get(struct rte_swx_pipeline *p,
 					 uint32_t learner_id,
@@ -11105,7 +11105,7 @@ rte_swx_ctl_pipeline_learner_timeout_get(struct rte_swx_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_learner_timeout_set, 22.07)
+RTE_EXPORT_SYMBOL(rte_swx_ctl_pipeline_learner_timeout_set)
 int
 rte_swx_ctl_pipeline_learner_timeout_set(struct rte_swx_pipeline *p,
 					 uint32_t learner_id,
@@ -11137,7 +11137,7 @@ rte_swx_ctl_pipeline_learner_timeout_set(struct rte_swx_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_table_state_get, 20.11)
+RTE_EXPORT_SYMBOL(rte_swx_pipeline_table_state_get)
 int
 rte_swx_pipeline_table_state_get(struct rte_swx_pipeline *p,
 				 struct rte_swx_table_state **table_state)
@@ -11149,7 +11149,7 @@ rte_swx_pipeline_table_state_get(struct rte_swx_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_table_state_set, 20.11)
+RTE_EXPORT_SYMBOL(rte_swx_pipeline_table_state_set)
 int
 rte_swx_pipeline_table_state_set(struct rte_swx_pipeline *p,
 				 struct rte_swx_table_state *table_state)
@@ -11161,7 +11161,7 @@ rte_swx_pipeline_table_state_set(struct rte_swx_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_port_in_stats_read, 20.11)
+RTE_EXPORT_SYMBOL(rte_swx_ctl_pipeline_port_in_stats_read)
 int
 rte_swx_ctl_pipeline_port_in_stats_read(struct rte_swx_pipeline *p,
 					uint32_t port_id,
@@ -11180,7 +11180,7 @@ rte_swx_ctl_pipeline_port_in_stats_read(struct rte_swx_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_port_out_stats_read, 20.11)
+RTE_EXPORT_SYMBOL(rte_swx_ctl_pipeline_port_out_stats_read)
 int
 rte_swx_ctl_pipeline_port_out_stats_read(struct rte_swx_pipeline *p,
 					 uint32_t port_id,
@@ -11199,7 +11199,7 @@ rte_swx_ctl_pipeline_port_out_stats_read(struct rte_swx_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_table_stats_read, 21.05)
+RTE_EXPORT_SYMBOL(rte_swx_ctl_pipeline_table_stats_read)
 int
 rte_swx_ctl_pipeline_table_stats_read(struct rte_swx_pipeline *p,
 				      const char *table_name,
@@ -11227,7 +11227,7 @@ rte_swx_ctl_pipeline_table_stats_read(struct rte_swx_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_selector_stats_read, 21.08)
+RTE_EXPORT_SYMBOL(rte_swx_ctl_pipeline_selector_stats_read)
 int
 rte_swx_ctl_pipeline_selector_stats_read(struct rte_swx_pipeline *p,
 	const char *selector_name,
@@ -11247,7 +11247,7 @@ rte_swx_ctl_pipeline_selector_stats_read(struct rte_swx_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_learner_stats_read, 21.11)
+RTE_EXPORT_SYMBOL(rte_swx_ctl_pipeline_learner_stats_read)
 int
 rte_swx_ctl_pipeline_learner_stats_read(struct rte_swx_pipeline *p,
 					const char *learner_name,
@@ -11281,7 +11281,7 @@ rte_swx_ctl_pipeline_learner_stats_read(struct rte_swx_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_regarray_info_get, 21.05)
+RTE_EXPORT_SYMBOL(rte_swx_ctl_regarray_info_get)
 int
 rte_swx_ctl_regarray_info_get(struct rte_swx_pipeline *p,
 			      uint32_t regarray_id,
@@ -11301,7 +11301,7 @@ rte_swx_ctl_regarray_info_get(struct rte_swx_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_regarray_read, 21.05)
+RTE_EXPORT_SYMBOL(rte_swx_ctl_pipeline_regarray_read)
 int
 rte_swx_ctl_pipeline_regarray_read(struct rte_swx_pipeline *p,
 				   const char *regarray_name,
@@ -11323,7 +11323,7 @@ rte_swx_ctl_pipeline_regarray_read(struct rte_swx_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_regarray_write, 21.05)
+RTE_EXPORT_SYMBOL(rte_swx_ctl_pipeline_regarray_write)
 int
 rte_swx_ctl_pipeline_regarray_write(struct rte_swx_pipeline *p,
 				   const char *regarray_name,
@@ -11345,7 +11345,7 @@ rte_swx_ctl_pipeline_regarray_write(struct rte_swx_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_metarray_info_get, 21.05)
+RTE_EXPORT_SYMBOL(rte_swx_ctl_metarray_info_get)
 int
 rte_swx_ctl_metarray_info_get(struct rte_swx_pipeline *p,
 			      uint32_t metarray_id,
@@ -11365,7 +11365,7 @@ rte_swx_ctl_metarray_info_get(struct rte_swx_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_meter_profile_add, 21.05)
+RTE_EXPORT_SYMBOL(rte_swx_ctl_meter_profile_add)
 int
 rte_swx_ctl_meter_profile_add(struct rte_swx_pipeline *p,
 			      const char *name,
@@ -11398,7 +11398,7 @@ rte_swx_ctl_meter_profile_add(struct rte_swx_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_meter_profile_delete, 21.05)
+RTE_EXPORT_SYMBOL(rte_swx_ctl_meter_profile_delete)
 int
 rte_swx_ctl_meter_profile_delete(struct rte_swx_pipeline *p,
 				 const char *name)
@@ -11419,7 +11419,7 @@ rte_swx_ctl_meter_profile_delete(struct rte_swx_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_meter_reset, 21.05)
+RTE_EXPORT_SYMBOL(rte_swx_ctl_meter_reset)
 int
 rte_swx_ctl_meter_reset(struct rte_swx_pipeline *p,
 			const char *metarray_name,
@@ -11448,7 +11448,7 @@ rte_swx_ctl_meter_reset(struct rte_swx_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_meter_set, 21.05)
+RTE_EXPORT_SYMBOL(rte_swx_ctl_meter_set)
 int
 rte_swx_ctl_meter_set(struct rte_swx_pipeline *p,
 		      const char *metarray_name,
@@ -11485,7 +11485,7 @@ rte_swx_ctl_meter_set(struct rte_swx_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_meter_stats_read, 21.05)
+RTE_EXPORT_SYMBOL(rte_swx_ctl_meter_stats_read)
 int
 rte_swx_ctl_meter_stats_read(struct rte_swx_pipeline *p,
 			     const char *metarray_name,
@@ -11514,7 +11514,7 @@ rte_swx_ctl_meter_stats_read(struct rte_swx_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_mirroring_session_set, 20.11)
+RTE_EXPORT_SYMBOL(rte_swx_ctl_pipeline_mirroring_session_set)
 int
 rte_swx_ctl_pipeline_mirroring_session_set(struct rte_swx_pipeline *p,
 					   uint32_t session_id,
@@ -11721,7 +11721,7 @@ rte_swx_ctl_pipeline_table_entry_id_get(struct rte_swx_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_regarray_read_with_key, 22.11)
+RTE_EXPORT_SYMBOL(rte_swx_ctl_pipeline_regarray_read_with_key)
 int
 rte_swx_ctl_pipeline_regarray_read_with_key(struct rte_swx_pipeline *p,
 					    const char *regarray_name,
@@ -11739,7 +11739,7 @@ rte_swx_ctl_pipeline_regarray_read_with_key(struct rte_swx_pipeline *p,
 	return rte_swx_ctl_pipeline_regarray_read(p, regarray_name, entry_id, value);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_regarray_write_with_key, 22.11)
+RTE_EXPORT_SYMBOL(rte_swx_ctl_pipeline_regarray_write_with_key)
 int
 rte_swx_ctl_pipeline_regarray_write_with_key(struct rte_swx_pipeline *p,
 					     const char *regarray_name,
@@ -11757,7 +11757,7 @@ rte_swx_ctl_pipeline_regarray_write_with_key(struct rte_swx_pipeline *p,
 	return rte_swx_ctl_pipeline_regarray_write(p, regarray_name, entry_id, value);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_meter_reset_with_key, 22.11)
+RTE_EXPORT_SYMBOL(rte_swx_ctl_meter_reset_with_key)
 int
 rte_swx_ctl_meter_reset_with_key(struct rte_swx_pipeline *p,
 				 const char *metarray_name,
@@ -11774,7 +11774,7 @@ rte_swx_ctl_meter_reset_with_key(struct rte_swx_pipeline *p,
 	return rte_swx_ctl_meter_reset(p, metarray_name, entry_id);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_meter_set_with_key, 22.11)
+RTE_EXPORT_SYMBOL(rte_swx_ctl_meter_set_with_key)
 int
 rte_swx_ctl_meter_set_with_key(struct rte_swx_pipeline *p,
 			       const char *metarray_name,
@@ -11792,7 +11792,7 @@ rte_swx_ctl_meter_set_with_key(struct rte_swx_pipeline *p,
 	return rte_swx_ctl_meter_set(p, metarray_name, entry_id, profile_name);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_meter_stats_read_with_key, 22.11)
+RTE_EXPORT_SYMBOL(rte_swx_ctl_meter_stats_read_with_key)
 int
 rte_swx_ctl_meter_stats_read_with_key(struct rte_swx_pipeline *p,
 				      const char *metarray_name,
@@ -11810,7 +11810,7 @@ rte_swx_ctl_meter_stats_read_with_key(struct rte_swx_pipeline *p,
 	return rte_swx_ctl_meter_stats_read(p, metarray_name, entry_id, stats);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_rss_info_get, 23.03)
+RTE_EXPORT_SYMBOL(rte_swx_ctl_rss_info_get)
 int
 rte_swx_ctl_rss_info_get(struct rte_swx_pipeline *p,
 			 uint32_t rss_obj_id,
@@ -11831,7 +11831,7 @@ rte_swx_ctl_rss_info_get(struct rte_swx_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_rss_key_size_read, 23.03)
+RTE_EXPORT_SYMBOL(rte_swx_ctl_pipeline_rss_key_size_read)
 int
 rte_swx_ctl_pipeline_rss_key_size_read(struct rte_swx_pipeline *p,
 				       const char *rss_name,
@@ -11856,7 +11856,7 @@ rte_swx_ctl_pipeline_rss_key_size_read(struct rte_swx_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_rss_key_read, 23.03)
+RTE_EXPORT_SYMBOL(rte_swx_ctl_pipeline_rss_key_read)
 int
 rte_swx_ctl_pipeline_rss_key_read(struct rte_swx_pipeline *p,
 				  const char *rss_name,
@@ -11881,7 +11881,7 @@ rte_swx_ctl_pipeline_rss_key_read(struct rte_swx_pipeline *p,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_rss_key_write, 23.03)
+RTE_EXPORT_SYMBOL(rte_swx_ctl_pipeline_rss_key_write)
 int
 rte_swx_ctl_pipeline_rss_key_write(struct rte_swx_pipeline *p,
 				   const char *rss_name,
@@ -14583,7 +14583,7 @@ pipeline_adjust(struct rte_swx_pipeline *p, struct instruction_group_list *igl)
 	instr_jmp_resolve(p->instructions, p->instruction_data, p->n_instructions);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_codegen, 22.11)
+RTE_EXPORT_SYMBOL(rte_swx_pipeline_codegen)
 int
 rte_swx_pipeline_codegen(FILE *spec_file,
 			 FILE *code_file,
@@ -14677,7 +14677,7 @@ rte_swx_pipeline_codegen(FILE *spec_file,
 	return status;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_build_from_lib, 22.11)
+RTE_EXPORT_SYMBOL(rte_swx_pipeline_build_from_lib)
 int
 rte_swx_pipeline_build_from_lib(struct rte_swx_pipeline **pipeline,
 				const char *name,
diff --git a/lib/pipeline/rte_swx_pipeline.h b/lib/pipeline/rte_swx_pipeline.h
index 882bd4bf6f..1eccba4753 100644
--- a/lib/pipeline/rte_swx_pipeline.h
+++ b/lib/pipeline/rte_swx_pipeline.h
@@ -12,8 +12,6 @@
 #include <stdint.h>
 #include <stdio.h>
 
-#include <rte_compat.h>
-
 #include "rte_swx_port.h"
 #include "rte_swx_table.h"
 #include "rte_swx_extern.h"
@@ -52,7 +50,6 @@ struct rte_swx_pipeline;
  * @return
  *   Valid pipeline handle if found or NULL otherwise.
  */
-__rte_experimental
 struct rte_swx_pipeline *
 rte_swx_pipeline_find(const char *name);
 
@@ -72,7 +69,6 @@ rte_swx_pipeline_find(const char *name);
  *   -ENOMEM: Not enough space/cannot allocate memory;
  *   -EEXIST: Pipeline with this name already exists.
  */
-__rte_experimental
 int
 rte_swx_pipeline_config(struct rte_swx_pipeline **p,
 			const char *name,
@@ -97,7 +93,6 @@ rte_swx_pipeline_config(struct rte_swx_pipeline **p,
  *   -ENOMEM: Not enough space/cannot allocate memory;
  *   -EEXIST: Input port type with this name already exists.
  */
-__rte_experimental
 int
 rte_swx_pipeline_port_in_type_register(struct rte_swx_pipeline *p,
 				       const char *name,
@@ -120,7 +115,6 @@ rte_swx_pipeline_port_in_type_register(struct rte_swx_pipeline *p,
  *   -ENOMEM: Not enough space/cannot allocate memory;
  *   -ENODEV: Input port object creation error.
  */
-__rte_experimental
 int
 rte_swx_pipeline_port_in_config(struct rte_swx_pipeline *p,
 				uint32_t port_id,
@@ -146,7 +140,6 @@ rte_swx_pipeline_port_in_config(struct rte_swx_pipeline *p,
  *   -ENOMEM: Not enough space/cannot allocate memory;
  *   -EEXIST: Output port type with this name already exists.
  */
-__rte_experimental
 int
 rte_swx_pipeline_port_out_type_register(struct rte_swx_pipeline *p,
 					const char *name,
@@ -169,7 +162,6 @@ rte_swx_pipeline_port_out_type_register(struct rte_swx_pipeline *p,
  *   -ENOMEM: Not enough space/cannot allocate memory;
  *   -ENODEV: Output port object creation error.
  */
-__rte_experimental
 int
 rte_swx_pipeline_port_out_config(struct rte_swx_pipeline *p,
 				 uint32_t port_id,
@@ -211,7 +203,6 @@ struct rte_swx_pipeline_mirroring_params {
  *   -ENOMEM: Not enough memory;
  *   -EEXIST: Pipeline was already built successfully.
  */
-__rte_experimental
 int
 rte_swx_pipeline_mirroring_config(struct rte_swx_pipeline *p,
 				  struct rte_swx_pipeline_mirroring_params *params);
@@ -242,7 +233,6 @@ rte_swx_pipeline_mirroring_config(struct rte_swx_pipeline *p,
  *   -ENOMEM: Not enough space/cannot allocate memory;
  *   -EEXIST: Extern type with this name already exists.
  */
-__rte_experimental
 int
 rte_swx_pipeline_extern_type_register(struct rte_swx_pipeline *p,
 	const char *name,
@@ -268,7 +258,6 @@ rte_swx_pipeline_extern_type_register(struct rte_swx_pipeline *p,
  *   -EEXIST: Member function with this name already exists for this type;
  *   -ENOSPC: Maximum number of member functions reached for this type.
  */
-__rte_experimental
 int
 rte_swx_pipeline_extern_type_member_func_register(struct rte_swx_pipeline *p,
 	const char *extern_type_name,
@@ -295,7 +284,6 @@ rte_swx_pipeline_extern_type_member_func_register(struct rte_swx_pipeline *p,
  *   -EEXIST: Extern object with this name already exists;
  *   -ENODEV: Extern object constructor error.
  */
-__rte_experimental
 int
 rte_swx_pipeline_extern_object_config(struct rte_swx_pipeline *p,
 				      const char *extern_type_name,
@@ -321,7 +309,6 @@ rte_swx_pipeline_extern_object_config(struct rte_swx_pipeline *p,
  *   -ENOMEM: Not enough space/cannot allocate memory;
  *   -EEXIST: Extern function with this name already exists.
  */
-__rte_experimental
 int
 rte_swx_pipeline_extern_func_register(struct rte_swx_pipeline *p,
 				      const char *name,
@@ -346,7 +333,6 @@ rte_swx_pipeline_extern_func_register(struct rte_swx_pipeline *p,
  *   -ENOMEM: Not enough space/cannot allocate memory;
  *   -EEXIST: Hash function with this name already exists.
  */
-__rte_experimental
 int
 rte_swx_pipeline_hash_func_register(struct rte_swx_pipeline *p,
 				    const char *name,
@@ -369,7 +355,6 @@ rte_swx_pipeline_hash_func_register(struct rte_swx_pipeline *p,
  *   -ENOMEM: Not enough space/cannot allocate memory;
  *   -EEXIST: RSS object with this name already exists.
  */
-__rte_experimental
 int
 rte_swx_pipeline_rss_config(struct rte_swx_pipeline *p,
 			    const char *name);
@@ -425,7 +410,6 @@ struct rte_swx_field_params {
  *   -ENOMEM: Not enough space/cannot allocate memory;
  *   -EEXIST: Struct type with this name already exists.
  */
-__rte_experimental
 int
 rte_swx_pipeline_struct_type_register(struct rte_swx_pipeline *p,
 				      const char *name,
@@ -449,7 +433,6 @@ rte_swx_pipeline_struct_type_register(struct rte_swx_pipeline *p,
  *   -EEXIST: Header with this name already exists;
  *   -ENOSPC: Maximum number of headers reached for the pipeline.
  */
-__rte_experimental
 int
 rte_swx_pipeline_packet_header_register(struct rte_swx_pipeline *p,
 					const char *name,
@@ -466,7 +449,6 @@ rte_swx_pipeline_packet_header_register(struct rte_swx_pipeline *p,
  *   0 on success or the following error codes otherwise:
  *   -EINVAL: Invalid argument.
  */
-__rte_experimental
 int
 rte_swx_pipeline_packet_metadata_register(struct rte_swx_pipeline *p,
 					  const char *struct_type_name);
@@ -601,7 +583,6 @@ rte_swx_pipeline_packet_metadata_register(struct rte_swx_pipeline *p,
  *   -ENOMEM: Not enough space/cannot allocate memory;
  *   -EEXIST: Action with this name already exists.
  */
-__rte_experimental
 int
 rte_swx_pipeline_action_config(struct rte_swx_pipeline *p,
 			       const char *name,
@@ -630,7 +611,6 @@ rte_swx_pipeline_action_config(struct rte_swx_pipeline *p,
  *   -ENOMEM: Not enough space/cannot allocate memory;
  *   -EEXIST: Table type with this name already exists.
  */
-__rte_experimental
 int
 rte_swx_pipeline_table_type_register(struct rte_swx_pipeline *p,
 				     const char *name,
@@ -739,7 +719,6 @@ struct rte_swx_pipeline_table_params {
  *   -EEXIST: Table with this name already exists;
  *   -ENODEV: Table creation error.
  */
-__rte_experimental
 int
 rte_swx_pipeline_table_config(struct rte_swx_pipeline *p,
 			      const char *name,
@@ -793,7 +772,6 @@ struct rte_swx_pipeline_selector_params {
  *   -EEXIST: Selector table with this name already exists;
  *   -ENODEV: Selector table creation error.
  */
-__rte_experimental
 int
 rte_swx_pipeline_selector_config(struct rte_swx_pipeline *p,
 				 const char *name,
@@ -881,7 +859,6 @@ struct rte_swx_pipeline_learner_params {
  *   -EEXIST: Learner table with this name already exists;
  *   -ENODEV: Learner table creation error.
  */
-__rte_experimental
 int
 rte_swx_pipeline_learner_config(struct rte_swx_pipeline *p,
 				const char *name,
@@ -907,7 +884,6 @@ rte_swx_pipeline_learner_config(struct rte_swx_pipeline *p,
  *   -ENOMEM: Not enough space/cannot allocate memory;
  *   -EEXIST: Register array with this name already exists.
  */
-__rte_experimental
 int
 rte_swx_pipeline_regarray_config(struct rte_swx_pipeline *p,
 				 const char *name,
@@ -930,7 +906,6 @@ rte_swx_pipeline_regarray_config(struct rte_swx_pipeline *p,
  *   -ENOMEM: Not enough space/cannot allocate memory;
  *   -EEXIST: Meter array with this name already exists.
  */
-__rte_experimental
 int
 rte_swx_pipeline_metarray_config(struct rte_swx_pipeline *p,
 				 const char *name,
@@ -950,7 +925,6 @@ rte_swx_pipeline_metarray_config(struct rte_swx_pipeline *p,
  *   -EINVAL: Invalid argument;
  *   -ENOMEM: Not enough space/cannot allocate memory.
  */
-__rte_experimental
 int
 rte_swx_pipeline_instructions_config(struct rte_swx_pipeline *p,
 				     const char **instructions,
@@ -971,7 +945,6 @@ rte_swx_pipeline_instructions_config(struct rte_swx_pipeline *p,
  *   -ENOMEM: Not enough space/cannot allocate memory;
  *   -EEXIST: Pipeline was already built successfully.
  */
-__rte_experimental
 int
 rte_swx_pipeline_build(struct rte_swx_pipeline *p);
 
@@ -993,7 +966,6 @@ rte_swx_pipeline_build(struct rte_swx_pipeline *p);
  *   -ENOMEM: Not enough space/cannot allocate memory;
  *   -EEXIST: Resource with the same name already exists.
  */
-__rte_experimental
 int
 rte_swx_pipeline_codegen(FILE *spec_file,
 			 FILE *code_file,
@@ -1026,7 +998,6 @@ rte_swx_pipeline_codegen(FILE *spec_file,
  *   -EEXIST: Pipeline with this name already exists;
  *   -ENODEV: Extern object or table creation error.
  */
-__rte_experimental
 int
 rte_swx_pipeline_build_from_lib(struct rte_swx_pipeline **p,
 				const char *name,
@@ -1042,7 +1013,6 @@ rte_swx_pipeline_build_from_lib(struct rte_swx_pipeline **p,
  * @param[in] n_instructions
  *   Number of instructions to execute.
  */
-__rte_experimental
 void
 rte_swx_pipeline_run(struct rte_swx_pipeline *p,
 		     uint32_t n_instructions);
@@ -1056,7 +1026,6 @@ rte_swx_pipeline_run(struct rte_swx_pipeline *p,
  *   Pipeline handle.
  *   If p is NULL, no operation is performed.
  */
-__rte_experimental
 void
 rte_swx_pipeline_flush(struct rte_swx_pipeline *p);
 
@@ -1066,7 +1035,6 @@ rte_swx_pipeline_flush(struct rte_swx_pipeline *p);
  * @param[in] p
  *   Pipeline handle.
  */
-__rte_experimental
 void
 rte_swx_pipeline_free(struct rte_swx_pipeline *p);
 
-- 
2.53.0

