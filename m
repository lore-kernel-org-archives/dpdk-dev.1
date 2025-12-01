Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46490D116F3
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Dec 2025 22:05:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EE9A94065B;
	Mon,  1 Dec 2025 23:04:33 +0100 (CET)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com
 [209.85.222.170])
 by mails.dpdk.org (Postfix) with ESMTP id C0D3640655
 for <dev@dpdk.org>; Mon,  1 Dec 2025 23:04:32 +0100 (CET)
Received: by mail-qk1-f170.google.com with SMTP id
 af79cd13be357-8b25dd7ab33so296125885a.1
 for <dev@dpdk.org>; Mon, 01 Dec 2025 14:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764626672;
 x=1765231472; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fm0fKRDS4YRVts/D6rPe52eqre9y2vs0bibayAdUECg=;
 b=HXpmHi3vJVVqOG9WnbNkZN7eENlyEFn9Xb3AWr5U1NbaCs+UHpliTmIuoqCQfrvBpw
 p6dLoqDBviYejYPOfii9cfYGt6Np6SxB832mcJIxcbFC83dGOs2PW/LDTAOicwQ79oPW
 tB8vRuYIqu/Kc5zg7UCT6uR4/llA9ancX5IKwTIfeT8Tf3gR9SPiWCYXANPXdPDj7irq
 9iY1iJQbWchOq2CR4xr3cfAG8p/RU3vspn5jtwJTqC2Wm+sZrFBjoSNdk5mQocWXaofp
 6fvoy4AZwm2Mfj2bBmf4X8wv3p2MhsZxHdrBLirPOn/9LvtY1OhE+XF7JngljkOIfEA9
 0okQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764626672; x=1765231472;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Fm0fKRDS4YRVts/D6rPe52eqre9y2vs0bibayAdUECg=;
 b=DKxaB+hqtsuTl3pLVyIeyVGqn5umukA/c17NWQOAvD4qa1+r3VDUfa2NtlPBuxr2x8
 aN/R7yA80308F3gJ/Ih3knP8rRlek16YdpCcnUee6oSA/Lyo+Xka2bvlFjVFOg1K29BD
 UxY6P+GARjVGUwTBxZPfTvXzGWHlSRu5TOZWaJmZB/jYxnb5vwVoqieaS2eJOtXj5/IT
 FzHWZYVT4qtlHjZYV6HorFPAavEb3wnF+nMXt0lP0mWUVU06vI7Q7e6oX9UjjcHO4/eP
 FMUO7xrDUjXghfICTgOw2y+KXFF7ARctxPxFm8ptZHfz4ohcv+VPKMkT793QaXGGhcan
 1pgA==
X-Gm-Message-State: AOJu0YxmiP1HudHYaAfRgkq2tFbltuCQizb2XwORukcM8WsllhXIpJhj
 jo4+t0ddK43kTkz1W/vm/02wAU20BqK5TY+wUlxKgRFWijpKqzAZY0K8YMIolLHYnDadfr6oVh9
 XilLl
X-Gm-Gg: ASbGncubxV4Q7fmrxfaptDeSkigQFutptTbYhjKtd/MOWaSjUtO0y4C/Nk+bFrlTQGr
 4Y+HMgPQKxs9gtrUHk9Yx2De73tN7VEz8Za1wGIs6GwPebyemx4lQ3Lckt4e86prcZVmG2xUv/R
 pJFU3RaM0cQO3Qr9lbaPTskIzuW4gK6jGLRrFv4PWik555E4tfFeVmbj63NhCKyfZ9APH8qhDDG
 6lwvinRMirpO+gnYOhdzV3qGIW5HcvFURAO9g2sJqskXw6TWtLH3Gg5YV6BUXnJtPNzmtuLzMdy
 EyLoIdUMghEvnA7g9MJRW7uv6c3EDEyDSnWYZREaaIRN0yMe5ZHjCOxXc0liBOorKsuJkeVc34T
 FT8nfHtEbmi/Q3NA06lb7oRyJNzWq6lcqmqPs1garXC3ZKLBiADd9LvAN3+qPblJ0TnjUw5SZPs
 cbDvglCgfXgsVJXlUC9I3CKrYsqH6Kz1ZiD9EKcnBl84REhCLEjTcWONEbAOfN
X-Google-Smtp-Source: AGHT+IGpVBK4bpTWlHEYRXUfwuw+sd/Y2UcFDCGKTwtEqfjJtIx5C6Tsr4QY/KrpjEHYkALujP+MaA==
X-Received: by 2002:a05:620a:318e:b0:8a2:689a:edbe with SMTP id
 af79cd13be357-8b4ebc4421fmr3540089385a.3.1764626672002; 
 Mon, 01 Dec 2025 14:04:32 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b52a1cad4esm934398885a.45.2025.12.01.14.04.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Dec 2025 14:04:31 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Pablo de Lara <pablo.de.lara.guarch@intel.com>
Subject: [PATCH v9 5/9] test: fix format overflow warning in ACL test
Date: Mon,  1 Dec 2025 14:02:03 -0800
Message-ID: <20251201220421.207285-6-stephen@networkplumber.org>
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

