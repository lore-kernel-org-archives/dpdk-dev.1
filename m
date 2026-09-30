Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B25C5CA5FC5
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 22:44:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F6BA42DE4;
	Thu,  1 Oct 2026 00:43:54 +0200 (CEST)
Received: from mail-pj2-f30.google.com (mail-pj2-f30.google.com
 [74.125.227.158])
 by mails.dpdk.org (Postfix) with ESMTP id 01D09427D8
 for <dev@dpdk.org>; Thu,  1 Oct 2026 00:43:49 +0200 (CEST)
Received: by mail-pj2-f30.google.com with SMTP id
 98e67ed59e1d1-3a4c6bfce73so896999a91.1
 for <dev@dpdk.org>; Wed, 30 Sep 2026 15:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790808229;
 x=1791413029; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1ML+YTzaEnpQDvccUJ/J1qNyPxHjM5V8vDFNCgkQMnM=;
 b=MJFPNe68ZlOZkqbvd0HVIt4YlAHotBuv5rUwNDH5BllcqpgkqlcWhee8U0qlcxGwez
 /f5YpecjDAI+pAUsdmWbo8Vs+ukywirbJA0L+8j1TYwHvUHsOGRE4KOojGo5hxThAK6i
 6gu0FqLh0pjqLInOXLt6ttiVJ6W6FL95UG6Qh01isEwYSYWn0Sqd/XXtAnVxgkVJglMC
 VqhwBzScJp4mJq7tBLo82OW/wXBFgrA3R1FT8bEa6CxHG2Q2qj0mU8B5dvYVAQ5BPGPt
 EGXSrtGMuVqtGJBOgLaXUDWQunRBY2/j0J5NMHJMp6GdrOKWHfu8qLHO3TcW1YAVuaKr
 YRqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790808229; x=1791413029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1ML+YTzaEnpQDvccUJ/J1qNyPxHjM5V8vDFNCgkQMnM=;
 b=uX3nRBpyY5t8i+8Xh9MFEVGrQKAE7/ujr4HL+bkfj1S7MKfaP2YRClJoscuw1r16wU
 PlgAZXIXy7Yu4US7SVzg3fR/4E7kvvf6shmGFEjsBKcrdUiram1MGBdBld4ynDlMoon3
 fRX8qi/8Pvv0xHvbZr3kaimx/O4PlWRiG9uvu1t0e7vuv2dF2agYRFhaxI7DFBVSzzFA
 2RDdmREDUWMXBNiy/+3GoiFRWzP15rfprMvwPg/5RtmGAxo6/lVxXXxGWQuVc0YcEMgQ
 dnlyQPoC0J5VtJN6FYlvjTHTOVuzPLiHu9mRNfOTnLwft3YCpjcHXssTOChhWtpchP/M
 chcw==
X-Gm-Message-State: AFq9FYJE50wxhDo3RLwtAjSDeiZu6tmqvRo+vRLLoJt/nnNEC+Cwm3EH
 Oll1rxAlGOBiXfJaWlMBKbqTgM7PKG1Dgv5EIKHt/kFSixLWQnGgir0MrMq86i+cw8wfiIudWuf
 1NyDBBgA=
X-Gm-Gg: AYBFou2T4dghVF18ovJpbcxzrbQq1oewNdoIJ8rzcJZ8wV7T4FnucqmmK7U54BZjJGd
 swueReoMacTLSkmIVxrQhH3+7CNBbxalPPZ5KIa95MdbWg715mRFddjHlq7FIvscJ87vo7TYlHU
 5sv4/jcQeAvxlH1eS36b/3wnmnSMSk+vmiiz5GbTubyVaQ5Cbq1u5x+kvjSF/Df0ngbqNtOaoiK
 az6qnhVYli2R8AG+y6ecNmc8ykCxMNlftHAUaN9f3nEOuIHcR/l0fF7VUTkBSsUXOSZr+4e5GnE
 GPWbDARKQA3wHFWcCnMt5wt3eUYzn1GDF+jj+Hnc/6PUUTnRBv8a0VIYhDNUQZwRIYQAUx4dsnt
 ztXHGa6sgSVVQLftALzKFqh81H0bsrtYhp9NRGTbG32hWGlTJ22C85Z+9D3M8ud6WN4psdfkpv3
 BiwSVb32TccERUX/koramw2lw61VOopHoBX6Z7C1MysnBWTj9M/Iu2xmEZyrL0/TGJ11vFsNmla
 TJfiEInpbo9iK2XJbmJXJ67+1JBgsJOM0TnqQ==
X-Received: by 2002:a17:90b:35c6:b0:3a4:b593:8657 with SMTP id
 98e67ed59e1d1-3a4d18e3b38mr2478325a91.49.1790808228645; 
 Wed, 30 Sep 2026 15:43:48 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f4371383sm1258985a91.2.2026.09.30.15.43.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 15:43:48 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>, Yuanhan Liu <yliu@fridaylinux.org>
Subject: [PATCH v3 07/65] net/vhost: use kvargs numeric helpers
Date: Wed, 30 Sep 2026 15:40:25 -0700
Message-ID: <20260930224340.58580-8-stephen@networkplumber.org>
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

