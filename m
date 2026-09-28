Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC96C9832A
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 05:41:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D983440276;
	Tue, 29 Sep 2026 07:41:45 +0200 (CEST)
Received: from mail.amicon.ru (mail.amicon.ru [77.108.111.100])
 by mails.dpdk.org (Postfix) with ESMTP id C12B840E26;
 Mon, 28 Sep 2026 16:57:35 +0200 (CEST)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; d=amicon.ru; s=mail; c=simple/simple;
 t=1790607453; h=from:subject:to:date:message-id;
 bh=gMwZhfbQY6Q4xFhPV1ksh+9lPS1yogWJRwNVmUZ0RdE=;
 b=ikHOm+yqACU8Bks42i836ccLe7VakZ7H5xL21CMNopNQB/wxxFINVb6Jd0X1JA4vHxKShzfRgMu
 qezOsBxt8uNf3LzAbuR8RN3FAq+p2ykQY7T/jHLeGrMFvcH/PNjpPQl0xkGNHY6jDXh/NXB7t1gbT
 f5qOdi+mLEaM35Mlyw9dEMMB28HqYqeNLn2K/RwL2w5qzT8MFoUO6ebHoTdVxcGfpqAs5CQ6ZQMi+
 uJfJezbBK89rCOSeXmgXJkOgShebVyns7TutHOpCYaF5vJ/zWesr+VB/Um7u30gUxSc5OzvJHWy7k
 /ITaXWbr/NxBvKzNZPkqkSRzEvfDjgCPiJWg==
Received: from dish.amicon.lan (172.16.30.10) by mail.amicon.lan
 (192.168.0.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Mon, 28 Sep
 2026 17:57:32 +0300
From: Daniil Iskhakov <dish@amicon.ru>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, <dish@amicon.ru>, <rrv@amicon.ru>,
 <dmitry.kozliuk@gmail.com>, <sdl.dpdk@linuxtesting.org>
Subject: [PATCH v2] fbarray: check file lock downgrade failure
Date: Mon, 28 Sep 2026 18:00:25 +0300
Message-ID: <20260928150025.593474-1-dish@amicon.ru>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Originating-IP: [172.16.30.10]
X-ClientProxiedBy: mail.amicon.lan (192.168.0.59) To mail.amicon.lan
 (192.168.0.59)
X-Mailman-Approved-At: Tue, 29 Sep 2026 07:41:44 +0200
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

If unlinking of the file fails, rte_fbarray_destroy() keeps the fbarray
mapped and attempts to downgrade the exclusive file lock back to a
shared lock. The result of this downgrade is currently ignored.

Check the return value and log a failure. Save errno immediately after
the failed unlink(), because subsequent calls may change it. Before
returning, set rte_errno to the saved value so the caller receives the
primary reason why the destroy operation failed.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 5b61c62cfd76 ("fbarray: add internal tailq for mapped areas")
Cc: stable@dpdk.org

Signed-off-by: Daniil Iskhakov <dish@amicon.ru>
---
v2:
- preserve the unlink() error across the lock downgrade attempt
- check the lock operation result explicitly
- update the Fixes tag to the commit that introduced the unchecked
    downgrade
---
Cc: dmitry.kozliuk@gmail.com
Cc: sdl.dpdk@linuxtesting.org
Cc: rrv@amicon.ru
---
 lib/eal/common/eal_common_fbarray.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/lib/eal/common/eal_common_fbarray.c b/lib/eal/common/eal_common_fbarray.c
index 8bdcefb717..5b3532893c 100644
--- a/lib/eal/common/eal_common_fbarray.c
+++ b/lib/eal/common/eal_common_fbarray.c
@@ -1015,15 +1015,19 @@ rte_fbarray_destroy(struct rte_fbarray *arr)
 		/* we're OK to destroy the file */
 		eal_get_fbarray_path(path, sizeof(path), arr->name);
 		if (unlink(path)) {
+			const int unlink_errno = errno;
+
 			EAL_LOG(DEBUG, "Cannot unlink fbarray: %s",
-				strerror(errno));
-			rte_errno = errno;
+				strerror(unlink_errno));
 			/*
 			 * we're still holding an exclusive lock, so drop it to
 			 * shared.
 			 */
-			eal_file_lock(fd, EAL_FLOCK_SHARED, EAL_FLOCK_RETURN);
+			if (eal_file_lock(fd, EAL_FLOCK_SHARED, EAL_FLOCK_RETURN) != 0)
+				EAL_LOG(DEBUG, "Cannot restore fbarray shared lock: %s",
+					rte_strerror(rte_errno));
 
+			rte_errno = unlink_errno;
 			ret = -1;
 			goto out;
 		}
-- 
2.53.0

