Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8EDECD6E57
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Jun 2026 15:51:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D70C4402CC;
	Wed,  3 Jun 2026 17:51:27 +0200 (CEST)
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by mails.dpdk.org (Postfix) with ESMTP id 2D4B4402BC
 for <dev@dpdk.org>; Wed,  3 Jun 2026 17:51:26 +0200 (CEST)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-137f27712fdso228833c88.0
 for <dev@dpdk.org>; Wed, 03 Jun 2026 08:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780501885;
 x=1781106685; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WX7YlaFn/QFT5NE3x26pJoiqDF1EW5bpdvtVmZIn6xY=;
 b=KAPPtBk5COvUGY1iPu6rRfmcM8rpvdEfXGuf/CMTzt0XicrlHnzrZpqwIdeZIlmLlG
 zemcMlQxvaaiPOpWHgmdqIlKwrB3we1d3FSGzr4QuQQJ7k7IbM5ui+3dmvSXVCiXNlUC
 jKajeIU+0FC0sELmBQ6ZtwFw8G76ajW6sPIVzLMF+KLJKSYO7MwdjQXDf8qcNHTIJZoX
 J8wCgAo4FwFHcnED0PV+2ofgH99HS4Q3mQhav04dtXfRpl4AEP+WczB+9RBIanJGh3WO
 xWyhmvL6B2dC7SgWqIKh+vgPWjr1pzeoy9OpJtNCT9Eb30/77U4320GsTFIRa8rnJBfo
 qUiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780501885; x=1781106685;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WX7YlaFn/QFT5NE3x26pJoiqDF1EW5bpdvtVmZIn6xY=;
 b=R7N1VI7hgiKTj4LVCtCl5wKiFm2FfGJc0gqdQCOCPz4UyvOdgySeskHGlSot9dqbbf
 aBP0mNv2uPiPSOCqZpxkHaCmySHduvsnxskUWqvgZJZb0exi4l77fS32NTn/FnGvbc6H
 VGa47lGWjkoXzEJPOxayvAjm39RgaiVy0PGsDkAsOkyhCJwppjNWeKiYQtdNA+FG1Vkw
 r4kEu9xlCOYyzwAXGDIovKxi1LI40UQXbQXTZDEyhDHaxoA/MA2DMMHtJU8a1OiDeHhq
 m/C/DwvKe8BlfVcWluBF2M1v+fKzmY0qcpWgjVrhP6hoOvCMEOi1dk3KTFTEnhbXGNoE
 vhQA==
X-Gm-Message-State: AOJu0YxD1bg0F0T718/AQ3qOcDklHSAA59tsCPLcaIzfAS8/0ExqdaUy
 fBNEaVsgL+zZ8Hq8N2Tx2wxbSXj5pOu14w3PRlbhCTtVROUBF1GKMtIVB6Vb3VaTqwc=
X-Gm-Gg: Acq92OHBgDtmgzN6lb7NPJ/3lBs8HDEspXExNKaGquCxrFPTv3IZIlZr5ertvlBMGht
 il5p/YI6mPS2kG6cxSOl8qT76sfPgXVXd8boMY2umk3g1LVJhXnAR1dGQXr/KYZIro0DuShrIYh
 QrHvGiuCxHSZ29B7B3XYLb8F9np/fs/efIyq4JNBVbv1nogJZbBjeCRlIKEWZsGLN/WKqFguZbX
 k28e1gGvjSPqx9ir9eAHA/+MqH70aAjjNx0hJcqqZnjBl/KnTbf0ColGZtPuD1N5nwKPuMYR+9B
 fTdkCMRddPZp+FvXYrTlsirCOswRhTOOqDlJvDZpxUV00C4SdbXxj1nncpY8PlM3id0nyqL9ta6
 ye2mDWs8AaWMgukSivglSyd0fA2jyyt0CwhBnZysOiTN9Mbysy+sgFK3Xag4iQ7BAduZLQZ5yDk
 d5gjxWA5pTUpwle6JGXXPkxShN73yAhr1poNNeVQoMtQ/INEWB4j/j1P7F28Pwr/Hxt0H7AECou
 Wk=
X-Received: by 2002:a05:7300:a498:b0:2ea:5057:a304 with SMTP id
 5a478bee46e88-3074fa653bbmr2021324eec.2.1780501885167; 
 Wed, 03 Jun 2026 08:51:25 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074dcad34esm3712407eec.11.2026.06.03.08.51.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 08:51:24 -0700 (PDT)
Date: Wed, 3 Jun 2026 08:27:49 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Denis Sergeev <denserg.edu@gmail.com>
Cc: dev@dpdk.org, sdl.dpdk@linuxtesting.org
Subject: Re: [PATCH] net/af_packet: fix qpairs argument upper bound check
Message-ID: <20260603082651.3fb3e81f@phoenix.local>
In-Reply-To: <20260603044228.117357-1-denserg.edu@gmail.com>
References: <20260603044228.117357-1-denserg.edu@gmail.com>
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

On Wed,  3 Jun 2026 07:42:18 +0300
Denis Sergeev <denserg.edu@gmail.com> wrote:

> diff --git a/drivers/net/af_packet/rte_eth_af_packet.c b/drivers/net/af_packet/rte_eth_af_packet.c
> index 0ee94e71ea..ebf015dd9a 100644
> --- a/drivers/net/af_packet/rte_eth_af_packet.c
> +++ b/drivers/net/af_packet/rte_eth_af_packet.c
> @@ -1169,7 +1169,7 @@ rte_eth_from_packet(struct rte_vdev_device *dev,
>  		pair = &kvlist->pairs[k_idx];
>  		if (strstr(pair->key, ETH_AF_PACKET_NUM_Q_ARG) != NULL) {
>  			qpairs = atoi(pair->value);
> -			if (qpairs < 1) {
> +			if (qpairs < 1 || qpairs > RTE_MAX_QUEUES_PER_PORT) {
>  				PMD_LOG(ERR,
>  					"%s: invalid qpairs value",
>  				        name);
> -- 

I would rather see atoi() not used in DPDK, it accepts too much and does not do
enough validation. Replace with strtoul() instead.
