Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028C0F43830
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Apr 2026 14:48:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7A4BD4067E;
	Wed, 15 Apr 2026 16:48:17 +0200 (CEST)
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com
 [209.85.160.49]) by mails.dpdk.org (Postfix) with ESMTP id E1D0040661
 for <dev@dpdk.org>; Wed, 15 Apr 2026 16:48:14 +0200 (CEST)
Received: by mail-oa1-f49.google.com with SMTP id
 586e51a60fabf-40f0e14b9f9so4318519fac.1
 for <dev@dpdk.org>; Wed, 15 Apr 2026 07:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776264494;
 x=1776869294; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SHvyTLl5Ryy7ZPBy8BRoBW2iPF2MZ5pOx3G/cJDj5UM=;
 b=BQoi7vN+tRKeNaI7tlsokQMhXFpz+8TsPa3abXteX202QHiQgIkpdolLBIHUFhdg7l
 91nbWbQIRtBQaWCNrlmhhwjfxcfx+rseLAVMYT2XueTnQB3JJzqhNXkQHsg2QPIal1I4
 zjPrvFr7rh0WS6E8P4K+KFxC3ww4av1UvxuXYPR1xq/4WLcnLg4EKntvMtfvg15cb/dK
 y8PFvCyMzjb9I1dsMNwgw0YaeKxNj3K+j1ig6Ap52swtRm39Fg7IHpmhULJ5AIy8solY
 zWIXAQqgk9JpI3WDcjtlBjdAjjNwQG90gq7BY43wr0gAufBM3WHoWAiCbYREUQ4ZhuvL
 w0+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776264494; x=1776869294;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SHvyTLl5Ryy7ZPBy8BRoBW2iPF2MZ5pOx3G/cJDj5UM=;
 b=c23+kThT8DW/NXFRsWHgkexi4X9r0LfkYWxV5kxOt5IRcI93RwgulBPb7jRt0y87g/
 BfZP4UibADZ8gGu42wewdsiNqNLqaRTCU7/96HodimwKfe2Wv+2/YwN+oIsoDgM7qquk
 qJzFlAjTKebYRCfNrsK99Fet59dpdAtZ0y1+vlaZUyGtWy4qrWLXKZC9nqH61dRyworO
 B2QVcjLoYHZ63F7iTaDG7tnqQgUy2e4vl6GZv5a/3w9zxRwBIA8G0LQinC8R64KTlOrZ
 yyXB0XMTEDDjm18gFV6IaqnL/yvM7vEeNwI1e2LRuOz+Wl8TrORdV/CdLT743G6DVsL/
 DSDQ==
X-Gm-Message-State: AOJu0Yyldc05I9/mJkL+QUNhcV5QxM4EZGUyTU8llN7DI9asF6YGY+Mr
 o+CF4WqetnMXMPp9fy0RY9wxNyLhozCqPCunP5TKE0mcMnstuU8LkF+nU7KXCUFq9Oc8Cc0Z8K4
 TA7FB
X-Gm-Gg: AeBDiesQ5OWecWwDoWha0RgDyuh5cN7CihFaBFGXFuxR3/nCwylrZ/b0hiswRirYe+I
 qleq02VPmfX32IvDU+dLxYm19jVnywR4IewlqP11kqX3tM5kFjPJ5PfpAlz2jJ2sCehV+zxUy2/
 sJqikIQ10XWAgL8LXaIhX2TX4AADqZp0KishBEkGsvvoUU8JUi1AOwdtv09lk7JvcNyhsVoeZbx
 UpOtMdGBQH5K548OKBq457nGpssFP5+Z0TgDntmBzstHphifkG+iqfdpvawcVgMcXygI+Y8iLMn
 zVykMBFP6o6OXg/gzeNjRJ6bSH0rEfNuUSTEqy6Nfv0Mobhu7lH97z7+pqJH8TbvogBSoW5WstX
 kd/pN4zLdTH37capWyAaKKlBfMwRhtvvMZu/UWb69bz4pLX3APMf8HH6sGEFvv2eL4NSuEdXfHD
 jLY0Kg1z3z+e2pqngHp7LsAQjB6Tg4LX2EXz/xIjFTk3k=
X-Received: by 2002:a05:6808:3086:b0:460:f435:2a71 with SMTP id
 5614622812f47-478a1919df0mr11026668b6e.46.1776264493960; 
 Wed, 15 Apr 2026 07:48:13 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4797a53b1fesm945798b6e.16.2026.04.15.07.48.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 07:48:13 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v23 05/24] net/pcap: remove unnecessary casts
Date: Wed, 15 Apr 2026 07:45:54 -0700
Message-ID: <20260415144717.226161-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415144717.226161-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260415144717.226161-1-stephen@networkplumber.org>
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

