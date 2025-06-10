Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 298A8C61CE8
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Jun 2025 00:20:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2D2BA41109;
	Tue, 10 Jun 2025 02:20:22 +0200 (CEST)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com
 [209.85.222.179])
 by mails.dpdk.org (Postfix) with ESMTP id A3A5740276
 for <dev@dpdk.org>; Tue, 10 Jun 2025 02:20:20 +0200 (CEST)
Received: by mail-qk1-f179.google.com with SMTP id
 af79cd13be357-7d2107eb668so765820285a.1
 for <dev@dpdk.org>; Mon, 09 Jun 2025 17:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1749514820;
 x=1750119620; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b7OC2qfIZsZs6aBFWfsv9+eYN+iSzzNbLGbKIIR4oRU=;
 b=PrPi24IDdFnw5zGhPWJJOSrR85nRzil3VHHO/Aob4UK3My3irPZTyhgTh7YngNCJlc
 5Jvse0VnVzJ6OtTRBPmgjgo1SKNn8OtuPSqxXKLPJsyA2R7W0Qe6022q7W6uqjKqnfon
 EyHlWQv/aWwl0zMNvM3KNZRQH3LEv6BhONWeom2FogzKhYYDenMfMZmuzg3G6h1Z9nxP
 hzxSmp1ZEadjkkj7Ot3oW3MRzdxPDFFIF/mr6aT+XxR+WwJT7kINnoYiPI50V4vuL4sJ
 R2ev4+nmMXSqOPnuMTg/Kp969rbUopcOIxPbvxxOsP7kl5YtaMW+dAUnq/QyPvEgBDnR
 584A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749514820; x=1750119620;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b7OC2qfIZsZs6aBFWfsv9+eYN+iSzzNbLGbKIIR4oRU=;
 b=IJBfVrU7vVZF1hnM1J18ISVcGL37MQAekL27Uuq8AdLsI2HdF+UeqQ9npbLsJPHuEn
 CQ3/0hBHk6S/9Lel5MQQSISHa1BEZpzBx/B057Vsj8G8Lvsq9CDA6mPxhKBt+8XCjI24
 Kwl+4AVjMGs1nJdVTL5ZMEQmXHqTiwBBI//Njso49fBVchvW/vqX2p42PZG6ZVnzbAJ7
 Ah2t6b8YeCCRPCGDh3d14B37FvVhR2uclM890OGOkvcX/ATgnwnVPdkqV2Rmwqm6sGHt
 KUEvZoB+JvZtNnsSLOuc6sUudJtm5KSyZPd9A6RWpSHjwv/P+xPSv0wQe/SJ/vJwC8US
 R8zw==
X-Gm-Message-State: AOJu0YwuzmBmrD0fk0sYb8NLHsU2spH+yWDaIOuCV4f0+fGpY75dcYTF
 NAZoFaW6HdfyJaFeKIq68Z7YtqzmbyB5SZBm5y/u5YYW+PWXDqfjlhhAVNe4PiRG6QFnsEvB1/p
 fdCJM
X-Gm-Gg: ASbGnctjnnRtj+4fYon6JyE7p1NcFVrucEK6E55/SX12vR/pPN4CNXFa1ZsE8uz3InH
 9yq2NrZh7bYIJbtkJpkyagkFmYIjWm4n7KQCLAYMdlo/lDpnOQC5ifBnSLFbA8rVv9oklFaSsD4
 vv1RTtqSMPu+S2KhxGFlc3y7V6bYpJ/Q9jtiPBNmZEoIH70HQsCzq0/LOwLyXMgLTlThiT4W9ro
 cg5cMsukP+u7nOtnYnL8y8h+fWRnzmz+tSt5CBmITzyjSlIf05OipPV1d/bQGeJhpdYGbGVVkQW
 tSO1GQjuvwK35BfxaJzvwmCR+J9+95Vdpx+TQMYsfJNX/b38JSCzWwPTnArpokR34PA6o3OUAuB
 I2t2Fvla3vBjU64BVo9nyF7ZI/y5K2txIZfeuobSargcDRPwoUw==
X-Google-Smtp-Source: AGHT+IHN+QmRLwdSIaajTv6ZgrdeDBYFvSASqCBLJ+hs3QgsvjTmj+kBnRn89JjVy7HVwrWR2PrbMw==
X-Received: by 2002:a05:620a:1919:b0:7d3:99da:bdbc with SMTP id
 af79cd13be357-7d399dac48bmr623800485a.36.1749514819672; 
 Mon, 09 Jun 2025 17:20:19 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d2669b3b3asm607857385a.103.2025.06.09.17.20.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 17:20:19 -0700 (PDT)
Date: Mon, 9 Jun 2025 17:20:15 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Wencheng Li <liwencheng@phytium.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v9 0/3] net/macb: updated net macb driver
Message-ID: <20250609172015.475d2976@hermes.local>
In-Reply-To: <1749200714-53359-1-git-send-email-liwencheng@phytium.com.cn>
References: <1749020337-44001-1-git-send-email-liwencheng@phytium.com.cn>
 <1749200714-53359-1-git-send-email-liwencheng@phytium.com.cn>
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

