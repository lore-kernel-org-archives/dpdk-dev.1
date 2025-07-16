Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F0CC83F22
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Jul 2025 13:05:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3746140676;
	Wed, 16 Jul 2025 15:04:18 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 3F58C40676
 for <dev@dpdk.org>; Wed, 16 Jul 2025 15:04:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752671055;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=siUdQF4AGH90dkgLqGOrsj3twhdj9vohTk5vMrpBmTc=;
 b=Mgx+qrlejL7dy0+zrEZ60SbWEnv2TKQQBYHdS/0I9aZdhW2sPsvTVX0lJ9at9fhlK1Wr+P
 rp2toAyJQjRWxcJ8Lk59Vy3ERiAsjYDL3d8p5Ao0ZABilP6VnWO6HVqWi5zVeo31mOgOWk
 HexRIth5SD1+f+60rWKchyqK9ZwA2RA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-67-G2klkB4VNpGybR4DtpEkFQ-1; Wed,
 16 Jul 2025 09:04:14 -0400
X-MC-Unique: G2klkB4VNpGybR4DtpEkFQ-1
X-Mimecast-MFC-AGG-ID: G2klkB4VNpGybR4DtpEkFQ_1752671053
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9D7501956086; Wed, 16 Jul 2025 13:04:13 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.225.235])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 00AAE1954213; Wed, 16 Jul 2025 13:04:11 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Aaron Conole <aconole@redhat.com>,
 Michael Santana <maicolgabriel@hotmail.com>
Subject: [PATCH v4 22/22] ci: extend coverage with UBSan
Date: Wed, 16 Jul 2025 15:02:09 +0200
Message-ID: <20250716130212.1736407-23-david.marchand@redhat.com>
In-Reply-To: <20250716130212.1736407-1-david.marchand@redhat.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250716130212.1736407-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Od4zwdX9nMGl6kUvoHCCxLzeHAnXzx7xku07pnBTdSw_1752671053
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

