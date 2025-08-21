Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5837CA0EF8
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 Aug 2025 08:44:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA7764026C;
	Thu, 21 Aug 2025 10:44:42 +0200 (CEST)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by mails.dpdk.org (Postfix) with ESMTP id 8D67E4026C
 for <dev@dpdk.org>; Thu, 21 Aug 2025 10:44:40 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.88.194])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4c6xcH2XYgz13NTd;
 Thu, 21 Aug 2025 16:41:03 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id D4B12140258;
 Thu, 21 Aug 2025 16:44:37 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 21 Aug 2025 16:44:37 +0800
Message-ID: <204be6b2-b7fa-4e66-a897-6593a8ee60bc@huawei.com>
Date: Thu, 21 Aug 2025 16:44:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [V5 18/18] drivers/net: add hinic3 PMD build and doc files
To: Feifei Wang <wff_light@vip.163.com>, <dev@dpdk.org>
CC: Yi Chen <chenyi221@huawei.com>, Xin Wang <wangxin679@h-partners.com>,
 Feifei Wang <wangfeifei40@huawei.com>
References: <20250418090621.9638-1-wff_light@vip.163.com>
 <20250702020953.599-1-wff_light@vip.163.com>
 <20250702020953.599-19-wff_light@vip.163.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20250702020953.599-19-wff_light@vip.163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemk500009.china.huawei.com (7.202.194.94)
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



On 7/2/2025 10:09 AM, Feifei Wang wrote:
> From: Yi Chen <chenyi221@huawei.com>
> 
> 
> The meson.build file is added to this patch to enable
> 
> the hinic3 compilation function.
> 
> 
> 
> Signed-off-by: Yi Chen <chenyi221@huawei.com>
> 
> Reviewed-by: Xin Wang <wangxin679@h-partners.com>
> 
> Reviewed-by: Feifei Wang <wangfeifei40@huawei.com>
> 
> ---
> 
>  doc/guides/nics/features/hinic3.ini | 61 +++++++++++++++++++++++++++++
> 
>  drivers/net/hinic3/base/meson.build | 50 +++++++++++++++++++++++
> 
>  drivers/net/hinic3/meson.build      | 33 ++++++++++++++++
> 
>  drivers/net/hinic3/mml/meson.build  | 33 ++++------------
> 
>  drivers/net/meson.build             |  1 +
> 
>  5 files changed, 153 insertions(+), 25 deletions(-)
> 
>  create mode 100644 doc/guides/nics/features/hinic3.ini
> 
>  create mode 100644 drivers/net/hinic3/base/meson.build
> 
>  create mode 100644 drivers/net/hinic3/meson.build
> 
> 
> 
> diff --git a/doc/guides/nics/features/hinic3.ini b/doc/guides/nics/features/hinic3.ini
> 
> new file mode 100644
> 
> index 0000000000..f098eb0103
> 
> --- /dev/null
> 
> +++ b/doc/guides/nics/features/hinic3.ini
> 
> @@ -0,0 +1,61 @@
> 
> +;
> 
> +; Supported features of the 'hinic3' network poll mode driver.
> 
> +;
> 
> +; Refer to default.ini for the full list of available PMD features.
> 
> +;
> 
> +[Features]
> 
> +Speed capabilities   = Y
> 
> +Link speed configuration = Y
> 
> +Link status          = Y
> 
> +Link status event    = Y ?

why add one extra '?'

