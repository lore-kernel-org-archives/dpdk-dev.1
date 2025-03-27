Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5862BC3600B
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Mar 2025 13:37:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 27E6840DFB;
	Thu, 27 Mar 2025 14:37:17 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 60CE940DDB
 for <dev@dpdk.org>; Thu, 27 Mar 2025 14:37:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743082634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T22wpUPnLkMozKDW+2YWI/ln8MMqdAnElm47oExvCyE=;
 b=Xkvz/DaRjjSFxVQLbdwRjng4r2XEBNaC464qBqJ3BfgBoXeaOmUrtBoIwEfsse4pXCHPKt
 +jvu6GHaoNOd9DANGVVxBDDzoqH2oDUfVAgs6LDm/y8nFIZMHrrL4Evpo3T6Yw7KKGVwMm
 5QVPe5+8HYmplrGuwepuTBZCPQS67+8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-583-lB2TB0S_MRqVeuhwQwnH8w-1; Thu,
 27 Mar 2025 09:37:12 -0400
X-MC-Unique: lB2TB0S_MRqVeuhwQwnH8w-1
X-Mimecast-MFC-AGG-ID: lB2TB0S_MRqVeuhwQwnH8w_1743082631
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D0A621800361; Thu, 27 Mar 2025 13:37:10 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.224.228])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4C9AC180B487; Thu, 27 Mar 2025 13:37:09 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, bruce.richardson@intel.com,
 andremue@linux.microsoft.com
Subject: [PATCH v5 3/8] buildtools: display version when listing symbols
Date: Thu, 27 Mar 2025 14:36:23 +0100
Message-ID: <20250327133638.2983276-4-david.marchand@redhat.com>
In-Reply-To: <20250327133638.2983276-1-david.marchand@redhat.com>
References: <20250305212349.2036410-1-david.marchand@redhat.com>
 <20250327133638.2983276-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Sk2_nntZAtiginioPdRUIshst-cl5H9gZq5djCt1f2A_1743082631
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

