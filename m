Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F2DD116EA
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Nov 2025 22:44:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B93CD40658;
	Fri, 28 Nov 2025 23:44:37 +0100 (CET)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com
 [209.85.219.52]) by mails.dpdk.org (Postfix) with ESMTP id DD8FE402E6
 for <dev@dpdk.org>; Fri, 28 Nov 2025 23:44:31 +0100 (CET)
Received: by mail-qv1-f52.google.com with SMTP id
 6a1803df08f44-88054872394so29982276d6.1
 for <dev@dpdk.org>; Fri, 28 Nov 2025 14:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764369871;
 x=1764974671; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fm0fKRDS4YRVts/D6rPe52eqre9y2vs0bibayAdUECg=;
 b=0yPONeXojr0bHbx8CZtoc95gUsd4J8hpR777d4RJbwTslJAkjKIt26mdy2cunW3P90
 KiYuoB2I8/t79Ftsd3nXBTGTfamsfgomC9udTG1kFq9QtSfR/NUaKlqF3TOzPR1IYXl0
 x23Ql6NnM57bkHyX+XbGkuzfUqb4gNYKldWV5MrSOIDvcIlWyEqT+J3CMLtoXHYY7T1O
 +wZY+xMDuugbqqe8kjoIwCbj7E8yGVoOXeHf9nhjOFG8QDxnaJbBFtTn0N2WoANcmByn
 TrHeFmkh7fcHwyTQL99edaVvKoWmrFBa0iBtigGEZjy4gKN9w5S/fl1b2mjjLCkY1hS8
 64UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764369871; x=1764974671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Fm0fKRDS4YRVts/D6rPe52eqre9y2vs0bibayAdUECg=;
 b=cRHGwYNwrbawfOq+BYgop8m0jzyunyMNcQCg9VtJsN96WLiM4fY2NBDcsSFNUBYPs4
 fw83FCl+udVRQ394xS4C84aVcsmX45GXowNPggd5B+AEreiRNGknMlZQ0n8ntz7Ws8Ld
 tfHjV0Sh9jg9VLJC8TC4Auokn2VF3ESptSMQPVestT9zfG4HEw7GWDVEj7F5QiYuvIl9
 U4RxS6z5JKjyw8PIB7DF/I5ZlvjF99oUsLlI6V2zIq9/InSjyzN5nT+7NqUW/Zn2WdL2
 Cs7ow3fYXZOhE+1f5FsoR49SHLSPXeJlxECAdzlAAFR5ZhqVqGDrdAFJf4VlXO0JXvRA
 upBQ==
X-Gm-Message-State: AOJu0YzK2WG8j4PLHRJwbxz2EdIpe/vILXnoKOaat995jQZes0XP4VIf
 LNCbRTPltkWrznDXu5Dvwii8HUWen380+fenmPJMvTI+R8Y+YaKtCI7sZAdF3exLBIvXAeFnES1
 wWL2j
X-Gm-Gg: ASbGncv6p/7JSbQ5cpXBp404sqTr8YFh+IImT44L89eYgA6aKUV4ThJRjvqgQDNpxPj
 yFTHAuWYAKLCKf6GAem/oKd3pW+W4MG2QTH6lhz8p5TQW4O73xLZyBmnO5xIZqUeqerlu/dK74c
 wBGDz66r+ieeHr8J7IN8pg+iZy3SgvWvjlgcJhIdGR5bW8vhXlubbJt77Qh7zRwwLz+oyIl1cFY
 8hegG57zWUEuqhh9cgab3xBV/IY3TG/U4QNTj+xHf8tkMmufrlecg1o5lE5GKEN03AdwspUixfE
 9UJb6zc/Zbah1N6TEjfKtZ5wcoEYMDUVdPYLKGRJCuFmeElb2M9UA6WmkPect+JJzK/wByKgwEI
 Dg/0iTplty9M83tKm6hHEj3REvYRnwbqbhoAL54gKGo36J5IahllhhpHjjydUZAK6CkufO68WgM
 1394j9kGphskNasPjJg4JH1qpnrawq+a7OhjS6BQVEck89nj8oYw==
X-Google-Smtp-Source: AGHT+IETG+hCiDZlw0HtUh1K4PnHFAsecZZhwIfYvOGtS9o+7kuAp1ArzDf7fbVeGI9UohUfcJWrXA==
X-Received: by 2002:a05:6214:27c8:b0:880:45ad:3db5 with SMTP id
 6a1803df08f44-8847c49f4aemr448975066d6.3.1764369871293; 
 Fri, 28 Nov 2025 14:44:31 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-886524e2b8asm37022216d6.16.2025.11.28.14.44.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Nov 2025 14:44:30 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Pablo de Lara <pablo.de.lara.guarch@intel.com>
Subject: [PATCH v8 05/10] test: fix format overflow warning in ACL test
Date: Fri, 28 Nov 2025 14:42:08 -0800
Message-ID: <20251128224420.195013-6-stephen@networkplumber.org>
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

This test has an array of input lines, but the two dimensional
array confuses compiler length checks. Convert to an array
of pointers to fixed strings which avoids the problem.
Make both variables static since not shared with other code.

Fixes: 5205954791cb ("app/test: packet framework unit tests")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 app/test/test_table_acl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/app/test/test_table_acl.c b/app/test/test_table_acl.c
index dff9bddfb9..94edf37234 100644
--- a/app/test/test_table_acl.c
+++ b/app/test/test_table_acl.c
@@ -317,7 +317,7 @@ parse_cb_ipv4_rule_del(char *str, struct rte_table_acl_rule_delete_params *v)
  * separated by ' : ', just ':'. It's a lot more readable and
  * cleaner, IMO.
  */
-char lines[][128] = {
+static const char * const lines[] = {
 	"@0.0.0.0/0 0.0.0.0/0 0:65535 0:65535 2/0xff", /* Protocol check */
 	"@192.168.3.1/32 0.0.0.0/0 0:65535 0:65535 0/0", /* Src IP checl */
 	"@0.0.0.0/0 10.4.4.1/32 0:65535 0:65535 0/0", /* dst IP check */
@@ -325,7 +325,7 @@ char lines[][128] = {
 	"@0.0.0.0/0 0.0.0.0/0 0:65535 206:206 0/0", /* dst port check */
 };
 
-char line[128];
+static char line[128];
 
 
 static int
-- 
2.51.0

