Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A849BC79F99
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Sep 2026 07:19:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 574E74026E;
	Tue,  8 Sep 2026 09:19:07 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 425824026A
 for <dev@dpdk.org>; Tue,  8 Sep 2026 09:19:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788851944;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hLwr+am3i2z70TLjiPb9ULLdSPh4jLdgyfwdaSDYGJ0=;
 b=NShVAn07X2EvQapItB5sYEEBaJOYoVBpX15jesXnxdWtr3AfBhOt71OB6F/XR9BwtNOTNE
 pwYlU9YO86YHCR4iw60oMYN60i0HgAGTbTyJhYX/9+AFw86R5gB9eLdQoWbEAJOBu/wKvk
 sHRzsuBIIMxBZCWEwIRPl3QsAW6NpAc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-211-OFOr0ksPOZ2OWHBi1hyoIQ-1; Tue,
 08 Sep 2026 03:19:00 -0400
X-MC-Unique: OFOr0ksPOZ2OWHBi1hyoIQ-1
X-Mimecast-MFC-AGG-ID: OFOr0ksPOZ2OWHBi1hyoIQ_1788851940
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 960401834573; Tue,  8 Sep 2026 07:18:59 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E3D8230002ED; Tue,  8 Sep 2026 07:18:57 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v3 1/2] net/i40e: fix MAC address removal
Date: Tue,  8 Sep 2026 09:18:52 +0200
Message-ID: <20260908071854.3419531-1-david.marchand@redhat.com>
In-Reply-To: <20260904121651.2254684-1-david.marchand@redhat.com>
References: <20260904121651.2254684-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3UaVaGjYLrBI30VZZcqbfIq6iCrrVTSgnXhkWD5A4dA_1788851940
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
 drivers/net/intel/i40e/i40e_ethdev.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
index b6b2d291ee..0d914d86ea 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.c
+++ b/drivers/net/intel/i40e/i40e_ethdev.c
@@ -4513,6 +4513,12 @@ i40e_macaddr_remove(struct rte_eth_dev *dev, uint32_t index)
 
 	macaddr = &(data->mac_addrs[index]);
 
+	if (!(pf->flags & I40E_FLAG_VMDQ)) {
+		if (i40e_vsi_delete_mac(pf->main_vsi, macaddr) != 0)
+			PMD_DRV_LOG(ERR, "Failed to remove MACVLAN filter");
+		return;
+	}
+
 	pool_sel = dev->data->mac_pool_sel[index];
 
 	for (i = 0; i < sizeof(pool_sel) * CHAR_BIT; i++) {
@@ -4521,8 +4527,7 @@ i40e_macaddr_remove(struct rte_eth_dev *dev, uint32_t index)
 				vsi = pf->main_vsi;
 			else {
 				/* No VMDQ pool enabled or configured */
-				if (!(pf->flags & I40E_FLAG_VMDQ) ||
-					(i > pf->nb_cfg_vmdq_vsi)) {
+				if (i > pf->nb_cfg_vmdq_vsi) {
 					PMD_DRV_LOG(ERR,
 						"No VMDQ pool enabled/configured");
 					return;
-- 
2.54.0

