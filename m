Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB8BD116E2
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Nov 2025 22:45:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E50FA4064F;
	Fri, 28 Nov 2025 23:44:38 +0100 (CET)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com
 [209.85.219.51]) by mails.dpdk.org (Postfix) with ESMTP id 93902402F1
 for <dev@dpdk.org>; Fri, 28 Nov 2025 23:44:33 +0100 (CET)
Received: by mail-qv1-f51.google.com with SMTP id
 6a1803df08f44-880503ab181so23105426d6.2
 for <dev@dpdk.org>; Fri, 28 Nov 2025 14:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764369873;
 x=1764974673; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WmT0N/n74EPEE6smaUUFOrqeqMbkWMQqkiLgpTfyWr0=;
 b=rQzfXn1i7+uXV4VlkfIThEQmtLKFWFcO/0xSnE4j19gbMlhPATZhXISIuro7cNKKve
 fqplZ9syndmpfJBcVuHkyGJfEnZ3/v2kgp3Ww9LBoLtrjHuF5MLAlHj9YyZfrHB3YpNo
 EUGxaN93jqoeMHGvl1UYyQ6wkAEHCib35tX/KRXU/77beB4wwsg38Wye7ty4RzHGyWpT
 7HKp13zBoSvzJCTU/s+eZFNXAlitkKNb9SOxLSllOo77daQiGjvEpdUrOG10dcQLyzzl
 v4wU+m3wGTNbEoU/f11opy1LgMNoT2H5/RKc+SwLDKXGY+h6SQQ/vRLJ5lMCAxxtj33k
 dHSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764369873; x=1764974673;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WmT0N/n74EPEE6smaUUFOrqeqMbkWMQqkiLgpTfyWr0=;
 b=hTOUb2kivl6M5ofhAUDUMfSWHQtWVUF6h+4rI27ssKRf2xSGiKuLMr8fQZJfibAH1y
 /dFiLfjOxJYMS2gwj4mnrPJXD5icNASJKb8YQWe/c/W8+wCEh3BcvoLgSYKL6DJdX31J
 4UT2zzfitzX1npa8MjYHAwR85RnbNUEP5L49x4O6LmE/YkKQZNMWpAGHJAuRrHtCEtB6
 ZUjz3e+U2dOev9fqMt6vByc5eHgblCjhuWmHVqGJpc9QY4zKa7jEDrW4McJpuETJAIwE
 mR+qaH5+2j8Zm3xtA9VOvsz2Fr+CkQtYm9OUej/Yau4zsiElgg667fjD9/PlrTWTApWI
 yE3w==
X-Gm-Message-State: AOJu0Yx7NbO+nklqxTd2r/IwtqnFDVRbqFZF3VBEA4FlSLm5Xaai+mSX
 KZCpBT1MyV+f6GqBTuliahcjlUAAe4SZ3AERCHUlOjvcwTwqbXCGb3NyAWZHOSt9XKuub02soQ7
 VA3tK
X-Gm-Gg: ASbGncvNhp1umlImEtg4Hi71ZcKZEcPmOv4AVci/OXLgY6QZSeR+gO9r9OfkCP0GDZA
 uDNUSl9R5naQYG5L6P2M6649OGd190ZAIpbu7SWMQxbqolyKcNQ//TewpudpJ8mu6Ii8KzoFwF3
 fscI2Arb+PuNbarlvrZuWRHnG+DoIe1gq6Ue66sNExtsAYqQ1CYxr4TdWEOUKKwGLlHP924F20g
 G77VC4pbBjCzSw3sFsnVQk4cJfDRwqnBS0daORIBo0OeLUbCfDYUQtL1KdDqi2+HiJKh+FpCCVk
 lSwuRX8u/MY1XIvQh3hJVdW5CzfDy0UHMJ7gMFWe9++JzQ0sYpq3LvGQ3L/BwoHu+vl7uIak7aP
 sPr5nmaTTeFh4ysfYFT9zoPELAsVXGgqALj1GsCfAaea/09T/vfZpfAfZJf4wTSFT2v3+NsjDDd
 J+ws2LFGCz/CeEenFXGnKQZu1buvXmy5z4rAHqDvkVJxSrDDsCCg==
X-Google-Smtp-Source: AGHT+IFypmZlVc3Rkx02DxROAQp2j/Duk5FQyPon6L3v6QkjjZ1ZdUj37DV5bbwIng4sFgQFXC/qvw==
X-Received: by 2002:a05:6214:262a:b0:87c:81f:6200 with SMTP id
 6a1803df08f44-8847c4c7decmr483103906d6.28.1764369872873; 
 Fri, 28 Nov 2025 14:44:32 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-886524e2b8asm37022216d6.16.2025.11.28.14.44.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Nov 2025 14:44:32 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v8 06/10] test: fix impossible format-truncation in cfgfiles
Date: Fri, 28 Nov 2025 14:42:09 -0800
Message-ID: <20251128224420.195013-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251128224420.195013-1-stephen@networkplumber.org>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20251128224420.195013-1-stephen@networkplumber.org>
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

