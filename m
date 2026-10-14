Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 995CDCC6B2A
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 15:01:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2336740689;
	Wed, 14 Oct 2026 17:01:04 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 5CEDC40616
 for <dev@dpdk.org>; Wed, 14 Oct 2026 17:01:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791990062;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uugp5IyGQLhRNE3i9whWZBdVPMFREr95kIRmn7j7J+k=;
 b=foiZ/Mf4PIWPAkF5jQo68rSnxg/EYRoMxZwQsHmHG2ejlDHWq7dtSGrtqKMVr+O1hEQXLj
 BLzq3jFUz/uzzjm28SI4rD6qz6VDVvPaPR+xZGf7m9BQrrAaFoaGRZtWJZSwtfw0E7DLma
 q9bLdqQT7zO8KqTNSNRYxys3OAzzNtY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-628-joSMNqUxO2aGSprW0XvP1Q-1; Wed,
 14 Oct 2026 15:00:56 +0000
X-MC-Unique: joSMNqUxO2aGSprW0XvP1Q-1
X-Mimecast-MFC-AGG-ID: joSMNqUxO2aGSprW0XvP1Q_1791990055
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 44A9C1955F6F; Wed, 14 Oct 2026 15:00:55 +0000 (UTC)
Received: from max-p1.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E04BE1800495; Wed, 14 Oct 2026 15:00:53 +0000 (UTC)
From: Maxime Coquelin <maxime.coquelin@redhat.com>
To: dev@dpdk.org
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>, stable@dpdk.org,
 Kevin Traynor <ktraynor@redhat.com>
Subject: [PATCH 02/14] vhost: fix missing memory size validation before mmap
Date: Wed, 14 Oct 2026 17:00:37 +0200
Message-ID: <20261014150049.2540538-2-maxime.coquelin@redhat.com>
In-Reply-To: <20261014150049.2540538-1-maxime.coquelin@redhat.com>
References: <20261014150049.2540538-1-maxime.coquelin@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _ctsIv76PJsMa326bdVVY-2RzWFp9mKTXVgTZWrmwHA_1791990055
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

A malicious guest could send a VHOST_USER_SET_MEM_TABLE message with
a memory_size larger than the actual backing file size. The mmap()
call would succeed, but subsequent access to addresses beyond the
real file size would cause SIGBUS, crashing the DPDK host process.

Add validation to check that mmap_size does not exceed the backing
file's st_size before calling mmap().

CVE-2026-86561
Bugzilla ID: 2002

Cc: stable@dpdk.org

Acked-by: Kevin Traynor <ktraynor@redhat.com>
Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 lib/vhost/vhost_user.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/lib/vhost/vhost_user.c b/lib/vhost/vhost_user.c
index 020c993b29..ce3420ae90 100644
--- a/lib/vhost/vhost_user.c
+++ b/lib/vhost/vhost_user.c
@@ -1345,6 +1345,7 @@ vhost_user_mmap_region(struct virtio_net *dev,
 	void *mmap_addr;
 	uint64_t mmap_size;
 	uint64_t alignment;
+	struct stat file_stat;
 	int populate;
 
 	/* Check for memory_size + mmap_offset overflow */
@@ -1384,6 +1385,19 @@ vhost_user_mmap_region(struct virtio_net *dev,
 		return -1;
 	}
 
+	/* Validate mmap_size does not exceed backing file size */
+	if (fstat(region->fd, &file_stat) == -1) {
+		VHOST_CONFIG_LOG(dev->ifname, ERR,
+			"failed to get backing file size: %s", strerror(errno));
+		return -1;
+	}
+	if (mmap_size > (uint64_t)file_stat.st_size) {
+		VHOST_CONFIG_LOG(dev->ifname, ERR,
+			"mmap size (0x%" PRIx64 ") exceeds backing file size (0x%" PRIx64 ")",
+			mmap_size, (uint64_t)file_stat.st_size);
+		return -1;
+	}
+
 	populate = dev->async_copy ? MAP_POPULATE : 0;
 	mmap_addr = mmap(NULL, mmap_size, PROT_READ | PROT_WRITE,
 			MAP_SHARED | populate, region->fd, 0);
-- 
2.56.0

