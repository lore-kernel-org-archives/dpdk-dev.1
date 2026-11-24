Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC8D606A321
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Nov 2026 18:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u/ZfzeJL
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3DE534060C;
	Tue, 24 Nov 2026 19:03:25 +0100 (CET)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by mails.dpdk.org (Postfix) with ESMTPS id 6BB5F40609
 for <dev@dpdk.org>; Tue, 24 Nov 2026 19:03:24 +0100 (CET)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4bb61185057so31907555e9.1
 for <dev@dpdk.org>; Tue, 24 Nov 2026 10:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795543404; x=1796148204; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=w2HDrjglrOBs+MFTCVasoYjJOqFkNO8Un2gN9LKtteY=;
 b=u/ZfzeJL2oy5E3XoxaE0fE24+XKfoYbPDGLAkncMQd+N0/w99ntkU2ZuqjzRVLmSaZ
 Bl84XI26weJq1Yjy2AWonYp+u3nW/w5Xw0Qg5UCiraGZnbeQq3co70IIwkH0QVUX84+J
 4SlIjmuAQN+Qin+orBME2NCbtnozQSWNS3Xw9Yoy1oBuIxpfKzjImjvrF3iUbNxBFtVk
 xZtQc+9uOQMoqfBptEvWb1bhMSmz3FmQwgzAkGb6eAeWlCPJJliKj4cfklO7Vs/b3HJS
 RJI2IDewb/axmDCA04ZAIm54ypMvpp8AFjpGlmV1oNfZl3tmCYUd4m7S0pr/5bxJElBg
 7q7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795543404; x=1796148204;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=w2HDrjglrOBs+MFTCVasoYjJOqFkNO8Un2gN9LKtteY=;
 b=KXvrrznJVNkD1tPI88PEBp9zRQDPboeNWLZNB7EgxcJkJX+nW6TXGHsnXbWfGPQNxe
 LkXXn3XrnZ/+NNnBZ2jYqpqt1GwGpXRm6Rrd7y1HtW9hUl+E0Lz3e1xTTxG4tgxVFy9/
 q65K/F36z9ZmFkIZ7LylNCZCzTKpUnk1Q5VeFeVwiVMOkaZ2i+Q6lYCzPwsPEuwza7VH
 6GG1+GXeWix0xo66yo9FyiecbvrLi70wAw7q13MzIKPbmDd0E7w9fa+jpPxIMkHdF+01
 VUYb8/IOPePj3k6Oudc3RbCPNNZfyzVp7pUPdoS3Onm/FsuZ4RzC1B4y9WdgimlShEhw
 uFow==
X-Gm-Message-State: APuU4Z/1hN8NMBFLjoU3ykcHL/jhSrH9ZRNkv9+KaKJJUJoaw6LW6PR0
 Sgf3LM8/jStIgYEGAVTFYPanQNN3pQr2dYr/4JpPX5iy28HpXPAr87gF
X-Gm-Gg: AZFdTZd5RPGHjh6/rEFmRxv8e+08m6tePGtXvZvzBdjg/zX7JSvnZx3S65VOVVYL4UE
 h0OGy1XFZt2XfVxk0lJfg8R5WO5/LXItmiZin5+Oh4qxvxn9tfSg03luVIX+FYwTLlBdLZGWFGu
 TuR2vMLe05oUn4J9SSK44Ela9HeRKcwd2ztDGqMvNCUTZbU8mbI/KUhm/I/rA/GETXGvgwzsk/1
 875wrWW/LQVwcvVz+NQgdn6WaOHK5PtQxdb53SBp8X0/P5ZIvnnT4Elb6MUqXeyxPxJJ1dFqeaH
 BRKEH+Nm3Q6D0KoUp0dkE07Mh2zwX4Z+/mpxELYSPgn+hy7cDYVdiBCdRNuoBHtmdYayExHurIB
 MCHVseXbgZbVWHEt6Uw+UDk4rg7HeAY3yzT0xU42tquJJoMIHBye66Ev0wYkXQCEpKBnDroAEgp
 lczfRt87/eW7L/5DxXchmCB7Jdv5J740G0BMG5dBl4Y8qLuyXJ8lWGfrT2tZXmFUPyuFIoePijB
 F6wRB233SgmeCbj1tluRnwHM3Z/dDgmR7xai+Pni7DkE0HsJ1rf4/hSc58gi1pg6FeEIsa5Hose
 BL5oiR5uinvt/1FlgM/kTsjgg7WEbEwQ97usxBk8QNpba8CxWNMma6YZohpa
X-Received: by 2002:a05:600c:848a:b0:4bb:6626:5a25 with SMTP id
 5b1f17b1804b1-4bb88813462mr273818975e9.20.1795543403914; 
 Tue, 24 Nov 2026 10:03:23 -0800 (PST)
Received: from freepad.home ([2a01:e0a:1248:bd70:ee15:c1ae:fed0:c345])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884ab091sm647065505e9.11.2026.11.24.10.03.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 10:03:23 -0800 (PST)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: vladimir.medvedkin@intel.com
Cc: dev@dpdk.org,
	rjarry@redhat.com,
	Maxime Leroy <maxime@leroys.fr>
Subject: [RFC v2 02/13] app/graph: zero-initialize FIB config structs
Date: Tue, 24 Nov 2026 19:02:38 +0100
Message-ID: <20261124180249.1099506-3-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124180249.1099506-1-maxime@leroys.fr>
References: <20260331214117.142495-1-maxime@leroys.fr>
 <20261124180249.1099506-1-maxime@leroys.fr>
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

The FIB and FIB6 configurations are filled field by field, which
leaves any field added to struct rte_fib_conf or struct rte_fib6_conf
uninitialized. Zero-initialize them.

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 app/graph/l3fwd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/app/graph/l3fwd.c b/app/graph/l3fwd.c
index fe25e43da8..f077cfea7b 100644
--- a/app/graph/l3fwd.c
+++ b/app/graph/l3fwd.c
@@ -24,7 +24,7 @@
 static int
 setup_fib(int socket)
 {
-	struct rte_fib_conf conf;
+	struct rte_fib_conf conf = { 0 };
 
 #define FIB_MAX_ROUTES (UINT16_MAX)
 #define FIB_NUM_TBL8   (UINT16_MAX / 2)
@@ -41,7 +41,7 @@ setup_fib(int socket)
 static int
 setup_fib6(int socket)
 {
-	struct rte_fib6_conf conf;
+	struct rte_fib6_conf conf = { 0 };
 
 #define FIB6_MAX_ROUTES (UINT16_MAX)
 #define FIB6_NUM_TBL8   (UINT16_MAX / 2)
-- 
2.43.0

