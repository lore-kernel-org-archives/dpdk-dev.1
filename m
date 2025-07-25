Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD91C87FCE
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Jul 2025 13:39:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D25B402D5;
	Fri, 25 Jul 2025 15:39:36 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 5D18B402D5
 for <dev@dpdk.org>; Fri, 25 Jul 2025 15:39:35 +0200 (CEST)
Received: from debian (unknown [78.109.66.179])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 7DFF5E0568;
 Fri, 25 Jul 2025 17:39:33 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 7DFF5E0568
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1753450775;
 bh=57L306Zg9HieGwvASZnRiMsx43QnUpTGBUnWwRd6XnY=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=AiYdostenC5WyZ40U5Uv8Abix3fTBqCg9Zg99UOJllQOS72knY6vxNlmUbcqGNV8y
 IB/o8npRCB/ZvcunIwz9hwmGk8YRSm48o3nMWtBz7aJ8DG7kIegEBWPLggTqsJncsK
 2fu0M0xxgCxT6UHz1cykqFmc+vM7mF3eBkcIn+KHBnI7MnQmNAOP6ddWl+Q2q2zStK
 nOvtW/juvOjIx1pF0Dhx9VyeD2eR30r7OFC8qWHy7v9XksNISsZQA7a5oLbIIMXI/Z
 wTYNdOW/fBKgoTooqeoV0SLm+41ZDj5ADHU21NTYrmG2bWbYJei5MxfacF6QyQgfIk
 P88YSECB9Hz5Q==
Date: Fri, 25 Jul 2025 17:39:28 +0400 (+04)
From: Ivan Malov <ivan.malov@arknetworks.am>
To: Jie Liu <liujie5@linkdatatechnology.com>
cc: stephen@networkplumber.org, dev@dpdk.org
Subject: Re: [PATCH 01/13] net/sxe: add base driver directory and doc
In-Reply-To: <20250425023652.37368-1-liujie5@linkdatatechnology.com>
Message-ID: <d23c1db1-9ffe-d68a-23df-5e410f418aa0@arknetworks.am>
References: <20250425023652.37368-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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

Hi,

(please see below)

On Thu, 24 Apr 2025, Jie Liu wrote:

