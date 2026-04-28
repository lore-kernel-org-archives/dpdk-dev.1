Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C424DFF886D
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Apr 2026 18:26:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C8E6740655;
	Tue, 28 Apr 2026 20:26:25 +0200 (CEST)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com
 [209.85.219.48]) by mails.dpdk.org (Postfix) with ESMTP id 9DD484064C
 for <dev@dpdk.org>; Tue, 28 Apr 2026 20:26:23 +0200 (CEST)
Received: by mail-qv1-f48.google.com with SMTP id
 6a1803df08f44-8a3b0242631so147660606d6.3
 for <dev@dpdk.org>; Tue, 28 Apr 2026 11:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1777400782; x=1778005582; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UF05fh73GEMOghZR4YxeVg1nEvSPEKXKjcZZKyfCwkw=;
 b=JnwbUiFseD0d51lypGlKzS/g5Xl09Tl7Wd3qAj5GVBN6iSr+wHhqVoRv9jvH6jcGuB
 zp5DXpdEUm8FdzQXaH7MFIRt03Ny+mpCbyGPdM1XmtRxPLmEo2oUfSbR+bHvGzJlQkRO
 7078dAcgiH1I3A4K6BAsyGteNWtcAhk1mZZrk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777400782; x=1778005582;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UF05fh73GEMOghZR4YxeVg1nEvSPEKXKjcZZKyfCwkw=;
 b=OJnD4VOtvZtpoCtgDCnF8mG81vGkXPQSZtRzf8llxEAgDs/BlG4KByAlHjyDJoBQT8
 3hQEVOYoaObbYnfXlvwujZTktC441EgOQf8/SDKV6DmmReZP8cVB7eRTC3GfbLMPegbN
 v3kPuagHe8/qmgllu6cLeRfSdSKETy2e5japTjBL1AGxOUtUMZ/7dwVFVBFVRDZCGNLB
 zBdikuPXEV2qLnScVtYRhn/9ItTlvEC1P8mcieRHfWjXR3auz/jBwWeiyfhKjE3PWO19
 ZCPv7v5VoPGGPUk2DvaWHL3zlAZPyAU+T4BibppwMINV6siaKnlaQJ77kphH2TcALYJp
 b22A==
X-Gm-Message-State: AOJu0YwTkx7UHDXObnITc3ikT81yx17ZqvFePdak9JSSXkfu/JaRvWZV
 g69TEVYVArzNOsUkOrdwNqav5yKUMOK5ilg/ggs5F81kRt7GEh2WAdpSUSlUbz+94jiDFTJ/OxD
 /hf8K3QZDQu5Oi3VaB13P7FW7wVxOWruSrnDQ2mB6dkU1/LPmhOCz5rXjaRCWX119WQK3E3gNDq
 MFvoRFiOL55wvp7qL01v6KbZ5R1KI=
X-Gm-Gg: AeBDievqtgdG/WmAsSn5wamSCfNIx0ordVPa5MfleY8Zcc18WJlTiHfXeC8f42JvaWH
 Hoq6QPUSfqOyJTm7mkPWTA8u2/PBIM9NwTtQth1Uym0Ljxzzj6oRiPZam53BZ8M++ug2m4Y38gh
 vWSERjvJW1GvqomftzCrjLqKqghZvBbHJ/n90/k5JmaV6FOW9huxDF9ldKpi2cFf8jN2mwK6HbE
 /l9FQMxzSYRm81wqDx+xuCb/lyzt/xAl0l8tFkUG9LPEia9gsOrx7h12lc0BEGQr+vd4ZQ+L5QT
 FqhOXvassta/mR9iVODwxqdstZTFotaAeSHE3T48jNEjYojslPSK2fYclmaeqTohz8KC1LtF37u
 Chu7MIRVifKpPOcT/kdcbGO6sPoFOzlaiPaXc2987C1vzzyQdyHkmMz3BaXKs0JAmZR5BnL4/4Z
 JhUjMbPtq0ggIytu65xZhP1pMElS5Yc4VgkCiKG8BS1NbsG05DoNz8Vv0Z/Aj9HmckNz0VdiIie
 N0=
X-Received: by 2002:a05:6214:3104:b0:8ac:b63e:72f8 with SMTP id
 6a1803df08f44-8b3e31d6f52mr64477296d6.24.1777400782378; 
 Tue, 28 Apr 2026 11:26:22 -0700 (PDT)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b3ee9e75a5sm603946d6.20.2026.04.28.11.26.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 11:26:21 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: dev@dpdk.org,
	luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: lylavoie@iol.unh.edu, ahassick@iol.unh.edu, knimoji@iol.unh.edu,
 dmarx@iol.unh.edu, Andrew Bailey <abailey@iol.unh.edu>
Subject: [RFC PATCH 1/2] dts: update parsing for cryptodev latency
Date: Tue, 28 Apr 2026 14:15:00 -0400
Message-ID: <20260428181501.72434-1-abailey@iol.unh.edu>
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

Previously, the parsing for cryptodev latency output would fail to parse
due to an incorrect regex. This commit updates this regex to properly
capture the burst size attribute for latency results.

Bugzilla ID: 1938
Fixes: 8ee2df9da125 ("dts: add cryptodev package")

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
---
 dts/api/cryptodev/types.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dts/api/cryptodev/types.py b/dts/api/cryptodev/types.py
index df73a86fa4..0942d08371 100644
--- a/dts/api/cryptodev/types.py
+++ b/dts/api/cryptodev/types.py
@@ -69,7 +69,7 @@ class LatencyResults(CryptodevResults):
     )
     #: burst size ran with app
     burst_size: int = field(
-        metadata=TextParser.find_int(rf"Burst(?:.*\n\s+\d+\s+){2}?(?: size:\s+)?(\d+)"),
+        metadata=TextParser.find_int(r"Burst size:\s+(\d+)"),
     )
     #: total operations ran
     total_ops: int = field(metadata=TextParser.find_int(r"total operations:\s+(\d+)"))
-- 
2.50.1

