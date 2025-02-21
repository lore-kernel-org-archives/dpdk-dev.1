Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAD1C021B2
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Feb 2025 01:27:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4778D402A8;
	Fri, 21 Feb 2025 02:27:29 +0100 (CET)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by mails.dpdk.org (Postfix) with ESMTP id 61ECA4026D;
 Fri, 21 Feb 2025 02:27:27 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.19.163.48])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4YzXS70RqHztSHH;
 Fri, 21 Feb 2025 09:22:47 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
 by mail.maildlp.com (Postfix) with ESMTPS id 7AB0118009E;
 Fri, 21 Feb 2025 09:27:25 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 21 Feb 2025 09:27:25 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 21 Feb
 2025 09:27:24 +0800
Message-ID: <afab1498-91b8-641b-5551-b3a2b5a48e5d@huawei.com>
Date: Fri, 21 Feb 2025 09:27:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] app/testpmd: fix out-of-bound reference in offload config
To: Stephen Hemminger <stephen@networkplumber.org>, <dev@dpdk.org>
CC: <stable@dpdk.org>, Aman Singh <aman.deep.singh@intel.com>, Jingjing Wu
 <jingjing.wu@intel.com>, Wei Dai <wei.dai@intel.com>
References: <20250220204427.213965-1-stephen@networkplumber.org>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20250220204427.213965-1-stephen@networkplumber.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.121.59]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemn100009.china.huawei.com (7.202.194.112)
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

