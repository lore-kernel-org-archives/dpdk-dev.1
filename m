Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACFBFD116F1
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Nov 2025 13:56:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A30364042C;
	Fri, 28 Nov 2025 14:56:53 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id C7CC9402D2
 for <dev@dpdk.org>; Fri, 28 Nov 2025 14:56:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764338212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ukhhs7FwriPKTDMoyF0TniHz8oFD6Pgo7cZT8rs6tRs=;
 b=YGkwJCHyyTWfbrLjJ+sFJJFL2HwL2kdTgdJwZDdnsPuyQ+1EDedpB+ZkuIxoIKH0bpPYSv
 2hBrS0563rTiGODbXHLF/Qi7lX/jvq4Pif2BeDbqENBRpNWla4JrfNeoaFks6l1qVMT7GN
 t6Dq6tPFMrVsWPf9NXmSbz+jqm86YQo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-373-aH0hGjJbPD2RnKV6SgSTEw-1; Fri,
 28 Nov 2025 08:56:49 -0500
X-MC-Unique: aH0hGjJbPD2RnKV6SgSTEw-1
X-Mimecast-MFC-AGG-ID: aH0hGjJbPD2RnKV6SgSTEw_1764338208
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 01001195608D; Fri, 28 Nov 2025 13:56:48 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.32.89])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ACA4819560B0; Fri, 28 Nov 2025 13:56:45 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: stable@dpdk.org, Apeksha Gupta <apeksha.gupta@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Ferruh Yigit <ferruh.yigit@amd.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: [PATCH 5/7] net/enetfec: fix const pointer in UIO filename parsing
Date: Fri, 28 Nov 2025 14:56:13 +0100
Message-ID: <20251128135616.2662164-6-david.marchand@redhat.com>
In-Reply-To: <20251128135616.2662164-1-david.marchand@redhat.com>
References: <20251128135616.2662164-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iUokOhwfi9mIrR7kl6HLLnB4EcvwHKCBt_UWYb0SohE_1764338208
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
../drivers/net/enetfec/enet_uio.c: In function 'file_name_match_extract':
../drivers/net/enetfec/enet_uio.c:37:16: warning: assignment discards
	'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
   37 |         substr = strstr(filename, match);
      |                ^

Fixes: b84fdd39638b ("net/enetfec: support UIO")
Cc: stable@dpdk.org

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/net/enetfec/enet_uio.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/net/enetfec/enet_uio.c b/drivers/net/enetfec/enet_uio.c
index f32d5e1b1e..c3917cd9df 100644
--- a/drivers/net/enetfec/enet_uio.c
+++ b/drivers/net/enetfec/enet_uio.c
@@ -32,13 +32,7 @@ static int enetfec_count;
 static bool
 file_name_match_extract(const char filename[], const char match[])
 {
-	char *substr = NULL;
-
-	substr = strstr(filename, match);
-	if (substr == NULL)
-		return false;
-
-	return true;
+	return strstr(filename, match) != NULL;
 }
 
 /*
-- 
2.51.1

