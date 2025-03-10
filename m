Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B13CC282DE
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Mar 2025 21:01:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 31B1140268;
	Mon, 10 Mar 2025 22:01:40 +0100 (CET)
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com
 [209.85.167.182])
 by mails.dpdk.org (Postfix) with ESMTP id 8D2D4400D7
 for <dev@dpdk.org>; Mon, 10 Mar 2025 22:01:38 +0100 (CET)
Received: by mail-oi1-f182.google.com with SMTP id
 5614622812f47-3f417de5e25so2146065b6e.3
 for <dev@dpdk.org>; Mon, 10 Mar 2025 14:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1741640497; x=1742245297; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XuKMch+7DwwU00/wwzL2ItxdSJilk4JF/HxnNd0UM6g=;
 b=Ctf7N4QW/YUtNJragfKJ8KubckRVlgNBMPxwD7Hi0kEGkz4FlfAyeOFVK7Pb5XFGGM
 diMRL+QRgAo7Z7OwGBiGc0yW7rdfzcb+iDXQ9g4kZSvclLWbj7yR53c5JFVcY6t085ml
 AA/lqdrWVqPt6+4/Pc9CYuI5fHhyeQQdyC3jk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741640497; x=1742245297;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XuKMch+7DwwU00/wwzL2ItxdSJilk4JF/HxnNd0UM6g=;
 b=DMvucMyQpV6ZWk5AMW0HBcbjAWzMWinBzNtz6MXsBXur1gaGmC8WAU2LeVQ91lOPB9
 nt/6nyvKn0nIHOV3igfH8x91vsOveQmTI7Y12OXKiZ4roXPfuJDx+nKPkmJzQmvTbO0O
 CVe1dF0cLDXH3f7RJyW3Du4GFk1y3TcVUoiC2+RhK3uWvSArDSDYydKuOVvgqDadPHDC
 R8CDixamgTefi7QzPh/VABSTpDreyIKaEBT5YJ4MjG0aZ+UlImgFe+n/TWyYF2HRtEer
 KYXrfO9TgTpY79umkDLkAiAhGcgN/H6QcP4X/QaM8tJt/dlYAQXLZV8GfCcfpOwG/FOf
 6HZQ==
X-Gm-Message-State: AOJu0YwWqPnDhjhe4yxr8tjKcHvQz+vP2ZwAW7HMSUwpbFs7jS+zUYXY
 +SNRK2VE75OfFN7w5tzAWWUysYIcQ2/WuYK29vbY6/frH9fhS9WrDYjrOJ8XKqYUcdh7+voJvjh
 WF5HS89oZuc/Zo2tl7J49YwwBA1z/qx9uwbqd3vPMvopDeMFjtGOAKchw8WUckuDZrAvP0wBQN0
 JpKM0Qm7e24vBU6b5kSgzZaWSroRmF
X-Gm-Gg: ASbGnctyni50liUVeGM4+j+DJucSUNP03YEGZ68RzyuR0l9tu1OW45K61afLEMzzwwH
 ZTDm+1Pgb07COMYuKCmAP5Bh21bSzHfbq3VIRbf6Hf1iwXA4+Brrsbyp04+szBx5eoXpLnRqVl/
 qKoUKYS4oaLmUVYHuTt/O0UESeIPCVXSv2d+wpysl0p4vM3EKKx9OLs9OpIRAjnFjPlrtGjMIlg
 HUg3f44NghDVFgPnpRhnRD+OWE9FwZFKULqZOKclfbjh3e8lNOXb1pT+MnrniYeivtQhHNmo3/T
 0f9OiQIIqmNwULFq5RTVBakpa/gKBmZlHv9rogntcqD76IpaKlO3sqBBm9RPFcF2nsMUQOEyD6S
 +lSN+Ag3Uy5otPBzMEbqEXMdrkT6J/H31vMZmCg==
X-Google-Smtp-Source: AGHT+IFpSDl44fgj8Bz+T/WGQ65EEpAg2XSU6kGJaH5z2GU/N6oY1SJ7jJCruKHtGPC2Kbj2aPERew==
X-Received: by 2002:a05:6808:1506:b0:3f6:7ed5:8fe8 with SMTP id
 5614622812f47-3f697af95camr7016924b6e.6.1741640497396; 
 Mon, 10 Mar 2025 14:01:37 -0700 (PDT)
Received: from C02GC2QQMD6T.wifi.broadcom.net ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3f7dcdc4050sm1034092b6e.40.2025.03.10.14.01.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Mar 2025 14:01:36 -0700 (PDT)
From: Ajit Khaparde <ajit.khaparde@broadcom.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net
Subject: [PATCH 0/2] bxnt fixes
Date: Mon, 10 Mar 2025 14:01:30 -0700
Message-Id: <20250310210132.48829-1-ajit.khaparde@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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

These patches address a couple of issues in the BNXT PMD.
Please apply.

Ajit Khaparde (2):
  net/bnxt: configure burst threshold based on speed
  net/bnxt: fix epoch bit calculation

 drivers/net/bnxt/bnxt_ethdev.c          | 20 ++++++++++++++++++++
 drivers/net/bnxt/bnxt_ring.h            | 19 +++++++++++++++++++
 drivers/net/bnxt/bnxt_rxq.c             |  1 +
 drivers/net/bnxt/bnxt_rxq.h             |  2 ++
 drivers/net/bnxt/bnxt_rxr.c             |  4 ++++
 drivers/net/bnxt/bnxt_rxtx_vec_avx2.c   | 18 ++++++++++--------
 drivers/net/bnxt/bnxt_rxtx_vec_common.h | 11 +++++------
 drivers/net/bnxt/bnxt_rxtx_vec_neon.c   |  9 +++++----
 drivers/net/bnxt/bnxt_rxtx_vec_sse.c    | 18 ++++++++++--------
 9 files changed, 76 insertions(+), 26 deletions(-)

-- 
2.39.5 (Apple Git-154)

