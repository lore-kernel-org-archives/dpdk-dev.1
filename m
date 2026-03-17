Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02152FB5E8B
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Mar 2026 01:07:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C140B402D6;
	Tue, 17 Mar 2026 02:07:44 +0100 (CET)
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com
 [113.46.200.219])
 by mails.dpdk.org (Postfix) with ESMTP id 2801C40270;
 Tue, 17 Mar 2026 02:07:43 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=ER5Upr/JSTHJ/lrGbUUOggRtKwXZtuLuajd2xAHzUhA=;
 b=eJJe/h4pXmPJlh3syZYA+oc25mZOV/3oHD3d1PbDeXK3gH9zn4Jp5pbUfabdRr7KiaDmNUafA
 b32gI32I8JwnfqA59pPELJ9y1pEXDDX22jksf1wFeV+/moYMcP/O2iWzvGYihMESOVnGL4yit2F
 fqjeokROJupC0nmyvBUzgLg=
Received: from mail.maildlp.com (unknown [172.19.162.140])
 by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4fZYbN0Yrdz1prKM;
 Tue, 17 Mar 2026 09:02:40 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 1556420168;
 Tue, 17 Mar 2026 09:07:41 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 17 Mar 2026 09:07:40 +0800
Message-ID: <99743ec5-e0d3-43cc-9395-5713bc5ca765@huawei.com>
Date: Tue, 17 Mar 2026 09:07:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] app/testpmd: fix DCB forwarding TC mask and queue guard
To: "Talluri, ChaitanyababuX" <chaitanyababux.talluri@intel.com>,
 "dev@dpdk.org" <dev@dpdk.org>, "Richardson, Bruce"
 <bruce.richardson@intel.com>, "stephen@networkplumber.org"
 <stephen@networkplumber.org>, "Singh, Aman Deep" <aman.deep.singh@intel.com>
CC: "Wani, Shaiq" <shaiq.wani@intel.com>, "stable@dpdk.org" <stable@dpdk.org>
References: <20260311083751.1107404-1-chaitanyababux.talluri@intel.com>
 <20260312103615.1282874-1-chaitanyababux.talluri@intel.com>
 <4fd815c8-4ce1-4182-af8b-57b7b92291a8@huawei.com>
 <BL3PR11MB6532E2AAD4A4AFA0002D0F2F9640A@BL3PR11MB6532.namprd11.prod.outlook.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <BL3PR11MB6532E2AAD4A4AFA0002D0F2F9640A@BL3PR11MB6532.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
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

