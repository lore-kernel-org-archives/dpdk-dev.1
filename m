Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C033CA1015
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Sep 2025 13:46:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5DAD1415D7;
	Thu,  4 Sep 2025 15:46:13 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 82ADF41156
 for <dev@dpdk.org>; Thu,  4 Sep 2025 15:46:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756993571;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=piY31ghgfOLV74Tf5HTXh7/5CsQTLjpakBVRiku3DcE=;
 b=QhsWWuTfA50wKH6pP9F7bEJDj6plH+zyEO1MuZ7rZ4skGaw3/RU4FRLZ012ROZz2Mxk7VC
 94g1ggXANpI8xhqeuCRjH403YjXFnxTFeSD7REdFbWP9Tj8ypzF8V41u5kp9VGMJkZjwq0
 ckVtWAVgI7Hihb/H8HG9AEafFntp51k=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-66-lYa-VwMkPF2s1HAxBMNV5w-1; Thu,
 04 Sep 2025 09:46:07 -0400
X-MC-Unique: lYa-VwMkPF2s1HAxBMNV5w-1
X-Mimecast-MFC-AGG-ID: lYa-VwMkPF2s1HAxBMNV5w_1756993566
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C025A19560B8; Thu,  4 Sep 2025 13:46:06 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.82])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 58F91180035E; Thu,  4 Sep 2025 13:46:04 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Aaron Conole <aconole@redhat.com>,
 Michael Santana <maicolgabriel@hotmail.com>
Subject: [PATCH] ci: switch testing to Fedora 42 in GHA
Date: Thu,  4 Sep 2025 15:45:31 +0200
Message-ID: <20250904134531.2171206-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: r_ixZHeGwshBIfQdK4_P8jMNepCrN0Gve62kB0blSJM_1756993566
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

Fedora 39 is EOL for some time.
Switch to Fedora 42 which will be maintained for a year (until May 2026).

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 .github/workflows/build.yml | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/.github/workflows/build.yml b/.github/workflows/build.yml
index 6f153ab681..cd8f0e2c6f 100644
--- a/.github/workflows/build.yml
+++ b/.github/workflows/build.yml
@@ -234,7 +234,7 @@ jobs:
       fail-fast: false
       matrix:
         config:
-          - image: fedora:39
+          - image: fedora:42
 
     steps:
     - name: Generate various keys
@@ -283,9 +283,9 @@ jobs:
       fail-fast: false
       matrix:
         config:
-          - image: fedora:39
+          - image: fedora:42
             compiler: gcc
-          - image: fedora:39
+          - image: fedora:42
             compiler: clang
 
     steps:
-- 
2.51.0

