Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE576CD6E55
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Jun 2026 18:24:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 07AF8402C4;
	Wed,  3 Jun 2026 20:24:06 +0200 (CEST)
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173]) by mails.dpdk.org (Postfix) with ESMTP id 7BFD9402BC
 for <dev@dpdk.org>; Wed,  3 Jun 2026 20:24:04 +0200 (CEST)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-3042a388168so498739eec.1
 for <dev@dpdk.org>; Wed, 03 Jun 2026 11:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780511043;
 x=1781115843; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qdCy6+al/4EDooGwhzWkO2n82+hXt3arH4UOEnsn+p0=;
 b=Q1M9CCVDb/N3BqYb7xv9dnX80yZe5fFsF7lgRH8RD0qSbBuFnbKmyzy1KNGxpOe6QC
 ezbW916tfYideNOEVKquDGG8zplC2mVRML/y7n/x5BZWioDaI5D4B2MzcWjgiT1dIGuP
 6wXIBbSbSg2TZnF0z10c9onb3WcMMqNNqcVCnXAXaLwTyvtaYjzdpK6TEXjuqLHpw+4g
 I/dTbeT+q3M4Dlu/Fs+drgjlmCgqTEdjOwI+kBxBE8HU5pkkKS9nmujz+DwHKhwTz+0k
 oo/Lf1nDus/XPsfr2Wp8ebiRZkclyP+TF+ObN5loQHedSaNdip4n7uEUqVwtwf9aga2J
 R2Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780511043; x=1781115843;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qdCy6+al/4EDooGwhzWkO2n82+hXt3arH4UOEnsn+p0=;
 b=K4z33Ow0rEbMjZafiUGmOrQs5PYIvgeb30bMmBVp+xKZNQP84BjlxKjU3foTp9gi+2
 Km7DDJbiswrs/HMawmksBQsLZrW9gg5SOjAZEJVJT37NtU7OP0tpOKccPWyQ3Jmrw6rr
 fZ4ss7AUb0Cca2dBndjZzA7ZBlIw863x6k+4qxaz36TO+GxWkFN4AcvmUL0eHVFVpjMy
 mfMrzUQyxq/EIwc7Tk5YXYYWmVsl2ndPfyVWsby8BW5CSPLhzYX+9vdXqPplYJvB2stL
 KidnhuB2ZqrNStwP7l6xUZDAAfZ5xdIhBwchMfOkZO7LGVYzzd3b1oY1WSEXqRARKP5l
 JPWA==
X-Gm-Message-State: AOJu0YwFTF6pCzC0IqxCguYzR7tQRrfsBEsv72akTPFE9UgHw4DHiWQb
 6hyei8k6gzzTmty6oJYw/T3ph5Pc42fPfeRR4xIFJCzxvRXsBdeUdLlADIo98W0myXghzpuUR7E
 am68d
X-Gm-Gg: Acq92OHiCtKaZe+GqeSFMt9fPZiw2f+2++gYoJBBKE35uCSEhYiVTWqf32kA9/JUCpv
 hXB/FrGshDyCNjerIV9lIB5jJmTaYL59XJkRksYKW60qAIQ5XPEvwKSwm2OH4TWbc+Ps1YawWJf
 CFzpOk3s7plQ9+2QEZcK44jAC842pr+WCthbnZ8zGZV4FJg3ripG45VM985a8LrnjDM4SLf4gbQ
 JClFfgLx07tNF43vjq13tX/piKmpeEQsE5RAHNuW6VWOP7M5t7K+xpsYzSJ68Z5ceLNNjuDnE6l
 aeeZJ0JdzbzL5+P0DAJ4jeasO/RwXXVZVBOstLmycIu4zh969WNv7O+MYpUq3WDZWwFaQ/h3q/d
 rdgZeRz7EijcQka4Yydx4x7TB7wuc2vAZapIWT85AhfGegvX3aiaa/RAFF9QuYZBVGDhx3Zjr5e
 d6HOBesD/1kjRR4bc/D+Novnqvo9ich1mgYbr6gtFza73LBCrfY9ybDGViaPdNVREAjxyqluf60
 qk=
X-Received: by 2002:a05:7300:3204:b0:2c1:67e1:61a9 with SMTP id
 5a478bee46e88-307621c407fmr267043eec.13.1780511043256; 
 Wed, 03 Jun 2026 11:24:03 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074df805d1sm2682632eec.28.2026.06.03.11.24.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 11:24:03 -0700 (PDT)
Date: Wed, 3 Jun 2026 11:19:57 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liujie5@linkdatatechnology.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v8 20/20] net/sxe2: update sxe2 feature matrix docs
Message-ID: <20260603111957.5b0c46b1@phoenix.local>
In-Reply-To: <20260603062945.1253672-21-liujie5@linkdatatechnology.com>
References: <20260603022150.1140722-21-liujie5@linkdatatechnology.com>
 <20260603062945.1253672-1-liujie5@linkdatatechnology.com>
 <20260603062945.1253672-21-liujie5@linkdatatechnology.com>
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

On Wed,  3 Jun 2026 14:29:45 +0800
liujie5@linkdatatechnology.com wrote:

> From: Jie Liu <liujie5@linkdatatechnology.com>
> 
> Update the sxe2.ini feature sheet to accurately reflect the recently
> implemented hardware capabilities in the sxe2 PMD.
> 
> Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
> ---
The flow support documentation does not match code.

$ ./devtools/check-doc-vs-code.sh 
rte_flow doc out of sync for sxe2
	item ah
	item any
	item ecpri
	item esp
	item icmp
	item mpls
	item pfcp
	item raw
