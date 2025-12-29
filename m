Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39547E92FE2
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Dec 2025 22:01:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 376914064C;
	Mon, 29 Dec 2025 23:01:09 +0100 (CET)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com
 [209.85.218.50]) by mails.dpdk.org (Postfix) with ESMTP id 3759940669
 for <dev@dpdk.org>; Mon, 29 Dec 2025 23:01:08 +0100 (CET)
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-b728a43e410so1787906666b.1
 for <dev@dpdk.org>; Mon, 29 Dec 2025 14:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767045668;
 x=1767650468; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fm0fKRDS4YRVts/D6rPe52eqre9y2vs0bibayAdUECg=;
 b=bxi4RNf9DxFPERZmFdzPxzgLheLrKXg98qn+koSA6pEjQVvQxXSaLN6bqBc5+p+f81
 ObxwqYM5t4flNytTSrrNiA8spi+V8X8QbidmSa6uyWsx322gnEcmk66WIDoofpLQq5oQ
 5wjugPQ0l7xkzqjdWNTU+61/MIGzT2iiZatdpbwlIQwdmQZfrGXnWHrTi39jTO57gru8
 PACIUVTbcLoi8cjFpNwWWnrCZBLobfqyn8242catB2wAXvBW33K3iWRsTPKYN3S8qzZj
 22olooHhr0YH5ia6dgZ2yA1lIItSPbes75NICATZhmWINgl2GDybw4BGv7J8aMiaUfKn
 ROrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767045668; x=1767650468;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Fm0fKRDS4YRVts/D6rPe52eqre9y2vs0bibayAdUECg=;
 b=WLBbatNSKQdnbfAf0YNdLUuknDZjov+D5gTfHmzD4S4+VgXOvQMsRgK8PAue799rCj
 Mtt2W1SeTahR9FV71L2f2hqowGwIGzTzUwZlY3xwBIV8jTl63iXUQtPWx0/O6GW86DCa
 B4YkV3RNtpQbpsufVvXlfoYzJagQ5+ktt+BStBLe9stfycaNmF3u4FAGGu4/w9eq9ocI
 rJh1paDmjkpJX3o8SJQwAlT8t25L7QFqcmAlWlP6l9Bj50KAw1pbOi84MQs+/EVRfyV6
 8tcslnnoTX+AOk28g4GTdfgzOmBsjpIzjKfYC+etnRm2i6RrLWHdka5AkvPQCsdK7QIx
 Ku8w==
X-Gm-Message-State: AOJu0Yyc86B3ggdCeJk7Kkeh8jM8v7VksotpBnY7gaN0f4BVoIMLtnmU
 sle97cEuSeKrQoijc+9ca26s+TKz2mZ86FpNKPJPlu1aDdax658DI0AloWal9VVC6T7ZqE4M9F/
 tSSEwgkg=
X-Gm-Gg: AY/fxX5kAL8xBJRg7bVr4NQXHw4ASKKKN/7rKXp08SuCDvVfpfe8Mwo33EJlo0wID1S
 3heAwZL+Dzx15TYQ6mkyWGmvw57kuo8gIWP0UohSrDO6zHmThbzM99zeVD+jPeS6l3dam0kQc4H
 Rp0raO9Xrd/db+O7oUihN0lxaw43K1Wsov3Rns1LrSAWlNEJlgHX7dNZLqPrYbsk+zYvimfR4/D
 XHPqn+tTSqYG/FNjrKs//dd44GYk34icM0pq4lxGzzZDhUy9tiTYmEtcxSfubN50+qVy+EYuvfF
 XkKB/6HJ9BI8voKKzX54vjj+jEHiRkrQ8qAVCvwjDpJ0XvkNZLEsvGcyInvzW/1jEWqBIEnP7Gd
 ZebtX+KMEJ1srQWiGDKvLItKdB0PhXPmhxtzssoivccic9vOyObwKA2+Ddm8+CDRZipGRFd2eMG
 bfyQ/coyO1gch0nbp54hDek5iY0OuyqBW0c1slxQfXJkOHtXgPEbsOL7V+VB08
X-Google-Smtp-Source: AGHT+IEILMN0F83g1nlW9haDyeyb5Rq+sW/bwKi74k3y5ClDpSqbV+Frft6N2vARcDSXfk+9BbGMTg==
X-Received: by 2002:a17:907:c14:b0:b80:1309:aa09 with SMTP id
 a640c23a62f3a-b803718387cmr3486098566b.47.1767045667120; 
 Mon, 29 Dec 2025 14:01:07 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8037a62973sm3496359366b.6.2025.12.29.14.01.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 14:01:06 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Pablo de Lara <pablo.de.lara.guarch@intel.com>
Subject: [PATCH v10 5/9] test: fix format overflow warning in ACL test
Date: Mon, 29 Dec 2025 13:59:05 -0800
Message-ID: <20251229220053.21981-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251229220053.21981-1-stephen@networkplumber.org>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20251229220053.21981-1-stephen@networkplumber.org>
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

