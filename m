Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B974DFD5F92
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Apr 2026 08:25:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 49C794014F;
	Wed,  8 Apr 2026 10:25:43 +0200 (CEST)
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com
 [209.85.167.171])
 by mails.dpdk.org (Postfix) with ESMTP id 8074540265
 for <dev@dpdk.org>; Tue,  7 Apr 2026 16:19:56 +0200 (CEST)
Received: by mail-oi1-f171.google.com with SMTP id
 5614622812f47-46a9ae3f860so1708501b6e.1
 for <dev@dpdk.org>; Tue, 07 Apr 2026 07:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775571595; x=1776176395; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CkecN2gXN4vQMjbgKxh1sORindU3tyECdthnMMR+Cps=;
 b=MNVGlI+X/kixyho+dztpn1ilP7mNlQAQ9QQrkzO1AyTTVcoInj6jXe4s6l51bPlN9y
 HwNyeIi07K+kVlYGTEZw2HFVg9FMQBONqzRY9bWl8kOr3dhxws/rgVJniwoe2veBSXZt
 KhRxu322ApGh6DKuOewUMxrXVJ9jFHfUhVb96PA9EaTmw25Jwyc/jpGyNtSNDAhmyZUr
 kZU4b2GuL5E47X8SkJy0sgI2twBGpx/eNrQf6s3oAjZr7Iyw3IQCfSaVXOm6iL61rUJR
 bo7mJ8Ala+fMSh5yTEr/TetWgvmHZf5w8N0q911zCovc7h6UnJOJCjA3idC3Ufa2X1sH
 LjAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775571595; x=1776176395;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CkecN2gXN4vQMjbgKxh1sORindU3tyECdthnMMR+Cps=;
 b=hu4sv7GGmehnH2nmXMgXYlldVV0NZgMMgK+CZO4ThXf+kWBU+mwLxseLng5/EyOHXu
 xOIsOv8Wrg9GXcq2Du6YfIs/skoZ1uLxs9TLhmSt2vIVLLw1rtIsgymkU6viNLcIrWov
 Nhn3UUTC7ct3EvrI2iAT6g6VEhn3lNWwj16qNn51QNs42E45qIqYAsVOUIqhXAPIxBNB
 l5kWkym2WGdesX3rlbJMIAAyvBP7FGicyiE/Td3m8U8TSIGiXt5OQ9fCH09TaSQGUN5U
 ooGQHpF5whQQYZtLGblZ+sGJkdz4N4tnW5f68TBi7noqqpgA2Edg8Cx7HVbiU4NVlV73
 7zhw==
X-Gm-Message-State: AOJu0YzJOxp6L4eVScXX6ooEaFJ7tP+DBaRqfiMU+WRzwtSAwT2UD1wl
 nVNnrwLzO+NTIvUwYUDCTT+zoGuSYrIo2HvaDxPO1CQRa9zMcAF5asqo
X-Gm-Gg: AeBDievV5WP/Pgg5xWRUnUtdfV6XnTn+AlsxUPqmzS+RrFQw06EvVNLwZxGkqYQye/D
 WohRZ7QhuB1ojcqjHJoI1d/Y0qdx/KNJ807208dPNeHtUL+lCAPksPO7zCPJ20gGxQ2y8mEYgxy
 DzcLljhy937trDYyjSoK7UxP+2SXgInpEhT8Wf7kyEEE74RBLkE+xHBRHVQeARj8KdejqSjOqrQ
 JKNdqvhmBvmZENUnIt0XZR4+AaDAQuldKWfCaALAb/4JHY6hvi+36+O7+/De44UyJijl+oqHDyY
 OIluGQvq+U0I8JU+5L5SDAnnEQVQz4r1H5Vj2VaHwavOe9jJMyWb8MIOFxwLDMa6qXZRDDEwsza
 Oq6WUgAHu06Hm+iG0JEeKZSMgH0yqO7X6HZJXjoUGz3C9VsFi9X0NjHGJKHqhY1iwA45cMtIkH8
 gaLBray8YipOSaw4lZI95ZN5s=
