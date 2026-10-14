Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE9FCC6B1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 15:58:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0335A40A67;
	Wed, 14 Oct 2026 17:58:14 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 22A94406BA
 for <dev@dpdk.org>; Wed, 14 Oct 2026 17:58:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791993492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zknj7YX3uyfIN1V4xozmacCtehHiGKvN92Jk/MBjqR0=;
 b=cdoXpU9qddd8wcivH3hfIKHPRoPmWUqmfR31Pb390WvMtRMAYvS0JF/E88IS9Z1vfLam7V
 r0J/gnn0YSjK5RGLHnpCwNQ07bxWiE/5zsJOtV5Odvvp1aP/A4sZYMb7HEQly1eq5XuquC
 ZlBPkuwxWXTXoYHbrAU/6DP7SaqmvUo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-59-7vUx5UQbOouoOtx9BFbM9g-1; Wed,
 14 Oct 2026 15:58:11 +0000
X-MC-Unique: 7vUx5UQbOouoOtx9BFbM9g-1
X-Mimecast-MFC-AGG-ID: 7vUx5UQbOouoOtx9BFbM9g_1791993490
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1011C19560AE; Wed, 14 Oct 2026 15:58:10 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A383518001CA; Wed, 14 Oct 2026 15:58:08 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: maxime.coquelin@redhat.com,
	dev@dpdk.org
Cc: bruce.richardson@intel.com, Chenbo Xia <chenbox@nvidia.com>,
 Adrian Moreno <amorenoz@redhat.com>
Subject: [PATCH v4 3/6] examples/vdpa: remove dependency on PCI library
Date: Wed, 14 Oct 2026 17:57:47 +0200
Message-ID: <20261014155750.1269862-4-david.marchand@redhat.com>
In-Reply-To: <20261014155750.1269862-1-david.marchand@redhat.com>
References: <20260723153111.3943368-1-david.marchand@redhat.com>
 <20261014155750.1269862-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9DPQnubexz8QP8NExJqPh6ESSJKOgXlZCK3Yija933M_1791993490
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

This is some forgotten unneeded header include from a previous
refactoring.

Fixes: 38f8ab0bbc8d ("vhost: make vDPA framework bus agnostic")

Signed-off-by: David Marchand <david.marchand@redhat.com>
Reviewed-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 examples/vdpa/main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/examples/vdpa/main.c b/examples/vdpa/main.c
index 1b989fc6e5..c39cece15c 100644
--- a/examples/vdpa/main.c
+++ b/examples/vdpa/main.c
@@ -13,7 +13,6 @@
 #include <rte_malloc.h>
 #include <rte_vhost.h>
 #include <rte_vdpa.h>
-#include <rte_pci.h>
 #include <rte_string_fns.h>
 
 #include <cmdline_socket.h>
-- 
2.54.0

