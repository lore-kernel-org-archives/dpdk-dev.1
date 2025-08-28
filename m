Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0ED7CA0FF2
	for <dpdk-dev@archiver.kernel.org>; Thu, 28 Aug 2025 05:29:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2B2204066A;
	Thu, 28 Aug 2025 07:29:14 +0200 (CEST)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by mails.dpdk.org (Postfix) with ESMTP id 1EF7A4027D
 for <dev@dpdk.org>; Thu, 28 Aug 2025 07:29:13 +0200 (CEST)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-b4717543ed9so432549a12.3
 for <dev@dpdk.org>; Wed, 27 Aug 2025 22:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1756358952;
 x=1756963752; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zudB1soIQ+4el4aegCleupr6DZa62XkvqbuqljDoj/g=;
 b=0k1i4/rHKah2bIh1uUuFXZ4DZXPUnOZ/sl1nSsKMK1RObxlFwHi8z2lSk+9+g8d83x
 fzJh3209AnrRvWeYA7CVg8n4hK9/Gkyw9h5A0yGDcFTeGulI80dkwcUClmQjys3gfi8H
 bpXUXJ5d3iXyizgKoC4X+3GqeXLD+ebxDjxjEdL4uM5pDWw0enj1y94exfx+WpnYENgc
 T5kQju+T+Qs1Jc0EK9XHHBbVk9qaSNvQdc41csZQbARTJ+/N4DjnTsqmrKv1XnzCJaJY
 sSJoKXakDC23nish03VEx5VuXCxFKtkSO678vGnnZob/OpniYBaIWiQC2OrquLghmORs
 2NyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756358952; x=1756963752;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zudB1soIQ+4el4aegCleupr6DZa62XkvqbuqljDoj/g=;
 b=Hhm2ajVPdWV83iTtRHgOFU6Tc9baJwWF6kqe/Kmvh0pqhk/fdXGVvXvCkKJZmKDhRZ
 UR9VGpFF+xZVjCvandYXU3W9fgWVo24dYktCMEtWShfbt1qZcps1gFjatqsTAMdtFvlD
 OT8WmL0oh7FYqk4Dsl9ILahd6wlPe+1v1nzdWWoURXAX+e6jCmzvnWpLCWiFD/LcJJpr
 ldzfTzxnWmJ9DdzpB0zdPHlWlkgy03LWd3Hyl0ZiwBtWQrtzWfl1Qb1gbjPL9fCYqyto
 S0OmWg5m+5LNgGgbxxlFNp+Z2NZfecoa3ac7nL7ehf20vBMEtqoZUdpGrC0LavUJdK4j
 6Kfg==
X-Gm-Message-State: AOJu0Yz2FtdT0J3Afgx6Uw/KdQKRwwF8ACVdkfQbbuTyA7k8vGrb+Lfz
 iSP0dCZiAJPcP5OqwWeM04iFj0nUKexlnuK6jc57ArUcbtlP0NRCzUNHXk9uegnqlZ0=
X-Gm-Gg: ASbGncvXWczX3owGv3dfVQCNyt6mfxyq8e8yF7eQ8hga8cSZ6a/YZ5lVJC9lz6sH4ZN
 BjFY9wPYjuhATWYekIpuccEYhPzIqL/M8Ql5Xo30rsqBcXITsFelI+j3CS/KD878/qUc9XWw4xu
 PeXu9Do+OWTp6Xk/vGmTG8Y2qkAhB5iSy6QWUzHLfLhXh1/xziAY3ngz4+L0/zU0L+2Bloj2yGt
 5kZA2oF2ibBqVMi9R4teqUj4XCmJhJ43W2CsXWp6rBFa5asC38uYXdImddEDO2sftvFL++UT+ez
 N8GaaLC9ISbyX16yJ2+VNq2kp+leZ0ESwL+hWFpK8yEy3OB5zm8MCXPqSCrFeV6hlQ1OKxroNMW
 Uc0z8LUiDnVsU/f2u08Q0rVxqroq+IrwzF/Q5QLBTDUqqtfmWNoowXfICcUw1ss54Nd7Crav5sy
 B0ALDLK3RDvRMU7mSGLHIYseXuBuZZzoBNqIvt3MMS47wwD9Q8f5LEPR/tir2nwX/rjg==
