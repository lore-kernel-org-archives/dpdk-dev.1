Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD1FFC7EE30
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 15:47:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2A31D40648;
	Thu, 26 Jun 2025 17:47:43 +0200 (CEST)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by mails.dpdk.org (Postfix) with ESMTP id 6DB1E40616
 for <dev@dpdk.org>; Thu, 26 Jun 2025 17:47:41 +0200 (CEST)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-b271f3ae786so944857a12.3
 for <dev@dpdk.org>; Thu, 26 Jun 2025 08:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1750952860;
 x=1751557660; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZYyRN/G5BuRZtHfG7XjnhahlxE1r+0piTY4GCu+jmHY=;
 b=DdFsY0ha8v6QSo77L3OJzkNr1SFPyzc4AFpLCYgtRoqLGOJ7/gwK8cbzmVG6XE55B0
 5/81VB3EN4GeHQ2pq/x5xq9VuH/iOaDW47VeF4YtPekhe78sHlKC1rHsh+h+oQqdpNOw
 UI+POMltHW4W+du4REkN6qIvp+fDJ5/4nQlBfE/Qwt1+WPW5QnMlkQEw8FCzGypMRF6o
 tyAYfiRGGv+CDhetbeLln0+cuuH58a1eWVlEtQsuYq5F1xu9sWssD2HjF+sQ/WTO3JyM
 NRR9EIz4C3bMGgwCD/URmXPJScK+ju6AwHrsV72O4C1PQnaj16rkEwvCxjr1phj9uAhv
 BUrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750952860; x=1751557660;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZYyRN/G5BuRZtHfG7XjnhahlxE1r+0piTY4GCu+jmHY=;
 b=fnoGuw8tARnvfessaUx8qMG9VhCAqL6o9fwgUnkS2mNpw/xkqTykXsmwqVQBaeThFU
 9HUNwq89Pu5WcMxqjKuvfdYjTEXA4kvmxIgaj8Lkpg8UIlHgBs6pXSDIUs/322Hutsv6
 T+OWXeOd+V7JFhiVjkqV1lNTkbFY7owX2xMki/2uUP+xG4qS72AMRZWkACYzmxPmeb43
 i1q8AD91j2Mf3HLNIeoC8gaycEhwNgnDOLrf6QO0G3BvtuAt2taVYfK6t29jFA9+zknZ
 m9c6Z1R6wY3TUZsYSG3f7bmQ5OEJJ5Fl7dDw8J2brz7CAz6GMyOnnjfPmuxdhbKtfzzo
 iofQ==
X-Gm-Message-State: AOJu0YyzWlZ5QJdOZCkJYiKFwLPUWGcY48BE0kRXnUzXZv9tklKPgpge
 XIZVFA8F4Ws2h1rfgDrRvI4zU3qcnVn8bADJAyMeEX24Gx0kqNdwoHjyKgfzNdBizPA=
X-Gm-Gg: ASbGncunKBoxgswYoSz/tXixBwvY7pGT5q1my60lRTYzILfKTkRBnO4K2UADBCSNKfU
 rLcl8dpYy251BOEXWrT9pZgN8F/CSMZevOWZbGMInkUVvBK0yUraDBF4ZnltxSn2XGph4VhS0wO
 x7MCsjnypDcmIOWFQeqz2aMbR3MKriZPZEPOWnjkgADDCxtmlXTXOix9k6evIQ1DE6LKPHtLv7f
 +ABr+DMsAAFt/Kq7iUADFUMF7RinBcYa4Zp4RL7/9+WkWf2y8PGSPwTlTNrLfTDiC9wwvxwj2dp
 rUsVBPRyXEntr9LR/69Y+dHvJDUbdiDuY8tvndWyYlyGd6yzKwOMs54WN+bKg60CeQQsAetTuJ6
 CYogbvTBisTag1mw4QJlzGRlK7OivHFjaEwarh0bq6PBUDX7G5Q==
X-Google-Smtp-Source: AGHT+IHt3KPC5r4xpsuZLAr+vY+tuSMJJpuFrlLTeXvsXN+7UBUkqDHCkp4x/z1GS6FvvEfNcKqA+w==
X-Received: by 2002:a05:6a20:7f9d:b0:215:de5f:febc with SMTP id
 adf61e73a8af0-2208c5b937amr6663624637.27.1750952860578; 
 Thu, 26 Jun 2025 08:47:40 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74af57ef4dbsm31812b3a.160.2025.06.26.08.47.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 08:47:40 -0700 (PDT)
Date: Thu, 26 Jun 2025 08:46:43 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Feifei Wang <wff_light@vip.163.com>
Cc: dev@dpdk.org, Yi Chen <chenyi221@huawei.com>, Feifei Wang
 <wangfeifei40@huawei.com>, Xin Wang <wangxin679@h-partners.com>
Subject: Re: [V2 01/18] add some basic files about hinic3 driver
Message-ID: <20250626084643.4728ae08@hermes.local>
In-Reply-To: <20250625022827.3091-2-wff_light@vip.163.com>
References: <20250418090621.9638-1-wff_light@vip.163.com>
 <20250625022827.3091-1-wff_light@vip.163.com>
 <20250625022827.3091-2-wff_light@vip.163.com>
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

On Wed, 25 Jun 2025 10:27:57 +0800
Feifei Wang <wff_light@vip.163.com> wrote:

> diff --git a/doc/guides/nics/hinic3.rst b/doc/guides/nics/hinic3.rst
> new file mode 100644
> index 0000000000..6ab13113b8
> --- /dev/null
> +++ b/doc/guides/nics/hinic3.rst
> @@ -0,0 +1,51 @@
> +..  SPDX-License-Identifier: BSD-3-Clause
> +    Copyright(c) 2025 Huawei Technologies Co., Ltd
> +
> +HINIC Poll Mode Driver
> +======================
> +
> +The hinic3 PMD (**librte_net_hinic3**) provides poll mode driver support
> +for 25Gbps/100Gbps/200Gbps Huawei SPx series Network Adapters.
> +
> +Features
> +--------
> +
> +- Multi arch support: x86_64, ARMv8.
> +- Multiple queues for TX and RX
> +- Receiver Side Scaling (RSS)
> +- flow filtering
> +- Checksum offload
> +- TSO offload
> +- Promiscuous mode
> +- Port hardware statistics
> +- Link state information
> +- Link flow control
> +- Scattered and gather for TX and RX
> +- Allmulticast mode
> +- MTU update
> +- Multicast MAC filter
> +- Flow API
> +- Set Link down or up
> +- VLAN filter and VLAN offload
> +- SR-IOV - Partially supported at this point, VFIO only
> +- FW version
> +- LRO
> +
> +Prerequisites
> +-------------
> +
> +- Learning about Huawei Hi1823 Series Intelligent NICs using
> +  `<https://www.hikunpeng.com/compute/component/nic>`_.
> +
> +- Follow the DPDK :ref:`Getting Started Guide for Linux <linux_gsg>` to setup the basic DPDK environment.
> +
> +
> +Driver compilation and testing
> +------------------------------
> +
> +Refer to the document :ref:`compiling and testing a PMD for a NIC <pmd_build_and_test>`
> +for details.
> +
> +Limitations or Known issues
> +---------------------------
> +X86-32, Windows, and BSD are not supported yet.
> \ No newline at end of file

All text files should end with a new line.
