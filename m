Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F11C3ABBE
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 May 2025 05:19:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C2F7F402E4;
	Thu,  8 May 2025 07:19:58 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 24931402E4
 for <dev@dpdk.org>; Thu,  8 May 2025 07:19:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746681596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=d6dt88gj/YxSLhmvCe6cZQxxuNM+KC2tIV/aumwX2lg=;
 b=iwzFvwJx677OMV4464zMN4fEF/TC10a2j5kTDSz3HcnTiltJvwwPuoZNAuxC1EpXhNIQw3
 YZ6G7rutMetCFvlBPZ0P1FsEq5RE/Qg7+Jrwbe1RkXCEtXE0eiVQuBrJCJ/MOLO8bBX6j2
 pOEdSc9F2ZhaBd2sG06mqqqqOrFfTBk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-847yDZu5OAymBB9ARdgfRw-1; Thu,
 08 May 2025 01:19:52 -0400
X-MC-Unique: 847yDZu5OAymBB9ARdgfRw-1
X-Mimecast-MFC-AGG-ID: 847yDZu5OAymBB9ARdgfRw_1746681591
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 877921955D6C; Thu,  8 May 2025 05:19:50 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.32.22])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BF13A180047F; Thu,  8 May 2025 05:19:47 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, stable@dpdk.org,
 Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Jianfeng Tan <jianfeng.tan@intel.com>, Neil Horman <nhorman@tuxdriver.com>
Subject: [PATCH] eal: warn if no lcore is available
Date: Thu,  8 May 2025 07:19:15 +0200
Message-ID: <20250508051915.226465-2-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1_BLwBtMb39T9WZVzbxTYN2LBAipZ09zRZdr3mvCNfk_1746681591
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

On systems with more cpu than RTE_MAX_LCORE, starting DPDK with
cores >= RTE_MAX_LCORE ends up with an ambiguous error log.

Example with RTE_MAX_LCORE=8:
$ taskset -c 8 ./build/app/dpdk-testpmd
EAL: Detected CPU lcores: 8
EAL: Detected NUMA nodes: 1
EAL: Invalid 'command line' arguments.
EAL: Error - exiting with code: 1
Cannot init EAL: Invalid argument

Add a better hint to help the user.

Fixes: 2eba8d21f3c9 ("eal: restrict cores auto detection")
Cc: stable@dpdk.org

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 lib/eal/common/eal_common_options.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index c77654c365..23c0c75932 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -2001,6 +2001,11 @@ eal_adjust_config(struct internal_config *internal_cfg)
 	if (!core_parsed)
 		eal_auto_detect_cores(cfg);
 
+	if (cfg->lcore_count == 0) {
+		EAL_LOG(ERR, "No detected lcore is enabled, please check the core list");
+		return -1;
+	}
+
 	if (internal_conf->process_type == RTE_PROC_AUTO)
 		internal_conf->process_type = eal_proc_type_detect();
 
-- 
2.49.0

