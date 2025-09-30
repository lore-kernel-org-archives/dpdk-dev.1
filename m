Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B82CCAC5B8
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 07:08:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8EA4C40E24;
	Tue, 30 Sep 2025 09:05:51 +0200 (CEST)
Received: from mail-qv1-f99.google.com (mail-qv1-f99.google.com
 [209.85.219.99]) by mails.dpdk.org (Postfix) with ESMTP id 91A01402A2
 for <dev@dpdk.org>; Tue, 30 Sep 2025 02:37:02 +0200 (CEST)
Received: by mail-qv1-f99.google.com with SMTP id
 6a1803df08f44-78ea15d3489so43644736d6.3
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:37:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759192622; x=1759797422;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7AC4lRdOLtLVMIYfNCDOJAsZu0pn1+BKzrGcc4bgyX4=;
 b=mVR0w3ZOY7dZ88iBmlY1hBghyv1oSmJWKv/0NKlUwGoVDdNM7zH8H5kh03XIVYxN8h
 YZPzWjQsr3CnVX/cUSmR5KTiJFPx2rLppCq+jmZ+zasQ9VmDZIB9i6vwS4YBED9AfltO
 xilkv5KpyBrK4fBjiSXSNMTTcoU1dDlXIgWvf10hiQHgEaCavov6+88vEyAb9PAT5xu9
 VZ4JmLPoxCzdtnZemm5cDvhRV/LB94uFjVTbmu8/UAyyaFLPhsPVPG9vKzQ94pmBAFiA
 hRTHD8hRxT8f2Fyt7PbAa3Hs0JRPCUj8MPr2hQTbbSLbRYF/Ms8SXmKK/BNzlg9S09S2
 j16Q==
X-Gm-Message-State: AOJu0YwDMgL+4zsd9SJL+PIbEl7E9r+moJW6oJk6b8WQT151RMpgssAV
 oQ3qzo2qPaFHusPK2jVGwAf+xzcZUelrQRLb8OulEicHJPDKKWQaOSViIkhaBN9nHxPx2CWHUeJ
 rdJbZYyMOIn3Xdw3fWbLovPw68RKkw6nEdF8VLnDORZfSr6pk49Bk4RbZ5U6HBkh0Beosy6MKSN
 I8/SrGO7LZmHgbNX/slwCUYVWjWKT/jjrnHEX61PBpgNH7tXzU5IgeidyMbNLv5TMQ6FoHPA==
X-Gm-Gg: ASbGnctN3plcTxTzp76tjUd1WRtd+6wJi3JgNf7kFm3YiFotEoKVyfMNB/0rHQg4KPt
 R/3eoBYC0jBeMMRx6wF2vBJfspGC2JzVksuWFEJWyVm/wqhMs5Lh0FyRqGN1Zf/P/c7Lk7up39Q
 k0XijapD7Pa5qPddhb0pwWsLCiaknnWMPnncIbv+mLEVzfTK0Ylhqzfpv6He1sNDrZFgF4HekCE
 XzxILxM/wcBbr/jCHAlPxW7KElUyzYGGea3yzIz4enXGASDJTQ+Joz5czWviiZWIEUy5DNBAZIF
 hsS5EOrehdeJmZji1KotwR/bwXeYOW3xvKPMtiECbn6D/8Uau7sQ/IeAROobE9xBGh1eIBEP2Jk
 wEXe5aWd7V8k/HoIggqd0bFFKwmVMaMD5UhEeRuNZVkvLA6H0i2Psp4JTGxtiZlRxDiwHx8D35q
 ukPQ==
X-Google-Smtp-Source: AGHT+IGsEK8+x8sseZx4KTz3IQCC2AumzHs06VZL106QgMeYduNXxOBdKUWAeiZi5rHw1d0G1LnqR3WfSMKp
X-Received: by 2002:a05:6214:1244:b0:80f:e547:f038 with SMTP id
 6a1803df08f44-80fe5482469mr199284126d6.10.1759192621726; 
 Mon, 29 Sep 2025 17:37:01 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-116.dlp.protect.broadcom.com. [144.49.247.116])
 by smtp-relay.gmail.com with ESMTPS id
 6a1803df08f44-8016193c3afsm9219396d6.22.2025.09.29.17.37.01
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Sep 2025 17:37:01 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-b522037281bso3373507a12.3
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1759192620; x=1759797420; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7AC4lRdOLtLVMIYfNCDOJAsZu0pn1+BKzrGcc4bgyX4=;
 b=f5lJR52KjzwiaYd3TBcVDkZPM38iYMtHtd6LEIkz9MoG8K3/Tecn4l07j6FKidqAhn
 NCEcfzT4PYMjIuRIc20MbYwn7OqaX/VMQZzzfmvAexFSPL/4nBdLM4Hs+o9FFgO2Xou+
 brSYJuig6iKotpD82Pvx5XIBmCFgTVr8k/t9c=
X-Received: by 2002:a05:6300:4ca:20b0:2fc:d558:78a9 with SMTP id
 adf61e73a8af0-2fcd5587a41mr11167016637.28.1759192620243; 
 Mon, 29 Sep 2025 17:37:00 -0700 (PDT)
X-Received: by 2002:a05:6300:4ca:20b0:2fc:d558:78a9 with SMTP id
 adf61e73a8af0-2fcd5587a41mr11166990637.28.1759192619704; 
 Mon, 29 Sep 2025 17:36:59 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b57c53bb97dsm12234825a12.9.2025.09.29.17.36.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 17:36:59 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Sangtani Parag Satishbhai <parag-satishbhai.sangtani@broadcom.com>,
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
 Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH 21/54] net/bnxt/tf_ulp: fix seg fault when devargs argument
 missing
Date: Mon, 29 Sep 2025 20:35:31 -0400
Message-Id: <20250930003604.87108-22-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250930003604.87108-1-manish.kurup@broadcom.com>
References: <20250930003604.87108-1-manish.kurup@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Mailman-Approved-At: Tue, 30 Sep 2025 09:05:07 +0200
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

