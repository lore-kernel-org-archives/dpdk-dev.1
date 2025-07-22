Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E7B6C87FC5
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Jul 2025 08:49:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 44B54402A5;
	Tue, 22 Jul 2025 10:49:23 +0200 (CEST)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by mails.dpdk.org (Postfix) with ESMTP id 9F3EC40265
 for <dev@dpdk.org>; Tue, 22 Jul 2025 10:49:21 +0200 (CEST)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-75ce8f8a3a1so1117567b3a.3
 for <dev@dpdk.org>; Tue, 22 Jul 2025 01:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1753174161;
 x=1753778961; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z/bgWgJ56GG6Tca1mIkuntPAWn1q/LcgtDqcphuWWOg=;
 b=LoCAWyENYYE1x+3nzYIee35k7rMy2xaQIqY8N83wJuxKTPzW23u2YjVm4FgAt8mGTz
 I403BzJ9T1H8/GQsPhxbnURIPN9KeLJx25gi7E9Fpl03dykP6RwZVMfJVCBDCMClPAJu
 jcE7EUQl5GzYRAeyf+zk+33fQCou+zLDh7xMc53FYHJGOGICTC8LCRTB4dNZz+eWxxUR
 DmLOA1Lv/woBeH0+r8amxgeIP3Pw/qYXQMj6+slwdtqK7G7qZiGIJOlngFn6FnoZsm30
 zSHpPqjGwyeCjnI7bjXd4aXqTIyDNHs0HaxSLWs6UynGrATgwbQqIKyaP9jHI9MVWJ8y
 dfEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753174161; x=1753778961;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z/bgWgJ56GG6Tca1mIkuntPAWn1q/LcgtDqcphuWWOg=;
 b=JHh8XILHqcEpVz5dUU64xNps5HH03647YDMSavyMwgb4mEcemNZKiZw6mv8Ol9WjCO
 /pF2ud332tSrbhM3jJsfrL/bM7fVQ0MheGPy4h1JWcCYy7QSFTHxNX855QZj3yzrL6b8
 5YM75WL7LDVmv0b0knfdR4bDzXtIHkDyE2UWTK0aGGBV0PLLw/ZW1JLphn7zPEYCp6d1
 +yM2ADcYTZuIQWNr6G3KsjxIWh/zPwR1TAB6pLtDyq4dXjFmlO2oX2UgFl27NQLJng1A
 WG8vmcF9/aMcjtix3rcRUw3VeYW6nu1X7S8vFnNZgSGD7F2pOfIqLZWln+i7Ji9N3GEH
 9uZA==
X-Gm-Message-State: AOJu0YxilxB2wuHR9enGUqrzRG8J/22kHD+c6/acvL1rmmL3fuDaYKF8
 urNEAZd3EcmhFnYblUeIOJkLBoDNaVmGbTxdqJqoc/ViDrssGyc/HIVrui1Ax6iZjJrAJyBWLZj
 KvnmmXYYoXA==
X-Gm-Gg: ASbGncvXUfTkiVOhlKXRU+gSaMAYxeKJNdhfuqisW454oLOQwhwybakOoseILZxgEiN
 DKAeOdtMdaoGNaP+mhfWG6sqzDr15uzzjJ1WvIP+Im0S3bkqRQF4IiM824GD9B2LorgjXlYQf1n
 HjZYoK8fX6op10EUhT7eUO0i/WXWZ0V+JfOdXVziKq+dQkit5WW8W/mO6ngL8NXEggVRVUcZH0I
 GjT8el8oe94Tm21XGf7S5+E76hR/M81Vqk6iQtfgLCgobXWwEcy+lC8ApBjp/aRlsDLwZJXFw5x
 6vGc7BPoQ7mzarRP1l5S4yBI2hDYwMn4Ymx1YMnvHvf1kH7eL2/NmfStA/JqnouQO0kVVIbbkCY
 jPymwqT8zpxbyUdA9PVm6pwggBX/vXCpdJCSEd4q0mZlvS6No
X-Google-Smtp-Source: AGHT+IHqJn/m0fa/cSq4rYvD9rwwKA8XdIzRT7dvZ2hRfejOfNOVAWG+Erwnr3/tnOzbVRWap+ycLg==
X-Received: by 2002:a05:6a00:2e91:b0:758:b81:603a with SMTP id
 d2e1a72fcca58-759ab63965bmr21830050b3a.2.1753174160605; 
 Tue, 22 Jul 2025 01:49:20 -0700 (PDT)
Received: from localhost.localdomain ([64.62.143.197])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-759cb154745sm7247059b3a.91.2025.07.22.01.49.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jul 2025 01:49:20 -0700 (PDT)
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
To: dsosnowski@nvidia.com
Cc: dev@dpdk.org, rasland@nvidia.com, stable@dpdk.org, viacheslavo@nvidia.com,
 bingz@nvidia.com, orika@nvidia.com, suanmingm@nvidia.com, matan@nvidia.com
Subject: Re: [PATCH] doc/mlx5: document firmware requirement for flex item
Date: Tue, 22 Jul 2025 04:48:27 -0400
Message-ID: <20250722084827.1309401-1-14pwcse1224@uetpeshawar.edu.pk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250721132120.x5knqldvshgfwjl6@ds-vm-debian.local>
References: <20250721132120.x5knqldvshgfwjl6@ds-vm-debian.local>
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

Hi,

Thank you for the clarification.

I was using this flex item configuration to offload a custom header to the NIC and apply match/action rules.

Looking forward to the PMD fix and the improved documentation.
Thanks again for investigating and clarifying the firmware requirements.

Best regards,
Khadem Ullah

