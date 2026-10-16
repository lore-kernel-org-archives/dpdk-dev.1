Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D49A2CC6B38
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 11:31:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C0C8F4064C;
	Fri, 16 Oct 2026 13:31:32 +0200 (CEST)
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181]) by mails.dpdk.org (Postfix) with ESMTP id F1C7A40291
 for <dev@dpdk.org>; Fri, 16 Oct 2026 08:26:55 +0200 (CEST)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-35cd4e8bdbdso7927630eec.1
 for <dev@dpdk.org>; Thu, 15 Oct 2026 23:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792132015; x=1792736815; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ldCKEzIp1SXAIp73QCEeh20c3+9eHABAhybYx98fK24=;
 b=r30t8bUshhnA9g0rMMUpDs+EBWCDXp4uNOTiR6TKnmibjpoOlyQyzfvDFwmFPbssXn
 V7Fi4V/h41UmstFOiGRQkCzfcYYBuQr9GpvhbyrgYgA65sBVj+/yjyl3pYhTynauwRet
 UVIiNEI18w23rx3VO9ybm2Z7+SVcy7NlKbL2SFKme371N1cnWwg9DEM7VBPeIELZmF/a
 Jfw+Ls9XL0hYSeueeLC07eKPiEXXgdT1I6Yu8DFPh0iXWbxjWdiHDt5S0IaJJ7INGtqz
 aQsN8w1JXeWT9uY6lRfCujJeu2HXcIdbcGyow0wEeHi1f3rjoe0EUM4JxVqTUwpOrI22
 Ueww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792132015; x=1792736815;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ldCKEzIp1SXAIp73QCEeh20c3+9eHABAhybYx98fK24=;
 b=nq9Lpmcd52TMOOsfq/R3RrVgHeZ8uUCqyTc7G0c0zVD8Qm9udQW05O8QoKZj4vCGiC
 t843WYS5EbKzkztKvs8U8sQQZNLZB6R/7CDQ0xfabHz+D6Vv1k3A1FySRfcrE2lKWgfM
 3SJtoBN/EJQ96G2+dSGcEKALAW8Xu06Kki4UIrpOGVC13xv4Bwng7yinTnorvT3ZoSbZ
 hcw9QsGmillaGD3zS90VLhGW0V2L91n0wZhwMmsvWWEycve90dq1lo1BavgVg6gcJ2uA
 5vldAVIyI80hErQIdJ0hlnxCrF5e9nm6SotxeYOo3lWBFuLKw+vQnBuATONGuAGT9Z1/
 mNZA==
X-Gm-Message-State: AFq9FYJWi9wA3qjH1GbRWd1+x7i+vqbFgjkWSD9i6zWn4os522SRZZN+
 +tzij+aElCh0lpbddVAxtAnHRE4P6FyyjRcIk/eFME5TlWcA/wQIBNE/yUlyfQ==
X-Gm-Gg: AYBFou3lteZHukgPYTmASRrS5Lf0lyf9rYf+XRiUfPgWFAIGEXrVGwd/H7xvHg9Nrsd
 hDNvZ/mqXc5D89nU2Rsc8JoGfA8wiBF6gtjk9xsXimYVOycLOJUG5uvj18h7C5hBzLtBXbx/8Rb
 LEvV7bi9JnYt+fN/s0lYrzVxi5gUIBbUoy5KxNvn7rbnqkwPONBX6D8Erh6FQtVcfKMwBdVDiwT
 X8Ui9IqQXTUWF+SXR30GZAmqf3qPRiF7DmYhTY4/lgqriWNM4hVlbkBu8PAEBqxR2blNWQGFOHb
 AY4HkEc/Y0Q2MRahLJ+RJtxKY6uY/m30fNI7jmRIb+3ucwbt2nUMUouHhV6GNX7PJxXzSl666bx
 3AgDeKcmYOcgy6587UVu/yi1INjJQqZGSqF6V3O5HqTvjcEfl6jRfLO+rZ4nxiS6HsYtMfNnPdR
 ZyymV9Cv3Tr3eRqjMvYdMxU3ZSlgYDxLesWnmJZz1Nowl44yzAXraaNQMmtQQeoli4ujAwtZRQt
 aVWvMGBoMc=
X-Received: by 2002:a05:7022:1709:b0:154:d06c:e70a with SMTP id
 a92af1059eb24-16a60ce6f1amr27755315c88.23.1792132014948; 
 Thu, 15 Oct 2026 23:26:54 -0700 (PDT)
Received: from aviuser.. ([192.19.252.250]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-183190aa3ebsm2743324c88.8.2026.10.15.23.26.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 23:26:54 -0700 (PDT)
From: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
To: dev@dpdk.org
Cc: joshwash@google.com,
	stephen@networkplumber.org,
	stable@dpdk.org
Subject: [PATCH v3 01/10] net/gve: fix DQO descriptor cleaning loop bound
Date: Fri, 16 Oct 2026 06:26:38 +0000
Message-ID: <12648982c592304da120914ffdfa1bc385f2821c.1792129992.git.tathagat.dpdk@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792129992.git.tathagat.dpdk@gmail.com>
References: <cover.1792129992.git.tathagat.dpdk@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 16 Oct 2026 13:31:30 +0200
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

gve_tx_clean_descs_dqo() loops on "while (--nb_descs)", which
processes one completion fewer than requested, and none when asked
for one.

Use a post-decrement so exactly nb_descs completions are processed.

Fixes: 4022f9999f56 ("net/gve: support basic Tx data path for DQO")
Cc: stable@dpdk.org

Signed-off-by: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
Acked-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/gve/gve_tx_dqo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/gve/gve_tx_dqo.c b/drivers/net/gve/gve_tx_dqo.c
index 5c03d3d1a2..e094761b38 100644
--- a/drivers/net/gve/gve_tx_dqo.c
+++ b/drivers/net/gve/gve_tx_dqo.c
@@ -122,7 +122,7 @@ gve_tx_clean_dqo(struct gve_tx_queue *txq)
 
 static inline void
 gve_tx_clean_descs_dqo(struct gve_tx_queue *txq, uint16_t nb_descs) {
-	while (--nb_descs)
+	while (nb_descs--)
 		gve_tx_clean_dqo(txq);
 }
 
-- 
2.43.0