On 3/16/2026 2:05 PM, Talluri, ChaitanyababuX wrote:
> 
> 
> -----Original Message-----
> From: fengchengwen <fengchengwen@huawei.com> 
> Sent: 13 March 2026 05:49
> To: Talluri, ChaitanyababuX <chaitanyababux.talluri@intel.com>; dev@dpdk.org; Richardson, Bruce <bruce.richardson@intel.com>; stephen@networkplumber.org; Singh, Aman Deep <aman.deep.singh@intel.com>
> Cc: Wani, Shaiq <shaiq.wani@intel.com>; stable@dpdk.org
> Subject: Re: [PATCH v2] app/testpmd: fix DCB forwarding TC mask and queue guard
> 
> On 3/12/2026 6:36 PM, Talluri Chaitanyababu wrote:
>> Update forwarding TC mask based on configured traffic classes to 
>> properly handle both 4 TC and 8 TC modes. The bitmask calculation (1u 
>> << nb_tcs) - 1 correctly creates masks for all available traffic 
>> classes (0xF for 4 TCs, 0xFF for 8 TCs).
>>
>> When the mask is not updated after a TC configuration change, it stays 
>> at the default 0xFF, which causes dcb_fwd_tc_update_dcb_info() to skip 
>> the compress logic entirely (early return when mask == 
>> DEFAULT_DCB_FWD_TC_MASK).
>> This can lead to inconsistent queue allocations.
> 
> Sorry, I cannot understand your question. Could you please provide some steps to reproduce the issue and the problem phenomenon?
> 
> Please find the reproduction steps and problem description below.
> 
> 1.bind 2 port to vfio-pci
> ./usertools/dpdk-devbind.py -b vfio-pci 0000:af:00.0 0000:af:00.1
> 2. start testpmd and reset DCB PFC
> ./x86_64-native-linuxapp-gcc/app/dpdk-testpmd -l 1-20 -n 4 -a 0000:af:00.0 -a 0000:af:00.1 --file-prefix=testpmd1 -- -i --rxq=256 --txq=256 --nb-cores=16 --total-num-mbufs=600000
> 
> testpmd> port stop all
> testpmd> port config 0 dcb vt off 8 pfc on
> testpmd> port config 1 dcb vt off 8 pfc on
> testpmd> port start all
> testpmd> port stop all
> testpmd> port config 0 dcb vt off 4 pfc on
> 
> Test Log: 
> root@srv13:~/test-1/dpdk# ./x86_64-native-linuxapp-gcc/app/dpdk-testpmd -l 1-20 -n 4 -a 0000:31:00.0 -a 0000:4b:00.0 --file-prefix=testpmd1 -- -i --rxq=256 --txq=256 --nb-cores=16 --total-num-mbufs=600000
> EAL: Detected CPU lcores: 96
> EAL: Detected NUMA nodes: 2
> EAL: Detected static linkage of DPDK
> EAL: Multi-process socket /var/run/dpdk/testpmd1/mp_socket
> EAL: Selected IOVA mode 'VA'
> EAL: VFIO support initialized
> EAL: Using IOMMU type 1 (Type 1)
> ICE_INIT: ice_load_pkg_type(): Active package is: 1.3.50.0, ICE OS Default Package (single VLAN mode)
> ICE_INIT: ice_load_pkg_type(): Active package is: 1.3.50.0, ICE OS Default Package (single VLAN mode)
> Interactive-mode selected
> testpmd: create a new mbuf pool <mb_pool_0>: n=600000, size=2176, socket=0
> testpmd: preferred mempool ops selected: ring_mp_mc
> Configuring Port 0 (socket 0)
> ICE_DRIVER: ice_set_tx_function(): Using Vector AVX2 (port 0).
> ICE_DRIVER: ice_set_rx_function(): Using Offload Vector AVX2 (port 0).
> Port 0: B4:96:91:9F:5E:B0
> Configuring Port 1 (socket 0)
> ICE_DRIVER: ice_set_tx_function(): Using Vector AVX2 (port 1).
> ICE_DRIVER: ice_set_rx_function(): Using Offload Vector AVX2 (port 1).
> Port 1: 68:05:CA:A3:13:4C
> Checking link statuses...
> Done
> testpmd> port stop all
> Stopping ports...
> 
> Port 0: link state change event
> Checking link statuses...
> 
> Port 1: link state change event
> Done
> testpmd> port config 0 dcb vt off 8 pfc on
> In DCB mode, all forwarding ports must be configured in this mode.
> testpmd> port config 1 dcb vt off 8 pfc on
> testpmd> port start all
> Configuring Port 0 (socket 0)
> ICE_DRIVER: ice_set_tx_function(): Using Vector AVX2 (port 0).
> ICE_DRIVER: ice_set_rx_function(): Using Offload Vector AVX2 (port 0).
> 
> Port 0: link state change event
> Port 0: B4:96:91:9F:5E:B0
> Configuring Port 1 (socket 0)
> ICE_DRIVER: ice_set_tx_function(): Using Vector AVX2 (port 1).
> ICE_DRIVER: ice_set_rx_function(): Using Offload Vector AVX2 (port 1).
> Port 1: 68:05:CA:A3:13:4C
> Checking link statuses...
> Done
> testpmd> port stop all
> Stopping ports...
> 
> Port 0: link state change event
> Checking link statuses...
> 
> Port 1: link state change event
> Done
> testpmd> port config 0 dcb vt off 4 pfc on
> Floating point exception

