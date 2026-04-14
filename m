Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2FA2F9D0E4
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Apr 2026 16:10:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A63A340674;
	Tue, 14 Apr 2026 18:10:23 +0200 (CEST)
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com
 [209.85.160.43]) by mails.dpdk.org (Postfix) with ESMTP id EE9224066C
 for <dev@dpdk.org>; Tue, 14 Apr 2026 18:10:20 +0200 (CEST)
Received: by mail-oa1-f43.google.com with SMTP id
 586e51a60fabf-4094b31a037so3869459fac.1
 for <dev@dpdk.org>; Tue, 14 Apr 2026 09:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776183020;
 x=1776787820; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SHvyTLl5Ryy7ZPBy8BRoBW2iPF2MZ5pOx3G/cJDj5UM=;
 b=v7lSEnjyr9EygZndzuar48mMhLIPhE/jmt7kyqLabwpFb/eyHNvNPEiAI5GbOO3O8t
 QxTpM/8zbPMfC70MZLpdEuE0AWGYX24F4ZGkpJqGy5yUGoJrRoYv6F7dDqFuPvrZG3UK
 FhQ8hBpcE3GGfUI7vxxuaJ1ZHRe3M2v2rRRoZv2njQx0lnlRqJ4GvdI1ITXyvWthmXxj
 7QyD1flgco2yUODb6umSV+xfo8nlkIkaX5pVplaumYa5UWUXIE63sAFFrL6rv6YfED4H
 UvT2MnUyOjRRWrhgScltIOf/EgUVNYKdrM6CYZRWAZdoZ8z2FqT2g5lN6NcaiH/go4rE
 5oBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776183020; x=1776787820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SHvyTLl5Ryy7ZPBy8BRoBW2iPF2MZ5pOx3G/cJDj5UM=;
 b=qbKalZcPVR2nhJFy3WlVEs0ES6Voijp2K6ys2Qm/qejE0GBJPvzV8e1XjDuKlqQELJ
 vzkuPSyWtU1Cqdgyw4D/nrnClh6tfr8mcd71Sv1c0gKN0NYN/GK/i7KvSODs4UBEz/6D
 71qWSucYppuez82qNxhJ9xfNPbnJSKVApup/vcv4eYiwaLj1GspdV7BSMBuYQ/D7XZf6
 Yz1UMr3l5IhG0N4+ByDPWdFIxMLfl6gNJsU+23tOmtXhUFK5S1DSrlgsK7ECnNCXSUwh
 8S7FfVhtWBrXNPrcO4YFup+ZivPIDkJYoH4n1U86qLOKGwyzI+OF3WzBXaOqq4F5BJUI
 Mxfw==
X-Gm-Message-State: AOJu0YwB3Le/4E0Dv3RCwif7zHoLhwPG/1UIBVNKPlwbXjREFUUpRw4M
 2CfGQiNwY5iAldtgXQlKmPSlGy1XxzS7mxx0CY6NxQsL+vcBL5B+xQZKhatNdNslyyYfAO3CDHd
 xJKoS
X-Gm-Gg: AeBDiesm8fOSnwC1zmMA3kdRVmEX0HiGRF4Jvl1wudCoDb33U0JfWmag8Bv5a8ZZcGJ
 gr1Tk6bTcTjxmQVMEn0jXP7T3VlrjZvOGBQ1uM8/B8RHg1G5GbkUEzY70ytOINFgAZNBfj/U9Jh
 qOS09bhuCa8Z/SjsslMWqXZ1q3bUVBz4Zxq1JtkcJN+YBmkGJIM5jtqzfPFRkTg9YFhbG3zI//9
 81aHCg262zVETW6W6m1MSoWOoRUv4sZY2XvvlK6fA4rCjScpgPmzZ40AjBU7Qgh+qH0Y4/ptdrl
 wIcD2xhmE31Flka+c5Vg9rBOqUbeeaqKYJ3ENAY6DRGk/KKPYaLX5Znj4GgAdaTv7bby29586ww
 ixpsodurs07TZKorNcthJ5kPrWK8nyH4tH/TOZSCXpFmx2rquEQHbLMCjljJSL2YUeQJTUqYeDH
 f45HPCfu1CIvuqnGe1jG04C4mpMgnhY2W9U8cp4CQ63zY=
X-Received: by 2002:a05:6870:d14a:b0:424:2672:445f with SMTP id
 586e51a60fabf-4242672ab18mr5563294fac.18.1776183020157; 
 Tue, 14 Apr 2026 09:10:20 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-423dd396960sm11809554fac.2.2026.04.14.09.10.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 09:10:19 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v22 05/24] net/pcap: remove unnecessary casts
Date: Tue, 14 Apr 2026 09:07:56 -0700
Message-ID: <20260414161011.756101-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414161011.756101-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260414161011.756101-1-stephen@networkplumber.org>
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

