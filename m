Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89CE7C83F34
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Jul 2025 03:27:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 77515402CA;
	Wed, 23 Jul 2025 05:27:56 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id BEBCB4026D
 for <dev@dpdk.org>; Wed, 23 Jul 2025 05:27:54 +0200 (CEST)
Received: from debian (unknown [78.109.70.60])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 4D728E080B;
 Wed, 23 Jul 2025 07:27:53 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 4D728E080B
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1753241273;
 bh=cCyGZUkt4eCRQG7npPvmmiZteYx0Qz9FN3Ov/R2sDrk=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=8KUZVr1M1Ro4vORGlBN8LDzljZ9K+VzpXRpRA6+qqGYnRP9DLAmYPo6gqbM/a5APc
 RuZ9n0B54MJNEB3MUDJDduYVfHi8CSJ1QbrJ1yPJlUX7fd5Q+qpfHjkGhx5Y8KD/Co
 AGcqfjYj4uzJH+M62iYWY3t4JGnYzF8h5oBkG+IdHqhd2Ybzzhg+0oN+byYffXk5Ew
 52E18ZRnRiV/OrNJL32MtkPhIGhT6Fe/yYy0Ec9A0Q5+S/qcYtWbZVX39AJTaB4mrR
 rGXNrMzv1aZAz1H2TWo1YreON6nRwJgxc3BsVahGGugjCF1a5OrBIxlL6lkdAutBs4
 iytr+SwRRIg0w==
Date: Wed, 23 Jul 2025 07:27:52 +0400 (+04)
From: Ivan Malov <ivan.malov@arknetworks.am>
To: Stephen Hemminger <stephen@networkplumber.org>
cc: dev@dpdk.org, Reshma Pattan <reshma.pattan@intel.com>
Subject: Re: [PATCH v6 12/13] app/dumpcap: use port mirror instead of pdump
In-Reply-To: <b2c6635a-0cdd-351d-cdb1-b3101a5cc247@arknetworks.am>
Message-ID: <3ea95845-ac60-fb1e-5900-5e5f8a6a2fe2@arknetworks.am>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250722173552.184141-1-stephen@networkplumber.org>
 <20250722173552.184141-13-stephen@networkplumber.org>
 <b2c6635a-0cdd-351d-cdb1-b3101a5cc247@arknetworks.am>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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

On Wed, 23 Jul 2025, Ivan Malov wrote:

