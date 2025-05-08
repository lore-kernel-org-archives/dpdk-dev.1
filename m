Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B8CDC3ABC0
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 May 2025 01:44:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 31F0A4025A;
	Thu,  8 May 2025 03:44:47 +0200 (CEST)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by mails.dpdk.org (Postfix) with ESMTP id A8ABB4014F
 for <dev@dpdk.org>; Thu,  8 May 2025 03:44:45 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.88.105])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ZtFFR0ndYzyVG3;
 Thu,  8 May 2025 09:40:27 +0800 (CST)
Received: from kwepemo500011.china.huawei.com (unknown [7.202.195.194])
 by mail.maildlp.com (Postfix) with ESMTPS id C6E831401F1;
 Thu,  8 May 2025 09:44:42 +0800 (CST)
Received: from [10.67.121.193] (10.67.121.193) by
 kwepemo500011.china.huawei.com (7.202.195.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 8 May 2025 09:44:42 +0800
Message-ID: <17f2ab6a-c519-4cd4-87b2-24e2835aee74@huawei.com>
Date: Thu, 8 May 2025 09:44:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] examples/l3fwd: adjust Tx burst size based on Rx burst
To: Sivaprasad Tummala <sivaprasad.tummala@amd.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Sivaprasad Tummala <sivaprasad.tummala@amd.com>, <david.hunt@intel.com>,
 <anatoly.burakov@intel.com>, <jerinj@marvell.com>, <radu.nicolau@intel.com>,
 <gakhil@marvell.com>, <cristian.dumitrescu@intel.com>,
 <ferruh.yigit@amd.com>, <konstantin.ananyev@huawei.com>,
 <mb@smartsharesystems.com>, liuyonglong <liuyonglong@huawei.com>
References: <20250212045416.2393001-1-sivaprasad.tummala@amd.com>
Content-Language: en-US
From: huangdengdui <huangdengdui@huawei.com>
In-Reply-To: <20250212045416.2393001-1-sivaprasad.tummala@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.193]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemo500011.china.huawei.com (7.202.195.194)
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

Tested-by: Dengdui Huang <huangdengdui@huawei.com>

The issue addressed by this patch is the same as the one fixed by the patch [1] pushed by Haijie.
However, this patch is better, and I have already tested it on the Kunpeng platform.
Please make the changes based on Konstantin's review comments and push the next version.

[1]
https://patchwork.dpdk.org/project/dpdk/patch/20241204020622.977156-1-haijie1@huawei.com/

