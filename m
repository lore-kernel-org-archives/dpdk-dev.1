Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1E0CA5FC5
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 22:46:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C3E8442E8A;
	Thu,  1 Oct 2026 00:44:07 +0200 (CEST)
Received: from mail-pj2-f39.google.com (mail-pj2-f39.google.com
 [74.125.227.167])
 by mails.dpdk.org (Postfix) with ESMTP id C035C42EB0
 for <dev@dpdk.org>; Thu,  1 Oct 2026 00:44:05 +0200 (CEST)
Received: by mail-pj2-f39.google.com with SMTP id
 98e67ed59e1d1-3a49896dd9dso750499a91.0
 for <dev@dpdk.org>; Wed, 30 Sep 2026 15:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790808245;
 x=1791413045; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ntlk6dRu/YasPaPpxJ41Z2HuVVycpvoalb/aDaQgxdo=;
 b=oMk9ntQgRQIaUHXvicn7Vs3ltBTtf9mTx9eXyTGZWbJTmi4K4B9zPflohrB4sXuq2+
 zJPIYJJWQ3R/m705CflzCs5/KFLPY1ULOfeuUug5q8ucP0yxC3Lu5nKFy427jj/O0jWD
 vm2T6WMDEptyvGex6vz3py2RnYRaHMHeUI9iQTkNN1uaSAMWcBTWjDab3guYynMwAT/d
 mkk+hLA39S8NlAH7ETNT/ylJDHlQbQFQta3FEC5zO3Zfvm9Egv6WWm4vcPo3pBUtyAwB
 uAHMzJ504NOvUVGBI2VKG/H14FY9T63+OpxcugHTMkrApQcpRUTwLFeCNc9LqWjlTo1G
 gtoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790808245; x=1791413045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ntlk6dRu/YasPaPpxJ41Z2HuVVycpvoalb/aDaQgxdo=;
 b=cIt57Kvn0tU6nUXfV8slcdPq26T+XxjYukyhTCXJ2z0TIygPdDhEBs9ALTs7LQHZTP
 Ogxnjd5YIdB6e9xEtEyHZ2cyuQg9ThutlbeijyEZtzXKZIR4hcMo4fhv8nPxDTt64CRk
 e3uITMiQ1DNtY1Ah1AGSvznAuwW5hOUoBzSLUlaXQ+/4EZaKS547yfLLA6gnZmZikrfm
 QsQrMmJ8YJ3leMFJuxH9/oe3ivRjj6N6lC4343zfIWaX7ftjZ6iOaIUk80S9R+folCmB
 vdY55XlMLXzO13l//0OkPvvz4DXNuEafqzKIbm+/dyK2hzak1shckTSArgXgxKXyHsSI
 yCeA==
X-Gm-Message-State: AFq9FYIa0Itah53ER71h9YOVYq5yb53VRsVZdQNaEWf5kJJ8IUcS/tmf
 /i10nq6omC14aci8bYaFpC9a6O+JdyQdzVht4eBMWwJpe3AgE8gmi0p1gy6nt1/NttZNJEKQ9VV
 rwOpv2MQ=
X-Gm-Gg: AYBFou1fIiVHblyCB9Wob04ry2hRnYPrRvldIFYQ4SyUeuAE65dpaLf15WljiOM5t5t
 dAVsNWh+CO0kidabWxIqfdhJ95mpwQnLMAIJ75HdhynRNNOOtDFE7KxBvuuKjwYj/Lt7enBI/iw
 t6f7D5As98d8l5xE2oS/zpokl1YOs2SiTE7L5GIqddG8Xlga02QmXVpRZZs4Q7hq4JRSjNyuJSz
 Unq+jykw1Uyt2VsBy1ZjbBFHKEQc/hqzTGDJoNBg7rFD0nxoUKQ+BkSw60Qlv4C13cZiV6X4QL4
 JeVd3gvPojix6gq+Zw6IJjvBDu/vOI52TSmBJhL9WvvpJ/cQs65qw13wAarkPVpvL+YpBSnMDzb
 Whn1z9rwEFJGpgrd4eRh9Wtm/oWOjU4Vo6df9FyG4OZc0CdFKrlwt6fMj0a7TLDmWRu1RzOuOAO
 sX1JqCU4ODdCw6I2Dr/vKS1StTkGQOI9Py1WrYJkDEyi8VTK11GlidFMw1+g8m4Vzu/m4+wzNB+
 OqnV3SEwI3DqirrAGMbJU/1aSYcepoWWeUnzw==
