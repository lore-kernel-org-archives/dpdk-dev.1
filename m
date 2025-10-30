Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB3A3CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Oct 2025 17:56:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 253624066A;
	Thu, 30 Oct 2025 18:56:18 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 3EFF540150
 for <dev@dpdk.org>; Thu, 30 Oct 2025 18:56:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761846976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4IjFfoTIgsAvvOBIm2fyNiXBpM+10e1aw8xkaqNz3Fs=;
 b=UmkmYalZ0ngGvtP6NY6tnUjTDqBerHBy536B3x3rFp/yk0+e2wXZdAsni76rpJqxWpVQeS
 rAAdM65FJBeCkiU30nrfvxIyoIyDrPSr8keURKZV6PhXkBTKuV4hMQNLKjCI/oeRfwZJQz
 TcUcl2tw3uxsQW3QJKEwvXhjsWG4Pto=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-674-N39BgzvIPSeaDQHkqomLPQ-1; Thu,
 30 Oct 2025 13:56:15 -0400
X-MC-Unique: N39BgzvIPSeaDQHkqomLPQ-1
X-Mimecast-MFC-AGG-ID: N39BgzvIPSeaDQHkqomLPQ_1761846974
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 99DB018089A2; Thu, 30 Oct 2025 17:56:14 +0000 (UTC)
Received: from ringo.home (unknown [10.45.224.62])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 028E819560A2; Thu, 30 Oct 2025 17:56:12 +0000 (UTC)
From: Robin Jarry <rjarry@redhat.com>
To: dev@dpdk.org,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH dpdk v4 4/4] net/tap: configure link carrier
Date: Thu, 30 Oct 2025 18:55:43 +0100
Message-ID: <20251030175537.219641-11-rjarry@redhat.com>
In-Reply-To: <20251030175537.219641-7-rjarry@redhat.com>
References: <20251027153750.445275-6-rjarry@redhat.com>
 <20251030175537.219641-7-rjarry@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 97XHbSLXXEYoAPUgfcF4cMy7wjTIg_gyYH--dsT1H3I_1761846974
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

In order for net_tap interfaces to be used in linux bonds, they need to
report a carrier.

After at last one RX queue has been configured, force the carrier on
with ioctl(TUNSETCARRIER) (there is no netlink equivalent for this).

Also do the same after the device has been moved to another netns.

TUNSETCARRIER support was added in Linux 5.0. Only enable carrier set if
this ioctl number is defined.

Signed-off-by: Robin Jarry <rjarry@redhat.com>
---
 drivers/net/tap/rte_eth_tap.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/net/tap/rte_eth_tap.c b/drivers/net/tap/rte_eth_tap.c
index 7869183c0ffe..730f1859bd28 100644
--- a/drivers/net/tap/rte_eth_tap.c
+++ b/drivers/net/tap/rte_eth_tap.c
@@ -1392,6 +1392,22 @@ tap_mac_set(struct rte_eth_dev *dev, struct rte_ether_addr *mac_addr)
 	return 0;
 }
 
+static int tap_carrier_set(struct pmd_internals *pmd, int carrier)
+{
+#ifdef TUNSETCARRIER
+	int ret = ioctl(pmd->ka_fd, TUNSETCARRIER, &carrier);
+	if (ret < 0) {
+		TAP_LOG(ERR, "%s: ioctl(TUNSETCARRIER) failed: %s",
+			pmd->name, strerror(errno));
+		return ret;
+	}
+#else
+	(void)pmd;
+	(void)carrier;
+#endif
+	return 0;
+}
+
 static int
 tap_gso_ctx_setup(struct rte_gso_ctx *gso_ctx, struct rte_eth_dev *dev)
 {
@@ -1559,6 +1575,11 @@ tap_rx_queue_setup(struct rte_eth_dev *dev,
 		tmp = &(*tmp)->next;
 	}
 
+	/* set carrier after creating at least one rxq */
+	ret = tap_carrier_set(internals, 1);
+	if (ret < 0)
+		goto error;
+
 	TAP_LOG(DEBUG, "  RX TUNTAP device name %s, qid %d on fd %d",
 		internals->name, rx_queue_id,
 		process_private->fds[rx_queue_id]);
@@ -1691,6 +1712,9 @@ tap_netns_change(struct rte_eth_dev *dev)
 		TAP_LOG(WARNING, "%s: failed to recreate LSC interrupt socket",
 			pmd->name);
 
+	/* Force carrier back after switching netns */
+	tap_carrier_set(pmd, 1);
+
 	/* Switch back to original namespace */
 	if (setns(orig_netns_fd, CLONE_NEWNET) < 0)
 		TAP_LOG(ERR, "%s: failed to return to original netns: %s",
-- 
2.51.1

