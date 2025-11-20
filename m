Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF68CF9C51
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Nov 2025 16:57:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 72FCE40653;
	Thu, 20 Nov 2025 17:57:26 +0100 (CET)
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
 [209.85.215.175])
 by mails.dpdk.org (Postfix) with ESMTP id 2ACCA40611
 for <dev@dpdk.org>; Thu, 20 Nov 2025 17:57:24 +0100 (CET)
Received: by mail-pg1-f175.google.com with SMTP id
 41be03b00d2f7-bc09b3d3b06so584172a12.2
 for <dev@dpdk.org>; Thu, 20 Nov 2025 08:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763657843;
 x=1764262643; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VN44TebtzgLwJlKcYhgTRWjdzqlWwvrDtTMcE8IROAY=;
 b=RT5/168v2CebUqnGXhaWjsVlrXCKD6NZEb/0ssnaQu9JnqT8gBvpPrlQ/dHcUw+hWG
 wBhrAUGEgF9jVKzDwJQWTS0GHbaTgf8LPkSk/OTlV61LWzGflIhwIP9OkaX/zTNxT7UT
 gwSonpnfrWLcZN6r46INewbUVG8KZhGRD5SZ1IsTo5jJN8n/LoYp4NCaT2y/KxcN/SpO
 DAz2sY1DCMHoLEAvipiZgXC46Ywkby6vXFoRvCwAlBTEuYwLXIRT7hdaFXfUmtDxIv2C
 B93CYgRVZqrhv8FbySG0mwdNanx+9gfotF7Qesou1dIVScdNguFTZxGdfA+1H4AzJKxR
 Re5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763657843; x=1764262643;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VN44TebtzgLwJlKcYhgTRWjdzqlWwvrDtTMcE8IROAY=;
 b=wY0YVsOr+aA5JDgQYO9lgvfniNtTE4mCSGKSbqa0fKaX3HFPBMYDQqcJbz2nmT6cYr
 rXLSa4otTRhYY1+6wmxCxFUtmHpWoRbOOYVwH1SAJc35Sy6rHHzpwuNRNBtHW+hIU9YX
 NoJeCo0eEPKEVNWDgJ89d9maSgN45ZAZJVHXVBXvAqc/mYs1jCaX7WljdJfo5kHoT2Km
 BpDGYVEdvFaWuJ2TkSsFNHPpWeYJtQDLHS/ZmkYwRY/Xjvl2B8ElQ1EFcY7KV4JCRP9R
 xvX5/EwoyRnTjdIBHk6BTRov3dtrqA0Ss/yYz6IqybolxRJqPwsvyxZkrNXS3cpuktUQ
 lPow==
X-Gm-Message-State: AOJu0YwSC2dOi8gOAlbO2wLpXOvYGpS2LvVguOHlpRudTpJu6hu02aIb
 4XztlZh49d3pEbYgamRkDAbXvLRzkxJ10z8p+7nGetQmLC4O3wpRjTcSrH70KPzwheJqHiU/BhC
 aGwJV
X-Gm-Gg: ASbGncuSMZ5GF/koGDrxAYwJ+kLNQpqi6dIre4I35iworUwtNtjFiiup/xtMeDCVYe/
 TtVCE8+99fGqRRzuVFRP8YLXbtT6cfgj441vU3HhiHpEh1EgKYG/ldDybodkM7Vn3VVvqyGCK7r
 DRQddqAUAXmweGa/tHHu6JgrvwfV4V7FM1MLRpqXaEKHdCjaCnl/wbHJUSofbxY9eGo1F+/gvJu
 VW98H+xYrDZHk1VHdl7vrRZJJ6wEJYVKWVScrJfsLZmYzqJYkZbdcdLlgoZ/9YPvu+6hWUJFMo6
 1o8X8aekPVVAdDODYnoOJ6+uLDHi1MuiMZKIqH/UxD9ZGf204xDznKtfmXxHDmO3mB5+RtmNQsK
 GQfrw79O8jLtNFytDaImtVZkoUuR+4N7CLyRZfFdEJnXlmzYNKMWvC9THbFsSnKWf5c8agr+PF1
 1SloXgVmfMAL17QXMOOPFDx7arabgJUxHkHzjtW+bQFBvCEE2bsg==
X-Google-Smtp-Source: AGHT+IE2yaBewyqqTSeiA34SqXtbi6OUMHjOkGqII5LIT75KelxepkFFQ2D5oaLV5O7aztCBpZG1EQ==
X-Received: by 2002:a05:7022:987:b0:119:e55a:9bfc with SMTP id
 a92af1059eb24-11c9388fe95mr1407347c88.24.1763657843067; 
 Thu, 20 Nov 2025 08:57:23 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-11c93e55af3sm11536747c88.7.2025.11.20.08.57.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Nov 2025 08:57:22 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 cristian.dumitrescu@intel.com,
 Pablo de Lara <pablo.de.lara.guarch@intel.com>
Subject: [PATCH v4 5/8] test: fix format overflow warning in ACL test
Date: Thu, 20 Nov 2025 08:55:33 -0800
Message-ID: <20251120165713.120238-6-stephen@networkplumber.org>
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

This test has an array of input lines, but the two dimensional
array confuses compiler length checks. Convert to an array
of pointers to fixed strings which avoids the problem.
Make both variables static since not shared with other code.

Fixes: 5205954791cb ("app/test: packet framework unit tests")
Cc: stable@dpdk.org
Cc: cristian.dumitrescu@intel.com

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
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

