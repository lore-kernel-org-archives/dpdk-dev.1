Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0858C8303C
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Jul 2025 12:32:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 92E2F40BA6;
	Tue,  8 Jul 2025 14:32:03 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 4C77E40BA6
 for <dev@dpdk.org>; Tue,  8 Jul 2025 14:32:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751977921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=73vc5IQ22BoFrg5c3Uy9zk6ksosH2ouY9rJn0AR9nHo=;
 b=EDZkprG82SiUZq9byMty4ddMR6yWT1HrqPZiCWjMpoJMjq1Qb8e/YeeqJOaW6eWEILANuP
 DdFW9a5wySht/CQl93lELO3HeWIyCvweS1mhTQORjWeGODeDvFE8F1VP4WcYQHFHowdq6f
 Vx/BuXgpV/7OtNlzgnifT2WDDFlOsfE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-461-Wnow0tbhOka_mjiKMiR0VA-1; Tue,
 08 Jul 2025 08:32:00 -0400
X-MC-Unique: Wnow0tbhOka_mjiKMiR0VA-1
X-Mimecast-MFC-AGG-ID: Wnow0tbhOka_mjiKMiR0VA_1751977920
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DA3171955ED8
 for <dev@dpdk.org>; Tue,  8 Jul 2025 12:31:59 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.95])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F08D8180035E
 for <dev@dpdk.org>; Tue,  8 Jul 2025 12:31:58 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Subject: [PATCH v3 17/18] test/raw: fix test without skeleton driver
Date: Tue,  8 Jul 2025 14:28:21 +0200
Message-ID: <20250708122823.3406288-18-david.marchand@redhat.com>
In-Reply-To: <20250708122823.3406288-1-david.marchand@redhat.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250708122823.3406288-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zNw0WQRh3OwaYX15tR9h2ZTg9v07R9NDA6fBRMgtzes_1751977920
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

Skip the test in the absence of the required skeleton driver.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 app/test/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/app/test/meson.build b/app/test/meson.build
index 79d635b42b..8df8d3edd1 100644
--- a/app/test/meson.build
+++ b/app/test/meson.build
@@ -154,7 +154,7 @@ source_file_deps = {
     'test_prefetch.c': [],
     'test_ptr_compress.c': ['ptr_compress'],
     'test_rand_perf.c': [],
-    'test_rawdev.c': ['rawdev', 'bus_vdev'],
+    'test_rawdev.c': ['rawdev', 'bus_vdev', 'raw_skeleton'],
     'test_rcu_qsbr.c': ['rcu', 'hash'],
     'test_rcu_qsbr_perf.c': ['rcu', 'hash'],
     'test_reassembly_perf.c': ['net', 'ip_frag'],
-- 
2.50.0

