Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99514CD5BB1
	for <dpdk-dev@archiver.kernel.org>; Sat, 23 May 2026 20:00:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1C00740DDE;
	Sat, 23 May 2026 21:59:07 +0200 (CEST)
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172]) by mails.dpdk.org (Postfix) with ESMTP id 76ACF40B8C
 for <dev@dpdk.org>; Sat, 23 May 2026 21:59:01 +0200 (CEST)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-2ee990e8597so20518427eec.1
 for <dev@dpdk.org>; Sat, 23 May 2026 12:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779566340;
 x=1780171140; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kUbmt0rzediWQB19CdlWGXc0qUHzquIS25urwpk7jRI=;
 b=nTrjjg6RIhsFVXCd5KWFmYSVmIjpJ3hYDRwdKe+gd/4DZ1sp/csasTuiPDqMsGi/KP
 MF2lMOto7O/bykYx3YZEpig9i2Fv+VPhmJJmnSULPW0O/ja22IbA6yxOgRPZUaVyzmlz
 PrsjvFqClp6YjsE9ldnSZ5/I5AT19Gl1OmbDqVRPzwGeBNA9zE5rwALCsDWXSv4uwho0
 2Prwv72/kKstmy51ExKP+VxlV5aZhb+0GFRY72ewJFGcmdxvUsvNVlNrIEb3BDrVnky6
 AXqr4BoMF+uNhu8baJ+Vu0Eale7ebm3bhI9LkoFvFScW065Sv2tH8FArqDN1V8set37k
 9xHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779566340; x=1780171140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kUbmt0rzediWQB19CdlWGXc0qUHzquIS25urwpk7jRI=;
 b=fu8HsRxts4vM517B9HDTngjZLk5jpEmxa8F50ZXrfPx7HPNGROQU2gsYDHtWe94hj8
 htLMZsHXPIisFUWE9co1KqwSmccM0uChzMvQ8cnaqMAJan5/Q3cbcpVvRQbWnXLYk9/l
 WO28FC9/b2NYtSheLT9l/lMQMp6E8XVv75sJejMf1iQ7xvYbHrPuoXmjqujF0x8xMdJ6
 Ijr16ipnBeCN344r6/U+zu0ilOYpkO/S2rPaebB8hNndxE681CND5QYzYrCqRNzJWxnS
 lGVD2rq9fA9aTp7sB5ZpmElpb2mi5ZTMiq9/8QFt/ejfl6EqopX56geskKBHy4w/7do5
 T93w==
X-Gm-Message-State: AOJu0YzrNNZy0nOxa+XLCVICyxYgwhM3UyYWiJQzxewhbTBgqtgmnCDP
 Katps//ItAIPAHYN1lgs6XUK9uXNcy4H9qw+1Jldko6/jNFOXDc0P1qF6TEbCXhv7YZjANzjvuY
 KiX2M
X-Gm-Gg: Acq92OGTOi/mhktrn8KIoH4Tcp1ao7ESybT35XMP6IWI9E64NXyW10VPLtxfqVg7fxC
 vQzvLq9mHIz18NttXjHbwePiGz9xU1Z8MoS4RanQLanzmzr0ixJfmxhZHo3mcpllpvrPuGOOkRu
 k5yMAWWzYjefIhzfDXYQRAGv9h5iA9zvXo6Mfopr46X/xVaieq7WCdI4Vd6yi4U3Q6ckrhvB+gl
 AIygoySj4G7lx2cvoeAq90hRJtw/hksKSYeg+E7eJCEJrXogpz7uh/iCm/rqTCTvZyEzpmXt65g
 wO38byJKENWyWsSsuKZAuv3iFfCJqXfSH6VWhyQcNFWW7MYskWCuUACixhj+IHfcv4oNyhicJv8
 H+Hs1/OWrcz/R6OSTzblbCrbrN/V7skA+TOKTIacOjbkiXbpiTPhiGH2uo23THwzwkzr9mImqNj
 L2UO0SfOjHNWLRQygwfYpcVmLBQluy6rj6KIwh8WeqSXpLIXiP1tiTBZsk4TO6Uw==
X-Received: by 2002:a05:7300:e605:b0:304:b15:17d6 with SMTP id
 5a478bee46e88-30448fbf201mr4456407eec.6.1779566340519; 
 Sat, 23 May 2026 12:59:00 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30452255234sm4838428eec.20.2026.05.23.12.58.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2026 12:59:00 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v3 18/27] common/dpaax: remove unused atomic macros
Date: Sat, 23 May 2026 12:56:32 -0700
Message-ID: <20260523195839.454952-19-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260523195839.454952-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260523195839.454952-1-stephen@networkplumber.org>
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

Driver copy/pasted some macros defining abstraction around
the now deprecated rte_atomic32. Dead code removed.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/common/dpaax/compat.h | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/common/dpaax/compat.h b/drivers/common/dpaax/compat.h
index d0635255da..580620caf0 100644
--- a/drivers/common/dpaax/compat.h
+++ b/drivers/common/dpaax/compat.h
@@ -365,20 +365,6 @@ static inline unsigned long get_zeroed_page(gfp_t __foo __rte_unused)
 #define spin_lock_irqsave(x, f) spin_lock_irq(x)
 #define spin_unlock_irqrestore(x, f) spin_unlock_irq(x)
 
-#define atomic_t                rte_atomic32_t
-#define atomic_read(v)          rte_atomic32_read(v)
-#define atomic_set(v, i)        rte_atomic32_set(v, i)
-
-#define atomic_inc(v)           rte_atomic32_add(v, 1)
-#define atomic_dec(v)           rte_atomic32_sub(v, 1)
-
-#define atomic_inc_and_test(v)  rte_atomic32_inc_and_test(v)
-#define atomic_dec_and_test(v)  rte_atomic32_dec_and_test(v)
-
-#define atomic_inc_return(v)    rte_atomic32_add_return(v, 1)
-#define atomic_dec_return(v)    rte_atomic32_sub_return(v, 1)
-#define atomic_sub_and_test(i, v) (rte_atomic32_sub_return(v, i) == 0)
-
 /* Interface name len*/
 #define IF_NAME_MAX_LEN 16
 
-- 
2.53.0

