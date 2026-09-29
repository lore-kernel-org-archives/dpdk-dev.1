Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF1CCA5FA7
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 16:38:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DAFDF42E6C;
	Tue, 29 Sep 2026 18:38:20 +0200 (CEST)
Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com
 [74.125.228.40]) by mails.dpdk.org (Postfix) with ESMTP id 7E2404281D
 for <dev@dpdk.org>; Tue, 29 Sep 2026 18:38:14 +0200 (CEST)
Received: by mail-pz2-f40.google.com with SMTP id
 d2e1a72fcca58-8804b59404aso2146684b3a.3
 for <dev@dpdk.org>; Tue, 29 Sep 2026 09:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790699894;
 x=1791304694; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1ML+YTzaEnpQDvccUJ/J1qNyPxHjM5V8vDFNCgkQMnM=;
 b=a5i30WiVw3zj8EOWRzaR+Oq7BPLPwIAGp26wdMSdB0EEtN+4R0hm1Io/hSoLT+TaYb
 97NHDrYGTCElCD5NtUfOFkSQbxuznQFc+sm2zyoB7XgffNH5WW/ceIDT133QaVM1bByK
 ihbcbDUkgJPgA70C+zO4qmfv7jtwYlVhT8tAD+MN1rn5OQs2MxfKfkG4UQuIDaDoQrn0
 nRuEzA1Vo5glai+R1EEMBgZgKn77zUqLriZu3ByL34AP6kBvu9XIq9V7POQVCyU+ushn
 7fXnMxusHrAijK0dlrZMEA6fie/hDmMD70yBvbDwAlRPhCvcw3EGW3H4b2NN0AP3Iuvg
 O7+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790699894; x=1791304694;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1ML+YTzaEnpQDvccUJ/J1qNyPxHjM5V8vDFNCgkQMnM=;
 b=k+wF7cFPn6O7NF3JU+qIvEJbiMSPdv4jOq8EDqOPKbmNdLUnejONP93sKWGtA7GYjh
 TaraDme0os7lX83w/3g/uZBtPtc/QJHIrXyEKp2Vx7iTP0+ygzOFtXFYSNIzKFug+ZNI
 BOm7pHMzDcC+5ghvNZSI6Q6IWuSC4EAh8PmqH2US2g0GDmX5YjXUQOGF2OobiaR0G5nX
 k7YmLh2StwpYdPoDs62dvHVchGMOVl+7Grw6/qhcxf8NebpmXN61IS9TPOYUouMANcmH
 1r2GyZoJouAmTC6aBDTsJL6SttGxBSAtFbeoeoVWhZms1l0byXeEaHZHOOlyyL7n+xgf
 yUNw==
X-Gm-Message-State: AFuF++n1BbecAKfgOon562vV+b0V+SbWFBaYOjFOYkN4C8n9ECJONDcE
 Rdu/QrJ32nzlqFbSDWVVwb7et+d1cxCU5EK1jIb7QD7MpCsJp/U+ksyHPX/LqbpbxXDBi5A3VDD
 KFWKVVts=
X-Gm-Gg: AYBFou0UupFREEh+T0zfqAIlHTs3ypOodmosT9xGMp+JClYRKCoPnNaWnHbrWgJWYx2
 gWZPnOmJPf6XratfE5fEPdmyhaZSPIj6aDMh1zQByFbULf5VMszp56AztE32PpH71Que3fTzFGh
 ff26f9mxKTRhKRBF6cgoNUsbuPjV7CEsQus4Q7JJ0jdIviMgnVIiIRY1mwNtOVWTz/yqTcXA22r
 VSyzuNPFaATeWoaK0QdY3EoemTKpTeODn6P9mMZk16CIf1pMcq7MvujwNr9mSfzCnTiGgrqcCAZ
 Gz5qFT+hMkg0VsQWkKYumKWnuazVlBUsNdFdTqMdJpOAjAzm+aES73UQYcn7rfSa2pXK6ibhiYq
 LFDREukgBfmVJWlY4u7xYSYtFx7NIj/ime80elcGyHW5PIN2sScsAc/+v7P8L8bQDztbmtgRpJ9
 pe6DDjlbfW7+fYGIKpHRiMhcJjUNQ7Adc2l0pd1vfxdHKHAKFf4/xVK2Sr31WhsfSlia153vkU3
 CDKDCzX2WQSFcUkkPttJ90ZGf12HX1eoQjU0Q==
