Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B125C83F25
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Jul 2025 05:58:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C15AE4067D;
	Wed, 23 Jul 2025 07:58:22 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 05477402CA;
 Wed, 23 Jul 2025 07:58:19 +0200 (CEST)
Received: from debian (unknown [78.109.70.60])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 4C19AE0568;
 Wed, 23 Jul 2025 09:58:19 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 4C19AE0568
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1753250299;
 bh=R36TJEh0XFi6nUA7M1cogLA9HvycTd69qzbILpFZpRQ=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=qDPA/JV4D7/1o1ZbOw8iebd99tSWxpdz1rvma6XuxTenmpY3nj5lDBFK7GkJiOADc
 gi9SYCOc9dGuad9i0j5bEchNk0YdyFMOWHpKRHnFwsbwUNXDb1fglMeOWmmeF2IXKg
 aY/np2+FKEnzuhM8qYo/K2HPaq6kToo9hu+ZY+GiPZOZnVXcFGiVwjr10mq58fqvWC
 i++qv+vw/TKVTh8da9PgXp7e3WjCMsg5qoDtsTFAJq6jb+agRWA4i5HumN/EMGtFTK
 FyUpupv45BmndBl30x89Gjhv2HJySDAqexWH8a2HDHLD+BZwANoy3FHal2pUM/7OZf
 FWho10mBTcfeg==
Date: Wed, 23 Jul 2025 09:58:18 +0400 (+04)
From: Ivan Malov <ivan.malov@arknetworks.am>
To: "Gokul K R (MS/ETA7-ETAS)" <KR.Gokul@in.bosch.com>
cc: "users@dpdk.org" <users@dpdk.org>, "dev@dpdk.org" <dev@dpdk.org>, 
 "Nivethitha N Shanmugasundaram (ETAS-ICA/XPC-Fe6)"
 <NShanmugasundaram.Nivethitha@etas.com>
Subject: =?UTF-8?Q?RE=3A_Issue_with_DPDK-Burst_Replay_=E2=80=93_No_F?=
 =?UTF-8?Q?rame_Transmission_Observed_Despite_Successful_Replay?=
In-Reply-To: <PAVPR10MB7355DA0FC9C2847774A0096AA45FA@PAVPR10MB7355.EURPRD10.PROD.OUTLOOK.COM>
Message-ID: <63d4634b-d09a-13bd-86c0-593147e8e874@arknetworks.am>
References: <PAVPR10MB73554B90C65B0D9A83AD8582A450A@PAVPR10MB7355.EURPRD10.PROD.OUTLOOK.COM>
 <5a8c61fe-9c47-d74c-7e0c-3f8dd47b3926@arknetworks.am>
 <PAVPR10MB7355DA0FC9C2847774A0096AA45FA@PAVPR10MB7355.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1663521967-1753250300=:15553"
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

--8323328-1663521967-1753250300=:15553
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

Hi,

On Wed, 23 Jul 2025, Gokul K R (MS/ETA7-ETAS) wrote:

> Hi Ivan Malov 😊
>
> Use Case:
> I'm currently using the DPDK-Burst-Replay tool to replay captured PCAP files at specific data rates (e.g., 150–200 Mbps).
>
> Response to your feedback:
> Point 1: "Port 0 is not on the good NUMA ID (-1)"
> I’m aware that this message is printed due to the NUMA ID being returned as -1.
> I've just started diving into the source code and found that the call to rte_eth_dev_socket_id() returns -1, which typically indicates an error.

No, -1 typically translates to 'SOCKET_ID_ANY'. In order to rule out 'EINVAL'
in 'rte_errno', one should attempt to invoke 'rte_eth_dev_socket_id' within the
loop of 'RTE_ETH_FOREACH_DEV' (see examples in DPDK) and print the socket ID.

> However, the current implementation does not output the rte_errno, which could help identify the root cause. I'm working on modifying the code to print the error code for better debugging.
>
> Point 2: "NIC Link is UP"
> Yes, on the NIC side, the link is up. I'm also able to transmit packets successfully using the testpmd application.
>
> Question:
> Could you please confirm if the current version of the DPDK-Burst-Replay tool supports replaying Ethernet frames larger than 64 bytes (e.g., up to 1500 bytes)? Or has the tool been enhanced to support this use case?

The tool seems like an external application. Try to look for any mentions of
API 'rte_eth_dev_set_mtu' or just the term 'mtu' in that source code. If there
are no such mentions, then default MTU applies, which depends on the driver.

Have you tried querying statistics to find the cause of the drops?

Thank you.

