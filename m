Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 411C7CCA470
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Oct 2025 06:45:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 99CAA40673;
	Wed,  1 Oct 2025 08:45:34 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id B5DE540672
 for <dev@dpdk.org>; Wed,  1 Oct 2025 08:45:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759301133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xmXM8tVCRWLdDtnrO7WKZU2zBAxP7Yc9J00rckQg3BM=;
 b=O9OdwPgxsBZk2PYmrdUu3hGoU9tdJTauX1iJ0Sm7FYbLn64+vrgISfaQrq4Rnh6tTEE54c
 mHd2Ijbz+hBSRbFZg3lPwJ7XIYJUpgJbfKZiqXCyyIeZxLyiq1aun3MBGsDCO5eNa+vfcA
 hFTAG0rtg5g23G6ws3t+ffctam0E6kg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-185-_TiTltlXPIadPlma2_M38Q-1; Wed,
 01 Oct 2025 02:45:30 -0400
X-MC-Unique: _TiTltlXPIadPlma2_M38Q-1
X-Mimecast-MFC-AGG-ID: _TiTltlXPIadPlma2_M38Q_1759301129
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A6E2E180048E; Wed,  1 Oct 2025 06:45:28 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.224.213])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6FAEB19560B4; Wed,  1 Oct 2025 06:45:26 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, Nicolas Chautru <nicolas.chautru@intel.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: [PATCH v7 1/9] baseband/acc: fix exported header
Date: Wed,  1 Oct 2025 08:45:03 +0200
Message-ID: <20251001064512.2539269-2-david.marchand@redhat.com>
In-Reply-To: <20251001064512.2539269-1-david.marchand@redhat.com>
References: <20241127112617.1331125-1-david.marchand@redhat.com>
 <20251001064512.2539269-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qx6kxW0n_vW2LL70pV4uO6png_gZ7N_V4v1-yzS7io0_1759301129
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

