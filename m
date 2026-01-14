Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D9AD37E4E
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 15:35:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DA51B40693;
	Wed, 14 Jan 2026 16:35:06 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id F149340684
 for <dev@dpdk.org>; Wed, 14 Jan 2026 16:35:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768404904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=omBz/siGG0PmrZAkWdInPTAFsiN/SzZy+KLjsvqVTuA=;
 b=Uthjo2drS1ZC2BtosKg2oavMxaceEgaSP8BRVrxpC9M0HsqrXQBvnvzVuYecheYfIuiDOC
 JPyFeVTh71JT2eqAiXcVsq5XWTSoY1DpbDV3TCAMuccQlriB5fUpx4xUUeet9tRnwoNHxA
 P1FPo1vNsnVusCvEgcYfamxSIoUfdvw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-yNVnUoq4N1aSYPqKl_zB3w-1; Wed,
 14 Jan 2026 10:35:01 -0500
X-MC-Unique: yNVnUoq4N1aSYPqKl_zB3w-1
X-Mimecast-MFC-AGG-ID: yNVnUoq4N1aSYPqKl_zB3w_1768404900
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6277019560A3; Wed, 14 Jan 2026 15:35:00 +0000 (UTC)
Received: from max-p1.redhat.com (unknown [10.45.242.30])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 049191800240; Wed, 14 Jan 2026 15:34:57 +0000 (UTC)
From: Maxime Coquelin <maxime.coquelin@redhat.com>
To: dev@dpdk.org,
	chenbox@nvidia.com,
	david.marchand@redhat.com
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>,
	stable@dpdk.org
Subject: [PATCH v2 3/3] vhost: fix mmap error check in VDUSE IOTLB miss handler
Date: Wed, 14 Jan 2026 16:34:45 +0100
Message-ID: <20260114153445.2751895-4-maxime.coquelin@redhat.com>
In-Reply-To: <20260114153445.2751895-1-maxime.coquelin@redhat.com>
References: <20260114153445.2751895-1-maxime.coquelin@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: eZt1bbbtoG0pTjR_NNa88iB8ccMHVsXKAShUALdLdcw_1768404900
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

The mmap() function returns MAP_FAILED on failure, not NULL.
The current check for !mmap_addr will never detect mmap failures.

When mmap fails but the error is not detected, an invalid address (-1)
is inserted into the IOTLB cache via vhost_user_iotlb_cache_insert().
Subsequent attempts to access this address will cause memory
corruption or crash.

Fix by checking for MAP_FAILED instead of NULL. Also add strerror to
the error message for easier debugging.

Fixes: f27d5206c598 ("vhost: add VDUSE callback for IOTLB miss")
Cc: stable@dpdk.org

Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
Reviewed-by: David Marchand <david.marchand@redhat.com>
---
 lib/vhost/vduse.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/vhost/vduse.c b/lib/vhost/vduse.c
index 897dee9f1b..0b5d158fee 100644
--- a/lib/vhost/vduse.c
+++ b/lib/vhost/vduse.c
@@ -86,9 +86,10 @@ vduse_iotlb_miss(struct virtio_net *dev, uint64_t iova, uint8_t perm __rte_unuse
 
 	size = entry.last - entry.start + 1;
 	mmap_addr = mmap(0, size + entry.offset, entry.perm, MAP_SHARED, fd, 0);
-	if (!mmap_addr) {
+	if (mmap_addr == MAP_FAILED) {
 		VHOST_CONFIG_LOG(dev->ifname, ERR,
-				"Failed to mmap IOTLB entry for 0x%" PRIx64, iova);
+				"Failed to mmap IOTLB entry for 0x%" PRIx64 ": %s",
+				iova, strerror(errno));
 		ret = -1;
 		goto close_fd;
 	}
-- 
2.52.0

