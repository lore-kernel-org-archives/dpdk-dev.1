Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CCADC021AA
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Feb 2025 18:58:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9AF7B4060F;
	Mon, 17 Feb 2025 19:58:00 +0100 (CET)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by mails.dpdk.org (Postfix) with ESMTP id E1E16402A7
 for <dev@dpdk.org>; Mon, 17 Feb 2025 19:57:56 +0100 (CET)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-221057b6ac4so34931125ad.2
 for <dev@dpdk.org>; Mon, 17 Feb 2025 10:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739818676;
 x=1740423476; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5pOC/FqRASKAHeZBhAimHJ1l8ohTp5EPkO7j3wpeRcI=;
 b=wpwxZkm7r5u2HTuzVpNc8eTZH2qmJC3WpS72rJvSsB/1gdP6r6qUolXTOt54h2ziSM
 Yl6oC8MKMwIcIWsey5+AwIZKHOsDnMqmWixiMhDQnYz+lFsEE0C2wbygZCmWPZxV2ADw
 TJxf+6zdpYR5aIRfsgTXLuIy6rSHsLv6q7y0cGovc+RN6jVnqCUWJVgSPdaM0RND0rhA
 dRfkiJ6hy/d5TxrEuzrER/Busa4Tds4C+ThEuv5GwQ2kvsaRSPoROafLvZEqjhCxtmbv
 Bw3oH8RwBo360la3+rssD46qwaQxevSPe5SE0TZL1ZYYolfnHMDWwuzEe+Me4MvvBhlG
 gUQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739818676; x=1740423476;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5pOC/FqRASKAHeZBhAimHJ1l8ohTp5EPkO7j3wpeRcI=;
 b=be3IJIR8S1Xt+uTPVgU7kfMTKz4hrTK8uLsj9HzY2Px15QdbtjIyDl/QzcQJQyTweD
 wY7IUmPmJcGgR7PYqPgNtCbwwwLSfUgDlAGNpKcjTctDgVUl4yENktXuZxFdRvY3I8A9
 PgIUXC1ZxXi/B/kVpSCLDIzqpJggqILfvsJ4YMk/XOv9fN1L1dCTMwuLwxe4ayDvycGZ
 61ry7TRBzZEZYhuRudLXPH5y51tGtAtyohDYvFDgoJ4zRaUbfpNcHOZboaBeRzzap+rC
 gpVqwEPABflftZtbwlO+I2ZwB0FZZ0tGLG0wf4RnnUYzfW76CXe1XI9ivZNVVZuex7Yr
 NYwg==
X-Gm-Message-State: AOJu0Ywa6BgVu5meiesBaOrwqhm6O/hqtxjcDtuNgLl9rRu63cfgzDDm
 ZW5PJ/GM9obN3cWe74pCOLjyDpTkPtAkdRjBqeDowX2DWetYcmVYfBfzpKCjRa/q2b/aQczVGNx
 hvkY=
X-Gm-Gg: ASbGncsAenkmSQZrRE8ZRsuKWKlFrkXrgCnLNy/OH/kww27wvsoGdclEiwOEvEYfHGK
 YCqYgqpruHahhm0DgirNguxPi3KQXK2Yicm5UfZSEP6uEULhU+ADcNNpAjWZFgLm8xBzj8nOr2A
 dKY4nZmMe8SYecCny3VHFV/PHi5kCETTWC0c2aBKH0YUTtmdcbqmwhtdBP2T8k2Kj6gJ9e/GSlw
 X1B34hOo2nYJQAKXHtrGV7zHx59SB6ebQ0NaJkuolPl9psgeywq7/CDKUOTK8IC2NHMCvx1BVCV
 wrPxVRuwor7bzA/fDWiVR+nY7PmVJ+yj78JEig6+pvc34jCYo7J2oPcmTXGa5GyJFNxB
X-Google-Smtp-Source: AGHT+IEWtBnEfAb2OtyBmioXU8yPyqKosGfPXMFuAikBzvh+Xwwb1Ov/yKJKYlHt1voMbB20TxdcQg==
X-Received: by 2002:a17:903:2f88:b0:216:2259:a4bd with SMTP id
 d9443c01a7336-221040eb63dmr175367885ad.52.1739818676187; 
 Mon, 17 Feb 2025 10:57:56 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-adb57c5dc68sm7815149a12.9.2025.02.17.10.57.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 10:57:55 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC 03/11] net/ixgbe: remove unnecessary dereference
Date: Mon, 17 Feb 2025 10:54:02 -0800
Message-ID: <20250217185743.169778-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250217185743.169778-1-stephen@networkplumber.org>
References: <20250217185743.169778-1-stephen@networkplumber.org>
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

The expression *dev->dev_ops->vlan_strip_queue_set and
dev->dev_ops->vlan_strip_queue are equivalent in C.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/intel/ixgbe/rte_pmd_ixgbe.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/intel/ixgbe/rte_pmd_ixgbe.c b/drivers/net/intel/ixgbe/rte_pmd_ixgbe.c
index 15c28e7a3f..5a7d66d9b9 100644
--- a/drivers/net/intel/ixgbe/rte_pmd_ixgbe.c
+++ b/drivers/net/intel/ixgbe/rte_pmd_ixgbe.c
@@ -291,7 +291,7 @@ rte_pmd_ixgbe_set_vf_vlan_stripq(uint16_t port, uint16_t vf, uint8_t on)
 	if (on > 1)
 		return -EINVAL;
 
-	if (*dev->dev_ops->vlan_strip_queue_set == NULL)
+	if (dev->dev_ops->vlan_strip_queue_set == NULL)
 		return -ENOTSUP;
 
 	/* The PF has 128 queue pairs and in SRIOV configuration
@@ -310,8 +310,7 @@ rte_pmd_ixgbe_set_vf_vlan_stripq(uint16_t port, uint16_t vf, uint8_t on)
 				  RTE_ETH_64_POOLS;
 
 	for (q = 0; q < queues_per_pool; q++)
-		(*dev->dev_ops->vlan_strip_queue_set)(dev,
-				q + vf * queues_per_pool, on);
+		dev->dev_ops->vlan_strip_queue_set(dev, q + vf * queues_per_pool, on);
 	return 0;
 }
 
-- 
2.47.2

