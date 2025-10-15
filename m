Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66FECCD193
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 22:11:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DCCF140F1A;
	Thu, 16 Oct 2025 00:10:51 +0200 (CEST)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com
 [209.85.222.179])
 by mails.dpdk.org (Postfix) with ESMTP id 9D300410D2
 for <dev@dpdk.org>; Thu, 16 Oct 2025 00:10:50 +0200 (CEST)
Received: by mail-qk1-f179.google.com with SMTP id
 af79cd13be357-88e4704a626so11597585a.0
 for <dev@dpdk.org>; Wed, 15 Oct 2025 15:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1760566250;
 x=1761171050; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=027Gxg4QCSPwyUYlGT84VbJX4PBXsTSH42jc6FG7Y6M=;
 b=LBEe3nUAEGLeGpVoh4NO4klpwd9oUQXv+iH9kGaI/ugNGhLdpSO0TI9lg8qfEGIXSH
 SFjeTo3BTL+Jv82H0Kr6XgYPsnfg0Hv5NVwh0jMogJ+ztOoyPd/nfyo55Y6i3Imft1kW
 Zk/bu/p5zcnYznGksM/SfTuT8qDkMAFEmxehgjuBaPx7GAqGqlose4KYHRWNhlRJY2Aq
 SW0S8Xy55aS0Z0+2PeGXvjk3SgpQ92/alq+MhmFFEA5qVUq6CCgjeWcKrT/Py1L65xFJ
 039NWn91T9KtJ10Vex0qXbQXXx3xWfY2ZVUbWR70CZtVcQILbxvHseLAZdFooObTTjwm
 nYlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760566250; x=1761171050;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=027Gxg4QCSPwyUYlGT84VbJX4PBXsTSH42jc6FG7Y6M=;
 b=oQYmC7B3qL+yFWw2adL91DpFKpGwx/nvGzb4WYYqaZxROV+0g2D8s5m/M903nfHQ0v
 NeepRlM0oRNZAynPOuNz+pGSTHbEpbh8erZXdwtE81PALR/28SF6WA2Cg1ynlZHlTJJn
 QeOeLEQNuAmQVvFGed7e6Mf5wMW5IcyvL1Hpz3K0GghnCYe+q4micMn30HPXEhMO3Osk
 ETLDwIz5b04LaYUSnPqunGeliuuFCUyaZApmoSXtsDI0kZ9s/fgjMI/THlZAZ0Ncr0Jy
 w50kqd0urez3zuJtPmKWmA8woivtwuqVTydKpZbTrgpWMflnl5OA6F5627T/eejl+vAX
 gPKg==
X-Gm-Message-State: AOJu0YzkV0kOT7XgSdXdOWEbDvNKJ3EXwV6OD1GBTqT9hYfNdUqBtxZd
 NNK2ssIgw5mDjk+prBHGmOcemWWdriysUkNC2FxTbkfyPZrudzsijaT+V45zojX3dfc=
X-Gm-Gg: ASbGncvzzINEioU06IlfuZv+W8LNRVlQgv5JX0g5WZaQY6KrVSneO2G8kTrrn3XueZY
 /rRmqKulevXGmcHu3ZAG6tEnb4nx13laSzsfYiAE26zeE5UXHplJVytQSVWscicR6lfmp5gtA8R
 zLUzmCRqtDv/RnEa6jhC6t5sjO+Jld/KIiIoetgFFAPAgr4sEgza7QTP5qDzkElhV9wacTyr1GM
 0ddi8yXa2LaG5Q0DoGSRMhtzNCvsQzpKshIAJGE8rcAH0T/YEqnrGqi1fA5C9W4deayTm0Jnuq9
 l0WHtnY4/uYZ2ED8yYPky9FTfOmbvMf8C3i9b1sf4A0nJEjXXOR6BXoeJqSDD+I7NGC6U+hk1+Z
 rE9e1tpz+0IiAWbc9kLJMUNL9v6Q/rTA6NqDacOIo0eXuIlA87l2gy8dzXKP1+prVT8+NfQJD8G
 Wc7KEwDiIQvpibB/nZxaFw5NLydHpMlxRn9GvRbFWh5Ucnc7e7SfwCU8i/tqzbeYk=
X-Google-Smtp-Source: AGHT+IFMb+e6/YwkkTrfCSLMuxvGr/a8T0Flnv3vMDBd13fpxL/do186mtIxB3ZbdDZb69P195sK/Q==
X-Received: by 2002:a05:622a:5c17:b0:4e5:6d3e:d769 with SMTP id
 d75a77b69052e-4e6eacbbf38mr403112411cf.7.1760566249878; 
 Wed, 15 Oct 2025 15:10:49 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4e881c577e6sm27732021cf.7.2025.10.15.15.10.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 15:10:49 -0700 (PDT)
Date: Wed, 15 Oct 2025 14:36:28 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: vanshika.shukla@nxp.com
Cc: dev@dpdk.org, Gagandeep Singh <g.singh@nxp.com>, Sachin Saxena
 <sachin.saxena@nxp.com>, Apeksha Gupta <apeksha.gupta@nxp.com>
Subject: Re: [v1 02/12] net/enetc: Add RX and TX queue APIs for ENETC4 PMD
Message-ID: <20251015143628.36799601@hermes.local>
In-Reply-To: <20251009111633.3585957-3-vanshika.shukla@nxp.com>
References: <20251009111633.3585957-1-vanshika.shukla@nxp.com>
 <20251009111633.3585957-3-vanshika.shukla@nxp.com>
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

On Thu,  9 Oct 2025 16:46:23 +0530
vanshika.shukla@nxp.com wrote:

> +int
> +enetc4_tx_queue_setup(struct rte_eth_dev *dev,
> +		     uint16_t queue_idx,
> +		     uint16_t nb_desc,
> +		     unsigned int socket_id __rte_unused,
> +		     const struct rte_eth_txconf *tx_conf)
> +{
> +	int err = 0;

Unnecessary initialization. Don't see where err is used except
after malloc failure (goto fail).

Better to not initialize if not needed so compiler can generate
warnings.