On Fri,  6 Jun 2025 09:05:14 +0000
Wencheng Li <liwencheng@phytium.com.cn> wrote:

> v9:
> - Added RTE_PMD_REGISTER_KMOD_DEP macro to
>  declare dependency on macb_uio kernel module.
> - The source link for the macb_uio module
>  can be found in macb.rst.
> 
> v8:
> - Delete log level reset code.
> - Delete code that links to external phy library.
> - Update document macb.rst.
> - Add usage instructions for the macb_uio module.
> - Update the explanation of testpmd parameters.
> 
> v7:
> - Use a legal name instead of an email alias.
> - Do not use additional __rte_cold.
> - Replace unsigned long with standard uint64_t.
> - Describe the devargs used by the driver in the documentation.
> - Update macb.ini.
> 
> v6:
> - Fixed build failures across different OS.
> 
> v5:
> - Putting __rte_unused after the declaration.
> - Correct RX-bytes and TX-bytes statistics.
> - Initialize the mbuf_initializer.
> - Add driver based on 25.07.
> - Fixed some code style issues.
> 
> v4:
> - Fix tab errors in meson.build file.
> - Use RTE_LOG_LINE instead of rte_log.
> - Replace %l with %PRI*64.
> - Replace rte_smp_[r/w]mb with rte_[r/w]mb.
> - Do not use variadic arguments in macros.
> - Do not use variable-length array pkts[nb_bufs].
> - Use __rte_cache_aligned only for struct or union types alignment.
> - Support hardware Rx/Tx checksum offload.
> - Fixed some code style issues.
> v3:
> - Changed functions that always return 0 and whose return value
> is unused to void type, improving code simplicity and readability.
> - Fixed the implicit conversion issues in the
> macb_usxgmii_pcs_check_for_link and
> macb_usxgmii_pcs_check_for_link functions.
> - Added the missing SPDX license tags.
> - Added the missing mailmap entry.
> - Updated the MAINTAINERS file to include the missing information.
> 
> v2:
> - Split the driver into three logically independent patches,
> rather than one large patch.
> - Added conditional compilation to address the issue of
> macb_rxtx_vec_neon.c failing to compile in certain modes.
> - Fixed some code style issues.
> 
> v1:
> - updated net macb driver.
> 
> *** BLURB HERE ***
> 
> Wencheng Li (3):
>   net/macb: add new poll mode driver
>   net/macb: add NEON vectorized Rx/Tx
>   net/macb: add necessary docs and update related files
> 
>  .mailmap                               |    1 +
>  MAINTAINERS                            |    6 +
>  doc/guides/nics/features/macb.ini      |   19 +
>  doc/guides/nics/index.rst              |    1 +
>  doc/guides/nics/macb.rst               |  181 ++++
>  doc/guides/rel_notes/release_25_07.rst |    4 +
>  drivers/net/macb/base/generic_phy.c    |  271 +++++
>  drivers/net/macb/base/generic_phy.h    |  202 ++++
>  drivers/net/macb/base/macb_common.c    |  670 ++++++++++++
>  drivers/net/macb/base/macb_common.h    |  253 +++++
>  drivers/net/macb/base/macb_errno.h     |   58 ++
>  drivers/net/macb/base/macb_hw.h        | 1138 ++++++++++++++++++++
>  drivers/net/macb/base/macb_type.h      |   23 +
>  drivers/net/macb/base/macb_uio.c       |  351 +++++++
>  drivers/net/macb/base/macb_uio.h       |   50 +
>  drivers/net/macb/base/meson.build      |   25 +
>  drivers/net/macb/macb_ethdev.c         | 1765 ++++++++++++++++++++++++++++++++
>  drivers/net/macb/macb_ethdev.h         |   75 ++
>  drivers/net/macb/macb_log.h            |   19 +
>  drivers/net/macb/macb_rxtx.c           | 1394 +++++++++++++++++++++++++
>  drivers/net/macb/macb_rxtx.h           |  325 ++++++
>  drivers/net/macb/macb_rxtx_vec_neon.c  |  675 ++++++++++++
>  drivers/net/macb/meson.build           |   22 +
>  drivers/net/meson.build                |    1 +
>  24 files changed, 7529 insertions(+)
>  create mode 100644 doc/guides/nics/features/macb.ini
>  create mode 100644 doc/guides/nics/macb.rst
>  create mode 100644 drivers/net/macb/base/generic_phy.c
>  create mode 100644 drivers/net/macb/base/generic_phy.h
>  create mode 100644 drivers/net/macb/base/macb_common.c
>  create mode 100644 drivers/net/macb/base/macb_common.h
>  create mode 100644 drivers/net/macb/base/macb_errno.h
>  create mode 100644 drivers/net/macb/base/macb_hw.h
>  create mode 100644 drivers/net/macb/base/macb_type.h
>  create mode 100644 drivers/net/macb/base/macb_uio.c
>  create mode 100644 drivers/net/macb/base/macb_uio.h
>  create mode 100644 drivers/net/macb/base/meson.build
>  create mode 100644 drivers/net/macb/macb_ethdev.c
>  create mode 100644 drivers/net/macb/macb_ethdev.h
>  create mode 100644 drivers/net/macb/macb_log.h
>  create mode 100644 drivers/net/macb/macb_rxtx.c
>  create mode 100644 drivers/net/macb/macb_rxtx.h
>  create mode 100644 drivers/net/macb/macb_rxtx_vec_neon.c
>  create mode 100644 drivers/net/macb/meson.build
> 

