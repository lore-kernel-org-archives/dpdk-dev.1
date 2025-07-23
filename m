Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89AC4C83F17
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Jul 2025 13:34:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 59C1D40ECF;
	Wed, 23 Jul 2025 15:33:42 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 933124067C
 for <dev@dpdk.org>; Wed, 23 Jul 2025 15:33:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753277619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1/yvcBMZnWta4iaaJBmIKy4H6XDdHpdbeYpLxoY5TgE=;
 b=atj9jz+9FzkrZt6GABZwbVCuGqr/onJt2U6Tvltpy7qYV/xUJkYc4JzZYTHDPp5JScy0+s
 tgfNHCigZ9yMmucQDFVxo7kNI1oCrkW/ImLNbLbpUBH+fAe+rxc0YdGnmdfXKCAuuz95iX
 nwGz9R+fbSK+OJguAlShoRXkbG46R+0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-9dEDKz0aNZqFxkMA0gc3_A-1; Wed,
 23 Jul 2025 09:33:36 -0400
X-MC-Unique: 9dEDKz0aNZqFxkMA0gc3_A-1
X-Mimecast-MFC-AGG-ID: 9dEDKz0aNZqFxkMA0gc3_A_1753277615
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B73761944CFD; Wed, 23 Jul 2025 13:33:35 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.51])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 904B11800165; Wed, 23 Jul 2025 13:33:34 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v5 17/22] test/raw: fix test without skeleton driver
Date: Wed, 23 Jul 2025 15:31:50 +0200
Message-ID: <20250723133157.159825-18-david.marchand@redhat.com>
In-Reply-To: <20250723133157.159825-1-david.marchand@redhat.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250723133157.159825-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QdlzFkhtVuLw0SL3NBMDpVE1pvOukczgoh3zYlbbllI_1753277615
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

