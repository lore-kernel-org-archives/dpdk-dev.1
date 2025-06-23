Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA16C77B7F
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Jun 2025 13:53:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DF30B40671;
	Mon, 23 Jun 2025 15:53:20 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id D7C7140677
 for <dev@dpdk.org>; Mon, 23 Jun 2025 15:53:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750686798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v7u8zU9mkifjHsanyjCms5uA0A7Hge29dr3pekqIuM4=;
 b=NVeL2yrsflbmYGVc5+X+T34/z7s4DSoTr6G6H7l5b8nM3k4Sdng1zdUQDQ+qXQ7cURrB6D
 KG6BACbJynVDt1tCYXXWo9eW3rswqYQqVnaQ2UY5w/gl1u1ku4HZgG+J/746oklwNsAjfF
 6Qebx/znmQdVNmYk8f7aM4aRzrQ9CAE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-311-xmoE1g_jNHWy30_NcUwVYA-1; Mon,
 23 Jun 2025 09:53:14 -0400
X-MC-Unique: xmoE1g_jNHWy30_NcUwVYA-1
X-Mimecast-MFC-AGG-ID: xmoE1g_jNHWy30_NcUwVYA_1750686793
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 280D8180121C; Mon, 23 Jun 2025 13:53:13 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.32.240])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EAED31956048; Mon, 23 Jun 2025 13:53:11 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: stable@dpdk.org
Subject: [PATCH v2 05/10] cmdline: fix port list parsing
Date: Mon, 23 Jun 2025 15:52:35 +0200
Message-ID: <20250623135242.461965-6-david.marchand@redhat.com>
In-Reply-To: <20250623135242.461965-1-david.marchand@redhat.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250623135242.461965-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: h-UZNQY9Lw6DqfpWliWzFeb-188lI4UiP2b3W6SERfU_1750686793
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

Doing arithmetics with the NULL pointer is undefined.

Caught by UBSan:

../lib/cmdline/cmdline_parse_portlist.c:40:19: runtime error:
	applying non-zero offset 1 to null pointer
SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior
	../lib/cmdline/cmdline_parse_portlist.c:40:19 in

Fixes: af75078fece3 ("first public release")
Cc: stable@dpdk.org

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
Changes since v1:
- moved some variable as suggested by Bruce,

---
 lib/cmdline/cmdline_parse_portlist.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/lib/cmdline/cmdline_parse_portlist.c b/lib/cmdline/cmdline_parse_portlist.c
index ef6ce223b5..549f6d9671 100644
--- a/lib/cmdline/cmdline_parse_portlist.c
+++ b/lib/cmdline/cmdline_parse_portlist.c
@@ -33,15 +33,12 @@ parse_set_list(cmdline_portlist_t *pl, size_t low, size_t high)
 static int
 parse_ports(cmdline_portlist_t *pl, const char *str)
 {
+	const char *first = str;
 	size_t ps, pe;
-	const char *first, *last;
 	char *end;
 
-	for (first = str, last = first;
-	    first != NULL && last != NULL;
-	    first = last + 1) {
-
-		last = strchr(first, ',');
+	while (first != NULL) {
+		const char *last = strchr(first, ',');
 
 		errno = 0;
 		ps = strtoul(first, &end, 10);
@@ -65,6 +62,7 @@ parse_ports(cmdline_portlist_t *pl, const char *str)
 			return -1;
 
 		parse_set_list(pl, ps, pe);
+		first = (last == NULL ? NULL : last + 1);
 	}
 
 	return 0;
-- 
2.49.0

