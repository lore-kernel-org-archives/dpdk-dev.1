Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F5CCD5BB1
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 May 2026 18:12:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 19D9D402EF;
	Tue, 26 May 2026 20:12:10 +0200 (CEST)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com
 [209.85.210.179])
 by mails.dpdk.org (Postfix) with ESMTP id E69B2402AC
 for <dev@dpdk.org>; Tue, 26 May 2026 20:12:08 +0200 (CEST)
Received: by mail-pf1-f179.google.com with SMTP id
 d2e1a72fcca58-8383fb7143aso4810795b3a.3
 for <dev@dpdk.org>; Tue, 26 May 2026 11:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779819128; x=1780423928; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Am1Syot8wkOpEtkRZj3PiKjXsSvX5eupGFqjJK58BUk=;
 b=I25iT1HPHvz4ikWpl7Ogx3ifzzkivdDsPxGJlikTv2QVHPYewFRWe93abA0h2Mojw3
 E5f+FCF04XuyXiXshJRxAdB/m/+/wjrY79H5rjRpdb1GjlSRebNgMfE/Bn+Z44Fs7tGd
 +O2h6vGsTfgNXX2teQjgQKJ6QaD+AgBQF5+jjqooi6kxfaTdowaO+/ugvFbxbHEcu7i2
 eyfH7owOas9Je3UV4XYEf09gVtpg2nMpFkX5kTWLOtqy7qB2oCfVc9ZNPmmn/PqP9Irm
 d7b1M6MOCBRlikzk+7ZmdGbgCk48CWnsny9Ano9YvqsckrS6ZCz5S4MgXO83ONA2w51U
 9iKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779819128; x=1780423928;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Am1Syot8wkOpEtkRZj3PiKjXsSvX5eupGFqjJK58BUk=;
 b=DNuuJffrjedQDN9roY/tf71kVixM9IAbku7t4jk82LdH1izMtmXrwzG9SbyDSunCfi
 CfRlf1RfAUZmuR8mwV8VeRkZ6rBzbLzPVmNhZbn8dJPaS2MKb4/oSl+ixmN2CTorGssu
 4NUDkDs9h/yZtcpAoWi9w38wAJm+z5UISISoDj+uekzU2bBOByz0szSPbHMcwx/X2YAy
 tf12R4D/rQXhoQEEtFEp3oC+iF/qvY1dFt6ea0T8WlsGmyZOLEsCyMuteEagMkZp1+Y0
 Yf9rQKSg3V3jwunxGN7IRcY0Egr+yuBkJ4g8+Vav0fAj5RXFLGb8kKjpWIbumLsIL6z5
 WF1A==
X-Gm-Message-State: AOJu0YwjOt6dcVNVhjcN5ulwsn9+PqhtQOiQf2JWtH/407tf+rhsrF0u
 wYAy6hy+AurS23uiVrGAMQ4HrEWs59vrxgJEvFKZ3Q0+XNZKBh3b8gP+
X-Gm-Gg: Acq92OGGdsvrKrce8dZlkZLxyGHe2M04PA3Rxl0WqgPDBZEIvftCeQXp0AKYGgJVGfP
 GTH3RHd6TqktmTy9AEgMMjxA4T1ISmJUr4uQtr/mEGTjjMyNB4IrTAN9k/is/MOdGPADY0/soov
 BQqi1L6iPeVecyF5+W7q0WAJdiwNZQfGTv7dHCY3C0yYZdGn0pMkOoeTp6cWKvIpXZfe4nbDSYY
 gH/mdnTqc2g9TQr6AQU5w2FlvWciZxxiBfR1PTDTFDfEoq/r2dmZdsXN7nyOLuvMu+nLZ2Sfb3M
 RgNPzossCJM37pyNqhOcp+AvLpoof5mcv53LpmwlkDBlFi/5cEg9u/cz/Md5w6ruqBMIWGDvA0x
 AtTqFHiWWMbGOxteRZlb3wKL9mJWz8e0rhb32wvQBDS1VH94SeA7dU/bwuJ4AXNZdfrPCu4VRH+
 tPFJrksi/+we4zM5ZagPUTXpmdhPh5lVU=
X-Received: by 2002:a05:6a00:3e06:b0:82c:6f07:299f with SMTP id
 d2e1a72fcca58-8415f3e81a6mr17515580b3a.14.1779819127703; 
 Tue, 26 May 2026 11:12:07 -0700 (PDT)
Received: from JRT-PC.. ([119.234.49.191]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84164e9e7a5sm16741462b3a.33.2026.05.26.11.12.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 11:12:07 -0700 (PDT)
From: James Raphael Tiovalen <jamestiotio@gmail.com>
To: orika@nvidia.com,
	thomas@monjalon.net,
	andrew.rybchenko@oktetlabs.ru
Cc: dev@dpdk.org, stable@dpdk.org,
 James Raphael Tiovalen <jamestiotio@gmail.com>
Subject: [PATCH 0/2] ethdev: fix out-of-bounds writes in rte_flow_conv()
Date: Wed, 27 May 2026 02:11:57 +0800
Message-ID: <20260526181159.287633-1-jamestiotio@gmail.com>
X-Mailer: git-send-email 2.43.0
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

rte_flow_conv() is documented to truncate output to the caller-supplied
buffer size, but two paths handling variable-length trailing data
ignored that contract and copied the full payload whenever the
destination pointer was non-NULL. A caller passing a buffer just large
enough for the fixed-size header had adjacent memory clobbered:

- GENEVE_OPT: up to option_len * 4 bytes
- FLEX: up to 4 GiB, since src->length is a uint32_t and the API places
  no bounds on it

Patch 1 aligns the GENEVE_OPT guard with the sibling RAW branch, which
already gates its copy on the remaining buffer size.

Patch 2 plumbs the remaining buffer size into the flex-item desc_fn
callback (which previously took no size argument at all) and gates the
inner rte_memcpy() on it.

James Raphael Tiovalen (2):
  ethdev: fix out-of-bounds write in GENEVE option conversion
  ethdev: fix out-of-bounds write in flex item conversion

 lib/ethdev/rte_flow.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

-- 
2.43.0

