Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FEC7E8FDA7
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Dec 2025 17:09:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3B867402C0;
	Fri, 26 Dec 2025 18:09:20 +0100 (CET)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42]) by mails.dpdk.org (Postfix) with ESMTP id AEE2E40262
 for <dev@dpdk.org>; Fri, 26 Dec 2025 18:09:18 +0100 (CET)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-47a80d4a065so37254395e9.2
 for <dev@dpdk.org>; Fri, 26 Dec 2025 09:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766768958;
 x=1767373758; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dNgfCaCmjh3rjvtldXL5H6gclEkKTt83rFaFNyCikhs=;
 b=CJTKKMT54u1UGBhdJX3UHn3PhpOHuVDhe4yjdAR7kuojEay+0Xi4lbiexFxY4GskeC
 R/BO+0nhiiqhheGu5MMqO/FDLwpLULKUOsmdaA0gDyb2BwmRpUDcRLcLk/BDHndabSEh
 5AqtfKRqgrPFxN+91wuSE5z3zOgZvxkilXe8veEcYK3qPa22KF/1v0+rLFusm2ukaKx0
 FqzWGq2SqtoZ6gIu52Hd7hrHaGN5tvm6I1HXMYgVSLmmsuRJzMIdhoMCLVT/NYbPtg+t
 sx5uDYmc5zaKPpwmPkUrZrQ3vn9M8ln+LfFS/bMasZpC9DICXhBvpqsrZua96YTE49nA
 dIuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766768958; x=1767373758;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dNgfCaCmjh3rjvtldXL5H6gclEkKTt83rFaFNyCikhs=;
 b=DpMMl5Pjsd28u3E51Fhzzfa2g4dMUjx4MNyd3onm1vyysfwK02sd+joNwyb5vO/+Uo
 CIRLiNE/Rdpg2IHiFcm9H0LwBhTgoE52kHCGcUhJrCYO3Ue4HmWnDqOPOU+EOPSsTOmI
 sBtv0x6I+Ms11c+RI8xw3EvJJyb0gjIFNoG53YPquV6Hy2ysS4OjGFiSyeUh3CuzBm5c
 2t63yGgBbJbODsFiIWbvSlVH2OkHMwDg3ufVIEujbj+aSi7OA5Edz6NdjYnruWQ4tKWO
 S57HBFrvLJu96fVfMYzrJDnylz19c8WkeHhwCw2Qh5irwINpjEu/2jG3FDqfkKSIcQLs
 sm2Q==
X-Gm-Message-State: AOJu0YwOKhYKs/vL18lG5VnZXpxFQscUX9+NIz1wj+lojLIdrq8jJk0L
 qS+IufCPmuCvNGnlW8Vu6WNGnUaRPLeTdsl7cA9xaDq+tPqcXaxDofjA5JC6OaXtEbKzJ5nbXFM
 7pnxTwNo=
X-Gm-Gg: AY/fxX6dV2jORLG9PtF9Bp0+kcxOf9B6XkmLRpHbvn39ID27V1tM0RmcwVwSIGWP/YA
 4rsOAY1UPADeHsSCrxLFbdHG7s2wEcWUCCTyJwt2o2QZ098KxbZvtS1/55Pq0RJkxccrLarSAzd
 oMyiDIVJL7zrXMcFYenD75ewrwWimfZLaVHiCBtadLIYquAXVnexo3WZ+NHV9pvvnymNn+slBJt
 tnXdMds8lhaaF/NERo7iWeTnxc9BDH+Gv9ZuDpuoRZT7/nxsTiSIN8CGggeDgoEjvbvuWParL0d
 hNaSra0+sw2fGGaZPUyrpJ8hZ7SSWvxLIaI4TGrrxNZ9RnsLV5IZxd0cCruv3FeD8xCmQDIz9H5
 GCVU+jnYKbm2snQKRcYhSvYUf4s2r/fqJ7ObYePzVF5tOCJN2xMACVcMehwTs+M9v+JX1GRqydE
 stNoR90t38/OpcxqVzHKnX+1PllJ8kRwFXjuCdFwtz7Pku558qEd3Y
X-Google-Smtp-Source: AGHT+IExWcsPf02ldw1Fk9B8wf8dHE3gk3ckTMTu55gJl95+ub7dOiR7kesNaPNu5EnJGdOQrRMizw==
X-Received: by 2002:a05:600c:1d1d:b0:477:632a:fd67 with SMTP id
 5b1f17b1804b1-47d19546487mr255498325e9.12.1766768957878; 
 Fri, 26 Dec 2025 09:09:17 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d193d5372sm417091505e9.14.2025.12.26.09.09.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Dec 2025 09:09:17 -0800 (PST)
Date: Fri, 26 Dec 2025 09:09:11 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Liangxing Wang <wangliangxing@hygon.cn>
Cc: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH] examples/l3fwd: extend NUMA nodes limit beyond 8
Message-ID: <20251226090911.375c630c@phoenix.local>
In-Reply-To: <20251226081719.1120313-1-wangliangxing@hygon.cn>
References: <20251226081719.1120313-1-wangliangxing@hygon.cn>
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

On Fri, 26 Dec 2025 08:17:19 +0000
Liangxing Wang <wangliangxing@hygon.cn> wrote:

> For platforms with more than 8 NUMA nodes, the l3fwd example fails when
> using cores on NUMA node 8 or above.
> 
> Use RTE_MAX_NUMA_NODES instead of 8 to extend NUMA nodes limit.
> 
> Cc: stable@dpdk.org
> 
> Signed-off-by: Liangxing Wang <wangliangxing@hygon.cn>


Acked-by: Stephen Hemminger <stephen@networkplumber.org>
