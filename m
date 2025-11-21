Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690B4CFC295
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Nov 2025 17:10:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1E6A140659;
	Fri, 21 Nov 2025 18:10:06 +0100 (CET)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by mails.dpdk.org (Postfix) with ESMTP id E25D2402F0
 for <dev@dpdk.org>; Fri, 21 Nov 2025 18:09:57 +0100 (CET)
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-bc2abdcfc6fso1369125a12.2
 for <dev@dpdk.org>; Fri, 21 Nov 2025 09:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763744997;
 x=1764349797; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WmT0N/n74EPEE6smaUUFOrqeqMbkWMQqkiLgpTfyWr0=;
 b=odSim114r/5VIAEf3QgOu1L0CuyXmoIwKN6u1JszoAvvIuHKPkufLmAVH7/VuqQx26
 G2WMWWUw+sNmGtEotlto7vQoNI1u/qFS7sZCdUpExHV018wuU9UvpIfLxbt0SZ45jlv9
 szKNW7WgakolSwFwCOTtp6wcqoQBeSedkGLnPwc33MdW+N54pv3zHWWWKwnRTrO/sV7X
 556nEXmef+rQwqDLWrLXCzNuwIy0xoLtlpKriniYTkz3buzgx1QMRmSgjXoW8l4fItIu
 is+4olKEkl6K1WSzdqeJsi1o0aielyJZ1qSRu4uca3+uW7DvZbm7MMCZnddCWmixZTDq
 8GUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763744997; x=1764349797;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WmT0N/n74EPEE6smaUUFOrqeqMbkWMQqkiLgpTfyWr0=;
 b=Hcei1kl2jIxZ3GeR904vbYjXO4vSfgssWsU/jXJqubvvH/H71vkTnQAknjVJfzsZRr
 yUY2n1MDqxIg+pl0+39wlp8TC3dC1gn2mKlqTGhitpOjNGMnsGGXlvycbpqdWL5P26Wy
 14A00uRoobtoAdcZZSW1rEzw5f79gJxASWabngD7hN+pK+7+GS2xtqTjfIiIpLt1yrFK
 DieXWNSJ8lnLSpn1eLuTEW1Y8iLpkI0isS6xb/TBjjEf+U6JkChtpvjoeneQedPIAllB
 Wn584vdYn+kLipznyGsZvota00XDKpQUpEGuP2JLrp5/amxBMNMJDrVLgjPYQPOFOKCT
 MVQg==
X-Gm-Message-State: AOJu0Ywx0RPFjixlYWq8DUzlfl96zlzsZmwudUOMoaOxro3TzY8g4+T9
 NDuyBZ7q+rNcINTB1EQvKNoVnzs4FvLQ2mMSclm4QdyxoNBf9HIVneGxaIUQyxUmkrMMbLuHRjK
 PcaK0
X-Gm-Gg: ASbGnctv//IUVLYBaLZZgEL0sQu2WAoo7CfYbuAIadyE1H8uZd+p3m+7EHLHvbtnc3E
 hSefF9e/nAfBfhim+KOhp3bXIsX6rWIfOvLur4c//Obm3tiSUeByBN7I6D95ok8PC79YqY8wAN1
 VNFDUf4FdRE+GEe1d8LVOq03s2HYb5MIyjnlJB6pi9QPPeEPOGr/Zo8e/FvwoQ/sxy7BFUOFfmx
 phFIuJjM/6ReX0VlXgPdPS0VRSG3xaKPForio3CTQhScLfK48GTTCQb4vB4EeKJYQ4AAFi8x6Y8
 9PO2Xej4CTcBGT70G1MmrwN/mw3D7UUrNCLKEMXrCfk4cLezoXk5by0d0P9thBnDOni3BsGqCpM
 RH2lOj7Q5cveEdYJvzqfbRzh7xGm7E0pjlzC+lIvE2mC6qw2f4gl8qeTf+WNMLTAeiwnRoPspxC
 oXyBcAP7v+tGeQZurPUJaey5qjhVmxDyQxv8zpmRijjN+aMOjpZA==
X-Google-Smtp-Source: AGHT+IHfFjysxU/q57WTOwq297MR34aYb0J0Ah5+yiAO1Y305FZGWNFFLyOnlZ6jEv5DqUWh2Ja4YA==
X-Received: by 2002:a05:693c:8016:b0:2a4:3593:ddd3 with SMTP id
 5a478bee46e88-2a7193c9fd0mr829525eec.0.1763744996653; 
 Fri, 21 Nov 2025 09:09:56 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2a6fc5b122dsm21341544eec.5.2025.11.21.09.09.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Nov 2025 09:09:56 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v5 6/8] test: fix impossible format-truncation in cfgfiles
Date: Fri, 21 Nov 2025 09:08:25 -0800
Message-ID: <20251121170947.134502-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251121170947.134502-1-stephen@networkplumber.org>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20251121170947.134502-1-stephen@networkplumber.org>
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

