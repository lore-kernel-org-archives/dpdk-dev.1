Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D52C56205
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 05:12:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 03A4240B98;
	Thu,  6 Aug 2026 07:10:38 +0200 (CEST)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by mails.dpdk.org (Postfix) with ESMTP id D8A3A4066C
 for <dev@dpdk.org>; Thu,  6 Aug 2026 07:10:35 +0200 (CEST)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-c99eaa1f020so1823850a12.2
 for <dev@dpdk.org>; Wed, 05 Aug 2026 22:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785993035;
 x=1786597835; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tGcdyLJjY6iR2dMv1Ft9l27CE1TMIf13cnrW33wlgcY=;
 b=I8nSz6XqKIvngrGfa6luTiWaP5NlRNYP8gIXCEqCfP61x/Gi6p8pMdWidTXktznYo6
 V/pBh2Zc+Xwy4SCbpg90LImU09gDoM1ly9MRt98jTH56/F15rp4ou/I8q/M1pUSodMhX
 qkCcZvo/HrGJSCeDQ0HytVnG8NGTTsc9c8VW1SyFtjxoWtOFGlJqtmCxeFioKANj/IDc
 Ki0RZGYnmiMlghKzyfrWtwwW5vT0jnhUL7LJr+9EWdXGY7T3tJOygQu6hhyc0Qh8CiXU
 1gsH13GhCusEKDnKDNzUAVnpfQ+u5jpI3AUNXqwUzc+w3JLNJJPkOaYmgZFMRUcBv6Gg
 kI8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785993035; x=1786597835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tGcdyLJjY6iR2dMv1Ft9l27CE1TMIf13cnrW33wlgcY=;
 b=J/9C1cvN/HuOOg2YwgB2fPta3SS9qdBRk3zlPA5g0AcXBwU6XRmzW1x6xWSMyS52qh
 GuWpyjg5jLl0YaZ6VL1PLKEBTiHl/NVnD2/iF+dSA5jPil5b8qiNHeHM6j+ic5IGYUUv
 gs5BSKeU9tmkFLJPthOU7xcxhLYYP5+bQ20TV+1Mn6WXwIzhafCDLCE7OlkXJNLU7Gfm
 gqjXa1/pBzdF7F8biVJB0YLHEFaB/wLk5a1W9JQrCcYGtvjKn+GejnL3IYkT4KgFwBg+
 BwIZ2uApwMLCcSjBC66ZnypLfyOJKG+IsGZPSoCBUw1K332zSiAhWHpcn+cxGyjyXNsx
 88bg==
X-Gm-Message-State: AOJu0YzninDTD0tjCCnU6qm8utk0K/cp6dADN8sUDquXJBa7zxK+cHMO
 vLES95UXpKJcQX/RDMPW95GcVI5wIR6dWK+qDue/zBsCr52l6K1uFlkfDpfpoJ0T5APZ+TXviiu
 sAj36Fag=
X-Gm-Gg: AR+sD11Z5sPzmEF5Hf/VhRkqZVOIINTVAAzfUY1UWgyAvGqap25PTadbJFs8bD0bevU
 ckEKULn6jE0l+r1I9FyvcF4xdX5TQ3RbHIqFwj9WLpGPnh+0RPoQu3STtnlim+Ie0YFufjY2CRD
 O296IpsNJaoQUETpYAKa7PzbD990UrbAmfWey0giKDmp1mGdjPk20qmWlVaEGr+bz7b1BVI8f2X
 3/EjRwr5R4BN3HmPncmVoWD1OUHVlRfHuYwRptL/GMyqPoeXogTLVdelz5WeehbcTS/Gmg0jzAU
 kyQiVDPNIEBQ8jAXzOjtVbaWWM9082ztB6aU0ikngSy2nxoc+MdM0LO2FvVRV2NP9SWgt/asjyR
 86vowLtOGNouc/Hw9k2429Qz/DbvCVURneDf+1rY0NthgKnZTebDyY3y/JsFzmPNt9E105mpnAJ
 0KiONsKzy9TNF+cVFum2Cze6iKizHmhkcJAI7UC4JA6+wzROkl4jwelDVsS8fTbwwN9bDAQJGCI
 El8jjmDbY2VLEetkd5OnWR+CTg6
X-Received: by 2002:a05:6a21:6112:b0:3c3:bb13:438 with SMTP id
 adf61e73a8af0-3cb85f50b14mr14811478637.32.1785993034982; 
 Wed, 05 Aug 2026 22:10:34 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315ae6c1fd4sm392780eec.14.2026.08.05.22.10.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 22:10:34 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v4 19/23] net/sfc: include rte_flow
Date: Wed,  5 Aug 2026 22:09:13 -0700
Message-ID: <20260806051004.166778-20-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806051004.166778-1-stephen@networkplumber.org>
References: <20260803165304.289869-1-stephen@networkplumber.org>
 <20260806051004.166778-1-stephen@networkplumber.org>
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

This driver was depending on rte_ethdev.h doing inclusion
of rte_flow.h.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/sfc/sfc_dp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/sfc/sfc_dp.c b/drivers/net/sfc/sfc_dp.c
index 7e2a20e4dc..c867c2c2ff 100644
--- a/drivers/net/sfc/sfc_dp.c
+++ b/drivers/net/sfc/sfc_dp.c
@@ -15,6 +15,7 @@
 #include <rte_ethdev.h>
 #include <rte_log.h>
 #include <rte_mbuf_dyn.h>
+#include <rte_flow.h>
 
 #include "efx.h"
 
-- 
2.53.0

