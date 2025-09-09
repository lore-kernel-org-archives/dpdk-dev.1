Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F73CA0FED
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Sep 2025 05:40:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C4E6A402E3;
	Tue,  9 Sep 2025 07:40:44 +0200 (CEST)
Received: from mail-wr1-f99.google.com (mail-wr1-f99.google.com
 [209.85.221.99]) by mails.dpdk.org (Postfix) with ESMTP id A2CBB40281
 for <dev@dpdk.org>; Tue,  9 Sep 2025 07:40:43 +0200 (CEST)
Received: by mail-wr1-f99.google.com with SMTP id
 ffacd0b85a97d-3db9641b725so5200356f8f.2
 for <dev@dpdk.org>; Mon, 08 Sep 2025 22:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=6wind.com; s=google; t=1757396443; x=1758001243; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NffGaMhctxwTPIL5NrfCLuUKojiSlqIIN5b0gio+XIs=;
 b=YZLplcLbEFxu8AIrX8YF0GnhZTooEwqjBqLLwWjiS8vR2Xtxgq55AqC+UxnxOHHHYQ
 Uzm+PT8jgioxc3cX6rPn5knScmGBMMnCsq7eGb2GL9ch04yz1kiGWj2CEi7rBWWXLJPU
 /3fq8yRzyjU7id+lrcRg44g3BL9DF0Di2Q2SrHk3i+oLShdYj3Kya9elHarmzWo7GJHw
 fL2oSMzSmfWfmWBNu8L4SaM97l5voIrA6K+fi9yYyqxKzaTRVLeZLvBsO16rIpyYbzKA
 LKO/kTPg7sjxKR4lTJOWjtLGeFKhuPTM1MZ2JGOjSuRTaaLje91h+sZrGaRDJEK/seVA
 TWRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757396443; x=1758001243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NffGaMhctxwTPIL5NrfCLuUKojiSlqIIN5b0gio+XIs=;
 b=R4yFFY4A+kwnDSvHa5Sd5yDc8jKWQA95DEScA2iLGJVrWHjGSj/1qn4tpt0ywXEEOQ
 pZT1+ElPEHo1p0w5Id9/nP0i+EP+3ijtkR6we5Wx95XPFlybi46a+LQWh4Le79MtTO10
 ABjbYHnNv+fHOlSroyq5G5x62KO0ZtVneV0t7z/usiaC5rCxtScR6wSW7orPC7akDg7C
 oQmi9apU9F38oma15ptsuPO2ok4IQJQtX5Gv3mNzE2bxZMpqkZMzrZzImP8gXVJBwSiE
 9zvmrurrBUNeimHimFq8s/0zqXp0D2M7J3Q7Mv8hggNnDWD7+rxHKZUrrpiwZ/4sREBk
 Nn7g==
X-Gm-Message-State: AOJu0YxH5tXM4d1BUV3jN528joob2+MtwwD/KIVfrj8QQF9DjtZd3RdX
 GKpUzSVj/ZX8Ngdnp99LBdHDlmJBShz8jYBwbSpca1j+0hnNdUSUhOfGdtKLIb98OWgaFxIsdfD
 lMrN2q9RI+6+fJNS1aaPyziFU+o3/N8Ak9X4nvd2s7p0=
X-Gm-Gg: ASbGncth6PWWfKSNAN83MmMfd1gZNpb9jo7mcBMQq1AZw+mHJpxkJnPLcsUgcUEP39b
 Cb+lndrqS30bZSLezVZ/LmiJ4Y1XI5O2Ka7J8e2j8wbYFOqZnCc9oo1a+R/Iz4qEFR/wWtF9h32
 NV6nORs5bmqy1m43r9VLDofmD0y2FOP6PbcPabtU0hSNCBrzDq2omH1gnKxktw4U5/CSFgCY+KZ
 IoHYXWzfP5A/NEPkSTGH94+DoWiZ3Dt9YTFiwOCxYaan3QCA5DV+xxU14oULfp9Z3tWcMoXVGcV
 n0/3ZL5+5+Wo/e4AYx2DXE+R+BHQxJ3W8zQIudB6qwTYL2wRGh76W1BLfd/BB+tY2lvUAVUveCN
 Uzr1kKVemriIRN4bROGk=
