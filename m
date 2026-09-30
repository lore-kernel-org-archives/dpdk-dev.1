Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D83F3CA5FC5
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 22:48:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 695A042F85;
	Thu,  1 Oct 2026 00:44:31 +0200 (CEST)
Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com
 [74.125.227.171])
 by mails.dpdk.org (Postfix) with ESMTP id 332E742F47
 for <dev@dpdk.org>; Thu,  1 Oct 2026 00:44:29 +0200 (CEST)
Received: by mail-pj2-f43.google.com with SMTP id
 98e67ed59e1d1-396ccb1a98dso3374947a91.0
 for <dev@dpdk.org>; Wed, 30 Sep 2026 15:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790808268;
 x=1791413068; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uDZhFynSfhLkAONLVWqGEFej7fbq4RxVGv328oBJaMA=;
 b=G76x4D6W7ZJAzXT+AeoOf70HwMcdQKffNJB/Qu7qK4qJQJkh9kIhh3ygjr2Eu1Hro/
 wEiZcJdm815X8U9mFDOMQuGNyX4Xlb1eWrTTI9z0+pi9jksfT3Ugod+Z1SvXibZGcn8W
 UvWumdv+PcOEqVgLmqS7jK72T6nF5TPNQPUzSKU89rY7w/o8MRXu5G8N9wGn/ESoKBDV
 dVlnxnjPW86/Y9GowmWdfgpU/GHhSNakfUfgUW+yGyKrlFdyXrTRdcoG1aDLhdOjzXjb
 Ug3mphPe1+xNgPgaAB0qzSOxvBt0t1NRa9k4+r9coZLs5HyE14Cr9VHYY5OPcVTg47mB
 eq1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790808268; x=1791413068;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uDZhFynSfhLkAONLVWqGEFej7fbq4RxVGv328oBJaMA=;
 b=0J1WdU2kv9xzEShcwMb4wi8m2GwHsCPNh+kPeuY4LQjDjMEoCgWKv2+mp9b4CEs6/i
 k6smzEuZXaI2VGqL+c5dDq/po3qRQ0rltk7YmfnM/LtdybAxOENK2exBbCdEGzKVS8QJ
 Uxtbf8vYonhvl62t/UUEAkl/XDkcCWxMzuPVcTvA3i+W1+0rsh9wqEmOI7lLtUjaUoFH
 nC5498uZfsCw0L0hX10qQKTz+NmuAYOBJLmTNrglvWjB248fYhKqMrFPXCpkaxKrQBpX
 ZVjLLBg04F7W3qSpgums/THCqftq2HFhkzetvo+li36PpYX378ns61KtgOcBZxGGL5Jw
 eX2A==
X-Gm-Message-State: AFq9FYLDBPABEm5ZqSanmSMMdHQ8VbbISx60nngEfBTOQHr59HJuXHze
 sqaBD0eqeac7PqfRbEmS8kieHumFq+tvkThJzwSejHlV7tvfb5sSCXS/WvF9j8a9aS7FiIOwnht
 Puuv8dfM=
X-Gm-Gg: AYBFou1DoZJ/4QATSVv8rq+BWfVSSpuXxu9x0Ijz7LoMnUkEVqVbdx5sYHnqggSZfLx
 +z97t5pPNhSvIYxIWvbNVFlkNhIdeN6c9dBD0HbQPvvaK4VbFANBw5XckDpTGXjhlUPDZ9maRUf
 J9hXduE+XKg7TGe+yc0CeU9hCI6UdSv+31z060NG5WELH9MDomb1vO8InVc7Ws1b36ArR9SdYtA
 RwwPU9Dm1mkosOVh9wV4X1aHFr7w2aJksgu2RiZOCC3Sg754ezO3dnb5nNYv+W0BXMLIUOvfq1I
 H4eVdl2m4TpNdqNVWHmcWzpKE6D2CRbzZEsNvHunBJHurttiOBuSfojs0IYw/CrlbClsU5+fYrk
 UkaynZCXaNfPgM7kuZnZeyhVWaMizem5u+FD17T9BftccoT4hILra5sWfMeOW2R1SVuUb5lYF1t
 5bfNMzh+kz1uClHA9M8fm+k8Zb9Cco+lKKXHz0JadUdqzX8+EPLTKLJVf3KmGzEXG3J792teDp0
 bcpDdgwgLzQMREH/t/ZnI92OIBVmJKwk1BTSA==
X-Received: by 2002:a17:90b:5281:b0:3a4:ab9f:c15 with SMTP id
 98e67ed59e1d1-3a4d18a26acmr2273027a91.32.1790808268253; 
 Wed, 30 Sep 2026 15:44:28 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f4371383sm1258985a91.2.2026.09.30.15.44.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 15:44:27 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Tirthendu Sarkar <tirthendu.sarkar@intel.com>
Subject: [PATCH v3 41/65] event/dlb2: use kvargs numeric helpers
Date: Wed, 30 Sep 2026 15:40:59 -0700
Message-ID: <20260930224340.58580-42-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930224340.58580-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
 <20260930224340.58580-1-stephen@networkplumber.org>
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

