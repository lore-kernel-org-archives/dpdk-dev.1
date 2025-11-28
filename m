Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51C4D116F1
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Nov 2025 13:56:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 75F2E402B1;
	Fri, 28 Nov 2025 14:56:48 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id E3E8D402B1
 for <dev@dpdk.org>; Fri, 28 Nov 2025 14:56:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764338207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hd6uiWOkrMNiYLPVOh2X8YGYUBBFRCYigogzxY9m7Gw=;
 b=BkkxpiUNb6tUE0qDRCuRsM9k6bxB/GfXO4Jq1d95bFT6kwkdqlft4c6wAqFSAP51l0MO40
 Kuj7bZHuK1JbmOFBDzGQE8GJeAutoJPkKMZUjYLlxXenMEdM+tqc2COBopvfJg+Yl63+FP
 xaD8NoWirnwhr66tnDfjgRMyZFB/FHQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-E-86qrMQPXuHH2W3e5AJQw-1; Fri,
 28 Nov 2025 08:56:42 -0500
X-MC-Unique: E-86qrMQPXuHH2W3e5AJQw-1
X-Mimecast-MFC-AGG-ID: E-86qrMQPXuHH2W3e5AJQw_1764338201
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 258071956053; Fri, 28 Nov 2025 13:56:41 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.32.89])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 09B8019560B0; Fri, 28 Nov 2025 13:56:38 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: stable@dpdk.org, Gagandeep Singh <g.singh@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, Akhil Goyal <gakhil@marvell.com>
Subject: [PATCH 4/7] crypto/caam_jr: fix const pointer in UIO filename parsing
Date: Fri, 28 Nov 2025 14:56:12 +0100
Message-ID: <20251128135616.2662164-5-david.marchand@redhat.com>
In-Reply-To: <20251128135616.2662164-1-david.marchand@redhat.com>
References: <20251128135616.2662164-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: C7RufLk59c1AI6SELBp2KEuDFB_mhfwxxwT38J3Hfgc_1764338201
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

With latest glibc (Fedora Rawhide):
../drivers/crypto/caam_jr/caam_jr_uio.c: In function
	'file_name_match_extract':
../drivers/crypto/caam_jr/caam_jr_uio.c:111:16: warning: assignment
	discards 'const' qualifier from pointer target type
	[-Wdiscarded-qualifiers]
  111 |         substr = strstr(filename, match);
      |                ^

Fixes: e7a45f3cc245 ("crypto/caam_jr: add UIO specific operations")
Cc: stable@dpdk.org

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/crypto/caam_jr/caam_jr_uio.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/crypto/caam_jr/caam_jr_uio.c b/drivers/crypto/caam_jr/caam_jr_uio.c
index 8956f7750d..43357091e1 100644
--- a/drivers/crypto/caam_jr/caam_jr_uio.c
+++ b/drivers/crypto/caam_jr/caam_jr_uio.c
@@ -106,19 +106,11 @@ static int g_uio_jr_num;
 static bool
 file_name_match_extract(const char filename[], const char match[], int *number)
 {
-	char *substr = NULL;
-
-	substr = strstr(filename, match);
-	if (substr == NULL)
-		return false;
-
 	/* substring <match> was found in <filename>
 	 * read number following <match> substring in <filename>
 	 */
-	if (sscanf(filename + strlen(match), "%d", number) <= 0)
-		return false;
-
-	return true;
+	return strstr(filename, match) != NULL &&
+		sscanf(filename + strlen(match), "%d", number) > 0;
 }
 
 /** @brief Reads first line from a file.
-- 
2.51.1

