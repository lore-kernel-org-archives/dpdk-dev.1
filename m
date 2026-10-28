Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38806606A31F
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Oct 2026 14:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=gkpRo7ed
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA9D040151;
	Wed, 28 Oct 2026 15:17:54 +0100 (CET)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mails.dpdk.org (Postfix) with ESMTPS id AB4F4400D7
 for <dev@dpdk.org>; Wed, 28 Oct 2026 15:17:53 +0100 (CET)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2e9d7791b00so6582415ad.0
 for <dev@dpdk.org>; Wed, 28 Oct 2026 07:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1793197072;
 x=1793801872; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Q3+Du89TOmremRWws5AsdQVp7DfruEv4vTMEN380JrI=;
 b=gkpRo7edUaeg4TwnhT7FUq+utY/xUfTsxa6R6y5C6owzZwEWzUfy5CqE0vBZDLauRF
 a6pcRiYaJMFGfZ82YV5DFtAKLwjzKeMCyriftnzaK06bobrIwFlr7a1MwTMBSfl1QbUc
 mvN7fBWuMAwk+371+qrqfQ7TJbEDiyg+/uX7S0PEAnJF4BELMXpEIS/p6751Ck3WeSxG
 sCy1FlfwgvmGcrW0gHWvFFiz3lEjL/MQ+6GtKbYcKtg6qRSrc+1ZLLBMlZ5Sh7YLzSCC
 sIJQmJYnKFEuTFDt4R/+zgMDImMnIjxCFSBQPD9J9qvAAdpfFFR/FBttEllzg8pcsofb
 Rblw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793197072; x=1793801872;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Q3+Du89TOmremRWws5AsdQVp7DfruEv4vTMEN380JrI=;
 b=ThS0B1bJEM0zaAfLm31A/qRpWUnYKFgQYW49RFqoEmLwFUbR9IDHSvoA+XzMqYjqux
 vFmBqAMvU9oS/vrIi6oZMCKCv80pE0jtcI7NoV2+5WeSlWcVcqtNm0hED52PW9ta2dbJ
 dgrbH7vcaEnlskeux4NHRd1aSxoREtEnL8eeA4zTrwEHHJpPgPhCib//Dq1Q86Fp81bX
 ovQ9UaO0tTUZMOGYhbhrxu7olMWCN5gomWdWj3CkTj9WXlfAamCsVo8NInwnBPky30PO
 ERJ6/AOPHwlGmUalUOugE4i8W3yiuolj8eM5JhHrBK6QytlcBnN9Hdr7mFfWBGmciUBM
 P3MQ==
X-Gm-Message-State: AFq9FYIOnp5Uns74HMS/OBFwLw+B64WFpAYMCnP2/YLDMOlt064Zi4Gm
 pliMV5FBVw24tNPNsJBsL2iSGezg7p5+2wbY7OBe+ji6yfpnH7fYlRLQLQnPoCFaYeZoma1aqLn
 8mQ/Lux8=
X-Gm-Gg: AYBFou2ukszR5UZhTxCeW7nmynnYHzWOniH7w84bZWh07ruLv5gY2u8aYJl1MC4bxJw
 uSAgspBYxjFujXaRV8ANEKpogho4Uoui8CRbkTZdOwAkz+5B1MdjU7vJiySXNHGzDjU9F06HrqO
 QpRmO0WYuWOqAq8tBXiXyuLmXRsIk7O64WQjDi449RfnUGT+LmbFJfvXKK6nTBFo1+Q6NpFHS0h
 cpLCwwVuW2n7LRVQfkROXWW50jNEIaepwu+hCDd3IsPaIxx3N1CpYsBmkal6x1PvXRAEnbZoXDg
 k33Mg67A4RaqCfuHeNZnrZRrSFnD+9mTo2mRh/1oJxI1Nsi+74wUd77okjcJuYhCsEfCoJZrdoS
 Jq33o0EA3lpJxcoKmXscy4qrB2rF67XlXQ2h+3w/cBAlvJXnfVRc0fNqqj8VsC87LW3MNNdrvqt
 Z3N1gZ/dOwvmCt0FQrBLK5i7Mw2Ssp4mCFFt6WQmSPg7Ifvs0x81IoIktAB30HcAHAU9O6ArVEQ
 lxR4H3fqZMezb8lXmfftqmVxrvxyaLjk5k5QttKT10qtkrqcW6G9i/7lagolNis6El0J3E10i4Z
 CoAczaH5DIK7fRIzY/Uly5WOA/IyyaxjrMW1pvlGfgpJ573x06wt40Hd/uYxSkqqmIce
X-Received: by 2002:a17:903:1a0b:b0:2ea:fb8b:258d with SMTP id
 d9443c01a7336-2eb0012b52bmr24122665ad.6.1793197072092; 
 Wed, 28 Oct 2026 07:17:52 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eae6c3b67bsm22182415ad.52.2026.10.28.07.17.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:17:51 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 0/4] pdump: fix capture on ports with hairpin queues
Date: Wed, 28 Oct 2026 07:16:49 -0700
Message-ID: <20261028141750.310963-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This was reported on dpdk slack channel.

dpdk-dumpcap fails on a port with hairpin queues. The first attempt
reports "Unknown error -22" and every later attempt fails with EEXIST
until the application is restarted.

Several bugs combine: pdump tries to add callbacks to hairpin queues,
the error is returned with the wrong sign, and a partially enabled
capture is not undone. Also the first Rx callback API was missing the
hairpin check the other callback APIs have.

Stephen Hemminger (4):
  ethdev: reject hairpin queue in add first Rx callback
  pdump: fix error code when adding callback fails
  pdump: skip hairpin queues
  pdump: undo partial enable on failure

 lib/ethdev/rte_ethdev.c |   5 ++
 lib/pdump/rte_pdump.c   | 112 +++++++++++++++++++++++++++++++++-------
 2 files changed, 98 insertions(+), 19 deletions(-)

-- 
2.53.0

