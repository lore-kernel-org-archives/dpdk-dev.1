Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF246CCFA1E
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 09:45:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E4D7A4027A;
	Wed, 29 Apr 2026 11:45:31 +0200 (CEST)
Received: from fout-b6-smtp.messagingengine.com
 (fout-b6-smtp.messagingengine.com [202.12.124.149])
 by mails.dpdk.org (Postfix) with ESMTP id 647CC40272
 for <dev@dpdk.org>; Wed, 29 Apr 2026 11:45:30 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.stl.internal (Postfix) with ESMTP id 855D91D0024A;
 Wed, 29 Apr 2026 05:45:29 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Wed, 29 Apr 2026 05:45:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to; s=fm2; t=1777455929; x=1777542329; bh=j2VjL/R5giZgVdWpq6VWt
 kmDrMgyjVKXZUT4aTrrjuI=; b=rrOFZVVOlm0jbhsfU/F6gmRhOUcukKNBSaC0a
 hU+OtjcM+RF/fKLQYR7acrTba6FoyAgmDwk8SQZZdAGAwZxwetF3oG/BH/kW9xzk
 uapL27aEFTYtaiqWZdvd8w19H/aLoU6UG8LDAIdy+iQybmwYLKYgODTxy3FqtEpq
 EEFy19R1AtHw2RCVNvDbYW01JfCKn2xLPVgiWtS0HwCiHzD8Jzsl5liT/QjHEwWA
 lSNfs8SIq16WvNzmpJdHmFM+TEnS5DPgPxjqHePcAJnNxY3Guy8gFg81f1uDLMbS
 SbDqUnJ5iiW9qWV3z2oL3Thv+OD2MT87nN4gCyskXDzIA99JQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1777455929; x=1777542329; bh=j2VjL/R5giZgVdWpq6VWtkmDrMgyjVKXZUT
 4aTrrjuI=; b=CqjkM1vYcnGIZv65sVPOh+6xp7NYGNPzCO4VXTg5MDD2H0LGEba
 ynvmMMJJ7YCrwdGK/ClCWJ/WVJmkOFUWNorAJCfPJG/U857Sn6Eh4T9D26mBPOM1
 kCl97vvHvzIJ+KYDTp2ma7XxZlFznS2+nqGSGECjzBLK9kNVkUoHYkXzkW+NMTGH
 Tnd7KzziC/YGZjKLDX/HryjtoJ/p8o3dVXvlWU9HzBngVr9eGz7p1PDafQVE1Ida
 Nh83XZB+dzNmvGOoamTfl/ySL2PtWPfvv77YUw4IaevfZkzi2FZJn7lmQBD5Ilr7
 NFqjGFboXUk4sN4nFMCsUw+2Y8s2P0u35sg==
X-ME-Sender: <xms:ONPxaZ1fu7GMEKResyfa8dWb0lytGCidR8Euz-7bMpezF71DA096Qg>
 <xme:ONPxaaIjuKFLgiynCP9ROE2h3cYQQriQbzyvOockvaMEO1J3WQUX6doLMQJX6rMRM
 7JQy2ZgGLUqWkEvIi3W3q7RnPOPVmbix1FcWeYGRLe90wZfLr_4-g>
X-ME-Received: <xmr:ONPxaZwTnRSes2W8ATn7H8bS7wt3KdUPn3uiJ0IiIt_sS2m-BK7hY7ndkoWaXSKflUfdO9tAxfAw4KnvfaY9wczf0d7zhcE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekgeduudcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefvhhhomhgrshcuofho
 nhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrfgrth
 htvghrnhepveevfeevieeihfetudekgeekleeigeffueekveduteeuffeiudevteeiudek
 feelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepth
 hhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepjedpmhhouggv
 pehsmhhtphhouhhtpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtoh
 epiihhrghnghdrhihonhhgvdehseiithgvrdgtohhmrdgtnhdprhgtphhtthhopeifrghn
 ghdrjhhunhhlohhnghduseiithgvrdgtohhmrdgtnhdprhgtphhtthhopehshhgrnhdrlh
 hijhhivgesiihtvgdrtghomhdrtghnpdhrtghpthhtohepfhgvnhhgtghhvghnghifvghn
 sehhuhgrfigvihdrtghomhdprhgtphhtthhopegtlhhouhgurdifrghnghigihgrohihuh
 hnsehhuhgrfigvihdrtghomhdprhgtphhtthhopeifrghnghhfvghifhgvihegtdeshhhu
 rgifvghirdgtohhm
