Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A29C021AA
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Feb 2025 03:42:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9D7FB40B9A;
	Fri, 21 Feb 2025 04:42:40 +0100 (CET)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 by mails.dpdk.org (Postfix) with ESMTP id 700574028E
 for <dev@dpdk.org>; Fri, 21 Feb 2025 04:42:38 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.19.163.252])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4YzbTx3bNszHr7h;
 Fri, 21 Feb 2025 11:39:33 +0800 (CST)
Received: from kwepemf500004.china.huawei.com (unknown [7.202.181.242])
 by mail.maildlp.com (Postfix) with ESMTPS id 0A41B1800EB;
 Fri, 21 Feb 2025 11:42:36 +0800 (CST)
Received: from [10.67.121.175] (10.67.121.175) by
 kwepemf500004.china.huawei.com (7.202.181.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 21 Feb 2025 11:42:35 +0800
Message-ID: <aa08f058-6ae4-f4fa-ab9e-c1563701a144@huawei.com>
Date: Fri, 21 Feb 2025 11:42:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] examples/l3fwd: add option to set Tx burst size
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>, "dev@dpdk.org"
 <dev@dpdk.org>, "thomas@monjalon.net" <thomas@monjalon.net>,
 "ferruh.yigit@amd.com" <ferruh.yigit@amd.com>, "stephen@networkplumber.org"
 <stephen@networkplumber.org>, "lihuisong (C)" <lihuisong@huawei.com>,
 Fengchengwen <fengchengwen@huawei.com>, =?UTF-8?Q?Morten_Br=c3=b8rup?=
 <mb@smartsharesystems.com>
CC: huangdengdui <huangdengdui@huawei.com>
References: <20241122071336.18470-1-haijie1@huawei.com>
 <20241204020622.977156-1-haijie1@huawei.com>
 <2d5511d1-f1d8-8410-e2ec-f6aced5a1f65@huawei.com>
 <4447f9ff97ad481996d74e26ea481f53@huawei.com>
From: Jie Hai <haijie1@huawei.com>
In-Reply-To: <4447f9ff97ad481996d74e26ea481f53@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.175]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemf500004.china.huawei.com (7.202.181.242)
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

On 2025/2/20 1:01, Konstantin Ananyev wrote:
> 
> 
> 
>> On 2024/12/4 10:06, Jie Hai wrote:
>>> The application send packets only when the buffer is full, or the
>>> buffer is empty and the packets to be sent extends TX_PKT_BURST.
>>> The change of MAX_PKT_BURST make TX buffer size and TX_PKT_BURST
>>> increase, while the default cache size is 256. The packets in
>>> the TX direction occupy the cache. As a result, the performance
>>> deteriorates.
>>>
>>> Restore the default Tx burst and add option '--tx-burst' to set
>>> the Tx burst size. To ensure consistency, rename the option
>>> '--burst' to '--rx-burst'. The valid range of the user-provided
>>> value is (0, MAX_PKT_BURST] for both directions.
>>>
>>> Fixes: d5c4897ecfb2 ("examples/l3fwd: add option to set RX burst size")
>>> Cc: stable@dpdk.org
> 
> Wouldn't that patch:
> https://patchwork.dpdk.org/project/dpdk/patch/20250212045416.2393001-1-sivaprasad.tummala@amd.com/
> fix that issue too?
> And probably in a less disruptive manner?
> 
Thanks for your comment.

I think different drivers may need different values for better 
performance, it makes sense to add options.

