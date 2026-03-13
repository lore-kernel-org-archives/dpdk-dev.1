Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 714FF107BCE4
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Mar 2026 21:00:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A0EF7402CC;
	Fri, 13 Mar 2026 22:00:49 +0100 (CET)
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177]) by mails.dpdk.org (Postfix) with ESMTP id CDAC6402BB
 for <dev@dpdk.org>; Fri, 13 Mar 2026 22:00:48 +0100 (CET)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-2bea03c64c1so1481291eec.0
 for <dev@dpdk.org>; Fri, 13 Mar 2026 14:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773435648;
 x=1774040448; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NyBWtP4iE6r+JxV8bq2DoS1Abo7ZLCQaa0k/GgwOdk8=;
 b=yPzq0Audu6ehNI3acuNcKZCnBO7vwrsBWRnCUoS2G8bFC+mUsXuDqol5hj5HiS8v/Y
 LZW2Kw/PLdP5+uDa0CEcGIs6h0ZMU/MmAlvTFG9SMzLJbMrvOVRdDxVgsHml+EeWAGdh
 Kql/ZcsDcimqtjmMqHUsqaHWjU2UibRb9r4sTrb66x4i+ueQXdmbXbJuQmJ/9ramMsh4
 wnoLAKokrGSFXSkfxxxJu6b1Y9jaGVR3RFpWYK2DzCW4/jUB4Z3vXqFfjZ6Dd5nrXQVs
 QorA9CRoTPV8OxeDBx6Tfc5+aBXHSsgXb02vT0+6BOfn4hWamjgbYfe0aBgWMfct57gI
 0/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773435648; x=1774040448;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NyBWtP4iE6r+JxV8bq2DoS1Abo7ZLCQaa0k/GgwOdk8=;
 b=p+rAnFjxDmQizmyaWsX1hPkbeCkAOG4hWiBuls4FS2bMy158KxKXX23OFCJV11APX+
 DiC/KBfb49m+RFxTlDm7qA+ovO2+oL+9LI+sbiI+usdKOUK/jnlCBEVgoiB9DD4vGz32
 Z8rZINDOaTKEU4AuOBS7dBbG19y93nZewFmcVk9dq2U9uFqSypO/QxPrAz/CGkNGRXAG
 wp9lwsddB04nDLN+Qggbplw3f61bHoU+cqejiV3NzKGYLvD01pTnAsGqxrYFlwxW3TvI
 WN7ugCPZUY+IR2pEUsSvG2qPl9KO+0Re1Lictl4q0sHkgwt2SF+tCjFbFPghBKsu7nal
 pYOQ==
X-Gm-Message-State: AOJu0Ywa8TTNbBO+A6W0IfJ11NRxT9/p0cgJ1CECBAZuZGoXxkfMDkqv
 07DH4n6UvmoyB18Vim9HO8pzuF9EUTp/SaFPOEUxReRdYoek2PrZIC4hLGKCIT0RPiw=
X-Gm-Gg: ATEYQzw6bw/QvilY/kqLvUYUeKI36YiFIS4pgrOkA4dJ6Dt8WkcGwIL/jZHmywsf9tm
 0n2xHoDezTVkIi0l2qeME6f/19s2MZPuIWFDyetIaKGJi2aPdGk75c7LXKyOm0jtBiEwlSjUc3w
 DwIyAMYqpJPSkEV6y2fVWGM3skMNK9oLr5UKZtpZ+KbRrMr+KvNjMmGZtkRt2fhSWw4jhxIg9zf
 NBgdTOzrFCgWB6hA4TxyCWjhlksgGaM7IvEri4rZgEbvBnUBqHihvfLoY8VO7trAxws+n0rx8lY
 D50cCrn9ku9/BTja1mcb5Q5FhUGBq205ansOylpc9MfNNN4pSH7sHjeIdNVArOdYYXUB/ga8DY3
 CCyc7Un+FE29rHcqZnf5oyV6PSH6VRbvBTYNTlO4MZQlRPObEj9Pc5vBmUzaIJZz/ezZB7HNTyH
 XPmx0Ct4J2TlyxJ0gRwWO9GgeguAm9XHsEXc8=
X-Received: by 2002:a05:7301:3f0a:b0:2be:1a8e:10bb with SMTP id
 5a478bee46e88-2bea54e71bcmr2035579eec.12.1773435647473; 
 Fri, 13 Mar 2026 14:00:47 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2beab5702e5sm4664662eec.29.2026.03.13.14.00.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 14:00:47 -0700 (PDT)
Date: Fri, 13 Mar 2026 14:00:44 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: KAVYA AV <kavyax.a.v@intel.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com, aman.deep.singh@intel.com,
 vladimir.medvedkin@intel.com, shaiq.wani@intel.com, stable@dpdk.org
Subject: Re: [PATCH] app/testpmd: fix DCB queue allocation for VMDq devices
Message-ID: <20260313140044.3ff14294@phoenix.local>
In-Reply-To: <20260313101553.1827216-1-kavyax.a.v@intel.com>
References: <20260313101553.1827216-1-kavyax.a.v@intel.com>
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

On Fri, 13 Mar 2026 10:15:53 +0000
KAVYA AV <kavyax.a.v@intel.com> wrote:

> diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
> index fbacee89ea..70be52d36f 100644
> --- a/app/test-pmd/testpmd.c
> +++ b/app/test-pmd/testpmd.c
> @@ -4444,9 +4444,11 @@ init_port_dcb_config(portid_t pid,
>  			if (rte_port->dev_info.vmdq_pool_base == 0) {
>  				nb_rxq = rte_port->dev_info.max_rx_queues;
>  				nb_txq = rte_port->dev_info.max_tx_queues;
> -			} else {
> -				nb_rxq = (queueid_t)num_tcs;
> -				nb_txq = (queueid_t)num_tcs;
> +			}
> +			/* Use device queue count to prevent null pointer errors */
> +			else {
> +				nb_rxq = rte_port->dev_info.nb_rx_queues;
> +				nb_txq = rte_port->dev_info.nb_tx_queues;
>  			}
>  		}
>  	}

Please don't break up  "} else {" with a comment.
The comment is associated with the next two lines anyway.
