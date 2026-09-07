Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12125C79F99
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Sep 2026 18:23:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DCE20402E8;
	Mon,  7 Sep 2026 20:23:28 +0200 (CEST)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com
 [209.85.210.178])
 by mails.dpdk.org (Postfix) with ESMTP id 60FDC40262
 for <dev@dpdk.org>; Mon,  7 Sep 2026 20:23:28 +0200 (CEST)
Received: by mail-pf1-f178.google.com with SMTP id
 d2e1a72fcca58-852c481415fso4431435b3a.3
 for <dev@dpdk.org>; Mon, 07 Sep 2026 11:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788805407;
 x=1789410207; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=z2mwuC7FbCJMicJfp07XNYmx6RivWXQieyszNvqwfPE=;
 b=gHNJXSqf9xQn7Cl2NaRj2wOF1S5kUE7h7tuDX42cYTzOeA5TZ38tkXd9RDVaVPcun4
 wDJlDgtXjBB3BX3p6bVBjzJNzvZvK3uHlIEOhEShCRy+sSGbKkgKmjO7CD9CGE43x9RH
 f6dM7XkABNFTdAyYT/XmRPDVMxyEMFKIIDaDjqos2ECG/N8EJ/+Zt7tBjni0Jwc4YAKT
 DwP/z5O1z0MbBnsz5fJWjWAetVU9p2z1cmLnSu/k+v41la5NVIk78ffpmMsWhdLqnfSW
 DNZcNYEAlthNXnh44WBty8qAfYIjioOSyDr0mQnlr9cNtbUylBi95oWRGw2Jxf3z8Z4b
 /CjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788805407; x=1789410207;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=z2mwuC7FbCJMicJfp07XNYmx6RivWXQieyszNvqwfPE=;
 b=Fo/zfwvjXvTRRfyMv31Cbvd9oBAxcWBq+CUL9uvAC0+SY2EHijiR/ri6Hi+a4M4upR
 4ZISdUDESmrooHRxAZuN+ctPJslMLgQbc0lPdAmFD/nGMO0/zk9Q9yalniHzv2BA6fF0
 r4M0li/igg1sElINusv+qVbpK1jlHwocz9+5wqHz8SQGwLl87/xXpMXnZ+TN321abynH
 M7vJwc736pIbk7uLfLL92N1SoDg97umLOmkruBeA5r+iabwtzDl5m9VlHDoyOObK0xEB
 iPuxRSkqrPQaaCZkXyEPx+W6PjqnjqYw99+rNh4ZnRGgF7rNil6OmR05HuThmTGC9mAB
 8GVQ==
X-Gm-Message-State: AFuF++mH8NrQZLXgRfDLfcb5hq2wQc9es31E4AD7PGanxZEDNG+mHe7e
 k+/WS33Da/Is9FAy4PyIYAHcOk3yKOR4E6QyW+ThZo9AXJfjv4Tnite4XU3eSzDTB1UViPJmrws
 GtaP1
X-Gm-Gg: AYBFou2QFtquRFef9cGwLvJZxxDRuqybM6Kd7jwoR2e/9DDP1g9SCOd2tptLNVEYhnr
 j1wj/ZBTVQrJARD1XkakyXFrBNyhltHo+A9QE97woouuG91BIJPPkv0uU1mCDD/uuqGMW2Pk8SJ
 SQrUQXyhch2hMfG4C0jzBOqr9UI2YQN3hpxrtwAZ+aCww3DoyKNCOBIbozLzkcj0Pp4HW1UEABA
 u5qPPU0cxNwnMVj3SHa/o5JRIzBcYJQ4dw2gwHuUnpVfDs6DZ45jgZL1XpGWKeE9TrPstvdHNSB
 pT3MEb15/9WR8HN8g6K+ETOtSvfpJSebS0uG/Jqc5t6sr8zqX4XutGXPYqeHrOjKFu59JXYhfvN
 +t+3CqoBYwXbTi93RMoDi1iOe0SGdKjXIU/ErALaKiJPNQSwZH3bd7n+3t/Qw7bx/FmEl/B3uJt
 kimZvCs5sHK8MAwFeVv8uMlqtYL99+tUAiKIr2RRYVWc/Ppe4jUamZxZeBcyQM0u5yqVrHR5DS/
 oaRamtwAe/ykGxIg4TRDNpKiqGsS5zAlW2IXQ==
X-Received: by 2002:a05:6a00:349a:b0:848:56ff:6ced with SMTP id
 d2e1a72fcca58-8616819d66fmr35346094b3a.8.1788805407220; 
 Mon, 07 Sep 2026 11:23:27 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-86152f32447sm4553302b3a.38.2026.09.07.11.23.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 11:23:26 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Kiran Kumar K <kirankumark@marvell.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 0/3] app/testpmd: fix more overflow issues
Date: Mon,  7 Sep 2026 11:22:01 -0700
Message-ID: <20260907182317.570481-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

While reviewing the flex item patches to test-pmd.
The AI review spotted some other problems.

Stephen Hemminger (3):
  app/testpmd: fix stack overflow parsing flex item link
  app/testpmd: fix flex item allocation overlap
  app/testpmd: fix null dereference parsing flex item link

 app/test-pmd/cmd_flex_item.c | 88 ++++++++++++++++++++----------------
 app/test-pmd/testpmd.h       |  7 +++
 2 files changed, 56 insertions(+), 39 deletions(-)

-- 
2.53.0

