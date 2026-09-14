Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 277E8C88E50
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 05:53:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 78ACA41060;
	Mon, 14 Sep 2026 07:51:46 +0200 (CEST)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45]) by mails.dpdk.org (Postfix) with ESMTP id 7590C40EDC
 for <dev@dpdk.org>; Mon, 14 Sep 2026 07:51:43 +0200 (CEST)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-398e9698a70so3005409a91.0
 for <dev@dpdk.org>; Sun, 13 Sep 2026 22:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789365102;
 x=1789969902; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uDZhFynSfhLkAONLVWqGEFej7fbq4RxVGv328oBJaMA=;
 b=pYQGKKaIVRgMU+uOCPT+Vi5WToeoGsAlnvFgxPBH7yHEDgFsr8XWfZIZ05TQTvcdJm
 3DUJLJLjaXO+MwoYRsSyNLB3hVo97xHdsjtBimnjO2K2Ui3tMKBwDp52NG2Fy3w7Fm41
 e/9jk4nx/W2T2yY5vZawGsV3pi8ls8Zo1GVahbVrv0RnPIb9gsRkggrv5aCe9YbbH8bg
 DAe9CCR07tojYrDK94llt9z69JD/x+KEahUZNusixmGa8X8P+7Hi5fmOUvn9ws776d5I
 QXSFH93SVi2E9+05yQnWr/MirtxsfdPeCopZavcVSmuXWG4/XyLK66WP+CXPCppq6zsr
 s2xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789365102; x=1789969902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uDZhFynSfhLkAONLVWqGEFej7fbq4RxVGv328oBJaMA=;
 b=mt2Uqs2aLYaYBP81TccCXtYGONszHVq1qZToNE5rH9+sYyebY1IaJXFpTk+I1i2Hb8
 MqF75Ivd6UUqDOwWbf1tZPMgFlDE3/6tbfTtdedHa86sVd4jObD0JQ3XWVgKWsnfgriG
 5In7aDnNMETJtiQQBeQVXX7zZxJ2I4yonlXwF190tGn4TA1Fvdw0nFgJuYpPdUA1xLbz
 vLBsSpr0RUetlJTD3mksTb+YdjuCT2NeS03jGNUT4UuxTTxwaQN0LzeDoM0ONZugYH4I
 hGCPrUUa4bT9jY5UwVJBts9EvIxFFwIdeAV+NS+sPs89/f6JaECFM3MRJOG3Mv6kw6JN
 7Q8g==
X-Gm-Message-State: AFuF++kra8G0AxrTbI5U1njyefsc7O/saxtcSfM+D+NyJYVYiuTUHySM
 HM12mH5+Qsw2GXce6uwsNHXKaVM3AWXuk//mU5SX3uqRTsrbmaTtnCSsT4J9HMpuqoPX5VqG+Dd
 7mKNu
X-Gm-Gg: AYBFou1sN80UqtzHdqtl39lgrMp/rRyGqyz8pjZ7hFcbqbNq5l+q4G+ZVQZIFbloNR5
 AOnQDRErInwcSstFq0vLD6YG0MXvVQ7veZC1RlZKYbiGK4uW28LrhiRdh+EpYeDBZRE6q3UMqX6
 P71d6QorLvMDG+zh6FmH8055WTpEpaRJFxx9Zz3en9xr6jRHctDetKKBhcTA3eXkH4t/rJjPaS9
 UQ4PGITtFBrxuw3mu+I5RTtxPyiy63vU2PDbB3WwUcIYiIhgFjY5SgW2ECrZB+BtUtBLt4IK/0p
 KMVfjyH7zPv3RMfSSa6mOR5fUfqzLp0k8tu6g8bJaohwy7CcUuKq6BjWVFR9iYIu1yoH9WvZ8Ou
 ciot/KnnLtOvqlBw7BF/tvUsD1zxLxQgP9CNtImi76VThcv8iX8XCvDQk5g2+HQBRycLDDAT2Ff
 0mzMM6wfi2DWpqdPuwb7CWjA+rjEHAzLsL0SOuvvUbg9tZqrGy9/spI+PZQZv50vSL0qw4iww9Y
 eyxw86D5Fa+ctXQAkdN6TCYeNG433ipzR7A+47L6h4OZCA0
X-Received: by 2002:a17:90b:5886:b0:39d:f253:ed66 with SMTP id
 98e67ed59e1d1-39df253ee28mr153106a91.22.1789365102585; 
 Sun, 13 Sep 2026 22:51:42 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d95864b4fsm19794492a91.15.2026.09.13.22.51.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 22:51:42 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Tirthendu Sarkar <tirthendu.sarkar@intel.com>
