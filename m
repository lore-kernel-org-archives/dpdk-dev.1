Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7533C624A4
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Aug 2026 16:11:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6CD8840269;
	Mon, 31 Aug 2026 18:11:15 +0200 (CEST)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46]) by mails.dpdk.org (Postfix) with ESMTP id AC94B4025A
 for <dev@dpdk.org>; Mon, 31 Aug 2026 18:11:13 +0200 (CEST)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-398ba166ce3so1763924a91.1
 for <dev@dpdk.org>; Mon, 31 Aug 2026 09:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788192673;
 x=1788797473; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6raJ6ue9m6QLnsUTQ//TibTlDmP26OQvf+33aulENTA=;
 b=0obyaaIufKPerfyJbF51evLmwcKqwEi4ReSWWNgmqVfIPS7saYwBcPzUkifUt1bSeu
 3/EMViqY0z++tsKhGbvQToGlfmXxUFX7co8yl/7qwEP+FkLhbNGM9W3WbfM9bTUSjZvr
 7LU2WkLe2p3K5BVt5+N6Mt3lG+hsMVM0LHNa8RT1lHz212TwGuOsCQEwotG8i8aEl5iX
 Z8wNEX2wCqKQXP2V+izXbzWYIAt0EkC2NDSdU4YyNob3KqD1rKyaWcA/W9PSMYZueK7A
 k97oxMh3cnidco3TYRPvp+55FHoQ36OK5bxFsPb8gIayw+nWmlgJzvnr8pbGg3y+8VIl
 qHKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788192673; x=1788797473;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6raJ6ue9m6QLnsUTQ//TibTlDmP26OQvf+33aulENTA=;
 b=Y7GJvPf3uqPYI9Z4iHF6QLDhW0IK1acayMbelWT0LVfHRW3aAJA0SGAfpZCn20rZdO
 EExThx0Rrt3/sUvL3Hz+xKj77DuTK6aWefByTjVflB1MUnKA5eHhjh2Vmt4+lBlTlksr
 I/N23tIpgtE8X8JLLl3deFbe5+L3vMZ1uLlhJwuVLBVRtm0YdX20hFVkttbxZGg2t582
 HBTySVifKOH1Rn8hf7/wZNTSH30WG4/FVkELf0MZjl3t06IBg7A8ZM5CAIzcwLT7FycI
 88rf4aSWMj8OnH5TcmpVLU4D5OW+UjcaMD8SS0UUgrOrqZ9Bt1qw7vwfEyWWY2gcVB0a
 MmQw==
X-Gm-Message-State: AFuF++kKkAUTCMuliRcXkSoTjoBLR8IJrgsEDgchiH+fj8Cwr/Swb98E
 8OxKAgxkoP4FMj5c4Z+pNnYZ4vQlvTIm/84E9FKlNyyC23mcmhc2OIH15kyQWPGYr1Iszj6AyqA
 eOHPv
X-Gm-Gg: AYBFou00NwMQ48hrXdQiIuqHSmbp6SfH3sX6G40Dv6zTQ18ltQ0Wk6iULuu2IXwZj3/
 keggWGMvm7ZKcTo7uSTqIS02vAnrNgpw1rlgqJT6YAt2XijFje14kBA0A8oNb5+oz6i9MqdiOJ7
 /ZzIMruhd/xEbUVojHDR5mwsEWwY9ryN481K8laziG/TZBFK/RESAamYkOGlnJDL+/NE0xLhtUv
 1K0rnLyfltGmEFHA2nRIBJethq4b1z9kuUDkToEwKgBHBnrzkGhdp8MP3wEeJhJ4dDkeUY0EH30
 Hr9m/xXounnWxkHDT7X8GMr5E/9zqEEjBwin5olkap0mFJ/MM21/Q3j7OQvkxJsX5IbOAY8rrT+
 wokBbhWPoSRG3FZdPVeDml/IqxxPE3RLA1X4G6ilsqmJexIddOeqvS4M4qZ/mu9S5BgJMhKLWRK
 Zr+WoHeetX97HT859O6axV5n+LMnbIPKl0zk1vOvi+eiR+ZKtyl4mK+olWr45t9RXcXavYmAu1J
 GTvO7o2QSdP5fQHxtyhfP1gNDsXgMqlpvi6zA==
X-Received: by 2002:a17:90b:17cd:b0:398:ba9e:75ff with SMTP id
 98e67ed59e1d1-398ba9e7753mr18878191a91.21.1788192672393; 
 Mon, 31 Aug 2026 09:11:12 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3286f7be607sm31355741eec.10.2026.08.31.09.11.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 09:11:11 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 0/8] net/bonding: fixes and per-member stats
Date: Mon, 31 Aug 2026 09:06:40 -0700
Message-ID: <20260831161105.289670-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260708174204.72574-1-wpan3636@gmail.com>
References: <20260708174204.72574-1-wpan3636@gmail.com>
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

The recent RFC's to bonding prompted me to (with AI assistance) to
look at current state of bonding PMD. Several issues were found.

This incorporates the RFC patch series and modifies it to 
have Fixes and more checks.

Added proper extended statistics which allows looking how
members are doing.

Weijun Pan reported the stats double counting and the secondary
process crash (Bugzilla 1900).

v2 - fix bonding.ini flow items

Stephen Hemminger (7):
  net/bonding: fix TLB member ordering with unusable member
  net/bonding: skip unavailable members in device info
  net/bonding: use atomic link status accessors
  net/bonding: restrict control ops in secondary process
  net/bonding: add extended statistics
  test/bonding: add extended statistics test
  doc: add bonding features matrix

Weijun Pan (1):
  net/bonding: skip unavailable member stats

 app/test/test_link_bonding.c              | 148 ++++++++++
 doc/guides/nics/features/bonding.ini      |  40 +++
 doc/guides/rel_notes/release_26_11.rst    |   6 +
 drivers/net/bonding/rte_eth_bond_8023ad.c |  18 ++
 drivers/net/bonding/rte_eth_bond_api.c    |  24 ++
 drivers/net/bonding/rte_eth_bond_pmd.c    | 338 +++++++++++++++++-----
 6 files changed, 495 insertions(+), 79 deletions(-)
 create mode 100644 doc/guides/nics/features/bonding.ini

-- 
2.53.0

