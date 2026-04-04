Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74990F3D5E1
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Apr 2026 07:06:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6EDF040293;
	Tue,  7 Apr 2026 09:06:27 +0200 (CEST)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com
 [209.85.210.53]) by mails.dpdk.org (Postfix) with ESMTP id DE05B40265
 for <dev@dpdk.org>; Sat,  4 Apr 2026 19:19:40 +0200 (CEST)
Received: by mail-ot1-f53.google.com with SMTP id
 46e09a7af769-7d9b1c57a4cso2388209a34.3
 for <dev@dpdk.org>; Sat, 04 Apr 2026 10:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775323180; x=1775927980; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CkecN2gXN4vQMjbgKxh1sORindU3tyECdthnMMR+Cps=;
 b=fDEcmAYSKxanvJDABLGSBO8mEA/nBv41DTiI49t1WfTOV+Tt9fkWBK3fBh+qstNEXQ
 aF3Kgit609g4XG4D6warT8h868INFRilGWkqiJPGxYg1DAYmhknkJf74UyoLntEM470s
 2VkWUHXA77iiGkefS2kxrrfTKdqLAUcnbJqS1XOeBJPBqw2iUSl/ncl7eUlD7wp5e1X0
 0SfFcc7RUiFxR/eCf5Vv7ET22LlibjLpfcWYbu30kWf6n/VjyKR20KEM7yXtlZhgXWlI
 ymU2iNEu8dHnuZY+FT3KE+Dmr6Nzy2Qxp3utAu12eXwQ7vAb1EDb28ThSb0h9bKWaRbg
 ndGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775323180; x=1775927980;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CkecN2gXN4vQMjbgKxh1sORindU3tyECdthnMMR+Cps=;
 b=UsO96VX9YhsLspnJeLLYNsMj4eFMbttKop+wWF4ZJw18UAfJ0GQotyJU/bp5RjoMWR
 KPVywrd2w8Qwst80ftLS+Ia683jp6JqKi7onWd2cOTzqO8sZdW2auXzOeFFJR6+c1GuZ
 FAhAJ1plsSiSM6GqNLs6CisMSdheSx15TbKAcC5IlNsirUfqKJGxHXwlXiD6m72kUAcX
 iHFSPyoAtWL8Yxheda9saA5JSPj5WVNeTATJDeB6gBi0h7R3FTjamn8Oh22Zl52XQ1gK
 fTPYgh4F77Unwu4I5rgGQMLd1caMbUOlhDvTk+3ujtjHmqYsCcUDViN3SgE8NJxwsV3E
 HShA==
X-Gm-Message-State: AOJu0YxnXpicHnLNsLjN5SRwPNo0DILKArh7aLXMc1XIeJEsm02fEyq/
 qmKz8Xsr0ojvwQizY18Mf5/NboJmqCTiysbaOPPLX3Fp7FScM6HR6Fk0
X-Gm-Gg: AeBDieuy2KW2K0Yr9mtdv+YAeCMrx2epme3qzAF4icYDrfjlbwPrAAx2XBa/PruNvG3
 NLCLRjnOqtrvyN3fRDiyGDu627WcDL1L/9FRyWH/n6oTnRJYdrIyy7QkLQpuQ+o2umK9iI0pd+A
 KlnLni/wtjWm3XVy0K/9szFcVIEAqNUuHvuipTqrosHRaQr3Redh4IPmn+I2QFO3edALG9Zwbvl
 770Lo+UJijaHoA/9Tu2V+SeXK2pGb2vOC1UdZBY18snRBYEG141U8EChhzK2pKs///Wkt6m0AWW
 HhbwbOCwlkYEMl1fBzYegsBqYzUA5dCwvf37M3o7sKSUv9aOdyRHEr4dzz6SK39tI3ueRgymMPV
 3N61irh7pOdIAAKQduGQ05z6NzO2+7bZHjReejoua+3sISFtDRKpIYNiNloR8BJv7Rv3Ws/z2PQ
 ==
X-Received: by 2002:a05:6830:6ae7:b0:7da:37fe:7b34 with SMTP id
 46e09a7af769-7dbb7576b6bmr4176136a34.25.1775323179895; 
 Sat, 04 Apr 2026 10:19:39 -0700 (PDT)
Received: from gmail.com ([50.93.222.110]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dba71261dbsm6580665a34.6.2026.04.04.10.19.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Apr 2026 10:19:39 -0700 (PDT)
From: Weijun Pan <wpan3636@gmail.com>
X-Google-Original-From: Weijun Pan <wpan36@wisc.edu>
To: Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Jun Yang <jun.yang@nxp.com>
Cc: dev@dpdk.org,
	Weijun Pan <wpan36@wisc.edu>,
	stable@dpdk.org
Subject: [PATCH] bus/fslmc: fix shadowed variables in queue storage macros
Date: Sat,  4 Apr 2026 12:19:11 -0500
Message-Id: <20260404171912.48947-1-wpan36@wisc.edu>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 07 Apr 2026 09:06:25 +0200
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

