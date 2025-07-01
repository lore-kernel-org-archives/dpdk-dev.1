Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8455DC7EE30
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Jul 2025 11:33:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 58EA0402A5;
	Tue,  1 Jul 2025 13:33:33 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 056D5400D7
 for <dev@dpdk.org>; Tue,  1 Jul 2025 13:33:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751369611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7ypxdRNNsMWHT4NPfQnqOgUgFCIalQpxk8tWGbWZoDk=;
 b=d3pDaMw/fvgqO4FsNhrmLK8jtp6CDBFEPEwoI4dJq6DVcKmVQD9/IZ7UPwX9of/QTtdrv9
 Ln1UFRsXvArr728GcHx49T2wMZXYK/Abuigpq8kzTEl9QxLsP98Wmk3BYCykXw/vcGW3KW
 XmFT98VdOncBDtVf9NHyyogH1ghihtk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-373-e2iXapKYPS-mbo-aZmY9Og-1; Tue,
 01 Jul 2025 07:31:54 -0400
X-MC-Unique: e2iXapKYPS-mbo-aZmY9Og-1
X-Mimecast-MFC-AGG-ID: e2iXapKYPS-mbo-aZmY9Og_1751369513
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B2F8E18002ED; Tue,  1 Jul 2025 11:31:52 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.143])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 07E35195608F; Tue,  1 Jul 2025 11:31:50 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, Aaron Conole <aconole@redhat.com>,
 Michael Santana <maicolgabriel@hotmail.com>
Subject: [PATCH] ci: check C++ headers with clang
Date: Tue,  1 Jul 2025 13:31:46 +0200
Message-ID: <20250701113146.1268492-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UzhakElBZjbxxh5_h1jyIFKd2l3IEgaV_9p6i0L2chU_1751369513
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
Depends-on: series-35592 ("node: fix C++ compatibility errors (option 2)")

---
 .ci/linux-build.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/.ci/linux-build.sh b/.ci/linux-build.sh
index e9272d3931..6156fc0e80 100755
--- a/.ci/linux-build.sh
+++ b/.ci/linux-build.sh
@@ -54,6 +54,12 @@ check_traces() {
 
 cross_file=
 
+if [ "${CC%%clang}" != "$CC" ]; then
+    export CXX=clang++
+else
+    export CXX=g++
+fi
+
 if [ "$AARCH64" = "true" ]; then
     if [ "${CC%%clang}" != "$CC" ]; then
         cross_file=config/arm/arm64_armv8_linux_clang_ubuntu
-- 
2.49.0

