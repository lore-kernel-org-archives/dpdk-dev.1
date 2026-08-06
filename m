Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CADC2C56208
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 14:04:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0FDB0402BB;
	Thu,  6 Aug 2026 16:04:02 +0200 (CEST)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47]) by mails.dpdk.org (Postfix) with ESMTP id 0344C4027E
 for <dev@dpdk.org>; Thu,  6 Aug 2026 16:04:00 +0200 (CEST)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-47fd4531020so1454233f8f.3
 for <dev@dpdk.org>; Thu, 06 Aug 2026 07:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786025039; x=1786629839; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=vUMO8y2f7LiHBAZ2N5vLuLSu6nQ0sX4X+AWbYK72P6g=;
 b=qmKdfT8dejFGN81QkL+GsHbvfUKIM2GHyHYQe1GOFepCx8pJlo8haO3DvHWy02B2uG
 O3YjPu7bYOe3tZB4A8w/VcvupsSauoctC48mQ0pvtnh110bnlK/eATNBPyhCdCxbfA7o
 CF0iDHWWtWVVHdtHralhSRYC//G6oGDpGDYXqsP0GhdLLDxLBpUAyJuWQB3j5RQUu5rt
 eMgLzsbdI0S2iLWqAbcyoyjOwXpIXOFeUeD/qtcCm0peBq/CkgUvvfMQtfbGFqgwpthN
 /ovHXcIUChWPSzNmrikyegA5EY9BwuInnT+BPlIr7INtZxLVYC3gz5tjaHFQbJLhUhuf
 bq1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786025039; x=1786629839;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vUMO8y2f7LiHBAZ2N5vLuLSu6nQ0sX4X+AWbYK72P6g=;
 b=H9MB3iuXjdVAegrIKezZoxm7cnddRxuWn39W3KMXgU3tgsUO2V28XW5IQbGBpmMZ4c
 pFgJk+G9modyiVuftOtJv6kRm++tFPd76UG5PYUpzEjwk2kgHwFBIrZD9DQD+vJpqBFq
 ShfltNBpkago74RrT6EwFJ8T3gyPzbVeaeOmjcdFsJYUHPdOdqYQ3xTb1ldwKzllsK1z
 /r+0ggEziw+/vwxNE+U3nUq89o1B7BkPB/9/QaUiCncuKKOjlokZpaU69Xm4ruQ8Slz/
 2rDl761VJulVyt7wUAxaNbCengmHU76dWLKt6YI4B3JoJrBYkQ+xRjuuyLkSsUpObP+l
 J3DA==
X-Gm-Message-State: AOJu0YySp+fElLBWf4Uk51CaRfChpM1gfEGhqfbmcmcyusi97Rdk42Cw
 CvwB03xpr7/0mPpeSZGHF+8QQOb0OuqLgyA+/tDo4XZ4SnVA9Czkl4hl
X-Gm-Gg: AR+sD13B2NJBdptn4+TDfgMZNu+mI2IlvngbIugl+5ADLbYg1MKacX4kVdt1aWCtwS1
 irfF6TkU1y6CIzCsSXNP2tfHCv3GGYLbY2dfWQKXj4RpTo4W+HzcpkIBtFq5tTLebPjMDf9rKnn
 0TokgMA4CyTTgSy361oxxyCoQ+qWprqwQK84XJ0HBILEK02+aj42vg9sdkHqLKxLxNrhJUst5JW
 mm3dKz7EuSB/Y2nDS18A5kwZKb5qnHKqNit+6IFlFWRH7KW9IUD6tze3Kg3yOOIkYqveo1ZrYXX
 XY+lda7YtmLr7tckFGoB8t6aTH4kqMBnbxQCersb+TCo+Ay/tc3B1ZIpU87tjDqehtdHwDL7zp7
 5qTNMjODNoWPgrZQMBsqGuNuOSl0o2ggUJ9p6+GkR2QXf9aNmpKqgx23XFI37aEqpTcDM83q5z3
 QtHSxwx9/f+jPGTOQoF9MfH+Q44IV/DSrpp/8n1+cpkaQxGianjlFa6GZ4s3h2kg6qquw=
X-Received: by 2002:adf:e19d:0:b0:47f:f138:226 with SMTP id
 ffacd0b85a97d-47ff138035cmr18321092f8f.17.1786025039358; 
 Thu, 06 Aug 2026 07:03:59 -0700 (PDT)
Received: from DMUbuntu ([95.214.11.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47ff7b183b2sm7168107f8f.24.2026.08.06.07.03.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 07:03:59 -0700 (PDT)
From: Dmitriy Matveichev <matveichev.dmitriy@gmail.com>
To: jgrajcia@cisco.com
Cc: dev@dpdk.org,
	Dmitriy Matveichev <matveichev.dmitriy@gmail.com>
Subject: [PATCH] net/memif: unregister callback on error in listener handler
Date: Thu,  6 Aug 2026 17:03:33 +0300
Message-ID: <20260806140333.35422-1-matveichev.dmitriy@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Fix the crash if a memif client disconnects before a server says hello

Signed-off-by: Dmitriy Matveichev <matveichev.dmitriy@gmail.com>
---

If a memif client disconnects before a server says hello in memif_listener_handler we get errors 
"MEMIF: memif_msg_send_from_queue(): sendmsg fail: Broken pipe.
EAL: PANIC in eal_intr_thread_main():
Error adding fd 59 epoll_ctl, Bad file descriptor".
During the error handling in this func a socket is freed but the eal_intr_thread_main knows nothing about it. The descriptor becomes invalid after close. 
We should unregister callback from the eal_intr_thread_main loop and only after that we can safely free the socket. 

 .mailmap                         |  1 +
 drivers/net/memif/memif_socket.c | 10 ++++++----
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/.mailmap b/.mailmap
index fcb3d1bb3f..d0148b0d9c 100644
--- a/.mailmap
+++ b/.mailmap
@@ -409,6 +409,7 @@ Ding Zhi <zhi.ding@6wind.com>
 Diogo Behrens <diogo.behrens@huawei.com>
 Dirk-Holger Lenz <dirk.lenz@ng4t.com>
 Dmitri Epshtein <dima@marvell.com>
+Dmitriy Matveichev <matveichev.dmitriy@gmail.com>
 Dmitriy Yakovlev <bombermag@gmail.com>
 Dmitry Eremin-Solenikov <dmitry.ereminsolenikov@linaro.org>
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com> <dkozlyuk@nvidia.com>
diff --git a/drivers/net/memif/memif_socket.c b/drivers/net/memif/memif_socket.c
index 649f8d0e61..898ad75fa6 100644
--- a/drivers/net/memif/memif_socket.c
+++ b/drivers/net/memif/memif_socket.c
@@ -878,14 +878,16 @@ memif_listener_handler(void *arg)
 	return;
 
  error:
-	if (sockfd >= 0) {
-		close(sockfd);
-		sockfd = -1;
-	}
 	if (cc != NULL) {
+		rte_intr_callback_unregister(cc->intr_handle, memif_intr_handler,
+					 cc);
 		rte_intr_instance_free(cc->intr_handle);
 		rte_free(cc);
 	}
+	if (sockfd >= 0) {
+		close(sockfd);
+		sockfd = -1;
+	}
 }
 
 static struct memif_socket *
-- 
2.53.0