I just try to reproduce this on Kunpeng platform but found it seems no error:
dpdk-testpmd -a 0000:7d:00.0 -a 0000:7d:00.2 --file-prefix=feng -l 0-20 -- -i --rxq=64 --txq=64 --nb-cores=16
PS: this netcard only has a max of 64 queues

So could you show the gdb output?


The detail output:
./dpdk-testpmd -a 0000:7d:00.0 -a 0000:7d:00.2 --file-prefix=feng -l 0-20 -- -i --rxq=64 --txq=64 --nb-cores=16
EAL: Detected CPU lcores: 96
EAL: Detected NUMA nodes: 4
EAL: Detected static linkage of DPDK
EAL: Multi-process socket /var/run/dpdk/feng/mp_socket
EAL: Selected IOVA mode 'VA'
EAL: VFIO support initialized
EAL: DPDK is running on a NUMA system, but is compiled without NUMA support.
EAL: This will have adverse consequences for performance and usability.
EAL: Please use --legacy-mem option, or recompile with NUMA support.
EAL: Using IOMMU type 1 (Type 1)
Interactive-mode selected
testpmd: create a new mbuf pool <mb_pool_0>: n=307456, size=2176, socket=0
testpmd: preferred mempool ops selected: ring_mp_mc
Configuring Port 0 (socket 0)
HNS3_DRIVER: 0000:7d:00.0 hns3_set_fiber_port_link_speed(): auto-negotiation is not supported, use default fixed speed!
Port 0: 00:18:2D:00:00:79
Configuring Port 1 (socket 0)
HNS3_DRIVER: 0000:7d:00.2 hns3_set_fiber_port_link_speed(): auto-negotiation is not supported, use default fixed speed!
Port 1: 00:18:2D:02:00:79
Checking link statuses...
Done
testpmd>
testpmd>
testpmd> HNS3_DRIVER: 0000:7d:00.0 hns3_update_link_status(): Link status change to up!

Port 0: link state change event

testpmd>
testpmd> port stop all
Stopping ports...
Checking link statuses...
Done
testpmd> port config 0 dcb vt off 8 pfc on
In DCB mode, all forwarding ports must be configured in this mode.
testpmd> port config 1 dcb vt off 8 pfc on
testpmd> port start all
Configuring Port 0 (socket 0)
HNS3_DRIVER: 0000:7d:00.0 hns3_set_fiber_port_link_speed(): auto-negotiation is not supported, use default fixed speed!
Port 0: 00:18:2D:00:00:79
Configuring Port 1 (socket 0)
HNS3_DRIVER: 0000:7d:00.2 hns3_set_fiber_port_link_speed(): auto-negotiation is not supported, use default fixed speed!
Port 1: 00:18:2D:02:00:79
Checking link statuses...
Done
testpmd> port stop all
Stopping ports...
Checking link statuses...
Done
testpmd> port config 0 dcb vt off 4 pfc on
testpmd>
testpmd> start
Not all ports were started
testpmd> port start all
Configuring Port 0 (socket 0)
HNS3_DRIVER: 0000:7d:00.0 hns3_set_fiber_port_link_speed(): auto-negotiation is not supported, use default fixed speed!
Port 0: 00:18:2D:00:00:79
HNS3_DRIVER: 0000:7d:00.2 hns3_set_fiber_port_link_speed(): auto-negotiation is not supported, use default fixed speed!
Port 1: 00:18:2D:02:00:79
Checking link statuses...
Done
testpmd> HNS3_DRIVER: 0000:7d:00.0 hns3_update_link_status(): Link status change to up!

Port 0: link state change event

