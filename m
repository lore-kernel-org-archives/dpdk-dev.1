Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326D2C9830C
	for <dpdk-dev@archiver.kernel.org>; Sat, 17 Jan 2026 02:38:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2364D42F0F;
	Sat, 17 Jan 2026 03:38:35 +0100 (CET)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
 [209.85.218.51]) by mails.dpdk.org (Postfix) with ESMTP id 9C1D242EFC
 for <dev@dpdk.org>; Sat, 17 Jan 2026 03:38:33 +0100 (CET)
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-b876f3f603eso462781866b.0
 for <dev@dpdk.org>; Fri, 16 Jan 2026 18:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768617513;
 x=1769222313; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hmdTmiW/21omU32vm+w9i24hOTGLuLxiFVgnit5uRGU=;
 b=bc/QVF424kOMgGRbv5QHGJ1DXO2SjBka56InnBVkbV5pr08938ka5yhV+9A+r546b4
 HVMWjaT6EyK1meN9M0U21t4gQZ8KEQhhPIQSfmuJTP/gl/u82u9SSMbKV6k3RStGdgM1
 sUH6aMPYRu1pTxIPnw9KgmIztT6ce9Xr03zhKLz+TWgIgiZECAGsJcZbSvlsjXtfoY6S
 f2sSBSf1Gc3zNSBKvJuThghJhj9ms4DQWbH3xMP0e3n792GTma5IMquNGyKVPl9F718a
 xkK3EGPP2A9WbxvV0Oj6heyrsg8CMwKk5wAAJIPnQx593B1C53Cx6PCbup16kuNlPNX2
 79JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768617513; x=1769222313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hmdTmiW/21omU32vm+w9i24hOTGLuLxiFVgnit5uRGU=;
 b=bLCAX5hIG7OD8Odp1pTsQW0vk6vAKdokKcrxEaq40FF3ct9E+8n3HSsFyoQTpqxYkR
 eQudm+R/d5akKC2BXvKxVxMUaszirmv54+zdf/UKwXDJI+jRzh/j1QBrPj/hySf8wup2
 kIMnh6CDDa+tEERuzHeALskc56Hgpqb2/n0VYS9spqFq8yjUn9NQceTdB1BZ4b8wt5SE
 L8HJjtJAyMi5Umj+Tiv3sQ98ZL0m8PPOvzmuf4fR9rayxSFO7aoR/pXBeLeXDonq9dTr
 j489mwB8TkiyN3m/wNNJpxY3beGyxoG5kTAaA2echy42FDHSDGiqMS2azEI+QDctEg1V
 WRog==
X-Gm-Message-State: AOJu0YwDFjUXtbt0L1ttq76VSqGPUvIcd2gKE0xPsyGxgKVSZ42c9EP5
 HV006im87sDZENC6oCHk2Z3VhPrr14KhI4NA27UjcQ5QdnG9DqyLSvcUMZah5vO4utzb7UZBIfP
 TduBb
X-Gm-Gg: AY/fxX4DGxTDWipgVlHN+Z+/sirgqsxz42uhItsXvT16tWSh7BuHNV2qY86dYeXmY3p
 mHyT2dTIRJSilZ94VNuI14tPBDz/mgk0DzEQsAzEMJ4aGla3mzqm44XqGRGtfXEpfAmlrOg3iW9
 2XwnoSdcR3UdyIAu0yb6U1VJPwzz1HgKLOxGNXSBPLBxKYLuHIS6e5zmwnRi3kCWXr2+owusHuA
 0fHXKUqrGhMvREKnMqmLsN3pNr/KPfiWLMtJYCHMN/k/o6vfmeYA8QvZababDLyt+YqfZSbS0yZ
 JDKyUiUPDgF+AINQLeHvK5n8MVqTvEwq5Xf4E8tEvEUhVqDQo/sGIemJKT0RpxNxQDNrFaDnklr
 FnsF2dkN+dto7CKZFv0V+SqIezvMQyHsHOrkOqOGVAgk1aw4aCn0Fp6WldkLmUoP/6h0cVaGlWM
 JHRYMbqiPZlrghxclYj6cU4Rm8bNd5mR5Rzgot3QhsMlL0d+4GJA==
X-Received: by 2002:a17:907:3c87:b0:b87:701d:342d with SMTP id
 a640c23a62f3a-b879690c555mr396557366b.21.1768617512536; 
 Fri, 16 Jan 2026 18:38:32 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87959fb980sm439960166b.49.2026.01.16.18.38.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 18:38:32 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Marat Khalili <marat.khalili@huawei.com>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v11 5/6] test: fix impossible format-truncation in cfgfiles
Date: Fri, 16 Jan 2026 18:37:00 -0800
Message-ID: <20260117023817.196694-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260117023817.196694-1-stephen@networkplumber.org>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20260117023817.196694-1-stephen@networkplumber.org>
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
Acked-by: Marat Khalili <marat.khalili@huawei.com>
---
 app/test/test_cfgfile.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/app/test/test_cfgfile.c b/app/test/test_cfgfile.c
index 3a5078fc46..1e56473064 100644
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

