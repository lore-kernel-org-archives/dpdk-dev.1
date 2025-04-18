Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68590C369AB
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Apr 2025 10:34:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C764E4028B;
	Fri, 18 Apr 2025 12:34:46 +0200 (CEST)
Received: from lf-2-37.ptr.blmpb.com (lf-2-37.ptr.blmpb.com [101.36.218.37])
 by mails.dpdk.org (Postfix) with ESMTP id 77C86400D6
 for <dev@dpdk.org>; Fri, 18 Apr 2025 12:34:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1744972478; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=dfUKPCBDX9qNEZ9uJQiTG5/GiQOo+Q1TpB+rkyk3kL0=;
 b=EsCJ4KlZElHqcOYyNj2D6IdxCa/RDhHNoWsSiUXc8y2o4F9ad8mT50U0SfgX5H2z73xQb0
 waCd0+H2NYXO2WPs9s8it0X28ivhnXmwr4kQ0GAlDuJagks4I/EnUMHIGBbo4hQ6N1ke18
 dUSVoPdcDpY1omN0cs3CYqu6fHve3dT0RFF/Q2p2xb9m2gLVXpk33MR+xV0LC3u/OYnV/y
 23PGmpry45aiuVrP2D2kyX1GzGNbjeX7nSLkffl1pxdhC+VASGkrWVOrJCT6u4SQQCz9BC
 f1S7cnFT/MD0Uo7qQ1BWkv31QnWkyK3Cd+Tsa65h55kizUcZuod7TdvrUU4k8w==
From: "Renyong Wan" <wanry@yunsilicon.com>
Subject: [PATCH 1/2] net/xsc: fix resource leaks
In-Reply-To: <20250418103434.2489377-1-wanry@yunsilicon.com>
References: <20250418103434.2489377-1-wanry@yunsilicon.com>
X-Original-From: Renyong Wan <wanry@yunsilicon.com>
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn
 with ESMTPS; Fri, 18 Apr 2025 18:34:36 +0800
To: <dev@dpdk.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+268022abc+838272+dpdk.org+wanry@yunsilicon.com>
Content-Transfer-Encoding: 7bit
Message-Id: <20250418103434.2489377-2-wanry@yunsilicon.com>
X-Mailer: git-send-email 2.25.1
Cc: <thomas@monjalon.net>, <stephen@networkplumber.org>, 
 <qianr@yunsilicon.com>, <nana@yunsilicon.com>, <zhangxx@yunsilicon.com>, 
 <xudw@yunsilicon.com>, <jacky@yunsilicon.com>, <weihg@yunsilicon.com>, 
 <zhenghy@yunsilicon.com>
Date: Fri, 18 Apr 2025 18:34:36 +0800
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

Fixed the Coverity-detected issue that resource leaks.

Coverity issue: 457741
Fixes: 3d57851720d4 ("net/xsc: check null pointer dereference")

Signed-off-by: Rong Qian <qianr@yunsilicon.com>
Signed-off-by: Renyong Wan <wanry@yunsilicon.com>
---
 drivers/net/xsc/xsc_rx.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/xsc/xsc_rx.c b/drivers/net/xsc/xsc_rx.c
index 0100ccdcfd..65d63b94de 100644
--- a/drivers/net/xsc/xsc_rx.c
+++ b/drivers/net/xsc/xsc_rx.c
@@ -309,8 +309,11 @@ xsc_rss_qp_create(struct xsc_ethdev_priv *priv, int port_id)
 
 	for (i = 0; i < priv->num_rq; i++) {
 		rxq_data = xsc_rxq_get(priv, i);
-		if (rxq_data == NULL)
-			return -EINVAL;
+		if (rxq_data == NULL) {
+			rte_errno = EINVAL;
+			goto error;
+		}
+
 		req = (struct xsc_cmd_create_qp_request *)(&in->data[0] + entry_len * i);
 		req->input_qpn = rte_cpu_to_be_16(0); /* useless for eth */
 		req->pa_num = rte_cpu_to_be_16(pa_num);
@@ -350,8 +353,11 @@ xsc_rss_qp_create(struct xsc_ethdev_priv *priv, int port_id)
 
 	for (i = 0; i < priv->num_rq; i++) {
 		rxq_data = xsc_rxq_get(priv, i);
-		if (rxq_data == NULL)
-			return -EINVAL;
+		if (rxq_data == NULL) {
+			rte_errno = EINVAL;
+			goto error;
+		}
+
 		rxq_data->wqes = rxq_data->rq_pas->addr;
 		if (!xsc_dev_is_vf(xdev))
 			rxq_data->rq_db = (uint32_t *)((uint8_t *)xdev->bar_addr +
-- 
2.25.1
