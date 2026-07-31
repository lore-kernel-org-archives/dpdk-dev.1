Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8FC0C55167
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jul 2026 09:23:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 36E88406BB;
	Fri, 31 Jul 2026 11:23:53 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id EFBFE40280
 for <dev@dpdk.org>; Fri, 31 Jul 2026 11:23:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785489831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kWCT+5zJAMWrzmscbbxjfJ4CLwD+4x/iqUwhMW6bAOM=;
 b=Rs1NP5T9XOS1VbbPxYcNS3VrGKVK06FTu2R4FKNUr3ZeyJotJZIYhT++pmdNcdqOcXq+MA
 mTD6mooUBB2pStD9Cq0Z1Q1zySOO+xkBBOo/ENd/x1pst/CEEWSpJuB4o920r4vVn9AH5E
 ikiGhYaHcFakvg6lAwm01pd+QIoNjY4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642-LHy9IiskNWSGZvOigYOuIA-1; Fri,
 31 Jul 2026 05:23:48 -0400
X-MC-Unique: LHy9IiskNWSGZvOigYOuIA-1
X-Mimecast-MFC-AGG-ID: LHy9IiskNWSGZvOigYOuIA_1785489827
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3FFAA19560A2; Fri, 31 Jul 2026 09:23:47 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.48.202])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 33FAC180044F; Fri, 31 Jul 2026 09:23:43 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: stable@dpdk.org, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 Nelio Laranjeiro <nelio.laranjeiro@6wind.com>,
 Adrien Mazarguil <adrien.mazarguil@6wind.com>
Subject: [PATCH 2/2] net/mlx5: reset promiscuous modes on device close
Date: Fri, 31 Jul 2026 11:23:32 +0200
Message-ID: <20260731092332.3833632-2-david.marchand@redhat.com>
In-Reply-To: <20260731092332.3833632-1-david.marchand@redhat.com>
References: <20260731092332.3833632-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: v_o7Cc3TP5Bd4E_1A_veSI7w4AgtofjScMo6bgzVbaY_1785489827
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

Since the DPDK port is backed by a kernel netdevice, leaving this
netdevice in promiscuous mode may have unexpected consequences.

Reset promiscuous and all multicast modes on close.

Fixes: dd4bb90bc3cb ("net/mlx5: use Netlink to enable promisc/allmulti mode")
Cc: stable@dpdk.org

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/net/mlx5/mlx5.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/mlx5/mlx5.c b/drivers/net/mlx5/mlx5.c
index 3fa38694e5..c7b0d3ef8b 100644
--- a/drivers/net/mlx5/mlx5.c
+++ b/drivers/net/mlx5/mlx5.c
@@ -2498,6 +2498,16 @@ mlx5_dev_close(struct rte_eth_dev *dev)
 		mlx5_free(priv->rss_conf.rss_key);
 	if (priv->reta_idx != NULL)
 		mlx5_free(priv->reta_idx);
+	if (priv->sh->dev_cap.vf || priv->sh->dev_cap.sf) {
+		if (mlx5_os_get_promisc(dev)) {
+			DRV_LOG(DEBUG, "port %u resetting promiscuous mode", dev->data->port_id);
+			mlx5_os_set_promisc(dev, 0);
+		}
+		if (mlx5_os_get_allmulti(dev)) {
+			DRV_LOG(DEBUG, "port %u resetting all multicast mode", dev->data->port_id);
+			mlx5_os_set_allmulti(dev, 0);
+		}
+	}
 	if (sh->dev_cap.vf)
 		mlx5_os_mac_addr_flush(dev);
 	if (priv->nl_socket_route >= 0)
-- 
2.54.0

