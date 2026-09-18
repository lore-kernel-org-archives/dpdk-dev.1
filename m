Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E37C88E75
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Sep 2026 03:24:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7B6E74326A;
	Fri, 18 Sep 2026 05:24:35 +0200 (CEST)
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com
 [209.85.214.225])
 by mails.dpdk.org (Postfix) with ESMTP id BA6FB4324F
 for <dev@dpdk.org>; Fri, 18 Sep 2026 05:24:32 +0200 (CEST)
Received: by mail-pl1-f225.google.com with SMTP id
 d9443c01a7336-2caced6038eso2274935ad.0
 for <dev@dpdk.org>; Thu, 17 Sep 2026 20:24:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789701872; x=1790306672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QfuUjwXqjGahh9Y3+PZzdBbVT5tqHLnlout01lZ2fio=;
 b=uRQuGV2nLVVXZ2ZCztivQ+uRqqxIEfgmMunU/Ay5eoifCnXdCGOXqxC8XLSvzfghzm
 EGD9s0MxkfNPWtV1BjaVt4dxfNjWuKmQmBr3655l+zzfoJ0jONnWPW9V4HF65nigS9AU
 OZep2wP8GdvW/rgUVCiacaAcx15+GC5DJu0aggkLLuzhOdEAi4dxBo5IbyzNtRU+G3Nj
 t+udAk2iF2Vo6O5QvZyQRIgl8qAou7Q0Bt1KZ8sJMjIziccWFVeSeca67y89AkQHH3Bc
 1QxZsBRg7jItYqxImM+Wh3IaG0AO3us4nxu474c9nFF7VAg/Yr9ihM7LwU5yR91cFDat
 EQBg==
X-Gm-Message-State: AFuF++lwY1JjBFrR3oW1gps3nAFKCD+9i99rwlJb/jP3HJITpfOkCg2r
 W/1Ida/sv7/jASWn1kM06jrSAtKWh4EZcU+kq2IxVlafZYsY6AQmBomspNLiHZjB+jc1DUMga93
 h6OYhj3VqY86iLnUXxAM8txJ7nMC2BfdYzcPHztKy7mO1KlKoxOR733TBMbo70x9mGJgx890evm
 A206TpJmdg6yq3hT9OrB1RlMdZkZ5Q1noxG3JNr5I/vUtFzBJQberdHvXoSdctV3ioZufc6NyNf
 qdXKmQXQ6L4
X-Gm-Gg: AYBFou2MbxcJiI7I6LuRLvK623DjkIoSD7eTu8skmK0pJFMRcGoeIVKo/lBSlAP9en8
 DZ/SxbAspNLQpyK8Ki0t0hBRmwbPnMxtB7dSS/dw/J3Nj7xRQuiTB6JcgRcUYXSyI4OdB5A688o
 XtvV5sijJa51+pLSNKGbv2A+CeBfGsuSV5JVzDeGP+9yOoDV5sAD5EfojTCHrej6k927w5NV+VR
 8gGxwaaGFgdVKdfmyE/PFBkaXicos+o6lvixeWUxxHR/QTs1EZ34jINmG3yH55OWCtXBj97Zmx6
 SD53RSprdYe0PmG0MACahOajIHluGzE/SmcOvzyP1WCMuHWmyoe+w3yh2E3RILqUyID7zDpppJw
 akJ+ecKSxiRvddXNqOISYTSpK3EIST+ewr1jpoIUkln1lZJIe1QC61XJDUC6+bOoTLIyCdPzW87
 6s7uhT33sqJF7y1QpCgPb9EcRo7gtgppz+dIkv3wLvHN5W6Doj4g==
X-Received: by 2002:a17:902:ebc9:b0:2d8:d4d2:d138 with SMTP id
 d9443c01a7336-2dd9ca272c6mr68247535ad.20.1789701871702; 
 Thu, 17 Sep 2026 20:24:31 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-98.dlp.protect.broadcom.com. [144.49.247.98])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-2ddb7539fb1sm113235ad.16.2026.09.17.20.24.31
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 17 Sep 2026 20:24:31 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cbedbd182f5so269674a12.1
 for <dev@dpdk.org>; Thu, 17 Sep 2026 20:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1789701870; x=1790306670; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QfuUjwXqjGahh9Y3+PZzdBbVT5tqHLnlout01lZ2fio=;
 b=W00Su0t2ZEt+gp9NBHVNsipbNj2RlvZDjpVPi9z1zD9GDzevQKHKZrJlRtr1JFYODT
 sAO5kl8kBK7SdcM1ekJRzum1Qfch4DmzABkbCUJTE+gYQQf8F64RL3PplXz/cNtyNBxO
 cHRjRYwLsK2o3mQAxC7jP2hNqeDjxnkPuJeJ4=
X-Received: by 2002:a17:90b:57e6:b0:39e:58d8:f899 with SMTP id
 98e67ed59e1d1-39e58d8fa69mr1110738a91.35.1789701869932; 
 Thu, 17 Sep 2026 20:24:29 -0700 (PDT)
X-Received: by 2002:a17:90b:57e6:b0:39e:58d8:f899 with SMTP id
 98e67ed59e1d1-39e58d8fa69mr1110696a91.35.1789701869286; 
 Thu, 17 Sep 2026 20:24:29 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c287b023bsm597708eec.23.2026.09.17.20.24.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 20:24:28 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, Joseph Wong <joseph.wong@broadcom.com>,
 stable@dpdk.org,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH 5/5] net/bnxt: fix VF info alloc error path memory leak
Date: Thu, 17 Sep 2026 21:27:26 -0600
Message-ID: <20260918032726.763384-6-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260918032726.763384-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260918032726.763384-1-Mohammad-Shuab.Siddique@broadcom.com>
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

From: Joseph Wong <joseph.wong@broadcom.com>

In bnxt_alloc_vf_info(), vf_info pointer needs to be assigned prior to
the nested allocation operations. If an error occurs during the nested
allocations, the cleanup function bnxt_free_vf_info() needs the vf_info
pointer to correctly free the resources.

Fixes: 01406837bf4 ("net/bnxt: fix VF info allocation")
Cc: stable@dpdk.org

Signed-off-by: Joseph Wong <joseph.wong@broadcom.com>
Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
 drivers/net/bnxt/bnxt_hwrm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_hwrm.c b/drivers/net/bnxt/bnxt_hwrm.c
index dee35758e1..52c75c64de 100644
--- a/drivers/net/bnxt/bnxt_hwrm.c
+++ b/drivers/net/bnxt/bnxt_hwrm.c
@@ -1079,6 +1079,7 @@ static int bnxt_alloc_vf_info(struct bnxt *bp, uint16_t max_vfs)
 	}
 
 	bp->pf->max_vfs = max_vfs;
+	bp->pf->vf_info = vf_info;
 	for (i = 0; i < max_vfs; i++) {
 		vf_info[i].fid = bp->pf->first_vf_id + i;
 		vf_info[i].vlan_table = rte_zmalloc("VF VLAN table",
@@ -1100,8 +1101,6 @@ static int bnxt_alloc_vf_info(struct bnxt *bp, uint16_t max_vfs)
 		STAILQ_INIT(&vf_info[i].filter);
 	}
 
-	bp->pf->vf_info = vf_info;
-
 	return 0;
 err:
 	bnxt_free_vf_info(bp);
-- 
2.47.3

