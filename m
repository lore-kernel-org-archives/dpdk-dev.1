Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA80DD46C16
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 Jan 2026 01:43:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DFDA440679;
	Thu, 29 Jan 2026 02:43:30 +0100 (CET)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50]) by mails.dpdk.org (Postfix) with ESMTP id 71A1240679
 for <dev@dpdk.org>; Thu, 29 Jan 2026 02:43:29 +0100 (CET)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-48039fdc8aeso2431965e9.3
 for <dev@dpdk.org>; Wed, 28 Jan 2026 17:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769651009;
 x=1770255809; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CXd3lefCqyeFmUQKQKVEzn7YKBdodMhP4sBYPSV8wck=;
 b=BpWZynHRyvBel92N2Rpy59P2n7E6HyTocng1WLYK1atK5BlvUCj1hRoVJ4KYWMc3dT
 GT9JVeukSo7tKbKTX/E/z86rokHX356bh57uZDaYQeitoWH4ndDZfNG7cQgbJ8IhgTM6
 EpCryPbMacoEwiEaUKy2BoO/VnT+tHLAfV0y6gqzUCDZcwazo6EcUWGNeauRdaRDk1Ji
 ammspZQZ6yP+gG0iViAmEdetX6aRKUaz7fPHuAKR+f1Hm13o0U0IjB88NyF5GNQLuLad
 Jya6s5vmB/Al4LOZ3S7Pe3Edv0UuhSmwbTz1PpFlm1dGcekiUviHJ62dfiMn/ENg14jh
 aMwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769651009; x=1770255809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CXd3lefCqyeFmUQKQKVEzn7YKBdodMhP4sBYPSV8wck=;
 b=JdbjEho1fLvwzM3RO0/Ru0BEZef4UJH1x0V8r0+k1bLcL9dB9lFgQpZzWkd1Hggiiu
 Sze7hwGepcAFQABeNI9II8m2AR2PvCwxSf1AQ1LK7BRBQUgl9yy+EXbwbiyky5WWnu6X
 EWtQQTkvitAJwGNvDxAX5Ro/AiLBBQAGXDIgltrjwKZwm58CLpgoADUosJFzErJne21P
 /2LOVfJ1x+sZrJZ267CCD8umVO5RkeRKbjq1vvkNqLxTL339Vpbh7jvYfWB+lbaUFOqs
 4E85Dybj1eVmcFOHcbbQHW0nsg+t5b8b1M/XjVOBfZNIjD4GhwiYZdHnFh9Ni0qyQ4ko
 6VMQ==
X-Gm-Message-State: AOJu0Yy5DUcmP6H7QWfR8K159KQy07zKzdJnzQG/zTC/2/iCKFblBGLe
 rpho3MHEXOHQm+3oURiYwLADG3CYhpZg++u8F/giPzi8Qu3AeyfBWP+s68hZz9CCNNTmCuZWAtg
 kvvP0
X-Gm-Gg: AZuq6aLnE350DnftO/fRP9U9YplOuWsJHCwldKbh2B5igEvB23dbmWEIrDtQKfS8h2s
 VX0wzFzKDyBqsKPUQph2L+udK8zcEqha1nTgoaqWZwn0U1f3TJJrUiM9/5uA1SskL7jWMkF1I17
 AoNrdejWbqcNxKiOZrvJjh+9OR8m5yZz+3t+m17vXu+F+VT0A57H7AsMwM01VYYuZ8zrqEqjnl+
 5jcM5kSx7WoR8mFsU86dF9kW0PjlS3u5K+Fvcnp0SkECcYaQ0BDispvg3tq7Yiz8Svr9X7+K1wN
 UQvqUG2Hpiqy1Y1ssfNqWWVvSuJSUdPQ0fpM5ODLAUSAOUacyTO7TdGlN1d/Rs6dynUdw0kMujl
 MRBFGc9z/SexZNMKlleu7eQZ7mVObbhMAyhAAWS9mK5dmIUUzRXsthXWP2041J2WNzUjPNzZ47t
 nNF9e4RHAP4IK457j7JXGpj8uMmuP6YS+sothjZWK07rWahsRVSw==
X-Received: by 2002:a05:600c:3e0e:b0:480:1b1a:551d with SMTP id
 5b1f17b1804b1-48069c69484mr86252395e9.18.1769651009082; 
 Wed, 28 Jan 2026 17:43:29 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-481a5e18427sm3217985e9.16.2026.01.28.17.43.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 17:43:28 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v14 05/17] telemetry: check for path overflow
Date: Wed, 28 Jan 2026 17:41:08 -0800
Message-ID: <20260129014313.939831-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260129014313.939831-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20260129014313.939831-1-stephen@networkplumber.org>
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

The unix domain socket path is limited, check for overflow.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/telemetry/telemetry_legacy.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/lib/telemetry/telemetry_legacy.c b/lib/telemetry/telemetry_legacy.c
index 89ec750c09..1d73282ba8 100644
--- a/lib/telemetry/telemetry_legacy.c
+++ b/lib/telemetry/telemetry_legacy.c
@@ -102,14 +102,17 @@ register_client(const char *cmd __rte_unused, const char *params,
 		return -1;
 	}
 	*strchr(data, '\"') = 0;
+	addrs.sun_family = AF_UNIX;
+	if (strlcpy(addrs.sun_path, data, sizeof(addrs.sun_path)) >= sizeof(addrs.sun_path)) {
+		fprintf(stderr, "Client path too long\n");
+		return -1;
+	}
 
 	fd = socket(AF_UNIX, SOCK_SEQPACKET, 0);
 	if (fd < 0) {
 		perror("Failed to open socket");
 		return -1;
 	}
-	addrs.sun_family = AF_UNIX;
-	strlcpy(addrs.sun_path, data, sizeof(addrs.sun_path));
 
 	if (connect(fd, (struct sockaddr *)&addrs, sizeof(addrs)) == -1) {
 		perror("\nClient connection error\n");
-- 
2.51.0

