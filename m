Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF67C44506
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Jan 2026 21:08:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9FE0742E80;
	Wed, 21 Jan 2026 22:08:24 +0100 (CET)
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
 [209.85.128.66]) by mails.dpdk.org (Postfix) with ESMTP id 8E74D42E87
 for <dev@dpdk.org>; Wed, 21 Jan 2026 22:08:23 +0100 (CET)
Received: by mail-wm1-f66.google.com with SMTP id
 5b1f17b1804b1-47ee301a06aso3382025e9.0
 for <dev@dpdk.org>; Wed, 21 Jan 2026 13:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769029703;
 x=1769634503; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bbs4p8Zf5fG0wh5pZQmnyKip7RhZ0QufmWBpfOo4Rko=;
 b=CFzKjo2tXitf+CEAP1tqBpaln7j9rEZ5OfH3d7bw4uWm2SnIejlwuvQHk0eWqBSroQ
 doMlPHRuynxcc8bPpWbISau8HlHtwZeiTZXjfzxqrj90P5Mgk3XyZpQJ/uUDJEqVbvqB
 PIutbzuhPcQvZkzvNT5bwLD1ZNeL1XbRB/c/VKhr3peqhmMw9XUXFEkFepxEmStUzt+y
 BEGnrDdyHlRKvM4RYQuf/LOrRkAMm1u3ti2kxS0gbeYlzSdSJeqtpWCHPxBme8A1qZ8e
 0Ae/VnY5r1NzQ6ZZagdevxmXx9ktZJWa/59mlIRcl+B7TClRlDVjoPCLRNO9gWm26XrF
 F/FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769029703; x=1769634503;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bbs4p8Zf5fG0wh5pZQmnyKip7RhZ0QufmWBpfOo4Rko=;
 b=b39a9wsBEEDv/HwSJ663Gd6IlkpOuCJaKpAN6Dl/RNDlA/8T4m2B+qvEuk0bH4HjDR
 f0sepqWqEEmlqghGBPPw33sn3SVeXBlDsc1iFY25RRFKIeSr9v0/rsyzi78CCirWTUIr
 7YZrH+CHH1zE5lLj/YHno6o7H67j1KGcZ2TzQu6ZsVrrFbcUqXtxYU6+L/qNDmqmvhhH
 laxH4sP9/NJfVTpcLnNPoH1/aRvXShjsCOQlxznuQAbjsktjG3IoTTons7dG4MDy2Tgj
 ns99QhJPxBrFQNHmUT/oNofDlh/txM0y/8QT3oX0MQnD+U6xi4nxh3b0jV6klRzrjiT5
 xfAw==
X-Gm-Message-State: AOJu0YzJ5B8NOeeUS/GTZZrlnES4LnRfNGwrajwSkGaLNXbpGPo0ALp2
 V0Lq1iXDHT1wXWkAgb1ZuXdZXLVK+VqbXsmzsboXyoAn2QilTRYjX6S7OgSe6eP/WZA2BshBUjz
 F/5SP
X-Gm-Gg: AZuq6aKK54uPUoD4WvmVCQRnPa2HnKscSVmWrFqlq1spt0rF/+QcsGmS5d7MbhLhHKh
 fr1ScvjBy0ehYSoT0LCbtDq9pNkq6Mp065omiSoWeH/yVbd5DPhn2OCvS69uwRRKFLMFNILS0Hh
 jkz1P9iySaDn5wGhEVrVy3w5EXqESDsfD6nPKc+eE9UnY1oK7NcQtIT5tUl/614ZU9KE5rZEi3g
 aK+i3DJLFFZr1m/+Sr+KkGRLwOM0J9AswmyH6AP1UnoxQcGKZVEn1wdoyEhZPlZMyVu6rCyYjdP
 LKjrWNwOpFViZOmxsF1wIWlSMkvc349yy/Sy7lRL6A1tITgRRobD9NrGIg+XcHcJfZeNfhMvWda
 ifQTXRMcE/M18BBUpwCbgpXTPrkKoffY3UJ2hZLbxdR04nrzt1UBykNa7+IHhdPPpz8P1VI6cPJ
 axZl+4ZUsklZgCElM/Z6ES/JWYjJel6npDsWT+vAPctHK/OLliLA==
X-Received: by 2002:a05:600c:3495:b0:477:639d:bca2 with SMTP id
 5b1f17b1804b1-4801eaadbd9mr245690245e9.4.1769029703063; 
 Wed, 21 Jan 2026 13:08:23 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48047028928sm27539845e9.2.2026.01.21.13.08.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 13:08:22 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Pablo de Lara <pablo.de.lara.guarch@intel.com>
Subject: [PATCH v12 4/8] test: fix format overflow warning in ACL test
Date: Wed, 21 Jan 2026 13:06:24 -0800
Message-ID: <20260121210810.1044276-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260121210810.1044276-1-stephen@networkplumber.org>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20260121210810.1044276-1-stephen@networkplumber.org>
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

This test has an array of input lines, but the two dimensional
array confuses compiler length checks. Convert to an array
of pointers to fixed strings which avoids the problem.
Make both variables static since not shared with other code.

Fixes: 5205954791cb ("app/test: packet framework unit tests")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 app/test/test_table_acl.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/app/test/test_table_acl.c b/app/test/test_table_acl.c
index dff9bddfb9..7b6ea16cfd 100644
--- a/app/test/test_table_acl.c
+++ b/app/test/test_table_acl.c
@@ -312,22 +312,6 @@ parse_cb_ipv4_rule_del(char *str, struct rte_table_acl_rule_delete_params *v)
 	return 0;
 }
 
-/*
- * The format for these rules DO NOT need the port ranges to be
- * separated by ' : ', just ':'. It's a lot more readable and
- * cleaner, IMO.
- */
-char lines[][128] = {
-	"@0.0.0.0/0 0.0.0.0/0 0:65535 0:65535 2/0xff", /* Protocol check */
-	"@192.168.3.1/32 0.0.0.0/0 0:65535 0:65535 0/0", /* Src IP checl */
-	"@0.0.0.0/0 10.4.4.1/32 0:65535 0:65535 0/0", /* dst IP check */
-	"@0.0.0.0/0 0.0.0.0/0 105:105 0:65535 0/0", /* src port check */
-	"@0.0.0.0/0 0.0.0.0/0 0:65535 206:206 0/0", /* dst port check */
-};
-
-char line[128];
-
-
 static int
 setup_acl_pipeline(void)
 {
@@ -343,6 +327,20 @@ setup_acl_pipeline(void)
 	parse_5tuple parser;
 	char acl_name[64];
 
+	/*
+	 * The format for these rules DO NOT need the port ranges to be
+	 * separated by ' : ', just ':'. It's a lot more readable and
+	 * cleaner, IMO.
+	 */
+	static const char * const lines[] = {
+		"@0.0.0.0/0 0.0.0.0/0 0:65535 0:65535 2/0xff", /* Protocol check */
+		"@192.168.3.1/32 0.0.0.0/0 0:65535 0:65535 0/0", /* Src IP checl */
+		"@0.0.0.0/0 10.4.4.1/32 0:65535 0:65535 0/0", /* dst IP check */
+		"@0.0.0.0/0 0.0.0.0/0 105:105 0:65535 0/0", /* src port check */
+		"@0.0.0.0/0 0.0.0.0/0 0:65535 206:206 0/0", /* dst port check */
+	};
+	char line[LINE_MAX];
+
 	/* Pipeline configuration */
 	p = rte_pipeline_create(&pipeline_params);
 	if (p == NULL) {
-- 
2.51.0

