Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B77FF885D
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Apr 2026 00:46:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1F24240293;
	Mon, 27 Apr 2026 02:46:50 +0200 (CEST)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com
 [209.85.219.54]) by mails.dpdk.org (Postfix) with ESMTP id A49ED4025F
 for <dev@dpdk.org>; Mon, 27 Apr 2026 02:46:48 +0200 (CEST)
Received: by mail-qv1-f54.google.com with SMTP id
 6a1803df08f44-8a58057d7baso115905006d6.1
 for <dev@dpdk.org>; Sun, 26 Apr 2026 17:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777250808; x=1777855608; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tb+zK5k8apJRsXddaf4RqDPCpLo1o5Sdyuq/KG4NZd0=;
 b=B9utPEaqL1onXdqcImz6NKHaLVMQwp+iOJXT1tzX2BaRJGLtAFGLAt/Ed3B+gJ9BSM
 sZk4udhD9KTTcm+j8RgLZ9u/QSnhQcWJIEOiXtPqHdwUPK0jJlOF6LOPrDFYfjqhEQyl
 +NFGQFu9+OZGUAkyN18swsqtMN1uO/s1ECKkUlqTr2nC9mCW2UhXOyh91liUCkKZJYWW
 ifFxDo8TSvzi4DlKssP+kXCznEgtZLRYttCLeQeUth2Axf3pHIWQZHhocIfK1L8sIaEh
 vNEz3Vgv4bnVAENnAibfFigdnQaWndT7OdcWfI4vFriiCTCMe2e+FhCKB1R5eOYC2HUk
 tMiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777250808; x=1777855608;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Tb+zK5k8apJRsXddaf4RqDPCpLo1o5Sdyuq/KG4NZd0=;
 b=RnSOa+IWDefyLfgKJsbTlxb/VH4LQ9qb5C7sDkP5twxXC/Vth7233WIL1eyLyJ7Ujk
 dlDGLekuKWr50ylWF6olMDzx3+8cJ/6W8wv7/c4wavDoulijq0ipLRCU0fs3U8Qn8ubH
 yt0Yna1ScE5p3MUloDPlfwUnjpOXXfSzJ+elvucN1lY78PXPoF6k4mM/Ym5PRJBt5ZAA
 m9Moj3eVN7rEmOcFn7BFMNz+LpTHo+NNU217UUe07/QJ7BuVmpgK2d0qtS3lO0zER3ZW
 6eDvzDCPiow5H/Nzn9ojvIhlt2nA07Y3danagw+qcEE/WmGCxzFsmVuyFYZQOBm5KtJu
 AOFg==
X-Gm-Message-State: AOJu0Yz00cI6DN6lKiibzVjGma24M9D2I682f6UxGqM8He/5op9qQzed
 MLMPzg2h3JWDdNSx225Dls/9eqx8jjCzeVZ6WLMV1Tcsyv0eps6+A/l/
X-Gm-Gg: AeBDieu3ilIP7UgkR7MVoPZqPI25HBbE0Fwb03XmnEtmY9Hi/v6VHDbX+jtXbmqZH5v
 ZyoO7QSQNbX882Xe81XP7AkNcEfbJb2P+KskSK+Q3rzfgCSsAK6Q0bf8X+IRZHkLRQEw7c+TlTA
 bhaastvuIl8vcgjnMeUafN7xgaFFDeJ88r9bP3RejWeXpJ+OFK7Z82HBJKwg8FtUHHNHG0I9pct
 wj/zOE9kXH4bEkNX78swOnN/F1qZvmqkQYbYHg4a/9l/Fo1Jt+bsEva08oAALvrvaUHjgwWgeAl
 QfNfXQfpY8MynGT0wNPFXBAR10xb/0bagL7Mk/7eh11F39TPLUn5xMI0w46HAFP0Q+0IaV5MpML
 aIQGr0zChmtzfq1cpBkx5yKrs1YISuZB9y7fyQajlMcLpuPLk6sGO+PYcttdUX+tgu6VaL1dAV/
 aEKjGO4LCL94/OEwbPP+WvzLdXnUTXB0nt2rrS53PAxkYN0t4wpP1hCdEXZ0M/Ykh1mOVXpym1C
 MOIEEDy0aBgNQmXwdC504LK4g==
X-Received: by 2002:a05:6214:4d06:b0:8ac:8938:ee55 with SMTP id
 6a1803df08f44-8b02802b6fcmr596407616d6.11.1777250807826; 
 Sun, 26 Apr 2026 17:46:47 -0700 (PDT)
Received: from blam-mobile.hsd1.nh.comcast.net ([75.69.100.91])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b3d9fe446esm5299066d6.15.2026.04.26.17.46.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 17:46:47 -0700 (PDT)
From: Patrick Robb <patrickrobb1997@gmail.com>
To: luca.vizzarro@arm.com
Cc: dev@dpdk.org, dmarx@iol.unh.edu, abailey@iol.unh.edu, knimoji@iol.unh.edu,
 lylavoie@iol.unh.edu, Patrick Robb <patrickrobb1997@gmail.com>
Subject: [PATCH v2] maintainers: update dts maintainer email
Date: Sun, 26 Apr 2026 20:46:43 -0400
Message-ID: <20260427004643.14200-1-patrickrobb1997@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260419194836.27602-1-patrickrobb1997@gmail.com>
References: <20260419194836.27602-1-patrickrobb1997@gmail.com>
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

Patrick Robb will now make contributions to DTS
as an individual in his personal capcity. So,
updating his email in the MAINTAINERS file to
be his personal email.

Signed-off-by: Patrick Robb <patrickrobb1997@gmail.com>
---
 .mailmap    | 2 +-
 MAINTAINERS | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/.mailmap b/.mailmap
index 0e0d83e1c6..e3c13d016f 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1232,7 +1232,7 @@ Patrick Fu <patrick.fu@intel.com>
 Patrick Kutch <patrick.g.kutch@intel.com>
 Patrick Lu <patrick.lu@intel.com>
 Patrick MacArthur <patrick@patrickmacarthur.net>
-Patrick Robb <probb@iol.unh.edu>
+Patrick Robb <patrickrobb1997@gmail.com> <probb@iol.unh.edu>
 Patrik Andersson <patrik.r.andersson@ericsson.com>
 Paul Atkins <paul.atkins@intl.att.com>
 Paul E. McKenney <paulmck@linux.ibm.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index 0f5539f851..b61eba8761 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -66,7 +66,7 @@ T: git://dpdk.org/next/dpdk-next-baseband
 
 Next-dts Tree
 M: Luca Vizzarro <luca.vizzarro@arm.com>
-M: Patrick Robb <probb@iol.unh.edu>
+M: Patrick Robb <patrickrobb1997@gmail.com>
 T: git://dpdk.org/next/dpdk-next-dts
 
 Stable Branches
@@ -2001,7 +2001,7 @@ F: doc/guides/tools/proc_info.rst
 
 DTS
 M: Luca Vizzarro <luca.vizzarro@arm.com>
-M: Patrick Robb <probb@iol.unh.edu>
+M: Patrick Robb <patrickrobb1997@gmail.com>
 T: git://dpdk.org/next/dpdk-next-dts
 F: dts/
 F: buildtools/check-dts-requirements.py
-- 
2.53.0

