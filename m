Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E5A9103A9A0
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 02:40:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1903240E12;
	Wed, 25 Mar 2026 03:40:31 +0100 (CET)
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180]) by mails.dpdk.org (Postfix) with ESMTP id 83ABB4027A
 for <dev@dpdk.org>; Wed, 25 Mar 2026 03:40:27 +0100 (CET)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-2b4520f6b32so2308489eec.0
 for <dev@dpdk.org>; Tue, 24 Mar 2026 19:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774406426;
 x=1775011226; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SHvyTLl5Ryy7ZPBy8BRoBW2iPF2MZ5pOx3G/cJDj5UM=;
 b=Pqy4jKxkquduUHiKHqIkcmxp2cmuHx6IF/nflzz7rs/VXUrEh3sLgHIYJK33DKkVQy
 cJNtVm3xtcrNpGSb+kbX5lf2HVsc1VJ8SoL9zmut9YP6zIk6aWEFZwOehibzeOlZmWu5
 T159H/q3j0/jsp5umfNGnEOFM/IYtV3P+1ajLvfnCLqYGFeS1/JhaTHlrzK/fIaB/mk6
 KAee/pqs7k1Gg7VlgaxL6UKwLpHQo0WmyBoIPjl05mV4jWDAVoyIj9bRZOe8TEAEbSJf
 eaWHOzPZ43Ux/JvKEFB6kbfDTQe/OyaOaFlyNVUD52C4Sdua0BOnsDH10VFa3neo0nra
 F8bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774406426; x=1775011226;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SHvyTLl5Ryy7ZPBy8BRoBW2iPF2MZ5pOx3G/cJDj5UM=;
 b=sM9EFIT+1JKuOuQrTZdIFKBrx1UH4KrhkiPKKGr3+EWwwvb/J6zv9tm2qZGg2T+gs7
 WOiziixo8so/0KvlWqBlMsvsIBYME59OWN7IJdjRUQAERi3+B1GV9rWO6upw3ZhPODvU
 iga13Y8Pp9Xy/h7NJe1aoQWAzWYRvR+6OpoRtJVXdxIu7PeScW4FjwG/enYHRT1mq007
 Bh+BFSPk9/g/BAkRcDbO2Mz8besNbZh20ythscpNlpaET+Ibt+ejcTiAww/CWYlEJiHE
 fK1vUAOEp8/vWFgXMLFf5doNnjlu1+Y7ll+6WjfaJHnbYbjAUjIeL2k3DrHQDZxC851+
 Y/zA==
X-Gm-Message-State: AOJu0YxX+8dH7JmJ3SzX+6ND31ph+MEZjTrfuUXacm0iFLzdbDyL9+yF
 aO4NN6u8o4STmOK4GQB7LjvNdB2+xeS5IWTvIFX/dJgKYmHXG71qbMXNM+NJNMsJE4aMO8u99Ya
 ui0da
X-Gm-Gg: ATEYQzzlh/8sw1ZLOFc32nQITGwfs/7yTkOyKtG6IXDOa16h0h9VTuETqETLpENEqpI
 EGCsxFRxxKjnkdE6T9wEG3Y8uu2XDe2GbDME7EominC5K34DaBGNBcFJ9rrCsm7zM5DSCnANph5
 Q8RgVrWhJGQyyHULMA48Aufzmy4jQQ28SlVhdr+L/Etbi7x7NkDbgZp9EfkubvovG3ErKrpceE2
 11spH3TIyW0wVL3q9skZ0VaKarGwCPu6YXEi329vKSsVa7DlyuW8aygNr5cK24+tg+iwMHufzZS
 8yy9vbwaQOaffdI1h21fedV6GSlkFUVL/j/7yAjZ2fzQxpyPputf8TSo60Q3VNykgSg9udWZKK9
 iG9FMfQJ2VZprZhPWG/64EKpsqUHxiYRzdWMisDveFoVxzX+Graha5FUWX/fQ4dxcHmqNIuoJO8
 PhmhXkedWyA/l1w/9ksju/6405XMo6Wp3t
X-Received: by 2002:a05:7300:641c:b0:2c0:e741:9d84 with SMTP id
 5a478bee46e88-2c15d493437mr851044eec.35.1774406426503; 
 Tue, 24 Mar 2026 19:40:26 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c10b29b447sm17209452eec.16.2026.03.24.19.40.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 19:40:26 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v21 05/25] net/pcap: remove unnecessary casts
Date: Tue, 24 Mar 2026 19:37:36 -0700
Message-ID: <20260325024018.1275209-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325024018.1275209-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260325024018.1275209-1-stephen@networkplumber.org>
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

