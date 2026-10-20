Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38E9606A31A
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 14:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=Jq4wX9eZ
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F1DC40297;
	Tue, 20 Oct 2026 16:55:52 +0200 (CEST)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by mails.dpdk.org (Postfix) with ESMTP id 9DFFC40283
 for <dev@dpdk.org>; Tue, 20 Oct 2026 16:55:50 +0200 (CEST)
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-cd61a2dfd7aso910534a12.1
 for <dev@dpdk.org>; Tue, 20 Oct 2026 07:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792508149;
 x=1793112949; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/Z1KjlEI6nqPyzpbm6gn38eFniKv6Wtq/rRKB1r6YB8=;
 b=Jq4wX9eZ6vIIgh0U47tjyGfVFxdB+mDxa72RLp2pAQSSL4q5kXrg/CAl86mvvaIE3Z
 mTUjvFkKRSeZog4PszACv2UJkJeaCnRTsevdOpvYaRodVn9XmMN8Z48o27/yQ2I8LhGB
 G6Mt9a6SwqCSDSszkVg/osxHHSYYl9GOL3Yw1LYOFbSrmvcdHyNn2kNQog8EGMF0nYM4
 a92DW9gKNMMNtDQ1lzPde3Q+xkjEbD082AisizxX60tPHl6PmqfoEeaZoy6JFK+fxpbo
 HI8GooDSuuHJPyXkFC8QAz6ECkPLa+O/rpnXdl65ZC9zlS9giZtkWxlIk2yuN0m7SppM
 QR+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792508149; x=1793112949;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/Z1KjlEI6nqPyzpbm6gn38eFniKv6Wtq/rRKB1r6YB8=;
 b=uVTK7/wCnf+0JlRfneIsr2yCLPgoqMAHqsZblZ/sDtBayuGrbRPsI3ZhBa0QjdorZ4
 kCy0CK/YTw43/PxTOcp5MJyn5javWYUgjJSe69W3Y7DuI2G9lu7kftwJ2mtk1GtU1I/c
 gejgznChx9F6wSyDRIfXwMwAsC1Rzy7SQqfqWcYc2aPziAuabiKmI/iC8TPL+WHUgh/Q
 1Rkq4AX8iZCoPfoGYOqBXwDbcSmxaIb+izdi8TlTibBwphyq1y7wSBoNF18bBG/Cyo/l
 7Hapbf43dtfuQck2x1Rfpwey/Pla9avEEsEeBfHpILJEDZPKatd2g4BXOeHLKqeDjb72
 8mTg==
X-Gm-Message-State: AFq9FYIl47YXxt/uzJBOr+BfHbUM8VfFeTV/i2HDVEB9kqO1H4t6KCmu
 Cb2SixAlMtH238jU3vIyh6DjQN7mSB7qyKbnUS5A18r6Vvn7MLo42+zK7Yf8cLZ35leuzR9cy+M
 anvmefOo=
X-Gm-Gg: AYBFou1tfxcDKYBRxjgssyHmt4RqvzF6MyqGqAlsh9cnASVV+HYrrl6D1U2EG0vLhcu
 IKAO2phOcsQ98+cYtEu9lF9OnK+jUCMhNpWjjIJldkdJmWDhQAiXu57QgwsPPTAbDNqwdkA1AJK
 MQv3U0ZbR5SuKK29nHfyeD41GyO0PC4/NCp19U4YJSYxHGrPCrutyVoBHneg4WlwegWfv1FhJ+L
 LRgq20wBhbcJjPVZ737m6PDuwZQvmjfm1N3wd+QMp91YNnfUaYJx0g1yFPaply4OwNnW7meqDkL
 jQg6ycj8AcKHZ8Asq/G8fjXhYiIirDmcF/MNqV0JqvJxZL4umxJ9k1TZ673ddLFAyG4zhii64o9
 A2yd+tQw5Nuo/H1Hfxvax3r5ew816Szn9zEbjd8q6HFNvQD/lyDHDQZTjUt1oG0fZY2G4FChZyD
 BLxIF5RfIbYDptqmznSyj8fAOelHCCanZWDnLpP4bsbHtM5L+3anmkwsntyAj4RUvpOjVmZyDix
 zPzs+pQQcKlh3PtJKPRMT0i7Sv/hr6Wh3Bccg==
X-Received: by 2002:a17:90b:35cb:b0:3aa:fc22:8aa7 with SMTP id
 98e67ed59e1d1-3acef5c49eemr10179385a91.53.1792508149349; 
 Tue, 20 Oct 2026 07:55:49 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3acd093380dsm10467306a91.3.2026.10.20.07.55.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 07:55:48 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Ali Alnubani <alialnu@nvidia.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 1/2] build: disable GCC string op warnings when unoptimized
Date: Tue, 20 Oct 2026 07:55:40 -0700
Message-ID: <20261020145541.388371-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Without optimization GCC produces warnings for unreachable code paths.
They check memcpy() against the object size even on paths that are dead
for the inlined arguments. This breaks debug builds of app/test
with -Werror on lib/stack/rte_stack_pile.h,
and has required local pragma workarounds elsewhere.

Disable both warnings when optimization is 0. They stay enabled for
optimized builds, where the analysis is flow-sensitive.

Bugzilla ID: 2061

Reported-by: Ali Alnubani <alialnu@nvidia.com>
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 config/meson.build | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/config/meson.build b/config/meson.build
index 745097e8aa..bfac1cd93d 100644
--- a/config/meson.build
+++ b/config/meson.build
@@ -378,6 +378,12 @@ if cc.has_argument('-Wno-comma')
     no_comma_cflag = '-Wno-comma'
 endif
 
+# GCC's string/memory access warnings are flow-insensitive without
+# optimization and produce false positives on dead paths of inlined code.
+if get_option('optimization') == '0' and cc.get_id() == 'gcc'
+    global_cflags += ['-Wno-stringop-overflow', '-Wno-stringop-overread']
+endif
+
 foreach arg: global_cflags
     if cc.has_argument(arg)
         add_project_arguments(arg, language: 'c')
-- 
2.53.0

