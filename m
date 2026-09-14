Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 462DBC88E67
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 05:51:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A38A40DC9;
	Mon, 14 Sep 2026 07:50:12 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id 768C240DD7
 for <dev@dpdk.org>; Mon, 14 Sep 2026 07:50:10 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-39b2ad83dc6so1767988a91.0
 for <dev@dpdk.org>; Sun, 13 Sep 2026 22:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789365009;
 x=1789969809; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Wdkap8isKBoLdl/KPS51zpmj/hYCUBTihMBW6lwMQ/M=;
 b=nz4VydCveZ/Fdb5e4mee6rUKJ25EvdfjEjz2B1mTyifccUCf7uiDrYu7NEIITiNG+0
 bH/NOCRrKuTFp2tR2BVI/r2bnkbtjJ2CbaqIrssfO1evHxjGz6KQhfjvB0y5Oy5Na6WI
 LqenFgX/LaBlVDM1o/03+lfjsFjjwwtu8i/Olth2ucQh/dCtHjiFROLDtMDRyeVmep0Q
 XBi+41V/Vy53FvUwsiIdJKw8MBRd/ciQF4A5JEKQlMO9nKMES5Leogdp23JEw4pVv05v
 K6Tz++2o7UbaoKnQ6dg34DMYxXPH5JMv7urOwrYdDThoF/Usr/Yi/5iFXfpDZTb+5Lty
 bebQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789365009; x=1789969809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Wdkap8isKBoLdl/KPS51zpmj/hYCUBTihMBW6lwMQ/M=;
 b=bf3A3EXAmpt9ZO7mfm07tMFjJl5e50GkOIBSk6NYx8Gd/1Ao34U80CZ3EsnzhNHUoQ
 vDaM6RGj+ubhsq7O/2Ic1PmU/OI72T++gDiuoaH70DT8Je8Zx+JLHrir4KC4A/VSMnSp
 lLyUOzZCye7lI1ohLud1pFOKERqZR05bDe36WJsZ9fLJMqIIou8tW+yIF7WUieSzVhL5
 0Ei1AjhQDMWi2xrQF121DrA6A8IwGaJh9LhMwlXJ4C7Ay2duAJch0c7blwd7zLx4McKF
 T7mpQvoAiqtQmeugiL3PUzhqjkuERLZF7zUC6p+rEiqHarOvOeErsxct35B34ySQiWug
 hvkQ==
X-Gm-Message-State: AFuF++kinvm5Ao5hGTg+yi9lDvBdRnC78eMi7pUuS6tBGzWjWLD1RNr2
 qM/o2Xd7+87zzOfevxkbEFpUP2k7m0c2/MSAhpakqG3C7E6Dd9b2EBgB5mD/bSKuyqXQNzTc79d
 We+ICNcM=
X-Gm-Gg: AYBFou0sUeH4uGm67BBY9fVwHGVra3GmrDuiWF21loWEX6SRt1P5jc+YS77oNYKWONT
 86KWZsxd+aH1lXgS1wY27V9XZvvVMlsZrrTZJCBkYwLWf1orYk8VkOtzGbc9icl9r25NIjN9Ik3
 j1po7XZHVVa00Fcf9QOTEiWEjgZO2bEObfs0tNBBDtBjgIMzez1lNMVj9PVIeu5wx4nxEnMJ1vB
 LU/FLeVyqNzhpXd9zfRj3doDG65f+yp4VKf03nL7+pqu+gNkRmXEQIx1UpdRB52B9lZ+jjJul8Y
 6r514RyZsXdrtpD0eEn7VKzxvEgkCgoNxHcUmoWzGKLG2wDwhdT7pGXpVuEqZjVrGdAEYWsYPGn
 UfSinkJNgRGEqKnI/wr3TcU0q6N6WpJDI3r1AB+k7GSjq5c5tRRS0k+mXOZHz3oHeNrJ0C+8oLR
 yEGSG4uTHFUcnuJela2o8TSlZMd117GQ0usvjcCoIgMSywOEzb6RHp0ewZgDSUonwfXdFU9wfo2
 CmnuYPd7xVnkoCNjv5rE3a1v2qZ9P1+EAbzatml/LlacjLi
X-Received: by 2002:a17:90b:3ec8:b0:39d:e43c:5a0f with SMTP id
 98e67ed59e1d1-39dec059046mr2463935a91.14.1789365009488; 
 Sun, 13 Sep 2026 22:50:09 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d95864b4fsm19794492a91.15.2026.09.13.22.50.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 22:50:09 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 15/62] net/pcap: use kvargs numeric helpers
Date: Sun, 13 Sep 2026 22:46:46 -0700
Message-ID: <20260914054912.755403-16-stephen@networkplumber.org>
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
index 08d3ab9e91..b262498f7d 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -1586,46 +1586,19 @@ open_tx_iface(const char *key, const char *value, void *extra_args)
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
 
@@ -1934,8 +1907,8 @@ pmd_pcap_probe(struct rte_vdev_device *dev)
 
 		dumpers.queue[0] = pcaps.queue[0];
 
-		ret = rte_kvargs_process(kvlist, ETH_PCAP_PHY_MAC_ARG,
-					 &process_bool_flag, &pcaps.phy_mac);
+		ret = rte_kvargs_process_opt(kvlist, ETH_PCAP_PHY_MAC_ARG,
+					 rte_kvargs_handle_bool, &pcaps.phy_mac);
 		if (ret < 0)
 			goto free_kvlist;
 
@@ -1973,9 +1946,9 @@ pmd_pcap_probe(struct rte_vdev_device *dev)
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
@@ -1993,8 +1966,8 @@ pmd_pcap_probe(struct rte_vdev_device *dev)
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

