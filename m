Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F23C021A4
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Feb 2025 02:48:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A30640662;
	Tue, 25 Feb 2025 03:48:25 +0100 (CET)
Received: from lf-2-39.ptr.blmpb.com (lf-2-39.ptr.blmpb.com [101.36.218.39])
 by mails.dpdk.org (Postfix) with ESMTP id F021D402B1
 for <dev@dpdk.org>; Tue, 25 Feb 2025 03:48:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1740451694; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=GqXGzuTLpwrU2V0G2PGBWIc006D0qDBR779e8fXOYLA=;
 b=VMOn6Z/0lueYZKISZUaMed+4io2B5zUmrhhGf+WdxfEhnEI76+aZQGS29cXVwXQXV3CYw1
 B/lmfAZ25WJ403aVUFXRCwleYzglZh1+75MEDDRIKJbGSVqbFoBFW20cQIjT+U9KW+v/cB
 MGbOse3NoeSHD4Ir0+KXtMEDp+8U7jfb5WI6FEzSqkXyI6ZDEe0dD6/mfHwRW0VuPSaIsJ
 PORtMjaF4mqvKrsRH4fL3jmBLmR46g3iS7kYFolpMuDBYGREnzBVMloFOMwPvp3PEHRD0z
 moA9a5PPH4AxUtRO/n5EbmkgdlgXCw1cWbfAgFESz9S2gd9qa4wmNUPA+qwIww==
Subject: [PATCH 1/2] net/xsc: check possible null pointer dereference
X-Mailer: git-send-email 2.25.1
X-Lms-Return-Path: <lba+267bd2f6c+b80840+dpdk.org+wanry@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn
 with ESMTPS; Tue, 25 Feb 2025 10:48:11 +0800
References: <20250225024810.2489747-1-wanry@yunsilicon.com>
X-Original-From: Renyong Wan <wanry@yunsilicon.com>
In-Reply-To: <20250225024810.2489747-1-wanry@yunsilicon.com>
To: <dev@dpdk.org>
Cc: <thomas@monjalon.net>, <stephen@networkplumber.org>, 
 <qianr@yunsilicon.com>, <nana@yunsilicon.com>, <zhangxx@yunsilicon.com>, 
 <xudw@yunsilicon.com>, <jacky@yunsilicon.com>, <weihg@yunsilicon.com>, 
 <zhenghy@yunsilicon.com>
Date: Tue, 25 Feb 2025 10:48:12 +0800
Mime-Version: 1.0
From: "Renyong Wan" <wanry@yunsilicon.com>
Message-Id: <20250225024810.2489747-2-wanry@yunsilicon.com>
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
https://pvs-studio.com/en/docs/warnings/v522/

Signed-off-by: Rong Qian <qianr@yunsilicon.com>
Signed-off-by: Renyong Wan <wanry@yunsilicon.com>
---
 drivers/net/xsc/xsc_rx.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/xsc/xsc_rx.c b/drivers/net/xsc/xsc_rx.c
index a702b9592b..0100ccdcfd 100644
--- a/drivers/net/xsc/xsc_rx.c
+++ b/drivers/net/xsc/xsc_rx.c
@@ -308,7 +308,9 @@ xsc_rss_qp_create(struct xsc_ethdev_priv *priv, int port_id)
 	in->req_len = rte_cpu_to_be_32(cmd_len);
 
 	for (i = 0; i < priv->num_rq; i++) {
-		rxq_data = (*priv->rxqs)[i];
+		rxq_data = xsc_rxq_get(priv, i);
+		if (rxq_data == NULL)
+			return -EINVAL;
 		req = (struct xsc_cmd_create_qp_request *)(&in->data[0] + entry_len * i);
 		req->input_qpn = rte_cpu_to_be_16(0); /* useless for eth */
 		req->pa_num = rte_cpu_to_be_16(pa_num);
@@ -348,6 +350,8 @@ xsc_rss_qp_create(struct xsc_ethdev_priv *priv, int port_id)
 
 	for (i = 0; i < priv->num_rq; i++) {
 		rxq_data = xsc_rxq_get(priv, i);
+		if (rxq_data == NULL)
+			return -EINVAL;
 		rxq_data->wqes = rxq_data->rq_pas->addr;
 		if (!xsc_dev_is_vf(xdev))
 			rxq_data->rq_db = (uint32_t *)((uint8_t *)xdev->bar_addr +
-- 
2.25.1
