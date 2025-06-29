Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F20B9C7EE39
	for <dpdk-dev@archiver.kernel.org>; Sun, 29 Jun 2025 18:01:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 48E4A4066A;
	Sun, 29 Jun 2025 20:01:00 +0200 (CEST)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com
 [209.85.222.175])
 by mails.dpdk.org (Postfix) with ESMTP id DBB004065E
 for <dev@dpdk.org>; Sun, 29 Jun 2025 20:00:58 +0200 (CEST)
Received: by mail-qk1-f175.google.com with SMTP id
 af79cd13be357-7d41cd4114aso677725185a.2
 for <dev@dpdk.org>; Sun, 29 Jun 2025 11:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1751220058;
 x=1751824858; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=minUwTUUBfEDB0FQbaQaXpwetOAv8g08hMsEUtN8uwg=;
 b=kW85UywPZqyutDRsntw6c7X9zoCBXRgrgRQOQmbwjAb79sBipHpTFpTRYDGe7yU5z1
 7jzhTRnREXEv+/gt8U2zNxmijNfXfHq9h3O6uVCS9UvXWW3eVIReXgkQ/xpawtUpAWwm
 mpzB5boVbEW4LOQPD9bhyhQweGiwP3mWXNIC0sVVTJt1jQBPSXNxPigckzXr2rVis3Bn
 fpKH5aQ15Ssq+seMB7z2tT4hTA+9D+xETDm119KozZyAtltHIUjqep8joE3KflHrDEP/
 EpWhjIqkf2gHYLo8iKwXE6BZTAak+c3Kb0XmDa5ocTfNpaH57995cfTJUkxlSGfq2UXm
 fZAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751220058; x=1751824858;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=minUwTUUBfEDB0FQbaQaXpwetOAv8g08hMsEUtN8uwg=;
 b=ETCZVu5ojTVzOGysLwGEwpsPixCfqFdfXO/96ylXcVqTSCt92hfq2nK1eJBAqC9Mph
 5yydiDamb0eC2tBFkdjtKhbsQdyxpKfIbPatLb4fk1sbY4xVWyzPhmWTXToM8kgPySQR
 lWeOFk+ZBHlqLcGOvBtGNMJmcA6dXMnwJbcXTkmtpOSKddprYap4Wpa+kuxg6BPLHn07
 0+8m+E23GYns6wY1slTvskXCI82zdMift30UwVXODn/+5SbhcYRXMQ5wkJQSjIp4Yy4y
 Jr6dWbhKjUYon/AVCNSXoMJM2yLx+xorhU3hectl3DTV6jfmntIqSvbgBIAAOlkddttC
 eH1w==
X-Gm-Message-State: AOJu0YyQi3CZu7gpw90a6db98K9I/RD0pSkLO5LTQcgV8+f+2Rf3eIbi
 N//AlbltF9tH+fK5suUkIAiuc9w5phHCeAypAEydPHBm1aoXY9ZIFF45zDnR9yR9vKI=
X-Gm-Gg: ASbGncv/O53RWo7ptMPUqTK55h/I89bp9JhJFLFPJiAVSJ6BXj2pbeMB9UlEdzO0rbR
 XsB6neXYtQyFhIEvaohU6BnvmEJk6aow8o9EGQ00cAM0LReylUtKiTj3gSLzxXUUezEWmUyTNbo
 JTWbbJQZS0yPjk/9qAosB6LswmVylNyOgtQBkVMVTAOmE4N+zKlsEDn/XrZ+6mAl4UT7rl6fOvN
 RjRshUwsoA+ZrsyOgWykzC1fABx1prUy76BudCSPuQ62HUO7wMiI97sWyv8cBnD0m55EetmHSnD
 dlyz4d6MVYpuMAnnzTste3LYVa2E5HWVK/pulhvLLEmtWWV427PCkH9CVqcH5fFzOL5Eie14P+n
 HL9XL6YGugFpmUJBbYweceeWyIaZ5pyuTJm19U7U=
X-Google-Smtp-Source: AGHT+IHqOiJU8iEDdUR8gjWe+ttCee8h1Rg1gE7EhelEeuF2sHUY8qmCdgK6z8a3l7Yclhw4APeBzA==
X-Received: by 2002:a05:620a:470b:b0:7d4:4970:6753 with SMTP id
 af79cd13be357-7d44970685dmr1106300885a.55.1751220057407; 
 Sun, 29 Jun 2025 11:00:57 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d443235ed1sm463866885a.100.2025.06.29.11.00.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Jun 2025 11:00:57 -0700 (PDT)
Date: Sun, 29 Jun 2025 10:57:37 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Feifei Wang <wff_light@vip.163.com>
Cc: dev@dpdk.org, gongfan1@huawei.com, Yi Chen <chenyi221@huawei.com>,
 Feifei Wang <wangfeifei40@huawei.com>, Xin Wang <wangxin679@h-partners.com>
Subject: Re: [V3 01/18] add some basic files about hinic3 driver
Message-ID: <20250629105737.5e0d6edc@hermes.local>
In-Reply-To: <20250628072552.1311-2-wff_light@vip.163.com>
References: <20250418090621.9638-1-wff_light@vip.163.com>
 <20250628072552.1311-1-wff_light@vip.163.com>
 <20250628072552.1311-2-wff_light@vip.163.com>
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

On Sat, 28 Jun 2025 15:25:24 +0800
Feifei Wang <wff_light@vip.163.com> wrote:

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

Fix your editor settings all DPDK doc files should end with a newline.
