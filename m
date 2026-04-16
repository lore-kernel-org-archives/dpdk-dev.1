Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91203F8D762
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Apr 2026 18:26:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7A1A040297;
	Thu, 16 Apr 2026 20:26:11 +0200 (CEST)
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
 by mails.dpdk.org (Postfix) with ESMTP id A1B2740272
 for <dev@dpdk.org>; Thu, 16 Apr 2026 20:26:09 +0200 (CEST)
Received: by mail-dl1-f47.google.com with SMTP id
 a92af1059eb24-12c637089ccso2910928c88.1
 for <dev@dpdk.org>; Thu, 16 Apr 2026 11:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776363969;
 x=1776968769; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y8cyaNut4+Rv9r02WmK+sJSstEHtk4cRsbohGgpqB0o=;
 b=DxNjrAqKPJdAtYkNMl63Hyx1VqTg80ELIfxgoCuAGFXieeZlBdSk3F26x54uZXhiPB
 a0OX56ExM1oKsvvzNbwjwKTbey9zYPg1VPnpXrqbSy+wBXGaRNua7fEzWQIfRWXeei3P
 A1rmIChjdx5W1QEU3ZD1KSLYJ4O+1Lal/kqzcZEeFWw3sYtumLX+Z+tsX701k5E+9cV/
 79lyNX/cx812lqP1apWP7iYSXVhaqmTAdC3RSpX73xWwATDQnNUQQluiYRS3LWCGO+6n
 7+XT8fonfvuDj4tqRvQMbbCARQiUNcmJDNhcfK+KLaQcXC+WG+BAIdA+d0tB+Cv5B1VZ
 y2QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776363969; x=1776968769;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Y8cyaNut4+Rv9r02WmK+sJSstEHtk4cRsbohGgpqB0o=;
 b=j6npfAaxOF8vd84t2BbHNWRgZXKlJ7bukszELrH2OF+6FVxnc+UeFChh4IG+8163fs
 mioVefDtbbtGEVnNw3bnEw99JFbNijSXhPiYIxsMFv3wTYJtVsLjBbofPZMMza0xYbS3
 ifqZ1S48oTxiK5f12QLM6Z/jibBYtg7Q3kLkAHYzOXw9sxC1Zv0JnXfiAR6Q+o5gxYkB
 BN5HFZs8vc6B+EiyBQXpPFfM2JFOPIJuU05sChrjlUcG5bH6bnvlMy4g15VVCOcEHJgu
 eOSXrjOS4CyvQdizGf2btVBEvLdRsf7ak/R2FnJY7t262eHoqzsajyigzOz78zVkaVLj
 cQkQ==
X-Gm-Message-State: AOJu0Yx2RN+ypoN7kHvDqS6kyxhVgM4fTIFTnwGV1Npuk4RGZ/N84swX
 RDtVccXuORZU+WXfUhp3g7Kw6Usgf4WuYbSzV26oSdFWjqpwfW7Dr5zFKw2NNBOzxfrikUcxL8n
 710W6
X-Gm-Gg: AeBDieu87rDYHevx29H4fX52FzTOVSASZ+S0dcjgcpdf1nG6acGO78n0dam7mi5zJjd
 tzy6mxixCwZEvrRnumPNckGUlW4QdtmlEmviqnsZc93FplCHMI7NiPfcyAurGU1qMIod+UdF1FZ
 1AUIXzfrdaDp+5wM2GY+oRubF41eccqHajXvl37nSfA17FayOsTbVIIQrSnRcRZHU4a54h12MJ/
 w2hTDka3zGXj3mEwr9Jk2dLoHsGq3O8Yy9jAtb3yhlzxWJbRQox6YuGI7CPcEgxLWIYnJcWwtzn
 IMBSn6MbsOxkkqlzxurjnA4CeY72LQCT516pu/K4xazfQXc6g4PGGe8s7EPjIWjItr4PD8PW6W3
 VAS8IG2DifpSMoQ3T8SH8sATDi///IkpDwFKfjOvXDh9iLYtmcOxS1W3y3FYNXo/ic2jJ2PBbaJ
 LMAJsE9OWHLG0q4tbXYU36BqCbba9KVyccgNGKHhrNMeMyGeKIpk90xw==
X-Received: by 2002:a05:7022:670f:b0:12a:94ab:e20 with SMTP id
 a92af1059eb24-12c7284c5e7mr146243c88.20.1776363968423; 
 Thu, 16 Apr 2026 11:26:08 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2de8eb8482asm8519273eec.15.2026.04.16.11.26.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 11:26:07 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 0/2] af_packet: cleanup and test
Date: Thu, 16 Apr 2026 10:57:26 -0700
Message-ID: <20260416182604.1187401-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413171836.123467-1-stephen@networkplumber.org>
References: <20260413171836.123467-1-stephen@networkplumber.org>
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

v4 - fix test to use stdatomic correctly

Stephen Hemminger (2):
  net/af_packet: fix indentation
  test: add test for af_packet

 app/test/meson.build                      |    1 +
 app/test/test_pmd_af_packet.c             | 1122 +++++++++++++++++++++
 drivers/net/af_packet/rte_eth_af_packet.c |   64 +-
 3 files changed, 1155 insertions(+), 32 deletions(-)
 create mode 100644 app/test/test_pmd_af_packet.c

-- 
2.53.0

