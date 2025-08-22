Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13C0CA0EFC
	for <dpdk-dev@archiver.kernel.org>; Fri, 22 Aug 2025 12:14:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 744E140A89;
	Fri, 22 Aug 2025 14:14:43 +0200 (CEST)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mails.dpdk.org (Postfix) with ESMTP id 393C840A79
 for <dev@dpdk.org>; Fri, 22 Aug 2025 14:14:42 +0200 (CEST)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2445806e03cso24479395ad.1
 for <dev@dpdk.org>; Fri, 22 Aug 2025 05:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1755864881;
 x=1756469681; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XzCtzXdlvuEIXVquRimWmafheHwLKk3uHgCkrTvdAjo=;
 b=YPrutFCeqSb6j0s/lwfJUioDCsonK9SPsRj4oF2FzNVIMGtBGkZjSj+7n1sYhCybl1
 EnifKiSjFLpw/tb2JtM/UHNQgPZvrK9jziMLvu5dP+lvpJQazCXfCLpf2Gw+x2G0kDWe
 svREFQ+/PptNsnb+MK5s4H6A28FL6oSFTP7bh++rjBWHtucYkHhSXYwwuu36ir+oYxQm
 a/C12J1uI7lnKf4+t0pcXjoO8Dv0vkyKENc45zNaRkFgXq1cqplddMPHi/S7NEQwd87g
 dio3o3izbfSF+JKHfh0inNnENXy7XPFzKJRxm9bow6x5qKQyUmwf8PwnJCGcYpgCp6J5
 lAZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755864881; x=1756469681;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XzCtzXdlvuEIXVquRimWmafheHwLKk3uHgCkrTvdAjo=;
 b=g6e8o9kn7Usa3uSGP50vO1//OGnkG/tck5mhW4VOTckWKHqJBclRlLiwKX+xdO2N8I
 jViSFPVuZ6r85gjQUcGnca10I2BK5OegLJ3yxkkCqYBc/xaxbZ1G6S62k3gKiYsxcO29
 SCzz2bCHS96+IkPD3ZAGr7rBEIlKSQtePaQu/XTV4bCq2s/DELI0Dq0ukPyb5AAr8jKa
 jVLjoiJP8O8cpPPurY4uXMHyB4PJZFFhArtorP9hgJKpxOK3+O9JvdkPfXMf6FfWAgsf
 9O8oLdXQYUdFEdEnkjMn1/rQQEd6efmp4/o2bJheW/eC0b0vs7ZLbdXWWpX6CbSCm9vF
 WrFg==
X-Gm-Message-State: AOJu0Ywmk4xgQEOJSt7hwJuKklZdp+SX8vuxjOAblZmot0BrUe67f3g5
 LISI2oH7zNsdTioJ2W8A7RvMF5GtCGD+gd6Jy5h496gwnd+MYiYioWxBip1jPx+oNV4=
X-Gm-Gg: ASbGncuM+szvJu1eJaupNne0/fx9MnYHsGxslB+6eIdFjbozO31hii9nAeypwhCBklB
 lZUuXIj4nfCNwmvJKtzkf1FaJunTy7tr2j5BeStkV4ja5ddwB9ZmCl+RKwMo2xE7VjsdC8zhKaA
 Koea5f0V1PHG1dOce1BW/A5Ez+0vwaAAOvFhLcstXCOce12ZDwRpcl0i5frDdJ7vsrzdQ55C/Kx
 qLYhDzlTF1BQEt7Ln8FtG9payBSlynEN21pfO+GrqPci4c5FtHQ5qAgw5tIgXx2+CN07QR4spC0
 M+NPlEzO8z8POqkb+S6zvebyvd1YO1vGtgBIjxrVkxeICD3b8so8STiBACdFIVnVvOnGHbVHW8q
 VbB1OQWFdMEBE+TgFs062lWiyQ3ObAhLPLHhq4BW/+phftJZGoO3oaaVP8pGVV01o6Iwu4WoT/E
 J4SwI8RL/Zzewi7kL+OMOarCyyQeBROI9L/Hk4in0azlVcowKoDLX9
X-Google-Smtp-Source: AGHT+IF8UFfQLJI/2vdwld1hlGx/OfGFMAKa8AKinueiuHUqHCLI1AIHfqyRAUEiuhVVtYjsV4e4UA==
X-Received: by 2002:a17:903:124c:b0:234:d292:be7a with SMTP id
 d9443c01a7336-2462ee0b991mr40670305ad.1.1755864881213; 
 Fri, 22 Aug 2025 05:14:41 -0700 (PDT)
Received: from localhost.localdomain ([64.62.143.197])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-245ed33cac4sm82875685ad.16.2025.08.22.05.14.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Aug 2025 05:14:40 -0700 (PDT)
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
To: Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Aman Singh <aman.deep.singh@intel.com>,
 Sunil Kumar Kori <skori@marvell.com>
Cc: dev@dpdk.org, Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>,
 stable@dpdk.org
Subject: [PATCH] app/testpmd: validate dscp and vlan table entries for meter
 creation
Date: Fri, 22 Aug 2025 08:14:30 -0400
Message-ID: <20250822121430.2228507-1-14pwcse1224@uetpeshawar.edu.pk>
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

This patch validates the maximum possible dscp and vlan table
entries for meter creation.

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

