Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC50BCD98E2
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 08:24:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0FF0C40289;
	Wed, 17 Jun 2026 10:24:12 +0200 (CEST)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id BA3474027A
 for <dev@dpdk.org>; Wed, 17 Jun 2026 10:24:10 +0200 (CEST)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-490a76757e5so39380865e9.2
 for <dev@dpdk.org>; Wed, 17 Jun 2026 01:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781684650; x=1782289450; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tkYL0E3LmTEtOS7n0jr3DPObjuLjjjpKJh+VXIo18/o=;
 b=caP54QDldHIxeO75ie4vbn6x9/Eh0Bpkl/2xD0VPv4AtmHCMfsPP9HezQff/XQmSAE
 D/J5b1xFrnjGFhW5J9NmMaPmaXs0TNbz/OAMsGpV3opRF43tlaSeONWKi4eTevG73hNp
 09fvi1PO69DB5P3w3BMSu3LBpp6Kx7zY1RQbztIc5fpFxXM9e94oCLwgAkctcx8UxBs9
 xBhRDHlzWEKE8OaA68Sl0/6gWxJkNbWEnS4WzSbE9VmqfZzedOpBnZIbdVJZBdncvFzK
 AVqdI8m5JYma3Wmj1ogvOG0qnMA9/6WhRCtFtop+mi2RPhahzB+P8iwIjeHXHHaiLBGY
 5nCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781684650; x=1782289450;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tkYL0E3LmTEtOS7n0jr3DPObjuLjjjpKJh+VXIo18/o=;
 b=FNA9WM2DozK7lPrAXatZAQ/TJemssnOEefSzlLG3bmwXTFjv/DWeCqsqn4J/Q9HxQ0
 Y8HbqfOJdFh9kC7rdM6bsyQq8UjyxTWw0xn9UoeWjZ/WuaZT173AKIdGJygCtS9vFRCJ
 BUjwQkZHsEx/LHfCvGVMsY306BvP7l8XvfLLCO9VehHs8bXMT+MrQ682EiJHOP0CJN6+
 3Y1zRJmNi6VaQVJS/5jirDjkqLgGLOc1NItlSGUDcNoq+QKF7o75UROXn21a1ufgItwe
 qs1QxpYIugamCKwqNWc2modnuhzapDSwYcFzlm70neMLbh/PiRqVSpNUFrq43C6HDmKO
 Icxg==
X-Gm-Message-State: AOJu0YzcDd19+oPury8rbdJ3IhUHcYsZimNcXLUHK3ramX9d9pPeNB5S
 tbFv8ji32l1VvcXYJtjfUGNUNnQAJ6nuWpfqpC+2PDwof321KwdhocvH
X-Gm-Gg: Acq92OGnzrTwopdCNwUlTDp2nvXpxv5omx3GkqmsitrhbCU1MdJjCQv0/jZYUHPgXsR
 UXr6rrTUuaCAZXz7qAPiB1TMfcbsWIWPbwiMai6M4ku9otLX7f634uV/5/PVWljxMFPX/x3fsBw
 Vooert0NNaNeqNdOelF23ww8yRmLlN6gN7WH2/pgTgb5H9KnnMAdRV8INFluyWnLFStOJMCdjFd
 RvWCQpj9ujbnhuzhYHnni2ehbfVPeTsYDRlTLswgzUXUE2mOUHtJRMsgrvCnv08Z4mTBrrSjINt
 I4rKdscAD/FHPpDiQuQnpaTvJRnnnNrMpXDB3meGmWXPjhy4slvDbQMkbeOh08YWjMn0p5GRuPE
 dV0TxvwOw0/TGHCbRqUZTkFM8MwL+wZJCAda5DdjIz1V0wEAyZ+eM2VDyje9lpAT18sLLGtUckM
 dHCOtH8+jyv6seM1JA9owr+3qEwrBsxniqmFh/G942dKGu
X-Received: by 2002:a05:600c:c09a:b0:490:bb37:9d49 with SMTP id
 5b1f17b1804b1-492333bf9f6mr41574255e9.11.1781684650077; 
 Wed, 17 Jun 2026 01:24:10 -0700 (PDT)
Received: from localhost.localdomain (free-mobile.vlq16.iliad.fr.
 [213.36.7.11]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49230a58fddsm127854015e9.8.2026.06.17.01.24.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 01:24:09 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: dev@dpdk.org,
	Maxime Leroy <maxime@leroys.fr>
Subject: [PATCH v2 0/3] fib6: fix tbl8 reservation drift
Date: Wed, 17 Jun 2026 10:23:57 +0200
Message-ID: <20260617082400.142129-1-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522145855.1748406-1-maxime@leroys.fr>
References: <20260522145855.1748406-1-maxime@leroys.fr>
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

trie_modify() maintained rsvd_tbl8s by computing a depth_diff from the
current RIB topology at both ADD and DEL. The two values diverge when
the RIB changes between an ADD and its later DEL (a covering parent
added or removed), so rsvd_tbl8s eventually wraps to UINT32_MAX and
rejects all subsequent /25+ ADDs with -ENOSPC. A zebra-kill /
reconverge cycle on a live BGP router reproduces it.

The fix computes the reservation from the RIB node shape:
count_empty_levels() returns the number of byte boundaries between the
prefix and its covering parent that no other prefix occupies
(has_children + parent depth), in O(1). It is the count of tbl8 levels
the current route set needs, so ADD/DEL accounting stays consistent and
cannot drift.

Patch 1 is the minimal self-contained fix (Fixes: + Cc: stable).
Patches 2-3 add the reproducer and extended regression tests.

Validated on a live BGP router (grout + FRR, 128 IPv6 prefixes):
RSVD_TBL8 returned to its pre-cycle value (70) after a zebra-kill /
reconverge cycle.

Maxime Leroy (3):
  fib6: fix tbl8 reservation drift in trie
  test/fib6: add reproducer for tbl8 reservation drift
  test/fib6: extended drift test cases

 app/test/test_fib6.c    | 335 ++++++++++++++++++++++++++++++++++++++++
 lib/fib/trie.c          |  83 +++++-----
 lib/rib/rib6_internal.h |  22 +++
 lib/rib/rte_rib6.c      |  15 ++
 4 files changed, 415 insertions(+), 40 deletions(-)
 create mode 100644 lib/rib/rib6_internal.h

---
v2:
* Compute the empty-level count directly from the RIB node
  (rte_rib6_node_has_children + rte_rib6_get_parent, O(1)) instead of
  the v1 multi-level supernet scan over byte boundaries.
* Drop v1 patches 4-5 (valid_descendants counter + single-descent
  helper): no longer needed, the node-based count is already O(1), so
  rte_rib6 needs no new per-node accounting field.

v1:
* Keep rsvd_tbl8s; recompute it via topology-stable empty-supernet
  count (dir24_8 pattern at 13 levels) instead of RIB-derived
  depth_diff.
* Drop RFC patch 3/3 (no longer needed).
* Add extended regression tests.
* Add patches 4-5: RIB valid_descendants + single-descent helper
  (optional perf optimization; not for stable).
* Production-validated on a live BGP router.

--
2.43.0

