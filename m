Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E42D606A31A
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 09:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LhiGoDvc
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BFB1740151;
	Tue, 27 Oct 2026 10:58:41 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTPS id 537EF400D5
 for <dev@dpdk.org>; Tue, 27 Oct 2026 10:58:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793095119;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=GjXPh4w+00klBtV5oId2VQN05FLU1+MeEW4F7exuEKk=;
 b=LhiGoDvcrnmx1j9KadFBjoyoiW/8FlytRUmuHuZizrcCxznHBlVgBXO6Tx16LDXIn09xcT
 v/dJplhlnKloznzJTUcBUHwLU15J4x5WgpMtn/S21w994SvrmxgmJuPyoOQrWmmGg1W63K
 obT9QYHSw8gLHDArGhN8/v1LfSKfyrQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-28-FDceuNfRO8GnCikiRLe2tA-1; Tue,
 27 Oct 2026 05:58:37 -0400
X-MC-Unique: FDceuNfRO8GnCikiRLe2tA-1
X-Mimecast-MFC-AGG-ID: FDceuNfRO8GnCikiRLe2tA_1793095117
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B20BC1955D7A; Tue, 27 Oct 2026 09:58:36 +0000 (UTC)
Received: from dmarchan.lan (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E5505195608B; Tue, 27 Oct 2026 09:58:35 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com
Subject: [PATCH] net/i40e: fix MAC address removal without VMDq
Date: Tue, 27 Oct 2026 10:58:32 +0100
Message-ID: <20261027095832.358077-1-david.marchand@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ghgQ362u_I3b85nLtfWXqjlQSmc-KNjhFCmd_M1JnO8_1793095117
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The MAC address removal was checking if the hardware supports VMDq
(I40E_FLAG_VMDQ) to decide whether to use pool-based removal.
However, ethdev only populates mac_pool_sel[] when VMDq mode is actually
configured. As a result, when VMDq is supported but not configured,
mac_pool_sel is 0 and no MAC address gets removed.

Fix by checking if VMDq mode is configured, matching the condition
used by ethdev to manage mac_pool_sel[].

Bugzilla ID: 2074
Fixes: 774365884bb8 ("net/i40e: fix MAC address removal")

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/net/intel/i40e/i40e_ethdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
index 2405d9e119..46149134fa 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.c
+++ b/drivers/net/intel/i40e/i40e_ethdev.c
@@ -4501,7 +4501,7 @@ i40e_macaddr_remove(struct rte_eth_dev *dev, uint32_t index)
 
 	macaddr = &(data->mac_addrs[index]);
 
-	if (!(pf->flags & I40E_FLAG_VMDQ)) {
+	if ((dev->data->dev_conf.rxmode.mq_mode & RTE_ETH_MQ_RX_VMDQ_FLAG) == 0) {
 		if (i40e_vsi_delete_mac(pf->main_vsi, macaddr) != 0)
 			PMD_DRV_LOG(ERR, "Failed to remove MACVLAN filter");
 		return;
-- 
2.54.0

