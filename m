Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E57CD5BD5
	for <dpdk-dev@archiver.kernel.org>; Thu, 28 May 2026 21:38:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5DF6040666;
	Thu, 28 May 2026 23:38:25 +0200 (CEST)
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com
 [74.125.224.49]) by mails.dpdk.org (Postfix) with ESMTP id B141D4003C
 for <dev@dpdk.org>; Thu, 28 May 2026 23:38:23 +0200 (CEST)
Received: by mail-yx1-f49.google.com with SMTP id
 956f58d0204a3-65c24be9e4bso13838588d50.1
 for <dev@dpdk.org>; Thu, 28 May 2026 14:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780004303;
 x=1780609103; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LddsqSb8uzxVcOxwA6L4f3KX1QREW+ODUUOzbeRAikM=;
 b=eeelSytF1KAJ5y36cfv9VSPf+YH7b4qfumHrq4EL7BHiNMmcJxZH1R42MrzHG9wGn/
 Qoxmqk0d0pDxIkpZSwiEImnkLvJ5Uayb4LbLYnv7zD9+Zn8Soe6bt2fYkU4UBu2FT9nK
 x8mgpCS53AAl2eSudinaUA8W7sGImmnTgs5jNsPygLnvFwGukUiwWU/MjSQiBHaz3cGJ
 Jz1bvHhkzsLycerEDCElIErdSMcYTkvNyCDiinJn2mCZaw9vJRNUC+YEWo5eXXEJ05fG
 BDj9k8dTpi6H8M5twgWiNNfHIf1qfVFOfXxCbXK3EV3wuiztWYoDFxkFmFGBl3D/zQWh
 HkTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780004303; x=1780609103;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LddsqSb8uzxVcOxwA6L4f3KX1QREW+ODUUOzbeRAikM=;
 b=PSRDdn5u1l8/Ms9JvDPt/VqefKDy33Q3v04EuGnzXME9k1lZgqu0fAHRFfZL3Y6Cwz
 JKlLSD529buSX+QZkaBy3WOIFEe52ef4ike//GgMFadNPnOMgx4GCSneZpaZqX6Wa7q1
 ZhGgWOFBU5MlLVLYOEu07hHbFr19yu2ZSOOTYUTGmJ6smt8SjZCIy7YBKFTe/RCKm4CR
 5KHTWEZv0ZODf0HmK+hq9ZqGQqD7QUV7ZhqOJsoSRf3DPAqyGQRzT7IayyGbemKuWvc8
 0N92IWn+//pjI9/OO0dEks7a0VdEVfIxXTaY8E+/cxI5yNqwcKh73bhITPe6wIDY19Yc
 G/Kg==
X-Gm-Message-State: AOJu0Yy1biW8tK7RH3eP0nJp5eRGHXfVw1JrRjHRhH7dX3rSrq0Es/ZW
 UbhJhUmM0t0VEbxW5QCRrisPcx1/bExfoRiB9FPnBFL6F4+rXj5by0lZJ8JQrSdQvNiR05s7LfC
 fKF2m
X-Gm-Gg: Acq92OEu5fplVTatLnfB2UMIqk+6stPtbkI7VmB/k9g6HZt42GKB4e/moGhxGYS4v8O
 xXUG+GKFxWzLTUNy8a3D3OD7ro1CbCrd4CQq8BuXAFChzfDU+4E94MKclK9cpJNvfgmLIGnHulo
 lGEuM+OvRcYXUiGWSjcJWtgGofmTpzLE+r8War7aYl081ffokjGZRsOV4SYmml3Q9pjghmHZjd7
 7tUg2KljR0RDhbQJ1wroIDmmoagkcEMdswAy9H6PwMSvhC5DTS5EEmBGMzVRjST6seNDbzezEDk
 bYqAohJZYDxY7swp/E6qwLe8iBlpJoMBLvLKA2n53lA+9IeqbDJZPc894I/o43WSLdffnjqkRci
 P1k+i/pO2BOrlZRqSRUtTDp77u+d5i0zVx3NCj5JSIjXRPZpK+nrqpLykgRMKnYP+n2osLRWyN2
 wdUE0ZmDWPT4E+U0Kb88xpsE2O5D0JdtW5hvou5W8MUJxIwxhSe81hGr9d++GF5XbXmbzN0Pcss
 oWq3fTahd4=
X-Received: by 2002:a05:690e:4809:b0:650:3952:3d2a with SMTP id
 956f58d0204a3-6604e54e025mr402728d50.8.1780004302920; 
 Thu, 28 May 2026 14:38:22 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-6604e12ea23sm208079d50.0.2026.05.28.14.38.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 14:38:22 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC 3/8] net/i40e: deprecate legacy flow filter API
Date: Thu, 28 May 2026 14:37:15 -0700
Message-ID: <20260528213816.562910-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260528213816.562910-1-stephen@networkplumber.org>
References: <20260528213816.562910-1-stephen@networkplumber.org>
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

The i40e PMD-private filter configuration API in rte_pmd_i40e.h predates
the rte_flow API and duplicates functionality now expressed as rte_flow
rules. Mark the legacy entry points as deprecated so they can be removed
in DPDK 26.11.

