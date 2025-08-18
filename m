Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F4DCA0EE4
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 23:36:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C0E3C40E1B;
	Tue, 19 Aug 2025 01:34:10 +0200 (CEST)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45]) by mails.dpdk.org (Postfix) with ESMTP id 7937040E19
 for <dev@dpdk.org>; Tue, 19 Aug 2025 01:34:09 +0200 (CEST)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-3b9d41c1964so3196061f8f.0
 for <dev@dpdk.org>; Mon, 18 Aug 2025 16:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755560049;
 x=1756164849; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cOClCLhni8ddo8l3+5iJhvsTOaG1/WbGbKTebwksevg=;
 b=eazQ9z8Bb6wAq/cArxuU8kPeKo5EnW9WixSNg1MRsiJcL2cgXNeuxf4w8J09VXflc/
 CgYePnZm6nGjKe96wFWf3bF2qLVmFI4luyL5NhWLr+HmU0YU2BYU9pLKQwc8/YmFOZK0
 indXRzAXQaZd/xhMKYq/+FNS62iQe0uKUw358eOguJdLxVNbUx9AG35ORfsxg16AKKCP
 rIs/BgZGwBvnOSM3fIgWOyai8pAI/2WMrRXPdlXAfw6Sww5UBF0NS6ojSLr01Jhb8jqx
 llNVQgAQu/ldWnRr9afCjk8RYOCvY3fAEiykNIGUwsmA11DnVoYbY9WSdpClG8DNAxKp
 VlDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755560049; x=1756164849;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cOClCLhni8ddo8l3+5iJhvsTOaG1/WbGbKTebwksevg=;
 b=XRqexR7JCTH85TdeCg5eh1weTjEr3LaL+jPC4PGXDGKxJOfBJ94/DOQ/4AQVZyellT
 P6z31hvX27nQ1ZVDVQ2Vigi4rl7xnmFJ8Be5g8wMJEwRSmfHHk9B+9cbr9L8rsbP+m4C
 8C7g72haO/7TC4yY8ouKxHUoTIfygn0Luytijs4dtEXTZvP8wL5R7cZZueS4c8GLk21O
 tS/n9HSxijaQIkGZ7vejAbwkFPmjDSE2yAEqLGRvqOAktHV4xErYIKHnF/IWroggm/8x
 GgiNiEAXp4Clv6CKQtxOWtgmSlbWh21UTjAy7KQxd+kg+tOjAX8kthQYWqYiuQYJilXL
 AqqQ==
X-Gm-Message-State: AOJu0YzKMQBOG1GQAD6KCvVjC8umjucMatkQagcycM/X/UyCwJHNgRsi
 aefxfG10lCvDyLXtbqJMf1/lEgcbCf9ooOMvEpAUpnRbAULCnZdqh4ZQMVrNhocRqk46i80KnPW
 IzFoo
X-Gm-Gg: ASbGncuyFSgu6Z+ndQipdFIZI9s0altfWDcJB1dqpZ0a4clfcBEjyqGUZNuP9/FYfP/
 yhR68eXwr7P7oE22BR50sD0bHxRgdctueTt7tVqWHJLs7KoxPRBmquAcC5t+hTfTiwdpAqTDTJr
 4XY/QgdKle6vEtsYysDxSTB1OM9ex0jnCihOj+pcvTYNsZM6X8uJ0MKGKNXvaOXakiAEcgvqQVj
 6n9frOVjLHQz257dWGVqlhR6TTim3XfS37nBBW+E7J1HS8yWgd1RIhPVbdMyd9aowQjTmkng4mk
 W+XVAj2Kx0vZ8FgkA/NNeL8S5tGG0w2eb4ORlZ0o/yd0QvrJnMw8WqXV0xuZ0zdj72gbFJV1EG4
 t5X1YNUYECfUbANH0o/nrh7a/s0+BBM91nI6q5EC/krCFbH5RFDB7Lc4ENNYY/wWuSY8t5Pby
X-Google-Smtp-Source: AGHT+IG6XFsr6CqgtUah6gxcxC65yv8E5o/HW8tJolT1RnVmuWOdhAWfFV+t8zdYeiklcJiHzSrNTQ==
X-Received: by 2002:a05:6000:420f:b0:3b7:8154:aa36 with SMTP id
 ffacd0b85a97d-3c0ea1e2c15mr313232f8f.7.1755560049115; 
 Mon, 18 Aug 2025 16:34:09 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c074879fe5sm1233063f8f.2.2025.08.18.16.34.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Aug 2025 16:34:08 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [RFC 37/47] net/sfc: replace use of sys/queue.h
Date: Mon, 18 Aug 2025 16:27:48 -0700
Message-ID: <20250818233102.180207-38-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250818233102.180207-1-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
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

Replace use of system sys/queue.h with DPDK bsd_queue.h

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/sfc/sfc_dp.c | 2 +-
 drivers/net/sfc/sfc_dp.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/sfc/sfc_dp.c b/drivers/net/sfc/sfc_dp.c
index 7e2a20e4dc..0dbdc5d6ff 100644
--- a/drivers/net/sfc/sfc_dp.c
+++ b/drivers/net/sfc/sfc_dp.c
@@ -7,7 +7,7 @@
  * for Solarflare) and Solarflare Communications, Inc.
  */
 
-#include <sys/queue.h>
+#include <bsd_queue.h>
 #include <stdalign.h>
 #include <string.h>
 #include <errno.h>
diff --git a/drivers/net/sfc/sfc_dp.h b/drivers/net/sfc/sfc_dp.h
index 545f0f32bf..6f61b20a0f 100644
--- a/drivers/net/sfc/sfc_dp.h
+++ b/drivers/net/sfc/sfc_dp.h
@@ -11,7 +11,6 @@
 #define _SFC_DP_H
 
 #include <stdbool.h>
-#include <sys/queue.h>
 
 #include <rte_pci.h>
 
-- 
2.47.2

