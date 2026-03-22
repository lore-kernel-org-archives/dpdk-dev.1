Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFBFEF483C9
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Mar 2026 16:15:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D048340268;
	Mon, 23 Mar 2026 17:15:23 +0100 (CET)
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
 by mails.dpdk.org (Postfix) with ESMTP id 9EA1B4025F
 for <dev@dpdk.org>; Mon, 23 Mar 2026 17:15:21 +0100 (CET)
Received: by mail-dl1-f47.google.com with SMTP id
 a92af1059eb24-12a71ade78cso411647c88.0
 for <dev@dpdk.org>; Mon, 23 Mar 2026 09:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774282521;
 x=1774887321; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JPlAzj8ZsXF0I1FLQSLuqFcAg90M0Bw+jWeEvumT+d4=;
 b=DcUl3EQjTOApoGn2iVO4/SKxTWXymvmk3t+aSSH4xtccre5ZrH6BIPfLsxlfsktyaz
 0GOUqkiHtoiI6Uj9Ozxl8to/OUTkh+vHFWmmXQq5IzZ4ciTj9M7x9z9nrEN+NhFB0QgW
 HjjK9IyDc/U67v9LvNAax8Ngt1VNiKhyJx7EqynU2aJqQ6GRBvbvEtOCTjNZBhRzizP8
 zWZ+o42YetMAJEa2926lDMre+cmkMI65N9d6rpvVQMvyu71E/Hgb5+662Ia8rScksjAP
 UJ34APyLWzaVDP2Qd0tSQ+3B6mWsqe4MOEQbFiMAmHMuktaP0MhcXLYE6A2cF87S9UMq
 Hg7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774282521; x=1774887321;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JPlAzj8ZsXF0I1FLQSLuqFcAg90M0Bw+jWeEvumT+d4=;
 b=f49CuJuK/5BegGJeobQBkAvJPgDGEr7hFKg1w3ZvrV2zXVjGobOJaD/1zJ9Z9g7Y3F
 LLf5ZWb+dU1ckdSmCOs3oAjbFgBjg/AZiweWVzfCFIDt3mzM1yHmiOgCSen+kk1LkdQw
 5DNJKs+Q7Zuse/VdInKpxnFRCeeSrp07pJ0SmcqHr5lFHIBzy0kwuohk1QvS6Uc/yEuQ
 PeOQZrChU+lJkN9/RUAaHMNBeyoGPRpyfVcxDrUs7gkPXQiqch5bC4s7mHpR0X/Brgxu
 /B0ofVrXXVXbpk1KtyZp0/iGVizyCUZTfOdfKrThAFT6TjsjhEmOco65pdcCm7L9Sh01
 Q5yA==
X-Gm-Message-State: AOJu0YyBsIY0qms5b8l22wqx1GuFNH8eCxxZkSHAbmRjdWMilb6zniRM
 gtXtM9QD4c12E60OQigeykQVvA33HN+KT7ofm77AN7uSsyJPhPmr9zDIxyalO8Ra/eg=
X-Gm-Gg: ATEYQzzdq41hTYsvY+SuhQmLiLlmsJ3WRH36eWWDRd/6NS3gz2/x+RbeX2BR8wSQIPI
 HVX+RecV7k0E3PTAF7tkyrs7DEyuvxwCh6xJIMcCRfN8FpfMNK9AAdkydmYHfDVrfW/wxk9ucNN
 8hg0lfVJ+FeJFF7QPBxTeyV7kOlGmnPnCyEomLVpeoQ7aUCcQbV2J0Bqrlm+YEuN6o9zhERD5Fd
 E3RH2GDrjsTMNgpIr9nvNkj1DjMvZoTgnx+I7k0Qq8rHpsV+12GzBDJY8GMxjqpo6Cc/UGYvqPw
 GrKA/fsEpg4uPrvTHMDwU7/1KAQtPNOwGVJXmvZQ+kUSNEcOEV5BDXOqRdVjzLM0uOl4fYhPH3P
 XzmbRiZGb5MDRJSnSn49s7lfNTJdL8AMHnOIg2hTXZTgdZmhykM3cE73UQK9GYniX7IDVbnnI15
 Fa0q+XBhsBb9D25uYzRDcJdSEOAIbQ2F4ToVHo/rCopy5ijA==
X-Received: by 2002:a05:7022:2507:b0:123:3500:b688 with SMTP id
 a92af1059eb24-12a726dc4a9mr5079669c88.19.1774282520566; 
 Mon, 23 Mar 2026 09:15:20 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12a733dd8c0sm9382538c88.5.2026.03.23.09.15.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 09:15:19 -0700 (PDT)
Date: Sun, 22 Mar 2026 09:45:19 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: dev@dpdk.org, rjarry@redhat.com, nsaxena16@gmail.com,
 mb@smartsharesystems.com, adwivedi@marvell.com, jerinjacobk@gmail.com
Subject: Re: [RFC PATCH 4/4] fib6: add VRF functional and unit tests
Message-ID: <20260322094459.30bf7683@phoenix.local>
In-Reply-To: <20260322154215.3686528-5-vladimir.medvedkin@intel.com>
References: <20260322154215.3686528-1-vladimir.medvedkin@intel.com>
 <20260322154215.3686528-5-vladimir.medvedkin@intel.com>
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

On Sun, 22 Mar 2026 15:42:15 +0000
Vladimir Medvedkin <vladimir.medvedkin@intel.com> wrote:

>  
> +	/* Allocate VRF IDs array for lookups if using multiple VRFs */
> +	if (config.nb_vrfs > 1) {
> +		vrf_ids = rte_malloc(NULL, sizeof(uint16_t) * config.nb_lookup_ips, 0);


Since this won't be shared across processes, use regular malloc, not hugepages.

> +		if (vrf_ids == NULL) {
> +			printf("Can not alloc VRF IDs array\n");
> +			return -ENOMEM;
> +		}
> +		/* Generate random VRF IDs for each lookup */
> +		for (i = 0; i < config.nb_lookup_ips; i++)
> +			vrf_ids[i] = rte_rand() % config.nb_vrfs;
> +	

Use rte_rand_max here.
