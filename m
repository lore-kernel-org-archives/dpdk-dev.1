Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45573CC6B33
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 16:02:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 206CE402E4;
	Thu, 15 Oct 2026 18:02:10 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 5AAB2402DA
 for <dev@dpdk.org>; Thu, 15 Oct 2026 18:02:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792080127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=n6Lz4UgflK33Jm91GtTnLYqPCvQXwORF0vwGj8hWkro=;
 b=exGqsH3E9Jpvy+Pfu/eIx/NJpZ+87R8sJmJ3o5Ft6qQY1a8qWcf2NP21ds+R25YqzSVDqy
 M4biUeCdrUc/lBxbW8zv8yz0a/3b+hbDq9teXFF4VqV10XMZ0MsmKLBx6Yg5UwyAQUCx98
 m2G8T35Dbw3ea2QQCwySTuc4TXVn7TA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-401-g3yRYp_ePlOv2j74gJ9w1A-1; Thu,
 15 Oct 2026 16:02:04 +0000
X-MC-Unique: g3yRYp_ePlOv2j74gJ9w1A-1
X-Mimecast-MFC-AGG-ID: g3yRYp_ePlOv2j74gJ9w1A_1792080123
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0F9A018001CD; Thu, 15 Oct 2026 16:02:03 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5EDCB1955F1C; Thu, 15 Oct 2026 16:02:01 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, Aaron Conole <aconole@redhat.com>,
 Robin Jarry <rjarry@redhat.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH] ci: fix dependency on cmdline
Date: Thu, 15 Oct 2026 18:01:57 +0200
Message-ID: <20261015160157.3348253-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EHGcAS_YwkKaagj5nE_kUeLpTdB7rjmDTHQoM1Ixw-0_1792080123
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

The unit tests, testpmd and some examples depend on the cmdline library.
Without it, the "mini" target in GHA ends up as a build failure.

Fixes: 6de2c9c791b8 ("build: make cmdline optional")

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 .ci/linux-build.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.ci/linux-build.sh b/.ci/linux-build.sh
index 4f266940e9..2c7386d320 100755
--- a/.ci/linux-build.sh
+++ b/.ci/linux-build.sh
@@ -120,7 +120,7 @@ else
 fi
 if [ "$MINI" = "true" ]; then
     OPTS="$OPTS -Denable_drivers=net/null"
-    OPTS="$OPTS -Ddisable_libs=*"
+    OPTS="$OPTS -Denable_libs=cmdline"
     if [ "$DEF_LIB" = "static" ]; then
         OPTS="$OPTS -Dexamples=l2fwd"
     fi
-- 
2.54.0

