Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4570FC44508
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Jan 2026 00:55:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8C2F840E25;
	Thu, 22 Jan 2026 01:54:32 +0100 (CET)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47]) by mails.dpdk.org (Postfix) with ESMTP id 4660341149
 for <dev@dpdk.org>; Thu, 22 Jan 2026 01:54:30 +0100 (CET)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-432da746749so199501f8f.0
 for <dev@dpdk.org>; Wed, 21 Jan 2026 16:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769043270;
 x=1769648070; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7hL1MdyypnLPE0Cb+MQRun0RmNPirsghdt+s7AybsYE=;
 b=z8XjtyqC4/Z3MhOtB0hypqd4/lrPH/lloLBIwhLdZti27/pLOY9eWpuUhI3dOZAicl
 bJGDhpG4Hn2aU2In3qcWsedoy4azg28EGjHHjydO6gwJwy/RnQQZvewqVQdRVJqhXNhn
 mhLks02hpMwIPnhJnyoRkbKBfb287VWZ/CQ3ebCjqvKqKfa4mliLXpSQtGPi5xlsZ8Z8
 PTWu4LQOtmy6TZaBZ+IgHbm1K/YOo2RBpnL9GgIQ7WsNGHxqxVPAoRzzHQoPOLhrirw4
 HCSzI5vSpGfVl6m31kJ24uDtmi16C4+yuvsUq0NQv3FocuDBw+llcI1/Z9vYoA8vf5ht
 ujUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769043270; x=1769648070;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7hL1MdyypnLPE0Cb+MQRun0RmNPirsghdt+s7AybsYE=;
 b=XDwidf9zcouO7mihWJ73ge+G2qaZtxV/DWE7933UPU8/v9C4RCg5jtPDKvZ9r9lXw7
 8xWrVHt6UpFfiY90CekAUpsPM4HAeH5hu+Aa4LGCS/YxF2U4+dkfkLt8LzFVhCW9V3cU
 zF9xNdbs5VeXHpZGpZVN5M9N0icYrJSZOMtZzLTD09kp/Gt4CbUNQqeDVZmXz1u5nQvs
 QO6PIARjQwYWoZZ6gV6ZWyTIvkei6Tqwzx5gzspTJLTc16qA4Qc+g8AE/uZtOniH4WfW
 uB1TTbdaqyoeqF8kdyE9Fv2Yg917woPu5TFJIoya9C9C4D7UH9Fxr/VkaR5mv/45BB3S
 dZxg==
X-Gm-Message-State: AOJu0Yw1paPPGnMhPIsdg1VOF/2jFv6eO6x2E++oug1NgYXgaOGQlG1T
 Gy+rIf7397QsBCeNb1csY5OSDgX0bXdDsnobLRsK876w2oFWQcG6qaUsRPydeJomRraJDmkrwfM
 4luBW
X-Gm-Gg: AZuq6aIkPBDuFcCPJmtJUaSvdNo6wwR4RftF3ndIvOJTjT4JpZtfJAQl0VdN2y4LonY
 EtmdnsOclrOFZIYuUkgOtjzLAGLuxywOYFDCkvDrSYbALo5gXV507B7FSAyk1vUsn0C9jAutGVs
 Y4rOFZoxSAwr7nvWN6I3O13vDkBhTcNJR4oQAk4FZsKY6gLIBSnua8Gs3buc8EIG/CObsRu+CYs
 XYl8WuQ7Qv5kZ/0BQb96bUvLbvH0hiejQ7qOO2s2AOSlZRjoeShQ5G+FW7HS82rxifIczR7Q4/M
 kWZmf4ibPGryT5SeJyBHMniu/JSkSj//ogbc79UkAt/1jfkrnpqma0K12sZUNnlemialzI3fw9N
 rPU81S1rqfonpEjsOMIg4nhW108HVPTPsdl6YRAWDJNqJOQpe/EtSoMvVN0oat0ej5njEdGWmHH
 hW4/iBX/E1cxdi9Gx30/qyQGdFOlUujWGqvAv++gX8M/jmY+DWxQ==
X-Received: by 2002:adf:fa0b:0:b0:435:8d02:b9cd with SMTP id
 ffacd0b85a97d-4358d02c81dmr11241272f8f.26.1769043269861; 
 Wed, 21 Jan 2026 16:54:29 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356997e6dasm41695104f8f.32.2026.01.21.16.54.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 16:54:29 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 David Marchand <david.marchand@redhat.com>
Subject: [PATCH v3 12/14] test/pcapng: skip test if null driver missing
Date: Wed, 21 Jan 2026 16:50:28 -0800
Message-ID: <20260122005356.1168221-13-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260122005356.1168221-1-stephen@networkplumber.org>
References: <20260118201223.323024-1-stephen@networkplumber.org>
 <20260122005356.1168221-1-stephen@networkplumber.org>
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

If null PMD is disabled in the build via -Ddisable_drivers=null
then do not build pcapng test.

Fixes: 6f01a3ca5c7f ("test: fix dependency on pcapng")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/app/test/meson.build b/app/test/meson.build
index f4d04a6e42..d03e5f7339 100644
--- a/app/test/meson.build
+++ b/app/test/meson.build
@@ -135,7 +135,7 @@ source_file_deps = {
     'test_mp_secondary.c': ['hash'],
     'test_net_ether.c': ['net'],
     'test_net_ip6.c': ['net'],
-    'test_pcapng.c': ['ethdev', 'net', 'pcapng', 'bus_vdev'],
+    'test_pcapng.c': ['net_null', 'ethdev', 'pcapng', 'bus_vdev'],
     'test_pdcp.c': ['eventdev', 'pdcp', 'net', 'timer', 'security'],
     'test_pdump.c': ['pdump'] + sample_packet_forward_deps,
     'test_per_lcore.c': [],
-- 
2.51.0

