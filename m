Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB41F483F8
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Mar 2026 20:24:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2C93C402D6;
	Mon, 23 Mar 2026 21:24:09 +0100 (CET)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com
 [209.85.160.175])
 by mails.dpdk.org (Postfix) with ESMTP id BC77740268
 for <dev@dpdk.org>; Mon, 23 Mar 2026 21:24:07 +0100 (CET)
Received: by mail-qt1-f175.google.com with SMTP id
 d75a77b69052e-5094e1d17d3so37416081cf.3
 for <dev@dpdk.org>; Mon, 23 Mar 2026 13:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1774297447; x=1774902247; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZLB+m/2zI2GZOb5jaY41Y7AevGHz7Ii0xegKYzx5/SM=;
 b=KUfc3HW35U2An/wbdhnl/1MD+e45V4FxRViibdSGD9/XGiK73+j1BzN6Bz5eaaoWse
 3n+EvMgcwWbwMNSPInS6XclnlbJthPiOfn5/v7kFRIQiymWr52rz1ZgDnzd0mEc5O9uh
 hKxfJL5PoNzryQC1cG9+7XoQtrwJH0oB0LL30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774297447; x=1774902247;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZLB+m/2zI2GZOb5jaY41Y7AevGHz7Ii0xegKYzx5/SM=;
 b=lJOe+N1Oem/IRcmi5kPkpKlxXs6H9I6AqyOEIPEkLkUf1ReEB6Ivsoq8rraVbeI/L5
 mHsERqxfN9PC3AMiuYV+KL4PBFSyqPrP+zXZa4AcSOZgPQZMOKYMvCJOCAKvwrFHcTef
 nh4BlBLkcB2NJpLXqDysR58S7ozCT27qB6zkVp+KGsp4rCyrFAgBOVUeOs19uFpUBmFz
 oWK2DAbb/5UwlU9GFyHCmuRriBr9HL0Oim7YRWB/bNbFPnir/Cj/b4v1YUTar+duxSEz
 RdlqYzoDNlr0beNDHeekXPXDNW7lGSSz40rMzg+FGPL+6xBEctfF/cyZhaqYDseQ8+le
 OXsQ==
X-Gm-Message-State: AOJu0Yz8d5ks+HBLxE98u58qoMC7EyOaNC8OILjuh2EFm3XnIqlKFfVs
 GouRH60zi8rxqrCOSz6zmMEriWvwqRNAfeYVK9ky0lnvO/W8h3AIyOF6dQ5J/FZJoV8=
X-Gm-Gg: ATEYQzw1aTxjME3pHuKCqoM6O4aGWOrpDXJKJf0qPtgpN2h5UtXh4QPg/VBYhfOD37/
 JO1jbQ19o8vKMuC2hic3zCdHQx2LmvWY4tcINUpjHs98AgZuoH7MIicuyGkGyLNwNHOBp8VqEk1
 httoapo2SOHPZxyys6KlWsNWXkY3YwsKSQA69T/nxaZLuiEMJBtxr3eQ9hZTqPzlcqGXseRsmhU
 agq4ftQ36cG/ff6SbBZ96qRSQDydDtPpVfrtLMNXnamvJui4TxvNPC1WcqEJBFWRL2HORw2IQvd
 tuw+lO4schhOWhwrtC6HfbHDLq/clNSP57cd32Cn5uIz9pdBGRwrf8c/2eMxjRQ8QZLQE7CsVI+
 TyGjjwEYiAX2rQXQx4mRXjq8rTcApiz+/tBEwyj0cNets6RL6EQJq4DPqeTi0gSWYA+7oi1JGJe
 0Lr/2mDjrnn0+gByGPTwBUmwE0Y685ChvkWWL09njCHe6YZ9g9dhUHwGkfRgco1NgN07kT7UYKb
 xgHmtU+QFik
X-Received: by 2002:ac8:57c8:0:b0:4ff:b1eb:2d03 with SMTP id
 d75a77b69052e-50b375f96a9mr204749401cf.72.1774297447021; 
 Mon, 23 Mar 2026 13:24:07 -0700 (PDT)
Received: from patrick-laptop.iol.unh.edu ([2606:4100:3880:1210::224])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50b702b85d2sm2966811cf.25.2026.03.23.13.24.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 13:24:06 -0700 (PDT)
From: Patrick Robb <probb@iol.unh.edu>
To: luca.vizzarro@arm.com
Cc: dev@dpdk.org, abailey@iol.unh.edu, dmarx@iol.unh.edu,
 Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH v2 0/2] dts: dpdk shell bug fixes
Date: Mon, 23 Mar 2026 16:20:51 -0400
Message-ID: <20260323202053.740203-1-probb@iol.unh.edu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260323180818.674041-1-probb@iol.unh.edu>
References: <20260323180818.674041-1-probb@iol.unh.edu>
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

Support for the dpdk-test-crypto-perf application in DTS was added
recently. This work introduced a new bug (incorrectly setting the EAL
port allowlist when checking ethdev capabilities) and also exposed a
pre-existing bug (insuffient time delay between dpdk app runs causing
resource conflicts). Both of these bugs are resolved by the patches in
this series. The patches are very small, but also important for the DTS
user experience, so if there is time for these to be merged in for RC3 I
think it would be a big benefit. Thanks.

v2:
Adding missing only_active decorator to the DPDKShell close method,
which resolves a doc build issue.

Patrick Robb (2):
  dts: always use ethdev ports to check capabilities
  dts: avoid dpdk resources conflict

 dts/api/testpmd/__init__.py                |  2 +-
 dts/framework/remote_session/dpdk_shell.py | 17 ++++++++++++-----
 dts/framework/testbed_model/capability.py  |  2 +-
 3 files changed, 14 insertions(+), 7 deletions(-)

-- 
2.49.0

