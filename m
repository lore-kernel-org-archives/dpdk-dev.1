Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B56F8D766
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Apr 2026 18:52:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BC5C740A73;
	Thu, 16 Apr 2026 20:51:56 +0200 (CEST)
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182]) by mails.dpdk.org (Postfix) with ESMTP id 408C54069D
 for <dev@dpdk.org>; Thu, 16 Apr 2026 20:51:53 +0200 (CEST)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-2de831d2b20so4433024eec.1
 for <dev@dpdk.org>; Thu, 16 Apr 2026 11:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776365512;
 x=1776970312; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SHvyTLl5Ryy7ZPBy8BRoBW2iPF2MZ5pOx3G/cJDj5UM=;
 b=0Q7WDUYLakQ6ctimhU2uMsWqXJhFBJwTEE+/wDMeTY6el/kqr3I7nJa+z0L5boOGai
 K9p1apOv76I9TsFcY3YZjynTmjA6HKdMSGAmTNKZFKEjiVySMHjGS5qJwXbXNIogQMUZ
 Qr/GyglXk6D8J8OH9x9FlqFfNshY1qi3gpYBWizpYOMBj8ALNwgXTxjOLa8T7A7l74Q1
 zF+IlAMjv0u7VjuRQIg6kmo1FTuhCMumpX/PO3lf6gf9wkugyU/HitRWdIl2ra7UgWpL
 zyhgZOLop+19V8Zb+76zqBoz7ct68agYlnd/E//OBn/FMoi0PXLaWPaZEwJ2Ywmhr6FW
 f0Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776365512; x=1776970312;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SHvyTLl5Ryy7ZPBy8BRoBW2iPF2MZ5pOx3G/cJDj5UM=;
 b=Re1sxP4srftIK+AqS6RLE2HQrDd16tkSaEp12xmRuPqp5KQkqi5O1Inee2vfRG1xJl
 zsEfgf2540Y7ceMqMutfOXIlM9swYCk7Yj0eyJoYyEtAFX8Ot0JhhS8mUbB0mJmcOP98
 M4tIyrdcyEf8IWlcBmEbWHuYVCCvJxnz7N7/5czo5by7MT1jq3plX5j+L166RJNPfxhc
 ihGAQBWIqGkjddyT2i3CQXn5BdrdOEta4KnlvSwDTsPNYceRX1zV6cn2sMrpPsfsSw2U
 LIKbmwHfEB9DstLzbXQrcHfqIqsM76yAXvZTsNbEObNz9U5K40fLixRJv5HJnFS448LI
 X6Eg==
X-Gm-Message-State: AOJu0YxlSykzAhBtEYCorDTPF7QJnKXr+zcdHi4xqO81cCVjN5KebAPb
 DaMPJCy7UJH4GPNIIn7wLPumevmcm/6no/hSkyigX2hZPfoAGqw7VxPTahMP96Ulwte7tOv3rgH
 Vw9wX
X-Gm-Gg: AeBDieslOvdnwAUS76RQITfwoUG6wqTRRQJ/5dwrxSy9XLUrq07dJQo+uabarnHcccG
 kxnFjXbOBWL6REi5eD2oLQQgMnlfdnmMfPlqvm+i9WBwDk4HhGwbXCg1osgr9xjhvMpUoRRcheT
 9ihgVYdmqu4zLyINJvLRG/GY5VzIi/gnBAS7NxbOK30OQ7KMTXC7+klFaBsGyXaTOUoqDAIfcfF
 RwWYHGxsF0mH+GFYO9qL3OuQr4lt6JWVyHq63BFaeVJjXLKGO02taKc0b4jJjTwIiX21Pc8c3Mu
 5gAGMwZAAH4/i5H+QJXNOkSEId3y9LYfqRUd5Tp3TqhM2ulJVNVKI1grAZOkX03FxaPmp3wb332
 fgPyCxhA+2rrJp5m4FSeWUg72GDP0x6PbrFsUBTSiHTp7nwa1YDEwP7c2u39HXTfa1S4eGNyNKj
 g931Og6FXPrXZFtlTirtZB7rIPUOR3lEndCpE8nNzjwGwk+4j7KaLTPQ==
X-Received: by 2002:a05:7300:5783:b0:2d2:129a:1682 with SMTP id
 5a478bee46e88-2e2e55170a6mr237557eec.16.1776365512357; 
 Thu, 16 Apr 2026 11:51:52 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2de8f6615d5sm10602510eec.24.2026.04.16.11.51.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 11:51:51 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v24 05/24] net/pcap: remove unnecessary casts
Date: Thu, 16 Apr 2026 11:48:22 -0700
Message-ID: <20260416185144.1359260-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416185144.1359260-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260416185144.1359260-1-stephen@networkplumber.org>
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

The function rte_zmalloc returns void * so cast is unnecessary.
Use numa aware allocation and add tag for tracing.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/pcap/pcap_ethdev.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 4513d46d61..d6fe062b92 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -1217,13 +1217,11 @@ pmd_init_internals(struct rte_vdev_device *vdev,
 	struct pmd_process_private *pp;
 	unsigned int numa_node = vdev->device.numa_node;
 
-	PMD_LOG(INFO, "Creating pcap-backed ethdev on numa socket %d",
+	PMD_LOG(INFO, "Creating pcap-backed ethdev on numa socket %u",
 		numa_node);
 
-	pp = (struct pmd_process_private *)
-		rte_zmalloc(NULL, sizeof(struct pmd_process_private),
-				RTE_CACHE_LINE_SIZE);
-
+	pp = rte_zmalloc_socket("pcap_private", sizeof(struct pmd_process_private),
+		RTE_CACHE_LINE_SIZE, numa_node);
 	if (pp == NULL) {
 		PMD_LOG(ERR,
 			"Failed to allocate memory for process private");
@@ -1284,7 +1282,7 @@ eth_pcap_update_mac(const char *if_name, struct rte_eth_dev *eth_dev,
 	if (osdep_iface_mac_get(if_name, &mac) < 0)
 		return -1;
 
-	mac_addrs = rte_zmalloc_socket(NULL, RTE_ETHER_ADDR_LEN, 0, numa_node);
+	mac_addrs = rte_zmalloc_socket("pcap_mac", RTE_ETHER_ADDR_LEN, 0, numa_node);
 	if (mac_addrs == NULL)
 		return -1;
 
@@ -1590,11 +1588,8 @@ pmd_pcap_probe(struct rte_vdev_device *dev)
 		unsigned int i;
 
 		internal = eth_dev->data->dev_private;
-			pp = (struct pmd_process_private *)
-				rte_zmalloc(NULL,
-					sizeof(struct pmd_process_private),
-					RTE_CACHE_LINE_SIZE);
-
+		pp = rte_zmalloc("pcap_private", sizeof(struct pmd_process_private),
+			 RTE_CACHE_LINE_SIZE);
 		if (pp == NULL) {
 			PMD_LOG(ERR,
 				"Failed to allocate memory for process private");
-- 
2.53.0

