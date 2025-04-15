Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E96C369AB
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Apr 2025 13:28:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BEC8A40289;
	Tue, 15 Apr 2025 15:28:12 +0200 (CEST)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by mails.dpdk.org (Postfix) with ESMTP id 9D60240263;
 Tue, 15 Apr 2025 15:28:10 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.163.174])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4ZcPyD58xRz69Z4;
 Tue, 15 Apr 2025 21:24:20 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
 by mail.maildlp.com (Postfix) with ESMTPS id 927F91402E2;
 Tue, 15 Apr 2025 21:28:08 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 15 Apr 2025 21:28:08 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 15 Apr
 2025 21:28:07 +0800
Message-ID: <89e4321b-4a28-400a-b54b-b723de2f6730@huawei.com>
Date: Tue, 15 Apr 2025 21:28:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 01/13] app/testpmd: revert auto attach/detach
To: Stephen Hemminger <stephen@networkplumber.org>, <dev@dpdk.org>
CC: <stable@dpdk.org>, Aman Singh <aman.deep.singh@intel.com>, Chengwen Feng
 <fengchengwen@huawei.com>, Dongdong Liu <liudongdong3@huawei.com>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250411234927.114568-2-stephen@networkplumber.org>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20250411234927.114568-2-stephen@networkplumber.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.121.59]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

Hi Stephen,

The main cause of cpfl driver attach failure is the added alarm in new 
event callback to setup port automatically.
It's a question of when to set up the new port. Please see the 
discussion[1]. I have a stupid method, but I'm not very willing to do that.
For the Bugzilla id1695, I'll take a look at it.

[1] https://bugs.dpdk.org/show_bug.cgi?id=1671

/Huisong

