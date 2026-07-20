Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C606C44520
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Jul 2026 11:50:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1C4C740290;
	Mon, 20 Jul 2026 13:50:00 +0200 (CEST)
Received: from fout-b1-smtp.messagingengine.com
 (fout-b1-smtp.messagingengine.com [202.12.124.144])
 by mails.dpdk.org (Postfix) with ESMTP id BE4884028E;
 Mon, 20 Jul 2026 13:49:58 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.stl.internal (Postfix) with ESMTP id CE45A1D000C5;
 Mon, 20 Jul 2026 07:49:57 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Mon, 20 Jul 2026 07:49:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to; s=fm2; t=1784548197; x=1784634597; bh=oXpBzVkFLO344cFRqcEa8
 90n2aBY6RrXRrap+4zYUmw=; b=MWdxqHmSPSK+FEMAAItS6r1wipUsq7Bbul8No
 gITy4GwCtD4oxFNYWwRG7E4SNVamUp3SVBb+JjMrjc+voK7MYNTMCbIk/O3N2bx8
 iAnoX4Q4+/I32bPYsN3UmJjo91+zc4XBonu+45yrdkVLoq1IzRRJnA+XKA5Pu1EG
 U1Skw2IV8CReA6QBL/aiBh4OL1Tzsdl+wwHxysGWxBRLWKf8aDkaGeXmNs6RUgRI
 yFjGDKYQSsGu0aSxfa1SpNYOQjyB2eDskl6iNzv1OEonGfOr401jWimjiOdHtCuS
 iJ2h91JTvU98GyMJXt9s7eaIGEQomY/fkrWYGVwsEVcpP4d1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1784548197; x=1784634597; bh=oXpBzVkFLO344cFRqcEa890n2aBY6RrXRra
 p+4zYUmw=; b=bkaYfmvJsIC1FfHVYKltpWU0OkMUy8D9DbOkCHA8X173QOUv1PG
 MCxpeuvvUD9E4ekGQOfIlX2eEx3+Iol+y9ReZeo4L0i1DU4IQgpk5Awqfn8lkh9F
 +qt7hCh3FgVHeUFmo3Dspw0jK8HA9IRbOKzqYQD2FKIyOlATS6zkN++fbm3UMnNj
 OsmbWCnSUbfPCBgGb+5Lx0zTKj+1YaI3x6/OG0V1bmwrbiuYHGg7LbaYPei1Uzn+
 SfHsps7gnBagFuxUY9/8dUKTw5+ir9y6psIT5p4pOSryHPXCPsik9k3/ZBgzuozi
 V9UYtj4anFYuRWqwsrGXgSxJ9U8OG2+Qb5g==
X-ME-Sender: <xms:ZQtearLyLuw_ELuF4hji78uqj3arkH15TVj-PuKqnDwSmxVDUsj94w>
 <xme:ZQteavn3wucP5Cuv6lmQ1Pro8-5Gwfd_P4FMoTJ0gzZS_fpKVy_zAhZTjFHbVUz_V
 7OioNcKUhqAeM1gD_7JwD4qRmEVvmqm3GgL6bKnpptQuZgWDtij9g>
X-ME-Received: <xmr:ZQteakZHYClDgE31KtGiXNJ5jPCWnbwVgdHjOtKaC_llvNzreBka7WG37RHbLDKuPkVLqfEF39W6SzdyHSUJ9esbv780TbDpUILGVRbQVQ>
X-ME-Proxy-Cause: dmFkZTEs+LpcrF2J3jAARuZ0UDti+0vaBrGRQ4OcpY7Ted/5irIFsXJ1AFKQiy7V+kRAMN
 r6VyO/dqdVIZDsgzV8atiUX9ZMlPO/aU4Bv600eD8vh7hxhmVQgBvMixSjMi4aj+stGwCx
 lmdK4w0LfyzHf0cbzfyzbpWoPbtSpgdb9YcbKipuYNEcGHU8F3wkeA+dp0/ppk2VHfrWXB
 rzyB0EY4A79JUwTjBzjGDW4fqyPkcrSnNHICHoejaCP0Aoq4csKtCsUiVFLPS0o58kcRdu
 KIPocW+1Ot1IMLrxYOkTuBUt5vpBKASf4E6qYWktYihYgazB6w4eEaES3ZV+FgHYti9SPf
 hcztbXZL7cic4m9cgo2Yokwy1K3Mx40+Bo3Ux6nBgQkffNNlYqwlNAQ/g/gqKxngiFmZC6
 NXK3wBvKJy9EqlvpplWxUuaQLEEhwQx/BXlrnLz1oUcfb4oMJtxQHqco5HlBwmZg3BHfhC
 EGL2y2Ju2IfKY/+l/3VB5/FSK/N52O33nrkDjTYiiaKhdjaI2brxzxUxSbnWyRkQ5SSrf/
 5tQBZsSN3aH+RoeSPjePCMbkPZkU7OAPNuvI84x8S7RFTpVhRaOMvE395XyNcwcx8cr0jH
 O8opvQ7F5afzctQYdQ96tBdkZ2ZT7yNzrYpsrD2SVcYyJKcz67wawCM53TUw