X-Received: by 2002:a17:90a:1196:b0:39b:5622:d645 with SMTP id
 98e67ed59e1d1-3a4f1e4d317mr440129a91.0.1790808244768; 
 Wed, 30 Sep 2026 15:44:04 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f4371383sm1258985a91.2.2026.09.30.15.44.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 15:44:04 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH v3 20/65] net/virtio: use kvargs numeric helpers
Date: Wed, 30 Sep 2026 15:40:38 -0700
Message-ID: <20260930224340.58580-21-stephen@networkplumber.org>
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

get_integer_arg() checks only errno, so "queues=foo" was silently taken
as zero, and since the store is skipped on failure but zero is returned,
the argument was accepted while leaving the default in place. It also
uses base 0, so a leading zero selects octal.

link_speed_handler() checks neither errno nor the end pointer before
validating the result against the speed capabilities.

The boolean arguments become bool and use rte_kvargs_handle_bool():
server, cq, packed_vq, vectorized, mrg_rxbuf and in_order for
virtio_user, and vectorized for virtio. They are passed by value into
virtio_user_dev_init(), whose parameters stay int.

vectorized_check_handler() treated anything other than "1" as false, so
"vectorized=y" silently disabled it and a typo did the same. It is now
a boolean like the rest: the usual spellings work, a bare key enables
the option, and anything else is rejected instead of being read as
false.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/virtio/virtio_ethdev.c      | 36 ++++++---------
 drivers/net/virtio/virtio_user_ethdev.c | 59 +++++++++----------------
 2 files changed, 34 insertions(+), 61 deletions(-)

