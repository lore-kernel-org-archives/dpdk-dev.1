Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7C3CD4F3E
	for <dpdk-dev@archiver.kernel.org>; Sun, 16 Nov 2025 19:01:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DFAAF42709;
	Sun, 16 Nov 2025 20:00:45 +0100 (CET)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by mails.dpdk.org (Postfix) with ESMTP id 8B90C41153
 for <dev@dpdk.org>; Sun, 16 Nov 2025 20:00:43 +0100 (CET)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-7b9387df58cso4869580b3a.3
 for <dev@dpdk.org>; Sun, 16 Nov 2025 11:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763319643;
 x=1763924443; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RdSvE1fwE0hovACbZUMxJ2r+SiMaoD2s6kplsmoLVi0=;
 b=Uzmwq0CjrMmujYBQdxuUT1e2X5XV1QkEPXdw8so6kh9mLXxalBuRBnImzijwJvMoqR
 AgzWEGIUftuIsVd3isPczv75Ah7LaVMlhsrd93klx9jcwuh9TWw2Qdrwu5YgAaNysrhn
 Sv3Qz8SksMVBOLxJ2nTUa4PZOdB0zkxAxv6RSeRLtV+c8Qtgavvw/p7vy5pArGMGZVjD
 c8xxXUy075OJjh2n0vHzolgz8Wq1uSx/ixUCCfz+qpRk+bwMLZzpRZ3r0JPSs1cHM089
 HX223tqJvX+mYlvmUbJtjoggnoAt0TdncK0tgv6X4qT5HorrWtuuhHdPcwJYQlnt40Dj
 iQbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763319643; x=1763924443;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RdSvE1fwE0hovACbZUMxJ2r+SiMaoD2s6kplsmoLVi0=;
 b=mWDGquOO8+zzzkGSmSlp3Iv7ue9G+eRDOxDmoEFou2wUlLhhTexgWZc+piBYosbvKH
 Ge/KefCS5cx7IbNFR+fVm2DkVb/IYo9gAituYpch++eqjbFjILCFhloJSw0LgERGej85
 IO9r7YfIbuTk3Of5y2xQOrZh4OgDJW2yNBgYff10RT0zzJ9UjxbC2XQFK4tmc9JISeYw
 ZpSunTrPTjrOwxEfuAogKGfgH2NIfHGKC4ih3ih5UB2h4iTU3p3DtVh1+cXw6+r2qyKS
 rVEkbDCJ3LdfX+UX/FbLaHSMrG5cVbbvOgLhAm6niZiLY+KX1+XNlyzPJbCK6vv6mcHT
 P5zQ==
X-Gm-Message-State: AOJu0Yzkl3Hgyoq6/c7eCdRw+2ULrd3wqf9Hcrt9wCmZfzTbhzh2l5/t
 86L9XwgbXM0OJYxZZoQuvgtear9UkbAx1+9v/wKiSSRwtmyc5u5bsgSLbQpuu35/DQWFfa2PqnU
 wnzMq
X-Gm-Gg: ASbGncvE27Udd4XGBlQtfQan8mV260ZcGFLEvRzGZDrLJWWKF+cbwAud+Xgz8xHvN7y
 KUSzhliQLyvP2H5h7VyRTY/vpBDacX8DiWDwPFESNaZipS1cuH61TG9EZALq9EqrwZ4+aAw79uk
 bZaF+Xn3WAgtHRepSRa2wyE2FhKkj5R1VKExOZHDv30kXzATNJvzKzELA44gD0aFO4JR3MDZ6ug
 KJ8ghteMypMZXDiFkNOzrHlr5eM37A+b/cbpyxehnK4o+lpimHsYZl4M6X6lrrlGI9iyRAJFX0a
 oWKCIeq3K9a8nIFWk1//tq2hM0kQhq4PJL2Q77qxXLtNJcdFYiqPf+6O2R5FQDyzvx88Qmj08bv
 FMLdLOwHfD0sPAKsap95uqoV440A1BpHz23OcyJ8KStnjzFnaqlnJTGcPsILkQ3v1J2+E//KZNd
 mnL1hYv0zswXHJqxm0JNfiiokV1rOKAj/c2WQYd5oedK7jmcYULOlPy24d5BkP
X-Google-Smtp-Source: AGHT+IGZDGU7ucdMLy93p2PKptSg6kDawYRjCDxdWs0vFRq1uhCtPxuqNajCgz2xV7orJYuQpLZi7Q==
X-Received: by 2002:a05:701b:240e:b0:119:e56b:c745 with SMTP id
 a92af1059eb24-11b40f92bf6mr3065445c88.10.1763319642523; 
 Sun, 16 Nov 2025 11:00:42 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2a49dad0aefsm28215946eec.3.2025.11.16.11.00.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Nov 2025 11:00:42 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>
Subject: [PATCH v2 4/5] test: fix format overflow warning in ACL test
Date: Sun, 16 Nov 2025 10:59:32 -0800
Message-ID: <20251116190035.76123-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251116190035.76123-1-stephen@networkplumber.org>
References: <20251115193409.99740-1-stephen@networkplumber.org>
 <20251116190035.76123-1-stephen@networkplumber.org>
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

