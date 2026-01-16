Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D4CC982C3
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 21:31:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 85BED42EED;
	Fri, 16 Jan 2026 22:31:15 +0100 (CET)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49]) by mails.dpdk.org (Postfix) with ESMTP id D353742EE8
 for <dev@dpdk.org>; Fri, 16 Jan 2026 22:31:14 +0100 (CET)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-432755545fcso1458221f8f.1
 for <dev@dpdk.org>; Fri, 16 Jan 2026 13:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768599074;
 x=1769203874; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZExTml0EtLcdHeef5vXE8LgMDL8XIEo96IfvK8qTn7g=;
 b=DdxSudg+VWGXw9xh5qlFQr2s859yxe9hyzy1f7SviBvGsB8TR+ZDJXypo5QYZ/QFUK
 wND+wqhQ+XQC2cjkFFi1LEDB7tGFDFikIu3aeFBjkSncSby0ahBOapNLqOk2zQX4eXSr
 viqIWt1O2ttxEEllUA+t3TvtfJgC+LEUx870FsW5kEstEnSiHy7cFe4UG1C0i4AV/KXY
 ilmF7LXWQSyh94A2w242uWSRgtX/Cl+TVrgBjjhHrg+FmBDfPBS6e3yvV0JHpkR6cm9B
 ZiYFisXWrH1ryuzsOgkerUj2VG7LCIQkpF0/s1V1vxtoj+aQKmo68sV31WXoHWPNnWWm
 FCqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768599074; x=1769203874;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZExTml0EtLcdHeef5vXE8LgMDL8XIEo96IfvK8qTn7g=;
 b=Afgf1hOq15lEHAL/K/ZrSNM02d96LYmdta96nX/o3qfAKdvACLeBihZWiOIfVFRysR
 4GbB1Qri2QB+Bjrb24+09rTu6P9Uy3AtSfXOuKkZHXNx+XTeCC2OBk62NNJwCKzBAh3O
 SoxUeWoy7c0vwCViyQUI4HS1zfvn4B9SDX6H7M3e3YX5Ekq4Z3xV0mllRedN1+d9e7NT
 ld/11FnppQnkL7APgqqL9nhx0VhJlz/hxrw5XM1tjx5NYWvl4cUn4KI9KvjidXv6HJzZ
 ulNedQY5HAvgTIvRTaYPqTu1PyQ0S77S+SZrrLnY3Cwy/0JG2SkIeC6jwcSdYk/yBePB
 Wj4g==
X-Gm-Message-State: AOJu0YxMwkQUPpnJzN9CrMmWD/sIIC+I4pCRzjLnT4jnuMAIkVrCSwRP
 KF9dYMPM5otY6BvNPo0Fmi+OFhwCUhZdHa92US4hufaJBBII9Mg1+30DeOaWskaODQXLn91zAgs
 ZFIjz
X-Gm-Gg: AY/fxX6p8VYjjvbuhbGJLej6NCjXhtCI62qebbuyisOuU3l+a7oNqw/ASsq2KH8OSrO
 EnDgAx6FYQDisXRrogYNs+Cp/4VH1CaLEXdfuztj6OVsdmAYnMXhElSsi6LSqBGdIAMXnh0lHdr
 8RYLk+9zLtWegJ84N1dIojaB7idzZGFTxQnrDbqTip901+5jN73JZeveZM5vY67gZr6agrvvLya
 7tDSYXQq35oc/+tYsBBXghHOfbOD4TxyXYhoWdlgjkP9Eoy8Bzv8aKg/WpPqwhSNQy3/UvizbhC
 pJmoGY2F7jJ18PstVh7467YknOOyDfsxtqFCZ1NQRBIhOA9IiyCFeTwZgz5MfcnwMG5ItmeR7Vl
 xUlfvG1+3cYEDR0qzcCjSWDo0gbW8Aa5TAjgbMZjSlvPSX30wFLI02jwWYfCv57m4qNV3UFVfMr
 b7kXiVNP69Ps5WAsypiLkbAiy7kIhuhVBXTAF1ctyj+Y03eAiwXLn6Ef8jsZ/2
X-Received: by 2002:a05:6000:26c2:b0:430:f272:3489 with SMTP id
 ffacd0b85a97d-4356999cae1mr5093548f8f.28.1768599074446; 
 Fri, 16 Jan 2026 13:31:14 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356996e2d8sm7398759f8f.28.2026.01.16.13.31.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 13:31:14 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>
Subject: [PATCH 5/5] doc: correct typos in traffic management guide
Date: Fri, 16 Jan 2026 13:29:36 -0800
Message-ID: <20260116213100.110419-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260116213100.110419-1-stephen@networkplumber.org>
References: <20260116213100.110419-1-stephen@networkplumber.org>
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

Two documentation issues corrected:
- Remove errant asterisk from "Head Drop*"
- Remove duplicate phrase in WRED algorithm description

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/prog_guide/ethdev/traffic_management.rst | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/doc/guides/prog_guide/ethdev/traffic_management.rst b/doc/guides/prog_guide/ethdev/traffic_management.rst
index c356791a45..086eb9d3af 100644
--- a/doc/guides/prog_guide/ethdev/traffic_management.rst
+++ b/doc/guides/prog_guide/ethdev/traffic_management.rst
@@ -109,15 +109,14 @@ They are made available for every leaf node in the hierarchy, subject to
 the specific implementation supporting them.
 On request of writing a new packet into the current queue while the queue is
 full, the Tail Drop algorithm drops the new packet while leaving the queue
-unmodified, as opposed to the Head Drop* algorithm, which drops the packet
+unmodified, as opposed to the Head Drop algorithm, which drops the packet
 at the head of the queue (the oldest packet waiting in the queue) and admits
 the new packet at the tail of the queue.
 
 The Random Early Detection (RED) algorithm works by proactively dropping more
 and more input packets as the queue occupancy builds up. When the queue is full
 or almost full, RED effectively works as Tail Drop. The Weighted RED (WRED)
-algorithm uses a separate set of RED thresholds for each packet color and uses
-separate set of RED thresholds for each packet color.
+algorithm uses a separate set of RED thresholds for each packet color.
 
 Each hierarchy leaf node with WRED enabled as its congestion management mode
 has zero or one private WRED context (only one leaf node using it) and/or zero,
-- 
2.51.0

