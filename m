Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C310C5DF8C
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Aug 2026 19:28:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5AB7A40696;
	Fri, 21 Aug 2026 21:28:48 +0200 (CEST)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com
 [209.85.210.174])
 by mails.dpdk.org (Postfix) with ESMTP id A198140B8C
 for <dev@dpdk.org>; Fri, 21 Aug 2026 21:28:43 +0200 (CEST)
Received: by mail-pf1-f174.google.com with SMTP id
 d2e1a72fcca58-84867f07d63so1329654b3a.2
 for <dev@dpdk.org>; Fri, 21 Aug 2026 12:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787340523;
 x=1787945323; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EmJm0SnVO+p9PIoyWZ0Gg+zdgn06byUtmevKiazhJTI=;
 b=hO4hUfzSn0zrx+8BInKp6WilvzNG8puHAOF4ks69AcnINLf1bmdZGuycfYhItDPSEP
 vOnJuJXkf7srkIwlbNxF5Dm4JTgdFG13mkcvfRrnwvxidiIpjtewkZfx/bbV6LwtY56E
 q+0nOacp0PQD1rlpbziq5fusEJRD2qxKyInaB5PCicqR1MezBKSwEESuUMJfULgg9Nok
 p9nRnoYs/LtXAUWSDeunfHUJZK4+HSgDcWRatwm0r925+U/HRoVuKIDX53VAXKHjv10L
 keeq3humlzqvR7kzUZky6LacwmSKYTHayDd+sDnIsFI6geuHNLM7gc3WAigMfVKUzYQK
 ydbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787340523; x=1787945323;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EmJm0SnVO+p9PIoyWZ0Gg+zdgn06byUtmevKiazhJTI=;
 b=RAssTkA4SNvV6Nwmm2kF+l8Z91HeUWR4dPAl9PSvZJfv9rqffeTREkCvPOxgDZzkNe
 4LOSqgpJmaaYVZz6P5aZGHtVWsvv22GyikipEvBa9BDy2fL+Hip7WrxclIhF1+s6/QHs
 Ln2wWaZfIW/2DQXjcJhyjxuNJx19HXSZyGW1YnK27FfqlwhaBHDG9cVynDv45pvUm+gK
 WLT2phj+pYyfAIYAM3RlN9CqdQldBKZknis5RIrlK1evf3ncCcIHHxjoMfni109s8uwu
 MX3b58izgXB6k6Lmqjxog6Y8RAi5k2LOh4Tb13h6qDy0gNAe5J1w0AqtktbO7etZIcPc
 P0JA==
X-Gm-Message-State: AFuF++nmQwvUbUC2ymy65V/G5OYIekcpG9QDd6rwyA+QqDqlo87cj3s8
 SSIDjDAsigN/klH8ecueCEOX+XxFDEytDfyzzCyGls6QyGars5r9yU0KXBJzwWqtgPXd3Ck9fT5
 OpE/z
X-Gm-Gg: AR+sD11pRBMCWy0jTBVkbmjPsqGcL8QfeF35zu2Ajyifq2b3Q7UHQsU6TpkEPvl+elY
 CYGfDNbHaxNjTHS3l2iZM/i14Ebwo1cirTsR6zk/FW8BDRQZrT92ZitmAqCsxlFW/SW2raYl6Vx
 cKB3xh50FntpCiGfu20hVZOshAP1Pl0flTerBZpEiOodWhY+PJqS+K6oiqktUxISoJxYVolagN5
 K/m7cpUkddXxqTTk88RO6Av0O0nEWWDCA8p4fFC8/iBiz38FUBhgIb7gzu9TRshiFFs/n53saUA
 RrGSOFOR3A9kyrOfZn5Bx4FzoUyAfo7B5y/Ho7J5D54JG9PixBapISrNBYXehwIy8v69V05h9iM
 QQ2YUGCVQsv2naZx4kaEE3pcDI2xLDPwioerauDEBEITGpTYscSXx4JLZLrPk/TSFNi+PrftxLZ
 L0IYykRH2sHcK24xVar78sHXtkPVjkMQrhZhgkrRaW9A0RQYXOi0skX8Ur1c1/tKvZrJIu874Lz
 +fwTiSkchK+/GJ2ScLkZYn6mnA=
X-Received: by 2002:a05:6a20:d48c:b0:3cc:9162:6bfe with SMTP id
 adf61e73a8af0-3cd4b68476bmr2307353637.0.1787340522794; 
 Fri, 21 Aug 2026 12:28:42 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc16c6dd2f4sm1860304a12.17.2026.08.21.12.28.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 12:28:42 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v2 13/68] acl: remove unnecessary include of rte_memcpy.h
Date: Fri, 21 Aug 2026 12:24:08 -0700
Message-ID: <20260821192646.146382-14-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821192646.146382-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <20260821192646.146382-1-stephen@networkplumber.org>
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

rte_memcpy is no longer used here.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/acl/rte_acl_osdep.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/acl/rte_acl_osdep.h b/lib/acl/rte_acl_osdep.h
index b2c262dee7..48f29d895b 100644
--- a/lib/acl/rte_acl_osdep.h
+++ b/lib/acl/rte_acl_osdep.h
@@ -33,7 +33,6 @@
 #include <rte_vect.h>
 #include <rte_memory.h>
 #include <rte_log.h>
-#include <rte_memcpy.h>
 #include <rte_prefetch.h>
 #include <rte_byteorder.h>
 #include <rte_branch_prediction.h>
-- 
2.53.0

