Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C317EC88E67
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 05:53:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A64C540DF8;
	Mon, 14 Sep 2026 07:51:45 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id 4030640EDC
 for <dev@dpdk.org>; Mon, 14 Sep 2026 07:51:40 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-39b9184fa80so1570427a91.2
 for <dev@dpdk.org>; Sun, 13 Sep 2026 22:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789365099;
 x=1789969899; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=x+UOwLyxNd/UfJahytuHtsWM8dsCXe0OteFJiuU5bjY=;
 b=xLWP7yb4h038lLwmBDVbuiC57bhB30wXtg145S+W3G3hg6onVT8GYUT8ULFyjNqmRS
 Y5f2ZUDfKupuoutQvtGvZa9F056fpCsyPCvhwrbyX1miqRKg8gcJjdXIhCWk3EEbN83b
 MrCv671lp1cEbG28iGKzII85iiXm1JNTGv+nfbgVt9cNwlI7IvsMJ6MQkjQV1VaifrmJ
 jYMcme4ml9hGDRboF8/gGF/3RpHtwjoHreKrwO74vbL4iwfk7iWdyi6PHMTu08gTYDWI
 H+9tbT6/uvzkJUgAnO5xxzhdLInAakfUq+vOGm1+UHP67NSGqyPWnWgZgJRT9jW5cfmz
 7htQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789365099; x=1789969899;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=x+UOwLyxNd/UfJahytuHtsWM8dsCXe0OteFJiuU5bjY=;
 b=hSPC3W4SisGtps4jijc1qJzPCYJ+pzoml9ORCGHcHabFIl60SYuRhJBqzaDaimG9TF
 8Z5PQ5Zc8ftmMBqFszV/taKYDi54uLFjgD5iuwcAZnozAGmhETLwMl5yy0S6SD6igICS
 du1IH0oh0Kbb8L574EEO1JmqmEndgUapHReqfJbjQGlchtz28APdfSnKZvE2N5b2OWZX
 HquSLxgfsMRfHGPc7GlgWriwuz1ZSAZZXY8H04vZW5AdwmD0uc0mvhsVuvKabwtsbx92
 HnGJjAjr7Y4LV9ytvEEFNJhUHL5XjuUnPXyNCMY46L00+jYii8+OHTTwlBepjuBs/RFL
 k7bg==
X-Gm-Message-State: AFuF++mO3ZqOuRpgWBoBNwTt0S4uqDWO0nCkf4EKTa6CwpkkKnWDPQnL
 EcdfEJDipKxLdyFhaNvMP005zL/Nh6PkjTmkGdhK+o7dTPbzQCYL4w0CiJwWxk+3s3fu/xADeZk
 oViuz
X-Gm-Gg: AYBFou0D+h1cqokCqWUyQ9vCgtLW4eS5IK0e1f6bhdjZSMkJQo4of8uwRgX6oWP1bP1
 Xudf5al43GCpZ6m9KIelBmDPpnO9qCSMAwg/mtar13y34WtheairPM0ubHItJ8CNz4pA/6uleEY
 vYGWG6WvjTNaDp6319e8t+csmp5rPIsLUM1BoMEe4Npn9AbrV/TyzrJORQ7aEmIPfsD7yclumz9
 MovdoUDWmt0IkocFjBLIBPckf4tQA2qfRu5JrNBYmUfckKalmPgFIa4CCVkqIuwCwhgBOpBYpEd
 +9i6g+o3RvDBrcBrjzQuE36tM+++NAYmyVmkAyWoy7xEWnnE4AtotqkFCdSzHb5Lnx9PO08Sb8T
 2rnTB5OAeF5XrSvYA2uFUE504kdKbco8TlTW060gBeA/pn28N5kHOUI+ccuMitDQkNfWdQm17uo
 3iJVOF9UOTFXEC8rkaqOc0gG+e0x8VQgm9U0jvHawBGhoB6Tj2HL7tNijd3DF+rpJ6dseh7L/rQ
 T7+mysxh9y2OooamZs4Z65OblCjC/R0910aVdKf7Vs9EjJ/
X-Received: by 2002:a17:90b:3e4f:b0:398:9be6:f997 with SMTP id
 98e67ed59e1d1-39dec0f7abamr2967947a91.22.1789365099321; 
 Sun, 13 Sep 2026 22:51:39 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d95864b4fsm19794492a91.15.2026.09.13.22.51.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 22:51:38 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Gagandeep Singh <g.singh@nxp.com>, Sachin Saxena <sachin.saxena@nxp.com>,
 Vanshika Shukla <vanshika.shukla@nxp.com>
Subject: [PATCH 40/62] net/enetc: use kvargs numeric helpers
Date: Sun, 13 Sep 2026 22:47:11 -0700
Message-ID: <20260914054912.755403-41-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914054912.755403-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
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

The VSI timeout and delay arguments are parsed with strtoul() without
checking the end pointer, so a value such as "10abc" is accepted. They
are also assigned into a uint32_t before being validated, so a value
above UINT32_MAX is truncated and only rejected if it happens to
truncate to zero.

Report the offending string rather than the truncated value, which was
not meaningful once the conversion had failed.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/enetc/enetc4_vf.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/net/enetc/enetc4_vf.c b/drivers/net/enetc/enetc4_vf.c
index ef5f1e6d66..18bbffc255 100644
--- a/drivers/net/enetc/enetc4_vf.c
+++ b/drivers/net/enetc/enetc4_vf.c
@@ -1359,28 +1359,30 @@ enetc4_vf_dev_init(struct rte_eth_dev *eth_dev)
 			/* parse optional VSI-PSI timeout devarg */
 			val = rte_kvargs_get(kvlist, ENETC4_VSI_TIMEOUT);
 			if (val) {
-				errno = 0;
-				hw->vsi_timeout = (uint32_t)strtoul(val, NULL, 0);
-				if (errno != 0 || hw->vsi_timeout == 0) {
-					ENETC_PMD_ERR("Invalid VSI Timeout value = %u",
-							hw->vsi_timeout);
+				uint64_t num;
+
+				if (rte_kvargs_to_uint(val, 1, UINT32_MAX, &num) < 0) {
+					ENETC_PMD_ERR("Invalid VSI Timeout value = %s",
+							val);
 					rte_kvargs_free(kvlist);
 					return -1;
 				}
+				hw->vsi_timeout = num;
 				ENETC_PMD_NOTICE("VSI timeout set to %u", hw->vsi_timeout);
 			}
 
 			/* parse optional VSI-PSI delay devarg */
 			val = rte_kvargs_get(kvlist, ENETC4_VSI_DELAY);
 			if (val) {
-				errno = 0;
-				hw->vsi_delay = (uint32_t)strtoul(val, NULL, 0);
-				if (errno != 0 || hw->vsi_delay == 0) {
-					ENETC_PMD_ERR("Invalid VSI Delay value = %u",
-							hw->vsi_delay);
+				uint64_t num;
+
+				if (rte_kvargs_to_uint(val, 1, UINT32_MAX, &num) < 0) {
+					ENETC_PMD_ERR("Invalid VSI Delay value = %s",
+							val);
 					rte_kvargs_free(kvlist);
 					return -1;
 				}
+				hw->vsi_delay = num;
 				ENETC_PMD_NOTICE("VSI delay set to %u us", hw->vsi_delay);
 			}
 
-- 
2.53.0

