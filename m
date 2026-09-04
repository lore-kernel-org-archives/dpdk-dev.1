Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF0CEC624DE
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Sep 2026 12:17:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EA21C42FDB;
	Fri,  4 Sep 2026 14:17:07 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id BD1CF42FC3
 for <dev@dpdk.org>; Fri,  4 Sep 2026 14:17:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788524226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vAM23x4u6pScVwcievcdUNYIQR6WzTXyDFIDJis6slg=;
 b=RskvoyYK05ZPyHrTKNynu2byNoMjtMSArtnlfC1tFHSyDoyKZLO5Wf+48R9teLpruXCm/h
 NNLJ3Dc7iX+eomEoIVX1gTB+s7i/AEybwEj/8F38U8hmXg5xKtewmUGls4WHAGzU1zmMjD
 mQoNXydtb/AcCvUkrHlubgdEtfL/4Aw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-509-TmkumrUQPnq82WwTB1K-Ow-1; Fri,
 04 Sep 2026 08:17:03 -0400
X-MC-Unique: TmkumrUQPnq82WwTB1K-Ow-1
X-Mimecast-MFC-AGG-ID: TmkumrUQPnq82WwTB1K-Ow_1788524222
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 21611188FEF7; Fri,  4 Sep 2026 12:17:02 +0000 (UTC)
Received: from dmarchan.home (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 91FFC1955F70; Fri,  4 Sep 2026 12:17:00 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH 1/2] net/i40e: fix MAC address removal
Date: Fri,  4 Sep 2026 14:16:50 +0200
Message-ID: <20260904121651.2254684-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IqJ8e79Q4UrqKr0qe5O5YK54nCy_sP5UrzIRdQ8LWwk_1788524222
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

---
 drivers/net/intel/i40e/i40e_ethdev.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
index b6b2d291ee..5bc3c22def 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.c
+++ b/drivers/net/intel/i40e/i40e_ethdev.c
@@ -4513,7 +4513,11 @@ i40e_macaddr_remove(struct rte_eth_dev *dev, uint32_t index)
 
 	macaddr = &(data->mac_addrs[index]);
 
-	pool_sel = dev->data->mac_pool_sel[index];
+	vmdq = (dev->data->dev_conf.rxmode.mq_mode & RTE_ETH_MQ_RX_VMDQ_FLAG) != 0;
+	if (!vmdq)
+		pool_mask = 1;
+	else
+		pool_mask = dev->data->mac_pool_sel[index];
 
 	for (i = 0; i < sizeof(pool_sel) * CHAR_BIT; i++) {
 		if (pool_sel & RTE_BIT64(i)) {
-- 
2.54.0