Driver is looking much better, still see some issues to address.
All check scrips and builds passed.

Uio
    The macb_uio driver has its own issues. It should be submitted and reviewed
    first. Maybe the ARM maintainers have better idea on how to read platform
    values.

Multiq
    Having multiple queues (8) without RSS is confusing.
    If you have 8 Rx queues, then in theory without RSS or RTE flow
    all packets should arrive on only one queue. I doubt that is what
    this hardware does.

Pragmas
    Using pragmas should be avoided.
    Why does vector neon need to disable cast-qual?

Dead code
    Why does base/macb_common.h include a spinlock, but it is  never used?


Name conflicts
    Symbol namespace issues (static linkage).
    C does not have namespaces, all drivers need to play nice and not
    overlap with libraries and each other.

 $ nm build/drivers/librte_net_macb.a | grep ' T ' | grep -v ' macb_'
0000000000000330 T get_last_num_from_string
00000000000000ec T hw_is_native_io
000000000000053e T genphy_check_for_link
00000000000003c4 T genphy_force_speed_duplex
00000000000005c5 T genphy_read_status
00000000000002ee T genphy_resume
000000000000027f T genphy_soft_reset
0000000000000360 T genphy_suspend
0000000000008068 T eth_macb_recv_pkts
0000000000015226 T eth_macb_recv_pkts_vec
000000000000862c T eth_macb_recv_scattered_pkts
000000000001523f T eth_macb_recv_scattered_pkts_vec
0000000000014f98 T eth_macb_rx_init
0000000000014058 T eth_macb_rx_queue_release
00000000000144a9 T eth_macb_rx_queue_setup
000000000000d86a T eth_macb_tx_init
000000000000cdb8 T eth_macb_tx_queue_release
000000000000cf9d T eth_macb_tx_queue_setup
0000000000005a75 T eth_macb_xmit_pkts
0000000000015258 T eth_macb_xmit_pkts_vec


> +int get_last_num_from_string(char *buf, int *id)
> +{
> +	int len = strlen(buf);
> +	int i, found = 0;
> +
> +	for (i = len - 1; (i >= 0); i--) {
> +		if (isdigit(buf[i]))
> +			found++;
> +		else if (found)
> +			break;
> +	}
> +
> +	if (found) {
> +		*id = atoi(&buf[i + 1]);
> +		return 0;
> +	}
> +
> +	return -1;
> +}
> +

Only called in macb_common.c so should be static.
This avoid exposing non-macb function names in static linkage.

Whitespace

> +/**
> + * DPDK callback to get device statistics.
> + *
> + * @param dev
> + *   Pointer to Ethernet device structure.
> + * @param stats
> + *   Stats structure output buffer.
> + *
> + * @return
> + *   0 on success, negative error value otherwise.
> + */
> +static int eth_macb_stats_get(struct rte_eth_dev *dev,
> +							  struct rte_eth_stats *stats)
> +{

The indentation style here (and a couple of other places) is odd.
Please indent so that the arguments line up not so far right.

If in doubt, use clang-format to find/fix things



> +static int eth_macb_stats_get(struct rte_eth_dev *dev,
> +							  struct rte_eth_stats *stats)
> +{
> +	struct macb_priv *priv = dev->data->dev_private;
> +	struct gem_stats *hwstat = &priv->bp->hw_stats.gem;
> +
> +	if (!priv->bp) {
> +		MACB_LOG(ERR, "Failed to get private data!");
> +		return -EPERM;
> +	}
> +

You are checking in several places for something that should never happen.
You are setting priv->bp as part of the init/probe process.
Maybe use RTE_ASSERT()?


> +static int eth_macb_set_default_mac_addr(struct rte_eth_dev *dev,
> +				     struct rte_ether_addr *mac_addr)
> +{
> +	struct macb_priv *priv = dev->data->dev_private;
> +	struct macb *bp = priv->bp;
> +
> +	if (!rte_is_valid_assigned_ether_addr(mac_addr)) {
> +		MACB_LOG(ERR, "Tried to set invalid MAC address.");
> +		return -EINVAL;
> +	}
> +

This check is already done by caller rte_eth_dev_default_mac_addr_set

> +static int rte_pmd_macb_remove(struct rte_vdev_device *vdev)
> +{
> +	uint16_t dev_id;
> +	int ret = 0;
> +
> +	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
> +		return 0;
> +
> +	RTE_ETH_FOREACH_DEV(dev_id)
> +	{
> +

Minor nit:
Prefer { on same line as RTE_ETH_FOREACH_DEV