Subject: [PATCH 41/62] event/dlb2: use kvargs numeric helpers
Date: Sun, 13 Sep 2026 22:47:12 -0700
Message-ID: <20260914054912.755403-42-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914054912.755403-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
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

dlb2_string_to_int() returns -errno on failure, but errno is only
meaningful when strtol() actually failed; on a plain parse failure it
returns -0, that is success, with an uninitialised result. The end
pointer is also only checked after the errno test, so "abc" reaches the
range check with a value of zero.

All thirteen dlb2 devargs handlers go through this one function, so
converting it covers them all.

set_numa_node() is replaced by rte_kvargs_handle_socket_id(). It used
"> RTE_MAX_NUMA_NODES", which is off by one and accepted a socket id one
past the end of the range, so that value is now rejected. The helper
also rejects a negative socket id other than -1, which is SOCKET_ID_ANY.

The four boolean arguments use rte_kvargs_handle_bool() and their local
handlers go away: vector_opts_enable, default_ldb_port_allocation,
enable_cq_weight and use_default_hl.

Beware that this changes what the first three accept. They only ever
tested for a leading 'y' or 'Y', so "=1" meant false, and any typo
silently meant false as well. They now take the usual boolean
spellings, "=1" means true, and anything else is rejected. The
documented "=<y/Y>" form still works; the examples are updated to the
more usual "=<0|1>". use_default_hl already treated '0' and 'n' as
false and everything else as true, so only the rejection of garbage
is new there.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/eventdevs/dlb2.rst |   4 +-
 drivers/event/dlb2/dlb2.c     | 127 ++++------------------------------
 2 files changed, 14 insertions(+), 117 deletions(-)

diff --git a/doc/guides/eventdevs/dlb2.rst b/doc/guides/eventdevs/dlb2.rst
index 06841ba312..0966746f4e 100644
--- a/doc/guides/eventdevs/dlb2.rst
+++ b/doc/guides/eventdevs/dlb2.rst
@@ -380,7 +380,7 @@ follows
 
     .. code-block:: console
 
-       --allow ea:00.0,vector_opts_enabled=<y/Y>
+       --allow ea:00.0,vector_opts_enabled=<0|1>
 
 Maximum CQ Depth
 ~~~~~~~~~~~~~~~~
@@ -459,7 +459,7 @@ Example command to enable QE Weight feature:
 
     .. code-block:: console
 
-       --allow ea:00.0,enable_cq_weight=<y/Y>
+       --allow ea:00.0,enable_cq_weight=<0|1>
 
 Credit Handling Scenario Improvements
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/drivers/event/dlb2/dlb2.c b/drivers/event/dlb2/dlb2.c
index 084875f1c8..b3eceab094 100644
--- a/drivers/event/dlb2/dlb2.c
+++ b/drivers/event/dlb2/dlb2.c
@@ -288,24 +288,15 @@ dlb2_hw_query_resources(struct dlb2_eventdev *dlb2)
 	return 0;
 }
 
