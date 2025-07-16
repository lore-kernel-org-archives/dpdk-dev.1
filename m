Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB351C83F22
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Jul 2025 13:04:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4A4AF4067C;
	Wed, 16 Jul 2025 15:03:52 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 1F21740A71
 for <dev@dpdk.org>; Wed, 16 Jul 2025 15:03:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752671030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1/yvcBMZnWta4iaaJBmIKy4H6XDdHpdbeYpLxoY5TgE=;
 b=Bfn/Elhu2+lIImpjSl1sGsOoXL5xWh09Nn8yW0GpXv9474OjF5iOp90kmCLNkkLAWHU7lg
 H4sf6SZTmh3oAYxp9AKxPsoWtxZB2oUXeNXA2OD/f0t2+aCVty7Phtw3nTIhOhG5fGWNKk
 U2DfCk24EKa0fYUkfflKxB6VkGAd7Mk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-JUj2Es0SP4-or5PxZhtrMg-1; Wed,
 16 Jul 2025 09:03:49 -0400
X-MC-Unique: JUj2Es0SP4-or5PxZhtrMg-1
X-Mimecast-MFC-AGG-ID: JUj2Es0SP4-or5PxZhtrMg_1752671028
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 82066195608E; Wed, 16 Jul 2025 13:03:48 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.225.235])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 50D59195E773; Wed, 16 Jul 2025 13:03:46 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v4 17/22] test/raw: fix test without skeleton driver
Date: Wed, 16 Jul 2025 15:02:04 +0200
Message-ID: <20250716130212.1736407-18-david.marchand@redhat.com>
In-Reply-To: <20250716130212.1736407-1-david.marchand@redhat.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250716130212.1736407-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kjdQFoJPUPkrhvjTcLIe_b6OKfassdbT84rwXuWHHfc_1752671028
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
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
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

