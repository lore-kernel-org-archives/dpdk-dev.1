Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 848FBCA5FA7
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 16:45:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E0EFB42F3B;
	Tue, 29 Sep 2026 18:40:35 +0200 (CEST)
Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com
 [74.125.228.40]) by mails.dpdk.org (Postfix) with ESMTP id 6218042E15
 for <dev@dpdk.org>; Tue, 29 Sep 2026 18:38:58 +0200 (CEST)
Received: by mail-pz2-f40.google.com with SMTP id
 d2e1a72fcca58-87fd84c0bfeso1794879b3a.3
 for <dev@dpdk.org>; Tue, 29 Sep 2026 09:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790699937;
 x=1791304737; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RrebAgMqDOr/jVMFCuTxgMbH6qmTQldzzkvHNgCrhKA=;
 b=GgrgToUGH/glkQPtqS56sBIEW6iK8kIsJP26IK6uG5tO7vN3WUONu+SXkuTgZHbs8n
 7+17R/O/k/4muID/X7OwV1dvSuXj0TZPdpN8hPzPiqskIWsukRqO3Jvb5pUrBbuwmKTN
 GzMaCzs782K8CIqM3hFdE4whbp5AEG2BYS6vwYEFX6hecXGqNRoOG3yl15HzAcQEulwb
 CG0M2EJdwiEhN110XQe+fbPEYLk6xmoyJxT9QiKtz3rTGdwEKaQgHdAOm/Yd8yWrgiRd
 F70ZCQH4AskvX7PTgJFxPlmQ4YGqpVi0h98y5iheFtyetpztwCvzFjEXVCbUzYiUBOqz
 Hxmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790699937; x=1791304737;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RrebAgMqDOr/jVMFCuTxgMbH6qmTQldzzkvHNgCrhKA=;
 b=QacEnr7R0gA0LYz2BHjEsy4sB8YxpZ/5QIJkNE8mgg1snJL7gEVIxE5FHQiavKeNsy
 HKnX/H8mZ9IYHzZ2rvl046b4Pp69F3IXg1ePiTpJM8GAsshI1iaeelastFBrI7GdcBYM
 nLFB0X2owO0sE2n38sTEmAqGqxU9bY2FQs0hHxLJSjaqDlaADiCQR4Lojbi8IIzKsBhP
 tiW9Up9/BS5n1lnZXXuoAgGA27PVXML/q5hJpor69dPF/s/yLH+M8tXY4xJD0RMF+VLr
 kfC+SC0rygqgaK4eI9VOM6Wtijhh/IZyXUP6bNEAJHm6lrMas6xw+3rsM6kQ014cbIQX
 /vtg==
X-Gm-Message-State: AFuF++kCI3Ff75xKr/fPj+9hm8oCe1KxNW5gAE5vxIi1uL3qO2KdnFnj
 lYhLf/IdddoaBsANUdx96PpvxV0DkbkeZlYrirav96jveQ2amfER8yN6SHgZlQlM4SBmh0UGDmH
 nVsh6dXHlPg==
X-Gm-Gg: AYBFou3u4wnwNsgdHJiUpMDO5DQop0Ysyc+altlnd9XcB23qekPrOweDBrd+vtxihNL
 fWCOd2bVpAhIqwb5xZW/FIcyQFwRWMmSqN54kXrw0FvI9B8DuCMGMeZvzgqpFwSyXDNo+rECYPY
 poW3eY9DQKu4EIfkk6sRX9iPdTLzA82w3JsoX23/nKKd7Ls3DrUp4rv+zS9SFbBL9f8vH3GVxNN
 nqIglXw8cT0YwZuaPUoX0KNVT0sjmv9I44YQNm1XBpaXPOxKoavtkcUDY7L/dRac7TGcXR+kFQ+
 GlM5TUZy65AFnVHou7Eo2jfHFwOQw6yIvrF2GdUWzp9jPiGQKfIiyF6Duahmv1JtaYK/uu+f/fc
 UMr+W6F8x0Wn89Kz/2ZZ0UeNRMvLFhahHwru5DFsjElseJnIbfv6jr74nWMJLFRhnmkmvAPCIDs
 Qjoi1Oxov9BKZGwaFDwxVUKNRWoLRs1XyXpeG2klZ44FsaXoyaPQhS2uBnMIZqWS4GP8NCDa0oU
 4RZDl1Kg5lWGsodHwlgveYARK+2VeDCcqkwYw==
X-Received: by 2002:a05:6a00:368c:b0:882:94ab:20ec with SMTP id
 d2e1a72fcca58-88294ab313fmr6513667b3a.25.1790699937514; 
 Tue, 29 Sep 2026 09:38:57 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8868ba02d02sm232392b3a.21.2026.09.29.09.38.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:38:56 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH v2 56/61] dma/hisi_acc: use kvargs numeric helpers
Date: Tue, 29 Sep 2026 09:36:59 -0700
Message-ID: <20260929163800.1108305-57-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929163800.1108305-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
 <20260929163800.1108305-1-stephen@networkplumber.org>
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

hacc_dma_parse_queues() open codes the errno and end pointer checks the
helper performs. A queue count of zero is rejected by making one the
minimum of the accepted range, as before.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/dma/hisi_acc/hisi_acc_dmadev.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/dma/hisi_acc/hisi_acc_dmadev.c b/drivers/dma/hisi_acc/hisi_acc_dmadev.c
index 196aaadc05..7db93852a3 100644
--- a/drivers/dma/hisi_acc/hisi_acc_dmadev.c
+++ b/drivers/dma/hisi_acc/hisi_acc_dmadev.c
@@ -660,13 +660,10 @@ hacc_dma_parse_queues(const char *key, const char *value, void *extra_args)
 {
 	struct hacc_dma_config *config = extra_args;
 	uint64_t val;
-	char *end;
 
 	RTE_SET_USED(key);
 
-	errno = 0;
-	val = strtoull(value, &end, 0);
-	if (errno == ERANGE || value == end || *end != '\0' || val == 0) {
+	if (rte_kvargs_to_uint(value, 1, UINT64_MAX, &val) < 0) {
 		HACC_DMA_LOG(ERR, "%s invalid queues! set to default one queue!",
 			    config->dev->name);
 		config->queues = HACC_DMA_DEFAULT_QUEUES;
-- 
2.53.0

