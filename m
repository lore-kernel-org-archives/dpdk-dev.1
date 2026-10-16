Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA5CCCF2E3
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 11:47:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AC64B40664;
	Mon, 19 Oct 2026 13:47:03 +0200 (CEST)
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
 by mails.dpdk.org (Postfix) with ESMTP id BA4534026C
 for <dev@dpdk.org>; Fri, 16 Oct 2026 19:45:53 +0200 (CEST)
Received: by mail-dl1-f49.google.com with SMTP id
 a92af1059eb24-15354aa70e8so387416c88.1
 for <dev@dpdk.org>; Fri, 16 Oct 2026 10:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792172752; x=1792777552; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cmbKGLKN6otxMkLryn9eJrJBi6qNuvjJD+k1JDlVEa4=;
 b=PQCTnwP0PHBjxttYAj8ZuId9NMsycblnyNGfFy9rkAniEv1/Uohz3S7NoZtvNn0fd6
 ocZXsTX+cWTK+PrahFA1AIZdbidA3CeO+9FqxsRg0uTdmpM2qIzGcL7qGseui/a6lPsZ
 ttvFd1eZKD80SrTk9dsLzL1/OLq4Ii4IkVHFz7tkjVPZmhjwCSo4sS6tT0ywPr/nJ3fm
 uf7a7RygEN/FHhUOfCWur22b8Mm0UgwXMn4q2Z0fok8+b6yqtQzVevRJxvXI5XEEhlHP
 PhfTWUDVEfsCGf5RGSog9nJ9pcKbq5taprTw7r1R3y7Txyzh9BOlfFOJxrXnyNfmd9ms
 PhQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792172753; x=1792777553;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cmbKGLKN6otxMkLryn9eJrJBi6qNuvjJD+k1JDlVEa4=;
 b=Zo/bVYef7O9wgxP3TohIAYlorcW3zE7jqSKAuhTasWrOOPhIq6yGE8fQIcL8oqGXwY
 J9iXQhtB8AP46i1SSsa8l8oySUSkKlGQoxEIusNDbS5k3+fScX88eeau7uvWzO7/k2d+
 7wmzed88Qv21VQmcezve0tY+TlILZ1tx8kwVD63Gs/2zj80x9KZlT0kVf3kQnXKjj0Fg
 F3dMVEdzD9oYe+7veYtKglPo9gsGBwLxs1SMfyRmgJsjDaNrMd5ERXd+qOi2oKv+/F+5
 xtq2ZrQZPgLbc+hBmSY9HIZ5RD1Eew/BdeE5FUdGQrtBNakgTB2hF4Uo+sC8qq4AaCX6
 6VQw==
X-Gm-Message-State: AFq9FYJxmdhzJngKSecbeRd7M+euQMvn69owkpSOiN/SSo8IgI7bR43z
 tKx20gYGTC4gQtyswP6r6rXzn7lAiuOxjf5ZfEEIZjdWqxcq/GwEgq8mx/2dow==
X-Gm-Gg: AYBFou0hLvdQjMOKt8kjCwqab3OxuiWKTBk4lp5zKvHv6l+wb30VdtKeesewAlkxf1F
 zO/ZX2YaUBmmO2gLRjOzXQi7UnrlVMwnykXYW5IB1bdD/w5/j+lO2DG0f65tS1r+EhonVIOZEd6
 ll2CruPACjlbHgwbP8KHOJyF0vh3GFMImq5aUqmQbmaPOgjpi8D4UguvHwOCrqQvQZkau9C5qAk
 CX0S6y+p1cracJNrMa+jnXMi1kvETTylLG3l7kHoFmQHsUvYyFXP1YR56MRPEIg1GrmYXSeoJAd
 u5wS72Oh7ohTua+GnSxlBfgUP+ahw2+2QVuBYA16nRqCZcI380qfwrIDUZ2XDKkm99Ez0CfK88f
 d+kvXT5rAugIHkmJqUkoc+bxKWSS/e71IOop8ZiSg/kEWBLwgLqQcvnUwCcwU8VjmZqhqaJIhOl
 bLrIBaLiFvfRK6WSTDr4s++u32UqbjH3CcU37SDTan60oCTj7p8CBF+nDQtD90xPa1oTvyZOCQ
