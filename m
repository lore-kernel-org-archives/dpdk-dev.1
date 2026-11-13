Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B05606EB80
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Nov 2026 15:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=ZRXDL6nw
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA1EB402A4;
	Fri, 13 Nov 2026 16:57:46 +0100 (CET)
Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com
 [209.85.215.227])
 by mails.dpdk.org (Postfix) with ESMTPS id 4D3644028E
 for <dev@dpdk.org>; Fri, 13 Nov 2026 16:57:46 +0100 (CET)
Received: by mail-pg1-f227.google.com with SMTP id
 41be03b00d2f7-cc4aa0246b7so487931a12.3
 for <dev@dpdk.org>; Fri, 13 Nov 2026 07:57:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794585464; x=1795190264;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5YWXV5HBpcLknv8yD4NzHY08Y2LSebZ2EvEaIs/gH+8=;
 b=lbAmwhHMXwy7+xoRWDQr07NX62ttAS5jubprDUBuA9xguqyRgBCkJoAfSVm4bSQnQQ
 RnitHbDiSCxZjCesEa8JKNUNrXJs0UdZqmq+9UFnmOUoKeFmkxx7wHtdTdYBlSZd8JTN
 RAdkPf9C/TfJhnnlEZreS6yDDDw8wk2+2FqusU8Cn4qvwW/XjoonjWbKyykOLp3nq3zS
 HzrU/IPFVRSa31fBvh/MRBUy0O3F9LNVaNQGC96I3+EapxS4KDbbSm3Tpzcc7etVv3bD
 4prp8ZBmt0PpAXDGBcsHDaoxacIv3GcEVIxsOlV/n+baO7iB+0N/dvRl8nG5TDvdvE8W
 kN3w==
X-Gm-Message-State: APuU4Z+ntqJ7BJXI6TlJw1iCvmP0wpF8kk+EqQQj3jAqSfWIAJrDBzuO
 4Ebw58X+GRhw/1rN6a6xzBnbBxaiE4at8oa9sTFJmIRogZUhqnva+cEeVFwJL6Mptjk/qwt4jIW
 NuwBkopOYQpoFM1zdgMepwwh4QNlOXJVZT5QB3upQS2adabeCoeXI8AkpFJ6qFFO/onOeT0GDz6
 Rajua6VrnQpRdc+uHaZcRcowbeQ+9Hsdct3nQD2RENoWP6lVCOjOpy0XC0hRnHmL5iO3ronrKgj
 qGc/A==
X-Gm-Gg: AYBFou2vyBgg5m/KOnKMXQ4pztkFcSDuggY+MH+/+cQH/31Si7/2pcsb/xZ89XKgmXo
 3ovMlEVuMcvdJKPun97zf8HzQVq1f+wumvz/B/ZKYhXaIJHhbLpliT8lYlhsGEmo9JZDARIi36L
 pp64yEE1J6fHqxdUoS1apdPWDxPOzAjil/SridUM5rVF7Nvq9H23J0naIkx33/Y1IePz+B6PJD9
 r8KG+kx8/i+Fs197vAy7XUiPgf0dR5tZuRdGSDfbqNb3FqbDFnFLDtRBCxnqMFvz+3G3PO+/ak9
 36jma1rc7PzLgKNV+WDzvIz3DBg3bbDSNZwzENCC+MaeIlW14+zHlT7iRGULnUm6g++dt+hCYuQ
 AN2GguCRsqs3j8cAa3PU6V3G+EtPwtrBo5niz8UKkJIJur0nymI7nGymhzc7W0Eza48CzMUVTRv
 oyRzAeD96FdHxk4vnF6tKKBOZyJtCffwg+kvyPu01VmElZiQ==