在 2025/4/12 7:44, Stephen Hemminger 写道:
> Revert "app/testpmd: add port attach/detach for multiple process"
> This reverts commit 994635edb2c038e64617bcf2790a8cd326c3e8e0.
>
> This commit breaks using pdump and other secondary processes that
> create there own devices. The patch makes testpmd grab any new
> hotplug device and configure it.
>
> It may also break failsafe and netvsc PMD handling of VF devices.
> But I don't have access to test that part.
>
> The patch is flawed in concept, and needs to go.
>
> Bugzilla ID: 1695
> Fixes: 994635edb2c0 ("app/testpmd: add port attach/detach for multiple process")
> Cc: lihuisong@huawei.com
> Cc: stable@dpdk.org
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>   app/test-pmd/testpmd.c | 77 +++++++++++-------------------------------
>   1 file changed, 20 insertions(+), 57 deletions(-)
>
> diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
> index b5f0c02261..7f4e3b434d 100644
> --- a/app/test-pmd/testpmd.c
> +++ b/app/test-pmd/testpmd.c
> @@ -705,7 +705,7 @@ eth_dev_set_mtu_mp(uint16_t port_id, uint16_t mtu)
>   }
>   
>   /* Forward function declarations */
> -static void setup_attached_port(void *arg);
> +static void setup_attached_port(portid_t pi);
>   static void check_all_ports_link_status(uint32_t port_mask);
>   static int eth_event_callback(portid_t port_id,
>   			      enum rte_eth_event_type type,
> @@ -2906,7 +2906,6 @@ start_port(portid_t pid)
>   		at_least_one_port_exist = true;
>   
>   		port = &ports[pi];
> -
>   		if (port->port_status == RTE_PORT_STOPPED) {
>   			port->port_status = RTE_PORT_HANDLING;
>   			all_ports_already_started = false;
> @@ -3254,7 +3253,6 @@ remove_invalid_ports(void)
>   	remove_invalid_ports_in(ports_ids, &nb_ports);
>   	remove_invalid_ports_in(fwd_ports_ids, &nb_fwd_ports);
>   	nb_cfg_ports = nb_fwd_ports;
> -	printf("Now total ports is %d\n", nb_ports);
>   }
>   
>   static void
> @@ -3427,11 +3425,14 @@ attach_port(char *identifier)
>   		return;
>   	}
>   
> -	/* First attach mode: event
> -	 * New port flag is updated on RTE_ETH_EVENT_NEW event
> -	 */
> +	/* first attach mode: event */
>   	if (setup_on_probe_event) {
> -		goto out;
> +		/* new ports are detected on RTE_ETH_EVENT_NEW event */
> +		for (pi = 0; pi < RTE_MAX_ETHPORTS; pi++)
> +			if (ports[pi].port_status == RTE_PORT_HANDLING &&
> +					ports[pi].need_setup != 0)
> +				setup_attached_port(pi);
> +		return;
>   	}
>   
>   	/* second attach mode: iterator */
> @@ -3439,17 +3440,13 @@ attach_port(char *identifier)
>   		/* setup ports matching the devargs used for probing */
>   		if (port_is_forwarding(pi))
>   			continue; /* port was already attached before */
> -		setup_attached_port((void *)(intptr_t)pi);
> +		setup_attached_port(pi);
>   	}
> -out:
> -	printf("Port %s is attached.\n", identifier);
> -	printf("Done\n");
>   }
>   
>   static void
> -setup_attached_port(void *arg)
> +setup_attached_port(portid_t pi)
>   {
> -	portid_t pi = (intptr_t)arg;
>   	unsigned int socket_id;
>   	int ret;
>   
> @@ -3464,8 +3461,14 @@ setup_attached_port(void *arg)
>   			"Error during enabling promiscuous mode for port %u: %s - ignore\n",
>   			pi, rte_strerror(-ret));
>   
> +	ports_ids[nb_ports++] = pi;
> +	fwd_ports_ids[nb_fwd_ports++] = pi;
> +	nb_cfg_ports = nb_fwd_ports;
>   	ports[pi].need_setup = 0;
>   	ports[pi].port_status = RTE_PORT_STOPPED;
> +
> +	printf("Port %d is attached. Now total ports is %d\n", pi, nb_ports);
> +	printf("Done\n");
>   }
>   
>   static void
> @@ -3495,8 +3498,10 @@ detach_device(struct rte_device *dev)
>   		TESTPMD_LOG(ERR, "Failed to detach device %s\n", rte_dev_name(dev));
>   		return;
>   	}
> +	remove_invalid_ports();
>   
>   	printf("Device is detached\n");
> +	printf("Now total ports is %d\n", nb_ports);
>   	printf("Done\n");
>   	return;
>   }
> @@ -3728,25 +3733,7 @@ rmv_port_callback(void *arg)
>   		struct rte_device *device = dev_info.device;
>   		close_port(port_id);
>   		detach_device(device); /* might be already removed or have more ports */
> -		remove_invalid_ports();
> -	}
> -	if (need_to_start)
> -		start_packet_forwarding(0);
> -}
> -
> -static void
> -remove_invalid_ports_callback(void *arg)
> -{
> -	portid_t port_id = (intptr_t)arg;
> -	int need_to_start = 0;
> -
> -	if (!test_done && port_is_forwarding(port_id)) {
> -		need_to_start = 1;
> -		stop_packet_forwarding();
>   	}
> -
> -	remove_invalid_ports();
> -
>   	if (need_to_start)
>   		start_packet_forwarding(0);
>   }
> @@ -3772,23 +3759,8 @@ eth_event_callback(portid_t port_id, enum rte_eth_event_type type, void *param,
>   
>   	switch (type) {
>   	case RTE_ETH_EVENT_NEW:
> -		/* The port in ports_id and fwd_ports_ids is always valid
> -		 * from index 0 ~ (nb_ports - 1) due to updating their
> -		 * position when one port is detached or removed.
> -		 */
> -		ports_ids[nb_ports++] = port_id;
> -		fwd_ports_ids[nb_fwd_ports++] = port_id;
> -		nb_cfg_ports = nb_fwd_ports;
> -		printf("Port %d is probed. Now total ports is %d\n", port_id, nb_ports);
> -
> -		if (setup_on_probe_event) {
> -			ports[port_id].need_setup = 1;
> -			ports[port_id].port_status = RTE_PORT_HANDLING;
> -		}
> -		/* Can't initialize port directly in new event. */
> -		if (rte_eal_alarm_set(100000, setup_attached_port,
> -				      (void *)(intptr_t)port_id))
> -			fprintf(stderr, "Could not set up deferred task to setup this attached port.\n");
> +		ports[port_id].need_setup = 1;
> +		ports[port_id].port_status = RTE_PORT_HANDLING;
>   		break;
>   	case RTE_ETH_EVENT_INTR_RMV:
>   		if (port_id_is_invalid(port_id, DISABLED_WARN))
> @@ -3801,15 +3773,6 @@ eth_event_callback(portid_t port_id, enum rte_eth_event_type type, void *param,
>   	case RTE_ETH_EVENT_DESTROY:
>   		ports[port_id].port_status = RTE_PORT_CLOSED;
>   		printf("Port %u is closed\n", port_id);
> -		/*
> -		 * Defer to remove port id due to the reason that the ethdev
> -		 * state is changed from 'ATTACHED' to 'UNUSED' only after the
> -		 * event callback finished. Otherwise this port id can not be
> -		 * removed.
> -		 */
> -		if (rte_eal_alarm_set(100000, remove_invalid_ports_callback,
> -				      (void *)(intptr_t)port_id))
> -			fprintf(stderr, "Could not set up deferred task to remove this port id.\n");
>   		break;
>   	case RTE_ETH_EVENT_RX_AVAIL_THRESH: {
>   		uint16_t rxq_id;
