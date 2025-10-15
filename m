Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E33A1CCD185
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 18:01:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2683C40A6D;
	Wed, 15 Oct 2025 20:01:18 +0200 (CEST)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com
 [209.85.222.169])
 by mails.dpdk.org (Postfix) with ESMTP id 986C640273
 for <dev@dpdk.org>; Wed, 15 Oct 2025 20:01:16 +0200 (CEST)
Received: by mail-qk1-f169.google.com with SMTP id
 af79cd13be357-816ac9f9507so176747985a.1
 for <dev@dpdk.org>; Wed, 15 Oct 2025 11:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1760551276;
 x=1761156076; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xQoOgN+zDYeNPF0jOtd6PP18yb/Wh0Wc9uLfbWrOHoU=;
 b=LsaJ6uj1/O003YqIJOcCOtyh3PFoQNGyFzdmnldQRzwxT8PNBzuObF5o2qyXqNZHmN
 vxz0ftg82dj+lMbBgSuAVsMWx5cTbt8pRqfsudfzmyBuegDe0OLA/eaNWLefRajOlWPF
 cR2oWLAVmDnQcHLAiQb+c5dWALkt2h5B+5woQWnVnbER5UmHgIFkXTW31QET2GM78SM5
 3oaM1RvNSmF+zxHGWJPw2J3y5v9UNx3orY/9E3vS7xB0hZBtFWipOv7tzcqa9MIXzi4Y
 0CejjQojz501iwcqmOFQtbk84gHH/AC0SMCosbbLEMBUPbB2B5tIfal6Nbgagv1zo1R0
 WxHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760551276; x=1761156076;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xQoOgN+zDYeNPF0jOtd6PP18yb/Wh0Wc9uLfbWrOHoU=;
 b=HeAsUWmmSYRCcCEQzSbEGbR/GpbdDHR/e08a6gwoUILL6oXS54x3En7WIWIcp8BIp5
 oYScpu5fXojm0CyhCmGR6Vf9ORelQUDuGQYjzYFYtA+i5UZqXBK4mvaL1eGtqnh45PC2
 63KouyzHzl53zCIdsyP1rzyv4GZo6Ii0jE64ZOeK5JIgJEdYNd+8S8xeTc0pJ/AWNFtC
 /N2c4zzmBMLZ69NHGf/3Y/ayhaMZ/HlJ1ZDEzy8X1AmPDvzkwzFadhu4WpzeXoxUIvNv
 SsV460uvM96ra806DsxrL0Jf/FTgzzjY6f+jmKpKrdr2yzL7pEWKPOgCuVJRkfz87LCx
 llIw==
X-Gm-Message-State: AOJu0Yxt3pnLMMe87+kvUkd833yZrLachtpjL65NPk1A9i+1BKa9AnV5
 IESCLdRtv61qETZfiPrBn+50ts/kDbAMdzL1rZQL4Mprjo3a63YNU3IpnaerU03FvEo=
X-Gm-Gg: ASbGncugBcoPNI3m5VaWhPR5ycLnxXGfsgynap6jIzWU5Jvh8vNreU9+txr6+UjGdAb
 Bw8zyrx+EWCQ3gC3OiQnBsWCjfpI/D81D0B9BnySNCc8jAXC9HTF0vCR7ytrVEjVPJcKusTcr+4
 Z5ruIEZ5/v/qctz7u2dI57Kip/u2+D9yKALavIR/Ce/7B3kiiZd9xWA9BOij3kNi9CT2I8mxN+B
 4evmVIsHl6R010A1Q8KA8Vw7sSCoUa1BSXSBIuUai2M+IUeeezvLcmxTc3eXDh+Ybb3TnHjCdjc
 Zr7zaQrdfUXSOtJ8shb2WprbscHpkgJ1TD90LhnxLQFNng9jWhkm7jjHD0aHxnRsREPaiFbYxIK
 6g4Q4CPcen5Yl0MtA+BfhHa2EQRH0aF8+5NFRmECujjXIogk/jM3bhLB77dTPpojstXIZj241LG
 TI1VeUFUtZxp95pc40kgPTK5t+EwHKduE5/cKm+yE=
X-Google-Smtp-Source: AGHT+IFWgOABBvU74IB78DTPxsHW/Uwp7ou6MJ4OEH/y0V+L+WmlFOEWxCGG5BztljneXbqFg3OC2A==
X-Received: by 2002:a05:622a:5d0:b0:4df:3139:d204 with SMTP id
 d75a77b69052e-4e890dfcc04mr11632661cf.10.1760551275420; 
 Wed, 15 Oct 2025 11:01:15 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4e88c640298sm10758011cf.9.2025.10.15.11.01.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 11:01:15 -0700 (PDT)
Date: Wed, 15 Oct 2025 10:26:32 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Vamsi Krishna <vattunuru@marvell.com>
Cc: <dev@dpdk.org>, <fengchengwen@huawei.com>, <thomas@monjalon.net>,
 <bruce.richardson@intel.com>, <anatoly.burakov@intel.com>,
 <kevin.laatz@intel.com>, <jerinj@marvell.com>
Subject: Re: [PATCH v3 1/1] lib/dma: introduce inter-process and inter-OS DMA
Message-ID: <20251015102622.4d519c2b@hermes.local>
In-Reply-To: <20251013042136.1727540-1-vattunuru@marvell.com>
References: <--in-reply-to=20251010144631.713063-1-vattunuru@marvell.com>
 <20251013042136.1727540-1-vattunuru@marvell.com>
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

On Mon, 13 Oct 2025 09:51:36 +0530
Vamsi Krishna <vattunuru@marvell.com> wrote:

> +struct rte_dma_inter_domain_param {
> +	enum rte_dma_inter_domain_type type; /**< Type of inter-domain. */
> +	uint16_t src_handler; /**< Source domain handler identifier. */
> +	uint16_t dst_handler; /**< Destination domain handler identifier. */
> +	uint64_t reserved[2]; /**< Reserved for future fields. */
> +};

If you have reserved fields in API, need to validate they are zero
for future compatibility.
