Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0741DC36010
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Mar 2025 10:53:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3F1044066A;
	Fri, 28 Mar 2025 11:53:24 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 941964066A
 for <dev@dpdk.org>; Fri, 28 Mar 2025 11:53:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743159203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T22wpUPnLkMozKDW+2YWI/ln8MMqdAnElm47oExvCyE=;
 b=XM6KoCLoqkRgFd+1lMRM07OOFL27LqbPfq87fTJker7knXfaSWoPSIeJ0I6WW8sKSFbi8a
 vLcfCBFp4JxKYZGNeIPN362g62nLaJwxCPLJ4C/5bDllI+pdwvAPSkUEfYAtOoxm/uEHP8
 wfqrJcutovTcR6BoErb7NDbRvz9veD0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-119-4X6RADR8O1W8j_JFIrIzTg-1; Fri,
 28 Mar 2025 06:53:18 -0400
X-MC-Unique: 4X6RADR8O1W8j_JFIrIzTg-1
X-Mimecast-MFC-AGG-ID: 4X6RADR8O1W8j_JFIrIzTg_1743159197
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5B9F8196B373; Fri, 28 Mar 2025 10:53:16 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.224.228])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ABA9E3001D0F; Fri, 28 Mar 2025 10:53:14 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, bruce.richardson@intel.com,
 andremue@linux.microsoft.com
Subject: [PATCH v6 3/8] buildtools: display version when listing symbols
Date: Fri, 28 Mar 2025 11:52:40 +0100
Message-ID: <20250328105250.3082414-4-david.marchand@redhat.com>
In-Reply-To: <20250328105250.3082414-1-david.marchand@redhat.com>
References: <20250305212349.2036410-1-david.marchand@redhat.com>
 <20250328105250.3082414-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KW3z1_mGm3JMFFDx6aL6guPPl5UprNl2UNUIp3u4ubk_1743159197
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

