Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77EF6CF9C5E
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Nov 2025 16:57:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 832584065E;
	Thu, 20 Nov 2025 17:57:27 +0100 (CET)
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
 by mails.dpdk.org (Postfix) with ESMTP id 1DACE40262
 for <dev@dpdk.org>; Thu, 20 Nov 2025 17:57:25 +0100 (CET)
Received: by mail-dl1-f45.google.com with SMTP id
 a92af1059eb24-11beb0a7bd6so1807465c88.1
 for <dev@dpdk.org>; Thu, 20 Nov 2025 08:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763657844;
 x=1764262644; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MGt4iTzAzvLgTyNWL9GwdWyS4jCaPVnMgsiGmIX723c=;
 b=TzWWez6AYYn48CbhqFxBSjgMlnkqgDnKIssTqKwkvKe6HEKK7dRkQCieO3f5xLqqeM
 3u1sbOXCzpsjypXPo648ofYPB/PBhZZVCUnJPRQxv3S1h0/lFD+V+7bLaqEVmHXbi2rU
 4WdGccF84456kNhCbBqz5qofE/4Si5uUZHYPe5t1BzpGOM3VCvgFmgS4AmmUrMYmqun5
 dlXWKOHjpGMatN2ebLRPXDAoPBWBpBBT6RKyRDj7U9yY3rDe/dksiOvcxJkFJBU3g9nB
 A9QvI1bHsN9VSt2Yb4Z8t7yj9DTaZMpG9HoHDQzOk595a1iZIVfB3IoOMarq/Z7xRkip
 IogQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763657844; x=1764262644;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MGt4iTzAzvLgTyNWL9GwdWyS4jCaPVnMgsiGmIX723c=;
 b=jVSTY25chHN8BKCYDMJhedqT0zGxjhmySvPo95mqZ98qnRuL5XNqGCmZ8EUr0uWMQg
 LiZeWSomz4toSJdujw9V7QP7m1okw+9OWduX3Y0ozmxiXQlg6OlfYtueCPeesjGih9qS
 uw1KdgWIIxmcmxf0lqaPUs/B8JqoZ0I5n+b4FpBy7hP/AEOFS6NmgbGuERZF5Ns9gy5J
 Wa0Z+OM83LZKnJRxN4fY2kj7bQjw9H4ulKkC3GRnasBWA0mwiSeAo+38R9mOCaX1aToK
 qhOqWmhJejzxgZPd5K2AyJdChGfbvsixZpEW4StUSu6/GNuyp7kXveREedWQ3sSIR3ZZ
 VwiQ==
X-Gm-Message-State: AOJu0Yx49g9olMw3hnoyC07SFrkL8n3vSoRcaNdBPKDgkTWsz0+rZdDt
 pMrsV+0zXfAbxgizHMyityfAsS+sEhn7bXJ2EKm689mD9eVPXywuCDeL/yaXDN8QZWAExlzK4mU
 g7m79
X-Gm-Gg: ASbGncss5mxXPmMZyezrzPC4bX7djwie22NF4T/KO1kXKn3ZYcWb9dBGlQk8g6QSS/z
 jYzVZr3BYOoiNaCg8G34t2hsEADT71f0BIGIFDUBW0al9n+CCCWXHQu1CPvLhE8klFGyBtrw6dg
 qyNXaCJ5CR2TeZ8qujXAeuG0JmIubyiZsi1oTTs2lHHQh4R1eYy6TDIdz6Xq8CNvrkNtS0FzNg/
 zDU13GhKn2kfdZjh1/pMnYTDnYSxvlHeHdjkiEO6ugjEKS5YL3Frs9G7H3Cro//H4c1EhnHabO5
 mJ6ctDW7IGbWrBBr52VCCVlPbv+93oW0Pr3TCtRWUZy/Ho/p183TmV+26EgZiSvvkvTkJLrlCbO
 U4tuhVEtcY+EQX15bX+b8GRz5jUcRK7nc/te8qlzIVAP1pzIikdH0oAbbcTxk5zazVDHQ3WdXcD
 ToNJ8FPEqhhIf4Ojfom7gYqoApsEyxyUKfGOQB/U9sIJZcKjaIKA==
X-Google-Smtp-Source: AGHT+IFLqrxukGR1yaKmNj8vK2q1V6Wu0BI7+D4UmXUnYmsmSjQR6mVprd6vGturlzHoJ/l2fHTE1A==
X-Received: by 2002:a05:7022:522:b0:119:e569:f86c with SMTP id
 a92af1059eb24-11c94b10d94mr994668c88.9.1763657844082; 
 Thu, 20 Nov 2025 08:57:24 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-11c93e55af3sm11536747c88.7.2025.11.20.08.57.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Nov 2025 08:57:23 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v4 6/8] test: fix impossible format-truncation in cfgfiles
Date: Thu, 20 Nov 2025 08:55:34 -0800
Message-ID: <20251120165713.120238-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251120165713.120238-1-stephen@networkplumber.org>
References: <0251115193409.99740-1-stephen@networkplumber.org>
 <20251120165713.120238-1-stephen@networkplumber.org>
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

