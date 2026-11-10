Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306F6606A31C
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Nov 2026 10:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PE0h67g1
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4333440E0B;
	Tue, 10 Nov 2026 11:03:27 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTPS id 586A040E0B
 for <dev@dpdk.org>; Tue, 10 Nov 2026 11:03:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794305004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T9Q2qPVfvAem925dl99ZRmealr8SHZTNNmV4B0traNY=;
 b=PE0h67g11K1XAREmZ6lOovoubeenAPKP7DkcRIzUp4yfeJcfvB4h2b02QFPw3CdrEdmfbd
 21JHxnpQt+Ew32kslDrLJEHcQREAP7aJ/+5FG722GrL1N4VoN6VPjmbiSgAFbVPawqTnLf
 orY4v6tMd4t1TnrZ1JKwMxbVrkvESqA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-144-agBSaXGEOkKQPU1uauAn-g-1; Tue,
 10 Nov 2026 05:03:22 -0500
X-MC-Unique: agBSaXGEOkKQPU1uauAn-g-1
X-Mimecast-MFC-AGG-ID: agBSaXGEOkKQPU1uauAn-g_1794305001
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8C5811955F73; Tue, 10 Nov 2026 10:03:21 +0000 (UTC)
Received: from dmarchan-thinkpadx1carbongen13.rmtfr.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 18CF61956087; Tue, 10 Nov 2026 10:03:19 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: rjarry@redhat.com, Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v3 2/2] net/tap: fix use after free on interrupt handle
Date: Tue, 10 Nov 2026 11:03:08 +0100
Message-ID: <20261110100308.3190833-2-david.marchand@redhat.com>
In-Reply-To: <20261110100308.3190833-1-david.marchand@redhat.com>
References: <20261103171730.1361878-1-david.marchand@redhat.com>
 <20261110100308.3190833-1-david.marchand@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3fSkKMt73wxgRx67c7SzgvUSBYZakACc_vfhm4Trsps_1794305001
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
Reviewed-by: Robin Jarry <rjarry@redhat.com>
---
Changes since v1:
- moved unrelated change,

---
 drivers/net/tap/rte_eth_tap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/tap/rte_eth_tap.c b/drivers/net/tap/rte_eth_tap.c
index 87779710a7..0476a327a1 100644
--- a/drivers/net/tap/rte_eth_tap.c
+++ b/drivers/net/tap/rte_eth_tap.c
@@ -1106,6 +1106,8 @@ tap_dev_close(struct rte_eth_dev *dev)
 		return 0;
 	}
 
+	tap_intr_handle_set(dev, 0);
+
 	if (!internals->persist)
 		tap_link_set_down(dev);
 
-- 
2.56.0