testpmd> start
io packet forwarding - ports=2 - cores=12 - streams=128 - NUMA support enabled, MP allocation mode: native
Logical Core 1 (socket 0) forwards packets on 16 streams:
  RX P=0/Q=0 (socket 0) -> TX P=1/Q=0 (socket 0) peer=02:00:00:00:00:01
  RX P=0/Q=1 (socket 0) -> TX P=1/Q=1 (socket 0) peer=02:00:00:00:00:01
  RX P=0/Q=2 (socket 0) -> TX P=1/Q=2 (socket 0) peer=02:00:00:00:00:01
  RX P=0/Q=3 (socket 0) -> TX P=1/Q=3 (socket 0) peer=02:00:00:00:00:01
  RX P=0/Q=4 (socket 0) -> TX P=1/Q=4 (socket 0) peer=02:00:00:00:00:01
  RX P=0/Q=5 (socket 0) -> TX P=1/Q=5 (socket 0) peer=02:00:00:00:00:01
  RX P=0/Q=6 (socket 0) -> TX P=1/Q=6 (socket 0) peer=02:00:00:00:00:01
  RX P=0/Q=7 (socket 0) -> TX P=1/Q=7 (socket 0) peer=02:00:00:00:00:01
  RX P=0/Q=8 (socket 0) -> TX P=1/Q=0 (socket 0) peer=02:00:00:00:00:01
  RX P=0/Q=9 (socket 0) -> TX P=1/Q=1 (socket 0) peer=02:00:00:00:00:01
  RX P=0/Q=10 (socket 0) -> TX P=1/Q=2 (socket 0) peer=02:00:00:00:00:01
  RX P=0/Q=11 (socket 0) -> TX P=1/Q=3 (socket 0) peer=02:00:00:00:00:01
  RX P=0/Q=12 (socket 0) -> TX P=1/Q=4 (socket 0) peer=02:00:00:00:00:01
  RX P=0/Q=13 (socket 0) -> TX P=1/Q=5 (socket 0) peer=02:00:00:00:00:01
  RX P=0/Q=14 (socket 0) -> TX P=1/Q=6 (socket 0) peer=02:00:00:00:00:01
  RX P=0/Q=15 (socket 0) -> TX P=1/Q=7 (socket 0) peer=02:00:00:00:00:01
Logical Core 2 (socket 0) forwards packets on 16 streams:
  RX P=0/Q=16 (socket 0) -> TX P=1/Q=8 (socket 0) peer=02:00:00:00:00:01
  RX P=0/Q=17 (socket 0) -> TX P=1/Q=9 (socket 0) peer=02:00:00:00:00:01
  RX P=0/Q=18 (socket 0) -> TX P=1/Q=10 (socket 0) peer=02:00:00:00:00:01
  RX P=0/Q=19 (socket 0) -> TX P=1/Q=11 (socket 0) peer=02:00:00:00:00:01
  RX P=0/Q=20 (socket 0) -> TX P=1/Q=12 (socket 0) peer=02:00:00:00:00:01
  RX P=0/Q=21 (socket 0) -> TX P=1/Q=13 (socket 0) peer=02:00:00:00:00:01
  RX P=0/Q=22 (socket 0) -> TX P=1/Q=14 (socket 0) peer=02:00:00:00:00:01
  RX P=0/Q=23 (socket 0) -> TX P=1/Q=15 (socket 0) peer=02:00:00:00:00:01
  RX P=0/Q=24 (socket 0) -> TX P=1/Q=8 (socket 0) peer=02:00:00:00:00:01
  RX P=0/Q=25 (socket 0) -> TX P=1/Q=9 (socket 0) peer=02:00:00:00:00:01
  RX P=0/Q=26 (socket 0) -> TX P=1/Q=10 (socket 0) peer=02:00:00:00:00:01
  RX P=0/Q=27 (socket 0) -> TX P=1/Q=11 (socket 0) peer=02:00:00:00:00:01
  RX P=0/Q=28 (socket 0) -> TX P=1/Q=12 (socket 0) peer=02:00:00:00:00:01
  RX P=0/Q=29 (socket 0) -> TX P=1/Q=13 (socket 0) peer=02:00:00:00:00:01
  RX P=0/Q=30 (socket 0) -> TX P=1/Q=14 (socket 0) peer=02:00:00:00:00:01
  RX P=0/Q=31 (socket 0) -> TX P=1/Q=15 (socket 0) peer=02:00:00:00:00:01
