Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB0BE9A047
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Feb 2026 17:10:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C9F940269;
	Wed, 18 Feb 2026 18:10:36 +0100 (CET)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com
 [209.85.219.50]) by mails.dpdk.org (Postfix) with ESMTP id C9E9C4014F
 for <dev@dpdk.org>; Wed, 18 Feb 2026 18:10:35 +0100 (CET)
Received: by mail-qv1-f50.google.com with SMTP id
 6a1803df08f44-896f5af3d8aso267866d6.1
 for <dev@dpdk.org>; Wed, 18 Feb 2026 09:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771434635;
 x=1772039435; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FYGccIz/6O3E8RoFnmxwZRdZ1quSlqrzWwyg66lUaQU=;
 b=q50aQvcdnBSkiajlXVdYyBjBJN2jKZcvdRYwOEGRyzm9I/8+fNyLqspFSQuKNr1Gxp
 n50Ruuo5LC/ITLEPteSxeAB9Bt+3iuRsZJX4o02XBIDVNqt3eVm/FyOGGigZekz46Qp+
 rIwY1mgtqbTujWot0dCi44MF+Yj8l7nLsf44jAQPP3aOAq/3FAm+uz7rIZ/GhgVAJe6G
 h+QOnHTMUno9zNy71KYDGRLQiUO5pG1fh0mpAONsJf9xtQ2B/O99QzxEhetjVBIrwox6
 KuFcz94fH9a3UYguKxPxeupkQEaF9lQcmnZzSseFWODY1ITG+6umcrlaIgoqNMxwSeao
 uPYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771434635; x=1772039435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FYGccIz/6O3E8RoFnmxwZRdZ1quSlqrzWwyg66lUaQU=;
 b=kAQQU7UU6D8zRkPl7m386G5kpd8Tn6CIYGOevz9n5gPZChEIxMROH1HXaDSPYlF/q8
 W6zpCJm+qhvd4AEPnbh1QhP2b4dNMahIfc59ER/zsoBwibegOyOoqxTmOxy1Wm5EBm22
 80LM4SOUJqRSZ47C8clPij4jPO/OTT9VbNcuZIaTIyMoJ5mVFj3Eh0PCkvxOq/IkQtQI
 +BrbOj3AzDq3IOrQltw2Qh9OfUWIJVqJOmd6IrrOjH4JMU2wLRDehZkfjepnVGMuLw8L
 kgaBeGWjvHGszVh5H/TbCcJSNPSP7U7H8ehC38un2CWi6pFgwo93KmrqpNaiAmX5CMCu
 /BjA==
X-Gm-Message-State: AOJu0YwvB5e3tNS55CijqRy02dxcA4YSZ3bp5gZTm8TipEn3i8q3bNZq
 ZhRS2H0W5gwCvDd7a7CfVYUIa7cOIxWAyMAQDIivlnVSMGUsh36OoflbWlUaU89jg9Q=
X-Gm-Gg: AZuq6aLU8qb+fZGuq2m+ckgvHVjM5XBW+D6bobI1kjD44VNdrSQYmIVPxaPlt4wITg4
 RDXsh8G0ImarAAtpwI56H4BSe+Z6/g1wAU1RruhSl8ymYQtZ3MrtH7d3YhykXbYxJwAykqO/Kr1
 L7IKYWb009wUoAD0pfwdEdd89P2IlqN+O/gdQY4WuBTTTnAg0PeiPrzYv8FZaAGNK8LIp7S4Hra
 qTwDvFAUmzZG6cPIqsnzPtr276AQD7Pbm9GQ5kTLYlyALmTAub1cSyIqg0pcy9NLCzv1Nzc7jzp
 xmL+coPMg6nTV3ux31L6ixTKBnVZkRpxPs51SP0UxLJhgd1gTTYZ3OQzEqV5LPvh3p42sy9W9Np
 OxQGB2J8rlTU/a1MwTtzL8tzWiAj1Hae0XBF8ACZ0Ok2iyY9UuSzTQzqr29G283glOJgnlb211W
 mzimH+PcljN7kq5Yvy1bbOWUEvubPpEeKHbLX5nbg1FD1iLsZdKx68oDJIr3Exzygb
X-Received: by 2002:a05:6214:c4b:b0:896:f2a6:b489 with SMTP id
 6a1803df08f44-8995808b0e1mr34114836d6.43.1771434634923; 
 Wed, 18 Feb 2026 09:10:34 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8971cdc050esm236955426d6.45.2026.02.18.09.10.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 09:10:34 -0800 (PST)
Date: Wed, 18 Feb 2026 09:10:30 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org, Feifei Wang <wangfeifei40@huawei.com>, Andrew Boyer
 <andrew.boyer@amd.com>, Jiawen Wu <jiawenwu@trustnetic.com>, Zaiyu Wang
 <zaiyuwang@trustnetic.com>, Vamsi Attunuru <vattunuru@marvell.com>, Andrew
 Rybchenko <andrew.rybchenko@oktetlabs.ru>, Anatoly Burakov
 <anatoly.burakov@intel.com>
Subject: Re: [PATCH] drivers/net: remove redundant callbacks cleanup
Message-ID: <20260218091031.29da0b14@phoenix.local>
In-Reply-To: <20260218104524.2780167-1-thomas@monjalon.net>
References: <20260218104524.2780167-1-thomas@monjalon.net>
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

On Wed, 18 Feb 2026 11:45:24 +0100
Thomas Monjalon <thomas@monjalon.net> wrote:

> Some callbacks are set to NULL in the release process.
> It is not needed as it is already done in rte_eth_dev_release_port()
> called by rte_eth_dev_close(), rte_eth_dev_destroy()
> or rte_eth_dev_pci_generic_remove().
> 
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
> ---

Acked-by: Stephen Hemminger <stephen@networkplumber.org>
