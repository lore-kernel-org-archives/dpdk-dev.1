Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF02DCFC518
	for <dpdk-dev@archiver.kernel.org>; Sun, 23 Nov 2025 17:45:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B7AB840430;
	Sun, 23 Nov 2025 18:45:25 +0100 (CET)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mails.dpdk.org (Postfix) with ESMTP id 4C602402E2
 for <dev@dpdk.org>; Sun, 23 Nov 2025 18:45:11 +0100 (CET)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-29853ec5b8cso44003175ad.3
 for <dev@dpdk.org>; Sun, 23 Nov 2025 09:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763919910;
 x=1764524710; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WmT0N/n74EPEE6smaUUFOrqeqMbkWMQqkiLgpTfyWr0=;
 b=j1D45Yyt5ioTSS4LO8vrOSdEjc6DZoNclE9+4k2l4nwApMY2kLg/BCxDDI7Pf36iD0
 Zr/WqLmUM5cwOP2oCl1GCLjXka8hANJNIkjieS4mxSqPuigNJTUR3VRurZxyIMLsGrkD
 4wjyUMSo1U+ufgdkud4DBQ4YhdgCS6mvtNDgAbVR59ICHvVKjirttQEQZzs4W5bHWvLU
 yIoPgNC13n6fS53LzDhjYvPxYQi32l8wsmInNbsX699Au8QLdxXf44Q+SGCxSOcBcM3u
 cW9VRmgn22g15vVYv5Rcvau0nRe4QIzRAnD5MXu4Z+tY27A9b8qxjrvXhJDJW84g3isG
 znIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763919910; x=1764524710;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WmT0N/n74EPEE6smaUUFOrqeqMbkWMQqkiLgpTfyWr0=;
 b=tpnpCKFkp1UYHnVcgLR2nshlJOgU8jtogBb4U6ojxbtIkhQ7bJq9AxhZYVkkKYY8bN
 bQf9x3TOqKNFlpK9Vo+d5LVN5wQpQ8msilKjNh7RybTkjAxl7eH4KMYg9M1APvebsalq
 BqChaDDrY3Yj7X2Jn0ghQ3yiMPQbH0BDPRlx+RA7fJXr9MPcsNl7qAup2zeRebA19/WY
 Y1kWX6P/5srj17iIBCziM058om10dTDGPbEiMMiHzFffcNJh6dwkYsTAOHSUoHtUY3Zj
 KHP5bSY0mE/n2gbC/d6TBTfL0rFqkqaw6NLLEI8DrRZX8TU6Y/lZ+ZaAXJ7fVaoNZ4ET
 qTxw==
X-Gm-Message-State: AOJu0YyzuMD16f6+geit4OiDOX0trinLp0vQc0KiLYRkDNKHWn5Qox5Z
 OlzoG2wf1pdfRrJ29pBRNqQRXCoSQGOH7OWNmHQI34hkbupBWVTBDf3MeccYamj3UwKL/n5014G
 8zjEp
X-Gm-Gg: ASbGncv5zcYhKcS9/h6qvCHBHhyX0Onxg+byNpnlmy7WF1ThFo7y+FQAMT5oAZXWboj
 VsdjW+y6sh/mn1ejuCuYgrZlCCAMTgBOncEna2qRzgQCqXxzpt91xuBYACZU81zkYHqJE0BbLeG
 hh4sEdqf294lVrpSjiuY1dKcu37iZjl9h0Ot59fGbFxNJQek4y5bohcIIKyS0fkdGkAJ2h22u6w
 nJoYh9sIUl+iEXmPPijC/pS5Hos3UXS4KIdY+3Wirw4IR5EQb9r/ohPJOydnJH6zUcKfvIXWtlA
 jDVYZzi26f4CqwBRzc+rnGwab7rtcqoiNL6Bm4YJQnOuPY86qcixfkvft/E0c4k/YvOD8cUVXB/
 zrhM9Z5Xzsf9wi47loLiJWaFEQgYQgTmBzCiJI0FIN7/tvP1c+VWszX0IZT2WULaYPrsjbtArVK
 LrNrqHAupGTwDCoenLIqFK70GZ/+dPMcAaF5TSGf4j7LgHMKNFmw==
X-Google-Smtp-Source: AGHT+IFdYvOvDROEXjVsudSVOy4N5JlfsAz2ffiQBePCQt9TSKZCoqJSGVFURrAg+zvKeIQzbXTE3A==
X-Received: by 2002:a17:903:178e:b0:295:543a:f7e3 with SMTP id
 d9443c01a7336-29b6c53992cmr107718775ad.27.1763919910478; 
 Sun, 23 Nov 2025 09:45:10 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29b5b13b973sm112585985ad.39.2025.11.23.09.45.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Nov 2025 09:45:10 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v6 6/9] test: fix impossible format-truncation in cfgfiles
Date: Sun, 23 Nov 2025 09:43:29 -0800
Message-ID: <20251123174503.20880-7-stephen@networkplumber.org>
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

