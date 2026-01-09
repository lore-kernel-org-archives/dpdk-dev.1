Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F22D1A638
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 Jan 2026 14:22:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 379C4402A7;
	Fri,  9 Jan 2026 15:22:00 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 2FC42402A7
 for <dev@dpdk.org>; Fri,  9 Jan 2026 15:21:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767968517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=n6IpMCNUXIunmYMcleLTHr7xu0/g/dN1vjelE3v+WjA=;
 b=aowXrhIAH0gN6Pxmusk0WAjNiyzaeJgPry3CGXdJZZD7rr/L9AmBHMiYdtWAzt07822CV7
 GvfLpPKOiELdkGG7mp9AqI53gyHxdOUPTtkOYRbd0xRLi3sujfi1PB/PEz5uUajo8uwUZo
 2EMTJN3wGAPa025z+ALDjVnKftap+FI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-81-OXM5rt9hP9C3E201DhVcgQ-1; Fri,
 09 Jan 2026 09:21:54 -0500
X-MC-Unique: OXM5rt9hP9C3E201DhVcgQ-1
X-Mimecast-MFC-AGG-ID: OXM5rt9hP9C3E201DhVcgQ_1767968513
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 28C551956058; Fri,  9 Jan 2026 14:21:53 +0000 (UTC)
Received: from ringo.home (unknown [10.44.33.1])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 299BA18007D2; Fri,  9 Jan 2026 14:21:50 +0000 (UTC)
From: Robin Jarry <rjarry@redhat.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Beilei Xing <beilei.xing@intel.com>, Ting Xu <ting.xu@intel.com>
Cc: stable@dpdk.org
Subject: [PATCH dpdk] iavf: fix reported max TX and RX queues in ethdev info
Date: Fri,  9 Jan 2026 15:21:30 +0100
Message-ID: <20260109142129.1550058-2-rjarry@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mHKdTRSERrymrwuGm0O7svo9Trhd9BDKWcE9AxRjnP8_1767968513
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

With a regular iavf device, rte_eth_dev_info_get reports 256 maximum TX
and RX queues. Trying to configure a port with 20 queues returns an
error:

  ERR: IAVF_DRIVER: iavf_dev_configure(): large VF is not supported

When the large VF feature isn't supported by the PF kernel driver,
ethdev info must not report 256 supported queues but 16.

Fixes: e436cd43835b ("net/iavf: negotiate large VF and request more queues")
Cc: stable@dpdk.org

Signed-off-by: Robin Jarry <rjarry@redhat.com>
---
 drivers/net/intel/iavf/iavf_ethdev.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index 15e49fe24814..59328ebc5ad2 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -1126,12 +1126,18 @@ iavf_dev_info_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 	struct iavf_adapter *adapter =
 		IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	struct iavf_info *vf = &adapter->vf;
+	uint16_t max_queue_pairs;
 
 	if (adapter->closed)
 		return -EIO;
 
-	dev_info->max_rx_queues = IAVF_MAX_NUM_QUEUES_LV;
-	dev_info->max_tx_queues = IAVF_MAX_NUM_QUEUES_LV;
+	if (vf->vf_res->vf_cap_flags & VIRTCHNL_VF_LARGE_NUM_QPAIRS)
+		max_queue_pairs = IAVF_MAX_NUM_QUEUES_LV;
+	else
+		max_queue_pairs = IAVF_MAX_NUM_QUEUES_DFLT;
+
+	dev_info->max_rx_queues = max_queue_pairs;
+	dev_info->max_tx_queues = max_queue_pairs;
 	dev_info->min_rx_bufsize = IAVF_BUF_SIZE_MIN;
 	dev_info->max_rx_pktlen = IAVF_FRAME_SIZE_MAX;
 	dev_info->max_mtu = dev_info->max_rx_pktlen - IAVF_ETH_OVERHEAD;
-- 
2.52.0

