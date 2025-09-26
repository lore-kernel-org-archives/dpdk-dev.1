Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABAD4CAC5B9
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Sep 2025 12:41:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B94140691;
	Fri, 26 Sep 2025 14:41:25 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 2852240674
 for <dev@dpdk.org>; Fri, 26 Sep 2025 14:41:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758890482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xmXM8tVCRWLdDtnrO7WKZU2zBAxP7Yc9J00rckQg3BM=;
 b=epFXK2M9A2g0+JyaOSwDfv3JMyWycleeQ8Ids/uDpXFoCcoi5YiirBMpRertZT0uS47FMT
 5e9uL9IuzFRyn5AJUCa2FzhBGDM1tRaawzSHE1SdiTU26Sn2eMgiFYRNdkb1oFvly6QRE/
 OjtvfRpN1QkrdbJvqcl5DA9yXWVXXsc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-645-AazoTz8uPB2x_ZJo8xFHcQ-1; Fri,
 26 Sep 2025 08:41:19 -0400
X-MC-Unique: AazoTz8uPB2x_ZJo8xFHcQ-1
X-Mimecast-MFC-AGG-ID: AazoTz8uPB2x_ZJo8xFHcQ_1758890478
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1E474195608B; Fri, 26 Sep 2025 12:41:18 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.225.72])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2E25618003FC; Fri, 26 Sep 2025 12:41:15 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, Nicolas Chautru <nicolas.chautru@intel.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: [PATCH v5 1/9] baseband/acc: fix exported header
Date: Fri, 26 Sep 2025 14:40:54 +0200
Message-ID: <20250926124103.750844-2-david.marchand@redhat.com>
In-Reply-To: <20250926124103.750844-1-david.marchand@redhat.com>
References: <20241127112617.1331125-1-david.marchand@redhat.com>
 <20250926124103.750844-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -d8q-uVDbDJwse2vrUfkEDcfkq0wHH6pv_mrp3NRp-0_1758890478
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

rte_acc_cfg.h relies on rte_acc_common_cfg.h.

Fixes: 32e8b7ea35dd ("baseband/acc100: refactor to segregate common code")

Signed-off-by: David Marchand <david.marchand@redhat.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/baseband/acc/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/baseband/acc/meson.build b/drivers/baseband/acc/meson.build
index 64fcf1537a..d9fb947eaa 100644
--- a/drivers/baseband/acc/meson.build
+++ b/drivers/baseband/acc/meson.build
@@ -26,4 +26,4 @@ deps += ['bus_pci']
 
 sources = files('acc_common.c', 'rte_acc100_pmd.c', 'rte_vrb_pmd.c')
 
-headers = files('rte_acc_cfg.h')
+headers = files('rte_acc_cfg.h', 'rte_acc_common_cfg.h')
-- 
2.51.0

