Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C23C61DD6
	for <dpdk-dev@archiver.kernel.org>; Sat, 29 Aug 2026 15:47:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2345F4065A;
	Sat, 29 Aug 2026 17:47:30 +0200 (CEST)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42]) by mails.dpdk.org (Postfix) with ESMTP id 9AA0D4067B
 for <dev@dpdk.org>; Sat, 29 Aug 2026 17:47:28 +0200 (CEST)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-398a4dcf289so879312a91.2
 for <dev@dpdk.org>; Sat, 29 Aug 2026 08:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788018448;
 x=1788623248; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VytXLc558jbvkMOcrp4s00+AfjprUJPCbQkvn/5sN2g=;
 b=YizoB1pgXS8Gu6bmkVovJZdOCa0O74RfX8AjZHQL5QD8TyHa4xX9QxUM6vIWT5n4M9
 /45cpIiIYlJurvglLGP0BdiAcj6sE8xeWq/1JRHkP69su6kHTu86NkE4N829vfegqxAc
 hmKF+tEumZ7OiF/tuLtoHee9lHh4doXprIapEVU2yh7kh2q56VIBYRfv0LIVhsogKU1H
 zdiZPq8cQF5C4x9ex/6Ijl7oIbtjApVhxNrIGYwaAkrItCFncl6o3zje8Eva9QS3jEen
 dTwOnHh5G5E+kqrQp6sRUmXK1dcQ4Yaq4OYhBefvSuQmhGz/oKnPDtAlnf6J0+MSKGgF
 RGfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788018448; x=1788623248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VytXLc558jbvkMOcrp4s00+AfjprUJPCbQkvn/5sN2g=;
 b=IK9FlKyIRh5xB5uyDjBqJUdVgjtB6IWTnmo1GD2WG+FZXLMchIEPSyxmotoo2xSD9R
 GMzeuZ/8GPp+JsKHPgdhCAPrKAP5w6mzFSZLMa2CXlFNgw/EQvkBuUhBWemv+HYdyLrz
 H2UNfhoQP/zRiKBjxcuEuAsxuHeF5donjHYm5jCf0yMjNhQ3LPWoQEdVdVEgUecuKCra
 yJmP/ybKiCrWJm//b+sGhGz6muUqtNnA6FY1JksOddT/2KVuf6JEwJCrzXTPAK5r4/e8
 oKEzPhnn7aCwlQ6etyLznUTaIoQGwrR+5SE6+vewqVMZyiTZe2PsQhdia3cloV8rpI77
 R53w==
X-Gm-Message-State: AFuF++n4eVhZ1EMhWEHhtEoNILo88DHYSbue+8/uUC9m32yq06N/hn/y
 uOb+QKAzsYG9h/z6yb+MQcVIwVfXGfaEucELMVWvKr8pCwkact+1hbOXPOzychwFTsQVs4R1HpP
 ja+cW
X-Gm-Gg: AYBFou09h1HZNaNAShGCEPWUSwwxOUd8KqI0GYXtmBHqadNNmxUIGITm8f3m8islCpi
 TVetQgkAxOehEurvz50RsMb3Iqn7zPvXpYSrV4+iXKJ6WmCswPxUUuxod1ycVx+eKEzNA5CagOi
 mOKjdgg4VbzvCSnz5oiR9xFxkvRbGNiq4+cP++6ie4oOZRiRu9alSpUCItXWcptgFXmVyfXStms
 JckAoSe8hoSHDDfUZstoWVBXKnIUjgAbvtt0fcK27aDzmNZ30Fix3evNICdq/xs6IVaoq5kSsIN
 ufqx1WxIusoU+uXhhSzRHm1FXr+IZ1eKlWJa6cAFZtBtMu96JN4OmEfOdBK6E2GQIlN92tgmZxT
 dFzZQcesw7lUPvqKYqreb0XzzyHVqBC7xLVZ6H+2SO8C9ZqrGfpd9p2hF3CyO8VNEwbm29fxnzY
 YRG0LkIlCeavDbFZtGSSCaglj+FxeNM7/feT21NI0+SDhAr/aeVYFCNhd+x6D/oi3xhikF/GWFY
 BaJoigZnk2uqLWB2dsGIXdML7wp
X-Received: by 2002:a17:90a:6d89:b0:398:b88c:2b7b with SMTP id
 98e67ed59e1d1-398b88c3003mr3567592a91.8.1788018447718; 
 Sat, 29 Aug 2026 08:47:27 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-142e41837c6sm13221356c88.11.2026.08.29.08.47.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Aug 2026 08:47:27 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [PATCH v2 4/4] net/qede: remove unused app version variable
Date: Sat, 29 Aug 2026 08:44:48 -0700
Message-ID: <20260829154706.52169-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260829154706.52169-1-stephen@networkplumber.org>
References: <20260826235933.194681-1-stephen@networkplumber.org>
 <20260829154706.52169-1-stephen@networkplumber.org>
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
clang 23 reports:

  qede_debug.c:820:12: warning: variable 's_app_ver' set but not used
        [-Wunused-but-set-global]

Since the whole qed_dbg_set_app_ver() function is doing nothing
remove it.

Fixes: ec55c118792b ("net/qede: add infrastructure for debug data collection")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/qede/qede_debug.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/net/qede/qede_debug.c b/drivers/net/qede/qede_debug.c
index 1d3147b724..d14ef93a3c 100644
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
@@ -4864,16 +4857,6 @@ enum dbg_status qed_dbg_set_bin_ptr(struct ecore_hwfn *p_hwfn,
 	return DBG_STATUS_OK;
 }
 
-enum dbg_status qed_dbg_set_app_ver(u32 ver)
-{
-	if (ver < TOOLS_VERSION)
-		return DBG_STATUS_UNSUPPORTED_APP_VERSION;
-
-	s_app_ver = ver;
-
-	return DBG_STATUS_OK;
-}
-
 bool qed_read_fw_info(struct ecore_hwfn *p_hwfn,
 		      struct ecore_ptt *p_ptt, struct fw_info *fw_info)
 {
@@ -8087,9 +8070,6 @@ void qed_dbg_pf_init(struct ecore_dev *edev)
 
 	OSAL_MUTEX_INIT(&edev->dbg_lock);
 
-	/* Sync ver with debugbus qed code */
-	qed_dbg_set_app_ver(TOOLS_VERSION);
-
 	/* Debug values are after init values.
 	 * The offset is the first dword of the file.
 	 */
-- 
2.53.0

