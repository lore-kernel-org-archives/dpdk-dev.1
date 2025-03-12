Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A443EC28B28
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Mar 2025 23:18:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 71F6240E40;
	Thu, 13 Mar 2025 00:17:36 +0100 (CET)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mails.dpdk.org (Postfix) with ESMTP id D302240E22
 for <dev@dpdk.org>; Thu, 13 Mar 2025 00:17:32 +0100 (CET)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-22403cbb47fso7495065ad.0
 for <dev@dpdk.org>; Wed, 12 Mar 2025 16:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1741821452;
 x=1742426252; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sLqDuODvwFx7ucTbKHNbJvK8zebWvm7kRt9oNbw/hWA=;
 b=09B4l94gbI1kgIKbeRMWOGDHqN47r5qiBEXfBJZkSEaMcJEoiy/ej+y2vAFas45Rxi
 6qJxKaIShUL4UGH0+24megJd4MNDP6/Jrkes/+jySGj9JuODnUBjJwEUltAbKE+kq0Wz
 rR9RAx8TXnZdnjULbs7uJC3VkrcjzZfgOv18sfyIkWSM+4z58Wy6wa5qP8dWCAO1wvv1
 dzLADd272mCd3zlrbY8SJDFTZsCyFdDM3iAMXf0KHIJx4itmT+jCpfyvohd78HldqldI
 WJihTSetB49QRj7csXI300HFg+M7cIlQfUFgWLNdzO16qmltOipHDx4YX4a/h66txnGw
 i2Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741821452; x=1742426252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sLqDuODvwFx7ucTbKHNbJvK8zebWvm7kRt9oNbw/hWA=;
 b=bIPt9wOLyLNaDy7I62H8pGhFm3mrszQkTL6IAv8020HQzzgLMtI4NyodNE3bA0i/MP
 /rmNZgRExv8ec9zkzo4vlfpForu1p1vNEDCWpHrFC92svNX8pAwvL1hme4ISusnz2Gba
 mJmVaiy8AldaoJ3SXh0w6pUaCRCP8YqTmQiIHh2gvZVbi41P3GuPLFiINuwegrdq6eAC
 eLZNWJYHDBOBpcRzGgOwPIFN0Dh1fA4Ct0+ZI4TlSZRzAL1ov+eUEtEnuo+NM13gqKd2
 Q8ck89ZWsOkmDnowXYImdtJAc8VjSuonTLJi+kC4uMr0yUkZH6eTNf3sOU4tyDCa9ePs
 cVhA==
X-Gm-Message-State: AOJu0YwM8hp90IRsQdF5MneA1ic0dLjKGWIBJuZXVRsO1G7cJj+7ZGyi
 EeDyPH31lxai2EZd6ktLc2DvneZSu54Mte5b6/keKqDfjiI4GYuDGC6lsv6MDN+FvNJVJfnfEQI
 k
X-Gm-Gg: ASbGncsA18KBr0R6AEkafOKkd+PwCvthm0WDyCjbzXW6vaRDQgy1RYGCk5d5jVDpqm6
 rfHWapcj090x4XoUPO2M9q74+OmzOzoZ8duBvF+V/V6QmP6Ftvvl7h0qs2FblRGaubb5b/ZDMnA
 JDK03Jim+kYlQ6G0oDrve55wTerpukclXL9C8qRWS4E6IygLVdKl9jScIkWBDMRxQo0R5j33w0s
 D2ywSWx4GwLYbfy7efHs0KaK5tWHgIq2LlPQDSEN6sNMYH61P0wt9G8HUJnbnv422yhyJwyzr2H
 efwVO1mcQShq2LdAiEV+8zovYIn9APsqRgqprgotKuf0SbeGA3EKYEBycUuHq2A00StNaYaxZIo
 +GufhwO02rdKQuyC8IfisTlbza0tu4pt1
X-Google-Smtp-Source: AGHT+IEmpXsp9nBn560PehICO1kvZRF55to7iXJpSdBX0+Iz1CYycXzAOY+A1yAXvFjjKLP/eMPs7w==
X-Received: by 2002:a17:902:e802:b0:21f:bd66:cafa with SMTP id
 d9443c01a7336-2242888cf05mr299497555ad.17.1741821452047; 
 Wed, 12 Mar 2025 16:17:32 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6ba6f38sm1028305ad.129.2025.03.12.16.17.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 16:17:31 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Rosen Xu <rosen.xu@intel.com>, Rosen Xu <rosen.xu@altera.com>
Subject: [PATCH v3 7/9] raw/ifpga: use EAL version of TAILQ_FOREACH_SAFE
Date: Wed, 12 Mar 2025 16:15:36 -0700
Message-ID: <20250312231715.222149-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250312231715.222149-1-stephen@networkplumber.org>
References: <20250127180842.97907-1-stephen@networkplumber.org>
 <20250312231715.222149-1-stephen@networkplumber.org>
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

Prefer the EAL version over local version of macro.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Reviewed-by: Rosen Xu <rosen.xu@intel.com>
---
 drivers/raw/ifpga/base/ifpga_enumerate.c | 4 +---
 drivers/raw/ifpga/base/opae_osdep.h      | 1 +
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/raw/ifpga/base/ifpga_enumerate.c b/drivers/raw/ifpga/base/ifpga_enumerate.c
index 61eb6601ea..085fb6db40 100644
--- a/drivers/raw/ifpga/base/ifpga_enumerate.c
+++ b/drivers/raw/ifpga/base/ifpga_enumerate.c
@@ -725,9 +725,7 @@ static void dfl_fpga_enum_info_free(struct dfl_fpga_enum_info *info)
 		return;
 
 	/* remove all device feature lists in the list. */
-	for (dfl = TAILQ_FIRST(&info->dfls);
-		dfl && (tmp = TAILQ_NEXT(dfl, node), 1);
-		dfl = tmp) {
+	TAILQ_FOREACH_SAFE(dfl, &info->dfls, node, tmp) {
 		TAILQ_REMOVE(&info->dfls, dfl, node);
 		opae_free(dfl);
 	}
diff --git a/drivers/raw/ifpga/base/opae_osdep.h b/drivers/raw/ifpga/base/opae_osdep.h
index e35a21c80e..b483d00a54 100644
--- a/drivers/raw/ifpga/base/opae_osdep.h
+++ b/drivers/raw/ifpga/base/opae_osdep.h
@@ -11,6 +11,7 @@
 
 #ifdef RTE_LIB_EAL
 #include "osdep_rte/osdep_generic.h"
+#include <rte_queue.h>
 #else
 #include "osdep_raw/osdep_generic.h"
 #endif
-- 
2.47.2

