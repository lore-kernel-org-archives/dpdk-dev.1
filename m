Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E9ACE8D6B
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Nov 2025 17:54:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F3A92402E5;
	Mon, 17 Nov 2025 18:53:43 +0100 (CET)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by mails.dpdk.org (Postfix) with ESMTP id 0BB54402C6
 for <dev@dpdk.org>; Mon, 17 Nov 2025 18:53:41 +0100 (CET)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-b55517e74e3so3638372a12.2
 for <dev@dpdk.org>; Mon, 17 Nov 2025 09:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763402020;
 x=1764006820; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VN44TebtzgLwJlKcYhgTRWjdzqlWwvrDtTMcE8IROAY=;
 b=EYnwJyzgq3uHdJBATDVYC04QBfOFFKkog659BU8TZScoY4jmyxpy83t8hJ3NOnf8/q
 iuc4AZl6jqf4SVKVKwJFl1O7yFnIOLyLQuM4/doZOjWzwWYiS6MrPISebDHVL6cNXspZ
 BIqle3QPzubh3xkKx+427vWvSiCJ/v/sW/nEovt/P06CuMKIRgIAU+Bdz+xqwSo6CiwR
 6a6SkToWxAxPUw0hdwqnDgyUyHTlRqM1oeNuDLrB7OfMiTkgG+Q8xgDKeXag3ckCnJax
 NZ88EF+PL+2CZ6lP0MAIiqwLkT3wsWsvvxjPxenN/GjNOAYMFvlL4EbfCmT/6BF3vmpa
 ov0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763402020; x=1764006820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VN44TebtzgLwJlKcYhgTRWjdzqlWwvrDtTMcE8IROAY=;
 b=KbtH8lCBELQdOlsPbFZGBD+eLPIFRz6RjNfMC/dB1SwWOEmy8N8oxaCPMYCTNFSCIV
 31/7fJq0kNh4pJ79UACJp3eVS9rsgvzd8u2fmCbsZ8uscO68OKG5oAKwSceZ4jgB4web
 EaHHyrpJt6KqpPgFcXFWu92o9Mw3WQb1bCv5usKMi/xuv9xM5HvMa0IP27ZarrfIc5kL
 t1u3hZnqmwDy+/7rm03EO8Ak/J+zyBPcEisA37Sc9mc5avQFrzOPqqqUuUQ299Jj90hK
 daVwvRHDgdAtt1rJyrCvROgd4pg+3j9W7HYuk+emdH0sb4qtydqpWv90ZFPHKqdcB0jy
 oyUw==
X-Gm-Message-State: AOJu0YxNhG+Z5LlB9Y5jwEIoOhg55ACs+cvwXOIWQE0LWQl1sYipq7fg
 rmjQrR79g6H1sQnF+NTHQvuImHKCWV8RLnj2ZdzfdYPeiFyYS4yBrHKHQZ1jsUWrCiWFpGEedf+
 VOfuv
X-Gm-Gg: ASbGncsAyPPfkDH5Is+D3lq/ZKBVkLImMfdViz1LpHTm4Zmx4mi5EEh3LCtQ3z8bc3C
 s6m38z0QAqcGd/77hpFsrpTgA78L8pT2kFDdBTY1Bl7pcDfjMXCawJbLj1OFYQnFSE7HSPjZ2WH
 UHG1IOxrAUo+SpOzHK1CdNkAorTPUwhm6fCL5TJsmhkF/+qN46EWQTbSUK4T3fpWp1ppG2SR8q9
 zxP8VfmBn/Y3+7R/rKpd73rWT+ljWJjqkmhhH8O2KOO/1WZD9E9t7cpSmZFDLUqPfZJ9cLpHTwO
 I/OkCd1cDbhnSrvlCO0HjcRKW5odx2oBjXB2Ccx8KcC52v9phBKUxgjy1QxfFfHYzB3DWLMv9vh
 y8Bq43w4IUj3xfMyC/2dacPKjm8RsKX3uzyUugdqC//S7GVs0QiMT3SjkrNcKpP6Rgcto27Ia7w
 QirvGi8qvobALbuz41LXSp5ot9w+Ya19XGIxx9uhOeIADQwF620w==
X-Google-Smtp-Source: AGHT+IHwtxoe7DGNIqTePU6WPLe1BSqnDphJVZkFotCC++fmGGOZ2eiumTU74VbyhwPEOU0Vwm3aGg==
X-Received: by 2002:a05:7300:7892:b0:2a4:3593:c7e3 with SMTP id
 5a478bee46e88-2a4abd79e8dmr6778366eec.35.1763402020017; 
 Mon, 17 Nov 2025 09:53:40 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2a49d9ead79sm63457494eec.1.2025.11.17.09.53.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 09:53:39 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 cristian.dumitrescu@intel.com,
 Pablo de Lara <pablo.de.lara.guarch@intel.com>
Subject: [PATCH v3 4/6] test: fix format overflow warning in ACL test
Date: Mon, 17 Nov 2025 09:52:11 -0800
Message-ID: <20251117175332.14014-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251117175332.14014-1-stephen@networkplumber.org>
References: <20251115193409.99740-1-stephen@networkplumber.org>
 <20251117175332.14014-1-stephen@networkplumber.org>
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
Cc: cristian.dumitrescu@intel.com

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_table_acl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/app/test/test_table_acl.c b/app/test/test_table_acl.c
index dff9bddfb9..94edf37234 100644
--- a/app/test/test_table_acl.c
+++ b/app/test/test_table_acl.c
@@ -317,7 +317,7 @@ parse_cb_ipv4_rule_del(char *str, struct rte_table_acl_rule_delete_params *v)
  * separated by ' : ', just ':'. It's a lot more readable and
  * cleaner, IMO.
  */
-char lines[][128] = {
+static const char * const lines[] = {
 	"@0.0.0.0/0 0.0.0.0/0 0:65535 0:65535 2/0xff", /* Protocol check */
 	"@192.168.3.1/32 0.0.0.0/0 0:65535 0:65535 0/0", /* Src IP checl */
 	"@0.0.0.0/0 10.4.4.1/32 0:65535 0:65535 0/0", /* dst IP check */
@@ -325,7 +325,7 @@ char lines[][128] = {
 	"@0.0.0.0/0 0.0.0.0/0 0:65535 206:206 0/0", /* dst port check */
 };
 
-char line[128];
+static char line[128];
 
 
 static int
-- 
2.51.0

