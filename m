Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C261CD4F3C
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 May 2026 04:44:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3257640296;
	Tue, 19 May 2026 06:44:23 +0200 (CEST)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45]) by mails.dpdk.org (Postfix) with ESMTP id 9D9344021E
 for <dev@dpdk.org>; Tue, 19 May 2026 06:44:21 +0200 (CEST)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-43d75312379so2648037f8f.1
 for <dev@dpdk.org>; Mon, 18 May 2026 21:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779165861; x=1779770661; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mFIcWB3vQ22FaXE8ZbZi1AZHTjZZ5PWfAeOdRCSKeL8=;
 b=ijDFdIKz5utK+wutAbf5VNZl3AXmmbWtWUNbU6LcfTQdeGNsq0knyHyaJvk2Lk7Q/P
 rTlOkmVYZhXD14l6H8JZWqh1QPM8xxGrvnFeYghFOxXxOpLeDtW/Q2HlJZI6OG+/peTZ
 DOPTWSTauHOePQ+tPrAgjiddOO4H7GGnB99dHNFsoUuKS6zVMROqPIwH04VubrPdjuug
 uPyryMSD/oLJ6xrOFQHEAneLdLnyCYJkFjMgN5uhsOJbgqCGsxqE9MsEJwwnt8yFP3+a
 gOTc5hBzgwg9USwXJACZC9jTjOnq24lpJdaFcvDCVuduOnfKu56PA3Mlis48XlPDk+5M
 YLLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779165861; x=1779770661;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mFIcWB3vQ22FaXE8ZbZi1AZHTjZZ5PWfAeOdRCSKeL8=;
 b=ZXNdoCxrT/8M69nj1KgpG8MXep08psucXMNY1ols6GHcwYINt6lxim93w10muGHdMC
 lnRpg1PRAQ9zXWp/SC7QlMEs7h6S4lEEEyCtHiKuL+70xZG6cwHvwG+XUXYKIFOBdrxh
 BFrDoaD7yhj2QI3bF5rq62geNuwtpIzI813ii/Qz8vR9KLKGtbO+dS1JjJHfdVR+VQ9W
 CEW5Kgw6pX7tdxOjqOmgxek1+SYPnUNSH95tZ5QB2szl56syoZX8kUFRKxICTce0xBbX
 mULnY51gOChGvfNq3RjNrtWCoUd25njiE7QXftQUiG/7pCdAlRSzt4lEhwsh15hFMVaf
 CtKw==
X-Gm-Message-State: AOJu0YxZGhqLbjVl+x+5ggUShU+yyVX62xKHYUu1aDLoxXLJLw+UVJ4F
 TA0oFZRCvXb9yI7DxYJVt8LXPfVZm7ixouNwlykvs2jXgq1KWpjCGZEyzTcCI0am
X-Gm-Gg: Acq92OHqBrTb5Tvv5AAZmNsMRuXTQNQQ9jPXyv7535NzUnEgtGP9eeuy8x91vycr+tP
 Vt+czzuBefMa+zr7gLZXu5d2aqg542edybGv3CvplRdOQab/1rKrCQ5IkdeLP9iSQoAk7tV0t8M
 vWqfxRpLx3yoyPlO7DkkIG0WHHhbqUPVh1nxixFkKMzDxYoO5P2UgAquIaLPkpjEO1ut7w6YDpv
 JDlb95dRnPjNE8D+x7gJWnCycXsG61nbMN1kM+MUgo+8rF6uMCzEcgisDoxPXarCcKuNfdexf9C
 cRngh7UpZSSGaiD5OMkIXc08tVBmQukTLfhXz1vS0pCdBLwSBfbGuZdNGJlNkTNcrudZSDxmnjG
 ZsUWRmHVHBX8cM4JMZxtNIt2PhuIvuCaFrQxP+nxsFNYy2xtGWtsyDv9CvYc8uMVE5uwyhugmmC
 PrdkYaISnb+UOpetI4tZaz6oSYb0dLmzNfT1+2ylFewUyxJA==
X-Received: by 2002:a05:6000:4023:b0:45e:6876:793b with SMTP id
 ffacd0b85a97d-45e68767abamr20098132f8f.28.1779165860777; 
 Mon, 18 May 2026 21:44:20 -0700 (PDT)
Received: from happy ([185.229.111.129]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da15a5653sm42842861f8f.35.2026.05.18.21.44.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 21:44:20 -0700 (PDT)
From: Denis Sergeev <denserg.edu@gmail.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, ajit.khaparde@broadcom.com,
 Denis Sergeev <denserg.edu@gmail.com>
Subject: [PATCH 0/2] net/bnxt/tf_core: fix ignored return of EM delete
Date: Tue, 19 May 2026 07:43:42 +0300
Message-ID: <20260519044344.9544-1-denserg.edu@gmail.com>
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

This series fixes a missing error check in the bnxt TF core EM delete
path that can lead to HW/SW state inconsistency.

The return value of tfc_em_delete_raw() in tfc_em_delete() was silently
discarded, so if the HW EM entry removal fails, the function continues
to free the corresponding SW pool entry, creating stale flow matches
or incorrect pool slot reuse.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Patches:
- net/bnxt/tf_core: fix ignored return of EM delete
- mailmap: add Denis Sergeev

Denis Sergeev (2):
  net/bnxt/tf_core: fix ignored return of EM delete
  mailmap: add Denis Sergeev

 .mailmap                             | 1 +
 drivers/net/bnxt/tf_core/v3/tfc_em.c | 5 +++++
 2 files changed, 6 insertions(+)

-- 
2.50.1

