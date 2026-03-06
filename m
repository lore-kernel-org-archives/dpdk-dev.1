Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69925F01832
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Mar 2026 13:30:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 78247402D3;
	Fri,  6 Mar 2026 14:30:44 +0100 (CET)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53]) by mails.dpdk.org (Postfix) with ESMTP id 2143640262
 for <dev@dpdk.org>; Fri,  6 Mar 2026 14:30:43 +0100 (CET)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-439b790af67so3455018f8f.0
 for <dev@dpdk.org>; Fri, 06 Mar 2026 05:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772803843; x=1773408643; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qBWEuMyduPm7Y1tiFF+Us69iEMP4dlldobDWwy7gNP0=;
 b=aTQiMC5NLAmul6IlljnJcQeqM2eDGZtjPhbpFEX8kTro7AnQ+V0A7VNd+0Az+1h81T
 tAP7hTFkObUll9RXRRaLF7DCAbsUzDyBkFuwWD//1GvIW0yD4GY5qKdYXg/tH3dlugeK
 Ahg4VbrGXfQvv07Jx/flFjvNgqlzQXva9Quw0iNTLV1STfXmiYDnVLS91FrsjfGxeEuC
 ZH85UUqzUf5A29gViwbot6DaaLpUq/rxBF9Shn8SDiGnuJ90+Ecdytma3Zl2CJbOB9Lg
 Ws45frgfOWi4+chdSz/Y03qIQRRhv6YjPrOfifNFb0XFm2aaCtu29Vf9csJ20AArSR73
 C3jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772803843; x=1773408643;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qBWEuMyduPm7Y1tiFF+Us69iEMP4dlldobDWwy7gNP0=;
 b=iwuPg6+IcDh8bDXEo5xeoPbCjdj5A37W6c4b8NZstP03iNvtGGWMT/29alEbDkIjyO
 bUSvXSNuhqqAucJ3V/7SmoThuwSzBdEspPoHRvy4PJHgKy30DOsTejtLxWw6sk/nA73A
 9p+XAmjPRS5g//C2KMvOKjxwtWb6TB4QhrDrWpAMAqALxf3k8cgJRo/F2BedDb+rtcOJ
 pDDLJc0uVPnKb7p/S3zbhFltGWdrcBatyqBznf6mmntLiJnXNlNPKMva7nlAoeICp+vv
 BAMMB2JKMBhzbFS1sDNfLNOAoSXd13SB6TXras9f7ppKjpoLze6WHTKmRoiZiXpv1mia
 t74Q==
X-Gm-Message-State: AOJu0YyhRrPyctVy4BcS/RUnKtxNcEXu82E8VGt5CMKPAnfjoTceCXm1
 TfXflUh2xjTnNa/vMfVucGoItCjQLxZTojR1Ak0OSUXTErRXHW/TJ61wgHxMBEk9
X-Gm-Gg: ATEYQzz1lfSpLMy8vsMaXNVKx56MGnXRg5+FKvWFd9aukKKzjpn+RytfDlznX/oEF5W
 9Om+7xaMoToDSc/pF+17K0Al9NVN4LnEztI3M08lyIcvdwGjwgNkPBhMr/anguIsOGuX8mY2jsk
 hy/AcE/LRV0ZYpKhndpIYpDsvjaYu7LTuw+THLFnzdQSMF0TW+nVEhWUZLxrT7R039ZPHKvdi3c
 Dcab6yyU56Tky5Kae57UD2qOhrhOrkCn4oaBttoSOcwKtcUBjd8P15nSVMrV7rasEgQAgQzW6lZ
 XojiEXOjyO1xioCwJJV84Pbq3zw4R/IqYiJE0nEfqZCckfrB23iDL8/Ih7TNYGRg4UBT1ylJKHD
 fKGaRv29da3OLzqeHLHOLMP5+QNyJUTeJqtUqgPuQ9bzro4OLVdqa/Q1WxumWrRAQTtaCPgaTxy
 gbxg2cm+qcQI/slGVvCoXLSB1zrws=
X-Received: by 2002:a05:600c:198a:b0:483:a352:b4e4 with SMTP id
 5b1f17b1804b1-4852671c9b1mr33689915e9.6.1772803842386; 
 Fri, 06 Mar 2026 05:30:42 -0800 (PST)
Received: from freepad.iliad.local ([213.36.9.102])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851fb27a13sm111941645e9.11.2026.03.06.05.30.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 05:30:41 -0800 (PST)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com, stephen@networkplumber.org,
 david.marchand@redhat.com, Maxime Leroy <maxime@leroys.fr>
Subject: [PATCH v3 00/17] net/dpaa2: fixes and improvements
Date: Fri,  6 Mar 2026 14:30:18 +0100
Message-ID: <20260306133035.179709-1-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226143341.282188-1-maxime@leroys.fr>
References: <20260226143341.282188-1-maxime@leroys.fr>
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

Changes since v2:
- Fix checkpatch warnings: short SHA in Fixes tag (patch 14),
  long line in commit message (patch 10)
- Fix check-git-log warnings: shorten headlines (patches 3, 9, 12, 14),
  fix tag order Fixes/Cc (patches 10, 11), fix wrong Fixes reference
  (patch 8), remove colon after function name in commit body (patch 8),
  lowercase macro name in headline (patch 15)

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
  net/dpaa2: fix Rx error queue memory leaks
  net/dpaa2: warn on Rx descriptor limit in high perf mode
  net/dpaa2: fix resource leak on softparser failure
  net/dpaa2: fix link not up after port stop/start
  bus/fslmc: fix devargs not propagated on hotplug
  net/dpaa2: fix spurious VLAN insertion on non-VLAN packets
  net/dpaa2: fix error packet dump crash and memory leak
  net/dpaa2: fix L4 packet type in slow parse path
  net/dpaa2: fix L3/L4 checksum offload flags
  net/dpaa2: fix software taildrop buffer access
  net/dpaa2: fix burst mode info report
  net/dpaa2: add SG table walk upper bound in Rx path
  net/dpaa2: fix MAC stats DMA alloc per xstats call
  net/dpaa2: use check interval macro in link down path
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

