Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB0AAFF5106
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Apr 2026 15:19:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B8EBA4066E;
	Tue,  7 Apr 2026 17:18:23 +0200 (CEST)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
 by mails.dpdk.org (Postfix) with ESMTP id 0D80D4066E
 for <dev@dpdk.org>; Tue,  7 Apr 2026 17:18:22 +0200 (CEST)
Received: by mail-pg1-f179.google.com with SMTP id
 41be03b00d2f7-c766cf593daso3679800a12.3
 for <dev@dpdk.org>; Tue, 07 Apr 2026 08:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775575101;
 x=1776179901; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yr4q3jzFGAmZefaSW5dJ4fCAfvNiHXI94JoTG+pfpOI=;
 b=HXARj4wF8FCYvq1iukYFoyPG0Qjsqq0AanvFChjScM+upuTWbwBSpFWOCvgBnasUkP
 n5QH8Ohyer7/u4Qjy8zFKd8hT4leNAVCMUIkcvanVMCph0Q24+nWtmAxD99Scg8ppPes
 J4J/bRO1K8rQzi9HDKp8Xf6pWIshKXIA5pgy73I7YCrR8dhxB1Fc23z21nwFjuuenwsA
 wNkRPw+0LHXEwZRdj+Zz8yFHSvHpKGobTm+G5zDE3rmaZX73d5Oa3K2hWVS3phZLkG7J
 vsQDdK3WOyOXMN9PRcVlaYoHV+tdWDKpMzgnxxp+moN6nQZVxpbsNQU2EeDTOhJp2sco
 fKiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775575101; x=1776179901;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yr4q3jzFGAmZefaSW5dJ4fCAfvNiHXI94JoTG+pfpOI=;
 b=OvE95PnTF+/brNXM9/XXxhkcRw6CkeEGuLFtdzxS03xwBUni9nVsNX8grOlEefg0fS
 Hht1vc7xk7Z8SGkLbKZe/5BX4eqa1GA6dpQ1WL1Y+DgdL2RJa40te6RbKaxV9+rcPPM4
 OMpNLBCjz0o3TmKq1Em6KY2uDVqraNi6D0RnacZRr486D/x6vqlmznuezFlzZXHrP6sS
 QWcAviPd1+um8nO1wyL9k1G0wMTL1Ru8q0q2tMMeZhDAqNup0YZq3EqUdlkCObcJWDBN
 p0wHo3ZDhfb1x5IJWGnzGGKWZg6OcwpB1AkXXfbyvZQKqn4+JkU8qc0XT4iMPZV6CjCN
 PNMA==
X-Gm-Message-State: AOJu0Ywyx+FDBYyD/Ve1YEP/Jwf+Hv4yQEot9JK5pW/AK/sp8wDdhHG5
 /SvS1UajzTqYLugo+P6dwBbF1ZNCWgDF6QeY+dKNTeJqGFNt014rnkjFl/whjo3G7H4KVyg5fTv
 VlyHT
X-Gm-Gg: AeBDietJOJ98zfuP7D3vOKl9Dgli8oLszIaPYDJuTqugQQvfH6+5RP+x4MXmRxbSQjg
 9obpzIN2zQ80gwjcgGQ7rQQyC8kw6FXNETK5M5+ac/O5ph/ujm7OOFraowLWml+VZORpMt2nTa6
 U5VA+qEdKElKIYtHXvZjgh3t5GZBAVT62cWGAmawxp/4izwRZCpGniQMaa0XxRafe/kQLbXaHJm
 U7dYQP5KpPC2Pmrp1RNFgTp1jJVwjddPAAm4DtCVwJHqChS4kF4xQI1U42DLNnpw+/f5BKDw9Mw
 VTMo+hZtIboE2kon9NBn/d5eoBFrh0xOAb0mYQwlujaCuldWYZCGwsyPN3Z5bomMP95My2zi3oz
 jWheT2WnP/AyQRCeefTfdG6p4uT+w5o1SOo/cGNY1cFpQHlR1ztJhiRuiXvlCXA4/UyKBranvMO
 PtAO6BLMbno5pa58qlAeqlgawc7e4khd0u/uUfrVYUc08=
X-Received: by 2002:a05:6a21:3396:b0:398:8cb2:84c1 with SMTP id
 adf61e73a8af0-39f2e93e9d9mr17533475637.0.1775575101060; 
 Tue, 07 Apr 2026 08:18:21 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76c6477bbcsm15842933a12.3.2026.04.07.08.18.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 08:18:20 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Sivaprasad Tummala <sivaprasad.tummala@amd.com>
Subject: [PATCH v2 12/23] examples/vm_power_manage: enable shadow warnings
Date: Tue,  7 Apr 2026 08:16:08 -0700
Message-ID: <20260407151732.272195-13-stephen@networkplumber.org>
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

No problems in this code, re-enable the warning.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 examples/vm_power_manager/guest_cli/meson.build | 1 -
 examples/vm_power_manager/meson.build           | 1 -
 2 files changed, 2 deletions(-)

diff --git a/examples/vm_power_manager/guest_cli/meson.build b/examples/vm_power_manager/guest_cli/meson.build
index 45f2edab22..6a6809240e 100644
--- a/examples/vm_power_manager/guest_cli/meson.build
+++ b/examples/vm_power_manager/guest_cli/meson.build
@@ -13,7 +13,6 @@ sources = files(
         'parse.c',
         'vm_power_cli_guest.c',
 )
-cflags += no_shadow_cflag
 
 allow_experimental_apis = true
 
diff --git a/examples/vm_power_manager/meson.build b/examples/vm_power_manager/meson.build
index 6bc84d752d..53949ce6d8 100644
--- a/examples/vm_power_manager/meson.build
+++ b/examples/vm_power_manager/meson.build
@@ -29,7 +29,6 @@ sources = files(
         'power_manager.c',
         'vm_power_cli.c',
 )
-cflags += no_shadow_cflag
 
 # If we're on X86, pull in the x86 code for the branch monitor algo.
 if dpdk_conf.has('RTE_ARCH_X86_64')
-- 
2.53.0

