Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59180C87FC5
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Jul 2025 09:20:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 777864021E;
	Mon, 21 Jul 2025 11:20:39 +0200 (CEST)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com
 [209.85.160.174])
 by mails.dpdk.org (Postfix) with ESMTP id 05D7D400D7
 for <dev@dpdk.org>; Sat, 19 Jul 2025 17:17:55 +0200 (CEST)
Received: by mail-qt1-f174.google.com with SMTP id
 d75a77b69052e-4ab3d08dd53so26379171cf.1
 for <dev@dpdk.org>; Sat, 19 Jul 2025 08:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752938274; x=1753543074; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NttuPk0erEAa0GmxU/x3sYVkRsZTw64VR0jxO6SaOG0=;
 b=NaIPGvED3cysAIQyR/sumcuH0NKFDumaXkdcgXEsHADBliMkPwC8g/vUP89JeeAG7M
 VBw4EvPE/awXghtQ9neM7+ZABqwPhhb5UGhgbj0LMDlMQbFBduB2Xg1rWGhu4hDylnKb
 sgL2joaQXPRJLIgKYFbmDUpajyX/bEaor28lc7CIBiQQNhyKB3xNYBRQIqpAMfruJVqh
 ImOC2aTN4fdvUv5wtLUg+VtFZM+sYn95ZD5JNl21nhegz9U1bVTs9IImmzdF8CEETGOH
 vCGR/+k5kV2c/pUXIyNvCaWJ1HcnZVfc2v2wrmQhVKHKrxAZLO0CcH9pG8l9IXt0Hdug
 S0EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752938274; x=1753543074;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NttuPk0erEAa0GmxU/x3sYVkRsZTw64VR0jxO6SaOG0=;
 b=VXlmG4X7Ru0RCt8hNJXUldOOpg1dIUwtFgG1FxBulym/hphXTHdMgFN0HUbKUgPOwU
 IBmg/LzYaxBj09e4fcmjOAbAOO9e4QXq2GjUn6UzHPiFQ2L/CkaOKByNVeiY7Lz613nk
 ZznlyrAmscNTK7krrm/c7Km274BuUZeOv6X3CkYEqMShR9FEoa1lXGabTagsetw/YwsN
 mbKY172dpGh6c7qWe1l+vCsphBSLLYG5y8nHd4g/VCe4O9D8+4Ndt9Mtq63jydamM9fK
 iDZKKF8D2LufRW+s2Vo5y2CqTb3zcHzzUnKeoUmObJdRTvBrEw8aLvTdU6GwfDfNbR9K
 FxlA==
X-Gm-Message-State: AOJu0Yx4nkVWMWTGcQQ8JvhvLGVw3byTBs6h77bBCSi2s0afZqbz3Hv2
 aHflHT148xbHmjzX1TLBcMF3/mK7ypsNTBp2C/zh0EkuIcCLm7JjHSzvb5IvYA==
X-Gm-Gg: ASbGncv7oHYLNk8rgqZ9pnuNLJO423ISuYZDt1pl/0s7KviPPaLH17I4yvrgvlkic89
 KBxqDsjdo+dpRZJnFJlbVfZe9l/wF2Pw8RegB+NKSOD797ZVZadjtA0ugVdFojUOt5qjfYIIrA4
 3pJct12uSBFq2oHx8rRhNceqWPgc60cHTvJQXXxcpEiW8v7irlN1PtX77AMSPgAh5F29aAihOKB
 tZbxcXfN1TLHIY0Ux2m5cqvPEjJnFUA4J5JrWv+F2yXA8zys2r3grQp139vsG+ctkkxC3Fxq3MN
 Ylppx8ZgsPmHp1Qn8EnCOlwBPgTI8yOY6zyAA5oXx59vY9CACWblPQP+M2prREHorqRWr5xbJDq
 89RwGwzyrLsVC2uS0sUNHdE46Tm5i0S/5vHNO80DNQxorMVoc+AOPNk691KogcBUUfXbmpw==
X-Google-Smtp-Source: AGHT+IH5pyIcNniXM4/RyltnqdCUxfsY6GLDQX8fX01sokHOpg3vjgTIRhFD0CZYd+6zVIEvwvr3bA==
X-Received: by 2002:a05:6214:2026:b0:6fa:bb26:1459 with SMTP id
 6a1803df08f44-704f69ea8d4mr273549216d6.7.1752938274054; 
 Sat, 19 Jul 2025 08:17:54 -0700 (PDT)
Received: from pravin-HP-Z840.. (ool-944c2daf.dyn.optonline.net.
 [148.76.45.175]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-7051ba91e48sm19646736d6.76.2025.07.19.08.17.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Jul 2025 08:17:53 -0700 (PDT)
From: Pravin Pathak <pravinpathakdev@gmail.com>
X-Google-Original-From: Pravin Pathak <pravin.pathak.dev@gmail.com>
To: dev@dpdk.org
Cc: jerinj@marvell.com, bruce.richardson@intel.com, thomas@monjalon.net,
 Pravin Pathak <pravin.pathak.dev@gmail.com>
Subject: [PATCH v3] mailmap: add new email to DPDK
Date: Sat, 19 Jul 2025 11:17:50 -0400
Message-ID: <20250719151750.48539-1-pravin.pathak.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714191141.1243467-1-pravin.pathak@intel.com>
References: <20250714191141.1243467-1-pravin.pathak@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 21 Jul 2025 11:20:37 +0200
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

Adding new mail for DPDK contribution

Signed-off-by: Pravin Pathak <pravin.pathak.dev@gmail.com>
---
 .mailmap | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index c7d55c7386..ca677c1c67 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1240,7 +1240,7 @@ Prateek Agarwal <prateekag@cse.iitb.ac.in>
 Prathisna Padmasanan <prathisna.padmasanan@intel.com>
 Praveen Kaligineedi <pkaligineedi@google.com>
 Praveen Shetty <praveen.shetty@intel.com>
-Pravin Pathak <pravin.pathak@intel.com>
+Pravin Pathak <pravin.pathak.dev@gmail.com> <pravin.pathak@intel.com>
 Prince Takkar <ptakkar@marvell.com>
 Priyalee Kushwaha <priyalee.kushwaha@intel.com>
 Priyanka Jain <priyanka.jain@nxp.com>
-- 
2.43.0

