Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84FCFCA0EDC
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 Aug 2025 14:07:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B16C4065E;
	Wed, 20 Aug 2025 16:07:02 +0200 (CEST)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com
 [209.85.219.54]) by mails.dpdk.org (Postfix) with ESMTP id E16C94065C
 for <dev@dpdk.org>; Wed, 20 Aug 2025 16:06:59 +0200 (CEST)
Received: by mail-qv1-f54.google.com with SMTP id
 6a1803df08f44-70a88de7d4fso50753536d6.0
 for <dev@dpdk.org>; Wed, 20 Aug 2025 07:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1755698819; x=1756303619; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KMfBcn76fh0IVo25YIUg9Jo13uAWxKr5PQJr3r7frq0=;
 b=QmwgVNdVl75KVNwlOLxAddVLVt56YA7zkD2FMSPYsfVOM1mxrYlAxuLKPqB6Ch5FYR
 Afz6LbP+QaMcqyq9TlGI6aUo7d4+ohBnYMpsYFbg4K4zeDWiu1ssvgAyTU6dn30Dre8J
 9FtVdk86aCjnrGkaNKDAXiLfTkXqXlfqgcHqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755698819; x=1756303619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KMfBcn76fh0IVo25YIUg9Jo13uAWxKr5PQJr3r7frq0=;
 b=IaUVaFT655IEyQftCzP/lPA4JX0//J85q98VQ9Wv/fOWFdBOMjHguQFWpFAXnueJ3t
 8Y75hzcKduJ59/eXVLy5hGpdAi/O0FyhsTk/pegNqvMhYaPyty+UN7tyC8x6cqAf0NK/
 zizpcwvFZnWNgY2MiBRtKyqakAZsGkqFSvVf/nj/PWveDXFzX1kK5UWXnfo7Bxh0DGGd
 Np5Vaw+HFuWnvnnmktpvICkrCxITlngqDhghEpTXy3ARv8oY5ZSqM/8pISF4X/1VT5rh
 5OQKcFCHuwKWGpqDpZmTfoBlLucnea5UTKpDrUF/mWh7665RIb03IK300Iltx6r7hCvg
 0EFg==
X-Gm-Message-State: AOJu0YxRD33eI+m1qYPUw1xj42qOfvwO0pRrN2LLHguvydh4WUvnzdZm
 UQ5YQcMnnBclmslg6cdHA6gcSx3FJUUM/cZwEAm2evF6lvfr+ErIJ3eEQI5JoqIx6c0=
X-Gm-Gg: ASbGncvbV7IfHReehW4nPpHhMTbZgm/MSn6xbvOd62Czhxuj94f9DeJoZgivXiGTtey
 pPuel6oCxlVv3apDnFfQjD9xJL7OdbpKig939LipNDYDHx7eybv0kz6ruXOFHoxHRMBbkZjs/uq
 VY4uMzxdhEmil5n7kZMoGUbCIA5NMyw3R6y9GGcmYCigy+rG2SX49in8YYfurlkKgolFFDYTdel
 bZOzqaZD6qGAuYmd4Q1fPgu9yY21cn1HoyZvcBlQSD49HNGXH/OgWVttCMIcpAYsJicuyAOHNmi
 zI5BPlf1mp/TCOXsmDVs+WCguyN0fItlEoD4aLAGatB2Toxzqnt7WBp8Ath1CZnRBkg8Ktk+XJc
 LR3eu3lImVa1raQ==
X-Google-Smtp-Source: AGHT+IGJw10B18QTlg/tsjZ+wG7/lcZheD6A/GCvhHT3K8gTFh3xqN5Be3uogtsKgKyi3KsYQ/3DLQ==
X-Received: by 2002:a05:6214:20aa:b0:709:76b4:5933 with SMTP id
 6a1803df08f44-70d77147677mr27074486d6.52.1755698817304; 
 Wed, 20 Aug 2025 07:06:57 -0700 (PDT)
Received: from d121016.iol.unh.edu ([2606:4100:3880:1210::202])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-70ba92f924bsm88806816d6.46.2025.08.20.07.06.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Aug 2025 07:06:55 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v3 1/2] dts: make one link the default topology
Date: Wed, 20 Aug 2025 10:06:50 -0400
Message-ID: <20250820140651.39604-2-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820140651.39604-1-dmarx@iol.unh.edu>
References: <20250807140730.292639-1-dmarx@iol.unh.edu>
 <20250820140651.39604-1-dmarx@iol.unh.edu>
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

Currently the default topology for test suites when not specified
is two link, which causes all one link test runs to skip.
This makes writing test suites less flexible for a user
who doesn't add a topology requirement, so changing this
to one link reduces barriers to getting a test suite
running quickly.

Bugzilla ID: 1759

Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
Reviewed-by: Luca Vizzarro <luca.vizzarro@arm.com>
---
 dts/framework/testbed_model/topology.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dts/framework/testbed_model/topology.py b/dts/framework/testbed_model/topology.py
index 899ea0ad3a..9f21520bbb 100644
--- a/dts/framework/testbed_model/topology.py
+++ b/dts/framework/testbed_model/topology.py
@@ -35,7 +35,7 @@ class TopologyType(int, Enum):
     @classmethod
     def default(cls) -> "TopologyType":
         """The default topology required by test cases if not specified otherwise."""
-        return cls.two_links
+        return cls.one_link
 
 
 class PortLink(NamedTuple):
-- 
2.50.1