LGTM,
Acked-by: Huisong Li <lihuisong@huawei.com>
在 2025/2/21 4:44, Stephen Hemminger 写道:
> When configuring offloads, need to check the port id before
> indexing into the ports[] array. This can easily be done
> by moving the call to oh_dev_conf_get_print_err() to before
> the checks for port stopped.
>
> Fixes: c73a9071877a ("app/testpmd: add commands to test new offload API")
> Cc: stable@dpdk.org
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>   app/test-pmd/cmdline.c | 57 +++++++++++++++++++++++-------------------
>   1 file changed, 31 insertions(+), 26 deletions(-)
>
> diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
> index 86d763b66a..d059b65003 100644
> --- a/app/test-pmd/cmdline.c
> +++ b/app/test-pmd/cmdline.c
> @@ -11627,7 +11627,7 @@ cmd_rx_offload_get_configuration_parsed(
>   	struct cmd_rx_offload_get_configuration_result *res = parsed_result;
>   	struct rte_eth_dev_info dev_info;
>   	portid_t port_id = res->port_id;
> -	struct rte_port *port = &ports[port_id];
> +	struct rte_port *port;
>   	struct rte_eth_conf dev_conf;
>   	uint64_t port_offloads;
>   	uint64_t queue_offloads;
> @@ -11635,12 +11635,13 @@ cmd_rx_offload_get_configuration_parsed(
>   	int q;
>   	int ret;
>   
> -	printf("Rx Offloading Configuration of port %d :\n", port_id);
> -
>   	ret = eth_dev_conf_get_print_err(port_id, &dev_conf);
>   	if (ret != 0)
>   		return;
>   
> +	port = &ports[port_id];
> +	printf("Rx Offloading Configuration of port %d :\n", port_id);
> +
>   	port_offloads = dev_conf.rxmode.offloads;
>   	printf("  Port :");
>   	print_rx_offloads(port_offloads);
> @@ -11741,12 +11742,17 @@ static void
>   config_port_rx_offload(portid_t port_id, char *name, bool on)
>   {
>   	struct rte_eth_dev_info dev_info;
> -	struct rte_port *port = &ports[port_id];
> +	struct rte_port *port;
>   	uint16_t nb_rx_queues;
>   	uint64_t offload;
>   	int q;
>   	int ret;
>   
> +	ret = eth_dev_info_get_print_err(port_id, &dev_info);
> +	if (ret != 0)
> +		return;
> +
> +	port = &ports[port_id];
>   	if (port->port_status != RTE_PORT_STOPPED) {
>   		fprintf(stderr,
>   			"Error: Can't config offload when Port %d is not stopped\n",
> @@ -11754,10 +11760,6 @@ config_port_rx_offload(portid_t port_id, char *name, bool on)
>   		return;
>   	}
>   
> -	ret = eth_dev_info_get_print_err(port_id, &dev_info);
> -	if (ret != 0)
> -		return;
> -
>   	if (!strcmp(name, "all")) {
>   		offload = dev_info.rx_offload_capa;
>   	} else {
> @@ -11943,10 +11945,15 @@ cmd_config_per_queue_rx_offload_parsed(void *parsed_result,
>   	struct rte_eth_dev_info dev_info;
>   	portid_t port_id = res->port_id;
>   	uint16_t queue_id = res->queue_id;
> -	struct rte_port *port = &ports[port_id];
> +	struct rte_port *port;
>   	uint64_t offload;
>   	int ret;
>   
> +	ret = eth_dev_info_get_print_err(port_id, &dev_info);
> +	if (ret != 0)
> +		return;
> +
> +	port = &ports[port_id];
>   	if (port->port_status != RTE_PORT_STOPPED) {
>   		fprintf(stderr,
>   			"Error: Can't config offload when Port %d is not stopped\n",
> @@ -11954,10 +11961,6 @@ cmd_config_per_queue_rx_offload_parsed(void *parsed_result,
>   		return;
>   	}
>   
> -	ret = eth_dev_info_get_print_err(port_id, &dev_info);
> -	if (ret != 0)
> -		return;
> -
>   	if (queue_id >= dev_info.nb_rx_queues) {
>   		fprintf(stderr,
>   			"Error: input queue_id should be 0 ... %d\n",
> @@ -12145,7 +12148,7 @@ cmd_tx_offload_get_configuration_parsed(
>   	struct cmd_tx_offload_get_configuration_result *res = parsed_result;
>   	struct rte_eth_dev_info dev_info;
>   	portid_t port_id = res->port_id;
> -	struct rte_port *port = &ports[port_id];
> +	struct rte_port *port;
>   	struct rte_eth_conf dev_conf;
>   	uint64_t port_offloads;
>   	uint64_t queue_offloads;
> @@ -12153,12 +12156,12 @@ cmd_tx_offload_get_configuration_parsed(
>   	int q;
>   	int ret;
>   
> -	printf("Tx Offloading Configuration of port %d :\n", port_id);
> -
>   	ret = eth_dev_conf_get_print_err(port_id, &dev_conf);
>   	if (ret != 0)
>   		return;
>   
> +	printf("Tx Offloading Configuration of port %d :\n", port_id);
> +	port = &ports[port_id];
>   	port_offloads = dev_conf.txmode.offloads;
>   	printf("  Port :");
>   	print_tx_offloads(port_offloads);
> @@ -12263,12 +12266,17 @@ static void
>   config_port_tx_offload(portid_t port_id, char *name, bool on)
>   {
>   	struct rte_eth_dev_info dev_info;
> -	struct rte_port *port = &ports[port_id];
> +	struct rte_port *port;
>   	uint16_t nb_tx_queues;
>   	uint64_t offload;
>   	int q;
>   	int ret;
>   
> +	ret = eth_dev_info_get_print_err(port_id, &dev_info);
> +	if (ret != 0)
> +		return;
> +
> +	port = &ports[port_id];
>   	if (port->port_status != RTE_PORT_STOPPED) {
>   		fprintf(stderr,
>   			"Error: Can't config offload when Port %d is not stopped\n",
> @@ -12276,10 +12284,6 @@ config_port_tx_offload(portid_t port_id, char *name, bool on)
>   		return;
>   	}
>   
> -	ret = eth_dev_info_get_print_err(port_id, &dev_info);
> -	if (ret != 0)
> -		return;
> -
>   	if (!strcmp(name, "all")) {
>   		offload = dev_info.tx_offload_capa;
>   	} else {
> @@ -12469,10 +12473,15 @@ cmd_config_per_queue_tx_offload_parsed(void *parsed_result,
>   	struct rte_eth_dev_info dev_info;
>   	portid_t port_id = res->port_id;
>   	uint16_t queue_id = res->queue_id;
> -	struct rte_port *port = &ports[port_id];
> +	struct rte_port *port;
>   	uint64_t offload;
>   	int ret;
>   
> +	ret = eth_dev_info_get_print_err(port_id, &dev_info);
> +	if (ret != 0)
> +		return;
> +
> +	port = &ports[port_id];
>   	if (port->port_status != RTE_PORT_STOPPED) {
>   		fprintf(stderr,
>   			"Error: Can't config offload when Port %d is not stopped\n",
> @@ -12480,10 +12489,6 @@ cmd_config_per_queue_tx_offload_parsed(void *parsed_result,
>   		return;
>   	}
>   
> -	ret = eth_dev_info_get_print_err(port_id, &dev_info);
> -	if (ret != 0)
> -		return;
> -
>   	if (queue_id >= dev_info.nb_tx_queues) {
>   		fprintf(stderr,
>   			"Error: input queue_id should be 0 ... %d\n",
