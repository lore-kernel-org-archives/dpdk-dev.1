Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A79FC83038
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Jul 2025 16:15:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D9D874067C;
	Tue,  1 Jul 2025 18:15:03 +0200 (CEST)
Received: from out203-205-221-164.mail.qq.com (out203-205-221-164.mail.qq.com
 [203.205.221.164])
 by mails.dpdk.org (Postfix) with UTF8SMTP id 6D21340676
 for <dev@dpdk.org>; Tue,  1 Jul 2025 18:15:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1751386490;
 bh=ykX5Tc7AqhknegLk52LYRvHmL//E51g+bLj9tzIxMck=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=DXG6t3pwbSIoEBx8fg95EnDuEAuIDjvD+YENT3mb9zZ/TSmVT5ZXAjBU9dEJMmKGt
 SkiE6ESfxHoAWxwFXk73xfbdRgGkpDGLNSJjGldZvy8IlNbSNEFQNRttFRSp62Zc0R
 LMU2IcZ+rqaEghTbZC/iG8GdYst3VL1Vc/AjQBWo=
Received: from ar ([113.231.127.221])
 by newxmesmtplogicsvrszc16-0.qq.com (NewEsmtp) with SMTP
 id 3B002AA4; Wed, 02 Jul 2025 00:14:48 +0800
X-QQ-mid: xmsmtpt1751386488tcwi7anzi
Message-ID: <tencent_72C3AA793655A72C6E86DE8A37E798B06409@qq.com>
X-QQ-XMAILINFO: N/WmRbclY25G/DImBq3olCSSknCPMwuRv8kGomUrg0NiEeEUojj3L08Oxyou5+
 csIsODF577p2ESeHzXaLY5FfiBE1OJPcVJnf4YFgT6Gx21cEkYknxul5lf3y17EQUxtwUyUtRYkO
 EO9R0ItWeRtSd/LR31U0uuSI7uZ6MtZO1jYhCek35Rm6rbXp2pSYsWqLQba9EJi6D0por6+yNxKm
 QEY9CeLAH0Hj8hTU69mlrNowvaYvNlJovcz7378sCUkCB8IeO+sB0xjTBeUp4GUy/6os2U7Z+4SB
 NBvcDCcf0x8fHEbtrj47OLml8LtcNoWFawsCjvvmsB9DWSI1+K5Hqo7XnZSoHRLbxcu3mm7Q7UIx
 BT1ak5UZNPryn8dk3ebyZwgE8rbQFYflfq2j6+CTbtY+VdH/bZP4eTxEzkyZnZtGajmmWIOMWTlz
 TveL+SKw9lTeVI6ZJ19rzfgEJeQNlad1u3lmoDGrdd98TcrYrCxfGCCLbtu8Hm2Be8G3i89a1Fwo
 4lGrSPYuMDIPvnbUL7oF3qmBV+rGETfQnZAFYUC/v5UUblVdVM4kY1nqe5dpbY2dY36nHg+Wsbmw
 YP33Fri7F+XHG7uXBTmUft+JnkaxffUivmtkzxV0C2HX4GeQh650gOeLs/iC9OMeDJ723gZ8uwb3
 ei5u6tj+B4T9HRhdQE2RzWNtM+qBePq1GU7gwd+n9P8n5UoFS+khRs2QvXT+vxQZ3DTky3mUwx11
 P82eVFmcvp2+jrWclv45HxbVJ9KIRx8/IyBQkkv1A1Spq3rHlLmO0XbRwBwMIftDH9V/hRSnyOFo
 ILe/65+rJr70diCqcerrNS+PuHG8lAwRuqxHTOi5m1rQnMCX4/QY0zWABw//ytlNT2/oc1KH6wa7
 AwNjKZKffnVmTybQY9KquR4SEXzxJ7bXH48iY4g/5APKkpXjv5yGJBzz4UQD6ZELfp6MLLnCJPjL
 NA4ITtAQTjI7qc+AwtmA==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: uk7b@foxmail.com
To: dev@dpdk.org
Cc: Sun Yuechi <sunyuechi@iscas.ac.cn>,
 Stanislaw Kardach <stanislaw.kardach@gmail.com>
Subject: [PATCH 2/5] eal/riscv/spinlock: add rte_cpuflag.h
Date: Wed,  2 Jul 2025 00:13:39 +0800
X-OQ-MSGID: <20250701161342.46750-3-uk7b@foxmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250701161342.46750-1-uk7b@foxmail.com>
References: <20250701161342.46750-1-uk7b@foxmail.com>
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

