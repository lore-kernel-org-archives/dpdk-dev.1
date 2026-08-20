Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87B0C5DF81
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 05:23:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B660B40693;
	Thu, 20 Aug 2026 07:23:22 +0200 (CEST)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by mails.dpdk.org (Postfix) with ESMTP id 8772440693
 for <dev@dpdk.org>; Thu, 20 Aug 2026 07:23:21 +0200 (CEST)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2d049069377so15519525ad.0
 for <dev@dpdk.org>; Wed, 19 Aug 2026 22:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787203401;
 x=1787808201; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VP5AM/VofpxSHq+WOAcKHqdb/qfaELWVfK7pW3PfCQY=;
 b=JLMhgatdZPlELEYZwtlaz0Xqoj+ahuv5ZNJVP9zW5atwoBEXEGvg52sfTPtsM9i6GI
 45gCeuY4EStr+i+G4bE5ypRIhnGmjMBSJQSl9h1bqhVjK4L0ciMe9z08q4GnFguH3z+9
 iBpCdnpGPNanSgeW3Wafg0ZN/dCTyUfoJjc/g+dQ6JwzA/j5B1PKkdF/eKKnTbsYnhzv
 /Gfp2wQ3QOkZ6fQUrqQjxBu9fblneFEIz6CRkl/SdfFfqik5uv/tYREs9CXnFCHO2EFK
 B2UEc7PiHypuIh2hDYXtqscN81e6D5EI72nUcVnaXQWAm3uOtxYVEzSIfHjFIPfLc4T+
 Eb5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787203401; x=1787808201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VP5AM/VofpxSHq+WOAcKHqdb/qfaELWVfK7pW3PfCQY=;
 b=HbWGzJolVMXXRkjgewOSznP0VGuL+4l3W3M5Uh8EdcNvk9CW9vDoopdxh3EQgHLFrO
 4crIY8K5T3vVN+EySbJRrqsphFDw7XRiWSGYhoaPP0vna2oK3DFsJpfnGcQkc6K/yEQe
 t1BlkzdpUw1RHyl7S49IVM7tUyqdni11a99g31w0J2uZHvGY4BkSF8NdenNLbWBokdTj
 u73zvbH4xTjlYm2dHkGEOuuW1dWrbWvQ7Fr2KQsq6U44Ib5WObWUwQSuD5GhKY20YHRl
 Nj297TrRm9MkeFI6Fs7ZCF8y7GD93VlqJvcOsPkR0vuOKhACoetLSke0b6pkD5Rsdo1q
 lgpA==
X-Gm-Message-State: AFuF++lfBj2UR5QA7iOJze/k28g4t7aw5msTff/lHKuAviWduiYKIuNg
 yLI0lhmwCKZtibo7RqW4vFf8r7TzZoVwQ8aoptMVo3hfXOM4HXptwhShVwPcj/odG93eAJYiDkI
 /4LZV
X-Gm-Gg: AR+sD11xvI8xTD9TJ23b/b+RhDFBtLj+yy51iOvJCR5CW5vtfELKA81NzIvgd1rXfNa
 4mSjAzTrw6CZLtoMmzCvnJVvCBtNEQ0Z064wplho4DPFQyMXsWvB868mV22D5DdVpln3yIhOXk9
 5qnjNsHCEQRLaU9Dyht9zphSRdj8NarLaRqwqQHzA1lzbKwoGKAtmHGo4kcCH9wuR8+yCnc+5gZ
 bP9ucMnoqGlxWbkXX/TCDggrz9bvzhI9ZCqw7fBSpIes1dWDHDYK6RnYwqXtVS4XOc02ut+UtN7
 UgAm2c9laCN6lDCYQnVu13jCK02C0ICktlBpEFOr4+BlJ+hMFIThTu1vxGmS3zOv2ydjqVXaZdZ
 +hWGIFW89IkSHGCHXl65ziBrekxOjiDmOWJrYMdBdB6FDTQjSHRZ3JgutyxffQin8ndvqt2lO/n
 pBJUNuTrlwvZXXFgqFZi9EHI8ivaG60jShRIhq2DDJM1v82HwiW6gyxwYE4aJAeus8YBWnKPSHE
 9/a4GywZOr/rQ7BFhCN/E4pLF0=
X-Received: by 2002:a17:90a:da90:b0:395:4de9:b30 with SMTP id
 98e67ed59e1d1-39580a9aed7mr19959800a91.5.1787203400590; 
 Wed, 19 Aug 2026 22:23:20 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bef3bb5csm13700974eec.2.2026.08.19.22.23.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 22:23:20 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Sunil Kumar Kori <skori@marvell.com>,
 Rakesh Kudurumalla <rkudurumalla@marvell.com>
Subject: [PATCH 04/61] app/graph: replace rte_memcpy with memcpy
Date: Wed, 19 Aug 2026 22:11:54 -0700
Message-ID: <20260820052251.1453273-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820052251.1453273-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
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

Use libc version of memcpy for fixed sizes.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/graph/neigh.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/app/graph/neigh.c b/app/graph/neigh.c
index 3298f63c1a..16c8257724 100644
--- a/app/graph/neigh.c
+++ b/app/graph/neigh.c
@@ -91,14 +91,14 @@ ip6_rewrite_node_add(struct neigh_ipv6_config *v6_config)
 	memset(data, 0, len);
 
 	/* Copy dst mac */
-	rte_memcpy((void *)&data[0], (void *)&v6_config->mac, RTE_ETHER_ADDR_LEN);
+	memcpy(data, &v6_config->mac, RTE_ETHER_ADDR_LEN);
 
 	/* Copy src mac */
 	rc = rte_eth_macaddr_get(portid, &smac);
 	if (rc < 0)
 		return rc;
 
-	rte_memcpy(&data[RTE_ETHER_ADDR_LEN], smac.addr_bytes, RTE_ETHER_ADDR_LEN);
+	memcpy(&data[RTE_ETHER_ADDR_LEN], smac.addr_bytes, RTE_ETHER_ADDR_LEN);
 
 	return rte_node_ip6_rewrite_add(portid, data, len, portid);
 }
@@ -121,7 +121,7 @@ ip4_rewrite_node_add(struct neigh_ipv4_config *v4_config)
 	memset(data, 0, len);
 
 	/* Copy dst mac */
-	rte_memcpy((void *)&data[0], (void *)&v4_config->mac, RTE_ETHER_ADDR_LEN);
+	memcpy(data, &v4_config->mac, RTE_ETHER_ADDR_LEN);
 
 	/* Copy src mac */
 	rc = rte_eth_macaddr_get(portid, &smac);
@@ -130,7 +130,7 @@ ip4_rewrite_node_add(struct neigh_ipv4_config *v4_config)
 		return rc;
 	}
 
-	rte_memcpy(&data[RTE_ETHER_ADDR_LEN], smac.addr_bytes, RTE_ETHER_ADDR_LEN);
+	memcpy(&data[RTE_ETHER_ADDR_LEN], smac.addr_bytes, RTE_ETHER_ADDR_LEN);
 
 	return rte_node_ip4_rewrite_add(portid, data, len, portid);
 }
-- 
2.53.0

