Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91460F8D765
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Apr 2026 18:48:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D509440297;
	Thu, 16 Apr 2026 20:47:46 +0200 (CEST)
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181]) by mails.dpdk.org (Postfix) with ESMTP id 33C494066D
 for <dev@dpdk.org>; Thu, 16 Apr 2026 20:47:45 +0200 (CEST)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-2d8ffdc31d0so10770885eec.0
 for <dev@dpdk.org>; Thu, 16 Apr 2026 11:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776365264;
 x=1776970064; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SHvyTLl5Ryy7ZPBy8BRoBW2iPF2MZ5pOx3G/cJDj5UM=;
 b=pQD3TwVm9n3tPBAawNQrhZ3OQg7/KXKEAPEFJJTpX6VhxN1HswxYVVP1P6Q1xEmCsx
 FdaLC9sLDoNOaC5OTTqtvTGywl9d8/0kwlVvRf1kVHxtHE1VN08pya03fQz3mq+2rdka
 ZMigKE/q9BYX0FXKtVULcgN1G5//LM03RkdkJOw+5G3/a7KgPuTw7gf69387SN7YN+G4
 SAB3qXSkBrBgplxAFiJCkcdkbvtrx41+fhm43G7Q/eIkQMdIfrZZyGp1DvAuKjbupjen
 xMP4jYar9iiYpWveQrNcJ/Bl3+k4W25yDflJ56Jj6rdltWKDnNlv/+buE/NecffVbAVx
 wLcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776365264; x=1776970064;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SHvyTLl5Ryy7ZPBy8BRoBW2iPF2MZ5pOx3G/cJDj5UM=;
 b=VXhl+BQZrYwuHGqw71o4Qzet9WmmiIgrGmvCbBlSDExHapfJXU87VWXS3hiBcsyAou
 JRQGhRTVXiHuSP9OtvA9PDTfJfRBGeWUayLYOjLgkYZZ4JmvvkGjlI3teoNGp48OM0hp
 7avX6JTBG77hgfRtdXmmMvbutXRGukWqSSlWHsh3yWm7icZ+dmaNhLorNvli9RUgZUyb
 dGxBM+05gs6zqSFGBXZ9bBgmvlIMMu0tzk8/PleK0MPFNoGQ4m9QhIYs4UpZuPdkF5yn
 vlK8a0fQvsy8qF/Wztmpy09egZWIA0cq1l4MVIfoAnVWOAF94NABnt6ARD8Ai0yBdgEQ
 9a+g==
X-Gm-Message-State: AOJu0Yzg4X3hwAPcwgNVHdeVm/4bGLStZ2Vh6fvtjk1X+cHSjnRiMhU0
 QtN1MnTTRi6hZmZWON0DDYgMmtTyYTsVJ4FDHx15X5Ew8BT4RWjx8uwvXOSZPG7CsLxVR4MD11a
 XsMUr
X-Gm-Gg: AeBDievsn+uFYRYrYpkFHptQfm7XREKa0ZMfCTQUlBwu5em0gChMzW+ey5aUp11ZGfN
 W+oE+aUzz0xrHTvAMhhGZHZpRUiP/CFl03eEeuuMJUTnKW/tJAcVJ8HTNFlbPL3xW8sAqytgeuf
 1IMhrYYJ1ZnW+sHlna5VWwu5G2OoWWF6Tea+ozgkyuuna1GGUDKgfXIj7qQRxkifmjXm+Dc3vSH
 UV6PB7IGlDS1z3MNQneYtO9uxFjWZI1ah7yI0FRN3zTkPWL0nQzWhqyZPINQZQllODnTPLpDzwu
 ZuX/Bu+Lv60z9TfqHZmcq98aUDXn8eUMXIFxnULjkQ2pIvaekLYqHGLNaTs3wTyhwENDiiIpqdv
 xc+M0uc6BrKhbaR+Kx4EARKOWHwIGagPS5gH6Tycng5ulopFThJhdKJPBv+7xR97mzRtZuqc+Fy
 xVhHj3vE7Kfu0T0+JODlujTkNIbfB1KsyJbXcgGual5tY=
X-Received: by 2002:a05:7301:9f0d:b0:2c8:7172:3b7b with SMTP id
 5a478bee46e88-2e2e551716bmr272885eec.18.1776365264201; 
 Thu, 16 Apr 2026 11:47:44 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2de8c606222sm10741314eec.8.2026.04.16.11.47.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 11:47:43 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v24 05/24] net/pcap: remove unnecessary casts
Date: Thu, 16 Apr 2026 11:45:27 -0700
Message-ID: <20260416184731.1347342-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416184731.1347342-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260416184731.1347342-1-stephen@networkplumber.org>
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

