Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8DD1C43458
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Jul 2026 13:26:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 99B4540615;
	Mon,  6 Jul 2026 15:26:56 +0200 (CEST)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com
 [209.85.160.176])
 by mails.dpdk.org (Postfix) with ESMTP id 81446402C3
 for <dev@dpdk.org>; Mon,  6 Jul 2026 15:26:55 +0200 (CEST)
Received: by mail-qt1-f176.google.com with SMTP id
 d75a77b69052e-51c21495722so16021001cf.3
 for <dev@dpdk.org>; Mon, 06 Jul 2026 06:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1783344415; x=1783949215; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BmTmfkPdlG6It5GPicOo1/Wf/Ufstmw3VPp4CfI5wlc=;
 b=adRn37rpnrnPdYBTPgxB9f162206nbeWZxunWyz0WJVJBSMvlpcHI8/aYU+Ey+VP32
 kH5uszN5AX/LYqmqjzXEcU38n8/D0M5PWQsFEytKceLvjMl17jIIA6xOlPObczs44qUY
 99SrYaK5qrpqGcLjNqCU4ebLy5BXbqCyj5WgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783344415; x=1783949215;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BmTmfkPdlG6It5GPicOo1/Wf/Ufstmw3VPp4CfI5wlc=;
 b=sYfH3GoIlwXi7hC1WbhhVagTEjI4+Rj9w8cqQaNf/KUCVYqmBKDFzdArkfFK2aNSqd
 c5Jl81jMkNtkCd6MTfXIMkr7CYelCAo3LITpFAbFqZnWNwOTYMlgbmrYk0JhmdeSMak8
 lEqu8oJmrhMhdF/VwIaScF20zj3aqS74CG4WgoBSRcVPkYeHO7omh3OBfyhC+xr4pKDg
 HNTXBA1CdZBWyWFvOy8rIZ5aDF458sIZGIEexwhlV+XgchdN//oyajeVxoK7YnaTFVVA
 TKQSuIIKufAVCsGzZiLR0L3IfvZZ8N+z7b42nI5VK2r+zEapoDdWJoJBgyiV25DaoIcU
 6byQ==
X-Gm-Message-State: AOJu0YwU+8Od1znxNTXORXrEdX9wb+j0ENU6StgrJ89eewnJOoWK5XXS
 qUabS3KBJEy0APPbRP+OSfDFsqhU55GuyG8W7RHXlMrbWFOLgit72wITMMgmvp8fmxIq9B+dfbe
 Ibhdg
X-Gm-Gg: AfdE7clp12PL2xBjRcF8uXOs+swHZ6laFKTiV3o1sL2arvCRyOPGGjqqwrlWyXWqV9n
 VjAw0eK2cFdmv5/v9RCB/kUaewmgI+2SvTTU8/b+vdbWRzIk/4qSl2MuC3CPT/BmaO8Tr9aAMQz
 bG5/ibh5gFpa1yXGm+7nZEdwRyYCOGPW9AjMt2bA6tUtBO1aWxQR639eLMzL4kNpRWrAjfPQSJY
 q1iptzKK+3O+XwYjOJjpqFVBH+ee+4JgZvtsovI5+ofeUbLW8SK2BMkcV4bA082QZc96K1cjO5F
 66zW79CTfCgG1PcvR6bsLUBVluXUpEo5OvJh7gHLWdPTMdIDoa+y9hUgyn9ZxBZoT1fRr2FMGiK
 4devjt5ZsHHlBM81w38ndsymIJVXPU1rRdLk1M9jj4vD0c6Yq1G7p8DDlfKgQ64wqCmt2fh6/CM
 WxfEJ43pH7ZfSc2pqHayAgVCv3HiCGV0mso2BREGzK90qwsBjLmZmJFA==
X-Received: by 2002:ac8:580a:0:b0:51c:14f5:8f9c with SMTP id
 d75a77b69052e-51c747be19dmr6107571cf.27.1783344414507; 
 Mon, 06 Jul 2026 06:26:54 -0700 (PDT)
Received: from d121029.iol.unh.edu ([2606:4100:3880:1210:5d7f:246:cd51:1b62])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51c41db4fb5sm87602801cf.25.2026.07.06.06.26.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 06:26:54 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: patrickrobb1997@gmail.com,
	luca.vizzarro@arm.com
Cc: dev@dpdk.org,
	knimoji@iol.unh.edu,
	Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v2 1/2] dts: update parsing for cryptodev latency
Date: Mon,  6 Jul 2026 09:26:32 -0400
Message-ID: <20260706132633.465385-1-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.54.0
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
Reviewed-by: Patrick Robb <patrickrobb1997@gmail.com>
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
2.54.0

