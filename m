Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF8B5C87FCF
	for <dpdk-dev@archiver.kernel.org>; Wed, 13 Aug 2025 14:22:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 16CBF40657;
	Wed, 13 Aug 2025 16:22:37 +0200 (CEST)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47]) by mails.dpdk.org (Postfix) with ESMTP id 126FB40265
 for <dev@dpdk.org>; Wed, 13 Aug 2025 16:22:36 +0200 (CEST)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-3b8d0f1fb49so3914211f8f.2
 for <dev@dpdk.org>; Wed, 13 Aug 2025 07:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755094956;
 x=1755699756; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dkt9GU1AamqGN16svn9IOnAMvzgDlD4Eg45dJCnQA5E=;
 b=RXtarr44jSrTb5A+NatUUdp+icCPnwrh417ZwtbOEQ3Snof+f2JFEvEohIt0hK338z
 n6EfLvj3EVq3Bipl2J+VXvU9POXFohgBBapKDsjGbnFcmOTHfMxnsYPvs4QPZd3OWQYW
 yBDH64wUB8xdpdtrddCtLP77ssnocVng61gDjmfzXluR8psDHVC90nKf9lOstTYmBXBz
 MPtfpy5rTpnajuJGTggKmo11d9gLYtBldUwgilCn6PU1tBkG52lCDFEdLjrjJRbNJbyu
 DB3qbXsc6ntKdhNecQQYXd4BbCjYdkt3TfRod2GAHin+DjEg21JLOc/PStdsvDz3tDmJ
 p+fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755094956; x=1755699756;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dkt9GU1AamqGN16svn9IOnAMvzgDlD4Eg45dJCnQA5E=;
 b=klyyW/AOIKsvvbOvXYFxaB1jAqNKx9tTltXUc10PEpiQFLef19OPvu/2DBa/eZsUwa
 lg3RLlsVd++3bmGughaoM3DscpmR9xkJU+mOyme15koXr7b5Bu1oHGBIjgk8ajHEZAHQ
 /CO2jfSLBe/zXb/3hbX3xK2v7QBjNOX6u8Le5Y0mcVGJoFDGtUDxWVczn3PcobbD5gf4
 00+bEmIU3Ly3l5U0XMJdtvXQBIm+WSdsEkKCFabuHmoELz8W7jgiw1CSBNe7I2LugTGo
 pvP375TwxbJHRkPIdamrJ3smC2Y0MdRNbnU5RMeFhgJjLbrKaChGR2rX8CNnF6f6pntw
 LEYg==
X-Gm-Message-State: AOJu0YxJfx3vHFALGT9pQOP343c4GGSxC0AsGCNghXl1mSXuJrNBYRL6
 ozb55klisMkClh/59Aa9mGHkCCKfK3xXjYJB2I2LDGJTSi8KiusCPHGejhFF7RVt9/8fc3kgkuc
 O5qkY
X-Gm-Gg: ASbGncsaYJSAkjq1oWdd9hvjjWEo8Nqq6J9OHHRr3F6xOZTrYyZr0GVL13peNiQZGtM
 ggdgGiiDVkBp1dFPz3gq22n+xB0Z351NWMenjPegiX/LVQ8vtoU8fwV5Gc3IGxMkgQz1co+oScv
 tqZQTvNb4CBpEiQ0ln6p/FNfjobqiwrIRBFfyAdye5IELqNv380IjNrX+7UuIyRvimgEuwYnQ7S
 zonlqY5DuwVF9iQswPAIR8qmXrj9LdQy5fM2bjJjDh5E6uhreg9UON8oOFPCwWbURSid1VPrt4g
 ftnSMNwM/K8rtY0OxQvL67spYfytElEUOxFF0Ari6ymRiGz/xdeUpy1DopjFamo9lENc1oG8UkN
 Ce8f9cPERTXmYSsLXNIouNyqEg4qvJtruQLu748JUQpbKRumxFfYCQoqJqoPn7QYs6XOsw/v/wh
 4=
X-Google-Smtp-Source: AGHT+IEA4CRRCS3aPkkVuYYN0yiQyMkQKZ6Q7iPOJtQFgdWSce+1t7Hhh+XtRWpvHjKKIPGiPSdIDw==
X-Received: by 2002:a05:6000:2304:b0:3b7:6d94:a032 with SMTP id
 ffacd0b85a97d-3b917d2d474mr2538048f8f.3.1755094955625; 
 Wed, 13 Aug 2025 07:22:35 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c4a2848sm47076585f8f.71.2025.08.13.07.22.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Aug 2025 07:22:35 -0700 (PDT)
Date: Wed, 13 Aug 2025 07:22:31 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dimon Zhao <dimon.zhao@nebula-matrix.com>
Cc: dev@dpdk.org, Kyo Liu <kyo.liu@nebula-matrix.com>, Leon Yu
 <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: Re: [PATCH v4 04/16] net/nbl: add Channel layer definitions and
 implementation
Message-ID: <20250813072231.087b2e9b@hermes.local>
In-Reply-To: <20250813064410.3894506-5-dimon.zhao@nebula-matrix.com>
References: <20250627014022.4019625-1-dimon.zhao@nebula-matrix.com>
 <20250813064410.3894506-1-dimon.zhao@nebula-matrix.com>
 <20250813064410.3894506-5-dimon.zhao@nebula-matrix.com>
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

On Tue, 12 Aug 2025 23:43:58 -0700
Dimon Zhao <dimon.zhao@nebula-matrix.com> wrote:

> +/**
> + * @brief: used to alloc continuous dma memory region for cmd buffer
> + * @mem: output, the memory object containing va, pa and size of memory
> + * @size: input, memory size in bytes
> + * @return: memory virtual address for cpu usage
> + */
> +void *nbl_alloc_dma_mem(struct nbl_dma_mem *mem, uint32_t size)
> +{
> +	const struct rte_memzone *mz = NULL;
> +	char z_name[RTE_MEMZONE_NAMESIZE];
> +
> +	if (!mem)
> +		return NULL;
> +
> +	snprintf(z_name, sizeof(z_name), "nbl_dma_%u",
> +		rte_atomic_fetch_add_explicit(&nbl_dma_memzone_id, 1, rte_memory_order_relaxed));
> +	mz = rte_memzone_reserve_bounded(z_name, size, SOCKET_ID_ANY, 0,
> +					 0, RTE_PGSIZE_2M);

Since this is setup during probe, and probe process is single threaded.
Using atomic here is overkill.
