Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B20AC369A2
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Apr 2025 22:42:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5C5FB40689;
	Thu, 10 Apr 2025 00:42:43 +0200 (CEST)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com
 [209.85.222.172])
 by mails.dpdk.org (Postfix) with ESMTP id 5160240671
 for <dev@dpdk.org>; Thu, 10 Apr 2025 00:42:40 +0200 (CEST)
Received: by mail-qk1-f172.google.com with SMTP id
 af79cd13be357-7c542ffec37so22226185a.2
 for <dev@dpdk.org>; Wed, 09 Apr 2025 15:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1744238559; x=1744843359; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IED+AQ2UwLK8KsCjbP9dtC8FhDuNS7lQiL1RBP6bwTE=;
 b=HvGwJUa03YOTwA0i3O4ofOPtQKmSR8YCW5igzCk0a45oOk1qTMZvp6D2hQ78STdtEa
 duiXqKQoTG4vqNfP45PNVfu9o8tDmbKKx08royuF1jGVcKRmcVKI6YVcBnwG/5IlEoqW
 866YopLoNuI4UH4hzqZZqne5AJ3/UGF0l7kEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744238559; x=1744843359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IED+AQ2UwLK8KsCjbP9dtC8FhDuNS7lQiL1RBP6bwTE=;
 b=ZaR79W5ciT/cNypLSC5Y3iu19DWcQgH406DdCJRzkOAgtScKcn0Kd4VIrW99XS55wW
 RHvME2EsEO40/mvt14PpJoI2r45fAiEiXEUpLYEvKnXfxxlhXgfNtXD31Zz25tpZeiPU
 ygoIf3uuB6Q5jBgK8C5lT/M7CSyWksZvhhgoUoOaA9S2qCDAxW/6Okal10vHV+MLz6ea
 2hSGdwa4M7hKYsS2mjiU/L/1J00UrjflFcjUkzxyOkr5e2O7wNHa4xkLNmpyQ1LHLN8o
 urH9prk8Ycsc0qw0SmI5Ho2oUIm92hSXpl7HZMcAEOg/CJKljEQVJUNjZ0Q7cRecwR79
 6QZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVegHnxQEnx37FxYUfTf8lct6GDfCfgaPWcl7QF5b6lOnm0BQ1rtHWZhpGbZ5atqt2GNnc=@dpdk.org
X-Gm-Message-State: AOJu0YzKNDlflsLjUw0vj4Wy/JZgiVrBLHyDMHdNKWvVxu4EpGWtJAWT
 xBWf/Cr7lVZxAyrTjQwxvON7dXCvC6TmzTKapBys5YWjWtxqEdrtw9SYKtccK2Y=
X-Gm-Gg: ASbGnctveGgmTGnGaSGsEzSeKjkHukAse9S+tirSZEVxPOv+zm1s99RkhdAhVgB8j5o
 r+D2Kz/MMp2Jnop0lxif2TA0Ft/lbPCQM+d+YtsgCXl7tx4Siu1RLoEaD7H05nJIIdoMTn8mmN9
 96Aaa1PMX3+limNOQXKpxBCJDXSuQ7YRv9JAL0lHyV7fgv1C/VHyh9D4bPKDlvq6ZkVuD/11SLb
 yzHBm3N2iDGNfSC5MiuBqbKMoQTCKJuBPGGPYlYLjzvJLr/oFIu9Yoxxg6R9Iu8IBwaeEIua8Oi
 jf6x+wOjTssAl3+QH0jIV7Xfu9O/AdecEL44XJDdn8kGnw2f+VI5ObB6Q8zeZ7AQrBSnxCVkxPS
 MB9u5KcKtE4RwVg==
X-Google-Smtp-Source: AGHT+IEy+vmGVOpKAKDbuHjWn1UVU+h0hr3MeFptfDsTgB6Gll2qnKnlpLVUOEH0Kb4ooHIvsQSfhQ==
X-Received: by 2002:a05:620a:1a96:b0:7c7:a5b7:b288 with SMTP id
 af79cd13be357-7c7a766e1f4mr79634185a.19.1744238559746; 
 Wed, 09 Apr 2025 15:42:39 -0700 (PDT)
Received: from patrick-laptop.iol.unh.edu
 ([2606:4100:3880:1271:8c70:5b9e:ecd3:14e])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c7a11ca015sm125949985a.82.2025.04.09.15.42.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Apr 2025 15:42:39 -0700 (PDT)
From: Patrick Robb <probb@iol.unh.edu>
To: Paul.Szczepanek@arm.com
Cc: probb@iol.unh.edu, Luca.Vizzarro@arm.com, dev@dpdk.org, dmarx@iol.unh.edu,
 npratte@iol.unh.edu
Subject: [PATCH 4/4] dts: extend meson fast tests timeout
Date: Wed,  9 Apr 2025 18:38:25 -0400
Message-ID: <20250409223825.1579256-5-probb@iol.unh.edu>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250409223825.1579256-1-probb@iol.unh.edu>
References: <20250403023059.1762841-1-probb@iol.unh.edu>
 <20250409223825.1579256-1-probb@iol.unh.edu>
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

The current timeout is insufficient for running
fast tests on some systems which are running DTS.
This timeout extension resolves the issue for the
systems in question.

Signed-off-by: Patrick Robb <probb@iol.unh.edu>
---
 dts/tests/TestSuite_smoke_tests.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dts/tests/TestSuite_smoke_tests.py b/dts/tests/TestSuite_smoke_tests.py
index 9e4d06a1c4..72901e59d5 100644
--- a/dts/tests/TestSuite_smoke_tests.py
+++ b/dts/tests/TestSuite_smoke_tests.py
@@ -59,7 +59,7 @@ def test_unit_tests(self) -> None:
             Run the ``fast-tests`` unit test suite through meson.
         """
         self.sut_node.main_session.send_command(
-            f"meson test -C {self.dpdk_build_dir_path} --suite fast-tests -t 60",
+            f"meson test -C {self.dpdk_build_dir_path} --suite fast-tests -t 120",
             480,
             verify=True,
             privileged=True,
-- 
2.48.1

