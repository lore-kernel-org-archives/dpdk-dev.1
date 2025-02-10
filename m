Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D39C0219B
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 19:04:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 93BFF4064C;
	Mon, 10 Feb 2025 20:04:24 +0100 (CET)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by mails.dpdk.org (Postfix) with ESMTP id 1FDDE40615
 for <dev@dpdk.org>; Mon, 10 Feb 2025 20:04:23 +0100 (CET)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-21f50895565so50082835ad.2
 for <dev@dpdk.org>; Mon, 10 Feb 2025 11:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739214262;
 x=1739819062; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vIuazVlvULVs868BppSNdpL1YPcYBYd5hLbiAQoiRH8=;
 b=yaWdpCQreuNUG98KxJB3tIRFTCl2RfYU8ioqHTyIiB63jgYQ0JGO7IsufFb3l3B+lP
 QIQhLK+vJjRu9rf6ahM3+6KntVWhlp+oVUtv4X6TI35FynEqvGaBWzxoUXa9sF4+HFVt
 jG8M05pD1Qamqiy0/c0+eWbbb94LGyUg2H15U68oABOEb+bdmfDYIuegYhy2Yae6+8yn
 T7Rog1sBNK7YfhPB6H0b+FJZ+naKs3UV7UA/7KwYRxKsuimB+R5jfNa65wTTRplr+tmq
 v9qRjWCbAmmj8odc0HSvjFNrEFgZKFT4CRL3kXQmBIIbJ2HiTTE0QDNJP42/z244cWAY
 M+Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739214262; x=1739819062;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vIuazVlvULVs868BppSNdpL1YPcYBYd5hLbiAQoiRH8=;
 b=OxGGWciKLL0cXwFHTqeXlrpE2/iK85tpaebcf/UhHLLKstnECx5SLZloIuHFKojwA3
 hnGeeP3C1coDS68pQ2HWgJ4fLMX9IDpQk2pPmiiDZZzD0YZpYechP2UhcjbvYzGbKdWx
 gzyHvUk8GACsZc07WZlekYMCnH7vQakrCxpok3cvOCduxaz9KN9osna3GCTBYOjG2cHw
 NK1jDIwRa69y0OUAC3wzNRiJUyYiX/O3mNm6fkD2n/DzyaenTJtX+6oRM36KSFlIcj+Y
 +2ZozdS5Q5zSZI1oUCFFpJvU1SUefrmvgH7m28K87Z/cc1yHCGUprPJ3DznLb9BguXMY
 b0fQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaZiCdiM2btifsxE6PxX1ZL6q+6e044hiwN8utD43+UMMzbM3apNgjAmPSnZ4pB2XUy+I=@dpdk.org
X-Gm-Message-State: AOJu0YwG4t5MPh1XlTOoIsYLo5wb2pI/8JlNh+qMp3sDx8ypHLEtB6aN
 vXg3O4nXQ9ND3VKU4vgQ8+0p0Yg3vewh8JMeb0U79VnjXZreL/uY7EHb+uUMPiA=
X-Gm-Gg: ASbGncsLQ6dvwdQbxNZoKVhv39BujHmSkQFTGY1+zqjwx/yC/lXFCJ73NaSaSYRsbT4
 7rGdLqfKPI4v/A//B2hpr3bX+77m8WXWzQ/KNbsAi6cNXpuYvIyOquNSFp/N3rY3zhy/o7b2M2K
 Cv0f+3Yxk/Yu6RRSEliBv7zd5YxU/fxrZrPNdDaSEl2sRItZ3EVHkyIjDDsAc6iERG7SKv5oyPq
 EfCd//e86y+QwB4X60xMC9lY/1W868HoAhowc0Qx70VZ0RBj9Jy5UOfVeei6fkE+jwT+aifRlqL
 M69jTDLUAQ1/3jJVZ7lOYNwpP0kD0rXPSSwf/XDy3saZlpy6xc4Ce9To/ziEsDmhKXmE
X-Google-Smtp-Source: AGHT+IEopqLA5y+evhZ7uAlCgWpjbojoNCzYQZzXscrlf0ZaI4VhAWxkgLepTAriRMtlPIxNTIg5VQ==
X-Received: by 2002:a05:6a20:12c9:b0:1e1:cbbf:be0 with SMTP id
 adf61e73a8af0-1ee49e819aemr1524396637.22.1739214262338; 
 Mon, 10 Feb 2025 11:04:22 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73077975f05sm4511914b3a.14.2025.02.10.11.04.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 11:04:21 -0800 (PST)
