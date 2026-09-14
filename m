Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A31DC88E67
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 05:51:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CF4D2406BC;
	Mon, 14 Sep 2026 07:50:17 +0200 (CEST)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53]) by mails.dpdk.org (Postfix) with ESMTP id A6A7040DCB
 for <dev@dpdk.org>; Mon, 14 Sep 2026 07:50:16 +0200 (CEST)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-398a5aad413so2817367a91.3
 for <dev@dpdk.org>; Sun, 13 Sep 2026 22:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789365016;
 x=1789969816; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YkR3Vq9JmpIaPTVLoNMwtLJbHW4MgwXm4nhgg+m+CTg=;
 b=qd90gL20QCYMzm0QuFe1YAX0Vl5PBs6w7qQKy51La9iu283gpPJjK3lYe+GOHSfZYw
 QVtBA+kGHvQD9cfkmjMYJoEyHOMZBBvZRts7Tpq12Djfhwpxm60LjzDa9OTPtdRAKcYe
 yqbF/41UQ23zupDGqbsU60jnRDRBzDQKC1F67GgJg+N763AQ4vQgGBdSjFLk4i6dafPu
 gyurhHvqSD162BwgGd8Hn7pcdcqn2EBM6JGsw45mGptMm07k9DMzFu4kGV6YuRSWGA0+
 Z5PUJPRpeaMV/gK4UC1/s9bjwxDj0iP35jj67X6vsZqtIHPuhnwUYL1cRgZbH0uP9Ofi
 0SWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789365016; x=1789969816;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YkR3Vq9JmpIaPTVLoNMwtLJbHW4MgwXm4nhgg+m+CTg=;
 b=dP1ee8LTDoYLQYJA8oJOpZGOAUbn+qIEdicCAnFkH9duAfcT1t7EzkKFDoiQ2ofedZ
 9a9nthgAUFyBktsYY9XyBh2AVgddeBJMNuGLVkeq1HySFfbe1uan06+/qLEFlquundCJ
 /zbM2XMINTT1U2WZKCaIvj7Ey85siuhncwlefefh4FcXUmqHiB/xD74VMyA6ot91ozkr
 Nholg01W/O2ijjb2KhNt50oQ4fU5GcDHlBBpNzovsuLfFzpEOIrd8+ZVqvJQ7Ot3nWaS
 rFbzowvRHG6DrID+9CXnN8t+MsuE+c3gMgSXL5HywS1Gn7kQWC0myNKp3vxS6I4aY5aE
 FFYA==
X-Gm-Message-State: AFuF++lShDor7eQVfuDlQfwZI5bMFQ9gj3kN8Tq+StILX/YA+Ra0wec0
 Q9pVu7gpxYcKRHeNWAveF1z0WXhtOl5/Ys7mEQSxMcfy8OEe28Q2EyfOLsXYOAjVpe8bl6TJ/wR
 VybeM
X-Gm-Gg: AYBFou1k+YrVx4HHBfeM7VYHMmGq5leR7nVEQzS/PsVmOXJPocyOsjEsITXuaQloaDC
 KLfIUobcgy3oAPOcZV3MPgNYAAoOtG5S7sucMNhy5KU+mgz2D2X7iM0+PPcgKZSutVdro3M/A8i
 MA7HfkN2XbiSd/biRnk0o4wYHp2k0M/JwXH2NqHt7JdXl3PiOwl5Nrl54zZ5BP/VFfilWinKbVT
 JpH2E0JwZqtTNkYMIKnuiy5AUVKZt3kPi88nftjOoWziZJuz4ZwM2Q4TRHJ1BI95I340+Lq2Lqr
 M2V/6n0sBHI35RfZlFfT5MmtjExRcnRv4+VHRQOvg6guEsSYO0Bquzb9RHOtlMtmM6ktCllX+zm
 OIhmmTraJKIlBWN4xaKpPwibnxHv1UgzzLRUfxuyc5TL265BdCkG8N4DL4kmQLkHJ75fjGWP3Wt
 iDwR77il50WRKgRugAvQmzXTdY66D+uG92Dpn1Z1AVuctL1kH1c+UyfZjElf55susU/HmyQOUEf
 hOR0KPFpTwmt+DQlApYooJ08F/yfgDnnPDmiQ==
