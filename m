Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 543A0CC6B1D
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 15:01:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B906840A8B;
	Wed, 14 Oct 2026 17:01:09 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 52C82406FF
 for <dev@dpdk.org>; Wed, 14 Oct 2026 17:01:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791990066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QhQGXNAf+K2G61z/CiTWBGYsooC4xNWUstdF+0wiRY0=;
 b=MVT5pLMAyOWjYTJEwUww8ySRTAyPoa4hHQ1zVlDV4s/1cWNfMU9drTXsZ+ljbFNmT+nWow
 or4/hyZ9csuVnd0jK+WPak+4E65hOAwlcEd8izdbM3Q7nr2syHews0GKdFt3eLCTgqLHAH
 qEy3RbYKKeHqe0XFVlVq1thb2WgBcfo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-696-DKulhxzxNj2EjKVXUvqSjw-1; Wed,
 14 Oct 2026 15:00:59 +0000
X-MC-Unique: DKulhxzxNj2EjKVXUvqSjw-1
X-Mimecast-MFC-AGG-ID: DKulhxzxNj2EjKVXUvqSjw_1791990058
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7FC4B19560B6; Wed, 14 Oct 2026 15:00:58 +0000 (UTC)
Received: from max-p1.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 385961800446; Wed, 14 Oct 2026 15:00:57 +0000 (UTC)
From: Maxime Coquelin <maxime.coquelin@redhat.com>
To: dev@dpdk.org
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>, stable@dpdk.org,
 Ivar Al-Safawi <hemo40047@gmail.com>, Kevin Traynor <ktraynor@redhat.com>
Subject: [PATCH 04/14] vhost: fix log base address mapping offset
Date: Wed, 14 Oct 2026 17:00:39 +0200
Message-ID: <20261014150049.2540538-4-maxime.coquelin@redhat.com>
In-Reply-To: <20261014150049.2540538-1-maxime.coquelin@redhat.com>
References: <20261014150049.2540538-1-maxime.coquelin@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AH6GQuFR3yeC1e9jQFZD4ZDBEtfezx9_INkLmBB0qS0_1791990058
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

Fix out-of-bounds write vulnerability caused by double-application of
mmap_offset in vhost_user_set_log_base(). The offset was used both as
a file offset in mmap() and then added again to compute log_base,
causing log_base to point beyond the mapped memory region.

Map the full region (size + offset) at file offset 0, matching the
correct pattern used in vhost_user_mmap_region(). Update munmap calls
to use the actual mapped size.

Fixes: bdd96d8ac76c ("vhost: fix offset while mapping log base address")

Bugzilla ID: 2004
CVE-2026-86563

Cc: stable@dpdk.org

Reported-by: Ivar Al-Safawi <hemo40047@gmail.com>
Acked-by: Kevin Traynor <ktraynor@redhat.com>
Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 lib/vhost/vhost_user.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/lib/vhost/vhost_user.c b/lib/vhost/vhost_user.c
index ce3420ae90..018adfe4b2 100644
--- a/lib/vhost/vhost_user.c
+++ b/lib/vhost/vhost_user.c
@@ -296,7 +296,8 @@ vhost_backend_cleanup(struct virtio_net *dev)
 	dev->guest_pages = NULL;
 
 	if (dev->log_addr) {
-		munmap((void *)(uintptr_t)dev->log_addr, dev->log_size);
+		munmap((void *)(uintptr_t)dev->log_addr,
+		       dev->log_size + dev->log_base - dev->log_addr);
 		dev->log_addr = 0;
 	}
 
@@ -2726,7 +2727,7 @@ vhost_user_set_log_base(struct virtio_net **pdev,
 	 * mmap from 0 to workaround a hugepage mmap bug: mmap will
 	 * fail when offset is not page size aligned.
 	 */
-	addr = mmap(0, size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, off);
+	addr = mmap(0, size + off, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
 	alignment = get_blk_size(fd);
 	close(fd);
 	if (addr == MAP_FAILED) {
@@ -2739,7 +2740,8 @@ vhost_user_set_log_base(struct virtio_net **pdev,
 	 * multiple VHOST_USER_SET_LOG_BASE.
 	 */
 	if (dev->log_addr) {
-		munmap((void *)(uintptr_t)dev->log_addr, dev->log_size);
+		munmap((void *)(uintptr_t)dev->log_addr,
+		       dev->log_size + dev->log_base - dev->log_addr);
 	}
 	dev->log_addr = (uint64_t)(uintptr_t)addr;
 	dev->log_base = dev->log_addr + off;
-- 
2.56.0

