Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AFBFC77B7F
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Jun 2025 13:53:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CF98F4065E;
	Mon, 23 Jun 2025 15:53:16 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id BF95140670
 for <dev@dpdk.org>; Mon, 23 Jun 2025 15:53:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750686793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JMgbZDSjUYX29HEI8Xnm2YMTjqqAbEM6j47HwpH0Xz4=;
 b=Vc0JiEa6pK1gnaHJK4JJ5liC1wVL8zC+eE0kKQzYr37XO7iCAZAKp1FP6KfDEYmforjONc
 UgofnoMY/8mlxFGRVe1ZhkGIM8CFbrpZrcvsYGaW36EFyeQtqWS6SubvdSzVq175lJdVz0
 3FU61IGVWD90AutFVGItQtYXWqTIYHk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-ThLkeDeFOPmvFBPE4suaPA-1; Mon,
 23 Jun 2025 09:53:10 -0400
X-MC-Unique: ThLkeDeFOPmvFBPE4suaPA-1
X-Mimecast-MFC-AGG-ID: ThLkeDeFOPmvFBPE4suaPA_1750686789
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DF8E51809C8F; Mon, 23 Jun 2025 13:53:08 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.32.240])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 523531803AFF; Mon, 23 Jun 2025 13:53:05 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: stable@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Timothy Redaelli <tredaelli@redhat.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: [PATCH v2 04/10] eal: fix plugin dir walk
Date: Mon, 23 Jun 2025 15:52:34 +0200
Message-ID: <20250623135242.461965-5-david.marchand@redhat.com>
In-Reply-To: <20250623135242.461965-1-david.marchand@redhat.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250623135242.461965-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tuuEtMejbm-lTUn-KTpumpUeshYEPhCahb4XQ8iBcQ0_1750686789
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
 lib/eal/common/eal_common_options.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index 83b6fc7e89..153f807e4f 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -399,6 +399,14 @@ eal_plugins_init(void)
 }
 #else
 
+static bool
+ends_with(const char *str, size_t str_len, const char *tail)
+{
+	size_t tail_len = strlen(tail);
+
+	return str_len >= tail_len && strncmp(&str[str_len - tail_len], tail, tail_len) == 0;
+}
+
 static int
 eal_plugindir_init(const char *path)
 {
@@ -417,13 +425,12 @@ eal_plugindir_init(const char *path)
 	}
 
 	while ((dent = readdir(d)) != NULL) {
+		size_t nlen = strnlen(dent->d_name, sizeof(dent->d_name));
 		struct stat sb;
-		int nlen = strnlen(dent->d_name, sizeof(dent->d_name));
 
 		/* check if name ends in .so or .so.ABI_VERSION */
-		if (strcmp(&dent->d_name[nlen - 3], ".so") != 0 &&
-		    strcmp(&dent->d_name[nlen - 4 - strlen(ABI_VERSION)],
-			   ".so."ABI_VERSION) != 0)
+		if (!ends_with(dent->d_name, nlen, ".so") &&
+				!ends_with(dent->d_name, nlen, ".so."ABI_VERSION))
 			continue;
 
 		snprintf(sopath, sizeof(sopath), "%s/%s", path, dent->d_name);
-- 
2.49.0

