Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3311AC28B24
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Mar 2025 21:47:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E607440DD1;
	Thu,  6 Mar 2025 22:47:51 +0100 (CET)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com
 [209.85.160.175])
 by mails.dpdk.org (Postfix) with ESMTP id 5881640DD1
 for <dev@dpdk.org>; Thu,  6 Mar 2025 22:47:50 +0100 (CET)
Received: by mail-qt1-f175.google.com with SMTP id
 d75a77b69052e-47521c604efso14603511cf.0
 for <dev@dpdk.org>; Thu, 06 Mar 2025 13:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1741297669; x=1741902469; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5G8Y6yTnyq7Napqn5OgN8wgypPo0nh25ExSMq0DrBZY=;
 b=Lj8vwVbD4Fe7A5g/vofRVc63bEvYBgtTCQz6SvLFhGAiqtYM35h3a0O235T+PGDhmg
 BdsCliPeT5nmHvxvILbZGsAhIYXrGw9G6fjRngwO0kkj+eyZJd3tfmlTJyvYT0jfhYX3
 FkA/R+QZvnTpARptS2jwMFsB7kGdlXcXmYwdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741297669; x=1741902469;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5G8Y6yTnyq7Napqn5OgN8wgypPo0nh25ExSMq0DrBZY=;
 b=bxoHQIP6ANBeaG+tMWGPSk3kRmy8oq/357uQDlxcLZIm+7xRNSvvYDPl2LrllE5n5e
 qEdE/LuAnJHLf/JMFEH8lv+6DRT73d09h2PCo7/r4xbnTOMVf9VefoEqtrUEt+1vtw9K
 /u8Ae4htnA1lGX96XyUcns4h0BG4Xz5NmJd7rksp7mF/+oNu+KEyi9+fDdKEGC2qhfW3
 q7AzNY3THuC2y2MZhhcr6jN8X1TQ32H7MglwKBJsXluO3XDkr2ZUwuRsFvnbXVt+VCT8
 CqQGmcqeQwgGQYjLA/sUp/H1XZfWGQH+Y6WGGXrCnIfZVktWkffCGExPJc4iv2rUS2uC
 Tsaw==
X-Gm-Message-State: AOJu0YwmRvIAajs8okJ8rIOUnBe9+qE9Ev7DESIm54V2g3mnvxVTNlPE
 W08yLzqJmLBmSp7hKAdvzhmdINn65Id+hPCzVL907apwgz1GF6DSAlS3b04HphM=
X-Gm-Gg: ASbGncs1ViQuwajGAUPmmJScNHHv4GjLaKIg+BhuquULiROp25XguFl0n0etYphpcCu
 oLVuhCRI/EwniYii5kt+fd06556hUB/7CQzevF6nvdDocOPn29MS9b1JcL2PGieSJ7nMLrozmDU
 dijH+99vR13Q++DNybK7Q0a62NGaHpEM1BHNlwjYdl4DvauM8oYvJquwqq5zXW7yiwc/D8OHLsL
 hEeEo95rxXl0bqCrPDbKmculeZZocjbjqGUnddBykq/HdHyWnISAL047rzFitQfH4MKVScnEqsB
 ZQHBZPwFoKqp+BFq+47hmfKzqGWJF9FlDTsoV6T5Cuiz2cjhBF8/jfz9D4xwmwtzn0E4qMf3p2d
 CT5a0Tsbz
X-Google-Smtp-Source: AGHT+IFl40jv6ErqJUO7CAjZ8SMeoBS268+Hv+jJBReWL9uS4J6oyIORd6LC6GF+An494Nj9HJ65Zg==
X-Received: by 2002:a05:622a:1485:b0:471:f1f1:ae71 with SMTP id
 d75a77b69052e-47618af9cc5mr9411061cf.52.1741297669650; 
 Thu, 06 Mar 2025 13:47:49 -0800 (PST)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:ac5d:4186:4dc6:47eb])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4751db4ca3fsm11892341cf.70.2025.03.06.13.47.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 13:47:49 -0800 (PST)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, npratte@iol.unh.edu, luca.vizzarro@arm.com,
 yoan.picchi@foss.arm.com, Honnappa.Nagarahalli@arm.com,
 paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v1 0/4] dts: change verbose packet verification to layer 4
 ports
Date: Thu,  6 Mar 2025 16:47:43 -0500
Message-ID: <20250306214747.579340-1-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.48.1
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

Currently, the unified packet and checksum offload test suites
use a random MAC destination address as a way to find sent
packets in testpmd verbose output. However, this does not work
for certain NICs that change the MAC address prior to reception.
The new verification involves setting a random UDP/TCP destination
port, and scanning the verbose output for the port.

This series depends on a testpmd verbose output patch, which
is listed below.

Fixes: patch-146043 ("dts: checksum offload test suite")
Fixes: patch-150118 ("dts: port over unified packet suite")

Depends-on: patch-143194 ("app/testpmd: add L4 port to verbose output")

Dean Marx (4):
  dts: add layer 4 port field to verbose parser
  dts: change verification field in checksum offload suite
  dts: remove unnecessary capability requirement
  change verification field in unified packet suite

 dts/framework/remote_session/testpmd_shell.py |   5 +
 dts/tests/TestSuite_checksum_offload.py       | 131 ++++++++++--------
 dts/tests/TestSuite_uni_pkt.py                | 106 +++++++-------
 3 files changed, 133 insertions(+), 109 deletions(-)

-- 
2.48.1

