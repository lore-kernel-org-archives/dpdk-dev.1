Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA803C021B8
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Mar 2025 15:50:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BF0864029A;
	Tue,  4 Mar 2025 16:50:52 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 6094940287
 for <dev@dpdk.org>; Tue,  4 Mar 2025 16:50:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741103450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qfR0wqq4azT8YsTfpew1VYXh6WVjQGcQ/2bYRWWOqR8=;
 b=bWSGBWgKWodpfls5AcsGKtyQs3iXeUK71om15qz55/eFJ+rsk+u/jb9pzI9+5Lm3XSOY6d
 BRuK8ZIsX51kvQlHUz003loL+9s4TXdEHZmoX6ufiHED7OsY/mZaHrzmnxPpFCWQdf5J6V
 gbY9SH2yWaEx9fTRbJPePlWkVLYa6zE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-92-vutPLzNVMCewQRn5T1owzg-1; Tue,
 04 Mar 2025 10:50:42 -0500
X-MC-Unique: vutPLzNVMCewQRn5T1owzg-1
X-Mimecast-MFC-AGG-ID: vutPLzNVMCewQRn5T1owzg_1741103441
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3C2DB1801A3B; Tue,  4 Mar 2025 15:50:41 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.224.74])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7F88C1800359; Tue,  4 Mar 2025 15:50:39 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: stable@dpdk.org, Aaron Conole <aconole@redhat.com>,
 Michael Santana <maicolgabriel@hotmail.com>
Subject: [PATCH] ci: point at GitHub mirror.
Date: Tue,  4 Mar 2025 16:50:36 +0100
Message-ID: <20250304155036.383468-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -cgxasfP4Um05aLDmKHUZjs4ug6TG8_XfGinHH3j6SE_1741103441
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

We face some random failures accessing dpdk.org git when running GHA.
Point at GitHub hosted mirror.

Cc: stable@dpdk.org

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 .github/workflows/build.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.github/workflows/build.yml b/.github/workflows/build.yml
index 183b0b1999..e98a60a852 100644
--- a/.github/workflows/build.yml
+++ b/.github/workflows/build.yml
@@ -11,7 +11,7 @@ defaults:
 
 env:
   REF_GIT_BRANCH: main
-  REF_GIT_REPO: https://dpdk.org/git/dpdk
+  REF_GIT_REPO: https://github.com/DPDK/dpdk
   REF_GIT_TAG: v24.11
 
 jobs:
-- 
2.48.1