X-Google-Smtp-Source: AGHT+IG8WLtV19hu64/MAiD25RGxdhC+dMtlqji042EWXHLW4IFviXZDLXq/5gCH8X6X4zx6S4eDV3ytPDKL
X-Received: by 2002:a05:6000:2288:b0:3cd:ef83:a9a1 with SMTP id
 ffacd0b85a97d-3e63736f5e1mr8500171f8f.20.1757396443004; 
 Mon, 08 Sep 2025 22:40:43 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
 by smtp-relay.gmail.com with ESMTP id
 ffacd0b85a97d-3e752224ce3sm279940f8f.36.2025.09.08.22.40.42; 
 Mon, 08 Sep 2025 22:40:42 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from localhost (vader.dev.6wind.com [10.17.1.39])
 by smtpservice.6wind.com (Postfix) with ESMTP id B062B34A98;
 Tue,  9 Sep 2025 07:40:42 +0200 (CEST)
From: Thierry Herbelot <thierry.herbelot@6wind.com>
To: dev@dpdk.org
Cc: Thierry Herbelot <thierry.herbelot@6wind.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Devendra Singh Rawat <dsinghrawat@marvell.com>,
 Alok Prasad <palok@marvell.com>, Jerin Jacob <jerinj@marvell.com>,
 Olivier Matz <olivier.matz@6wind.com>,
 Edwin Brossette <edwin.brossette@6wind.com>, stable@dpdk.org
Subject: [V3] net/qede: reduce the optimization level for gcc > 11
Date: Tue,  9 Sep 2025 07:40:23 +0200
Message-Id: <20250909054023.3263401-1-thierry.herbelot@6wind.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250908070414.1297844-1-thierry.herbelot@6wind.com>
References: <20250908070414.1297844-1-thierry.herbelot@6wind.com>
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
for this issue (see Link). The same issue is also seen with gcc-12
and gcc-14. The issue is not seen with clang-20.

A first workaround is to just disable all optimizations (-O0), which
restores packet Rx with Qlogic NICs. However, the performance impact
is not acceptable (around 50% drop).

A better compromise is to use -O1 for the qede PMD:
- there is some perf impact,
- but the PMD is working as expected (packets are correctly received).

When compiling with both -O2 and -O3 and gcc > 11, there is no packet
reception when using the qede PMD. The root cause could be missing
'volatile' keywords or missing memory barriers in the qede PMD code.

Link: https://bugs.dpdk.org/show_bug.cgi?id=1379
Signed-off-by: Thierry Herbelot <thierry.herbelot@6wind.com>
---
V2: be more precise when dropping optimization level (only for gcc > 11)
V3: even more precise: the issue appears with gcc-12
---
 drivers/net/qede/base/meson.build | 4 ++++
 drivers/net/qede/meson.build      | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/qede/base/meson.build b/drivers/net/qede/base/meson.build
index a6dad3ec7bcc..acab6e8ac938 100644
--- a/drivers/net/qede/base/meson.build
+++ b/drivers/net/qede/base/meson.build
@@ -55,3 +55,7 @@ foreach flag: error_cflags
         base_cflags += flag
     endif
 endforeach
+# no packet Rx with gcc > 11 with compiling with default -O3 or -O2
+if (cc.get_id() == 'gcc' and cc.version().version_compare('>=12.0'))
+    base_cflags += '-O1'
+endif
diff --git a/drivers/net/qede/meson.build b/drivers/net/qede/meson.build
index e1b21d6ff5cd..86c3503a82f6 100644
--- a/drivers/net/qede/meson.build
+++ b/drivers/net/qede/meson.build
@@ -22,3 +22,7 @@ sources = files(
 if cc.has_argument('-Wno-format-nonliteral')
     cflags += '-Wno-format-nonliteral'
 endif
+# no packet Rx with gcc > 11 with compiling with default -O3 or -O2
+if (cc.get_id() == 'gcc' and cc.version().version_compare('>=12.0'))
+    cflags += '-O1'
+endif
-- 
2.39.2

