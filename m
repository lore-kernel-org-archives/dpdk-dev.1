Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0959BFD4F04
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 16:14:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 38B7140E1B;
	Tue, 10 Mar 2026 17:14:07 +0100 (CET)
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com
 [209.85.210.42]) by mails.dpdk.org (Postfix) with ESMTP id 1B37F40DD8
 for <dev@dpdk.org>; Tue, 10 Mar 2026 17:14:05 +0100 (CET)
Received: by mail-ot1-f42.google.com with SMTP id
 46e09a7af769-7d756f2a06dso32324a34.1
 for <dev@dpdk.org>; Tue, 10 Mar 2026 09:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773159244;
 x=1773764044; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RwwYkZLERL/NvPhVkvbEFYQtg6xiIbmLV+xoN1tKQ0s=;
 b=P6dVDsiYjP56zeLyims3b1rlxPbjHyd0wyuEIZbdPU6I0iS9828V2Pe0AKcyZ+SxH4
 tZ8Z76ndbh6T8ral1tOzM9AMJ3F2QfLWMcKF7vAjp7b/fvp38EP7kw3IePfaVVOjXYco
 KwqwkRw0cU8IzTGKYW10+jNq717BxD4Mxben1v8fnQlbJpKMuU8T88+joea92sHrwZM/
 L93fF0lNIWFn6kaMFmwWuhzIq6Z4ROdxf8+ym1iXpAISK954ko3zRmnD/K/B785eFqD3
 GDGT/0K9t1zCToFdXtVEO1TOh5Hatlb09nukbxSupZCtTVH8XXVOuEOVvgxNgWs3NYoI
 +grg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773159244; x=1773764044;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RwwYkZLERL/NvPhVkvbEFYQtg6xiIbmLV+xoN1tKQ0s=;
 b=Q+H7OIJsl66RNb5izmfwid50zxTTxAdY4grWD8oCZ1xLZNrlpHAO3aNUM4joAJ/XQf
 BNb6HX+GAyoxjelCLF5oCO5fP+p19ZUPyWicYoQFpi2/j5UZlXL1d/X7vIkfsM1gJ/sH
 EwGCEjFFziRhpEAtEAHkFTSEG1dyW6bl6lEe9XmaTy77NkwD8YHuJlb+Trh0CDHef5CD
 B39VjdhloHOA3hOm1ISRjpvgXGCUgBQ1uTVDIAVLgnBRuBJxQtlnoWEWQmmhE6p+8deN
 mP0vsrzi3qxA7SRedxGRSnZdAkJcWxOaCk/Aszm67Vxze8YRtxfNlSkp/nGbx7PblOrT
 VAFQ==
X-Gm-Message-State: AOJu0YzZ62xgoYCzb3hjTB3iFUmQEUVHw4uoEwW/uqoOxDBALVTGHTXW
 LLJ80hThiNkJlIh7mYdT9DStpM28/g11z/oQ+oTuHaGt8yY9wBaStzkRhDF7avMyyEHzaMH0Ftz
 1juV91nc=
X-Gm-Gg: ATEYQzwC6iuuloqB+yJFVu6CG5VRDSqo0WkGOAiD7/BRBuZ1wteBFYFwX8zSaDPDHOc
 87NUfwnHe9CTLlxHghct+6nB03gKwZSi8nOxa5Z7ApFpVUrTawwDhfVPKF8MlG4K/ra7m+5hCyZ
 NFa3Mm7LgEtWfZC4uCNOBH2frreV1O+FjeLt7S1APz/4dek3f1Maj/e90RRf5V75ddUhPlLQu0W
 Xoq/MEl8pDLLuTre1Nr/sswkb/Y0eIOcLKEQyU3KIDlm9fkgp4eTSnX1VLXQT3PxX1qgnOikTBt
 Xwv00iSmefexFmahg82bMRX7Ne7OKWVSRRuavnaO/Me4d56YTq51Gf2SO65wewmCYHEC7TVbWX9
 3xD4FMHLOrFex34MeG03hF6eGPCUF38BCrBVMJEAP4OugxPvWI51Som/rDcWiQuqy2JPUvXtNWL
 K8Vs6vEmikgUgu+Xanldc/0v1yH4UaqYZz
X-Received: by 2002:a05:6830:6f8c:b0:7d4:c276:7484 with SMTP id
 46e09a7af769-7d759a6dec6mr2479622a34.7.1773159244366; 
 Tue, 10 Mar 2026 09:14:04 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d738e3f421sm7304004a34.25.2026.03.10.09.14.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 09:14:04 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v20 03/25] doc: update features for PCAP PMD
Date: Tue, 10 Mar 2026 09:09:41 -0700
Message-ID: <20260310161356.194553-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260310161356.194553-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260310161356.194553-1-stephen@networkplumber.org>
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

The PCAP PMD supports more features that were not flagged
in the feature matrix.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/nics/features/pcap.ini | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/doc/guides/nics/features/pcap.ini b/doc/guides/nics/features/pcap.ini
index 7fd22b190e..c4f0360a06 100644
--- a/doc/guides/nics/features/pcap.ini
+++ b/doc/guides/nics/features/pcap.ini
@@ -4,8 +4,15 @@
 ; Refer to default.ini for the full list of available PMD features.
 ;
 [Features]
+Link status          = Y
+Queue start/stop     = Y
+Timestamp offload    = Y
 Basic stats          = Y
+Stats per queue      = Y
 Multiprocess aware   = Y
+FreeBSD              = Y
+Linux                = Y
+Windows              = Y
 ARMv7                = Y
 ARMv8                = Y
 Power8               = Y
-- 
2.51.0

