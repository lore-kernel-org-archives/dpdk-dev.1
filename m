Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8919C71135
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Jun 2025 08:10:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9478E42E7B;
	Fri, 13 Jun 2025 10:10:41 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 0E7B0402E2
 for <dev@dpdk.org>; Fri, 13 Jun 2025 10:10:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749802239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=UDo2hfMW4Z5PD0E2xDIwt31+590sQaUljYACJ0JKn5M=;
 b=S3IOhYEUxT/Cpo0DY8upOxyRFw8dclq8DhR3ZqHusjP352BHRG8B5XpM2MnFHZ8aFxTaEt
 jIEEt3G3r7EfsWGZf1XU/5kvj8682kyYbQ9NuOOCJBSjVdS6eOJ5GBBis5LjCSyiTAzT5t
 UO8+YKnbPgsO56ZAgyvLN4BnBr0CqqM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-GNJUSmDqNB2x9RDx9alV1w-1; Fri,
 13 Jun 2025 04:10:35 -0400
X-MC-Unique: GNJUSmDqNB2x9RDx9alV1w-1
X-Mimecast-MFC-AGG-ID: GNJUSmDqNB2x9RDx9alV1w_1749802233
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 340681955F57; Fri, 13 Jun 2025 08:10:33 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.8])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 10DE630044CC; Fri, 13 Jun 2025 08:10:28 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: probb@iol.unh.edu, andremue@linux.microsoft.com,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 Thomas Monjalon <thomas@monjalon.net>, Tal Shnaiderman <talshn@nvidia.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [PATCH] common/mlx5: fix dependency detection on Windows
Date: Fri, 13 Jun 2025 10:10:18 +0200
Message-ID: <20250613081018.2790825-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PxD8VQFtl8IzbNTOXNVH2NxkwkIpN1J8orJ260GSkVs_1749802233
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

Don't *require* mlx5dev library when testing its presence.

Fixes: 85c51a4ffab8 ("common/mlx5: get Windows dependency from standard variables")

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/common/mlx5/windows/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/common/mlx5/windows/meson.build b/drivers/common/mlx5/windows/meson.build
index f60daed840..c3bd3aac26 100644
--- a/drivers/common/mlx5/windows/meson.build
+++ b/drivers/common/mlx5/windows/meson.build
@@ -7,7 +7,7 @@ if not cc.has_header('mlx5devx.h')
     subdir_done()
 endif
 
-devxlib = cc.find_library('mlx5devx', required: true)
+devxlib = cc.find_library('mlx5devx', required: false)
 if not devxlib.found()
     build = false
     reason = 'missing dependency, "mlx5devx"'
-- 
2.49.0

