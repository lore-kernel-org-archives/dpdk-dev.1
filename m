Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CEF6CD6E44
	for <dpdk-dev@archiver.kernel.org>; Thu, 28 May 2026 13:01:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E4E0040611;
	Thu, 28 May 2026 15:01:54 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.3])
 by mails.dpdk.org (Postfix) with ESMTP id 70BC54003C
 for <dev@dpdk.org>; Thu, 28 May 2026 15:01:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=mH1D+3naddPoOehvD/LeDvbHeOYixux7S4rzYp/hhvo=;
 b=MJZ8Q0/B7vikBG2WhT9RRFID9fZOcxjJ5tj+EpFRZwaWTP2wlU75a2zsIHH+kR
 BzIxNjS0W0fLPoEweIw9NZ6UBWUPm9/Ov5H/Q8FSZEc3neP6CGB43ZFfYS+OTegp
 uvWyYEsWJKVeYihc7iAQ/HgFvPkYBt6cKZ11I6VYNe71o=
Received: from localhost.localdomain (unknown [114.116.198.59])
 by gzsmtp2 (Coremail) with SMTP id As8vCgD3g3ayPBhqOOLhCw--.25977S6;
 Thu, 28 May 2026 21:01:47 +0800 (CST)
From: Feifei Wang <wff_light@vip.163.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>, Feifei Wang <wangfeifei@huawei.com>
Subject: [v6 2/2] net/hinic3: Modify SP230 VF device id
Date: Thu, 28 May 2026 21:01:20 +0800
Message-ID: <20260528130122.1213-3-wff_light@vip.163.com>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <20260528130122.1213-1-wff_light@vip.163.com>
References: <20260526121820.1093-2-wff_light@vip.163.com>
 <20260528130122.1213-1-wff_light@vip.163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgD3g3ayPBhqOOLhCw--.25977S6
X-Coremail-Antispam: 1Uf129KBjvdXoWrtw43Jr1kKF18Aw4kJFy7Wrg_yoW3JFb_CF
 1vgF1fuwnYkFn7tw4rKa4IvryYyF4IqrnYqw42yas3Zw15XrnIqr18Wrs8Wr9rGFn8ZFnx
 J3Z2grs3twn8tjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbqQ6tUUUUU==
X-Originating-IP: [114.116.198.59]
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiMhvd52oYPLucKAAA3S
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

From: Feifei Wang <wangfeifei40@huawei.com>

Modify SP230 the VF device ID of the SP230 NIC.

Signed-off-by: Feifei Wang <wangfeifei@huawei.com>
---
 drivers/net/hinic3/base/hinic3_csr.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/hinic3/base/hinic3_csr.h b/drivers/net/hinic3/base/hinic3_csr.h
index eceb34e..7cae241 100644
--- a/drivers/net/hinic3/base/hinic3_csr.h
+++ b/drivers/net/hinic3/base/hinic3_csr.h
@@ -11,7 +11,7 @@
 #define HINIC3_DEV_ID_VF_SP620	0x375F
 
 #define HINIC3_DEV_ID_SP230	0x0229
-#define HINIC3_DEV_ID_VF_SP230	0x3750
+#define HINIC3_DEV_ID_VF_SP230	0x022a
 
 #define HINIC3_DEV_ID_SP920	0x0224
 
-- 
2.47.0.windows.2