On 2025/2/12 12:54, Sivaprasad Tummala wrote:
> Previously, the TX burst size was fixed at 256, leading to performance
> degradation in certain scenarios.
> 
> This patch introduces logic to set the TX burst size to match the
> configured RX burst size (--burst option, default 32, max 512)
> for better efficiency.
> 
> Fixes: d5c4897ecfb2 ("examples/l3fwd: add option to set Rx burst size")
> Cc: haijie1@huawei.com
> Cc: stable@dpdk.org
> 
> Signed-off-by: Sivaprasad Tummala <sivaprasad.tummala@amd.com>
> ---
>  examples/l3fwd/l3fwd.h        |  6 +++---
>  examples/l3fwd/l3fwd_common.h | 11 +++++++----
>  examples/l3fwd/main.c         |  2 ++
>  3 files changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/examples/l3fwd/l3fwd.h b/examples/l3fwd/l3fwd.h
> index 0cce3406ee..9d7c73504b 100644
> --- a/examples/l3fwd/l3fwd.h
> +++ b/examples/l3fwd/l3fwd.h
> @@ -35,7 +35,7 @@
>  /*
>   * Try to avoid TX buffering if we have at least MAX_TX_BURST packets to send.
>   */
> -#define	MAX_TX_BURST	  (MAX_PKT_BURST / 2)
> +#define	MAX_TX_BURST	  (DEFAULT_PKT_BURST / 2)
>  
>  #define NB_SOCKETS        8
>  
> @@ -152,8 +152,8 @@ send_single_packet(struct lcore_conf *qconf,
>  	len++;
>  
>  	/* enough pkts to be sent */
> -	if (unlikely(len == MAX_PKT_BURST)) {
> -		send_burst(qconf, MAX_PKT_BURST, port);
> +	if (unlikely(len == nb_pkt_per_burst)) {
> +		send_burst(qconf, nb_pkt_per_burst, port);
>  		len = 0;
>  	}
>  
> diff --git a/examples/l3fwd/l3fwd_common.h b/examples/l3fwd/l3fwd_common.h
> index d94e5f1357..6cb7de5144 100644
> --- a/examples/l3fwd/l3fwd_common.h
> +++ b/examples/l3fwd/l3fwd_common.h
> @@ -25,6 +25,9 @@
>   */
>  #define SENDM_PORT_OVERHEAD(x) (x)
>  
> +extern uint32_t nb_pkt_per_burst;
> +extern uint32_t max_tx_burst;
> +
>  /*
>   * From http://www.rfc-editor.org/rfc/rfc1812.txt section 5.2.2:
>   * - The IP version number must be 4.
> @@ -71,7 +74,7 @@ send_packetsx4(struct lcore_conf *qconf, uint16_t port, struct rte_mbuf *m[],
>  	 * If TX buffer for that queue is empty, and we have enough packets,
>  	 * then send them straightway.
>  	 */
> -	if (num >= MAX_TX_BURST && len == 0) {
> +	if (num >= max_tx_burst && len == 0) {
>  		n = rte_eth_tx_burst(port, qconf->tx_queue_id[port], m, num);
>  		if (unlikely(n < num)) {
>  			do {
> @@ -86,7 +89,7 @@ send_packetsx4(struct lcore_conf *qconf, uint16_t port, struct rte_mbuf *m[],
>  	 */
>  
>  	n = len + num;
> -	n = (n > MAX_PKT_BURST) ? MAX_PKT_BURST - len : num;
> +	n = (n > nb_pkt_per_burst) ? nb_pkt_per_burst - len : num;
>  
>  	j = 0;
>  	switch (n % FWDSTEP) {
> @@ -112,9 +115,9 @@ send_packetsx4(struct lcore_conf *qconf, uint16_t port, struct rte_mbuf *m[],
>  	len += n;
>  
>  	/* enough pkts to be sent */
> -	if (unlikely(len == MAX_PKT_BURST)) {
> +	if (unlikely(len == nb_pkt_per_burst)) {
>  
> -		send_burst(qconf, MAX_PKT_BURST, port);
> +		send_burst(qconf, nb_pkt_per_burst, port);
>  
>  		/* copy rest of the packets into the TX buffer. */
>  		len = num - n;
> diff --git a/examples/l3fwd/main.c b/examples/l3fwd/main.c
> index 994b7dd8e5..4cabd05be2 100644
> --- a/examples/l3fwd/main.c
> +++ b/examples/l3fwd/main.c
> @@ -59,6 +59,7 @@ uint16_t nb_rxd = RX_DESC_DEFAULT;
>  uint16_t nb_txd = TX_DESC_DEFAULT;
>  uint32_t nb_pkt_per_burst = DEFAULT_PKT_BURST;
>  uint32_t mb_mempool_cache_size = MEMPOOL_CACHE_SIZE;
> +uint32_t max_tx_burst = MAX_TX_BURST;
>  
>  /**< Ports set in promiscuous mode off by default. */
>  static int promiscuous_on;
> @@ -733,6 +734,7 @@ parse_pkt_burst(const char *optarg)
>  		return;
>  	}
>  	nb_pkt_per_burst = burst_size;
> +	max_tx_burst = burst_size / 2;
>  	RTE_LOG(INFO, L3FWD, "Using PMD-provided burst value %d\n", burst_size);
>  }
>  