X-Received: by 2002:a17:90b:1d46:b0:3ac:7613:1ec3 with SMTP id
 98e67ed59e1d1-3b1b0a3eaaemr2457302a91.37.1794585464388; 
 Fri, 13 Nov 2026 07:57:44 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-119.dlp.protect.broadcom.com. [144.49.247.119])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3b197cdc76asm7225109a91.7.2026.11.13.07.57.43
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 13 Nov 2026 07:57:44 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1b238436265so527640c88.1
 for <dev@dpdk.org>; Fri, 13 Nov 2026 07:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1794585463; x=1795190263; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5YWXV5HBpcLknv8yD4NzHY08Y2LSebZ2EvEaIs/gH+8=;
 b=ZRXDL6nw8ia/PDcHamfKvnCkMIuN+z863fK1LNE8/Ht7SgorSv6flHluwBZbuFpaBI
 Esnge4RFt+k9leFKpso6yw2hOaRajIuTeRqnTfOQBHrA1tnh3CNYDGr9KTeXV9mZGRfG
 TtoSjCHgKLsfrwLji/ManVa/YrOoW8RKS7HV4=
X-Received: by 2002:a05:701b:2706:b0:16d:dd5c:4261 with SMTP id
 a92af1059eb24-1b503120981mr2576006c88.46.1794585462720; 
 Fri, 13 Nov 2026 07:57:42 -0800 (PST)
X-Received: by 2002:a05:701b:2706:b0:16d:dd5c:4261 with SMTP id
 a92af1059eb24-1b503120981mr2575980c88.46.1794585461793; 
 Fri, 13 Nov 2026 07:57:41 -0800 (PST)
Received: from accvda5707.acc.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b5031b98e5sm8386190c88.14.2026.11.13.07.57.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 07:57:41 -0800 (PST)
From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
To: dev@dpdk.org
Cc: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Aman Singh <aman.deep.singh@intel.com>
Subject: [PATCH 2/3] app/testpmd: remove mbuf cache size limit
Date: Fri, 13 Nov 2026 10:56:32 -0500
Message-ID: <20261113155633.1883479-2-kishore.padmanabha@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261113155633.1883479-1-kishore.padmanabha@broadcom.com>
References: <20261113155633.1883479-1-kishore.padmanabha@broadcom.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The mempool library no longer limits the cache size to
RTE_MEMPOOL_CACHE_MAX_SIZE, but the --mbcache option still rejected
values above it.

Limit the option to the range of the variable holding the value
instead. A cache size larger than the number of mbufs in the pool is
still rejected by the mempool library when the pool is created.

Update the user guide accordingly.

Fixes: b815acfdfc48 ("mempool: remove cache size limit")
Signed-off-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
---
 app/test-pmd/parameters.c             | 5 ++---
 doc/guides/testpmd_app_ug/run_app.rst | 2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/app/test-pmd/parameters.c b/app/test-pmd/parameters.c
index 34a4f74e636b..9967e49881c5 100644
--- a/app/test-pmd/parameters.c
+++ b/app/test-pmd/parameters.c
@@ -1455,13 +1455,12 @@ launch_args_parse(int argc, char** argv)
 			break;
 		case TESTPMD_OPT_MBCACHE_NUM:
 			n = atoi(optarg);
-			if ((n >= 0) &&
-					(n <= RTE_MEMPOOL_CACHE_MAX_SIZE))
+			if ((n >= 0) && (n <= UINT16_MAX))
 				mb_mempool_cache = (uint16_t) n;
 			else
 				rte_exit(EXIT_FAILURE,
 					"mbcache must be >= 0 and <= %d\n",
-					RTE_MEMPOOL_CACHE_MAX_SIZE);
+					UINT16_MAX);
 			break;
 		case TESTPMD_OPT_TXFREET_NUM:
 			n = atoi(optarg);
diff --git a/doc/guides/testpmd_app_ug/run_app.rst b/doc/guides/testpmd_app_ug/run_app.rst
index e34e414ce246..e10fc5e16223 100644
--- a/doc/guides/testpmd_app_ug/run_app.rst
+++ b/doc/guides/testpmd_app_ug/run_app.rst
@@ -315,7 +315,7 @@ The command line options are:
 
 *   ``--mbcache=N``
 
-    Set the cache of mbuf memory pools to N, where 0 <= N <= 512.
+    Set the cache of mbuf memory pools to N, where 0 <= N <= UINT16_MAX.
     The default value is 16.
 
 *   ``--rxpt=N``
-- 
2.54.0

