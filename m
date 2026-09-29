Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB462CA5FA5
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 14:05:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3F25E42E4D;
	Tue, 29 Sep 2026 16:04:26 +0200 (CEST)
Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com
 [74.125.228.41]) by mails.dpdk.org (Postfix) with ESMTP id 01AB942DA6
 for <dev@dpdk.org>; Tue, 29 Sep 2026 16:04:20 +0200 (CEST)
Received: by mail-pz2-f41.google.com with SMTP id
 d2e1a72fcca58-85469f204f6so2030882b3a.2
 for <dev@dpdk.org>; Tue, 29 Sep 2026 07:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790690659;
 x=1791295459; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Wy0LWLsrRgN2Tir69nk6vc0zGehOJuqPUdF+aOw17wg=;
 b=oaG9p0iqVd3aVX/UfPwDZ746tDNvr5L5MraFljRLuBogTT21iipq4TTVZke0xcuH4B
 xUNi0PT58qeCP3elbaI08A607KeGQEhm9nNPIrmkqEcCiHBpi/W/1Ryget4p+juj7jSY
 GSItbaGG1CN+un6Ci8Pd4sHjeQLdvFg939x7fscFB5Hq9UxIbzg5WUZCltTaIA9AyFhx
 ti9BF1ZFaPrZ/TJKrJ/72hdc5n1pEUz7sXkoCqHzZjAWKwRSey6OdEgL0RbMfj/72qVu
 +YZOLs/vh1qkzvawfFy0HMRe6u/PlXKnoj+xwA+FsmyRFE+D87htSgZQ14qigFQ8GPfu
 l/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790690659; x=1791295459;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Wy0LWLsrRgN2Tir69nk6vc0zGehOJuqPUdF+aOw17wg=;
 b=2TeyUWhFJ/asNQmDGbAqBsOgrfETPFJgwUWlZyrHbVLaNGOYQ6PuFAqUBCJ14snHFZ
 v0c+n5dDjjfEhH3kX6O0k/Pynz+RjYqqlCWgQJERD3grqWifbjIRo7bqoE0Ei2iX4yhH
 yWKx0jnTJunAVstNmmuORBHgZUdVJlojwHYRv/ZAlPawN0Fh5ObBu4wO9+w2eUaNd3yd
 u5HPIU2dUxEKsbI9IPTtFuGxeHpLKZ9tQjNwBzjqL4flqXk8/uDc3RNwag4wy6Ji/YUj
 bN6BK6JZ5Z44KVIpvIsMfiIKQfLoIYglIlhMxC8tdBeN0j5YIXcUSs6YU6RgDqrv71kk
 Ia6A==
X-Gm-Message-State: AFuF++nuWL70InHUU2s+il7Suy2ENzuyefyBIa+n6lV3ohEWUchnjNhu
 xL2iplHkLrmga38V+SGSCA4PUj8Dbdg3R15s7mqhXHqOqz83qZfNd7Jod6X19NWjxH3IUZ88MjF
 RK1dgME0=
X-Gm-Gg: AYBFou0UJY8mRR2Rt/oO8R7domgTFADuHWwfy8BdiG+/C/NYuye+8LD8zayb4XN1sUP
 AiuOtbDrux9XJbS/bXdIde8EKbZKzuD+vMGc7XOKgmb0ajdsO3KEE1LitrwMX7JnNx9FvoWAVLI
 Gv3qc2Tc786bGNpU+zjqlI2ntLpZcCdz4mRKIbWNctmB4XIPC3/A6h5U7eJbrk4ANiablOQcqMa
 cqPp/AJOlB1NMdPjysaxga+T/XSPH5W6omwG3toUZvlxKUIH1aJ5py/2dH5bSbWRnEUgQZgKir1
 HySiK2GwywBBhVX3R0AwXPs89oaSFDo4yJJpSRciZZxvuWlHnsJGRa69i+jF/TiG/nmesiiC3IE
 jFZudtymJtgFg9Sboy5/uPXDQst8/gOJ9WFpBilKupEw8AhiYk3IvPWA3JFRdDqEpazqH4PV32r
 fK1EWP1+xNm8veO03AbrvfxqIepsv6VPyrB/MjofQcdI+UHAxcUI4jBM7KMi8JCGjDeDOiTV9Oa
 AoOqvM7azpkmNuP7pn0TefTShe0KygH5h7MBcA4rR+fAFYx