diff --git a/drivers/net/virtio/virtio_ethdev.c b/drivers/net/virtio/virtio_ethdev.c
index a6fe4f3023..556e4bfede 100644
--- a/drivers/net/virtio/virtio_ethdev.c
+++ b/drivers/net/virtio/virtio_ethdev.c
@@ -47,7 +47,7 @@ static int virtio_dev_allmulticast_disable(struct rte_eth_dev *dev);
 static uint32_t virtio_dev_speed_capa_get(uint32_t speed);
 static int virtio_dev_devargs_parse(struct rte_devargs *devargs,
 	uint32_t *speed,
-	int *vectorized);
+	bool *vectorized);
 static int virtio_dev_info_get(struct rte_eth_dev *dev,
 				struct rte_eth_dev_info *dev_info);
 static int virtio_dev_link_update(struct rte_eth_dev *dev,
@@ -2029,7 +2029,7 @@ eth_virtio_dev_init(struct rte_eth_dev *eth_dev)
 {
 	struct virtio_hw *hw = eth_dev->data->dev_private;
 	uint32_t speed = RTE_ETH_SPEED_NUM_UNKNOWN;
-	int vectorized = 0;
+	bool vectorized = false;
 	int ret;
 
 	if (sizeof(struct virtio_net_hdr_hash_report) > RTE_PKTMBUF_HEADROOM) {
@@ -2128,20 +2128,6 @@ virtio_dev_speed_capa_get(uint32_t speed)
 	}
 }
 
-static int vectorized_check_handler(__rte_unused const char *key,
-		const char *value, void *ret_val)
-{
-	if (value == NULL || ret_val == NULL)
-		return -EINVAL;
-
-	if (strcmp(value, "1") == 0)
-		*(int *)ret_val = 1;
-	else
-		*(int *)ret_val = 0;
-
-	return 0;
-}
-
 #define VIRTIO_ARG_SPEED      "speed"
 #define VIRTIO_ARG_VECTORIZED "vectorized"
 
@@ -2149,21 +2135,25 @@ static int
 link_speed_handler(const char *key __rte_unused,
 		const char *value, void *ret_val)
 {
-	uint32_t val;
-	if (!value || !ret_val)
+	uint64_t val;
+
+	if (ret_val == NULL)
+		return -EINVAL;
+
+	if (rte_kvargs_to_uint(value, 0, UINT32_MAX, &val) < 0)
 		return -EINVAL;
-	val = strtoul(value, NULL, 0);
+
 	/* validate input */
 	if (virtio_dev_speed_capa_get(val) == 0)
 		return -EINVAL;
-	*(uint32_t *)ret_val = val;
 
+	*(uint32_t *)ret_val = val;
 	return 0;
 }
 
 
 static int
-virtio_dev_devargs_parse(struct rte_devargs *devargs, uint32_t *speed, int *vectorized)
+virtio_dev_devargs_parse(struct rte_devargs *devargs, uint32_t *speed, bool *vectorized)
 {
 	struct rte_kvargs *kvlist;
 	int ret = 0;
@@ -2190,9 +2180,9 @@ virtio_dev_devargs_parse(struct rte_devargs *devargs, uint32_t *speed, int *vect
 
 	if (vectorized &&
 		rte_kvargs_count(kvlist, VIRTIO_ARG_VECTORIZED) == 1) {
-		ret = rte_kvargs_process(kvlist,
+		ret = rte_kvargs_process_opt(kvlist,
 				VIRTIO_ARG_VECTORIZED,
-				vectorized_check_handler, vectorized);
+				rte_kvargs_handle_bool, vectorized);
 		if (ret < 0) {
 			PMD_INIT_LOG(ERR, "Failed to parse %s",
 					VIRTIO_ARG_VECTORIZED);
diff --git a/drivers/net/virtio/virtio_user_ethdev.c b/drivers/net/virtio/virtio_user_ethdev.c
index 747dddeb2e..4925924211 100644
--- a/drivers/net/virtio/virtio_user_ethdev.c
+++ b/drivers/net/virtio/virtio_user_ethdev.c
@@ -387,23 +387,6 @@ get_string_arg(const char *key __rte_unused,
 	return 0;
 }
 
-static int
-get_integer_arg(const char *key __rte_unused,
-		const char *value, void *extra_args)
-{
-	uint64_t integer = 0;
-	if (!value || !extra_args)
-		return -EINVAL;
-	errno = 0;
-	integer = strtoull(value, NULL, 0);
-	/* extra_args keeps default value, it should be replaced
-	 * only in case of successful parsing of the 'value' arg
-	 */
-	if (errno == 0)
-		*(uint64_t *)extra_args = integer;
-	return -errno;
-}
-
 static uint32_t
 vdpa_dynamic_major_num(void)
 {
@@ -508,13 +491,13 @@ virtio_user_pmd_probe(struct rte_vdev_device *vdev)
 	struct virtio_user_dev *dev;
 	enum virtio_user_backend_type backend_type = VIRTIO_USER_BACKEND_UNKNOWN;
 	uint64_t queues = VIRTIO_USER_DEF_Q_NUM;
-	uint64_t cq = VIRTIO_USER_DEF_CQ_EN;
+	bool cq = VIRTIO_USER_DEF_CQ_EN;
 	uint64_t queue_size = VIRTIO_USER_DEF_Q_SZ;
-	uint64_t server_mode = VIRTIO_USER_DEF_SERVER_MODE;
-	uint64_t mrg_rxbuf = 1;
-	uint64_t in_order = 1;
-	uint64_t packed_vq = 0;
-	uint64_t vectorized = 0;
+	bool server_mode = VIRTIO_USER_DEF_SERVER_MODE;
+	bool mrg_rxbuf = true;
+	bool in_order = true;
+	bool packed_vq = false;
+	bool vectorized = false;
 	char *path = NULL;
 	char *ifname = NULL;
 	char *mac_addr = NULL;
@@ -602,7 +585,7 @@ virtio_user_pmd_probe(struct rte_vdev_device *vdev)
 
 	if (rte_kvargs_count(kvlist, VIRTIO_USER_ARG_QUEUE_SIZE) == 1) {
 		if (rte_kvargs_process(kvlist, VIRTIO_USER_ARG_QUEUE_SIZE,
-				       &get_integer_arg, &queue_size) < 0) {
+				       rte_kvargs_handle_u64, &queue_size) < 0) {
 			PMD_INIT_LOG(ERR, "error to parse %s",
 				     VIRTIO_USER_ARG_QUEUE_SIZE);
 			goto end;
@@ -611,7 +594,7 @@ virtio_user_pmd_probe(struct rte_vdev_device *vdev)
 
 	if (rte_kvargs_count(kvlist, VIRTIO_USER_ARG_QUEUES_NUM) == 1) {
 		if (rte_kvargs_process(kvlist, VIRTIO_USER_ARG_QUEUES_NUM,
-				       &get_integer_arg, &queues) < 0) {
+				       rte_kvargs_handle_u64, &queues) < 0) {
 			PMD_INIT_LOG(ERR, "error to parse %s",
 				     VIRTIO_USER_ARG_QUEUES_NUM);
 			goto end;
@@ -619,8 +602,8 @@ virtio_user_pmd_probe(struct rte_vdev_device *vdev)
 	}
 
 	if (rte_kvargs_count(kvlist, VIRTIO_USER_ARG_SERVER_MODE) == 1) {
-		if (rte_kvargs_process(kvlist, VIRTIO_USER_ARG_SERVER_MODE,
-				       &get_integer_arg, &server_mode) < 0) {
+		if (rte_kvargs_process_opt(kvlist, VIRTIO_USER_ARG_SERVER_MODE,
+				       rte_kvargs_handle_bool, &server_mode) < 0) {
 			PMD_INIT_LOG(ERR, "error to parse %s",
 				     VIRTIO_USER_ARG_SERVER_MODE);
 			goto end;
@@ -628,8 +611,8 @@ virtio_user_pmd_probe(struct rte_vdev_device *vdev)
 	}
 
 	if (rte_kvargs_count(kvlist, VIRTIO_USER_ARG_CQ_NUM) == 1) {
-		if (rte_kvargs_process(kvlist, VIRTIO_USER_ARG_CQ_NUM,
-				       &get_integer_arg, &cq) < 0) {
+		if (rte_kvargs_process_opt(kvlist, VIRTIO_USER_ARG_CQ_NUM,
+				       rte_kvargs_handle_bool, &cq) < 0) {
 			PMD_INIT_LOG(ERR, "error to parse %s",
 				     VIRTIO_USER_ARG_CQ_NUM);
 			goto end;
@@ -637,8 +620,8 @@ virtio_user_pmd_probe(struct rte_vdev_device *vdev)
 	}
 
 	if (rte_kvargs_count(kvlist, VIRTIO_USER_ARG_PACKED_VQ) == 1) {
-		if (rte_kvargs_process(kvlist, VIRTIO_USER_ARG_PACKED_VQ,
-				       &get_integer_arg, &packed_vq) < 0) {
+		if (rte_kvargs_process_opt(kvlist, VIRTIO_USER_ARG_PACKED_VQ,
+				       rte_kvargs_handle_bool, &packed_vq) < 0) {
 			PMD_INIT_LOG(ERR, "error to parse %s",
 				     VIRTIO_USER_ARG_PACKED_VQ);
 			goto end;
@@ -646,8 +629,8 @@ virtio_user_pmd_probe(struct rte_vdev_device *vdev)
 	}
 
 	if (rte_kvargs_count(kvlist, VIRTIO_USER_ARG_VECTORIZED) == 1) {
-		if (rte_kvargs_process(kvlist, VIRTIO_USER_ARG_VECTORIZED,
-				       &get_integer_arg, &vectorized) < 0) {
+		if (rte_kvargs_process_opt(kvlist, VIRTIO_USER_ARG_VECTORIZED,
+				       rte_kvargs_handle_bool, &vectorized) < 0) {
 			PMD_INIT_LOG(ERR, "error to parse %s",
 				     VIRTIO_USER_ARG_VECTORIZED);
 			goto end;
@@ -655,8 +638,8 @@ virtio_user_pmd_probe(struct rte_vdev_device *vdev)
 	}
 
 	if (rte_kvargs_count(kvlist, VIRTIO_USER_ARG_MRG_RXBUF) == 1) {
-		if (rte_kvargs_process(kvlist, VIRTIO_USER_ARG_MRG_RXBUF,
-				       &get_integer_arg, &mrg_rxbuf) < 0) {
+		if (rte_kvargs_process_opt(kvlist, VIRTIO_USER_ARG_MRG_RXBUF,
+				       rte_kvargs_handle_bool, &mrg_rxbuf) < 0) {
 			PMD_INIT_LOG(ERR, "error to parse %s",
 				     VIRTIO_USER_ARG_MRG_RXBUF);
 			goto end;
@@ -664,8 +647,8 @@ virtio_user_pmd_probe(struct rte_vdev_device *vdev)
 	}
 
 	if (rte_kvargs_count(kvlist, VIRTIO_USER_ARG_IN_ORDER) == 1) {
-		if (rte_kvargs_process(kvlist, VIRTIO_USER_ARG_IN_ORDER,
-				       &get_integer_arg, &in_order) < 0) {
+		if (rte_kvargs_process_opt(kvlist, VIRTIO_USER_ARG_IN_ORDER,
+				       rte_kvargs_handle_bool, &in_order) < 0) {
 			PMD_INIT_LOG(ERR, "error to parse %s",
 				     VIRTIO_USER_ARG_IN_ORDER);
 			goto end;
@@ -816,7 +799,7 @@ RTE_PMD_REGISTER_ALIAS(net_virtio_user, virtio_user);
 RTE_PMD_REGISTER_PARAM_STRING(net_virtio_user,
 	"path=<path> "
 	"mac=<mac addr> "
-	"cq=<int> "
+	"cq=<0|1> "
 	"queue_size=<int> "
 	"queues=<int> "
 	"iface=<string> "
-- 
2.53.0

