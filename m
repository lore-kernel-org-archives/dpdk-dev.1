Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B31CAC5AE
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 17:25:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 04D4F40695;
	Wed, 24 Sep 2025 19:25:53 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id A36D34067E
 for <dev@dpdk.org>; Wed, 24 Sep 2025 19:25:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758734750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xmXM8tVCRWLdDtnrO7WKZU2zBAxP7Yc9J00rckQg3BM=;
 b=PJCzjroW+W1NchuujWXSBciiWdMuxBeBxN7VVN4I9VgpSHyp1Phcj0zOXKfN11jj5lQxT/
 jsZr4BK/9VBcySUV5QjLvrCveE9xN3dvHqavZI7O4Hb3KdlbLC1oYejrUdPsspN3EFROLt
 TskKRoFU5IQdL5F8EhJTVIYADxknTNo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-348-W9hYgRw8NU6XqVwfCGyiWA-1; Wed,
 24 Sep 2025 13:25:47 -0400
X-MC-Unique: W9hYgRw8NU6XqVwfCGyiWA-1
X-Mimecast-MFC-AGG-ID: W9hYgRw8NU6XqVwfCGyiWA_1758734746
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 083741800289; Wed, 24 Sep 2025 17:25:46 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.225.72])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1D6BE1955F19; Wed, 24 Sep 2025 17:25:43 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Nicolas Chautru <nicolas.chautru@intel.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: [PATCH v3 1/7] baseband/acc: fix exported header
Date: Wed, 24 Sep 2025 19:25:29 +0200
Message-ID: <20250924172536.2447183-2-david.marchand@redhat.com>
In-Reply-To: <20250924172536.2447183-1-david.marchand@redhat.com>
References: <20241127112617.1331125-1-david.marchand@redhat.com>
 <20250924172536.2447183-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Nwl3isCrVlBr19gOmpHsqRmUmAWZK492ZUDTc7tWgRs_1758734746
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

