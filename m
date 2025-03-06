Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DAE4C282D1
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Mar 2025 14:34:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4127C406B6;
	Thu,  6 Mar 2025 15:34:53 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 75FA64065F
 for <dev@dpdk.org>; Thu,  6 Mar 2025 15:34:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741271691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5zRMZi85ZzIXYrSfOAa1MHgZoSu2fYfHf0aKdbCzRjg=;
 b=aAjs5CXNrfIriezUEpO/lb2j96o3JaC3ytqyJcJFTmw3nqW2KNznkNmRyCDc0KlpYQJbib
 e8f0KN3yf+UDOGpf2d8s2/zjPKmo4Fg1zH4RDVfWWlr5V82Fv3SetoRr4PBHy5skzRJScS
 ojOjaccB+jMArwwFtYuU3E5f2UNC1sU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-IRMoxQa9Po6WI5eID-zkbQ-1; Thu,
 06 Mar 2025 09:34:49 -0500
X-MC-Unique: IRMoxQa9Po6WI5eID-zkbQ-1
X-Mimecast-MFC-AGG-ID: IRMoxQa9Po6WI5eID-zkbQ_1741271688
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D92CC19560B1; Thu,  6 Mar 2025 14:34:47 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.224.74])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 39A3C180174E; Thu,  6 Mar 2025 14:34:45 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: stable@dpdk.org, Aaron Conole <aconole@redhat.com>,
 Michael Santana <maicolgabriel@hotmail.com>
Subject: [PATCH] ci: fix ccache for Ubuntu 22.04
Date: Thu,  6 Mar 2025 15:34:43 +0100
Message-ID: <20250306143443.3972030-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 463og28XxCMx9-U1_dOCj7MVisXyyRbKAkGsfJcaRmU_1741271688
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

By default (and if no $HOME/.ccache directory exists), Ubuntu 22.04 ccache
stores its data in $HOME/.cache/ccache.
As a result, since the switch to Ubuntu 22.04, ccache has not been
functional.

Set the ccache directory to the location cached in GHA.

Note: ccache is working with the Fedora containers, as the presence of a
.ccache directory made ccache use it, still,
explicitly set CCACHE_DIR for consistency.

Fixes: 8400093195dd ("ci: bump tested distributions in GHA")
Cc: stable@dpdk.org

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 .github/workflows/build.yml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.github/workflows/build.yml b/.github/workflows/build.yml
index 183b0b1999..a5739a72c6 100644
--- a/.github/workflows/build.yml
+++ b/.github/workflows/build.yml
@@ -45,6 +45,7 @@ jobs:
       BUILD_DOCS: ${{ contains(matrix.config.checks, 'doc') }}
       BUILD_EXAMPLES: ${{ contains(matrix.config.checks, 'examples') }}
       CC: ccache ${{ matrix.config.compiler }}
+      CCACHE_DIR: $HOME/.ccache
       DEF_LIB: ${{ matrix.config.library }}
       LIBABIGAIL_VERSION: libabigail-2.6
       MINGW: ${{ matrix.config.cross == 'mingw' }}
@@ -307,6 +308,7 @@ jobs:
         mkdir -p ~/.ccache
         > ~/env
         echo CC=ccache ${{ matrix.config.compiler }} >> ~/env
+        echo CCACHE_DIR=/root/.ccache >> ~/env
         echo DEF_LIB=${{ matrix.config.library }} >> ~/env
         echo STDATOMIC=false >> ~/env
     - name: Load the cached image
-- 
2.48.1

