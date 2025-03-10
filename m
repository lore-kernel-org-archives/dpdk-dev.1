Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EBADC282DE
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Mar 2025 10:08:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 20D2D40268;
	Mon, 10 Mar 2025 11:08:25 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 4CAC240151
 for <dev@dpdk.org>; Mon, 10 Mar 2025 11:08:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741601303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=3UKoL3KsLCpdlJrvMshJbBKMXwWHXUXleZ9fjbkqWMY=;
 b=CU2NujystwTbkmyyJR+/ExIVO8pXdA+fbPNhg1pbkATvbkvR+mmXHt3igandIXs1x10aEN
 Q+t5Q7cJL4dheIbYAvYHflsvRTL19fuC7cYr8coO3PV1rNL98kVy+yM5KLqAacH8fZ8y8i
 usam9jUu8NZAdEa4RVeDKgpTb/Oysj0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-151-ngwUfnB1Mb2xC6dJmW7IpQ-1; Mon,
 10 Mar 2025 06:08:20 -0400
X-MC-Unique: ngwUfnB1Mb2xC6dJmW7IpQ-1
X-Mimecast-MFC-AGG-ID: ngwUfnB1Mb2xC6dJmW7IpQ_1741601297
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 49BBD1801A1A; Mon, 10 Mar 2025 10:08:17 +0000 (UTC)
Received: from rh.redhat.com (unknown [10.45.226.117])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 968CB1956094; Mon, 10 Mar 2025 10:08:15 +0000 (UTC)
From: Kevin Traynor <ktraynor@redhat.com>
To: dev@dpdk.org
Cc: Kevin Traynor <ktraynor@redhat.com>,
	stable@dpdk.org
Subject: [PATCH] doc: fix year of final LTS release
Date: Mon, 10 Mar 2025 10:08:07 +0000
Message-ID: <20250310100807.17559-1-ktraynor@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1iH0q0N00wbyapfaB06IbwX0lL8SIcZp4cfk5CxDdUY_1741601297
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

LTS length was updated to 3 years, but a sentence saying
when the final release would be was not updated.

Fixes: 3c60ea7b289a ("doc: update LTS maintenance to 3 years")
Cc: stable@dpdk.org

Signed-off-by: Kevin Traynor <ktraynor@redhat.com>
---
 doc/guides/contributing/stable.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/guides/contributing/stable.rst b/doc/guides/contributing/stable.rst
index 289769a61d..808e7fa779 100644
--- a/doc/guides/contributing/stable.rst
+++ b/doc/guides/contributing/stable.rst
@@ -74,5 +74,5 @@ For a list of the currently maintained stable/LTS branches please see
 the latest `stable roadmap <https://core.dpdk.org/roadmap/#stable>`_.
 
-At the end of the 2 years, a final X.11.N release will be made and at that
+At the end of the 3 years, a final X.11.N release will be made and at that
 point the LTS branch will no longer be maintained with no further releases.
 
-- 
2.48.1

