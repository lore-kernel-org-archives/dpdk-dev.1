Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8260EE9A02C
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Feb 2026 16:05:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 89078402E1;
	Wed, 18 Feb 2026 17:04:59 +0100 (CET)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53]) by mails.dpdk.org (Postfix) with ESMTP id 198734014F
 for <dev@dpdk.org>; Wed, 18 Feb 2026 17:04:58 +0100 (CET)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-483770e0b25so61425e9.0
 for <dev@dpdk.org>; Wed, 18 Feb 2026 08:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771430698; x=1772035498; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=aq9m8TCaFaebm5ZUVbPJhzlFZoz3cP1oToodKCFwzDs=;
 b=SXt03PzlRFbbuj6JO/67CajBp+BlCmmt96fQYOEDU3kVL/y5GinpNtvE0mbWBJ2gIH
 sIeNXr9PRSkZTcptBf9TKsUncj3DjbllqO02Soq/KOl5pxAGz5mktwwzG03Q71SLLHEL
 U7hGGnPHgOnhsEEfEhEuv8K9LCtfA3Rk8o9rOATrB9MTLAh9d/vtIs0GNefmgGbwB0p9
 gSUaAKQqticBiQV3KVYs7t6N3EbYF4E39Ph6LJVLk8krehb871M4JEFF83RHqp6d7VOa
 wJKmwBeVKS1ptZhQwTX5KqZnwYyNgCZnB0W6hnqJ5jEX93pBFORNCPNsK73Ss4v0KPSZ
 pxRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771430698; x=1772035498;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aq9m8TCaFaebm5ZUVbPJhzlFZoz3cP1oToodKCFwzDs=;
 b=ImFnYg0sJuIBDZa6vmsLdMsPsuw3JWeqMAHTKP6f33gBP+8T0rDnvI5UDzFy+IGZBR
 Wzw0LO2a1nikwpGZfOJo52X4uk2z2sTsU+S43i1gb0Ct0BQtcsn0I0Y0UXP3kak4XHQn
 0ti4GDb1oFP/Mc5yTzyVWeBy/u6tpskTeFqnUi9jQe7RlRkAc2XHyQ3+bRkPNameqDHX
 nQLz2h6fkbItnzW8IdTYG2nC9uu0bKM3wAIxTivhoRQIN0oW8ofEuNFJgTj7UxVyx+CQ
 SLuFyNcU6oru7Jh83ERw2VcZpbATIeWViKHx4IGBuBxeRsEd5tuT9KWCLztYoGpYTN6k
 V8nw==
X-Gm-Message-State: AOJu0YzRnz3M/A3BT6gXn1+vpqc4hUKrroMqiF22HRhhOUlDJ8hW125N
 vIBRz8UeU7VLfmnZj9xyYEJbec1m9hkQGW0TJ3uhLRWM3jKqgOJ++NIJ6Iu9Yg==
X-Gm-Gg: AZuq6aI6W66sNlXmX5X8k2z6YdDCQZsddsdA01HN6TdGA3rsdz6R0pzWmlBk35ttMhc
 XPu8qoRYFqTMoA/IcoRU4qONVUpxJ3B6UyW9v5Tj9PojTDUMkttp+P1iNLKKzs0aPfWrvMYgnRj
 XtiMGUy0Vc4h8EWEZLO2oipgCHXJ+v9lNBLmCkBRvcUbWm7y0BGTF6Yr66N6jbFQuEeCpEcbe0Y
 5Kb5BmrZfiRD3xg2wjgAn2X7vhTukontwamMLTctQ4dwS80gobr9MULDEpL9yoaocp+Y9Q8H3Tz
 YVle0gHtNsGlmsLPYMZaMziTDyEe+oG/SXLk+ltUP6Ohz31h6wAwsbZRZxWhQR6Gy58IYoOcYpK
 rSBL1vRn4DITFaZmUFJ2dQLK46iLHB/NJpFtv5l5I9e/wnnTmWGroKrcP9MpslU7s8Fnrab0rGh
 9gJPZV+/A2FkcQY/9mP09vXWbi5PeUM3GhSf6v
X-Received: by 2002:a05:600c:314b:b0:482:eec4:772 with SMTP id
 5b1f17b1804b1-483710962c5mr245777725e9.32.1771430697256; 
 Wed, 18 Feb 2026 08:04:57 -0800 (PST)
Received: from freepad.iliad.local ([213.36.9.41])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835dd0e327sm604619175e9.14.2026.02.18.08.04.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 08:04:56 -0800 (PST)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: hemant.agrawal@nxp.com
Cc: dev@dpdk.org,
	Maxime Leroy <maxime@leroys.fr>
Subject: [PATCH 00/11] net/dpaa2: fixes and improvements
Date: Wed, 18 Feb 2026 17:04:42 +0100
Message-ID: <20260218160453.142311-1-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Various fixes and improvements for the dpaa2 net driver and fslmc bus.

Patches 1-2, 4-5 fix resource leaks on port close and in error paths.

Patch 3 fixes a misleading Rx descriptor limit warning.

Patches 6-7 replace getenv-based configuration with proper devargs
for taildrop and data stashing options. There are still 8 remaining getenv
calls in the driver that should be converted to devargs.
Note: the taildrop disable path has never been reachable until now
and is untested. NXP maintainers should validate this feature.

Patch 8 fixes link status not updating after port stop/start when
link state change interrupts are enabled.
Patch 9 is a minor cleanup in the same area.

Patches 10-11 fix devargs propagation on DPNI hotplug.

Maxime Leroy (11):
  net/dpaa2: fix queue block memory leak on port close
  net/dpaa2: fix rx error queue memory leak on port close
  net/dpaa2: warn on rx descriptor limit only in high perf buffer mode
  net/dpaa2: fix rx error queue leak in alloc error path
  net/dpaa2: fix resource leak on softparser failure
  net/dpaa2: add devargs to disable Rx taildrop
  net/dpaa2: replace data stashing getenv with devargs
  net/dpaa2: fix link not up after port stop/start
  net/dpaa2: use CHECK_INTERVAL macro in set_link_down
  bus/fslmc: fix devargs not propagated on hotplug
  bus/fslmc: remove dead blocklist check in plug path

 drivers/bus/fslmc/fslmc_bus.c           | 12 ++---
 drivers/bus/fslmc/portal/dpaa2_hw_pvt.h | 16 +++---
 drivers/net/dpaa2/dpaa2_ethdev.c        | 69 +++++++++++++++++--------
 drivers/net/dpaa2/dpaa2_ethdev.h        |  3 ++
 drivers/net/dpaa2/mc/fsl_dpni.h         |  6 +++
 5 files changed, 71 insertions(+), 35 deletions(-)

-- 
2.43.0

