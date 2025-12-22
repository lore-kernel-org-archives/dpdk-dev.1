Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A2DE6B260
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Dec 2025 23:53:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F25340296;
	Tue, 23 Dec 2025 00:53:55 +0100 (CET)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42]) by mails.dpdk.org (Postfix) with ESMTP id 46A7640265
 for <dev@dpdk.org>; Tue, 23 Dec 2025 00:53:54 +0100 (CET)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-47774d3536dso34851165e9.0
 for <dev@dpdk.org>; Mon, 22 Dec 2025 15:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766447634;
 x=1767052434; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8NIdkCMhtP1/sgCre59UZ3rSlUG5IjQiNciiSGAYSwU=;
 b=MYuyWU07FUAfyI372zPkm/ZJ3oZCsbdB8ALRIVtDFrn3UA//okiEJ0CTHMlxYaK8bo
 bPTFGh/Rsh6qxP1kJkkUSyW2QMqEre1zxJfS0N0PlHbvKaOsKJcf6G+i2QZpiiB2bK74
 EkgilYTgoOOoq15LcqySN2juQrqMqzW8i1mz0zi89R9/f4uGqc1moA2zjUm2FjgJRvqA
 8StNGANMJHa+exMYKAdTV6ykwNOPVsHfm/pNyBqGKb9aqn3trXa11+NYdd+NFQyICA6H
 fS/MbmsseXv38zFPTty/9z9vNpk1vvsUVZg8/s2PFwfsYfl/MhVlrBqkONnaeUfnPXnE
 TOeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766447634; x=1767052434;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8NIdkCMhtP1/sgCre59UZ3rSlUG5IjQiNciiSGAYSwU=;
 b=XSBLrZ0273KomIUQgiGg9CKUeteeMyFh2HaLtCQWj/+HLAuH3Qo/oI6NwY7lel8V/o
 mLB4nKPLK9jSFXBZv3jHFOn2+D+yg7DSeJioTDHWA/MLebgwDkJVSdBTU0qsyOWG2JzC
 fqWMIPe3IMNZNoTVJiW0HJyxkok4FGNMdPpuXq1uqFOdQuqwiMxpuS29duEjcw02TtLh
 Zvd6OaEFApkCVi0YXyn8Ix9EuP480gRSuyDWob6wxlxqY0/BdOOpCyd37ZegpC1Cbnzu
 LfQYk0JOfWPNSJPgWFAXZjAoV6pc3XG3Cqf7jo8MOh7j9XliPmEq1JUjaRmy1h0m+rFs
 ueqw==
X-Gm-Message-State: AOJu0YxxQhB2B69/fclTvltPVCPsjo8O611nP+Xb82IeueX3wjbHMzIl
 /f7GnOxF/TFOEjhN1ZOS4XSZw+ZnGFaS4B39fpOt1emJrn592mKdChgHcGkyYDxNmbc=
X-Gm-Gg: AY/fxX7a40Gt0h57FivfuScAnmwokEmfFj3OJOcy8aioCjV90kWh3VBB9Nt1Sd0Kkbm
 tZ/mnjSL4Y2R8O0cBT1Xtix0j33GKYm2JM15QywI8HB+My91bZ1ka6D1FAMGV7BJEuafYwVCOIS
 54QWTpahyNZLvdsVr1OQbbrjPJyvy8hPHoi1GzD0/7W520ARzG17Tc6DA9YeGysOlvALtuTga5m
 dDOeRkvu8kGeTgGfzZrbyzQjRJtJm+7PAD2fQXmTswe97Ky2NodVQLjl29XG/ujiwpZKkBQBnMb
 bDc20DnTxSr6BTvZdBXznbdgg2Ys73OHTlURUQ6TpH0YRquCBdq3DJxGYgj1PWLWunkWTJgtI/T
 EFY7NeGV/huxmJckZ6L3MNe1u7E3KYX6Xwo0Bt35MQA4WAOtyNU0ZSRSD2FrN6voxYAt5EUZmnn
 7t8hWiK8rgl4K52RHuuH0JES56K7UI7pcFFqK38bE8sNDsGAU+KZMh
X-Google-Smtp-Source: AGHT+IHW88n/zJX5jxelXj/8mZXm8YnyE02CMRjv+1Ol/8V2Qqbm4tkULCeVwnhKu+L9/ehTP6pkRw==
X-Received: by 2002:a05:600c:6749:b0:471:665:e688 with SMTP id
 5b1f17b1804b1-47d18be89d5mr167342935e9.17.1766447633617; 
 Mon, 22 Dec 2025 15:53:53 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3a40a14sm115085525e9.2.2025.12.22.15.53.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Dec 2025 15:53:53 -0800 (PST)
Date: Mon, 22 Dec 2025 15:53:47 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Xingui Yang <yangxingui@huawei.com>
Cc: <dev@dpdk.org>, <david.marchand@redhat.com>, <fengchengwen@huawei.com>,
 <lihuisong@huawei.com>, <liuyonglong@huawei.com>, <kangfenglong@huawei.com>
Subject: Re: [PATCH] net/hns3: fix outer UDP checksum fail with simple BD
Message-ID: <20251222155347.4b27bd5e@phoenix.local>
In-Reply-To: <20251205073955.3225775-1-yangxingui@huawei.com>
References: <20251205073955.3225775-1-yangxingui@huawei.com>
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

On Fri, 5 Dec 2025 15:39:55 +0800
Xingui Yang <yangxingui@huawei.com> wrote:

> From: Chengwen Feng <fengchengwen@huawei.com>
> 
> On the hardware platform that supports simple BD, if outer-ip, outer-udp
> and udp checksum offloading are enabled, the hardware incorrectly
> processes the ether+ipv6+vxlan+ether+ipv4+udp packet (the incorrect
> field is modified).
> 
> The root cause is that the simple BD feature does not exclude outer-udp
> checksum. This commit add it.
> 
> Fixes: 6393fc0b823c ("net/hns3: simplify hardware checksum offloading")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
> Signed-off-by: Xingui Yang <yangxingui@huawei.com>

Queued to next-net