> Hi Stephen,
>
> (please see below)
>
> On Tue, 22 Jul 2025, Stephen Hemminger wrote:
>
>> Use the new port mirror API instead of pdump.
>> 
>> Since filtering is now done in dumpcap process (not primary).
>> For portability use PCAP to do packet filtering.
>> This removes dependency on DPDK implementation of BPF.
>> Filtering will be slower (no JIT) but is portable to Windows.
>> Can revisit later when BPF support is updated.
>> 
>> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
>> ---
>> app/dumpcap/main.c      | 468 ++++++++++++++++++++++++++++++++--------
>> app/dumpcap/meson.build |   8 +-
>> 2 files changed, 378 insertions(+), 98 deletions(-)
>> 
>> diff --git a/app/dumpcap/main.c b/app/dumpcap/main.c
>> index 3d3c0dbc66..9934504f8a 100644
>> --- a/app/dumpcap/main.c
>> +++ b/app/dumpcap/main.c
>> @@ -25,7 +25,6 @@
>> 
>> #include <rte_alarm.h>
>> #include <rte_bitops.h>
>> -#include <rte_bpf.h>
>> #include <rte_config.h>
>> #include <rte_debug.h>
>> #include <rte_eal.h>
>> @@ -36,8 +35,6 @@
>> #include <rte_mbuf.h>
>> #include <rte_mempool.h>
>> #include <rte_pcapng.h>
>> -#include <rte_pdump.h>
>> -#include <rte_ring.h>
>> #include <rte_string_fns.h>
>> #include <rte_thread.h>
>> #include <rte_time.h>
>> @@ -93,15 +90,26 @@ struct interface {
>> 	TAILQ_ENTRY(interface) next;
>> 	uint16_t port;
>> 	struct capture_options opts;
>> -	struct rte_bpf_prm *bpf_prm;
>> 	char name[RTE_ETH_NAME_MAX_LEN];
>> +	struct bpf_insn *bpf;
>> 
>> +	struct rte_eth_stats start_stats;
>> 	const char *ifname;
>> 	const char *ifdescr;
>> };
>> 
>> +static int timestamp_dynfield = -1;
>> +static uint64_t timestamp_dynflag;
>> +static int mirror_origin_dynfield = -1;
>> +static uint64_t mirror_origin_dynflag;
>> +static uint64_t mirror_ingress_dynflag;
>> +static uint64_t mirror_egress_dynflag;
>> +
>> +static bool filtering;
>> +
>> TAILQ_HEAD(interface_list, interface);
>> static struct interface_list interfaces = 
>> TAILQ_HEAD_INITIALIZER(interfaces);
>> +static struct interface *port2intf[RTE_MAX_ETHPORTS];
>> 
>> /* Can do either pcap or pcapng format output */
>> typedef union {
>> @@ -239,14 +247,16 @@ static void find_interfaces(void)
>>
>> 	TAILQ_FOREACH(intf, &interfaces, next) {
>> 		/* if name is valid then just record port */
>> -		if (rte_eth_dev_get_port_by_name(intf->name, &intf->port) == 
>> 0)
>> -			continue;
>> +		if (rte_eth_dev_get_port_by_name(intf->name, &intf->port) != 
>> 0) {
>> +			/* maybe got passed port number string as name */
>> +			intf->port = get_uint(intf->name, "port_number", 
>> UINT16_MAX);
>> +			if (rte_eth_dev_get_name_by_port(intf->port, 
>> intf->name) < 0)
>> +				rte_exit(EXIT_FAILURE, "Invalid port number 
>> %u\n",
>> +					 intf->port);
>> +		}
>> 
>> -		/* maybe got passed port number string as name */
>> -		intf->port = get_uint(intf->name, "port_number", UINT16_MAX);
>> -		if (rte_eth_dev_get_name_by_port(intf->port, intf->name) < 0)
>> -			rte_exit(EXIT_FAILURE, "Invalid port number %u\n",
>> -				 intf->port);
>> +		if (rte_eth_stats_get(intf->port, &intf->start_stats) < 0)
>> +			rte_exit(EXIT_FAILURE, "Could not read stats for port 
>> %u\n", intf->port);
>> 	}
>> }
>> 
>> @@ -266,6 +276,10 @@ static void set_default_interface(void)
>>
>> 		intf = add_interface(name);
>> 		intf->port = p;
>> +
>> +		if (rte_eth_stats_get(intf->port, &intf->start_stats) < 0)
>> +			rte_exit(EXIT_FAILURE,
>> +				 "Could not read stats for port %u\n", 
>> intf->port);
>> 		return;
>> 	}
>> 	rte_exit(EXIT_FAILURE, "No usable interfaces found\n");
>> @@ -291,44 +305,40 @@ static void compile_filters(void)
>> 	struct interface *intf;
>>
>> 	TAILQ_FOREACH(intf, &interfaces, next) {
>> -		struct rte_bpf_prm *bpf_prm;
>> 		struct bpf_program bf;
>> 		pcap_t *pcap;
>> 
>> +		/* cache for filter packets */
>> +		port2intf[intf->port] = intf;
>> +
>> +		if (intf->opts.filter == NULL) {
>> +			intf->bpf = NULL;
>> +			continue;
>> +		}
>> +
>> 		pcap = pcap_open_dead(DLT_EN10MB, intf->opts.snap_len);
>> 		if (!pcap)
>> 			rte_exit(EXIT_FAILURE, "can not open pcap\n");
>> 
>> -		if (pcap_compile(pcap, &bf, intf->opts.filter,
>> -				 1, PCAP_NETMASK_UNKNOWN) != 0) {
>> +		if (pcap_compile(pcap, &bf, intf->opts.filter, 1, 
>> PCAP_NETMASK_UNKNOWN) != 0) {
>> 			fprintf(stderr,
>> 				"Invalid capture filter \"%s\": for interface 
>> '%s'\n",
>> 				intf->opts.filter, intf->name);
>> -			rte_exit(EXIT_FAILURE, "\n%s\n",
>> -				 pcap_geterr(pcap));
>> +			rte_exit(EXIT_FAILURE, "\n%s\n", pcap_geterr(pcap));
>> 		}
>> 
>> -		bpf_prm = rte_bpf_convert(&bf);
>> -		if (bpf_prm == NULL)
>> -			rte_exit(EXIT_FAILURE,
>> -				 "BPF convert interface '%s'\n%s(%d)\n",
>> -				 intf->name,
>> -				 rte_strerror(rte_errno), rte_errno);
>> -
>> 		if (dump_bpf) {
>> 			printf("cBPF program (%u insns)\n", bf.bf_len);
>> 			bpf_dump(&bf, 1);
>> -			printf("\neBPF program (%u insns)\n",
>> -			       bpf_prm->nb_ins);
>> -			rte_bpf_dump(stdout, bpf_prm->ins, bpf_prm->nb_ins);
>> 			exit(0);
>> 		}
>> 
>> -		intf->bpf_prm = bpf_prm;
>> +		intf->bpf = malloc(bf.bf_len * sizeof(struct bpf_insn));
>> +		if (!intf->bpf)
>> +			rte_exit(EXIT_FAILURE, "can not allocate memory for 
>> bpf\n");
>> 
>> -		/* Don't care about original program any more */
>> -		pcap_freecode(&bf);
>> -		pcap_close(pcap);
>> +		memcpy(intf->bpf, bf.bf_insns, bf.bf_len * sizeof(struct 
>> bpf_insn));
>> +		filtering = true;
>> 	}
>> }
>> 
>> @@ -518,13 +528,12 @@ static void statistics_loop(void)
>> }
>> 
>> static void
>> -cleanup_pdump_resources(void)
>> +disable_mirror_ports(uint16_t mirror_port)
>> {
>> 	struct interface *intf;
>>
>> 	TAILQ_FOREACH(intf, &interfaces, next) {
>> -		rte_pdump_disable(intf->port,
>> -				  RTE_PDUMP_ALL_QUEUES, RTE_PDUMP_FLAG_RXTX);
>> +		rte_eth_remove_mirror(intf->port, mirror_port);
>> 		if (intf->opts.promisc_mode)
>> 			rte_eth_promiscuous_disable(intf->port);
>> 	}
>> @@ -541,7 +550,7 @@ monitor_primary(void *arg __rte_unused)
>> 		rte_eal_alarm_set(MONITOR_INTERVAL, monitor_primary, NULL);
>> 	} else {
>> 		fprintf(stderr,
>> -			"Primary process is no longer active, exiting...\n");
>> +			"\nPrimary process is no longer active, 
>> exiting...\n");
>> 		rte_atomic_store_explicit(&quit_signal, true, 
>> rte_memory_order_relaxed);
>> 	}
>> }
>> @@ -552,7 +561,6 @@ enable_primary_monitor(void)
>> {
>> 	int ret;
>> 
>> -	/* Once primary exits, so will pdump. */
>> 	ret = rte_eal_alarm_set(MONITOR_INTERVAL, monitor_primary, NULL);
>> 	if (ret < 0)
>> 		fprintf(stderr, "Fail to enable monitor:%d\n", ret);
>> @@ -571,23 +579,24 @@ disable_primary_monitor(void)
>> static void
>> report_packet_stats(dumpcap_out_t out)
>> {
>> -	struct rte_pdump_stats pdump_stats;
>> 	struct interface *intf;
>> -	uint64_t ifrecv, ifdrop;
>> -	double percent;
>>
>> 	fputc('\n', stderr);
>> +
>> 	TAILQ_FOREACH(intf, &interfaces, next) {
>> -		if (rte_pdump_stats(intf->port, &pdump_stats) < 0)
>> +		uint64_t ifrecv, ifdrop;
>> +		struct rte_eth_stats stats;
>> +		double percent;
>> +
>> +		if (rte_eth_stats_get(intf->port, &stats) < 0)
>> 			continue;
>> 
>> -		/* do what Wiretap does */
>> -		ifrecv = pdump_stats.accepted + pdump_stats.filtered;
>> -		ifdrop = pdump_stats.nombuf + pdump_stats.ringfull;
>> +		ifrecv = stats.ipackets - intf->start_stats.ipackets;
>> +		ifdrop = (stats.rx_nombuf - intf->start_stats.rx_nombuf)
>> +			+ (stats.imissed - intf->start_stats.imissed);
>>
>> 		if (use_pcapng)
>> -			rte_pcapng_write_stats(out.pcapng, intf->port,
>> -					       ifrecv, ifdrop, NULL);
>> +			rte_pcapng_write_stats(out.pcapng, intf->port, 
>> ifrecv, ifdrop, NULL);
>>
>> 		if (ifrecv == 0)
>> 			percent = 0;
>> @@ -668,12 +677,21 @@ static void dpdk_init(void)
>> 		rte_exit(EXIT_FAILURE, "Can not restore original CPU 
>> affinity\n");
>> }
>> 
>> -/* Create packet ring shared between callbacks and process */
>> -static struct rte_ring *create_ring(void)
>> +/* Create ring port to redirect packet to.
>
> Perhaps adhere to
> /*
> * comment
> */
> style (I do not insist - this is up to you).
>
>> + * This could be much simpler if the ring PMD API (rte_eth_from_rings)
>> + * worked from a secondary process, but it doesn't.
>> + */
>> +static struct rte_ring *
>> +create_ring_dev(char *vdev_name, uint16_t *mirror_port)
>> {
>> -	struct rte_ring *ring;
>> +	struct rte_eth_dev_owner owner = { 0 };
>> +	struct rte_eth_conf dev_conf = { 0 };
>> +	struct rte_ring *ring = NULL;
>> 	char ring_name[RTE_RING_NAMESIZE];
>> +	char vdev_args[128];
>> 	size_t size, log2;
>> +	uint16_t port;
>> +	int ret;
>>
>> 	/* Find next power of 2 >= size. */
>> 	size = ring_size;
>> @@ -686,17 +704,59 @@ static struct rte_ring *create_ring(void)
>> 		ring_size = size;
>> 	}
>> 
>> -	/* Want one ring per invocation of program */
>> -	snprintf(ring_name, sizeof(ring_name),
>> -		 "dumpcap-%d", getpid());
>> +	/* Use owner as unique Id for ring and to isolate */
>
> Perhaps spell 'Id' all-caps: 'ID' (this is up to you).
>
>> +	ret = rte_eth_dev_owner_new(&owner.id);
>> +	if (ret < 0)
>> +		rte_exit(EXIT_FAILURE, "rte_eth_dev_owner_new failed: %s\n",
>> +			 strerror(-ret));
>> 
>> -	ring = rte_ring_create(ring_name, ring_size,
>> -			       rte_socket_id(), 0);
>> +	/* Give the vdev a unique name */
>> +	snprintf(ring_name, sizeof(ring_name), "dumpcap%"PRIu64, owner.id);
>> +	ring = rte_ring_create(ring_name, ring_size, rte_socket_id(),
>> +			       RING_F_MP_RTS_ENQ | RING_F_SC_DEQ);
>> 	if (ring == NULL)
>> 		rte_exit(EXIT_FAILURE, "Could not create ring :%s\n",
>> 			 rte_strerror(rte_errno));
>> 
>> +	strlcpy(owner.name, ring_name, sizeof(owner.name));
>> +
>> +	snprintf(vdev_name, RTE_DEV_NAME_MAX_LEN, "net_ring-dumpcap%"PRIu64, 
>> owner.id);
>> +	snprintf(vdev_args, sizeof(vdev_args), "ring=%s", ring_name);
>> +
>> +	if (rte_eal_hotplug_add("vdev", vdev_name, vdev_args) < 0)
>
> Perhaps enclose the multi-line statement with '{' and '}'. Also, if 
> 'rte_exit'
> frees resources, including the ring created above, then not jumping to 
> 'unplug'
> is fine, but is slightly inconsistent with below jumps: if jump there, why 
> not
> also do this here? May be I'm wrong in fact.
>
> May be add a little more elaborate fail ladder instead of just one 'unplug'?
>
>> +		rte_exit(EXIT_FAILURE,
>> +			 "rte_eal_hotplug_add of %s failed:%s\n",
>> +			 vdev_name, rte_strerror(rte_errno));
>> +
>> +	ret = rte_eth_dev_get_port_by_name(vdev_name, &port);
>> +	if (ret != 0) {
>> +		fprintf(stderr, "Could not port for %s: %s\n",
>> +			vdev_name, strerror(-ret));
>> +		goto unplug;
>> +	}
>> +
>> +	ret = rte_eth_dev_owner_set(port, &owner);
>> +	if (ret != 0) {
>> +		fprintf(stderr, "Could not set owner for port for %u: %s\n",
>
> Redundant 'for' in 'for port for'?
>
>> +			port, strerror(-ret));
>> +		goto unplug;
>> +	}
>> +
>> +	ret = rte_eth_dev_configure(port, 1, 1, &dev_conf);
>> +	if (ret < 0) {
>> +		fprintf(stderr, "Could not configure port %u: %s\n",
>> +			port, strerror(-ret));
>> +		goto unplug;
>> +	}
>> +
>> +	*mirror_port = port;
>> 	return ring;
>> +
>> +unplug:
>> +	rte_eal_hotplug_remove("vdev", vdev_name);
>> +	rte_ring_free(ring);
>> +	rte_eal_cleanup();
>> +	exit(EXIT_FAILURE);
>> }
>> 
>> static struct rte_mempool *create_mempool(void)
>> @@ -796,7 +856,7 @@ static dumpcap_out_t create_output(void)
>> 					   version(), capture_comment);
>> 		if (ret.pcapng == NULL)
>> 			rte_exit(EXIT_FAILURE, "pcapng_fdopen failed: %s\n",
>> -				 strerror(rte_errno));
>> +				 rte_strerror(rte_errno));
>> 		free(os);
>>
>> 		TAILQ_FOREACH(intf, &interfaces, next) {
>> @@ -823,37 +883,32 @@ static dumpcap_out_t create_output(void)
>> 	return ret;
>> }
>> 
>> -static void enable_pdump(struct rte_ring *r, struct rte_mempool *mp)
>> +static int enable_mirror(uint16_t mirror_port, struct rte_mempool *mpool)
>> {
>> 	struct interface *intf;
>> 	unsigned int count = 0;
>> -	uint32_t flags;
>> 	int ret;
>> 
>> -	flags = RTE_PDUMP_FLAG_RXTX;
>> -	if (use_pcapng)
>> -		flags |= RTE_PDUMP_FLAG_PCAPNG;
>> +	ret = rte_eth_dev_start(mirror_port);
>> +	if (ret < 0)
>> +		rte_exit(EXIT_FAILURE, "Could not start mirror port %u: 
>> %s\n",
>> +			 mirror_port, strerror(-ret));
>>
>> 	TAILQ_FOREACH(intf, &interfaces, next) {
>> -		ret = rte_pdump_enable_bpf(intf->port, RTE_PDUMP_ALL_QUEUES,
>> -					   flags, intf->opts.snap_len,
>> -					   r, mp, intf->bpf_prm);
>> +		struct rte_eth_mirror_conf conf = {
>> +			.mp = mpool,
>> +			.target = mirror_port,
>> +			.snaplen = intf->opts.snap_len,
>> +			.flags = RTE_ETH_MIRROR_ORIGIN_FLAG | 
>> RTE_ETH_MIRROR_TIMESTAMP_FLAG,
>> +			.direction = RTE_ETH_MIRROR_DIRECTION_INGRESS |
>> +				     RTE_ETH_MIRROR_DIRECTION_EGRESS,
>> +		};
>> +
>> +		ret = rte_eth_add_mirror(intf->port, &conf);
>> 		if (ret < 0) {
>> -			const struct interface *intf2;
>> -
>> -			/* unwind any previous enables */
>> -			TAILQ_FOREACH(intf2, &interfaces, next) {
>> -				if (intf == intf2)
>> -					break;
>> -				rte_pdump_disable(intf2->port,
>> -						  RTE_PDUMP_ALL_QUEUES, 
>> RTE_PDUMP_FLAG_RXTX);
>> -				if (intf2->opts.promisc_mode)
>> - 
>> rte_eth_promiscuous_disable(intf2->port);
>> -			}
>> -			rte_exit(EXIT_FAILURE,
>> -				"Packet dump enable on %u:%s failed %s\n",
>> -				intf->port, intf->name,
>> -				rte_strerror(rte_errno));
>> +			fprintf(stderr, "Port mirror on %u:%s failed %s\n",
>> +				intf->port, intf->name, strerror(-ret));
>> +			return -1;
>> 		}
>>
>> 		if (intf->opts.promisc_mode) {
>> @@ -868,6 +923,60 @@ static void enable_pdump(struct rte_ring *r, struct 
>> rte_mempool *mp)
>> 		}
>> 		++count;
>> 	}
>> +	return count;
>> +}
>> +
>> +static int setup_mbuf(void)
>> +{
>> +	int offset;
>> +
>> +	offset = rte_mbuf_dynfield_lookup(RTE_MBUF_DYNFIELD_TIMESTAMP_NAME, 
>> NULL);
>> +	if (offset < 0) {
>> +		fprintf(stderr, "Could not find timestamp dynamic field\n");
>> +		return -1;
>> +	}
>> +	timestamp_dynfield = offset;
>> +
>> +	offset = rte_mbuf_dynflag_lookup(RTE_MBUF_DYNFLAG_TX_TIMESTAMP_NAME, 
>> NULL);
>> +	if (offset < 0) {
>> +		fprintf(stderr, "Could not find timestamp flag\n");
>> +		return -1;
>> +	}
>> +	timestamp_dynflag = RTE_BIT64(offset);
>> +
>> +	offset = rte_mbuf_dynfield_lookup(RTE_MBUF_DYNFIELD_MIRROR_ORIGIN, 
>> NULL);
>> +	if (offset < 0) {
>> +		fprintf(stderr, "Could not find mirror origin dynamic 
>> field\n");
>> +		return -1;
>> +	}
>> +	mirror_origin_dynfield = offset;
>> +
>> +	offset = rte_mbuf_dynflag_lookup(RTE_MBUF_DYNFLAG_MIRROR_ORIGIN, 
>> NULL);
>> +	if (offset < 0) {
>> +		fprintf(stderr, "Could not find mirror origin dynamic 
>> flag\n");
>> +		return -1;
>> +	}
>> +	mirror_origin_dynflag = RTE_BIT64(offset);
>> +
>> +	offset = rte_mbuf_dynflag_lookup(RTE_MBUF_DYNFLAG_MIRROR_INGRESS, 
>> NULL);
>> +	if (offset < 0) {
>> +		fprintf(stderr, "Could not find mirror ingress flag\n");
>> +		return -1;
>> +	}
>> +	mirror_ingress_dynflag = RTE_BIT64(offset);
>> +
>> +	offset = rte_mbuf_dynflag_lookup(RTE_MBUF_DYNFLAG_MIRROR_EGRESS, 
>> NULL);
>> +	if (offset < 0) {
>> +		fprintf(stderr, "Could not find mirror egress flag\n");
>> +		return -1;
>> +	}
>> +	mirror_egress_dynflag = RTE_BIT64(offset);
>> +	return 0;
>> +}
>> +
>> +static void show_capturing(unsigned int count)
>> +{
>> +	struct interface *intf;
>>
>> 	fputs("Capturing on ", stdout);
>> 	TAILQ_FOREACH(intf, &interfaces, next) {
>> @@ -898,6 +1007,47 @@ static void show_count(uint64_t count)
>> 	bt = fprintf(stderr, "%"PRIu64" ", count);
>> }
>> 
>> +static ssize_t
>> +pcapng_write_packets(rte_pcapng_t *pcapng, struct rte_mbuf *pkts[], 
>> uint16_t n)
>> +{
>> +	struct rte_mbuf *towrite[BURST_SIZE];
>> +	unsigned int count = 0;
>> +
>> +	for (unsigned int i = 0; i < n; i++) {
>> +		struct rte_mbuf *m = pkts[i];
>> +		enum rte_pcapng_direction direction = 
>> RTE_PCAPNG_DIRECTION_UNKNOWN;
>> +
>> +		/* If no origin flag then why did we get this? */
>> +		if (unlikely(!(m->ol_flags & mirror_origin_dynflag))) {
>> +			fprintf(stderr, "Missing origin info in packet\n");
>
> And what happens to the rest of mbufs in the 'pkts' batch? Leak?

Sorry, my bad, - I see the whole bulk is freed outside.

Thank you.

>
>> +			return -1;
>> +		}
>> +
>> +		const struct rte_mbuf_origin *origin
>> +			= RTE_MBUF_DYNFIELD(m, mirror_origin_dynfield, 
>> rte_mbuf_origin_t *);
>> +
>> +		if (m->ol_flags & mirror_ingress_dynflag)
>> +			direction = RTE_PCAPNG_DIRECTION_IN;
>> +		else if (m->ol_flags & mirror_egress_dynflag)
>> +			direction = RTE_PCAPNG_DIRECTION_OUT;
>> +
>> +		uint64_t timestamp;
>> +		if (m->ol_flags & timestamp_dynflag)
>> +			timestamp = *RTE_MBUF_DYNFIELD(m, timestamp_dynfield,
>> +						       rte_mbuf_timestamp_t 
>> *);
>> +		else
>> +			timestamp = rte_get_tsc_cycles();
>> +
>> +		if (rte_pcapng_insert(m, origin->queue_id, direction, 
>> origin->original_len,
>> +				      timestamp, NULL) < 0)
>> +			continue;  /* skip no headroom? */
>> +
>> +		towrite[count++] = m;
>> +	}
>> +
>> +	return rte_pcapng_write_packets(pcapng, towrite, count);
>> +}
>> +
>> /* Write multiple packets in older pcap format */
>> static ssize_t
>> pcap_write_packets(pcap_dumper_t *dumper,
>> @@ -930,16 +1080,129 @@ pcap_write_packets(pcap_dumper_t *dumper,
>> 	return total;
>> }
>> 
>> +/* Do packet filter on incoming packets.
>> + * Some issues to note here:
>> + *  - would be better to do before putting into ring
>> + *    but that causes ethdev to have dependency on BPF.
>> + *  - the filter is per-interface and there maybe more than one interface
>> + *    combined into the ring. That means filter is executed once
>> + *    per packet (not as burst).
>> + */
>> +static unsigned int
>> +filter_packets(struct rte_mbuf *pkts[], unsigned int n)
>> +{
>> +	unsigned int matches = 0;
>> +	unsigned int results[BURST_SIZE] = { 0 };
>> +
>> +	for (unsigned int i = 0; i < n; i++) {
>> +		struct rte_mbuf *m = pkts[i];
>> +
>> +		/* all packets should have origin info, if not just skip */
>> +		if (unlikely(!(m->ol_flags & mirror_origin_dynflag)))
>> +			continue;
>> +
>> +		const struct rte_mbuf_origin *origin
>> +			= RTE_MBUF_DYNFIELD(m, mirror_origin_dynfield, 
>> rte_mbuf_origin_t *);
>> +		uint16_t port_id = origin->port_id;
>> +
>> +		if (unlikely(port_id >= RTE_MAX_ETHPORTS))
>> +			continue;
>> +
>> +		const struct interface *intf = port2intf[port_id];
>> +		if (intf == NULL || intf->bpf == NULL)
>> +			continue;
>> +
>> +		results[i] = bpf_filter(intf->bpf, rte_pktmbuf_mtod(m, u_char 
>> *),
>> +					origin->original_len, m->data_len);
>> +		if (results[i] != 0)
>> +			++matches;
>> +	}
>> +
>> +	if (matches == n)
>> +		return n;	/* no packets skipped */
>> +
>> +	/* need to shuffle out the skipped packets */
>> +	unsigned int count = 0;
>> +	struct rte_mbuf *towrite[BURST_SIZE];
>> +	for (unsigned int i = 0; i < n; i++) {
>> +		if (results[i])
>> +			towrite[count++] = pkts[i];
>> +		else
>> +			rte_pktmbuf_free(pkts[i]);
>> +	}
>> +	memcpy(pkts, towrite, count * sizeof(struct rte_mbuf *));
>> +	return count;
>> +}
>> +
>> +/* Make sure configuration of mbuf pool has enough headroom for both vlans 
>> */
>
> Perhaps spell 'vlans' all-caps: 'VLANs'.
>
>> +static_assert(RTE_PKTMBUF_HEADROOM > 2 * sizeof(struct rte_vlan_hdr),
>> +	"not enough mbuf headroom for vlan insertion");
>
> Same here: 'VLAN' (up to you).
>
>> +
>> +/*
>> + * More general version of rte_vlan_insert()
>> + * Note: mbufs are allocated by rte_eth_mirror_burst() from the
>> + * pool that was passed when setting up mirror.
>> + */
>> +static void
>> +vlan_insert(struct rte_mbuf *m, uint16_t ether_type, uint16_t tci)
>> +{
>> +	struct rte_ether_hdr *nh, tmph;
>> +	const struct rte_ether_hdr *oh;
>> +	struct rte_vlan_hdr *vh;
>> +
>> +	RTE_ASSERT(!RTE_MBUF_DIRECT(m));
>> +	RTE_ASSERT(rte_mbuf_refcnt_read(m) == 1);
>> +
>> +	oh = rte_pktmbuf_read(m, 0, sizeof(*oh), &tmph);
>> +	RTE_ASSERT(oh != NULL);
>> +
>> +	/* overlay new header */
>> +	nh = (struct rte_ether_hdr *)
>> +		rte_pktmbuf_prepend(m, sizeof(struct rte_vlan_hdr));
>
> Prepend? But what if this is an indirect mbuf. Is it OK? Just asking.
>
> Thank you.
>
>> +
>> +	RTE_ASSERT(nh != NULL);
>> +
>> +	memmove(nh, oh, 2 * RTE_ETHER_ADDR_LEN);
>> +	nh->ether_type = rte_cpu_to_be_16(ether_type);
>> +
>> +	vh = (struct rte_vlan_hdr *) (nh + 1);
>> +	vh->vlan_tci = rte_cpu_to_be_16(tci);
>> +}
>> +
>> +/* Filtering and pcap file format require that VLAN not be offloaded */
>> +static void
>> +remove_vlan_offload(struct rte_mbuf *pkts[], unsigned int n)
>> +{
>> +	unsigned int i;
>> +
>> +	for (i = 0; i < n; i++) {
>> +		struct rte_mbuf *m = pkts[i];
>> +
>> +		if (m->ol_flags & mirror_ingress_dynflag) {
>> +			if (m->ol_flags & RTE_MBUF_F_RX_VLAN_STRIPPED)
>> +				vlan_insert(m, RTE_ETHER_TYPE_VLAN, 
>> m->vlan_tci);
>> +			if (m->ol_flags & RTE_MBUF_F_RX_QINQ_STRIPPED)
>> +				vlan_insert(m, RTE_ETHER_TYPE_QINQ, 
>> m->vlan_tci_outer);
>> +		}
>> +		if (m->ol_flags & mirror_egress_dynflag) {
>> +			if (m->ol_flags & RTE_MBUF_F_TX_VLAN)
>> +				vlan_insert(m, RTE_ETHER_TYPE_VLAN, 
>> m->vlan_tci);
>> +			if (m->ol_flags & RTE_MBUF_F_TX_QINQ)
>> +				vlan_insert(m, RTE_ETHER_TYPE_QINQ, 
>> m->vlan_tci_outer);
>> +
>> +		}
>> +	}
>> +}
>> +
>> /* Process all packets in ring and dump to capture file */
>> -static int process_ring(dumpcap_out_t out, struct rte_ring *r)
>> +static int process_ring(dumpcap_out_t out, struct rte_ring *ring)
>> {
>> 	struct rte_mbuf *pkts[BURST_SIZE];
>> -	unsigned int avail, n;
>> +	unsigned int n, avail;
>> 	static unsigned int empty_count;
>> 	ssize_t written;
>> 
>> -	n = rte_ring_sc_dequeue_burst(r, (void **) pkts, BURST_SIZE,
>> -				      &avail);
>> +	n = rte_ring_sc_dequeue_burst(ring, (void **)pkts, BURST_SIZE, 
>> &avail);
>> 	if (n == 0) {
>> 		/* don't consume endless amounts of cpu if idle */
>> 		if (empty_count < SLEEP_THRESHOLD)
>> @@ -948,11 +1211,18 @@ static int process_ring(dumpcap_out_t out, struct 
>> rte_ring *r)
>> 			usleep(10);
>> 		return 0;
>> 	}
>> -
>> 	empty_count = (avail == 0);
>> 
>> +	remove_vlan_offload(pkts, n);
>> +
>> +	if (filtering) {
>> +		n = filter_packets(pkts, n);
>> +		if (n == 0)
>> +			return 0;
>> +	}
>> +
>> 	if (use_pcapng)
>> -		written = rte_pcapng_write_packets(out.pcapng, pkts, n);
>> +		written = pcapng_write_packets(out.pcapng, pkts, n);
>> 	else
>> 		written = pcap_write_packets(out.dumper, pkts, n);
>> 
>> @@ -971,15 +1241,18 @@ static int process_ring(dumpcap_out_t out, struct 
>> rte_ring *r)
>> 
>> int main(int argc, char **argv)
>> {
>> -	struct rte_ring *r;
>> 	struct rte_mempool *mp;
>> 	struct sigaction action = {
>> 		.sa_flags = SA_RESTART,
>> 		.sa_handler = signal_handler,
>> 	};
>> 	struct sigaction origaction;
>> +	struct rte_ring *ring = NULL;
>> +	char vdev_name[RTE_DEV_NAME_MAX_LEN];
>> +	uint16_t mirror_port = UINT16_MAX;
>> 	dumpcap_out_t out;
>> 	char *p;
>> +	int ret;
>>
>> 	p = strrchr(argv[0], '/');
>> 	if (p == NULL)
>> @@ -1018,12 +1291,21 @@ int main(int argc, char **argv)
>> 		exit(0);
>> 	}
>> 
>> -	r = create_ring();
>> 	mp = create_mempool();
>> +	ring = create_ring_dev(vdev_name, &mirror_port);
>> 	out = create_output();
>> 
>> +	ret = enable_mirror(mirror_port, mp);
>> +	if (ret < 0)
>> +		goto cleanup;
>> +
>> +	ret = setup_mbuf();
>> +	if (ret < 0)
>> +		goto cleanup;
>> +
>> +	show_capturing(ret);
>> +
>> 	start_time = time(NULL);
>> -	enable_pdump(r, mp);
>>
>> 	if (!quiet) {
>> 		fprintf(stderr, "Packets captured: ");
>> @@ -1031,7 +1313,7 @@ int main(int argc, char **argv)
>> 	}
>>
>> 	while (!rte_atomic_load_explicit(&quit_signal, 
>> rte_memory_order_relaxed)) {
>> -		if (process_ring(out, r) < 0) {
>> +		if (process_ring(out, ring) < 0) {
>> 			fprintf(stderr, "pcapng file write failed; %s\n",
>> 				strerror(errno));
>> 			break;
>> @@ -1048,20 +1330,24 @@ int main(int argc, char **argv)
>> 			break;
>> 	}
>> 
>> -	disable_primary_monitor();
>> -
>> 	if (rte_eal_primary_proc_alive(NULL))
>> 		report_packet_stats(out);
>> 
>> +cleanup:
>> +	disable_primary_monitor();
>> +
>> 	if (use_pcapng)
>> 		rte_pcapng_close(out.pcapng);
>> 	else
>> 		pcap_dump_close(out.dumper);
>> 
>> -	cleanup_pdump_resources();
>> +	if (rte_eal_primary_proc_alive(NULL)) {
>> +		disable_mirror_ports(mirror_port);
>> 
>> -	rte_ring_free(r);
>> -	rte_mempool_free(mp);
>> +		rte_eal_hotplug_remove("vdev", vdev_name);
>> +		rte_ring_free(ring);
>> +		rte_mempool_free(mp);
>> +	}
>>
>> 	return rte_eal_cleanup() ? EXIT_FAILURE : 0;
>> }
>> diff --git a/app/dumpcap/meson.build b/app/dumpcap/meson.build
>> index 69c016c780..3b50077756 100644
>> --- a/app/dumpcap/meson.build
>> +++ b/app/dumpcap/meson.build
>> @@ -6,12 +6,6 @@ if not dpdk_conf.has('RTE_HAS_LIBPCAP')
>>     reason = 'missing dependency, "libpcap"'
>> endif
>> 
>> -if is_windows
>> -    build = false
>> -    reason = 'not supported on Windows'
>> -    subdir_done()
>> -endif
>> -
>> ext_deps += pcap_dep
>> sources = files('main.c')
>> -deps += ['ethdev', 'pdump', 'pcapng', 'bpf']
>> +deps += ['net_ring', 'ethdev', 'pcapng' ]
>> -- 
>> 2.47.2
>> 
>> 
>
