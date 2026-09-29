Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA989CA5FA7
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 16:40:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 63A7E42EB6;
	Tue, 29 Sep 2026 18:38:46 +0200 (CEST)
Received: from mail-pz2-f38.google.com (mail-pz2-f38.google.com
 [74.125.228.38]) by mails.dpdk.org (Postfix) with ESMTP id DADBD42E7A
 for <dev@dpdk.org>; Tue, 29 Sep 2026 18:38:25 +0200 (CEST)
Received: by mail-pz2-f38.google.com with SMTP id
 d2e1a72fcca58-881d9da69b1so990772b3a.0
 for <dev@dpdk.org>; Tue, 29 Sep 2026 09:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790699905;
 x=1791304705; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ntlk6dRu/YasPaPpxJ41Z2HuVVycpvoalb/aDaQgxdo=;
 b=zqFviyAWzOPADax1IBuEjxjJelMW79v6kFmmRhAaf4Rl05qIuQOYkz/jdymwlNQ95A
 LRBHkX54iOx4+fLvTBCGp+j0YvJA5HHOqAljCj1bao1q4ZSHgNa4JRxHxelQHdtc2epc
 oOhHQsvz40kI/GBUS7jP6AHVvNvtTZd79ybaP4NoFkXrW5cc7ISevjPMffxV1onN29SD
 lxbnX7sj0tZE/36Uu++ZWowrCoSO6nBOJa+a9NivMYKr/PqZoeT4mQ4fdkFuUqFFEbAB
 fCz8msc8wW4Bh1DQ97tihD73LsVT8MeYahjWKME6ryw5dlVondHuPf3N/Ny+B29DkYJ3
 2UOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790699905; x=1791304705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ntlk6dRu/YasPaPpxJ41Z2HuVVycpvoalb/aDaQgxdo=;
 b=hJpac0B8xS2IwVqg2s/A6MeH7lo05/ZJpW4rbRFzXMbdKGqzOu0MASJGPpNVYh1jOj
 O5EkrQUbrOSn0e9bvB8BW4CEXSSS6ztEnYEYb7cL/biyT+KX77engXeftjQg8xypY6uB
 RKPETJeLDJSiYZENAQVMyQGPmNJOF0eY26Le8vGrR/c+Q60SdcSIcO9c3jaG2yXNcFNS
 T+MeDn1KRbEAerJi0yZfULxCr69Whsj6VACVmwz8PJUtdAxcSSpsNU259OaqfxMTIAZx
 2VFsfE7yh1PpOnWtWHgH8HtuWHvi1ekmSCEoD3Ffk570pIRB9rIYvqOPrMmn4b7Mu1wa
 m1kg==
X-Gm-Message-State: AFuF++mOQZ0Q500otIBcBH80zVcxrzJC6wBzUcxWrZKfV7AEmsYGs4Ha
 oEnWSN2moKYFdUJKTtufrYTyJ9StdSnIt5E8QGAEyUORvZpmBL2zHGNwOH7NJLc4NAVrgQo/aMy
 iZ3LXzCw=
X-Gm-Gg: AYBFou2zUPFoSa8FgXR2KjHmo3Rmk+zoUrBPtma9UnKjNIszymZVPvebgXqXsrthvct
 tGh3Y6twY1UtycTFygWy0gFBcQ1mAT1EPUZ86CC5Y0CCQqfbj7QzGzN1oLjwIjCZKv9WzjePo+M
 diTMm2kX0sviq/cAtHFiGLTU0EFYfkcmZ9hvOvXmyPDr3I1ZY9GgZwhecvTzOMaW/rDCbGxVGae
 Kj9t/7Xat7LMjCuwqJQuc2upnVy/GNiVdN36T5E9JdjKl3pGxrw6PshmbOPUF3fnqGtq4OqM19y
 cYdn7CnhUUp5TQnieylQr1uvrLzNj+v74rAVIZA6e1Hy1BJTXpi1g6dxoFPTDgmpMGpziRBK9D2
 jPrHRiF4adAwloUq6eK7sK7ZK2YshJni3XCwPJbJGKxOGVYlVoMX/EevWwwITPlRUkIsr4vEmu4
 Hj2KIwnemBt69c9TmNG3yott6o4jQOEMwPxY9AbThwpqiXAz5RoRY37NcizbqUQajDDtv7YDIq7
 hxbXvFrTdBeGnsbEb1N5c+gDFhOMzS53sAEDg==
X-Received: by 2002:a05:6a00:9283:b0:883:904e:da56 with SMTP id
 d2e1a72fcca58-883905e238amr6135251b3a.36.1790699904971; 
 Tue, 29 Sep 2026 09:38:24 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8868ba02d02sm232392b3a.21.2026.09.29.09.38.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:38:24 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH v2 19/61] net/virtio: use kvargs numeric helpers
Date: Tue, 29 Sep 2026 09:36:22 -0700
Message-ID: <20260929163800.1108305-20-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929163800.1108305-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
 <20260929163800.1108305-1-stephen@networkplumber.org>
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

