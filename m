Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21185C5B552
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Jun 2025 08:36:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0BDFC41109;
	Tue, 10 Jun 2025 10:36:56 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 4B6B540292
 for <dev@dpdk.org>; Tue, 10 Jun 2025 10:36:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749544613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=a51gaSl3NICYYMM1ohLT6RMEmnoRgLpoBoxSBpaxRF8=;
 b=iCTF2xHheW0mC3TtMrEjgRJ9b4mWAMAGkB5cKIPY3Fgoi14Pp80smLK9yNmuVzx2n0UnAg
 A2ZEVGvQA5ttQI3csrloFl6Cg+eIUd+gmrAvP7TEVHf7RT1lkuYITUVDX8o37+N58XiHoP
 2WjENtbvZwWUVVQb4U9aDaz2NfiEPPk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-450-XNZhiEC8NiGdO3GHR7mW7g-1; Tue,
 10 Jun 2025 04:36:50 -0400
X-MC-Unique: XNZhiEC8NiGdO3GHR7mW7g-1
X-Mimecast-MFC-AGG-ID: XNZhiEC8NiGdO3GHR7mW7g_1749544609
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D86D219560B2; Tue, 10 Jun 2025 08:36:48 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.8])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F10D8195608D; Tue, 10 Jun 2025 08:36:46 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, Aaron Conole <aconole@redhat.com>,
 Michael Santana <maicolgabriel@hotmail.com>
Subject: [PATCH 1/2] ci: treat warning as error for MSVC builds in GHA
Date: Tue, 10 Jun 2025 10:36:41 +0200
Message-ID: <20250610083643.8466-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qk8ohyYUT6t-bnW-UOXtG5gUKpI8NpgGgl_fPRvkDM8_1749544609
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

Some trivial builds warnings with MSVC were missed as those were not
treated as errors.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 .github/workflows/build.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.github/workflows/build.yml b/.github/workflows/build.yml
index 1e289979e3..e5f17ef6ac 100644
--- a/.github/workflows/build.yml
+++ b/.github/workflows/build.yml
@@ -198,7 +198,7 @@ jobs:
       shell: cmd
       run: |
         call "C:\Program Files\Microsoft Visual Studio\2022\Enterprise\Common7\Tools\VsDevCmd.bat" -host_arch=amd64 -arch=amd64
-        meson setup -Denable_stdatomic=true build
+        meson setup -Denable_stdatomic=true -Dwerror=true build
     - name: Build
       shell: cmd
       run: |
-- 
2.49.0

