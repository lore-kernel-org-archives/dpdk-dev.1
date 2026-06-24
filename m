Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766C8CDB470
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 04:24:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3AB2A40299;
	Wed, 24 Jun 2026 06:24:53 +0200 (CEST)
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171]) by mails.dpdk.org (Postfix) with ESMTP id E67CE40150
 for <dev@dpdk.org>; Wed, 24 Jun 2026 06:24:51 +0200 (CEST)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-30c55adcf66so592165eec.0
 for <dev@dpdk.org>; Tue, 23 Jun 2026 21:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782275091;
 x=1782879891; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DkPqN/7T/rvx3luFx8HD9r/GUSX0o+OgPNUxHLnFc1A=;
 b=UzHSMeOGRPVwzEXeXYTkcFyGjFXZF7GoqxoALFUDGN9YyfyR7wKXeZxRIf5jvmjK2Z
 RCYa4DfOK1Wi3sXiJJdrROzZfF3AANC5HTOOkzuJcPy3XTUBTCZljRewVtHC/oyWFlz1
 0gXEZLEZhQM+KtGmLYIhMpa9L32LT8s6VZ+Y+oN5V2zk2mu1mfWT5nKJIOdxtbfZJ0V/
 XyKIN09gj2JuG1pLwZbnkBi1y1Q8gX8yp3oazfnJmznf9lIoOeAdAkA32DPKAOpWpY0I
 5FKHQC5uCOUi2UQL25K3ud+PbVPUko54qnKR0fvB6TlwgvtIEI3J61NOMq4FZVEcU1PD
 mZcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782275091; x=1782879891;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DkPqN/7T/rvx3luFx8HD9r/GUSX0o+OgPNUxHLnFc1A=;
 b=pU3jgGB8hjvgmmWrttHAf2odW3/3ZWRQz7fBuLEBmD3durMWwPUqYzGo4ZYCUuMBdh
 EUtxGVsvmEcVqVJjDFtvTkdLsdvzN4kEgG3K3yTJHBxa6HxbJnPsARndq553UtSE0kpu
 i4Btlr6P6L30f9YvrnBhojAVlJQyv5HARb0U8aylVqzHeZFiKolN6TUvYeMFZG4pU6vA
 Vw7zC135B1lvP6xBdGz1nJLR5C8NH/z7sVd6rnt9l/P8IXd9KxuXA9zhMJMWxN9bFZDr
 WCUqT6AAn1d13nSQOP5kMq4TceRrduBm+wCYOfeBHfSsAJzbCYMMj4BNuPcee/lC1LWM
 PMgg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrnM6cvJ417GrQgPciy8/OZyB1jwpoWOUKQKMI5t7aKbMyuZuxn5Rjlv7IyKx5kV8It5hU=@dpdk.org
X-Gm-Message-State: AOJu0Yzbkmx2baXoznyL0UBaT8yZAJBIggjEsWY4RfFG9Md0Livq0+Ug
 FMPoIXApZmaKpwlGZ0TlTybYb41a/JpEr+nnggCtq7oZV+Uk/o4ZdjAvSPG3S4eUT10=
X-Gm-Gg: AfdE7ckGE+cRO6rVVSrwJWAsMduDKwZrYe32ds825E826xszuWPnKRcu0OnDwpt3nQI
 JLhZD1JPjsCG4zziWzekwv5ZeYo3NeQduYdEBkRGyEHXGjeD2WrKlOvTJdKx9Vo60fqiWG1Acai
 32D9ElgeHdQbxXKFvRCBaL/dE/bXAmCZQzldF6ftepkiuPJEkeKDjdf5UtufBwdqcFkToKGR/Ap
 EjCzvta+XDLdf9aaPTmanWQxwJVmJGHWMt2bQaOMd40v5Ojd7T83G9Pe5/hYdsnGdMKhkB1LiFo
 Eie8HRKzZ0dxz3uGICwyN4BBu4fPrybg9L4q49vbrVa/icW/3ig0avb419Oieq+K6aG0jOxDUyL
 X+09BNKl21AUfQB2wGqI9BpH+okzAZdwJmNa3mLYdiD8jDPKMfJ55dWn3uIfV6sQY7J37ebm2gu
 3HEMzMUxYc97VJ9vs56wThMC4JamfdhB/tQcbccDkiVCIIF4rRxksBnw==
X-Received: by 2002:a05:7300:1903:b0:303:f26f:df30 with SMTP id
 5a478bee46e88-30c69325f6dmr2023057eec.23.1782275090676; 
 Tue, 23 Jun 2026 21:24:50 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1ba1c376sm22503633eec.3.2026.06.23.21.24.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 21:24:50 -0700 (PDT)
Date: Tue, 23 Jun 2026 21:24:47 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: fengchengwen <fengchengwen@huawei.com>
Cc: Bruce Richardson <bruce.richardson@intel.com>, Rupesh Chiluka
 <rchiluka@marvell.com>, Cheng Jiang <honest.jiang@foxmail.com>,
 <dev@dpdk.org>, <gakhil@marvell.com>, <anoobj@marvell.com>,
 <ktejasree@marvell.com>
Subject: Re: [PATCH] app/dma_perf: skip case if worker maps to main lcore
Message-ID: <20260623212447.7010f7e6@phoenix.local>
In-Reply-To: <2b53ac05-892d-4c1e-8c8e-56d13ec402ad@huawei.com>
References: <20260623045841.2602104-1-rchiluka@marvell.com>
 <ajo-ra8UUPRXKoWF@bricha3-mobl1.ger.corp.intel.com>
 <2b53ac05-892d-4c1e-8c8e-56d13ec402ad@huawei.com>
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

On Wed, 24 Jun 2026 08:57:56 +0800
fengchengwen <fengchengwen@huawei.com> wrote:

> >>  
> >> +	for (uint32_t i = 0; i < case_cfg->num_worker; i++) {  
> 
> Please define the variables in front of function impl.

No longer required in DPDK coding style.
