Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98DD8C021B6
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Feb 2025 02:48:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C919942D0C;
	Tue, 25 Feb 2025 03:48:31 +0100 (CET)
Received: from lf-1-14.ptr.blmpb.com (lf-1-14.ptr.blmpb.com [103.149.242.14])
 by mails.dpdk.org (Postfix) with ESMTP id 814D5427D7
 for <dev@dpdk.org>; Tue, 25 Feb 2025 03:48:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1740451697; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=Xgn+EuVODdlKyUYkzaeBgJ017apYoPF+2jLslZC2/6s=;
 b=D/sn78L9BsaDNMsLHNnnRcy7xNoBjiKm5aRH8M8dLIBdG+40gl2NDc5GNfkzSHoPBxhGkb
 EqTAl5vN5/TNhc0Z2GiKbuvaguF6b+BWniklkRBhHfLr59CvZq0qw0Cgu2RDnufc8LZotA
 kLs8ilmjESV+ycZtA4ZnWe6NgI1D+T2aLcVEgIrl4cPHTLFMiCg/nYWtCJeog7xgk6lJOd
 dqKXit5YrtnIbZTFSP17KV3iuyne9DVOL6pWOfI1QHcoRdP2ISkTAFuUnNFV6BFQL0NQ1Q
 oGFr1uXcaun4/j3aa/fwTBqY+jrKq9JKXCMk4EJcg7smLVjMFBWcLQTCdTX7nA==
In-Reply-To: <20250225024810.2489747-1-wanry@yunsilicon.com>
From: "Renyong Wan" <wanry@yunsilicon.com>
Message-Id: <20250225024813.2489747-3-wanry@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8
X-Mailer: git-send-email 2.25.1
Mime-Version: 1.0
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn
 with ESMTPS; Tue, 25 Feb 2025 10:48:14 +0800
References: <20250225024810.2489747-1-wanry@yunsilicon.com>
To: <dev@dpdk.org>
Cc: <thomas@monjalon.net>, <stephen@networkplumber.org>, 
 <qianr@yunsilicon.com>, <nana@yunsilicon.com>, <zhangxx@yunsilicon.com>, 
 <xudw@yunsilicon.com>, <jacky@yunsilicon.com>, <weihg@yunsilicon.com>, 
 <zhenghy@yunsilicon.com>
Content-Transfer-Encoding: 7bit
Subject: [PATCH 2/2] net/xsc: suppress assign the same value warning
Date: Tue, 25 Feb 2025 10:48:15 +0800
X-Lms-Return-Path: <lba+267bd2f6f+63d613+dpdk.org+wanry@yunsilicon.com>
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

This issue was reported by PVS studio, described as:
https://pvs-studio.com/en/docs/warnings/v1048/

This warning is harmless since both structs have the same size.
The tool is just being annoying, so we should suppress it.

Signed-off-by: Rong Qian <qianr@yunsilicon.com>
Signed-off-by: Renyong Wan <wanry@yunsilicon.com>
---
 drivers/net/xsc/xsc_vfio_mbox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/xsc/xsc_vfio_mbox.c b/drivers/net/xsc/xsc_vfio_mbox.c
index c465679527..3c8bb54601 100644
--- a/drivers/net/xsc/xsc_vfio_mbox.c
+++ b/drivers/net/xsc/xsc_vfio_mbox.c
@@ -572,7 +572,7 @@ xsc_vfio_mbox_init(struct xsc_dev *xdev)
 	cmdq->req_lay = cmdq->req_mz->addr;
 
 	snprintf(name, RTE_MEMZONE_NAMESIZE, "%s_cmd_cq", xdev->pci_dev->device.name);
-	size = (1 << XSC_CMDQ_DEPTH_LOG) * sizeof(struct xsc_cmdq_rsp_layout);
+	size = (1 << XSC_CMDQ_DEPTH_LOG) * sizeof(struct xsc_cmdq_rsp_layout); /* -V1048 */
 	cmdq->rsp_mz = rte_memzone_reserve_aligned(name,
 						   size, SOCKET_ID_ANY,
 						   RTE_MEMZONE_IOVA_CONTIG,
-- 
2.25.1
