Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A1A4CD98E4
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 14:23:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0EA0040289;
	Tue, 16 Jun 2026 16:23:34 +0200 (CEST)
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169]) by mails.dpdk.org (Postfix) with ESMTP id 55F7A4026A
 for <dev@dpdk.org>; Tue, 16 Jun 2026 16:23:33 +0200 (CEST)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-304ec41197bso5237108eec.1
 for <dev@dpdk.org>; Tue, 16 Jun 2026 07:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781619812;
 x=1782224612; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vIy8MSmW/NXV2JrgiF7kvFtGiSnhwo56O33FHNyaBrI=;
 b=KFg471Mmt3ds6+3iK9G4FWgNuloScpERCAnrVfRJeT8uNmiiFMb8DKtR03ilHYtuSL
 MLXkbqzAVJkKjqG1CxYjF/VQu9fiywryWlPz+drQ6GBSrKOs4tpGeZgbZzzhY4YebC2M
 I0DgwGMZc8lL3zUvtC8iDXnsBnuZ66WsUa0eoJpAYsQqSiD2BLODBolBhfGvniqtkh2Q
 aAXDug0cqbiUZ3UyEckr5K7NAosZ6r3XKQAgHUH7UM19d9VbPjEdoB9KT1IwNGu6DLo/
 EcJmNwRDqA/mvob2ifX3MvShhRUODSEENgQP9qC/KM9gSydx8tp+CR5B51HZ2TM6gaRx
 jTrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781619812; x=1782224612;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vIy8MSmW/NXV2JrgiF7kvFtGiSnhwo56O33FHNyaBrI=;
 b=OIdbnHe17TOsrlYNsJ0WtZlF5zm4EEVrL+k5cDPqIZupybej6iWLjUvGjEqu0xl0Ie
 5kJH8zYPN3dRzaRkb9UOD6ojguvXflml4GYLWtE3KoY17ybbXjMAalky0SDsYjHvXTlQ
 STY2M8BZYHmz7zToPzNkTAHXNi04mfuaaiI/WkDxQm7bDUUQfpK5kSm5eM8UcCAaCWTQ
 gBYcpdGRKmfhtbWZJAViGmoGsPxDHL1JFFq6RJW1c+QJB3tzkNnfUGhlGkORZ97S0b42
 NabNF5GEAancBIXCj2vlKvTb8RfT7CNzqv1PJXz6qBZQl0KCJn+IlnVoJNvM7CDQoiJ+
 mdXQ==
X-Gm-Message-State: AOJu0Yy9bUo744XBEt9qlzOO3aMowcXYIDaVWTwEQWaxsiXIY5uwaVUe
 GRUp9FYeaoxmGvLVXBypu+/p34ijuR2oTDvxEM5zMDDlRmdRU76lIn3qngSpYcLnXkQ=
X-Gm-Gg: Acq92OErE9OhJiG2eFaikErv/FksXEzhKYMw9ze0RgXS8SRf5nXeCW193LgcFa8n2o2
 ucwSLaq8uJzV0A+TsW+st+aBjbceW/BJfSER5iDyeIgdB5zgj5eUZ/U3OTiNXss7U/cmRAZd2/b
 oguO1yRCCcB0+GHe9H991BY+mlc6cjiUWOB/OUkyqmQ+VIekb08JUf25RIXpNUK9KWXBJh8K9UR
 2bheu/FzUEmhXLVhxrfxz+vAO3KoDu4208L9YBTjIFpfwR/6/ARxiqknHUnbmhgzpUSTpGDoNjR
 /+HGbgGvFneTVKAaBkZLD3F7DAKzy338fEmRj4RaXQuXiTZHekqpPUncjpEML4UpeUFZ+W6qsJ2
 2YgPAj/pnJOTqz96GvZNn8FZ0wUFqEHznZnekTNowjJefp8SqSH68Wx7Dm5CUqAmcLAKjn1k/Ls
 2BJ8zF4oI+UKlEhhtBkaF7cib5zUU8iF5tLYAX6y5jpGny+k4vyIPkXpJg9K0VghGM
X-Received: by 2002:a05:7300:80cc:b0:307:91f5:8eee with SMTP id
 5a478bee46e88-30ba59ea7femr2815686eec.12.1781619812178; 
 Tue, 16 Jun 2026 07:23:32 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081e5d3f20sm18802451eec.9.2026.06.16.07.23.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 07:23:31 -0700 (PDT)
