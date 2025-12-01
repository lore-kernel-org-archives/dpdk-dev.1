Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F8E9D116F3
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Dec 2025 22:05:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BA56A40670;
	Mon,  1 Dec 2025 23:04:35 +0100 (CET)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com
 [209.85.222.171])
 by mails.dpdk.org (Postfix) with ESMTP id 3EF6740661
 for <dev@dpdk.org>; Mon,  1 Dec 2025 23:04:34 +0100 (CET)
Received: by mail-qk1-f171.google.com with SMTP id
 af79cd13be357-8b31a665ba5so421336385a.2
 for <dev@dpdk.org>; Mon, 01 Dec 2025 14:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764626673;
 x=1765231473; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WmT0N/n74EPEE6smaUUFOrqeqMbkWMQqkiLgpTfyWr0=;
 b=AqVE5nyt/TJYSueNjqaaItddM2KsGGdC9TUHJprmoXLfMNS+7fOoWo1bfZ/N9LVF+X
 Q4c6rwEEeITTZ1NI+i8YLJJqfEEUYrhVBALTjfSVVbZXazWq3TLduTSpSBZRKJhR7ASI
 aGqELb16QaJaP23ata3LTxZr25ewfiyKdzqS7yLB/b2tph/+5ogvy+L1DRSKvQ+tn31H
 J8FgFmaGwDYJYe6CBo7ExOo1H227yuqufaOrIO003fNwUuOkbrOidF3P/Pg0pLdu4Psr
 +nhH2D7a2BOGP9JzrR9UfTkZKY+3u+MDeKSqOrCIopbyu7NL8R3nrxoahIamK53I5YkT
 ouIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764626673; x=1765231473;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WmT0N/n74EPEE6smaUUFOrqeqMbkWMQqkiLgpTfyWr0=;
 b=HTmC95y1oFsctU/NEwvSGuIAVr+tGpAs2GRd1ESz3MLKB9Qtz2zE0EQUNXjI0hz7wF
 n21ghRlKlbUzST5QYbejjOLKr2hUa9coUGUd9RqNkOhB2j1xpV95NRSnG5emX922SxFA
 aDDoXveoz/aK7zlG2JcU5baEVfH8ZCv7BHWKZ7VmksfzYN69yCVkCe4JctFUHoNj0SjE
 HHW6WjJXJPRsi5GaYje+DI1tllArUoezAI7TlQzTh+N5CzXHwREO3RJEGelD/clHlrYU
 YarHsNzHvClfeqR8TpuRi1frj39qUD+Zgx9g8UKXa3LASZ1LO6U5DUl5uxh3xWlyG1qZ
 TYAg==
X-Gm-Message-State: AOJu0YyQeEGK6m/sVhnFp6ZDFHnmlCbxUVhKP8R63VRlCvv/o4rxqv80
 8HSazpiOjQ9IwtvEMG0F1XmyxuSBx3MRJgF7s9+yflIyRnLfziyhSbdj5XE9l8KlmaerXiZSXw7
 wIpiJ
X-Gm-Gg: ASbGnctoXf846aggPlWoKFoHWrF2NBjAiVTVD2KCKx5NeRSZlB8x3RKyhrw8K427bNs
 MmBcaEMlk8GRaYQgGtUbj1UOIN3sul/IKKhdRuEWUZbYKfcyH9vuTgHOViH8dCMCpKBT5tJtGom
 xaupQAxxEdIupvouWgE81Eq3Sl+e3+uRCDoIydBg/YuCMB0qoKp1lHvMtAw30k6HcgujZafWXa/
 R3bVKTlftk1zYIocTIfn/hz0Wdqf1l1wp2o7xV6ze9/0BiscGUlz/ibid52V9RGvvgDVhz9dFDk
 wcY/m8JUBnhkcLP3amr7oOdjpmXz8d27K2aorXElRUFH48Ps47g+0VQ8ZwVv1kH/VQxWdg0AbKg
 cyGvHTcjZ11GKntdkdUbLx9UznctbmHwt8xW58Eor7SbPOPl6BxHOSoFtIY+e1ENGD4mgE1cw7M
 Pcp0crDjtmZ8ZfvN7ROPQgNfVJxZR08/C4dCVi/hnb/oHkcF1TWg==
X-Google-Smtp-Source: AGHT+IHMMcxdFoGDySJIAr+4A5AcbymGHe7AojaOegORppsaeHpTB8pBeMr0SSek1x3Q2UzfyaZgdA==
X-Received: by 2002:a05:620a:2682:b0:827:7a5a:2dcb with SMTP id
 af79cd13be357-8b4ebd5294fmr3900029585a.16.1764626673529; 
 Mon, 01 Dec 2025 14:04:33 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b52a1cad4esm934398885a.45.2025.12.01.14.04.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Dec 2025 14:04:33 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v9 6/9] test: fix impossible format-truncation in cfgfiles
Date: Mon,  1 Dec 2025 14:02:04 -0800
Message-ID: <20251201220421.207285-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251201220421.207285-1-stephen@networkplumber.org>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20251201220421.207285-1-stephen@networkplumber.org>
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

