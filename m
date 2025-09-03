Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79837CA1009
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Sep 2025 11:33:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 35BBF40DDA;
	Wed,  3 Sep 2025 13:33:18 +0200 (CEST)
Received: from mail-lf1-f99.google.com (mail-lf1-f99.google.com
 [209.85.167.99]) by mails.dpdk.org (Postfix) with ESMTP id E50DB402BD
 for <dev@dpdk.org>; Wed,  3 Sep 2025 13:33:16 +0200 (CEST)
Received: by mail-lf1-f99.google.com with SMTP id
 2adb3069b0e04-55ce508d4d6so5555462e87.0
 for <dev@dpdk.org>; Wed, 03 Sep 2025 04:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=6wind.com; s=google; t=1756899196; x=1757503996; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UGBoDaSM1RJG7iewvZSuvsIdTYAY2IgiQT3h9ufIpHY=;
 b=NXULnaq0EKKGkKuyk2hQEdzaaF4gMBtdWP0GU5jty1ACAJUCd0IU4eB/l3oPC9fPh+
 oy8pYIaj8WnD6SHr34Uwu6rrhPR1zoKQOQK6/CZ+vbVhwtlgIbJfwg1EnfcjLuiamMZ8
 Wm+QRf/dZpC1dLYesSD+lpcH5Ffcylb3WeqduG0bX2gvbQy4D0BoV/yR2nGYPIIeaz2/
 RhgqxsppYCD9Q7sBF2PUoBiduOZzYl4nUvfL3rGDLiyKbPOw/k2YCuTBdL7wr935uuG0
 z/xsTxu8ffktJgK/+VCRkNluNR5sXnc6b0GgaJl2HGhoek5H/K0xIe7kUAfmYWwb2syt
 mxcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756899196; x=1757503996;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UGBoDaSM1RJG7iewvZSuvsIdTYAY2IgiQT3h9ufIpHY=;
 b=swHqYvycxzSOarl9SKo+aCSjbw9PCjuMYgVdB98uxA61qZsGvOPYmwKnwrRH3Goexz
 o5UF3QjSG5aqDayEzfEXJ6Cv04MJdEv2Pu5/5emPCs1mlC2DbogswqKM43CEn/iMzooL
 XHrfXLs0YfLKRbQ4TBAZ3BfoHeLY5FQEMreecmWEyPIxdtVgGSEtB9HDitamD3RdvebZ
 L42SZ3uxovQKNcPlcI4RQmLn3nZMG09d3s+sreUyf7ScR+Oeb9qicdm7Rp91GBFzowsa
 9j18AIM/Xnl0Z5N8kdx1KyXxHy3TrGoko8Se7siStjG/DsTesy7BnRIEmvFOwT1BKck8
 YZWw==
X-Gm-Message-State: AOJu0YyWuU3hT0T01qwlLVWBqIIqZnGIKdBm4hBr8gzLOi2UDfbJD+Dz
 1IAH5QlI4rUN2NHZd3p3Br8cjZ3Fv/rSGYcNEtS340IqOWcJJQUGSnruYaZfJLWQXBQfuiHr3dd
 mdFeNS7tJGkBDj9Hl8IwxeBFxCLHhHHGz62k95jpeKEk=
X-Gm-Gg: ASbGncuXYRKgUPOJ9434qR81pupkeUfANvjdLheYDXkLQK2GylJDHuCAUInmtne4FxR
 LuwAD/YM3YLj7n1yUNQc7hQElKSISTKU8KDkusB4zC/zycMLeksYzxyrIAniLFzkSy3r3PwfsHx
 4SlGVkPydCpD1esH0m837eWQdV/RUXtxHYO0iLZJipnOMygkiU4pxnBU4+T2ZRPMnHxDDs0+eLR
 UV1G/Kjl2QKkXgPIhpF5b+42e/uEGBGAgG8pZY1+SzVWO07Z0TNj6WTKqiUnaBKwN9N+8kcSnKv
 7G4PpYgjJhxYYXnQ/LpIMdHHQnwhktmhAs7XvsipbbClrWVDX7Urme1iF/J36/K2NO38N4C/ReL
 6q6ncka3aZnRKSUepNbM=
X-Google-Smtp-Source: AGHT+IFIb25k/ndj/0wkgDySOa9WzdavB9byXi3SIfgP62cXlt5JEYcW4uz+CfYaiJqk2klkzkEFuZTiV45E
X-Received: by 2002:a05:6512:1393:b0:55f:4506:a638 with SMTP id
 2adb3069b0e04-55f7093e990mr4349308e87.41.1756899194505; 
 Wed, 03 Sep 2025 04:33:14 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
 by smtp-relay.gmail.com with ESMTP id
 2adb3069b0e04-5608ad07774sm353446e87.51.2025.09.03.04.33.14; 
 Wed, 03 Sep 2025 04:33:14 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from localhost (vader.dev.6wind.com [10.17.1.39])
 by smtpservice.6wind.com (Postfix) with ESMTP id E967A31A92;
 Wed,  3 Sep 2025 13:33:13 +0200 (CEST)
From: Thierry Herbelot <thierry.herbelot@6wind.com>
To: dev@dpdk.org
Cc: Thierry Herbelot <thierry.herbelot@6wind.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Devendra Singh Rawat <dsinghrawat@marvell.com>,
 Alok Prasad <palok@marvell.com>, Jerin Jacob <jerinj@marvell.com>,
 Olivier Matz <olivier.matz@6wind.com>,
 Edwin Brossette <edwin.brossette@6wind.com>, stable@dpdk.org
Subject: [PATCH] net/qede: reduce the optimization level
Date: Wed,  3 Sep 2025 13:32:52 +0200
Message-Id: <20250903113252.2496087-1-thierry.herbelot@6wind.com>
X-Mailer: git-send-email 2.39.2
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

The qede PMD stopped working under Ubuntu-24.04 (using gcc-13) when
compiled with -O3 (default level for all DPDK code). A bug is opened
for this issue (see Link).

A first workaround is to just disable all optimizations (-O0), which
restores packet Rx with Qlogic NICs. However, the performance impact
is not acceptable (around 50% drop).

A better compromise is to use -O1 for the qede PMD:
- there is some perf impact,
- but the PMD is working as expected (packets are correctly received).

When compiling with both -O2 and -O3 and gcc-13, there is no packet
reception when using the qede PMD. The root cause could be missing
'volatile' keywords or missing memory barriers in the qede PMD code.

Link: https://bugs.dpdk.org/show_bug.cgi?id=1379
Signed-off-by: Thierry Herbelot <thierry.herbelot@6wind.com>
---
 drivers/net/qede/base/meson.build | 1 +
 drivers/net/qede/meson.build      | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/qede/base/meson.build b/drivers/net/qede/base/meson.build
index a6dad3ec7bcc..6c8800a3f48f 100644
--- a/drivers/net/qede/base/meson.build
+++ b/drivers/net/qede/base/meson.build
@@ -55,3 +55,4 @@ foreach flag: error_cflags
         base_cflags += flag
     endif
 endforeach
+base_cflags += '-O1'
diff --git a/drivers/net/qede/meson.build b/drivers/net/qede/meson.build
index e1b21d6ff5cd..3c2a5205732a 100644
--- a/drivers/net/qede/meson.build
+++ b/drivers/net/qede/meson.build
@@ -22,3 +22,4 @@ sources = files(
 if cc.has_argument('-Wno-format-nonliteral')
     cflags += '-Wno-format-nonliteral'
 endif
+cflags += '-O1'
-- 
2.39.2

