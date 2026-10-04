Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A46A3CA5FCE
	for <dpdk-dev@archiver.kernel.org>; Sun,  4 Oct 2026 16:11:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AC85E402B5;
	Sun,  4 Oct 2026 18:11:03 +0200 (CEST)
Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com
 [74.125.227.171])
 by mails.dpdk.org (Postfix) with ESMTP id C60F540285
 for <dev@dpdk.org>; Sun,  4 Oct 2026 18:11:01 +0200 (CEST)
Received: by mail-pj2-f43.google.com with SMTP id
 98e67ed59e1d1-396ccb1a98dso447650a91.0
 for <dev@dpdk.org>; Sun, 04 Oct 2026 09:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791130260;
 x=1791735060; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jx86gKstymxVnMF3e+AFJfLNqAxcdhv8WJ6fFIrS9XQ=;
 b=Sh512eeYQDOh/2ZxOiqRDF+wanMhBfAKwqE+7tNP1mAljk2ocyf1DLXan5iysMKESl
 9hzmJjqKkFwWpMBR6TjtD3lszoeRctKe/SuDWhqKJKkNZu93dOn9lPumtmsKZAQqwzll
 ZK+KOHOzDMGdzOFxmrboeohze1SRaVAWsXJBU8Cxmp4W2WB/9o0cy5KUvX5GPk8Y1pX6
 7HTp2iYICFF2bfjEteTKp6X2NMAcEhl5Wu/D366vjFqicx6r+SULrxzxp+C+7yYPldUa
 lBiTsTZqyst+BdF9nHIJYseAF0Kr67yTGuvKPUNDHsl5m5Di6k3QE1lWsif7jldIMCi8
 7kOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791130260; x=1791735060;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jx86gKstymxVnMF3e+AFJfLNqAxcdhv8WJ6fFIrS9XQ=;
 b=ljkwKNN/K78+/JmZ9v2saMcU1Isdb3oU1GNl4hzO2wV0Qa5MPtrCWgbvFHlcWWDF9o
 JMjAofXeCmGEwGaKEN2OhRjorUGgF8tvoGIg5W1TToDEI/3+RvaEEX7x9EQD1G7bg/bk
 bwnTSRX94NSd9iXgPcRbB6qxNeCJC7pGd/1QN0ArpFpo1zbk5yRW1YqGZrmV+02iBzWm
 RzmoJBRuCSpovrWVECBCnunItnk4xlWQDsEzclkjgi67kmil3ZouXR7RJb3+UVxFQcar
 1MA1EphqeKbf9YsJweSbt6JS7joUDi95SiyHFEiH/KnbSWBG0a+OzLYfNml5xwg2WnuW
 kJyw==
X-Gm-Message-State: AFq9FYIMwqVhL7Ono3Ga8YWPmntiR74FW4mRFjkMxQm6arqE3FzXkjpD
 9ku+av/Nt5o61Rctjixbw/6QpFKHFEWT1if9SJrTmaEQQOjEOkhZGBsoUce/UA5O5iB3BBrVW8c
 PT2UDx0c=
X-Gm-Gg: AYBFou3kP1cFshvI+xg4DfpOHGy8ZbRgeNWdtCnEAhfABOOrrlitpRJxFNVm+h5lLDR
 PVPSqmmBGl3OcmZRsUyJXE6tbT9l90e1/tCnD0zvJfiiV7CJRIddiG83sFa+zOwKuvh9im545PK
 oMsci7QL1G/qWDZRUPXpa6VpWUDRWD8dsggJg8aSVrjccPuSAsv8IIeJpnIMDJkCTbS5as+HVRg
 kvJMCU4gzSQSKEdlLqXpe0c8uRUqfh5E4yuksLIICJh5rB2JkhXyHZ2nHmnCObQ/3B3tehUHzlc
 rpVAwdFxpeTbLnkcFQLQWIjJ2On/8Nygk6miZJWK+eNTUFEjbxNrWkAsLlsT4Mgqbo4bfyC7gEE
 MnVb1TO9vxLP77syUOv6d5yniFhh8nhUkGDl1zxmyPfJFJaIuzB+SW1dNoTefRl0fDvaEsy2ZlI
 XW9H8Sp6+OBjCLqDHMDshVkmrhyPxjkRXNjNZpyhOnZuYVaTt63+DpaIxHoceXT3Cd3SfXLI8mv
 HgRGFUT7hwK9TCV5UWSbcmEmULxhl+CwHvD5u3L
X-Received: by 2002:a17:90b:33cc:b0:3a2:aec0:6bc2 with SMTP id
 98e67ed59e1d1-3a6ced50989mr7372476a91.53.1791130260436; 
 Sun, 04 Oct 2026 09:11:00 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a78d687e85sm7136021a91.9.2026.10.04.09.10.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 09:10:59 -0700 (PDT)
Date: Sun, 4 Oct 2026 09:10:57 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Frank Dressler <frank@dressler.pro>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>
Subject: Re: [PATCH] net/af_packet: add capture direction option
Message-ID: <20261004091057.2c0fb83a@phoenix.local>
In-Reply-To: <20261004042255.1517316-1-frank@dressler.pro>
References: <20261004042255.1517316-1-frank@dressler.pro>
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

On Sun,  4 Oct 2026 05:22:54 +0100
Frank Dressler <frank@dressler.pro> wrote:

> By default, AF_PACKET sockets capture both incoming and outgoing
> packets. This leads to unexpected behavior in the AF_PACKET PMD
> since other PMDs only return actually received packets in
> rte_eth_rx_burst() calls.
> 
> This patch adds an option capture_dir=<in|out|inout> that controls
> which packets are received, similar to tcpdump's -Q option.
> 
> The PMD never sees its own TX on RX, but TX from other sources on
> the same netdev is still seen. Use inout for tcpdump-like tools and
> in for applications that send and receive.
> 
> The default is "inout" so that existing software keeps working as
> before.
> 
> The filter checks the packet type in the struct sockaddr_ll that
> comes with each packet. Each TPACKET_V2 packet is laid out as
>   struct tpacket2_hdr | struct sockaddr_ll | packet data.
> The kernel sets sockaddr_ll::sll_pkttype to skb->pkt_type, which is
> PACKET_OUTGOING for outgoing packets (set by dev_queue_xmit_nit())
> and a different value otherwise. Libpcap's linux_check_direction()
> uses the same check.
> 
> A unit test injects OUTGOING traffic from a second port on the same
> TAP and checks in/out/inout filtering.
> 
> Signed-off-by: Frank Dressler <frank@dressler.pro>

The AF_PACKET PMD is special case really intended for monitoring
applications, not for general use. You are probably better off using AF_XDP
for general use. 

The kernel does have flags to filter by direction, so you could
avoid having it be done in the PMD.

