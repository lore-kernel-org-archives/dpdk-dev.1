Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B75C7EE30
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 20:04:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C7294026F;
	Thu, 26 Jun 2025 22:04:51 +0200 (CEST)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com
 [209.85.219.45]) by mails.dpdk.org (Postfix) with ESMTP id D0B944026C
 for <dev@dpdk.org>; Thu, 26 Jun 2025 22:04:50 +0200 (CEST)
Received: by mail-qv1-f45.google.com with SMTP id
 6a1803df08f44-6fb1be9ba89so13440116d6.2
 for <dev@dpdk.org>; Thu, 26 Jun 2025 13:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1750968290;
 x=1751573090; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=990+ZyxwSu2XCQGPqqVXl5/ZY7HmsCwGiJGerkgcsGw=;
 b=yiaVmy7qzFhqVc1NS6UoRqlFsLDfaGarAgcr6ltN4GeyVr9IdF5CRXzRMQ8616ocSf
 bXnxhciHHxvtL4amknclsS5pSwvErndC8YcBuC3XvX5yv/RlfVujAE38S7w1OCGRqGAk
 cA5JdK7JywDkGnNG+fZfiFVua7xvBIAYYK6K+RyebgBXQuPrGC33RjIWAwx25oYNA5Gj
 W6Jt54sG58FbGRy//3l+fr1W1j54/TXhbDK68K9mGrPts6q5lb2a7tfuriIwbEyImMKZ
 aqUSV8uJXNMd5FOo0ePkbna/9ZV/FIxJg/kCT/wYgtMsw+I9Qei/Z+TmDvvmgcBdP1Jr
 VSeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750968290; x=1751573090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=990+ZyxwSu2XCQGPqqVXl5/ZY7HmsCwGiJGerkgcsGw=;
 b=tuKzUpnePckZwFF0WCKy8wL2csjem6eRTuHkS+id4rv5mWbXFIygvvLcewncUfcVtQ
 TLlte7caXXXovE7kbcL4yYOabgBCsOtQXkGFEIS261d177u2Lxf4Tm6JI6AF+DgWhT+z
 UBTgMD5Kd0soNZHuRo1w5eID53zvRp3tX9mrY0vgxS4bv7Ed5ga2zA4Wjk5VTNnZyoNP
 IetBYBb3rjdhnURLSZGzcEUXnFo11byu857E1aKnyJwpiqfc/n5Y3pYB8ZSAHGVcpmS4
 WaDXjfumvS6/B+eyoauhHvbH2fQLmHlW6lnO0FMdG7ua+DMmFL2vrmkvlOc00mOk9zIX
 IqWw==
X-Gm-Message-State: AOJu0Yw+rZcwe/1KBQ+RcsWgCB9fSJ/2ftefH+zL9fMzSLPsLRseN2QS
 //jWxnoe6zk28gDymsxEjY5vmsNKXpSrivMMTU27p9OZUzdec7apLxFphlASEal893k=
X-Gm-Gg: ASbGncs5CAwAbl0xUshN58XcuE+t0GhTNbwRFMRsVb59tiXPms3Jdk5wk38PRVlqAGx
 2iuEPEGBbJMfnToFICDueD6TtZ35EM7BH8BDU4y4bezp5u8oTrD/l9+EPqfWBNO96COhZLPqMrB
 Qo0c0SNJxcrFrH68tXrwfgwuyyFu40TfBBepFHu+my8qYX+BKct57ASkVY4vg2/0hHKzrg1YEvG
 AXdDedVQlNDtNf0hzArACvQvKEnkwDrMJ3FnnfQ9j+NGUppki5kC87KrCfFUJJ+r3Po2M+PMNAR
 ft1sQtbfzsDhRyk0XSk4ypX16wyfgaPMIO2YNVjH2LLR78MxfOGkbKo7zqiv/yJavNqnGlEEii1
 6sMPEa+v8Ia2HgEH3Hq9C+WqLv2yoM7qpSBHFYiSE9Ld4boNCaA==
X-Google-Smtp-Source: AGHT+IHAQd3HR6uYT/BoNj4+6Gt4wdtV5izNdIvSseEH4jWpSt0dwlvVAnc+yVjjjkjWdLOWonk2+Q==
X-Received: by 2002:ad4:5bcf:0:b0:6fb:4caf:5d04 with SMTP id
 6a1803df08f44-700031c6a5bmr12831886d6.45.1750968290146; 
 Thu, 26 Jun 2025 13:04:50 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fd7730aaf8sm11278286d6.109.2025.06.26.13.04.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 13:04:50 -0700 (PDT)
Date: Thu, 26 Jun 2025 13:04:47 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Feifei Wang <wff_light@vip.163.com>
Cc: dev@dpdk.org, Feifei Wang <wangfeifei40@huawei.com>, Yi Chen
 <chenyi221@huawei.com>, Xin Wang <wangxin679@h-partners.com>
Subject: Re: [V2 14/18] net/hinic3: add Rx/Tx functions
Message-ID: <20250626130447.37985cfc@hermes.local>
In-Reply-To: <20250625022827.3091-15-wff_light@vip.163.com>
References: <20250418090621.9638-1-wff_light@vip.163.com>
 <20250625022827.3091-1-wff_light@vip.163.com>
 <20250625022827.3091-15-wff_light@vip.163.com>
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

On Wed, 25 Jun 2025 10:28:10 +0800
Feifei Wang <wff_light@vip.163.com> wrote:

> +#ifdef HINIC3_XSTAT_MBUF_USE
> +		rxq->rxq_stats.rx_free_mbuf_bytes += pkts;
> +#endif
> +	}
> +	rxq->rxq_stats.burst_pkts = pkts;
> +	rxq->rxq_stats.tsc = rte_get_timer_cycles();
> +out:
> +	/* 10. Rearm mbuf to rxq. */
> +	hinic3_rearm_rxq_mbuf(rxq);
> +
> +#ifdef HINIC3_XSTAT_PROF_RX
> +	/* Do profiling stats. */
> +	t2 = rte_get_tsc_cycles();
> +	rxq->rxq_stats.app_tsc = t1 - rxq->prof_rx_end_tsc;
> +	rxq->prof_rx_end_tsc = t2;
> +	rxq->rxq_stats.pmd_tsc = t2 - t1;
> +#endif

I understand why you would want #ifdef's while testing a new driver.
But once it is released, they become latent problems.
The #ifdef code never gets tested, and may or may not have bugs
that are waiting to happen.

Please try and stick to the standard ifdefs that other drivers use.
For example for mbuf, maybe put it under mbuf debug #ifdef?
