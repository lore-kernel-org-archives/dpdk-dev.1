Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA268FF5105
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Apr 2026 15:18:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9D60440693;
	Tue,  7 Apr 2026 17:18:15 +0200 (CEST)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by mails.dpdk.org (Postfix) with ESMTP id E1B244065C
 for <dev@dpdk.org>; Tue,  7 Apr 2026 17:18:14 +0200 (CEST)
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-c766a95a72dso3287588a12.1
 for <dev@dpdk.org>; Tue, 07 Apr 2026 08:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775575094;
 x=1776179894; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/cz4w9x8WkM5nAAuJawejIbAKniaxX+aYDodiVGfuD0=;
 b=YZZtYftkq9mIOZLEgQqpj+s2qZ1nr0jeZkRqBs7nyDnqpiX7MCYOg2GFfN9xwuJLD0
 jrujqIR7VQ/byr4rM8ASE0dRAJmRYXF4ngTcVGTy7mGt+X1UGl1GOIKGBc6G0lkueHvH
 1uraBFDYGSYY4q2mNI1Ncupdr1lZ02fBkNdLtBJobqivGBYPIrXUBrgDVbBrCfS8aUGC
 8PuiWPGkudfdtwnyeOAzbsPr78wGuHtfYMhlEVdf3FrRJoBTlodkCNSD/3W8dKeexBWA
 j8cnP9bUQvKzzAsyEkYJISgelZoiYzUseVaC5ohACQGgMNbsEMurApDTPwS0gMP789PC
 jvHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775575094; x=1776179894;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/cz4w9x8WkM5nAAuJawejIbAKniaxX+aYDodiVGfuD0=;
 b=q2x67J3cPvESUj5bayYCZVr8ykse5nCroF2VmfootVRvLjCwJquzByXe+TJQtPwAOE
 JYDUlU7ek1zrkeGTOA7xgIwbMMm+Y2GXL/tpmmwEeVCp3e5mS0kpWBZr2kilVo7QRlU6
 pUmHtTvYNKUxg58JNcG4O1yjqX+Su/YKDbzCEKhUMR/fM5fTvlQuqTNZlOVk1bGoJ9Ro
 jhXccy/DonIHCbbmPumWFBejgNku9RnxMhplxdkcHMndqIwRmqiRN2BWwNQmgOlFSf/V
 01xESuFBbsfeyS0uIWg0dnosmSNGxPV4ZTUOAWr+OYyoUwG30ST0Szv1Wx0m6UbvLBka
 NFqg==
X-Gm-Message-State: AOJu0YwRQlc8qNFkJu2j7xiOE4uWZnpLt5JoQ7tP8sHkhiPqmOUDCWkN
 O+JgEpHuFvLmOfgoEr7kDZMSxLEh4wA0nvdB1cdHppwkHNcpuZA1aekl8QEuoZmB5c+xir+EBX6
 3B/hq
X-Gm-Gg: AeBDieuFK96XQdcpVTtA0h0KlxcTGZfU7woca6pN0IVYzDemhxRle/sPNW2I2UE/Ket
 LuWaRRm15W89GA8kzmDoojlm1ozoQsDTk/uBosuvAjv8rxXS9hRCK0or/LhUQ9W2WjB39Y/YyPa
 1BskZE7y3GYDCYdz0PEl1/fNenq6guNYDv/DERuAfBURa4sEVw08yv+rn9SrIkE09AWdkxwNxzi
 ueAmr+EMmwRdFaFlfkv/ZfNy6fRkRfQrgSdhBrLtH/AqWWnaTDBl6c8M37utqjE+/rm5uBgXauA
 xpkjDszX7Fu+FBqS+YybS4dXtVFqyezSaXUJFXngUCtmgxeYwB/pnHIvfVvMS81mTJYjf6Yd7fv
 KbrvNu1rZB+uNu6AIB2H0Pik9jg0VFa6DreUAbToAOkSNXcIiy8OILyD0CA4wkP9ygBJJRczbhp
 iMuCBtJwy8AllAW6HXIwdHNAazQ7amK0cK
X-Received: by 2002:a05:6a21:33a9:b0:366:2341:4980 with SMTP id
 adf61e73a8af0-39f2ed8d518mr19266275637.11.1775575094075; 
 Tue, 07 Apr 2026 08:18:14 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76c6477bbcsm15842933a12.3.2026.04.07.08.18.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 08:18:13 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>
Subject: [PATCH v2 10/23] examples/ip_pipeline: resolve shadow variable warning
Date: Tue,  7 Apr 2026 08:16:06 -0700
Message-ID: <20260407151732.272195-11-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407151732.272195-1-stephen@networkplumber.org>
References: <20260407035209.650419-1-stephen@networkplumber.org>
 <20260407151732.272195-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The variable p was used for both pipeline and parameters.
Rename first instance.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 examples/ip_pipeline/cli.c       | 9 ++++-----
 examples/ip_pipeline/meson.build | 1 -
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/examples/ip_pipeline/cli.c b/examples/ip_pipeline/cli.c
index 766fc8e46e..935c9b39d5 100644
--- a/examples/ip_pipeline/cli.c
+++ b/examples/ip_pipeline/cli.c
@@ -4721,7 +4721,7 @@ table_rule_show(const char *pipeline_name,
 	uint32_t table_id,
 	const char *file_name)
 {
-	struct pipeline *p;
+	struct pipeline *pipeline;
 	struct table *table;
 	struct table_rule *rule;
 	FILE *f = NULL;
@@ -4732,12 +4732,11 @@ table_rule_show(const char *pipeline_name,
 		(file_name == NULL))
 		return -1;
 
-	p = pipeline_find(pipeline_name);
-	if ((p == NULL) ||
-		(table_id >= p->n_tables))
+	pipeline = pipeline_find(pipeline_name);
+	if (pipeline == NULL || table_id >= pipeline->n_tables)
 		return -1;
 
-	table = &p->table[table_id];
+	table = &pipeline->table[table_id];
 
 	/* Open file. */
 	f = fopen(file_name, "w");
diff --git a/examples/ip_pipeline/meson.build b/examples/ip_pipeline/meson.build
index c5cda980f9..68049157e4 100644
--- a/examples/ip_pipeline/meson.build
+++ b/examples/ip_pipeline/meson.build
@@ -28,4 +28,3 @@ sources = files(
         'thread.c',
         'tmgr.c',
 )
-cflags += no_shadow_cflag
-- 
2.53.0

