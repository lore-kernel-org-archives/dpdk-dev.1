Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0CC606A33F
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Nov 2026 09:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=b+N0PFLL
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DC6C9402C4;
	Tue, 17 Nov 2026 10:22:58 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTPS id E5F38402C3
 for <dev@dpdk.org>; Tue, 17 Nov 2026 10:22:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794907377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=kEsBkUXqvHrdzGLElNhDwOhrumMMar3GWllb6RazuFo=;
 b=b+N0PFLL5Oo8eNvJZvGc3a+ZPAIWzWr0Pvys+0VLN3vnSI/iNe9+RfgOxkE3X00MKYEEg1
 X7b2WdN9kAOkuryp2yLPH1QvlGzmgZY0kHfPTGpcI2fFIDSRXDLdH568bMdTxCJzk6Qh/z
 RgLbukarmrHNHGWNmPrGuDuvwFmN+WI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-74-Ees6vmNCOWSjk-FpZ-9O-A-1; Tue,
 17 Nov 2026 04:22:53 -0500
X-MC-Unique: Ees6vmNCOWSjk-FpZ-9O-A-1
X-Mimecast-MFC-AGG-ID: Ees6vmNCOWSjk-FpZ-9O-A_1794907373
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D1A0418003FD; Tue, 17 Nov 2026 09:22:52 +0000 (UTC)
Received: from dmarchan-thinkpadx1carbongen13.rmtfr.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B2ACC1956047; Tue, 17 Nov 2026 09:22:51 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: stable@dpdk.org,
	Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH] eal/linux: skip hugetlbfs locking for in-memory
Date: Tue, 17 Nov 2026 10:22:17 +0100
Message-ID: <20261117092218.1067506-1-david.marchand@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GCrMVE0rgX2PaFYsvMgOoC6pEv0_5jMwFKhJsx7XKIw_1794907373
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When running with --in-memory, EAL uses anonymous hugepages via
memfd_create() and never needs hugetlbfs files.

However, hugepage_info_init() only skipped the mountpoint and
directory locking when no hugetlbfs mount was found.
When a mount existed, the code fell through to open and flock()
the hugepage directory regardless of --in-memory.

This causes initialization failures when EAL encounters a hugetlbfs
mount it cannot access (e.g., mounts owned by another component on
the system), even though in-memory mode does not need the mount at all.

Skip the mountpoint lookup and directory locking entirely when
--in-memory is set.
The hugepage sizes and counts are read from sysfs, which is all
that in-memory mode needs.

Fixes: 72b49ff623c4 ("mem: support --in-memory mode")
Cc: stable@dpdk.org

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 lib/eal/linux/eal_hugepage_info.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/lib/eal/linux/eal_hugepage_info.c b/lib/eal/linux/eal_hugepage_info.c
index 05c5b3f613..781eb3787b 100644
--- a/lib/eal/linux/eal_hugepage_info.c
+++ b/lib/eal/linux/eal_hugepage_info.c
@@ -480,6 +480,20 @@ hugepage_info_init(void)
 		hpi->hugepage_sz =
 			rte_str_to_size(&dirent->d_name[dirent_start_len]);
 
+#ifdef MAP_HUGE_SHIFT
+		/* if we have kernel support for reserving hugepages
+		 * through mmap, and we're in in-memory mode, treat this
+		 * page size as valid. we cannot be in legacy mode at
+		 * this point because we've checked this earlier in the
+		 * init process.
+		 */
+		if (internal_conf->in_memory) {
+			calc_num_pages(hpi, dirent, 0);
+			num_sizes++;
+			continue;
+		}
+#endif
+
 		/* first, check if we have a mountpoint */
 		if (get_hugepage_dir(hpi->hugepage_sz,
 			hpi->hugedir, sizeof(hpi->hugedir)) < 0) {
@@ -493,22 +507,6 @@ hugepage_info_init(void)
 					"%" PRIu64 " reserved, but no mounted "
 					"hugetlbfs found for that size",
 					num_pages, hpi->hugepage_sz);
-			/* if we have kernel support for reserving hugepages
-			 * through mmap, and we're in in-memory mode, treat this
-			 * page size as valid. we cannot be in legacy mode at
-			 * this point because we've checked this earlier in the
-			 * init process.
-			 */
-#ifdef MAP_HUGE_SHIFT
-			if (internal_conf->in_memory) {
-				EAL_LOG(DEBUG, "In-memory mode enabled, "
-					"hugepages of size %" PRIu64 " bytes "
-					"will be allocated anonymously",
-					hpi->hugepage_sz);
-				calc_num_pages(hpi, dirent, 0);
-				num_sizes++;
-			}
-#endif
 			continue;
 		}
 
-- 
2.56.1

