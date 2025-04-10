Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B41C369A2
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Apr 2025 16:02:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A3F5F40676;
	Thu, 10 Apr 2025 18:02:50 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id BE0A3402ED
 for <dev@dpdk.org>; Thu, 10 Apr 2025 18:02:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744300969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Wr+RfkomHnPY2fFp7oecIR0nBzmd0v7L6hZDO3jqg90=;
 b=NJYYuNjiFojGQ9GaG+bct/JOBYBcOBenU6X2eAiT0Bh6XIiyWhid5J9AgkpL82z81Bh9sy
 UsBBPuxah4VN3N20+5rLZd5mnR7vUn6099EUDUS6vFkooU58twAKqSHligrhUOI2d4EJ8k
 vyPHNddm7du/idsEos0L1CkU+lzx+5g=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-65-7-_A_ONUPSuksQlcam9qbA-1; Thu,
 10 Apr 2025 12:02:44 -0400
X-MC-Unique: 7-_A_ONUPSuksQlcam9qbA-1
X-Mimecast-MFC-AGG-ID: 7-_A_ONUPSuksQlcam9qbA_1744300963
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9DD6F19560B0; Thu, 10 Apr 2025 16:02:43 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.224.228])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5A26D180B493; Thu, 10 Apr 2025 16:02:42 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: andremue@linux.microsoft.com,
	Aman Singh <aman.deep.singh@intel.com>
Subject: [PATCH] app/testpmd: fix dump command list for MSVC
Date: Thu, 10 Apr 2025 18:02:36 +0200
Message-ID: <20250410160237.3067629-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ql_VCLXum2_ZU2n7IWYaZFO4MfJpXD4gCzOJr6-M7HQ_1744300963
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

Compiling with MSVC results in warnings like below:

app/test-pmd/cmdline.c(9023): warning C5101: use of preprocessor
    directive in function-like macro argument list is undefined behavior

Construct token list at runtime.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
Note: this is an alternative to
https://patchwork.dpdk.org/project/dpdk/patch/1740414265-12217-6-git-send-email-andremue@linux.microsoft.com/

---
 app/test-pmd/cmdline.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
index d10709f6bc..b4089d281b 100644
--- a/app/test-pmd/cmdline.c
+++ b/app/test-pmd/cmdline.c
@@ -9018,6 +9018,12 @@ static void cmd_dump_parsed(void *parsed_result,
 
 static cmdline_parse_token_string_t cmd_dump_dump =
 	TOKEN_STRING_INITIALIZER(struct cmd_dump_result, dump,
+		"" /* defined at init */);
+
+static void
+cmd_dump_init(void)
+{
+	cmd_dump_dump.string_data.str =
 		"dump_physmem#"
 		"dump_memzone#"
 		"dump_socket_mem#"
@@ -9029,7 +9035,8 @@ static cmdline_parse_token_string_t cmd_dump_dump =
 #ifndef RTE_EXEC_ENV_WINDOWS
 		"dump_trace#"
 #endif
-		"dump_log_types");
+		"dump_log_types";
+}
 
 static cmdline_parse_inst_t cmd_dump = {
 	.f = cmd_dump_parsed,  /* function to call */
@@ -13961,6 +13968,7 @@ init_cmdline(void)
 	/* initialize non-constant commands */
 	cmd_set_fwd_mode_init();
 	cmd_set_fwd_retry_mode_init();
+	cmd_dump_init();
 
 	count = 0;
 	for (i = 0; builtin_ctx[i] != NULL; i++)
-- 
2.49.0

