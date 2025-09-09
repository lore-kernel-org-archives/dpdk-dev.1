Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22042CA0FED
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Sep 2025 07:04:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D5EA402D7;
	Tue,  9 Sep 2025 09:04:53 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id D118140281
 for <dev@dpdk.org>; Tue,  9 Sep 2025 09:04:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757401490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=o9ocbkY35DPrkS70puMKllw0rmYKsbBioIL1Mbl5i5Y=;
 b=cKgpcnXVQmQsG2pjY1Xs7onMWaboT9vpsORuj12bl0WTAzi6uMdsr7xZ/GQRkb8tL6fh/7
 vFSukMMUikPr5JrRiMk5Jfi12BWEQ09eFV8R7qsqLIRj3daZNFaja4TDo8y+nFFMHCjenr
 VVM9ZguvjaxpM86vnAwH7Um0NW4qcIA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-223-BcJDMChhN9aGYiimQkl5jA-1; Tue,
 09 Sep 2025 03:04:42 -0400
X-MC-Unique: BcJDMChhN9aGYiimQkl5jA-1
X-Mimecast-MFC-AGG-ID: BcJDMChhN9aGYiimQkl5jA_1757401481
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4DB6119560B4; Tue,  9 Sep 2025 07:04:40 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.32.60])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 069AE19560A2; Tue,  9 Sep 2025 07:04:36 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, Renyong Wan <wanry@yunsilicon.com>,
 Na Na <nana@yunsilicon.com>, Rong Qian <qianr@yunsilicon.com>,
 Xiaoxiong Zhang <zhangxx@yunsilicon.com>, Dongwei Xu <xudw@yunsilicon.com>
Subject: [PATCH] net/xsc: fix use after free in some RXQ cleanup
Date: Tue,  9 Sep 2025 09:04:27 +0200
Message-ID: <20250909070427.2711048-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _TRiIDHDpUewc6d-35WsJuYK9lr1aju1nkQNR10ZD4g_1757401481
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

Debian 12 gcc complains about a use after free in this cleanup section.

[7/11] Compiling C object drivers/libtmp_rte_net_xsc.a.p/net_xsc_xsc_rx.c.o
In function 'xsc_rss_qp_create',
    inlined from 'xsc_rxq_rss_obj_new' at ../drivers/net/xsc/xsc_rx.c:565:8:
../drivers/net/xsc/xsc_rx.c:501:9: warning: pointer 'req' may be used after
	'free' [-Wuse-after-free]
  501 |         free(req);
      |         ^~~~~~~~~
../drivers/net/xsc/xsc_rx.c:501:9: note: call to 'free' here

Indeed, req may be free'd twice, as an error in the cleanup loop may
jump back to the set_qp_fail label.

Instead, skip the erroneous rxq and don't touch errno since all the code
jumping to set_qp_fail already sets it.

Fixes: 3991c890fb4c ("net/xsc: optimize RSS queue creation")

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/net/xsc/xsc_rx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/xsc/xsc_rx.c b/drivers/net/xsc/xsc_rx.c
index 5f8003a1f6..5ff3f818c2 100644
--- a/drivers/net/xsc/xsc_rx.c
+++ b/drivers/net/xsc/xsc_rx.c
@@ -502,10 +502,8 @@ xsc_rss_qp_create(struct xsc_ethdev_priv *priv, int port_id)
 	for (i = 0; i < set_last_no; i++) {
 		xsc_unset_qp_info(xdev, rqn_base + i);
 		rxq_data = xsc_rxq_get(priv, i);
-		if (rxq_data == NULL) {
-			rte_errno = EINVAL;
-			goto set_qp_fail;
-		}
+		if (rxq_data == NULL)
+			continue;
 		rte_memzone_free(rxq_data->rq_pas);
 		rxq_data->rq_pas = NULL;
 	}
-- 
2.51.0