Date: Tue, 16 Jun 2026 07:23:28 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Xingui Yang <yangxingui@huawei.com>
Cc: <dev@dpdk.org>, <david.marchand@redhat.com>,
 <aman.deep.singh@intel.com>, <fengchengwen@huawei.com>,
 <yangshuaisong@h-partners.com>, <lihuisong@huawei.com>,
 <liuyonglong@huawei.com>, <kangfenglong@huawei.com>
Subject: Re: [PATCH v2] app/testpmd: add VLAN priority insert support
Message-ID: <20260616072328.1dcb8cf8@phoenix.local>
In-Reply-To: <20260616131001.2955655-1-yangxingui@huawei.com>
References: <20260612081411.2798403-1-yangxingui@huawei.com>
 <20260616131001.2955655-1-yangxingui@huawei.com>
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

On Tue, 16 Jun 2026 21:10:01 +0800
Xingui Yang <yangxingui@huawei.com> wrote:

> The tx_vlan set and tx_qinq set commands only accepted VLAN ID in range
> [0, 4095]. This prevented users from setting 802.1p priority and CFI
> bits when using hardware VLAN insertion.
> 
> Since mbuf vlan_tci field already supports full 16-bit VLAN Tag Control
> Information (TCI), relax the validation for TX paths to allow priority
> and CFI bits. The vlan_id parameter now accepts:
>   - Bits 0-11:  VLAN ID (0-4095)
>   - Bit 12:    CFI (Canonical Format Indicator)
>   - Bits 13-15: Priority (0-7, 802.1p CoS)
> 
> Suggested-by: Stephen Hemminger <stephen@networkplumber.org>
> Suggested-by: fengchengwen <fengchengwen@huawei.com>
> Signed-off-by: Xingui Yang <yangxingui@huawei.com>
> ---
> v2:
> - Removed --enable-vlan-priority option and global variable as suggested
>   by Stephen Hemminger. The feature is now always enabled for TX paths
> - RX VLAN filter continues to enforce strict VLAN ID validation as
>   suggested by fengchengwen
> - Added documentation updates for testpmd_funcs.rst and release notes
> 
>  app/test-pmd/config.c                       | 13 ++++++++-----
>  doc/guides/rel_notes/release_26_07.rst      |  7 +++++++
>  doc/guides/testpmd_app_ug/testpmd_funcs.rst | 17 ++++++++++++++---
>  3 files changed, 29 insertions(+), 8 deletions(-)
> 
> diff --git a/app/test-pmd/config.c b/app/test-pmd/config.c
> index 9d457ca88e..38758f9c05 100644
> --- a/app/test-pmd/config.c
> +++ b/app/test-pmd/config.c
> @@ -1241,8 +1241,11 @@ void print_valid_ports(void)
>  }
>  
>  static int
> -vlan_id_is_invalid(uint16_t vlan_id)
> +vlan_id_is_invalid(uint16_t vlan_id, bool is_tx)
>  {
> +	if (is_tx)
> +		return 0;
> +
>  	if (vlan_id < 4096)
>  		return 0;
>  	fprintf(stderr, "Invalid vlan_id %d (must be < 4096)\n", vlan_id);
> @@ -6876,7 +6879,7 @@ rx_vft_set(portid_t port_id, uint16_t vlan_id, int on)
>  
>  	if (port_id_is_invalid(port_id, ENABLED_WARN))
>  		return 1;
> -	if (vlan_id_is_invalid(vlan_id))
> +	if (vlan_id_is_invalid(vlan_id, false))
>  		return 1;
>  	diag = rte_eth_dev_vlan_filter(port_id, vlan_id, on);
>  	if (diag == 0)
> @@ -6923,7 +6926,7 @@ tx_vlan_set(portid_t port_id, uint16_t vlan_id)
>  	struct rte_eth_dev_info dev_info;
>  	int ret;
>  
> -	if (vlan_id_is_invalid(vlan_id))
> +	if (vlan_id_is_invalid(vlan_id, true))
>  		return;

Why have the is_tx flag if it is always used as constant?
Just remove the whole vlan_id_is_invalid() branch test in the transmit path.
Maybe add a comment that any VLAN is allowed on transmit?

Or make a new function. Since VLAN of 0xffff is reserved. Though you might want
to allow it since testpmd is for testing even invalid packets.

