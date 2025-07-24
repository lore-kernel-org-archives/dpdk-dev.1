Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C754C83F26
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Jul 2025 10:24:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7FCCD40279;
	Thu, 24 Jul 2025 12:24:58 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 727DA40267;
 Thu, 24 Jul 2025 12:24:57 +0200 (CEST)
Received: from debian (unknown [78.109.73.219])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id BA8A3E05A2;
 Thu, 24 Jul 2025 14:24:56 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am BA8A3E05A2
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1753352697;
 bh=/0Hi1KSkIhPXJ5Oit/q76Q8FSDHnJQoti2cPNR/pB7I=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=lkIHFy5VEUwZfKYYw11yXyT3VKEMJ7iZ4+M1gDR/RmcR1x0Sw8TUylvofJ9g0LSNw
 2PaAdJzghYrTnOlk47y6zyPpFbbMcs+qbBA3oV9rS3Y61e1xTUQRqSLklgmMZuUQkG
 U4rJws8ZWk+Q8ih91/wSXqJk+YFm3+ea95CzkVQXAoQHrVkjAWxJllPjCn6n2LDTeO
 jnGtjXlP37VVlN9NvFtnyTYpya4A/je5UZMisVBVdLvRgwfCEmxtyNQrF/IPhKDLq2
 NUpe5Q3TFA4YaJUjr+NElP5FxKcm7SjFdnk4QCRDnkHWdEhjpF1/eNHhYsinJeL/jl
 li2qD996TKsXA==
Date: Thu, 24 Jul 2025 14:24:55 +0400 (+04)
From: Ivan Malov <ivan.malov@arknetworks.am>
To: "Gokul K R (MS/ETA7-ETAS)" <KR.Gokul@in.bosch.com>
cc: "users@dpdk.org" <users@dpdk.org>, "dev@dpdk.org" <dev@dpdk.org>, 
 "Nivethitha N Shanmugasundaram (ETAS-ICA/XPC-Fe6)"
 <NShanmugasundaram.Nivethitha@etas.com>, 
 "Aloysius Nishanth Britto (MS/ETA7-ETAS)"
 <Britto.AloysiusNishanth@in.bosch.com>
Subject: =?UTF-8?Q?RE=3A_Issue_with_DPDK-Burst_Replay_=E2=80=93_No_F?=
 =?UTF-8?Q?rame_Transmission_Observed_Despite_Successful_Replay?=
In-Reply-To: <PAVPR10MB7355B7E86E0F65E0F77579DEA45EA@PAVPR10MB7355.EURPRD10.PROD.OUTLOOK.COM>
Message-ID: <945b5f86-c309-ca09-3764-ad6cd1e0ffa8@arknetworks.am>
References: <PAVPR10MB73554B90C65B0D9A83AD8582A450A@PAVPR10MB7355.EURPRD10.PROD.OUTLOOK.COM>
 <5a8c61fe-9c47-d74c-7e0c-3f8dd47b3926@arknetworks.am>
 <PAVPR10MB7355DA0FC9C2847774A0096AA45FA@PAVPR10MB7355.EURPRD10.PROD.OUTLOOK.COM>
 <63d4634b-d09a-13bd-86c0-593147e8e874@arknetworks.am>
 <ae786850-6920-c96b-4fd0-89200b78003a@arknetworks.am>
 <PAVPR10MB7355B7E86E0F65E0F77579DEA45EA@PAVPR10MB7355.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1639654681-1753352697=:9994"
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

--8323328-1639654681-1753352697=:9994
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

Hi,

On Thu, 24 Jul 2025, Gokul K R (MS/ETA7-ETAS) wrote:

> Hi Ivan,
>
> I hope you're doing well.
>
> Point #1:
> Since the DPDK-Burst Replay tool is not an official part of the DPDK project and is community-developed, could you please let us know whom we should contact for support or further information regarding this tool?

For the very same reason (not an in-house tool), I have no way of knowing.
Perhaps take a look at repository owner's profile on GitHub or something.

>
> Point #2:
> We have identified an issue while using dpdk-burst replay tool.
> During EAL mempool initialization, “--pci-whitelist” parameter is given as an argument for “rte_eal_init” function. However, when rte_eal_init is executed with these arguments, it fails with the following error:
>
> ./dpdk-replay: unrecognized option ‘--pci-whitelist’
> Invalid command line argument
>
> We couldn’t find any official documentation on the --pci-whitelist parameter. Could you help clarify its purpose and whether this argument is essential for the tool to operate correctly?

1) In 2020, commit db27370b5720 ("eal: replace blacklist/whitelist options")
    renamed this argument. Now it is '-a' ('--allow') and '-b' ('--block') [1].
2) The argument is application-agnostic and is designed to give a finer control
    on which devices get picked by DPDK during EAL initialisation.
