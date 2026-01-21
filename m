Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2DF6C44506
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Jan 2026 21:08:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 48BE442E97;
	Wed, 21 Jan 2026 22:08:27 +0100 (CET)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id E99F042E93
 for <dev@dpdk.org>; Wed, 21 Jan 2026 22:08:25 +0100 (CET)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-47ff94b46afso1992795e9.1
 for <dev@dpdk.org>; Wed, 21 Jan 2026 13:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769029705;
 x=1769634505; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hmdTmiW/21omU32vm+w9i24hOTGLuLxiFVgnit5uRGU=;
 b=Uh9ioQq7vg2AL06x39d5VNw4GVEU1KTCbW6701WxKQC8EX1TDSrgOzK6rX5Vgw/YB/
 YNTUKMqMZhyCCU9JgIEbjYynSGI5Em/lG+G5NCp2rJ5H9HBtNZseFOUDOm57cZ0/LXIw
 FwRkzSc770bVyQ8J4oIXOxcWrCCsCHgsNWSLN2pTFIChvE7asFiHpf5lxxKrKTCGrQnX
 6NDX1moQVOJ9eodclPO71rZuXBynTWSDN4O/WIVun/YGhAjHeZG/kox7nSFUlx8yMxgQ
 7x4cK+tupQ4GTKn+kaxck8KM1mqARSM1VW564IG9oSyQxehnvz3O5NOK7T0FF6y/Tl6M
 x4MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769029705; x=1769634505;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hmdTmiW/21omU32vm+w9i24hOTGLuLxiFVgnit5uRGU=;
 b=ituIooFckKw/R1BB30bTFuaM/XJspj+RhO4uD5Gjstqir1WyP5zjNkHkiIONogO0Ev
 M3G6CDKROJ69aN4l/7EFlHyQz8wuz8br+ygiyiJ+loBgEXMviunTAOoXoZ0NOeaWL7sN
 AWGlA2NPBm6vhJKF6/ltPQe2fcQfPqj2CS+YEphxzN82sdLevjUFg1KU16ysXztAh1b3
 6LG4R0n1tdJKvhndXEOwfB99Mrh3Stegnh6stZzB6DXA+A4OQ0cT3xrVRsnxIuVWz/jp
 LMdZ7Xm84+xq3DP9JLUoAny11NfXa2Wo/MKR6j9OzJBSeggbTDmGFBguyDlg9PrRKoTm
 ynQw==
X-Gm-Message-State: AOJu0YxgkOLlKrFjmbR53tuR3JyYlhG6kxKdt5XPCghpllGzTOWzw3kC
 lAf60OHW9lFKz30JbOIIWPIP4mlYaPe7nw8QZKir67DmJbbbLIFVGrBJ78Uzu75OZVFEssW7T3k
 08caI
X-Gm-Gg: AZuq6aK7o4hniihIV6OsUGAofIiJ/y1xVqc0BtGpZHsq0a4XkUtsqziPwvkowwvTlRL
 eMGCcUcY9wxBVAMC8hzLbupL++O2b9+4jBedWgMV0zZY/OloQN8tOI+JdC6PkODpBFrRN8hUGB6
 Ev/Enirt7AHBpIlXzoyfDnlRAYv+1np1uLUDlKuZYXjnCvOZTpcYRz+WGI+ZLbBYRtbFkY8oPpu
 xYrQlnsZ9YUnUy5777sF9zeMD1whxmzxeYFRi9bAVBEpsfRbH38D5eBiVhEtgOomjuPtrCbpiD8
 rwpNDj6PJyS1CujFtHYjS8OKjG6CUmgFQy/iSeqaU00NtTnBxxkTJWqkK8kUsuWjjzno7w0Ro8F
 DE2VesVqJJ5TW5QQZbW/YAUJz735sVwn+1g4FRr3skcq0SwCIZ3HtdFe/Dv5aocRkU13rrPsd3T
 K035J1yI/OXyYFLwaGQjxl8B/5cwJ2BFzDWKWYffERniaxGdhYeQ==
X-Received: by 2002:a05:600c:1d23:b0:477:a289:d854 with SMTP id
 5b1f17b1804b1-48047073e5bmr17577345e9.5.1769029705514; 
 Wed, 21 Jan 2026 13:08:25 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48047028928sm27539845e9.2.2026.01.21.13.08.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 13:08:25 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Marat Khalili <marat.khalili@huawei.com>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v12 5/8] test: fix impossible format-truncation in cfgfiles
Date: Wed, 21 Jan 2026 13:06:25 -0800
Message-ID: <20260121210810.1044276-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260121210810.1044276-1-stephen@networkplumber.org>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20260121210810.1044276-1-stephen@networkplumber.org>
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

