Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A77CA5FA7
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 16:39:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3753242E90;
	Tue, 29 Sep 2026 18:38:39 +0200 (CEST)
Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com
 [74.125.228.41]) by mails.dpdk.org (Postfix) with ESMTP id E1F3142D27
 for <dev@dpdk.org>; Tue, 29 Sep 2026 18:38:19 +0200 (CEST)
Received: by mail-pz2-f41.google.com with SMTP id
 d2e1a72fcca58-85469e25400so1771505b3a.0
 for <dev@dpdk.org>; Tue, 29 Sep 2026 09:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790699899;
 x=1791304699; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=g4ItmOeCrAFTzfYIHgcSk8XhV2lDKXWbaowKe1xzTwY=;
 b=UoAEslx3sNM9izk7tLEPmWRg96SwYYbifxGg208rlV2Nzq06FBBVASSe/3pbQ8zSUV
 byIib2wgQbS+d+9AYk/VaS5c5hfwTKex4Q66o+kYPng+6yatjMeLYl1pJT1o2stmyjFT
 0tdLG1LTM6orvbbb4a1jiIHdxpy/lvjhJf9LtoPQi5I6eHK1itXq7GHhko19n6iVYeMf
 Uy54e2sHNaXcqI54gjNRT5woOJJPhCOFr5MGjW/m0Wr1SRWB6YpF3mTCQfIDLXes3XOI
 NClhQA+e/3VavAVORA1kLJg7J2p5L6uXvy3df14WEXJ6N+zD9zfJskcHhw3K9xhO+Jsj
 PA9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790699899; x=1791304699;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=g4ItmOeCrAFTzfYIHgcSk8XhV2lDKXWbaowKe1xzTwY=;
 b=adT9beFUebg+m18HvPF4/g9DDlA5EGkysGRh5RgENa9vuha06NvzlCV7FYCVGqhgKg
 m+oUkJKSAvq/tMwyQnxy8PRHRm24fQreTBeuscHFFqvySgTNexqKLh38w92nHJilZxnk
 6LXy8PsKQZLPsBm5XhIOOUHeITZZEqw+oKb4xzFLhl87yeHUt5LL3T1Ja9CjTl18WMC8
 PO01geP9iGKqUccHT/lU2FmflaM58z2ZoCf8fkAPesvShccwz8frtluP0h4awtXKsdJr
 atuOVGRTS7inKRfmiNNEd/yXxTmb2/5yNYH0zZ7aH7fo0u8IxLSg4nkFo3Hazdn/XfHd
 1F2g==
X-Gm-Message-State: AFuF++lB4x8DyjXUF0nKb3sNs9HAa83yitsd/ZhrzGOeumlRc0xgjJrv
 G5WTkfMf8yoy/MyNSJdAdKxWGopOqfn5wUzQWryG35RtvebUPhPkVmJ4N/N+8W50UD7eSQm74yP
 MEePhtag=
X-Gm-Gg: AYBFou3TdcAgmUxmNwuRvXxicO4GLM+Dyp0Sp7dXzh/EOz+hkyPD67oSx0ExyZLhch9
 qGyt5pPguiKx0B0PrA/6cydduKUY9U1Rh1eBfJ/hPjrdbpxK8MYUo59mAHohsLyRaTjXDQ0GrLv
 Dr0ZKhjBue9NdNlZD4hBBrJRGVrGMW2UtCaoQ8AkHgskQdz5J1oqXSYrLAF9WgVPJvlp4ZCuznz
 jDh/D4jkS0OoyG8ySfRCK9N2c02eSUJ4Hv/aIUCICKQ8aqKMMuXEYq1SZDmFjI27z2X2S3iTzoT
 GrnXF1gd7JdEZ31HdJybtI6vqt6DTplslC9yHGHX92s02owgo0q+X0FFoIGCs/CsVRxHKycXJcB
 n/7uYnZj6O7E3j0GTHpOvOVhNBbi5gikvW7UXuFNqlZEsqewTJZyW5mCpzxKK5BM5sXqyNxE/q3
 acFTq44GXbk/fdXGSGHCGLj57Z5Jf+PFaZZjVuDgAQ3zAuBGgie9YiU2/Sr43TpaWCcQ4QmL4tg
 IoYtgjnI8/1q3fQQnjCqNaRIN+2fhSBKL6kgw==
X-Received: by 2002:a05:6a00:1bc7:b0:874:705d:f63b with SMTP id
 d2e1a72fcca58-87e9b896b84mr13120200b3a.29.1790699899009; 
 Tue, 29 Sep 2026 09:38:19 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8868ba02d02sm232392b3a.21.2026.09.29.09.38.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:38:18 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jakub Grajciar <jgrajcia@cisco.com>
Subject: [PATCH v2 12/61] net/memif: use kvargs numeric helpers
Date: Tue, 29 Sep 2026 09:36:15 -0700
Message-ID: <20260929163800.1108305-13-stephen@networkplumber.org>
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

memif_set_id() dereferences the value without checking it for NULL, so
"net_memif,id" with no value crashes. It then ignores the result of the
conversion entirely, with a comment noting that zero is a valid id, so
"id=foo" silently selects interface zero.

memif_set_bs() and memif_set_rs() check neither errno nor the end
pointer, so a malformed value is taken as zero and rejected with a
misleading message, while an overflowing one wraps into range.

memif_set_owner() is nearly correct but does not reset errno before
strtoul(), and rejects UINT32_MAX which is a valid uid.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/memif/rte_eth_memif.c | 73 ++++++++++++++-----------------
 1 file changed, 34 insertions(+), 39 deletions(-)

