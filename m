Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73443C5B543
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Jun 2025 15:12:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B9FC42F05;
	Tue, 10 Jun 2025 17:12:07 +0200 (CEST)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com
 [209.85.160.169])
 by mails.dpdk.org (Postfix) with ESMTP id 3884F42EFC
 for <dev@dpdk.org>; Tue, 10 Jun 2025 17:12:04 +0200 (CEST)
Received: by mail-qt1-f169.google.com with SMTP id
 d75a77b69052e-4a58c2430edso60582681cf.1
 for <dev@dpdk.org>; Tue, 10 Jun 2025 08:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1749568323;
 x=1750173123; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lU+rB3JLvyoW+ELH6ONq8PWMDs33svixM2isQ6O/iHU=;
 b=hTARMHqJuMisgBou3+lT0Z0+5HPMoTndzIpQ27zgwamObGy9wuX43iplJxSlvDItht
 wZBTTkf3jOuIoZAuUJnkN6NW5G21nm+8F8YEKZGMgKlQ3OnFBV7j74aQFvafKkK+4rrL
 uCVqfBULkVXQSMd5Q22+34VEZDK3aNHtQykLrYvVXEG0zvUVhQb/rZwpfKbnVGnbYK+3
 k6ZmuEJTIrJU4cQeQHhT5bbP/yU3bnLtreHUyZAofo9PIfFFlbvWB7PpCaq3wW6QaPzw
 oddzJpdp1Z2mxaYksLKZG42p5mgIBCGGfAovJwE7DxXpqB30itLuNeAwGVPAJETy2Y9n
 5/sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749568323; x=1750173123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lU+rB3JLvyoW+ELH6ONq8PWMDs33svixM2isQ6O/iHU=;
 b=M8YpkgI7S/umVYK1rA5TCKvIOKd4udvSbUWDUH99FHRyFt+vwpmdBs7SXup/AMAB40
 0C2u9JmBY3fTA2i37b+sAKdgel5CgRtyOQi1Cor5Rb2IWcoF7MYi7xVtOLn7zcG0voml
 kXZG405DOLfEtu4JleKi+qRJrEI8Ac8qxTpPwP57hMAb7TEyOHtK1wTDAl7hhYi6JuxO
 XYy1gnS1lNXqLVfDP82BXxV1XJYbeG7R9Hrx/yX9IO5T1kApC8XAGh1qg5eDF/vVZHw1
 RUIJ0Yb94fcc7PRnZnfWZ/lJV1/IR/RaLpvITD/LCIxGhcGgvYllDW70PAj2Ax0iHqew
 re1A==
X-Gm-Message-State: AOJu0YxlqsFD7JCJdMhhJNlNzE13WMTW8HihOZVt++UCJeplOB8GEsRj
 waEVNXxx2wz21IjsSWdbdDZ7kK/BZ4M6rk3a4rhC9rr8ULhnQbuCpxCpL+MEtri1J7jHs0a5bok
 NQV0L
X-Gm-Gg: ASbGncuO+q1vsVKfue9T55V1cX6tJbC+WLvtbeJ6aP7MLzGAaZYU7+FXeskWHXqiDw2
 rHdLgAAfdWbtO+44K7smHmTl6MRz2Vg/zpW+cd+k4oLEts811LjsVsJYtcv1ZLhUWe379iQxCvy
 Az6ZlInWr5rFXaBt0ubiD6To7DNU8zn63bTNS2l2/xCXIdctUbnA9r9YUn2ikMlUgF04b6Tgdqs
 SPQVtEDNcnqVV1AtMD/dVkdMKbv7urA4OWVqL5tAmHATqJzgs5vgG4DG0qsXhUK/lGoigi8Qgi5
 6fXg7aJ/gKoQzNUmbcQepiRZdU8YDhi1z8fHcPrCMF8pyDSTqLJKAW3E7g/VNjDGebMpaLgFY2K
 KdcrS8cRYbhVdoAYaid8J0Su8AWQo31Faocnj
X-Google-Smtp-Source: AGHT+IH++GSFxXneGOWblnlmC8rg8dzW9IpcaPHsWuAmd3gczfQA0uVvS12X80Lapxi7p+O/7aKTnw==
X-Received: by 2002:a05:622a:424f:b0:494:70e7:1528 with SMTP id
 d75a77b69052e-4a708dc51d3mr65855711cf.24.1749568323337; 
 Tue, 10 Jun 2025 08:12:03 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d2517fa678sm705822685a.22.2025.06.10.08.12.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Jun 2025 08:12:03 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 2/2] uapi: update headers to 6.15 kernel
Date: Tue, 10 Jun 2025 08:11:21 -0700
Message-ID: <20250610151158.209572-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250610151158.209572-1-stephen@networkplumber.org>
References: <20250610151158.209572-1-stephen@networkplumber.org>
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

The header contents does not change, but version and wrapper
ifdef does change.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 kernel/linux/uapi/linux/vduse.h | 6 +++---
 kernel/linux/uapi/version       | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/linux/uapi/linux/vduse.h b/kernel/linux/uapi/linux/vduse.h
index 68a627d04a..f46269af34 100644
--- a/kernel/linux/uapi/linux/vduse.h
+++ b/kernel/linux/uapi/linux/vduse.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
-#ifndef _UAPI_VDUSE_H_
-#define _UAPI_VDUSE_H_
+#ifndef _VDUSE_H_
+#define _VDUSE_H_
 
 #include <linux/types.h>
 
@@ -350,4 +350,4 @@ struct vduse_dev_response {
 	};
 };
 
-#endif /* _UAPI_VDUSE_H_ */
+#endif /* _VDUSE_H_ */
diff --git a/kernel/linux/uapi/version b/kernel/linux/uapi/version
index 3c68968f92..ca6d638260 100644
--- a/kernel/linux/uapi/version
+++ b/kernel/linux/uapi/version
@@ -1 +1 @@
-v6.14
+v6.15
-- 
2.47.2

