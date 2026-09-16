Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38BF9C88E77
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Sep 2026 13:11:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 85D874279F;
	Wed, 16 Sep 2026 15:11:40 +0200 (CEST)
Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com
 [74.125.228.43]) by mails.dpdk.org (Postfix) with ESMTP id 5039740E12
 for <dev@dpdk.org>; Wed, 16 Sep 2026 15:11:39 +0200 (CEST)
Received: by mail-pz2-f43.google.com with SMTP id
 d2e1a72fcca58-85a4329731cso647975b3a.3
 for <dev@dpdk.org>; Wed, 16 Sep 2026 06:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789564298; x=1790169098; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FTnpKmARd6PtCO3QgeL4X2yrg7hXG0gQKA/jd3CoxG0=;
 b=nSd7RWqrJV18w5DoPHFz6x+J9WbjdlPhuwttrExJnxWSoxmtKoaFrqTTOnY/YQcKUm
 bey0FTBRqUUpGKy5lq/pOTrmfr1rLMas4uDY7+PoEIfEjTn5ZkaYc3sOaoRn3r6yhGaW
 4l7vj/WLSpObhy7GHj64z8IsY7grZd+9ZCARV/y9ydX36DwKQzo5vFpw4mcX53UaPF3U
 csBWugxRq+lO/hy9QHlvjhhGZxrhFYeYkj/hPmupIpFGywRPtmALVqSPRhnJwE5CnFZx
 QZdFoEtauHcc8P/OE1ZeIlwAOlzJDjx5xuSHeOtcFWAW+7oRkXZbNdcf3Pgn2phx3N4u
 n+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789564298; x=1790169098;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=FTnpKmARd6PtCO3QgeL4X2yrg7hXG0gQKA/jd3CoxG0=;
 b=weplHWE0ZAeWKUplcFpt2YuB3cyQppJEi85qKpGV3aNgMplsfChWMbpopanpDqQI2M
 aDLZYoy3UsKufjy6kJArzuErQWE24+FdJj3Rhx9IMrGJzUnDlOXy8vsx6nGTHXe84W7c
 zhEB3yJhet0NwSNYX/kJRp+sPz1+kMSBkrDXGC2FDAfCXpLxU2L5sTgsoWEcIjj7wIgt
 LXCOKo8AbZO/UarlmOJesDT3nU+nBR/BzHToqdJVuyFHz7xqB9T3NnYkmLTQjemXRuvd
 SlMdZkTtWWBm2E+RpfRFsEDrinvz0M2tPliSoMSxHVqNs9wDPf4nJE427TNSYo/wBsD/
 OuIA==
X-Gm-Message-State: AFuF++lJPppafuMHzho3T9eRO0nawWdF/Mp3VouvX91TTnk6VKF3qI/F
 x0gDdcaDKQK3osNMw41W3zY5xZYqygBCX3zmfd5u73bxk8HT+E6Iz54wiaBlI7j2
X-Gm-Gg: AYBFou0TMBxRpVPv09vyn0mxYXEeo63wihet4qiLHHgh6MAEMJptmOZV8xz70LY1nZ5
 aAWIbq6uDpwaUMOSUU+zUPSQqoYWinvxANv0IENwhMhUpxwgOjxD8ySj5nivVJSY5tQPXktZIsI
 d1Ig6TR7qMqGWAw939zy5wfF1N/g8BTlEhdSzAbl0e/ppTtKHiADkZKiqCbd8M4HK0S1SxFewJ6
 fG6ZHMiYpnU6S6pDFE5DIsbEXzJJhaQH3K746NGRnqYCVdfto3cFuOBl19wTv13hRaJ3NnYzlbM
 /GdNUYOJGxFH4El+iUBmcWqd0qH1ZPG69NXqsz5vaH4V453zX2VejwUJMPKGPhXRpWDgaHq6D2r
 SWe15prYWxyFgIX4y9W8b6q5enzf6UrwD6LmDMa1OvW+N8vtbJzLrgKhaE/T+0Quiu+wrPheK/t
 LWI2cEmO2x8PY2bcSBcIVw4OhY1RlgXUHReofB+UrO9R+KgZ4latARc3EnHsmNL4+JfDxdi/hl8
 9gZl7jRF5nEvI9j2g==
X-Received: by 2002:a05:6a00:1a8c:b0:857:7317:cff5 with SMTP id
 d2e1a72fcca58-8723a4942bemr4757958b3a.22.1789564298081; 
 Wed, 16 Sep 2026 06:11:38 -0700 (PDT)
Received: from OptiPlex (mail.forbuysw.info. [66.175.223.235])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-872025dd04csm1224882b3a.60.2026.09.16.06.11.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:11:37 -0700 (PDT)
From: Zhang Tengfei <zhtfdev@gmail.com>
To: 
Cc: dev@dpdk.org, stephen@networkplumber.org, Zhang Tengfei <zhtfdev@gmail.com>
Subject: [PATCH v2 0/3] net/txgbe: fix flow create errors
Date: Wed, 16 Sep 2026 21:11:02 +0800
Message-ID: <20260916131106.105667-1-zhtfdev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915152436.67378-1-zhtfdev@gmail.com>
References: <20260915152436.67378-1-zhtfdev@gmail.com>
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

v2:
- split L2 tunnel add-failure goto out into its own patch
- allocate FDIR object before installing the global mask
- add Fixes tag for the VF FDIR path
- set -EINVAL on remaining FDIR goto out paths with bad ret
- use struct assignment instead of rte_memcpy for filter copies

1/3 fix L2 tunnel error on flow create
2/3 fix leak of filters on flow create
3/3 fix flow create error codes

Zhang Tengfei (3):
  net/txgbe: fix L2 tunnel error on flow create
  net/txgbe: fix leak of filters on flow create
  net/txgbe: fix flow create error codes

 drivers/net/txgbe/txgbe_flow.c | 240 +++++++++++++++++----------------
 1 file changed, 126 insertions(+), 114 deletions(-)

-- 
2.53.0

