Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C8EEF99CF
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 19:21:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7D12C40677;
	Fri, 13 Feb 2026 20:20:59 +0100 (CET)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41]) by mails.dpdk.org (Postfix) with ESMTP id D847D40674
 for <dev@dpdk.org>; Fri, 13 Feb 2026 20:20:56 +0100 (CET)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-4375d4fb4d4so1013433f8f.0
 for <dev@dpdk.org>; Fri, 13 Feb 2026 11:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771010456;
 x=1771615256; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=91Ud7lUbflLrzIeGpGKO4HmKR4t8GtWFyAmS9Vfu3+0=;
 b=HjFsEG4GghOkOuYr55TTEmuHGukUnqTFuEF+iuBqfIS6/2cRNf9YM73qe86tQFhReW
 8gxdR22AwAkD/r/WAt++2w3qogLgTUTe6tAddcmG5hKN8G+MXsSb//CtM+QyrVWDRMSu
 uKZlNrW+gJkxNnxAqfkKIho4aB1UtsSgy9LBwrZQSh6lzhniNPQ7GRiyBDleevbg0LhM
 Z6M2NWJ3QXrqrfCpPZWNWCT9ffOUTfGL7gy6tCSOfrtM7qiEszifbBDRvVYhYSzGvti7
 VwZ/H5nxsWNHeYFPrAi+ReUGRbOSFWM44stcMF9+ytMl7n4Mi2oJRw4IkZbUh+LEJHHr
 670w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771010456; x=1771615256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=91Ud7lUbflLrzIeGpGKO4HmKR4t8GtWFyAmS9Vfu3+0=;
 b=tK1Hrp90+O3zF0lHZtlAlG7mDgkQaeC6spNu+lsw8j5riqnFabfzeqXBwCRbfnD1VF
 2blz7kl8irKL174YbMaSC5Ew8qz9VAjRXgFHNeMAq6Y7Auk26Ue3bWaAuuc0g0LlgxLg
 DIDN7+wx4Sqm6RHvEQNDvUmx8qD6vl0hTRsSDlD6WBMYuwU1zkD9+Wzc/0KBSK0zlU+n
 CJemauYWmVVa9aXH9/bZmccz1CDCYTnWaFFSM+3cJ/n/JdtUxlKBtpkW0Phxilj4FG4L
 SSxYO2/Ml2tBw4PIs8Xl9T75nuFjOTTSsj0NYgYP59sv5toCUSfHEtLfrtDfqV3CWg0d
 da+Q==
X-Gm-Message-State: AOJu0YzWVnVZoEKw1mCsSjdPoJWbFSymQ0wCc3u2pBW2bObvvdPn892Y
 Qqgaww1vRf5r51Fe0UrO9mqEwN8PXasuxRbbTM9s3YoIb7Ot2CcW6UjRDpMLxM5b5YDdd3Pgo+P
 Rzz0N
X-Gm-Gg: AZuq6aKm0IHPfHzQKI6z7ANlJ9+nthZSZ1kgBKPh1eX6tvpThjfhZsAn7JZ6Pc/u9H/
 C5pgnC9JJw4OT1Wg39Fb0nH4BjhkqvZ5bOw333WtcpVi/zVXqbmZURTC3MV2K6J0pM3ruWQZutR
 NWqh7Npr6r1mROWhrhsxJ1uVjAezKT2dv79IVRXnoMAH5gBrZRnc+2FGhxUxgP2neCcNqgXaMMa
 yMgAUKxQBYeR9q4vtWYj9LGHpsZ0iBwYJtTOwa2gkSwLvhhn/KszCriNRx7vWdSBfccg6kTnY8j
 y6G8yLvV3QtslF966T2e1jmBm3VxttrIk8i11EXtJebiIuuPx+BAA1he/zNTWYU6fo2VbrS5YaN
 Nty0lF4Cw8KNxqrNeWHcoXzxkmNTiPdGfve0Vibyc4Rty3C6bAax3nYfu7J9gOqTvQWqd5skP/N
 QRxFPoAt+Jp6kmO+5qOYVSji9EVfdgdZtl8VWPoPwrRxAjV6B0qMPaPtQJvyutn03dWDdz5jh8
X-Received: by 2002:a05:6000:420b:b0:436:10bc:d718 with SMTP id
 ffacd0b85a97d-437979278admr5154294f8f.57.1771010456334; 
 Fri, 13 Feb 2026 11:20:56 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796ac8d82sm7758723f8f.31.2026.02.13.11.20.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 11:20:55 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 David Marchand <david.marchand@redhat.com>
Subject: [PATCH v7 6/7] test/pcapng: skip test if null driver missing
Date: Fri, 13 Feb 2026 11:18:23 -0800
Message-ID: <20260213192039.221213-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260213192039.221213-1-stephen@networkplumber.org>
References: <20260126210615.175816-1-stephen@networkplumber.org>
 <20260213192039.221213-1-stephen@networkplumber.org>
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
index 48874037eb..4fd8670e05 100644
--- a/app/test/meson.build
+++ b/app/test/meson.build
@@ -135,7 +135,7 @@ source_file_deps = {
     'test_mp_secondary.c': ['hash'],
     'test_net_ether.c': ['net'],
     'test_net_ip6.c': ['net'],
-    'test_pcapng.c': ['ethdev', 'net', 'pcapng', 'bus_vdev'],
+    'test_pcapng.c': ['net_null', 'net', 'ethdev', 'pcapng', 'bus_vdev'],
     'test_pdcp.c': ['eventdev', 'pdcp', 'net', 'timer', 'security'],
     'test_pdump.c': ['pdump'] + sample_packet_forward_deps,
     'test_per_lcore.c': [],
-- 
2.51.0

