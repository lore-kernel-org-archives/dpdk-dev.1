Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57212C021B5
	for <dpdk-dev@archiver.kernel.org>; Sat, 22 Feb 2025 03:58:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E563F427E8;
	Sat, 22 Feb 2025 04:57:59 +0100 (CET)
Received: from lf-2-32.ptr.blmpb.com (lf-2-32.ptr.blmpb.com [101.36.218.32])
 by mails.dpdk.org (Postfix) with ESMTP id 312BA427E9
 for <dev@dpdk.org>; Sat, 22 Feb 2025 04:57:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1740196671; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=rmNSRXNn8hYhnpLrF1Eym4IwPviDWsAErAIb8WugebY=;
 b=SicwHvU/ziZgz4s66kNW3QxI7mCMAMP8/vxEF/RmymDq/iMRYVY0jxL6Eq8Z7UDFkMQ8lV
 o78FXWbOktc3rso23Lqpmdc41/wxUh03o8h/OSJlKcpUpiorpPDYWjV5cQQj3jcm+gzDvD
 Dg5s9XhDNykNXxIEYEBa9XjYMDJHkZSM2BuJVks+V8IyYqrdXfssob3l15USJyRD1ZF9c6
 zP+7Galw9MzTrgiAQa+0VdyrN2qrM+CYDBtB2RJHfVmlS+CYmESArZ7MPZ1DjNNNuDEcJa
 ukOzKz8soTeI9JSX8O1IfvspsGwDMKz++q2F1OTLSPMiTaW0usUN/YY1Ctdotg==
Date: Sat, 22 Feb 2025 11:57:48 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn
 with ESMTPS; Sat, 22 Feb 2025 11:57:48 +0800
X-Original-From: Renyong Wan <wanry@yunsilicon.com>
Content-Transfer-Encoding: 7bit
To: <dev@dpdk.org>
Cc: <thomas@monjalon.net>, <stephen@networkplumber.org>, 
 <qianr@yunsilicon.com>, <nana@yunsilicon.com>, <zhangxx@yunsilicon.com>, 
 <xudw@yunsilicon.com>, <jacky@yunsilicon.com>, <weihg@yunsilicon.com>, 
 <zhenghy@yunsilicon.com>
From: "Renyong Wan" <wanry@yunsilicon.com>
Subject: [PATCH 08/12] net/xsc: remove always-true part of if expression
In-Reply-To: <20250222035732.2290067-1-wanry@yunsilicon.com>
Message-Id: <20250222035747.2290067-9-wanry@yunsilicon.com>
References: <20250222035732.2290067-1-wanry@yunsilicon.com>
X-Lms-Return-Path: <lba+267b94b3d+6a30a8+dpdk.org+wanry@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8
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

This issue was reported by PVS studio, described as:
https://pvs-studio.com/en/docs/warnings/v560/

Signed-off-by: Rong Qian <qianr@yunsilicon.com>
Signed-off-by: Renyong Wan <wanry@yunsilicon.com>
---
 drivers/net/xsc/xsc_rx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/xsc/xsc_rx.c b/drivers/net/xsc/xsc_rx.c
index dfb71ed087..c031e56a94 100644
--- a/drivers/net/xsc/xsc_rx.c
+++ b/drivers/net/xsc/xsc_rx.c
@@ -42,8 +42,6 @@ xsc_rx_poll_len(struct xsc_rxq_data *rxq, volatile struct xsc_cqe *cqe)
 		if (unlikely(ret != XSC_CQE_OWNER_SW)) {
 			if (unlikely(ret == XSC_CQE_OWNER_ERR)) {
 				++rxq->stats.rx_errors;
-				if (ret == XSC_CQE_OWNER_HW || ret == -1)
-					return 0;
 			} else {
 				return 0;
 			}
-- 
2.25.1
