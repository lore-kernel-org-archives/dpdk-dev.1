Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5025510F6FDC
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Apr 2026 16:41:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ED10A40BA4;
	Wed,  1 Apr 2026 18:41:14 +0200 (CEST)
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177]) by mails.dpdk.org (Postfix) with ESMTP id 68B12402E2
 for <dev@dpdk.org>; Wed,  1 Apr 2026 18:41:13 +0200 (CEST)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-2ba895adfeaso13958eec.0
 for <dev@dpdk.org>; Wed, 01 Apr 2026 09:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1775061672;
 x=1775666472; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eilep1PI3o3Io64GsWgbVN8KdJFnqXFK/lbGGvdhkhQ=;
 b=Ft6/3atDdFXzJGBqZfjxZk3CLuG3DafdUf+9dFb8J2QUOEFMjFvyTl3iixSTr/rqhP
 03IdxY9+M2ADrh4LcT3tHxZ7ekLa1uE9+e8dMEmmTe5HSheh/0Ml+n6QGPE8o3fmwx9o
 W/nwvnVXsFf7oqAbVW8yim1zxlTaTri9ZeBNnhTpJ56iycat/aIpKDy8RMhqLuH56N3n
 fHNdYFrXaKd5sC3GhoRBz/eDH3Miljiw743QpvmF2CgUk+0L3iJuOhwMUdaS3aY43yuv
 KDo9hPN7mvdvaKsPdojIAn6BudxEwYu+cp46hk5BB+8MX66baD0gaEzw16Bq6v8ZdDvV
 8PfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775061672; x=1775666472;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eilep1PI3o3Io64GsWgbVN8KdJFnqXFK/lbGGvdhkhQ=;
 b=i3zBFkH8ByvjHkBbBWzPA4eXQ7gdfbmQu1vRCzZtJGrOeYT/Rcn4YmU5oxZ/tHFpHT
 IFw5mRSxZix6a1kky9smhm6i82HL77SUafZXfQe2NTivlNi/MuNV8kN8IamdTozDTBY2
 8jSqcJ18/RXJMfPjAzkVWA5XQLpNxWPU5yvBzBKtPzeaTmRyxPDecl1XvTGud7QvW65K
 g26ZkoioBAVP8+MasvUCXeCYIP0k3DTMlqYRwt6Nx06lC6E+IeRpmXb9TLi5kqhTYfLP
 w3CvXm9CKvPqClgSWdb3UOOJZU8qskqoD5LOfFeUuPhrJcWefyJH1X735muA9tXHNqe9
 GiVw==
X-Gm-Message-State: AOJu0YwvURE4SCfss1znbQ7xttkK7KJz96qO+Y2xF9vY0Qk6u0d4SNau
 D50RHAT/SE+G8DLF/HhjpVFqubLzI3lCHSV6hYNKIa1fSbjWwgZi+TTnd0AFVwvNpfpJ37xpnR5
 B0qHF
X-Gm-Gg: ATEYQzxRhJ2dHIrgDmT0rhUgLF/kkYPBBebpAWWmlaXQ8gHmUnnrlorVAZn3536cBzl
 OAdXob6ELMZ8wRS0whtuRKw3uut+8zOqV0yjYBip6LTcxkzMTyGkY1Lji/OMBZzZ0PXOumqFLts
 6bd2k/1kPNmVTNqQ8/pg/3xfj+VSs9e3a+9idYb89yek43phI4iYy4SXnXDzNL4OayXS4MSEVGU
 2W/jw0TFnhHyWSlNMDNVlWQkuDejzLDJbpWKurgLV9xV2v93jDlGmiKgIljN6UUlGlFExvBkTNY
 h50qtDUn0so20VDh9AcL3shwFqpezUw5H6EBgiYI9U3Jx9gIrCf4EVy6d31TI0AnVJWrYHmyn/Q
 vI3tCueKs+B5+DoQn5fpaYTtttfKBWu21BC1jyio2dSUL50VrrhGPsQIAvVOMV79oim+9shnwWr
 qnoXkv4XVUYY6UeFwW3yIXMomgY7+rISOf
X-Received: by 2002:a05:7300:2213:b0:2c4:c4ef:48f7 with SMTP id
 5a478bee46e88-2c931170de3mr2240586eec.11.1775061672240; 
 Wed, 01 Apr 2026 09:41:12 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ca7c20c0c2sm202583eec.17.2026.04.01.09.41.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 09:41:11 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH 1/4] net/ice: remove unnecessary null check
Date: Wed,  1 Apr 2026 09:40:22 -0700
Message-ID: <20260401164108.201404-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401164108.201404-1-stephen@networkplumber.org>
References: <20260401164108.201404-1-stephen@networkplumber.org>
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

No need to check for null before calling free.
Found by coccinelle script null_free.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/intel/ice/ice_dcf_sched.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/intel/ice/ice_dcf_sched.c b/drivers/net/intel/ice/ice_dcf_sched.c
index 948774a282..14e902edbe 100644
--- a/drivers/net/intel/ice/ice_dcf_sched.c
+++ b/drivers/net/intel/ice/ice_dcf_sched.c
@@ -877,10 +877,8 @@ static int ice_dcf_hierarchy_commit(struct rte_eth_dev *dev,
 	return ret_val;
 
 fail_clear:
-	if (vf_bw != NULL)
-		free(vf_bw);
-	if (tc_bw != NULL)
-		free(tc_bw);
+	free(vf_bw);
+	free(tc_bw);
 
 	/* clear all the traffic manager configuration */
 	if (clear_on_fail) {
-- 
2.53.0

