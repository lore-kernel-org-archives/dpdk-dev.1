Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93E9C83F1B
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Jul 2025 09:43:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 49F554067A;
	Thu, 17 Jul 2025 11:43:02 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 14F604021F
 for <dev@dpdk.org>; Thu, 17 Jul 2025 11:42:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752745365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=sOYy5L7tcg85EvCnp3UJ7mPdU+V3e691KUU/4BVuebc=;
 b=Dy1xKyzIkUNOzkP//tNHZDJuFsqHS5+r6iGjHisypIhh3/JSX/JrE12V7TDIPKqWCUjdqU
 wzLZVx9x1Jyml5eumccKEDocK0DtqRrAIuOK73CO5uvTS1tOEQQhGm8uLkXZfRsrXlCHep
 pTfr3HwhRtz9oQpENmGZwDOoshWXOis=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-163-egn1wGy_P2-MJbJFYc68kg-1; Thu,
 17 Jul 2025 05:42:42 -0400
X-MC-Unique: egn1wGy_P2-MJbJFYc68kg-1
X-Mimecast-MFC-AGG-ID: egn1wGy_P2-MJbJFYc68kg_1752745361
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5B397180048E; Thu, 17 Jul 2025 09:42:40 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.225.187])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C09591956089; Thu, 17 Jul 2025 09:42:37 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, bruce.richardson@intel.com, stable@dpdk.org,
 Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Harry van Haaren <harry.van.haaren@intel.com>
Subject: [PATCH] eal: add description of service corelist in usage
Date: Thu, 17 Jul 2025 11:42:32 +0200
Message-ID: <20250717094232.2184783-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: f9oIFLlx4ixUkq66YM-u0g7rvpNQ1OyvDU7d-FksNzg_1752745361
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

The -S option is not described in EAL usage().

Fixes: 7dbd7a6413ef ("service: add -S corelist option")
Cc: stable@dpdk.org

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 lib/eal/common/eal_common_options.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index f0a9ddeeb7..3169dd069f 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -2127,6 +2127,7 @@ eal_common_usage(void)
 	       "                      '( )' can be omitted for single element group,\n"
 	       "                      '@' can be omitted if cpus and lcores have the same value\n"
 	       "  -s SERVICE COREMASK Hexadecimal bitmask of cores to be used as service cores\n"
+	       "  -S SERVICE CORELIST List of cores to run services on\n"
 	       "  --"OPT_MAIN_LCORE" ID     Core ID that is used as main\n"
 	       "  --"OPT_MBUF_POOL_OPS_NAME" Pool ops name for mbuf to use\n"
 	       "  -n CHANNELS         Number of memory channels\n"
-- 
2.50.0

