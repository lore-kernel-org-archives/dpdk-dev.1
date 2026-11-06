Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B26606A32C
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Nov 2026 08:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ae+QcGaB
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9CF7D42D76;
	Fri,  6 Nov 2026 09:57:17 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTPS id 815B84026A
 for <dev@dpdk.org>; Fri,  6 Nov 2026 09:57:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793955435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ROa3AkIx0FN5YBj3AYmzsSeJFqJMRTgkdQU2SVwV3M0=;
 b=ae+QcGaBXSljrTnlIgAKIkcBJzv/GanNmrQ27fltMTeBbXOCo6+bQo7BMgVgHyJQPugbKg
 xEGndOLNEuIrbfFIXGOZW7DqNh53Jcko+mjejT531N+ljRYimA5V/+5XGRrR+JCo/yzns5
 EEj/iMEoCHre/QuB98tAICskba30V/M=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-307-HPO0bCYNPQWPOGphMIQy1Q-1; Fri,
 06 Nov 2026 03:57:12 -0500
X-MC-Unique: HPO0bCYNPQWPOGphMIQy1Q-1
X-Mimecast-MFC-AGG-ID: HPO0bCYNPQWPOGphMIQy1Q_1793955431
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4857F193E8BD; Fri,  6 Nov 2026 08:57:10 +0000 (UTC)
Received: from dmarchan-thinkpadx1carbongen13.rmtfr.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 071631848D45; Fri,  6 Nov 2026 08:57:08 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: rjarry@redhat.com, Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v2 2/2] net/tap: fix use after free on interrupt handle
Date: Fri,  6 Nov 2026 09:57:00 +0100
Message-ID: <20261106085701.2429186-2-david.marchand@redhat.com>
In-Reply-To: <20261106085701.2429186-1-david.marchand@redhat.com>
References: <20261103171730.1361878-1-david.marchand@redhat.com>
 <20261106085701.2429186-1-david.marchand@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uwYvGXKoBZAad34GL3FnueKuBb2VJxkBmh8ht6Uf8Xc_1793955431
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
index 66a55301e7..f6502c5e56 100644
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

