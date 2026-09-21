Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EADDFC982EA
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 02:17:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 76350410CF;
	Mon, 21 Sep 2026 04:17:12 +0200 (CEST)
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com
 [209.85.216.100])
 by mails.dpdk.org (Postfix) with ESMTP id CE44840E2C
 for <dev@dpdk.org>; Mon, 21 Sep 2026 04:17:06 +0200 (CEST)
Received: by mail-pj1-f100.google.com with SMTP id
 98e67ed59e1d1-383b4a3755fso1091711a91.3
 for <dev@dpdk.org>; Sun, 20 Sep 2026 19:17:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789957026; x=1790561826;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=joC7Y9F20wp9p2SvEH4ritduYy2uIc8i9z+T5IJhmeo=;
 b=OMie2RHHBP+gntxnr3W5+TlyPjp52JcoC8oAtHHiIZKGpXywnixyMEi33E55i9Z7od
 dLymkE1HSfaYX18hkU+1147ltlgkaAthCP3QzaiDkvJUQJB6Xru/zW3ndma6XXLDmHrb
 AsFIMBAkcVg6O4xfjofn72hsBK0xqGW6hqAmc4LDpfZy/OcvV9CKgklJlTZDBAngU+y2
 ct8NTGQv3LT+iNuSpv/gNAF4j/LGaRLFVveqrCP0TYNxh6h0tYu48k/4TiOxYRdkAL8+
 wu7uHMj7D3eyWBGEamJq9OJmmNQ8cDsA7z7TO1lnD5y1i4zupWwTN4Ik9it09eMpjaTk
 RDtw==
X-Gm-Message-State: AFuF++mqHqv+24DKJkmJ2SFX54XdZFRiyCyO4nhHNOudaj9uJZ4UYT3a
 O8589219yLKzYbLg/y+i8OLjJ5GF191z8e0YhvLxGLZQ2+uTX5lrPAHYk4J+/No9oLaGvvfFVo7
 R0n50BPDIbo8tjWyC5AgSRqzA3so7l534nz8JDj0ex7JSsWqps0I/uxEdM8gEIkx7jQQhJW7OaK
 4QRkAzlwKlM8HCjhVzC9DE1HUQm7fcPDXeCnKm94EdMRV7o/Mr5SKnyCYYQdlMiyLBxDezoAFEy
 laREqVFzs6D
X-Gm-Gg: AYBFou21dcSlP101/r3nxTRJrmI27T3vbwQCD6eOaV+T6RhQPu3li5NLISFdjVIqIPl
 wYxt5bFjym7/x7VrRoBKebS8g97hSSaneLLx2hE47vuM4h4AWEANedXPK7QzSeXo6yTYil3TgOz
 GJCegfAfOpaGLglKdVFsRruMWWV85wSlgvxz3CWIWnPYGsMS2+K1BQHV50OTmaFDNy0HUUXcjbs
 7Kdl1UXnC1/+JB/42UfAX5OVBr66Gfu4x+nAkzlFoBuGbVBPuHKxurUGRP4pwrAgUHWF1EeyxYk
 KKs7QQUlQJNjKsIMrr1n/5eSBx0otBZK769hbUpd9BPYqy6/oY7Zdy2YFi/Ktpga5zuPp20djil
 USmAwfEq47TlK8mef/AhqiOj6DnVsQyNyioykS9N5adPjv6WnZLL4F0YHrhBGpGInSuSSotFaR2
 sUhM+m2O9hhOfAJZweON0HZ3aJIULUxghSF8Hi+YK2H5CJwrTnfQ==
X-Received: by 2002:a17:90b:4cc1:b0:3a0:4668:4cae with SMTP id
 98e67ed59e1d1-3a046686d5dmr2390858a91.56.1789957025938; 
 Sun, 20 Sep 2026 19:17:05 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-29.dlp.protect.broadcom.com. [144.49.247.29])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3a02de1d995sm3202363a91.5.2026.09.20.19.17.05
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 20 Sep 2026 19:17:05 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-39512608fb1so6311904a91.1
 for <dev@dpdk.org>; Sun, 20 Sep 2026 19:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1789957024; x=1790561824; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=joC7Y9F20wp9p2SvEH4ritduYy2uIc8i9z+T5IJhmeo=;
 b=FmtqlnVD0E9pJ7aofFNigO/1nro3VCSpnS1H5oonSN2lyzuPphLTe1ZUGaD6im/v/P
 VWVSr/qUxIrPnTThCP5auZzgVWrzFgG42xFzZGw9HOxAQ41xVqIM0wzh7cSKmR3jHzlc
 OUBnOIlSJzzjhfh53bS03Qf139L90EjTsiV3I=
X-Received: by 2002:a17:90b:17c5:b0:39e:1633:d29e with SMTP id
 98e67ed59e1d1-39e54cc6ef6mr15567977a91.5.1789957024220; 
 Sun, 20 Sep 2026 19:17:04 -0700 (PDT)
X-Received: by 2002:a17:90b:17c5:b0:39e:1633:d29e with SMTP id
 98e67ed59e1d1-39e54cc6ef6mr15567945a91.5.1789957023643; 
 Sun, 20 Sep 2026 19:17:03 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c331d55cfsm18536753eec.30.2026.09.20.19.17.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 19:17:03 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, Joseph Wong <joseph.wong@broadcom.com>,
 stable@dpdk.org,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH v2 5/5] net/bnxt: fix VF info alloc error path memory leak
Date: Sun, 20 Sep 2026 20:20:02 -0600
Message-ID: <20260921022002.1033815-6-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260921022002.1033815-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260918032726.763384-1-Mohammad-Shuab.Siddique@broadcom.com>
 <20260921022002.1033815-1-Mohammad-Shuab.Siddique@broadcom.com>
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

Fixes: 01406837bf49 ("net/bnxt: fix VF info allocation")
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

