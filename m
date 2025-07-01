Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2AB8C83038
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Jul 2025 18:20:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F0424402E9;
	Tue,  1 Jul 2025 20:20:53 +0200 (CEST)
Received: from out203-205-221-245.mail.qq.com (out203-205-221-245.mail.qq.com
 [203.205.221.245])
 by mails.dpdk.org (Postfix) with UTF8SMTP id 36BD440264
 for <dev@dpdk.org>; Tue,  1 Jul 2025 20:20:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1751394043;
 bh=ykX5Tc7AqhknegLk52LYRvHmL//E51g+bLj9tzIxMck=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=PAytSwUN3t9UJU8I3YgckWhv08QgGDDwfT5lvXxN1ic+dBPiNMjGduLnIHAdS+7OG
 TIMAbSxSGZP3MLxPKCVOfLyPhBL0B53DmxUabYIZA+l3/HRKBVIh3ixLU/GhKcK+B7
 VDER2mpxeT0MkB3G20F3par69uC5jD+xVvqmMGkE=
Received: from ar ([113.231.127.221])
 by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
 id 52A9EABC; Wed, 02 Jul 2025 02:20:42 +0800
X-QQ-mid: xmsmtpt1751394042t1pocvzxz
Message-ID: <tencent_EFCE09AB3F6C9C0743F5C9226108A2D86D05@qq.com>
X-QQ-XMAILINFO: OVFdYp27KdlJTT2mTNrgDRl75j7N4NcI6svJu5LuQrFyLGFNPyF72zMYiUAYMS
 Dasg4zinx3j/mWUpRQtoy35Ldy+6M9Yqfz5vQectV3carHVW6n3McD0XDBqAqTx9NmkL7aAfHDsz
 tF3Mq2Iv0OyqcsJImITFs0k00ZPSDbePL2pFRmShLd6g0wWYH/jtbjZB3FV+UP3KAzyarsnen8Ow
 JD4yXGcw5VkwDp/rzfz2JmcGfYCIyw/cKVu+XhldJKPqgRvyQ6ELXGNc8QFCtiqAvfQw2WXLr7RK
 BVMs2mdd9Qgax2N3r8Nsu1UMzP2737YHq9GVybIjTN/Bb/AYCTxYPzoxKb9uiLhlBcvGNj7jah3q
 xITIO4rHUE6kga9IEvs2Y9iG8tgZvRE2wEk1Fqy4Cvl/YqAhahji8CzTC/t+kymcbhjgClrCjAbp
 Ot9qvYSMZjBdKY+KV3f88jiQ2JWqnpzA+wBi6pJjfoImwSlBxjTYfrCa+Ygt3E2Ob+5XujzGNzl3
 6DboWvRN+Q8UBD1PxumPuaOukd95yr2e1Fosm/GHQN+0zL9OJ9moNVidmKsDddk8sL2Sq0yiqaT2
 fN50ehkOiJYx98sqkY3TwZ9qaRwvsSZIoIAv7Od8St5VV9U2Op2ItLqp5SHhkV6E7FSrk4lj2Sdf
 PrSHXpKL9lz5MOvfA4Wl3S7WF29vu0d9cufvtTqzDPz1+xzSkuyAY5WMtAN/shmEOfuOehuLu7oF
 +e3s3A65C30oIiRgVnfRJyAOpTkfGZUnsuhWLmhL1Lhvd0qDlDxM1AAYmafDQX8lmoWSUWqklZe3
 /z/7g9hxx6ytGWjTOQTX92RckLH88yrn12eLy9ra35J7ZE1u9N6Y+9EcO9zqp0aPKyJdU2x7PZu8
 pqOWa70Acrtq74ml1Sq9jhkLYatxv/eakdjqZzfsnIprcxPp4wANNv1YVQzDHPKfIg/GvMBwJASs
 4CzeX8vVI7QmcpLrXURA==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: uk7b@foxmail.com
To: dev@dpdk.org
Cc: Sun Yuechi <sunyuechi@iscas.ac.cn>,
 Stanislaw Kardach <stanislaw.kardach@gmail.com>
Subject: [PATCH v2 2/5] eal/riscv/spinlock: add rte_cpuflag.h
Date: Wed,  2 Jul 2025 02:20:30 +0800
X-OQ-MSGID: <20250701182033.642384-3-uk7b@foxmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250701182033.642384-1-uk7b@foxmail.com>
References: <20250701182033.642384-1-uk7b@foxmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Sun Yuechi <sunyuechi@iscas.ac.cn>

Same as the x86 style, include "rte_cpuflags.h" in rte_spinlock.h
so that files like lib/fib/dir24_8.c don’t need to include it.

Signed-off-by: Sun Yuechi <sunyuechi@iscas.ac.cn>
---
 lib/eal/riscv/include/rte_spinlock.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/eal/riscv/include/rte_spinlock.h b/lib/eal/riscv/include/rte_spinlock.h
index 5fe4980e44..afbe83a061 100644
--- a/lib/eal/riscv/include/rte_spinlock.h
+++ b/lib/eal/riscv/include/rte_spinlock.h
@@ -14,6 +14,7 @@
 
 #include <rte_common.h>
 #include "generic/rte_spinlock.h"
+#include "rte_cpuflags.h"
 
 #ifdef __cplusplus
 extern "C" {
-- 
2.50.0

