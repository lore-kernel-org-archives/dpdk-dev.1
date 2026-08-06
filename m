Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D303C56208
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 16:21:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 788484027E;
	Thu,  6 Aug 2026 18:21:40 +0200 (CEST)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43]) by mails.dpdk.org (Postfix) with ESMTP id B162340262
 for <dev@dpdk.org>; Thu,  6 Aug 2026 18:21:38 +0200 (CEST)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-38125cebfdaso2902098a91.1
 for <dev@dpdk.org>; Thu, 06 Aug 2026 09:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786033297;
 x=1786638097; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HJ+6u8p7raeH8j3LM4f5/FSvtiTMA6PxumCAGy57jY4=;
 b=HsBNssvRXHp+8R9PEHw4tNqmHyRSd9I3UsJ5DYSElyWLR1BpeDPDqeoqXmzC3upt3u
 BeLvnajmlN0DiSfhdXCfgRw+3Y4+RHlcCEl+j4AK05giCzVvK359a9c3D9k8u6CbjSql
 N0JDbJeqNAnyT8qk5gOWZj9Lp6+QCREcm0j9qBsqsXNtdIN5EW+KNcuSpOSRK0bJjpTv
 8PDjqdX5T9ydHw9w6ChQY8QsNVfvu3XcGIT0OYraoYRal+h+B2iGrcMGiNAJFYXguynB
 YS6OSs6zckAuRZbP4BpIuSHXPn2TkMZN1VVLYC1SAK4kvncISliqRypwxpQ5VKxiCLRX
 Uldg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786033297; x=1786638097;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HJ+6u8p7raeH8j3LM4f5/FSvtiTMA6PxumCAGy57jY4=;
 b=aH3PXkOmoc+IiiKTzWKthsyNrRM3Gjbm6zbiRp6gkv4aUEYTL+3JenKyzMt/wpIzDN
 P7N3SkVmpVq2G1sxlljEkW25vMRd+9VKFWic4nTa4OmfjEQke4Y98ww4jCFGbFdUP51s
 FWlOhY4gCOo7xw1MJ4vMNPypXtN/tM+qYK1Z+MmdxLGs4mxsl+oyDUPjCqZdtZfPWjy8
 NEEtXWaD6uVQHsoDvvXhSpOFEuUZC93fnDL7YMNX81+MV68FDPktntQ/g5NktL1XRPVT
 vtCfjij+JUqSiF5oNBCrWZdUXPdV2EI+jeEOyl7OTxFgIYJVcoShE/pyLX1AQSoCVm4g
 y/2A==
X-Gm-Message-State: AOJu0YzSUudYbEC7tj0Wm8CDUx4J0Y1dWha9IABsdXed9Qo3mbo5Zk3P
 q+sczfp39O/MRIIwShVcfbdhsPt8n0eT8YIw85jlTPQt96B0Nqg6ueF3cP4sFyZplvM=
X-Gm-Gg: AR+sD13TtjtnUSVVATK9hwkupmtPEjrNxEZ3OTJ/5ZqsOumB57OQPfBepmqlfnsJ1s3
 gDZ0uqEA1d4bTkTNHjLBX65FpIce+ixDfO1BlKd3zevvd5T6jt70wos5ZvK1s7n1RIbszedpDzd
 PuAhf9S2qmeQQ9HN5DUmmonvbxV2ca+yLRoJ91VXE8TTocJegiojLT0cxnkyxoPkoFsau3cp88I
 OemgSFF7d0Ve+hhKHjX/u7hKsltzi4YjVpYcivyHmjCVwfEDH4FGi+7VMij1CSxMotOr5aehgVd
 zJtzTR/TUa5OGIBlmD0V7gqHdU9WOAe+VeFrw9dlAK/BViNogjsJo9JeweAh2UukYijq+qxfolT
 H0Up0Ji85SkGzXNPEYnyeRpLj1klJrtqBH9U9v1vGSELQxgAg7C6So5CoGkx701MLmk7tUyicbf
 uC2rpYAtxcGpDnPhUvvlOQgT+sWiL7wTKUm8DiOHuhB/oHBywsXVnXK/bqVn2bPua1rEIJdHeg5
 a4voYHSjDD2LDbbKEIoduRLAG9f0g==
X-Received: by 2002:a17:90b:5111:b0:38e:64b0:8bce with SMTP id
 98e67ed59e1d1-3903c633720mr17849226a91.20.1786033297534; 
 Thu, 06 Aug 2026 09:21:37 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13fca508a48sm23617804c88.1.2026.08.06.09.21.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 09:21:36 -0700 (PDT)
Date: Thu, 6 Aug 2026 09:21:32 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Gagandeep Singh <g.singh@nxp.com>
Cc: dev@dpdk.org, Prashant Gupta <prashant.gupta_3@nxp.com>,
 hemant.agrawal@nxp.com
Subject: Re: [PATCH 4/4] dma/imx_edma5: add statistics and dump
Message-ID: <20260806092132.59cfd375@phoenix.local>
In-Reply-To: <20260806084245.561305-5-g.singh@nxp.com>
References: <20260806084245.561305-1-g.singh@nxp.com>
 <20260806084245.561305-5-g.singh@nxp.com>
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

On Thu,  6 Aug 2026 14:12:45 +0530
Gagandeep Singh <g.singh@nxp.com> wrote:

> +	(void)fprintf(f, "  imx_edma5 nb_channels=%u nb_vchans=%u\n",
> +		      ed->nb_channels, ed->nb_vchans);

Please don't use this style with extra (void) casts.