Logical Core 3 (socket 0) forwards packets on 16 streams:
  RX P=0/Q=32 (socket 0) -> TX P=1/Q=16 (socket 0) peer=02:00:00:00:00:01
  RX P=0/Q=33 (socket 0) -> TX P=1/Q=17 (socket 0) peer=02:00:00:00:00:01
  RX P=0/Q=34 (socket 0) -> TX P=1/Q=18 (socket 0) peer=02:00:00:00:00:01
  RX P=0/Q=35 (socket 0) -> TX P=1/Q=19 (socket 0) peer=02:00:00:00:00:01
  RX P=0/Q=36 (socket 0) -> TX P=1/Q=20 (socket 0) peer=02:00:00:00:00:01
  RX P=0/Q=37 (socket 0) -> TX P=1/Q=21 (socket 0) peer=02:00:00:00:00:01
  RX P=0/Q=38 (socket 0) -> TX P=1/Q=22 (socket 0) peer=02:00:00:00:00:01
  RX P=0/Q=39 (socket 0) -> TX P=1/Q=23 (socket 0) peer=02:00:00:00:00:01
  RX P=0/Q=40 (socket 0) -> TX P=1/Q=16 (socket 0) peer=02:00:00:00:00:01
  RX P=0/Q=41 (socket 0) -> TX P=1/Q=17 (socket 0) peer=02:00:00:00:00:01
  RX P=0/Q=42 (socket 0) -> TX P=1/Q=18 (socket 0) peer=02:00:00:00:00:01
  RX P=0/Q=43 (socket 0) -> TX P=1/Q=19 (socket 0) peer=02:00:00:00:00:01
  RX P=0/Q=44 (socket 0) -> TX P=1/Q=20 (socket 0) peer=02:00:00:00:00:01
  RX P=0/Q=45 (socket 0) -> TX P=1/Q=21 (socket 0) peer=02:00:00:00:00:01
  RX P=0/Q=46 (socket 0) -> TX P=1/Q=22 (socket 0) peer=02:00:00:00:00:01
  RX P=0/Q=47 (socket 0) -> TX P=1/Q=23 (socket 0) peer=02:00:00:00:00:01
Logical Core 4 (socket 0) forwards packets on 16 streams:
  RX P=0/Q=48 (socket 0) -> TX P=1/Q=24 (socket 0) peer=02:00:00:00:00:01
  RX P=0/Q=49 (socket 0) -> TX P=1/Q=25 (socket 0) peer=02:00:00:00:00:01
  RX P=0/Q=50 (socket 0) -> TX P=1/Q=26 (socket 0) peer=02:00:00:00:00:01
  RX P=0/Q=51 (socket 0) -> TX P=1/Q=27 (socket 0) peer=02:00:00:00:00:01
  RX P=0/Q=52 (socket 0) -> TX P=1/Q=28 (socket 0) peer=02:00:00:00:00:01
  RX P=0/Q=53 (socket 0) -> TX P=1/Q=29 (socket 0) peer=02:00:00:00:00:01
  RX P=0/Q=54 (socket 0) -> TX P=1/Q=30 (socket 0) peer=02:00:00:00:00:01
  RX P=0/Q=55 (socket 0) -> TX P=1/Q=31 (socket 0) peer=02:00:00:00:00:01
  RX P=0/Q=56 (socket 0) -> TX P=1/Q=24 (socket 0) peer=02:00:00:00:00:01
  RX P=0/Q=57 (socket 0) -> TX P=1/Q=25 (socket 0) peer=02:00:00:00:00:01
  RX P=0/Q=58 (socket 0) -> TX P=1/Q=26 (socket 0) peer=02:00:00:00:00:01
  RX P=0/Q=59 (socket 0) -> TX P=1/Q=27 (socket 0) peer=02:00:00:00:00:01
  RX P=0/Q=60 (socket 0) -> TX P=1/Q=28 (socket 0) peer=02:00:00:00:00:01
  RX P=0/Q=61 (socket 0) -> TX P=1/Q=29 (socket 0) peer=02:00:00:00:00:01
  RX P=0/Q=62 (socket 0) -> TX P=1/Q=30 (socket 0) peer=02:00:00:00:00:01
  RX P=0/Q=63 (socket 0) -> TX P=1/Q=31 (socket 0) peer=02:00:00:00:00:01