3) Whether the argument is needed for the use of this particular application
    is not apparent to me. One should refer to the application's documentation.

>
> Point #3:
> Could you also suggest any official DPDK tool that supports replaying PCAP files? This would help us explore alternatives that are actively maintained by the DPDK community.

Please take a look at DPDK pcap PMD [2]. It may meet your needs.

[1] https://doc.dpdk.org/guides-25.07/linux_gsg/linux_eal_parameters.html#device-related-options
[2] https://doc.dpdk.org/guides-25.07/nics/pcap_ring.html

Thank you.

>
> Looking forward to your inputs.
>
> Best regards,
> Gokul K R
> -----Original Message-----
> From: Ivan Malov <ivan.malov@arknetworks.am>
> Sent: Wednesday, July 23, 2025 11:43 AM
> To: Gokul K R (MS/ETA7-ETAS) <KR.Gokul@in.bosch.com>
> Cc: users@dpdk.org; dev@dpdk.org; Nivethitha N Shanmugasundaram (ETAS-ICA/XPC-Fe6) <NShanmugasundaram.Nivethitha@etas.com>
> Subject: RE: Issue with DPDK-Burst Replay – No Frame Transmission Observed Despite Successful Replay
>
> On Wed, 23 Jul 2025, Ivan Malov wrote:
>
>> Hi,
>>
>> On Wed, 23 Jul 2025, Gokul K R (MS/ETA7-ETAS) wrote:
>>
>>> Hi Ivan Malov 😊
>>>
>>> Use Case:
>>> I'm currently using the DPDK-Burst-Replay tool to replay captured
>>> PCAP files at specific data rates (e.g., 150–200 Mbps).
>>>
>>> Response to your feedback:
>>> Point 1: "Port 0 is not on the good NUMA ID (-1)"
>>> I’m aware that this message is printed due to the NUMA ID being
>>> returned as -1.
>>> I've just started diving into the source code and found that the call
>>> to
>>> rte_eth_dev_socket_id() returns -1, which typically indicates an error.
>>
>> No, -1 typically translates to 'SOCKET_ID_ANY'. In order to rule out 'EINVAL'
>> in 'rte_errno', one should attempt to invoke 'rte_eth_dev_socket_id'
>> within the loop of 'RTE_ETH_FOREACH_DEV' (see examples in DPDK) and
>> print the socket ID.
>>
>>> However, the current implementation does not output the rte_errno,
>>> which could help identify the root cause. I'm working on modifying
>>> the code to print the error code for better debugging.
>>>
>>> Point 2: "NIC Link is UP"
>>> Yes, on the NIC side, the link is up. I'm also able to transmit
>>> packets successfully using the testpmd application.
>>>
>>> Question:
>>> Could you please confirm if the current version of the
>>> DPDK-Burst-Replay tool supports replaying Ethernet frames larger than
>>> 64 bytes (e.g., up to
>>> 1500 bytes)? Or has the tool been enhanced to support this use case?
>>
>> The tool seems like an external application. Try to look for any
>> mentions of API 'rte_eth_dev_set_mtu' or just the term 'mtu' in that
>> source code. If there are no such mentions, then default MTU applies,
>> which depends on the driver.
>>
>> Have you tried querying statistics to find the cause of the drops?
>
> Also, given the fact that the application replays some pcap traffic, have you made sure the receiver (where you seek to watch the replayed traffic arrive) has got 'promiscuous' mode [1] enabled? IIRC, 'test-pmd' enables it by default.
>
> [1] https://doc.dpdk.org/api-25.07/rte__ethdev_8h.html#a5dd1dedaa45f05c72bcc35495e441e91
>
> Thank you.
>
>>
>> Thank you.
>>
>>>
>>> Thanks for your time and support!
>>>
>>> Best regards,
>>> Gokul K.R
>>>
>>>
>>>
>>>
>>>
>>> -----Original Message-----
>>> From: Ivan Malov <ivan.malov@arknetworks.am>
>>> Sent: Friday, July 18, 2025 5:29 PM
>>> To: Gokul K R (MS/ETA7-ETAS) <KR.Gokul@in.bosch.com>
>>> Cc: users@dpdk.org; dev@dpdk.org
>>> Subject: Re: Issue with DPDK-Burst Replay – No Frame Transmission
>>> Observed Despite Successful Replay
>>>
>>> Hi,
>>>
>>> (please see below)
>>>
>>> On Fri, 18 Jul 2025, Gokul K R (MS/ETA7-ETAS) wrote:
>>>
>>>>
>>>> Hi Team,
>>>>
>>>> I’m currently working with the dpdk-burst-replay tool and
>>>> encountered an issue during execution. Below are the details:
>>>>
>>>>
>>>> ____________________________________________________________________
>>>> __
>>>> ____________________________________________________________________
>>>> __ ______________________________________________
>>>>
>>>>
>>>> Observation:
>>>> During replay, we received the following informational message:
>>>>
>>>> port 0 is not on the good numa id (-1)
>>>
>>> Which API was used to check this? Was API [1] used? If not, what does
>>> it show in the absence of 'numactl' command?
>>>
>>> [1]
>>> https://doc/
>>> .dpdk.org%2Fapi-25.03%2Frte__ethdev_8h.html%23ad032e25f712e6ffeb0c19e
>>> ab1ec1fd2e&data=05%7C02%7CKR.Gokul%40in.bosch.com%7C53a20884cad14b947
>>> a0008ddc9aff5bf%7C0ae51e1907c84e4bbb6d648ee58410f4%7C0%7C0%7C63888847
>>> 9792834143%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLj
>>> AuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%
>>> 7C&sdata=XxPfmsX4WsR83ifUfkkup2jIOw4PU%2FX%2BdefEqVfazj4%3D&reserved=
>>> 0
>>>
>>>>
>>>> As per the DPDK mailing list discussions, this warning is typically
>>>> benign—often seen on NICs like Intel I225/I210, which do not report
>>>> NUMA affinity. Hence, we proceeded with execution.
>>>>
>>>>
>>>> ____________________________________________________________________
>>>> __
>>>> ____________________________________________________________________
>>>> __ ______________________________________________
>>>>
>>>>
>>>> Command Used:
>>>>
>>>> sudo numactl --cpunodebind=0 --membind=0 ./src/dpdk-replay
>>>> Original_MAC.pcap 0000:01:00.1
>>>>
>>>> Execution Output:
>>>>
>>>> preloading Original_MAC.pcap file (of size: 143959 bytes)
>>>>
>>>> file read at 100.00%
>>>>
>>>> read 675 pkts (for a total of 143959 bytes). max packet length =
>>>> 1518 bytes.
>>>>
>>>> -> Needed MBUF size: 1648
>>>>
>>>> -> Needed number of MBUFs: 675
>>>>
>>>> -> Needed Memory = 1.061 MB
>>>>
>>>> -> Needed Hugepages of 1 GB = 1
>>>>
>>>> -> Needed CPUs: 1
>>>>
>>>> -> Create mempool of 675 mbufs of 1648 octets.
>>>>
>>>> -> Will cache 675 pkts on 1 caches.
>>>
>>> What does this 'cache' stand for? Does it refer to the mempool
>>> per-lcore cache?
>>> If so, please note that, according to API [2] documentation, cache
>>> size "must be lower or equal to RTE_MEMPOOL_CACHE_MAX_SIZE and n /
>>> 1.5", where 'n' stands for the number of mbufs. Also, documentation
>>> says it is advised to choose cache_size to have "n modulo cache_size
>>> == 0". Does your code meet these requirements?
>>>
>>> By the looks of it, it doesn't (cache_size = n = 675). Consider to
>>> double-check.
>>>
>>> [2]
>>> https://doc/
>>> .dpdk.org%2Fapi-25.03%2Frte__mempool_8h.html%23a0b64d611bc140a4d2a0c9
>>> 4911580efd5&data=05%7C02%7CKR.Gokul%40in.bosch.com%7C53a20884cad14b94
>>> 7a0008ddc9aff5bf%7C0ae51e1907c84e4bbb6d648ee58410f4%7C0%7C0%7C6388884
>>> 79792843977%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwL
>>> jAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C
>>> %7C&sdata=VLPTrAXqY2FNmhA6mwLFEZgc6f4LFc7oa%2BUb8DrmtWs%3D&reserved=0
>>>
>>>>
>>>>
>>>> ____________________________________________________________________
>>>> __
>>>> ____________________________________________________________________
>>>> __ ______________________________________________
>>>>
>>>>
>>>> Issue:
>>>> Despite successful parsing of the pcap file and proper
>>>> initialization, no frames were transmitted or received on either the
>>>> sender or receiver sides.
>>>
>>> Is this observation based solely on watching APIs [3] and [4] return
>>> 0 all the time? If yes, one can consider to introduce invocations of
>>> APIs [5], [6] and [7] in order to periodically poll and print
>>> statistics (may be with 1-second delay), which may, for example, shed
>>> light on mbuf allocation errors (extended stats).
>>>
>>> Do statistics display any interesting figures to be discussed?
>>>
>>> [3]
>>> https://doc/
>>> .dpdk.org%2Fapi-25.03%2Frte__ethdev_8h.html%23a3e7d76a451b46348686ea9
>>> 7d6367f102&data=05%7C02%7CKR.Gokul%40in.bosch.com%7C53a20884cad14b947
>>> a0008ddc9aff5bf%7C0ae51e1907c84e4bbb6d648ee58410f4%7C0%7C0%7C63888847
>>> 9792853601%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLj
>>> AuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%
>>> 7C&sdata=56BbJeMo6BtewrRGcnIIWBx4gxbvQKl7iATnoUpcTMc%3D&reserved=0
>>> [4]
>>> https://doc/
>>> .dpdk.org%2Fapi-25.03%2Frte__ethdev_8h.html%23a83e56cabbd31637efd648e
>>> 3fc010392b&data=05%7C02%7CKR.Gokul%40in.bosch.com%7C53a20884cad14b947
>>> a0008ddc9aff5bf%7C0ae51e1907c84e4bbb6d648ee58410f4%7C0%7C0%7C63888847
>>> 9792862833%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLj
>>> AuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%
>>> 7C&sdata=bDP8uNF03zuftWy%2BRbXKg1sYwv8DruMG53ntffCy%2BOk%3D&reserved=
>>> 0
>>>
>>> [5]
>>> https://doc/
>>> .dpdk.org%2Fapi-25.03%2Frte__ethdev_8h.html%23adec226574c53ae413252c9
>>> b15f6f4bab&data=05%7C02%7CKR.Gokul%40in.bosch.com%7C53a20884cad14b947
>>> a0008ddc9aff5bf%7C0ae51e1907c84e4bbb6d648ee58410f4%7C0%7C0%7C63888847
>>> 9792872496%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLj
>>> AuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%
>>> 7C&sdata=dJ3yB2MTz28n2mQ5ogbYilcj4sr7K2JD723k5zWvlyU%3D&reserved=0
>>> [6]
>>> https://doc/
>>> .dpdk.org%2Fapi-25.03%2Frte__ethdev_8h.html%23a418ad970673eb171673185
>>> e36044fd79&data=05%7C02%7CKR.Gokul%40in.bosch.com%7C53a20884cad14b947
>>> a0008ddc9aff5bf%7C0ae51e1907c84e4bbb6d648ee58410f4%7C0%7C0%7C63888847
>>> 9792882662%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLj
>>> AuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%
>>> 7C&sdata=aFt%2Fn%2B4FqX6cJDxWVRyWlZrAlVPXOqE6jV7Uymq7WQw%3D&reserved=
>>> 0
>>> [7]
>>> https://doc/
>>> .dpdk.org%2Fapi-25.03%2Frte__ethdev_8h.html%23a300d75b583c1f5acfe5b16
>>> 2a5d8c0ac1&data=05%7C02%7CKR.Gokul%40in.bosch.com%7C53a20884cad14b947
>>> a0008ddc9aff5bf%7C0ae51e1907c84e4bbb6d648ee58410f4%7C0%7C0%7C63888847
>>> 9792892124%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLj
>>> AuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%
>>> 7C&sdata=TlmU3IaIKCzOEvsmFn8if%2BftgQq7ZJCuzcs6x%2B8jaAY%3D&reserved=
>>> 0
>>>
>>>>
>>>>
>>>> ____________________________________________________________________
>>>> __
>>>> ____________________________________________________________________
>>>> __ ______________________________________________
>>>>
>>>>
>>>> Environment Details:
>>>>
>>>>  *  NIC used: Intel I225/I210
>>>>  *  Hugepages configured: 1 GB
>>>>  *  NUMA binding: --cpunodebind=0 --membind=0
>>>>  *  OS: [Your Linux distribution, e.g., Ubuntu 20.04]
>>>>  *  DPDK version: [Mention if known]
>>>>
>>>> ____________________________________________________________________
>>>> __
>>>> ____________________________________________________________________
>>>> __ ______________________________________________
>>>>
>>>>
>>>> Could you please advise if any additional setup, configuration, or
>>>> known limitations may be impacting the packet transmission?
>>>
>>> This may be a wild suggestion from my side, but it pays to check
>>> whether link status is "up" upon port start on both ends. One can use
>>> API [8] to do that.
>>>
>>> [8]
>>> https://doc/
>>> .dpdk.org%2Fapi-25.03%2Frte__ethdev_8h.html%23ac05878578e4fd9ef3551d2
>>> c1c175ebe7&data=05%7C02%7CKR.Gokul%40in.bosch.com%7C53a20884cad14b947
>>> a0008ddc9aff5bf%7C0ae51e1907c84e4bbb6d648ee58410f4%7C0%7C0%7C63888847
>>> 9792901138%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLj
>>> AuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%
>>> 7C&sdata=kLtuxeh0nYIV7UnU5WGLykXqngpIXzqHNsMlRG%2F89e0%3D&reserved=0
>>>
>>> Thank you.
>>>
>>>
>>>>
>>>> Thank you in advance for your support!
>>>>
>>>>
>>>> Best regards,
>>>> Gokul K R
>>>>
>>>>
>>>>
>>>>
>>>>
>>
>
--8323328-1639654681-1753352697=:9994--
