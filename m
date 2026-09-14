Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1594C88E67
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 05:50:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 29BF340B9E;
	Mon, 14 Sep 2026 07:50:06 +0200 (CEST)
Received: from mail-pz2-f31.google.com (mail-pz2-f31.google.com
 [74.125.228.31]) by mails.dpdk.org (Postfix) with ESMTP id 405F340B9E
 for <dev@dpdk.org>; Mon, 14 Sep 2026 07:50:05 +0200 (CEST)
Received: by mail-pz2-f31.google.com with SMTP id
 41be03b00d2f7-cc1ceb47d55so143640a12.1
 for <dev@dpdk.org>; Sun, 13 Sep 2026 22:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789365004;
 x=1789969804; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KfhYT2P0n4ZSApbiklRCqGPigdGy6eIo7hNhOIzLAzA=;
 b=NOiVJMbivtnR2mwsf0qUdaXRIunEgLd1g3r9w9zc6pEYWM5YM2PANImUvrGelUKIa1
 6l0PSMNHduiXKUSvFHba3WSt5ljdmwQD4KtveSX0gYEyz1XkPfe+qQ0MO1lRaGeHTjYc
 GrtNy2U0r/JBSHbsIuFGkbHBgRE3jjQ1VycQ+dVZvIjsjh0MXC1eCII+BSGNHndfs5Z2
 IHluKA+KDcWJ5kgA6+naz4e+k9pXkz0O6u88RTpq0Ry0cBBD0YH2IS8yCHpM+Pkyfgjz
 8bP82AzJoAQ4dzeSf1zjSKt+hU7CD1Ye9oZdGZ//UfzRKiHIMUqbbbPqbX0whyzdbb4F
 1R6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789365004; x=1789969804;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KfhYT2P0n4ZSApbiklRCqGPigdGy6eIo7hNhOIzLAzA=;
 b=bkm9i/edj6Nf9J09jLOVpNVtyIpDbG7uUeRIMDE815smO7CdF6dJbwTm7a6VE9SKK0
 tmgrS0QZbpfbl5voVATkwi30ydexqpEhC/XE3pTDsMQ7PYNAlnZU2q9yVinAcdput1ii
 sMm8KLsdOIgzglGLyqr2zsJObtT1SNSK8HFuXqSI7qPW+P5C3Nr/6Y6XpnDbWNWzx+pf
 HBvd/yhuEdv9EJHsAQp38sd8CJRW5U54A845lYNP3LAiN8ri4uoiQH9El18LjoBc6ANx
 UuFtjiwBBK9B31EIesejGPtlYSSXFcBlVqBS4b1qHYxRJprTgR5QygSOG3xtK68KlJKC
 wQtg==
X-Gm-Message-State: AFuF++lirhnfEVDPThH1C1CcL6dAZsL60k9b3JrfFK54b73NDa671S1p
 bOll4pcVsVxzwLymMGwXjOqN19m6qsP4lvqx7nsJGgWvHiG6QEFbudlxF2zJZwWkgxkrpj+TF4o
 rHKCIra4=
X-Gm-Gg: AYBFou2Smpu2+AUQwkEpCgy3Q9bugpEriZet8yNj47VRUThgTGZQPIP9lyF7HfF6Hax
 oX186hxsQdjGAdUqfgTbU67O6iO8hg3j6IsCWqTB0MN6HAHIo5iTZ/vqF9Rf534f/FghuW7W5Qy
 Upt8cf5qyFkeekO43XA1ULpth8B1hpU+1zih/Di2+2ZnL//V5KIbU28OGz1ODPnBiFvxj1sxhUe
 PvLs1GFFcEQWnPse3w/GwwPvzhJUAtlyfGxDTYkvYEFlcDQ/KMjBtqUHJv6TRiWdooWl+9mBVAp
 Inzx+GI5Ikn2jAEwWPBp11w/EPUu7FwoMjdTOmZK/0MI31OwCia5g4tTh3G7V3yzm/NewbHQsP0
 dyKhuhp8oo3ADJeCcnnu0zXmRuka91mA7GY5dKYHB0h9wiogxKfIz5XV3DnmADlqlr/jC+1AW5C
 8FAxd+x51ooRUpqIYvDp3bFMPDaYzVngGKlm3K3mlFd5qm/aT1ECIpDAPzKHLweDo/OJzwBIjyD
 LfspUa9y54EarmHeZe9vRVNTcC1WNXMwGWWCg==
X-Received: by 2002:a17:90b:3885:b0:39d:b57e:b47d with SMTP id
 98e67ed59e1d1-39dec3f5508mr1229724a91.8.1789365004271; 
 Sun, 13 Sep 2026 22:50:04 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d95864b4fsm19794492a91.15.2026.09.13.22.50.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 22:50:03 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jakub Grajciar <jgrajcia@cisco.com>
Subject: [PATCH 13/62] net/memif: use kvargs numeric helpers
Date: Sun, 13 Sep 2026 22:46:44 -0700
Message-ID: <20260914054912.755403-14-stephen@networkplumber.org>
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
index 5d153c3a5a..807ff20e1b 100644
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

