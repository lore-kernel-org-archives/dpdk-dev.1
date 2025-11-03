Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A724ACCFA03
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Nov 2025 16:52:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A70340E2C;
	Mon,  3 Nov 2025 17:50:07 +0100 (CET)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by mails.dpdk.org (Postfix) with ESMTP id CA8D640E1E
 for <dev@dpdk.org>; Mon,  3 Nov 2025 17:50:02 +0100 (CET)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-29524abfba3so31931295ad.1
 for <dev@dpdk.org>; Mon, 03 Nov 2025 08:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762188602;
 x=1762793402; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hu8u0LbRG5+kqGeGx7KIY7lbJMR5BQZ0uxv0Cp1op3w=;
 b=N+PO4cCXJrleb0lVfKl6zGNzNXr2YIg1y3GvzAyhIprrak6uM7Rex0n42gXpZilY7k
 v8fwQ8P1XAa27JTUYa2UnmHTTjsbTPyosXVUAJdZhRvtbbLff9my8D3hBSU9+i0RZVJW
 2P4BW+9IGVni+bANS1PbmZp72qh1qVMUS/cndllm/JSsfAviRnv/DEr+PkmvgC6eXQKp
 voSTsEniDL+GrYgi0/3u6A/IJABtuHOm9jnrT394rz2i9s8qBqaVjCv9ZHUmmSxLcYj5
 O8JruinQ2RWp0BdtJ6TRL/LdDlt+2RJty1VvUCKxfVrD3arLmIXE3QBCBZ6bhCOM9urh
 m4nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762188602; x=1762793402;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hu8u0LbRG5+kqGeGx7KIY7lbJMR5BQZ0uxv0Cp1op3w=;
 b=oswhaSiMQqiQNI0wE5Wrv0rOs18k1XO5K1JlLyQXnDGzXMX9qdStnzT4dz5D+sApYX
 i57LSUYH601+L1/NHW3Lsxizex1x/dtH34DVtvo0s+TIK4E6RuZaDY/8uoBEeXQlRja3
 r/F/x0QsZyTdsERwuHPbIBbKgDM2RwniDw1tJ9bOqB9h8/gTmtAheeiO5WT8YuNJITGR
 d7qE8QJH3Cc4LUb7pUXcnm3AENVDkP6IDh4mc6hwFQYwQVMc/4Ad6JfEZJ2AXHfLHo1c
 xBBkNBwEKLR53RgmrZ5cEpmgCLpA++3Xh/C85yQy+d5ljtEUGUhw2dqpY4b1YWxp/+Dx
 DEzA==
X-Gm-Message-State: AOJu0Yx3m9zgh0pLA2KA9abk+UfaWywd4ibbLQnjNFNh2RTESqGhr2xJ
 L5+8/Xm7HUgwXsam5MJtEf70AFrcX1RRnu1ZKPF89vyzX7uBR1XZt4EsdMYuuODMBQl6B9ZMm7J
 X6mDE
X-Gm-Gg: ASbGncvuLF5wxyqRsHoRAOeIrJWLtoJ0wN7UThLfVfPCeREJzgD9OigJjXVCdfMFD/+
 oo882KNfa7qODhWxrCu3B0uWKwR30Io9gUXQrixKVP4hbsHrQwVZpsOCcYKVJq4s4wjZV0vL+i1
 FWjDO7Fcu9et3WodHafhHGeckGimFqbXZMe7ZObCcwdQOWFfMW+cZYQa5hEcMc9GLJX1Ct+deul
 VChqB+9Hjkh4aMhJsZ1DWgG8v5E3bZo9knyJdzZ1G7LYZDBFXV6fFXBhNkyHma0xx1OYlxpVf8v
 KVXHxR/u4exmWDhtJ8cOtTGqqY/agd4U7gX0dCXxr7ceyl5VfsSIq3T/LZz3y0SkXtp1GkS0DU4
 29FuR69Uq2XJmyapTnvzfzytKao/IoO2hx8NZ/AVxD36DjSrbXcA2xBhSMT3xvtq8qAUhJFwunH
 +sD2MwcBEQ7rT+7E8IUkPXX2b11A3hq02Yt+8BxAFq0u3XhznSxw==
X-Google-Smtp-Source: AGHT+IEz4B3cV9DBF83CZSl8+GbOJJcYyIOwi/DxfkLCvOvJEE9nPlcLwC4Y/P2qTkGuQmDzsofa/Q==
X-Received: by 2002:a17:903:988:b0:295:512d:a283 with SMTP id
 d9443c01a7336-295512da484mr120139575ad.36.1762188601993; 
 Mon, 03 Nov 2025 08:50:01 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3407f26e0a6sm6779040a91.5.2025.11.03.08.50.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 08:50:01 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Matan Azrad <matan@nvidia.com>
Subject: [PATCH v3 33/44] net/vdev_netvsc: replace use of sys/queue.h
Date: Mon,  3 Nov 2025 08:47:38 -0800
Message-ID: <20251103164915.101713-34-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103164915.101713-1-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
 <20251103164915.101713-1-stephen@networkplumber.org>
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

Replace use of system sys/queue.h with DPDK rte_bsd_queue.h

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/vdev_netvsc/vdev_netvsc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/vdev_netvsc/vdev_netvsc.c b/drivers/net/vdev_netvsc/vdev_netvsc.c
index f4a84783ce..7d4800af6b 100644
--- a/drivers/net/vdev_netvsc/vdev_netvsc.c
+++ b/drivers/net/vdev_netvsc/vdev_netvsc.c
@@ -19,7 +19,7 @@
 #include <stdio.h>
 #include <string.h>
 #include <sys/ioctl.h>
-#include <sys/queue.h>
+#include <rte_bsd_queue.h>
 #include <sys/socket.h>
 #include <unistd.h>
 
-- 
2.51.0

