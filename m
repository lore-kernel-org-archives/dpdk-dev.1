Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 775B9C83F17
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Jul 2025 13:32:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 81F5540E09;
	Wed, 23 Jul 2025 15:32:39 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 863D240B98
 for <dev@dpdk.org>; Wed, 23 Jul 2025 15:32:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753277557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G+vLQlE1eQ1D0MoQNt4IVVqw1Xy5yVQmNfxEqf9VN3M=;
 b=FbS0pZHzKUiTjFJYw0sU0SVPcyfkJ9EOY8UEaJ+QWHq3b5VgHleawLRP5Gs9P+3KGLPHHB
 acHt3QI0ffw5dOG+IbO9GA4/H3r+Qoz+tiDWZHezlPsk1NxlP08tK/212vLmA25ba40tCz
 BFO3GoPfUx+RE7+zTQdf0ilL4/FpGsA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-648-IEzHb0AYPuOwPL7FmQ9JyQ-1; Wed,
 23 Jul 2025 09:32:32 -0400
X-MC-Unique: IEzHb0AYPuOwPL7FmQ9JyQ-1
X-Mimecast-MFC-AGG-ID: IEzHb0AYPuOwPL7FmQ9JyQ_1753277550
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9FF9819560A3; Wed, 23 Jul 2025 13:32:30 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.51])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4439019560A0; Wed, 23 Jul 2025 13:32:26 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: stable@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Timothy Redaelli <tredaelli@redhat.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: [PATCH v5 04/22] eal: fix plugin dir walk
Date: Wed, 23 Jul 2025 15:31:37 +0200
Message-ID: <20250723133157.159825-5-david.marchand@redhat.com>
In-Reply-To: <20250723133157.159825-1-david.marchand@redhat.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250723133157.159825-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SjOIVbiC98-ozozXiw2hzG5dOY7WEekOjJHjZQ0u-vk_1753277550
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

For '.' and '..' directories (or any short file name),
a out of bound issue occurs.

Caught by UBSan:

EAL: Detected shared linkage of DPDK
../lib/eal/common/eal_common_options.c:420:15: runtime error: index -2
	out of bounds for type 'char[256]'
    #0 0x7f867eedf206 in eal_plugindir_init
	eal_common_options.c
    #1 0x7f867eede58a in eal_plugins_init
	(build/lib/librte_eal.so.25+0xde58a)
	(BuildId: e7e4a1935e4bacb51c82ab1a84098a27decf3b4c)
    #2 0x7f867efb8587 in rte_eal_init
	(build/lib/librte_eal.so.25+0x1b8587)
	(BuildId: e7e4a1935e4bacb51c82ab1a84098a27decf3b4c)
    #3 0x55b62360861e in main
	(/home/runner/work/dpdk/dpdk/build/app/dpdk-testpmd+0x9e061e)
	(BuildId: d821ec918612c83fad8b5ccb6cc518e66bee48cd)
    #4 0x7f8667429d8f in __libc_start_call_main
	csu/../sysdeps/nptl/libc_start_call_main.h:58:16
    #5 0x7f8667429e3f in __libc_start_main
	csu/../csu/libc-start.c:392:3
    #6 0x55b622d9d444 in _start
	(/home/runner/work/dpdk/dpdk/build/app/dpdk-testpmd+0x175444)
	(BuildId: d821ec918612c83fad8b5ccb6cc518e66bee48cd)
SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior
	../lib/eal/common/eal_common_options.c:420:15 in
	../lib/eal/common/eal_common_options.c:421:15:
	runtime error: index 18446744073709551609 out of bounds
	for type 'char[256]'

Fixes: c57f6e5c604a ("eal: fix plugin loading")
Cc: stable@dpdk.org

Signed-off-by: David Marchand <david.marchand@redhat.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
Changes since v2:
- removed check on null termination of dirent,

---
 lib/eal/common/eal_common_options.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index 3169dd069f..2f91b96190 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -399,12 +399,21 @@ eal_plugins_init(void)
 }
 #else
 
+static bool
+ends_with(const char *str, const char *tail)
+{
+	size_t tail_len = strlen(tail);
+	size_t str_len = strlen(str);
+
+	return str_len >= tail_len && strcmp(&str[str_len - tail_len], tail) == 0;
+}
+
 static int
 eal_plugindir_init(const char *path)
 {
-	DIR *d = NULL;
 	struct dirent *dent = NULL;
 	char sopath[PATH_MAX];
+	DIR *d = NULL;
 
 	if (path == NULL || *path == '\0')
 		return 0;
@@ -418,12 +427,8 @@ eal_plugindir_init(const char *path)
 
 	while ((dent = readdir(d)) != NULL) {
 		struct stat sb;
-		int nlen = strnlen(dent->d_name, sizeof(dent->d_name));
 
-		/* check if name ends in .so or .so.ABI_VERSION */
-		if (strcmp(&dent->d_name[nlen - 3], ".so") != 0 &&
-		    strcmp(&dent->d_name[nlen - 4 - strlen(ABI_VERSION)],
-			   ".so."ABI_VERSION) != 0)
+		if (!ends_with(dent->d_name, ".so") && !ends_with(dent->d_name, ".so."ABI_VERSION))
 			continue;
 
 		snprintf(sopath, sizeof(sopath), "%s/%s", path, dent->d_name);
-- 
2.50.0

