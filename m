Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 347C7FF5105
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Apr 2026 15:19:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E383D40A87;
	Tue,  7 Apr 2026 17:18:25 +0200 (CEST)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by mails.dpdk.org (Postfix) with ESMTP id 3B9B040A7F
 for <dev@dpdk.org>; Tue,  7 Apr 2026 17:18:25 +0200 (CEST)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-b6ce6d1d3dcso1829911a12.3
 for <dev@dpdk.org>; Tue, 07 Apr 2026 08:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775575104;
 x=1776179904; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lwZgshHbhJ6MIdbTT1dVVv8yG2fROyix+VMSSeejADo=;
 b=HxA6vlsLZkBiCvlYLg7bQE7nj6FA41pVVnIM5cGjQqR1V+Oiw4aMwGVqWRi8EAr7bG
 2IUNiGZyFRrQSM4ygkWjFDkehIxgFbEHwgXd8XZB8O/YM7AnV2vzylZs7iVYf50vbHzz
 wkYIwV60U8RWA+hfQfddMuR3cIy/PkArPKV7fqqAoOeg4FUGaC9/UhhaDmEoS25KQSfx
 FJGzOM43PNRKYbaBeT9oPpsP3Tci0bPRCu/aHrNg9yR+i/FjZIX0Bci5GUvXegdXwZle
 jraly1Gh/X6gSQZVBrF2W1TsIAbOXOxbbWFqFnVDrGpYlJdYCLKRUqXfB2mzQCcNauMa
 mFIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775575104; x=1776179904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lwZgshHbhJ6MIdbTT1dVVv8yG2fROyix+VMSSeejADo=;
 b=IofyDXZ7dcJ2YtdLuBjGHtgjHLcXRumwqcYrpWSJe94DhCaYhbl5Jdf1J9XgfO95Ox
 9SsIWOpHn6cU907916Csbs243UHyl0CzAC/ZBQYDCJ/nZHP7mWjQIW36RPLQ2wpRVLts
 jUViozgp2s/4nKoLGgnxIG5zN4BLFaceHnRvxMhBFjjfl8l5ZX6ptrUCcppPonSAwPKO
 FhI2u93XYanRCK7vki8fW919eFVfpUr9qIbc0khOqaHyPjXGxN47K0lWxxbEh2YoeLu3
 aNBTrF2QQJEFguNZsOdRbETxXRE7IUHa6+5sge3Vga9JZyYpmbDLn0bgqZ+G2BR5/Sql
 5+Qw==
X-Gm-Message-State: AOJu0Yxac6gnXmlvrzFZZE61JgHWOY4kcFhy7Gr/NjFLTCNYZp0fq+pN
 l3++7pIigV4WO3xXRoXMDUTVPmN3x0jMqiVGAsGRCpaH3i7OfD+dua37dHeZWGqQoLe72um0SaK
 YbGTn
X-Gm-Gg: AeBDieuefnwkjxfkVQoKtggF4Oc4essDf5zvOoIznRWO4gAbvx0DF1Z6lhIiUFv2EnX
 L3tns/N80FQwy6BFCEr98/8q+vDzKYVwltURHeF7d7DmuZY+EooA4thcEIPr0aJKKLliNVImJHX
 wdp8KqSeXPMXMm/HPeGefYCADCi4KXLmnj7b86UI/TrObY4sH9IV7u9zki5q4rWcTlyLbxagB2K
 Bt4rThWGUDTqbPWPpZ3Mqaf7dx+RfWu2y0mIBRiUeTOx9bbWC8Br0rG5aR/q+hecgkkfmNGMv0V
 ZYbcMOMDTQIZ3K1zufEmzrYin1kJrKPU5fR+5olt6uzpMGXuprf/Led3Jlfk9JezClG6LZBgSYf
 gIabSJ3wgtU8ityU6tfMsDksQvUIEjg6P6RoNWut0smDiPldS5gDuvrMypZFXVgrFDbT7V0KQhw
 ViVfep+MswwWGerA4M+EWsR9cR6I8UMc6c
X-Received: by 2002:a05:6a21:2d8a:b0:39f:82bd:298 with SMTP id
 adf61e73a8af0-39f82bd1d58mr7222269637.0.1775575104385; 
 Tue, 07 Apr 2026 08:18:24 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76c6477bbcsm15842933a12.3.2026.04.07.08.18.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 08:18:24 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Nicolas Chautru <nicolas.chautru@intel.com>
Subject: [PATCH v2 13/23] examples/bbdev_app: enable shadow warnings
Date: Tue,  7 Apr 2026 08:16:09 -0700
Message-ID: <20260407151732.272195-14-stephen@networkplumber.org>
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

Replace shadowed optarg with parameter named arg.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 examples/bbdev_app/main.c      | 4 +---
 examples/bbdev_app/meson.build | 1 -
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/examples/bbdev_app/main.c b/examples/bbdev_app/main.c
index 03f15f91cc..5ac70dab59 100644
--- a/examples/bbdev_app/main.c
+++ b/examples/bbdev_app/main.c
@@ -214,7 +214,6 @@ static int
 bbdev_parse_args(int argc, char **argv,
 		struct app_config_params *app_params)
 {
-	int optind = 0;
 	int opt;
 	int opt_indx = 0;
 	char *prgname = argv[0];
@@ -269,8 +268,7 @@ bbdev_parse_args(int argc, char **argv,
 			return -1;
 		}
 	}
-	optind = 0;
-	return optind;
+	return 0;
 }
 
 static void
diff --git a/examples/bbdev_app/meson.build b/examples/bbdev_app/meson.build
index 283a9551b3..ea588e8706 100644
--- a/examples/bbdev_app/meson.build
+++ b/examples/bbdev_app/meson.build
@@ -11,4 +11,3 @@ allow_experimental_apis = true
 sources = files(
         'main.c',
 )
-cflags += no_shadow_cflag
-- 
2.53.0

