Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 059C4C83030
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Jul 2025 08:20:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D8C5D40287;
	Thu,  3 Jul 2025 10:20:20 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 0F5C940285
 for <dev@dpdk.org>; Thu,  3 Jul 2025 10:20:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751530818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XBZKS+DWP92tHommVBAMV4B+U4jGUBQpHXU61CPFfoU=;
 b=EpgnsBMx8uOCidB47EshYxjxxbBz2JaDHnhX4c9Mek7ZKzoiE32UjFDyHoQGtGVhYm/3P4
 uVDe/+7ZNOKtiJN9cHu7MZyCeax9k3tgIXsTXNtQyUoIqLJlZwn9n4L8BiO2Sr935OWIE6
 xF3xX9lM0AxFuSpOBQjMAtY/IRVJzlE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-a1vAx21cP8aeADSAVROBsg-1; Thu,
 03 Jul 2025 04:20:17 -0400
X-MC-Unique: a1vAx21cP8aeADSAVROBsg-1
X-Mimecast-MFC-AGG-ID: a1vAx21cP8aeADSAVROBsg_1751530816
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5FA64180047F; Thu,  3 Jul 2025 08:20:16 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.143])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A1DA9180045C; Thu,  3 Jul 2025 08:20:14 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, Aaron Conole <aconole@redhat.com>,
 Michael Santana <maicolgabriel@hotmail.com>
Subject: [PATCH v2] ci: check C++ headers with clang
Date: Thu,  3 Jul 2025 10:20:10 +0200
Message-ID: <20250703082010.2002295-1-david.marchand@redhat.com>
In-Reply-To: <20250701113146.1268492-1-david.marchand@redhat.com>
References: <20250701113146.1268492-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 970MsN7-8JOObsAEt_NYoUoREAT_FLd5tO6dDW5gJeg_1751530816
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

If not passing an explicit compiler for C++, meson uses c++ which
defaults to /usr/bin/g++ on a Ubuntu system.
Explicitly choose which compiler to use for C++.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
Changes since v1:
- rebased,
- moved CXX tweaking in the branch enabling headers check,

---
 .ci/linux-build.sh | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/.ci/linux-build.sh b/.ci/linux-build.sh
index e9272d3931..5c4bfa75c3 100755
--- a/.ci/linux-build.sh
+++ b/.ci/linux-build.sh
@@ -102,9 +102,14 @@ OPTS="$OPTS -Dplatform=generic"
 OPTS="$OPTS -Ddefault_library=$DEF_LIB"
 OPTS="$OPTS -Dbuildtype=$buildtype"
 if [ "$STDATOMIC" = "true" ]; then
-	OPTS="$OPTS -Denable_stdatomic=true"
+    OPTS="$OPTS -Denable_stdatomic=true"
 else
-	OPTS="$OPTS -Dcheck_includes=true"
+    OPTS="$OPTS -Dcheck_includes=true"
+    if [ "${CC%%clang}" != "$CC" ]; then
+        export CXX=clang++
+    else
+        export CXX=g++
+    fi
 fi
 if [ "$MINI" = "true" ]; then
     OPTS="$OPTS -Denable_drivers=net/null"
-- 
2.50.0

