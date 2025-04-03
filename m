Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A09C3601A
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Apr 2025 16:59:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 29D52406B4;
	Thu,  3 Apr 2025 18:59:18 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 319B4402CB
 for <dev@dpdk.org>; Thu,  3 Apr 2025 18:59:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743699556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MfvqqfhJNRd/SYS8GEsEkMlX6MarJ798/jZPB/izU0M=;
 b=QjF1y08UYs6BjWP2C9iSJiFU029ql9I3CVce2VkkNstY9wZPA4N/DG1BAFfx463aSjpgZ4
 F7HNgyB1oo7ceIk6igPzz8NrNTAqligyHSfrKAP/rWff7Nz6Ciliqot1BtqN6Ju1JyRLCF
 9KNSu0Pt298fUnCvmEGq1TrMIPvIkEk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-362-kajmznKFP16s3Qu-ukgo6g-1; Thu,
 03 Apr 2025 12:59:13 -0400
X-MC-Unique: kajmznKFP16s3Qu-ukgo6g-1
X-Mimecast-MFC-AGG-ID: kajmznKFP16s3Qu-ukgo6g_1743699550
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 79EF918001E2; Thu,  3 Apr 2025 16:59:10 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.224.228])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CAD3A1955BC2; Thu,  3 Apr 2025 16:59:08 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, bruce.richardson@intel.com,
 andremue@linux.microsoft.com
Subject: [PATCH v7 3/8] buildtools: display symbols version from map
Date: Thu,  3 Apr 2025 18:58:32 +0200
Message-ID: <20250403165845.1315380-4-david.marchand@redhat.com>
In-Reply-To: <20250403165845.1315380-1-david.marchand@redhat.com>
References: <20250305212349.2036410-1-david.marchand@redhat.com>
 <20250403165845.1315380-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OzF5PiBZHbzz3AWn3MqqwjQGpYTRgGJmcnDXMmobkU0_1743699550
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

Display the version when a symbol was introduced.
This is needed for scripting the conversion from static to dynamically
generated version maps.
It is also useful when listing experimental symbols.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 buildtools/map-list-symbol.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/buildtools/map-list-symbol.sh b/buildtools/map-list-symbol.sh
index 43f276c05f..eb98451d8e 100755
--- a/buildtools/map-list-symbol.sh
+++ b/buildtools/map-list-symbol.sh
@@ -73,7 +73,7 @@ for file in $@; do
 		if ("'$symbol'" == "all" || $1 == "'$symbol'") {
 			ret = 0;
 			if ("'$quiet'" == "") {
-				print "'$file' "current_section" "$1;
+				print "'$file' "current_section" "$1" "current_version;
 			}
 			if ("'$symbol'" != "all") {
 				exit 0;
-- 
2.49.0

