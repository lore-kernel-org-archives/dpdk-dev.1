Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5520CCFC518
	for <dpdk-dev@archiver.kernel.org>; Sun, 23 Nov 2025 17:45:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 53A1040613;
	Sun, 23 Nov 2025 18:45:24 +0100 (CET)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by mails.dpdk.org (Postfix) with ESMTP id 6D06C402DD
 for <dev@dpdk.org>; Sun, 23 Nov 2025 18:45:10 +0100 (CET)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-297e982506fso48779955ad.2
 for <dev@dpdk.org>; Sun, 23 Nov 2025 09:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763919909;
 x=1764524709; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fm0fKRDS4YRVts/D6rPe52eqre9y2vs0bibayAdUECg=;
 b=QM9RjW6Zo3Ic1EHJPOS8c/xXC7LAHQqMzkNPJ2ywBmaX+B7176kgGGg2aW9Uvf1QRo
 Z6Y/zpHC/sM7Xc4l2o4pezdi23uE8hAq1evxp9ywy/Pk6TY+dvX1DKTLnC1WiaCsEi/2
 ubbxmJAtJB2R+PMRC/p+N7f9XmGsyHBYXB2Ioy38T2ofVhKS9w4w4EvfOjS1GG24spYh
 Svt36TqsVAAEcdbWPy7rUa8/YZciazs44iv7KOJjjjhy1cCRUVIDu4iCMuKLh3aqrMHe
 +hYWnGq/yofZpxVs+Q1BgfEgP/8jmJYYkevgNgseA7quMsRpZ8gLJukk3TQhchsHIMT1
 cTcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763919909; x=1764524709;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Fm0fKRDS4YRVts/D6rPe52eqre9y2vs0bibayAdUECg=;
 b=Eld12fOByOmova3hHu63sR5eXeL2EmmtFtPWTPA1cB3rAKkOA7RRMBsv56I8oakbkt
 DP2YpqFZWuJYwbOP2ZzaKwMed5/y/6TSJ2KW4rc7owKZe4NIdr3dOKbC80GEqwagUEOA
 55UZtl2PeUIgiyar2hxQrWvUOowSFeR3ce755WBrF1Wo/u7nBQgvaO9EXvoGZmRo5PAE
 Dedpyro1TNT/NCr5+0DxXBTyk9CpP37TXfVjhVPNeh6Cjhb38LKbcB1x8efLjJawdL9p
 9M0xNuUPtN4gjkE0POB9jRWu6/sX8E03+ukGOWsdBhzPmSGOlROw3zUbaNslhPfr+M4s
 LFRQ==
X-Gm-Message-State: AOJu0YzoFOEyXKh2G7jKxVGGTlmy7Lc/333dId2HTHznU7XSV4h420/o
 SaLSr8iqdiBtIYxNizkCgfotPWF4UnMJ6rts4qCW9jVNP+Cx9FgAuRLRcbRRUpSKAB0ounDRU2d
 G0IX7
X-Gm-Gg: ASbGncsKbFWos8wXv6FOUKvn505wT4TvkTFezm+coEXfvb6dPMYckcnV7bjPwPQ44ri
 wMi/W70YdXiUadPSL5sg0VADaxeFHOcazAoyfwrxqXFbpEH5Sfb6liZTATdvSriwfX64TUGUVMk
 pOAH26hNNweKJkffUnQekBQ45YUH2O1YHJmZfHMsnEaDjT1WGh5RlGZIYQnLwfEWEcCSbYh9mpf
 OxFDpBomo+X9nT3eCAGFhmJeWJY12JzdqR2A8+oGjK+KeXkhCrQZfdk2b6+PMcHLJ5QbUrZ8hxG
 jmarVWLnkuVa7xkS/E9YvW+qU7vq+/6/VXNU6Fw/tf8rEl29YvixfKkOoi6BqoBdeaPB6A0Flt0
 iHfyeP2IaVrfgcXQ6tMwLSz8FWyXjhe7c3ZiVrf5iqnTKJGsn0nM1gsCSM9uHYyXtVKjwi3yZdC
 qONLFNwut9JN0/oLEqp9Qszo2MNKgEUOPOIEI8mG/iAI9F0S599A==
X-Google-Smtp-Source: AGHT+IFRC55taxP/0j6tAKqCSVOYJ5eCMfn6pusbThjxGkFZOuCsBA9MkKZBkirBaVj2I2Q0S8GzUw==
X-Received: by 2002:a17:902:d541:b0:295:9db1:ff32 with SMTP id
 d9443c01a7336-29b6bf5d676mr104080045ad.48.1763919909650; 
 Sun, 23 Nov 2025 09:45:09 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29b5b13b973sm112585985ad.39.2025.11.23.09.45.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Nov 2025 09:45:09 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Pablo de Lara <pablo.de.lara.guarch@intel.com>
Subject: [PATCH v6 5/9] test: fix format overflow warning in ACL test
Date: Sun, 23 Nov 2025 09:43:28 -0800
Message-ID: <20251123174503.20880-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251123174503.20880-1-stephen@networkplumber.org>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20251123174503.20880-1-stephen@networkplumber.org>
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

