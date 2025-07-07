Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD510C83030
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Jul 2025 23:18:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9B79B40287;
	Tue,  8 Jul 2025 01:18:16 +0200 (CEST)
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com
 [209.85.210.202])
 by mails.dpdk.org (Postfix) with ESMTP id 243FC4025D
 for <dev@dpdk.org>; Tue,  8 Jul 2025 01:18:15 +0200 (CEST)
Received: by mail-pf1-f202.google.com with SMTP id
 d2e1a72fcca58-74890390d17so3460669b3a.2
 for <dev@dpdk.org>; Mon, 07 Jul 2025 16:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1751930294; x=1752535094; darn=dpdk.org;
 h=cc:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=IvcEw46AEsdC1vKQmnagY0mzmChYIlkLDdR7AkpIPNI=;
 b=mNRxYSlWJaOJzRJBFbCVCiQAEsqmvRYHrgzfKw1XT0Gjn8GfI4WCEO0fEqeg3Ffn+B
 ZPZvEaR/0E7ykomHPLlxpvzLq+Q3pRQizqiqMr/ScmwhT/Tlum+rCNCcMnPEndQ1sjRp
 z+L5RwzTjmAxqvaAzpM0lb4ZR7EgSG47zKTyP6HW8LXVDBaHrJO6fdF4jIC4G/z3M41O
 HFi9XqqY/RpaXsZswz4hSG5GRBclUrur6CNMFgVStKd5Wba2b/1BLRTa506belSgW0QV
 zyb5xDJaBWLgZXyjFUxSzTuefATBgHlau4PiBAMuEIT5wMADDw+WsH4TqxG/CpKC94n1
 vXUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751930294; x=1752535094;
 h=cc:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IvcEw46AEsdC1vKQmnagY0mzmChYIlkLDdR7AkpIPNI=;
 b=bJ1kbdx4KweMHKhglD3Hk7xyGrxc1/qxElkBxd/yTpwa5UFApapUKNPFPQISl1B0bK
 mFQQsoKE+M8fATosw5P/aqbFk/3RAVqBACA//NkrDS6cno824dbxuY7XNZX+7J6/lF4W
 cz3HYY7mFVhyYVXhqMhGVVOJ4dm4DcXvx2fOXs3sUIrqz9Pffz1zKU64chRSFbcnqa9P
 jn644v9xmMvSpOrihVbXRsMzsLHIAuTlOAsK5AZkT+19lE1JgZSx8eWkrK43H+whWsf8
 Qc4yig/OIbMWK0uC9EEDb6NJQlj8oERcqJsCu9sNK+z58RBqnh4cCP+cMT2EoOLIR4W5
 DP5g==
X-Gm-Message-State: AOJu0YzHz5BNdxcCh1STIFC45ZSlhdKji6uUPVdsvqRC/9yZuhRC4bg+
 NKm07w9vwrkloAnURx4+Plt2o01Yj9xDJlZ8Dr+9tMThy535uLzEUmqHhGvSjdDovfGZmR4/fzF
 6Ag/L+6oPE1mrSUeP63lKsTSVxIFcu+aHMXF5/YbR1cPWxgBwqU9flTchnZrg1KmEhJ+H5VvZ2P
 i1xyrI0wRDBH98S57EaUv4tdZH7/VZt8LlLw==
X-Google-Smtp-Source: AGHT+IFlD8GWaXFXjt37v45urMAuJNSPiFUzZySdDziotddxRGdz3DkzLR6VrAvARya3xd8RgLUN0/9649lmzw==
X-Received: from pfv14.prod.google.com ([2002:a05:6a00:bb0e:b0:748:2476:b25f])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:10c2:b0:747:accb:773c with SMTP id
 d2e1a72fcca58-74d243ed589mr1338212b3a.13.1751930293989; 
 Mon, 07 Jul 2025 16:18:13 -0700 (PDT)
Date: Mon,  7 Jul 2025 16:18:04 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250707231812.1937260-1-joshwash@google.com>
Subject: [PATCH 0/7] net/gve: Tx datapath fixes for GVE DQO
From: Joshua Washington <joshwash@google.com>
Cc: dev@dpdk.org, Joshua Washington <joshwash@google.com>
Content-Type: text/plain; charset="UTF-8"
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

There are a number of consistency errors with the DQO Tx datapath, which
this series aims to address. These changes should make the driver much
more resilient against edge case and malformed packets overall.

Joshua Washington (7):
  net/gve: send whole packet when mbuf is large
  net/gve: clean when there are insufficient Tx descs
  net/gve: don't write zero-length descriptors
  net/gve: validate Tx packet before sending
  net/gve: add DQO Tx descriptor limit
  net/gve: fix DQO TSO descriptor limit
  net/gve: clear DQO Tx descriptors before writing

 .mailmap                     |   1 +
 drivers/net/gve/gve_ethdev.c |   1 +
 drivers/net/gve/gve_ethdev.h |   1 +
 drivers/net/gve/gve_tx_dqo.c | 164 ++++++++++++++++++++++++++++++-----
 4 files changed, 143 insertions(+), 24 deletions(-)

-- 
2.50.0.727.gbf7dc18ff4-goog

