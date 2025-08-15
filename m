Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65171CA0ED1
	for <dpdk-dev@archiver.kernel.org>; Fri, 15 Aug 2025 11:12:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2C1A24026C;
	Fri, 15 Aug 2025 13:12:43 +0200 (CEST)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by mails.dpdk.org (Postfix) with ESMTP id 643B84003C
 for <dev@dpdk.org>; Fri, 15 Aug 2025 13:12:42 +0200 (CEST)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-76e2e88c6a6so1773363b3a.1
 for <dev@dpdk.org>; Fri, 15 Aug 2025 04:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1755256361;
 x=1755861161; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HbRlgleKAh4uu7c/8hixA1bURFlifZPILrRRn5bKgYk=;
 b=z7ZNmTIl/HrOW/59cHiRw2FyyRl9gGwVgJ3s5Go0iTmQtlj3VWykb03pbIOnRmigAD
 OB0sH3TmqIJrRuTkxKwelbI0+2KlQvzNsM0/n3EvUh0cGg2pu/uvuckcEG390/O6P/0x
 MqZvfvLI7f17jc3HJ41V0zUpS1lCqAlZTgg15j9gIrMGRp3pdK/ouzb2HKUiHq/M4ZUr
 TEl/MnSrR4k+fisApyOW3LSWXbbYodFZsfNBCiYKh1pmpIk2zAc9OS8cwR0Ho/gjr648
 VypKtjNW/Zc59mkwyZRAT+nmpCJNFamuhTgXJkGBKq5Q/tGewPMex2N+Vu810HSO+TUT
 abww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755256361; x=1755861161;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HbRlgleKAh4uu7c/8hixA1bURFlifZPILrRRn5bKgYk=;
 b=a5DIa/LpanxCv0V60ftLjlnrHQhTlJdOjEkAxa83Y/y7qBNqMFQxKy/dmucsz7QwwO
 bGEIlcBJ0k4cHQk3l3A4SUXRDwgRgLJq/E6BZzyLYtB+jaD4gxTcbMCkn0h4D08XOboq
 2T61MZj+Dbua6dKNxSDpEtEgkQvZPqG9M/aTDk7rCLbuPX9f1B+ncjDq/p/o2HoorQo6
 zA5FB4Hr3HpGnKpujrPsEOo+aUoHalfY3GCMMTOqJbvTi7RAvQJ8H8ZUguKnqgamRAtx
 Whww/0tQmQN5NxHyoAN0Jth8TjmYQn3RdkpeVeA/BrUScPE79d4X+svwISi1KzSQ1PFT
 ULsg==
X-Gm-Message-State: AOJu0Yw+z89i8LaC0ST+ESa7Yoj2c06MtaO1EGND4KjKZMjKfkO/ZnUf
 wxTuylCtU75E9x0Tj54yNokHObOKU1R7ZFndQHLKzYjmDX7d4BEQGuhVwpH6Xu8N2lY=
X-Gm-Gg: ASbGncs5hDBiXFu6OevkzZmX4GzYMYNYEkDy/julcBGY3jSTkDzWywGfQCzgs8lEcCW
 2NcLWa5qHnxcukP/sVZlTrCFlq33h+TomTGYpwjmFJywpO0J14nTatwsLclqYs5YArzjqgNU4dX
 4rd75IvDyv2z/IiI816QrNQ5/FIRpav9aWT+mkCxkX0CKjHxgVGs6V8/RVqBOk7oJVB2DZJcYel
 SFQvj+jaWCazOJ5PYY0u9kI5cgUTJm1ivYp7Z3+VbSeRnswAfmrpNe1wtslSB+55yJr1nw6d0TW
 MPRIsLo+Qve4yGO6MYLlBkQYNu/jrMgjcehLzjIHPrfq1+od5tos2bT2jdc91T1zLiiC/FbYzDr
 OEtngZ4W/NS7w+rTlilprX0jDLVO2vRxNxtUsjtjDAwHvecbu
X-Google-Smtp-Source: AGHT+IG6MuoN0tChBHfOuWhFz8UyBc9Hhia3Iw6QZ8e8mWZ4xOR0RF3aJ0/sNA8xObCUidvaePqDvQ==
X-Received: by 2002:a05:6a00:3c8d:b0:748:323f:ba21 with SMTP id
 d2e1a72fcca58-76e446a92fbmr1985932b3a.1.1755256360984; 
 Fri, 15 Aug 2025 04:12:40 -0700 (PDT)
Received: from localhost.localdomain ([64.62.143.197])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76e45566fafsm913004b3a.73.2025.08.15.04.12.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Aug 2025 04:12:40 -0700 (PDT)
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
To: Aman Singh <aman.deep.singh@intel.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>
Cc: dev@dpdk.org, stable@dpdk.org,
 Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Subject: [PATCH] app/testpmd: add contrack state inspect commands commands
Date: Fri, 15 Aug 2025 07:12:00 -0400
Message-ID: <20250815111201.3865042-1-14pwcse1224@uetpeshawar.edu.pk>
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

