Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B51BCD6E60
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Jun 2026 13:13:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D7C49402A9;
	Tue,  2 Jun 2026 15:13:26 +0200 (CEST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com
 [209.85.167.52]) by mails.dpdk.org (Postfix) with ESMTP id 76D1440150
 for <dev@dpdk.org>; Tue,  2 Jun 2026 15:13:25 +0200 (CEST)
Received: by mail-lf1-f52.google.com with SMTP id
 2adb3069b0e04-5aa21fa024cso15575540e87.2
 for <dev@dpdk.org>; Tue, 02 Jun 2026 06:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780406005; x=1781010805; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wamRTm+SwCUOYcIyES4PqEXfUpwdXLnEOrRGT9XJogU=;
 b=E1OQr6a4gZ27irpRLD8TU1G8xiizolCMXHO1ZlqmkjWiF+3QSEySZbfpTvFEatLil4
 1FSKkCSTHiPwhQMAdBPVn5dzsIdID99K/Nyzykl4Ih7uL+M274F3Upoe4P27KMEyLdgV
 n3rHVZ9yqYWiggkzaCJrfAYuTkX7L3KPorx7rMpah59h6fwl1IK/yvRTgepfvSavjFHJ
 9x0F3S3QbnSVOQMy+A+vbvq5BH7aLClbWo5YMcJX8g4kWtx8JFx+dEYGuhN4JesilosC
 1ZxcOvqwV2udg8912TIS0E1PgNZ0nnb2MyKi/FIEr7NvF+lHKCCxMHdLkcayoUlep6w4
 E8Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780406005; x=1781010805;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wamRTm+SwCUOYcIyES4PqEXfUpwdXLnEOrRGT9XJogU=;
 b=LJq4nBz+m7i6/DtVv8ut7CKt6sHTsi0evPN44Xx/PKsBgdI2g1zIXqLad34KrxdU2T
 VFGM6fclaTEGSljRbMYDviW9LgMAlV0uELqPZaPqlRFQEVGIlyMP37U1DE0cVJh1E1t6
 wMg2gBSHDRjQ/p460NAY13240tc4mbsp+cXtpP5rM6GeE/7Ezo/HYjy1yz+VvQbPv8D9
 dVl6wt/8tIlEwXs4OZ/qgUWPl3Q7/s9jWrJNqq9gF+SUntzm9Rwv+rTUe7bqEPB4pl1H
 yJMh2nv08/WFtt1bJoZpKK8Jgjvg9AXFg7PG2H0876DOSMZi4heSWzIi3RH1+7R5GJwm
 oYcg==
X-Forwarded-Encrypted: i=1;
 AFNElJ99kZFB3/V89UCMCMxbnrso40TPE+eUDiIroXgfazyihWqT4oIKshiXjjESJFcoeRArgvo=@dpdk.org
X-Gm-Message-State: AOJu0YyFxyM5RFAN70+xN/9IAdKECpVpolpHrGFlFba7YClum9NY4UuI
 Y7tt9cd4xjjAN+paGuf0BzbLh1KJMDuLWR1cawnGtmlSgnNwQ8YoE4EB
X-Gm-Gg: Acq92OFLrxF6lMrPLWrVxtVEpCePLCTGXEUZFkbYeQRZeA0Mz5e4JlHq2j55ae8nys8
 lnXLAE5kJKxXnzipgaDIf5IO2o8JxoFi8DhlHT58b2/piyVGltDKS8V7PzmwOpYsiWyhzSry+a5
 fzQAHilu0uzB7Orgzlexv26vaaVFwjlybwtyTyXd8zqwoA4A3y5klBiWm9Vl0P6Mj1GQPnO/kKB
 MQ8jqO3FxVdbFB7QojZBQtNc5FbkupLU/tfLxvrBtCs+61OKtBVMXlG1jihy+MwHzwyD6EO859q
 2VHJ9dBebkbqrZC/coWAyyppfLxj5tf3bwqWmy89T50U1LccrD5QGjNnmt/Vo3eh4eOg1EHQ1bu
 48ozN9LBNowhZVUligs05/pN7b2sOPbmCrJnDnHRTlYIAna+U8pehK0FnN4oZ8EMFUXJKuQLsoA
 FHeSPlQzo2pSqgKiwdJmR1cMsYtzdNahodoK0g1TWlS7aMzZbdgdrklqMgMqMPAslTu7EAJPdnW
 SNdBklz9iQa5Cmp+VOOkQALyOI4ww==
X-Received: by 2002:a05:6512:318b:b0:5aa:126b:4504 with SMTP id
 2adb3069b0e04-5aa608e36eamr4558299e87.23.1780406004550; 
 Tue, 02 Jun 2026 06:13:24 -0700 (PDT)
Received: from home-server.lan (95-37-131-142.dynamic.mts-nn.ru.
 [95.37.131.142]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa5b78b3f1sm2776618e87.66.2026.06.02.06.13.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 06:13:23 -0700 (PDT)
From: Alexey Simakov <bigalex934@gmail.com>
To: Sunil Kumar Kori <skori@marvell.com>
Cc: Alexey Simakov <bigalex934@gmail.com>,
 Rakesh Kudurumalla <rkudurumalla@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Jerin Jacob <jerinj@marvell.com>, dev@dpdk.org, sdl.dpdk@linuxtesting.org
Subject: [PATCH] graph/conn: fix memory leak on socket init failure
Date: Tue,  2 Jun 2026 16:12:58 +0300
Message-Id: <20260602131257.108880-1-bigalex934@gmail.com>
X-Mailer: git-send-email 2.34.1
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

In conn_init(), conn_free() does not release the buffer allocated
for conn structure, resulting in a memory leak when server socket
creation fails.

Add missing free(c->buf) call to conn_free().

Fixes: 3f90eda5b7fb ("app/graph: add telnet connectivity")
Cc: skori@marvell.com

Signed-off-by: Alexey Simakov <bigalex934@gmail.com>
---
 app/graph/conn.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/app/graph/conn.c b/app/graph/conn.c
index c5e1c1ae1b..e73e929a08 100644
--- a/app/graph/conn.c
+++ b/app/graph/conn.c
@@ -197,6 +197,7 @@ conn_free(struct conn *c)
 	free(c->msg_in);
 	free(c->prompt);
 	free(c->welcome);
+	free(c->buf);
 	free(c);
 }
 
-- 
2.34.1

