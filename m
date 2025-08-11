Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77208CA0EC1
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 08:42:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 986934025D;
	Mon, 11 Aug 2025 10:42:05 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 481FF400D5
 for <dev@dpdk.org>; Mon, 11 Aug 2025 10:42:04 +0200 (CEST)
Received: from debian (unknown [78.109.69.83])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 77350E0B61;
 Mon, 11 Aug 2025 12:42:02 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 77350E0B61
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1754901723;
 bh=rQXVDt8FqcrWd9zaDjflwid98azWWokX6+tytA2YlvA=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=bTfPKR4AzVX9f+GshWAsH2nzSJaKg9BxVPEBP7J9L0AeBTfHfW55Z/C+CANTBpqaw
 jjbVmHqcelqKo90uhHPXH+iSRiZ7PvHZIeJn2hcHX60J9G5inYb9eXsLoxghLlr9OL
 xT9eLl2qmAR/M9n6OS0xz1cu/pfjtRCsxbqOhnBm5BtcPX6EXRUGq6W0z41prvUANn
 G/qg98Z0+zBffnCoZeoBHpGGpFpElgVm6X+kKjHS71gefBHkfxStG4l10w3u5wB5XM
 /qwC+vejuB+w+i0/SsNb1yhDDiwhgSmi0L4KoLDodhcMuPOWBOQU3h3YKnTTHNsMDO
 GPnjPtCMrI4AQ==
Date: Mon, 11 Aug 2025 12:41:54 +0400 (+04)
From: Ivan Malov <ivan.malov@arknetworks.am>
To: =?ISO-8859-15?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
cc: dev@dpdk.org, Aman Singh <aman.deep.singh@intel.com>, 
 Thomas Monjalon <thomas@monjalon.net>, 
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, 
 Stephen Hemminger <stephen@networkplumber.org>, 
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: Re: [PATCH v3 1/3] testpmd: Do not enable mbuf fast release TX
 offload by default
In-Reply-To: <20250803194218.683318-1-mb@smartsharesystems.com>
Message-ID: <95547628-7d62-56c4-c775-4d554250b9a2@arknetworks.am>
References: <20250731090731.671589-1-mb@smartsharesystems.com>
 <20250803194218.683318-1-mb@smartsharesystems.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1973279343-1754901722=:10221"
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1973279343-1754901722=:10221
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Sun, 3 Aug 2025, Morten Brørup wrote:

> Enabling some offload by default may conflict with a manually configured
> offload.
> Specifically, the mbuf fast release TX offload, which conflicts with multi
> segment packet TX offload, was enabled by default.
> Therefore, mbuf fast release TX offload (the only TX offload which was
> enabled by default) is not enabled by default anymore.
>
> Signed-off-by: Morten Brørup <mb@smartsharesystems.com>

Acked-by: Ivan Malov <ivan.malov@arknetworks.am>

> ---
> app/test-pmd/testpmd.c | 11 +----------
> 1 file changed, 1 insertion(+), 10 deletions(-)
>
> diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
> index bb88555328..f00eae3992 100644
> --- a/app/test-pmd/testpmd.c
> +++ b/app/test-pmd/testpmd.c
> @@ -490,9 +490,7 @@ lcoreid_t latencystats_lcore_id = -1;
>  */
> struct rte_eth_rxmode rx_mode;
>
> -struct rte_eth_txmode tx_mode = {
> -	.offloads = RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE,
> -};
> +struct rte_eth_txmode tx_mode;
>
> volatile int test_done = 1; /* stop packet forwarding when set to 1. */
>
> @@ -1592,10 +1590,6 @@ init_config_port_offloads(portid_t pid, uint32_t socket_id)
> 	if (ret != 0)
> 		rte_exit(EXIT_FAILURE, "rte_eth_dev_info_get() failed\n");
>
> -	if (!(port->dev_info.tx_offload_capa & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE))
> -		port->dev_conf.txmode.offloads &=
> -			~RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE;
> -
> 	/* Apply Rx offloads configuration */
> 	for (i = 0; i < port->dev_info.max_rx_queues; i++)
> 		port->rxq[i].conf.offloads = port->dev_conf.rxmode.offloads;
> @@ -2857,9 +2851,6 @@ update_bonding_port_dev_conf(portid_t bond_pid)
> 		return;
> 	}
>
> -	if (port->dev_info.tx_offload_capa & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE)
> -		port->dev_conf.txmode.offloads |=
> -				RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE;
> 	/* Apply Tx offloads configuration */
> 	for (i = 0; i < port->dev_info.max_tx_queues; i++)
> 		port->txq[i].conf.offloads = port->dev_conf.txmode.offloads;
> -- 
> 2.43.0
>
--8323328-1973279343-1754901722=:10221--
