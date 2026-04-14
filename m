Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8221AF9D0DA
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Apr 2026 16:10:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8674F40647;
	Tue, 14 Apr 2026 18:10:18 +0200 (CEST)
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com
 [209.85.160.45]) by mails.dpdk.org (Postfix) with ESMTP id 49A0740647
 for <dev@dpdk.org>; Tue, 14 Apr 2026 18:10:16 +0200 (CEST)
Received: by mail-oa1-f45.google.com with SMTP id
 586e51a60fabf-40f0e14b9f9so3614690fac.1
 for <dev@dpdk.org>; Tue, 14 Apr 2026 09:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776183015;
 x=1776787815; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Vbp4u9gM9TWygNLGhiTUb6nULz7qpRw1eo/ENs94tw=;
 b=k4lp5RshlznfUuy4xVtWk/KfcG+W0BYIQksOLac8dxlfxDhln2C9LQYKrhiv2B41aw
 YshjA9hLkV7iX9wz2Yed0AXHH8vQvv9ug8V7dnn8H1Zj1wFb9rTjODCgGyDiiSZXh7It
 mxQskPqvHd7gmkOO0xb7RMMp65BdZ5opkcO9ZUwwtOtOxcqJlTrrxHYHMolCAfwJHsOV
 X6ehMbqSdrob4TjFd2DFL1IZbvg+AoOlaTjhXW/jEeZOjcr83ahexulG82tyTZhqo3tb
 ctz80zvay05Bp2tM301rTNmqS3YEcO+NRJpN0IYyfF7/H0TcTFCqY5vyxw/v1mbMuNjT
 McEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776183015; x=1776787815;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1Vbp4u9gM9TWygNLGhiTUb6nULz7qpRw1eo/ENs94tw=;
 b=Yi2/VdWuG+86AvbMXjQvFy6znvghwb54Qu5bxhr97mOZL3tx3KG6nZ8C1NBo6ueIIT
 c+jUQ0iUya3pDhrN8IUMweuDV3VOSHSqIU6L78dyq0443fw8qXVuwk18DOpLllNw7Mfy
 tPCYWkDQ2aPyBjOODAmtJuZJ2WLZLr8MlxbDnGwKxMkoc75eKWRujn26q+c5z9w6fhhp
 jGr0uZ8Oa7Uv/JZ+4rjEbSxXAtM9zywrJo6+wSDNzVbVI4Ye6qy3iCx4QfpqvB0iX61H
 bxDxtX8sZJvXHvA0kFCMw0N+tGS75sVI4lNI5D+ma3l4CYVeV/DAKzP1tyk94qo/rbau
 lKbQ==
X-Gm-Message-State: AOJu0YxJiZxD36UgRXhMnmQpSUkr8lrciaa3MMG11XE5uQ3uSflrRIT5
 a7EB7hd2qUDINtrZolh2TfoILV081sZPfn6S/61w2rjKWk7pleE+EjfC0yK8LV28Su/VP6gfQ/S
 quZ7N
X-Gm-Gg: AeBDieuhQeP/O3AQ+tc4EE9T73MfPOOfhbW6gtDCd705R0/U6UnCzGoJkLyzfWov9lz
 DtJsvQJ48adYwCOwpOheqqxHY9w+0zaqNC0C8qag8kO8AkF3w7NoEHOjAMXQM9vsRoeeT7m4esw
 Ew6MtC06MoEKHFHwN9fBt6wuCepiGPdmpaZYhLP0nFZiLJBl+rxFwcOJj8IaTAzrohwNw+wA4Kz
 8cqG7kLUK34UgPQeiCv6y828aaQj16ZGIfVeaD4cxqlLDPCbqa+6TNU1xQrlt5/N0duUOuWD0KR
 zxo0fzOgSPSPe88seR5i7wdrP8fCv6ICdjISjELsp8bBbnGtuzbQMt3Ole5omJUJ4NuULawZn5a
 rtcrPet9m1RWjwUSS++rLR7go5l6H8xgr3OomVhQoelrRGS+QptMPqemT8EhPaO4rtw1NtFy4Ze
 Z0rQq6qcqJIgBTW1wd3TSo/HkilxS4xQ5U/R7PZpvcyZI=
X-Received: by 2002:a05:6870:d289:b0:41c:d38:f3b0 with SMTP id
 586e51a60fabf-423e1208b58mr10284023fac.42.1776183015345; 
 Tue, 14 Apr 2026 09:10:15 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-423dd396960sm11809554fac.2.2026.04.14.09.10.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 09:10:14 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH v22 01/24] maintainers: update for pcap driver
Date: Tue, 14 Apr 2026 09:07:52 -0700
Message-ID: <20260414161011.756101-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414161011.756101-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260414161011.756101-1-stephen@networkplumber.org>
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

Nominate myself to take care of this since already doing pcapng
and pdump code.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0f5539f851..580113a658 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1116,6 +1116,7 @@ F: doc/guides/nics/zxdh.rst
 F: doc/guides/nics/features/zxdh.ini
 
 PCAP PMD
+M: Stephen Hemminger <stephen@networkplumber.org>
 F: drivers/net/pcap/
 F: doc/guides/nics/pcap.rst
 F: doc/guides/nics/features/pcap.ini
-- 
2.53.0

