Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D02C83F27
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Jul 2025 17:20:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4759540283;
	Tue, 22 Jul 2025 19:20:01 +0200 (CEST)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com
 [209.85.160.178])
 by mails.dpdk.org (Postfix) with ESMTP id 751194003C
 for <dev@dpdk.org>; Tue, 22 Jul 2025 19:20:00 +0200 (CEST)
Received: by mail-qt1-f178.google.com with SMTP id
 d75a77b69052e-4ab92d06ddeso83323421cf.3
 for <dev@dpdk.org>; Tue, 22 Jul 2025 10:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1753204800; x=1753809600; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hYg9bHDMODfzqYj3i283vkOWAXIkxni+88kfYn0opkM=;
 b=iuCeQCPta/aWtG+vy1LbREKKAh3gpmKoaI9JEFHUZO9IU+WEoQovjLE6xFswJUHRm/
 Ycrp7dD/fBdDdxqqUy+EfFV4AdQ/d6KRDzyyb8Eh4Q3B9HvnmxV89NKYHroUBIzKRPf/
 KCAWhhBiqoySJuk5Uh+5VdQRiqvCZAl6EimQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753204800; x=1753809600;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hYg9bHDMODfzqYj3i283vkOWAXIkxni+88kfYn0opkM=;
 b=JtMdsgIbfQ/I35Ky1+pVhvdxbsJKhmGxZGaukbPk7FDGv3RoeB2bzQo6ptVqxTp5EF
 xKigMy13jsEJxuPm7CFev8/KC8dkfemS30ndU/ZiPysHiWXYU6JEusfacZhwpKy/Pz1P
 HLmleVjY/rxTgYnsAj0hoPNUtzwqdf7/HeiHVKiw1h/d/0UCuZzpl71M+3/8BSbGFm4l
 cyE5QhA++/QBjVaMVk3jfsGBJmGfwGIz7V+65wV+aZXNjDs/zO/CCZlQYDwswPVGcjLi
 NzzE3lneOR8lgZpTw8R+cRI5xwApBwsMV08cnQ+2Avqfs3pWaoQeDD0wATsUYusRyB6F
 G6UQ==
X-Gm-Message-State: AOJu0Yz0X29mA7T3BylGBWi1JvynA0E2DM2sf+JpTA/Gevy43MpkH/S9
 +hPaV99JYWdc+ynht+bsTEKo8Ss/GwlqV/YhEuQH9sQQYEStXZ8q2TieAVUU2+7KxDI=
X-Gm-Gg: ASbGncshlhvjMJoAGdV12KRMsjcIJscVbljNg0DeM6vuRJriUYLnUGD09R3O00PFB2N
 q7f3QEl0izX9MkkfIteNf1Xz7yjN1FKKvhNNg1jmHdGSk85dY0h+9VdLAerLtTJ6zsZ5yoeuOAt
 J/5qq/QjeuQkvvMgF/UkRl2w5sxIhuF+ZG35lI7S4RbfqvKOZXGp9Y5zljx5/kNeUs5kA4cFMFG
 Vt0l2uovqeYTh+6+ROwDfoN7PGPUf134xLRTzGtk6Q/JkD52/Q0SkD4LouGoXeQFCf41o1bnqIs
 X8V/JtB7gDnnCqiq2rJPQ318ZAsT2muBc5pxOWn3KrtuizYzCkO/EXq1kDoOgQ+q6Ip4rA1+I7O
 1n3L3nhrdx+EI6f3HJCw3SBrGYRRF8nLQ8CozeitYcYicrc2JE3BA
X-Google-Smtp-Source: AGHT+IEuVjsAQQFX/LEaX0mDkVkdZXYWVpy+CM23TsyQwesfKoOu1WaEwxmFayxqWjKa53lC8AKghQ==
X-Received: by 2002:a05:622a:58cc:b0:4ab:73d0:b3f5 with SMTP id
 d75a77b69052e-4ab93c7ae06mr435978901cf.3.1753204799685; 
 Tue, 22 Jul 2025 10:19:59 -0700 (PDT)
Received: from fedora.iol.unh.edu ([132.177.125.216])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4abb4981ec5sm55175521cf.11.2025.07.22.10.19.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jul 2025 10:19:59 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v1 1/2] doc: add test case docstring example to dts rst
Date: Tue, 22 Jul 2025 13:19:56 -0400
Message-ID: <20250722171957.200698-1-dmarx@iol.unh.edu>
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

Add a section to the dts rst under How to Write a Test Suite
which provides an example for how to write a test case
docstring, including a steps and verify section.

Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
---
 doc/guides/tools/dts.rst | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/doc/guides/tools/dts.rst b/doc/guides/tools/dts.rst
index 78761dc49e..7f21b45281 100644
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
+         Launch testpmd.
+         Check port info.
+
+      Verify:
+         Port info shows link status is up.
+      "
+
 Setup and Teardown Hooks
 
    Setup and teardown methods can be defined at both the suite and test case levels.
-- 
2.50.1

