Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90858CA5FC5
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 22:50:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1AE114328B;
	Thu,  1 Oct 2026 00:44:52 +0200 (CEST)
Received: from mail-pz2-f32.google.com (mail-pz2-f32.google.com
 [74.125.228.32]) by mails.dpdk.org (Postfix) with ESMTP id 87D8F43265
 for <dev@dpdk.org>; Thu,  1 Oct 2026 00:44:47 +0200 (CEST)
Received: by mail-pz2-f32.google.com with SMTP id
 41be03b00d2f7-cc4d04d73b8so2306948a12.1
 for <dev@dpdk.org>; Wed, 30 Sep 2026 15:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790808287;
 x=1791413087; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=daIJXiSoXKhz8lpZgwqv/Nqoyvo7VuJEdsUWf0MAOQg=;
 b=ZU47P3e+c7YGy2tj6NFGoL6QpOrUGzv7JGg2TTfwtrYHqw0hrB2hvZ/Fv3BMXFlwKl
 9/3TIq7yTrxMh2Fu2RnsEvHQ5ZKM/iTiROlR1FX2BWjlXpts1GlFXV8Vmh708QKkJ9+G
 vn/5xgnlENq36RV1v4sRfl+wcaEkPxPFCk4r8vC4t/Qru2ugE92DdlPWHk5cnDwr+cE6
 JcgK9qOTwt2EFSweM43viKLrVBrte2OCMWQobKr3Ka2aQe2k9fdg44NUS23acmimGFFW
 yBvi4U7IcYdrquUbeTnZfbBlEi6dsWjLqSndlMA0by+VgaRa42w2R3o+YsUR7yadCqx9
 99iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790808287; x=1791413087;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=daIJXiSoXKhz8lpZgwqv/Nqoyvo7VuJEdsUWf0MAOQg=;
 b=F4SChbxzSKPzOfCXhrOhquQez/Lp5AQoyuTo32U6hc4lk+4IFq41cZKOtK1n3RbpQ9
 IuFOhFZ8SztqE+Sup69eOT5QFKhNDxJFk6sLOfIts7wrVED3/hH7BdFGyhNmvx8t0FvH
 EoVxbiqrVOJmUBHIvgeTl3ctgWIF9xCTP8Lp8xPcEPCDOas+JyYSfjLKzIi62WV5d0AX
 7GYSc9TNt4oO1WYRurRzaP6+pBOTFelAFMwQWN0NuBROVq1WA5ecSGh4a0o1wamlvu4e
 GuNQ5zW2pOpExjw8Cb1yvSB1C/+g3KiXAao8YlSjqE7CeLEannu0bgEFe7GCV/aM2Vld
 pmNw==
X-Gm-Message-State: AFq9FYKHHzzEdodIePAznBTs0VWUJQANZ65uf/ea0eeVWL8RDe7D7bMp
 9pKAiQ5pox9ylnefcKwBiBzHzRh5YPwBdWDg9XLlmlj0hA4ev4FrrcxyfsJirHFl9clu4fDjs4i
 orai1G3I=
X-Gm-Gg: AYBFou0LAyGRwnm8vaqVTNulbIlGQMWsARbi4Ay2wDcBTweDtbYfXgwc0CUBIviKYUi
 f+MpJ1R1NDydikzmttW4ssPNcUk8Z4+vyIHV+T1NOrSgI5Uh2k1mB5dXhzLSOat70qbIo08tP/9
 F6DijQGg8KW2FDLs0as0hN2lM/D5AfPZzVSfbI10Nyuqkqp/zsGKGG1b9wBZLXfl2L+2P9jzFty
 awRJKQ6NBFsTChPNx05KZ5SCAN5Q7smWqqGiwxCHQdLiO9ZORA/5Lfn86HlcRUpLm5LxrEiHVB7
 6dFP20sp0p1xM7xiCVYpFyeVvQKtRQWV7ST3KnkERg639YuoWNvT0nQVMgafOI1uCyL5FfeVJIm
 5LTAHHvFjxIDt8HT9/KnBJ/9DjKTsd6H3Ue/eb3/Tpmc2RPLr7EwndPyY7yb0OOe4F7zNdz1cRq
 9AIRp7HfYS15NPRuPm/hw5+pkicF0lX5o2oWYJO51zDiKMhNuclxMFviYuexouvfb1iz0H6q6xI
 wNZ1qazbK0OtKJ0CGsNk09xoUUIeBltUzDMVg==
X-Received: by 2002:a17:90b:2888:b0:3a2:b465:fb8a with SMTP id
 98e67ed59e1d1-3a4d1ddc911mr2719362a91.67.1790808286664; 
 Wed, 30 Sep 2026 15:44:46 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f4371383sm1258985a91.2.2026.09.30.15.44.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 15:44:46 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Potnuri Bharat Teja <bharat@chelsio.com>
