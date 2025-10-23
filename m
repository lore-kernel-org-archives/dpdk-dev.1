Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40BFACCD193
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Oct 2025 19:42:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6045440151;
	Thu, 23 Oct 2025 21:42:41 +0200 (CEST)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com
 [209.85.210.179])
 by mails.dpdk.org (Postfix) with ESMTP id 4A16E40144
 for <dev@dpdk.org>; Thu, 23 Oct 2025 21:42:40 +0200 (CEST)
Received: by mail-pf1-f179.google.com with SMTP id
 d2e1a72fcca58-78af3fe5b17so957487b3a.2
 for <dev@dpdk.org>; Thu, 23 Oct 2025 12:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761248559;
 x=1761853359; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ifg4961S73qcR1ysYZ4lzy0J2gSldDnQLadsz9dggHw=;
 b=ro2ZD8Im4GOp8JZWb07IgKswkLFcHpX4/9IOR3MwFV3uSeWs/aToA779N8ucpFP+s9
 cBQP5H1PDV2VOexMGYDdHMT6+onyFnN2qdhsiJUoqVUTDTB4pnJ/0/ZWv42Wfq1rdGGL
 yT1O06MiuzKfKccFoOd/h7U33reuUgto11MsLSte2uUo2cS0cCrtl9TCelUdgSvoFASw
 cVR+gladKiwcKS0F0EoRD3Nq/ZvIbx1PaEwEd8k/pLAhquhpG/OwhdmVz67gzxW/x1m2
 ClRrsu4KyOH71OUro9Y0rtea5pwtaOxyrOsI6UYmoUqv3sJY7TNHKdxyroHrfA3Y4bNU
 rsew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761248559; x=1761853359;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ifg4961S73qcR1ysYZ4lzy0J2gSldDnQLadsz9dggHw=;
 b=VmF6/0zQ2sZpVfUwf6vQVapp7Qso9aaH3mgAUmog4AbR2zOOLRbw/gTQqX67NCYi9C
 ZrnBqkTKCffzqJa7ZchmD5NpEOS0C4qkSLgVe2q3iVpyOMkPQVM9XyDYUGdqtms/ssD1
 1aEC8ZuZXtzk7RTOUuzqy2w1wiEczrE4vWixr/PsiS889c4MTz+jUkpjbypkwGwLcts7
 Kgaht6QxiquRa1CnawfLL59D1mJv9z3HsLc048D1GikcT9UnKp5t17CDZRV+0YKueBjN
 oyy74FXqc8vw4BurrDbX0Nv622xrPu35lp/BQGDoN5X2qSI7bE60mYT4ARzqmGer3psk
 e38w==
X-Gm-Message-State: AOJu0YyobXv9JmLFA4vVL1fDyIIc9bOXMJo/zN87E1vEmua8DE52k7BV
 Et6WEo46gHhhEBZxo2K9ac7kL8il+OWZ3QyV1/SoyX9DUNy0zeC8HBA0eLW8omM3ayVUaKOSwg3
 S+rPO
X-Gm-Gg: ASbGncuG0NA9Dmqpv5DtbiLhzB7BKBKpjqtpqtfVROVAVYAoyCGz41gm+zzje1xRXbX
 N5iZviXNjohavmVq1G2ZPI2gYqs0GlXmmQOx9rO/Y3fZR3biZTvCAtz/P+1O7HKnTzkC562fFbf
 Vca6M0izGoPYH46WWKG+eDpi5iRYAKFEkhNNXDVCeho40H+vJGHCZ8sDirRQfVW2aAFa/4Yjfno
 TAWXCWCYnaAuBqTFiOVJRLGfGWN6io9uEVf08eaXpXpmBnHaSO3kttpCSOSAr3+LfJ90vpW5+nW
 8rsmWCzA2vs5x66LDgwDgBeYEaMb6GymFjGEgEyqP7smi/E4CF6KMT4r0x+dJXlv1Dt+VqzKBKp
 OvZrC7+6Fydew+ZDeRjQ00VWdVADCUC6VbC0cA0meTfUwTesK1UIMGlziespqkpsu47mjTgtdnU
 lD1fC8zhwKH8awYdXoV2mwcxeiW1iqO4FUNsqT334=
X-Google-Smtp-Source: AGHT+IEZOaqDm8humUsxqRgnXPDcJDr3QDg9rNFqGlaipaW6dpH/2lBGhrpnLGWHtvpJDjM0LUxy+A==
X-Received: by 2002:a05:6a20:3c8e:b0:33d:7c46:c4ec with SMTP id
 adf61e73a8af0-33d7c46c5b1mr1004196637.41.1761248559164; 
 Thu, 23 Oct 2025 12:42:39 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b6cf4e15a80sm2884768a12.22.2025.10.23.12.42.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 12:42:38 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC 0/3] common/cnxk: remove dependence on VLA
Date: Thu, 23 Oct 2025 12:41:30 -0700
Message-ID: <20251023194237.197681-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

While looking at LTO compile failures, it looks like the cnxk common
code can be modified to not use VLA's. This fixes one of the compile
problems there.

Compile tested only!

Stephen Hemminger (3):
  common/cnxk: replace variable length state array
  common/cnxk: replace variable length array
  common/cnxk: re-enable vla warnings

 drivers/common/cnxk/meson.build    | 2 --
 drivers/common/cnxk/roc_aes.c      | 3 ++-
 drivers/common/cnxk/roc_platform.c | 4 ++--
 3 files changed, 4 insertions(+), 5 deletions(-)

-- 
2.51.0