X-Google-Smtp-Source: AGHT+IEtxEe9lnQjy7ooPhgA3zaqrYpBtI8R7p+w9Y1C/17SBEusB9WBqaGDyYbbUD/HV/GZcnMRmQ==
X-Received: by 2002:a17:902:da89:b0:248:cd4c:b43d with SMTP id
 d9443c01a7336-248cd4cb50dmr33336975ad.55.1756358952098; 
 Wed, 27 Aug 2025 22:29:12 -0700 (PDT)
Received: from localhost.localdomain ([64.62.143.197])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-248b6a16ae3sm23507495ad.137.2025.08.27.22.29.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 22:29:11 -0700 (PDT)
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
To: Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Aman Singh <aman.deep.singh@intel.com>,
 Sunil Kumar Kori <skori@marvell.com>
Cc: dev@dpdk.org, Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>,
 stable@dpdk.org
Subject: [PATCH v3] app/testpmd: validate dscp and vlan table entries for
 meter creation
Date: Thu, 28 Aug 2025 01:29:01 -0400
Message-ID: <20250828052901.4134670-1-14pwcse1224@uetpeshawar.edu.pk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827111837.3882892-1-14pwcse1224@uetpeshawar.edu.pk>
References: <20250827111837.3882892-1-14pwcse1224@uetpeshawar.edu.pk>
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
 app/test-pmd/cmdline_mtr.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/app/test-pmd/cmdline_mtr.c b/app/test-pmd/cmdline_mtr.c
index e16c5b268f..0c5897ada8 100644
--- a/app/test-pmd/cmdline_mtr.c
+++ b/app/test-pmd/cmdline_mtr.c
@@ -85,15 +85,35 @@ parse_uint(uint64_t *value, const char *str)
 	return 0;
 }
 
+static int
+validate_input_color_table_entries(char *str)
+{
+	char *saveptr;
+	char *token = strtok_r(str, PARSE_DELIMITER, &saveptr);
+	for (int i = 0; token != NULL; i++) {
+		if (i > ((MAX_DSCP_TABLE_ENTRIES + MAX_VLAN_TABLE_ENTRIES) - 1))
+			return -1;
+		token = strtok_r(NULL, PARSE_DELIMITER, &saveptr);
+	}
+	return 0;
+}
+
 static int
 parse_input_color_table_entries(char *str, enum rte_color **dscp_table,
 	enum rte_color **vlan_table)
 {
 	enum rte_color *vlan, *dscp;
-	char *token;
+	char *token, *saveptr;
+	char *temp_str = strdup(str);
 	int i = 0;
 
-	token = strtok_r(str, PARSE_DELIMITER, &str);
+	if (validate_input_color_table_entries(temp_str)) {
+		free(temp_str);
+		return -1;
+	}
+	free(temp_str);
+
+	token = strtok_r(str, PARSE_DELIMITER, &saveptr);
 	if (token == NULL)
 		return 0;
 
@@ -117,7 +137,7 @@ parse_input_color_table_entries(char *str, enum rte_color **dscp_table,
 		if (i == MAX_DSCP_TABLE_ENTRIES)
 			break;
 
-		token = strtok_r(str, PARSE_DELIMITER, &str);
+		token = strtok_r(NULL, PARSE_DELIMITER, &saveptr);
 		if (token == NULL) {
 			free(dscp);
 			return -1;
@@ -126,7 +146,7 @@ parse_input_color_table_entries(char *str, enum rte_color **dscp_table,
 
 	*dscp_table = dscp;
 
-	token = strtok_r(str, PARSE_DELIMITER, &str);
+	token = strtok_r(NULL, PARSE_DELIMITER, &saveptr);
 	if (token == NULL)
 		return 0;
 
@@ -154,7 +174,7 @@ parse_input_color_table_entries(char *str, enum rte_color **dscp_table,
 		if (i == MAX_VLAN_TABLE_ENTRIES)
 			break;
 
-		token = strtok_r(str, PARSE_DELIMITER, &str);
+		token = strtok_r(NULL, PARSE_DELIMITER, &saveptr);
 		if (token == NULL) {
 			free(vlan);
 			free(*dscp_table);
-- 
2.43.0

