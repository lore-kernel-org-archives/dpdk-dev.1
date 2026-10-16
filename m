Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A31D7CC6B38
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 16:49:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ECCF9402E7;
	Fri, 16 Oct 2026 18:49:23 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id BDA444026C
 for <dev@dpdk.org>; Fri, 16 Oct 2026 18:49:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792169362;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=EXs6o63Bfn6sadnZh7nvIB+aTV/C88F00WT4zcKRUSI=;
 b=RgrniMXyru5nxddVLrb7k4UItMJxmzZwtPodgDFdivY1zxxQS0mUmNs7PTNE+B3LMNXKPT
 gnAqHX6NH9yUccsClX9iIm0NIZ/g5Q73QxMBVG8W5yApNgJKTbcwFprjScHDzjFK/9iKA8
 CM5NdMyNAeCdOODVgIgHc3JKP+VxdKk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-397-ENYe5NIzPpmas5AEeZRywg-1; Fri,
 16 Oct 2026 16:49:20 +0000
X-MC-Unique: ENYe5NIzPpmas5AEeZRywg-1
X-Mimecast-MFC-AGG-ID: ENYe5NIzPpmas5AEeZRywg_1792169360
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EBA5B18005B9
 for <dev@dpdk.org>; Fri, 16 Oct 2026 16:49:19 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 590141955F10
 for <dev@dpdk.org>; Fri, 16 Oct 2026 16:49:19 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Subject: [PATCH] eal: add some debug for unit test failures
Date: Fri, 16 Oct 2026 18:49:14 +0200
Message-ID: <20261016164914.1763399-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VjCLB59HdJ3JoVinkMIkhSdTYzTSaUxzNrwcTaTfa8k_1792169360
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

Dirty patch to try to catch more info about a unit test failure seen in
ARM containers at UNH.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 app/test/commands.c          | 4 +++-
 app/test/process.c           | 7 +++++++
 lib/eal/common/malloc_heap.c | 2 ++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/app/test/commands.c b/app/test/commands.c
index 497d8e9952..5108295202 100644
--- a/app/test/commands.c
+++ b/app/test/commands.c
@@ -368,8 +368,10 @@ int commands_init(void)
 	}
 
 	commands = (char *)calloc(commands_len, sizeof(char));
-	if (!commands)
+	if (!commands) {
+		printf("commands_init: calloc(%d) failed %s\n", commands_len, strerror(errno));
 		return -1;
+	}
 
 	TAILQ_FOREACH(t, &commands_list, next) {
 		strlcat(commands, t->command, commands_len);
diff --git a/app/test/process.c b/app/test/process.c
index 92c8af702b..dc39d0ea7b 100644
--- a/app/test/process.c
+++ b/app/test/process.c
@@ -200,6 +200,13 @@ process_dup(const char *const argv[], int numargs, const char *env_value)
 	}
 #endif
 #endif
+	if (WIFEXITED(status))
+		printf("Child process exited with status %d\n", WEXITSTATUS(status));
+	else if (WIFSIGNALED(status))
+		printf("Child process killed by signal %d\n", WTERMSIG(status));
+	else
+		printf("Child process terminated with wait status %d\n", status);
+
 	return status;
 }
 
diff --git a/lib/eal/common/malloc_heap.c b/lib/eal/common/malloc_heap.c
index 39240c261c..6c6bcd3b29 100644
--- a/lib/eal/common/malloc_heap.c
+++ b/lib/eal/common/malloc_heap.c
@@ -657,6 +657,8 @@ malloc_heap_alloc_on_heap_id(size_t size, unsigned int heap_id, unsigned int fla
 	/* for legacy mode, try once and with all flags */
 	if (internal_conf->legacy_mem) {
 		ret = heap_alloc(heap, size, flags, align, bound, contig);
+		if (ret == NULL)
+			EAL_LOG(ERR, "Error allocating from heap in legacy mode");
 		goto alloc_unlock;
 	}
 
-- 
2.54.0

