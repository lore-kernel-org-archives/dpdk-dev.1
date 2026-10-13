Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F06CC6B0E
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 17:16:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2B50E40656;
	Tue, 13 Oct 2026 19:16:02 +0200 (CEST)
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com
 [209.85.216.100])
 by mails.dpdk.org (Postfix) with ESMTP id 3ACCD40612
 for <dev@dpdk.org>; Tue, 13 Oct 2026 19:16:01 +0200 (CEST)
Received: by mail-pj1-f100.google.com with SMTP id
 98e67ed59e1d1-3a4cdc9025bso1649412a91.0
 for <dev@dpdk.org>; Tue, 13 Oct 2026 10:16:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791911760; x=1792516560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=u68UtOdo3v7oaYHUDscY9TbQhKcBI9ZW/ri9tbss2+A=;
 b=bF4KN7DqSzH8kvTgqoMeCvbEWdxhhfYWFIopXxlSVrKnp1wQnkRVlQkM2CY+hEfN72
 Ti/NjA59/8AyEmogqhosvxLvEScAuZg77ITTbVv35NkdhFjUiK7Exx4eqRe5qpeOBAgn
 8L6k3hBla3WK+8Mucwclfnlx+4FcmRpeDnPCJKoIx1/RL5CdxLiY5OjjT9KZoyTCdSJe
 8vIfgixM3ZmtkWXU/SoW8734udRBXNNmkQ2XLQhK1tLuDkstT29VEolksacvT4Z7ok2Y
 olnf1TJPrI9vv9VaFWMHlYiOcScXRFGz988S/PUgAQyGKeX7OqFXXAo44L3mM+08HsqR
 VZLg==
X-Gm-Message-State: AFq9FYLwFwA4v2f5k6ZI2GQkS/TuOShZqYUBKK2fvxLcm+hXXMDZaVzW
 0z+7QcSUebYtMQhvqJchM1g/KlrKig09udl+5zjTSZvOUTiBgNMJqgfrRz+6tTIuS7JSYaevkF4
 Q8r9GCrPreHZfzcw3MgZhSnwl64sM4wu94YvBHMs7KjbeeAqJfRK8y2v0j0bjiV4XzdjQ/+vcx+
 ua4qfPm/S4itcRgJgR+PB4TZ/Ezw4BALFhp6Tunf1Jq4fBdxV79qmpL7kn/Diivy/L9VHsCmw35
 /hPyIva/3i9
X-Gm-Gg: AYBFou2ajJ/2nbZGFvDadIC1/GkuU0g+KeS7Vw20q8CSNSxKl2aFye4F9jE/zDlTf6q
 +QeP+LqxtvzdbtoPXIByHmPRYT03LE9lo/yDNes8D3I7xwDxLMaPjF55lM9Q1zGuR+RPINPuM+A
 osLd4JKpWaTxj6iAdEdqD/jjfD1ZBenEjEdUbXA+8fFpSHVeomLJ5ei+buiG5T2+SJbVOgI8vAA
 JxZgf3G9l9KLJBtUwuWqLhjBIa1xYiGx/iWfnJSmItf7slekFBkeCX9Rild3EwafGOIZr40cGtq
 2r2/dXR3KRHC+t9mmq+RGzPiJIvlQyYKHc4lbYcbEAxf5d1jqevhku/DkVXuaIyA1BKKxTvao8V
 0P24061COSf58a9XOzKjW1kTAhxbkVRBmDfpB8buDPa4P3ZCXYUshsgIBF0sClfRJARsg7HMYx+
 cl3WQa4cUSbJ+DfXA5bEDpMKwaS7/vR/uheUyi+veezZD8DcmUPrJA
X-Received: by 2002:a17:90b:590d:b0:3ab:1e1c:8381 with SMTP id
 98e67ed59e1d1-3ab3aaf4709mr9248410a91.45.1791911760122; 
 Tue, 13 Oct 2026 10:16:00 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3ac60395c4fsm103135a91.6.2026.10.13.10.15.59
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 13 Oct 2026 10:16:00 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-534f3fe0236so68614101cf.2
 for <dev@dpdk.org>; Tue, 13 Oct 2026 10:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1791911759; x=1792516559; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=u68UtOdo3v7oaYHUDscY9TbQhKcBI9ZW/ri9tbss2+A=;
 b=YQK9cButjOJrtdNNQcIVGeKfVlVJHO4pUx0rJWktvpSVK9dT9pFQK7qobAeIHbL5Dl
 GcztfognCss2MEmJuHRZyX9OpduDbRsPV50xQddee9rtdVSBu31dCDVGntFK/dK0noqc
 K/E91RqLIWDWfUg4ZY7VHlWN+/WSxO77s2ewE=
X-Received: by 2002:a05:622a:1f0c:b0:530:fd73:6c22 with SMTP id
 d75a77b69052e-5359f059b1bmr221357501cf.0.1791911758805; 
 Tue, 13 Oct 2026 10:15:58 -0700 (PDT)
X-Received: by 2002:a05:622a:1f0c:b0:530:fd73:6c22 with SMTP id
 d75a77b69052e-5359f059b1bmr221357141cf.0.1791911758309; 
 Tue, 13 Oct 2026 10:15:58 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91b97b3581fsm30072516d6.9.2026.10.13.10.15.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 10:15:57 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, manish.kurup@broadcom.com,
 stable@dpdk.org,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH v2] net/bnxt: fix memory corruption in tunnel entry list
Date: Tue, 13 Oct 2026 11:19:41 -0600
Message-ID: <20261013171941.452363-1-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261005202547.18322-1-manish.kurup@broadcom.com>
References: <20261005202547.18322-1-manish.kurup@broadcom.com>
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

From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>

In ulp_app_tun_search_entry(), when a matching tunnel entry is found
at index i, the reference count was incremented on
tun_ent_list[free_entry] instead of tun_ent_list[i]. free_entry is -1
when no unused slot precedes the match (always the case when the table
is full), so this wrote before the start of the array; otherwise it
bumped the count of an unused slot and left the matched entry's count
unchanged. Use the matching index.

Fixes: bdf4a3c6316b ("net/bnxt: support tunnel offload")
Cc: stable@dpdk.org

Signed-off-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Signed-off-by: Manish Kurup <manish.kurup@broadcom.com>
Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
v2:
 - Reword the commit message: free_entry is -1 whenever no unused slot precedes the matching entry, not only when the table is full
 - No code change

 drivers/net/bnxt/tf_ulp/ulp_tun.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/bnxt/tf_ulp/ulp_tun.c b/drivers/net/bnxt/tf_ulp/ulp_tun.c
index b90b4bf2523..8ecdac0dcce 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_tun.c
+++ b/drivers/net/bnxt/tf_ulp/ulp_tun.c
@@ -33,7 +33,7 @@ ulp_app_tun_search_entry(struct bnxt_ulp_context *ulp_ctx,
 				    app_tunnel,
 				    sizeof(struct rte_flow_tunnel))) {
 				*tun_entry =  &tun_ent_list[i];
-				tun_ent_list[free_entry].ref_cnt++;
+				tun_ent_list[i].ref_cnt++;
 				return rc;
 			}
 		}
-- 
2.47.3

