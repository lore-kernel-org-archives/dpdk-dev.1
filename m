Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9670C3ABBE
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 May 2025 04:42:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 98B414027C;
	Thu,  8 May 2025 06:42:46 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id A3F6C4025A
 for <dev@dpdk.org>; Thu,  8 May 2025 06:42:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746679364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/5RRMEG6ybTw7YLkSKPhbATZ9O1MIcW1ZnGX4R6wVt4=;
 b=YnfIwkN2sxqYcGCLo4F8JwNwW7f1c6hqU5lhl41gp74ibAE3fNbaSZMR/ue61rau64cq8h
 T9MRJN7J/p/Qtj02z/sdJaDq93QDZ8Pc3L+pCmVwLFaMEB9aWNf9gFuDHqT1KBKjy/KpFc
 8gekyHt23FTnirgZpxG2ouQCNiSbIl8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-326-GHJ3uzBQN1iwO3vKHcmUMA-1; Thu,
 08 May 2025 00:42:42 -0400
X-MC-Unique: GHJ3uzBQN1iwO3vKHcmUMA-1
X-Mimecast-MFC-AGG-ID: GHJ3uzBQN1iwO3vKHcmUMA_1746679359
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D7434180035E; Thu,  8 May 2025 04:42:38 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.32.22])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 175C91956055; Thu,  8 May 2025 04:42:36 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH] build: fix disabling developer mode
Date: Thu,  8 May 2025 06:42:29 +0200
Message-ID: <20250508044230.133966-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ne6LOCGwrHGLhVy2uAHwahsTrN6HJpcrcgWFYE12uN0_1746679359
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

A recent change broke disabling developer mode:
$ meson setup plop -Ddeveloper_mode=disabled
...
drivers/meson.build:150:14: ERROR: Unknown variable "fs".

Fixes: 8fa3af6c05f8 ("build: add generic support for base code in drivers")

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 meson.build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 8436d1dff8..dfb4cb3aee 100644
--- a/meson.build
+++ b/meson.build
@@ -13,10 +13,11 @@ project('DPDK', 'c',
         meson_version: '>= 0.57'
 )
 
+fs = import('fs')
+
 # check for developer mode
 developer_mode = false
 if get_option('developer_mode').auto()
-    fs = import('fs')
     developer_mode = fs.exists('.git')
 else
     developer_mode = get_option('developer_mode').enabled()
-- 
2.49.0

