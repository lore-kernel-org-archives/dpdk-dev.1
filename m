Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2C9CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 07:45:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 21ECF40662;
	Wed,  5 Nov 2025 08:45:59 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 4BA8C400D7
 for <dev@dpdk.org>; Wed,  5 Nov 2025 08:45:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762328756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZpPNvQL9wENQmvWszpfxRXRz+2mhQqE9/Mw59zIxA0s=;
 b=PN+u8kmBU6/mgURi8F3fYHz9fY7wH7hgfRZG+n6hiDMFEViXIlsZZRRuDoE9Uzgn1ZHDO6
 U7GOWP6qKYGjm+zNqi2sVO+rXi+KmZYMQ7iFDip8XGKXp9A9gBAxdLcO2Rjmz0nYg9xqzp
 UFoyChMzgGt2SXWWIEFVtGZ7d3R3zLE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-436-MVAdI6GgOvGVWMTFQJSSLw-1; Wed,
 05 Nov 2025 02:45:55 -0500
X-MC-Unique: MVAdI6GgOvGVWMTFQJSSLw-1
X-Mimecast-MFC-AGG-ID: MVAdI6GgOvGVWMTFQJSSLw_1762328754
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4F2D51800343; Wed,  5 Nov 2025 07:45:54 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.224.16])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 96978300018D; Wed,  5 Nov 2025 07:45:52 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Aaron Conole <aconole@redhat.com>,
 Michael Santana <maicolgabriel@hotmail.com>
Subject: [PATCH v2] ci: switch testing to Fedora 43 in GHA
Date: Wed,  5 Nov 2025 08:45:47 +0100
Message-ID: <20251105074547.3760605-1-david.marchand@redhat.com>
In-Reply-To: <20250904134531.2171206-1-david.marchand@redhat.com>
References: <20250904134531.2171206-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _oBbQBtr392BjOVvSYlR0d4kS9SpMDyAUvuJe-J6GRQ_1762328754
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
Switch to Fedora 43 which will be maintained for a year
(until December 2026).

Signed-off-by: David Marchand <david.marchand@redhat.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Aaron Conole <aconole@redhat.com>
---
Changes since v1:
- skipped Fedora 42 now that 43 is out,

---
 .github/workflows/build.yml | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/.github/workflows/build.yml b/.github/workflows/build.yml
index 6f153ab681..2da27dca5d 100644
--- a/.github/workflows/build.yml
+++ b/.github/workflows/build.yml
@@ -234,7 +234,7 @@ jobs:
       fail-fast: false
       matrix:
         config:
-          - image: fedora:39
+          - image: fedora:43
 
     steps:
     - name: Generate various keys
@@ -283,9 +283,9 @@ jobs:
       fail-fast: false
       matrix:
         config:
-          - image: fedora:39
+          - image: fedora:43
             compiler: gcc
-          - image: fedora:39
+          - image: fedora:43
             compiler: clang
 
     steps:
-- 
2.51.0

