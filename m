Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28CFEC021A4
	for <dpdk-dev@archiver.kernel.org>; Sat, 15 Feb 2025 19:07:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2F82B40E24;
	Sat, 15 Feb 2025 20:06:16 +0100 (CET)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by mails.dpdk.org (Postfix) with ESMTP id 8781C40DF6
 for <dev@dpdk.org>; Sat, 15 Feb 2025 20:06:08 +0100 (CET)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-220c8f38febso57634795ad.2
 for <dev@dpdk.org>; Sat, 15 Feb 2025 11:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739646368;
 x=1740251168; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BWlABOBDjT+D93lC4xk3UAjMk4KNQQKjBPILflrvYnM=;
 b=ZzmMmblZm3ui77aTezLZc8h2UV4dQhXGWBx93neWeCo+Bq7x6eHiN0ctW9UX6W2IAO
 brpvdbJqKObelGct+M3Pa8pdEIHgqFKlcpqIbganXxF9m+9iSnJQwiKN5iCFpd+vTEBS
 HMgZ/j8RrqONMFFDAKBp1evOqcPucycl3HDSCVvON4HGtLABomNJl0+M1UA+IofpFnyK
 6Vxjs8QOuahWhxO3/kMLve5WFeAKlEkTqJOMZ7M/jdPqkIdpFDFNTzrwmCyl7POIgOUr
 PjQ+RcVNpC8gklugjvE8Ssiz1leXalpUtTg7KrQD+eNhhV2m9ZlANx5dEeU0YIaX6KxT
 TJiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739646368; x=1740251168;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BWlABOBDjT+D93lC4xk3UAjMk4KNQQKjBPILflrvYnM=;
 b=eoTj91dF4Se5PB6wyQDzVLYPbYJNSdSu8GdTl+k51rJtQ6Kyv8IdG9mq70EV1rmi28
 1nVVCtXCHCyL0WWGLTRdcUAargwA3mHzZ+diWuPzjZuzquH+nEHkqGqPw1BTi6HMjVSj
 aGIbtbaRIhFUVEhcmuO60raIC35luRAFp3qujJAktZAM9ty2y9o91mDosPo0ucbGzSkU
 CnHJu8qznzwI+bh67RFg8ZvRz085cx4MsQE1PznJGkMh7H/5ECVlZPsptMkHZCWj99lO
 W71z31tU6PUGd73N5JaG0FGrfv2LuBfVx111R1Y2zWalKuBwx0X5GR7DbTyJG7+eLK54
 l2tg==
X-Gm-Message-State: AOJu0Ywb7TtxuK6xetkfrhzWmn02Ao14Wmw3SUQ/IO6v7A15imSXXXY9
 uzzioOlNvF2CAsgbAuqlb7OpHjh4Yk6Vh8gboEkrThB/8j/YgdHaw6l2BY5vfzIjnidjgZXOwg1
 a
X-Gm-Gg: ASbGnctP5z7KMWTYlR3FCQoAZ0pBJLQpr3yPP0dJwMht0h7hS71ALn8xE+PLOVjKIU9
 NOmAi+W2OYAFgDe+7Hu69QXdtfkWjo6IZ4LisJzVTjZoTV0VLHunhMnjt2HVmsraaRVgL8j2/qK
 CAZK2GLJOc4Ty50odhByCgShVaMdmKXFo3xgsmYESPvmicY2CKygPM2DOeZa4ITSfgrkh2XJtBR
 F6ssaJPBExNwTy6aFtcEp+knF3y6NpIqoJMmszhUXE0XiJcifvGagWybCqo7zLSQ77Wv0deTtbG
 X+meIPj3tFaIhd1RJgVOVuE4dYwnI2OKVuRgoXn+HmKFamiBnW6GFMtAEOeRXWULjsLW
X-Google-Smtp-Source: AGHT+IFOlRpdszxFZvt50K6vqChvQBiCSepNT/2wb1lscKqKVpEXnhkW0xsEjbCI5pHy6ozTPYWZhA==
X-Received: by 2002:a05:6a00:1816:b0:730:7970:1f8f with SMTP id
 d2e1a72fcca58-732617bfaa2mr5626033b3a.12.1739646367821; 
 Sat, 15 Feb 2025 11:06:07 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7324254685csm5080179b3a.4.2025.02.15.11.06.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2025 11:06:07 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Christian Koue Muf <ckm@napatech.com>,
 Serhii Iliushyk <sil-plv@napatech.com>, Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH v7 14/16] net/ntnic: check result of malloc
Date: Sat, 15 Feb 2025 11:04:42 -0800
Message-ID: <20250215190544.988310-15-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250215190544.988310-1-stephen@networkplumber.org>
References: <20241114011129.451243-1-stephen@networkplumber.org>
 <20250215190544.988310-1-stephen@networkplumber.org>
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

Need to check the result of malloc() before calling memset.
This is only place in this driver that forgot, other code
does check.

Fixes: 0d9bca480e26 ("net/ntnic: add FPGA modules for initialization")
cc: stable@dpdk.org
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/ntnic/nthw/nthw_rac.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ntnic/nthw/nthw_rac.c b/drivers/net/ntnic/nthw/nthw_rac.c
index ca6aba6db2..f275e64da3 100644
--- a/drivers/net/ntnic/nthw/nthw_rac.c
+++ b/drivers/net/ntnic/nthw/nthw_rac.c
@@ -31,7 +31,9 @@
 nthw_rac_t *nthw_rac_new(void)
 {
 	nthw_rac_t *p = malloc(sizeof(nthw_rac_t));
-	memset(p, 0, sizeof(nthw_rac_t));
+
+	if (p)
+		memset(p, 0, sizeof(nthw_rac_t));
 	return p;
 }
 
-- 
2.47.2

