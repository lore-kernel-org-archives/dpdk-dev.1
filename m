Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E8BCA0FED
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 Aug 2025 16:27:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D5DAF4029E;
	Wed, 27 Aug 2025 18:27:39 +0200 (CEST)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49]) by mails.dpdk.org (Postfix) with ESMTP id 886E040292
 for <dev@dpdk.org>; Wed, 27 Aug 2025 18:27:39 +0200 (CEST)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-3c7aa4ce85dso2407406f8f.3
 for <dev@dpdk.org>; Wed, 27 Aug 2025 09:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756312059;
 x=1756916859; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dIIHOYjoxkKKmjuWxyXZE3u1jUUiLiRzRLwJEu57/gM=;
 b=KRBdl6BNWDSHlnFwWGS20uQATy3ieqp7JyW56L+HRd1x1xY9cs4Z9vqFa5dvCo50bF
 M/7jawcLfGVzHsRnJ8Kau/7IWzSDJhoWNz+Z1IkPULzv4Txkt94SOG5uxvHtbSXUjCmx
 k7AUhKjz18MAtoNmp27yuca46Hy/VaIjNXqxg/IgM0bx533J4Qgr+EPUzrQekA+/qOr2
 eiC0pGxrAbn7V7irCQV1sOcSrGHQkkOa3v3DrV474c6jt16lSCSJBohJYmK7Gz6tAvH/
 lA1pVEoHlLNoMBxwE1KbKbUpUT8S6zpF8PPg74RpFou0nFNMW0CeLTius2tUWJUFhCAU
 kPOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756312059; x=1756916859;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dIIHOYjoxkKKmjuWxyXZE3u1jUUiLiRzRLwJEu57/gM=;
 b=T1UtwBgg9AaBDScLCEL95s1320b5aWedvcMxdbqyV3XSbuzvRo8aKyQrbt+Zl5nSII
 OEy13k8KitDaYjZ4c0vNrJH9pdVhpaLHK4Bz3fbtdQB1x+jyJ0uEOAcHys6NknWWU9uI
 9C/r8BHgbI/VTavZB8EQWkkGwH9QODeINQ0F/UGTBmcHaQzIVDOOs06tCJLindvT/g6p
 aLP6WlUWehga8L67ps5uHNu3nRnpbu06oy6PFJ53Zd2m8KUTl+0q8f1Q/y0j/8NFpK40
 l6BObYPLx7YMvQ17CQWBYRptfD6x2xMEOBNQpdYDxfQu7UJ2w8ObGOwnn7bqSxgJxdVQ
 XVqA==
X-Gm-Message-State: AOJu0YxUBwsslLttOssvIitX3sXurL82cvAsB5FBz+B7r2BRoYa0+r0V
 eFLSsqAGoKtItVKx46z8ws570QeEvKjFAZ68+sVpjcSXXsbRh/Xi5FOMQ06GEk/GbeU=
X-Gm-Gg: ASbGncs+XWDPvbplCbKEKXqF1zTHtUACPrsVaiBtiMaect56YeNA+l/CkzSXKUjymnH
 lYRylrHUW88RDbzbVsFlxGo0bc1fjOahtsaSzDAARzISTSRTgkzRnAKkU2t97TPc7EAXiPtUzbN
 LgYaVetwgrUOHd6n3x9LSpmcD+7P9hIJ7LDhsY4S9INAzSY1NR+uexPmftKRMQS3xWvOzf3xXYQ
 6yWH8E+9lmK4BArD1aeXNr1nMfGezVwP318nxnLjLT295LoZsmMZkC5PqB/zrH4d+q74jkaxgNf
 8Z24v/simjfCl/YObB3IuceNMPz0o08s0xHyga2hvTtgu/h9U1iGk5/o1Rcx5scN6gYEsqEX8dN
 GHB/fojMt1T4TDqfYKOd7+pjCXYeO9mpPT7ZGl4iG/K/gjdOci5q3OXiFVhAdFCA+H5Fi32UKTS
 Y=
X-Google-Smtp-Source: AGHT+IGJIw7xc3GT1LGTAUqHNqs1KEa8umtCVAjjJ3yhChmrsmbX+atendMEac9N7ZpfMqdtLbNVCg==
X-Received: by 2002:a05:6000:2403:b0:3c9:1433:f8c0 with SMTP id
 ffacd0b85a97d-3c91433ff3fmr9562763f8f.7.1756312058976; 
 Wed, 27 Aug 2025 09:27:38 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c70e4b9e1fsm23159934f8f.14.2025.08.27.09.27.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 09:27:38 -0700 (PDT)
Date: Wed, 27 Aug 2025 09:27:34 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dimon Zhao <dimon.zhao@nebula-matrix.com>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, Kyo Liu
 <kyo.liu@nebula-matrix.com>, Leon Yu <leon.yu@nebula-matrix.com>, Sam Chen
 <sam.chen@nebula-matrix.com>
Subject: Re: [PATCH v6 01/17] net/nbl: add doc and minimum nbl build framework
Message-ID: <20250827092734.03fb2729@hermes.local>
In-Reply-To: <20250822090359.614551-2-dimon.zhao@nebula-matrix.com>
References: <20250627014022.4019625-1-dimon.zhao@nebula-matrix.com>
 <20250822090359.614551-1-dimon.zhao@nebula-matrix.com>
 <20250822090359.614551-2-dimon.zhao@nebula-matrix.com>
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

This code looks like it was part of something bigger (and/or written
by a object oriented programmer).

Lots of indirection tables and most never have multiple implementations.
Function indirection is slower and risks SPECTRE type attacks.

> +struct nbl_product_core_ops {
> +	int (*hw_init)(void *p);
> +	void (*hw_remove)(void *p);
> +	int (*res_init)(void *p, struct rte_eth_dev *eth_dev);
> +	void (*res_remove)(void *p);
> +	int (*chan_init)(void *p);
> +	void (*chan_remove)(void *p);
> +};




> +struct nbl_product_dev_ops {
> +	int (*dev_init)(void *adapter);
> +	void (*dev_uninit)(void *adapter);
> +	int (*dev_start)(void *adapter);
> +	void (*dev_stop)(void *adapter);
> +};
> +
> +struct nbl_product_dispatch_ops {
> +	int (*dispatch_init)(void *mgt);
> +	int (*dispatch_uninit)(void *mgt);
> +};



> +struct nbl_product_dev_external_ops {
> +	int (*external_pf_ops_get)(struct rte_eth_dev *dev, void *arg);
> +	int (*external_rep_ops_get)(struct rte_eth_dev *dev, void *arg);
> +	int (*external_bond_ops_get)(struct rte_eth_dev *dev, void *arg);
> +};

These are defined but never used.


> +#endif

