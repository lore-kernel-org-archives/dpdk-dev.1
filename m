Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D7BACCD195
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Oct 2025 12:20:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 181B5427D7;
	Fri, 17 Oct 2025 14:20:06 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 5C965427D7
 for <dev@dpdk.org>; Fri, 17 Oct 2025 14:20:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760703604;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=hQx79gASU9nxFkh5JEJN5564/IxS2kz86DGMsuzTfYI=;
 b=X1OphMsIDEelBBOLoueZDojsti1lr2esgfWACctoj1kRith8Inc6k3LKP9D4mksBPW9a2e
 YFb97fcmFCA/4XefKJIwMfvHZBLhJfA+ChYCLu8raahcX9KUG+8wTx3RH3WGJX8+rZy4Rs
 m9W1YV9omD+89fxgT0FfM/bO781K1/g=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-mwQ-1WjEMKOmHWznS-APGA-1; Fri,
 17 Oct 2025 08:20:02 -0400
X-MC-Unique: mwQ-1WjEMKOmHWznS-APGA-1
X-Mimecast-MFC-AGG-ID: mwQ-1WjEMKOmHWznS-APGA_1760703601
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7E079195608F; Fri, 17 Oct 2025 12:20:00 +0000 (UTC)
Received: from ringo.redhat.com (unknown [10.44.33.159])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6C0BC1956056; Fri, 17 Oct 2025 12:19:58 +0000 (UTC)
From: Robin Jarry <rjarry@redhat.com>
To: dev@dpdk.org, Stephen Hemminger <stephen@networkplumber.org>,
 Keith Wiles <keith.wiles@intel.com>, Pascal Mazon <pascal.mazon@6wind.com>
Cc: stable@dpdk.org
Subject: [PATCH dpdk] net/tap: fix interrupt callback crash after failed start
Date: Fri, 17 Oct 2025 14:19:47 +0200
Message-ID: <20251017121946.421658-2-rjarry@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: d0kXmdAQStFZxeM-tKkFijysidaWhf0CoeEXVD9UT7g_1760703601
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

After moving a tap linux net device to a different namespace,
tap_link_set_up fails with an -ENODEV error. Indeed it relies on an
ioctl call using the interface name as argument:

	/* with ifr->ifrn_name = "dtapX" */
	ioctl(pmd->ioctl_sock, SIOCGIFFLAGS, ifr)

This causes rte_eth_dev_stop() to do nothing since the device is not
seen as started. And then, when removing the device, the interrupt
callbacks are left there.

If they are invoked, they will be so with a "freed" device pointer:

Thread 2 "dpdk-intr" hit Breakpoint 1, tap_dev_intr_handler
    at ../drivers/net/tap/rte_eth_tap.c:1689
1689            struct pmd_internals *pmd = dev->data->dev_private;
(gdb) p *dev
$2 = {
  ...
  data = 0x0,
  ...
  state = RTE_ETH_DEV_UNUSED,
  security_ctx = 0x0
}

This causes a crash when dereferencing the data pointer.

When tap_link_set_up fails, ensure to unregister the interrupt callbacks
that were just reinstalled.

Cc: stable@dpdk.org
Fixes: c0bddd3a057f ("net/tap: add link status notification")

Signed-off-by: Robin Jarry <rjarry@redhat.com>
---
 drivers/net/tap/rte_eth_tap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/tap/rte_eth_tap.c b/drivers/net/tap/rte_eth_tap.c
index 650ddbd70623..58d70f7dd60f 100644
--- a/drivers/net/tap/rte_eth_tap.c
+++ b/drivers/net/tap/rte_eth_tap.c
@@ -889,8 +889,10 @@ tap_dev_start(struct rte_eth_dev *dev)
 		return err;
 
 	err = tap_link_set_up(dev);
-	if (err)
+	if (err) {
+		tap_intr_handle_set(dev, 0);
 		return err;
+	}
 
 	for (i = 0; i < dev->data->nb_tx_queues; i++)
 		dev->data->tx_queue_state[i] = RTE_ETH_QUEUE_STATE_STARTED;
-- 
2.51.0

