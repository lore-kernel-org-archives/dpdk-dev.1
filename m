Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD707C982FE
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 21:17:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 132F642ED1;
	Fri, 16 Jan 2026 22:17:16 +0100 (CET)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com
 [209.85.218.45]) by mails.dpdk.org (Postfix) with ESMTP id 26ECC42ED0
 for <dev@dpdk.org>; Fri, 16 Jan 2026 22:17:15 +0100 (CET)
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-b879d5c1526so209397266b.1
 for <dev@dpdk.org>; Fri, 16 Jan 2026 13:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768598235;
 x=1769203035; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AeDN80x2mTeNEn78vKRz5JV46OJ/DoK2Dn8E8THx/N4=;
 b=RMeV4FUpH1NLdBU9pWWV0jVwTs0W/8v2DTWJHlnUyJUarZdE+i41k+vi4J5QxNt5KX
 fsVM3OAWnVCv6kDZOa/8RtAcnO3RaVgrmrewZyBXx/H3nK+x1mcymO03C2glZH/BDbtk
 DBtTe+dpB+AU3z6npQKN/5bwGCx3mLNpaN1NP+pKWIalwI+34EKTLS27Kb8nLkfnumEG
 KkG9fEhxX7to6bx+ju3qExrJHm63vR4nW77ootij8PNgbLd9zX0+JeeqSsgaf1RYfoJi
 5P2mSptzR44IoggpLqn8JHPY0rc05UqldU5qGOFmaSykqmxH6DjY24i/Wat9w8A3OuM6
 7AmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768598235; x=1769203035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AeDN80x2mTeNEn78vKRz5JV46OJ/DoK2Dn8E8THx/N4=;
 b=KyB++pRphMz1JnkuYj86fkJrdrMNwMMy2hIQRN0mpghaHqvu+2Mb2M49ZU+JdjcAhQ
 +PQiOnlM+kAMPJ84Qf6L8EbCiOcaaTaQWdJ7sLy2vzKe1qW2bgTqnplvPbdgNm8dx4PD
 cIvZr+Xp5O8+W1bqRPlBxtZyjZIkLmYJ3ydJq+d5pfshMv/uWnsSVEs3bj+H/DKkWkGe
 JZ2V7uoAoEHdZ70IeZaRXTqCuW0sABiGHC7rH22LTCP7iv0IcjXjhelyozqAOqGRk8JZ
 OYElQiHfsI5bS/xJ2WYwHAHcKviTjTb2cnJmtUhyKUv6n6uMBDgb+Abvn1vBdc6t/IZV
 QgKw==
X-Gm-Message-State: AOJu0YwPgP8TpUz7DBsPaQVPLQZXx78AEIY2XxW/tFeG/0yxPyQtoA8g
 MEaRp7AdC+BpkF3/9Jr7/gaLD8qRUJLrBbxnSW1EbAwU9ydDq4uQbrTw2W74RSi7ImH5T85NI8m
 I2OC2
X-Gm-Gg: AY/fxX5xurB6wmKxKOTe+/9RMeGnp8man0J7dK4gYdvt29GIghZUmp3S3wsZAUJhdKk
 7Lz4s7KyKogBKM3BNscQfpAty7bLz+KTSNi/UbK9yrdIhNKAVkj8N79DZnqwcCVxTz/NTZ/v9na
 m5TvEYnLeqRt+UKVF/uFMr8GnocpwdsI02RXKpZPQ5vlhew488VPeSjX20viKwa5YRDabcNipet
 XBFEbHeRKRzWXCPtFyIvmdQvaHcAIp1XCRAU3gorb1OqimX98bE6Vq6SZA0NaZ0hgFyb5f4eZKC
 zvcm1toVkStGnDAx016Da8L7QaijwWkdPXenPE9NViwdWz+lekztiNhRe3dFUPxnICSZyW+AD9Z
 fW25DcsAlFo6GkeNQUFvBi5JFj7NmsqMZ5YwK1gBMC4BXPINjNmTv1PIMmvyOaJJ9y0OA0Nc6Q4
 Tm6j5FVrY+YdWIQBlbyQPxNmv734u1IgeWwqhDchi4AmlgC2gt1A==
X-Received: by 2002:a17:907:2d9e:b0:b87:908:9aca with SMTP id
 a640c23a62f3a-b87968a9870mr348770066b.9.1768598234715; 
 Fri, 16 Jan 2026 13:17:14 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8795168ca9sm336649066b.15.2026.01.16.13.17.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 13:17:14 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 10/11] doc: correct typos in enabling functionality guide
Date: Fri, 16 Jan 2026 13:06:26 -0800
Message-ID: <20260116211649.104776-11-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260116211649.104776-1-stephen@networkplumber.org>
References: <20260116211649.104776-1-stephen@networkplumber.org>
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

Remove space before hyphen in "frequency-based".
Change "can not" to "cannot" (one word).
Change "my" to "may" (typo).

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/linux_gsg/enable_func.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/doc/guides/linux_gsg/enable_func.rst b/doc/guides/linux_gsg/enable_func.rst
index a551ddebec..4e1a939f35 100644
--- a/doc/guides/linux_gsg/enable_func.rst
+++ b/doc/guides/linux_gsg/enable_func.rst
@@ -104,7 +104,7 @@ Power Management and Power Saving Functionality
 -----------------------------------------------
 
 Enhanced Intel SpeedStep\ |reg| Technology must be enabled in the platform BIOS if the power management feature of DPDK is to be used.
-Otherwise, the sys file folder ``/sys/devices/system/cpu/cpu0/cpufreq`` will not exist, and the CPU frequency- based power management cannot be used.
+Otherwise, the sys file folder ``/sys/devices/system/cpu/cpu0/cpufreq`` will not exist, and the CPU frequency-based power management cannot be used.
 Consult the relevant BIOS documentation to determine how these settings can be accessed.
 
 For example, on some Intel reference platform BIOS variants, the path to Enhanced Intel SpeedStep\ |reg| Technology is::
@@ -134,7 +134,7 @@ to isolate them from the general Linux scheduler tasks.
 .. note::
 
    It is not recommended to use CPU core 0 for DPDK polling applications
-   because it can not be truly isolated from other system and kernel activity.
+   because it cannot be truly isolated from other system and kernel activity.
 
 For example, if a given CPU has 0-7 cores
 and DPDK applications are to run on logical cores 2, 4 and 6,
@@ -173,7 +173,7 @@ To enable HPET support in DPDK:
 
 #. Ensure that HPET is enabled in BIOS settings.
 #. Enable ``HPET_MMAP`` support in kernel configuration.
-   Note that this my involve doing a kernel rebuild,
+   Note that this may involve doing a kernel rebuild,
    as many common linux distributions do *not* have this setting
    enabled by default in their kernel builds.
 #. Enable DPDK support for HPET by using the build-time meson option ``use_hpet``,
-- 
2.51.0

