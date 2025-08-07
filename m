Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C9FC87FDA
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 Aug 2025 14:50:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F1AC64027C;
	Thu,  7 Aug 2025 16:50:06 +0200 (CEST)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com
 [209.85.219.46]) by mails.dpdk.org (Postfix) with ESMTP id 537CE40270
 for <dev@dpdk.org>; Thu,  7 Aug 2025 16:50:05 +0200 (CEST)
Received: by mail-qv1-f46.google.com with SMTP id
 6a1803df08f44-7076b55460eso12017486d6.0
 for <dev@dpdk.org>; Thu, 07 Aug 2025 07:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1754578204; x=1755183004; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZvTsLl+SAEHTQVDDwiv96erRmyLHzbHtDeB/gBvWm+g=;
 b=dyY25lvRtCeBzenmiUIVjXOEv0u/xX/cSluwL+QOw2gy3wQUN1a5b1tzecuPqX65m9
 yUbaDDSbb0kzFWPhRWwidmIjVwk29HfhGQp65ju4wSN4uwaeS+W6S53PwXc6WJUgUtGW
 a3fIsm+XGzU9NRABpeejaua4qzPKFBagOUDT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754578204; x=1755183004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZvTsLl+SAEHTQVDDwiv96erRmyLHzbHtDeB/gBvWm+g=;
 b=k3GBWYrveZ9MMMwg9hbPWMRlyjF7vMegPmJCkCoyaH2AHr5K5iJfNy0HJDr4V/W66n
 el+SESJ50hxKw0UfDC3AS+a5tKl9J57fVm/mcutJbqS7XI+RgkOBcFtHufakBm+mfEKs
 6zxthiQBrEcpjIIoLf0622LE12VeW0Fq01F4hg6Igv9BHQAVqTigCVobsJOQpOwOoVMf
 CPN3d5jmQP+ha+BpRnGNnWSP38/lASsL+VIYjVd4nHMeM5Jm/gDr0JtWp6BXHYpRS2nC
 iQisrsnwqqG1rkrc7hMhrty0hpd5Kesp8Gnvs7dnqJV20wdLhE4UVJR6UK6VjVynAX6N
 Jc+g==
X-Gm-Message-State: AOJu0YzmNeb0mrvbBHZV0bPUOxOiSJ13mKWwSGs7Xuzz2u+sHPLRwdCN
 abCcNMwMw1VEXwydc/0slDMONrpkDx6WJNY0MI2l9XziOULIJ8fjQoPKSVME2gW4UI7hKdcWKUQ
 QLi7d
X-Gm-Gg: ASbGncuF0CfOg8M08Md129YkGdR3cCgE594FdmDFmwBp1c4qMETUOQ64EQ6CW6xhGUJ
 shSDGaoXceEUdt5roCTe/hdKV63bmiEHahPUsOFC9lfgCHUeZXSWlVZGV5FdT6qkIY0/np50S5q
 UiCz7zyMrXf0O3JwCuJnQmGGczYsDBOwksNyVzCP9xn+wm4Om4psLnO1rdnuAERWq0zFAum17YI
 VF4Urj4bQLeYOxPa/kaKGusfks2s03KTglkyi46U634k4w1PI5W3iteD6+p9pXaEpvWvYA2cXGy
 8w5vERrrh6XJgfXwVJYpriTGO+UYnKB9EbDBpUOjJ2yzG2mmpG6SCP8Hw4OzaMUBnFZ0OByyELe
 0lZURHLthXv2vFaJCBFH7WiFlBHbkPYCqYn1ZaEsKqzE=
X-Google-Smtp-Source: AGHT+IEkVxupSJQgvVqA1y179tAV//cze+XyW1LJwf9UkLr6vP+pRghmxLhlbKxtUu0pecwg46KI0w==
X-Received: by 2002:ad4:4ee1:0:b0:6fd:5cf4:cbb0 with SMTP id
 6a1803df08f44-709985e1087mr854666d6.25.1754578204513; 
 Thu, 07 Aug 2025 07:50:04 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:ac5d:4186:4dc6:47eb])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-7077ce39fb3sm99707406d6.82.2025.08.07.07.50.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 07:50:03 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v2 1/2] doc: add test case docstring example to dts rst
Date: Thu,  7 Aug 2025 10:50:01 -0400
Message-ID: <20250807145002.297452-1-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250722171957.200698-1-dmarx@iol.unh.edu>
References: <20250722171957.200698-1-dmarx@iol.unh.edu>
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
index 3837b398cf..e9dcec22b3 100644
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
+         - Launch testpmd.
+         - Check port info.
+
+      Verify:
+         - Port info shows link status is up.
+      """
+
 Setup and Teardown Hooks
 
    Setup and teardown methods can be defined at both the suite and test case levels.
-- 
2.50.1