>
> Thanks for your time and support!
>
> Best regards,
> Gokul K.R
>
>
>
>
>
> -----Original Message-----
> From: Ivan Malov <ivan.malov@arknetworks.am>
> Sent: Friday, July 18, 2025 5:29 PM
> To: Gokul K R (MS/ETA7-ETAS) <KR.Gokul@in.bosch.com>
> Cc: users@dpdk.org; dev@dpdk.org
> Subject: Re: Issue with DPDK-Burst Replay – No Frame Transmission Observed Despite Successful Replay
>
> Hi,
>
> (please see below)
>
> On Fri, 18 Jul 2025, Gokul K R (MS/ETA7-ETAS) wrote:
>
>>
>> Hi Team,
>>
>> I’m currently working with the dpdk-burst-replay tool and encountered an issue during execution. Below are the details:
>>
>>
>> ______________________________________________________________________
>> ______________________________________________________________________
>> ______________________________________________
>>
>>
>> Observation:
>> During replay, we received the following informational message:
>>
>> port 0 is not on the good numa id (-1)
>
> Which API was used to check this? Was API [1] used? If not, what does it show in the absence of 'numactl' command?
>
> [1] https://doc.dpdk.org/api-25.03/rte__ethdev_8h.html#ad032e25f712e6ffeb0c19eab1ec1fd2e
>
>>
>> As per the DPDK mailing list discussions, this warning is typically benign—often seen on NICs like Intel I225/I210, which do not report NUMA affinity. Hence, we proceeded with execution.
>>
>>
>> ______________________________________________________________________
>> ______________________________________________________________________
>> ______________________________________________
>>
>>
>> Command Used:
>>
>> sudo numactl --cpunodebind=0 --membind=0 ./src/dpdk-replay
>> Original_MAC.pcap 0000:01:00.1
>>
>> Execution Output:
>>
>> preloading Original_MAC.pcap file (of size: 143959 bytes)
>>
>> file read at 100.00%
>>
>> read 675 pkts (for a total of 143959 bytes). max packet length = 1518 bytes.
>>
>> -> Needed MBUF size: 1648
>>
>> -> Needed number of MBUFs: 675
>>
>> -> Needed Memory = 1.061 MB
>>
>> -> Needed Hugepages of 1 GB = 1
>>
>> -> Needed CPUs: 1
>>
>> -> Create mempool of 675 mbufs of 1648 octets.
>>
>> -> Will cache 675 pkts on 1 caches.
>
> What does this 'cache' stand for? Does it refer to the mempool per-lcore cache?
> If so, please note that, according to API [2] documentation, cache size "must be lower or equal to RTE_MEMPOOL_CACHE_MAX_SIZE and n / 1.5", where 'n' stands for the number of mbufs. Also, documentation says it is advised to choose cache_size to have "n modulo cache_size == 0". Does your code meet these requirements?
>
> By the looks of it, it doesn't (cache_size = n = 675). Consider to double-check.
>
> [2] https://doc.dpdk.org/api-25.03/rte__mempool_8h.html#a0b64d611bc140a4d2a0c94911580efd5
>
>>
>>
>> ______________________________________________________________________
>> ______________________________________________________________________
>> ______________________________________________
>>
>>
>> Issue:
>> Despite successful parsing of the pcap file and proper initialization, no frames were transmitted or received on either the sender or receiver sides.
>
> Is this observation based solely on watching APIs [3] and [4] return 0 all the time? If yes, one can consider to introduce invocations of APIs [5], [6] and [7] in order to periodically poll and print statistics (may be with 1-second delay), which may, for example, shed light on mbuf allocation errors (extended stats).
>
> Do statistics display any interesting figures to be discussed?
>
> [3] https://doc.dpdk.org/api-25.03/rte__ethdev_8h.html#a3e7d76a451b46348686ea97d6367f102
> [4] https://doc.dpdk.org/api-25.03/rte__ethdev_8h.html#a83e56cabbd31637efd648e3fc010392b
>
> [5] https://doc.dpdk.org/api-25.03/rte__ethdev_8h.html#adec226574c53ae413252c9b15f6f4bab
> [6] https://doc.dpdk.org/api-25.03/rte__ethdev_8h.html#a418ad970673eb171673185e36044fd79
> [7] https://doc.dpdk.org/api-25.03/rte__ethdev_8h.html#a300d75b583c1f5acfe5b162a5d8c0ac1
>
>>
>>
>> ______________________________________________________________________
>> ______________________________________________________________________
>> ______________________________________________
>>
>>
>> Environment Details:
>>
>>  *  NIC used: Intel I225/I210
>>  *  Hugepages configured: 1 GB
>>  *  NUMA binding: --cpunodebind=0 --membind=0
>>  *  OS: [Your Linux distribution, e.g., Ubuntu 20.04]
>>  *  DPDK version: [Mention if known]
>>
>> ______________________________________________________________________
>> ______________________________________________________________________
>> ______________________________________________
>>
>>
>> Could you please advise if any additional setup, configuration, or known limitations may be impacting the packet transmission?
>
> This may be a wild suggestion from my side, but it pays to check whether link status is "up" upon port start on both ends. One can use API [8] to do that.
>
> [8] https://doc.dpdk.org/api-25.03/rte__ethdev_8h.html#ac05878578e4fd9ef3551d2c1c175ebe7
>
> Thank you.
>
>
>>
>> Thank you in advance for your support!
>>
>>
>> Best regards,
>> Gokul K R
>>
>>
>>
>>
>>
>
--8323328-1663521967-1753250300=:15553--
