Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B46DAC71136
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Jun 2025 18:39:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C803C402D5;
	Mon, 16 Jun 2025 20:39:03 +0200 (CEST)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com
 [209.85.222.179])
 by mails.dpdk.org (Postfix) with ESMTP id EB81E4003C
 for <dev@dpdk.org>; Mon, 16 Jun 2025 20:39:01 +0200 (CEST)
Received: by mail-qk1-f179.google.com with SMTP id
 af79cd13be357-7c922169051so306481685a.0
 for <dev@dpdk.org>; Mon, 16 Jun 2025 11:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1750099141; x=1750703941; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oeSXj+LJrbvFmLYXkd5jLkmSqEnzCv0jg2xZ0cIUiSQ=;
 b=g3xcv/GjVbFWdDZxjFcW7VEKjMbv1PXrj4RJ1n2FfE8pDjR0PiNOzC3gSA5tMQub4K
 GsTIk4d5n2rbZJcqMrcwkyOKn9ynN8bzKrt69Fk7WoOaZH+znC+TvsSszXA1okJcgXJj
 /beii11J5CDF02e6Hr4Hy54GSGTTSJncL5ezA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750099141; x=1750703941;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oeSXj+LJrbvFmLYXkd5jLkmSqEnzCv0jg2xZ0cIUiSQ=;
 b=xBsTioZPIyuaIjkqVon88TZhclHivBhFlvuo8U0vI+g3lWK6EvYw3hyNpK0ZWdJ1gt
 iJ6exgTvUL/B42Flisx4j7hA0FzyLdC1VvNp/L6TwmJEEGyt5pExTIyHlb3TSF+zDi2N
 4E92sx57W0a7089/gcp2aDbane9ERe+NLSp2Ow1dkPWuPIb1H5NIhe3rTGvFMUwJygzX
 OGWZ5xNzrAcmWPZxU5esoQpEZwuCFPcQYEoyexVohbOZKuBXxeRo7TCWsaypWChTOjGe
 WzZh3jb2d15DYB6O8jTYSf0gkEdx8+11uOquNuSkJyNMeW0ZD87Dn1qtcgI9MwCb+dyB
 5p7g==
X-Gm-Message-State: AOJu0YwJjz407/jkXYYrurr2Dei1UgRb/qxG//po7AI4VEwjiCWDKoZi
 GdjFxYwbbz0qT978iNb0bMHuS8Tg0Z9KtWvR2ZDLqJqONJ6WG3sLzlMJDhqiwizBifE=
X-Gm-Gg: ASbGnct4Y9IAHCvWQ22rzNotHOj7E2VETnpS/MjCjXlSPO81glgugG/Tl00eZoyIkIe
 S2TjvLckud2oXDwAxJykWQ2R67SPohnGYR4I0IjbXck6FEs+uUEbvlsc+iUR4Nghqv1gHmCOV3+
 7selsdc769Z1VO+3N4ATH4elH5+ZtCDSwxyKS6LrMKJwwZKsgBWjFyCz4NGJLGDRO6X6Soce67y
 DTN2NvE8LotQqYE0LOrs/Usx3qsbk6bz8bV4uOTSKcF5Cx0Y1qX2sIDxTpZiTBHlDvvTvgDDKvk
 S6+N9G2A1Onmrn5Nm3hJSOQ8yLzawmAF2WY2UaO1Np+Si5UPyEC3L+zYgd5wUYpBjX9RRJ3g
X-Google-Smtp-Source: AGHT+IFYzB2R2d39lqWJSPJYkkwsJmdALr0PaTYh/JbI6uF3xcDDAyNE6dII077AfIKb/e5g59ieaw==
X-Received: by 2002:a05:620a:40c7:b0:7d3:9ecc:1bd2 with SMTP id
 af79cd13be357-7d3c6c0c7d9mr1454551685a.10.1750099141199; 
 Mon, 16 Jun 2025 11:39:01 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:ac5d:4186:4dc6:47eb])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d3b8dfe347sm558125285a.36.2025.06.16.11.39.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Jun 2025 11:39:00 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v2] dts: fix devbind initialization bug
Date: Mon, 16 Jun 2025 14:38:59 -0400
Message-ID: <20250616183859.646384-1-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250612201220.614724-1-dmarx@iol.unh.edu>
References: <20250612201220.614724-1-dmarx@iol.unh.edu>
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

Rearrange the topology and DPDK setup/teardown calls during
test runs to ensure the devbind script is not called
while the DPDK tmp directory doesn't exist.

Fixes: 4cef16f1f0a4 ("dts: improve port handling")

Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
---
 dts/framework/test_run.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/dts/framework/test_run.py b/dts/framework/test_run.py
index cff0085317..60a9ec8148 100644
--- a/dts/framework/test_run.py
+++ b/dts/framework/test_run.py
@@ -344,8 +344,9 @@ def next(self) -> State | None:
 
         test_run.ctx.sut_node.setup()
         test_run.ctx.tg_node.setup()
-        test_run.ctx.topology.setup()
         test_run.ctx.dpdk.setup()
+        test_run.ctx.topology.setup()
+        self.test_run.ctx.topology.configure_ports("sut", "dpdk")
         test_run.ctx.tg.setup(test_run.ctx.topology)
 
         self.result.ports = test_run.ctx.topology.sut_ports + test_run.ctx.topology.tg_ports
@@ -433,8 +434,8 @@ def next(self) -> State | None:
         """Next state."""
         self.test_run.ctx.shell_pool.terminate_current_pool()
         self.test_run.ctx.tg.teardown()
-        self.test_run.ctx.dpdk.teardown()
         self.test_run.ctx.topology.teardown()
+        self.test_run.ctx.dpdk.teardown()
         self.test_run.ctx.tg_node.teardown()
         self.test_run.ctx.sut_node.teardown()
         self.result.update_teardown(Result.PASS)
-- 
2.49.0

