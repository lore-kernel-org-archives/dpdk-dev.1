Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 856EECA0EF1
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 23:36:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 05CEC40E22;
	Tue, 19 Aug 2025 01:34:19 +0200 (CEST)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47]) by mails.dpdk.org (Postfix) with ESMTP id C3ED340678
 for <dev@dpdk.org>; Tue, 19 Aug 2025 01:34:17 +0200 (CEST)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-3bb2fb3a48aso1751683f8f.1
 for <dev@dpdk.org>; Mon, 18 Aug 2025 16:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755560057;
 x=1756164857; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1h38YexGHB2RdENaaHVG0Tt5ih04AwJ97XyHORWV6cI=;
 b=BayOXbO6hSEUxTW8UaYyi7wJ7lfczILsnLCAYOV7rGH+ZTwMvQ2SBB/zH3eqzVxZ9Z
 r5lbE/DI1R1I2PYV3+dqc7mF0g5yKJ1KeEgzpBtKWDz0BIP8sHacmHQk4BWClhTqCRbV
 iRS0NPUO+dY9qSJ6PJghGdYd9WYr9SeQJZUZftwFfAyVkeca0MvDxtnd6cSP7GzGfOcz
 rhqXG1JUsp1SJsG+74bJhe+Bhw/F6ufeDTZPqGCye1P6YX3OtJzqPeBiKqlZNb8zdkHg
 Ca136ysJqnJDT0Ky/0qYzmLgmqiJ33fSnO6WF0mLqQJMDFmSAJAnFt3gHqzJARtTK6YV
 zuaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755560057; x=1756164857;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1h38YexGHB2RdENaaHVG0Tt5ih04AwJ97XyHORWV6cI=;
 b=u7HQ6RmwZTTHaSXr22JSKYqJi29seNrCD/UEB+GiFykuNTsrAmL9GgqOiD0o9jBOOH
 ZB3zwTK+Lt6+OBrKr+akPqTVn0D/CGkxSRyB23VREBjPTuN/SDJX+rGWMqym/LynzSsj
 JPC7WtT7nKh0CkTrehjvJZ0+eIecvqWByEblvPwQDb93iAtpd72uZZ9/cOuYLcx/GBbq
 u9+wSTCN4QbLYwttor8PtPLQsUHTdTYq+vOFlpbYTd6I4rvJfHMjXC5Zo+o2L/8wlALf
 W/lSArGXQzwKc1CCl7ld3/yfxfd9Zo9O5aRDVEqDHHEzwvCnPoUeo4LviahD0B5OIgFP
 yW2A==
X-Gm-Message-State: AOJu0YzG42FQQQ9SmEMKn4TpmRmBZ7KFX4EhvJvbwMU2PIrrDO+0ufKP
 cyE2iZML9N1bXO6yw2iLEfOAIoth/6QA47kqRR5zKnT+VKGTJSCgMGqJabE6pr7R5Ka67RkXZaA
 /Ouz0
X-Gm-Gg: ASbGncuQv07tP75o7IZMzsKlHLOhnwE+Fc0Ia4YPvIG6cc2HEyPwEaRVsmmWfNO6/FD
 KWQHNvwB9ML7PJZX10BK4OszkeinSs+9VNWHxH6S7nOIks4KgzatrqQUBgfXzU+iJ0ah3h2+rw6
 L5UjMn2gafImk8x09HERcXUZYrvW/fX2pcUVuRq/AaQ4w15GBBu+DobDFk6V+7iTOmOM9hZkQRC
 iyMS3iGp312il4EfUyPZ5kWVk1RqPHa3ARCNkNak4fMilpEULxQayHwnj1PHBfFkKLScayH/e05
 CYaNXp84FoAtprGiP757kecYaakjiyyOzc2mYfj2rkNQ1n2QFHMrNBLh5FN5jws1vngRJ3hzuh2
 BslWkQ/RBuf4pgu9SFgwXuZa2qquX9UepmODlfVzSU16LAylAxMEcF8JT7Km9HtHU4LPISxo+
X-Google-Smtp-Source: AGHT+IG2hZbY34Fans6KKWX3HtK9UXlNLg0ixhdoFkG18TYi2itMeeScz1KlCa4Jha323KXlfZJkdw==
X-Received: by 2002:a05:6000:4027:b0:3b7:895c:1562 with SMTP id
 ffacd0b85a97d-3c0ea2d8421mr350031f8f.11.1755560057451; 
 Mon, 18 Aug 2025 16:34:17 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c074879fe5sm1233063f8f.2.2025.08.18.16.34.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Aug 2025 16:34:17 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Matan Azrad <matan@nvidia.com>
Subject: [RFC 41/47] net/vdev_netvsc: replace use of sys/queue.h
Date: Mon, 18 Aug 2025 16:27:52 -0700
Message-ID: <20250818233102.180207-42-stephen@networkplumber.org>
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
 drivers/net/vdev_netvsc/vdev_netvsc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/vdev_netvsc/vdev_netvsc.c b/drivers/net/vdev_netvsc/vdev_netvsc.c
index f4a84783ce..e7a05b1aa8 100644
--- a/drivers/net/vdev_netvsc/vdev_netvsc.c
+++ b/drivers/net/vdev_netvsc/vdev_netvsc.c
@@ -19,7 +19,7 @@
 #include <stdio.h>
 #include <string.h>
 #include <sys/ioctl.h>
-#include <sys/queue.h>
+#include <bsd_queue.h>
 #include <sys/socket.h>
 #include <unistd.h>
 
-- 
2.47.2

