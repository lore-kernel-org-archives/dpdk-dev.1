Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F7FCC6B38
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 11:31:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0483D4060A;
	Fri, 16 Oct 2026 13:31:32 +0200 (CEST)
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171]) by mails.dpdk.org (Postfix) with ESMTP id E52F640291
 for <dev@dpdk.org>; Fri, 16 Oct 2026 08:26:53 +0200 (CEST)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-30b6dad2382so14598481eec.0
 for <dev@dpdk.org>; Thu, 15 Oct 2026 23:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792132013; x=1792736813; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kuuHxEPzEEseLeMUT/HiPuVQnbaRNv+/LQTXo7h9AuQ=;
 b=GF8b2mnDlcLKFy5aDlMtGW3SetFmRAR6XcRTPtGm3JGlcY/TxvZ6DLXxNw+2T9264x
 IGwcbBnhdnn+QE4EPa4+aDv8nTu4cCXsjG8I+23pFYya/EulWDRpJzZnpMCR0c+c6nkd
 in2e5H9EEmb5tX/aFpagFGAdzkLQ1XHF39Euq56AE/iS3QQLCmF3JT1QTDRVLN4dX+xW
 FgWXpEmKxqkZWYlz2eqjDGoWfGPdD+N68vglBkMI3HXGGN4cbvhP3iwGurU5cqrrmJnF
 FAqzg8eh7sIQs9u+cKTrEjghg5yk8qoPovG9680W/dYlEFluniEA20pACsqGuPJsDtiN
 pHCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792132013; x=1792736813;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kuuHxEPzEEseLeMUT/HiPuVQnbaRNv+/LQTXo7h9AuQ=;
 b=zR2FUiwP3mdtp07fJqJ1Y7WJsljj1cVg50VayLed8SBfOApTlTs2qDkfZvfz0fAUal
 GIDFE+wzetMXujYE2INctB9IgnrMFRP+wGkqX/y2JjKWZHNNJliBqs7lfeDUV7Dvy9dh
 PjTvFRquDFYpd1gawkVJTC9uFepnfhi8xS9imcDbb66z+LmAEXsgo+LUa0ySlaREiOqI
 pySsILnyZN/Ugd30IJu57c0P8f30gy2rzI+XKrbUIx3cZoWsLeXauWVtVvcMAfYAu5Ad
 YMbU1zZxS3KmZhLSZ/uG01vjOmQ75uMxkx6VCr7WrP2VVWF9gVJf+w0DALWD/hCsj8MC
 DkAg==
X-Gm-Message-State: AFq9FYLAuwfFXcinPmeRX57PnlXOt5bIc9yOIK6PcjvTW07WYx5vEUlf
 UjYBqSriDoetf0byOKBZg2bzZsqKBD1hBCjNhFY9cIKYGaRCeLMqH/zmER46lg==
X-Gm-Gg: AYBFou2oSZMVu14bBoxQZI9FmdNqJBBmvBIhIjbNt4zxWIIJg9oVAuVaYop4BAOkAgj
 kAiT9F5jk7fe+WS/6Yt7284CReuYrQ5RIuaUItKS0Dn9K/NyjN93lZKMV9XytDXlSr785sCJbq3
 Tbk0z3wXhAw4sd3yAXIDjE3UkNaZlB/GN9oE1DYqjwOrduHcOvLgrQZrBfRlokhCKW1Im0duqw+
 2YuFhM7yMrPopWn6Z9nDkc2GqxrC4L1FTAYZOWxMoHdr9NKkO7biIdjb+QM0Kdec1zQG1cpe6N0
 k9i5JsypsN5Yypc5YA05L1ftExMyDnak/0yyIj20voiZf+zYNxHxK2Qu3b+LavV2MMUkxjXWVB6
 4CElygHZ6+2/f4iaIJ1oSBHmPB+9zTXwSC7Zr/3uPMUQB2+ps0x3giECCNFR/OsypVKBntNMJU7
 pbDlW31ThJ/X0mUyGWdaLqviw6zOZR9P5i368+H8Ma4B6H5z7cnR5n5/Hj/gdaOCNClZ8hxuTi
X-Received: by 2002:a05:7023:a47:10b0:14c:fb3f:bedb with SMTP id
 a92af1059eb24-16a5ed3da20mr28725145c88.18.1792132012548; 
 Thu, 15 Oct 2026 23:26:52 -0700 (PDT)
Received: from aviuser.. ([192.19.252.250]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-183190aa3ebsm2743324c88.8.2026.10.15.23.26.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 23:26:52 -0700 (PDT)
From: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
To: dev@dpdk.org
Cc: joshwash@google.com,
	stephen@networkplumber.org
Subject: [PATCH v3 00/10] net/gve: fix DQO Tx queue stalls
Date: Fri, 16 Oct 2026 06:26:37 +0000
Message-ID: <cover.1792129992.git.tathagat.dpdk@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261012105023.669486-1-tathagat.dpdk@gmail.com>
References: <20261012105023.669486-1-tathagat.dpdk@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 16 Oct 2026 13:31:30 +0200
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

