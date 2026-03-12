Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A94E103E301
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Mar 2026 10:36:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6375940B9B;
	Thu, 12 Mar 2026 11:36:48 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id AB7C640B9B
 for <dev@dpdk.org>; Thu, 12 Mar 2026 11:36:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773311806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+KKdFn9+edmpzBODXM/i9jn9ZDGyiN+7r2HrXVZFVEU=;
 b=SLkWEGu54Ka4F3gtHU/1nC+5yn63OiRDXH5pHdISL8ud/1KvMGgrd20s1s5774wDjD8Wx4
 DO6VfssOyP0TnUcVIBjZ0Kdoz88BSvRIbi9b42w+yEiLrwC3U96b/+7vxsAZKkj+qo6Fht
 tXVDQit2PzssbL1UV1VqYVCXvm8ny2c=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-231-QYnx4xdUNnylexY2qPH5OA-1; Thu,
 12 Mar 2026 06:36:43 -0400
X-MC-Unique: QYnx4xdUNnylexY2qPH5OA-1
X-Mimecast-MFC-AGG-ID: QYnx4xdUNnylexY2qPH5OA_1773311802
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3EDB118005BD; Thu, 12 Mar 2026 10:36:41 +0000 (UTC)
Received: from rh.redhat.com (unknown [10.45.224.40])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1DCAD30001A1; Thu, 12 Mar 2026 10:36:37 +0000 (UTC)
From: Kevin Traynor <ktraynor@redhat.com>
To: dev@dpdk.org
Cc: Kevin Traynor <ktraynor@redhat.com>, stable@dpdk.org,
 Aman Singh <aman.deep.singh@intel.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Shani Peretz <shperetz@nvidia.com>
Subject: [PATCH 4/4] app/testpmd: fix fd leak
Date: Thu, 12 Mar 2026 10:36:06 +0000
Message-ID: <20260312103606.702617-5-ktraynor@redhat.com>
In-Reply-To: <20260312103606.702617-1-ktraynor@redhat.com>
References: <20260312103606.702617-1-ktraynor@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: erkHQw8G3o2y8pGTPCCxs92hVuTXDfyQyg7vD686xCw_1773311802
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

In error cases, the fd was not being closed.

Add label for error case that will close the fd.

Fixes: 1303b50a9c21 ("app/testpmd: add commands to dump mbuf history")
Cc: stable@dpdk.org

Signed-off-by: Kevin Traynor <ktraynor@redhat.com>
---
 app/test-pmd/cmdline.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
index ab85f4e0ad..365f780aac 100644
--- a/app/test-pmd/cmdline.c
+++ b/app/test-pmd/cmdline.c
@@ -9359,5 +9359,5 @@ static void cmd_dump_mbuf_history_parsed(void *parsed_result,
 					"Failed to find mempool '%s'\n",
 					res->name);
-			return;
+			goto out_close;
 		}
 		rte_mbuf_history_dump_mempool(out, mp);
@@ -9372,5 +9372,5 @@ static void cmd_dump_mbuf_history_parsed(void *parsed_result,
 			cmdline_printf(cl,
 					"Invalid mbuf pointer format. Use 0x<address>\n");
-			return;
+			goto out_close;
 		}
 		mbuf = (struct rte_mbuf *)mbuf_addr;
@@ -9382,4 +9382,5 @@ static void cmd_dump_mbuf_history_parsed(void *parsed_result,
 	}
 
+out_close:
 	if (out != stdout)
 		fclose(out);
-- 
2.53.0

