Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C787010F6FDC
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Apr 2026 16:41:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D3F2E40E15;
	Wed,  1 Apr 2026 18:41:17 +0200 (CEST)
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170]) by mails.dpdk.org (Postfix) with ESMTP id 25B9140DDC
 for <dev@dpdk.org>; Wed,  1 Apr 2026 18:41:16 +0200 (CEST)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-2bd9a485bd6so13977462eec.1
 for <dev@dpdk.org>; Wed, 01 Apr 2026 09:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1775061675;
 x=1775666475; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aUDZC/1q4hXKgHC3FR+HuN6mDAUwYjhj2fFRrnWnrMs=;
 b=TmVpHa28hdbLwNUrfg7Ab8VEoCGT99D1/c3UOIQj583n8Ot6sRzhrPHwhimmAKOb0T
 RS184JPbv1upAt0aWDaNVju87+8B2HFe1j4PcOelRSCKgbVks1hfznLdYCzWEqIiJQEz
 LJSKTTW9N/vp+ZYOlEDNabBhFUk7Ac7GAtUnqs/2MwhijuloNiDrvagn0k45T1ScXX7L
 7UpZOlv0sJudGYD6dHoa4aM/1AdpzCviA60FBmcjQMeu4WS91moEVXt6T28BjTCnyBbq
 ++7PVgBa6zxEQGEN53LoO0w+UVTvkQd5xtFTyYJW1lqHyMEyicVkOXLxT0soyqzVfdfr
 RpkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775061675; x=1775666475;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aUDZC/1q4hXKgHC3FR+HuN6mDAUwYjhj2fFRrnWnrMs=;
 b=Qrvjp0nepxOh/TWGPosItxNoU9PqgmzA+J04uZdJ1Jh4mMQ2hriEWM8UYiTSpYQrYl
 jb/Q5/xwQzZuidtJ/nbapA7VCNvJtfN8KyRwodYnWtql0hvfAGYYLfrParmUfQH1vZKP
 5mWXXtBFZ9wi4tSLNqRDuH7CaTR2Q/OwItisd6+OUQUG5G9zxzqpAWkOaYWNOf4tg5o9
 jhHfTbDVM7Oj4b4sBBsqfI2051F4T5A+aW/JWUl9cKR7nK4tgsVqgZp4hIroiBzHkc0P
 JaAxemw7sO6VSHEGqXWLey5p6OownQnfyLuqFTtpCeg+V4T18SsBEZ9L244S7AWQpJev
 THyA==
X-Gm-Message-State: AOJu0YyfHoUoiBZQgB+mSEZ0NwVL+lunY6+6RpsDKY7jTWEsv6GaBoYU
 oJiflM2D9Eglq75EMCeDhW9gDDgFeHG9EGdyxCLsOQ2D0tJN1iWB8Uk7ERH/8uJKmu0OBDgoxC+
 Vz0ox
X-Gm-Gg: ATEYQzxMlTWu3pPsnYfJy9Hokw14XUXlCW6TeQx2LrsIEHc40MdIl8+beQtk0odtETX
 Owvi5FZHfdgZttjvHgPspGSskddPY4aOcKg0qQpSt9egJCwDF2G1pQiIe9hFujzBe1wf2IZUF78
 7Ss6atgCreDgl8ZPPmAHCMOyjuVYNmbdNsjHjcZGwkjNDWN8CMH66q24ARjM3/KMd24cfRWTi8X
 uQtuRvivoFjqxTHsHQG3MyMViDLHvh/zC8g2NAZsUCFSbFoxhqzA3XZqj+2tvilLomRyapa35Kx
 +qmew0pnNya1TSC8PRNMlf0rGoUsksc/DpF7IKk3zLIHKGzGuP4nMaVouqUCIEMP20tDY5TK18E
 g4EkRGO64S67gGQWxk3rJpDWsy7LaAI/2d75TwUzRXT7A3QSQItQhfnfspl57E4syKb0JNdUzBd
 ck7LSrtWZrSEPol5S07vboPOPMmWLTVS4YsBFcU/qpPDU=
X-Received: by 2002:a05:7301:168b:b0:2c8:409:a9b5 with SMTP id
 5a478bee46e88-2c932bb2347mr2252824eec.26.1775061675102; 
 Wed, 01 Apr 2026 09:41:15 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ca7c20c0c2sm202583eec.17.2026.04.01.09.41.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 09:41:14 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 4/4] app/test_compress: remove unnecessary null check
Date: Wed,  1 Apr 2026 09:40:25 -0700
Message-ID: <20260401164108.201404-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401164108.201404-1-stephen@networkplumber.org>
References: <20260401164108.201404-1-stephen@networkplumber.org>
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

No need to check for null before calling free.
Found by coccinelle script null_free.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test-compress-perf/main.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/app/test-compress-perf/main.c b/app/test-compress-perf/main.c
index c9ead02cb4..bc2b185da4 100644
--- a/app/test-compress-perf/main.c
+++ b/app/test-compress-perf/main.c
@@ -392,15 +392,13 @@ comp_perf_dump_dictionary_data(struct comp_test_data *td)
 
 		if (fread(data, data_to_read, 1, f) != 1) {
 			RTE_LOG(ERR, USER1, "Input file could not be read\n");
-			if (td->dictionary_data)
-				rte_free(td->dictionary_data);
+			rte_free(td->dictionary_data);
 			goto end;
 		}
 		if (fseek(f, 0, SEEK_SET) != 0) {
 			RTE_LOG(ERR, USER1,
 				"Size of input could not be calculated\n");
-			if (td->dictionary_data)
-				rte_free(td->dictionary_data);
+			rte_free(td->dictionary_data);
 			goto end;
 		}
 		remaining_data -= data_to_read;
-- 
2.53.0