>>> Signed-off-by: Jie Hai <haijie1@huawei.com>
>>> ---
>>>    examples/l3fwd/l3fwd.h        | 14 +++---
>>>    examples/l3fwd/l3fwd_acl.c    |  2 +-
>>>    examples/l3fwd/l3fwd_common.h |  2 +-
>>>    examples/l3fwd/l3fwd_em.c     |  2 +-
>>>    examples/l3fwd/l3fwd_fib.c    |  2 +-
>>>    examples/l3fwd/l3fwd_lpm.c    |  2 +-
>>>    examples/l3fwd/main.c         | 89 ++++++++++++++++++-----------------
>>>    7 files changed, 59 insertions(+), 54 deletions(-)
>>>
>>> diff --git a/examples/l3fwd/l3fwd.h b/examples/l3fwd/l3fwd.h
>>> index 0cce3406ee7d..a4e23b817edf 100644
>>> --- a/examples/l3fwd/l3fwd.h
>>> +++ b/examples/l3fwd/l3fwd.h
>>> @@ -32,10 +32,6 @@
>>>
>>>    #define VECTOR_SIZE_DEFAULT   MAX_PKT_BURST
>>>    #define VECTOR_TMO_NS_DEFAULT 1E6 /* 1ms */
>>> -/*
>>> - * Try to avoid TX buffering if we have at least MAX_TX_BURST packets to send.
>>> - */
>>> -#define	MAX_TX_BURST	  (MAX_PKT_BURST / 2)
>>>
>>>    #define NB_SOCKETS        8
>>>
>>> @@ -116,7 +112,11 @@ extern struct acl_algorithms acl_alg[];
>>>
>>>    extern uint32_t max_pkt_len;
>>>
>>> -extern uint32_t nb_pkt_per_burst;
>>> +extern uint32_t rx_pkt_burst;
>>> +/*
>>> + * Try to avoid TX buffering if we have at least tx_pkt_burst packets to send.
>>> + */
>>> +extern uint32_t tx_pkt_burst;
>>>    extern uint32_t mb_mempool_cache_size;
>>>
>>>    /* Send burst of packets on an output interface */
>>> @@ -152,8 +152,8 @@ send_single_packet(struct lcore_conf *qconf,
>>>    	len++;
>>>
>>>    	/* enough pkts to be sent */
>>> -	if (unlikely(len == MAX_PKT_BURST)) {
>>> -		send_burst(qconf, MAX_PKT_BURST, port);
>>> +	if (unlikely(len == tx_pkt_burst)) {
>>> +		send_burst(qconf, tx_pkt_burst, port);
>>>    		len = 0;
>>>    	}
>>>
>>> diff --git a/examples/l3fwd/l3fwd_acl.c b/examples/l3fwd/l3fwd_acl.c
>>> index 4fc4b986cce6..a5af82357a03 100644
>>> --- a/examples/l3fwd/l3fwd_acl.c
>>> +++ b/examples/l3fwd/l3fwd_acl.c
>>> @@ -1136,7 +1136,7 @@ acl_main_loop(__rte_unused void *dummy)
>>>    			portid = qconf->rx_queue_list[i].port_id;
>>>    			queueid = qconf->rx_queue_list[i].queue_id;
>>>    			nb_rx = rte_eth_rx_burst(portid, queueid,
>>> -				pkts_burst, nb_pkt_per_burst);
>>> +				pkts_burst, rx_pkt_burst);
>>>
>>>    			if (nb_rx > 0) {
>>>    				nb_drop = acl_process_pkts(pkts_burst, hops,
>>> diff --git a/examples/l3fwd/l3fwd_common.h b/examples/l3fwd/l3fwd_common.h
>>> index d94e5f135791..34fe70b9415c 100644
>>> --- a/examples/l3fwd/l3fwd_common.h
>>> +++ b/examples/l3fwd/l3fwd_common.h
>>> @@ -71,7 +71,7 @@ send_packetsx4(struct lcore_conf *qconf, uint16_t port, struct rte_mbuf *m[],
>>>    	 * If TX buffer for that queue is empty, and we have enough packets,
>>>    	 * then send them straightway.
>>>    	 */
>>> -	if (num >= MAX_TX_BURST && len == 0) {
>>> +	if (num >= tx_pkt_burst / 2 && len == 0) {
>>>    		n = rte_eth_tx_burst(port, qconf->tx_queue_id[port], m, num);
>>>    		if (unlikely(n < num)) {
>>>    			do {
>>> diff --git a/examples/l3fwd/l3fwd_em.c b/examples/l3fwd/l3fwd_em.c
>>> index da9c45e3a482..ea74506ed971 100644
>>> --- a/examples/l3fwd/l3fwd_em.c
>>> +++ b/examples/l3fwd/l3fwd_em.c
>>> @@ -644,7 +644,7 @@ em_main_loop(__rte_unused void *dummy)
>>>    			portid = qconf->rx_queue_list[i].port_id;
>>>    			queueid = qconf->rx_queue_list[i].queue_id;
>>>    			nb_rx = rte_eth_rx_burst(portid, queueid, pkts_burst,
>>> -				nb_pkt_per_burst);
>>> +				rx_pkt_burst);
>>>    			if (nb_rx == 0)
>>>    				continue;
>>>
>>> diff --git a/examples/l3fwd/l3fwd_fib.c b/examples/l3fwd/l3fwd_fib.c
>>> index 82f1739df778..4223540b30ae 100644
>>> --- a/examples/l3fwd/l3fwd_fib.c
>>> +++ b/examples/l3fwd/l3fwd_fib.c
>>> @@ -239,7 +239,7 @@ fib_main_loop(__rte_unused void *dummy)
>>>    			portid = qconf->rx_queue_list[i].port_id;
>>>    			queueid = qconf->rx_queue_list[i].queue_id;
>>>    			nb_rx = rte_eth_rx_burst(portid, queueid, pkts_burst,
>>> -					nb_pkt_per_burst);
>>> +					rx_pkt_burst);
>>>    			if (nb_rx == 0)
>>>    				continue;
>>>
>>> diff --git a/examples/l3fwd/l3fwd_lpm.c b/examples/l3fwd/l3fwd_lpm.c
>>> index fec0aeb79c6a..bd1307c43e70 100644
>>> --- a/examples/l3fwd/l3fwd_lpm.c
>>> +++ b/examples/l3fwd/l3fwd_lpm.c
>>> @@ -205,7 +205,7 @@ lpm_main_loop(__rte_unused void *dummy)
>>>    			portid = qconf->rx_queue_list[i].port_id;
>>>    			queueid = qconf->rx_queue_list[i].queue_id;
>>>    			nb_rx = rte_eth_rx_burst(portid, queueid, pkts_burst,
>>> -				nb_pkt_per_burst);
>>> +				rx_pkt_burst);
>>>    			if (nb_rx == 0)
>>>    				continue;
>>>
>>> diff --git a/examples/l3fwd/main.c b/examples/l3fwd/main.c
>>> index 994b7dd8e596..48453faf7c56 100644
>>> --- a/examples/l3fwd/main.c
>>> +++ b/examples/l3fwd/main.c
>>> @@ -57,7 +57,8 @@
>>>    static_assert(MEMPOOL_CACHE_SIZE >= MAX_PKT_BURST, "MAX_PKT_BURST should be at most MEMPOOL_CACHE_SIZE");
>>>    uint16_t nb_rxd = RX_DESC_DEFAULT;
>>>    uint16_t nb_txd = TX_DESC_DEFAULT;
>>> -uint32_t nb_pkt_per_burst = DEFAULT_PKT_BURST;
>>> +uint32_t rx_pkt_burst = DEFAULT_PKT_BURST;
>>> +uint32_t tx_pkt_burst = DEFAULT_PKT_BURST;
>>>    uint32_t mb_mempool_cache_size = MEMPOOL_CACHE_SIZE;
>>>
>>>    /**< Ports set in promiscuous mode off by default. */
>>> @@ -399,7 +400,8 @@ print_usage(const char *prgname)
>>>    		" --config (port,queue,lcore)[,(port,queue,lcore)]"
>>>    		" [--rx-queue-size NPKTS]"
>>>    		" [--tx-queue-size NPKTS]"
>>> -		" [--burst NPKTS]"
>>> +		" [--rx-burst NPKTS]"
>>> +		" [--tx-burst NPKTS]"
>>>    		" [--mbcache CACHESZ]"
>>>    		" [--eth-dest=X,MM:MM:MM:MM:MM:MM]"
>>>    		" [--max-pkt-len PKTLEN]"
>>> @@ -426,8 +428,10 @@ print_usage(const char *prgname)
>>>    		"            Default: %d\n"
>>>    		"  --tx-queue-size NPKTS: Tx queue size in decimal\n"
>>>    		"            Default: %d\n"
>>> -		"  --burst NPKTS: Burst size in decimal\n"
>>> -		"            Default: %d\n"
>>> +		"  --rx-burst NPKTS: RX Burst size in decimal\n"
>>> +		"            Default: %d, Maximum: %d\n"
>>> +		"  --tx-burst NPKTS: TX Burst size in decimal\n"
>>> +		"            Default: %d, Maximum: %d\n"
>>>    		"  --mbcache CACHESZ: Mbuf cache size in decimal\n"
>>>    		"            Default: %d\n"
>>>    		"  --eth-dest=X,MM:MM:MM:MM:MM:MM: Ethernet destination for port X\n"
>>> @@ -459,7 +463,10 @@ print_usage(const char *prgname)
>>>    		"                    another is route entry at while line leads with character '%c'.\n"
>>>    		"  --rule_ipv6=FILE: Specify the ipv6 rules entries file.\n"
>>>    		"  --alg: ACL classify method to use, one of: %s.\n\n",
>>> -		prgname, RX_DESC_DEFAULT, TX_DESC_DEFAULT, DEFAULT_PKT_BURST, MEMPOOL_CACHE_SIZE,
>>> +		prgname, RX_DESC_DEFAULT, TX_DESC_DEFAULT,
>>> +		DEFAULT_PKT_BURST, MAX_PKT_BURST,
>>> +		DEFAULT_PKT_BURST, MAX_PKT_BURST,
>>> +		MEMPOOL_CACHE_SIZE,
>>>    		ACL_LEAD_CHAR, ROUTE_LEAD_CHAR, alg);
>>>    }
>>>
>>> @@ -693,47 +700,30 @@ parse_mbcache_size(const char *optarg)
>>>    			 RTE_MEMPOOL_CACHE_MAX_SIZE);
>>>    }
>>>
>>> -static void
>>> -parse_pkt_burst(const char *optarg)
>>> +static int
>>> +parse_pkt_burst(const char *optarg, bool is_rx)
>>>    {
>>> -	struct rte_eth_dev_info dev_info;
>>>    	unsigned long pkt_burst;
>>> -	uint16_t burst_size;
>>>    	char *end = NULL;
>>> -	int ret;
>>>
>>>    	/* parse decimal string */
>>>    	pkt_burst = strtoul(optarg, &end, 10);
>>> -	if ((optarg[0] == '\0') || (end == NULL) || (*end != '\0'))
>>> -		return;
>>> -
>>> -	if (pkt_burst > MAX_PKT_BURST) {
>>> -		RTE_LOG(INFO, L3FWD, "User provided burst must be <= %d. Using default value %d\n",
>>> -			MAX_PKT_BURST, nb_pkt_per_burst);
>>> -		return;
>>> -	} else if (pkt_burst > 0) {
>>> -		nb_pkt_per_burst = (uint32_t)pkt_burst;
>>> -		return;
>>> +	if ((optarg[0] == '\0') || (end == NULL) || (*end != '\0')) {
>>> +		RTE_LOG(ERR, L3FWD, "Invalid %s-burst\n", is_rx ? "rx" : "tx");
>>> +		return -1;
>>>    	}
>>>
>>> -	/* If user gives a value of zero, query the PMD for its recommended Rx burst size. */
>>> -	ret = rte_eth_dev_info_get(0, &dev_info);
>>> -	if (ret != 0)
>>> -		return;
>>> -	burst_size = dev_info.default_rxportconf.burst_size;
>>> -	if (burst_size == 0) {
>>> -		RTE_LOG(INFO, L3FWD, "PMD does not recommend a burst size. Using default value %d. "
>>> -			"User provided value must be in [1, %d]\n",
>>> -			nb_pkt_per_burst, MAX_PKT_BURST);
>>> -		return;
>>> -	} else if (burst_size > MAX_PKT_BURST) {
>>> -		RTE_LOG(INFO, L3FWD, "PMD recommended burst size %d exceeds maximum value %d. "
>>> -			"Using default value %d\n",
>>> -			burst_size, MAX_PKT_BURST, nb_pkt_per_burst);
>>> -		return;
>>> +	if (pkt_burst > MAX_PKT_BURST || pkt_burst == 0) {
>>> +		RTE_LOG(ERR, L3FWD, "User-provided %s burst must be in (0, %d].\n",
>>> +			is_rx ? "Rx" : "Tx", MAX_PKT_BURST);
>>> +		return -1;
>>> +	} else if (pkt_burst > 0) {
>>> +		if (is_rx)
>>> +			rx_pkt_burst = (uint16_t)pkt_burst;
>>> +		else
>>> +			tx_pkt_burst = (uint16_t)pkt_burst;
>>>    	}
>>> -	nb_pkt_per_burst = burst_size;
>>> -	RTE_LOG(INFO, L3FWD, "Using PMD-provided burst value %d\n", burst_size);
>>> +	return 0;
>>>    }
>>>
>>>    #define MAX_JUMBO_PKT_LEN  9600
>>> @@ -767,7 +757,8 @@ static const char short_options[] =
>>>    #define CMD_LINE_OPT_RULE_IPV4 "rule_ipv4"
>>>    #define CMD_LINE_OPT_RULE_IPV6 "rule_ipv6"
>>>    #define CMD_LINE_OPT_ALG "alg"
>>> -#define CMD_LINE_OPT_PKT_BURST "burst"
>>> +#define CMD_LINE_OPT_PKT_RX_BURST "rx-burst"
>>> +#define CMD_LINE_OPT_PKT_TX_BURST "tx-burst"
>>>    #define CMD_LINE_OPT_MB_CACHE_SIZE "mbcache"
>>>
>>>    enum {
>>> @@ -798,7 +789,8 @@ enum {
>>>    	CMD_LINE_OPT_ENABLE_VECTOR_NUM,
>>>    	CMD_LINE_OPT_VECTOR_SIZE_NUM,
>>>    	CMD_LINE_OPT_VECTOR_TMO_NS_NUM,
>>> -	CMD_LINE_OPT_PKT_BURST_NUM,
>>> +	CMD_LINE_OPT_RX_PKT_BURST_NUM,
>>> +	CMD_LINE_OPT_TX_PKT_BURST_NUM,
>>>    	CMD_LINE_OPT_MB_CACHE_SIZE_NUM,
>>>    };
>>>
>>> @@ -826,7 +818,8 @@ static const struct option lgopts[] = {
>>>    	{CMD_LINE_OPT_RULE_IPV4,   1, 0, CMD_LINE_OPT_RULE_IPV4_NUM},
>>>    	{CMD_LINE_OPT_RULE_IPV6,   1, 0, CMD_LINE_OPT_RULE_IPV6_NUM},
>>>    	{CMD_LINE_OPT_ALG,   1, 0, CMD_LINE_OPT_ALG_NUM},
>>> -	{CMD_LINE_OPT_PKT_BURST,   1, 0, CMD_LINE_OPT_PKT_BURST_NUM},
>>> +	{CMD_LINE_OPT_PKT_RX_BURST,   1, 0, CMD_LINE_OPT_RX_PKT_BURST_NUM},
>>> +	{CMD_LINE_OPT_PKT_TX_BURST,   1, 0, CMD_LINE_OPT_TX_PKT_BURST_NUM},
>>>    	{CMD_LINE_OPT_MB_CACHE_SIZE,   1, 0, CMD_LINE_OPT_MB_CACHE_SIZE_NUM},
>>>    	{NULL, 0, 0, 0}
>>>    };
>>> @@ -916,8 +909,20 @@ parse_args(int argc, char **argv)
>>>    			parse_queue_size(optarg, &nb_txd, 0);
>>>    			break;
>>>
>>> -		case CMD_LINE_OPT_PKT_BURST_NUM:
>>> -			parse_pkt_burst(optarg);
>>> +		case CMD_LINE_OPT_TX_PKT_BURST_NUM:
>>> +			ret = parse_pkt_burst(optarg, false);
>>> +			if (ret) {
>>> +				print_usage(prgname);
>>> +				return -1;
>>> +			}
>>> +			break;
>>> +
>>> +		case CMD_LINE_OPT_RX_PKT_BURST_NUM:
>>> +			ret = parse_pkt_burst(optarg, true);
>>> +			if (ret) {
>>> +				print_usage(prgname);
>>> +				return -1;
>>> +			}
>>>    			break;
>>>
>>>    		case CMD_LINE_OPT_MB_CACHE_SIZE_NUM:
