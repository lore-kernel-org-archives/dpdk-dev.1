Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 233B9C5DF97
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Aug 2026 00:00:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8698840671;
	Thu, 27 Aug 2026 02:00:01 +0200 (CEST)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by mails.dpdk.org (Postfix) with ESMTP id 58C8D40664
 for <dev@dpdk.org>; Thu, 27 Aug 2026 02:00:00 +0200 (CEST)
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-cc1c3c90074so1366508a12.2
 for <dev@dpdk.org>; Wed, 26 Aug 2026 17:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787788799;
 x=1788393599; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gjkGsyQc+xs3FEv3bEVshvsqJTMDT2dXKT053Svubm8=;
 b=X5UDZO6MKsNeJhx41WRM4OGJPy4o24FzktqipeCoGw68jjgmB8b2Helakfgh4Lt3ac
 wo+3Y/L3IGH5MhMO5FhzdxNd4CX2mmXoZTQkRpmRDp3uKdVI/S8ZlRSrIqDNhbJLW3MJ
 qMMThZtr+fVppWb/xYByqo6vK1Fb41zjT/u2xzcmmr2Lsboc9hPZSn1iTob60GhEqMY3
 EnJ2CxgSZIvwiSUctjAdFvF0F4/Lv42kZAhxRdZld1cvTjvz7udZNL0a3N7HR1gq7ZZk
 OUcy85KYJ/GjXDaiyv9OO9Ej84U+4T+h+/VVoC6T52JABpM/Zmr7aPhirFVvOPwWcxtd
 I82A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787788799; x=1788393599;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gjkGsyQc+xs3FEv3bEVshvsqJTMDT2dXKT053Svubm8=;
 b=awYLRfph4bUYETMXdBPTh30d1VcjhGcEapp2JVIixVRDOEW6w376To2Y9eGCmJlj6E
 qTVghmOCK98+9gKCNc5gFl4hyuuC413tsiZGRH9Cj6zoTMMy7bOMFCAYgrMc7CIvWUxo
 jnf0QnEW+b0VyhuddWYahOJDHdk31z0yjMmL+yLZvLZY7NaHe8xQcsWtDncXQSXsVedd
 iuUkLtVspRO0KGKeYXoXaZuDJ8vW9ZXf1vcpg1fhY6PiTZywHCmFOBSQ7QXKyVyCkewh
 JZ+U73WKvSfVZS8uzUDbuX7MFxzawU+dn8FtPL2LFfR938uA7PBt66g0Mjnh1sJxjj4k
 cdvw==
X-Gm-Message-State: AFuF++nC6MiF1sFhMc65CQb1YjjAwzFhJ0p/mW+uuZUrFzjWQZ7+0zLm
 5EplOARxY3xBunU/nf3mvGTBWD0b7b8RkYNCIkNSMx81L9IX3Sd3/GSFQdjBpCE49pX3m8cizO9
 ZK6gH
X-Gm-Gg: AR+sD1251V4LcaMOkmSgfFxQ6Yfw8Banr6P2mUHwD6Z9AIGBNcZBw00pdoT/w2KN8Pv
 vOxG9aY8T7kRhdl3kJFqrRvBdccTaSeYgd9QCUg8aGf2JNfGexL0s3z3h6uuD1RwyMMhiY3eFVb
 6bM+s04QdoarGhH7YQNTP+J9VSE8eqVioHVpusEnafzi/KM7LMwmMjOztHd4YCLzoA2hUg53lsN
 1x2UwyHAaP0/tTcEGDIXcWaW8FftSB/ruQT/z7cdiYsr//0pbtO8i9hzOSOCjhL6dorYWHISvVf
 4tCUW40sNFgGpqbpYKa3opv9sOY0qBEb2gqH4fsSes9CEBwckTL5nay4xXmhUTLTxcWBveppM+f
 pg6XoK3lEZoGrzsbzyCenCn2LoeDX5kyiqhtTg1bhs1BEWWtNXoMx0ul5A6/b/tJUC2QnLuTXzn
 rSWProTTCFROjIs7wfKXx3BW62f0Mh7gUCXm94K9OJh9viE7AnR4Gxeeovav00nmkrtBjDasSZE
 1XQFx8/TnkCEo58e1Hj15iE/r8=
X-Received: by 2002:a05:6a20:6a11:b0:3c0:b766:751b with SMTP id
 adf61e73a8af0-3cf8455031bmr17322222637.14.1787788799533; 
 Wed, 26 Aug 2026 16:59:59 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-141a8eedd13sm11019596c88.1.2026.08.26.16.59.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 16:59:59 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Devendra Singh Rawat <dsinghrawat@marvell.com>,
 Alok Prasad <palok@marvell.com>, Rasesh Mody <rmody@marvell.com>,
 Igor Russkikh <irusskikh@marvell.com>
Subject: [PATCH 4/4] net/qede: remove unused app version variable
Date: Wed, 26 Aug 2026 16:43:04 -0700
Message-ID: <20260826235933.194681-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826235933.194681-1-stephen@networkplumber.org>
References: <20260826235933.194681-1-stephen@networkplumber.org>
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

qed_dbg_set_app_ver() validates the caller's version and stores it.
But the variable s_app_ver is never used in DPDK driver.

clang 23 reports:

  qede_debug.c:820:12: warning: variable 's_app_ver' set but not used
        [-Wunused-but-set-global]

Remove the variable and the dead store.

Fixes: ec55c118792b ("net/qede: add infrastructure for debug data collection")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/qede/qede_debug.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/net/qede/qede_debug.c b/drivers/net/qede/qede_debug.c
index 1d3147b724..8afaa5c108 100644
--- a/drivers/net/qede/qede_debug.c
+++ b/drivers/net/qede/qede_debug.c
@@ -812,13 +812,6 @@ static struct split_type_defs s_split_type_defs[] = {
 	{"vf"}
 };
 
-/******************************** Variables *********************************/
-
-/**
- * The version of the calling app
- */
-static u32 s_app_ver;
-
 /**************************** Private Functions ******************************/
 
 /* Reads and returns a single dword from the specified unaligned buffer */
@@ -4869,8 +4862,6 @@ enum dbg_status qed_dbg_set_app_ver(u32 ver)
 	if (ver < TOOLS_VERSION)
 		return DBG_STATUS_UNSUPPORTED_APP_VERSION;
 
-	s_app_ver = ver;
-
 	return DBG_STATUS_OK;
 }
 
-- 
2.53.0

