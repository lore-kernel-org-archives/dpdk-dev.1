Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95705C79F87
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Jan 2026 12:36:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 626064026F;
	Mon,  5 Jan 2026 13:36:52 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 7634140267
 for <dev@dpdk.org>; Mon,  5 Jan 2026 13:36:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767616610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mm0vy3d2I5ciJx5w2KbnhEMvLJslJLihmJQc7bMTac8=;
 b=bPwAYyZpdY6ZCsEnS2PF7teX9VhWubyz2Y0ui7WhsUztYiitDx5NvWV7MKaR6QERoTyHpk
 YC8yvO3piQHdZVdOSOpEh5tUdkMF9Rb2AMBsJ/0Lx8i/4JaTdm79ctiPe5atunuIXzCj5U
 ao/WamM139qEjpmsHrMEgvQgd7X1Nro=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-nKa4etAAPMasUnVcbbbDAQ-1; Mon,
 05 Jan 2026 07:36:47 -0500
X-MC-Unique: nKa4etAAPMasUnVcbbbDAQ-1
X-Mimecast-MFC-AGG-ID: nKa4etAAPMasUnVcbbbDAQ_1767616605
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8EFEC1956096; Mon,  5 Jan 2026 12:36:45 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.224.210])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BCCF5180049F; Mon,  5 Jan 2026 12:36:43 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: stable@dpdk.org, Stephen Hemminger <stephen@networkplumber.org>,
 Ferruh Yigit <ferruh.yigit@amd.com>,
 Kumara Parameshwaran <kumaraparamesh92@gmail.com>
Subject: [PATCH] net/tap: remove log when running without multiprocess
Date: Mon,  5 Jan 2026 13:36:40 +0100
Message-ID: <20260105123640.48325-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dWSB2FxaXbHU3_uMlOVDT8xklAc9u3rdrzdxkL52ung_1767616605
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

In case DPDK is started with multiprocess disabled (like in OVS), there
is no reason to log an error on multiprocess aspects.

Note: the only caller of this helper does not check the return value.

Fixes: c36ce7099c21 ("net/tap: fix to populate FDs in secondary process")
Cc: stable@dpdk.org

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/net/tap/rte_eth_tap.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/tap/rte_eth_tap.c b/drivers/net/tap/rte_eth_tap.c
index 730f1859bd..7a8a98cddb 100644
--- a/drivers/net/tap/rte_eth_tap.c
+++ b/drivers/net/tap/rte_eth_tap.c
@@ -769,7 +769,7 @@ tap_link_set_up(struct rte_eth_dev *dev)
 	return 0;
 }
 
-static int
+static void
 tap_mp_req_on_rxtx(struct rte_eth_dev *dev)
 {
 	struct rte_mp_msg msg;
@@ -791,13 +791,10 @@ tap_mp_req_on_rxtx(struct rte_eth_dev *dev)
 	msg.num_fds = dev->data->nb_rx_queues;
 
 	err = rte_mp_sendmsg(&msg);
-	if (err < 0) {
+	if (err < 0 && rte_errno != ENOTSUP) {
 		TAP_LOG(ERR, "Failed to send start req to secondary %d",
 			rte_errno);
-		return -1;
 	}
-
-	return 0;
 }
 
 static int
-- 
2.52.0

