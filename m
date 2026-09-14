Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19FFFC88E50
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 05:50:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BC06740A67;
	Mon, 14 Sep 2026 07:49:45 +0200 (CEST)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46]) by mails.dpdk.org (Postfix) with ESMTP id 907A14065A
 for <dev@dpdk.org>; Mon, 14 Sep 2026 07:49:44 +0200 (CEST)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-398a5aad413so2816909a91.3
 for <dev@dpdk.org>; Sun, 13 Sep 2026 22:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789364984;
 x=1789969784; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XruEIuYTFHNdSDMTzpl6cmn0qKhIkFM6H/T2ZITYK58=;
 b=T71FdxzGZNzfuwgN3IfRiEjHPPFAEX3uJy6QTDKsgPZV8lJySFVn4UgM85z1/nvpB0
 itnGiWqguijhyXvQ5muwoJt6IUvDhfVm8k6IG66opw63HVj7kkzWkzqna8HTbRU2IN5Z
 DyYuV1iUxEEu19K5k+pHPrXiqoRRck4cahUxk2sCR7ef2V9k0z7subZNOHw8VqT0aNR+
 D3qPZiryRol6EQF7eamK0IHufYKNZDkzf1lH4F9HjJ0BX9tn/Re9GPlI/sRFz6wcZBXw
 S4Zn6GGDvohEuFZ6+zGNaRWv8QyAEfg7KF30RcNoiLpoxfmjaaXbkbA0TZjF8CdAxsoC
 TKQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789364984; x=1789969784;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XruEIuYTFHNdSDMTzpl6cmn0qKhIkFM6H/T2ZITYK58=;
 b=Z9doOVq2VRITpQG2b97/gXOCeZI8QqI8NHHbkPO27aWc2EOLHxvq6yGP0zTiJmVEw+
 Xu51kCGZWjaEUq+KGm3gOz4QWCenPQKhAOgXH4RsDxCd6/KaCmYwg1yTADIt1Ih63EHn
 BELp/ARAb8bXKy2dY0HgMOWY/5RPhZLm56g+9xscCzpydYgCFscXV47x0bawMUyusDiO
 vk1GWhNr/5ji6ltAuONa6j+im2rq9NYHyMmYuQQBk1Q9+BLkwRagJmFvZ22n4hhHITV2
 +A71+IWjIdHr7iEcfPYLVbrWIAwewEvPmDXMAMHgI+PukLAXs8u8nz73dRd1+FaNa3VQ
 tk2Q==
X-Gm-Message-State: AFuF++nkpb3X99yBftp9berb97CvRHLocVY2iJcYeV03t51KoVho2N88
 jRhAFW1xEKdDVw4UIbSE0Lz9SWMwTLGKDIAHpXwoyGe03bD8Ms6wP/4jmiv5jN96MtiMToxxbm+
 EHmIQEfI=
X-Gm-Gg: AYBFou17WVA9ond6kddhsZvTfOh3idX+uPN6kWEcIjbakpVjK2fIR1yQeu9Vq9L0zwj
 IAr7+U6S58L8q+FO1eOATThtnQoi+qogvvtbDb2NHSL+YGmXNDYIavtozNOwd+w8Vf8BVMilYX1
 /s5n3tUjqZpy57FyTE/i992kgZCl3kkSNxK2JagySaoxrCaosYSZVeG0/w5Ri3BbLGStFuEPdZB
 FqxkmAm0VKw9BmXiElQc5JE8i8/2+nIMde4US6PwF4B5mE5vrl7bFTe5xW2uHfyfKGczHDeXvVX
 Mcxzx6Tr0M23HannnrYNHgqjP+XDyNXwaKpv+Lx3Nu+IxtStn79rLf5GhOubWZL2l2HqlDYtLow
 WLgo2PadvGp2af4CLf5ix9XZzbl2f6ARq/eorMbFheBwWc8x/H6vNp/3gU5OjMFqq9cLN2oJVaO
 QX1VqHdOaD1ulonMgWMRbbd6Cgl02OQVKWUwXxE/SarztA15hiMmsMRDUvVFV2uulUIyUScJ4eG
 q6ZMss3V+hsvOV9l43R5RB1j/IRZAzmQ6AwMA==
X-Received: by 2002:a17:90b:134e:b0:395:5f43:4ec4 with SMTP id
 98e67ed59e1d1-39debe21783mr2608825a91.0.1789364983599; 
 Sun, 13 Sep 2026 22:49:43 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d95864b4fsm19794492a91.15.2026.09.13.22.49.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 22:49:43 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>, Yuanhan Liu <yliu@fridaylinux.org>
Subject: [PATCH 07/62] net/vhost: use kvargs numeric helpers
Date: Sun, 13 Sep 2026 22:46:38 -0700
Message-ID: <20260914054912.755403-8-stephen@networkplumber.org>
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
index 05940f2461..a3acdcabb4 100644
--- a/drivers/net/vhost/rte_eth_vhost.c
+++ b/drivers/net/vhost/rte_eth_vhost.c
@@ -1585,17 +1585,18 @@ open_iface(const char *key __rte_unused, const char *value, void *extra_args)
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
@@ -1609,13 +1610,13 @@ rte_pmd_vhost_probe(struct rte_vdev_device *dev)
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
 
@@ -1653,16 +1654,16 @@ rte_pmd_vhost_probe(struct rte_vdev_device *dev)
 
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
 
@@ -1671,8 +1672,8 @@ rte_pmd_vhost_probe(struct rte_vdev_device *dev)
 	}
 
 	if (rte_kvargs_count(kvlist, ETH_VHOST_IOMMU_SUPPORT) == 1) {
-		ret = rte_kvargs_process(kvlist, ETH_VHOST_IOMMU_SUPPORT,
-					 &open_int, &iommu_support);
+		ret = rte_kvargs_process_opt(kvlist, ETH_VHOST_IOMMU_SUPPORT,
+					     rte_kvargs_handle_bool, &iommu_support);
 		if (ret < 0)
 			goto out_free;
 
@@ -1681,8 +1682,8 @@ rte_pmd_vhost_probe(struct rte_vdev_device *dev)
 	}
 
 	if (rte_kvargs_count(kvlist, ETH_VHOST_POSTCOPY_SUPPORT) == 1) {
-		ret = rte_kvargs_process(kvlist, ETH_VHOST_POSTCOPY_SUPPORT,
-					 &open_int, &postcopy_support);
+		ret = rte_kvargs_process_opt(kvlist, ETH_VHOST_POSTCOPY_SUPPORT,
+					     rte_kvargs_handle_bool, &postcopy_support);
 		if (ret < 0)
 			goto out_free;
 
@@ -1691,49 +1692,49 @@ rte_pmd_vhost_probe(struct rte_vdev_device *dev)
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

