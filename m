Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DFB6CA5FA7
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 16:39:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 203B642E9E;
	Tue, 29 Sep 2026 18:38:41 +0200 (CEST)
Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com
 [74.125.228.41]) by mails.dpdk.org (Postfix) with ESMTP id 8E94A42E6F
 for <dev@dpdk.org>; Tue, 29 Sep 2026 18:38:21 +0200 (CEST)
Received: by mail-pz2-f41.google.com with SMTP id
 d2e1a72fcca58-8631d0023daso2278330b3a.2
 for <dev@dpdk.org>; Tue, 29 Sep 2026 09:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790699901;
 x=1791304701; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=T/WAQD5oaNv4lxfHcblbwU4iJfnsR7jKB5NaEQ4aPGI=;
 b=q+DqVwO8ghkC27fKIz/jGsGrj9Z1o/A7bsv48mR1Y2rvSvsOTj/mh/VgZI3LrQCZkg
 J1PjHU0L1dYOkZDkj5qHlTlJ1Lw9on3c5f5IXGznzGKET2v/lW3EoiTDHjvarIqniII4
 SHyxvuDbsYg0dHiWkLACo7B3+rqYV+pOGOCZvq/F2bLoWAcuF1UZIdB3zyQOJQgVN+M8
 qYteXI1eEZaL7Lt/NJzZjRO+0AgAeAPeBEUX1AaNQfXwcCxV1Ug01mSVBaQghctI4sr+
 3eARn98RV/EWe+PvbAyPVFM5Mb8+8XKn+b2JQaBtpDCTytfIT1mv345T7LoXjhs3Gndw
 M7fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790699901; x=1791304701;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=T/WAQD5oaNv4lxfHcblbwU4iJfnsR7jKB5NaEQ4aPGI=;
 b=Z4aSJ2mYHH8Nsbr+33diaSjJ7N7nmgGhZF1gZaVP37ebQVCWyxwWFRqMAkU6fZIrsB
 z7UFCkG7QmQfF3nCKcTGmHg7hOUoHZKDeRDEK19m0TILNkSTGLn7+9VK0im5/hwg8W8L
 9K24OS9syGAVTa8TMj1S1lVZsyUcnInZiXyu9YCFdQgczYfyccLvqqtuNDWTQgeF9AWc
 fFze2+i1V/BQ8J4Zk6V8gnJI3E26h/aCSevysvOxGWSHBAGVA4Jkq/Bo4QwHbnuY/C4M
 FtdRpevoJgcpXXEqdQvHJZyAVqAz59AswpV0it5mb0hNX1YdsWzk8BbDSWZ49U8yEKI5
 vVdw==
X-Gm-Message-State: AFuF++lRg8wSsPZb92y7tS11WtPKAf67I+VwE4mwY8+IMmTt0QO+wAwz
 c1A4+39xVKObTQFcclXy253SCVNwclCxdVr5WeV5PvCQfPLqDKnIXvCVpKh4ZKp3KceZGTCmCit
 /vC8HPNo=
X-Gm-Gg: AYBFou0/+wb9BJZC05i42+4EU+htxDa/N6rPy0vWjTanqgUl94v3X9T+Ytf08eHfs3I
 7h2/QGRuacw7LwdIQ6PImg5iOLj07QSHuHC4pY6isx6cygr9omd7foW9fPx+TSwSSASMBncuaQz
 MEJ8ynuuXlmDcwrlq3IJnrAH7r67gg8A8NZJTUQqD6cld4aSrfE4y5pzMAFZeiY1HqJAIThf5+C
 HiD1xy0VUECHcwNq5ZpBoQs3tsiVbzNFLOK9vOsUDWLFILqqAd2Zh2PRadONP70nB0BCFg7CuRb
 t9g5Rjncw6iCdDVzRWiM7+2HfUfxmvw/vrt5IUdtkatu9KrkYjhvuI4ahaTMzgXfHhZ3MeG0As7
 5IPMnDagWhrTAf7tJAzqOGo4DXMzW3aOiWZ6ZgQwrMj+bM8wcJt9vQLuRa1tZxsYPofhq4ON+7K
 QPSfqCvjrfTEY6DoIJQ6dpW0yS6/W+OyBrp+KIaPbNnxjVmcvJxOeD03S1Xf61WYeBMOM0S4Byh
 woABZsJXHBqya+OCZcs0RkYIgH/n5gFdky2YxDRlvQP2yuJ
X-Received: by 2002:a05:6a00:368c:b0:882:94ab:20ec with SMTP id
 d2e1a72fcca58-88294ab313fmr6512272b3a.25.1790699900674; 
 Tue, 29 Sep 2026 09:38:20 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8868ba02d02sm232392b3a.21.2026.09.29.09.38.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:38:20 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 14/61] net/pcap: use kvargs numeric helpers
