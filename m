Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E471C021AA
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Feb 2025 15:37:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 87EB340611;
	Tue, 18 Feb 2025 16:37:47 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 2B6774060C
 for <dev@dpdk.org>; Tue, 18 Feb 2025 16:37:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739893065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pgGdQIfzfTGXcmt33fxUK3CQYs1OJyllsC6ileAvHyM=;
 b=UuQPVQmrBJU1TfgPk1Sg4b5B1wdUzdM0TJ5PCTO+YeQI+BMlD1r0pabuygDY2xFcei/mGP
 PM55oJG6hbDNX00ZzGq9SW1go8d6tiApn8GmByy/T5D/eTOh+Y0LQBhTNKvuOmYLOt4fbI
 Wb99PptyvD3fp5wBL4Owmy6Tqb02veE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-214-5qnFeGQ7MSGRJOSVFJmpbg-1; Tue,
 18 Feb 2025 10:37:41 -0500
X-MC-Unique: 5qnFeGQ7MSGRJOSVFJmpbg-1
X-Mimecast-MFC-AGG-ID: 5qnFeGQ7MSGRJOSVFJmpbg_1739893060
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 59B7019039C8; Tue, 18 Feb 2025 15:37:40 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.32.171])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E875C180056F; Tue, 18 Feb 2025 15:37:37 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, bruce.richardson@intel.com,
 andremue@linux.microsoft.com, Parav Pandit <parav@nvidia.com>,
 Xueming Li <xuemingl@nvidia.com>
Subject: [PATCH v3 01/10] bus/auxiliary: remove weak symbols
Date: Tue, 18 Feb 2025 16:37:15 +0100
Message-ID: <20250218153730.773836-2-david.marchand@redhat.com>
In-Reply-To: <20250218153730.773836-1-david.marchand@redhat.com>
References: <20250207083252.3131588-1-david.marchand@redhat.com>
 <20250218153730.773836-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SxhRxUhPNfFGTMlvTN9u2e_VMQrql5-EaUgE5JzMSQ4_1739893060
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