Logical Core 5 (socket 0) forwards packets on 8 streams:
  RX P=1/Q=0 (socket 0) -> TX P=0/Q=0 (socket 0) peer=02:00:00:00:00:00
  RX P=1/Q=1 (socket 0) -> TX P=0/Q=1 (socket 0) peer=02:00:00:00:00:00
  RX P=1/Q=2 (socket 0) -> TX P=0/Q=2 (socket 0) peer=02:00:00:00:00:00
  RX P=1/Q=3 (socket 0) -> TX P=0/Q=3 (socket 0) peer=02:00:00:00:00:00
  RX P=1/Q=4 (socket 0) -> TX P=0/Q=4 (socket 0) peer=02:00:00:00:00:00
  RX P=1/Q=5 (socket 0) -> TX P=0/Q=5 (socket 0) peer=02:00:00:00:00:00
  RX P=1/Q=6 (socket 0) -> TX P=0/Q=6 (socket 0) peer=02:00:00:00:00:00
  RX P=1/Q=7 (socket 0) -> TX P=0/Q=7 (socket 0) peer=02:00:00:00:00:00
Logical Core 6 (socket 0) forwards packets on 8 streams:
  RX P=1/Q=8 (socket 0) -> TX P=0/Q=16 (socket 0) peer=02:00:00:00:00:00
  RX P=1/Q=9 (socket 0) -> TX P=0/Q=17 (socket 0) peer=02:00:00:00:00:00
  RX P=1/Q=10 (socket 0) -> TX P=0/Q=18 (socket 0) peer=02:00:00:00:00:00
  RX P=1/Q=11 (socket 0) -> TX P=0/Q=19 (socket 0) peer=02:00:00:00:00:00
  RX P=1/Q=12 (socket 0) -> TX P=0/Q=20 (socket 0) peer=02:00:00:00:00:00
  RX P=1/Q=13 (socket 0) -> TX P=0/Q=21 (socket 0) peer=02:00:00:00:00:00
  RX P=1/Q=14 (socket 0) -> TX P=0/Q=22 (socket 0) peer=02:00:00:00:00:00
  RX P=1/Q=15 (socket 0) -> TX P=0/Q=23 (socket 0) peer=02:00:00:00:00:00
Logical Core 7 (socket 0) forwards packets on 8 streams:
  RX P=1/Q=16 (socket 0) -> TX P=0/Q=32 (socket 0) peer=02:00:00:00:00:00
  RX P=1/Q=17 (socket 0) -> TX P=0/Q=33 (socket 0) peer=02:00:00:00:00:00
  RX P=1/Q=18 (socket 0) -> TX P=0/Q=34 (socket 0) peer=02:00:00:00:00:00
  RX P=1/Q=19 (socket 0) -> TX P=0/Q=35 (socket 0) peer=02:00:00:00:00:00
  RX P=1/Q=20 (socket 0) -> TX P=0/Q=36 (socket 0) peer=02:00:00:00:00:00
  RX P=1/Q=21 (socket 0) -> TX P=0/Q=37 (socket 0) peer=02:00:00:00:00:00
  RX P=1/Q=22 (socket 0) -> TX P=0/Q=38 (socket 0) peer=02:00:00:00:00:00
  RX P=1/Q=23 (socket 0) -> TX P=0/Q=39 (socket 0) peer=02:00:00:00:00:00
