Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E546C83F17
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Jul 2025 13:33:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 73AE440E27;
	Wed, 23 Jul 2025 15:32:49 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 3871240E20
 for <dev@dpdk.org>; Wed, 23 Jul 2025 15:32:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753277565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t2gNZi/RGYzdvkmfXEcdV6WNIbKD6ik/zfXRDVESoqM=;
 b=dhH+feUFysAkVgTiicqlugS0Bwjbs6x5cmAQAAU2v9uQjEJmUe2qkXwKrb3kjP/GkFvAG9
 BTtG+w3RgM5TbZ/ImYwU9doXoL2YxH7CjTlp1aEfpS0WqgK1hg5AhfVlRMCfT2p+GMNpjC
 Ppm/sNIeaSs3xcHaAvnUoDbJhqh/+gk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-574-h3wioWVvM5GDhKqn-cb8vQ-1; Wed,
 23 Jul 2025 09:32:43 -0400
X-MC-Unique: h3wioWVvM5GDhKqn-cb8vQ-1
X-Mimecast-MFC-AGG-ID: h3wioWVvM5GDhKqn-cb8vQ_1753277562
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AC1AB18015FD; Wed, 23 Jul 2025 13:32:35 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.51])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C456D18016F9; Wed, 23 Jul 2025 13:32:33 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: stable@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Marat Khalili <marat.khalili@huawei.com>
Subject: [PATCH v5 05/22] cmdline: fix port list parsing
Date: Wed, 23 Jul 2025 15:31:38 +0200
Message-ID: <20250723133157.159825-6-david.marchand@redhat.com>
In-Reply-To: <20250723133157.159825-1-david.marchand@redhat.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250723133157.159825-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Z5HFzUnmkfMFYG7u8QC_QxvrI7jOAoTVW3B9AgDHnWw_1753277562
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

Doing arithmetic with the NULL pointer is undefined.

Caught by UBSan:

../lib/cmdline/cmdline_parse_portlist.c:40:19: runtime error:
	applying non-zero offset 1 to null pointer
SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior
	../lib/cmdline/cmdline_parse_portlist.c:40:19 in

Fixes: af75078fece3 ("first public release")
Cc: stable@dpdk.org

Signed-off-by: David Marchand <david.marchand@redhat.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Marat Khalili <marat.khalili@huawei.com>
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
2.50.0

