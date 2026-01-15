Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E095D4662F
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Jan 2026 23:02:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CDD9D42DAC;
	Fri, 16 Jan 2026 00:01:45 +0100 (CET)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45]) by mails.dpdk.org (Postfix) with ESMTP id 1ADD442D2B
 for <dev@dpdk.org>; Fri, 16 Jan 2026 00:01:44 +0100 (CET)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-47fedb7c68dso9531245e9.2
 for <dev@dpdk.org>; Thu, 15 Jan 2026 15:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dyna-nic.com; s=google; t=1768518103; x=1769122903; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+IH+QQWPNjUmEmr9Br3zj7xfJIR5Vpi2t7LuwHNR69k=;
 b=Yd+sO8lqESHSK22H1/B3DcvAEGo8hL56b1QTT4ZtdAAnGtD8/nPqg2hlsjZTMke+Sq
 UxZnqaYqvEjBN8+Wdkp+vLonQkzsb/DPacYtOFeePu/YNKWN6+RnXlh7C2ORu2icEN3h
 1gR6ZPKzDqjV2gBVj0AYdyALHPydDcckKqMZcEFk+FZ41ESYqvgKpmuZ1bHvsO0G6l/I
 NS3m5dwsSsL/3yld5chxb3umHV9hU8Nzop6l+rmFIf6B2hz58/w9NmQOWJQjkAYvtYvb
 DDuZpC5sdLdmHTuEQMaGUOLmOn15MNYGaMIcEp4mlx5q6z5/SfOJFl3UlbB4bs6GU6kY
 vHHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768518103; x=1769122903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+IH+QQWPNjUmEmr9Br3zj7xfJIR5Vpi2t7LuwHNR69k=;
 b=JPtmtluIlGKx29S/CqdZPbctKJ5ZUMvOf2Q+KiC1ry9Y62W80NmtyWvaR5wC/1t3BK
 ZLX/eXNva34xCh/I9eSNIZbiJp78aiuLKQo1FnqXc1alJ10K4hx/QEhgtzb3xX5sx6HY
 oNt63ikcJTgK3fDUtz+fXP8ShyB1r1RcgVxMY2MAywjuXXcI3Srk739i5rL/odG7WYYQ
 6tZzBjFN/1PZiOiyC3rGxveMfb/UpiYcmWyV3uuO/pLaBup4OdwdrriR1m+dAXXtEg4c
 U5Br2tSmTpl179WjHlAq30o4fgJNkj+XLUOp0d8N/F07tLXQnogokyb3eErcKsM+g7P7
 8QcA==
X-Gm-Message-State: AOJu0YwUx6IGE6aiTYMjhszZoOD1QQonWk1o9l0EBSg91bOH8TRf0FmC
 icTDQkoqi2ltc4nyc5zOfHWn2mxtUl/A5wuArkzCR3uqwGTED4mT/X2E1JAK259F9FT0xipfass
 qJTYi
X-Gm-Gg: AY/fxX48J9IqlxeiNSQg/MqU5P9C4G8uynJg3RAMuSNbUWoQub3JL6ZGvX19jnY+1Ph
 rMl2TsH/G+1COnpIRsxF52PJjW2HfH5w7G0k1SmZH8w/Cg4BggAUxmbcrIeu2U0d9jisLgLJOC2
 Yq5Hd2QXzx53oiey9YpES5KX/b4C0wrRlKjoq2azdN86Zqb9z25vwauNXgtLPbG9r8av4WVhOnb
 Q5ve4F5sj6z2WR+zr39dtgRrUtbaaPKoJzg58qosptz4NqJiAWG9VEeWeAubPHentbIRvX8hQ2S
 EeNBIMdVxZdOT8YPf1MOxjO4cfp7M47sOTInj0Q+V/Yc+91fXGZ15qsASsb8epDJWCto5DSAzM/
 bAUcznsONE58ncxYizSot8dHIWjQRcsS/ex4+x1DVNvbo6SW2P2SpUIaDwppFYfLAv7uLGX8FtF
 0jRG0/XkdBYc0xDgvQvo/aZ2ewg2mwgpPS1EbtGFd8oi+DKSj+6pY=
X-Received: by 2002:a05:6000:144a:b0:42f:bab5:953d with SMTP id
 ffacd0b85a97d-43569bcbc8emr1187947f8f.47.1768518103495; 
 Thu, 15 Jan 2026 15:01:43 -0800 (PST)
Received: from dpdk-test3.liberouter.org (rt-tmc-kou.liberouter.org.
 [195.113.172.126]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43569921dedsm1572918f8f.9.2026.01.15.15.01.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 15:01:42 -0800 (PST)
From: Lukas Sismis <sismis@dyna-nic.com>
To: dev@dpdk.org
Cc: Lukas Sismis <sismis@dyna-nic.com>
Subject: [PATCH v3 6/7] mailmap: update a new contributor email
Date: Fri, 16 Jan 2026 00:01:12 +0100
Message-ID: <2684b346fc6e0d1983758b6beb166bdadc3319b2.1768518003.git.sismis@dyna-nic.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1768518003.git.sismis@dyna-nic.com>
References: <cover.1768518003.git.sismis@dyna-nic.com>
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

Signed-off-by: Lukas Sismis <sismis@dyna-nic.com>
---
 .mailmap | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 2f089326ff..d838ffb4db 100644
--- a/.mailmap
+++ b/.mailmap
@@ -933,7 +933,7 @@ Luca Boccassi <luca.boccassi@microsoft.com> <lboccass@brocade.com>
 Luca Boccassi <luca.boccassi@microsoft.com> <luca.boccassi@intl.att.com>
 Luca Vizzarro <luca.vizzarro@arm.com>
 Luka Jankovic <luka.jankovic@ericsson.com>
-Lukas Sismis <sismis@cesnet.cz>
+Lukas Sismis <sismis@dyna-nic.com> <sismis@cesnet.cz>
 Lukasz Bartosik <lbartosik@marvell.com>
 Lukasz Cieplicki <lukaszx.cieplicki@intel.com>
 Lukasz Czapnik <lukasz.czapnik@intel.com>
-- 
2.43.7

