Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82602C3ABB2
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 May 2025 09:37:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7F5F84028D;
	Wed, 28 May 2025 11:36:59 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id D0AD040279
 for <dev@dpdk.org>; Wed, 28 May 2025 11:36:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748425018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Fxo/o3/53XXlLC392HmXAdv7D5xlYj3xravj2rRiDak=;
 b=FhjK6Qc/0nSbTulBL/8OQBkPHQyiWkzY+xjEVBK40A9kIae1H78xng3QrShXL+ShRCZaLM
 U4QBZskcD77lJBV6Ozu2gOYW+Kgll8KHk4qxcAp8CINjGMN+Qx5r8nIXDmwYlROwheafMj
 nL7GgzSkosFc282pmYqCu5df/QP1Wjo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-402-720rLFGrPqi0fcyx9rd_kA-1; Wed,
 28 May 2025 05:36:56 -0400
X-MC-Unique: 720rLFGrPqi0fcyx9rd_kA-1
X-Mimecast-MFC-AGG-ID: 720rLFGrPqi0fcyx9rd_kA_1748425015
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A2188180036E; Wed, 28 May 2025 09:36:55 +0000 (UTC)
Received: from max-p1.redhat.com (unknown [10.45.242.24])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9EB2A18001DB; Wed, 28 May 2025 09:36:52 +0000 (UTC)
From: Maxime Coquelin <maxime.coquelin@redhat.com>
To: dev@dpdk.org, dsosnowski@nvidia.com, viacheslavo@nvidia.com,
 david.marchand@redhat.com
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>,
	stable@dpdk.org
Subject: [PATCH] net/mlx5: avoid setting kernel MTU if not needed
Date: Wed, 28 May 2025 11:36:44 +0200
Message-ID: <20250528093644.2456221-1-maxime.coquelin@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0p4QrGreezegPhrgV1M0eBxl0qktTn2HmUXXsb3UPm0_1748425015
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

This patch checks whether the Kernel MTU has the same value
as the requested one at port configuration time, and skip
setting it if it is the same.

Doing this, we can avoid the application to require
NET_ADMIN capability, as in v23.11.

Fixes: 10859ecf09c4 ("net/mlx5: fix MTU configuration")
Cc: stable@dpdk.org

Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---

Hi Dariuz,

I set priv->mtu as it is done after the mlx5_set_mtu() call,
but I'm not sure it is necessary, as is the existing call to
mlx5_get_mtu() because it seems done in mlx5_dev_spawn().

---

 drivers/net/mlx5/mlx5_ethdev.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/mlx5/mlx5_ethdev.c b/drivers/net/mlx5/mlx5_ethdev.c
index 7708a0b808..f2ae75a8e1 100644
--- a/drivers/net/mlx5/mlx5_ethdev.c
+++ b/drivers/net/mlx5/mlx5_ethdev.c
@@ -647,6 +647,14 @@ mlx5_dev_set_mtu(struct rte_eth_dev *dev, uint16_t mtu)
 	ret = mlx5_get_mtu(dev, &kern_mtu);
 	if (ret)
 		return ret;
+
+	if (kern_mtu == mtu) {
+		priv->mtu = mtu;
+		DRV_LOG(DEBUG, "port %u adapter MTU was already set to %u",
+			dev->data->port_id, mtu);
+		return 0;
+	}
+
 	/* Set kernel interface MTU first. */
 	ret = mlx5_set_mtu(dev, mtu);
 	if (ret)
--
2.49.0

