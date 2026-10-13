Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989A3CC6B0E
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 17:16:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 777FA40430;
	Tue, 13 Oct 2026 19:16:15 +0200 (CEST)
Received: from mail-qk1-f228.google.com (mail-qk1-f228.google.com
 [209.85.222.228])
 by mails.dpdk.org (Postfix) with ESMTP id DB0B140A70
 for <dev@dpdk.org>; Tue, 13 Oct 2026 19:16:13 +0200 (CEST)
Received: by mail-qk1-f228.google.com with SMTP id
 af79cd13be357-93cc1ab5f6cso387215185a.0
 for <dev@dpdk.org>; Tue, 13 Oct 2026 10:16:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791911773; x=1792516573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AvI3L4MqYuqhIyCbcjDEp6I4yJfshk89vLx0tZkhlrE=;
 b=YWRh9JHEPaDcYalVLW6isR+IwXozaM0Ts1yVy7O65Gw9VZPh/7HVDjA+4o48KNOQp1
 tRDIq+YkpZOuoYKNdHKGa9GgONUgepbabNWuYGzeRMuZCfxqAXe/LYGh4lwhh8b480Hy
 47caGHwWGmDS3mAT8CCMmmGLRMj5pQ6l93yrPfpy/QfJSLCrOANaTbhAbrS3ZCB4kT4t
 KiZrOGOInl0IJ6Aj3o3S60pOpgzre0oCpLgtUmALF6NENgbx8pwwISgg2gNSzEN0NFJm
 1au535xEEZSihIn7Ga5dMNuVvzpGpDClE+Hx0gdej4brAXYywXFAOApnCzignKhLpWnS
 23Eg==
X-Gm-Message-State: AFq9FYJxJeA6C16lBiVNu/A7lrHPodTUxvn2eiY2VhFdYb8y6kWoi8/9
 qbrKDDG5xzEg9y0oouC5AMkAjyXLVyL9VJAkq53wv0BngLIkSTcNF8bWedSTGu5YtrlRJW+Af19
 7esibIJqnLKhutL9WUvOCuVoJ2UnlFBKGUL1AQK2mB1wxzOjKntT3/1UNsSF+rHwBtqQtEJKj2d
 BPBfFn92DP8zukwwQ3tr5jf+2ytgSiFKZ0+9T/w/i1mo2NTorqgbBG0NhxqtTGFwMmVLvqjG1tX
 34U3HxzY9Lz
X-Gm-Gg: AYBFou3F+h4r60Lp3y+dpoh4ktxYzorHTrOim7LB+8mletMd1NffV05D4awvfZPtlfJ
 NCO9poDLOP+qOEozkEMgMinbUoDAkCYg1WdJ0zg4v1dZv7bv1/ZJ+oSSNQvLxOg2Etcw16Kd6df
 PT6MPeuUiOfb/HJSlLqh9SGrOjOpsawUA6xYxtPgto7I5aOjgQy/LpkggmHO7MxLUZ2mZbJcpMv
 mFRAo8rh76SHwyBJtuBHPDk0HYIMwplvDWBrEdtE4dyvqI+q1jqnKVEmrzFnrI6TBeve21B1BW7
 ygU970CSBqLj3bRs8jDF4aAjBexlBV9IyLanWEyJx1JsW3I2VAfECiitj4ccCRCh34utTgCdoy5
 Jv6fIb1HEKpSYmi4D3PO3PiCDV3Kz1yRn38aZS48gp8Ikjr28kMUA+WrcDe1I5JKUnZkbxqoHQU
 Gvbdhgj8sMPIZbliE/+zh/CcWI1zWcbpw16lsM0XyoDJBETi4hC1Zi
X-Received: by 2002:a05:620a:890c:b0:93e:c12c:fbbf with SMTP id
 af79cd13be357-93ec12d0fcemr1970968585a.76.1791911772963; 
 Tue, 13 Oct 2026 10:16:12 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
 by smtp-relay.gmail.com with ESMTPS id
 af79cd13be357-93ef5076d3dsm73683485a.12.2026.10.13.10.16.12
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 13 Oct 2026 10:16:12 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93ea8067974so804173885a.1
 for <dev@dpdk.org>; Tue, 13 Oct 2026 10:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1791911772; x=1792516572; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AvI3L4MqYuqhIyCbcjDEp6I4yJfshk89vLx0tZkhlrE=;
 b=JQ3Mzua3LHVL4mkdIFpjqcxolMs0KA45UYkFtRh4Am92hZrzt8lCo8mYGJhkqVExy+
 KJaX8a8jOyDkhJKMlgZu2ve59blRXGrCTtqI/D/A4QlN8LBMaM2gx/sNHxKtCpskbUJO
 3TyB5d97o0uJ3qGEvSYxpyUgnQ1YH1Kar8m2Q=
X-Received: by 2002:a05:620a:1d0b:b0:93e:646c:9133 with SMTP id
 af79cd13be357-93ebd4a1302mr2147615985a.64.1791911772317; 
 Tue, 13 Oct 2026 10:16:12 -0700 (PDT)
X-Received: by 2002:a05:620a:1d0b:b0:93e:646c:9133 with SMTP id
 af79cd13be357-93ebd4a1302mr2147610385a.64.1791911771631; 
 Tue, 13 Oct 2026 10:16:11 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93ef5028051sm283063785a.18.2026.10.13.10.16.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 10:16:11 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, manish.kurup@broadcom.com,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH v2 0/2] net/bnxt: fix two ULP parser/mapper safety issues
Date: Tue, 13 Oct 2026 11:19:53 -0600
Message-ID: <20261013171955.452416-1-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261005151727.1706155-1-manish.kurup@broadcom.com>
References: <20261005151727.1706155-1-manish.kurup@broadcom.com>
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

From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>

Two independent hardening changes in the ULP parser and mapper, found by
static analysis.

v2:
 - 1/2: reworded as hardening: all current callers pass sizeof() of a
   protocol field, so there is no known overflow; drop Fixes and Cc:
   stable. No code change.
 - 2/2: swap the blocks in place instead of allocating a temporary
   buffer, so there is no per-flow heap allocation and no -ENOMEM path;
   retitled accordingly; drop Fixes and Cc: stable.

Dakota Sicher (2):
  net/bnxt: cap memcpy at field size
  net/bnxt: remove VLA from EM key block swap

 drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c | 18 ++++++++++--------
 drivers/net/bnxt/tf_ulp/ulp_rte_parser.c | 10 ++++++++++
 2 files changed, 20 insertions(+), 8 deletions(-)

-- 
2.47.3

