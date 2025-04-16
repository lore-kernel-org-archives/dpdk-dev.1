Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9843CC369BD
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Apr 2025 12:35:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8003D40E30;
	Wed, 16 Apr 2025 14:34:46 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 9002540DFD
 for <dev@dpdk.org>; Wed, 16 Apr 2025 14:34:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744806884;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=05DHvoRLOA732E5WBBg62iPxB2xvlfqtPNqHgBw+MqU=;
 b=i41lMIQ46KEg8cU4Gej6SYU6yPfO1/puQGjBtjW4ZLnA51XM9iyERGaa/3EKGR9m+NkljF
 co5qqyV0Q8hBwKY9lQ3bG+Ij36671h8nFme+ppD9XB9bMYqp0etDUc0fGtH83JiWkhT2uS
 5cOqFC9eMQ7m2BoG3W17G/urXlM1HKs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-484-woo16RtANbi8kbaVreuymA-1; Wed,
 16 Apr 2025 08:34:42 -0400
X-MC-Unique: woo16RtANbi8kbaVreuymA-1
X-Mimecast-MFC-AGG-ID: woo16RtANbi8kbaVreuymA_1744806881
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C0BDA19560B9; Wed, 16 Apr 2025 12:34:41 +0000 (UTC)
Received: from max-p1.redhat.com (unknown [10.44.22.20])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 232171800361; Wed, 16 Apr 2025 12:34:39 +0000 (UTC)
From: Maxime Coquelin <maxime.coquelin@redhat.com>
To: dev@dpdk.org,
	david.marchand@redhat.com,
	thomas@monjalon.net
Cc: Aaron Conole <aconole@redhat.com>
Subject: [PATCH 4/4] ci: check licenses
Date: Wed, 16 Apr 2025 14:34:26 +0200
Message-ID: <20250416123426.2638250-5-maxime.coquelin@redhat.com>
In-Reply-To: <20250416123426.2638250-1-maxime.coquelin@redhat.com>
References: <20250416123426.2638250-1-maxime.coquelin@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FnA_yy2sXu8XncArwIOX9xiozk3GhWXXMu2yymRPoLE_1744806881
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

From: David Marchand <david.marchand@redhat.com>

Call check-spdx.tag.sh so that all committed files are checked.

Signed-off-by: David Marchand <david.marchand@redhat.com>
Acked-by: Aaron Conole <aconole@redhat.com>
---
 .github/workflows/build.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.github/workflows/build.yml b/.github/workflows/build.yml
index 7a6b679fe5..1e289979e3 100644
--- a/.github/workflows/build.yml
+++ b/.github/workflows/build.yml
@@ -31,6 +31,7 @@ jobs:
         failed=
         devtools/check-doc-vs-code.sh upstream/${{ env.REF_GIT_BRANCH }} || failed=true
         devtools/check-meson.py || failed=true
+        devtools/check-spdx-tag.sh || failed=true
         [ -z "$failed" ]
   ubuntu-vm-builds:
     name: ${{ join(matrix.config.*, '-') }}
-- 
2.49.0

