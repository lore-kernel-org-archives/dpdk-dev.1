Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6D5CA0EFF
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 Aug 2025 11:19:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8360D40292;
	Wed, 27 Aug 2025 13:19:53 +0200 (CEST)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by mails.dpdk.org (Postfix) with ESMTP id C417340292
 for <dev@dpdk.org>; Wed, 27 Aug 2025 13:19:52 +0200 (CEST)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-771fa65b0e1so821171b3a.0
 for <dev@dpdk.org>; Wed, 27 Aug 2025 04:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1756293592;
 x=1756898392; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wlf4L+hixTUITR8y27ELRVQtRuXyf+fKJCR0SwsLwi4=;
 b=vp8Y5OGupx0AFNL5o+3LoQ+BIl6aQECX/RI6acqQivMtkTs9bh6oR6h2JcV4mnPGOs
 nwDjVK6KMv80/h2Yj8g/hnMJjgCZyuLbLSL3UP/ls0j5AgQs9BHpgvyC/QqPAe9/SCJd
 ryNHQiIKbhfbTYsxuB3seg0HHpqywcpBCWveJxVdzfU3m/gmPY1yD+sGi1jyFrbrR537
 YX7yKpqsK6SOWZorAyPyVz8YSWZECT/Mk3n+z14bhX3nxzCW/JiLX9PdZCuNB+EavKKJ
 rSVUL1OXlGGB2BZPRKHmPXF6ANG4womrpqKKpY8yNCbbXRe7CPVXrS5ELvJxIDxje0vt
 yh4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756293592; x=1756898392;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wlf4L+hixTUITR8y27ELRVQtRuXyf+fKJCR0SwsLwi4=;
 b=RLlov7PO9Ic1URpTfsNb6gfJceuFuZs/Xa11WVLHC4rl/pSy78Fk0k/Ux3OVMCDRij
 lntLzGS31lWXFOubUnLsFV3sIBBROtTqUrHb7Acq1tj8hdEqIr2Nd1oVcOVkSvUrGUMM
 7z0UrOYtFaVZVFjEBe3sXSzLe2YhbA3AnwHlydUujO9o3gMY4uvWWDm09icgc/wGZvTE
 vXppLlCZUFWmprlIkRNgYYqI31+RO4sQdXLSVQ1Qt+ohRiwQu25VpnX6GKIrKV0jzZnI
 s043DqriZCg/CI1wdgdNkxzsw4VVGfXw4InXhhm1Urrp1W1P86Yd53ynfs6FHaj+PgKs
 gQ3A==
X-Gm-Message-State: AOJu0YxulOVfSOmZeiCOdaj2q26OuEIzJETbKkcI7Z0RYJMUAGR+xHo4
 UqHVo5V6SkgeD+eFJVgidAaxrikjoHYVDmiPv2KrKP11p1gIANdvFtJqntcxrFPypEo=
X-Gm-Gg: ASbGncvBxvMvnG+fehFw0Age+d10BMO1mnL3q03ZmTLp3SKdnvl9OGKjZKlqqGadL0M
 tniW42cIa/Er8yBsrd/deEX7FlZYsgsw1IstVEYq6ud+lMNhdxZT0MuSsb/zHZjYZGeyg1YKABO
 mzHmnR06CCsfRiNjFUYlRV+nIZLbhDuOHD4KYnmJMKNrqOBJIbCsKZ+FgCrEFITtkActP1ml5dC
 /tY804VKiWMUV1tLehau0aCOEb9gYuygCltPPms1B6WhXYkapOrXcBwV3QUfwFibtjHaJTNv8AY
 1QNRm41Nqk1rm33QISP2+SvzM89svgn7+NNNm808PcvnPc++YbyD0v+V7WOglyGKN/+/9Ffterm
 7BWcQKlQrNFLVbnr/3BbXMWdO+4FViYMxpW2Z0rIxmkY/Ezcz3JdPNM0hSLQk9aVhWNCh7srreG
 XsVuoWJe5Nrjb0FMCNJopqyU80BchDJ+7PrNET0KKAP4pIVUc4
X-Google-Smtp-Source: AGHT+IFCgawi0LRy4KSlveQ+NSdYVxXDvVeVxYAQ0hqSCNPc9DY3nnhTL4KMeP4ij2VMW6iONr+r1g==
X-Received: by 2002:a05:6a21:339c:b0:240:af8:1784 with SMTP id
 adf61e73a8af0-24340b01762mr26292467637.1.1756293591741; 
 Wed, 27 Aug 2025 04:19:51 -0700 (PDT)
Received: from localhost.localdomain ([64.62.143.197])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4c1b6dedd2sm7119993a12.23.2025.08.27.04.19.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 04:19:51 -0700 (PDT)
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
To: Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Aman Singh <aman.deep.singh@intel.com>,
 Sunil Kumar Kori <skori@marvell.com>
Cc: dev@dpdk.org, Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>,
 stable@dpdk.org
Subject: [PATCH v2] app/testpmd: validate dscp and vlan table entries for
 meter creation
Date: Wed, 27 Aug 2025 07:18:37 -0400
Message-ID: <20250827111837.3882892-1-14pwcse1224@uetpeshawar.edu.pk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250822121430.2228507-1-14pwcse1224@uetpeshawar.edu.pk>
References: <20250822121430.2228507-1-14pwcse1224@uetpeshawar.edu.pk>
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

Add validation mechanism for meter creation. The maximum
possible entries are
[<dscp_tbl_entry0> <dscp_tbl_entry1> ...<dscp_tbl_entry63>]
[<vlan_tbl_entry0> <vlan_tbl_entry1> ... <vlan_tbl_entry15>].
Currently, testpmd allows any input table entries for dscp
and vlan tables.

This patch validates the maximum possible dscp and vlan table
entries for meter creation.

Fixes: 9f5488e326d3b ("app/testpmd: support different input color method")
Cc: stable@dpdk.org

Signed-off-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
---
 app/test-pmd/cmdline_mtr.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/app/test-pmd/cmdline_mtr.c b/app/test-pmd/cmdline_mtr.c
index e16c5b268f..256d5b4238 100644
--- a/app/test-pmd/cmdline_mtr.c
+++ b/app/test-pmd/cmdline_mtr.c
@@ -85,14 +85,33 @@ parse_uint(uint64_t *value, const char *str)
 	return 0;
 }
 
+static int
+validate_input_color_table_entries(char *str)
+{
+	char *token = strtok_r(str, PARSE_DELIMITER, &str);
+	for (int i = 0; token != NULL; i++) {
+		if (i > ((MAX_DSCP_TABLE_ENTRIES + MAX_VLAN_TABLE_ENTRIES) - 1))
+			return -1;
+		token = strtok_r(str, PARSE_DELIMITER, &str);
+	}
+	return 0;
+}
+
 static int
 parse_input_color_table_entries(char *str, enum rte_color **dscp_table,
 	enum rte_color **vlan_table)
 {
 	enum rte_color *vlan, *dscp;
 	char *token;
+	char *temp_str = strdup(str);
 	int i = 0;
 
+	if (validate_input_color_table_entries(temp_str)) {
+		free(temp_str);
+		return -1;
+	}
+	free(temp_str);
+
 	token = strtok_r(str, PARSE_DELIMITER, &str);
 	if (token == NULL)
 		return 0;
-- 
2.43.0

