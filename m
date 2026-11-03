Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B92606A324
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 07:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OqzmtL1Y
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ADF7C4028B;
	Tue,  3 Nov 2026 08:59:43 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTPS id D4DB940278
 for <dev@dpdk.org>; Tue,  3 Nov 2026 08:59:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793692780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=eyqPIQJzmAvxYIEf/ZUmm6IB9DidfPzaHoLVE4SluEU=;
 b=OqzmtL1YtFm9J2EFxRxTRl5eDVs7V2vOvib87DfdwKqwE2sEV+oT1wJBePPPIcLqG/GWif
 aptKsgeIkymTJCjOZhmzfyckmCxut+OJfpmLRFx035HflwOWJM+aW2qNmwvY4xFlozYVzN
 gKgBOlizGSzK0zigaXTdQjYq/P1aFNY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-oIwuSBu3OKm2nrZzHoaoFg-1; Tue,
 03 Nov 2026 02:59:39 -0500
X-MC-Unique: oIwuSBu3OKm2nrZzHoaoFg-1
X-Mimecast-MFC-AGG-ID: oIwuSBu3OKm2nrZzHoaoFg_1793692779
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 920481800611; Tue,  3 Nov 2026 07:59:38 +0000 (UTC)
Received: from dmarchan-thinkpadx1carbongen13.rmtfr.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3B9B0180029C; Tue,  3 Nov 2026 07:59:36 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: maxime.coquelin@redhat.com,
	thomas@monjalon.net
Subject: [PATCH] devtools: check uAPI headers inclusions
Date: Tue,  3 Nov 2026 08:59:33 +0100
Message-ID: <20261103075933.1005684-1-david.marchand@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZxoMs4CFZPTL_8LX4yDx0d0ThpHbVMYO7PASUHk1BBw_1793692779
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Imported Linux kernel uAPI headers must be included before any other
header to avoid a system-installed header being read instead.

Add a check that runs after every operation to catch files where
Linux uapi includes are preceded by other includes.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 devtools/linux-uapi.sh | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/devtools/linux-uapi.sh b/devtools/linux-uapi.sh
index 3f804685aa..d03b43a0aa 100755
--- a/devtools/linux-uapi.sh
+++ b/devtools/linux-uapi.sh
@@ -138,6 +138,29 @@ check_header()
 	return 0
 }
 
+check_include_order()
+{
+	local errors=0
+
+	$quiet || echo "Checking uapi/linux inclusion order"
+	for filename in $(git grep -l '#include <uapi/linux/' ':!devtools/linux-uapi.sh' \
+			':!doc/guides/contributing/linux_uapi.rst' ':!kernel/linux/uapi/'); do
+		last_uapi=$(grep -n '#include <uapi/linux/' "$filename" | tail -1 | cut -d: -f1)
+		first_other=$(grep -n '^#include' "$filename" | grep -v 'uapi/linux/' |
+			head -1 | cut -d: -f1)
+		if [ -z "$first_other" ] || [ "$first_other" -gt "$last_uapi" ]; then
+			continue;
+		fi
+		$quiet || echo "$filename: uapi headers must be included before other headers"
+		errors=$((errors + 1))
+	done
+	if [ $errors -ne 0 ] || ! $quiet; then
+		echo "$errors error(s) found in uapi inclusion order"
+	fi
+
+	return $errors
+}
+
 check_all()
 {
 	local errors=0
@@ -192,3 +215,5 @@ if $check_headers; then
 else
 	update_all
 fi
+
+check_include_order
-- 
2.56.0

