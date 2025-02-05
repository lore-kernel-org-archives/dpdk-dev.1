Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B85CEC02192
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 17:20:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DC75C4060C;
	Wed,  5 Feb 2025 18:20:10 +0100 (CET)
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com
 [209.85.210.47]) by mails.dpdk.org (Postfix) with ESMTP id 116B540261
 for <dev@dpdk.org>; Wed,  5 Feb 2025 18:20:10 +0100 (CET)
Received: by mail-ot1-f47.google.com with SMTP id
 46e09a7af769-721d213e2aeso13010a34.3
 for <dev@dpdk.org>; Wed, 05 Feb 2025 09:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1738776009; x=1739380809; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=G07/QgcngEuAZ7ljoOGPkOjUfhiNHugiL+/C5RW6fkw=;
 b=OTu9kbeIYmRl9SbvC/ZmA4YojqVMOqulcaLZnBwoUp2s6iSqxIKF9oZr47anA34Q2q
 omMLsUtjhtcbEwk4H6fzcxSY2v0v0pc7f7F1HnsjS7CKdLGouvf1MpYHHeydCKTwnoj3
 0sPO9rWTsOdu72h6xnLQKEqRcVqlWeKRWumjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738776009; x=1739380809;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G07/QgcngEuAZ7ljoOGPkOjUfhiNHugiL+/C5RW6fkw=;
 b=drVB9ttCoX6/vb4ag6tEKPkqr0sstsqRlOvFAWH9BsfF3ipvrpW4Wxa24JfDBWPg77
 MH3tvlGTF2nXZgXuCBsljK6lKL+AmMorYXzuAyOvANxeBnvNqieK4OPVB9/J2r44OlZc
 C0Jg/sqgX435mNSblrj1P6z9pRrvMlIEshXkeCIL1H3NuBMoBSPILNse1zq1h6BHX8D0
 ReaZtzqNrm7Ux2RcO2AxvDmiml8oItnLgJgP18OdlFOIWEnEg0GZr+brx9CNrYxuOI+y
 RvLKiui8pHBJkscpvqif/g/QGGxbvQV+/kFUPxAmMA5pliu/ZLTItgdVZatWOAN4nNY5
 HxJg==
X-Gm-Message-State: AOJu0YyfdS6krGkkaTg49+c3m5IJiWJq25YmCOVL6NXT5rAMmWMdbo+9
 hLEZOGrEFAZlmN4S6KJ8JFrJKbNwgkWMMDPvETh1B91HM52mT5pQsYUVjPTX5x2Icfekw9bcaDE
 DkLRgCgZBmLu+CtVWOVIMSrxHpfVwHikvzAF00v4p13TeMaCSkXi40bByZsx554vm1JS6ELff8U
 71T/iqt9JVfsf6KQhgPUkzMJqgBI4s
X-Gm-Gg: ASbGncvYRsX4GSC8hvtkHkXBGzJbg6AgzFlVxdro6sUWZNsK1Z6WdxuDObOb7S4SnGz
 xNy7ZTf8N06xvjDLuDHujjXbNGe7ZAE9ieGW363K5v5QamRiIYhzH5wWzBM/TI2cba3gXm6Dqia
 ipGrNacUaVmHaXngcsoTkrIyprmQEW28tKjPSkbpN0BzZgLdfZSAUSFvmWlLEtq/ZfUpVD9G6Bz
 S4YeRzeOJU1JQi+fbO36/TdDW/btF/n8up0io4pSzds5KFWx/Azh/TdQ4GW7ddzNN5YdsiytcGj
 g6vJdI96sOkevu2O5zQCXGjnRcpPId51D+VicFTaWQvKfHM65NXk8JdfAPeWAd4/6FMJ3JzsOSj
 Jv1y2zWV9
X-Google-Smtp-Source: AGHT+IGj1DOJx4+IvtTw3jPpoOigwEEqqMB/huyYlCigP0e4tUPfsRg/RsOOSbQcew3OBgyjRv22+w==
X-Received: by 2002:a05:6830:6999:b0:71e:1392:80b5 with SMTP id
 46e09a7af769-726a428adbdmr2976997a34.24.1738776008796; 
 Wed, 05 Feb 2025 09:20:08 -0800 (PST)
Received: from C02GC2QQMD6T.wifi.broadcom.net ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-726617cde49sm4004016a34.27.2025.02.05.09.20.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2025 09:20:08 -0800 (PST)
From: Ajit Khaparde <ajit.khaparde@broadcom.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net
Subject: [PATCH 00/11] bnxt patch set
Date: Wed,  5 Feb 2025 09:19:53 -0800
Message-Id: <20250205172004.50395-1-ajit.khaparde@broadcom.com>
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

Patchset with bug fixes for bnxt PMD.
Also addresses various Coverity issues reported in the recent
Coverity scan.

Please apply.

Ajit Khaparde (4):
  net/bnxt: disable TruFlow if compressed CQE is set
  net/bnxt: simplify check for CQE mode
  net/bnxt: fix Rx handler
  net/bnxt: fix burst handler initialization

Peter Spreadborough (6):
  net/bnxt: address coverity deadcode issue
  net/bnxt: address coverity checked return issues
  net/bnxt: address coverity overflow issues
  net/bnxt: address coverity integer overflow issues
  net/bnxt: address coverity uninitialized variables issues
  net/bnxt: address coverity control flow issues

Sangtani Parag Satishbhai (1):
  net/bnxt/truFlow: Fix seg fault when rep are re-attached

 drivers/net/bnxt/bnxt.h                       |   4 -
 drivers/net/bnxt/bnxt_ethdev.c                |  31 ++--
 drivers/net/bnxt/bnxt_hwrm.c                  |   2 +-
 drivers/net/bnxt/bnxt_rxr.c                   |  16 +-
 .../hcapi/cfa_v3/bld/p70/cfa_bld_p70_mpc.c    |  90 +++++------
 .../p70/host/cfa_bld_p70_host_mpc_wrapper.c   | 150 +++++++++---------
 drivers/net/bnxt/hcapi/cfa_v3/mm/cfa_mm.c     |   6 +-
 drivers/net/bnxt/tf_core/v3/tfc_em.c          |   1 +
 drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c   |   2 +-
 drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h      |   2 +-
 drivers/net/bnxt/tf_ulp/ulp_mapper.c          |  10 +-
 drivers/net/bnxt/tf_ulp/ulp_rte_parser.c      |   8 +-
 drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c          |   1 +
 13 files changed, 174 insertions(+), 149 deletions(-)

-- 
2.39.5 (Apple Git-154)

