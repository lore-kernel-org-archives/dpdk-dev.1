Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D91C71136
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Jun 2025 18:35:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 54B57402E7;
	Mon, 16 Jun 2025 20:35:32 +0200 (CEST)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com
 [209.85.219.52]) by mails.dpdk.org (Postfix) with ESMTP id DDDBA402D5
 for <dev@dpdk.org>; Mon, 16 Jun 2025 20:35:30 +0200 (CEST)
Received: by mail-qv1-f52.google.com with SMTP id
 6a1803df08f44-6facacf521eso50108416d6.3
 for <dev@dpdk.org>; Mon, 16 Jun 2025 11:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1750098930; x=1750703730; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oeSXj+LJrbvFmLYXkd5jLkmSqEnzCv0jg2xZ0cIUiSQ=;
 b=O2LxQya7oWcI8vdSCVn+HULK2nilxwms8Ke0MdWYbdhIySMyyYy7Fdh34AtQOihkR9
 LwU0XUPa7C9CvMuWs4HjVo3HCpau3VnQaPJBwLJtHHLVt9ZTHjo0+7jsR4Olo1P7DdcI
 efJnDVcmeLOf1zLXZD0GSETBhYX1lIcf3rklQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750098930; x=1750703730;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oeSXj+LJrbvFmLYXkd5jLkmSqEnzCv0jg2xZ0cIUiSQ=;
 b=BsXeikgAJDUjWHm6wzKjAphBrwufpU2BikLqaxYXgm0FVmlHCCN4MEFEIAvkS0lvtp
 03gSIanZ+xp69bKfvVPvlaKIq3U2xKvkQ0dVbERdpltwdXVN2DgesEc6B1/AEGE/2kSV
 i/edQDfV6Ju8e4Icaza4oyLmTqbeSdx98lwLHgGt0qy1urq2s3M1JqhW2llTtrOgw9T9
 3SDc1Bo+/qJLsGzXM+jBF9f3DTEivfmKEl65eU9KCMxSm2EKAxRusGc1SzuWY1e3k3Xj
 2B7it95PLEEQGjOP1pGyNymprrW1UEVosAFrNqWV0LYxaduM5L9tmDJOsDfQLvHoKjPa
 41OA==
X-Gm-Message-State: AOJu0YwcshQ3eahanqCTS0UDE6UnJXfRxSWvm/mHeo42J7J1cvNhK5P8
 Rp3LLTm/pGoLu5wT93ik7ab83FbADDPtxFGyGmO52BEFPyPZIHkW9MG8t/TjWmJwvAw=
X-Gm-Gg: ASbGncsJ7uf8mxpMaGMw6FCATcxTe1klZ1GjQqJiPkmeEqeL8eYjxv4HOf1JokOexS3
 efKPa50SHsSDuULd23frzHv52dNqAPbwnai+YMDhD1Bi7St94u7qX0QwEM8bdnUMUOXqyp7YHx6
 L3trcoNiE3+8LPOSvPeE9/XT+46UQ2gWJuQOmcjFhBNffG5on6jiaj7NmD6JiDk0sO2MGz7C0jI
 aan5qRcILCLuk4Cv/fhIXQPnLWcgfXzyFd56T+ow5kbFz3+9yEJFh6NgxhQ2sGl+AphkoIEMCDl
 b5vSzTED+RX/hSnKO9/5ZGxJMD2qJk/GTpFhpHasBfHlW1CSfn6jB4z0FdWTL9a4cqS6IhUb
X-Google-Smtp-Source: AGHT+IHgmvQbU/MTFQ9qhJn5MwlVdZxjtl0ClX2sTh4jl8RtjgV8/HSzhCcZshWL3a8c/2oXzpv0vg==
X-Received: by 2002:ad4:54c4:0:b0:6fb:4c6d:d4d9 with SMTP id
 6a1803df08f44-6fb4c6dd6d1mr100422066d6.13.1750098930044; 
 Mon, 16 Jun 2025 11:35:30 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:ac5d:4186:4dc6:47eb])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fb35c841d0sm54130716d6.111.2025.06.16.11.35.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Jun 2025 11:35:29 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v2] dts: fix devbind initialization bug
Date: Mon, 16 Jun 2025 14:35:27 -0400
Message-ID: <20250616183527.645888-1-dmarx@iol.unh.edu>
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

