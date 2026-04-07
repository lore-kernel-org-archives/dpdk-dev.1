Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBBA5FF5106
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Apr 2026 15:18:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9DC0F40659;
	Tue,  7 Apr 2026 17:18:05 +0200 (CEST)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by mails.dpdk.org (Postfix) with ESMTP id 1E678406A2
 for <dev@dpdk.org>; Tue,  7 Apr 2026 17:18:04 +0200 (CEST)
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-c70ea5e9e9dso2117393a12.1
 for <dev@dpdk.org>; Tue, 07 Apr 2026 08:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775575083;
 x=1776179883; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7bieW0CTSzRbEHG3UZ13aH+mm4B74J7/08TJsfRHTe8=;
 b=nf3brI1Z1t/AfJScbiIgww4pAShsGHmK63dHJW0kYGNGC6J9ATIgyVTWyetEjYsghE
 uimRsyD6L8edcnwgb6nPon371W6Azt5kQQaMoSYDx3JertCpAK4l0fZJythSQdBppqkL
 ykPFQi3sDt2ZOkdGPiyxvfVU92NIFAOvqfqseoBbXVLpz64YkeaKlrzaXkC5j+kEk5M0
 AuJh+/gQA5hSjzQgLYIngW65M+5ydT4i3Y4Z0bjcud0Va6h4q9+2l7gDycs3HHWZwoaN
 50283wV23ZJhiY7260I4HszW9Mbpb5ojOKz3GBm/2yxGouvIZqK58ifvgzDYuo80ADTk
 JG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775575083; x=1776179883;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7bieW0CTSzRbEHG3UZ13aH+mm4B74J7/08TJsfRHTe8=;
 b=o+AtyE6NmEAJpJkSyk34jobCxEjKGqzJOA6lhYext/95Zq5vy9+SOq3Fc6/IGaDOTJ
 5/Wh3LKUEjctrCfvqdfHYjVI7h2CnvykK6BsTiVFs1wI9jDI7ImyTXCAUb4Aqrn629mz
 H1SHlRIytIhrN0CNxwTYPHnteSSyzO6DhIwAMK1kpjuA1jOhVtwKHle1EbDhFQqRK6VR
 bU3peFkQwGTvb1Qjj4+UidUd/DWFjgPeInh8Dg0i3LfAGwNz56U/z5hBr6gBOyVp7SjV
 rvK5jRPqfLE6j/pxh2ZeQUuyT5CL9dLUzwY2DDAO6EyXVXtqGDwoOpjo/T6RCczBxnoz
 GK2Q==
X-Gm-Message-State: AOJu0YzbIml4sxxVoqjnWT4EzbHiWSxlzZFpDw+hrftZZX1kPVbFjCSj
 CGCSKHp9G8eflxvHcO0eqGke+PsQkkwcrHxl4F0yVGMl+1WvD2B6lLA+ISEFCVtxmkMT8d65y+B
 yPal4
X-Gm-Gg: AeBDietegH0eKQO0smpXL7xDWnQSU8s0HaahqsfmvrxEtj9cUWjfa3wL2o8pzWh9hoZ
 ahEzp6rWudj/Vdx72FN6Ddx73jKDRceTe5yGX8bULLFpYPbqQIv5GwKPHHwEBHxNf7b7/H28ZgR
 4nvSlW0NVyzbGHo8oC1t5JwxIlGhcP0xfokwt4TfVPU7soMZX1jNhKdjkDY1MWqruNFBzk0OSLf
 +4R+HPMS/nhROMfxqb/UHhxo2M7vVl3BTRll8FF4XuQgMo+EVqG9XmVHgRJ3foxM3Pw1xPn5qgL
 kIHPdk8vlkXP2D2MSzxq3pOLe7fFR3764n5Q9hDOES1l9xE73kE5VSvt3c6wcMbZNrzTkKpnAMY
 KBXxfvLnJLnCc/I3AewgUtMflNHRMx7gW3kd8ju8y/hhxh8Y50l46xOaFEtalhRSGs32WXhlETD
 i3WWDVq74AJ+EtNlcYv9pgdIuxX1WF60D1
X-Received: by 2002:a05:6a21:99a6:b0:39b:8933:a300 with SMTP id
 adf61e73a8af0-39f2f0f8c6fmr16964046637.52.1775575083220; 
 Tue, 07 Apr 2026 08:18:03 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76c6477bbcsm15842933a12.3.2026.04.07.08.18.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 08:18:02 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Yipeng Wang <yipeng1.wang@intel.com>
Subject: [PATCH v2 07/23] examples/server_node_efd: resolve shadow variable
 warning
Date: Tue,  7 Apr 2026 08:16:03 -0700
Message-ID: <20260407151732.272195-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407151732.272195-1-stephen@networkplumber.org>
References: <20260407035209.650419-1-stephen@networkplumber.org>
 <20260407151732.272195-1-stephen@networkplumber.org>
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

Argument to parse_numa_nodes() shadowed global variable.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 examples/server_node_efd/efd_server/args.c      | 6 +++---
 examples/server_node_efd/efd_server/meson.build | 1 -
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/examples/server_node_efd/efd_server/args.c b/examples/server_node_efd/efd_server/args.c
index 0e5e89705d..cb0486a952 100644
--- a/examples/server_node_efd/efd_server/args.c
+++ b/examples/server_node_efd/efd_server/args.c
@@ -81,15 +81,15 @@ parse_portmask(uint8_t max_ports, const char *portmask)
  * and convert to a number to store in the num_nodes variable
  */
 static int
-parse_num_nodes(const char *nodes)
+parse_num_nodes(const char *arg)
 {
 	char *end = NULL;
 	unsigned long temp;
 
-	if (nodes == NULL || *nodes == '\0')
+	if (arg == NULL || *arg == '\0')
 		return -1;
 
-	temp = strtoul(nodes, &end, 10);
+	temp = strtoul(arg, &end, 10);
 	if (end == NULL || *end != '\0' || temp == 0)
 		return -1;
 
diff --git a/examples/server_node_efd/efd_server/meson.build b/examples/server_node_efd/efd_server/meson.build
index fa0e15d73a..f1a6616738 100644
--- a/examples/server_node_efd/efd_server/meson.build
+++ b/examples/server_node_efd/efd_server/meson.build
@@ -10,4 +10,3 @@ allow_experimental_apis = true
 deps += 'efd'
 sources += files('args.c', 'init.c', 'main.c')
 includes += include_directories('../shared')
-cflags += no_shadow_cflag
-- 
2.53.0

