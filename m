Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BC6CCD184
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 22:16:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3A0B440A71;
	Fri, 10 Oct 2025 00:15:51 +0200 (CEST)
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com
 [209.85.214.227])
 by mails.dpdk.org (Postfix) with ESMTP id 1ECF740B8C
 for <dev@dpdk.org>; Fri, 10 Oct 2025 00:15:49 +0200 (CEST)
Received: by mail-pl1-f227.google.com with SMTP id
 d9443c01a7336-27eceb38eb1so15910015ad.3
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:15:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760048148; x=1760652948;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7AC4lRdOLtLVMIYfNCDOJAsZu0pn1+BKzrGcc4bgyX4=;
 b=qIkVE3DsnLI5B3AsxNQLBsARAG8JX6vL3VYIeAh26DOnvrjO9/fAxuG9n/Ja2Sc4Dt
 hHjAm6gnGaQ4Zeh7O24C4/qQQJZSckwOMdV86UmnevlnC+BCphP3AYxsLRQAXsorpmtI
 o7fV6qCe1y6Ng3xMjT/rzPs9TtxYW48YrjYhfy3hv9Xco09BSeUb/A3qF6oKA8ZY4/bv
 yXZexDKXR1N6p5kY6aBpNyxPb+mF7ukdDaqNyQKR7/UfD9cyUPer8AJOtjcfxpQZHPfn
 A7zp/IT3qXmBeoJtPbZpURFnhsBHnWLCxqE/wc63/U3L7D3QmFl6PD3UNWWWlDdOIAVY
 3ktw==
X-Gm-Message-State: AOJu0Ywla1l0aq4EhcpQ5mgo6n0CF4VYFAq0euzricxnQvS5gurQF/BR
 tbbIvRA0EFXjtfK76E4UCWdNLsrqWKzEtacpkphEf3p0Oqnj8+d0gaLmbBgF1/pkKO3HiRrdXvI
 EwJOemr8O5GIewGPybgr3zg/9Pums6HA8cYQIFWIAMdFSJXXYaJ+FGLZnzstSVBFAxnI7bN3TGN
 XR6vdOET/PavE4V4BvSB5ey3OmoUaXPfIScBW2YcXyyIiSqBJ2wnbzNtxXh80qpyIhya0dbg==
X-Gm-Gg: ASbGnctYN9sELFbEU6OOMuCA8WaSWHROj0HnMNHZgBYX30NIZCi05kaybksuL/C50KJ
 fbeIDUro8FwRXm5s5MAUi+LQMtwT/V8mH9aUfrTOBKlBT5/gST5CSBZ0scgxcIBwMwXUiWONXRe
 EOkip2ln0TtlNMOIZ+q4rkV9iWZDJODqdcK/iMxpD08Cv6tUFEJCLAqW9faHL3vAg1RHCEXqWIN
 DEyYOCKK5Ug68aMTNXG4/riWddYqEsYNScj9zfR+tiHYqkg68fy9bW3HZWE8VM0V4JWJwwlY8XX
 h30DZ+IeAm27Id+AimxrUAbVGEhkdWL1joliRBQwftlhabW1yOWL7gbDbfO4HVmgNTzkUHmFGje
 4kLh54KYjNl9IalgCoLBi3yVs0nVrdnxn7KlfUEHEoHTvh6JazrgS2h7BQ/vUFjt/gTv8OJ43MT
 W40hjEmSg=
X-Google-Smtp-Source: AGHT+IEyIboOFjJIqmtpVOYAaOQnZlMvznDK91EoHH2WmnoI/37k+Wqq0snKkKO/VUGT/ldEbs5urMH3ZABq
X-Received: by 2002:a17:902:ea02:b0:280:caeb:ed67 with SMTP id
 d9443c01a7336-29027384f4fmr122837615ad.23.1760048148249; 
 Thu, 09 Oct 2025 15:15:48 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-29034df1257sm3163915ad.4.2025.10.09.15.15.47
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 09 Oct 2025 15:15:48 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-79390b83c48so46339856d6.1
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760048146; x=1760652946; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7AC4lRdOLtLVMIYfNCDOJAsZu0pn1+BKzrGcc4bgyX4=;
 b=cm39fd3XBVNZFBBTYTKGvoxvLjf9OsTbo7jD5UYWbHv/MGc3Yv6I/DrYTYKm/UIs46
 Pmi7oTIT74DjQNTetelMORmzdA8/OUJnZoHkILqZ3Dr7LEFOAgWIyvnIh0daDX+lECgA
 EhQXHv7MQ3P297DM7Cpmpj9Sgl7mjZ2hJo2uE=
X-Received: by 2002:ad4:5d48:0:b0:815:f648:bd95 with SMTP id
 6a1803df08f44-87b2106e7efmr110626016d6.29.1760048146489; 
 Thu, 09 Oct 2025 15:15:46 -0700 (PDT)
X-Received: by 2002:ad4:5d48:0:b0:815:f648:bd95 with SMTP id
 6a1803df08f44-87b2106e7efmr110625546d6.29.1760048145939; 
 Thu, 09 Oct 2025 15:15:45 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87bc3479344sm4189986d6.17.2025.10.09.15.15.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 15:15:44 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Sangtani Parag Satishbhai <parag-satishbhai.sangtani@broadcom.com>,
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
 Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH v2 21/54] net/bnxt/tf_ulp: fix seg fault when devargs argument
 missing
Date: Thu,  9 Oct 2025 18:10:56 -0400
Message-Id: <20251009221129.28256-22-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251009221129.28256-1-manish.kurup@broadcom.com>
References: <20250930003604.87108-1-manish.kurup@broadcom.com>
 <20251009221129.28256-1-manish.kurup@broadcom.com>
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

From: Sangtani Parag Satishbhai <parag-satishbhai.sangtani@broadcom.com>

For Thor2 if any of the ports are attached on testpmd without
"mpc=1" argument, code flow will not initialize core mpc
structure which can lead to seg fault in bnxt_mpc_send while
accessing tx queues. Fix it by adding NULL conditional check for
mpc member of bp structure.

Signed-off-by: Sangtani Parag Satishbhai <parag-satishbhai.sangtani@broadcom.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
---
 drivers/net/bnxt/bnxt_mpc.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/bnxt/bnxt_mpc.c b/drivers/net/bnxt/bnxt_mpc.c
index 2582b50782..ff2f0d7043 100644
--- a/drivers/net/bnxt/bnxt_mpc.c
+++ b/drivers/net/bnxt/bnxt_mpc.c
@@ -719,10 +719,20 @@ int bnxt_mpc_send(struct bnxt *bp,
 		  bool batch)
 {
 	int rc;
-	struct bnxt_mpc_txq *mpc_queue = bp->mpc->mpc_txq[in_msg->chnl_id];
+	struct bnxt_mpc_txq *mpc_queue;
 	int retry = BNXT_MPC_RX_RETRY;
 	uint32_t pi = 0;
 
+	/*
+	 * TODO: This condition check is added to avoid
+	 * segmentation fault in case mpc argument is
+	 * missing in dev-args. Fix this by removing
+	 * mpc argument from dev args.
+	 */
+	if (!bp->mpc)
+		return -1;
+	mpc_queue = bp->mpc->mpc_txq[in_msg->chnl_id];
+
 	if (out_msg->cmp_type != CMPL_BASE_TYPE_MID_PATH_SHORT &&
 	    out_msg->cmp_type != CMPL_BASE_TYPE_MID_PATH_LONG)
 		return -1;
-- 
2.39.5 (Apple Git-154)

