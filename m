Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02554C83F1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Jul 2025 13:35:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E569740EE5;
	Wed, 23 Jul 2025 15:34:03 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 7FE7D40E4A
 for <dev@dpdk.org>; Wed, 23 Jul 2025 15:34:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753277642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=siUdQF4AGH90dkgLqGOrsj3twhdj9vohTk5vMrpBmTc=;
 b=Bf9JHaQNGSB8hZiWIHp0hBIVzORC4XWMljbfcd9/ljZhOV37L4Glgb/oxG5+J+0MP85QBK
 1v7OZH4jRFmFV5+k5xd2ETsoxHkp+ZwrwEccTbnrKrAsThuO6bt/cpfuLCFUTxtNJHpP2R
 PCNxcaYFDBXsFxVJ5q6VfsehLbLP/CQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-iAc1LlHNOem_lRAqzpykug-1; Wed,
 23 Jul 2025 09:34:00 -0400
X-MC-Unique: iAc1LlHNOem_lRAqzpykug-1
X-Mimecast-MFC-AGG-ID: iAc1LlHNOem_lRAqzpykug_1753277639
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CF10D1800945; Wed, 23 Jul 2025 13:33:59 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.51])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 60A441800165; Wed, 23 Jul 2025 13:33:58 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Aaron Conole <aconole@redhat.com>,
 Michael Santana <maicolgabriel@hotmail.com>
Subject: [PATCH v5 22/22] ci: extend coverage with UBSan
Date: Wed, 23 Jul 2025 15:31:55 +0200
Message-ID: <20250723133157.159825-23-david.marchand@redhat.com>
In-Reply-To: <20250723133157.159825-1-david.marchand@redhat.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250723133157.159825-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: unRzKMwlF8pv8VoIWzHGmiqQNKZ3MuVkWEynhVUoHuk_1753277639
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

Enable more libraries, but exclude the ones with currently failing
unit tests.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
Changes since v3:
- re-enabled cfgfile, fib, lpm and rib,

---
 .ci/linux-build.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.ci/linux-build.sh b/.ci/linux-build.sh
index c7f3179598..ceead259f3 100755
--- a/.ci/linux-build.sh
+++ b/.ci/linux-build.sh
@@ -144,7 +144,7 @@ if [ "$UBSAN" = "true" ]; then
         # Restrict drivers to a minimum set for now
         OPTS="$OPTS -Denable_drivers=net/null"
         # There are still known issues in various libraries, disable them for now
-        OPTS="$OPTS -Ddisable_libs=*"
+        OPTS="$OPTS -Ddisable_libs=acl,bpf,distributor,member,ptr_compress,table"
         # No examples are run
         OPTS="$OPTS -Dexamples="
         # The UBSan target takes a good amount of time and headers coverage is done in other
-- 
2.50.0

