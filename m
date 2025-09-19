Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF654CAC59A
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Sep 2025 19:30:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 080FC40647;
	Fri, 19 Sep 2025 21:30:24 +0200 (CEST)
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com
 [162.62.57.252])
 by mails.dpdk.org (Postfix) with UTF8SMTP id 122B64042F
 for <dev@dpdk.org>; Fri, 19 Sep 2025 21:30:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1758310214;
 bh=jMopkwARxzGCdGuyMHIGNUESpEQxE2azS3Yk43T1s64=;
 h=From:To:Cc:Subject:Date;
 b=Vl8L/cpYimkdPMj2QkL1z6bttoGi6+z+EJ19oE1PNxPYxhsAWzUWjqVGaGZ9hqg42
 3g7cIfBV7+dNUIL9P0mLkEw/iPotf93qN9AcV71e5LPBQf4DZLfQ3DrBHD/iinXsa7
 M7O4GCiLu9QmkVLu4zsV2Uq2ZAasDbP8B2DdreGg=
Received: from ar ([42.177.177.196])
 by newxmesmtplogicsvrszb20-1.qq.com (NewEsmtp) with SMTP
 id 78D008ED; Sat, 20 Sep 2025 03:30:13 +0800
X-QQ-mid: xmsmtpt1758310213tbzwpoy1p
Message-ID: <tencent_7559D52E8BB321BEE2D7B90CAC9A30759E07@qq.com>
X-QQ-XMAILINFO: MIXpHopat2IaWft8bJevzYsHHoesEOwojLm7iiDuTIKB9saaVWmqix7yQH56hQ
 9nDzPDm3cMvn9tTgYcmxvano3X0iRxd6YgqdkpnY7yEbewTW2AzIeVLBAuXS9Both16FZz7J3rfo
 TjxZAZHpal6NMItCF4HQKqwRUd7x+lohbTZxLP6tt8BqTQjs1TK3vgQB77urdMabtZMOxGe5yEE5
 YwqUXwM34vVAIc/jJeTl/eXGIFBTDzE9eV2mD5sueAS2ME7W0Ti8wgjJhj3V0JtpDh2VYrRSsuaC
 /m2tQr2IDM+/qxhEroUy79FBoBLAcWLG0G2G809peTv1531Rdo8HNMifmLhmk0Mqp3W5H0epFlBc
 H4hk/Aa9ATgU0TPH30qFgJDtMuiQt6akfe1Zx5EzZ0vlpH+SJc9AkmWClzZNE0GbI40w7V/n0yDa
 agL87gvJxgnTljVn6zisrFXA4IOHO/QZ5BmBp7muPysyvmGtXFhz7z2al6xua6eRgDn+Gd65Rzax
 sMLBGndcUvSSof6hJvbYV7PeAYWc0FBFkv7ca9H9hNZmeUCyS67Hao5nZZitAZZG8Bm+cO0gezLH
 XxWi/VZh4UGIu9o4uv4KDqEeSfEfqQCgQ25i82SDcM37HVTV8Q58JTHjpFXBxKnxOEr5BKNpRBc0
 ZnfJXyYq/1/Uql7/CYZ13NCvQG6MX03kDgky/p+tdGmaKyLpXs5/uRgEFBk+iTC9smmeTrQecif5
 jsJAy+DpLBwpMIymdpNF95I4QLRLC4/CzFIMXYDvjD5EIAgtYna0D7161HH/++z/UbCiiWFRNxCo
 yr3N6dYVNYLAYtK67qB9XdOGVsQvQkeSw3QO4Scu7HgGFeAEn/tXkeG3Rrz11B4DnGC2FSNkfeQL
 rMqGsrk+ZozRKzUa+rja08WwN2hb8OUXYUAt6UNtc9kZzXBTy5DJdg74E55qrriIhggdjvMOrdrx
 V5rJIdBZQ=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: uk7b@foxmail.com
To: dev@dpdk.org
Cc: Sun Yuechi <sunyuechi@iscas.ac.cn>, Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH] maintainers: update for RISC-V
Date: Sat, 20 Sep 2025 03:30:06 +0800
X-OQ-MSGID: <20250919193006.3720968-1-uk7b@foxmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Sun Yuechi <sunyuechi@iscas.ac.cn>

Add myself as maintainer for RISC-V.

Signed-off-by: Sun Yuechi <sunyuechi@iscas.ac.cn>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1a2729be66..df1d295f93 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -337,10 +337,10 @@ F: examples/common/altivec/
 
 RISC-V
 M: Stanisław Kardach <stanislaw.kardach@gmail.com>
+M: Sun Yuechi <sunyuechi@iscas.ac.cn>
 F: config/riscv/
 F: doc/guides/linux_gsg/cross_build_dpdk_for_riscv.rst
 F: lib/eal/riscv/
-M: Sun Yuechi <sunyuechi@iscas.ac.cn>
 F: lib/**/*rvv*
 
 Intel x86
-- 
2.51.0

