Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0009BD0E6FA
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Nov 2025 15:23:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EA7C540E0F;
	Tue, 25 Nov 2025 16:22:48 +0100 (CET)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by mails.dpdk.org (Postfix) with ESMTP id 91E1040B97
 for <dev@dpdk.org>; Tue, 25 Nov 2025 16:22:42 +0100 (CET)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-29555415c5fso62400145ad.1
 for <dev@dpdk.org>; Tue, 25 Nov 2025 07:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764084162;
 x=1764688962; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WmT0N/n74EPEE6smaUUFOrqeqMbkWMQqkiLgpTfyWr0=;
 b=gHXrw+dAW1WxXy+o8imTG2+RxicsZ4BQ6pcxve5Pt48GFafKBduvlsZPdTspZ8tK14
 S0J+lIJIG9iRAUBsJVm/94JSdzq1RtDT2T3OcdYF1yOo4uLW8/sqUyiI8INJaHViv5GW
 pEDIpwwQTdec15nNC+dgm1NtRZpjgf+pgSIlchGpa4su1LtVCAYFfQOhQ0fHk6SN4im9
 jhAiSBpotWD1aqvBlFkx2ge+h/hNbWhngFHDX4we8Y0PrAGRCDPQgdkP8h3ktNnjnffB
 IVZP6qf4+cxDcQVjyXeJrgo7nLA4cc/YZ+iY3hZkNUxEmtfl0j5vodz75dVwJGVQmgpK
 FUWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764084162; x=1764688962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WmT0N/n74EPEE6smaUUFOrqeqMbkWMQqkiLgpTfyWr0=;
 b=IvikktOUaq1MR2OqthBVKQPNZzMCM6Q5fiIHLPu54CGUzzBHs8qxoBYMCCAnotqbij
 I9LR54CgpZ5X62mXH+OzISKNMRwKB6kGefXYd6+ncK5OeU3rxPNpmFkOW25FJlScybUT
 6KKW3wBSthB8xzmPJaCIofzfCDJ5f+ZdSmNIVkQyx8CQQDTYa7PfEu4PllD/SJKDaOxl
 tYaM8c/ydf43ihAlSeslFyx125MWVoODmOcmZhRNsfj/kB8GMDNHit61SHLGIwozHHgR
 mp+YAWGgE3GwgQJxnm/3LGJwlG3nsP4hx8fAXYu0QvAGTbcGkStH6DEqFRouX3k6+h4k
 7cBg==
X-Gm-Message-State: AOJu0Yxrb+cFgm8jEz7CCKmZSQ3ttI7snNuHovlDXidfJu7blYxe9eKR
 fhaw6iL21mzHpZ+1zQVTOU4ViznxpIdEwAPA0pVfD0WGU8utqw7RidfMn/VSHpfiVRU9D1v/b5n
 we2z4
X-Gm-Gg: ASbGncsmWtpXckeP6cCfcAodxlE9mqRDjFhd7QmXx3fc94RZ74Op5F8FkHl94dUD9Kd
 lN1319nQCl+CHvUHY9s7Dzew0VVa/qZ+Ia5n46sfG8ZS9abrpoLp2EY/MXvg4bWuyds/XKBXkwc
 PPgoEV3H+f7SMWNPE0WIs+0KE8/MBRQpjCrQ7KfciC6Uy4FYag1w53ZjV6vsbPnkWaDeTD/KDn+
 rHAzuMo/hk6ySjlpS/48eCPh6K5ty6N6IDXitXX0qjleutPEo93A/UkXQMMoDzS/S/5ogZIfJZo
 I9KulUv1V5F4tBCYHsk+Kb3UJprlRMJOYwogSYsRAa7jQM4kLgGRt8AwQ8Zh8OXT7HPboC2DKtV
 tC0BMapLTqC5mpz65zh1YqEz4B7RjPRpEo8sM9LdeAmTbvfNZQbDEG/+IStgTbFTr81/L6jRj8T
 c98iF6L2aVckwZ/3y6UeEoxZ+u9xo1tCj+h+bMP2kjRIrmC5X0pg==
X-Google-Smtp-Source: AGHT+IHQK0y5cPKxPQM0mrJ5SVmYnjWQpRAaliZxLolfEFSXvQrhYSk2UUnYghm/DL7CIdHVn95MSg==
X-Received: by 2002:a17:903:234e:b0:293:e5f:85b7 with SMTP id
 d9443c01a7336-29b6c3dc272mr171378515ad.11.1764084161749; 
 Tue, 25 Nov 2025 07:22:41 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29b5b111acfsm172573345ad.19.2025.11.25.07.22.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Nov 2025 07:22:41 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v7 06/10] test: fix impossible format-truncation in cfgfiles
Date: Tue, 25 Nov 2025 07:20:56 -0800
Message-ID: <20251125152232.73528-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251125152232.73528-1-stephen@networkplumber.org>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20251125152232.73528-1-stephen@networkplumber.org>
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

