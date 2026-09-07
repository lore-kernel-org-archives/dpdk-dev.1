Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25FFAC79FA9
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Sep 2026 11:17:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2618B4027F;
	Mon,  7 Sep 2026 13:17:36 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 8EA6B40041
 for <dev@dpdk.org>; Mon,  7 Sep 2026 13:17:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788779854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DXWCOFaIFZB3bBNczvX8a3wi8Mt8Opy36IDOQSycpMo=;
 b=QXH8rCL+FDIJttynpIPgVfN2jQnib439KxeY+4HJfETiqssk8OCjk2hzBbJ6SKak1hutY3
 iNzDNLi/06PqN6nnQFVk88xmZbELWe42xoAivm8G+DL34Yq+ciE6No1lD2szok8whW8OHL
 /RCj8BOGr0SfI8d7eS2GchaJa7jUKIw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-373-lHVdRr_8MTiFb_77pU1ErA-1; Mon,
 07 Sep 2026 07:17:30 -0400
X-MC-Unique: lHVdRr_8MTiFb_77pU1ErA-1
X-Mimecast-MFC-AGG-ID: lHVdRr_8MTiFb_77pU1ErA_1788779850
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5E4E519541A9; Mon,  7 Sep 2026 11:17:29 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 015F21955F0E; Mon,  7 Sep 2026 11:17:27 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v2 1/2] net/i40e: fix MAC address removal
Date: Mon,  7 Sep 2026 13:17:23 +0200
Message-ID: <20260907111724.3043887-1-david.marchand@redhat.com>
In-Reply-To: <20260904121651.2254684-1-david.marchand@redhat.com>
References: <20260904121651.2254684-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wU8SWLOjb_JRsEwIre47aEJTWi0SZJsWgiDJ19p94Rc_1788779850
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

Fixes: 9de506a6c781 ("ethdev: skip VMDq pools unless configured")

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
I could not test the change as my setups are KO atm.

Probably worth squashing in 9de506a6c781 before pulling to main

Changes since v1:
- fixed compilation,

---
 drivers/net/intel/i40e/i40e_ethdev.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
index b6b2d291ee..3c01354c39 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.c
+++ b/drivers/net/intel/i40e/i40e_ethdev.c
@@ -4509,11 +4509,16 @@ i40e_macaddr_remove(struct rte_eth_dev *dev, uint32_t index)
 	struct rte_ether_addr *macaddr;
 	int ret;
 	uint32_t i;
+	bool vmdq;
 	uint64_t pool_sel;
 
 	macaddr = &(data->mac_addrs[index]);
 
-	pool_sel = dev->data->mac_pool_sel[index];
+	vmdq = (dev->data->dev_conf.rxmode.mq_mode & RTE_ETH_MQ_RX_VMDQ_FLAG) != 0;
+	if (!vmdq)
+		pool_sel = 1;
+	else
+		pool_sel = dev->data->mac_pool_sel[index];
 
 	for (i = 0; i < sizeof(pool_sel) * CHAR_BIT; i++) {
 		if (pool_sel & RTE_BIT64(i)) {
-- 
2.54.0