The two functions taking public rte_eth_fdir_* types
(rte_pmd_i40e_get_fdir_info, rte_pmd_i40e_get_fdir_stats) are already
marked __rte_experimental and will be removed alongside the ethdev
fdir struct family in 26.11; they need no separate deprecation notice.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/deprecation.rst  |  3 +
 drivers/net/intel/i40e/rte_pmd_i40e.h | 80 ++++++++++++++++++++++++++-
 2 files changed, 82 insertions(+), 1 deletion(-)

diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
index 17f90a6352..d152e76fdc 100644
--- a/doc/guides/rel_notes/deprecation.rst
+++ b/doc/guides/rel_notes/deprecation.rst
@@ -158,3 +158,6 @@ Deprecation Notices
 * net/iavf: The dynamic mbuf field used to detect LLDP packets on the
   transmit path in the iavf PMD will be removed in a future release.
   After removal, only packet type-based detection will be supported.
+
+* net/i40e: The legacy filter configuration API in ``rte_pmd_i40e.h``,
+  superseded by the ``rte_flow`` API, will be removed in DPDK 26.11.
diff --git a/drivers/net/intel/i40e/rte_pmd_i40e.h b/drivers/net/intel/i40e/rte_pmd_i40e.h
index 5af7e2330f..5dcca91264 100644
--- a/drivers/net/intel/i40e/rte_pmd_i40e.h
+++ b/drivers/net/intel/i40e/rte_pmd_i40e.h
@@ -229,6 +229,9 @@ struct rte_pmd_i40e_queue_regions {
 };
 
 /**
+ * @deprecated
+ * Superseded by the rte_flow API; will be removed in DPDK 26.11.
+ *
  * Behavior will be taken if raw packet template is matched.
  */
 enum rte_pmd_i40e_pkt_template_behavior {
@@ -238,7 +241,10 @@ enum rte_pmd_i40e_pkt_template_behavior {
 };
 
 /**
- * Flow director report status
+ * @deprecated
+ * Superseded by the rte_flow API; will be removed in DPDK 26.11.
+ *
+ * Flow director report status.
  * It defines what will be reported if raw packet template is matched.
  */
 enum rte_pmd_i40e_pkt_template_status {
@@ -253,6 +259,9 @@ enum rte_pmd_i40e_pkt_template_status {
 };
 
 /**
+ * @deprecated
+ * Superseded by the rte_flow API; will be removed in DPDK 26.11.
+ *
  * A structure used to define an action when raw packet template is matched.
  */
 struct rte_pmd_i40e_pkt_template_action {
@@ -271,6 +280,9 @@ struct rte_pmd_i40e_pkt_template_action {
 };
 
 /**
+ * @deprecated
+ * Superseded by the rte_flow API; will be removed in DPDK 26.11.
+ *
  * A structure used to define the input for raw packet template.
  */
 struct rte_pmd_i40e_pkt_template_input {
@@ -283,6 +295,9 @@ struct rte_pmd_i40e_pkt_template_input {
 };
 
 /**
+ * @deprecated
+ * Superseded by the rte_flow API; will be removed in DPDK 26.11.
+ *
  * A structure used to define the configuration parameters
  * for raw packet template.
  */
@@ -295,6 +310,10 @@ struct rte_pmd_i40e_pkt_template_conf {
 	uint32_t soft_id;
 };
 
+/**
+ * @deprecated
+ * Superseded by the rte_flow API; will be removed in DPDK 26.11.
+ */
 enum rte_pmd_i40e_inset_type {
 	INSET_NONE = 0,
 	INSET_HASH,
@@ -307,6 +326,10 @@ struct  rte_pmd_i40e_inset_mask {
 	uint16_t mask;
 };
 
+/**
+ * @deprecated
+ * Superseded by the rte_flow API; will be removed in DPDK 26.11.
+ */
 struct rte_pmd_i40e_inset {
 	uint64_t inset;
 	struct rte_pmd_i40e_inset_mask mask[2];
@@ -326,7 +349,12 @@ struct rte_pmd_i40e_inset {
  *   - (-ENODEV) if *port* invalid.
  *   - (-EINVAL) if *conf* invalid.
  *   - (-ENOTSUP) not supported by firmware.
+ *
+ * @deprecated
+ * This function is superseded by the rte_flow API and will be removed
+ * in DPDK 26.11.
  */
+__rte_deprecated
 int rte_pmd_i40e_flow_add_del_packet_template(
 			uint16_t port,
 			const struct rte_pmd_i40e_pkt_template_conf *conf,
@@ -865,6 +893,10 @@ int rte_pmd_i40e_add_vf_mac_addr(uint16_t port, uint16_t vf_id,
 #define RTE_PMD_I40E_PCTYPE_MAX		64
 #define RTE_PMD_I40E_FLOW_TYPE_MAX	64
 
+/**
+ * @deprecated
+ * Superseded by the rte_flow API; will be removed in DPDK 26.11.
+ */
 struct rte_pmd_i40e_flow_type_mapping {
 	uint16_t flow_type; /**< software defined flow type*/
 	uint64_t pctype;    /**< hardware defined pctype */
@@ -886,7 +918,12 @@ struct rte_pmd_i40e_flow_type_mapping {
  *	keep other PCTYPEs mapping unchanged.
  *    -(!0) overwrite referred PCTYPE mapping,
  *	set other PCTYPEs maps to PCTYPE_INVALID.
+ *
+ * @deprecated
+ * This function is superseded by the rte_flow API and will be removed
+ * in DPDK 26.11.
  */
+__rte_deprecated
 int rte_pmd_i40e_flow_type_mapping_update(
 			uint16_t port,
 			struct rte_pmd_i40e_flow_type_mapping *mapping_items,
@@ -903,7 +940,12 @@ int rte_pmd_i40e_flow_type_mapping_update(
  *    the base address of the array to store returned items.
  *    array should be allocated by caller with minimum size of
  *    RTE_PMD_I40E_FLOW_TYPE_MAX items
+ *
+ * @deprecated
+ * This function is superseded by the rte_flow API and will be removed
+ * in DPDK 26.11.
  */
+__rte_deprecated
 int rte_pmd_i40e_flow_type_mapping_get(
 			uint16_t port,
 			struct rte_pmd_i40e_flow_type_mapping *mapping_items);
@@ -914,7 +956,12 @@ int rte_pmd_i40e_flow_type_mapping_get(
  *
  * @param port
  *    pointer to port identifier of the device
+ *
+ * @deprecated
+ * This function is superseded by the rte_flow API and will be removed
+ * in DPDK 26.11.
  */
+__rte_deprecated
 int rte_pmd_i40e_flow_type_mapping_reset(uint16_t port);
 
 /**
@@ -946,6 +993,12 @@ int rte_pmd_i40e_query_vfid_by_mac(uint16_t port,
 int rte_pmd_i40e_rss_queue_region_conf(uint16_t port_id,
 			enum rte_pmd_i40e_queue_region_op op_type, void *arg);
 
+/**
+ * @deprecated
+ * This function is superseded by the rte_flow API and will be removed
+ * in DPDK 26.11.
+ */
+__rte_deprecated
 int rte_pmd_i40e_cfg_hash_inset(uint16_t port,
 				uint64_t pctype, uint64_t inset);
 
@@ -965,7 +1018,12 @@ int rte_pmd_i40e_cfg_hash_inset(uint16_t port,
  *   - (-ENODEV) if *port* invalid.
  *   - (-EINVAL) if bad parameter.
  *   - (-ENOTSUP) if operation not supported.
+ *
+ * @deprecated
+ * This function is superseded by the rte_flow API and will be removed
+ * in DPDK 26.11.
  */
+__rte_deprecated
 int rte_pmd_i40e_inset_get(uint16_t port, uint8_t pctype,
 			   struct rte_pmd_i40e_inset *inset,
 			   enum rte_pmd_i40e_inset_type inset_type);
@@ -986,7 +1044,12 @@ int rte_pmd_i40e_inset_get(uint16_t port, uint8_t pctype,
  *   - (-ENODEV) if *port* invalid.
  *   - (-EINVAL) if bad parameter.
  *   - (-ENOTSUP) if operation not supported.
+ *
+ * @deprecated
+ * This function is superseded by the rte_flow API and will be removed
+ * in DPDK 26.11.
  */
+__rte_deprecated
 int rte_pmd_i40e_inset_set(uint16_t port, uint8_t pctype,
 			   struct rte_pmd_i40e_inset *inset,
 			   enum rte_pmd_i40e_inset_type inset_type);
@@ -1001,7 +1064,12 @@ int rte_pmd_i40e_inset_set(uint16_t port, uint8_t pctype,
  * @return
  *   - (1) if set.
  *   - (0) if cleared.
+ *
+ * @deprecated
+ * This function is superseded by the rte_flow API and will be removed
+ * in DPDK 26.11.
  */
+__rte_deprecated
 static inline int
 rte_pmd_i40e_inset_field_get(uint64_t inset, uint8_t field_idx)
 {
@@ -1027,7 +1095,12 @@ rte_pmd_i40e_inset_field_get(uint64_t inset, uint8_t field_idx)
  * @return
  *   - (-1) if failed.
  *   - (0) if success.
+ *
+ * @deprecated
+ * This function is superseded by the rte_flow API and will be removed
+ * in DPDK 26.11.
  */
+__rte_deprecated
 static inline int
 rte_pmd_i40e_inset_field_set(uint64_t *inset, uint8_t field_idx)
 {
@@ -1052,7 +1125,12 @@ rte_pmd_i40e_inset_field_set(uint64_t *inset, uint8_t field_idx)
  * @return
  *   - (-1) if failed.
  *   - (0) if success.
+ *
+ * @deprecated
+ * This function is superseded by the rte_flow API and will be removed
+ * in DPDK 26.11.
  */
+__rte_deprecated
 static inline int
 rte_pmd_i40e_inset_field_clear(uint64_t *inset, uint8_t field_idx)
 {
-- 
2.53.0

