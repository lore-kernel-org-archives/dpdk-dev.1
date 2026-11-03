Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E5C606D803
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 17:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=C3qxAmDB
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7DA094279F;
	Tue,  3 Nov 2026 18:17:46 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTPS id 196F542788
 for <dev@dpdk.org>; Tue,  3 Nov 2026 18:17:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793726264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TmcHOnlsDoXcwTMA7pMbAS1ua3y3TabDhlwFmP7CbZM=;
 b=C3qxAmDBbsnS7ofhh08EhCAtuXI1qYOlK3D6fXwZsfi9of/rmWPRgsBoKW1AHtDXizz0ET
 JpKzEYt51C/SCiQ46bGQTL9knlkEIeeXYeG+bM5u8/LLsTBgtn795QHsPSjp3Bb5KQ3UOF
 /ZoQCjvX1sBUgNFLjxdxfJFxnMYqqB0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-_L-Qze7UN6SPtag5hhMIyA-1; Tue,
 03 Nov 2026 12:17:43 -0500
X-MC-Unique: _L-Qze7UN6SPtag5hhMIyA-1
X-Mimecast-MFC-AGG-ID: _L-Qze7UN6SPtag5hhMIyA_1793726262
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 02549195604A; Tue,  3 Nov 2026 17:17:42 +0000 (UTC)
Received: from dmarchan-thinkpadx1carbongen13.rmtfr.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CCA2A30002CD; Tue,  3 Nov 2026 17:17:40 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: rjarry@redhat.com,
	stephen@networkplumber.org
Subject: [PATCH 2/2] net/tap: fix use after free on interrupt handle
Date: Tue,  3 Nov 2026 18:17:30 +0100
Message-ID: <20261103171730.1361878-2-david.marchand@redhat.com>
In-Reply-To: <20261103171730.1361878-1-david.marchand@redhat.com>
References: <20261103171730.1361878-1-david.marchand@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fNbc45jBLi2HEOc_u0u3CLyHqQq9kjdxyRx5osIfskE_1793726262
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This driver was not unregistering its interrupt callbacks when closing
the port, which now means use after free after the interrupt handle
is not duplicated anymore by the interrupt thread.

Fixes: c663018eb7f3 ("interrupts: do not duplicate interrupt handles")

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/net/tap/rte_eth_tap.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/tap/rte_eth_tap.c b/drivers/net/tap/rte_eth_tap.c
index 15320c4b7e..15dca58c8d 100644
--- a/drivers/net/tap/rte_eth_tap.c
+++ b/drivers/net/tap/rte_eth_tap.c
@@ -1106,6 +1106,8 @@ tap_dev_close(struct rte_eth_dev *dev)
 		return 0;
 	}
 
+	tap_intr_handle_set(dev, 0);
+
 	if (!internals->persist)
 		tap_link_set_down(dev);
 
@@ -1958,6 +1960,9 @@ tap_lsc_intr_handle_set(struct rte_eth_dev *dev, int set)
 
 clean:
 	rte_eal_alarm_cancel(tap_lsc_register_alarm, dev);
+	if (rte_intr_fd_get(pmd->intr_handle) < 0)
+		return 0;
+
 	do {
 		ret = rte_intr_callback_unregister(pmd->intr_handle,
 			tap_dev_intr_handler, dev);
-- 
2.56.0

