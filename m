Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86076E92FE2
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Dec 2025 22:01:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 62BE340662;
	Mon, 29 Dec 2025 23:01:11 +0100 (CET)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com
 [209.85.218.43]) by mails.dpdk.org (Postfix) with ESMTP id DE62D40659
 for <dev@dpdk.org>; Mon, 29 Dec 2025 23:01:09 +0100 (CET)
Received: by mail-ej1-f43.google.com with SMTP id
 a640c23a62f3a-b728a43e410so1787910266b.1
 for <dev@dpdk.org>; Mon, 29 Dec 2025 14:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767045669;
 x=1767650469; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WmT0N/n74EPEE6smaUUFOrqeqMbkWMQqkiLgpTfyWr0=;
 b=GOGPKX6gozYSsdIeWp+OraQvpxBlWoDTwWVZTyOiueXDmLDIWdZwd/TgtdlXr63U6N
 Eo8E+L6XEggls+R3Ei5XNIRxm3nPa3QehRQHmZsFDPqIPiWqGfVOp481c6txjS/BXLSm
 YMCM6w3Ebs3Z1wZVyOJxGTf3LtivjV/gzDb2AOEEB5Nichtxo4cWsffDGw3tp3AC2ULH
 sqQBKDwqypDZJ9wTWsGJKrscLJUVWfejok8NZSsJ7nyYYpda+F3pNfv1g+GlC65S7Fw+
 LW+MlZoqYEoCrggm8T1qmJHnaXZ3xVa0WxhqkX+rbcSRqYvc7IQIVfq0e6xAB8nE99ND
 MV7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767045669; x=1767650469;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WmT0N/n74EPEE6smaUUFOrqeqMbkWMQqkiLgpTfyWr0=;
 b=WOLfVbovu/IsZPQozDzHcCZ4KoMFl+J4M13RORBu9Onxy0eh656doVriu/glwbvam3
 gxQAmg88UfktPkcQsehvLtoRmPhxE3W2vMw01KhrQduTtQ5a7Bt2uXSQ7MmeBNSB+fPx
 uJZtePElRTx7+wt5wwS0WXwOEP5IYIho/sYEMlZRwxubg3X3JlhOLmAAoIk2FTgOqXa2
 xpAKx+568fv9XNINTLjztA5Mrmb1IJco9OI2UAVLyu7JIPHMfWU6QyePRO5nGCkrATpG
 4KsjjWpspy+vvu2W30VgguIz8S2eujHiOp5j4KWrlOENUpOVuaTJCruk4gxyd+ygZLDt
 T/wQ==
X-Gm-Message-State: AOJu0YyXuzoVesCEngs3WKtMM3v7Z6x6NnFMvgSOleysHOBT2JPeHyen
 7AYISIPZvEwKwVGc2JqAYmgMhVvwWq12Go6mS4EzlUGTxdklnQ+FyyrjOL93U7N09OKSNhmxqOl
 570Z1ea0=
X-Gm-Gg: AY/fxX55qE1ASxBhGWHD+NgXEjY0gz/HUKRTo8cD73PEkIV7yk8DGYIY4DOGzC17XKs
 LwWbnl3X2fTt/QpEBEtXgB0lgMwjpjOnPX2zv9nRUXBT+JLxwuvjT6Tia/ZoNCE6DOQ0+8RyNX5
 WNYnpuYn50xKOLVUuNFYSPPpEHhwgV+5jvFHHttr0INHZf8s5bGEbclqtbNyBBqqgmrEzJ09bvX
 9as0R74d+kNRfY+kE6aqPh67B4UGnVmArrGRo9gJw7Se6sEzq++zf8p7jfb9cA0MSZpD4Yzd7JL
 R89eNRJ8Aou4rHbsKNa11SUOiBk/AjsSy91TdkAhcplJZ/bOKUjvFNHC2iHkIt9UMNcetrgPNdK
 SmZZz74wz+FThzLB0biaG+fZ5runyv+LWguJHgmBYj6TfclGpbYvuND6u7ajJNJkcOem+7jUl7w
 hv4xuCG6OVKBUQIf7VGzLEPBQcmJyn9j8RrgzkV3JAQCyiDcUmLg==
X-Google-Smtp-Source: AGHT+IG/cVYEOWQoXZRcfl45z0AM++rb7cgAPgEmnx0WeK0qgma3tKkpxp9lnaE3FDtv+qTdMTx2Sw==
X-Received: by 2002:a17:907:6d06:b0:b71:854:4e49 with SMTP id
 a640c23a62f3a-b80371d4462mr3466005966b.56.1767045669337; 
 Mon, 29 Dec 2025 14:01:09 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8037a62973sm3496359366b.6.2025.12.29.14.01.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 14:01:09 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v10 6/9] test: fix impossible format-truncation in cfgfiles
Date: Mon, 29 Dec 2025 13:59:06 -0800
Message-ID: <20251229220053.21981-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251229220053.21981-1-stephen@networkplumber.org>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20251229220053.21981-1-stephen@networkplumber.org>
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

Although, it is not possible on Linux (which always uses /tmp)
the compiler complains about possible snprintf() truncation.

Use existing code to make empty tmp file which puts the
OS specific code in one spot and avoids any races if
two tests are run at once.

Fixes: be22019a58c4 ("test: restore cfgfile tests")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 app/test/test_cfgfile.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/app/test/test_cfgfile.c b/app/test/test_cfgfile.c
index b189d9d7a5..eabf155404 100644
--- a/app/test/test_cfgfile.c
+++ b/app/test/test_cfgfile.c
@@ -178,12 +178,8 @@ test_cfgfile_realloc_sections(void)
 	ret = remove(filename);
 	TEST_ASSERT_SUCCESS(ret, "Failed to remove file");
 
-	char tmp[PATH_MAX] = "/tmp/";
-#ifdef RTE_EXEC_ENV_WINDOWS
-	ret = GetTempPathA(sizeof(tmp), tmp);
-	TEST_ASSERT(ret > 0, "Failed to get tmp directory");
-#endif
-	snprintf(filename, sizeof(filename), "%s%s", tmp, "cfg_save.ini");
+	ret = make_tmp_file(filename, "save", "");
+	TEST_ASSERT(ret == 0, "Failed to make empty tmp filename for save");
 
 	ret = rte_cfgfile_save(cfgfile, filename);
 	TEST_ASSERT_SUCCESS(ret, "Failed to save to %s", filename);
-- 
2.51.0

