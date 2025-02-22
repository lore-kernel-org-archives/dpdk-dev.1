Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1BE3C021B2
	for <dpdk-dev@archiver.kernel.org>; Sat, 22 Feb 2025 03:57:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9D3FA41143;
	Sat, 22 Feb 2025 04:57:44 +0100 (CET)
Received: from lf-1-16.ptr.blmpb.com (lf-1-16.ptr.blmpb.com [103.149.242.16])
 by mails.dpdk.org (Postfix) with ESMTP id 271AA427CC
 for <dev@dpdk.org>; Sat, 22 Feb 2025 04:57:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1740196655; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=BjKQe9pFI+6RhEUK00RGubAET6yQ3vO2bB9wWEphlHM=;
 b=YYU5Hp/UiQ7XAOQuAQMl7Xw3aJhu0ANwbEoKDwp4kMz7x57H34bnXUkEQJwiNvMuOEGkoa
 AG4YczqWN5fKN31n5spdLhUOGa54pPBJyih+n/MuOyWzPq7y83bgu6Ttrg0mbfQf48TGND
 ngq+h2uYnou9e5jrzNb+YjzXMvPXl7DaL52pLYDVhWhFx0spusV5blM25KSPS5FKxgq9vi
 7RCLKuouj6QhTLrDvNt//0QM5Qxxxrkpl4PpCZw0CQ3RpPtDPLm9rMwQ7jGp08CQQX4spa
 TIQIqf+mFR1lweG2yXIXgtuVqENGYveghYkwWBrlXgKOhlsbCVjTuMbqxgaTsg==
X-Original-From: Renyong Wan <wanry@yunsilicon.com>
Content-Transfer-Encoding: 7bit
Cc: <thomas@monjalon.net>, <stephen@networkplumber.org>, 
 <qianr@yunsilicon.com>, <nana@yunsilicon.com>, <zhangxx@yunsilicon.com>, 
 <xudw@yunsilicon.com>, <jacky@yunsilicon.com>, <weihg@yunsilicon.com>, 
 <zhenghy@yunsilicon.com>
Date: Sat, 22 Feb 2025 11:57:33 +0800
Mime-Version: 1.0
References: <20250222035732.2290067-1-wanry@yunsilicon.com>
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn
 with ESMTPS; Sat, 22 Feb 2025 11:57:33 +0800
Subject: [PATCH 01/12] net/xsc: avoid integer overflow
X-Lms-Return-Path: <lba+267b94b2d+fbe8c9+dpdk.org+wanry@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8
To: <dev@dpdk.org>
From: "Renyong Wan" <wanry@yunsilicon.com>
Message-Id: <20250222035732.2290067-2-wanry@yunsilicon.com>
In-Reply-To: <20250222035732.2290067-1-wanry@yunsilicon.com>
X-Mailer: git-send-email 2.25.1
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

Address the integer overflow issue reported by Coverity Scan.

Coverity issue: 456589

Signed-off-by: Renyong Wan <wanry@yunsilicon.com>
---
 drivers/net/xsc/xsc_tx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/xsc/xsc_tx.c b/drivers/net/xsc/xsc_tx.c
index 406fa95381..1d31e84d69 100644
--- a/drivers/net/xsc/xsc_tx.c
+++ b/drivers/net/xsc/xsc_tx.c
@@ -50,7 +50,7 @@ xsc_txq_obj_new(struct xsc_dev *xdev, struct xsc_txq_data *txq_data,
 	txq_data->cq_db = cq_info.cq_db;
 	txq_data->cqn = cq_info.cqn;
 	txq_data->cqes = cq_info.cqes;
-	txq_data->cqe_m = txq_data->cqe_s - 1;
+	txq_data->cqe_m = (uint16_t)(1 << cq_info.cqe_n) - 1;
 
 	PMD_DRV_LOG(INFO, "Create tx cq, cqe_s:%d, cqe_n:%d, cq_db=%p, cqn:%d",
 		    txq_data->cqe_s, txq_data->cqe_n,
-- 
2.25.1