X-Received: by 2002:a17:90b:5886:b0:39d:f253:ed66 with SMTP id
 98e67ed59e1d1-39df253ee28mr144346a91.22.1789365015803; 
 Sun, 13 Sep 2026 22:50:15 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d95864b4fsm19794492a91.15.2026.09.13.22.50.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 22:50:15 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Ciara Loftus <ciara.loftus@intel.com>, Maryam Tahhan <mtahhan@redhat.com>
Subject: [PATCH 17/62] net/af_xdp: use kvargs numeric helpers
Date: Sun, 13 Sep 2026 22:46:48 -0700
Message-ID: <20260914054912.755403-18-stephen@networkplumber.org>
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

parse_integer_arg() and parse_budget_arg() do not check the end pointer
or errno, so "start_queue=foo" is silently taken as zero, and they store
the unvalidated result before testing it, so a rejected argument still
overwrites the caller's default.

The shared_umem, force_copy, use_cni and use_pinned_map arguments are
booleans, and are already stored as bool in the internals, so parse them
as bool rather than as int.

The booleans use rte_kvargs_process_opt(), so that a bare key with no
value enables the option.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/af_xdp/rte_eth_af_xdp.c | 68 +++++++++++++++++------------
 1 file changed, 39 insertions(+), 29 deletions(-)

diff --git a/drivers/net/af_xdp/rte_eth_af_xdp.c b/drivers/net/af_xdp/rte_eth_af_xdp.c
index 2cdb533276..30739d07bc 100644
--- a/drivers/net/af_xdp/rte_eth_af_xdp.c
+++ b/drivers/net/af_xdp/rte_eth_af_xdp.c
@@ -3,6 +3,8 @@
  */
 #include <unistd.h>
 #include <errno.h>
+#include <limits.h>
+#include <stdbool.h>
 #include <stdlib.h>
 #include <string.h>
 #include <netinet/in.h>
