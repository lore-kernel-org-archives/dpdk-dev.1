Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00298CD98C5
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Jun 2026 15:54:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B7A514025E;
	Tue,  9 Jun 2026 17:54:24 +0200 (CEST)
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178]) by mails.dpdk.org (Postfix) with ESMTP id 5B984400D5
 for <dev@dpdk.org>; Tue,  9 Jun 2026 17:54:23 +0200 (CEST)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-304d7f31215so5040032eec.1
 for <dev@dpdk.org>; Tue, 09 Jun 2026 08:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781020462;
 x=1781625262; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QXGV76CQl3zX4ePY/tCmud+JZRPTLfJBBDokvx7vqlM=;
 b=TAYlxbVEz8lnsq3WUzbhk1Iae+C1mjnZtFuCONLPyu2sq2qpr6YA+Q/yspBz2mH4tc
 o/yciMqGt6iFzp1n+4LobImiLwy5Ff9LFYioEGJ3TS0f/3oEbB6KTMBESPbzIkQqVo/s
 5QeSMtHJf/sGGWhGtUAbROtAb6ET4PzWc1YwMtKEE7pkqtbVO/vZnIZhuhojtZrK1tXy
 CKuyHVI2VRD2i/eqbxk6qXvD6v5gmd3qxk2KkNQ8cgaindvf4gLKdJOvtqro65GogibE
 QuTiRariPr+05ZH2eVpwSRLngn3iFXOr24qwGhwC4yyEUQoWBDGAPjcx+3xokRxRwr2G
 us3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781020462; x=1781625262;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QXGV76CQl3zX4ePY/tCmud+JZRPTLfJBBDokvx7vqlM=;
 b=sXyHsfNE1zBL70iGZ3qNn8z4xPOkG+6/HDDPcboCe7cNFYWVW1GXIyrS6db0/KxNPv
 7zckfxFcpuODzRi9Gt7VQ1LASx/flZkwrXfKxACGvTcpq/PkAIYucxElTYcQa3RMFLzp
 pNeWZAxqDIRrkGAlV8L7KlBkI0WAIvZXHTUFzOH2C4izNow45jDhUd0rHoyOdTScOApj
 gj2ygyJnVm9vJe+ktnqKhlQxpWxCF3vhX/3IrH68Xfc12m7TgIcw1xI280Swka2L3EJa
 6i3Iq9llxVC2rkdnOXH77LNSUu7kjIbOVRV5EgFX6BPd14ZoXfm7lJlpUELFBl9X+MRZ
 pTxg==
X-Gm-Message-State: AOJu0YxzOscPjiI0ha3T+bJ36Hm1X7MaQZwp5QaHdv+9kn8CZhK6trRT
 n0MRY3Ieu3qPyOsG9jN6eaF1gm22zP7Yd+Imyt1QVu8zPt+UpMiEo4ZOrTTsBc9RK3vg9iDZ1VV
 0TngO
X-Gm-Gg: Acq92OHiiUCkSbW/m/j1akY27UdQABSAqJYL7EjCAwJlNWnKn2eyxaBCAnnnNoSHC8t
 fFi3kQVjq3CvBFpjN4C0+p8qaAuJjdQeko+zT11BfM7nNWFWNtiaCnS5FqlHYrhZLdxwsMgjAj5
 RZPzXQf5sH31S9ObhfLZuCFuZ5zCeAdxqCps94flhk9Qk01We4WXzBxoZvvj5Uu52UeBDTgjjp6
 NBvqWe4uPdzNXR48E8zBU0fG8yePv3RgqlM/DsBLZUg1krWjS+QFqPVb+bcgmmySimrzFr71s41
 P1KFv8W1mBeQR4Z8TaeylOZtjN3SG5VdQ1dQJF0DMlDiHEIG1FWB5kHXjieAaNbyEEWxXC1Dxzg
 2MkMbjYCxUqbfYmQ232bF4j3IWdRfVLsAQeDn0qu+WGdtcTRUwz5HRtDskWtks1KltQ+eTgyquX
 BUf5A920tcrqtxjMCzhunlcc9lksLNNT4RC6k77SYsLWeTEDgtuxCgBqPzL0QPCRwNWkuzxwkFG
 wFI9wLiPVo=
X-Received: by 2002:a05:7300:d70d:b0:304:c520:4e14 with SMTP id
 5a478bee46e88-3077b32888bmr14262729eec.11.1781020461965; 
 Tue, 09 Jun 2026 08:54:21 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074dcad34esm31015551eec.11.2026.06.09.08.54.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 08:54:21 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 0/2] eal: tailq fixes
Date: Tue,  9 Jun 2026 08:53:29 -0700
Message-ID: <20260609155419.263787-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260607150418.30885-1-stephen@networkplumber.org>
References: <20260607150418.30885-1-stephen@networkplumber.org>
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

A couple of small fixes to EAL tailq

Stephen Hemminger (2):
  eal: fix off by one in in tailq name init
  eal: add destructor to unregister tailq on unload

 lib/eal/common/eal_common_tailqs.c | 15 ++++++++++++++-
 lib/eal/include/rte_tailq.h        | 16 ++++++++++++++++
 2 files changed, 30 insertions(+), 1 deletion(-)

-- 
2.53.0