diff --git a/drivers/net/memif/rte_eth_memif.c b/drivers/net/memif/rte_eth_memif.c
index 1c8dc1d5ec..212947c833 100644
--- a/drivers/net/memif/rte_eth_memif.c
+++ b/drivers/net/memif/rte_eth_memif.c
@@ -1807,45 +1807,42 @@ memif_set_zc(const char *key __rte_unused, const char *value, void *extra_args)
 	return 0;
 }
 
-static int
-memif_set_id(const char *key __rte_unused, const char *value, void *extra_args)
-{
-	memif_interface_id_t *id = (memif_interface_id_t *)extra_args;
-
-	/* even if parsing fails, 0 is a valid id */
-	*id = strtoul(value, NULL, 10);
-	return 0;
-}
-
 static int
 memif_set_bs(const char *key __rte_unused, const char *value, void *extra_args)
 {
-	unsigned long tmp;
-	uint16_t *pkt_buffer_size = (uint16_t *)extra_args;
+	uint64_t tmp;
+	int ret;
 
-	tmp = strtoul(value, NULL, 10);
-	if (tmp == 0 || tmp > 0xFFFF) {
-		MIF_LOG(ERR, "Invalid buffer size: %s.", value);
+	if (extra_args == NULL)
 		return -EINVAL;
+
+	ret = rte_kvargs_to_uint(value, 1, UINT16_MAX, &tmp);
+	if (ret < 0) {
+		MIF_LOG(ERR, "Invalid buffer size: %s.", value);
+		return ret;
 	}
-	*pkt_buffer_size = tmp;
+
+	*(uint16_t *)extra_args = tmp;
 	return 0;
 }
 
 static int
 memif_set_rs(const char *key __rte_unused, const char *value, void *extra_args)
 {
-	unsigned long tmp;
-	memif_log2_ring_size_t *log2_ring_size =
-	    (memif_log2_ring_size_t *)extra_args;
+	uint64_t tmp;
+	int ret;
 
-	tmp = strtoul(value, NULL, 10);
-	if (tmp == 0 || tmp > ETH_MEMIF_MAX_LOG2_RING_SIZE) {
+	if (extra_args == NULL)
+		return -EINVAL;
+
+	ret = rte_kvargs_to_uint(value, 1, ETH_MEMIF_MAX_LOG2_RING_SIZE, &tmp);
+	if (ret < 0) {
 		MIF_LOG(ERR, "Invalid ring size: %s (max %u).",
 			value, ETH_MEMIF_MAX_LOG2_RING_SIZE);
-		return -EINVAL;
+		return ret;
 	}
-	*log2_ring_size = tmp;
+
+	*(memif_log2_ring_size_t *)extra_args = tmp;
 	return 0;
 }
 
@@ -1917,21 +1914,19 @@ memif_set_owner(const char *key, const char *value, void *extra_args)
 	RTE_ASSERT(sizeof(uid_t) == sizeof(uint32_t));
 	RTE_ASSERT(sizeof(gid_t) == sizeof(uint32_t));
 
-	unsigned long val;
-	char *end = NULL;
-	uint32_t *id = (uint32_t *)extra_args;
+	uint64_t val;
+	int ret;
 
-	val = strtoul(value, &end, 10);
-	if (*value == '\0' || *end != '\0') {
-		MIF_LOG(ERR, "Failed to parse %s: %s.", key, value);
+	if (extra_args == NULL)
 		return -EINVAL;
-	}
-	if (val >= UINT32_MAX) {
-		MIF_LOG(ERR, "Invalid %s: %s.", key, value);
-		return -ERANGE;
+
+	ret = rte_kvargs_to_uint(value, 0, UINT32_MAX, &val);
+	if (ret < 0) {
+		MIF_LOG(ERR, "Failed to parse %s: %s.", key, value);
+		return ret;
 	}
 
-	*id = val;
+	*(uint32_t *)extra_args = val;
 	return 0;
 }
 
@@ -2032,15 +2027,15 @@ rte_pmd_memif_probe(struct rte_vdev_device *vdev)
 		if (ret < 0)
 			goto exit;
 		ret = rte_kvargs_process(kvlist, ETH_MEMIF_ID_ARG,
-					 &memif_set_id, &id);
+					 rte_kvargs_handle_u32, &id);
 		if (ret < 0)
 			goto exit;
 		ret = rte_kvargs_process(kvlist, ETH_MEMIF_PKT_BUFFER_SIZE_ARG,
-					 &memif_set_bs, &pkt_buffer_size);
+					 memif_set_bs, &pkt_buffer_size);
 		if (ret < 0)
 			goto exit;
 		ret = rte_kvargs_process(kvlist, ETH_MEMIF_RING_SIZE_ARG,
-					 &memif_set_rs, &log2_ring_size);
+					 memif_set_rs, &log2_ring_size);
 		if (ret < 0)
 			goto exit;
 		ret = rte_kvargs_process(kvlist, ETH_MEMIF_SOCKET_ARG,
@@ -2053,11 +2048,11 @@ rte_pmd_memif_probe(struct rte_vdev_device *vdev)
 		if (ret < 0)
 			goto exit;
 		ret = rte_kvargs_process(kvlist, ETH_MEMIF_OWNER_UID_ARG,
-					 &memif_set_owner, &owner_uid);
+					 memif_set_owner, &owner_uid);
 		if (ret < 0)
 			goto exit;
 		ret = rte_kvargs_process(kvlist, ETH_MEMIF_OWNER_GID_ARG,
-					 &memif_set_owner, &owner_gid);
+					 memif_set_owner, &owner_gid);
 		if (ret < 0)
 			goto exit;
 		ret = rte_kvargs_process(kvlist, ETH_MEMIF_MAC_ARG,
-- 
2.53.0

