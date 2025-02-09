Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22568C0219B
	for <dpdk-dev@archiver.kernel.org>; Sun,  9 Feb 2025 17:29:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7D8864065C;
	Sun,  9 Feb 2025 18:29:06 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 402314065A
 for <dev@dpdk.org>; Sun,  9 Feb 2025 18:29:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739122144;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pgGdQIfzfTGXcmt33fxUK3CQYs1OJyllsC6ileAvHyM=;
 b=ZuDwNteylEeSFykFCIVOPpZQ+FJZwFpbwSwAKZCBhiVCA4cXmqwIgR/gwY0CEvudovJaGX
 ouvygBAlqUSsEm8PpLTrDOcCdEpYNni2RKboNrwQnfiyWApwnuNu7eEvxOzcC/inQq0q1a
 I8uCz84Yrszr6y2jd3UU4MPwcmkjmdE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-534-c-WUDnuOMCqUygwKkbW5Vg-1; Sun,
 09 Feb 2025 12:29:01 -0500
X-MC-Unique: c-WUDnuOMCqUygwKkbW5Vg-1
X-Mimecast-MFC-AGG-ID: c-WUDnuOMCqUygwKkbW5Vg
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D3B1C1800873; Sun,  9 Feb 2025 17:28:59 +0000 (UTC)
Received: from dmarchan.com (unknown [10.44.32.76])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A66C71800265; Sun,  9 Feb 2025 17:28:57 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, bruce.richardson@intel.com,
 andremue@linux.microsoft.com, Parav Pandit <parav@nvidia.com>,
 Xueming Li <xuemingl@nvidia.com>
Subject: [RFC v2 01/10] bus/auxiliary: remove weak symbols
Date: Sun,  9 Feb 2025 18:28:39 +0100
Message-ID: <20250209172850.2429075-2-david.marchand@redhat.com>
In-Reply-To: <20250209172850.2429075-1-david.marchand@redhat.com>
References: <20250207083252.3131588-1-david.marchand@redhat.com>
 <20250209172850.2429075-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kZeBJaSTn0I2Bp4hrvEFYiFCvv2GS1R8tpHRA0hOi90_1739122140
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

Rather than use weak symbols, expose stubs symbols when needed.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/bus/auxiliary/auxiliary_common.c | 6 ++++--
 drivers/bus/auxiliary/meson.build        | 1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/auxiliary/auxiliary_common.c b/drivers/bus/auxiliary/auxiliary_common.c
index e6cbc4d356..b444eb43ef 100644
--- a/drivers/bus/auxiliary/auxiliary_common.c
+++ b/drivers/bus/auxiliary/auxiliary_common.c
@@ -36,12 +36,13 @@ auxiliary_devargs_lookup(const char *name)
 	return NULL;
 }
 
+#ifndef AUXILIARY_OS_SUPPORTED
 /*
  * Test whether the auxiliary device exist.
  *
  * Stub for OS not supporting auxiliary bus.
  */
-__rte_weak bool
+bool
 auxiliary_dev_exists(const char *name)
 {
 	RTE_SET_USED(name);
@@ -53,11 +54,12 @@ auxiliary_dev_exists(const char *name)
  *
  * Stub for OS not supporting auxiliary bus.
  */
-__rte_weak int
+int
 auxiliary_scan(void)
 {
 	return 0;
 }
+#endif /* AUXILIARY_OS_SUPPORTED */
 
 /*
  * Update a device's devargs being scanned.
diff --git a/drivers/bus/auxiliary/meson.build b/drivers/bus/auxiliary/meson.build
index 10468fd130..38d2f05d4b 100644
--- a/drivers/bus/auxiliary/meson.build
+++ b/drivers/bus/auxiliary/meson.build
@@ -7,6 +7,7 @@ sources = files(
         'auxiliary_params.c',
 )
 if is_linux
+    cflags += '-DAUXILIARY_OS_SUPPORTED'
     sources += files(
             'linux/auxiliary.c',
     )
-- 
2.48.1

