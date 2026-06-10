Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49053CD98CC
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Jun 2026 18:47:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 47A60427A2;
	Wed, 10 Jun 2026 20:47:07 +0200 (CEST)
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172]) by mails.dpdk.org (Postfix) with ESMTP id 7E0BE402A7
 for <dev@dpdk.org>; Wed, 10 Jun 2026 20:47:05 +0200 (CEST)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-304f0039c02so12838135eec.1
 for <dev@dpdk.org>; Wed, 10 Jun 2026 11:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781117224;
 x=1781722024; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oGLoIcgxRpRIXcuzStyv5d3P/Rwez8yVLObWOe817/0=;
 b=a8zRDpbYNU7ndKUSHvaubYsCleM8HuXn4TXnG7+DDUre609Q2n+1/DjZYziWueFIGc
 5etltv6UjMB1GVsAMzth1DVCmT6Lti3v1ps9/cSL1jMjptpa8XQ4nzjX2MErJ42htvGj
 JId2o+KdbiuZnclQlbHtlgTI4t0No9jAV7Zl1q9WjapQKMCiXDWvH/k+ORu+JoSWnass
 Hj+AKBnTp06EjAYuDIP0mW4N8EZgqA+1pQswzUXZ1ZMGgLCcz8BI4bI6hIxbh6Fjvu0d
 wLt5XkLoOzBcOf/f3/+5QbmVocDmDIQrAT2afv3dOnuXlXxu5KzZq9gLVsL+d4TR1J/c
 sLrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781117224; x=1781722024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oGLoIcgxRpRIXcuzStyv5d3P/Rwez8yVLObWOe817/0=;
 b=gOtfUBX+7sl5U5whHCrkbNSgjA4zHbmSYFFjXaBKjhfELaWdOYWFe4/PlXj2ownYMI
 PoiEtkgA7Ixa2lruqKTQiOm6jWu4UKOIDkSjIYOvxe5uQuSjIiQdPBZ2W1RXTHh45smu
 Uv/tY0grJOUHxEpqMyGQ/CRM8PLlsNMR4F8Z4lbVyUw6CmpZoIJAh1YmmMqmpgdqnyQY
 cQ40TsYDBDHHA+rdIhjCyzF/iizcNn6dLbamRwKGL/nRcEFsxZdPIZNVppt1LFtmIbMl
 r1Ty2OVEyU/am6kmDPbTyL6VG9yBZLZDFyVXq+5OGeHaqjP1KrPABwF2ofvmSK73j0H8
 D28Q==
X-Gm-Message-State: AOJu0YybIWbJQu5kG3ravin2cBNTL0EzdfK7ZetUkgVJCPfahLUf9UF3
 AjkycVUInmebZG7JP9uqEYxzUP9hZbjSgtiLAx2nf9irFPn9LEp/3WeVo5rOG40XbqPcF8uaZLa
 x55li
X-Gm-Gg: Acq92OH2+lwHQtrWi7cx5+m57j10ME1ROxMsjD/QJY0bEdaqNkI+zpBncEOR7KG+UXC
 v1yHRyvUikwYKeStJTTzaZyjLsIcB82pF/W+QarMtBCxNSxSRLAvouhASW7Su9sj70Nuy5xlWzo
 fVPQervL9k5WjRO5REPLG/1bpmnGNmMNxyrZfHO2JMOGkk9L2zDaDBLebVmyeEXPT8c0eMgHlp/
 s3FGP7lnMnjfFUiOrENGq3hK/vPPQQdhuf+IRIE/7EumdQavGzu2Xsc3Tm1uKONu5A1wzwOzD1R
 uLS0ycNPqiiuy1DCj8jiVLebHtPGJfqRiLnxX2DVPNlwY60DQjFfPgpMRj7IrKCE/psGGPGYM1Z
 4rJyiYYZYt8R2JcfRybBbHecyweHYZmEZesh0K6h18lc661IFr91SWrrBFYvL/t/TJ5m565m2Bf
 J9A/IF4dIwljh/mbIqkZ3b6RwQEFzsrjOt/LOFV9Zr+DF9Fhd67E/wXwpkJRSk+wCnPF4ntBTw
X-Received: by 2002:a05:7300:3b28:b0:304:d4c0:82ea with SMTP id
 5a478bee46e88-307d62db608mr6767469eec.21.1781117224230; 
 Wed, 10 Jun 2026 11:47:04 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074db560d7sm37799844eec.5.2026.06.10.11.47.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 11:47:03 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 0/2] ring: replace use of rte_atomic
Date: Wed, 10 Jun 2026 11:43:06 -0700
Message-ID: <20260610184701.657769-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260602171552.686349-1-stephen@networkplumber.org>
References: <20260602171552.686349-1-stephen@networkplumber.org>
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

This is part of the broader rte_atomic32 deprecation work, sent
separately because it is the most complex part and benefits from
independent review.

Convert lib/ring off rte_atomic32 and onto the C11 memory model,
except for the ring head compare-and-swap where special case
is needed. On x86 with GCC using C11 atomics produces measurably
worse code.

After this series only __rte_ring_headtail_move_head has separate
C11 and GCC-builtin implementations; everything else uses the same
code on all architectures. The default RTE_USE_C11_MEM_MODEL
selection per architecture is unchanged.

v3:
  - rebase and squash patches
  - keep original code for x86 single thread case

Stephen Hemminger (2):
  ring: split single thread vs multi-thread cases
  ring: replace rte_atomic32 with __sync builtin

 lib/ring/meson.build             |   2 +-
 lib/ring/rte_ring_c11_pvt.h      | 107 +++++++++++++--------
 lib/ring/rte_ring_elem_pvt.h     |  53 ++++++++---
 lib/ring/rte_ring_gcc_pvt.h      | 155 +++++++++++++++++++++++++++++++
 lib/ring/rte_ring_generic_pvt.h  | 119 ------------------------
 lib/ring/rte_ring_hts_elem_pvt.h |   8 +-
 lib/ring/soring.c                |  34 ++++---
 7 files changed, 289 insertions(+), 189 deletions(-)
 create mode 100644 lib/ring/rte_ring_gcc_pvt.h
 delete mode 100644 lib/ring/rte_ring_generic_pvt.h

-- 
2.53.0

