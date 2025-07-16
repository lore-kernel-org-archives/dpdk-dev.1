Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E418C83F22
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Jul 2025 13:05:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3250640B91;
	Wed, 16 Jul 2025 15:04:19 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 8F7D3406B7
 for <dev@dpdk.org>; Wed, 16 Jul 2025 15:04:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752671056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YS8HiwYCgPn0+3ybr77CgbMga0xQMTSohF18Noiv+Oo=;
 b=Xjv8KRL22ZGKKIbg5rimTgq/UJGFkUGGY/hvS5n4OzpSA9R+oi/fW0+mYjiu+8OazHK4//
 OrLd2paxbglfnhLMVj04TENCQmqyYAj477ZaDfLQx/uDZ29jOIvA7FP30+y3M6E9l6Pguq
 tnOZG9t7uh9F7w8bdHQuk8tLH7NzJbA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-t1DlsZQJMhOu_U3JztJ8Fg-1; Wed,
 16 Jul 2025 09:04:10 -0400
X-MC-Unique: t1DlsZQJMhOu_U3JztJ8Fg-1
X-Mimecast-MFC-AGG-ID: t1DlsZQJMhOu_U3JztJ8Fg_1752671049
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D949A1800281; Wed, 16 Jul 2025 13:04:08 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.225.235])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A24C830001A2; Wed, 16 Jul 2025 13:04:04 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Anatoly Burakov <anatoly.burakov@intel.com>,
 Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>
Subject: [PATCH v4 21/22] test/func_reentrancy: fix EAL init call
Date: Wed, 16 Jul 2025 15:02:08 +0200
Message-ID: <20250716130212.1736407-22-david.marchand@redhat.com>
In-Reply-To: <20250716130212.1736407-1-david.marchand@redhat.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250716130212.1736407-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -ho7U-qGII4B3Mz4bEUFsTTF_lzhZR1_wEIO6twCLr4_1752671049
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

../lib/eal/common/eal_common_options.c:1638:16: runtime error:
	null pointer passed as argument 2, which is declared to never be null

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 app/test/test_func_reentrancy.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/app/test/test_func_reentrancy.c b/app/test/test_func_reentrancy.c
index 34d685d493..f4c6cbc548 100644
--- a/app/test/test_func_reentrancy.c
+++ b/app/test/test_func_reentrancy.c
@@ -66,15 +66,16 @@ static RTE_ATOMIC(uint32_t) synchro;
  * rte_eal_init only init once
  */
 static int
-test_eal_init_once(__rte_unused void *arg)
+test_eal_init_once(void *arg)
 {
 	unsigned lcore_self =  rte_lcore_id();
+	char *argv[] = { arg, NULL };
 
 	WAIT_SYNCHRO_FOR_WORKERS();
 
 	/* silent the check in the caller */
 	rte_atomic_store_explicit(&obj_count, 1, rte_memory_order_relaxed);
-	if (rte_eal_init(0, NULL) != -1)
+	if (rte_eal_init(RTE_DIM(argv) - 1, argv) != -1)
 		return -1;
 
 	return 0;
-- 
2.50.0

