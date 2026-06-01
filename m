Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C86CD6E55
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Jun 2026 16:31:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2F22A4042C;
	Mon,  1 Jun 2026 18:31:39 +0200 (CEST)
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178]) by mails.dpdk.org (Postfix) with ESMTP id 61B09402DB
 for <dev@dpdk.org>; Mon,  1 Jun 2026 18:31:38 +0200 (CEST)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-304c520fe9aso10823230eec.0
 for <dev@dpdk.org>; Mon, 01 Jun 2026 09:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780331497;
 x=1780936297; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oipRcMvZUleQFAq5vpWLLeKB+Df4YVfWmwPJO10b93g=;
 b=StZK42x7YsWdAM2H9BAgXpp7mArV/jCpI7iMw3x+ZJrc1N/svRIvFyo7b6bFCOiRlP
 Mh0zSJEQ+CUBvMH4yQ09qYfWgFjQDvNw25fQLgmlQRBrv1e/bA/ftJnNC+OYqHHDyz0w
 pZAipf7rvDN53bD67sdBRMtkiBqk6qa7bfrtsampYJlQsTt3Va4Qo97LcgeCB2oYPaPe
 cxZ79W/JL5nlv7/4ns1XS3GeA/aj1JI49PqXN52wxuFIhgrETFV4TGXEvyXVaCN08j7F
 HCqheAItkOb5xydI5ZdzuU5gxonUnYnZVxc+b/vhkykG8bLTGeAN+3MyhS3bhzl/3Ppv
 laRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780331497; x=1780936297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oipRcMvZUleQFAq5vpWLLeKB+Df4YVfWmwPJO10b93g=;
 b=boFxVPfTbURal+UKQXcFzy8SW/K7eVVzSCV0/CApn+XsM+mh2ecyL2ASHSpl3KOZxE
 OUdvtx2ObP1SHfj5Of+4GDT8RFrfDTMSl1tP+gnoH/AkZFLmq4g+Jtu1o/VHXJOc34pw
 SPNF8AgqZ64URyuCZz8kE3KLfO7brhbgsGlYSfeONMWfbh7aWuwQeau9e8Mol4cyvTqU
 HifHIUyaJSnv0ylvqaeJOHyW35FMgOLe+aiWiyRZ95n+cXEfZwctplsvKPAbuJKelwW6
 Ys0P3Pqb7KEut1b2j2YLC5PoqlgK7X9pSWrL74QLXLFMBlCZSlVrWdPS/FdU5WmLOEqY
 LqGA==
X-Gm-Message-State: AOJu0Ywgyiubb+KaUm87vs6Ffw1UIwhZI51WQ8Ql5qJSC6VECGAtQQXm
 E/+AXjJdljgWpf9ASsLIIld1MjL1SZ0c/uZM9pFZ/iZ/Y9brmCelN10SRn5dmArxvdA=
X-Gm-Gg: Acq92OGB+3cQFZf8am7+zxialHTQRR8JUPSPc9UGDq7TQLIXVs3YhZWp43tf+M1pMLU
 uBuitL3s6INuYsir+SQwH0C9kHELbnTUwk9V1VuZOOgPFdIG/SWSaLUh0g0KWIroEjqH9KMXIsj
 y/OX7wSWhJ7YVddI3ExUesL+4s62iAM01107n9gSDf49CU4BtMyaedL4PZhjfFayL3hWc36Hcoe
 MjKXv0xhvXnEYYwxtIqY2Xb6jRnVfU0fZ2YFk4Gwyd19clA1DJ5COZmlpYMcqOEET40DB3BysmS
 U9nXDlk4iqpgFE5dqHhwvs3qqYHbNlBM2+NURBnzFCnyOMx34ygX0RMHBwcmrWzYjxfSWSAimlt
 d6V/p9784RG17tTdHOjKQiy//3sFtdvDfxCzIHJEyITZXJbJjs26PdMnz4ZFxVca2QjGHgaPNoh
 Q9OCMWN+0AQFTW8UFxWz1WxaVW6D6gQK/hPiYz10zu7zbDyh3vnlq9akCmV6Cn3Dhz3JooufuXJ
 GE=
X-Received: by 2002:a05:7300:4353:b0:304:886b:b07a with SMTP id
 5a478bee46e88-304fa4d66c4mr6284662eec.14.1780331497155; 
 Mon, 01 Jun 2026 09:31:37 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ee0dd6fdsm8617574eec.23.2026.06.01.09.31.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 09:31:36 -0700 (PDT)
Date: Mon, 1 Jun 2026 09:31:34 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Wei Hu <weh@linux.microsoft.com>
Cc: dev@dpdk.org, longli@microsoft.com, weh@microsoft.com
Subject: Re: [PATCH v5 1/1] net/mana: add device reset support
Message-ID: <20260601093134.6bcd43da@phoenix.local>
In-Reply-To: <20260529142648.148407-2-weh@linux.microsoft.com>
References: <20260529142648.148407-1-weh@linux.microsoft.com>
 <20260529142648.148407-2-weh@linux.microsoft.com>
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

On Fri, 29 May 2026 07:26:48 -0700
Wei Hu <weh@linux.microsoft.com> wrote:

> +#define MANA_OPS_1_LOCK(_func)						\
> +static int								\
> +_func##_lock(struct rte_eth_dev *dev)					\
> +{									\
> +	struct mana_priv *priv = dev->data->dev_private;		\
> +	int ret;							\
> +	if (!pthread_mutex_trylock(&priv->reset_ops_lock)) {		\
> +		if (rte_atomic_load_explicit(&priv->dev_state,		\
> +		    rte_memory_order_acquire) !=			\
> +		    MANA_DEV_ACTIVE) {					\
> +			pthread_mutex_unlock(&priv->reset_ops_lock);	\
> +			return -EBUSY;					\
> +		}							\
> +		ret = _func(dev);					\
> +		pthread_mutex_unlock(&priv->reset_ops_lock);		\
> +	} else {							\
> +		ret = -EBUSY;						\
> +	}								\
> +	return ret;							\
> +}
> +
> +MANA_OPS_1_LOCK(mana_dev_configure)
> +
> +MANA_OPS_1_LOCK(mana_dev_start)

I strongly dislike wrapping locking in macros.
Macros make code harder to analyze and hide things.

Also, using pthread_mutex here needs seems like a bigger hammer than needed.
It looks like reset is just an atomic flag and as long as it was in shared
memory simple atomic operators would suffice.

In Linux there are many ways to express the same thing
but in general if most drivers follow the same patterns it helps
when there is an issue to be able to fix it globally.

Also any code which turns off thread safety analysis is a red flag
for me. It needs strong justification.

Overall this reset logic looks more complex than other drivers.