X-ME-Proxy: <xmx:ONPxaYV8uNA3GIki4Pyx-UXLw-ash0ugSVFhZF5RWb3L_5whNcn7nA>
 <xmx:ONPxaZhAlVIALDtAEUU56Tu2EFWLcUuu5FsH3kdCZY5QoSuTviAhRA>
 <xmx:ONPxaYAunhJeQVOUZdCFbmRvZGJUP-bafQ1br-nv2Pgz5yEDcHzRxw>
 <xmx:ONPxaftaXxEtCvwGAhNG66kpJfONjiaV4V60GputY_5CERv0qJqWjQ>
 <xmx:OdPxaZCiM9LDBsaLrZN3W0DOSp792oHW2UV7n63AjW4n3kEva33rqy8C>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Apr 2026 05:45:27 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Yong Zhang <zhang.yong25@zte.com.cn>,
 Junlong Wang <wang.junlong1@zte.com.cn>,
 Lijie Shan <shan.lijie@zte.com.cn>,
 Chengwen Feng <fengchengwen@huawei.com>,
 Xiaoyun Wang <cloud.wangxiaoyun@huawei.com>,
 Feifei Wang <wangfeifei40@huawei.com>
Subject: [PATCH] maintainers: prune unreachable contacts
Date: Wed, 29 Apr 2026 11:45:15 +0200
Message-ID: <20260429094516.3558155-1-thomas@monjalon.net>
X-Mailer: git-send-email 2.53.0
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

Emails to the maintainers of ZTE zsda and HiSilicon uadk
crypto and compress drivers do not respond.

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 MAINTAINERS | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0f5539f851..9164c736db 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1201,7 +1201,6 @@ F: drivers/crypto/scheduler/
 F: doc/guides/cryptodevs/scheduler.rst
 
 HiSilicon UADK crypto
-M: Zhangfei Gao <zhangfei.gao@linaro.org>
 F: drivers/crypto/uadk/
 F: doc/guides/cryptodevs/uadk.rst
 F: doc/guides/cryptodevs/features/uadk.ini
@@ -1300,7 +1299,6 @@ F: doc/guides/cryptodevs/virtio.rst
 F: doc/guides/cryptodevs/features/virtio.ini
 
 ZTE Storage Data Accelerator (ZSDA)
-M: Hanxiao Li <li.hanxiao@zte.com.cn>
 F: drivers/crypto/zsda/
 F: doc/guides/cryptodevs/zsda.rst
 F: doc/guides/cryptodevs/features/zsda.ini
@@ -1318,7 +1316,6 @@ F: doc/guides/compressdevs/octeontx.rst
 F: doc/guides/compressdevs/features/octeontx.ini
 
 HiSilicon UADK compress
-M: Zhangfei Gao <zhangfei.gao@linaro.org>
 F: drivers/compress/uadk/
 F: doc/guides/compressdevs/uadk.rst
 F: doc/guides/compressdevs/features/uadk.ini
@@ -1352,7 +1349,6 @@ F: doc/guides/compressdevs/zlib.rst
 F: doc/guides/compressdevs/features/zlib.ini
 
 ZTE Storage Data Accelerator (ZSDA)
-M: Hanxiao Li <li.hanxiao@zte.com.cn>
 F: drivers/common/zsda/
 F: drivers/compress/zsda/
 F: doc/guides/compressdevs/zsda.rst
-- 
2.53.0

