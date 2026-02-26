Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476AFFCE08C
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 14:34:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 611904027F;
	Thu, 26 Feb 2026 15:34:05 +0100 (CET)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47]) by mails.dpdk.org (Postfix) with ESMTP id 18AB44026F
 for <dev@dpdk.org>; Thu, 26 Feb 2026 15:34:04 +0100 (CET)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-43984d7e49bso842526f8f.2
 for <dev@dpdk.org>; Thu, 26 Feb 2026 06:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772116444; x=1772721244; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hVQbT27a/7RWqmmaMbNIEUv7mfy3m0Q5pghCBRLQQTs=;
 b=CeeQ3R+e6LxkmV81kFyfKvOYJbQj+G6ozfTP3rnSwdn8F89C0jiFZJV9T10rOYWYks
 Tw96pUaITMBZa/Qqn2VkJTfBzGrbF5YLfeinneNV+6+snk2+msESf5r5l78LfA45a8PI
 46v60YF685J5wyy1imKo7neTC+bh5coDcfksPBIQnOzcI2k2vxPcpMuyG54uqvgC5q2m
 mnLtgeB9YeQMogpb321Lk2HUTe9J0qzR6Om4Yy9ob/expXebEhjA8W1ZHc9o2vaMMDUi
 AGvOJGfH6r/E98jUrSK9S+wVZDQ+x/gNA8wnQFtmwVkgI0H9h+/hzNFglqqrNYqMaHx8
 RgrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772116444; x=1772721244;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hVQbT27a/7RWqmmaMbNIEUv7mfy3m0Q5pghCBRLQQTs=;
 b=Ves6VFaN0WZTzaJ3iokv7Y3GhXXdqB7ouwtJbbxIOUmrh+ZlMmUOCQjmcHTGHyu5FO
 udg3wX63Qu2sOQUwSA5p2V7WTLeteefMVH1Qk/LuZE9mQEh7bA6ZzYCxjAMyNl+qswp0
 bcNuSR6gdNBJMtG58t6l8194izGvC68bG1dc0nIlSLL1qU8xqg4hg2bxzT6cu3eKJu0q
 XDMPTIecMPlsvM0uTXd18wLaHJtfryyH3FFe6o2Gp2digL/8mHk2QSM+MQa/pQ1wciYC
 bPyF/IoLScg1zgWiGBlJabP/c0TbSrn+hXkdCxUrej0eJFLsKn/lanQwy1H3by8k6RFr
 2rVg==
X-Gm-Message-State: AOJu0YxJO1LzqY06Q5y/pB267ewD+q6KHnII2wQQD6WLvQuckbByDbLU
 zpRDFJ/a7yAWp2UJ+Slh+ZThvNhoPURArCnZtqndK2P8I4CuLGNUnwVLbVVLnA==
X-Gm-Gg: ATEYQzybhIwhFdeFYAVSJIHhexQXq3Ja9fDKO4NCw0LPuLw0yWT/RK+OF0IOpwMy6+c
 x7IpzOM9wTy2//YceIreKnlfw9q0nvxU+7Ez/2Zbj2hq/y9Qd5xwXCGqXkJreIPNPgUHFP19XF7
 NRRhdr6vjs2uUgqKLgMtbBKqrJsU/Oub6dU1R00VEUkU5FaFfh1Du9vw5DQBjoedAztU1J372M0
 ctLtpoH5aR9yZXVNP6Cl1wCykWMAyaz7pI7gmDzhHLGK5rXz42ydFVqsIuRLislUQ+iSboRfQDu
 zuKcKSSPrtRkCh0ihOvsA4VVMSemSV+01+47/ZD0MpVT8z2AADSXjz+tZnb3U/mXb6OhNaHbmYv
 3P6QVZSjq+DaZN8gRzuFn4NM0mxgzL/B98rzC6dNeqooTYL4iIrDGLHkHv7OWyQCVlsHuXlSPNr
 mK6graqaXfIQqdjHyii0eVIq/5MA==
X-Received: by 2002:a05:6000:2404:b0:437:7773:91d6 with SMTP id
 ffacd0b85a97d-43997efd008mr4900993f8f.25.1772116443369; 
 Thu, 26 Feb 2026 06:34:03 -0800 (PST)
Received: from freepad.iliad.local ([213.36.9.96])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4398bb96b90sm17993866f8f.9.2026.02.26.06.34.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 06:34:02 -0800 (PST)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com, stephen@networkplumber.org,
 david.marchand@redhat.com, Maxime Leroy <maxime@leroys.fr>
Subject: [PATCH v2 00/17] net/dpaa2: fixes and improvements
Date: Thu, 26 Feb 2026 15:33:24 +0100
Message-ID: <20260226143341.282188-1-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260218160453.142311-1-maxime@leroys.fr>
References: <20260218160453.142311-1-maxime@leroys.fr>
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

Patches 1-6 fix resource leaks on port close, error paths, link status
and devargs propagation on hotplug.

Patches 7-14 fix additional bugs: spurious VLAN insertion, error packet
dump crash, packet type classification, checksum offload flags, software
taildrop buffer access, burst mode info reporting, SG table walk bounds,
and MAC stats DMA allocation.

Patch 15 is a minor cleanup in the link status area.

Patches 16-17 add devargs alternatives for getenv-based configuration
of taildrop and data stashing options.

Changes since v1:
- Add Cc: stable@dpdk.org on patches with Fixes: tags (Stephen)
- Reorder series: fixes first, then improvements (Stephen)
- Patch 2: squash with former patch 4 (Hemant)
- Patch 6: move devargs refresh from plug to scan rescan path (David)
- Patch 17: keep getenv for backward compatibility, add devargs as
  alternative instead of replacement
- Drop former patch 11 (bus/fslmc: remove dead blocklist check) to
  avoid disaligning with other buses (David)
- New patches 8, 11-14 fixing issues reported by Stephen
- New patches 7, 9-10 fixing VLAN insertion and packet classification
  issues

Maxime Leroy (17):
  net/dpaa2: fix queue block memory leak on port close
  net/dpaa2: fix rx error queue memory leaks
  net/dpaa2: warn on rx descriptor limit only in high perf buffer mode
  net/dpaa2: fix resource leak on softparser failure
  net/dpaa2: fix link not up after port stop/start
  bus/fslmc: fix devargs not propagated on hotplug
  net/dpaa2: fix spurious VLAN insertion on non-VLAN packets
  net/dpaa2: fix error packet dump crash and memory leak
  net/dpaa2: fix L4 packet type classification in slow parse path
  net/dpaa2: fix L3/L4 checksum offload flags
  net/dpaa2: fix software taildrop buffer access
  net/dpaa2: fix burst mode info to report active burst function
  net/dpaa2: add SG table walk upper bound in Rx path
  net/dpaa2: fix MAC stats DMA buffer allocation per xstats call
  net/dpaa2: use CHECK_INTERVAL macro in set_link_down
  net/dpaa2: add devargs to disable Rx taildrop
  net/dpaa2: add devargs alternative for data stashing getenv

 drivers/bus/fslmc/fslmc_bus.c           |   4 +
 drivers/bus/fslmc/portal/dpaa2_hw_pvt.h |  16 +-
 drivers/net/dpaa2/dpaa2_ethdev.c        | 211 ++++++++++++------------
 drivers/net/dpaa2/dpaa2_ethdev.h        |   3 +
 drivers/net/dpaa2/dpaa2_rxtx.c          |  85 +++++-----
 drivers/net/dpaa2/mc/fsl_dpni.h         |   6 +
 6 files changed, 164 insertions(+), 161 deletions(-)

-- 
2.43.0

