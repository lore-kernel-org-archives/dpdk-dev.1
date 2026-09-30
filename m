Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B58CA5FC5
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 22:45:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A82C442E7D;
	Thu,  1 Oct 2026 00:44:00 +0200 (CEST)
Received: from mail-pj2-f38.google.com (mail-pj2-f38.google.com
 [74.125.227.166])
 by mails.dpdk.org (Postfix) with ESMTP id B941142E6D
 for <dev@dpdk.org>; Thu,  1 Oct 2026 00:43:57 +0200 (CEST)
Received: by mail-pj2-f38.google.com with SMTP id
 98e67ed59e1d1-3a4eda6744bso526517a91.1
 for <dev@dpdk.org>; Wed, 30 Sep 2026 15:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790808237;
 x=1791413037; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=g4ItmOeCrAFTzfYIHgcSk8XhV2lDKXWbaowKe1xzTwY=;
 b=Ad7pozU7HLL0x/QnKra8xRnejkZom6xnnnYf1Vlin7JixgwdDDKrPds6TDd4qI2vZv
 E0Q0+xTlEGD5j2xNgd3n+xApWer0FeSJ517f5oGpfymZUCws1Bd8cORr5fFjeroae3bO
 BC0TdJoaSQFoT2WiiZH4KV/iaKJUfZEMJQnhST3Tp8AiTKcBlV4bINYwJ16uKaFcbvzl
 Ab7a5+Sypj6nyKX+ZjFdOi3m8sERWs5RKyP29te9bmSiPD7L68SRDXv4A2w5vgHq/kWN
 t5Irl62Qdt0bYZdSs42XgciZt800BVWHQOptVMC86MJY/Vf9xr1JbYnNNxFlEkGDku4u
 VDSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790808237; x=1791413037;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=g4ItmOeCrAFTzfYIHgcSk8XhV2lDKXWbaowKe1xzTwY=;
 b=ysv3MHAf4wjIq4gpFB1mJQ4ciMrV7A2zl2XVgSC51ZHc8Rd5I3wsQ1idhRaaC7J749
 8ZWnaXFitOfmvNpqQ93CLOQJVS99XokeuommRwXgeiXHtl2Vlo4Elm75vdpgqChH8h4k
 yVFodsytEnBZTmsVcv5cd6Zodq/yJUVh1+ZhGDRc8rb/oFpy5VB1ZCynPzFcIBtMiTqY
 /FFz/xg0s4g8SB3h87VbcfkAmRIKthgK54x/AHd2ZGdsemCIHlw5JRL+ztYY/7BiL0f9
 Rcfri7675VaoC4/aO3aYZmYQSdlsp382OzY9X8IbRfk4vK37Du6oklhl7QnwBdoId3yN
 YwjQ==
X-Gm-Message-State: AFq9FYJiXJCBr4iiPtoqfIwZHV6osFYesJe8fVgkIEEgQK/oxJ2tMB9J
 P0flzArzcBweXeZ9m1jqQI+HWrl+5DDVZ0IjOPugzIfRqGjtph/9zq8XFQnbMVdTJXY79TQieji
 au79S9xI=
X-Gm-Gg: AYBFou2UDDXCltaGMImT3IdP/xS/jTx8MrrAnICIfDowbd43lPG/7cHLdWra7ZTm8PF
 qi3imq4fXfq5IBXbX9cEOY+nzdanHKKxiA+S9yyMe0J70lLNGbjc6ejaWby+mqsiZtjuDN/ImY4
 WGue7QbQp4g0rxZ0Vxpe13F+ztZpaMhogrKi07XYzW9sPMFG7e1PSwn7za5aAHSi/avnGGHXIjh
 PfGgi0HvbWo30sfMNmwqCckV1S7Ru8tZJC7eHaud6SL/W+/56Thd80U2e0tOXUBn9a/NWxZ0mpO
 SrbG9htY0ou19qHDdJRAUBsvIXsvlss8l54CRf8u3TBIMx3AjJ9yuQ628wuVmYVJTqlLd1HESvx
 rLHr0ywMLrNdWB0Hzg5q/juNWOrOdSExwZjavAbA0WVfhvp2m26rUsTps1kXmrHba3EdBTiBfhx
 TTuzAEcLAHHTu0If5zIlAweQLqdaMsQzoeZoi37loa2OFaB3WFGJfCO5ewerL5dSYrsP2RuKWQ5
 qsuAylMX3zfRGtpETfP7dhipjCp3m4BLRLqQA==
X-Received: by 2002:a17:90b:2f10:b0:3a0:7cbf:b8d2 with SMTP id
 98e67ed59e1d1-3a4d15008c6mr2391525a91.10.1790808236760; 
 Wed, 30 Sep 2026 15:43:56 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f4371383sm1258985a91.2.2026.09.30.15.43.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 15:43:56 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jakub Grajciar <jgrajcia@cisco.com>
Subject: [PATCH v3 13/65] net/memif: use kvargs numeric helpers
Date: Wed, 30 Sep 2026 15:40:31 -0700
Message-ID: <20260930224340.58580-14-stephen@networkplumber.org>
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

