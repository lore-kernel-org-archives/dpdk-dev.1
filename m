Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1665C5DF7D
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Aug 2026 19:32:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B81CC40EF1;
	Fri, 21 Aug 2026 21:31:12 +0200 (CEST)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by mails.dpdk.org (Postfix) with ESMTP id 9137640EF0
 for <dev@dpdk.org>; Fri, 21 Aug 2026 21:31:10 +0200 (CEST)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-c9e607d81fcso870105a12.2
 for <dev@dpdk.org>; Fri, 21 Aug 2026 12:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787340670;
 x=1787945470; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5GFMU6eLUo9VkwyxM8F6SqCmPOOC4RYks46v9/yVcVA=;
 b=w0YAapi2PLCL7c1yq2zXQycfLtNUIwC80jyd/8FjWBX06qojF7vBd+0aQ78j2dcHU7
 ZcVWRZMzcuksn7RZLC45xSRDsVGiccmT+7ezT6u5UMqawbZc3GAIKdAt908UJG/TQT7e
 haYCP2eyvagdy1vNF+aRVdPD9yJZXEPDnic/FXBiAbztKPW2KYGajFfw9B9JsDTIrDf7
 urjiKYKJs3vT+81Y3eX/c+YFyO8clvCijbNET5TzCfUl+JRVkad8Br1EDGGSK2shUWzX
 4HaWF4bXN0crhn4a+KJRycTc8voC2ZQeH/OEvsXM7cVV45ShLVOccorDdTZdXAhTw/Oo
 nMWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787340670; x=1787945470;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5GFMU6eLUo9VkwyxM8F6SqCmPOOC4RYks46v9/yVcVA=;
 b=kTnM8UQ2beKAWbNaZTdtwKGIE2JVnIXNe/xAHKrsmnLvc3H4tumifEKo5lyH/UdeQh
 wnIB71BzybXDeb61tFqb9TOZE/QYaUoB6Zl/ECsquwnd6ec1Pyemvok+7M3jZqtO1O86
 rhY/rtYj1Q37SG1DzxByVlZKjgIw7Kpx1aCnlHuMD9kkKVw0oSeQGQyEj/txvZdJ6NaL
 Dd358WSjiWhiNr0wjEDU/V3Qyxt2vxL7zeB7pcUZ17P7UDQ+LLtChK7ReRBoOWbCb7Jr
 ophK9Fwzr4PpJkKFsMv8ldcv+J3SVvesx+ufFrAlHRkycoZroC99FduGG9lNcigIZlr+
 iXXQ==
X-Gm-Message-State: AFuF++mYq8Jyd0AQDHs1387k15m1SGFd+RwKkh23BtjaiC/9h2Q0gOav
 bRRysa6yvETL3S3uRxH+Dc/KpxC/eEm6HbrDpUqG0EcOqgZcrcekKIXovDkrwrD/NmDuDdLLmt4
 d2AiRRlk=
X-Gm-Gg: AR+sD10xOKdlgiP03xBGMTL95SaGHVt6o0oyv3lIBh/xnHBe7UjOSb6fBQ3H2vQJrKH
 FkRB10yFzexsaMn3e3gY59a9hE7x6xbgNtvC3tVgy+TDca5MNQp1nsiFTJMgjXodphn6aF6SQ61
 R+Y1NmPeCiCZJs6mPeJgR5zK2I+Fzs54R3/6frAgnttXr+8pDqb1tOhpTpREgCBwnz84RqNKvvZ
 oU2Ue8x7ihy7cJRrgsWg9G0+PCPDBQK9cAP5EcA4ghoDlFZPgCpvsZPjXl4/Nyx6XI75phGxCFu
 1Ee3373nh+wUxJ2K+eYa6o+FfPjK+nXPcXWXChoDfYAiPsvZ3g49I+mENxGC7Bgwf5kkoK6FWK/
 M9OGY3ULoTQZToTTVosTFmSDEMek4jrrh6Df6jDz5frL39HIbJPOJSMp6bIm0DJANKBIliFnou3
 /xbyErxHjgNVaEIG4O/HuF3ijkuVkydplN4861HoMEEp/Ol4iGOabVYCcwiNZh/A9bPcLyq1+H7
 +TDGF/+k51hKuZZwgs4uu3D/uTQOzkX
X-Received: by 2002:a05:6a20:a10a:b0:3cb:e8b4:f03b with SMTP id
 adf61e73a8af0-3cd3013c9bemr15945051637.17.1787340669777; 
 Fri, 21 Aug 2026 12:31:09 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc16c6dd2f4sm1860304a12.17.2026.08.21.12.31.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 12:31:09 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nicolas Chautru <nicolas.chautru@intel.com>
Subject: [PATCH v2 55/68] test-bbdev: remove unnecessary include rte_memcpy.h
Date: Fri, 21 Aug 2026 12:24:50 -0700
Message-ID: <20260821192646.146382-56-stephen@networkplumber.org>
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

rte_memcpy not used here.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test-bbdev/test_bbdev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/app/test-bbdev/test_bbdev.c b/app/test-bbdev/test_bbdev.c
index 2422312f6b..5028e844ea 100644
--- a/app/test-bbdev/test_bbdev.c
+++ b/app/test-bbdev/test_bbdev.c
@@ -6,7 +6,6 @@
 #include <rte_hexdump.h>
 #include <rte_mbuf.h>
 #include <rte_malloc.h>
-#include <rte_memcpy.h>
 #include <rte_cycles.h>
 
 #include <rte_bus_vdev.h>
-- 
2.53.0

