Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FB5D0E6F8
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Nov 2025 15:23:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6CD8840DDE;
	Tue, 25 Nov 2025 16:22:47 +0100 (CET)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mails.dpdk.org (Postfix) with ESMTP id D435640B97
 for <dev@dpdk.org>; Tue, 25 Nov 2025 16:22:41 +0100 (CET)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-297dd95ffe4so50257595ad.3
 for <dev@dpdk.org>; Tue, 25 Nov 2025 07:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764084161;
 x=1764688961; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fm0fKRDS4YRVts/D6rPe52eqre9y2vs0bibayAdUECg=;
 b=Oax9Wy9thPbGnGsCeUvuDc3u3mv15u1MSknDz6Ci1jdKng/3blaubJ2GNw6ZEXVavd
 vJos6G677sv2q01GW0Sanp9JP9zZfzkrxQ/FiyGBrusCi8FeVihI705364RvD1QET/pL
 cLpYWxqd0Uw5NfnPZrjR82/kMaeJyQoil6zJk0Qx3DW5d7tC8qvShQyIF4rB2gZD9ijX
 qPjxxjWbfsCC8wkzglVydXYU1T1QAhkmMyFSbfuEirk3P4KH88WVg/pqRY5/qo8lQfv+
 AY9GavlhhlFbwxxEMrkBwMJJMhu3bwxWQ6Bbv1GIm6LBQDaSBe0sJK7ALELFacVPweyU
 oNfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764084161; x=1764688961;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Fm0fKRDS4YRVts/D6rPe52eqre9y2vs0bibayAdUECg=;
 b=I8ZK07mXxH/Ev2uXbGdjmT0zci6hYNQXIhrVcaMkLGiIe9dj9AXuRFpx3mxeEOfAcF
 G1Of8QZ5vddpFNN4W7Zpsza/es6oB/rFo99CKS0SqraGBdbLMMBuiMmTlAQE6C5ZpLJX
 IwyryCYvo9HkpysPaM+FFp0oZBE5uzZOZ4lFifuA0+TsVeWpus7q7jolghMaY05h762m
 bQjEBydbYBzSZ1K74xmMQ1kb6VE40wOMjbN4LO0Bdx2PcMDelUlSa69rTcvhd+BQzNbs
 50dg3qJ2YE4SFC1ffC2yeCXzMVjk3Mss7w5okjx2TOzL9i9aPi74tAxAW1gvHYDmbhcy
 nwLQ==
X-Gm-Message-State: AOJu0YzqqVD4DHD8YnC2/qbOCX+ABhjQ3haY9pKV/LbZZZg9F8tQuLsp
 jBCRZK0bvd5iMJvabSSXmXPbynezKrxADsN87UPKDHuKhbZmxVXSl1B45WB8Td5Wco1TA0Y+toA
 yPKRp
X-Gm-Gg: ASbGncvFuRanOyKvsctiWVmtYNa/OvqYV3uSUXrTLy4kjRZiWAnGx+PuDX01h1rcE9G
 3QCTVBCgNMmUB8kSOx5Q8/jRfZwkayNP9jgY2Oms3bKCHhw5bMYEOcCuzKezTpnbjfXzdO4CylR
 4CH82E9oZ8im8YxV/zLla5yaN374lOJIeQlwxH1gycAWE0C+VpnwP3N5SeHGI3ICa1FgoxQCVUp
 OVLT1CxvOxS7lyScuBDOR8hvuzLIh530V9hi4mBN11oN7BX5188WC9XrveFFghK+ZYm98UNGkrk
 8UzI4A4NsLwhhRet+8qD9mt8t5eB+qLHSWiElmRnZS2TcU83MZCjuM7qT4yBHM9R9UYLCxzjvYb
 rNFIaaI6af7fYUR2DBh3W9RX0n2FtAXq550UZuO6e+3YJyTKgOwr5f9ENpc5RCccYTk9FIAxwLW
 muTHMObQFtesrCgL+HWHKqyMMDwZn6AbSF/S4=
X-Google-Smtp-Source: AGHT+IEvHtXvm3KapcnzbslW7MeZDiIC0wNNCJjuB4jcmZGztMnUeIQ7ByP8eYKlA/X0foUvV2Tp8w==
X-Received: by 2002:a17:902:e550:b0:298:42ba:c422 with SMTP id
 d9443c01a7336-29bab1460aemr35703835ad.31.1764084160902; 
 Tue, 25 Nov 2025 07:22:40 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29b5b111acfsm172573345ad.19.2025.11.25.07.22.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Nov 2025 07:22:40 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Pablo de Lara <pablo.de.lara.guarch@intel.com>
Subject: [PATCH v7 05/10] test: fix format overflow warning in ACL test
Date: Tue, 25 Nov 2025 07:20:55 -0800
Message-ID: <20251125152232.73528-6-stephen@networkplumber.org>
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

