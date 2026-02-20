Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87388C5ACD9
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 17:06:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 66668402AA;
	Fri, 20 Feb 2026 18:06:22 +0100 (CET)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com
 [209.85.160.177])
 by mails.dpdk.org (Postfix) with ESMTP id E55954026D
 for <dev@dpdk.org>; Fri, 20 Feb 2026 18:06:20 +0100 (CET)
Received: by mail-qt1-f177.google.com with SMTP id
 d75a77b69052e-50335b926c2so20295171cf.2
 for <dev@dpdk.org>; Fri, 20 Feb 2026 09:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771607179;
 x=1772211979; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qWvgSx32CO2ryAGSqMt3NPecHT47gTbI+mf3v1KqhqQ=;
 b=SHwuUI5qz1f4BX1Z0AEpjJFaqj2UqU04CeCO3gFKH/QorMIwmuEWPLmtxBPebdDpw9
 SrBXqBShqI4dNOVHBhTLsuAvj5owJO1+HU0sgF2Bbeu4EKXhpMXHGfxPxpBonTpBfaia
 +9MkLjIqZK5TFV7e7+vYr7jJ/xPxdBu8ZRq4PCq/4w0XukfnF0232CbjyPcz6iiwTU2S
 NC0LfBKsE16Kay4V4zIZJNUeUJpSr5s7EOxaeGHX58vmLd80PgJaTCBvfEXqxrO14tjT
 ivcrCQkBPJL+l3LTUv471SvD0g1d8mMPIc/cdaXeoe8rHetXHdGfs5Tcpc1JBBNVUwYM
 SL5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771607179; x=1772211979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qWvgSx32CO2ryAGSqMt3NPecHT47gTbI+mf3v1KqhqQ=;
 b=eUktFyNvCHe5f7yAtuJPLhXi/dclGdav5qqMBBPbGjWVA/k07BHHkqoCxT9oEdaDZk
 dA4S7J+yFTtheDpKv/ItqrusuJIBJ6UppeOYEkFN+B9rfnl7QidgNx/Y4GgOdezeabsp
 9XMnUnhf0VLeLhFOQpBCimW2dNiiV6qpttvXDEM1yY7wjYNVYbdLilo6HWwQx6PLzD4n
 UV4cfF6VTrWWxTt9oAkYadyx8aHw2qdT75UkUKlZHH7+T/WvzLwVH1M9AYtZfOR5oa+z
 PjrYq6EP5N/tSm/sEJmfkCmkBzzK6qOQooclwPaDYjrGCNtniRlOCwDAeebSrABQfVHy
 DKkw==
X-Gm-Message-State: AOJu0YyVqgHFN32bc+aWjKuL8/F+j5CfQAHqnq1MzjqPFYhT3ZKbMe7D
 B0SWMcRD1hXjsVz/V8WpjYQ33/IgcaXBhiXd+lgFuzGDrh+ABevjGoiHTmHYvktm/32LHkSE3Oi
 /M9ZA
X-Gm-Gg: AZuq6aJipLUZoUG+NKQWc0VMlPPhtb1fFjzYQSOxrHwaAZM0CR1l+rQ8eqj9lxQ6D4/
 cnCrhZchg2FurHXd8mwNao8zyynRJANTpL+tcI9FGIBYvmsv5Gar/WMbMZWCatAjYR6EsEhGwDR
 y9sS6vcskiTbz/sIvpz97HU0xGNnUdbSVKkP2DT85vGsJW92QKfcYfikpMdvYKhQXcy1dNyqFCf
 2ykXg8bS9MkZXQzEdzo9wPVpHqtZziP55n5S6w4AGmaUV1IuWBKDe01Pa2bJjVAf4fZmQe4C0UT
 BWt2wG+0swUD78ItGrA1VBhBahI0I8fUQd4ZDf/RK6WXts9pOPtifas0kKYwXAoas0rAxLEfSiC
 +QoY4/rn4YVcoa+zg5EfQvJH8eejnMYWrfdDjxx64rn29bzKuLhlLf1DB/l/5OZ+O9UO1v5zJTc
 O/lWDbAJigThkOs5bKEB3sD/047rmv2hFOzY1teRa4F6tm/zM0ap6VLMdVFfzIkw==
X-Received: by 2002:ac8:5a8c:0:b0:4ed:b5d8:a192 with SMTP id
 d75a77b69052e-5070bc6b84emr6969031cf.38.1771607178922; 
 Fri, 20 Feb 2026 09:06:18 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50684bc39e6sm276277591cf.31.2026.02.20.09.06.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Feb 2026 09:06:18 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 00/10] net/tap: cleanups and bug fixes
Date: Fri, 20 Feb 2026 09:02:00 -0800
Message-ID: <20260220170614.75560-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260215195348.557945-1-stephen@networkplumber.org>
References: <20260215195348.557945-1-stephen@networkplumber.org>
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

Patches 1-3 are minor cleanups: replace the runtime speed capability
function with a compile-time constant (TAP is always 10G), clarify
TUN/TAP flag operator precedence with parentheses, and extend the
fixed MAC index to 16 bits to avoid duplicates after 256 hot-plug
cycles.

Patches 4-9 fix bugs tagged for stable: a bounds check to prevent
an out-of-bounds read on truncated L4 headers; resource leaks in
the primary and secondary process probe error paths; a missing free
of the IPC reply buffer on queue count mismatch; a use-after-free
with an orphaned kernel TC rule when remote flow creation fails; and
a leaked remote_flow allocation on EEXIST from an implicit rule.

Patch 10 adds a unit test suite for the TAP PMD modeled on the ring
PMD tests, covering configuration, link, stats, MTU, MAC, promisc,
allmulti, queue start/stop, link up/down, stop/start, and multi-queue.

v4 - fix build on clang

Stephen Hemminger (10):
  net/tap: replace runtime speed capability with constant
  net/tap: clarify TUN/TAP flag assignment
  net/tap: extend fixed MAC range to 16 bits
  net/tap: skip checksum on truncated L4 headers
  net/tap: fix resource leaks in tap create error path
  net/tap: fix resource leaks in secondary process probe
  net/tap: free IPC reply buffer on queue count mismatch
  net/tap: fix use-after-free on remote flow creation failure
  net/tap: free remote flow when implicit rule already exists
  test: add unit tests for TAP PMD

 app/test/meson.build          |   1 +
 app/test/test_pmd_tap.c       | 907 ++++++++++++++++++++++++++++++++++
 drivers/net/tap/rte_eth_tap.c |  97 ++--
 drivers/net/tap/tap_flow.c    |  23 +-
 4 files changed, 967 insertions(+), 61 deletions(-)
 create mode 100644 app/test/test_pmd_tap.c

-- 
2.51.0

