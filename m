Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F17CA5FD9
	for <dpdk-dev@archiver.kernel.org>; Fri,  2 Oct 2026 07:45:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2CC10427B9;
	Fri,  2 Oct 2026 09:45:07 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id F1A62427E9
 for <dev@dpdk.org>; Fri,  2 Oct 2026 09:45:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790927105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yrbQZgqzCSTB7S5HSKa0xTlwnW69Cwz3LQJzd6lZZyA=;
 b=M7iaZGBQKblvvTzz/lYNBiutwDwXy2dN2zycHRfYO5hxyihsG843D3ZGTlimxvg7j1OSCx
 y0bQf/CXgdhEG5jvzaJfAWnpaCAb6cKy2z7JI9Tm3HThwk1m2jaRQl0oW+wCB+LssLbvpY
 C0ksqTrHjvX/G9P0bSDVWHVSgz9+InA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-356-PQdF1qqaN0yheVac-ogzhQ-1; Fri,
 02 Oct 2026 03:45:00 -0400
X-MC-Unique: PQdF1qqaN0yheVac-ogzhQ-1
X-Mimecast-MFC-AGG-ID: PQdF1qqaN0yheVac-ogzhQ_1790927099
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 082861955F39; Fri,  2 Oct 2026 07:44:59 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9CE451956087; Fri,  2 Oct 2026 07:44:57 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: maxime.coquelin@redhat.com,
	dev@dpdk.org
Cc: bruce.richardson@intel.com, Chenbo Xia <chenbox@nvidia.com>,
 Adrian Moreno <amorenoz@redhat.com>
Subject: [PATCH v3 3/6] examples/vdpa: remove dependency on PCI library
Date: Fri,  2 Oct 2026 09:44:37 +0200
Message-ID: <20261002074440.2551536-4-david.marchand@redhat.com>
In-Reply-To: <20261002074440.2551536-1-david.marchand@redhat.com>
References: <20260723153111.3943368-1-david.marchand@redhat.com>
 <20261002074440.2551536-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1jgSQ0ZxMYwB--vyopSZKMbLcYx2SPx-evRErYy1Akc_1790927099
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
index ac6da79b05..79bfe7022a 100644
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