X-ME-Proxy: <xmx:ZQtear8jW_58bYwTd23jKzEuD7v5rSE6JutxzUthnajh-HZOVQOv_w>
 <xmx:ZQteajYLpjiMnKFTgROKthr0eaTVHcHEgsJxhxnpPMFVl7baZWl1AA>
 <xmx:ZQtealdLAqeL_uy1gzDJ66I46lRo9t4walkFx523QathSw1JxWC1YQ>
 <xmx:ZQteagkW_G01rQfAqgyhjLCQccdf3KEPyUMCDPXpnEVb7utqm08bgw>
 <xmx:ZQteakE3Z2dzAuvKR2c-pwjB184UPL9N9QB0EyB-X7m4G0zcbbSByYd0>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Jul 2026 07:49:55 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: stable@dpdk.org, Pier Damouny <pdamouny@nvidia.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 Banoth Saikumar <banoth.saikumar@oracle.com>
Subject: [PATCH] net/mlx5: revert fallback to Verbs Tx allocation
Date: Mon, 20 Jul 2026 13:49:29 +0200
Message-ID: <20260720114929.2998238-1-thomas@monjalon.net>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

On Windows, DevX CQ creation was failing because
of a different allocation fallback behaviour.

Fixes: 4abc12b9331c ("net/mlx5: fall back to Verbs Tx allocation without DevX")
Cc: stable@dpdk.org

Reported-by: Pier Damouny <pdamouny@nvidia.com>
Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 .mailmap                        | 1 -
 drivers/net/mlx5/mlx5_trigger.c | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/.mailmap b/.mailmap
index a610456351..fcb3d1bb3f 100644
--- a/.mailmap
+++ b/.mailmap
@@ -184,7 +184,6 @@ Ayuj Verma <ayverma@marvell.com> <ayuj.verma@caviumnetworks.com>
 Balakrishna Bhamidipati <bbhamidipati@marvell.com>
 Balasubramanian Manoharan <balasubramanian.manoharan@caviumnetworks.com>
 Balazs Nemeth <bnemeth@redhat.com> <balazs.nemeth@intel.com>
-Banoth Saikumar <banoth.saikumar@oracle.com>
 Bao-Long Tran <longtb5@viettel.com.vn>
 Baoyuan Li <updoing@sina.com>
 Bar Neuman <bneuman@nvidia.com>
diff --git a/drivers/net/mlx5/mlx5_trigger.c b/drivers/net/mlx5/mlx5_trigger.c
index c2804c5897..25847c8ba2 100644
--- a/drivers/net/mlx5/mlx5_trigger.c
+++ b/drivers/net/mlx5/mlx5_trigger.c
@@ -1201,7 +1201,7 @@ static int mlx5_dev_allocate_consec_tx_mem(struct rte_eth_dev *dev)
 	void *umem_buf = NULL;
 
 	/* Legacy per queue allocation, do nothing here. */
-	if (priv->sh->config.txq_mem_algn == 0 || !mlx5_devx_obj_ops_en(priv->sh))
+	if (priv->sh->config.txq_mem_algn == 0)
 		return 0;
 	alignment = (size_t)1 << priv->sh->config.txq_mem_algn;
 	total_size = priv->consec_tx_mem.sq_total_size + priv->consec_tx_mem.cq_total_size;
-- 
2.54.0

