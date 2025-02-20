Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B717DC021B0
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 02:35:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F267240430;
	Thu, 20 Feb 2025 03:35:29 +0100 (CET)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41]) by mails.dpdk.org (Postfix) with ESMTP id 00195402D3
 for <dev@dpdk.org>; Thu, 20 Feb 2025 03:35:24 +0100 (CET)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-2fa8ada6662so881558a91.1
 for <dev@dpdk.org>; Wed, 19 Feb 2025 18:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1740018924;
 x=1740623724; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5pOC/FqRASKAHeZBhAimHJ1l8ohTp5EPkO7j3wpeRcI=;
 b=eTCyu3K9+xC90f3ADJB8VOed+gmniamHvw5rW0zK6m1Foj4vRZcto5b4S7acBN9eFj
 6yilCp9zDy/0r8u1JS8usEEeMfZLj8jrQC/1i5trGr5/xawaEpnvJ195uhUGTxOhQPoO
 CfBaybJ+k5MLXnyyElh4tgUmbn9VAN1R7KPFBWuUh2jcNRSebiYdP2UxvanS/iOnBpol
 5pOFQMsJWV9kXMwqUXVCNRlP7VUDwNJNe3LKr0YWr7UvZhjPMKjHFiIv3BS9Eaytbl4J
 5gHna64tRZNVnyaDj2QGZGq8UWNsMPE4EBxtgLRBQ1lVTkW8n9BYa2CXMpLOHYCsGP21
 gzQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740018924; x=1740623724;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5pOC/FqRASKAHeZBhAimHJ1l8ohTp5EPkO7j3wpeRcI=;
 b=Oifwd94QrpzAf2KrGp+18IP/kQvbZ2FEe8cfZCDgYFrAU0jOdFjbTyGSaX7Dl+0M/v
 GFjLdSDE8gvLZRysVaLCjOYt1tADxGPk7h+HLTXpcN/TsmHyRfZp0vmKdUWAno450PHC
 z+Xiet6S2iUTUEhdehNLHEPPjb++olJS0eQ0ZgBO1/vo0Hdb5MjJdEUMSq5epmczVtWF
 YzPX5sWBlqTO4d87EYXk8ACEZ62BpYSVoiStvDL+OZasLVp863fOf1rqH93/NolDsAtX
 b+UI9BG3ATfZrioYI26CGVlNqcvsSxW6Q8a+TpiOYIjCXeAhWdLgYnErL872oyPwcRlU
 FuDQ==
X-Gm-Message-State: AOJu0YzQE/QApaAdnoGtHyxPnAKswDaUwyPDsf7ssekBFuanlLYDifuB
 CyHFIAoaKmL/iiuZdw6n1+3st3EG0MZs9ZR5OJDxaS5XMKxcF+iWaEFIPTgdlbNlux7Cz5IYUQY
 jkAk=
X-Gm-Gg: ASbGnctIFdWytwKmOuQMSef4uCxR0dvAzFD9q2YWm6Xu26t36LTW88w7p+iPMN/ToVx
 kBXtsLNOdyftQdoTplkMFG3v6N56JeQQx7O7xcv5x7otUAgduqFnGq96mE2z/GjbhQieI/g3Vhu
 LtK8k4YMA7RwDxXmgyMMuxkYFEJRdfKO5xKkcQinSbmvsOnpWyDyaQu5fdK9Tl6US39910viHqW
 I/Qz6q6DCTogY9mxadmBWLsWsEh8Gx3FR6NGeVVkKu14w26dRVGToV/bRDZQWpgxn21Gi5NRRD2
 fvvSOZP6G6DbWB0jnos3qmXjIaNYbYVLGzE9zAXUzXgdOVWzPvGNwgh6jbvdeR12jF9T
X-Google-Smtp-Source: AGHT+IE6PsvCtkVYCjU5288pC6XYq6OiXP8eut8+CBA/vynIFFF5N2sBccrjgtn5jYdTw3nXXyZPTQ==
X-Received: by 2002:a17:90b:224e:b0:2ea:bf1c:1e3a with SMTP id
 98e67ed59e1d1-2fc40f0e957mr36975139a91.12.1740018924200; 
 Wed, 19 Feb 2025 18:35:24 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d53490b6sm111668345ad.16.2025.02.19.18.35.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2025 18:35:23 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v2 04/14] net/ixgbe: remove unnecessary dereference
Date: Wed, 19 Feb 2025 18:32:08 -0800
Message-ID: <20250220023509.630569-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250220023509.630569-1-stephen@networkplumber.org>
References: <20250217185743.169778-1-stephen@networkplumber.org>
 <20250220023509.630569-1-stephen@networkplumber.org>
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

