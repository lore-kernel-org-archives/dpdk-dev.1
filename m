Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB14C44500
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Jul 2026 11:56:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CEB1740264;
	Tue,  7 Jul 2026 13:56:01 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 0287B4025F
 for <dev@dpdk.org>; Tue,  7 Jul 2026 13:56:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783425360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wzeoWmn5pDFx9b7GbdwnLSyKHKoE8W5x/ETZlHFQlUA=;
 b=f0p5YWeCv2lamRLdNp2ZpYRQINc5QJ5jrEMJwbhHQbLx2cB+I7iPQownJNyaaz8Lu7e8B5
 0dvbNhcgaCmKQyQLsdf/aWhAxPyBHai0HgxxQyYMoR0VwXjXyEEIFQDx3FOvHlIRhK/SsI
 sSe8HEr+FvJjMCCpkB/CkgXeasvt2C4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-99-4yvCq0-0PzS1w8mdFGeVJg-1; Tue,
 07 Jul 2026 07:55:57 -0400
X-MC-Unique: 4yvCq0-0PzS1w8mdFGeVJg-1
X-Mimecast-MFC-AGG-ID: 4yvCq0-0PzS1w8mdFGeVJg_1783425356
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 323811955D4A; Tue,  7 Jul 2026 11:55:56 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.48.202])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EC5D436924; Tue,  7 Jul 2026 11:55:54 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: fengchengwen@huawei.com
Subject: [PATCH v2] dev: fix hotplug notification to secondary
Date: Tue,  7 Jul 2026 13:55:50 +0200
Message-ID: <20260707115551.967336-1-david.marchand@redhat.com>
In-Reply-To: <20260706145510.680077-1-david.marchand@redhat.com>
References: <20260706145510.680077-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4CLxXDP2yiQD8N8zEHwLpGNuvcVT71IihihM2DYQH7g_1783425356
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

There was a logical error when making some last minute change.
Fix the no_shconf evaluation.

Bugzilla ID: 1963
Fixes: 1a2e26d8701d ("dev: skip multi-process in hotplug")

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
Changes since v1:
- separated the unit test from the fix,

---
 lib/eal/common/eal_common_dev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/eal/common/eal_common_dev.c b/lib/eal/common/eal_common_dev.c
index 9ed62a20e0..b43b0a4bb3 100644
--- a/lib/eal/common/eal_common_dev.c
+++ b/lib/eal/common/eal_common_dev.c
@@ -269,7 +269,7 @@ rte_dev_probe(const char *devargs)
 {
 	const struct internal_config *internal_conf =
 		eal_get_internal_configuration();
-	bool do_mp = !!internal_conf->no_shconf;
+	bool do_mp = internal_conf->no_shconf == 0;
 	struct eal_dev_mp_req req;
 	struct rte_device *dev;
 	int ret;
@@ -428,7 +428,7 @@ rte_dev_remove(struct rte_device *dev)
 {
 	const struct internal_config *internal_conf =
 		eal_get_internal_configuration();
-	bool do_mp = !!internal_conf->no_shconf;
+	bool do_mp = internal_conf->no_shconf == 0;
 	struct eal_dev_mp_req req;
 	char *devargs;
 	int ret;
-- 
2.54.0

