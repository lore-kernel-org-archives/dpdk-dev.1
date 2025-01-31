Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F9AC0218F
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jan 2025 18:34:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6939A40274;
	Fri, 31 Jan 2025 19:34:47 +0100 (CET)
Received: from mail-ej1-f100.google.com (mail-ej1-f100.google.com
 [209.85.218.100])
 by mails.dpdk.org (Postfix) with ESMTP id 0069E4026B
 for <dev@dpdk.org>; Fri, 31 Jan 2025 19:34:45 +0100 (CET)
Received: by mail-ej1-f100.google.com with SMTP id
 a640c23a62f3a-ab34a170526so372528766b.0
 for <dev@dpdk.org>; Fri, 31 Jan 2025 10:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=6wind.com; s=google; t=1738348485; x=1738953285; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CmV/gtb4ls5Bv4dHfJnYf5cRxuInDYkWE9nZg1E9JG0=;
 b=BR/0N+WS8qsPFTidIzG9MvpO++GG6Qfj2U6bWK4IRL0StwSatV916W2kZwBoHRn8yH
 y4iE+z9m38MEz1qS9EjTkxoA9BbAmudsAQC/rd4kCPd4ML7lmp7bn4zEMI2Fsf+7MMXr
 Yvf1ZHeyWljN4W5Hw5M+Hy3tmvF4qVKiLs11X8tfKE7BnH7tg5qtHHdgpcqTh+stOKgf
 3UdRktkoRCk27BsDDg9ozzANMkj6JiePs6QHwXqBeBNaeNVGEhJMNSJqBHsMbQPQ5dRN
 LzGvP5RQ/6xWwJKsb/MzeYDZkqMTzN2jbxkiaU81vRMNh+xDd4hvIVjnt6QjAa3geaVF
 5IzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738348485; x=1738953285;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CmV/gtb4ls5Bv4dHfJnYf5cRxuInDYkWE9nZg1E9JG0=;
 b=s+DhA85LCumuQpcQnwNl2f5lXiAapxkwfc5+jwloIbhE6ZCJ6DUr+Ewwi/H3IWgHFC
 O9Mv5T8ILJcTNcPcG2g9HLsoXIoi+/fJXIcKdkJGAYncaLcGlm/woceH5o2HOvdQmVNa
 dQqUSw02qFOmTEBH6kAurSpZdSTGfvmUqe/t4Vu/Ky1/MyVbLy8DHjNWNnwvdO+PMZRP
 OkR8vjnBnOezjOIwL8uReWIRyijHWg2qNq5Ei4KhsIJLZO3FfuGvgi2Sv+Qp22K1vnjF
 /vHuC2ttU6uV2nYZ7klpyaxUmpbzpZfa71MCO8qviuJQ5R4EzBzCitxFYUA6kMc0FQEe
 yvzw==
X-Gm-Message-State: AOJu0YyROCn3Pl7cbmOFvdhWxU5L4Zf/bHuDG0XLm+ZH8po1mG6ytvaV
 3RrxkwSLTvp/AtzEx1SzLhuEOfHGu07QjYmaGSHoayPoQ6JyotCjBNhn1ho4LoqnHDksk0XENEf
 Grx6RZIdpCk7QgOBeAI4hgR2r95pV+WF121hNvg7c
X-Gm-Gg: ASbGncvz7sHOWPX135F+XA4Kdd5oDwOr9CG9zGew82Rwo01y2iRvFoTK7NuCgmta68U
 V+DY9xjKO78NrkM0vJ5snAbjOf4AYXR0l0MymO4mrnlvOsI2gwS0fvgLTZZhkM1hBDiyHxrNYAz
 clDNDDRqUuO1zGcnxwxIzAcY5T3AEsbUsM130DH0SMUNHq7HU6wepFk+n4ErsN0P4mnJzoiXrfa
 oygJKmkmyrRBXpEhFoe8Vom/jOseBuggj9cKEyUpFTQc6iEHwxAbMeqWzKpVILy+dPxtrBdSEh3
 +Ps47GyAZnIgRMeTivpBltBH8f89ksoHIhBfBBtGb8A3RPXALQ==
X-Google-Smtp-Source: AGHT+IHFIqPeXcacncIKqMLKL2JI/o45KBblfgnRTT4aUzXELTDnVBdAvVV8fWf4gbBujkTFAH1a86eOF33/
X-Received: by 2002:a17:907:96a0:b0:aaf:1183:ec2c with SMTP id
 a640c23a62f3a-ab6cfcb3ba8mr1284867166b.5.1738348485308; 
 Fri, 31 Jan 2025 10:34:45 -0800 (PST)
Received: from smtpservice.6wind.com ([185.13.181.2])
 by smtp-relay.gmail.com with ESMTP id
 a640c23a62f3a-ab6e48ba162sm12494466b.116.2025.01.31.10.34.45; 
 Fri, 31 Jan 2025 10:34:45 -0800 (PST)
X-Relaying-Domain: 6wind.com
Received: from localhost (rainbow.dev.6wind.com [10.17.1.165])
 by smtpservice.6wind.com (Postfix) with ESMTP id 1BBE219C93;
 Fri, 31 Jan 2025 19:34:44 +0100 (CET)
From: Ariel Otilibili <ariel.otilibili@6wind.com>
To: dev@dpdk.org
Cc: stable@dpdk.org, Thomas Monjalon <thomas@monjalon.net>,
 David Marchand <david.marchand@redhat.com>,
 Ariel Otilibili <ariel.otilibili@6wind.com>,
 Ciara Loftus <ciara.loftus@intel.com>, Maryam Tahhan <mtahhan@redhat.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 0/2] Fix use after free, and refactor af_xdp_tx_zc
Date: Fri, 31 Jan 2025 19:34:37 +0100
Message-Id: <20250131183439.909831-1-ariel.otilibili@6wind.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250116195640.68885-1-ariel.otilibili@6wind.com>
References: <20250116195640.68885-1-ariel.otilibili@6wind.com>
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

Hello,

The series addresses Bugzilla ID 1440 in two steps;

1. Fix use after free.
2. Refactor af_xdp_tx_zc().

Thank you,
---
v5
* fix style issues in the signature of reserve_and_fill() (Stephen Hemminger)

v4 (https://inbox.dpdk.org/dev/20250130221853.789366-1-ariel.otilibili@6wind.com/)
* redid the refactor (Maryam Tahhan)
* marked the fix as acked (Stephen Hemminger)
* updated .mailmap, my main e-mail is @6wind.com (https://inbox.dpdk.org/dev/20250115121152.487360-4-otilibil@eurecom.fr/)

v3 (https://inbox.dpdk.org/dev/20250128231152.249497-1-ariel.otilibili@6wind.com/)
* reworded commit message of patch-1
* addressed feedback of Maryam Tahhan

v2 (https://inbox.dpdk.org/dev/20250116225151.188214-1-ariel.otilibili@6wind.com/)
* reworded commit messages
* addressed feedback from Stephen Hemminger

v1 (http://inbox.dpdk.org/dev/20250116195640.68885-1-ariel.otilibili@6wind.com/)


Ariel Otilibili (2):
  net/af_xdp: Fix use after free in af_xdp_tx_zc
  net/af_xdp: Refactor af_xdp_tx_zc

 .mailmap                            |  2 +-
 drivers/net/af_xdp/rte_eth_af_xdp.c | 64 ++++++++++++++++-------------
 2 files changed, 36 insertions(+), 30 deletions(-)

-- 
2.30.2

