Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A6DC02194
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 01:26:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4608C402D5;
	Fri,  7 Feb 2025 02:26:31 +0100 (CET)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by mails.dpdk.org (Postfix) with ESMTP id 265EE402A7
 for <dev@dpdk.org>; Fri,  7 Feb 2025 02:26:30 +0100 (CET)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-21ddab8800bso22297505ad.3
 for <dev@dpdk.org>; Thu, 06 Feb 2025 17:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1738891589;
 x=1739496389; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=APx83yPwLbwnOI9qEuZzzgFyR+olF338iFO8ESJQiKE=;
 b=DcUWZFttAQMcCKkftEasb96WzYnZWNgaxIAYcHshBbQUUMt6xuPuHuZ+B2x9wdWCOb
 M8NlNPUu/B2Zae6rbQMdGnglYCk3T8WTURjaO33E4eT4ndTb6WaiEYEcfgUIC5MTvcN7
 EOQwUi0O4jVNQMauuLGti83rHrTrMg/nrLQ4BS3zPkf9OGnTiWWDdTV2WZr3WRiWnWle
 VJ3TxAcjLPB6+zSQ1B/R5ksi/m39M6h8QTP26S5ZgAASjp3x4lpAzeMrCaUAySabLmh+
 eQmQ63bllJR4GoTBD7ZV/ycZAU68S/Whuy1ORgG1C/gdJKkNQp5PLJyIQN6Q2YEOZiOR
 o1dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738891589; x=1739496389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=APx83yPwLbwnOI9qEuZzzgFyR+olF338iFO8ESJQiKE=;
 b=NlU6AJZQlwpnYmlEMH5aGHzMKb8vMmU9FP1gYvztoXY/72vUvnKgiI0++ZVHuJyWsu
 jLLGJHzJFD045kVuDBOJLKx4kQaBE1PjEI5hUuJ3wNvevAtCcyF9UNrmxzdtxjgP/aoo
 aFUp3pxNtJHWgV3FlO+6FbsLanpa+MpVQMCiDhBeejMFWFOqIf6DKJIfYnK5Moci+q6+
 YRMKnRLAuV9KfdkGT+V3WvQgPJDoDEuPY4ShIex0cL9V2DxO6wAgXhcb3THp3QzJtnmE
 s9TWcY//br/CtXoNkJMAzR2lzsTx46XXbTCwl1tSBga9J+9L4YKXnL6JLXIdaP/wND0C
 JI6g==
X-Gm-Message-State: AOJu0Yy4KEIT+32ShlASLe+0UOLZ3oc04mVKOHGWxcPY0SZMrpBExsoO
 eUB2hZuyo9+RbPxnc7+J9Im60J2e99ynf+sRg0mzkYUkZa+1uUgnIIq8q6ua3vk=
X-Gm-Gg: ASbGnctEBahz8InCqs7dnt+WM7pI4KuneakSPbUP5PrnUKHpMpLc8qqef4++XFvbqb3
 3dNFHlXSOUvb2jkQ0poUmhWL+heDcWSF0sYRY0VPDCuHv21xjt4+iEz/mv8HSOr0UwlpqeJ1Eq4
 ENewo4t3TzRyj/2WyFo+jC4nsv2mH5hydUJJ7fERMoGNwFUW8t8zeIC89UX0I6sk6r7tPsMwDrh
 vF47d6cWrf2UFJYSHoXvjP9lN82xBi/Jgbc/nT2jRNLJyaK5yCxbnnPkh3btWeUkBRuVQHeYzU4
 A1A0QUK0wveFHBjec8TRSec6YgYMIRtqciHtO5zvGzeYe9Brm9KG676kCUz3M1bEBTf1
X-Google-Smtp-Source: AGHT+IHVCeGj3hTjkM4XNFufMkScbO7bWLqXvgDuvQPSpzPtUqboZEwPo1xuv/J8E2zcOGgI/5jefw==
X-Received: by 2002:a17:903:283:b0:21f:3e2d:7d35 with SMTP id
 d9443c01a7336-21f4e6ad3c9mr20366125ad.15.1738891589117; 
 Thu, 06 Feb 2025 17:26:29 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f3650f259sm19387285ad.35.2025.02.06.17.26.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 17:26:28 -0800 (PST)
Date: Thu, 6 Feb 2025 17:26:27 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Tudor Cornea <tudor.cornea@gmail.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH] net/af_packet: fix socket close on device stop
Message-ID: <20250206172627.2d437e36@hermes.local>
In-Reply-To: <20250204164508.864080-1-tudor.cornea@gmail.com>
References: <20250204164508.864080-1-tudor.cornea@gmail.com>
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

On Tue,  4 Feb 2025 18:45:08 +0200
Tudor Cornea <tudor.cornea@gmail.com> wrote:

> Currently, if we call rte_eth_dev_stop(), the sockets are closed.
> If we attempt to start the port again, socket related operations
> will not work correctly.
> 
> This can be alleviated by closing the socket at the same place in
> which we currently free the memory, in eth_dev_close().
> 
> If an application calls rte_eth_dev_stop() on a port managed
> by the af_packet PMD, the port becomes unusable. This is in contrast
> with ports managed by other drivers (e.g virtio).
> 
> I also managed to reproduce the issue using testpmd.
> 
> sudo ip link add test-veth0 type veth peer name test-veth1
> 
> sudo ip link set test-veth0 up
> sudo ip link set test-veth1 up
> 
> AF_PACKET_ARGS=\
> "blocksz=4096,framesz=2048,framecnt=512,qpairs=1,qdisc_bypass=0"
> 
> sudo ./dpdk-testpmd \
>         -l 0-3 \
>         -m 1024 \
>         --no-huge \
>         --no-shconf \
>         --no-pci \
>         --vdev=net_af_packet0,iface=test-veth0,${AF_PACKET_ARGS} \
>         --vdev=net_af_packet1,iface=test-veth1,${AF_PACKET_ARGS} \
>         -- \
>         -i
> 
> testpmd> start tx_first  
> 
> Forwarding will start, and we will see traffic on the interfaces.
> 
> testpmd> stop
> testpmd> port stop 0  
> Stopping ports...
> Checking link statuses...
> Done
> testpmd> port stop 1  
> Stopping ports...
> Checking link statuses...
> Done
> 
> testpmd> port start 0  
> AFPACKET: eth_dev_macaddr_set(): receive socket not found
> Port 0: CA:65:81:63:81:B2
> Checking link statuses...
> Done
> testpmd> port start 1  
> AFPACKET: eth_dev_macaddr_set(): receive socket not found
> Port 1: CA:12:D0:BE:93:3F
> Checking link statuses...
> Done
> 
> testpmd> start tx_first  
> 
> When we start forwarding again, we can see that there is no traffic
> on the interfaces. This does not happen when testing with other PMD
> drivers (e.g virtio).
> 
> With the patch, the port should re-initialize correctly.
> 
> testpmd> port start 0  
> Port 0: CA:65:81:63:81:B2
> Checking link statuses...
> Done
> 
> Fixes: 364e08f2bbc0 ("af_packet: add PMD for AF_PACKET-based virtual devices")
> 
> Signed-off-by: Tudor Cornea <tudor.cornea@gmail.com>

Makes sense, applied to next-net
