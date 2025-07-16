Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0932EC83F22
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Jul 2025 13:05:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6297040A6F;
	Wed, 16 Jul 2025 15:04:05 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 3A4D740A82
 for <dev@dpdk.org>; Wed, 16 Jul 2025 15:04:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752671043;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tdQ3WYSTQYPC6JhLyZFU/1ajHFozU3ndLd4Gyj5iTpg=;
 b=dt8dcECqhLVcYMR8XfqHptoOqALaiawkc1qhAk9gpHe5Rd7ps2KmttTLgRSLNB7GGxqErz
 Lt769dX8Ee1fz/0+FVjJg2j9rrsY8lT8g7J3wBynprvf06fp1BIOOCpLmc6KO1+2/JBMvr
 a2S4sC8ZVOvz7bmBjyGjM0OrUwwaq1E=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-134-xbGfiTlZM5ix1foJawIgzA-1; Wed,
 16 Jul 2025 09:04:02 -0400
X-MC-Unique: xbGfiTlZM5ix1foJawIgzA-1
X-Mimecast-MFC-AGG-ID: xbGfiTlZM5ix1foJawIgzA_1752671041
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 86B8D19560BF; Wed, 16 Jul 2025 13:04:01 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.225.235])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EE5A51954213; Wed, 16 Jul 2025 13:03:59 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Allain Legacy <allain.legacy@windriver.com>
Subject: [PATCH v4 20/22] cfgfile: fix section count with no name
Date: Wed, 16 Jul 2025 15:02:07 +0200
Message-ID: <20250716130212.1736407-21-david.marchand@redhat.com>
In-Reply-To: <20250716130212.1736407-1-david.marchand@redhat.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250716130212.1736407-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mMju0pKdKpvLoUu90jAiYN4OLxPeTUFbte4LYQoKrME_1752671041
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

Passing a NULL to strncmp is incorrect.

 + ------------------------------------------------------- +
 + Test Suite : Test Cfgfile Unit Test Suite
 + ------------------------------------------------------- +
../lib/cfgfile/rte_cfgfile.c:475:7: runtime error: null pointer passed as
	argument 2, which is declared to never be null

On the other hand, it seems the intent was to count all sections, so
skip the whole loop and section name comparisons.

Fixes: c54e7234bc9e ("test/cfgfile: add basic unit tests")

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 lib/cfgfile/rte_cfgfile.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/lib/cfgfile/rte_cfgfile.c b/lib/cfgfile/rte_cfgfile.c
index 8bbdcf146e..9723ec756f 100644
--- a/lib/cfgfile/rte_cfgfile.c
+++ b/lib/cfgfile/rte_cfgfile.c
@@ -477,10 +477,14 @@ int rte_cfgfile_close(struct rte_cfgfile *cfg)
 RTE_EXPORT_SYMBOL(rte_cfgfile_num_sections)
 int
 rte_cfgfile_num_sections(struct rte_cfgfile *cfg, const char *sectionname,
-size_t length)
+	size_t length)
 {
-	int i;
 	int num_sections = 0;
+	int i;
+
+	if (sectionname == NULL)
+		return cfg->num_sections;
+
 	for (i = 0; i < cfg->num_sections; i++) {
 		if (strncmp(cfg->sections[i].name, sectionname, length) == 0)
 			num_sections++;
-- 
2.50.0

