Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6239ECD98D2
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 09:46:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B3DEC42F89;
	Thu, 11 Jun 2026 11:46:18 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id D1A8642F87
 for <dev@dpdk.org>; Thu, 11 Jun 2026 11:46:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781171176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+cPfgtHxaBYC6H+spw5W7jIGLtRqzBR786iDIuqZTbY=;
 b=S1hPc1N/6BQllAJZc5ghxxLYktLxUpsQlQ2joqi00QVMlSXkkrgzgIXELRYUzpRtVY7XZK
 2lQAjkAc85uxQ8hZe/aZXNtOi0BAdTYRbEfudh8w9y3/Rr6pJ1IUDzi0snIpCAubuRNisJ
 NorwYbDCNANmm3gRbeNsZhIXGbknRVw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-nICwqyo8NUy4B-B7JGxE1Q-1; Thu,
 11 Jun 2026 05:46:10 -0400
X-MC-Unique: nICwqyo8NUy4B-B7JGxE1Q-1
X-Mimecast-MFC-AGG-ID: nICwqyo8NUy4B-B7JGxE1Q_1781171169
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 335DD18D97D9; Thu, 11 Jun 2026 09:46:09 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.28])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F39E236917; Thu, 11 Jun 2026 09:46:06 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, stephen@networkplumber.org,
 bruce.richardson@intel.com, fengchengwen@huawei.com
Subject: [PATCH 01/13] bus: fix reference to plug callback
Date: Thu, 11 Jun 2026 11:45:38 +0200
Message-ID: <20260611094551.1514962-2-david.marchand@redhat.com>
In-Reply-To: <20260611094551.1514962-1-david.marchand@redhat.com>
References: <20260611094551.1514962-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OS__8oqEANV1nxTYNIi7TWNKBmd2SMdeQfPfhZUSsuU_1781171169
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

Update documentation and some log following the callback rename.

Fixes: 76622feba9e6 ("bus: refactor device probe")

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 doc/guides/prog_guide/device_hotplug.rst | 2 +-
 lib/eal/common/eal_common_dev.c          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/guides/prog_guide/device_hotplug.rst b/doc/guides/prog_guide/device_hotplug.rst
index 9896a097f3..7eb7fbcc2b 100644
--- a/doc/guides/prog_guide/device_hotplug.rst
+++ b/doc/guides/prog_guide/device_hotplug.rst
@@ -234,7 +234,7 @@ When ``rte_dev_probe()`` is called, the following sequence occurs:
    and the attach operation fails if the device is not found.
 
 #. **Device Probe**:
-   The bus's ``plug()`` method is called, which triggers the device driver's probe function.
+   The bus's ``probe_device()`` method is called, which triggers the device driver's probe function.
    The probe function typically allocates device-specific resources,
    maps device memory regions, initializes device hardware,
    and registers the device with the appropriate subsystem (e.g., ethdev for network devices).
diff --git a/lib/eal/common/eal_common_dev.c b/lib/eal/common/eal_common_dev.c
index 48b631532a..2a2103ec57 100644
--- a/lib/eal/common/eal_common_dev.c
+++ b/lib/eal/common/eal_common_dev.c
@@ -193,7 +193,7 @@ local_dev_probe(const char *devargs, struct rte_device **new_dev)
 		goto err_devarg;
 
 	if (da->bus->probe_device == NULL) {
-		EAL_LOG(ERR, "Function plug not supported by bus (%s)",
+		EAL_LOG(ERR, "Function probe_device not supported by bus (%s)",
 			da->bus->name);
 		ret = -ENOTSUP;
 		goto err_devarg;
-- 
2.53.0