X-Received: by 2002:a05:6808:3027:b0:468:776:1ec3 with SMTP id
 5614622812f47-46ef65fa7d8mr8061619b6e.24.1775571595573; 
 Tue, 07 Apr 2026 07:19:55 -0700 (PDT)
Received: from gmail.com ([50.93.222.110]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-46d9387a763sm9994080b6e.18.2026.04.07.07.19.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 07:19:55 -0700 (PDT)
From: Weijun Pan <wpan3636@gmail.com>
X-Google-Original-From: Weijun Pan <wpan36@wisc.edu>
To: Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Jun Yang <jun.yang@nxp.com>
Cc: dev@dpdk.org,
	Weijun Pan <wpan36@wisc.edu>,
	stable@dpdk.org
Subject: [PATCH] bus/fslmc: fix shadowed variables in queue storage macros
Date: Tue,  7 Apr 2026 09:19:27 -0500
Message-Id: <20260407141928.9426-1-wpan36@wisc.edu>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 08 Apr 2026 10:25:39 +0200
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

The queue storage allocation and free macros declare local variables
named ret and i, which shadow local variables in
rte_dpaa2_create_dpci_device() and trigger -Wshadow warnings.

Rename the macro-local variables to avoid shadowing without changing
behavior.

Bugzilla ID: 1744
Fixes: 12d98eceb8ac ("bus/fslmc: enhance QBMAN DQ storage logic")
Cc: jun.yang@nxp.com
Cc: stable@dpdk.org

Signed-off-by: Weijun Pan <wpan36@wisc.edu>
---
 drivers/bus/fslmc/portal/dpaa2_hw_pvt.h | 28 ++++++++++++-------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h b/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
index e625a5c035..bbeccd8fc3 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
@@ -204,33 +204,33 @@ struct swp_active_dqs {
 
 #define dpaa2_queue_storage_alloc(q, num) \
 ({ \
-	int ret = 0, i; \
+	int qs_ret = 0, qs_idx; \
 	\
-	for (i = 0; i < (num); i++) { \
-		(q)->q_storage[i] = rte_zmalloc(NULL, \
+	for (qs_idx = 0; qs_idx < (num); qs_idx++) { \
+		(q)->q_storage[qs_idx] = rte_zmalloc(NULL, \
 			sizeof(struct queue_storage_info_t), \
 			RTE_CACHE_LINE_SIZE); \
-		if (!(q)->q_storage[i]) { \
-			ret = -ENOBUFS; \
+		if (!(q)->q_storage[qs_idx]) { \
+			qs_ret = -ENOBUFS; \
 			break; \
 		} \
-		ret = dpaa2_alloc_dq_storage((q)->q_storage[i]); \
-		if (ret) \
+		qs_ret = dpaa2_alloc_dq_storage((q)->q_storage[qs_idx]); \
+		if (qs_ret) \
 			break; \
 	} \
-	ret; \
+	qs_ret; \
 })
 
 #define dpaa2_queue_storage_free(q, num) \
 ({ \
 	if (q) { \
-		int i; \
+		int qs_idx; \
 		\
-		for (i = 0; i < (num); i++) { \
-			if ((q)->q_storage[i]) { \
-				dpaa2_free_dq_storage((q)->q_storage[i]); \
-				rte_free((q)->q_storage[i]); \
-				(q)->q_storage[i] = NULL; \
+		for (qs_idx = 0; qs_idx < (num); qs_idx++) { \
+			if ((q)->q_storage[qs_idx]) { \
+				dpaa2_free_dq_storage((q)->q_storage[qs_idx]); \
+				rte_free((q)->q_storage[qs_idx]); \
+				(q)->q_storage[qs_idx] = NULL; \
 			} \
 		} \
 	} \
-- 
2.34.1

