Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD002103E301
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Mar 2026 10:36:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8071D4065D;
	Thu, 12 Mar 2026 11:36:44 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 7028F40A6C
 for <dev@dpdk.org>; Thu, 12 Mar 2026 11:36:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773311802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mPmEB++amNUdTY9YXGXxueaXE20zOYRx5ziFVIWysTE=;
 b=IIDJenrZZS00WwWqOGZrA0VYxtbvUoIKLgUkiE1L63J4Yag/2uppeWJXZ1yBOVnFNFy5u7
 zqd8UOsjvcXyrsWV801m1hWk9egy85CWM01dLLPV57bVv7ubV6oVQYZtRvd/oIbjVtzweX
 73ggXjxtMHH9QwXO7L3k7RsiEccPZVY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-216-nb2eWjF0PeaI6QEvgsOzlw-1; Thu,
 12 Mar 2026 06:36:39 -0400
X-MC-Unique: nb2eWjF0PeaI6QEvgsOzlw-1
X-Mimecast-MFC-AGG-ID: nb2eWjF0PeaI6QEvgsOzlw_1773311798
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7C36B19560A1; Thu, 12 Mar 2026 10:36:37 +0000 (UTC)
Received: from rh.redhat.com (unknown [10.45.224.40])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F2DE430001A1; Thu, 12 Mar 2026 10:36:34 +0000 (UTC)
From: Kevin Traynor <ktraynor@redhat.com>
To: dev@dpdk.org
Cc: Kevin Traynor <ktraynor@redhat.com>, stable@dpdk.org,
 Aman Singh <aman.deep.singh@intel.com>,
 Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 3/4] app/testpmd: check for no arguments
Date: Thu, 12 Mar 2026 10:36:05 +0000
Message-ID: <20260312103606.702617-4-ktraynor@redhat.com>
In-Reply-To: <20260312103606.702617-1-ktraynor@redhat.com>
References: <20260312103606.702617-1-ktraynor@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OQw4Hv78WVsfeSlEGs3gzsClC7nfWJty3gX5EDwARZ0_1773311798
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

For the case where token is NULL, there are no arguments
and split_str[0] is used uninitialized.

Check counter to ensure there is a token and return error if not.

Fixes: 601576ae6699 ("app/testpmd: add prio-tc map in DCB command")
Cc: stable@dpdk.org

Signed-off-by: Kevin Traynor <ktraynor@redhat.com>
---
 app/test-pmd/cmdline.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
index c33c66f327..ab85f4e0ad 100644
--- a/app/test-pmd/cmdline.c
+++ b/app/test-pmd/cmdline.c
@@ -3570,4 +3570,9 @@ parse_dcb_token_value(char *token_str,
 	} while (1);
 
+	if (split_num == 0) {
+		fprintf(stderr, "Bad Argument: no arguments provided\n");
+		return -1;
+	}
+
 	/* parse fixed parameter "pfc-en" first. */
 	token = split_str[0];
-- 
2.53.0

