Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2696FC0219B
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Feb 2025 16:24:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 96DD84068E;
	Tue, 11 Feb 2025 17:24:45 +0100 (CET)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44]) by mails.dpdk.org (Postfix) with ESMTP id 18BB64067B
 for <dev@dpdk.org>; Tue, 11 Feb 2025 17:24:44 +0100 (CET)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-2f833af7a09so7985826a91.2
 for <dev@dpdk.org>; Tue, 11 Feb 2025 08:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739291083;
 x=1739895883; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/6XdsBQI9ebPlCcRQaWwMRaLMbllYGPaIMdXRDsBKQA=;
 b=Io4Q/juyuPG+b6fxsd8HVrOim33q3Mn9Xe+dsi2te3pJ+NmIkPqRnzgOfMDrt/PUh7
 6nsW1US+IXZIxK2TQuED60U30qCzVp76VuL7EqJ1++b1xCeicapjveMz+K1VONXVl1A5
 hkQ6eb6SsWx1psYbtM8koFOWNNzjTu4rMLd9kcDZbTAKqXf+s6MZ/HJkpCvAvqZsMS5q
 EigeKD9kP1sLext0r3PJyvcnbiYIaYFw1LRdOnZufwWOsmoeD09k1g/bzbhg82OB5lIK
 tyqsd2M1CVCy0xH8KuGWR0feZRujlSHqxsVOM+0n6AglICC7QeHNvM9VtED7yC54/Jxe
 SR7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739291083; x=1739895883;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/6XdsBQI9ebPlCcRQaWwMRaLMbllYGPaIMdXRDsBKQA=;
 b=ItajXFTbbW/ip160VgFGp0P4++JktDQtfuycsesWoUv83DIbqcuOgEkSirYY465NKB
 Lo58FDK/8KiONuSo4NbJjA03uePz2phqCKAa0iiEvy9v32AJNfOt4b2LTUNMIkYOlMZY
 33JjM42HDwVF/Ra8QAUn1FjzCvcpb4IqTJq+ZtYRz14d0gED5Cs0Bgz0TWChBinocuhA
 E+OrrsVaqKOxRkMQ1Ap3FHDRAdluu+zkksRiZbLULo1gLDGLAKd90Vq5Is+aQ59oZKsZ
 SP0QRtb6LdKJBHNLEQpgvR9ktkPG5RvVmBC/V0CbGJaJ1Nd4niAZRDJEienWgAiDPt/K
 a1bQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWenF5qJs/disFO/4A1lud1VFto1vOEIDRB+mrLipDABigufZjUdTJszg6YjeEVrui+qEo=@dpdk.org
X-Gm-Message-State: AOJu0YzTwJzMpeVqJlE7Fmd01NryzB2pJE0hcnfnTjBjp8ugYOkIC26v
 I6niAaOgHMGyrLucWyC7ZuC4+GfFlt1NDQLrgUo5ScctGNvMZ4E2V+k9pmnJ79g=
X-Gm-Gg: ASbGncu6OBU0Mj1L44cgK3GtLbW3h6DCRmryo9VVhbvI5NR7YgwPjAjy51kwN7WEDXe
 OCCP+qkT++a9khAWB2qt3OROndCzfxDdaiRIvqbZcCBfmf2a8g2OaLM0k4Rr6p/sJlJuzA18rJn
 KFauBUXD3CJ527InE+AgkO3nbSQe3dYTAFWiwoJrR0k8jj+FFWyIHu968Yv3Esf4EDOLUVaukjA
 yc4UvavmfI2V6Qxbq3dhTYfFuqlSrVOf7tBAv6qgCA3V97zorgNWKpwn9MxoqykWhnk7JVfc3Lc
 OKSiWNA2P2tU+FnRor0rVk55Du3ykbeBI8eo35S5nJKS4V++pqTAj0rNhB8VQwyDZJJv
X-Google-Smtp-Source: AGHT+IEhfx+t2AsQKov1NXJ2R/Krr2lXhu3XGCtqymOCBTjkZ1ZBT1N6Rp/NKIEBID8mi8r9sgf6Pg==
X-Received: by 2002:a17:90b:5186:b0:2ee:c9d8:d01a with SMTP id
 98e67ed59e1d1-2fb63d1acb7mr550837a91.11.1739291083278; 
 Tue, 11 Feb 2025 08:24:43 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fa2d831a1csm8617326a91.44.2025.02.11.08.24.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 08:24:42 -0800 (PST)
Date: Tue, 11 Feb 2025 08:03:19 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Wenbo Cao <caowenbo@mucse.com>
Cc: thomas@monjalon.net, dev@dpdk.org, ferruh.yigit@amd.com,
 andrew.rybchenko@oktetlabs.ru, yaojun@mucse.com
Subject: Re: [PATCH v9 08/28] net/rnp: add queue setup and release operations
Message-ID: <20250211080319.3fa6c266@hermes.local>
In-Reply-To: <1739263818-59770-9-git-send-email-caowenbo@mucse.com>
References: <1739263818-59770-1-git-send-email-caowenbo@mucse.com>
 <1739263818-59770-9-git-send-email-caowenbo@mucse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Tue, 11 Feb 2025 16:49:58 +0800
Wenbo Cao <caowenbo@mucse.com> wrote:

> +static void rnp_rx_queue_release(void *_rxq)
> +{
> +	struct rnp_rx_queue *rxq = (struct rnp_rx_queue *)_rxq;
> +
> +	PMD_INIT_FUNC_TRACE();
> +
> +	if (rxq) {
> +		rnp_rx_queue_release_mbuf(rxq);
> +		if (rxq->rz)
> +			rte_memzone_free(rxq->rz);
> +		if (rxq->sw_ring)
> +			rte_free(rxq->sw_ring);
> +		rte_free(rxq);
> +	}
> +}
> +

Null checks before free are unnecessary. The coccinelle script null_free
will generate this:

diff --git a/drivers/net/rnp/rnp_rxtx.c b/drivers/net/rnp/rnp_rxtx.c
index 9459b5b93d..990f0c5dfb 100644
--- a/drivers/net/rnp/rnp_rxtx.c
+++ b/drivers/net/rnp/rnp_rxtx.c
@@ -56,10 +56,8 @@ static void rnp_rx_queue_release(void *_rxq)
 
        if (rxq) {
                rnp_rx_queue_release_mbuf(rxq);
-               if (rxq->rz)
-                       rte_memzone_free(rxq->rz);
-               if (rxq->sw_ring)
-                       rte_free(rxq->sw_ring);
+               rte_memzone_free(rxq->rz);
+               rte_free(rxq->sw_ring);
                rte_free(rxq);
        }
 }
@@ -279,8 +277,7 @@ int rnp_rx_queue_setup(struct rte_eth_dev *eth_dev,
 
        return 0;
 rxbd_setup_failed:
-       if (rxq->rz)
-               rte_memzone_free(rxq->rz);
+       rte_memzone_free(rxq->rz);
 fail:
        rte_free(rxq);
 
@@ -312,10 +309,8 @@ static void rnp_tx_queue_release(void *_txq)
        if (txq) {
                rnp_tx_queue_release_mbuf(txq);
 
-               if (txq->rz)
-                       rte_memzone_free(txq->rz);
-               if (txq->sw_ring)
-                       rte_free(txq->sw_ring);
+               rte_memzone_free(txq->rz);
+               rte_free(txq->sw_ring);
                rte_free(txq);
        }
 }
~
~
