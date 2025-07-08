Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A67C8303C
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Jul 2025 12:32:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 74E5D40A89;
	Tue,  8 Jul 2025 14:32:17 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 053D84069F
 for <dev@dpdk.org>; Tue,  8 Jul 2025 14:32:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751977935;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TSHCN+WlV00+rw7B7660M1B1euXmXLCyemoJKArjBW4=;
 b=DDbSbaGfjSXbbhzmlSjcI+8hqY34aQFSqbZYoNGq0w4EGBS74kcuRytlV2WJ3OOPcbW2XB
 a36X3ko6bJr0s1BGkjEr3oaUIgvG439JY7QQhKZv6XEVV+5i6K+tYlAwuqBcrt5XA85LR3
 WPJwlsW8vXeZqvxsLNLiILX7OEkY9Lg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-3-j-5w6EOEG9KS-8CHczfQ-1; Tue,
 08 Jul 2025 08:32:14 -0400
X-MC-Unique: 3-j-5w6EOEG9KS-8CHczfQ-1
X-Mimecast-MFC-AGG-ID: 3-j-5w6EOEG9KS-8CHczfQ_1751977933
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9D19418DA5CA; Tue,  8 Jul 2025 12:32:13 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.95])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2A0F71803AFF; Tue,  8 Jul 2025 12:32:11 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Aaron Conole <aconole@redhat.com>,
 Michael Santana <maicolgabriel@hotmail.com>
Subject: [PATCH v3 18/18] ci: extend coverage with UBSan
Date: Tue,  8 Jul 2025 14:28:22 +0200
Message-ID: <20250708122823.3406288-19-david.marchand@redhat.com>
In-Reply-To: <20250708122823.3406288-1-david.marchand@redhat.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250708122823.3406288-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TQmN4RDBaNYChC4dBDOC3ryNHo7HBnUXJ4yJUdVhkDE_1751977933
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
 .ci/linux-build.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.ci/linux-build.sh b/.ci/linux-build.sh
index a24820c65b..1b0e01d395 100755
--- a/.ci/linux-build.sh
+++ b/.ci/linux-build.sh
@@ -139,7 +139,7 @@ if [ "$UBSAN" = "true" ]; then
         # Restrict drivers to a minimum set for now
         OPTS="$OPTS -Denable_drivers=net/null"
         # There are still known issues in various libraries, disable them for now
-        OPTS="$OPTS -Ddisable_libs=*"
+        OPTS="$OPTS -Ddisable_libs=acl,bpf,cfgfile,distributor,fib,lpm,member,ptr_compress,rib,table"
         # No examples are run
         OPTS="$OPTS -Dexamples="
         # The UBSan target takes a good amount of time and headers coverage is done in other
-- 
2.50.0