Logical Core 8 (socket 0) forwards packets on 8 streams:
  RX P=1/Q=24 (socket 0) -> TX P=0/Q=48 (socket 0) peer=02:00:00:00:00:00
  RX P=1/Q=25 (socket 0) -> TX P=0/Q=49 (socket 0) peer=02:00:00:00:00:00
  RX P=1/Q=26 (socket 0) -> TX P=0/Q=50 (socket 0) peer=02:00:00:00:00:00
  RX P=1/Q=27 (socket 0) -> TX P=0/Q=51 (socket 0) peer=02:00:00:00:00:00
  RX P=1/Q=28 (socket 0) -> TX P=0/Q=52 (socket 0) peer=02:00:00:00:00:00
  RX P=1/Q=29 (socket 0) -> TX P=0/Q=53 (socket 0) peer=02:00:00:00:00:00
  RX P=1/Q=30 (socket 0) -> TX P=0/Q=54 (socket 0) peer=02:00:00:00:00:00
  RX P=1/Q=31 (socket 0) -> TX P=0/Q=55 (socket 0) peer=02:00:00:00:00:00
Logical Core 9 (socket 0) forwards packets on 8 streams:
  RX P=1/Q=32 (socket 0) -> TX P=0/Q=0 (socket 0) peer=02:00:00:00:00:00
  RX P=1/Q=33 (socket 0) -> TX P=0/Q=1 (socket 0) peer=02:00:00:00:00:00
  RX P=1/Q=34 (socket 0) -> TX P=0/Q=2 (socket 0) peer=02:00:00:00:00:00
  RX P=1/Q=35 (socket 0) -> TX P=0/Q=3 (socket 0) peer=02:00:00:00:00:00
  RX P=1/Q=36 (socket 0) -> TX P=0/Q=4 (socket 0) peer=02:00:00:00:00:00
  RX P=1/Q=37 (socket 0) -> TX P=0/Q=5 (socket 0) peer=02:00:00:00:00:00
  RX P=1/Q=38 (socket 0) -> TX P=0/Q=6 (socket 0) peer=02:00:00:00:00:00
  RX P=1/Q=39 (socket 0) -> TX P=0/Q=7 (socket 0) peer=02:00:00:00:00:00
Logical Core 10 (socket 0) forwards packets on 8 streams:
  RX P=1/Q=40 (socket 0) -> TX P=0/Q=0 (socket 0) peer=02:00:00:00:00:00
  RX P=1/Q=41 (socket 0) -> TX P=0/Q=1 (socket 0) peer=02:00:00:00:00:00
  RX P=1/Q=42 (socket 0) -> TX P=0/Q=2 (socket 0) peer=02:00:00:00:00:00
  RX P=1/Q=43 (socket 0) -> TX P=0/Q=3 (socket 0) peer=02:00:00:00:00:00
  RX P=1/Q=44 (socket 0) -> TX P=0/Q=4 (socket 0) peer=02:00:00:00:00:00
  RX P=1/Q=45 (socket 0) -> TX P=0/Q=5 (socket 0) peer=02:00:00:00:00:00
  RX P=1/Q=46 (socket 0) -> TX P=0/Q=6 (socket 0) peer=02:00:00:00:00:00
  RX P=1/Q=47 (socket 0) -> TX P=0/Q=7 (socket 0) peer=02:00:00:00:00:00
Logical Core 11 (socket 0) forwards packets on 8 streams:
  RX P=1/Q=48 (socket 0) -> TX P=0/Q=0 (socket 0) peer=02:00:00:00:00:00
  RX P=1/Q=49 (socket 0) -> TX P=0/Q=1 (socket 0) peer=02:00:00:00:00:00
  RX P=1/Q=50 (socket 0) -> TX P=0/Q=2 (socket 0) peer=02:00:00:00:00:00
  RX P=1/Q=51 (socket 0) -> TX P=0/Q=3 (socket 0) peer=02:00:00:00:00:00
  RX P=1/Q=52 (socket 0) -> TX P=0/Q=4 (socket 0) peer=02:00:00:00:00:00
  RX P=1/Q=53 (socket 0) -> TX P=0/Q=5 (socket 0) peer=02:00:00:00:00:00
  RX P=1/Q=54 (socket 0) -> TX P=0/Q=6 (socket 0) peer=02:00:00:00:00:00
  RX P=1/Q=55 (socket 0) -> TX P=0/Q=7 (socket 0) peer=02:00:00:00:00:00