X-Received: by 2002:a05:6a00:4289:b0:886:5938:cdd4 with SMTP id
 d2e1a72fcca58-8865938ebdfmr1007870b3a.19.1790699893732; 
 Tue, 29 Sep 2026 09:38:13 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8868ba02d02sm232392b3a.21.2026.09.29.09.38.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:38:13 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>, Yuanhan Liu <yliu@fridaylinux.org>
Subject: [PATCH v2 06/61] net/vhost: use kvargs numeric helpers
Date: Tue, 29 Sep 2026 09:36:09 -0700
Message-ID: <20260929163800.1108305-7-stephen@networkplumber.org>
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

open_int() converts with strtoul() and checks errno without resetting
it first, so an unrelated earlier failure makes a valid value fail,
and an overflow which does not happen to produce USHRT_MAX is accepted.
The end pointer is not checked at all, so "queues=foo" is silently
taken as zero.

More seriously, open_int() stores through a uint16_t pointer, but seven
of its eight callers pass the address of an int. Only two bytes of a
four byte object are written; this happens to work on little endian
because the callers initialize the variable to zero first, but it is
wrong on big endian.

The queues argument is the only real number, and it keeps a handler of
its own so that the range is checked where it is parsed. The caller
tested "queues > RTE_MAX_QUEUES_PER_PORT" after the fact but left ret
at zero, so an out of range value skipped the rest of the parsing and
still returned success from probe. Bounding it in the handler to
1..RTE_MAX_QUEUES_PER_PORT makes it fail properly, and also rejects
"queues=0", which was accepted before and left the device with no
queues.

The rest are booleans, so store them as bool and use
rte_kvargs_handle_bool, which also gives them the word forms such as
"client=on". They are processed with rte_kvargs_process_opt(), so a
bare key with no value enables the option.

Bugzilla ID: 2039
Fixes: 39cac2adcad0 ("net/vhost: add client option")

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/vhost/rte_eth_vhost.c | 69 ++++++++++++++++---------------
 1 file changed, 35 insertions(+), 34 deletions(-)

diff --git a/drivers/net/vhost/rte_eth_vhost.c b/drivers/net/vhost/rte_eth_vhost.c
index 56c7a973e9..2117aba741 100644
--- a/drivers/net/vhost/rte_eth_vhost.c
+++ b/drivers/net/vhost/rte_eth_vhost.c
@@ -1583,17 +1583,18 @@ open_iface(const char *key __rte_unused, const char *value, void *extra_args)
 	return 0;
 }
 
-static inline int
-open_int(const char *key __rte_unused, const char *value, void *extra_args)
+static int
+open_queues(const char *key, const char *value, void *extra_args)
 {
-	uint16_t *n = extra_args;
+	uint64_t queues;
 
-	if (value == NULL || extra_args == NULL)
+	if (rte_kvargs_to_uint(value, 1, RTE_MAX_QUEUES_PER_PORT, &queues) < 0) {
+		VHOST_LOG_LINE(ERR, "invalid %s, must be 1..%u", key,
+			       RTE_MAX_QUEUES_PER_PORT);
 		return -EINVAL;
+	}
 
-	*n = (uint16_t)strtoul(value, NULL, 0);
-	if (*n == USHRT_MAX && errno == ERANGE)
-		return -1;
+	*(uint16_t *)extra_args = queues;
 
 	return 0;
 }
@@ -1607,13 +1608,13 @@ rte_pmd_vhost_probe(struct rte_vdev_device *dev)
 	uint16_t queues;
 	uint64_t flags = RTE_VHOST_USER_NET_STATS_ENABLE;
 	uint64_t disable_flags = 0;
-	int client_mode = 0;
-	int iommu_support = 0;
-	int postcopy_support = 0;
-	int tso = 0;
-	int linear_buf = 0;
-	int ext_buf = 0;
-	int legacy_ol_flags = 0;
+	bool client_mode = false;
+	bool iommu_support = false;
+	bool postcopy_support = false;
+	bool tso = false;
+	bool linear_buf = false;
+	bool ext_buf = false;
+	bool legacy_ol_flags = false;
 	struct rte_eth_dev *eth_dev;
 	const char *name = rte_vdev_device_name(dev);
 
