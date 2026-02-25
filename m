Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A8BEFCEE8B
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Feb 2026 11:29:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 704B34021E;
	Wed, 25 Feb 2026 12:29:36 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 09D1E400D6
 for <dev@dpdk.org>; Wed, 25 Feb 2026 12:29:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772018974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5T/x8wg78mS3++lJLrelbdnhVEGSDSIUKUejpu46jek=;
 b=C1nnDRZitLJIXnUsCH+X4WzR+T28lvOZBeLIdIqGP7kUbXjZcJUMo3NlvRwxZktO4K3KDh
 bR7C1m/c0bIB3JEtpg4RDQKywu+mFn0Nh9J0o7EYiuvffHytWtq6Nw0Q0JpXwhceEGK8Tl
 /tYvnmWwVnTn5UHvhet6Eef/JnX28Lg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-2sucfJLpODy4CYLEo82XCQ-1; Wed,
 25 Feb 2026 06:29:31 -0500
X-MC-Unique: 2sucfJLpODy4CYLEo82XCQ-1
X-Mimecast-MFC-AGG-ID: 2sucfJLpODy4CYLEo82XCQ_1772018970
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D4A1A180061C; Wed, 25 Feb 2026 11:29:29 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.32.223])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 275F019560B6; Wed, 25 Feb 2026 11:29:27 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [RFC 1/2] devtools: check packet forwarding in null test
Date: Wed, 25 Feb 2026 12:29:20 +0100
Message-ID: <20260225112922.3982104-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ppD2HGLWeeTDSvzpLzgJdmd4m4p0YsPLhnMn4IIghNg_1772018970
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

Add some simple checks that testpmd was indeed polling two ports, and
some packets got through it.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 devtools/test-null.sh | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/devtools/test-null.sh b/devtools/test-null.sh
index e3ac168ce3..8f21189262 100755
--- a/devtools/test-null.sh
+++ b/devtools/test-null.sh
@@ -26,8 +26,14 @@ else
 	libs=
 fi
 
+logfile=$build/test-null.log
 (sleep 1 && echo stop) |
 # testpmd only needs 20M, make it x2 (default number of cores) for NUMA systems
 $testpmd -l $corelist --no-huge -m 40 \
 	$libs -a 0:0.0 --vdev net_null1 --vdev net_null2 $eal_options -- \
-	--no-mlockall --total-num-mbufs=2048 $testpmd_options -ia
+	--no-mlockall --total-num-mbufs=2048 $testpmd_options -ia | tee $logfile
+
+# we expect two ports and some traffic is received and transmitted
+grep -q 'io packet forwarding - ports=2 -' $build/test-null.log
+grep 'RX-packets: ' $logfile | tail -1 | grep -q 'RX-packets:[[:space:]]*[^0[:space:]]'
+grep 'TX-packets: ' $logfile | tail -1 | grep -q 'TX-packets:[[:space:]]*[^0[:space:]]'
-- 
2.53.0

