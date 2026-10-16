Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19878CCF2D6
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 11:47:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F5DF4069D;
	Mon, 19 Oct 2026 13:47:05 +0200 (CEST)
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178]) by mails.dpdk.org (Postfix) with ESMTP id 45C6D40291
 for <dev@dpdk.org>; Fri, 16 Oct 2026 19:46:00 +0200 (CEST)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-30b6dad2382so455921eec.0
 for <dev@dpdk.org>; Fri, 16 Oct 2026 10:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792172759; x=1792777559; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UPv2MY97wlhAV0SL6IlHmHIdRAI9ifvw17vNCwGKG5s=;
 b=DYSFX/qZ9oUqs3an44XSDvbP1QsK54yG1Rmc5cZIM3Hr/YswBDNMys/XxiuzCp3Q32
 j7MDFQx5ffGxhIcOKgp33Ucs/BgSp7P4QOGdvX78hex+Ueeq3UOXb3boTvqfwmRK/BPQ
 aSPaTM6EZos0+8P/fkXPChb80foD1k3Y1cvKpJ8+zPP3Et7qYQFq3MalaiWfOQ2H6jHC
 SXlM3wLqSrAqNRg3VrAo+a+mYyDVOhj36H7vPhgSpFjzmNouIBiZdbcx3D2Hvvrb8RBV
 URXD40OU1Pi4YqO1Kgl60Sg/Cpijs5z5iZF5j0uqYZ3ig0We6rNidfPGAyfTBvu42MAq
 FACA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792172759; x=1792777559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=UPv2MY97wlhAV0SL6IlHmHIdRAI9ifvw17vNCwGKG5s=;
 b=eiSIBzrfawFf1UmLkyeJaQA63s0Q0WcGjxWbiz8Ky8YatmY+/qaTDcwVK9kt6QXddz
 KqwSKpvd9jtsqBnU7pTSSlrTnHWedEEpNpg+h/nMtuHx3mh0QasIz0RO9HXoiMM7U3FM
 2cP1XR26oFsX6m1DhshbugMS+qbgZzjC5TB4iJc3PYZF4jN5ZpcpwuYsPmP17knFjcwM
 2I2K7jR5nY2spd/IGMlWe3izBWD7fjlCXPgDONwSh1O/YwOkRkWH/XZwaAqjy74vtLaz
 38Ai4G12tJTEVV4I8IrMzHT0UAoH45hk358VbDvxrBl+naNGgqzJpeI/UwdRP9hrIaIp
 7y8A==
X-Gm-Message-State: AFq9FYLUW6PpKn2InMYE0MBo94Zu3TLZmjaB2/ER1QGPcNawZMAFMkeT
 EugYhfUzWFzNVH0qOtstpVyexigZtd7CFLhTwt6yJ16h67eahh1hOPZh8APevQ==
X-Gm-Gg: AYBFou0gxBNxYE/vazssFh5B4aNuIh5V5HZOPmdcxoiBDAVGjpb6fNXIH+AeNcPLanI
 9Vz6PQU9F+SWTOHAwTb9VO/kZTlW47n1afBYANCNE7GeUZAv2EFmCdmzljH22IsLsxwz3MvYRcl
 w8oTL2sueJVeLpWgqQFGRSXjPGOk2m5U2PZ18j130SPeDBILXPmrh/GEE6sjlVQd6KwkWneA14x
 WQw2D9pvpG1RveJEswVponGlGbWwY82tzOMnDA3yVBSYrMm7+Abj0Q10TNhyO6EObLlTSGTQy0O
 vcmjSswW2cHMGxRqrzColbubZz7LZXUCk0xTKl6/bT5rKGYJJ0WBIRf7D4QiCPApHe5nPCPAR2A
 mtwva9WuwJIyBtZiTHZNS/TaKLTMCIFuIPHCFIKAquGN8H/3e9pMFKEwRWvIDIM85w8+ZLMUkfy
 +TGMZiNIAgj3/lTIKBdDeN+lbenGPkGSjQMau3QAPxFgAqxt53N1RXWLSkC8x5Fx2Tcla7xFsk
X-Received: by 2002:a05:701b:4510:20b0:14b:cf58:ce5e with SMTP id
 a92af1059eb24-18506f56db0mr842513c88.0.1792172759004; 
 Fri, 16 Oct 2026 10:45:59 -0700 (PDT)
Received: from aviuser.. ([192.19.252.250]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-18314ef8ed8sm7099936c88.3.2026.10.16.10.45.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 10:45:58 -0700 (PDT)
From: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
To: dev@dpdk.org
Cc: Joshua Washington <joshwash@google.com>,
 Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Rushil Gupta <rushilg@google.com>, Jeroen de Borst <jeroendb@google.com>,
 Junfeng Guo <junfengg@nvidia.com>
Subject: [PATCH v4 02/10] net/gve: fix DQO completion queue stall on unknown
 type
Date: Fri, 16 Oct 2026 17:45:37 +0000
Message-ID: <7d24785decb142945bc6075bda678d72a7a1dc94.1792170902.git.tathagat.dpdk@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792170902.git.tathagat.dpdk@gmail.com>
References: <cover.1792170902.git.tathagat.dpdk@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 19 Oct 2026 13:47:02 +0200
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

When gve_tx_clean_dqo() sees an unknown completion type, it returns
without advancing complq_tail. Every later call stops at the same
entry, so Tx completions are never processed again.

Log the type and skip the entry.

Fixes: 4022f9999f56 ("net/gve: support basic Tx data path for DQO")
Cc: stable@dpdk.org

Signed-off-by: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
Acked-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/gve/gve_tx_dqo.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/gve/gve_tx_dqo.c b/drivers/net/gve/gve_tx_dqo.c
index 7e12da68e6..4b84135d02 100644
--- a/drivers/net/gve/gve_tx_dqo.c
+++ b/drivers/net/gve/gve_tx_dqo.c
@@ -105,8 +105,8 @@ gve_tx_clean_dqo(struct gve_tx_queue *txq)
 		PMD_DRV_DP_LOG(DEBUG, "GVE_COMPL_TYPE_DQO_MISS ignored !!!");
 		break;
 	default:
-		PMD_DRV_DP_LOG(ERR, "unknown completion type.");
-		return;
+		PMD_DRV_DP_LOG(ERR, "unknown completion type %u", compl_desc->type);
+		break;
 	}
 
 	next++;
-- 
2.43.0

