Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA5ED10775E7
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Mar 2026 16:36:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 762914026F;
	Wed, 18 Mar 2026 17:36:44 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id B901B40150
 for <dev@dpdk.org>; Wed, 18 Mar 2026 17:36:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773851802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fHORCoI/2cU1iS9AH4drLeK8BDfXr8yP910ymzeVt0M=;
 b=es6S+6PGPvqVh/N2tp2L/7RsOtHwqD4YkhvQ1sv1DdysfeRm3pyvJv4LxQtE7MQ0dM4EhY
 Rd/AHbZQXGA2Dnr8JZE/3gDExDBgaLSOPxuebELMZk77WDMH1OKkNXAgf9Z10timZFhlhU
 Zq5K3nW2lao8YvNAx+sWO4qDeXr6zL0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-451-s8mw--6yPZyZEToeUJpuKQ-1; Wed,
 18 Mar 2026 12:36:41 -0400
X-MC-Unique: s8mw--6yPZyZEToeUJpuKQ-1
X-Mimecast-MFC-AGG-ID: s8mw--6yPZyZEToeUJpuKQ_1773851799
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1FAAE195608D; Wed, 18 Mar 2026 16:36:39 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.173])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 38E451955F19; Wed, 18 Mar 2026 16:36:34 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: stable@dpdk.org, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 Adrien Mazarguil <adrien.mazarguil@6wind.com>,
 Nelio Laranjeiro <nelio.laranjeiro@6wind.com>
Subject: [PATCH] common/mlx5: fix mac deletion on Linux
Date: Wed, 18 Mar 2026 17:36:28 +0100
Message-ID: <20260318163628.609968-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UlN86Pcnb7ODNrplq90HE5uKp-3BjM07brqx_NHjDF0_1773851799
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

Re-enable debug logs unconditionally, this helps understanding why mac
deletions were silently failing (while a bridge fdb del command was
working fine).

testpmd> mac_addr add 0 FA:35:44:3F:58:31
testpmd> mac_addr remove 0 FA:35:44:3F:58:31
mlx5_common: Interface 35 cannot remove MAC address FA:35:44:3F:58:31
	Operation not supported

Then, fix mac deletion as the NLM_F_CREATE == 0x200 flag is relevant
with a RTM_NEWNEIGH op.
For a RTM_DELNEIGH op, 0x200 == NLM_F_BULK and passing this flag
makes the deletion fail miserably for a single mac.

Fixes: ccdcba53a3f4 ("net/mlx5: use Netlink to add/remove MAC addresses")
Cc: stable@dpdk.org

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/common/mlx5/linux/mlx5_nl.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/common/mlx5/linux/mlx5_nl.c b/drivers/common/mlx5/linux/mlx5_nl.c
index eceb3d796f..b50431fb61 100644
--- a/drivers/common/mlx5/linux/mlx5_nl.c
+++ b/drivers/common/mlx5/linux/mlx5_nl.c
@@ -581,8 +581,8 @@ mlx5_nl_mac_addr_modify(int nlsk_fd, unsigned int iface_idx,
 	} req = {
 		.hdr = {
 			.nlmsg_len = NLMSG_LENGTH(sizeof(struct ndmsg)),
-			.nlmsg_flags = NLM_F_REQUEST | NLM_F_CREATE |
-				NLM_F_EXCL | NLM_F_ACK,
+			.nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK |
+				add ? NLM_F_CREATE | NLM_F_EXCL : 0,
 			.nlmsg_type = add ? RTM_NEWNEIGH : RTM_DELNEIGH,
 		},
 		.ndm = {
@@ -612,7 +612,6 @@ mlx5_nl_mac_addr_modify(int nlsk_fd, unsigned int iface_idx,
 		goto error;
 	return 0;
 error:
-#ifdef RTE_PMD_MLX5_DEBUG
 	{
 		char m[RTE_ETHER_ADDR_FMT_SIZE];
 
@@ -622,7 +621,6 @@ mlx5_nl_mac_addr_modify(int nlsk_fd, unsigned int iface_idx,
 			iface_idx,
 			add ? "add" : "remove", m, strerror(rte_errno));
 	}
-#endif
 	return -rte_errno;
 }
 
-- 
2.53.0

