Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C39C36010
	for <dpdk-dev@archiver.kernel.org>; Sat,  5 Apr 2025 15:36:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CCE3840144;
	Sat,  5 Apr 2025 17:36:37 +0200 (CEST)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by mails.dpdk.org (Postfix) with ESMTP id E598A400EF
 for <dev@dpdk.org>; Sat,  5 Apr 2025 17:36:36 +0200 (CEST)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-736c062b1f5so2430271b3a.0
 for <dev@dpdk.org>; Sat, 05 Apr 2025 08:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1743867396;
 x=1744472196; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2L2cBxBSuFLXuyUQsyuJWxLJPiJxQ3ZIw51aVollc+s=;
 b=E9Y3DJo9Ya6MoskFdWGZdse46iqFXBY4Psb9sNz8SIRALH2a8Pnlancc6gxHLjHQ84
 q+93B2bo9e69/pGQDdpQtiuQ7qBu0uF7g9j8RzfIJOpzxv0BXhZWZ2O6c+/+2J6UNeWZ
 PFgK/C+IjN0ChdSY5TJRLzhu5UkzaxZcVoGNd9gUQW97Ib6p1aZ8/6IhNzS0V7neghuu
 B4sLfOwNkjUKr1xct9kx531USJ6R46zNuy00ozQtTSg8wDEhiYOy+MTVzakAGf79lAKp
 RMREh20+6fTURnhIxaz4kdFO/cbA8/0QCoNQ7Ls1FLJUUOq7EuyRcIvLSxDNjJXUkxNP
 Hd1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743867396; x=1744472196;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2L2cBxBSuFLXuyUQsyuJWxLJPiJxQ3ZIw51aVollc+s=;
 b=jwpuKR1+oqG6tl/j1xhxixT7tLEAE39CPr6Ycyxu9bPtOXYqbaDOFlC7YhxjdAaZb9
 sYWfhKTkvfHiShAjn5/J+LEgoqQjfdWo2BRVJn7P79Nh3Zfb7hYd+9m7XfMZuK8qpV/B
 tHBZtFjaDk+agUhdrOswdCsJyUY2e9O0DBpKN8qpOlKg/0UTocXvRjhMZKx7UotTdXFq
 7l4ciCg6/634oDD+3bO/PvsA96qRfSSWc74vFLWa/5EqBNEsn3fvgg/A5Tz8E0+BPeDX
 Ivb/nSI1tKbWNgW1tbPNdGgx76PvBvbudqJ6EqByG4OcxESEQT9SUQuJ2+2XZmtW8ORY
 jo5g==
X-Gm-Message-State: AOJu0YzF7zZP9ojtdoz6mP858mxaO9PrXLr+nB04MaUDYOrCTc9T9RH7
 ONpR7inS/BFY5zM9AfgzLnqj9nGQAvnWF+LK/584jIjQbj6n4rFZn+QiHCaSJi8a/SM/a77Gd9i
 v
X-Gm-Gg: ASbGnctDACf0jiRwzvvrUQVCrfgu+1m2xFBUVTjfWOjdn7EdMs4oacQtbAFNGgpX8Ij
 w9Aud3/SI8fJJxccTWZP7WXYemeHqsVFEb5ImGhAmsuxO0EDjhrFfAaefXp93Y0+8RXpsjNf/fR
 XuJE2ErqhIH8a+PYTtS4ZLk/I/BUmoUo/Yk2jXJfNMKNkNcs9wtEJk+QgKPvapz5msbkpxBzBEE
 yIMHk5KTxIbjJxylrm2yDRtPnZln9xJ4DEizPi048v/RmfH9HVUcT45WSrYdbHv7JKbHs+cb3fY
 bhnGt6KbG0z5rfbjQD0cAuCM7Uk7oElsH0mpcIxhSYY/Nik2FP30GyQqYTgxl2f937IB6gUChkE
 jjyYXWpudo8ZYsINg84EZ
X-Google-Smtp-Source: AGHT+IE9eUoWs8GO3Z/E5r7T2gMG/8spUILEap4VjqHo6s8FSvgYq0itqxmmqB5b9tTJnngvUhtLhw==
X-Received: by 2002:a05:6a20:438e:b0:1f5:535c:82d6 with SMTP id
 adf61e73a8af0-201081b193emr11064157637.35.1743867395930; 
 Sat, 05 Apr 2025 08:36:35 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739da0b2cccsm5357070b3a.121.2025.04.05.08.36.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Apr 2025 08:36:35 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH] net/pcap: fix indentation and numa node
Date: Sat,  5 Apr 2025 08:36:23 -0700
Message-ID: <20250405153623.200771-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
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

The process private data allocation was indented incorrectly
in the source code, and had unnecessary cast. It is better
that the data be allocated on same numa node as the device
structure.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/pcap/pcap_ethdev.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 728ef85d53..aefa74c7be 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -1208,10 +1208,8 @@ pmd_init_internals(struct rte_vdev_device *vdev,
 	PMD_LOG(INFO, "Creating pcap-backed ethdev on numa socket %d",
 		numa_node);
 
-	pp = (struct pmd_process_private *)
-		rte_zmalloc(NULL, sizeof(struct pmd_process_private),
-				RTE_CACHE_LINE_SIZE);
-
+	pp = rte_zmalloc_socket(NULL, sizeof(struct pmd_process_private),
+				RTE_CACHE_LINE_SIZE, numa_node);
 	if (pp == NULL) {
 		PMD_LOG(ERR,
 			"Failed to allocate memory for process private");
@@ -1578,11 +1576,8 @@ pmd_pcap_probe(struct rte_vdev_device *dev)
 		unsigned int i;
 
 		internal = eth_dev->data->dev_private;
-			pp = (struct pmd_process_private *)
-				rte_zmalloc(NULL,
-					sizeof(struct pmd_process_private),
-					RTE_CACHE_LINE_SIZE);
-
+		pp = rte_zmalloc_socket(NULL, sizeof(struct pmd_process_private),
+					RTE_CACHE_LINE_SIZE, dev->device.numa_node);
 		if (pp == NULL) {
 			PMD_LOG(ERR,
 				"Failed to allocate memory for process private");
-- 
2.47.2

