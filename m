Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE51C79F8A
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Jan 2026 12:54:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E171A40648;
	Mon,  5 Jan 2026 13:54:56 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id CD33C4026F
 for <dev@dpdk.org>; Mon,  5 Jan 2026 13:54:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767617695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=EBBzAk/7e/rVmHywDt8D64NqXUb60u0d2w9h46/Hmes=;
 b=QnusSeqb4bM/VMA/bJa49oc6VF7MlsFhRdiP76hZjnQw2JwbkB02f4+R82lHvmvSzCwCYj
 rBq/9Cvydr+JhHuHuryp8/ozXox4MgdS2k7Q5+4pxS9g+DoZ1ah26f+v2nKCHOnLwXyYH6
 O3IibA8iC124I0/qHGwN1zBxbrB8Xq8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-573-y_YJmkfqOpOA14d7BxJ4CA-1; Mon,
 05 Jan 2026 07:54:51 -0500
X-MC-Unique: y_YJmkfqOpOA14d7BxJ4CA-1
X-Mimecast-MFC-AGG-ID: y_YJmkfqOpOA14d7BxJ4CA_1767617690
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 618E7195609D; Mon,  5 Jan 2026 12:54:50 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.224.210])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D959F1800576; Mon,  5 Jan 2026 12:54:47 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: stable@dpdk.org, Ciara Loftus <ciara.loftus@intel.com>,
 Maryam Tahhan <mtahhan@redhat.com>, Xiaolong Ye <xiaolong.ye@intel.com>,
 Kevin Laatz <kevin.laatz@intel.com>
Subject: [PATCH] net/af_xdp: fix external mbuf transmit
Date: Mon,  5 Jan 2026 13:54:41 +0100
Message-ID: <20260105125441.50447-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Erpfs9K_z2uyDpeakZYwEv4uM5wcFGWeWOzadtkYHOI_1767617690
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

A mbuf may be pointing at external buffer like when forwarding a TSO
packet coming from a vhost-user port in OVS (see
RTE_VHOST_USER_EXTBUF_SUPPORT).

Checking the mbuf mempool to trigger the zero copy optimisation is
broken: the driver will (at best) read 0s or (at worse) crash when
reading more data than what the direct buffer can contain.

Fixes: d8a210774e1d ("net/af_xdp: support unaligned umem chunks")
Cc: stable@dpdk.org

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/net/af_xdp/rte_eth_af_xdp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/af_xdp/rte_eth_af_xdp.c b/drivers/net/af_xdp/rte_eth_af_xdp.c
index f2a8fb95d1..10dbcf1333 100644
--- a/drivers/net/af_xdp/rte_eth_af_xdp.c
+++ b/drivers/net/af_xdp/rte_eth_af_xdp.c
@@ -608,7 +608,7 @@ af_xdp_tx_zc(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	for (i = 0; i < nb_pkts; i++) {
 		mbuf = bufs[i];
 
-		if (mbuf->pool == umem->mb_pool) {
+		if (RTE_MBUF_DIRECT(mbuf) && mbuf->pool == umem->mb_pool) {
 			desc = reserve_and_fill(txq, mbuf, umem, NULL);
 			if (!desc) {
 				kick_tx(txq, cq);
-- 
2.52.0