> From: JieLiu <liujie5@linkdatatechnology.com>
>
> Adding a minimum maintainable directory structure for the
> network driver and request maintenance of the sxe driver.
>
> Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
> ---
> MAINTAINERS                         |  6 +++
> doc/guides/nics/features/sxe.ini    | 82 +++++++++++++++++++++++++++++
> doc/guides/nics/features/sxe_vf.ini | 39 ++++++++++++++
> doc/guides/nics/index.rst           |  1 +
> doc/guides/nics/sxe.rst             | 71 +++++++++++++++++++++++++
> drivers/net/sxe/meson.build         |  9 ++++
> drivers/net/sxe/pf/sxe_ethdev.c     |  3 ++
> drivers/net/sxe/pf/sxe_ethdev.h     |  3 ++
> 8 files changed, 214 insertions(+)
> create mode 100644 doc/guides/nics/features/sxe.ini
> create mode 100644 doc/guides/nics/features/sxe_vf.ini
> create mode 100644 doc/guides/nics/sxe.rst
> create mode 100644 drivers/net/sxe/meson.build
> create mode 100644 drivers/net/sxe/pf/sxe_ethdev.c
> create mode 100644 drivers/net/sxe/pf/sxe_ethdev.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 82f6e2f917..f92f4fea81 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2055,3 +2055,9 @@ F: examples/vmdq/
> F: doc/guides/sample_app_ug/vmdq_forwarding.rst
> F: examples/vmdq_dcb/
> F: doc/guides/sample_app_ug/vmdq_dcb_forwarding.rst
> +
> +Linkdata sxe
> +M: Jie Li <lijie@linkdatatechnology.com>
> +F: drivers/net/sxe/
> +F: doc/guides/nics/sxe.rst
> +F: doc/guides/nics/features/sxe*.ini
> diff --git a/doc/guides/nics/features/sxe.ini b/doc/guides/nics/features/sxe.ini
> new file mode 100644
> index 0000000000..b61ad7c699
> --- /dev/null
> +++ b/doc/guides/nics/features/sxe.ini
> @@ -0,0 +1,82 @@
> +;
> +; Supported features of the 'sxe' network poll mode driver.
> +;
> +; Refer to default.ini for the full list of available PMD features.
> +;
> +[Features]
> +Speed capabilities   = Y
> +Link speed configuration = Y
> +Link status          = Y
> +Link status event    = Y
> +Rx interrupt         = Y
> +Queue start/stop     = Y
> +Power mgmt address monitor = Y
> +MTU update           = Y
> +Scattered Rx         = Y
> +LRO                  = Y
> +TSO                  = Y
> +Promiscuous mode     = Y
> +Allmulticast mode    = Y
> +Unicast MAC filter   = Y
> +Multicast MAC filter = Y
> +RSS hash             = Y
> +RSS key update       = Y
> +RSS reta update      = Y
> +VMDq                 = Y
> +SR-IOV               = Y
> +DCB                  = Y
> +VLAN filter          = Y
> +Flow control         = Y
> +Rate limitation      = Y
> +Traffic manager      = Y
> +Inline crypto        = Y
> +CRC offload          = P
> +VLAN offload         = P
> +QinQ offload         = P
> +L3 checksum offload  = P
> +L4 checksum offload  = P
> +MACsec offload       = P
> +Inner L3 checksum    = P
> +Inner L4 checksum    = P
> +Packet type parsing  = Y
> +Timesync             = Y
> +Rx descriptor status = Y
> +Tx descriptor status = Y
> +Basic stats          = Y
> +Extended stats       = Y
> +Stats per queue      = Y
> +FW version           = Y
> +EEPROM dump          = Y
> +Module EEPROM dump   = Y
> +Registers dump       = Y
> +Multiprocess aware   = Y
> +FreeBSD              = Y
> +Linux                = Y
> +ARMv8                = Y
> +LoongArch64          = Y
> +rv64                 = Y
> +x86-32               = Y
> +x86-64               = Y
> +
> +[rte_flow items]
> +eth                  = P
> +e_tag                = Y
> +fuzzy                = Y
> +ipv4                 = Y
> +ipv6                 = Y
> +nvgre                = Y
> +raw                  = Y
> +sctp                 = Y
> +tcp                  = Y
> +udp                  = Y
> +vlan                 = P
> +vxlan                = Y
> +
> +[rte_flow actions]
> +drop                 = Y
> +mark                 = Y
> +pf                   = Y
> +queue                = Y
> +rss                  = Y
> +security             = Y
> +vf                   = Y
> diff --git a/doc/guides/nics/features/sxe_vf.ini b/doc/guides/nics/features/sxe_vf.ini
> new file mode 100644
> index 0000000000..49eaeaaaae
> --- /dev/null
> +++ b/doc/guides/nics/features/sxe_vf.ini
> @@ -0,0 +1,39 @@
> +;
> +; Supported features of the 'sxe_vf' network poll mode driver.
> +;
> +; Refer to default.ini for the full list of available PMD features.
> +;
> +[Features]
> +Link status          = Y
> +Rx interrupt         = Y
> +Power mgmt address monitor = Y
> +MTU update           = Y
> +Scattered Rx         = Y
> +LRO                  = Y
> +TSO                  = Y
> +Promiscuous mode     = Y
> +Allmulticast mode    = Y
> +Unicast MAC filter   = Y
> +RSS hash             = Y
> +RSS key update       = Y
> +RSS reta update      = Y
> +VLAN filter          = Y
> +Inline crypto        = Y
> +CRC offload          = P
> +VLAN offload         = P
> +QinQ offload         = P
> +L3 checksum offload  = P
> +L4 checksum offload  = P
> +Inner L3 checksum    = P
> +Inner L4 checksum    = P
> +Packet type parsing  = Y
> +Rx descriptor status = Y
> +Tx descriptor status = Y
> +Basic stats          = Y
> +Extended stats       = Y
> +Registers dump       = Y
> +FreeBSD              = Y
> +Linux                = Y
> +ARMv8                = Y
> +x86-32               = Y
> +x86-64               = Y
> diff --git a/doc/guides/nics/index.rst b/doc/guides/nics/index.rst
> index 10a2eca3b0..67e6374c69 100644
> --- a/doc/guides/nics/index.rst
> +++ b/doc/guides/nics/index.rst
> @@ -72,3 +72,4 @@ Network Interface Controller Drivers
>     vmxnet3
>     xsc
>     zxdh
> +    sxe
> diff --git a/doc/guides/nics/sxe.rst b/doc/guides/nics/sxe.rst
> new file mode 100644
> index 0000000000..d86d15bec8
> --- /dev/null
> +++ b/doc/guides/nics/sxe.rst
> @@ -0,0 +1,71 @@
> +..  SPDX-License-Identifier: BSD-3-Clause
> +    Copyright (C), 2022, Linkdata Technology Co., Ltd.

