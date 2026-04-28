Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61745FF886F
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Apr 2026 14:14:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 74449402A3;
	Tue, 28 Apr 2026 16:14:55 +0200 (CEST)
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
 by mails.dpdk.org (Postfix) with ESMTP id 9527C4003C
 for <dev@dpdk.org>; Tue, 28 Apr 2026 16:14:54 +0200 (CEST)
Received: by mail-dl1-f53.google.com with SMTP id
 a92af1059eb24-12dca45ca21so4781293c88.1
 for <dev@dpdk.org>; Tue, 28 Apr 2026 07:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1777385693;
 x=1777990493; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sE/SFX1oSUrw0Gr2/iPSN7fa6f6LL+fskvf82JytYrU=;
 b=Y9omeN7Lxr8c5fibqo6lyV02aDpc/pvTn9w1dPNtM5ItPwtq9FdZCvOD9qmUwFoSMc
 Jv6VA1UbasI2Q0akf/dYRo31ktoAE6brqZyH/ogfjBTUcVxpMK16iccovPYeG/0bmECG
 3oOMihCKtRc6dutEgmPWbmMguaW9PrHPC/1IPXs0buP8gd2OTHdNbfCyn651KJ+5YZJ1
 OnZt2sHrfH6C9+U/4PR3KwzgpW8ky2fC17y5kEjJUsYOooWlCnGP/cj83I2GoJjVFkPE
 lr9swBWXhu2LQm07uAhczlksMwlc7sCdCCk46XSALKsDxyok06hUe7oL0khM89Z+qWeK
 AB7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777385693; x=1777990493;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sE/SFX1oSUrw0Gr2/iPSN7fa6f6LL+fskvf82JytYrU=;
 b=LDe39/M1msgvavw2TlDzqKdus06e3BZNtJj+6wRF5EaWKrNuOYIplGmaSAAX4MiJJv
 nCh7gIagIgMSBg4JRQQkKf7XPVLYKTI9AmB6GRkH0qTotJgOryP6sqdIfHwjh7RGbMVG
 Ep9gaLmDhbkVmjgKp0rbu3AJUB95QD8tRlDigjSIFqKxHUnNl+ZslXEhlyv6jX6Bb61N
 auGlY47iG/fT3PRt/wto1JnfH7/USOEho4Yedc036K7tMRn7eXN8vcWztC2kYkvmXCQD
 ft9QzzgYK9QVpNKHdYfL9wAG7PPQ1nvg28T4oAkrDacsfueENsjIhqqRrVo0DeAW9CZC
 QRSA==
X-Gm-Message-State: AOJu0Yw4NUSsYhFIGnmFnGg/EVP/DhxaR3YPVeOVsSpXwHhMhmo9jklR
 BNBRVGOWYlmd6uLgnC7lWRF7nvH4rnlLyQIrbADwmv8GgJuMRFk8xz2pr8L8kC1FUvaKyPe46P3
 64s0T
X-Gm-Gg: AeBDieteHLn6WWMYx/VDhR02Qn0l1L+U/eHIP9h24oK90lspVf3jwllE5jrSQW2JPta
 BVigsx5lQySp0WQH/TUUG/NYEpYHaE4HUihWBBRuK06HcVEpeGEl1LllgrKMBYtKzAiHiCHtKc4
 /BWsIqvab/Fi+TFYZnlESvGzdNu77WCndbvoUnnKzVEheQ56G6rw68mLSJ6vagTe/lTen4RruOL
 Ib4pSvFbyTBqmrjik5gnq6SkaPWUO3Zcnx4UwwuDdKQO/v9yA7hUCnU61ybpKutEUxn9/YRcMEU
 t74WM3L57EBIlbmlRztvmlpCTUtfzhvL2E9k/6DlQpfBXiaE2c7OMsTmNSUaM0v9FtyqO39KeYJ
 MzE2Hw+12KJfd0SI+FGOrY89Z2Ieh4203cHE2wEGs9oQpITt/vk3t68eKjNrw3AYhmyskmJfBgZ
 lEQAMPKzffg7VgRYXnIf+kmrBWQxJDEOSBn7Sf7sME+Wo=
X-Received: by 2002:a05:7022:698c:b0:12a:6fb7:8801 with SMTP id
 a92af1059eb24-12ddd99a48amr1548605c88.14.1777385693363; 
 Tue, 28 Apr 2026 07:14:53 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12ddd9a60f3sm2886093c88.10.2026.04.28.07.14.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 07:14:52 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 0/2] af_packet: cleanup and add test
Date: Tue, 28 Apr 2026 07:13:17 -0700
Message-ID: <20260428141450.202091-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413230018.515837-1-stephen@networkplumber.org>
References: <20260413230018.515837-1-stephen@networkplumber.org>
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

A couple of small patches for the af_packet PMD.
Fix indentation and add a basic test.

Stephen Hemminger (2):
  net/af_packet: fix indentation
  test: add test for af_packet

v5 - end test after 10 packets or timeout

v4 - fix test to use stdatomic correctly

Stephen Hemminger (2):
  net/af_packet: fix indentation
  test: add test for af_packet

 app/test/meson.build                      |    1 +
 app/test/test_pmd_af_packet.c             | 1123 +++++++++++++++++++++
 drivers/net/af_packet/rte_eth_af_packet.c |   64 +-
 3 files changed, 1156 insertions(+), 32 deletions(-)
 create mode 100644 app/test/test_pmd_af_packet.c

-- 
2.53.0

