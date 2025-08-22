Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F427CA0EFC
	for <dpdk-dev@archiver.kernel.org>; Fri, 22 Aug 2025 12:07:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 819FB4029A;
	Fri, 22 Aug 2025 14:07:21 +0200 (CEST)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mails.dpdk.org (Postfix) with ESMTP id 819FB40297
 for <dev@dpdk.org>; Fri, 22 Aug 2025 14:07:19 +0200 (CEST)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2445811e19dso16777785ad.1
 for <dev@dpdk.org>; Fri, 22 Aug 2025 05:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1755864438;
 x=1756469238; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=aMnyob63q9H4oJGXQK1xN9xv33lVn8/jLdfylm8ymFM=;
 b=QHQ86RmF+PrOQoanx5W1hiOJLtWQ0WBKBRlQ6goY2thZceczauR2wbjGtlS2jfkX2o
 Z7u9qwIiMpi8/QLMkd5EJW9jB8gm+4JbCplrXCSeLeUeJr0Tatys+A+kYWaa1E62PsnI
 aG1XUE7ficOrbiNA/eUvjEfdWwJIsZEei6RhblP6Nl5Cq7v+hLS5EIrheAaqQ+8jOJNv
 qoiWnAml+GIP05cy2AKnrvdOugckqpb/5Yja8s5tdza1HdfyJ2RbZT0DUXO44L922n0f
 sGJH2eH9xXkY8H4GHnMIuDAw1jO2nzeHG+XNg1IKKFfh1lLmpuNmwicq7KSq1RVP6nVg
 GHYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755864438; x=1756469238;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aMnyob63q9H4oJGXQK1xN9xv33lVn8/jLdfylm8ymFM=;
 b=nfZfHhMpCFN5vRdwaem0vQe1Y+r0gFdKgIshSRFFDuW0GCCtlB5XD10XeKqJRzFnZ+
 qw/wxfTJ4wb9u4tSZYaJZ8+nVhKjFi6j2h7QiddJPeWzvJ5RKit4/mgBoLO5Bxaex07b
 a8ExU9Ih7Vc5Nfo0CXQe6C0K/sNXvpTeUOO5OAWZQa8T5LMZLOJdqOF5cRP5HF0e5JwH
 bjY4DzOiXFRqDL1zduHlKuyQ9ZQa7wh3H3n1UC/4JpA9eaO6WH4URqRlMNXmqExuVnwe
 oWWgCcPdwuibxhlHJipz1o/4+lw3K3RMCW+z5BiWeedQqxsiTgH38Wx57xy372v6eZZR
 QJhg==
X-Gm-Message-State: AOJu0YzE7etBQV8xWhtDX8swS4bgFMWKbEwZ/nT9ueZJs7ttFOcy0+Do
 zUxWtJeJVAXeLP1Csq9GHm7lym8L7yZxVnYsjy6YpMDYSLPRFen0o0ZWmLfkdVbL4ps=
X-Gm-Gg: ASbGnct0XYcaCWvnw01U1TJ9HanN6xHlCjMJEqwQ4cEArdty4496Ii6s7FT1zx/3e0w
 mWTfEbWO+Lz0LI4Q2hPDq5jOKFOLyKe1Pyx+mAxMVvX1iVrV9QPagR2xy+z5xFdZnTKDsD59O4r
 6bGdLcYbmhQKGAaNpbm/6kDXNfp09c9Z3oV8iRSW9lYd8RR16dfs5N5t6GtXBusQ1UMQ4Al4O68
 quXT9dcG1WISzsKQNKCjAjNMBY0loLkSUQAXZY90WQbkElXCCie+lXqdGhumMN0FRPzIn/Mhx7E
 RWG7t5b8+uM2C/Ewh/niMpMV7Pk/60umyakr4c6QVGIDaPa1WTl1tBIp8Fa6XvQQIXNpkXf1fy3
 HnDM3aLtM9oi8xkSPhHvXP2OPBUyrGOY1e603X26B3p/Ty/32oKKNN4LhrCiVCtOGuD+Lmz3k9A
 VPvtky/R2eQ8homNrWiJmMMZhTq0rdFrFSWbt1aTLMv6BMgCLGLXlN
X-Google-Smtp-Source: AGHT+IFEvZh+DOU2O2tyq4odvNH8RxD5ppHnnnReKajzw2gfNzBO2LHYqOeRtPCOdxWyq8//Kyq6VA==
X-Received: by 2002:a17:903:22c5:b0:240:7753:3c07 with SMTP id
 d9443c01a7336-2462ef22167mr32918815ad.33.1755864438339; 
 Fri, 22 Aug 2025 05:07:18 -0700 (PDT)
Received: from localhost.localdomain ([64.62.143.197])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-32513901429sm2386296a91.13.2025.08.22.05.07.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Aug 2025 05:07:17 -0700 (PDT)
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
To: Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Aman Singh <aman.deep.singh@intel.com>,
 Sunil Kumar Kori <skori@marvell.com>
Cc: dev@dpdk.org, Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>,
 stable@dpdk.org
Subject: [PATCH] app/testpmd: validate dscp and vlan table entries for meter
 creation
Date: Fri, 22 Aug 2025 08:06:24 -0400
Message-ID: <20250822120624.2226447-1-14pwcse1224@uetpeshawar.edu.pk>
X-Mailer: git-send-email 2.43.0
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

This patch validate the maximum possible dscp and vlan table
enteries for meter creation.

Fixes: 9f5488e326d3b ("app/testpmd: support different input color method")
Cc: stable@dpdk.org

Signed-off-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
---
 app/test-pmd/cmdline_mtr.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/app/test-pmd/cmdline_mtr.c b/app/test-pmd/cmdline_mtr.c
index e16c5b268f..1435645c1a 100644
--- a/app/test-pmd/cmdline_mtr.c
+++ b/app/test-pmd/cmdline_mtr.c
@@ -85,14 +85,33 @@ parse_uint(uint64_t *value, const char *str)
 	return 0;
 }
 
+static int
+validate_input_color_table_entries(char *str)
+{
+	char *token;
+	int i = 0;
+	token = strtok_r(str, PARSE_DELIMITER, &str);
+	for (i = 0; token != NULL; i++)
+		token = strtok_r(str, PARSE_DELIMITER, &str);
+
+	if (i > (MAX_DSCP_TABLE_ENTRIES + MAX_VLAN_TABLE_ENTRIES))
+		return -1;
+	else
+		return 0;
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
 
+	if (validate_input_color_table_entries(temp_str))
+		return -1;
+
 	token = strtok_r(str, PARSE_DELIMITER, &str);
 	if (token == NULL)
 		return 0;
-- 
2.43.0

