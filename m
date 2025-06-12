Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EEF6C71136
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Jun 2025 20:12:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AAB7D42DD9;
	Thu, 12 Jun 2025 22:12:24 +0200 (CEST)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com
 [209.85.160.171])
 by mails.dpdk.org (Postfix) with ESMTP id 17CD7410FB
 for <dev@dpdk.org>; Thu, 12 Jun 2025 22:12:23 +0200 (CEST)
Received: by mail-qt1-f171.google.com with SMTP id
 d75a77b69052e-4a58c2430edso14363491cf.1
 for <dev@dpdk.org>; Thu, 12 Jun 2025 13:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1749759142; x=1750363942; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pKuPpY0MYegQqg8RISofR/UAhJgiOO7fTxfzQzDOghA=;
 b=ChyZZcCLINixD6yDk992U/S28dcQ3wydAtqArttjQxIMUh2833wz4u3sQX18ZaaER0
 t542tzDAHRPK5wzI1aDoxyxufsWrF6+Om0guvXQPDMDJLcTA2slt8no9gTue3cKf6ivd
 6gQkTA5RgNMQeZbHkkzwjXmVEzHdbMSuMdQS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749759142; x=1750363942;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pKuPpY0MYegQqg8RISofR/UAhJgiOO7fTxfzQzDOghA=;
 b=HSSCccRTur+qbMEchlvf90/f3P5b2MXZU4NPVlK0s/QiTy4c/j6yADUPWDhkbFls+N
 v7bdx9z3a0TV3ZyCNj/VCJjxl5ifyYWUm2aezfoSReGAhalUpifFGERrPoZ339CRUIQM
 gzxn58QZHn166ik5KlTcwuVxZKvjG6KY5wuJez9o1XiQmERirECIjIPPsbjsJWW1T8sz
 Xiss/DTkB//H1UtpBJWoITMcLskCYKPyqRoIGOQDPxupIFrlbDGAngmYUecJ+mMUslQv
 VGzy0/BBDuM/r50rei5oivh5uPdZv9wuk2jLobL7c6wdyF24JhyXrkK0bUP3EkQhKeWr
 4ffQ==
X-Gm-Message-State: AOJu0YyLUypYJwcNbk2YtKiiEBHIUlKeEdQvUO6VnPcGibC6YU2JyX9X
 1XqIN3uXYBvlcJ2YyeOXuDhKU1Bn/UqkmJYdoy5qIgOVE1wkOtKEwab5zsFJXGVmQR6SohDHzFC
 yqz5C
X-Gm-Gg: ASbGncuk3XiDnFGV44LTPqSB/dObD9krNxX683EmsOex7Ja7LduvUlBL0UxYtp6G3j2
 L4XNlYMsWD0J1GQQm6VA015QUj0etan/5knr3t48fBZC5kfY7LBsK4Pdm0oGomXUZfo46MyRXni
 TiGqb8tJS4C0RO3Ab+88dd6SDBSUhr7IFMSe5Dr8VX5RN6HOzPpVyEbkeFk+fCtS2px4DTELknQ
 1po+NWnbNN2MN1cJyUEeBh1/GlUIP+6cpP490LUHpOMjACxQk7W/coQZFMzGaDA8E5x4y1b4Uw/
 xCFYeWaG0UZ/6Rj0g6WyaLly9qtNUIMeym1RJVMGyo0qEprUwpzuhWuBUBnzRGgBghKngE5f
X-Google-Smtp-Source: AGHT+IGp6xJrbPcbW0h39UHt8LoxNf1hFgMFGXS3GGdvdtxDhKCmdaev4AwPTjJAiZeryCQN9O845Q==
X-Received: by 2002:a05:622a:59ca:b0:49a:6859:1c10 with SMTP id
 d75a77b69052e-4a73057c375mr6318041cf.24.1749759142348; 
 Thu, 12 Jun 2025 13:12:22 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:ac5d:4186:4dc6:47eb])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d3b8dc9666sm80299585a.2.2025.06.12.13.12.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Jun 2025 13:12:21 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v1] dts: fix devbind initialization bug
Date: Thu, 12 Jun 2025 16:12:20 -0400
Message-ID: <20250612201220.614724-1-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.49.0
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

Rearrange the topology and DPDK setup/teardown calls during
test runs to ensure the devbind script is not called
while the DPDK tmp directory doesn't exist.

Fixes: 4cef16f1f0a4 ("dts: improve port handling")

Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
---
 dts/framework/test_run.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/dts/framework/test_run.py b/dts/framework/test_run.py
index cff0085317..4287028b4b 100644
--- a/dts/framework/test_run.py
+++ b/dts/framework/test_run.py
@@ -344,8 +344,8 @@ def next(self) -> State | None:
 
         test_run.ctx.sut_node.setup()
         test_run.ctx.tg_node.setup()
-        test_run.ctx.topology.setup()
         test_run.ctx.dpdk.setup()
+        test_run.ctx.topology.setup()
         test_run.ctx.tg.setup(test_run.ctx.topology)
 
         self.result.ports = test_run.ctx.topology.sut_ports + test_run.ctx.topology.tg_ports
@@ -433,8 +433,8 @@ def next(self) -> State | None:
         """Next state."""
         self.test_run.ctx.shell_pool.terminate_current_pool()
         self.test_run.ctx.tg.teardown()
-        self.test_run.ctx.dpdk.teardown()
         self.test_run.ctx.topology.teardown()
+        self.test_run.ctx.dpdk.teardown()
         self.test_run.ctx.tg_node.teardown()
         self.test_run.ctx.sut_node.teardown()
         self.result.update_teardown(Result.PASS)
-- 
2.49.0

