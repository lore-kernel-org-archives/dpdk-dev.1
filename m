Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66078CA0EDC
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 Aug 2025 14:39:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 22161402CC;
	Wed, 20 Aug 2025 16:39:28 +0200 (CEST)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com
 [209.85.219.45]) by mails.dpdk.org (Postfix) with ESMTP id DD4FA4027D
 for <dev@dpdk.org>; Wed, 20 Aug 2025 16:39:26 +0200 (CEST)
Received: by mail-qv1-f45.google.com with SMTP id
 6a1803df08f44-70ba7aa131fso51452216d6.2
 for <dev@dpdk.org>; Wed, 20 Aug 2025 07:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1755700766; x=1756305566; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lwum5r7SJZzkwN/FolOOirk2w7pr6R4ujDo15EYmREQ=;
 b=dAsk4L8ARNxAB7kppitvKi2iSYvEP2/VVycrtMmb3e0bpYIKNCZ5BR+4zlbQ9bQQCB
 fCXXZ8sefP3xBcsB6JBpvVG73UoTJlnaqDEkCxwFodIdBzA+5kDYgAnuqBnfMqaGUu6F
 SO8c2eQWFH9BNtorqHDJNUvxe1VtVOJsI2YYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755700766; x=1756305566;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lwum5r7SJZzkwN/FolOOirk2w7pr6R4ujDo15EYmREQ=;
 b=jFB1LobQ9zFr+1GUfv+syPOwz+Vb4kHVM+0m0srnKlNUyEqv9H9JdtyEbN3reL+ixp
 MfAGVVI0TMjacb3xkgx3QmkdgfQQqNB/HN9cxjGSTEhsdtjNw6CTq9OqwMXoDOZo7Z6m
 vdACmzsyowQejvD1cqbPEL+um1C/asT1BOfx28n66rfSNW+H9+xUy7hGWiHXRbszzeRf
 bHDoIZsRxEzCrzUc94V1QAO+SxJLtRjeU4hNKViLE2SwIRpOHvvNKEo8qOf0zySWEi1o
 iYtViVdXaFinZxOl0kGlcQTanAPWwe0Ujfe2udwNrr2A2NKM2u3RduyVg4fIci4siAPg
 T3yQ==
X-Gm-Message-State: AOJu0YwXq4PjBEO3bohDD43ikTPaB/FP9kW0ywqJzS/5Ri6Xar1JzCcM
 csP7945/KWuDz4Od0LBNRMp5iVltsEqGoPDE4+29w5Y661Zukwdnye4jc7a5xyTaSpc=
X-Gm-Gg: ASbGncvk0a++LY2bOp3GaNVCXDFjuPz4FdPDli7ahrr0rnmOcALwV200cDmTiqmm76f
 RDSIGXA57S426UsPBrPpBz48T+btd6S1yHb+GBNXUmRBpdvaURD7wS0HRWImLf2pLqUdFmVpDBw
 iN6uileImqKNHTdgM/68Xxgt8kgJ3crP4bKPRPydB85a662lRNugK3LMHoKtZ5lzNHT9fIukG2A
 R+V2+OoeTsAoMWl6QG3FlilXcmZFGQcwSwyOrhiZciRiSlwFFrJC3Nz/m2dap85JXrguYIRa1/v
 es17hGUnn51tlqu0LlGSv8x08RFE/E0AhOx6d5D3AhpUNuFlj052J8JYVLyPvZ+8cJie7XdOeyo
 /XxHT7u69yhJwiA==
X-Google-Smtp-Source: AGHT+IHKazlGOsbxzkmJez49ipBlT4AHV9AJF725bqc11Yn0AcFrWrUJFovk7U6Dsa86fsr3h+mWXQ==
X-Received: by 2002:a05:6214:2467:b0:704:f952:18bb with SMTP id
 6a1803df08f44-70d771402c7mr27009456d6.46.1755700765959; 
 Wed, 20 Aug 2025 07:39:25 -0700 (PDT)
Received: from d121016.iol.unh.edu ([2606:4100:3880:1210::202])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-70bafbd35f5sm77408366d6.23.2025.08.20.07.39.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Aug 2025 07:39:24 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v3 1/2] doc: add test case docstring example to dts rst
Date: Wed, 20 Aug 2025 10:39:21 -0400
Message-ID: <20250820143922.42596-1-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250807145002.297452-1-dmarx@iol.unh.edu>
References: <20250807145002.297452-1-dmarx@iol.unh.edu>
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

Add a section to the dts rst under How to Write a Test Suite
which provides an example for how to write a test case
docstring, including a steps and verify section.

Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
---
 doc/guides/tools/dts.rst | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/doc/guides/tools/dts.rst b/doc/guides/tools/dts.rst
index 3837b398cf..31eceb6c43 100644
--- a/doc/guides/tools/dts.rst
+++ b/doc/guides/tools/dts.rst
@@ -414,6 +414,22 @@ Test Cases
    A test suite may include any number of functional and/or performance test cases.
    Each suite should focus on testing a single feature (one feature = one test suite).
 
+   Test case docstrings must include a Steps and Verify section. For example:
+
+   Example::
+
+      @func_test
+      def test_basic_link(self):
+      """Tests basic link status.
+
+      Steps:
+         * Launch testpmd.
+         * Check port info.
+
+      Verify:
+         * Port info shows link status is up.
+      """
+
 Setup and Teardown Hooks
 
    Setup and teardown methods can be defined at both the suite and test case levels.
-- 
2.50.1