X-Received: by 2002:a05:7022:f50b:b0:17c:a0c5:8c9a with SMTP id
 a92af1059eb24-18514914deamr739108c88.42.1792172752317; 
 Fri, 16 Oct 2026 10:45:52 -0700 (PDT)
Received: from aviuser.. ([192.19.252.250]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-18314ef8ed8sm7099936c88.3.2026.10.16.10.45.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 10:45:51 -0700 (PDT)
From: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
To: dev@dpdk.org
Cc: Joshua Washington <joshwash@google.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 00/10] net/gve: fix DQO Tx queue stalls
Date: Fri, 16 Oct 2026 17:45:35 +0000
Message-ID: <cover.1792170902.git.tathagat.dpdk@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 19 Oct 2026 13:47:02 +0200
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

This series fixes several ways the gve DQO RDA Tx path can stall or
post invalid descriptors: completion handling bugs (1-2), a report
event interval that can starve the ring (3), a stray TSO context
descriptor when completion tags run out (4), a missing cacheline
margin (5), invalid packets blocking the burst (6-8), and missing
device length checks (9-10).

v4:
- Rebased on main; v3 no longer applied after 4a543ae8c8
  ("net/gve: clean Tx queue directly in DQO") removed txqs next
  to the field changed in 3/10. No functional changes.

v3:
- Split the series into one fix per patch, per review feedback.
  The code is the same as v2 except where noted below.
- 1/10, 2/10: v2 1/4, split in two. Kept Joshua's Ack.
- 3/10: v2 2/4 without the declaration reordering
  (per Joshua Washington) and without ringing the doorbell on each
  report event, which is a performance change to be sent separately
  with numbers (per Stephen Hemminger).
- 4/10: the completion tag reorder from v2 2/4, as its own patch.
  Fixes tag now points at the commit that made the tag pop fallible.
- 5/10: v2 3/4, unchanged. Kept Joshua's Ack.
- 6/10-10/10: v2 4/4, split:
  * Keep too_many_descs and add per-reason invalid_mbufs and
    invalid_pkts counters instead of a generic dropped_pkts
    (per Joshua Washington), and export them as xstats
    (per Stephen Hemminger).
  * Count sent packets after writing descriptors instead of
    subtracting drops (per Joshua Washington).
  * Move the length and TSO header checks into gve_tx_validate_pkt(),
    leaving gve_tx_validate_descs() to descriptor counts, without
    the declaration moves.
  * Reword the TSO length limit (per Stephen Hemminger) and shorten
    the commit messages.
- Stephen's Reviewed-by on v2 is not carried over because of the
  rework.

Tathagat Priyadarshi (10):
  net/gve: fix DQO descriptor cleaning loop bound
  net/gve: fix DQO completion queue stall on unknown type
  net/gve: fix DQO Tx report event interval
  net/gve: fix stray TSO context descriptor on tag exhaustion
  net/gve: add cacheline overlap margin to DQO Tx ring
  net/gve: fix Tx stall on invalid packets
  net/gve: export Tx drop counters in xstats
  net/gve: reject Tx packets that cannot fit in the ring
  net/gve: enforce DQO Tx packet length limits
  net/gve: enforce DQO TSO header and length limits

 drivers/net/gve/base/gve_desc_dqo.h |   3 +
 drivers/net/gve/gve_ethdev.c        |   3 +
 drivers/net/gve/gve_ethdev.h        |   4 +-
 drivers/net/gve/gve_tx_dqo.c        | 113 +++++++++++++++++++++-------
 4 files changed, 96 insertions(+), 27 deletions(-)

-- 
2.43.0

