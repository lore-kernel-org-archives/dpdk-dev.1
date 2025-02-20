Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B262C021B2
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 16:57:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0245940664;
	Thu, 20 Feb 2025 17:57:13 +0100 (CET)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mails.dpdk.org (Postfix) with ESMTP id BDD8940653
 for <dev@dpdk.org>; Thu, 20 Feb 2025 17:57:08 +0100 (CET)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-221206dbd7eso23451185ad.2
 for <dev@dpdk.org>; Thu, 20 Feb 2025 08:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1740070628;
 x=1740675428; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KDp+RYq3dZYAh5S+aCHpQ8W3bUtvbp6cTZZ1+kQdwug=;
 b=AKqUuthD59W9VDUpvNWDytbSd6pNF7nYq769p3jOe/AV939wr/SAAXTWtbmMPi78vw
 kdKPCijEKogD4LEuRuc+XJ0mx6nSGA+q2NB71or0lM87tCqWKMhsZ/8NmMuSWv3wJtXe
 HNNZ3R+ZGPOgXBH1CUVKvBzyC8aQM3A8++YGYZspCu6LHbpZp5L805Cgr8i6yTloGzhK
 oTjlByptQxyPPLZlnDpj7NGXwZbs5FAS77u/KFI172gFpuFyBLS8v16QmJ1uH4X/60jD
 CtA47+DbMItEgiIlc02QXnaTcp8L/Rg4NDdDl6NCr0ajMlqluPat9xuKovNp3hcA5OFj
 Cbdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740070628; x=1740675428;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KDp+RYq3dZYAh5S+aCHpQ8W3bUtvbp6cTZZ1+kQdwug=;
 b=grV4NvvxhyLQqufqqgzVbCV5GB61lGlNxwif7jil8Hre9/xNLEnJdGUojaJmlWIzza
 zFRexA+S77FFORilbsZDWNrIO7RmwD6ALVLt0Ov+26P7YILiKqUh40V6t5UIf8ni9KbK
 wJveml9T9KP9IRohB1zXyzcckuuIiG0TQTzOLRNG/2WmN1lWDamDbTAwzVm3Gu6gaEFf
 +rBDFYXsLVHPMAtVCdyultsT5sSJ7Qu6AbRBFGh+66XSTQvvE/vvAm6Hbn6nxFnkAe3z
 Za+2UGEBySFZ4FpY8yTuJO46nfpRD1p+kPlfCdbg6uklGncj03J60g0LOKLDd8SOAxRq
 N4vw==
X-Gm-Message-State: AOJu0YyHAr7b0JncSERKHobrGbz9u3MuyrXibob0AqA2szAbN/6+693s
 3mMBVWohzs413S/+C68qcxyvr7ymv7D6aOXLlyandhCdftUfK5PshQBOf+Xf6tV3RxYHpRllehS
 b
X-Gm-Gg: ASbGnct/jZw8C3oW7r3vfDa8KM7NwMjn/MaQUX1KvJfs3Vrj9a6lws6Xqe8zaA7asEF
 Pg8UteQL8W7xuCJ5O5Xq6nxwG2sFYqCXzHNpCAZdSE0cGjO5scog1f5V2gRYTRkyfofFYGSm6BR
 PteqjpuQ4YbjKTy0gsKW/GG888gyMJfYxORc+3ZbCv6lZguML6+/D3/hT0oOdLorApw7OyQ+HB8
 yxD17l2PLBKRpFnHzteKaFtfub3xTJC9WmeXKFeBn6YeFpmmdAmTX+DVroTRh1WWo5GEUL2m2J+
 49HJ9czTkSOp7Fs9p7/zdudEbFbaObtN48HXtjlR8VoJXXsOgz7kTUmF+X41M+VvLAzY
X-Google-Smtp-Source: AGHT+IGh4RdEtbOrAxo93MG0i2voMnOp9JBTJVl1pjKgXbGqKPmokDiiSk5JBM633D2E0FwyHVOllg==
X-Received: by 2002:a17:902:eccc:b0:220:e63c:5b08 with SMTP id
 d9443c01a7336-22170561beamr132528665ad.11.1740070627988; 
 Thu, 20 Feb 2025 08:57:07 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d53491b3sm122729435ad.40.2025.02.20.08.57.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 08:57:07 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Jakub Grajciar <jgrajcia@cisco.com>
Subject: [PATCH v3 06/14] net/memif: remove unnecessary deref of function
 pointers
Date: Thu, 20 Feb 2025 08:55:20 -0800
Message-ID: <20250220165644.16421-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250220165644.16421-1-stephen@networkplumber.org>
References: <20250217185743.169778-1-stephen@networkplumber.org>
 <20250220165644.16421-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Since queue release functions are local to driver, prefer those
over dereferencing the dev_ops table.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Morten Brørup <mb@smartsharesystems.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/memif/rte_eth_memif.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/memif/rte_eth_memif.c b/drivers/net/memif/rte_eth_memif.c
index c0bf1e3bbf..f7b04c4f9e 100644
--- a/drivers/net/memif/rte_eth_memif.c
+++ b/drivers/net/memif/rte_eth_memif.c
@@ -70,6 +70,8 @@ static const struct rte_eth_link pmd_link = {
 
 static int memif_region_init_zc(const struct rte_memseg_list *msl,
 				const struct rte_memseg *ms, void *arg);
+static void memif_rx_queue_release(struct rte_eth_dev *dev, uint16_t qid);
+static void memif_tx_queue_release(struct rte_eth_dev *dev, uint16_t qid);
 
 const char *
 memif_version(void)
@@ -1418,9 +1420,9 @@ memif_dev_close(struct rte_eth_dev *dev)
 		memif_msg_enq_disconnect(pmd->cc, "Device closed", 0);
 
 		for (i = 0; i < dev->data->nb_rx_queues; i++)
-			(*dev->dev_ops->rx_queue_release)(dev, i);
+			memif_rx_queue_release(dev, i);
 		for (i = 0; i < dev->data->nb_tx_queues; i++)
-			(*dev->dev_ops->tx_queue_release)(dev, i);
+			memif_tx_queue_release(dev, i);
 
 		memif_socket_remove_device(dev);
 	}
-- 
2.47.2

