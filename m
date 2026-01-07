Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E0D6D0D176
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Jan 2026 21:51:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 520B64028B;
	Wed,  7 Jan 2026 22:51:51 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 17DD64021E
 for <dev@dpdk.org>; Wed,  7 Jan 2026 22:51:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767822709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=rllG9p6pOuWagpHVQXJ8bLEhCxj5eO6fm7rgabi8RV8=;
 b=Eisrpolpfbzuk6z/ai+eZTGXHihO+qrdAIse7h2dtoSXkfFjyCrKCoijo3sIUoi1R9gbdm
 Caa8/I9JIDOTaVK6/bMTg++TOclm8ohR9suMQXnzFmphOHSfHNq+pnJUndaT5xGpDhcoLg
 biDewz/VpYaohiSCMIpuKru2q8j/rfo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-139-S7ft6VXYPDyRtZJ-rN56og-1; Wed,
 07 Jan 2026 16:51:45 -0500
X-MC-Unique: S7ft6VXYPDyRtZJ-rN56og-1
X-Mimecast-MFC-AGG-ID: S7ft6VXYPDyRtZJ-rN56og_1767822705
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DAD871956094; Wed,  7 Jan 2026 21:51:44 +0000 (UTC)
Received: from ringo.redhat.com (unknown [10.44.32.43])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 175EF1800109; Wed,  7 Jan 2026 21:51:42 +0000 (UTC)
From: Robin Jarry <rjarry@redhat.com>
To: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Ciara Power <ciara.power@intel.com>
Subject: [PATCH dpdk] telemetry: fix adding dicts in container arrays
Date: Wed,  7 Jan 2026 22:51:30 +0100
Message-ID: <20260107215129.1329960-2-rjarry@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5-dkoukQumR8owcSpD08LFQZ6lhiF0I18yAzwfe1L0c_1767822705
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

Currently, adding TEL_DICT containers in TEL_ARRAY_CONTAINER containers
is not supported by rte_tel_data_add_array_container. It wrongfully
returns -EINVAL where it should allow it.

This is supported by the JSON formatter.

Allow the same value types than rte_tel_data_add_dict_container().

Fixes: c933bb5177ca ("telemetry: support array values in data object")

Signed-off-by: Robin Jarry <rjarry@redhat.com>
---
 lib/telemetry/telemetry_data.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/telemetry/telemetry_data.c b/lib/telemetry/telemetry_data.c
index 0354a0654804..0a006559ab42 100644
--- a/lib/telemetry/telemetry_data.c
+++ b/lib/telemetry/telemetry_data.c
@@ -96,10 +96,10 @@ int
 rte_tel_data_add_array_container(struct rte_tel_data *d,
 		struct rte_tel_data *val, int keep)
 {
-	if (d->type != TEL_ARRAY_CONTAINER ||
-			(val->type != TEL_ARRAY_UINT
+	if (d->type != TEL_ARRAY_CONTAINER || (val->type != TEL_ARRAY_UINT
 			&& val->type != TEL_ARRAY_INT
-			&& val->type != TEL_ARRAY_STRING))
+			&& val->type != TEL_ARRAY_STRING
+			&& val->type != TEL_DICT))
 		return -EINVAL;
 	if (d->data_len >= RTE_TEL_MAX_ARRAY_ENTRIES)
 		return -ENOSPC;
-- 
2.52.0

