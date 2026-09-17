Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC71C982D6
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 16:29:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F2E4742DE4;
	Thu, 17 Sep 2026 18:29:49 +0200 (CEST)
Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com
 [74.125.228.41]) by mails.dpdk.org (Postfix) with ESMTP id DA08940E4D
 for <dev@dpdk.org>; Thu, 17 Sep 2026 18:29:48 +0200 (CEST)
Received: by mail-pz2-f41.google.com with SMTP id
 d2e1a72fcca58-85469f20513so943998b3a.0
 for <dev@dpdk.org>; Thu, 17 Sep 2026 09:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789662588;
 x=1790267388; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IB0SSb76tqD25aMT5iJFlDulzyD5wWkHV+zLs6XO2Hc=;
 b=L8+YD4BLTiIigfcMIlH328cGf0Qk2sMlVHpDBuqBxxZI/QPhJVDS2X9CaIxkc1G/eL
 XZu8c77h83pVz2ItbqhJoQY+TZ4D5W6E7b8vSt31S5gsAiJ4JUwSku6BzjLLd5ZhGy09
 NtMQaS50FNnkpiwV5UAt7v02MxyQldHeufm//7/NgWwNxy+Vtc5qJ+itju6etjsDJBvD
 PzIRXyh3leVc+pc87Uwgq8vNdZL6tBxJuUwkNAC5DMPyNSXeWwTFUueGiDEPkwYLdGrH
 dsXGityzx9xoZLYvuRLQ4d+ysaA3TNX7m26zLdUR4Slx6u/E5K0V0I8AuzrgPGET77Vp
 04bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789662588; x=1790267388;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IB0SSb76tqD25aMT5iJFlDulzyD5wWkHV+zLs6XO2Hc=;
 b=eOH34Qrhauj3ubT7mymLsMqnSvOe8LLQgl6ESPYW6TSbbKYpO9ROM06sP8dovB+2bc
 P36ukndF4OKTFhZb6fanZ+U5t2uJoJCxAWzgy+JIxFqdlkPcyCj9fPIrUf7oMntxBz8y
 ilzYg0thG7mAJM77ri8Sbmss1NZ+q06mg5JPtxn4/fIueTQXxqU0lzx4lkEXA5XcNXFe
 InMqY5AI/RnDXTEmaiYmp9rIdzPu24YTea1frXoL8M8F2LRIszw3lUAUwnOJjkhjHbeI
 sx4+lgu/RFSFItzXYq3HhsM3MACZkZyh2fI7bIB/c2K8AQ2WY6SsKwuGasglPtStIebP
 sSNw==
X-Gm-Message-State: AFuF++mSQ59SUoKBZ/wXXr56pfUYfCUQSYU8SC3eBKjeAGkm3Wmu3zO0
 2KCS5oFxEV1CN98KjBvfT5vn/Z8Vh4dWpvwqJMaM1ae8WKlNjqFU8Im9usffuw5Nyac=
X-Gm-Gg: AYBFou1uc/RYse0LWWpWl2wHmGi5rZ9BWXIqJOzNeak1rE4GZYpv7Ysr8aFEASNTR0j
 aNszSzMJ6BNN9cQf9rCIzfk+bsST4HwCIbkOyi+QM/JnwK6Fi3FKtiEZJ3YwixFDTjXhXwH+MId
 Ix7eA7iq600D7/IxAk8wjN2Vm/I5B1eKB9eEsSC3A0Yoc/QgxJal3unqifpd5P3GhlJeIqNsrIW
 llHCOrvgOJ/OP+tL80EHX/j4xoFch8NJ6M6mAwoeegwvRbwBiAS6c6TiNARSEyT4VF25wuMCfNF
 bjMkojSQD5x/sFD68BYAJgXcIsxYlAyJ6YPgONsnpiE2zCPp3R7k8YLeZQ6wvrtdwRpAzuAU8N4
 PNOsvlJ6ulU7fo1cENfv79M0FALJ2Zuxo2Uv/9XpsRYXrTrfh/DtdGzfrI9gH19jwOeWPVSmuN0
 7oc7TbIXylV0S8YSERgUvQsoUrLYnFxKfJBU1nUGA8hYToYYpENl6vavQUJu+eLW9fXpejl03Ex
 1VfZva8amnkbAsrQGqlLl9Jgv7uzhQHKPnHdzhA
X-Received: by 2002:aa7:888a:0:b0:874:708d:b620 with SMTP id
 d2e1a72fcca58-874708db889mr1638194b3a.30.1789662588011; 
 Thu, 17 Sep 2026 09:29:48 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87201a2befcsm3126835b3a.44.2026.09.17.09.29.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 09:29:47 -0700 (PDT)
Date: Thu, 17 Sep 2026 09:29:44 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Rahul Bhansali <rbhansali@marvell.com>
Cc: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar
 K <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha
 Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>,
 <jerinj@marvell.com>, <stable@dpdk.org>
Subject: Re: [PATCH 01/14] net/cnxk: fix packet length handling
Message-ID: <20260917092944.2dc6ee0d@phoenix.local>
In-Reply-To: <20260917071016.2366467-1-rbhansali@marvell.com>
References: <20260917071016.2366467-1-rbhansali@marvell.com>
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

On Thu, 17 Sep 2026 12:40:03 +0530
Rahul Bhansali <rbhansali@marvell.com> wrote:

> Fix packet length handling for reassembly failure cases.
> Also updated few macros as per cn20k platform.
> 
> Fixes: 5856f23129bb ("net/cnxk: support CN20K inline IPsec Rx")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
> ---

NAK
Lots of problem reported from AI review of this series.
