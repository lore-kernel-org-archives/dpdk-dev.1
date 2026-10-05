Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A694CA5FF0
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 15:17:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 86A1140A80;
	Mon,  5 Oct 2026 17:17:35 +0200 (CEST)
Received: from mail-yx1-f100.google.com (mail-yx1-f100.google.com
 [74.125.224.100])
 by mails.dpdk.org (Postfix) with ESMTP id BC5544029D
 for <dev@dpdk.org>; Mon,  5 Oct 2026 17:17:33 +0200 (CEST)
Received: by mail-yx1-f100.google.com with SMTP id
 956f58d0204a3-66c9995ca60so1283876d50.1
 for <dev@dpdk.org>; Mon, 05 Oct 2026 08:17:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791213453; x=1791818253;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=+qhKDEW7QVRuHznJYJa1AfIT9p7tgFgPdR73/3hnNbI=;
 b=I+lXVH3fqYstTA3m97axWak37uxsCCgizNVizsNgWe0VJr72sB06Mljy3so00Bw9WJ
 nrkjW4g1RdLzxEQu6HzSjldNkvx7OiXNB36mcPZ9jkmrlf4Tz/sXwMUJ0wVp/jmxXa71
 kKR7NgIsoOHrNKWT2taw8wuKHi6t9fZe3T0okBV0Qjyy8MDQ3LSondCLFhqzV+vqBQJG
 axIq8ZCPZIB8w7+n7QkwiCVz9vDW4YXC6TPMk9ITxDhKZWxi0uunMlz3hvBELZGMndki
 fmwbS4G3XIw4e5rOZJve/rPSidYrqnZSNaYAoQ7nR2ko666o1j8gqlYGVRpcKQzaKeZN
 v9dA==
X-Gm-Message-State: AFq9FYIdO5ozoWazV/4m2ecZ8cob6t6uWtuYITwwJJMmGjiW9RHCisli
 G/yC9TwaxzGoFX1/f30cqsRyLXk5JG22drjkp/5QowIkOVjdpdFhj/EWBgDZAkKkOk4pkCa+SqB
 JCsQTZ8cnxHQdLxeRdNpMeYKXQKnwF+jDrPso4rO2JtpzBU1eKB1+fyYpJDu+21hRsqEJCE2Q0L
 IZ+FfIL+rMqFpswkOjybOK8vQxwW94nVemrQAJ6cMMnyaNXxWUmfNtuP0DfnrAuLLisGwlYw==
X-Gm-Gg: AYBFou1sb9iRNT0bhaONUNyX5dDkNWE3hRCMxpMtPmKfu7oy0OwT7TJVrUWtmDPlDd8
 tnZgLNBNHS25CxiVKNGPOCtYBAxAFj5ptw/YqZaFP4jm5QbjoAB2a8A6i8ds/zALaGsvAUVIIPK
 qRMra7SyhGdWIvNf12fhC1JPhED1mC0GR9uhy1+8rWzZLUI3XJSwvK21ckkQ0duLwLwV9bnBlJe
 oNZ8+a0O6es2UDegNWdeBb4ACeCksd6zxMmbNQonaS6HJXeVNjb7hrpUjUy2pnsOkdrhUNUZ/Hy
 eXQPYXWTamzrhz1OPdWYt2AgKrsolBgriDdeGhipFCHJTYFtUHC7zVDumvyL+TaFg4SDYP/ZDaA
 DqcSLZS/+9gkewQiQMznOHzhToVSv1eQFWoZFWjqIUX0vz2j6M1OHOfPGi4si234th0IlXWZRwP
 AVGq+J0xm1CTtSs71z3w2siDuUbQBDj9o0aDZKeA==
X-Received: by 2002:a53:d048:0:10b0:677:ede9:3d46 with SMTP id
 956f58d0204a3-677ede9478emr44471d50.2.1791213453012; 
 Mon, 05 Oct 2026 08:17:33 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
 by smtp-relay.gmail.com with ESMTPS id
 956f58d0204a3-677c16b2fb6sm1311686d50.0.2026.10.05.08.17.32
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 05 Oct 2026 08:17:33 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-917870a9be3so53056d6.0
 for <dev@dpdk.org>; Mon, 05 Oct 2026 08:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1791213452; x=1791818252; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+qhKDEW7QVRuHznJYJa1AfIT9p7tgFgPdR73/3hnNbI=;
 b=B/SB7WdNflHOMKV7NOSzY5FW51N3Je45Ucz9Fz5qF6TB5LedoFVIFYtWXjNOaZcARs
 Rb3yFSxD7oRomeeyU5j8kGR29gscEB0K1r7ltM+Gb83d0YCkYquxCexByZZBDr+HvO/Q
 7Ei90/OztsN0LhT65HQlcgtfEi/g4vA1Eq9Og=
X-Received: by 2002:a05:6214:5413:b0:919:5e97:76b7 with SMTP id
 6a1803df08f44-9195e97771dmr147910586d6.18.1791213451762; 
 Mon, 05 Oct 2026 08:17:31 -0700 (PDT)
X-Received: by 2002:a05:6214:5413:b0:919:5e97:76b7 with SMTP id
 6a1803df08f44-9195e97771dmr147909766d6.18.1791213451158; 
 Mon, 05 Oct 2026 08:17:31 -0700 (PDT)
Received: from r740-105-132.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-917e0b19decsm89364566d6.14.2026.10.05.08.17.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 08:17:30 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com
Subject: [PATCH 0/2] net/bnxt: fix two ULP parser/mapper safety issues
Date: Mon,  5 Oct 2026 10:17:25 -0500
Message-Id: <20261005151727.1706155-1-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

Two unrelated hardening fixes in the ULP parser/mapper found during
review:

- Patch 1 caps a header-field memcpy() at the field's spec size,
  fixing a potential overflow when the source value is larger than
  the destination field.

- Patch 2 replaces a variable-length array sized by caller input
  with a heap allocation, avoiding unbounded stack growth.

Dakota Sicher (2):
  net/bnxt: cap memcpy at field size
  net/bnxt: replace VLA with heap allocation

 drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c | 10 ++++++++--
 drivers/net/bnxt/tf_ulp/ulp_rte_parser.c | 10 ++++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

-- 
2.31.1

