Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B674C5B552
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Jun 2025 08:37:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0020842E62;
	Tue, 10 Jun 2025 10:37:00 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id D19D440292
 for <dev@dpdk.org>; Tue, 10 Jun 2025 10:36:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749544619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sEwJy9Bd42zJRFk6oBTU4lb+B8RZpR/ud8Q+ScTMMk8=;
 b=aVmB4kBPryJDTb+iBZsmovTkRPTWUmMgGArbfB8wfwqiqMW2OyECGZYjkGmO0Pa15Y4ycP
 o6I2CspXCfGnOsUpkcsDuuNiRzwe5HiB7WNrb0z3DQe+mgdGO4yAWuUzO5PeGPukyr73v4
 ScVl6+VEiSScR7wfdVxXAKJnZW+gm0k=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-426-KsTqN3FwMmGWCEugUpygOw-1; Tue,
 10 Jun 2025 04:36:56 -0400
X-MC-Unique: KsTqN3FwMmGWCEugUpygOw-1
X-Mimecast-MFC-AGG-ID: KsTqN3FwMmGWCEugUpygOw_1749544615
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D9A4E1956088; Tue, 10 Jun 2025 08:36:54 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.8])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 35D081800287; Tue, 10 Jun 2025 08:36:52 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net,
	Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [PATCH 2/2] test/lcore: fix build with MSVC
Date: Tue, 10 Jun 2025 10:36:42 +0200
Message-ID: <20250610083643.8466-2-david.marchand@redhat.com>
In-Reply-To: <20250610083643.8466-1-david.marchand@redhat.com>
References: <20250610083643.8466-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FcjMqd7jq-rH5iqChwUzkl9pIfos2frriwPDu1Vh-eM_1749544615
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

MSVC warns about atomic qualifier:
../app/test/test_per_lcore.c(101): error C2220: the following warning is
	treated as an error
../app/test/test_per_lcore.c(101): warning C4090: 'function': different
	'_Atomic' qualifiers

Fixes: 7c37826c2b87 ("test/lcore: fix race in per-lcore test")

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 app/test/test_per_lcore.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/app/test/test_per_lcore.c b/app/test/test_per_lcore.c
index 9c72f0fa21..e0674b0e70 100644
--- a/app/test/test_per_lcore.c
+++ b/app/test/test_per_lcore.c
@@ -98,7 +98,7 @@ test_per_lcore(void)
 	}
 
 	/* test if it could do remote launch twice at the same time or not */
-	ret = rte_eal_mp_remote_launch(test_per_lcore_delay, &wait, SKIP_MAIN);
+	ret = rte_eal_mp_remote_launch(test_per_lcore_delay, RTE_PTR_UNQUAL(&wait), SKIP_MAIN);
 	if (ret < 0) {
 		printf("It fails to do remote launch but it should able to do\n");
 		return -1;
-- 
2.49.0

