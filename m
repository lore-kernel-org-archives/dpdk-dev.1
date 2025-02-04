Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C0EC02194
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 20:58:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 366054064A;
	Tue,  4 Feb 2025 21:57:32 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id E08DF40265;
 Tue,  4 Feb 2025 21:57:22 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 50394210C339; Tue,  4 Feb 2025 12:57:21 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 50394210C339
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1738702641;
 bh=Zaw3j4IpC+ev3dZ58fCpkMXxz+DLueTBX9Y4LIBnsoA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=dVt0Qpqi5bdgOVlSZvG4z956RzO4CUsMPFmairKSujQEdYvOTPAtojy31luD5zcxV
 VQLAjOrXtQo4mEJl2Ucap3wNEQ+Ma60OgyGiWYRu1B8nD46pF+WLwX2EAj0RUNrtvG
 M5HWMOiSuYHAdw6fXPq2PRTU8Lm5wLLeGpzEgQ3k=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: dev@dpdk.org
Cc: konstantin.ananyev@huawei.com, thomas@monjalon.net,
 david.marchand@redhat.com, stable@dpdk.org
Subject: [PATCH v21 08/27] gro: fix overwrite unprocessed packets
Date: Tue,  4 Feb 2025 12:56:59 -0800
Message-Id: <1738702638-22363-9-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1738702638-22363-1-git-send-email-andremue@linux.microsoft.com>
References: <1713397319-26135-1-git-send-email-roretzla@linux.microsoft.com>
 <1738702638-22363-1-git-send-email-andremue@linux.microsoft.com>
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

From: Konstantin Ananyev <konstantin.ananyev@huawei.com>

gro_vxlan_tcp4_tbl_timeout_flush() is called without taking into account
that first entries in pkts[] can be already occupied by
un-processed packets.

Fixes: 74080d7dcf31 ("gro: support IPv6 for TCP")
Cc: stable@dpdk.org

Signed-off-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Acked-by: Ferruh Yigit <ferruh.yigit@amd.com>
---
 lib/gro/rte_gro.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/gro/rte_gro.c b/lib/gro/rte_gro.c
index d824eebd93..db86117609 100644
--- a/lib/gro/rte_gro.c
+++ b/lib/gro/rte_gro.c
@@ -327,7 +327,7 @@ rte_gro_reassemble_burst(struct rte_mbuf **pkts,
 		/* Flush all packets from the tables */
 		if (do_vxlan_tcp_gro) {
 			i += gro_vxlan_tcp4_tbl_timeout_flush(&vxlan_tcp_tbl,
-					0, pkts, nb_pkts);
+					0, &pkts[i], nb_pkts - i);
 		}
 
 		if (do_vxlan_udp_gro) {
-- 
2.47.2.vfs.0.1

