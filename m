Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3B9CD4F54
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 May 2026 00:02:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D52334021F;
	Fri, 29 May 2026 02:02:02 +0200 (CEST)
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172]) by mails.dpdk.org (Postfix) with ESMTP id A7CF44003C
 for <dev@dpdk.org>; Fri, 29 May 2026 02:02:01 +0200 (CEST)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-2f33ae12f97so7273228eec.1
 for <dev@dpdk.org>; Thu, 28 May 2026 17:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780012920;
 x=1780617720; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=svoi93Nz5hBoC++FEWH47xBxaz5amIPKlOkLPBkS/Lo=;
 b=Jmk7mQF5ZHioE2nMymVUiG6hTz9zDBGi5mRE0b8nhEdXdMk1Oy/zlXecv7l1u2O6ug
 I1rHzpP+NUj5nqG/MZAvECVPIgyrV8vPk8wbrKOgi9RI7/YOzMoM4GtLUH4P7Vk4vkAI
 bSQmNHH09T54TDnoOlyRYbURKbdjuYhfG0ZO5+iyu4TjTD0t84+RNyz222wfhEkVV/6j
 J9H4GhqIFbdiDnySoCOWebXFQ4fPqeJv5UrSe/0V6Y/Pl19HGipj6Vi7U++kBkJPWPXg
 FQdHJgE8ZCWP5JEr9gMjQoWSuNjQaQCpDgyG+05f2dwuDPilDcIPPhtaF1ge4FQLO/3k
 DaBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780012920; x=1780617720;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=svoi93Nz5hBoC++FEWH47xBxaz5amIPKlOkLPBkS/Lo=;
 b=V3WgWhKw05lAk5cy42gnn50kJr51d4rI3R3s+iXz0MTQBt/UQJZBYxpFxTXvIS+fat
 keV0a0ocpXCIjrRkfeuKw+n03xCVy+K4aqu94gxmfGjKaFMnfQW334JPnT4g2I0gCbld
 xOhppqNxVzpu9xyIg/r5+n6h8Hh0AIGHVbbEeTBY/NsDbO5G/jodEHkX5867J+yF0kur
 gda4CL0/EhzAH7ypaqS1xIw0VmwICBO7USiODoHCiUVfeSvryaoY939lpFQ7BQ3VrtPS
 ByjDm+9w6qccQZTV19TbaKMOyu7lIgPSy9jVPW4fEYmHkaz8VvW+Zli7jyPB69gTFxRU
 ILAQ==
X-Gm-Message-State: AOJu0Yyg1DqA7BnyRehpezx5ht1dMGDYzdmdFRV2MMnUJ4zHBf/G8X7s
 piPiY1YBeQNZ5T535lQjeadegDsVHDmskUYdsgxtlzjdFRazwtiS+Il0tpnMQjq8WObSc8qMa2h
 8whN/
X-Gm-Gg: Acq92OFPvzoifMeRZOZ2AHdJGxvIVFhv/pmqNsqLQZZmnMIdam2BRqNyDFaB0ZM5nOZ
 xFdJLVwuqYEncDombXiQnooyNojlNqGa0UDfwqS1KnpjNjR/ZR8zbm115EWJ4qomsNe3hr/ARrB
 qnD30cEfdOaca7zcTKJqwMzugE819XFec+lB6VafZURhKyxlKBFKm8XHAZ6QG1ss3t7YSjZh3BO
 2PfhPOBfhBKq2xLZiE1+hBwC8r36oXmc0ApaZ6UoT2MH5JU5zi3sZBXH2TnbDTAz8LXnFeOdOYz
 7UTPNbcc7OulhjzRRgQ64+gYDAmGcevS7p7jP92zS17550uW2ply98Sl6ckKwLQh78XfGoebn2L
 QO7KZciaqhrTqBagfVdFetTIldIsFvJ7dfM1xP3XSGys32QEKm1dr6MUDnQUtBtxjHHjTAYi9/+
 gL4f86GcrH1EMg97NYeO2dQX3fZq+JGSRV/ms3CC7k+nhEzxl8YwwZKVXG4VXmf0WRaK2m0hl7
X-Received: by 2002:a05:7300:a504:b0:2ed:e16:6b4d with SMTP id
 5a478bee46e88-304eb2926e1mr357002eec.35.1780012920369; 
 Thu, 28 May 2026 17:02:00 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed5d5385sm53076eec.28.2026.05.28.17.01.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 17:01:59 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 0/4] net/bond: fixes and cleanup
Date: Thu, 28 May 2026 16:59:12 -0700
Message-ID: <20260529000157.235931-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260417165530.653328-1-stephen@networkplumber.org>
References: <20260417165530.653328-1-stephen@networkplumber.org>
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

Automated analysis of the bonding found a few minor things.
The bug fix is in patch 3 for secondary process crash does rx/tx. 

The cleanups are in handling of 8023ad mode setting
and the logging macros.

v2 - feedback about the mode setting and log messages

Stephen Hemminger (4):
  net/bonding: make 8023ad enable function void
  net/bonding: check mode before setting dedicated queues
  net/bonding: prevent crash on Rx/Tx from secondary process
  net/bonding: remove redundant function names from log

 drivers/net/bonding/eth_bond_8023ad_private.h | 17 +----
 drivers/net/bonding/rte_eth_bond_8023ad.c     | 16 ++--
 drivers/net/bonding/rte_eth_bond_api.c        |  4 +-
 drivers/net/bonding/rte_eth_bond_pmd.c        | 73 ++++++++++++++-----
 4 files changed, 67 insertions(+), 43 deletions(-)

-- 
2.53.0

