Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC942C8303C
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Jul 2025 12:28:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BEDB14069F;
	Tue,  8 Jul 2025 14:28:58 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id DB17E4069F
 for <dev@dpdk.org>; Tue,  8 Jul 2025 14:28:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751977737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tmgV9SKsz+4rSjlCAN/dyhUOvszljr/hC46c+ZdbN2I=;
 b=Z+EMAkrDgowdp37rvnIQCzbbPhePYoD0E4fcxQlNVsHf61SEqg2ae/bC1qA4CpehrApWsf
 g7HVnNz3q1YZ5QSzJWphrkY15yJt14UmrVtZJM1BidX/uzxBSqSxwN6E5NJk2KCitvWx6z
 sJO+Kxt9i2Ywp/Qr1OoS5YiAlVW/OsQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-226-7aCvJIhPPHOBVTUeqqr5wQ-1; Tue,
 08 Jul 2025 08:28:56 -0400
X-MC-Unique: 7aCvJIhPPHOBVTUeqqr5wQ-1
X-Mimecast-MFC-AGG-ID: 7aCvJIhPPHOBVTUeqqr5wQ_1751977735
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 523E31800368; Tue,  8 Jul 2025 12:28:55 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.95])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B95B61956087; Tue,  8 Jul 2025 12:28:53 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Aaron Conole <aconole@redhat.com>,
 Michael Santana <maicolgabriel@hotmail.com>
Subject: [PATCH v3 01/18] ci: save ccache on failure
Date: Tue,  8 Jul 2025 14:28:05 +0200
Message-ID: <20250708122823.3406288-2-david.marchand@redhat.com>
In-Reply-To: <20250708122823.3406288-1-david.marchand@redhat.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250708122823.3406288-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZFa3U2VfQ3nc3pSGB2fBMQ8-4twaMyrvNzG8obiMG7k_1751977735
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

When troubleshooting unit test failures and repeating jobs in GHA,
the absence of ccache makes the whole process way slower.

Signed-off-by: David Marchand <david.marchand@redhat.com>
Acked-by: Aaron Conole <aconole@redhat.com>
---
 .github/workflows/build.yml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/.github/workflows/build.yml b/.github/workflows/build.yml
index e5f17ef6ac..6c4bc664d0 100644
--- a/.github/workflows/build.yml
+++ b/.github/workflows/build.yml
@@ -164,6 +164,12 @@ jobs:
         chmod o-w $HOME
     - name: Build and test
       run: .ci/linux-build.sh
+    - name: Save ccache on failure
+      if: failure()
+      uses: actions/cache/save@v4
+      with:
+        path: ~/.ccache
+        key: ${{ steps.get_ref_keys.outputs.ccache }}-${{ github.ref }}
     - name: Upload logs on failure
       if: failure()
       uses: actions/upload-artifact@v4
-- 
2.50.0

