Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB70C28B2E
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Mar 2025 09:56:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A9C8740650;
	Tue, 11 Mar 2025 10:56:47 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 38F7A40612
 for <dev@dpdk.org>; Tue, 11 Mar 2025 10:56:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741687005;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T22wpUPnLkMozKDW+2YWI/ln8MMqdAnElm47oExvCyE=;
 b=QWZwn1xeYenMeSAD/oka7CsQSHXoItA3K5fqrVEjTU1qcLBVCMsZ/2KbszlsYL3bzGaN+f
 E6iYf1dwqnKWlJdfxeBA0MzISiLcOku9y+7dWZSBoIBiJOA/9L3Tas48w3jcn6nGyq1he8
 fCMPT4cMllbsM+FBP7IYkpawRgxCp9k=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-392-2ALp9D_OM5qrZsoeq75cKQ-1; Tue,
 11 Mar 2025 05:56:42 -0400
X-MC-Unique: 2ALp9D_OM5qrZsoeq75cKQ-1
X-Mimecast-MFC-AGG-ID: 2ALp9D_OM5qrZsoeq75cKQ_1741687001
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 40C471800265; Tue, 11 Mar 2025 09:56:41 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.225.29])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6584119560AB; Tue, 11 Mar 2025 09:56:39 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, bruce.richardson@intel.com,
 andremue@linux.microsoft.com
Subject: [RFC v3 4/8] buildtools: display version when listing symbols
Date: Tue, 11 Mar 2025 10:56:02 +0100
Message-ID: <20250311095609.194523-5-david.marchand@redhat.com>
In-Reply-To: <20250311095609.194523-1-david.marchand@redhat.com>
References: <20250305212349.2036410-1-david.marchand@redhat.com>
 <20250311095609.194523-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lu7y0yL5HUHHDpUggb_0s8qS_9cgeF2okCnMkrhEsEY_1741687001
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
2.48.1

