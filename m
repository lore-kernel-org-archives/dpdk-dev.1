Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC80CA0EE4
	for <dpdk-dev@archiver.kernel.org>; Fri, 15 Aug 2025 11:15:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7F9DB4026C;
	Fri, 15 Aug 2025 13:15:28 +0200 (CEST)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mails.dpdk.org (Postfix) with ESMTP id 720F14003C
 for <dev@dpdk.org>; Fri, 15 Aug 2025 13:15:27 +0200 (CEST)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2445806e03cso20138775ad.1
 for <dev@dpdk.org>; Fri, 15 Aug 2025 04:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1755256526;
 x=1755861326; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HbRlgleKAh4uu7c/8hixA1bURFlifZPILrRRn5bKgYk=;
 b=A5PP1uky18NVTn6oQfNuCAfH6ZkJhOJGrOT3uswManx5GvBfGWDMtEc6LsVPPF2YUm
 Z3jIbGARRtJz4zzakqsNuqo9D7bZmqlwG5dyaOt38gNAHu1jSINNB07MniXeB1GrCAu0
 Vf40LVqIybnbJkuYBxtdp2o5c6w3ZKpCyFvfYTQSZ/QvZ7GD+oDpF84E0VHlr2TQBNKS
 9mRpmflRDSwj/k+3jkMuHG0XI3M5N4w1JWaCDp89JVqSm7zIZGH6Lpq1ncNNagtO1ktG
 Q1n1/cnxSowvlmCXz/93+3VzKBZQwiu9Sxz6iW2FWdX5IYhJrBKQ2XeN7kyV+Wlf71bI
 zLPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755256526; x=1755861326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HbRlgleKAh4uu7c/8hixA1bURFlifZPILrRRn5bKgYk=;
 b=bDZPli0tj+H+KP/FQUsO03C5WE/dU8lJpOZg9tetmKLf5T9LbXedeUKHKIHrD4ehC5
 a50tmfDdemk7aFtTIs9ZyxFjCoBTGPZU80QP3kMGcPP+hlYr54MxrOYvK7Zy3RHHKjYh
 AvmwbSY5DBLLGZE26JExiOuC9Y1WYpcyK0TVSx/PTiKuBsmo0WSSOsJJiDelei6Em62T
 f9krPsewpjy1ATVxMkKPBPbLZ9kbWX67r1XOF7ZklxwR97Bxxk8/2KWSs1hvf4RnKfGT
 ZhM1ezR6GmCjJ+Py28fqi7gW82CpjXPd5jggV6wOrybKeeLozDDFnCt37dXSGW9Bvf+8
 cmYw==
X-Gm-Message-State: AOJu0YwNrUvKz8+3lke5xST3ry8dA/OpIZS+H0+2AbceOqLhSsaYez5b
 45ryvblUjkx6c+3JeuLAd0Bk4FzOterKkWsMM+w7Uvj+p1Ab5kHGAf5UIeUVPUn5TT0=
X-Gm-Gg: ASbGnctmYPmMvffiyGuSs0Mt+aridkhvdOD+fPKTsJDuFrrZ6nEl950v2pFcvfCr6E0
 v02es5pnxbz4IgnanNobOrObyOW4oDeG1L1jrjHd+2rOHNt58LTmk8RpKG1BUtV1qEhRGsdEQQ6
 G/+S+b58TXIob5sVwRz8JNdpZVqAYJqOWUhCcOzr2XjXHNZ0itnbFO5GfdgXHdnzkVSpCLs2XZo
 INvOBliUYWuOK3kOHk6zQaArCM+jSrc/tcU83Bc1u5bnet38mN4xbsnsiQ31rrpB6obDUgLaact
 ql1NNxVC8aS7DDPsw/p+pws2c18RX1f0FRVz5IwK0b5DpZmuVQEWM+fqvEYwQv1D+sZ4X9PS/G+
 tXW85UVHgL1FqmjhLNg1q5FjSL8HD69CdTSW4BvTpGMUpXUgL
X-Google-Smtp-Source: AGHT+IEWkLAbSPGkGLGgz/qfAIOAfraBvOfzqoHEJGEgJ91A8A4TxHvcoaSHIgN8HL5Rpt5dfqwXVg==
X-Received: by 2002:a17:902:d482:b0:242:c66f:9f80 with SMTP id
 d9443c01a7336-2446da0196cmr25008785ad.53.1755256526399; 
 Fri, 15 Aug 2025 04:15:26 -0700 (PDT)
Received: from localhost.localdomain ([64.62.143.197])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2446d58b80asm11741285ad.160.2025.08.15.04.15.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Aug 2025 04:15:26 -0700 (PDT)
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
To: Aman Singh <aman.deep.singh@intel.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>
Cc: dev@dpdk.org, stable@dpdk.org,
 Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Subject: [PATCH] app/testpmd: add contrack CT state inspect commands
Date: Fri, 15 Aug 2025 07:15:14 -0400
Message-ID: <20250815111514.3866449-1-14pwcse1224@uetpeshawar.edu.pk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814085831.3511020-1-14pwcse1224@uetpeshawar.edu.pk>
References: <20250814085831.3511020-1-14pwcse1224@uetpeshawar.edu.pk>
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

Add command in testpmd user guide to inspect conntract CT states.

The conntract possible CT states
are SYN_RECV, ESTABLISHED, FIN_WAIT, CLOSE_WAIT, LAST_ACK and
TIME_WAIT.

Fixes: 4d07cbefe3ba0 ("app/testpmd: add commands for conntrack")
Cc: stable@dpdk.org

Signed-off-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
---
 doc/guides/testpmd_app_ug/testpmd_funcs.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/doc/guides/testpmd_app_ug/testpmd_funcs.rst b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
index 6ad83ae50d..1653fcdbee 100644
--- a/doc/guides/testpmd_app_ug/testpmd_funcs.rst
+++ b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
@@ -5392,6 +5392,12 @@ rules like above for the peer port.
 
  testpmd> flow indirect_action 0 update 0 action conntrack_update dir / end
 
+Inspect the conntrack action state through the following command:
+
+::
+
+ testpmd> flow indirect_action 0 query <action ID>
+
 Sample meter with policy rules
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-- 
2.43.0

