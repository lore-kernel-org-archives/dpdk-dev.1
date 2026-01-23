Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB552D6CFC1
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Jan 2026 04:31:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1FDB940A75;
	Fri, 23 Jan 2026 05:30:32 +0100 (CET)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49]) by mails.dpdk.org (Postfix) with ESMTP id 45A8A40653
 for <dev@dpdk.org>; Fri, 23 Jan 2026 05:30:30 +0100 (CET)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-4359a316d89so1402625f8f.0
 for <dev@dpdk.org>; Thu, 22 Jan 2026 20:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769142630;
 x=1769747430; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NAHPuQvE2165rpGxsJHW1wsr08rO3/PzDs3KR/V/FX8=;
 b=JBj6Ycb8ZvLLRzT2KnY3KI4QiStjJa6cxOOlrHOu4OgNv92CYG0oYOUuIF7c+nCme1
 uNVE3mcshYHIclHWsovL4NTNf3r/tco60DPuy7o7VfBQ4NynfkmRHDqSnVi18kWi0Sey
 ebtd8YWWaWUuAEMRTzLg4haK4L1O9/Q3DMdk2cXcHabg+MUJ4Z0g+bGsCViGiPKcIsgo
 qDbnwBEXhrT0v1nBWBK4hNRjKup9iSvgZv2T9WWrtL9CM1AWsMhDYTizD8r51kcyVJMM
 AQ4axW3wlsDLLmY9tg+SQpMt0sGJ+mHhSQJ0OcjSzYsU4MpJ2ETmjzYt+lRYZKLW7EYQ
 mb+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769142630; x=1769747430;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NAHPuQvE2165rpGxsJHW1wsr08rO3/PzDs3KR/V/FX8=;
 b=l2tRiv0mcJq+2iHISFj553HSJwf2m99tg6Uwcw7ZNg9iDFfuKIChgVrT1iRjNY+nGi
 qveu9slDLFZltqBWx1hxev8eQ70y0abKT/5TwuFjYYwQzZOgElyR9mQF/OdctayWTVYn
 /AkQNVZ7h+jiBSL9e4qIcC6vOxa6/qUgnbvhEEJqHmAakixePLcWFqq2Vwv8ROB9z7Tu
 1DzulhxOBO7zxqt6zWUW+q2HwUOPm1XHHBHVY4pbfLSFrmyUxBFqjYx/jbdPJgyHUKsd
 7OJ+EUs/O36Ljk1pfspKLgjHjmdwSf9C357mploeAwnKtT3V+oXqF79YK6BZwiDVgEBu
 gaqA==
X-Gm-Message-State: AOJu0Yz5x+s6F7o+qO8b+4G4C5kyB9HPT3V0bgGJPZZYKcUJ3MxR//T2
 nXAbKpOgJlLYVqtDL+GcPWJGnhWy5OcYdBkdgEHrPwhbfcgFOmpT5AW/b5HV0b+KzwchO7wm7p7
 4CYY+
X-Gm-Gg: AZuq6aLNIQltkjikkElPYmbdOiBcXs2VgxJf3W6NpQt2IRBKcWwZigcYyYj/nFoMWXD
 7nHuVOTbC0Kon4tfBRt2qP0hxZnq2TWQcoXYsM6BeqxB5uYlAibNeLd78D34ilv22Pa2vsD5q+o
 aTH21gB077gRAXRfvD4iJH64jQcg6AJ99CGYcI03QubLRR/H/K28tsui70rb1bIeSWWuJBTlzic
 Yq38+yxZgztz3VDJIHeA2DHokYMjfRSy9Ke7Jlb9tMj86usJSi76jzOk/YwSrPOKLylfIElDhzO
 lArqWmOzyWtze2Uq4/TJS30aMV0SxKfADlj0fkla8MsXoayT/cMVwbwi+RDeB0F1ffOo/Eqn7Oo
 unk43gKKFcqRRnTlx7pA92aKKPJsC94PKrNUie/zKKxLTHB/nYiB+GiGfCpdwAUslii8oCWWyqD
 56CPS8h7Ai55Pg6qC7cz+T9US3s9LOKUuFJTsh1QjxnOt9LYaJzQ==
X-Received: by 2002:a05:6000:2313:b0:430:f5dc:d34a with SMTP id
 ffacd0b85a97d-435b15f8986mr3250218f8f.29.1769142629799; 
 Thu, 22 Jan 2026 20:30:29 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1f7b41asm3603771f8f.39.2026.01.22.20.30.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 20:30:29 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v11 18/18] lib: enable format overflow warnings
Date: Thu, 22 Jan 2026 20:28:16 -0800
Message-ID: <20260123042945.159075-19-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260123042945.159075-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20260123042945.159075-1-stephen@networkplumber.org>
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

Enable compiler checking of format overflow

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/meson.build | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/lib/meson.build b/lib/meson.build
index c8f4270868..8f5cfd28a5 100644
--- a/lib/meson.build
+++ b/lib/meson.build
@@ -113,10 +113,6 @@ default_cflags = machine_args
 default_cflags += ['-DALLOW_EXPERIMENTAL_API']
 default_cflags += ['-DALLOW_INTERNAL_API']
 
-if cc.has_argument('-Wno-format-truncation')
-    default_cflags += '-Wno-format-truncation'
-endif
-
 foreach l:libraries
     build = true
     reason = '<unknown reason>' # set if build == false to explain why
-- 
2.51.0

