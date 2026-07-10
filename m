Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB283C43458
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Jul 2026 22:10:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DA6094027F;
	Sat, 11 Jul 2026 00:10:19 +0200 (CEST)
Received: from mail-yx1-f73.google.com (mail-yx1-f73.google.com
 [74.125.224.73]) by mails.dpdk.org (Postfix) with ESMTP id CD7D040270
 for <dev@dpdk.org>; Sat, 11 Jul 2026 00:10:18 +0200 (CEST)
Received: by mail-yx1-f73.google.com with SMTP id
 956f58d0204a3-667bd638ee6so127300d50.1
 for <dev@dpdk.org>; Fri, 10 Jul 2026 15:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783721418; x=1784326218; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=jB17c2EvbLtCjHmowDNBzK8rjBI0B+IcKY9WSNRrocs=;
 b=ofS5VmkcWacwKEoXqfg6SN8AjCCr5BfNz7uUXmT+C6jlKaelD8hr0QjHrS8AOJN/7J
 g/1MZ/FxqYO4DPtRGK6vfAFrh9hCtYTqYA9PZIlLJBByBkruMwZlDy7nj8eRv3f1cUAi
 G3K45gcDSclCRyvtMnQoRqccGoDrUZUFhvovNOA9O6hEXBjkDIcHzMZ70hsqDtbamQTU
 Qs46SGARV1ZIqMZlGI8e1Tg+8bdlt8ZD1EJEVVlraZfGBoBsExMK19mj3VenIxODMkbL
 W01PaRAFk55P4yXD1sSww/haNXX+oCCrIHX9xJBdyRdsZiFmBZc55FRBqLvFnU7hGK/P
 Kp/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783721418; x=1784326218;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jB17c2EvbLtCjHmowDNBzK8rjBI0B+IcKY9WSNRrocs=;
 b=G7YebSgs4oKezORqXY1iXXrVxNUT51ldEOGNfHcrli3vMMG8YRDmdEbwcZSX33nqq+
 D30TjmHoztpfuWUajK3izWBoRdHhmAccPW5rHzWBE+luAwnVUq/5Q2geXombap3Pkyi1
 QQRWr4Xt8yCKQSLJOuOMvOuKo4S5bdXun0KVeSWiWaQKCQlbUEicQ1xEXM1Iq14bxbOs
 1jBW2ZDsOtyPfSvEU9QrCcOOnztrwnQTlgYvt5S62lIDAPliUrjz9j8RBECa+uV62cqw
 ObtR/MAXgIpcCvBGMFCdBzhagDtpOKfd6r3AaB/VesocEgDt97ykcMJbxv23JP5TOro5
 vJ9w==
X-Gm-Message-State: AOJu0YzOW6iuxynyeQPtHqZSnaSfd150US2+aJq5KVBHn/eAn6JMULbE
 oVU0/UVSW/2Ufax1v29t4shKXeCpzUne6c2nXc7mLoJF0vipUe17tt76IxRXxPC7z6gaBOtM/gh
 mDlkryhHJmC5/tBB3Kq/pAuiiMVNaskDDS0roN/xaBM2LR3mvdk0MH16zZheSMMK6wZiX9z4rse
 8w3QD3Hh7qg2bLJZTKE/VmjFU=
X-Received: from yxsz7.prod.google.com ([2002:a53:c9c7:0:b0:662:d983:9358])
 (user=blasko job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690e:4385:b0:667:ac1d:16c6
 with SMTP id 956f58d0204a3-667d7cb7958mr615498d50.81.1783721417733; Fri, 10
 Jul 2026 15:10:17 -0700 (PDT)
Date: Fri, 10 Jul 2026 22:10:10 +0000
In-Reply-To: <20260623215325.814776-1-blasko@google.com>
Mime-Version: 1.0
References: <20260623215325.814776-1-blasko@google.com>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <20260710221013.3913447-1-blasko@google.com>
Subject: [PATCH v2 0/2] net/af_xdp: add Rx timestamping and read_clock support
From: Mark Blasko <blasko@google.com>
To: dev@dpdk.org
Cc: joshwash@google.com, jtranoleary@google.com, blasko@google.com
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

This patch series introduces support for dynamic RX timestamping and
clock querying in the AF_XDP Poll Mode Driver.

The first patch introduces three new vdev devargs to specify
layout-agnostic metadata offsets and bitmasks for extracting hardware
RX timestamps from XDP metadata into the mbuf dynamic timestamp field.

The second patch implements the read_clock ethdev operation, querying
ethtool for the interface's PTP Hardware Clock index at start and using
clock_gettime to query the NIC hardware clock time.

---
v2:
- Patch 1:
  - Replace static metadata struct assumption with configurable vdev devargs
    for layout-agnostic timestamp offset extraction and validity verification.
- Patch 2:
  - New patch introduced in v2 to support read_clock ethdev operation.
---

Mark Blasko (2):
  net/af_xdp: add af_xdp rx metadata and dynamic timestamping support
  net/af_xdp: add read_clock support to AF_XDP PMD

 drivers/net/af_xdp/rte_eth_af_xdp.c | 266 +++++++++++++++++++++++++++-
 1 file changed, 261 insertions(+), 5 deletions(-)

-- 
2.55.0.141.g00534a21ce-goog

