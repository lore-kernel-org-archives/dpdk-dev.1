Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B55DCAC5B5
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Sep 2025 11:32:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 074894068A;
	Mon, 29 Sep 2025 13:32:26 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 86F8340668
 for <dev@dpdk.org>; Mon, 29 Sep 2025 13:32:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759145544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=dGHA9dc+Vs+dvj3hp2SkLYEe5XAQ9RuB4UtF6LqcBnQ=;
 b=MqDiyoP+Q1sNzRim0Avsd3uv3L6GWzOXspbqLHrOf4Y8wRqCAobjRD/FOaiiFUdJreesq1
 AD3r2GvQB/LUWB2r1ra9CBq2y42LEBTWjzASRZsARdZGoFQimHaVFbt16xyNUOes0GfnX3
 H2bfUdSmw6kRT2sgzcalE/R7lk47rjo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-484-tJoW7htjPDyj9i6-JIeWKg-1; Mon,
 29 Sep 2025 07:32:20 -0400
X-MC-Unique: tJoW7htjPDyj9i6-JIeWKg-1
X-Mimecast-MFC-AGG-ID: tJoW7htjPDyj9i6-JIeWKg_1759145539
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 34E8B18002C3; Mon, 29 Sep 2025 11:32:19 +0000 (UTC)
Received: from rh.redhat.com (unknown [10.45.224.59])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 25B7730001A4; Mon, 29 Sep 2025 11:32:15 +0000 (UTC)
From: Kevin Traynor <ktraynor@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, Kevin Traynor <ktraynor@redhat.com>, stable@dpdk.org,
 Andre Muezerie <andremue@linux.microsoft.com>,
 Ali Alnubani <alialnu@nvidia.com>
Subject: [PATCH] docs: fix Nvidia bifurcated driver presentation link
Date: Mon, 29 Sep 2025 12:31:10 +0100
Message-ID: <20250929113110.50545-1-ktraynor@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cwQbPhAp1ZNEsk63k224KgUm3AQhY5LbNGuYU5hy8jA_1759145539
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

Fix link for Nvidia bifurcated DPDK PMD presentation.

Bugzilla ID: 1793
Fixes: d052a9a7d5f9 ("doc: fix link about bifurcated model in Linux guide")
Cc: stable@dpdk.org

Reported-by: Andre Muezerie <andremue@linux.microsoft.com>
Signed-off-by: Kevin Traynor <ktraynor@redhat.com>
---

Not clear if link became stale or was incorrect in first place, but
adding tags for backport.
---
 doc/guides/linux_gsg/linux_drivers.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/guides/linux_gsg/linux_drivers.rst b/doc/guides/linux_gsg/linux_drivers.rst
index 039823d61e..739fc0226c 100644
--- a/doc/guides/linux_gsg/linux_drivers.rst
+++ b/doc/guides/linux_gsg/linux_drivers.rst
@@ -385,5 +385,5 @@ Such model has the following benefits:
 More about the bifurcated driver can be found in
 NVIDIA `bifurcated PMD
-<https://www.dpdk.org/wp-content/uploads/sites/35/2016/10/Day02-Session04-RonyEfraim-Userspace2016.pdf>`_ presentation.
+<https://www.dpdk.org/wp-content/uploads/sites/23/2016/10/Day02-Session04-RonyEfraim-Userspace2016.pdf>`_ presentation.
 
 .. _uio:
-- 
2.51.0

