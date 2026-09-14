Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D332DC88E67
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 05:51:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C361A40A87;
	Mon, 14 Sep 2026 07:50:24 +0200 (CEST)
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12]) by mails.dpdk.org (Postfix) with ESMTP id 76965406B7
 for <dev@dpdk.org>; Mon, 14 Sep 2026 07:50:23 +0200 (CEST)
Received: by mail-pz2-f12.google.com with SMTP id
 41be03b00d2f7-cc4b29fa803so1255580a12.1
 for <dev@dpdk.org>; Sun, 13 Sep 2026 22:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789365022;
 x=1789969822; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=coOkkg8n6nLOJYvGlI695zgjM+lG21SWysfmcLhYbsI=;
 b=lbC8yyrPmUW+vCErGNn4JToXN2IBx8W30K4UUIKf0LM7U8H3lnkN9PQ4Ti5f5VLoq+
 jLMZXBVf9XDYVYmSsRahC/UEVvRAUYbyvDOb4jPDCW3hn0S8YzT1xb1WvWlOzQnRVOJ1
 NgGW3atbN8PvKBek01O/iWdHl43R7PIWlpuG/KFvtaUKoeWCIJiGpl/yGB1g+5z519wA
 aGQNVoCy270O9RnD+9XM+oFds2bFvlhjBeXu1AbikOeEIze6hZ3c/InzNrsUsMcu+qOZ
 sbTsfAxe9SUlsxwnlYovvO2zfvFZV9A3bXoyAAGrHhUUZZKS8T3liviSlQAeGGdflPB1
 206A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789365022; x=1789969822;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=coOkkg8n6nLOJYvGlI695zgjM+lG21SWysfmcLhYbsI=;
 b=fWkw+1J/GnIo+fRNFFJ75ZVn6Diayp2eCSR3gpfWezK+UD7d5es9h0Mf/HSDiOVr3h
 86YkBhorAV5Vujokx0MR2QOI46gi/+rI22SYIXbd+Xf+NbMF+rPOV5izHH0VKMe0ePEz
 40pqeZN3XRx4dEwlej/NKnpmGiAVce9o6USkSBr6SM6otNz2WPI+qZMypa5zv8vlzL8O
 5pWoO+Y1L5EJFvbQbVxxFJCBMeAx4kYks6kCm0pcW0Qnzgihw/JfenQM7twKfucTrKp3
 a2wpFILfPVAVBozq4fFxzFKNNGrQHAnbVUtSXM5I70UCKK49oFhwigHTjsB+rDcwf5U/
 Ev5A==
X-Gm-Message-State: AFuF++nUW0kCw+Ttx4jlw8pKy178VL2XRDoesJ/D0O61jPOoeCv8J9ka
 XQS7jeLaDnlheZycluXQR5/MZLA2f/I6rzs9llVFHkZptBmG3NCEnksAXavKuNUZC2dUgGv+vY7
 MJQoGOLs=
X-Gm-Gg: AYBFou1MuRV6wW2Pe7dQWrfg8VnuKYH0wAFtEmXL7Jf/vGFl3kFJUoygTU/L99KhITO
 0umA+xNsBwtioqGbipOfDftHpGYOw1ZmQr7b4zJLh3vDLTyq1WEa27X2Byu/cIsqUN4WH2meRMF
 +nhDAhkFSTfD0LddHpHOOQ8SqXk9Fi6RUscsvo4CFVktKAlnIgl/N+pAwEADRqPu5QRdqu1Ay3u
 ieXcH9YT+nI17wPTVfX5l0IukI7JKjGfEc5c5ppEGoua+iskkPhPaLsXlNIJW0GUcCKnTOtC6i0
 a9PBOyksKjVYO3mLaBrErkkmJ52ZOQB/fSk0I/Ksfn0dLwn5cQBz0LceBoFeb8m7mta4vNUIRcL
 PVWL6mPe1JW0n3ZEwTGSc7JDXTwHODZjj71issWBKDiGgu7G2/H+jN4yyF/xNVNzwX3gr2mMj0r
 bx4OYR4JHkDHn/4VkSWto+Y+ZQGq6ZpRCwzcNoY5XteNyF5UvfAcQ0+JIg1KMmTcOTEoquVcbuR
 Elzt0PpRfzOdhwMeQuHiLb3RyZWnx4BtTw3dw==
X-Received: by 2002:a17:90b:3c47:b0:393:19a3:4f1 with SMTP id
 98e67ed59e1d1-39debf8d92cmr2792546a91.6.1789365022626; 
 Sun, 13 Sep 2026 22:50:22 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d95864b4fsm19794492a91.15.2026.09.13.22.50.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 22:50:22 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Gaetan Rivet <grive@u256.net>
Subject: [PATCH 19/62] net/failsafe: use kvargs numeric helpers
Date: Sun, 13 Sep 2026 22:46:50 -0700
Message-ID: <20260914054912.755403-20-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914054912.755403-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
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

fs_get_u64_arg() returns -errno on failure, but errno is not reset
before strtoull(), so an unrelated earlier failure is reported. It also
accepts a value with trailing garbage, and base 0 means a leading zero
selects octal.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/failsafe/failsafe_args.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/drivers/net/failsafe/failsafe_args.c b/drivers/net/failsafe/failsafe_args.c
index 1b8f1d3050..f256a9f6a0 100644
--- a/drivers/net/failsafe/failsafe_args.c
+++ b/drivers/net/failsafe/failsafe_args.c
@@ -345,24 +345,6 @@ fs_remove_sub_devices_definition(char params[DEVARGS_MAXLEN])
 	return 0;
 }
 
-static int
-fs_get_u64_arg(const char *key __rte_unused,
-		const char *value, void *out)
-{
-	uint64_t *u64 = out;
-	char *endptr = NULL;
-
-	if ((value == NULL) || (out == NULL))
-		return -EINVAL;
-	errno = 0;
-	*u64 = strtoull(value, &endptr, 0);
-	if (errno != 0)
-		return -errno;
-	if (endptr == value)
-		return -1;
-	return 0;
-}
-
 static int
 fs_get_mac_addr_arg(const char *key __rte_unused,
 		const char *value, void *out)
@@ -416,7 +398,7 @@ failsafe_args_parse(struct rte_eth_dev *dev, const char *params)
 		if (arg_count == 1) {
 			ret = rte_kvargs_process(kvlist,
 					PMD_FAILSAFE_HOTPLUG_POLL_KVARG,
-					&fs_get_u64_arg, &failsafe_hotplug_poll);
+					rte_kvargs_handle_u64, &failsafe_hotplug_poll);
 			if (ret < 0)
 				goto free_kvlist;
 		}
-- 
2.53.0

