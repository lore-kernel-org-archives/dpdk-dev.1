Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1917C4451B
	for <dpdk-dev@archiver.kernel.org>; Sat, 18 Jul 2026 09:18:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ECBA840609;
	Sat, 18 Jul 2026 11:18:13 +0200 (CEST)
Received: from mail.amicon.ru (unknown [77.108.111.100])
 by mails.dpdk.org (Postfix) with ESMTP id BA72A40289;
 Tue, 14 Jul 2026 10:01:47 +0200 (CEST)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; d=amicon.ru; s=mail; c=simple/simple;
 t=1784016105; h=from:subject:to:date:message-id;
 bh=+5TZb/XKoH+R9g+PwYGhe9tz+8aJHe04f8CLEh3UR5E=;
 b=QQXUbqq82a8qhmxb7pbpEdW2BJvgfsTNEjuNNq5f4jsi+yyjgj9LmxIuPpqAiItUuUAbnvLfnXU
 90OIgqXJxEdMq0JLCZ+yS5u+UkICoQH3mLWJmGfREcBhg1cSG79Juhgje1ZbyMyd3KJmv1q7oG16q
 r9QZEfU/zDnfql8LiMZm6EZxWi7Yj+B513oGNRkMQfsS7Dx8jj4Qm4D30wbKg6Pi1SR0Y3joCS06j
 RtAeNUt3YSBTfG1mDG/Z5aSBrsfgVm/uo+v+eEt4JcTuqmx65fLulx/URNVchjmTeBdla/DUVF9p9
 CM/G42yMgzPhO223K4CB3P4z9imcJoldiJaA==
Received: from dish.amicon.lan (172.16.30.10) by mail.amicon.lan
 (192.168.0.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Tue, 14 Jul
 2026 11:01:44 +0300
From: Daniil Iskhakov <dish@amicon.ru>
To: Anatoly Burakov <anatoly.burakov@intel.com>, Dmitry Kozlyuk
 <dmitry.kozliuk@gmail.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, <rrv@amicon.ru>, <dish@amicon.ru>,
 <sdl.dpdk@linuxtesting.org>
Subject: [PATCH] fbarray: check fbarray lock downgrade failure
Date: Tue, 14 Jul 2026 11:02:42 +0300
Message-ID: <20260714080242.35630-1-dish@amicon.ru>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Originating-IP: [172.16.30.10]
X-ClientProxiedBy: mail.amicon.lan (192.168.0.59) To mail.amicon.lan
 (192.168.0.59)
X-Mailman-Approved-At: Sat, 18 Jul 2026 11:18:11 +0200
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

Return value of eal_file_lock() is ignored in the fbarray destroy error
path.

Check the return value and log the downgrade failure while keeping the
original rte_errno reported by unlink().

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 176bb37ca6f3 ("eal: introduce internal wrappers for file operations")
Cc: stable@dpdk.org

Signed-off-by: Daniil Iskhakov <dish@amicon.ru>
---
Cc: dmitry.kozliuk@gmail.com
Cc: sdl.dpdk@linuxtesting.org
Cc: rrv@amicon.ru
---
 lib/eal/common/eal_common_fbarray.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/eal/common/eal_common_fbarray.c b/lib/eal/common/eal_common_fbarray.c
index 8bdcefb717..5a694ccdae 100644
--- a/lib/eal/common/eal_common_fbarray.c
+++ b/lib/eal/common/eal_common_fbarray.c
@@ -1022,7 +1022,9 @@ rte_fbarray_destroy(struct rte_fbarray *arr)
 			 * we're still holding an exclusive lock, so drop it to
 			 * shared.
 			 */
-			eal_file_lock(fd, EAL_FLOCK_SHARED, EAL_FLOCK_RETURN);
+			if (eal_file_lock(fd, EAL_FLOCK_SHARED, EAL_FLOCK_RETURN))
+				EAL_LOG(DEBUG, "Cannot restore fbarray shared lock: %s",
+					rte_strerror(rte_errno));
 
 			ret = -1;
 			goto out;
-- 
2.43.0

