Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC82CFD3779
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Feb 2026 17:37:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 209A24027F;
	Wed, 25 Feb 2026 18:37:32 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id CA5F5400D6
 for <dev@dpdk.org>; Wed, 25 Feb 2026 18:37:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772041049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wJtJ2kpL/gBw6531rexANInTCYzZ+iXqVmswTyFuJ+M=;
 b=bBJAqIIlKNZJQdkP6pM5vMyusCuGR4pRK9xoyaiYlhD4B4sqsAd05GrHaJCA47D9QWbZol
 VG/S50WKWm0UyXThJapZSU6jphQ+X5WGWGjTO0vBdjQJYbLmpOPXhtTUaBooZtEY6UPt5z
 WMva/L6fR06j+HsQVygN8frVmjVZfsI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-257-XVjnDt7zOPy3Ynj4B9dMyw-1; Wed,
 25 Feb 2026 12:37:28 -0500
X-MC-Unique: XVjnDt7zOPy3Ynj4B9dMyw-1
X-Mimecast-MFC-AGG-ID: XVjnDt7zOPy3Ynj4B9dMyw_1772041046
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9A37E1956051; Wed, 25 Feb 2026 17:37:26 +0000 (UTC)
Received: from rh.redhat.com (unknown [10.45.226.126])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A02461800465; Wed, 25 Feb 2026 17:37:23 +0000 (UTC)
From: Kevin Traynor <ktraynor@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, david.marchand@redhat.com,
 Kevin Traynor <ktraynor@redhat.com>, stable@dpdk.org,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 David Hunt <david.hunt@intel.com>,
 Sivaprasad Tummala <sivaprasad.tummala@amd.com>
Subject: [PATCH] examples/vm_power: fix format-truncation warning
Date: Wed, 25 Feb 2026 17:36:32 +0000
Message-ID: <20260225173632.283928-1-ktraynor@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tLNIVwN02ILJycHCQOn16InEAeQVAGmsYu58sXJqvfs_1772041046
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Without libbsd-devel strlcpy is defined as rte_strlcpy and a warning is
raised for format-truncation. Observed with gcc 15.2.1.

In function ‘rte_strlcpy’,
    inlined from ‘add_host_channels’ at
../examples/vm_power_manager/channel_manager.c:600:3:
../lib/eal/include/rte_string_fns.h:63:24:
warning: ‘%s’ directive output may be truncated writing up to
4095 bytes into a region of size 108 [-Wformat-truncation=]
63 |         return (size_t)snprintf(dst, size, "%s", src);
   |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Check for truncation of socket_path[4096] into channel_path[108] to
remove warning.

Cc: stable@dpdk.org

Signed-off-by: Kevin Traynor <ktraynor@redhat.com>
---
 examples/vm_power_manager/channel_manager.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/examples/vm_power_manager/channel_manager.c b/examples/vm_power_manager/channel_manager.c
index 7d7efdd05a..b69449c61d 100644
--- a/examples/vm_power_manager/channel_manager.c
+++ b/examples/vm_power_manager/channel_manager.c
@@ -561,4 +561,5 @@ add_host_channels(void)
 	struct core_info *ci;
 	struct channel_info *chan_infos[RTE_MAX_LCORE];
+	size_t channel_path_size;
 	int i;
 
@@ -598,6 +599,13 @@ add_host_channels(void)
 		}
 		chan_infos[i] = chan_info;
-		strlcpy(chan_info->channel_path, socket_path,
-				sizeof(chan_info->channel_path));
+		channel_path_size = sizeof(chan_info->channel_path);
+		if (strlcpy(chan_info->channel_path, socket_path,
+			      channel_path_size) >= channel_path_size) {
+			RTE_LOG(ERR, CHANNEL_MANAGER, "Socket path is too long "
+				"'%s' >= %zu\n", socket_path, channel_path_size);
+			rte_free(chan_info);
+			chan_infos[i] = NULL;
+			goto error;
+		}
 
 		if (setup_host_channel_info(&chan_info, i) < 0) {
-- 
2.53.0

