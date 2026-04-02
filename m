Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 508B9D6AAE9
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Apr 2026 16:17:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2853B4028F;
	Thu,  2 Apr 2026 18:17:26 +0200 (CEST)
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
 by mails.dpdk.org (Postfix) with ESMTP id 24C494028E
 for <dev@dpdk.org>; Thu,  2 Apr 2026 18:17:25 +0200 (CEST)
Received: by mail-dl1-f41.google.com with SMTP id
 a92af1059eb24-1274204434bso1913479c88.1
 for <dev@dpdk.org>; Thu, 02 Apr 2026 09:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1775146644;
 x=1775751444; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=j1bOszU7ocdz2s5wU3XnuovVp/QUAFQMWku88lkZZjE=;
 b=f0UMTUSIcJyTnMaTDe/oBY7PzOjfznSRDyuDio2rU8TTAFH9513ZgwRNAvG5J21X2c
 UGoTY/DRKFozveOlPg+Vdvh2pDrBwKh7COZ1movNeGFzwe2/ZkOmsMJfT4RVq5Cun1rh
 LSM0NbUwvM7lvZlib/94ICdBcUzFrviAfm9DKzXJt2ZanmxRlVTS/Qjm8quY4i29YL/e
 JbDJj8Sm1TaE+7W33MxvCWwuxdTAHdASL8DihylRdM/vbCqRodY1kvhCo/so9WJG45BO
 BbyNE3F7o5anzU0b65v325H0OzQmTAZ9jaOEvu3sRtlXItCIQCbzj/dY22yUXBRYI04V
 +6Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775146644; x=1775751444;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j1bOszU7ocdz2s5wU3XnuovVp/QUAFQMWku88lkZZjE=;
 b=KxZyMCPqdXj7/zm+8u17VXj0YDDxV9wZFYixo1uAA02NE73ndvpxsYrnDjesNk6HTh
 bY7MpOESdH6s8RbeCwmMy9+oNSAp4TWmPOOrngXV3j2kwNKce0zjtz2elamdjEow1z8V
 J/9V9Uy0A3sDW9KdvL0REhkLt6nmK5LMF1Ba5DeoUFn9UGtL1igeSzRTVvFkUjeLmozz
 8pmlAd6lJ3Yr5ogpWKHkpBY/ctg1Da61C5peQp5MD+yi9/DmpB6oXK0clSeXsVANr/c0
 yKKlOoWW33zBAOoaOBFeOzyFTAZSVG1QcgXmvwF6V2lrI7sSdz0SeXaaeQc+4aVcIGNP
 z1rw==
X-Gm-Message-State: AOJu0YwRU2pH2MX+mdQrQ/PMGJuE/WZ3wQI8ASkGGAoUax+Vw3b0nCrc
 cWvbMRv8vVTTqa28NohHBHjpRxVDq5jc1QbO93zsnVn2/hiv9OwqyVxn65FVG56G7vYlASpKLSf
 U6pUb
X-Gm-Gg: ATEYQzwhPbaJwOYdUJZ4+eq0+fWFgd2bzV/+9+GHFfCDwzc2RIhg2Lg2Qu68LBHyJla
 VpRrc/BDiijgsYk/7mNX6d6I67VkLt1a+fk0NbOZiAeM1vHo5LgYRUYYO5XT5NUPwhjSXgUyOu7
 Hh58NgDki9yy+q0ujg+HblPhqMG9mWd94nHYRC/Rrvcj4+jkC+oxVVrvU6wd/U51i9VUXQKUDhb
 /6yyLE22CmlP3GPMCeH2ddFQFGDV/v6W7gLjYIirdjjGp8idivhm/YKrxHhRsosqaSkegnuEeAo
 Jem1zejMmT6BUhvTeZkOC+vyv4L/kCIK/yTJzfGfSgTNg79K1OGhJjcebttuTZQKuLgUbND/gjk
 n3mB2mBmMSDrk1dOiX4rpX+l3EvxgHa/cj3DvhW2X1EZx3aeoWVI4fzBDjSUIGWK2UX0w+rorra
 3iUO3QqsuO45NK/8zjIpl0TnR+WvSABOqe
X-Received: by 2002:a05:7022:ead3:b0:12b:ec20:4eba with SMTP id
 a92af1059eb24-12bf07b43a7mr1254037c88.7.1775146643432; 
 Thu, 02 Apr 2026 09:17:23 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ca79e1d331sm2887311eec.13.2026.04.02.09.17.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 09:17:23 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 0/4] devtools: align trailer checks with kernel convention
Date: Thu,  2 Apr 2026 09:16:05 -0700
Message-ID: <20260402161719.82570-1-stephen@networkplumber.org>
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

This series makes four incremental changes to check-git-log.sh to
align DPDK's commit message trailer handling with the Linux kernel
convention.

The motivation came from the recent work in kernel where the
same patch needed different trailer formatting for DPDK vs. the kernel.
This is unnecessary friction for developers who work across both
projects.

Patch 1: Use git's built-in %(trailers) format instead of grepping
  the commit body with hand-rolled patterns.

Patch 2: Recognize the kernel trailer tags that DPDK was missing:
  Co-developed-by, Closes:, and Link:.  Also adds proper format
  validation for Cc:, Coverity issue:, and Bugzilla ID: tags.

Patch 3: Remove the blank line requirement between relation tags
  (Fixes, Cc) and attribution tags (Signed-off-by).  All trailers
  now form a single contiguous block, matching kernel convention
  and git-interpret-trailers(1) semantics.

Patch 4: Demote tag ordering from error to warning, since the
  kernel itself does not enforce strict ordering via tooling.

Stephen Hemminger (4):
  devtools: use git trailer parser for tag extraction
  devtools: recognize kernel trailer tags
  devtools: remove blank line requirement between trailers
  devtools: demote tag ordering to warning

 devtools/check-git-log.sh | 50 +++++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 21 deletions(-)

-- 
2.53.0

