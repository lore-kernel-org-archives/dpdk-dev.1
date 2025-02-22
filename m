Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A365C021B2
	for <dpdk-dev@archiver.kernel.org>; Sat, 22 Feb 2025 03:58:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F45E42D0C;
	Sat, 22 Feb 2025 04:57:57 +0100 (CET)
Received: from lf-1-14.ptr.blmpb.com (lf-1-14.ptr.blmpb.com [103.149.242.14])
 by mails.dpdk.org (Postfix) with ESMTP id 9320F427E9
 for <dev@dpdk.org>; Sat, 22 Feb 2025 04:57:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1740196668; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=Aavf5FlmJYwL0i7UXkEYyJrJE5lqpsWF87V2q36rCp8=;
 b=fkF6s47J7b6RE6maOMOF16uqGbi2QaYegAJHA7CUyNmYEAhjlCsZQiO1xpCiUsJlyZzlib
 6U0DOFlvnnZ17FjwSEXKzfFtZpdLC8T5uNEc/wbB0mg9nmCG+fyh5HzdVcfi3NTk8Q0Zew
 L+QmiJsJOREY+JnUbNAgTozXCFQfDVcT8TvPAYFtPTKdg00eWRy8xQ/32E9uDdk1V9mokO
 L7Wqiy+aX3MqZK156EVL8UO7CIXpRnzEyNat1bhTG5qPiew/0Of76Qix8UNVPdjl0PXIGL
 f5AV7MBgcbcr46Omc+F0rME5vmCcUFl4l5Aa8HqHZgsgFsA/qUylhfWKztuiEg==
Subject: [PATCH 07/12] net/xsc: avoid potential null pointer before used
Date: Sat, 22 Feb 2025 11:57:46 +0800
In-Reply-To: <20250222035732.2290067-1-wanry@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8
From: "Renyong Wan" <wanry@yunsilicon.com>
X-Original-From: Renyong Wan <wanry@yunsilicon.com>
X-Lms-Return-Path: <lba+267b94b3a+ddc880+dpdk.org+wanry@yunsilicon.com>
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
Cc: <thomas@monjalon.net>, <stephen@networkplumber.org>, 
 <qianr@yunsilicon.com>, <nana@yunsilicon.com>, <zhangxx@yunsilicon.com>, 
 <xudw@yunsilicon.com>, <jacky@yunsilicon.com>, <weihg@yunsilicon.com>, 
 <zhenghy@yunsilicon.com>
Message-Id: <20250222035745.2290067-8-wanry@yunsilicon.com>
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn
 with ESMTPS; Sat, 22 Feb 2025 11:57:46 +0800
X-Mailer: git-send-email 2.25.1
References: <20250222035732.2290067-1-wanry@yunsilicon.com>
To: <dev@dpdk.org>
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

This issue reported by PVS studio, described as:
https://pvs-studio.com/en/docs/warnings/v595/

Signed-off-by: Renyong Wan <wanry@yunsilicon.com>
---
 drivers/net/xsc/xsc_np.c   | 2 +-
 drivers/net/xsc/xsc_rx.c   | 2 +-
 drivers/net/xsc/xsc_vfio.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/xsc/xsc_np.c b/drivers/net/xsc/xsc_np.c
index f032a0dbc2..eff7497255 100644
--- a/drivers/net/xsc/xsc_np.c
+++ b/drivers/net/xsc/xsc_np.c
@@ -172,13 +172,13 @@ xsc_dev_np_exec(struct xsc_dev *xdev, void *cmd, int len, int table, int opmod)
 	out_len = sizeof(struct xsc_np_mbox_out) + data_len;
 	cmd_len = RTE_MAX(in_len, out_len);
 	in = malloc(cmd_len);
-	memset(in, 0, cmd_len);
 	if (in == NULL) {
 		rte_errno = ENOMEM;
 		PMD_DRV_LOG(ERR, "Failed to alloc np cmd memory");
 		return -rte_errno;
 	}
 
+	memset(in, 0, cmd_len);
 	in->hdr.opcode = rte_cpu_to_be_16(XSC_CMD_OP_EXEC_NP);
 	in->len = rte_cpu_to_be_16(data_len);
 
diff --git a/drivers/net/xsc/xsc_rx.c b/drivers/net/xsc/xsc_rx.c
index 140d7728d6..dfb71ed087 100644
--- a/drivers/net/xsc/xsc_rx.c
+++ b/drivers/net/xsc/xsc_rx.c
@@ -296,13 +296,13 @@ xsc_rss_qp_create(struct xsc_ethdev_priv *priv, int port_id)
 	out_len = sizeof(struct xsc_cmd_create_multiqp_mbox_out) + entry_total_len;
 	cmd_len = RTE_MAX(in_len, out_len);
 	in = malloc(cmd_len);
-	memset(in, 0, cmd_len);
 	if (in == NULL) {
 		rte_errno = ENOMEM;
 		PMD_DRV_LOG(ERR, "Alloc rss qp create cmd memory failed");
 		goto error;
 	}
 
+	memset(in, 0, cmd_len);
 	in->qp_num = rte_cpu_to_be_16((uint16_t)priv->num_rq);
 	in->qp_type = XSC_QUEUE_TYPE_RAW;
 	in->req_len = rte_cpu_to_be_32(cmd_len);
diff --git a/drivers/net/xsc/xsc_vfio.c b/drivers/net/xsc/xsc_vfio.c
index 6c679449af..2cd796ba26 100644
--- a/drivers/net/xsc/xsc_vfio.c
+++ b/drivers/net/xsc/xsc_vfio.c
@@ -431,13 +431,13 @@ xsc_vfio_rx_cq_create(struct xsc_dev *xdev, struct xsc_rx_cq_params *cq_params,
 	}
 
 	in = malloc(cmd_len);
-	memset(in, 0, cmd_len);
 	if (in == NULL) {
 		rte_errno = ENOMEM;
 		PMD_DRV_LOG(ERR, "Failed to alloc rx cq exec cmd memory");
 		goto error;
 	}
 
+	memset(in, 0, cmd_len);
 	in->hdr.opcode = rte_cpu_to_be_16(XSC_CMD_OP_CREATE_CQ);
 	in->ctx.eqn = 0;
 	in->ctx.pa_num = rte_cpu_to_be_16(pa_num);
-- 
2.25.1
