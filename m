Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C1F3FF5106
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Apr 2026 15:18:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CEEC840670;
	Tue,  7 Apr 2026 17:17:54 +0200 (CEST)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by mails.dpdk.org (Postfix) with ESMTP id 9F3DD40695
 for <dev@dpdk.org>; Tue,  7 Apr 2026 17:17:53 +0200 (CEST)
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-c76bc3e8de3so1973621a12.2
 for <dev@dpdk.org>; Tue, 07 Apr 2026 08:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775575073;
 x=1776179873; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2x2vgYBX9/88gKhNZHzh5SLV2kolREotT2i62VbRBXQ=;
 b=z/w6l6nyZ3r2ejH1wzB0rY1jaiKD7B0VKHoQxd/T3gdCzCivybNo6zaWVgK9x5obL9
 EtnXaibkTE8PvWPQWKLe/nWU8ea6IkCFYrd5IflpfM1sNykWCPsMF46/KbsMrkWfxKjB
 An0CS4c+1EUNIw2UQf/qyJPEUqvlGbSQe3NxoYB2WOlMlelSeh4oGQjL36HJ7NrpxX5O
 EYkEwmnm6gVKW/RSJMVPpKEoVItIM/7xaJfM3B576Pmj2rDpOrYDtfeHwPgwhsVxQSFv
 rd+B18Rh36wfVVTvjn679MW2edBIX6knYR1wLvIiWmAvVN9bWmglGceXKorYV/fWOEpT
 JPwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775575073; x=1776179873;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2x2vgYBX9/88gKhNZHzh5SLV2kolREotT2i62VbRBXQ=;
 b=e6K57Hq/e9l8JJ8xMJitKqfag2GZrLWC7QQvRniuGOykByx/Mpt9IoDjE1AlRmYLwI
 YAidPEVHa50x2VN1dWi+l2J/ykVDDs9M8H3IFpXI2emF7T71Oc1JM7PxxF9/AT3hb44j
 TaK9hzlwJpalQZFvcssweuO6bfRIl/qrkelpnd30+sjA5DceENc76+Sro1azxu7g7M6M
 vaQ09fQWYRBZfCh5X7riaGTDXWuZG7VWLTBsgX55qxOfk93/0uEepsMJ4zX+K0E/7ZHC
 Ma3zKlEd3BtCU4Vjj7UaWeYAiQMYjQVxcRgLytZ5wDAG3WvurzQ/pNjwfKGiN93N+09Y
 dCcg==
X-Gm-Message-State: AOJu0YyLQI0LFPSzxWE171BsEUDRTqsXDqwTDPmJNntDPejRzEmyHl60
 daBi8iBVvDivQCqRL1foSFv9yH5sNaG94dcg2bZbmZVi05r1CLz0R3f2Vpaf6lk61s9Sc8lzHqT
 AgOdj
X-Gm-Gg: AeBDiesN85n47osahi1j7MGGwxGuOcmvTTI0WkRHbqfOeiEn7a+CpIbgvF/InVFmq7M
 ine28t3FFXzjyp6dR4a2dqzyd/uFD80Z9P/J2pYpGmc5rugzxtfF9wpMn4QOXj2C1XcjhxmP2No
 o4SzY8bIAGHXpk0ZIUUMyzfLu94Jlv2mf5ZzMPjdaikExckg/KBdndpK4a9L0Cae4eqGbhmhxBi
 JDFHxChkh3WAIe/v9fikom5Io/yvM7ZMJLqlUjE29K9yvBDdaCNSJzVaCq4xdshpJsYlyvrrH02
 y/BSU28b61SiCxkOwD48scxa8MN9dyyiBgxluColD3grU73A1HJBLd8XxJ1DIR0K6j6aO6qGBPr
 g2HRfkkzbgVlPYcqCjsqKuHS3fwWKchZr3HZHhD6FMp2LvEG7FwwEBsuUJ4NmPH68caIJJVosqQ
 fzrxjxqQY/iIZ0BOue/NgRdi44Wsbzwk9KhksqN7rTtS8=
X-Received: by 2002:a05:6a20:430a:b0:39f:a91:783 with SMTP id
 adf61e73a8af0-39f2ef77549mr19073390637.4.1775575072628; 
 Tue, 07 Apr 2026 08:17:52 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76c6477bbcsm15842933a12.3.2026.04.07.08.17.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 08:17:52 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Volodymyr Fialko <vfialko@marvell.com>
Subject: [PATCH v2 04/23] examples/packet_ordering: resolve shadow variable
 warning
Date: Tue,  7 Apr 2026 08:16:00 -0700
Message-ID: <20260407151732.272195-5-stephen@networkplumber.org>
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

Fix shadow variable warning by renaming the parameter from
'portmask' to 'mask' in parse_portmask() to avoid shadowing
the global variable.

../examples/packet_ordering/main.c:147:28: warning: declaration of
'portmask' shadows a global declaration [-Wshadow]

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 examples/packet_ordering/main.c      | 6 +++---
 examples/packet_ordering/meson.build | 1 -
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/examples/packet_ordering/main.c b/examples/packet_ordering/main.c
index 748fe0826a..0279faf081 100644
--- a/examples/packet_ordering/main.c
+++ b/examples/packet_ordering/main.c
@@ -144,14 +144,14 @@ print_usage(const char *prgname)
 }
 
 static int
-parse_portmask(const char *portmask)
+parse_portmask(const char *mask)
 {
 	unsigned long pm;
 	char *end = NULL;
 
 	/* parse hexadecimal string */
-	pm = strtoul(portmask, &end, 16);
-	if ((portmask[0] == '\0') || (end == NULL) || (*end != '\0'))
+	pm = strtoul(mask, &end, 16);
+	if ((mask[0] == '\0') || (end == NULL) || (*end != '\0'))
 		return 0;
 
 	return pm;
diff --git a/examples/packet_ordering/meson.build b/examples/packet_ordering/meson.build
index 092a5258ef..f8be053fb0 100644
--- a/examples/packet_ordering/meson.build
+++ b/examples/packet_ordering/meson.build
@@ -11,4 +11,3 @@ deps += 'reorder'
 sources = files(
         'main.c',
 )
-cflags += no_shadow_cflag
-- 
2.53.0