Date: Tue, 29 Sep 2026 09:36:17 -0700
Message-ID: <20260929163800.1108305-15-stephen@networkplumber.org>
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

The open coded conversion is correct, but the same checks are now
available from kvargs.

process_bool_flag() duplicated what rte_kvargs_handle_bool() does, so
drop it and use the helper for phy_mac, infinite_rx and eof. The
process_opt() form newly enables the bare "infinite_rx" spelling: the
value == NULL branch of process_bool_flag() was dead, since
rte_kvargs_process() rejects a missing value before the handler runs.
The usual words such as "on" and "true" are now accepted as well,
while an empty "infinite_rx=" is rejected rather than taken as true.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/pcap/pcap_ethdev.c | 51 ++++++++--------------------------
 1 file changed, 12 insertions(+), 39 deletions(-)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index b1f3718c8a..df3a480f97 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -1584,46 +1584,19 @@ open_tx_iface(const char *key, const char *value, void *extra_args)
 	return open_iface(key, value, extra_args);
 }
 
-static int
-process_bool_flag(const char *key, const char *value, void *extra_args)
-{
-	bool *flag = extra_args;
-
-	if (value == NULL || *value == '\0') {
-		*flag = true; /* default with no additional argument */
-	} else if (strcmp(value, "0") == 0) {
-		*flag = false;
-	} else if (strcmp(value, "1") == 0) {
-		*flag = true;
-	} else {
-		PMD_LOG(ERR, "Invalid '%s' value '%s'", key, value);
-		return -1;
-	}
-	return 0;
-}
-
 static int
 process_snapshot_len(const char *key, const char *value, void *extra_args)
 {
-	uint32_t *snaplen = extra_args;
-	unsigned long val;
-	char *endptr;
-
-	if (value == NULL || *value == '\0') {
-		PMD_LOG(ERR, "Argument '%s' requires a value", key);
-		return -1;
-	}
+	uint64_t val;
 
-	errno = 0;
-	val = strtoul(value, &endptr, 10);
-	if (errno != 0 || *endptr != '\0' ||
-	    val < RTE_ETHER_HDR_LEN ||
-	    val > ETH_PCAP_MAXIMUM_SNAPLEN) {
-		PMD_LOG(ERR, "Invalid '%s' value '%s'", key, value);
+	if (rte_kvargs_to_uint(value, RTE_ETHER_HDR_LEN,
+			       ETH_PCAP_MAXIMUM_SNAPLEN, &val) < 0) {
+		PMD_LOG(ERR, "Invalid '%s' value '%s'", key,
+			value == NULL ? "" : value);
 		return -1;
 	}
 
-	*snaplen = (uint32_t)val;
+	*(uint32_t *)extra_args = val;
 	return 0;
 }
 
@@ -1932,8 +1905,8 @@ pmd_pcap_probe(struct rte_vdev_device *dev)
 
 		dumpers.queue[0] = pcaps.queue[0];
 
-		ret = rte_kvargs_process(kvlist, ETH_PCAP_PHY_MAC_ARG,
-					 &process_bool_flag, &pcaps.phy_mac);
+		ret = rte_kvargs_process_opt(kvlist, ETH_PCAP_PHY_MAC_ARG,
+					 rte_kvargs_handle_bool, &pcaps.phy_mac);
 		if (ret < 0)
 			goto free_kvlist;
 
@@ -1971,9 +1944,9 @@ pmd_pcap_probe(struct rte_vdev_device *dev)
 				ETH_PCAP_INFINITE_RX_ARG);
 
 		if (infinite_rx_arg_cnt == 1) {
-			ret = rte_kvargs_process(kvlist,
+			ret = rte_kvargs_process_opt(kvlist,
 					ETH_PCAP_INFINITE_RX_ARG,
-					 &process_bool_flag,
+					 rte_kvargs_handle_bool,
 					 &devargs_all.infinite_rx);
 			if (ret < 0)
 				goto free_kvlist;
@@ -1991,8 +1964,8 @@ pmd_pcap_probe(struct rte_vdev_device *dev)
 		 * Check whether to signal EOF via link status change.
 		 */
 		if (rte_kvargs_count(kvlist, ETH_PCAP_EOF_ARG) == 1) {
-			ret = rte_kvargs_process(kvlist, ETH_PCAP_EOF_ARG,
-						 &process_bool_flag,
+			ret = rte_kvargs_process_opt(kvlist, ETH_PCAP_EOF_ARG,
+						 rte_kvargs_handle_bool,
 						 &devargs_all.eof);
 			if (ret < 0)
 				goto free_kvlist;
-- 
2.53.0

