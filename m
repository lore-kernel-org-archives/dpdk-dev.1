Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F171ACD4F24
	for <dpdk-dev@archiver.kernel.org>; Wed, 13 May 2026 15:27:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B2E5C402B6;
	Wed, 13 May 2026 17:27:33 +0200 (CEST)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com
 [209.85.222.177])
 by mails.dpdk.org (Postfix) with ESMTP id 7A0D440041
 for <dev@dpdk.org>; Wed, 13 May 2026 17:27:32 +0200 (CEST)
Received: by mail-qk1-f177.google.com with SMTP id
 af79cd13be357-91066394ef8so24082985a.1
 for <dev@dpdk.org>; Wed, 13 May 2026 08:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1778686052; x=1779290852; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a0DVWl8UBtkWu+St0t4TyhhX+ylaJJQCkIWcoPBfbI0=;
 b=N+BaWrZH9KQk06dVAOxPnwV52dOyd2MGOc7GIP084KY9tLB/Z9mOkHKuhfBRCWzE2O
 nqqLjxUUYCyeHNjvxMO4lh+wpdQdy5+pT1Or+3edsKed5kvdaZ/te2Qoaa10LoQsP2bw
 w2wOTTSkyK7tGVSqnWARwUHs93lW2RpUopDUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778686052; x=1779290852;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=a0DVWl8UBtkWu+St0t4TyhhX+ylaJJQCkIWcoPBfbI0=;
 b=OUHr0Skjcq0EHLxDcaVGHa1QpFVtVgkbh7Evq6Zs5G5VbitXRHQrTS2w8iikyhSYjS
 hG0zJtBBX7dwKW/A1LUeyT5So2u+zqLlIJtbDSZpQj1VxH4I9fCVR92L7CiHrCu8MKrL
 EX6pHDv7MuzzJ4pMeq4He+z/N99V6qYYVs+8j/TjlWB5JsWPc9hWbPei2Ljszzu1R5zh
 o/WRMlox9I4l4gDrrCVPW4JwNh6VE1QkEvD46yrohVmDn+uthiMik1xcfHSx3KPJCEJp
 NxZiMBcjcvHsBCKf4sTN8fsg2uzuMHXHE9f3yuA1rYdLlcLw75X6Xt+H+Wi6N9SoNfYb
 x77A==
X-Gm-Message-State: AOJu0YzWfVHdXUmzVCyrZfS9JagrXAcQRY6XNHL9zQYrwUA4Yq4Fb/E5
 B96e+hXTaXeaO8H+x9piusXbhXsik8I/RDX09n0PBBpmnV02qJE0CBchG4SzI3MeF/g=
X-Gm-Gg: Acq92OFk3ZsV9AN12FA93sO+QYPPXwhmFurSESwLncxCRQA6KPa4Nf730NPLN067y4t
 TQMSiNtpQ8Dn7CAkKcnH3zWDPtvyhIlrdUmDWcDAJ8mu38IXUtzL8HG5w7nrk/R0ctNAPyyo6CY
 vsHkynUieV68vAcqJtoZC717egm7JE/kUvbZx0gryf7TW8R/tDvKb7sTcHJiJptLZF5BNnyb4KV
 8YvehN5SmW4LK5NNeX3CqXvvn/WdtnUTNQBZABoj3MO/MSj+arxiQD5B1bKcD19eWC3+lFbcju4
 gIF04gb4fcmD0zQlrzHaSO5QoMT1bMjiGjgv8oSH7/vV2Q0QUenTS/BQtRWY1/fN0fFVr4YeGds
 ZORxjKN8ldlRL3MsaleG1TAW/qyPtiIh54IKGeZnyIq7PSnCFb36y/Iphvzr9NPDfbrpVBU1Q/l
 udNPvLonqzzTC7wusEbVfbAEIjxstxO3rOkJ/m2+j8UGokyYe0lmH6AEvv6c4slJC0
X-Received: by 2002:a05:620a:4620:b0:8cf:d6f8:599f with SMTP id
 af79cd13be357-90f8b2d97f0mr554192385a.57.1778686051724; 
 Wed, 13 May 2026 08:27:31 -0700 (PDT)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-907b977274csm1645468585a.6.2026.05.13.08.27.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 08:27:31 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: dev@dpdk.org, lylavoie@iol.unh.edu, ahassick@iol.unh.edu,
 knimoji@iol.unh.edu, Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v1 1/2] dts: update parsing for cryptodev latency
Date: Wed, 13 May 2026 11:27:14 -0400
Message-ID: <20260513152715.133381-1-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260428181501.72434-1-abailey@iol.unh.edu>
References: <20260428181501.72434-1-abailey@iol.unh.edu>
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
 dts/api/cryptodev/__init__.py | 3 +--
 dts/api/cryptodev/types.py    | 4 ++--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/dts/api/cryptodev/__init__.py b/dts/api/cryptodev/__init__.py
index a4fafc3713..15cffcb409 100644
--- a/dts/api/cryptodev/__init__.py
+++ b/dts/api/cryptodev/__init__.py
@@ -117,7 +117,6 @@ def run_app(self, num_vfs: int = 1) -> list[CryptodevResults]:
                     f"dependencies missing for virtual device {self._app_params['vdevs'][0].name}"
                 )
             raise e
-
         regex = r"^\s+\d+.*$"
         parser_options = re.MULTILINE
         parser: type[CryptodevResults]
@@ -126,7 +125,7 @@ def run_app(self, num_vfs: int = 1) -> list[CryptodevResults]:
             case TestType.throughput:
                 parser = ThroughputResults
             case TestType.latency:
-                regex = r"total operations:.*time[^\n]*"
+                regex = r"total operations:.*?time[^\n]*"
                 parser_options |= re.DOTALL
                 parser = LatencyResults
             case TestType.pmd_cyclecount:
diff --git a/dts/api/cryptodev/types.py b/dts/api/cryptodev/types.py
index df73a86fa4..7b4fd17cb6 100644
--- a/dts/api/cryptodev/types.py
+++ b/dts/api/cryptodev/types.py
@@ -65,11 +65,11 @@ class LatencyResults(CryptodevResults):
 
     #: buffer size ran with app
     buffer_size: int = field(
-        metadata=TextParser.find_int(r"Buf(?:.*\n\s+\d+\s+)?(?:fer size:\s+)?(\d+)"),
+        metadata=TextParser.find_int(r"Buffer size:\s+(\d+)"),
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