> 
> +Rx interrupt         = Y
> 
> +Queue start/stop     = Y
> 
> +Runtime Rx queue setup = Y
> 
> +Runtime Tx queue setup = Y
> 
> +Burst mode info      = Y
> 
> +Fast mbuf free       = Y
> 
> +Free Tx mbuf on demand = Y
> 
> +MTU update           = Y
> 
> +Scattered Rx         = Y
> 
> +TSO                  = Y
> 
> +LRO                  = Y
> 
> +Promiscuous mode     = Y
> 
> +Allmulticast mode    = Y
> 
> +Unicast MAC filter   = Y
> 
> +Multicast MAC filter = Y
> 
> +RSS hash             = Y
> 
> +RSS key update       = Y
> 
> +RSS reta update      = Y
> 
> +VLAN filter          = Y
> 
> +Flow control         = Y
> 
> +Traffic manager      = Y
> 
> +CRC offload          = Y
> 
> +FEC                  = Y
> 
> +L3 checksum offload  = Y
> 
> +L4 checksum offload  = Y
> 
> +Inner L3 checksum    = Y
> 
> +Inner L4 checksum    = Y
> 
> +Packet type parsing  = Y
> 
> +Basic stats          = Y
> 
> +Extended stats       = Y
> 
> +Stats per queue      = Y
> 
> +FW version           = Y
> 
> +Registers dump       = Y
> 
> +Module EEPROM dump   = Y
> 
> +Timesync             = Y
> 
> +Multiprocess aware   = Y
> 
> +Linux                = Y
> 
> +x86-64               = Y
> 
> +ARMv8                = Y
> 
> +
> 
> +[rte_flow items]
> 
> +any                  = Y
> 
> +eth                  = Y
> 
> +icmp                 = Y
> 
> +ipv4                 = Y
> 
> +ipv6                 = Y
> 
> +tcp                  = Y
> 
> +udp                  = Y
> 
> +vxlan                = Y
> 
> +[rte_flow actions]
> 
> +queue                = Y
> 
> diff --git a/drivers/net/hinic3/base/meson.build b/drivers/net/hinic3/base/meson.build
> 
> new file mode 100644
> 
> index 0000000000..b6a3a6cfe7
> 
> --- /dev/null
> 
> +++ b/drivers/net/hinic3/base/meson.build
> 
> @@ -0,0 +1,50 @@
> 
> +# SPDX-License-Identifier: BSD-3-Clause
> 
> +# Copyright(c) 2025 Huawei Technologies Co., Ltd
> 
> +
> 
> +sources = files(
> 
> +        'hinic3_cmdq.c',
> 
> +        'hinic3_eqs.c',
> 
> +        'hinic3_hw_cfg.c',
> 
> +        'hinic3_hw_comm.c',
> 
> +        'hinic3_hwdev.c',
> 
> +        'hinic3_hwif.c',
> 
> +        'hinic3_mbox.c',
> 
> +        'hinic3_mgmt.c',
> 
> +        'hinic3_nic_cfg.c',
> 
> +        'hinic3_nic_event.c',
> 
> +        'hinic3_wq.c',
> 
> +)
> 
> +
> 
> +extra_flags = []
> 
> +
> 
> +# The driver runs only on arch64 machine, remove 32bit warnings
> 
> +if not dpdk_conf.get('RTE_ARCH_64')
> 
> +    extra_flags += [
> 
> +            '-Wno-int-to-pointer-cast',
> 
> +            '-Wno-pointer-to-int-cast',
> 
> +    ]
> 
> +endif
> 
> +
> 
> +foreach flag: extra_flags
> 
> +    if cc.has_argument(flag)
> 
> +        cflags += flag
> 
> +    endif
> 
> +endforeach
> 
> +
> 
> +deps += ['hash']
> 
> +c_args = cflags
> 
> +includes += include_directories('../')
> 
> +
> 
> +base_lib = static_library(
> 
> +    'spnic_base',
> 
> +    sources,
> 
> +    dependencies: [
> 
> +        static_rte_eal,
> 
> +        static_rte_ethdev,
> 
> +        static_rte_bus_pci,
> 
> +        static_rte_hash,
> 
> +    ],
> 
> +    include_directories: includes,
> 
> +    c_args: c_args,
> 
> +)
> 
> +base_objs = base_lib.extract_all_objects()
> 
> diff --git a/drivers/net/hinic3/meson.build b/drivers/net/hinic3/meson.build
> 
> new file mode 100644
> 
> index 0000000000..42fb5bc194
> 
> --- /dev/null
> 
> +++ b/drivers/net/hinic3/meson.build
> 
> @@ -0,0 +1,33 @@
> 
> +# SPDX-License-Identifier: BSD-3-Clause
> 
> +# Copyright(c) 2025 Huawei Technologies Co., Ltd
> 
> +
> 
> +if not is_linux
> 
> +    build = false
> 
> +    reason = 'only supported on Linux'
> 
> +    subdir_done()
> 
> +endif
> 
> +
> 
> +if (arch_subdir != 'x86' and arch_subdir != 'arm'
> 
> +        or not dpdk_conf.get('RTE_ARCH_64'))
> 
> +    build = false
> 
> +    reason = 'only supported on x86_64 and aarch64'
> 
> +    subdir_done()
> 
> +endif
> 
> +
> 
> +cflags += ['-DHW_CONVERT_ENDIAN']
> 
> +
> 
> +subdir('base')
> 
> +subdir('mml')
> 
> +objs = [base_objs] + [mml_objs]
> 
> +
> 
> +sources = files(
> 
> +        'hinic3_ethdev.c',
> 
> +        'hinic3_fdir.c',
> 
> +        'hinic3_flow.c',
> 
> +        'hinic3_nic_io.c',
> 
> +        'hinic3_rx.c',
> 
> +        'hinic3_tx.c',
> 
> +)
> 
> +
> 
> +includes += include_directories('base')
> 
> +includes += include_directories('mml')
> 
> diff --git a/drivers/net/hinic3/mml/meson.build b/drivers/net/hinic3/mml/meson.build
> 
> index f8d2650d8d..67bba4f067 100644
> 
> --- a/drivers/net/hinic3/mml/meson.build
> 
> +++ b/drivers/net/hinic3/mml/meson.build
> 
> @@ -2,36 +2,19 @@
> 
>  # Copyright(c) 2025 Huawei Technologies Co., Ltd
> 
>  
> 
>  sources = files(
> 
> -    'hinic3_dbg.c',
> 
> -    'hinic3_mml_cmd.c',
> 
> -    'hinic3_mml_ioctl.c',
> 
> -    'hinic3_mml_lib.c',
> 
> -    'hinic3_mml_main.c',
> 
> -    'hinic3_mml_queue.c',
> 
> +        'hinic3_dbg.c',

please modify corresponding commit where the problem introduced.

> 
> +        'hinic3_mml_cmd.c',
> 
> +        'hinic3_mml_ioctl.c',
> 
> +        'hinic3_mml_lib.c',
> 
> +        'hinic3_mml_main.c',
> 
> +        'hinic3_mml_queue.c',
> 
>  )
> 
>  
> 
> -extra_flags = [
> 
> -    '-Wno-cast-qual',
> 
> -    '-Wno-format',
> 
> -    '-Wno-format-nonliteral',
> 
> -    '-Wno-format-security',
> 
> -    '-Wno-missing-braces',
> 
> -    '-Wno-missing-field-initializers',
> 
> -    '-Wno-missing-prototypes',
> 
> -    '-Wno-pointer-sign',
> 
> -    '-Wno-pointer-to-int-cast',
> 
> -    '-Wno-sign-compare',
> 
> -    '-Wno-strict-aliasing',
> 
> -    '-Wno-unused-parameter',
> 
> -    '-Wno-unused-value',
> 
> -    '-Wno-unused-variable',
> 
> -]
> 
> -
> 
>  # The driver runs only on arch64 machine, remove 32bit warnings
> 
>  if not dpdk_conf.get('RTE_ARCH_64')
> 
>      extra_flags += [
> 
> -        '-Wno-int-to-pointer-cast',
> 
> -        '-Wno-pointer-to-int-cast',
> 
> +            '-Wno-int-to-pointer-cast',
> 
> +            '-Wno-pointer-to-int-cast',
> 
>      ]
> 
>  endif
> 
>  
> 
> diff --git a/drivers/net/meson.build b/drivers/net/meson.build
> 
> index 61f8cddb30..2d32068ed2 100644
> 
> --- a/drivers/net/meson.build
> 
> +++ b/drivers/net/meson.build
> 
> @@ -23,6 +23,7 @@ drivers = [
> 
>          'failsafe',
> 
>          'gve',
> 
>          'hinic',
> 
> +        'hinic3',
> 
>          'hns3',
> 
>          'intel/e1000',
> 
>          'intel/fm10k',
> 