-#define DLB2_BASE_10 10
-
 static int
 dlb2_string_to_int(int *result, const char *str)
 {
-	long ret;
-	char *endptr;
+	int64_t ret;
 
-	if (str == NULL || result == NULL)
+	if (result == NULL)
 		return -EINVAL;
 
-	errno = 0;
-	ret = strtol(str, &endptr, DLB2_BASE_10);
-	if (errno)
-		return -errno;
-
-	/* long int and int may be different width for some architectures */
-	if (ret < INT_MIN || ret > INT_MAX || endptr == str)
+	if (rte_kvargs_to_int(str, INT_MIN, INT_MAX, &ret) < 0)
 		return -EINVAL;
 
 	*result = ret;
@@ -329,22 +320,6 @@ set_producer_coremask(const char *key __rte_unused,
 	return 0;
 }
 
-static int
-set_numa_node(const char *key __rte_unused, const char *value, void *opaque)
-{
-	int *socket_id = opaque;
-	int ret;
-
-	ret = dlb2_string_to_int(socket_id, value);
-	if (ret < 0)
-		return ret;
-
-	if (*socket_id > RTE_MAX_NUMA_NODES)
-		return -EINVAL;
-	return 0;
-}
-
-
 static int
 set_max_cq_depth(const char *key __rte_unused,
 		 const char *value,
@@ -667,84 +642,6 @@ set_default_depth_thresh(const char *key __rte_unused,
 	return 0;
 }
 
-static int
-set_vector_opts_enab(const char *key __rte_unused,
-	const char *value,
-	void *opaque)
-{
-	bool *dlb2_vector_opts_enabled = opaque;
-
-	if (value == NULL || opaque == NULL) {
-		DLB2_LOG_ERR("NULL pointer");
-		return -EINVAL;
-	}
-
-	if ((*value == 'y') || (*value == 'Y'))
-		*dlb2_vector_opts_enabled = true;
-	else
-		*dlb2_vector_opts_enabled = false;
-
-	return 0;
-}
-
-static int
-set_default_ldb_port_allocation(const char *key __rte_unused,
-		      const char *value,
-		      void *opaque)
-{
-	bool *default_ldb_port_allocation = opaque;
-
-	if (value == NULL || opaque == NULL) {
-		DLB2_LOG_ERR("NULL pointer");
-		return -EINVAL;
-	}
-
-	if ((*value == 'y') || (*value == 'Y'))
-		*default_ldb_port_allocation = true;
-	else
-		*default_ldb_port_allocation = false;
-
-	return 0;
-}
-
-static int
-set_enable_cq_weight(const char *key __rte_unused,
-		      const char *value,
-		      void *opaque)
-{
-	bool *enable_cq_weight = opaque;
-
-	if (value == NULL || opaque == NULL) {
-		DLB2_LOG_ERR("NULL pointer");
-		return -EINVAL;
-	}
-
-	if ((*value == 'y') || (*value == 'Y'))
-		*enable_cq_weight = true;
-	else
-		*enable_cq_weight = false;
-
-	return 0;
-}
-
-static int set_hl_override(const char *key __rte_unused, const char *value,
-			   void *opaque)
-{
-	bool *default_hl = opaque;
-
-	if (value == NULL || opaque == NULL) {
-		DLB2_LOG_ERR("NULL pointer");
-		return -EINVAL;
-	}
-
-	if ((*value == 'n') || (*value == 'N') || (*value == '0'))
-		*default_hl = false;
-	else
-		*default_hl = true;
-
-	return 0;
-}
-
 static int set_hl_entries(const char *key __rte_unused, const char *value,
 			  void *opaque)
 {
@@ -5223,7 +5120,7 @@ dlb2_parse_params(const char *params,
 				      name);
 		} else {
 			int ret = rte_kvargs_process(kvlist, NUMA_NODE_ARG,
-						     set_numa_node,
+						     rte_kvargs_handle_socket_id,
 						     &dlb2_args->socket_id);
 			if (ret != 0) {
 				DLB2_LOG_ERR("%s: Error parsing numa node parameter",
@@ -5335,9 +5232,9 @@ dlb2_parse_params(const char *params,
 				return ret;
 			}
 
-			ret = rte_kvargs_process(kvlist,
+			ret = rte_kvargs_process_opt(kvlist,
 					DLB2_VECTOR_OPTS_ENAB_ARG,
-					set_vector_opts_enab,
+					rte_kvargs_handle_bool,
 					&dlb2_args->vector_opts_enabled);
 			if (ret != 0) {
 				DLB2_LOG_ERR("%s: Error parsing vector opts enabled",
@@ -5403,9 +5300,9 @@ dlb2_parse_params(const char *params,
 				return ret;
 			}
 
-			ret = rte_kvargs_process(kvlist,
+			ret = rte_kvargs_process_opt(kvlist,
 						 DLB2_DEFAULT_LDB_PORT_ALLOCATION_ARG,
-						 set_default_ldb_port_allocation,
+						 rte_kvargs_handle_bool,
 						 &dlb2_args->default_ldb_port_allocation);
 			if (ret != 0) {
 				DLB2_LOG_ERR("%s: Error parsing ldb default port allocation arg",
@@ -5414,9 +5311,9 @@ dlb2_parse_params(const char *params,
 				return ret;
 			}
 
-			ret = rte_kvargs_process(kvlist,
+			ret = rte_kvargs_process_opt(kvlist,
 						 DLB2_ENABLE_CQ_WEIGHT_ARG,
-						 set_enable_cq_weight,
+						 rte_kvargs_handle_bool,
 						 &dlb2_args->enable_cq_weight);
 			if (ret != 0) {
 				DLB2_LOG_ERR("%s: Error parsing enable_cq_weight arg",
@@ -5427,8 +5324,8 @@ dlb2_parse_params(const char *params,
 			if (version == DLB2_HW_V2 && dlb2_args->enable_cq_weight)
 				DLB2_LOG_INFO("Ignoring 'enable_cq_weight=y'. Only supported for 2.5 HW onwards");
 
-			ret = rte_kvargs_process(kvlist, DLB2_USE_DEFAULT_HL,
-						 set_hl_override,
+			ret = rte_kvargs_process_opt(kvlist, DLB2_USE_DEFAULT_HL,
+						 rte_kvargs_handle_bool,
 						 &dlb2_args->use_default_hl);
 			if (ret != 0) {
 				DLB2_LOG_ERR("%s: Error parsing hl_override arg",
-- 
2.53.0