Why not 2025?

> +
> +SXE Poll Mode Driver
> +======================
> +
> +The SXE PMD (librte_pmd_sxe) provides poll mode driver support
> +for Linkdata 1160-2X 10GE Ethernet Adapter.
> +
> +Features
> +--------
> +- PXE boot
> +- PTP(Precision Time Protocol)

Consider: 'PTP (precision time protocol)'.

> +- VMDq(Virtual Machine Device Queues)

Consider: 'VMDq (virtual machine devise queues)'.

> +- SR-IOV,max 2PF,63VF per PF

Consider: 'SR-IOV, max. 2 PFs, 63 VFs per PF'.

> +- 128 L2 Ethernet MAC Address Filters (unicast and multicast)
> +- 64 L2 VLAN filters
> +- pldm over mctp over smbus
> +- 802.1q VLAN
> +- Low Latency Interrupts
> +- LRO
> +- Promiscuous mode
> +- Multicast mode
> +- Multiple queues for TX and RX

Consider to spell it as 'Tx' and 'Rx.

> +- Receiver Side Scaling (RSS)

For consistency, 'RSS (receive side scaling)', may be?

> +- MAC/VLAN filtering
> +- Packet type information
> +- Checksum offload
> +- VLAN/QinQ stripping and inserting
> +- TSO offload
> +- Port hardware statistics
> +- Link state information
> +- Link flow control
> +- Interrupt mode for RX
> +- Scattered and gather for TX and RX

Consider to spell it as 'Tx' and 'Rx'.

> +- DCB
> +- IEEE 1588
> +- FW version
> +- Generic flow API
> +
> +Configuration
> +-------------
> +
> +Dynamic Logging Parameters
> +~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +One may leverage EAL option "--log-level" to change default levels
> +for the log types supported by the driver. The option is used with
> +an argument typically consisting of two parts separated by a colon.
> +
> +SXE PMD provides the following log types available for control:
> +
> +- ``pmd.net.sxe.drv`` (default level is **DEBUG**)
> +
> +  Affects driver-wide messages unrelated to any particular devices.
> +
> +- ``pmd.net.sxe.init`` (default level is **DEBUG**)
> +
> +  Extra logging of the messages during PMD initialization.
> +
> +- ``pmd.net.sxe.rx`` (default level is **DEBUG**)
> +
> +  Affects rx-wide messages.

Perhaps 'rx' -> 'Rx'.

> +- ``pmd.net.sxe.tx`` (default level is **DEBUG**)

Perhaps 'tx' -> 'Tx'.

> +
> +  Affects tx-wide messages.

Why is 'DEBUG' used by default? Won't it overwhelm the screen with messages?

Thank you.

> +
> +------------------------------
> +
> +Refer to the document :ref:`compiling and testing a PMD for a NIC <pmd_build_and_test>`
> +for details.
> diff --git a/drivers/net/sxe/meson.build b/drivers/net/sxe/meson.build
> new file mode 100644
> index 0000000000..dad9ee44a0
> --- /dev/null
> +++ b/drivers/net/sxe/meson.build
> @@ -0,0 +1,9 @@
> +# SPDX-License-Identifier: BSD-3-Clause
> +# Copyright (C), 2020, Wuxi Stars Micro System Technologies Co., Ltd.
> +
> +deps += ['hash']
> +sources = files(
> +        'pf/sxe_ethdev.c',
> +)
> +
> +includes += include_directories('pf')
> diff --git a/drivers/net/sxe/pf/sxe_ethdev.c b/drivers/net/sxe/pf/sxe_ethdev.c
> new file mode 100644
> index 0000000000..e31a23deeb
> --- /dev/null
> +++ b/drivers/net/sxe/pf/sxe_ethdev.c
> @@ -0,0 +1,3 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright(c) 2015-2024
> + */
> diff --git a/drivers/net/sxe/pf/sxe_ethdev.h b/drivers/net/sxe/pf/sxe_ethdev.h
> new file mode 100644
> index 0000000000..e31a23deeb
> --- /dev/null
> +++ b/drivers/net/sxe/pf/sxe_ethdev.h
> @@ -0,0 +1,3 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright(c) 2015-2024
> + */
> -- 
> 2.18.4
>
>
