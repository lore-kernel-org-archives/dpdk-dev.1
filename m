Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A02EBC83F26
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Jul 2025 05:42:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 812AD40668;
	Tue, 29 Jul 2025 07:42:49 +0200 (CEST)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mails.dpdk.org (Postfix) with ESMTP id DC48640668
 for <dev@dpdk.org>; Tue, 29 Jul 2025 07:42:47 +0200 (CEST)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-23c8f179e1bso58944045ad.1
 for <dev@dpdk.org>; Mon, 28 Jul 2025 22:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1753767767;
 x=1754372567; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5PryZlsNiAugyNBpO7ZPlbkUAuslHH4Skk8dLlDpCV4=;
 b=TEgm1+QdU3CMbcP2vjOdd61udtoK2q1/VUUWLOUomMKk1Q3NbUnFIhJ0CGmZ+eYh49
 ztL/ClEGPWZisxILKQFf9UdkAe1CC5loYlb/IO1UXhKEhgwqGeLjSDpWEaWAQ9jtiRjr
 dnvaZ9F3edqtnNc8wuxIqFAXrK1iNmaFHJjFO0ap1QWAEVADBlXNPwdTYgQKph8I4HjN
 Z8d+pfOlauVIOTNHxb5I6wADpS9FePsGPccwSnRcWbW7zharZmSlKaGlb6FSciXpOcw+
 1tPhVBVb//M46Pgo7JzxbDU3mzId1XKJ3AdN7HIItW/Nn+9X3tu3m5HgUE6dndVTisPL
 g7yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753767767; x=1754372567;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5PryZlsNiAugyNBpO7ZPlbkUAuslHH4Skk8dLlDpCV4=;
 b=gSbYaOPRDRCR51M2VpDVupEDnx7KOeRHVSWvAXtj/OfmRe8D1Pihc6L1S6EfGd2Slx
 GOpl/4JQfi9MqEzVQMIczH7SnY5pQhuMBrGicdr0DRyLQ/lrZyN7HztBQdWkz/uSF5U3
 WzSCy+2uDJ7Vf+IixK3eZYKeFawuhkEiBdGIx/Quj2awBl1/4TaRApziO0Go8/vRligs
 d05X6vXwQ+S+Rp7k/H8JpdS8nih+NUDn3VJhbog9tjaa2SYzg96MTOV/QwgEtrFSejUf
 ut0Mg/GZkmI5xZjiLYbA6t1Eer9ExlAwnpNkZykDDWynORl9AQC+f3ia9UVR3C/ERnfo
 08qA==
X-Gm-Message-State: AOJu0YzalZdQlAFx45DOPddP4hMusBv6yfn3hdpt79qSw0h1YddXNHXB
 3tox42DtRVO5/jYxHZWVSoR4saNxzgPmpt8ZlE+h+75KVmDvMtLI04JOYfgoZ4ciV58=
X-Gm-Gg: ASbGncv83+3kktJbX0bhNxh6Hh0u4Ne5NM0r12NghE4eNmFokulUkCXIeXAAjl9Txxp
 X1OmDQSD387r4UH1+oDlnl+HagDoLjaO+AWW4rmvMF6n6DOUb/LfB501KlaR2oqIdJN0BeApX6D
 X6E+5xgZGe1l1BqWbuI2Y9ffee/UZ0Obx3KR+pOxFJGzLiluRgKKPlhp/KDMJhFcmb9RE6sFcg1
 4RA4oQT3Ktp+InSt+SryhL79WBYyNZZ98RapMH/gr+H2szzxUHd9FvuHFWxakL03j3vw/2DoUaY
 O3nNfEnweBCX0+HsS1lXBeOXTzicySvCauVUyp7fjBDiGrGuVRheATA/3VXI+vAe7jpu4L95ION
 wlFoEGfJT4AY+o+PvR9KYuNvMB0WO014U4bZGl6Nqjxn5FFZx747WHiU1fWg=
X-Google-Smtp-Source: AGHT+IHOjHuETRifnGJm8k+eiqM3xcVka+xSNUD8RGuDUSTsMompGl8cPYNXS0w+QXCB3KNrpKdmEg==
X-Received: by 2002:a17:902:ceca:b0:240:2bb6:d4ae with SMTP id
 d9443c01a7336-2402bb6de62mr74010375ad.30.1753767766899; 
 Mon, 28 Jul 2025 22:42:46 -0700 (PDT)
Received: from localhost.localdomain ([64.62.143.197])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24071bddcfcsm5456375ad.4.2025.07.28.22.42.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Jul 2025 22:42:46 -0700 (PDT)
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
To: stephen@networkplumber.org, thomas@monjalon.net, ferruh.yigit@amd.com,
 andrew.rybchenko@oktetlabs.ru
Cc: dev@dpdk.org,
	stable@dpdk.org
Subject: Re: [PATCH] [PATCH v4] lib/ethdev: fix segfault in secondary process
 by validating dev_private pointer
Date: Tue, 29 Jul 2025 01:42:29 -0400
Message-ID: <20250729054229.3537412-1-14pwcse1224@uetpeshawar.edu.pk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250728144552.361c17e4@hermes.local>
References: <20250728144552.361c17e4@hermes.local>
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

Hi Stephen,

Many Thanks for the feedback.
I have addressed all the comments on the patch, I have removed the unnecessary check in ethdev, the only one check in rte_ethdev seems to be a neccessary one, as without it, it can still generate segfault while secondary exists after primary.

Best regards,
Khadem
