Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D8ECDB463
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 23:31:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 50D2040E5A;
	Fri, 14 Nov 2025 00:31:30 +0100 (CET)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com
 [209.85.222.178])
 by mails.dpdk.org (Postfix) with ESMTP id E8DEE40E5A
 for <dev@dpdk.org>; Fri, 14 Nov 2025 00:31:28 +0100 (CET)
Received: by mail-qk1-f178.google.com with SMTP id
 af79cd13be357-8b22b1d3e7fso137353585a.3
 for <dev@dpdk.org>; Thu, 13 Nov 2025 15:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1763076688; x=1763681488; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MOV+m+BcWmVlBaNCJzsDoYaq6K955OTRFzQn1rgckUs=;
 b=WNMA404FlSquWefx4ah6zrU3KdM9ABNtEjc0P9JtgbCtuMbDcnhOglK4NhFZEL5LKv
 2Qrw+xvdwGQnhTmTK4oCEAJ9w3tIiMJXXEQDNwgn2sWO9pgsFAkSsSCPIkfxtf7T++Uq
 3H9J4UQExwVovNky1pbCtS6lYz2c314CSoOho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763076688; x=1763681488;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MOV+m+BcWmVlBaNCJzsDoYaq6K955OTRFzQn1rgckUs=;
 b=Xtp8zVFRFKEy7hnXtKPCl97mtvbO6PG8Z5ZSbqT9kw0vXQ7Klk28thXOcNm7M9Vatk
 sfpUW4EWnotPOW/rLOZ8m7vcTLE1OVq+TnSgLwQOeYMfEFkRtlyM7NKSjYuzXH7FUTPv
 oJBO0ob6PDsml7tSDFViV8Psj0GxF4u1enfCBfHwdqdVRLoGFd6uTruZMwFSrjvRy1by
 S6KVgDmSZ6b6WsjXBKndK3+HWUar5YnSeSDwut2G96n5/tAs6p5yom6/9w+U2RxRx5Hy
 OfU3qy5jYwBGzpBQH6QG4PXdI166+SnSU8YyeZ48RgjsUSBqgk6ihHXLcxzTJs82mKho
 El1g==
X-Gm-Message-State: AOJu0YyQDO65uJrM+jQCPpCqCkAvZD1Udnd6XshQFxodjq17wv06bAsI
 jswLs6LAdAcuMjt8WfjcEGwOTR33dGlTxesB8I2ZI1cFEpWzlrIdY07/L36J4ZEKExQ=
X-Gm-Gg: ASbGncsCq7xLba/tDii+ZEIGqLX1bC6bq/AWT0Xcfo09E+8MSk0fsk797RkyeAlYpRi
 w5MrH3Haq9fgchdxe0/Ds3QWG35w15ZF6JZCXHe5/GpFHp0QovS0NmLmu+AcKr3026ZSNsTHfOt
 KptiRtmB1MhSR/A2UO/MCd0N/Ng+XfI5T80dyxDhRs/N9+OWjOWW27eQoa5fcY2ceZk4fF1uqyE
 wzCwDCR2ejEVdmzmMJuWLgEdv/tneQrJVA2l6RfjHTPC/Tnv4/dMd5QuuaRTmD87Yq7lOMWPQwT
 NPdxRhFye8t2pziCRdA35oUApYCvLDRNGcoHIdYl3gubd23UkuDExjtlEamFh/0wDusVcHgi9E8
 cJlqrOhQBusFQtTDxrLqDe8JTEjgtGhLeK/nVy+R2YuJLRY5kUqsmkB9HnRej5vxr73khFS2E2L
 dfNnIabpL5BCqyI+hR0GBjtYIAo7v0cA==
X-Google-Smtp-Source: AGHT+IHhhkqSAecC5XEI1EYCXGwnvW+cFRPqb4LrQQvSvJy3/LIXpd/VT8Rq/3GMIZD09yDtw9Iofw==
X-Received: by 2002:a05:620a:198e:b0:8a6:e239:3509 with SMTP id
 af79cd13be357-8b2c314d8fcmr154088985a.15.1763076688256; 
 Thu, 13 Nov 2025 15:31:28 -0800 (PST)
Received: from patrick-laptop.iol.unh.edu
 ([2606:4100:3880:1271:8c70:5b9e:ecd3:14e])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b2af064724sm221837285a.54.2025.11.13.15.31.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 15:31:27 -0800 (PST)
From: Patrick Robb <probb@iol.unh.edu>
To: luca.vizzarro@arm.com
Cc: dev@dpdk.org, thomas@monjalon.net, david.marchand@redhat.com,
 Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH 2/2] dts: shorten a too long line
Date: Thu, 13 Nov 2025 18:29:54 -0500
Message-ID: <20251113232954.273454-3-probb@iol.unh.edu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251113232954.273454-1-probb@iol.unh.edu>
References: <20251113232954.273454-1-probb@iol.unh.edu>
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

Bring a line which is too long under 100 characters, which
is the limit.

Fixes: f6fb8c6238db ("dts: add link check on testpmd port start")

Signed-off-by: Patrick Robb <probb@iol.unh.edu>
---
 dts/api/testpmd/__init__.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dts/api/testpmd/__init__.py b/dts/api/testpmd/__init__.py
index b6f5a8f0da..e98f882b14 100644
--- a/dts/api/testpmd/__init__.py
+++ b/dts/api/testpmd/__init__.py
@@ -96,7 +96,7 @@ def _requires_started_ports(func: TestPmdMethod) -> TestPmdMethod:
         func: The :class:`TestPmd` method to decorate.
 
     Raises:
-        InteractiveCommandExecutionError: If the ports has been started but a port link will not come up.
+        InteractiveCommandExecutionError: If ports have been started but the link won't come up.
     """
 
     @functools.wraps(func)
-- 
2.49.0