Subject: [PATCH v3 61/65] net/cxgbe: use kvargs numeric helpers
Date: Wed, 30 Sep 2026 15:41:19 -0700
Message-ID: <20260930224340.58580-62-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930224340.58580-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
 <20260930224340.58580-1-stephen@networkplumber.org>
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

check_devargs_handler() is a single handler shared by all five device
arguments, which dispatches on the key to decide how to parse the value.

The dispatch is done with strncmp(key, NAME, strlen(key)), which compares
only as many bytes as the key given by the user is long, so a short key
matches a longer name by prefix. That is harmless today because
rte_kvargs_process() has already selected the pairs by exact key, but it
means the handler cannot tell which argument it was called for except by
accident.

The filtermode and filtermask branch checks errno without clearing it
first, so a stale ERANGE from unrelated earlier code rejects a valid
mask. The boolean branch tests only for "1" and silently ignores
anything else, so "keep_ovlan=yes" leaves the default in place without
complaint.

Pass the handler to cxgbe_get_devargs() instead of having one handler
work out what it was called for: rte_kvargs_handle_hex32() for the two
masks, which are documented as hexadecimal, and rte_kvargs_handle_bool()
for the three flags.

The masks are still read as hexadecimal with or without a 0x prefix, so
"filtermode=44" is unchanged. The flags now also accept "y", "yes",
"on" and "true" as well as "1", and a value which is not a boolean at
all is rejected rather than ignored.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/cxgbe/cxgbe_main.c | 38 ++++++----------------------------
 1 file changed, 6 insertions(+), 32 deletions(-)

diff --git a/drivers/net/cxgbe/cxgbe_main.c b/drivers/net/cxgbe/cxgbe_main.c
index 2ed21f2d66..e0eefae6c1 100644
--- a/drivers/net/cxgbe/cxgbe_main.c
+++ b/drivers/net/cxgbe/cxgbe_main.c
@@ -744,36 +744,8 @@ void cxgbe_print_port_info(struct adapter *adap)
 	}
 }
 
-static int check_devargs_handler(const char *key, const char *value, void *p)
-{
-	if (!strncmp(key, CXGBE_DEVARG_CMN_KEEP_OVLAN, strlen(key)) ||
-	    !strncmp(key, CXGBE_DEVARG_CMN_TX_MODE_LATENCY, strlen(key)) ||
-	    !strncmp(key, CXGBE_DEVARG_VF_FORCE_LINK_UP, strlen(key))) {
-		if (!strncmp(value, "1", 1)) {
-			bool *dst_val = (bool *)p;
-
-			*dst_val = true;
-		}
-	}
-
-	if (!strncmp(key, CXGBE_DEVARG_PF_FILTER_MODE, strlen(key)) ||
-	    !strncmp(key, CXGBE_DEVARG_PF_FILTER_MASK, strlen(key))) {
-		u32 *dst_val = (u32 *)p;
-		char *endptr = NULL;
-		u32 arg_val;
-
-		arg_val = strtoul(value, &endptr, 16);
-		if (errno || endptr == value)
-			return -EINVAL;
-
-		*dst_val = arg_val;
-	}
-
-	return 0;
-}
-
 static int cxgbe_get_devargs(struct rte_devargs *devargs, const char *key,
-			     void *p)
+			     arg_handler_t handler, void *p)
 {
 	struct rte_kvargs *kvlist;
 	int ret = 0;
@@ -788,7 +760,7 @@ static int cxgbe_get_devargs(struct rte_devargs *devargs, const char *key,
 	if (!rte_kvargs_count(kvlist, key))
 		goto out;
 
-	ret = rte_kvargs_process(kvlist, key, check_devargs_handler, p);
+	ret = rte_kvargs_process(kvlist, key, handler, p);
 
 out:
 	rte_kvargs_free(kvlist);
@@ -807,7 +779,8 @@ static void cxgbe_get_devargs_int(struct adapter *adap, bool *dst,
 	if (!pdev)
 		return;
 
-	ret = cxgbe_get_devargs(pdev->device.devargs, key, &devarg_value);
+	ret = cxgbe_get_devargs(pdev->device.devargs, key,
+				rte_kvargs_handle_bool, &devarg_value);
 	if (ret)
 		return;
 
@@ -825,7 +798,8 @@ static void cxgbe_get_devargs_u32(struct adapter *adap, u32 *dst,
 	if (!pdev)
 		return;
 
-	ret = cxgbe_get_devargs(pdev->device.devargs, key, &devarg_value);
+	ret = cxgbe_get_devargs(pdev->device.devargs, key,
+				rte_kvargs_handle_hex32, &devarg_value);
 	if (ret)
 		return;
 
-- 
2.53.0