Logical Core 12 (socket 0) forwards packets on 8 streams:
  RX P=1/Q=56 (socket 0) -> TX P=0/Q=0 (socket 0) peer=02:00:00:00:00:00
  RX P=1/Q=57 (socket 0) -> TX P=0/Q=1 (socket 0) peer=02:00:00:00:00:00
  RX P=1/Q=58 (socket 0) -> TX P=0/Q=2 (socket 0) peer=02:00:00:00:00:00
  RX P=1/Q=59 (socket 0) -> TX P=0/Q=3 (socket 0) peer=02:00:00:00:00:00
  RX P=1/Q=60 (socket 0) -> TX P=0/Q=4 (socket 0) peer=02:00:00:00:00:00
  RX P=1/Q=61 (socket 0) -> TX P=0/Q=5 (socket 0) peer=02:00:00:00:00:00
  RX P=1/Q=62 (socket 0) -> TX P=0/Q=6 (socket 0) peer=02:00:00:00:00:00
  RX P=1/Q=63 (socket 0) -> TX P=0/Q=7 (socket 0) peer=02:00:00:00:00:00

  io packet forwarding packets/burst=32
  nb forwarding cores=16 - nb forwarding ports=2
  port 0: RX queue number: 64 Tx queue number: 64
    Rx offloads=0x80200 Tx offloads=0x10000
    RX queue: 0
      RX desc=1024 - RX free threshold=64
      RX threshold registers: pthresh=0 hthresh=0  wthresh=0
      RX Offloads=0x80200
    TX queue: 0
      TX desc=1024 - TX free threshold=928
      TX threshold registers: pthresh=0 hthresh=0  wthresh=0
      TX offloads=0x10000 - TX RS bit threshold=32
  port 1: RX queue number: 64 Tx queue number: 64
    Rx offloads=0x80200 Tx offloads=0x10000
    RX queue: 0
      RX desc=1024 - RX free threshold=64
      RX threshold registers: pthresh=0 hthresh=0  wthresh=0
      RX Offloads=0x80200
    TX queue: 0
      TX desc=1024 - TX free threshold=928
      TX threshold registers: pthresh=0 hthresh=0  wthresh=0
      TX offloads=0x10000 - TX RS bit threshold=32
testpmd>


> 
> Expected behaviour:
> 
> After reconfiguring PFC from 8 to 4 TCs, the forwarding TC mask should reflect
> the configured number of TCs (mask = 0xF).
>>
>> Additionally, the existing VMDQ pool guard in dcb_fwd_config_setup() 
>> only checks RX queue counts, missing the case where the TX port has 
>> zero queues for a given pool/TC combination. When nb_tx_queue is 0, 
>> the expression "j % nb_tx_queue" triggers a SIGFPE (integer division by zero).
> 
> The dcb_fwd_check_cores_per_tc() check this case. So please provide the steps.
> 
>>
>> Fix this by:
>> 1. Updating dcb_fwd_tc_mask after port DCB reconfiguration using the
>>    user requested num_tcs value, so fwd_config_setup() sees the correct
>>    mask.
>> 2. Extending the existing pool guard to also check TX queue counts.
>> 3. Adding a defensive break after the division by dcb_fwd_tc_cores to
>>    catch integer truncation to zero.
>>
>> Fixes: 0ecbf93f5001 ("app/testpmd: add command to disable DCB")
>> Cc: stable@dpdk.org
>>
>> Signed-off-by: Talluri Chaitanyababu 
>> <chaitanyababux.talluri@intel.com>
>> Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
>> ---

