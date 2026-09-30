Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00635CA5FB1
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 10:00:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9FE7440DD8;
	Wed, 30 Sep 2026 12:00:19 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 3F48440DD8
 for <dev@dpdk.org>; Wed, 30 Sep 2026 12:00:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790762417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VzvggzjX164CflEcxmkUIDYK3zV57t6KCbk2TSeSRpw=;
 b=grKh+AmXHFQQdICrs0Sbp2mnGOyHSyqibZ9trxoZlaexDXjk2heBitAExtvk3JLBRmZhHm
 J4cJ2DMHDmrYVn+lAwja7gPqDeXpjy6uwEZKvriHghJPWleo8CBNFlPErDZjpBSGiQLbwo
 +8DRYNNOJQaLkFzjcalwLMDfu874H+g=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-45-R5sngtKVMGy4pzlEjeM9jQ-1; Wed,
 30 Sep 2026 06:00:15 -0400
X-MC-Unique: R5sngtKVMGy4pzlEjeM9jQ-1
X-Mimecast-MFC-AGG-ID: R5sngtKVMGy4pzlEjeM9jQ_1790762415
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B80DF1801321; Wed, 30 Sep 2026 10:00:14 +0000 (UTC)
Received: from max-p1 (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3BC9F30000E8; Wed, 30 Sep 2026 10:00:12 +0000 (UTC)
From: Maxime Coquelin <maxime.coquelin@redhat.com>
To: dev@dpdk.org, eperezma@redhat.com, david.marchand@redhat.com,
 thomas@monjalon.net, stephen@networkplumber.org
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: [PATCH 1/2] config: add compatibility for old compilers with new UAPI
 headers
Date: Wed, 30 Sep 2026 11:57:59 +0200
Message-ID: <20260930095800.551314-2-maxime.coquelin@redhat.com>
In-Reply-To: <20260930095800.551314-1-maxime.coquelin@redhat.com>
References: <20260930095800.551314-1-maxime.coquelin@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 06Q3RrcHXqC0ichJLm9mdHeJLKX8_4ra5eU3hgl2dLw_1790762415
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

This patch adds a compatibility define for __counted_by attribute,
which is not present in older compilers but required for recent UAPI
headers like vfio.h.

Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 config/rte_config.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/config/rte_config.h b/config/rte_config.h
index 0447cdf2ad..307e7dac62 100644
--- a/config/rte_config.h
+++ b/config/rte_config.h
@@ -25,6 +25,15 @@
 #define RTE_TOOLCHAIN_MSVC 1
 #endif
 
+/*
+ * Compatibility define for Linux kernel UAPI headers that may use __counted_by
+ * attribute for bounds checking. This attribute is not understood by userspace
+ * compilers, so define it as empty if not already provided.
+ */
+#ifndef __counted_by
+#define __counted_by(m)
+#endif
+
 /* legacy defines */
 #ifdef RTE_EXEC_ENV_LINUX
 #define RTE_EXEC_ENV_LINUXAPP 1
-- 
2.55.0