X-Received: by 2002:a05:6a00:b44:b0:885:153:c3e9 with SMTP id
 d2e1a72fcca58-8850153d764mr3531815b3a.50.1790690659102; 
 Tue, 29 Sep 2026 07:04:19 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-885e1066470sm998330b3a.18.2026.09.29.07.04.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 07:04:18 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v9 07/25] net/pfe: use ethdev linkstatus helpers
Date: Tue, 29 Sep 2026 07:01:53 -0700
Message-ID: <20260929140409.234453-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929140409.234453-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260929140409.234453-1-stephen@networkplumber.org>
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

Rather than open coding with deprecated rte_atomic64,
use the existing ethdev helpers to get and set link status.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/pfe/pfe_ethdev.c | 32 ++------------------------------
 1 file changed, 2 insertions(+), 30 deletions(-)

diff --git a/drivers/net/pfe/pfe_ethdev.c b/drivers/net/pfe/pfe_ethdev.c
index 1efa17539e..1b183ab1f3 100644
--- a/drivers/net/pfe/pfe_ethdev.c
+++ b/drivers/net/pfe/pfe_ethdev.c
@@ -531,34 +531,6 @@ pfe_supported_ptypes_get(struct rte_eth_dev *dev, size_t *no_of_elements)
 	return NULL;
 }
 
-static inline int
-pfe_eth_atomic_read_link_status(struct rte_eth_dev *dev,
-				struct rte_eth_link *link)
-{
-	struct rte_eth_link *dst = link;
-	struct rte_eth_link *src = &dev->data->dev_link;
-
-	if (rte_atomic64_cmpset((uint64_t *)dst, *(uint64_t *)dst,
-				*(uint64_t *)src) == 0)
-		return -1;
-
-	return 0;
-}
-
-static inline int
-pfe_eth_atomic_write_link_status(struct rte_eth_dev *dev,
-				 struct rte_eth_link *link)
-{
-	struct rte_eth_link *dst = &dev->data->dev_link;
-	struct rte_eth_link *src = link;
-
-	if (rte_atomic64_cmpset((uint64_t *)dst, *(uint64_t *)dst,
-				*(uint64_t *)src) == 0)
-		return -1;
-
-	return 0;
-}
-
 static int
 pfe_eth_link_update(struct rte_eth_dev *dev, int wait_to_complete __rte_unused)
 {
@@ -570,7 +542,7 @@ pfe_eth_link_update(struct rte_eth_dev *dev, int wait_to_complete __rte_unused)
 	memset(&old, 0, sizeof(old));
 	memset(&link, 0, sizeof(struct rte_eth_link));
 
-	pfe_eth_atomic_read_link_status(dev, &old);
+	rte_eth_linkstatus_get(dev, &old);
 
 	/* Read from PFE CDEV, status of link, if file was successfully
 	 * opened.
@@ -601,7 +573,7 @@ pfe_eth_link_update(struct rte_eth_dev *dev, int wait_to_complete __rte_unused)
 	link.link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
 	link.link_autoneg = RTE_ETH_LINK_AUTONEG;
 
-	pfe_eth_atomic_write_link_status(dev, &link);
+	rte_eth_linkstatus_set(dev, &link);
 
 	PFE_PMD_INFO("Port (%d) link is %s", dev->data->port_id,
 		     link.link_status ? "up" : "down");
-- 
2.53.0