Date: Mon, 10 Feb 2025 11:02:35 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Wenbo Cao <caowenbo@mucse.com>
Cc: thomas@monjalon.net, dev@dpdk.org, ferruh.yigit@amd.com,
 andrew.rybchenko@oktetlabs.ru, yaojun@mucse.com
Subject: Re: [PATCH v8 00/28] [v8]drivers/net Add Support mucse N10 Pmd Driver
Message-ID: <20250210110235.4940b6fb@hermes.local>
In-Reply-To: <1739172415-48507-1-git-send-email-caowenbo@mucse.com>
References: <1739172415-48507-1-git-send-email-caowenbo@mucse.com>
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

On Mon, 10 Feb 2025 15:26:27 +0800
Wenbo Cao <caowenbo@mucse.com> wrote:

> For This patchset just to support the basic chip init work
> and user can just found the eth_dev, but can't control more.
> For Now just support 2*10g nic,the chip can support
> 2*10g,4*10g,4*1g,8*1g,8*10g.
> The Feature rx side can support rx-cksum-offload,rss,vlan-filter
> flow_clow,uncast_filter,mcast_filter,1588,Jumbo-frame
> The Feature tx side can support tx-cksum-offload,tso,vxlan-tso 
> flow director base on ntuple pattern of tcp/udp/ip/ eth_hdr->type
> for sriov is also support.
> 
> Because of the chip design defect, for multiple-port mode
> one pci-bdf will have multiple-port (max can have four ports)
> so this code must be care of one bdf init multiple-port.
> 
> v8:
>   * fixed codespell issue.
>   * fixed MAINTAINERS file
> 
> v7:
>   * add support nic basic feature such as rss vlan strip/filter,
>   * mtu-change recv/send scater-recv/mutltiple-send.
>   * fixed code rationality, advised by Ferruh Yigit.
> 
> v6:
>   * fixed the doc(rst) format problem advise by Thomas Monjalon
> 
> v5:
>   * fixed the symbol name require by the style documentation
> 
> v4:
>   * one patch has been forgot to upload :(
> 
> v3:
>   * fixed http://dpdk.org/patch/129830 FreeBSD 13 compile Issue
>   * change iobar type to void suggest by Stephen Hemminger
>   * add KMOD_DEP support for vfio-pci
>   * change run-cmd argument parse check for invalid extra_args
> 
> v2:
>   * fixed MAINTAIN maillist fullname format
>   * fixed driver/net/meson the order issue of new driver to driver list
>   * improve virtual point function usage suggest by Stephen Hemminger
> 
> Wenbo Cao (28):
>   net/rnp: add skeleton
>   net/rnp: add ethdev probe and remove
>   net/rnp: add log
>   net/rnp: support mailbox basic operate
>   net/rnp: add device init and uninit
>   net/rnp: add get device information operation
>   net/rnp: add support mac promisc mode
>   net/rnp: add queue setup and release operations
>   net/rnp: add queue stop and start operations
>   net/rnp: add support device start stop operations
>   net/rnp: add RSS support operations
>   net/rnp: add support link update operations.
>   net/rnp: add support link setup operations
>   net/rnp: add Rx burst simple support
>   net/rnp: add Tx burst simple support
>   net/rnp: add MTU set operation
>   net/rnp: add Rx scatter segment version
>   net/rnp: add Tx multiple segment version
>   net/rnp: add support basic stats operation
>   net/rnp: add support xstats operation
>   net/rnp: add unicast MAC filter operation
>   net/rnp: add supported packet types
>   net/rnp: add support Rx checksum offload
>   net/rnp: add support Tx TSO offload
>   net/rnp: support VLAN offloads.
>   net/rnp: add support VLAN filters operations.
>   net/rnp: add queue info operation.
>   net/rnp: support Rx/Tx burst mode info
> 
>  MAINTAINERS                         |    6 +
>  doc/guides/nics/features/rnp.ini    |   33 +
>  doc/guides/nics/index.rst           |    1 +
>  doc/guides/nics/rnp.rst             |  100 ++
>  drivers/net/meson.build             |    1 +
>  drivers/net/rnp/base/meson.build    |   28 +
>  drivers/net/rnp/base/rnp_bdq_if.c   |  398 ++++++
>  drivers/net/rnp/base/rnp_bdq_if.h   |  154 +++
>  drivers/net/rnp/base/rnp_bitrev.h   |   64 +
>  drivers/net/rnp/base/rnp_common.c   |  103 ++
>  drivers/net/rnp/base/rnp_common.h   |   17 +
>  drivers/net/rnp/base/rnp_crc32.c    |   37 +
>  drivers/net/rnp/base/rnp_crc32.h    |   10 +
>  drivers/net/rnp/base/rnp_dma_regs.h |   68 +
>  drivers/net/rnp/base/rnp_eth_regs.h |   90 ++
>  drivers/net/rnp/base/rnp_fw_cmd.c   |  162 +++
>  drivers/net/rnp/base/rnp_fw_cmd.h   |  358 ++++++
>  drivers/net/rnp/base/rnp_hw.h       |  136 ++
>  drivers/net/rnp/base/rnp_mac.c      |  367 ++++++
>  drivers/net/rnp/base/rnp_mac.h      |   34 +
>  drivers/net/rnp/base/rnp_mac_regs.h |  207 +++
>  drivers/net/rnp/base/rnp_mbx.c      |  512 ++++++++
>  drivers/net/rnp/base/rnp_mbx.h      |   58 +
>  drivers/net/rnp/base/rnp_mbx_fw.c   |  499 ++++++++
>  drivers/net/rnp/base/rnp_mbx_fw.h   |   24 +
>  drivers/net/rnp/base/rnp_osdep.h    |  175 +++
>  drivers/net/rnp/meson.build         |   20 +
>  drivers/net/rnp/rnp.h               |  258 ++++
>  drivers/net/rnp/rnp_ethdev.c        | 1829 +++++++++++++++++++++++++++
>  drivers/net/rnp/rnp_link.c          |  439 +++++++
>  drivers/net/rnp/rnp_link.h          |   38 +
>  drivers/net/rnp/rnp_logs.h          |   36 +
>  drivers/net/rnp/rnp_rss.c           |  367 ++++++
>  drivers/net/rnp/rnp_rss.h           |   43 +
>  drivers/net/rnp/rnp_rxtx.c          | 1820 ++++++++++++++++++++++++++
>  drivers/net/rnp/rnp_rxtx.h          |  162 +++
>  36 files changed, 8654 insertions(+)
>  create mode 100644 doc/guides/nics/features/rnp.ini
>  create mode 100644 doc/guides/nics/rnp.rst
>  create mode 100644 drivers/net/rnp/base/meson.build
>  create mode 100644 drivers/net/rnp/base/rnp_bdq_if.c
>  create mode 100644 drivers/net/rnp/base/rnp_bdq_if.h
>  create mode 100644 drivers/net/rnp/base/rnp_bitrev.h
>  create mode 100644 drivers/net/rnp/base/rnp_common.c
>  create mode 100644 drivers/net/rnp/base/rnp_common.h
>  create mode 100644 drivers/net/rnp/base/rnp_crc32.c
>  create mode 100644 drivers/net/rnp/base/rnp_crc32.h
>  create mode 100644 drivers/net/rnp/base/rnp_dma_regs.h
>  create mode 100644 drivers/net/rnp/base/rnp_eth_regs.h
>  create mode 100644 drivers/net/rnp/base/rnp_fw_cmd.c
>  create mode 100644 drivers/net/rnp/base/rnp_fw_cmd.h
>  create mode 100644 drivers/net/rnp/base/rnp_hw.h
>  create mode 100644 drivers/net/rnp/base/rnp_mac.c
>  create mode 100644 drivers/net/rnp/base/rnp_mac.h
>  create mode 100644 drivers/net/rnp/base/rnp_mac_regs.h
>  create mode 100644 drivers/net/rnp/base/rnp_mbx.c
>  create mode 100644 drivers/net/rnp/base/rnp_mbx.h
>  create mode 100644 drivers/net/rnp/base/rnp_mbx_fw.c
>  create mode 100644 drivers/net/rnp/base/rnp_mbx_fw.h
>  create mode 100644 drivers/net/rnp/base/rnp_osdep.h
>  create mode 100644 drivers/net/rnp/meson.build
>  create mode 100644 drivers/net/rnp/rnp.h
>  create mode 100644 drivers/net/rnp/rnp_ethdev.c
>  create mode 100644 drivers/net/rnp/rnp_link.c
>  create mode 100644 drivers/net/rnp/rnp_link.h
>  create mode 100644 drivers/net/rnp/rnp_logs.h
>  create mode 100644 drivers/net/rnp/rnp_rss.c
>  create mode 100644 drivers/net/rnp/rnp_rss.h
>  create mode 100644 drivers/net/rnp/rnp_rxtx.c
>  create mode 100644 drivers/net/rnp/rnp_rxtx.h
> 


Did you do a test build of doc's it shows error:

Warning generate_overview_table(): Unknown feature 'Jumbo frame' in 'rnp.ini'
