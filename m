Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D525C636A0
	for <dpdk-dev@archiver.kernel.org>; Sun, 22 Feb 2026 17:34:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 016A540B91;
	Sun, 22 Feb 2026 18:33:03 +0100 (CET)
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com
 [209.85.160.51]) by mails.dpdk.org (Postfix) with ESMTP id 072DF4069F
 for <dev@dpdk.org>; Sun, 22 Feb 2026 18:32:49 +0100 (CET)
Received: by mail-oa1-f51.google.com with SMTP id
 586e51a60fabf-40ef10ec84cso2726974fac.2
 for <dev@dpdk.org>; Sun, 22 Feb 2026 09:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771781568;
 x=1772386368; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xU1IAXrRstZhf2zNkH6dFCHGGd6lrudoa5YbnSr1LX0=;
 b=r48njkWEWQs0g7zm3oE6VDY9DIHwAI7fE4L4nJ/eHlHLkYvTH1+ICKI0acvBHFafCg
 zgzI2IKQTOfV9aN5wicODfVeMKIJbHMelNSLfSVUrBuvZi1ePL62d4cFZzVrldSnAGgZ
 05H+kmJ9+RTYmvkYZaTFDIA6HB7dAgYhUNi1rvjXnPPz1S+xzLS43Dtaihs0XDYxvNf/
 sVca4oMhUowPMlUPPW7IU6PVFmxdrFiee7G95tm/TZkQjZxmxPMn9RLiP6GCbTT12fxW
 o0knghNqb6EgZeKJT86YE0+UTGh677KC50iSxoiex0mqTDG9C/qfn656BucJuocv9+HF
 smeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771781568; x=1772386368;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xU1IAXrRstZhf2zNkH6dFCHGGd6lrudoa5YbnSr1LX0=;
 b=FcFEfE/874HXfCTo0A6bH2B9KINlYvn4c5pQpl+JEVgPvMyR7Ec9Cl57Urhm/izkyf
 9xsstS5V/XdNSNXxMeQd3gBbY0sT1I1K9nVBuMzLOsRBt+8JQ2Ia96vlXbOUrh12s5Xq
 esQMYwiNB2sHqpq5+BN8gP3pXnRNiDfFmSDsiunJNVsfiqNBK3tvMenKjLkb6zeA3ahU
 XOFX6fwSmvVroU3t+Lu6M/s0rSxN6UZ4xLNR7y9E3l+HAsYgLfXtRjPnKReuQIDnQTa8
 meeXSbay2G5XmvqcQdpWtLx6R0Pnwd4fhh7izsljQ4gREwJliO5h5ZqoqbtEpmMpCLhg
 Dm4A==
X-Gm-Message-State: AOJu0YyG+NpnAuZGKvxV4MSpJhIzKgIFD45ZFgUHfWRArcrWc9gjfbDx
 q63wBYhHvibiq1HyNyPAzTV2dLexYVnLkPJthCbWHF34cfD9nU4dJbyo0NtLPoFSg4cgvuuc0yI
 k6ors
X-Gm-Gg: AZuq6aIXFg2rd6moH60vDXN3WEPhfpyYSqGbxngs9VxwLtrC3eoM9cugVoWrE1J6rWg
 egeb50HpyrkgGviI/SZlog0JwZqFUPalrHLBElamE5SB7kM1503sBKLTsabsEIb6vWuCUMG4B2H
 vixW4/pSU2+VOvXfm689O/tw82u23M6fxGTmB/dhbvbGt1c6q0qjg6yCW3u1FGffHU3/24fBlUu
 52di8mujrOs5PUBKvA/6pl8puAA94avVauze3+P0dlCMMRfErrLfbn8cyrluya09xjNV6zeionI
 neQxiwQin7yeObiaOpLAsJ5GnL18tlknqMO+Y60NdXVSsh7pqYJ4L0g4Q1BaTRWOLJOQu4O9Soq
 3qnJtdcUWjbGEW3kIMT0t2WzFBNYKO7XGd518pE86MNj6xB3+Nhnq+ILbffbw+dJGYpezTU9KR3
 M0/kMOeyYca8XL0X7qJgHqJbBZTnwy6Ng6dJWu3sc7iJP/QCjHjSObwxWiNgybuw==
X-Received: by 2002:a05:687c:2f22:b0:409:74c7:1cbb with SMTP id
 586e51a60fabf-4157abcb10fmr2625237fac.7.1771781568326; 
 Sun, 22 Feb 2026 09:32:48 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4157d2d7922sm5608972fac.12.2026.02.22.09.32.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Feb 2026 09:32:48 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 18/19] net/tap: enable VLA warnings
Date: Sun, 22 Feb 2026 09:30:53 -0800
Message-ID: <20260222173225.522754-19-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260222173225.522754-1-stephen@networkplumber.org>
References: <20260215195348.557945-1-stephen@networkplumber.org>
 <20260222173225.522754-1-stephen@networkplumber.org>
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

The TAP driver no longer has any VLA's.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/tap/meson.build | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/tap/meson.build b/drivers/net/tap/meson.build
index 7160e9e98d..fa4e6cbec9 100644
--- a/drivers/net/tap/meson.build
+++ b/drivers/net/tap/meson.build
@@ -16,7 +16,6 @@ deps = ['bus_vdev', 'gso', 'hash']
 
 max_queues = '-DTAP_MAX_QUEUES=64'
 cflags += max_queues
-cflags += no_wvla_cflag
 
 require_iova_in_mbuf = false
 
-- 
2.51.0

