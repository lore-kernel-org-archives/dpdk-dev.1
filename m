Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A64ED74EFA
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Jan 2026 16:21:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 643A4402D7;
	Fri, 23 Jan 2026 17:21:30 +0100 (CET)
Received: from mail-ed1-f97.google.com (mail-ed1-f97.google.com
 [209.85.208.97]) by mails.dpdk.org (Postfix) with ESMTP id 081C340269
 for <dev@dpdk.org>; Fri, 23 Jan 2026 17:21:29 +0100 (CET)
Received: by mail-ed1-f97.google.com with SMTP id
 4fb4d7f45d1cf-64b791b5584so3836006a12.0
 for <dev@dpdk.org>; Fri, 23 Jan 2026 08:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=6wind.com; s=google; t=1769185288; x=1769790088; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LUA2JxI2UBL4Yw73YuEw+EA7yohM1Ew4LqVMgTy6k+w=;
 b=RRbwt9TI0g2mcgrS7Nli8MH64scJBhwYsRo3QwRBT1mMniZje+urHKdbK9lbqVIPu9
 x4WLFWwfkTm+rrJRn8/o8cpuoWCACG7DPuBKnmzmm/+l/vo3VVjuXT+O7lunil+gSgIh
 H7S+umEhE2AEhtUqCXj3VdH1PAaLLAyTf4X6hoEvwXnBtgSUdlaYPrswEU8S5ROtM1rx
 1fB4mWeI7WQ2eR5lqRaDdyyy463zGIpOlwIvvctqCpMWVFm/VgiWNH4HJzGmAj3QE9nG
 3Jg3Q9tUHpD7GRyAjm8vY60KAti6/LLlR9fMUpySKxY8/UCzBG+2JIBtk01EVqUpr6/+
 a08w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769185288; x=1769790088;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LUA2JxI2UBL4Yw73YuEw+EA7yohM1Ew4LqVMgTy6k+w=;
 b=WXuoQzgXscvQrizmYm7wwCwHVEbMaQH7iL2gSwBoEKh4gR9r4FlmzD5gDIPf/emIh4
 ZGFOJgevALXYJMBX4Qi7gAZA+1FXSXQygzod6ezgl/nlw254vbLb0l/7TkdJRh29s/l3
 0vJjZzpcmK1eY+BnE9t+hohwZLcvKsqYbF/hoFaaAREMLic51Fbt/5J1KgMjY1ivkyw6
 GAiVLrAVY4GpQMMx0/cSor+29DzbDlLlli4Gx/WafczuM6NehxGIVj9zwoR/5aAfc+vW
 YSXY/1CAQPA+Eo7udFqYLY0cO3GtYdPKqyHNTNSk62LHaUauLinjAtXoSVh89m8LPomI
 w78A==
X-Gm-Message-State: AOJu0Yynvc3DUttuKFZUG0iBFaxEUZ7BCdKak9DfobIspbQsQtZ4/omn
 OieeE5v7asSq0W9AyKYRIPOh/+RN8I5qAoLzFvyf+X64V+bxxD+1USIfffTe7rTa14MSN1rXSMU
 1VpcFeR2bl6FyWzj9i9qamNBJAip+CDEEE1/tfI4cPZ0=
X-Gm-Gg: AZuq6aJwIVznY3YMk0FygYqD2Ud0qfQRD/cFl9/EZurljGy7Hnpr8jgCBxYYJoiSENk
 cscV2EY4Tco3JuNN+7V+7rsHMa/k1ZSvB4JZgdFSekX7XPV/du6v/RTN0BkI9P798+LASMbxYhY
 B/LGQid2fcAtDAQhXQ7ns8pN2w3/3aTwAZr/Ekw+ymhzOn2DpYBDIz/imt+2kkmEwhMBXDI2TKh
 S6uM+capRCQKevelw3+VYYadnR/NRXtr5mvIbQFXQALrdREt1hTm/mqd7fMlWA8zHYlRInCzej8
 eh6Q/nWUGmnZRtDcVoeaoxDDlCJBS17T1pSbIkt1NJPPD1YQonr2fJ46FcxwCbXM0vTOgQsJSGg
 iA2ag7gxgywSKnSvtPon0ugLMwm22KcbbLnQDRM5De3Vz6aMmPqZFjluol2fWB17B
X-Received: by 2002:a05:6402:51cb:b0:658:1224:3d51 with SMTP id
 4fb4d7f45d1cf-658487c99edmr2314490a12.32.1769185288514; 
 Fri, 23 Jan 2026 08:21:28 -0800 (PST)
Received: from smtpservice.6wind.com ([185.13.181.2])
 by smtp-relay.gmail.com with ESMTP id
 4fb4d7f45d1cf-6584b955e96sm318066a12.15.2026.01.23.08.21.28; 
 Fri, 23 Jan 2026 08:21:28 -0800 (PST)
X-Relaying-Domain: 6wind.com
Received: from localhost (vader.dev.6wind.com [10.17.1.39])
 by smtpservice.6wind.com (Postfix) with ESMTP id 5389C2429C;
 Fri, 23 Jan 2026 17:21:28 +0100 (CET)
From: Thierry Herbelot <thierry.herbelot@6wind.com>
To: dev@dpdk.org
Cc: Thierry Herbelot <thierry.herbelot@6wind.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>, stable@dpdk.org,
 Olivier Matz <olivier.matz@6wind.com>
Subject: [PATCH] drivers/net: reorder Intel drivers list in meson script
Date: Fri, 23 Jan 2026 17:21:04 +0100
Message-Id: <20260123162104.1854187-1-thierry.herbelot@6wind.com>
X-Mailer: git-send-email 2.39.2
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

After an upstream patch (see Fixes), net_ixgbe_vf is no longer declared
in testpmd PMD info, when compiling under Redhat-9:

> [user@vader dpdk]$ meson setup build && ninja -C build
> [user@vader dpdk]$ ./usertools/dpdk-pmdinfo.py build/app/dpdk-testpmd|grep ixgbe
>     "name": "net_ixgbe",

Name 'net_ixgbe_vf' should also be reported.

One workaround is to move 'intel/ixgbe' as last in the list of Intel
drivers. This restores net_ixgbe_vf under Redhat-9:

> [user@vader dpdk]$ ./usertools/dpdk-pmdinfo.py build/app/dpdk-testpmd|grep ixgbe
>     "name": "net_ixgbe_vf",
>     "name": "net_ixgbe",

Fixes: 04f1b16c54f3 ("drivers: merge common and net idpf drivers")
Signed-off-by: Thierry Herbelot <thierry.herbelot@6wind.com>
---
 drivers/net/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/meson.build b/drivers/net/meson.build
index c7dae4ad273c..8d96244cdbb0 100644
--- a/drivers/net/meson.build
+++ b/drivers/net/meson.build
@@ -32,8 +32,8 @@ drivers = [
         'intel/ice',
         'intel/idpf',
         'intel/ipn3ke',
-        'intel/ixgbe',
         'intel/cpfl',  # depends on idpf, so must come after it
+        'intel/ixgbe',
         'ionic',
         'mana',
         'memif',
-- 
2.39.2