@@ -2002,16 +2004,20 @@ static int
 parse_budget_arg(const char *key __rte_unused,
 		  const char *value, void *extra_args)
 {
-	int *i = (int *)extra_args;
-	char *end;
+	int64_t val;
+	int ret;
 
-	*i = strtol(value, &end, 10);
-	if (*i < 0 || *i > UINT16_MAX) {
-		AF_XDP_LOG_LINE(ERR, "Invalid busy_budget %i, must be >= 0 and <= %u",
-				*i, UINT16_MAX);
+	if (extra_args == NULL)
 		return -EINVAL;
+
+	ret = rte_kvargs_to_int(value, 0, UINT16_MAX, &val);
+	if (ret < 0) {
+		AF_XDP_LOG_LINE(ERR, "Invalid busy_budget %s, must be >= 0 and <= %u",
+				value == NULL ? "" : value, UINT16_MAX);
+		return ret;
 	}
 
+	*(int *)extra_args = val;
 	return 0;
 }
 
@@ -2020,15 +2026,19 @@ static int
 parse_integer_arg(const char *key __rte_unused,
 		  const char *value, void *extra_args)
 {
-	int *i = (int *)extra_args;
-	char *end;
+	int64_t val;
+	int ret;
 
-	*i = strtol(value, &end, 10);
-	if (*i < 0) {
-		AF_XDP_LOG_LINE(ERR, "Argument has to be positive.");
+	if (extra_args == NULL)
 		return -EINVAL;
+
+	ret = rte_kvargs_to_int(value, 0, INT_MAX, &val);
+	if (ret < 0) {
+		AF_XDP_LOG_LINE(ERR, "Argument has to be positive.");
+		return ret;
 	}
 
+	*(int *)extra_args = val;
 	return 0;
 }
 
@@ -2144,9 +2154,9 @@ xdp_get_channels_info(const char *if_name, int *max_queues,
 
 static int
 parse_parameters(struct rte_kvargs *kvlist, char *if_name, int *start_queue,
-		 int *queue_cnt, int *shared_umem, char *prog_path,
-		 int *busy_budget, int *force_copy, int *use_cni,
-		 int *use_pinned_map, char *dp_path, uint32_t *xdp_mode)
+		 int *queue_cnt, bool *shared_umem, char *prog_path,
+		 int *busy_budget, bool *force_copy, bool *use_cni,
+		 bool *use_pinned_map, char *dp_path, uint32_t *xdp_mode)
 {
 	int ret;
 
@@ -2167,8 +2177,8 @@ parse_parameters(struct rte_kvargs *kvlist, char *if_name, int *start_queue,
 		goto free_kvlist;
 	}
 
-	ret = rte_kvargs_process(kvlist, ETH_AF_XDP_SHARED_UMEM_ARG,
-				&parse_integer_arg, shared_umem);
+	ret = rte_kvargs_process_opt(kvlist, ETH_AF_XDP_SHARED_UMEM_ARG,
+				rte_kvargs_handle_bool, shared_umem);
 	if (ret < 0)
 		goto free_kvlist;
 
@@ -2182,18 +2192,18 @@ parse_parameters(struct rte_kvargs *kvlist, char *if_name, int *start_queue,
 	if (ret < 0)
 		goto free_kvlist;
 
-	ret = rte_kvargs_process(kvlist, ETH_AF_XDP_FORCE_COPY_ARG,
-				&parse_integer_arg, force_copy);
+	ret = rte_kvargs_process_opt(kvlist, ETH_AF_XDP_FORCE_COPY_ARG,
+				rte_kvargs_handle_bool, force_copy);
 	if (ret < 0)
 		goto free_kvlist;
 
-	ret = rte_kvargs_process(kvlist, ETH_AF_XDP_USE_CNI_ARG,
-				 &parse_integer_arg, use_cni);
+	ret = rte_kvargs_process_opt(kvlist, ETH_AF_XDP_USE_CNI_ARG,
+				     rte_kvargs_handle_bool, use_cni);
 	if (ret < 0)
 		goto free_kvlist;
 
-	ret = rte_kvargs_process(kvlist, ETH_AF_XDP_USE_PINNED_MAP_ARG,
-				 &parse_integer_arg, use_pinned_map);
+	ret = rte_kvargs_process_opt(kvlist, ETH_AF_XDP_USE_PINNED_MAP_ARG,
+				     rte_kvargs_handle_bool, use_pinned_map);
 	if (ret < 0)
 		goto free_kvlist;
 
@@ -2246,9 +2256,9 @@ get_iface_info(const char *if_name,
 
 static struct rte_eth_dev *
 init_internals(struct rte_vdev_device *dev, const char *if_name,
-	       int start_queue_idx, int queue_cnt, int shared_umem,
-	       const char *prog_path, int busy_budget, int force_copy,
-	       int use_cni, int use_pinned_map, const char *dp_path, uint32_t xdp_mode)
+	       int start_queue_idx, int queue_cnt, bool shared_umem,
+	       const char *prog_path, int busy_budget, bool force_copy,
+	       bool use_cni, bool use_pinned_map, const char *dp_path, uint32_t xdp_mode)
 {
 	const char *name = rte_vdev_device_name(dev);
 	const unsigned int numa_node = dev->device.numa_node;
@@ -2466,12 +2476,12 @@ rte_pmd_af_xdp_probe(struct rte_vdev_device *dev)
 	char if_name[IFNAMSIZ] = {'\0'};
 	int xsk_start_queue_idx = ETH_AF_XDP_DFLT_START_QUEUE_IDX;
 	int xsk_queue_cnt = ETH_AF_XDP_DFLT_QUEUE_COUNT;
-	int shared_umem = 0;
+	bool shared_umem = false;
 	char prog_path[PATH_MAX] = {'\0'};
 	int busy_budget = -1, ret;
-	int force_copy = 0;
-	int use_cni = 0;
-	int use_pinned_map = 0;
+	bool force_copy = false;
+	bool use_cni = false;
+	bool use_pinned_map = false;
 	uint32_t xdp_mode = 0;
 	char dp_path[PATH_MAX] = {'\0'};
 	struct rte_eth_dev *eth_dev = NULL;
-- 
2.53.0

