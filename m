Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB40C021B2
	for <dpdk-dev@archiver.kernel.org>; Sat, 22 Feb 2025 03:57:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BD5FC427D7;
	Sat, 22 Feb 2025 04:57:46 +0100 (CET)
Received: from lf-1-18.ptr.blmpb.com (lf-1-18.ptr.blmpb.com [103.149.242.18])
 by mails.dpdk.org (Postfix) with ESMTP id CD0BC427CC
 for <dev@dpdk.org>; Sat, 22 Feb 2025 04:57:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1740196657; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=g1MTM3NUkCeS1swIID0x9L42LqkyA9u6l1tDi2RHKxA=;
 b=FjVWLNbFKMF0+7NrkqpW3HEvoKVV1li6UvtvtDgBf2pewSQ0j2QOmYRLCJDfJ56cS1iY0/
 Yh3oaCyM2pjMvLii9o5wndx/MnsG6jGfxOv2SLjx3/gOO3x1Nk/mFKFVKwc9ZBIONAcF6J
 BkSM15quRPGZqvVYtOKorI4eqt3CeuZOnkeJCvRZ2hnOMTAhFvp/MjNDFw4VEKztn2BPa7
 7wGCR+dCct3ZihW4d469RueLB4+94rB95JxsDZ3i+SsP+ATxbkxWm/e5MJ0TI+LvTK0XJ2
 Gtq0ZBSEwscbx5s7lxGF/D34oLNEil6/BcS3SFEYSODNsJeT4565Yr3WmvAadg==
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn
 with ESMTPS; Sat, 22 Feb 2025 11:57:35 +0800
Cc: <thomas@monjalon.net>, <stephen@networkplumber.org>, 
 <qianr@yunsilicon.com>, <nana@yunsilicon.com>, <zhangxx@yunsilicon.com>, 
 <xudw@yunsilicon.com>, <jacky@yunsilicon.com>, <weihg@yunsilicon.com>, 
 <zhenghy@yunsilicon.com>
From: "Renyong Wan" <wanry@yunsilicon.com>
Mime-Version: 1.0
References: <20250222035732.2290067-1-wanry@yunsilicon.com>
Date: Sat, 22 Feb 2025 11:57:35 +0800
Content-Transfer-Encoding: 7bit
Message-Id: <20250222035734.2290067-3-wanry@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20250222035732.2290067-1-wanry@yunsilicon.com>
X-Lms-Return-Path: <lba+267b94b2f+0f8a33+dpdk.org+wanry@yunsilicon.com>
To: <dev@dpdk.org>
Subject: [PATCH 02/12] net/xsc: remove useless call
X-Mailer: git-send-email 2.25.1
X-Original-From: Renyong Wan <wanry@yunsilicon.com>
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

Address incorrect expression (USELESS_CALL) reported by Coverity Scan.

Coverity issue: 456590

Signed-off-by: Renyong Wan <wanry@yunsilicon.com>
---
 drivers/net/xsc/xsc_np.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/xsc/xsc_np.c b/drivers/net/xsc/xsc_np.c
index d4eb833bf6..f032a0dbc2 100644
--- a/drivers/net/xsc/xsc_np.c
+++ b/drivers/net/xsc/xsc_np.c
@@ -384,7 +384,6 @@ xsc_dev_create_vfos_baselp(struct xsc_dev *xdev)
 void
 xsc_dev_pct_uninit(void)
 {
-	rte_bitmap_free(xsc_pct_mgr.bmp_pct);
 	rte_free(xsc_pct_mgr.bmp_mem);
 }
 
-- 
2.25.1
