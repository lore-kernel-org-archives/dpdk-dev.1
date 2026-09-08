Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD61C79F99
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Sep 2026 07:19:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D6C240655;
	Tue,  8 Sep 2026 09:19:09 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 9607840615
 for <dev@dpdk.org>; Tue,  8 Sep 2026 09:19:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788851948;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ebkGDqAaQsbY9/a2HjAooWVZXXw5Sk2VcywbKeZrXF0=;
 b=X049sg2KNgdFWLcsWpHlQJ+oZodHaRk3fT2n/mS6s4u1Se1k57EY3Ejy8ABcD/uwcVwLxz
 hPBEPyuQZjhgNVCwz2Jzo9BlcvOOGPKjiofYBryFXtJwxs3I46rglqmztGOP7xqzqQCUfQ
 pwDqsX2AF13vbi10AgMpY3PEXmizzzI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-516-qSpzaG-7OU-LNH8IMLAHlQ-1; Tue,
 08 Sep 2026 03:19:04 -0400
X-MC-Unique: qSpzaG-7OU-LNH8IMLAHlQ-1
X-Mimecast-MFC-AGG-ID: qSpzaG-7OU-LNH8IMLAHlQ_1788851944
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5FF1F19539B8; Tue,  8 Sep 2026 07:19:03 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2259E1955F05; Tue,  8 Sep 2026 07:19:01 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v3 2/2] net/bnxt: fix MAC address removal
Date: Tue,  8 Sep 2026 09:18:53 +0200
Message-ID: <20260908071854.3419531-2-david.marchand@redhat.com>
In-Reply-To: <20260908071854.3419531-1-david.marchand@redhat.com>
References: <20260904121651.2254684-1-david.marchand@redhat.com>
 <20260908071854.3419531-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DudHuEpkfjELeSRTSR1HMnwT9BAdmwJoYY9GxAw3hA8_1788851944
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

MAC addresses removal was tied with VMDq pools even when not used.
So if VMDq is not enabled, no address would be ever removed.

Fixes: f9ddb36e0065 ("ethdev: skip VMDq pools unless configured")

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/net/bnxt/bnxt_ethdev.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethdev.c
index c6f566c214..178814509e 100644
--- a/drivers/net/bnxt/bnxt_ethdev.c
+++ b/drivers/net/bnxt/bnxt_ethdev.c
@@ -2019,7 +2019,7 @@ static void bnxt_mac_addr_remove_op(struct rte_eth_dev *eth_dev,
 				    uint32_t index)
 {
 	struct bnxt *bp = eth_dev->data->dev_private;
-	uint64_t pool_mask = eth_dev->data->mac_pool_sel[index];
+	uint64_t pool_mask;
 	struct bnxt_vnic_info *vnic;
 	struct bnxt_filter_info *filter, *temp_filter;
 	uint32_t i;
@@ -2027,6 +2027,11 @@ static void bnxt_mac_addr_remove_op(struct rte_eth_dev *eth_dev,
 	if (is_bnxt_in_error(bp))
 		return;
 
+	if ((eth_dev->data->dev_conf.rxmode.mq_mode & RTE_ETH_MQ_RX_VMDQ_FLAG) == 0)
+		pool_mask = 1;
+	else
+		pool_mask = eth_dev->data->mac_pool_sel[index];
+
 	/*
 	 * Loop through all VNICs from the specified filter flow pools to
 	 * remove the corresponding MAC addr filter
@@ -4540,6 +4545,7 @@ static int bnxt_restore_mac_filters(struct bnxt *bp)
 	uint64_t pool_mask;
 	uint32_t pool = 0;
 	uint32_t i;
+	bool vmdq;
 	int rc;
 
 	if (BNXT_VF(bp) && !BNXT_VF_IS_TRUSTED(bp))
@@ -4549,6 +4555,8 @@ static int bnxt_restore_mac_filters(struct bnxt *bp)
 	if (rc)
 		return rc;
 
+	vmdq = (dev->data->dev_conf.rxmode.mq_mode & RTE_ETH_MQ_RX_VMDQ_FLAG) != 0;
+
 	/* replay MAC address configuration */
 	for (i = 1; i < dev_info.max_mac_addrs; i++) {
 		addr = &dev->data->mac_addrs[i];
@@ -4558,7 +4566,10 @@ static int bnxt_restore_mac_filters(struct bnxt *bp)
 			continue;
 
 		pool = 0;
-		pool_mask = dev->data->mac_pool_sel[i];
+		if (!vmdq)
+			pool_mask = 1;
+		else
+			pool_mask = dev->data->mac_pool_sel[i];
 
 		do {
 			if (pool_mask & 1ULL) {
-- 
2.54.0

