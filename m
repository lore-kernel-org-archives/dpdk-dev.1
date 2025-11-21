Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D749CFC50A
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Nov 2025 21:06:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 62EE740280;
	Fri, 21 Nov 2025 22:06:56 +0100 (CET)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com
 [209.85.219.42]) by mails.dpdk.org (Postfix) with ESMTP id 889D240269
 for <dev@dpdk.org>; Fri, 21 Nov 2025 22:06:55 +0100 (CET)
Received: by mail-qv1-f42.google.com with SMTP id
 6a1803df08f44-8824a756771so27505836d6.0
 for <dev@dpdk.org>; Fri, 21 Nov 2025 13:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1763759215; x=1764364015; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=I1/KDJ2X7mrt6CoJvy3kV4pnmL6DjkIjnuAeAbtU7H8=;
 b=DEkq9jbGsQa8iNkHCCdKGowCiUM+BkW5lxJwlkLsQpruU4WHL/OBNVo9SMM7MbqfgL
 fxE8qR0wFUKkWifBDcsx4XqfjzI1Ec/h/S8rWJ42+AuIn/qIEAm0G8zJXwOwe9C7Wr6e
 kKkCKb7NoAPzc/DirHDExX9dRaQpKbD8gDK0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763759215; x=1764364015;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I1/KDJ2X7mrt6CoJvy3kV4pnmL6DjkIjnuAeAbtU7H8=;
 b=A9bVUumSeJ3bOFbGVtwNM6O0Qat3rKa1ZPc5xOBMq+tpntaM2beni8z+oEfVnFGUwI
 8Igi0gBifV1RZbXtiezL//KmwQkTsSBTGPc21hYV2oInJrl0mmVjEWWMGV9gnROkh1DA
 LwUai7SWximUc6gr8PjqWUglZhnZJd6R+23KdUdrcOHeAvCiN0tXcYtP6so2isPUZ3Q5
 HoFG+5Z9K2gc9jxL7o9zANW+seTWfPwdcrDi4s69Mtf7ZUnowoJUrMHwHkSasfYfRKvZ
 l2IwnZdklC+vNp78mkQQnb6nRx8gf6c9kI01R3DncNyd770sqPHSbk8yXm76T+paRuJT
 1z9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8CBmJy3ys9EaA3vr84ssCcv4eFrOPpEZVD4BuxYDVCBnIS/oVB1PjCmO3IcCqC2Ko+vY=@dpdk.org
X-Gm-Message-State: AOJu0YxfeEXs50fHWEgqWWKhpcfwywbhHK3hEI709lMCqEyAmRz2I+A/
 2ipbSI7tuJ1NBXXjmYVy2N33XxnRqAUZ3f31zloif8eLqKcAPVexr9NvubLUvD9i8V/uZogL42X
 WVBYO
X-Gm-Gg: ASbGnct6SeIYq1b4YHWqXqgZNYyxa+dDDVq/4HYCz6ZhM0HhIxMEbZscJBl9mfNRtjo
 kFyztQI9el32IVLtTG+O9vC6l5/pBHeSaFtoV9xD3HmZz2Te3BM99liSEYaXKtiaejs1bFbR69D
 a39ZabVJjCRGP96xlpK0F40ROjTyhUiQOkJlzxyYvl5rTZdDIVMLxbyPFkdon8uCgrunmn4cYpj
 MzpqOaZKP8YUxnEbc6AYYYVvP6a0FjAd9rpBWpRevCTOIplEAI5QFBfCDmsGu0S6EAZFrSh2Gue
 ulmoElyHPbkJytAtidunL3ig7rMmQ2/+S0afXczczzyK9h0zrlZ6dD1yQq3OF/4ZCh2QbtWLVhw
 SEvajj5rQfIgkRo42OdB8EWUJ3xnCpG5bf2OKFgb//FZQL9jXW0SxyHoiYza/+8KJ+9SALsJGje
 mgCS4Qd9pvu3upi7ClWmW0Eic4Kk0g0xweow==
X-Google-Smtp-Source: AGHT+IEpvik8zIVyHmsCsxTazIMkJPuu7HOmIzzQnoV44SeRBe5cY9290LrznMwnTM7zr8yhk7+iSQ==
X-Received: by 2002:a05:6214:f6f:b0:880:531a:bf6b with SMTP id
 6a1803df08f44-884700a93efmr114251406d6.9.1763759214778; 
 Fri, 21 Nov 2025 13:06:54 -0800 (PST)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8846e54c032sm46449346d6.36.2025.11.21.13.06.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Nov 2025 13:06:54 -0800 (PST)
From: Andrew Bailey <abailey@iol.unh.edu>
To: probb@iol.unh.edu
Cc: abailey@iol.unh.edu, dev@dpdk.org, dmarx@iol.unh.edu, luca.vizzarro@arm.com
Subject: [PATCH v1] dts: automate VFIO-PCI modprobe
Date: Fri, 21 Nov 2025 16:06:50 -0500
Message-ID: <20251121210650.328804-1-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
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

Currently, users must modprobe vfio-pci before running DTS when using a
non-mellanox NIC. This patch automates the process on test run start up.

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
---
 dts/framework/test_run.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/dts/framework/test_run.py b/dts/framework/test_run.py
index ff0a12c9ce..38f9e6c07d 100644
--- a/dts/framework/test_run.py
+++ b/dts/framework/test_run.py
@@ -347,6 +347,10 @@ def next(self) -> State | None:
         test_run.ctx.dpdk.setup()
         test_run.ctx.topology.setup()
 
+        if test_run.ctx.sut_node.ports[0].config.os_driver_for_dpdk == "vfio-pci":
+            test_run.ctx.sut_node.main_session.send_command("modprobe vfio")
+            test_run.ctx.sut_node.main_session.send_command("modprobe vfio-pci")
+
         if test_run.config.use_virtual_functions:
             test_run.ctx.topology.instantiate_vf_ports()
 
-- 
2.50.1