@@ -1651,16 +1652,16 @@ rte_pmd_vhost_probe(struct rte_vdev_device *dev)
 
 	if (rte_kvargs_count(kvlist, ETH_VHOST_QUEUES_ARG) == 1) {
 		ret = rte_kvargs_process(kvlist, ETH_VHOST_QUEUES_ARG,
-					 &open_int, &queues);
-		if (ret < 0 || queues > RTE_MAX_QUEUES_PER_PORT)
+					 &open_queues, &queues);
+		if (ret < 0)
 			goto out_free;
 
 	} else
 		queues = 1;
 
 	if (rte_kvargs_count(kvlist, ETH_VHOST_CLIENT_ARG) == 1) {
-		ret = rte_kvargs_process(kvlist, ETH_VHOST_CLIENT_ARG,
-					 &open_int, &client_mode);
+		ret = rte_kvargs_process_opt(kvlist, ETH_VHOST_CLIENT_ARG,
+					     rte_kvargs_handle_bool, &client_mode);
 		if (ret < 0)
 			goto out_free;
 
@@ -1669,8 +1670,8 @@ rte_pmd_vhost_probe(struct rte_vdev_device *dev)
 	}
 
 	if (rte_kvargs_count(kvlist, ETH_VHOST_IOMMU_SUPPORT) == 1) {
-		ret = rte_kvargs_process(kvlist, ETH_VHOST_IOMMU_SUPPORT,
-					 &open_int, &iommu_support);
+		ret = rte_kvargs_process_opt(kvlist, ETH_VHOST_IOMMU_SUPPORT,
+					     rte_kvargs_handle_bool, &iommu_support);
 		if (ret < 0)
 			goto out_free;
 
@@ -1679,8 +1680,8 @@ rte_pmd_vhost_probe(struct rte_vdev_device *dev)
 	}
 
 	if (rte_kvargs_count(kvlist, ETH_VHOST_POSTCOPY_SUPPORT) == 1) {
-		ret = rte_kvargs_process(kvlist, ETH_VHOST_POSTCOPY_SUPPORT,
-					 &open_int, &postcopy_support);
+		ret = rte_kvargs_process_opt(kvlist, ETH_VHOST_POSTCOPY_SUPPORT,
+					     rte_kvargs_handle_bool, &postcopy_support);
 		if (ret < 0)
 			goto out_free;
 
@@ -1689,49 +1690,49 @@ rte_pmd_vhost_probe(struct rte_vdev_device *dev)
 	}
 
 	if (rte_kvargs_count(kvlist, ETH_VHOST_VIRTIO_NET_F_HOST_TSO) == 1) {
-		ret = rte_kvargs_process(kvlist,
+		ret = rte_kvargs_process_opt(kvlist,
 				ETH_VHOST_VIRTIO_NET_F_HOST_TSO,
-				&open_int, &tso);
+				rte_kvargs_handle_bool, &tso);
 		if (ret < 0)
 			goto out_free;
 	}
 
-	if (tso == 0) {
+	if (!tso) {
 		disable_flags |= (1ULL << VIRTIO_NET_F_HOST_TSO4);
 		disable_flags |= (1ULL << VIRTIO_NET_F_HOST_TSO6);
 	}
 
 	if (rte_kvargs_count(kvlist, ETH_VHOST_LINEAR_BUF) == 1) {
-		ret = rte_kvargs_process(kvlist,
+		ret = rte_kvargs_process_opt(kvlist,
 				ETH_VHOST_LINEAR_BUF,
-				&open_int, &linear_buf);
+				rte_kvargs_handle_bool, &linear_buf);
 		if (ret < 0)
 			goto out_free;
 
-		if (linear_buf == 1)
+		if (linear_buf)
 			flags |= RTE_VHOST_USER_LINEARBUF_SUPPORT;
 	}
 
 	if (rte_kvargs_count(kvlist, ETH_VHOST_EXT_BUF) == 1) {
-		ret = rte_kvargs_process(kvlist,
+		ret = rte_kvargs_process_opt(kvlist,
 				ETH_VHOST_EXT_BUF,
-				&open_int, &ext_buf);
+				rte_kvargs_handle_bool, &ext_buf);
 		if (ret < 0)
 			goto out_free;
 
-		if (ext_buf == 1)
+		if (ext_buf)
 			flags |= RTE_VHOST_USER_EXTBUF_SUPPORT;
 	}
 
 	if (rte_kvargs_count(kvlist, ETH_VHOST_LEGACY_OL_FLAGS) == 1) {
-		ret = rte_kvargs_process(kvlist,
+		ret = rte_kvargs_process_opt(kvlist,
 				ETH_VHOST_LEGACY_OL_FLAGS,
-				&open_int, &legacy_ol_flags);
+				rte_kvargs_handle_bool, &legacy_ol_flags);
 		if (ret < 0)
 			goto out_free;
 	}
 
-	if (legacy_ol_flags == 0)
+	if (!legacy_ol_flags)
 		flags |= RTE_VHOST_USER_NET_COMPLIANT_OL_FLAGS;
 
 	if (dev->device.numa_node == SOCKET_ID_ANY)
-- 
2.53.0

