Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B498FC83F1B
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Jul 2025 11:46:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C50414013F;
	Thu, 17 Jul 2025 13:46:18 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 03F61400EF
 for <dev@dpdk.org>; Thu, 17 Jul 2025 13:46:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752752776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Lm4c1BX7xHUw5MMHcDGMZZVLCGxj/7gwKWDTRSy37Ik=;
 b=T3amnDPkYzz3S/txB6mpM0tn1iYL+VwObSChZ+MwJwLYlOYzuco0xI96AEw+B9Sk1Q4tgt
 xYfjrcdTKifqaNGdo8f8lDLfr+ho6bCwTu16QvFrO56ykxz6GTMOoOXj9neQ9sIeiTwyx+
 zUJyyXnpQCTBiyHU+lX/RTQapP1Zwus=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-ZuYvA45TMWaR688Y0pc8Lg-1; Thu,
 17 Jul 2025 07:46:13 -0400
X-MC-Unique: ZuYvA45TMWaR688Y0pc8Lg-1
X-Mimecast-MFC-AGG-ID: ZuYvA45TMWaR688Y0pc8Lg_1752752772
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D0FA01956089; Thu, 17 Jul 2025 11:46:11 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.225.187])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 55F66180045B; Thu, 17 Jul 2025 11:46:09 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, bruce.richardson@intel.com, stable@dpdk.org,
 Bernard Iremonger <bernard.iremonger@intel.com>
Subject: [PATCH 1/2] doc: remove reference to device selection option
Date: Thu, 17 Jul 2025 13:46:03 +0200
Message-ID: <20250717114604.2285791-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1AnTVnhoNqEW9vz3NqpqImsWNNWdXuUffauLQuwYLgA_1752752772
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

--use-device was replaced with -a / --vdev options in v1.6
with commit cac6d08c8bde ("devargs: replace --use-device option by
--pci-whitelist and --vdev").

It was reintroduced in the doc in v1.8 when the rst documentation
was imported in .rst format.

Fixes: 1ab07743b21b ("doc: getting started guide for linux")
Fixes: dacdbfa45752 ("doc: getting started guide for freebsd")
Cc: stable@dpdk.org

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 doc/guides/freebsd_gsg/build_sample_apps.rst | 4 ----
 doc/guides/linux_gsg/build_sample_apps.rst   | 4 ----
 2 files changed, 8 deletions(-)

diff --git a/doc/guides/freebsd_gsg/build_sample_apps.rst b/doc/guides/freebsd_gsg/build_sample_apps.rst
index 1f054f2152..5212c1a0b4 100644
--- a/doc/guides/freebsd_gsg/build_sample_apps.rst
+++ b/doc/guides/freebsd_gsg/build_sample_apps.rst
@@ -70,10 +70,6 @@ DPDK application. Some of the EAL options for FreeBSD are as follows:
     Blocklisting of ports; prevent EAL from using specified PCI device
     (multiple ``-b`` options are allowed).
 
-*   ``--use-device``:
-    Use the specified Ethernet device(s) only.  Use comma-separate
-    ``[domain:]bus:devid.func`` values. Cannot be used with ``-b`` option.
-
 *   ``-v``:
     Display version information on startup.
 
diff --git a/doc/guides/linux_gsg/build_sample_apps.rst b/doc/guides/linux_gsg/build_sample_apps.rst
index f2b92187a6..aed184fc33 100644
--- a/doc/guides/linux_gsg/build_sample_apps.rst
+++ b/doc/guides/linux_gsg/build_sample_apps.rst
@@ -51,10 +51,6 @@ The EAL options are as follows:
   Blocklisting of ports; prevent EAL from using specified PCI device
   (multiple ``-b`` options are allowed).
 
-* ``--use-device``:
-  use the specified Ethernet device(s) only. Use comma-separate
-  ``[domain:]bus:devid.func`` values. Cannot be used with ``-b`` option.
-
 * ``--numa-mem``:
   Memory to allocate from hugepages on specific sockets. In dynamic memory mode,
   this memory will also be pinned (i.e. not released back to the system until
-- 
2.50.0

