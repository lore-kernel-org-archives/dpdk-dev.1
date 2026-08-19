Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5862BC5DF81
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Aug 2026 02:29:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 56BEA4028B;
	Wed, 19 Aug 2026 04:28:59 +0200 (CEST)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52]) by mails.dpdk.org (Postfix) with ESMTP id 28B294028A
 for <dev@dpdk.org>; Wed, 19 Aug 2026 04:28:58 +0200 (CEST)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-38e347638adso682971a91.0
 for <dev@dpdk.org>; Tue, 18 Aug 2026 19:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787106537; x=1787711337; darn=dpdk.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=6vQhMkVZnYPyu6HsVJ9avg+bQPKqGiAomW3eO/JJugc=;
 b=BuvskkUNirfF2qpDGrEuMajG30mJ/zOwszSxKX6lADiM66ZNQ5TbLqgix5VPOsGeNh
 vcO7F4RqYM8j+XRCUcc5SuPR5UmFfy4mFZiv3eVOMUUX6jWmqK2Pdba0YtqVu/QRd7Ft
 E1YsBETUZp1h/xXZ6JhRIwVmi9Zruuv2ffdNIBh/0EuT9VhNc6iDEyy5ZWu4ZGYFcWfM
 RQs8UKofc8vijrbKGnUkqJFf163+8/OMcMh7VlwwdVQ16m4McB3sfa2iIZiqlhXgbEL2
 gPCy4IKWsfuw3JtEgTFmWSyfOmjUWMDhsiEx5ACqnbHQNTRWdbLa0IL7jUbeSJx33jYa
 OhGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787106537; x=1787711337;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6vQhMkVZnYPyu6HsVJ9avg+bQPKqGiAomW3eO/JJugc=;
 b=qxWSgtydZFpolhSEzRSOBqKwSAWwPgpUPaYeoVNCYYpsj46mPIlBLiIN/a3R1G7eFq
 2s+QalXMIJZp4gc0PdeN6bcM6b+3SNY2id8/3jkp7pEAvkV4RBQlms9uk8Dboi8mNeF8
 xI62ZKJYNijuj2ExOFrNLBlbBqIdJvfVyHggiXr698D+b8QML339X5RxfefjKA2kfzdB
 H3xRNb2ZT0QOtVrda3zwGviZoi40lTPfmRMVmv/vE9BWTpeBjC9rq/Zs+pqUNxSjBAKq
 I2UmHSnXqE6eZ4YYCfpma1EyGQUtrZFKhHIX5Y9twdycY/RJswtplJiX6OBUt0ViC/c/
 cA+A==
X-Gm-Message-State: AOJu0YxTc2cY+50RhCAeIwL3VdUs4nrV+g9TRBneJi+M15797k79mbn4
 O56l1Hq46kSUa7M2mmuOJug2quQlFnhejfUvSs9IcTiqNN9wzF8a8ZhlwL66EQ==
X-Gm-Gg: AR+sD10YQW+ljCaWAc9lksPLMm+t4yczG2CfgLnv3OT2ip1272u4Mh8qrZC5ux01hnr
 ZEWhbr5qJsBlR3GGcdEds2QaAVoX9oFM0Q6kTAYgIftYSOmZNH7E7Vzn91HPHrKNPHowtI0sg4b
 yQ9TCtC4afgyx63g2MjZTNx9vGfn1AAgxzHhLkcQVP2P4qmj0SIkRJabww5DqTxrldDLjKOmjTQ
 gkAShKaPRnaIlo/d43weXkR1l96DNu1pREbgacl60iqa6q26cQCJ7xFbA9R553y6pIC00pBCx2S
 RiiR8ss2xhM/hfR//iKT+9YVnSqDKYVWa6lz0rfuUf/sGQngLqcY3YGchZ31ZaDJQk4MoJjQ7Sm
 wKHWws0FyffNAFdJA9SXhc3WXTf0vG6vn6uY5vUDRdwFAcmHFtdbehs9RTh9fdJOFbdrrhHNyNo
 yFljtc75wBBe9fyq6OM2Zzd4BseKFDe7D6QV7/V2TtJIjCMXcWvDWVZ9a0Jj5w7Ru/WZ9Vf+AlV
 xal2Yt50J+fKrItr88gbOt7T7Sl
X-Received: by 2002:a17:90b:4a05:b0:37f:c22a:c188 with SMTP id
 98e67ed59e1d1-39580a80a65mr2556361a91.4.1787106536890; 
 Tue, 18 Aug 2026 19:28:56 -0700 (PDT)
Received: from YTJMJ2RP0G.bytedance.net ([139.177.225.232])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bf1970e4sm1315683eec.30.2026.08.18.19.28.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Aug 2026 19:28:56 -0700 (PDT)
From: Su Sai <spiderdetective.ss@gmail.com>
To: dev@dpdk.org
Cc: thomas.monjalon@6wind.com,
	spiderdetective.ss@gmail.com
Subject: [PATCH] app/test: lpm6 perf autotest fix lpm delete total time
Date: Wed, 19 Aug 2026 10:28:44 +0800
Message-Id: <20260819022844.58986-1-spiderdetective.ss@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
MIME-Version: 1.0
Content-Type: text/plain; charset=y
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

Make total_time from '+='' to '=' when test rte_lpm6_delete

Signed-off-by: Su Sai <spiderdetective.ss@gmail.com>
---
 .mailmap                  | 1 +
 app/test/test_lpm6_perf.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index fcb3d1bb3f..1bd625811b 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1644,6 +1644,7 @@ Sunyang Wu <sunyang.wu@jaguarmicro.com>
 Surabhi Boob <surabhi.boob@intel.com>
 Sushmita Hoskeri <sushmita.hoskeri@intel.com>
 Suyang Ju <sju@paloaltonetworks.com>
+Su Sai <spiderdetective.ss@gmail.com> <susai.ss@bytedance.com>
 Sylvain Rodon <srn@nexatech.fr>
 Sylvia Grundwürmer <sylvia.grundwuermer@b-plus.com>
 Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>
diff --git a/app/test/test_lpm6_perf.c b/app/test/test_lpm6_perf.c
index 1860a99ed6..7b295a5752 100644
--- a/app/test/test_lpm6_perf.c
+++ b/app/test/test_lpm6_perf.c
@@ -148,7 +148,7 @@ test_lpm6_perf(void)
 				large_route_table[i].depth);
 	}
 
-	total_time += rte_rdtsc() - begin;
+	total_time = rte_rdtsc() - begin;
 
 	printf("Average LPM Delete: %g cycles\n",
 			(double)total_time / NUM_ROUTE_ENTRIES);
-- 
2.39.2 (Apple Git-143)

