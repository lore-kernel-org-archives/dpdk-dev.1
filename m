Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88CC606A31A
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 20:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iol.unh.edu header.i=@iol.unh.edu header.a=rsa-sha256 header.s=unh-iol header.b=VN3F33nB
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4FB0140151;
	Mon, 26 Oct 2026 21:17:14 +0100 (CET)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com
 [209.85.222.172])
 by mails.dpdk.org (Postfix) with ESMTPS id 6312540041
 for <dev@dpdk.org>; Mon, 26 Oct 2026 21:17:13 +0100 (CET)
Received: by mail-qk1-f172.google.com with SMTP id
 af79cd13be357-93f1ca4132bso290054685a.0
 for <dev@dpdk.org>; Mon, 26 Oct 2026 13:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1793045832; x=1793650632; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kF72MyyD8MJJ6puH1APCgDZYRgAbAh8pnjyqkFHrLs8=;
 b=VN3F33nB8uGzgcZ6337AyY+43bPwGFKgvVve5J7WbFyrDJ5wiAhFF/MQvQqdTKU0Jf
 y4YEowXODYw6cXaAGqdsyvtJhU3zdkBonBSt1gUoTU8gRfJYh+bohWfWxMqwBDKydL7H
 g3+/O1cAxBa+hSmlkQQSExl4gYWCctlBZQ9Jg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793045832; x=1793650632;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kF72MyyD8MJJ6puH1APCgDZYRgAbAh8pnjyqkFHrLs8=;
 b=0Ij9kU4y5wRJ62NODbP95Y5412WlqDezXIz5SglEYgwuWs/AQmZztjA3eatGbaO+UI
 LQccS8gx4GaVfyNT18F2xC9w2kazv0Y9VGoEcbv5OlFnDMEf5MV+Z/I9GI/ZH7MWynxQ
 7Ep0JD5FTXfjgMm9ebBeMnN2yJ22M5krMyADFxh2xFxH+hjJzYs9nHrst9N/HZdIBsoX
 CLLVLxejeyItoTJMFno0YrolqMcluFj3+E/FYcXDgZWwi/oLAxvNhAAkG8Pt5fQmBrGf
 J8xp9xuqAKU5kZCn6n5VoNaI5ntCQpb984r57fD8pTTj2TVAjEfQQEAJo0NqyeFcT+84
 crag==
X-Gm-Message-State: AFq9FYLExOW/W/vX2qV0ZdE7x8ayy7n9ED4v7lTYWJo7E58sEpThREvt
 Efwi7ol5XDiX+luog2P0dz0HXGeD2HaRa8hNlR+oBQPoFA25mqjBIHLbV8CcndtGNSj+Pd9ER7t
 6tJWVJhoC0Qx7j1VHg2v4Gy+ia9tgIoGqjvi+wgD8CNtVwb90XfKyhM3OvEzFPscO8cf3UrSRFZ
 +3Cr1k7NMeYT5aAoLmtKSmQUNA7ZA=
X-Gm-Gg: AYBFou134oPsSAwC/VKKtfUDdiAxQnWxj/HfP+MzyPw3MXo2aMLaWldMD1s7snytghf
 3Lzk6hHml477GLJxA162RID79ysURNf7kzNNgCu2WHojlclBFntrliJt+6py0w67ighYwwdZS4P
 sJc10qQUBizdzY7vjSkFsXg0wgFiCfXVEiCpJQhYzR2PLgJW+fuw/qsMcgmBRtiTua+Yu7GkDQw
 udStoWDw7xmUVopHIJOut7QhVypeBeC0FkpBQRwj8WhUzvpdo/bZp3tgOlCXf3STL+QZNpnD8MJ
 9b0wpvP+y54meBHBDWNwdrzOe3+BaVjxl5D51W+E72FpLYR/4RTIi14A8O3IxGmeL6MP9fDdFt2
 em0U/B29YJNGwthFVwd0HlqMe9JwLVuyrx3I7vTQg/ouryCTSGL8Wwcpih8qQnGdAZIi63l32kM
 QeL5gT2G+H8w0bLaPwT406p1nSL928GPGKFKPJn7qP6I+ELYu6sWjl0N9r8nrlCb+ZxG5v4KMFo
 r1/26HvH8/AnpX7OGLWVL415UQepy/eaihDT8P0Y8yRUrwAv3xJlWd3AvO9AObMO0scwwj3//tO
 3A==
X-Received: by 2002:a05:620a:458e:b0:93f:216f:f404 with SMTP id
 af79cd13be357-940ef956be3mr1165183785a.40.1793045832080; 
 Mon, 26 Oct 2026 13:17:12 -0700 (PDT)
Received: from d121029.iol.unh.edu ([2606:4100:3880:1210::219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91c47c50e10sm81969766d6.25.2026.10.26.13.17.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 13:17:11 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: dev@dpdk.org,
	luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: knimoji@iol.unh.edu, lylavoie@iol.unh.edu, dladd@iol.unh.edu,
 Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v5 0/3] dts: add verify coverage for cryptodev testing
Date: Mon, 26 Oct 2026 16:16:40 -0400
Message-ID: <20261026201643.72369-1-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20260428193541.79005-1-abailey@iol.unh.edu>
References: <20260428193541.79005-1-abailey@iol.unh.edu>
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Currently, next-DTS only covers throughput testing through the
dpdk-test-crypto application. This series adds coverage for the verify
option to next DTS to allow functional testing for various algorithms of
crypto devices and virtual devices.

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
---

v4:
 * Rebased on main.
v5:
 * Updated commit description

Andrew Bailey (3):
  dts: add directory for test resources
  dts: fix cryptodev verify parsing
  dts: add verify coverage for cryptodev testing

 dts/api/cryptodev/__init__.py           |   3 +-
 dts/api/cryptodev/types.py              |  20 ++-
 dts/test_resources/test_aes_cbc.data    |  27 ++++
 dts/test_resources/test_aes_gcm.data    |  19 +++
 dts/tests/TestSuite_cryptodev_verify.py | 162 ++++++++++++++++++++++++
 tests.TestSuite_cryptodev_verify.rst    |   8 ++
 6 files changed, 226 insertions(+), 13 deletions(-)
 create mode 100644 dts/test_resources/test_aes_cbc.data
 create mode 100644 dts/test_resources/test_aes_gcm.data
 create mode 100644 dts/tests/TestSuite_cryptodev_verify.py
 create mode 100644 tests.TestSuite_cryptodev_verify.rst

--
2.56.0

