Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD958C982DA
	for <dpdk-dev@archiver.kernel.org>; Sun, 20 Sep 2026 18:15:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E913540E3F;
	Sun, 20 Sep 2026 20:14:13 +0200 (CEST)
Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com
 [74.125.228.42]) by mails.dpdk.org (Postfix) with ESMTP id 52F2140E27
 for <dev@dpdk.org>; Sun, 20 Sep 2026 20:14:08 +0200 (CEST)
Received: by mail-pz2-f42.google.com with SMTP id
 41be03b00d2f7-cc1cebcb8d7so720296a12.0
 for <dev@dpdk.org>; Sun, 20 Sep 2026 11:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789928047;
 x=1790532847; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=j+6++tilbNRJ6kg26GjuFzl8xP9OUNprHsnbNrRi+O0=;
 b=dmXxHYqMvei5QRgFVjlQ6LFFBfXpY33fsthXosP53XJGgNWFpVngmxgJbjr5B+7dQW
 txHLyKxa0yI38Uj7oGVrk2iTy5n2qVHRYN1g65gHDn3GMbjqZBFIMdOvnrWfGT6uhnz9
 yC/T/GqJH3OJSEXy7sQMO6dxqVbNHMeGSzaCm6CUOij858nDAIIOyvmR1C1H5HBzg4n4
 lFoZoYWdq34JV2q4jwRp9VzYvGR6KoabSuHKozN9jNvlPA7r/2PARh4525FnPLZcZ2gm
 bJL90qjLMj4hXteUOyrTI3xTVeN6nhKDWhcbeYVjvC9kVpMed87mkLaCrqRQ6ziRZQuZ
 7ixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789928047; x=1790532847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=j+6++tilbNRJ6kg26GjuFzl8xP9OUNprHsnbNrRi+O0=;
 b=VLD144n8FFpZAAWJRIwEIxXBzrxMLUIz5djdcuHDaftABmmZBsB2fkxszpOlRd56Rz
 F9f5Ow64AjGvogEOahLYfMTCZTKxaMPAEnjUHTXdaIRfVIJnDyViJrDBZpLXlrZDOP2Q
 HZDEwjenNOQaJrA1RQnAEDRbgLeO3ero/M4Xkzxw3PEDfOy1chl7XF/G3qZpfvDP1b+n
 s6TuiITzOqYHP6sDHwSmcMMLW01yJHSkaR9Ls8eu8APLZXw98hPW4nZcm6A1BZOOk3jC
 5aoJqil2yvZmNr4h3fv4FQJzZO5kz2S1nOqi1flW0JvI/su4Qrc2AuOpAah3piSbf9jp
 FKcQ==
X-Gm-Message-State: AFuF++nHAkRVfMWPC90lwoDqePT+Gk/jgyEuJbfc5V5PHPUrGQ4+lCnS
 9hG9j/d+84CKfR2N/ek7K4gsXMmPaem6jK5QzZmOaOf/ptIPUw8i4TxOZkImSL0wMhk1hwJO2eb
 2nbbY
X-Gm-Gg: AYBFou0PEL8Kqqi5GjeEyg4lPFEpTbzVjThi/lOOuUpKKQA0lknHRNJrod5Y5+OFLMt
 /ngJ079jdA57jYu+t8PLlw3l15AQiG/QtWBLmRf2tm0MaxmO+OLwgljYUL4mWqNBfPYfoZEjOXs
 uQU/XsZPdZ8CoEcx/+I1VXzO2iii5xqcJuQqKxJrfW6pdQjmlKJMseU4UfkkU9Zp0zZQCzD9xZB
 b5xDiuvalHOf9+fLb8rGS5Kjp+gNvoqwPc7Hg8QMxxp/rr5xryIgez+GnxFHCLSgdsZLPhDZqOw
 M7V6sJ+XueiUmUhvY3U51IfnCS5KsWhv0y4xNR3FqQ7Zi5vvDgaQmkoPm8CagIOl+a6ltshv4fn
 LdvwnCCDVZcMdQmokkPEkcJNEScYxvdmJ9CgjWtGshVYTsMrV4lHDOLeAQ5zT9cjasDprtVIK/m
 jG/QPaQOhsGg4zHm6Tly6Mn8GOYS2pIPBVGkN9JnW7XdORav7UypWp/vD6/HZO/NowyIj9D3TQP
 EraTM0mC/+9KNUIvWE7WEBw1JfXgB+YmOqLyQ==
X-Received: by 2002:a17:90a:d650:b0:39e:6a7f:6188 with SMTP id
 98e67ed59e1d1-39e6a7f641bmr5272112a91.25.1789928047459; 
 Sun, 20 Sep 2026 11:14:07 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e6c37a88csm10088091a91.8.2026.09.20.11.14.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 11:14:06 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jay Zhou <jianjay.zhou@huawei.com>
Subject: [PATCH v2 13/33] crypto/virtio: update comment reference to
 rte_smp_rmb
Date: Sun, 20 Sep 2026 11:10:05 -0700
Message-ID: <20260920181347.747210-14-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260920181347.747210-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20260920181347.747210-1-stephen@networkplumber.org>
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

The rte_smp_rmb helper is no longer used.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/crypto/virtio/virtqueue.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/virtio/virtqueue.h b/drivers/crypto/virtio/virtqueue.h
index 97a3ace48c..23c001a8e6 100644
--- a/drivers/crypto/virtio/virtqueue.h
+++ b/drivers/crypto/virtio/virtqueue.h
@@ -302,7 +302,7 @@ virtqueue_nused(const struct virtqueue *vq)
 
 	if (vq->hw->weak_barriers) {
 	/**
-	 * x86 prefers to using rte_smp_rmb over rte_atomic_load_explicit as it
+	 * x86 prefers to using virtio_rmb over rte_atomic_load_explicit as it
 	 * reports a slightly better perf, which comes from the saved
 	 * branch by the compiler.
 	 * The if and else branches are identical with the smp and io
-- 
2.53.0

