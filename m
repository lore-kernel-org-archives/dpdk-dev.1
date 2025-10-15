Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B36CCD185
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 07:53:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA8D740650;
	Wed, 15 Oct 2025 09:53:16 +0200 (CEST)
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com
 [113.46.200.222])
 by mails.dpdk.org (Postfix) with ESMTP id 40BC9402C3
 for <dev@dpdk.org>; Wed, 15 Oct 2025 09:53:15 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=KYY1lEOvnKXd1ctjgpNbTOdad+dLF0ey2rlVpwlgdos=;
 b=dRS/a1xYfEUfdpbNEXbsdThAddpfSnNJJj0xGMMSGlcopj2DhiTHSkwKJDkCul4wpON0jsV8E
 nuvngljGKrc+e1Wh75dBfeEQncWVnsGaOKxpzR/OKhjewqRZM8kaL/mVIriHjEcub15sgPsFJPs
 Q/M1MLcLVuGhvW2iOsZ5+lA=
Received: from mail.maildlp.com (unknown [172.19.162.112])
 by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4cmjxG1vkVzLlVq;
 Wed, 15 Oct 2025 15:52:50 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 80A4714022E;
 Wed, 15 Oct 2025 15:53:10 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 15 Oct 2025 15:53:10 +0800
Message-ID: <a6ca7fc0-d7d7-4f8f-b04b-df637097a374@huawei.com>
Date: Wed, 15 Oct 2025 15:53:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 05/21] argparse: add documentation on supported value
 types
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
CC: <david.marchand@redhat.com>
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
 <20251009130056.2630343-1-bruce.richardson@intel.com>
 <20251009130056.2630343-6-bruce.richardson@intel.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20251009130056.2630343-6-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
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

Minor comment on paragraph layout, with that fixed:
Acked-by: Chengwen Feng <fengchengwen@huawei.com>

On 10/9/2025 9:00 PM, Bruce Richardson wrote:
> The different value types supported by the argparse library are not
> discussed in the documentation, so add some reference material about
> them.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  doc/guides/prog_guide/argparse_lib.rst | 73 +++++++++++++++++++++++++-
>  1 file changed, 71 insertions(+), 2 deletions(-)
> 
> diff --git a/doc/guides/prog_guide/argparse_lib.rst b/doc/guides/prog_guide/argparse_lib.rst
> index b309260d20..7868af5672 100644
> --- a/doc/guides/prog_guide/argparse_lib.rst
> +++ b/doc/guides/prog_guide/argparse_lib.rst
> @@ -160,6 +160,75 @@ both use this way, the parsing is as follows:
>  - For argument ``ooo``, it is positional argument,
>    the ``ooo_val`` will be set to user input's value.
>  
> +Supported Value Types
> +~~~~~~~~~~~~~~~~~~~~~

This paragraph should be the inner paragraph of 'Parsing by autosave way'
I suggest delete the ~~~~~, and move the whole after "Parsing by autosave way"

> +
> +The argparse library supports automatic parsing of several data types when using
> +the autosave method. The parsed values are automatically converted from string
> +input to the appropriate data type and stored in the ``val_saver`` field.
> +
> +Integer Types
> +^^^^^^^^^^^^^
> +
> +The library supports parsing various integer types:
> +
> +- ``RTE_ARGPARSE_VALUE_TYPE_INT`` - signed integer
> +- ``RTE_ARGPARSE_VALUE_TYPE_U8`` - unsigned 8-bit integer
> +- ``RTE_ARGPARSE_VALUE_TYPE_U16`` - unsigned 16-bit integer
> +- ``RTE_ARGPARSE_VALUE_TYPE_U32`` - unsigned 32-bit integer
> +- ``RTE_ARGPARSE_VALUE_TYPE_U64`` - unsigned 64-bit integer
> +
> +.. code-block:: C
> +
> +   static int my_int;
> +   static uint16_t my_port;
> +   static uint32_t my_count;
> +
> +   static struct rte_argparse obj = {
> +      .args = {
> +         { "--number", "-n", "Integer value", &my_int, NULL, RTE_ARGPARSE_VALUE_REQUIRED, RTE_ARGPARSE_VALUE_TYPE_INT },
> +         { "--port", "-p", "Port number", &my_port, NULL, RTE_ARGPARSE_VALUE_REQUIRED, RTE_ARGPARSE_VALUE_TYPE_U16 },
> +         { "--count", "-c", "Count value", &my_count, (void *)1000, RTE_ARGPARSE_VALUE_OPTIONAL, RTE_ARGPARSE_VALUE_TYPE_U32 },
> +         ARGPARSE_ARG_END(),
> +      },
> +   };
> +
> +String Type
> +^^^^^^^^^^^
> +
> +String arguments are parsed using ``RTE_ARGPARSE_VALUE_TYPE_STR``.
> +When using this type, the input value is saved to the provided pointer without any parsing or validation.
> +
> +.. code-block:: C
> +
> +   static const char *my_string;
> +
> +   static struct rte_argparse obj = {
> +      .args = {
> +         { "--name", "-n", "Name string", &my_string, NULL, RTE_ARGPARSE_VALUE_REQUIRED, RTE_ARGPARSE_VALUE_TYPE_STR },
> +         ARGPARSE_ARG_END(),
> +      },
> +   };
> +
> +Boolean Type
> +^^^^^^^^^^^^
> +
> +Boolean arguments are parsed using ``RTE_ARGPARSE_VALUE_TYPE_BOOL`` and accept the following input formats:
> +
> +- ``true``, ``false`` (case-sensitive)
> +- ``1``, ``0`` (numeric format)
> +
> +.. code-block:: C
> +
> +   static bool my_flag;
> +
> +   static struct rte_argparse obj = {
> +      .args = {
> +         { "--enable", "-e", "Enable feature", &my_flag, NULL, RTE_ARGPARSE_VALUE_REQUIRED, RTE_ARGPARSE_VALUE_TYPE_BOOL },
> +         ARGPARSE_ARG_END(),
> +      },
> +   };
> +
>  Parsing by callback way
>  ~~~~~~~~~~~~~~~~~~~~~~~
>  
> @@ -167,8 +236,8 @@ It could also choose to use callback to parse,
>  just define a unique index for the argument
>  and make the ``val_save`` field to be NULL also zero value-type.
>  
> -In the above example, the arguments ``--ddd``/``--eee``/``--fff`` and ``ppp``
> -both use this way.
> +In the example at the top of this section,
> +the arguments ``--ddd``/``--eee``/``--fff`` and ``ppp`` all use this way.
>  
>  Multiple times argument
>  ~~~~~~~~~~~~~~~~~~~~~~~

