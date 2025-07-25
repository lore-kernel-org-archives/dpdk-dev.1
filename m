Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FAE9C87FCA
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Jul 2025 06:46:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 428BB402E6;
	Fri, 25 Jul 2025 08:46:11 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 6C7BB4025A;
 Fri, 25 Jul 2025 08:46:09 +0200 (CEST)
Received: from debian (unknown [78.109.76.61])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 8F366E0568;
 Fri, 25 Jul 2025 10:46:08 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 8F366E0568
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1753425969;
 bh=V9vPCj9xu0+q7XyATMErJsBtuCzyC3xXP5rgAWBAX0M=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=pSzYW2AT3EXMtWRS4Lv3yhDfiBD16UugeGkIKR9XV5v8TEL5Fv1wJpPWK3t0qUhWc
 2HtoDIj70MmDSCFHA3ESvoA7G11W20qNZ0fmP7vVX3VC97UDZHBitgqe+GZVjkHh1V
 MsURHBXbwEnznvdpeC0b3nNaGVqn7IYTaVFGlgmxTASHpwZjE4TURHazZo6mZbgdJz
 Y3MnjrjGOZG5Vu1o4gj7kOkCkBp6qE7ILfHSnR9YukAVwtZCmiX6UN5AN7L7QNqnm0
 C8kHi2WyGH65gK/wssjVux4PCOYx1pthAEKUGQnOVDLU6sig5oF1H52UMocNHKjkk3
 bK1Y7uRfmcKew==
Date: Fri, 25 Jul 2025 10:46:06 +0400 (+04)
From: Ivan Malov <ivan.malov@arknetworks.am>
To: "Gokul K R (MS/ETA7-ETAS)" <KR.Gokul@in.bosch.com>
cc: "users@dpdk.org" <users@dpdk.org>, "dev@dpdk.org" <dev@dpdk.org>, 
 "Nivethitha N Shanmugasundaram (ETAS-ICA/XPC-Fe6)"
 <NShanmugasundaram.Nivethitha@etas.com>, 
 "Aloysius Nishanth Britto (MS/ETA7-ETAS)"
 <Britto.AloysiusNishanth@in.bosch.com>
Subject: =?UTF-8?Q?RE=3A_Issue_with_DPDK-Burst_Replay_=E2=80=93_No_F?=
 =?UTF-8?Q?rame_Transmission_Observed_Despite_Successful_Replay?=
In-Reply-To: <PAVPR10MB73554E72245AA0D44E9822D7A459A@PAVPR10MB7355.EURPRD10.PROD.OUTLOOK.COM>
Message-ID: <a4bbdaac-640e-cf9a-cfdf-28e0e5443a97@arknetworks.am>
References: <PAVPR10MB73554B90C65B0D9A83AD8582A450A@PAVPR10MB7355.EURPRD10.PROD.OUTLOOK.COM>
 <5a8c61fe-9c47-d74c-7e0c-3f8dd47b3926@arknetworks.am>
 <PAVPR10MB7355DA0FC9C2847774A0096AA45FA@PAVPR10MB7355.EURPRD10.PROD.OUTLOOK.COM>
 <63d4634b-d09a-13bd-86c0-593147e8e874@arknetworks.am>
 <ae786850-6920-c96b-4fd0-89200b78003a@arknetworks.am>
 <PAVPR10MB7355B7E86E0F65E0F77579DEA45EA@PAVPR10MB7355.EURPRD10.PROD.OUTLOOK.COM>
 <945b5f86-c309-ca09-3764-ad6cd1e0ffa8@arknetworks.am>
 <PAVPR10MB73559ECA8CBD947C9A80D111A45EA@PAVPR10MB7355.EURPRD10.PROD.OUTLOOK.COM>
 <ac43a41e-299c-d8ab-3198-116e7d5a128c@arknetworks.am>
 <PAVPR10MB73554E72245AA0D44E9822D7A459A@PAVPR10MB7355.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-978156084-1753425968=:9407"
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

--8323328-978156084-1753425968=:9407
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

Hi,

On Fri, 25 Jul 2025, Gokul K R (MS/ETA7-ETAS) wrote:

> Hi Ivan,
> Yes, I rechecked.
> The PCAP file has the correct source and destination MAC addresses, and promiscuous mode is enabled on receiver NIC.
>
> Question 1:
> Is there a recommended way to verify whether packets are actually being transmitted from the DPDK-bound NIC?

1) One can take notes on what 'rte_eth_tx_burst' returns (in the sender code).
    If non-zero, then it likely submits the packets for transmission to the HW.
2) STATISTICS -- both on sender (APIs [1], [2]. [3]) and at the receiver. If the
    receiver is a Linux interface (not DPDK), then 'sudo ethtool -S <ifname>'.

Provided that 'rte_eth_tx_burst' does not return zero, are the drops reflected
in ethdev statistics? Are the drops reflected in statistics at the receiver?

[1] https://doc.dpdk.org/api-25.07/rte__ethdev_8h.html#adec226574c53ae413252c9b15f6f4bab
[2] https://doc.dpdk.org/api-25.07/rte__ethdev_8h.html#a418ad970673eb171673185e36044fd79
[3] https://doc.dpdk.org/api-25.07/rte__ethdev_8h.html#a300d75b583c1f5acfe5b162a5d8c0ac1

Thank you.

>
> Mit freundlichen Grüßen / Best regards
>
> K R Gokul
>
>
> -----Original Message-----
> From: Ivan Malov <ivan.malov@arknetworks.am>
> Sent: Thursday, July 24, 2025 10:06 PM
> To: Gokul K R (MS/ETA7-ETAS) <KR.Gokul@in.bosch.com>
> Cc: users@dpdk.org; dev@dpdk.org; Nivethitha N Shanmugasundaram (ETAS-ICA/XPC-Fe6) <NShanmugasundaram.Nivethitha@etas.com>; Aloysius Nishanth Britto (MS/ETA7-ETAS) <Britto.AloysiusNishanth@in.bosch.com>
> Subject: RE: Issue with DPDK-Burst Replay – No Frame Transmission Observed Despite Successful Replay
>
> On Thu, 24 Jul 2025, Gokul K R (MS/ETA7-ETAS) wrote:
>
>> Hi,
>>
>> In the meantime, I was able to successfully replay my PCAP file using the dpdk-burst-replay tool from your repository (https://github.com/FraudBuster/dpdk-burst-replay). Below is the output from the tool:
>>
>> sudo ./src/dpdk-replay wendutput.pcap 0000:01:00.0 preloading
>> wendutput.pcap file (of size: 5900 bytes) file read at 100.00% read
>> 100 pkts (for a total of 5900 bytes). max packet length = 43 bytes.
>> -> Needed MBUF size: 174
>> -> Needed number of MBUFS: 100
>> -> Needed Memory = 16.992 Mo
>> -> Needed Hugepages of 1 Go = 1
>> -> Needed CPUs: 1
>> -> Create mempool of 100 mbufs of 174 octs.
>> -> Will cache 100 pkts on 1 caches.
>> file read at 100.00%
>> -> NIC port 0 ready.
>>
>> RESULTS :
>> [thread 00]: 1.703287 Gbit/s, 3874767.513949 pps on 0.000026 sec (0 pkts dropped)
>> TOTAL        : 1.703 Gbit/s. 3874767.514 pps.
>> Total dropped: 0/100 packets (0.000000%) Cannot close started device
>> (port 0) I have a question:
>>
>> #1: The tool shows that packets are transmitted, but they are not received on the other end. The same setup works fine with the testpmd application. Since the transmit-side NIC is bound to DPDK, I cannot use tools like Wireshark or tcpdump to verify transmission. Is there any recommended way to confirm whether packets are actually being sent from the DPDK-bound NIC?
>
> Once again, are you sure destination MAC addresses in the replayed packets match that of the receiver NIC? Have you enabled promiscuous mode on the receiver?
>
> Thank you.
>
>>
>> In parallel, as per your suggestion, I’m also exploring the DPDK PCAP PMD to replay my PCAP file.
>>
>>
>> Mit freundlichen Grüßen / Best regards
>>
>> K R Gokul
>>
>> Compact Devices, ESxx, Product and System Acceptance Tests
>> (MS/ETA7-ETAS) Robert Bosch GmbH | Postfach 10 60 50 | 70049 Stuttgart
>> | GERMANY | http://www.bosch.com/ Mobile +91-9003755978 |
>> KR.Gokul@in.bosch.com
>>
>> Registered Office: Stuttgart, Registration Court: Amtsgericht
>> Stuttgart, HRB 14000; Chairman of the Supervisory Board: Prof. Dr.
>> Stefan Asenkerschbaumer; Managing Directors: Dr. Stefan Hartung, Dr.
>> Christian Fischer, Dr. Markus Forschner, Stefan Grosch, Dr. Markus
>> Heyn, Dr. Frank Meyer, Katja von Raven, Dr. Tanja Rückert
>>
>> -----Original Message-----
>> From: Ivan Malov <ivan.malov@arknetworks.am>
>> Sent: Thursday, July 24, 2025 3:55 PM
>> To: Gokul K R (MS/ETA7-ETAS) <KR.Gokul@in.bosch.com>
>> Cc: users@dpdk.org; dev@dpdk.org; Nivethitha N Shanmugasundaram
>> (ETAS-ICA/XPC-Fe6) <NShanmugasundaram.Nivethitha@etas.com>; Aloysius
>> Nishanth Britto (MS/ETA7-ETAS) <Britto.AloysiusNishanth@in.bosch.com>
>> Subject: RE: Issue with DPDK-Burst Replay – No Frame Transmission
>> Observed Despite Successful Replay
>>
>> Hi,
>>
>> On Thu, 24 Jul 2025, Gokul K R (MS/ETA7-ETAS) wrote:
>>
>>> Hi Ivan,
>>>
>>> I hope you're doing well.
>>>
>>> Point #1:
>>> Since the DPDK-Burst Replay tool is not an official part of the DPDK project and is community-developed, could you please let us know whom we should contact for support or further information regarding this tool?
>>
>> For the very same reason (not an in-house tool), I have no way of knowing.
>> Perhaps take a look at repository owner's profile on GitHub or something.
>>
>>>
>>> Point #2:
>>> We have identified an issue while using dpdk-burst replay tool.
>>> During EAL mempool initialization, “--pci-whitelist” parameter is given as an argument for “rte_eal_init” function. However, when rte_eal_init is executed with these arguments, it fails with the following error:
>>>
>>> ./dpdk-replay: unrecognized option ‘--pci-whitelist’
>>> Invalid command line argument
>>>
>>> We couldn’t find any official documentation on the --pci-whitelist parameter. Could you help clarify its purpose and whether this argument is essential for the tool to operate correctly?
>>
>> 1) In 2020, commit db27370b5720 ("eal: replace blacklist/whitelist options")
>>    renamed this argument. Now it is '-a' ('--allow') and '-b' ('--block') [1].
>> 2) The argument is application-agnostic and is designed to give a finer control
>>    on which devices get picked by DPDK during EAL initialisation.
>> 3) Whether the argument is needed for the use of this particular application
>>    is not apparent to me. One should refer to the application's documentation.
>>
>>>
>>> Point #3:
>>> Could you also suggest any official DPDK tool that supports replaying PCAP files? This would help us explore alternatives that are actively maintained by the DPDK community.
>>
>> Please take a look at DPDK pcap PMD [2]. It may meet your needs.
>>
>> [1]
>> https://doc/.
>> dpdk.org%2Fguides-25.07%2Flinux_gsg%2Flinux_eal_parameters.html%23devi
>> ce-related-options&data=05%7C02%7CKR.Gokul%40in.bosch.com%7C57cfefaffe
>> 594a1f684f08ddcad02240%7C0ae51e1907c84e4bbb6d648ee58410f4%7C0%7C0%7C63
>> 8889717468467726%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiO
>> iIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C
>> %7C%7C&sdata=%2BDcatRiQWskP%2Bfw2vXBcjlgxEorKY3mFKJUBH%2Fwees8%3D&rese
>> rved=0 [2]
>> https://doc/.
>> dpdk.org%2Fguides-25.07%2Fnics%2Fpcap_ring.html&data=05%7C02%7CKR.Goku
>> l%40in.bosch.com%7C57cfefaffe594a1f684f08ddcad02240%7C0ae51e1907c84e4b
>> bb6d648ee58410f4%7C0%7C0%7C638889717468477644%7CUnknown%7CTWFpbGZsb3d8
>> eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTW
>> FpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=DgWTrx5oQEaOq94tKZALlh2vzaJz
>> H67dhzf9l80v4Hs%3D&reserved=0
>>
>> Thank you.
>>
>>>
>>> Looking forward to your inputs.
>>>
>>> Best regards,
>>> Gokul K R
>>> -----Original Message-----
>>> From: Ivan Malov <ivan.malov@arknetworks.am>
>>> Sent: Wednesday, July 23, 2025 11:43 AM
>>> To: Gokul K R (MS/ETA7-ETAS) <KR.Gokul@in.bosch.com>
>>> Cc: users@dpdk.org; dev@dpdk.org; Nivethitha N Shanmugasundaram
>>> (ETAS-ICA/XPC-Fe6) <NShanmugasundaram.Nivethitha@etas.com>
>>> Subject: RE: Issue with DPDK-Burst Replay – No Frame Transmission
>>> Observed Despite Successful Replay
>>>
>>> On Wed, 23 Jul 2025, Ivan Malov wrote:
>>>
>>>> Hi,
>>>>
>>>> On Wed, 23 Jul 2025, Gokul K R (MS/ETA7-ETAS) wrote:
>>>>
>>>>> Hi Ivan Malov 😊
>>>>>
>>>>> Use Case:
>>>>> I'm currently using the DPDK-Burst-Replay tool to replay captured
>>>>> PCAP files at specific data rates (e.g., 150–200 Mbps).
>>>>>
>>>>> Response to your feedback:
>>>>> Point 1: "Port 0 is not on the good NUMA ID (-1)"
>>>>> I’m aware that this message is printed due to the NUMA ID being
>>>>> returned as -1.
>>>>> I've just started diving into the source code and found that the
>>>>> call to
>>>>> rte_eth_dev_socket_id() returns -1, which typically indicates an error.
>>>>
>>>> No, -1 typically translates to 'SOCKET_ID_ANY'. In order to rule out 'EINVAL'
>>>> in 'rte_errno', one should attempt to invoke 'rte_eth_dev_socket_id'
>>>> within the loop of 'RTE_ETH_FOREACH_DEV' (see examples in DPDK) and
>>>> print the socket ID.
>>>>
>>>>> However, the current implementation does not output the rte_errno,
>>>>> which could help identify the root cause. I'm working on modifying
>>>>> the code to print the error code for better debugging.
>>>>>
>>>>> Point 2: "NIC Link is UP"
>>>>> Yes, on the NIC side, the link is up. I'm also able to transmit
>>>>> packets successfully using the testpmd application.
>>>>>
>>>>> Question:
>>>>> Could you please confirm if the current version of the
>>>>> DPDK-Burst-Replay tool supports replaying Ethernet frames larger
>>>>> than
>>>>> 64 bytes (e.g., up to
>>>>> 1500 bytes)? Or has the tool been enhanced to support this use case?
>>>>
>>>> The tool seems like an external application. Try to look for any
>>>> mentions of API 'rte_eth_dev_set_mtu' or just the term 'mtu' in that
>>>> source code. If there are no such mentions, then default MTU
>>>> applies, which depends on the driver.
>>>>
>>>> Have you tried querying statistics to find the cause of the drops?
>>>
>>> Also, given the fact that the application replays some pcap traffic, have you made sure the receiver (where you seek to watch the replayed traffic arrive) has got 'promiscuous' mode [1] enabled? IIRC, 'test-pmd' enables it by default.
>>>
>>> [1]
>>> https://doc/.
>>> dpdk.org%2Fapi-25.07%2Frte__ethdev_8h.html%23a5dd1dedaa45f05c72bcc354
>>> 9
>>> 5e441e91&data=05%7C02%7CKR.Gokul%40in.bosch.com%7Cb670bffe53b8485c75a
>>> 9
>>> 08ddca9c56bf%7C0ae51e1907c84e4bbb6d648ee58410f4%7C0%7C0%7C63888949504
>>> 0
>>> 750455%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMD
>>> A
>>> wMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sd
>>> a
>>> ta=7xqux5VPYgMerNkhy7YOCzj371irrkhEFFrkHTuK1pg%3D&reserved=0
>>>
>>> Thank you.
>>>
>>>>
>>>> Thank you.
>>>>
>>>>>
>>>>> Thanks for your time and support!
>>>>>
>>>>> Best regards,
>>>>> Gokul K.R
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>
>>>>> -----Original Message-----
>>>>> From: Ivan Malov <ivan.malov@arknetworks.am>
>>>>> Sent: Friday, July 18, 2025 5:29 PM
>>>>> To: Gokul K R (MS/ETA7-ETAS) <KR.Gokul@in.bosch.com>
>>>>> Cc: users@dpdk.org; dev@dpdk.org
>>>>> Subject: Re: Issue with DPDK-Burst Replay – No Frame Transmission
>>>>> Observed Despite Successful Replay
>>>>>
>>>>> Hi,
>>>>>
>>>>> (please see below)
>>>>>
>>>>> On Fri, 18 Jul 2025, Gokul K R (MS/ETA7-ETAS) wrote:
>>>>>
>>>>>>
>>>>>> Hi Team,
>>>>>>
>>>>>> I’m currently working with the dpdk-burst-replay tool and
>>>>>> encountered an issue during execution. Below are the details:
>>>>>>
>>>>>>
>>>>>> __________________________________________________________________
>>>>>> _
>>>>>> _
>>>>>> __
>>>>>> __________________________________________________________________
>>>>>> _ _ __ ______________________________________________
>>>>>>
>>>>>>
>>>>>> Observation:
>>>>>> During replay, we received the following informational message:
>>>>>>
>>>>>> port 0 is not on the good numa id (-1)
>>>>>
>>>>> Which API was used to check this? Was API [1] used? If not, what
>>>>> does it show in the absence of 'numactl' command?
>>>>>
>>>>> [1]
>>>>> https://doc/
>>>>> .dpdk.org%2Fapi-25.03%2Frte__ethdev_8h.html%23ad032e25f712e6ffeb0c1
>>>>> 9
>>>>> e
>>>>> ab1ec1fd2e&data=05%7C02%7CKR.Gokul%40in.bosch.com%7C53a20884cad14b9
>>>>> 4
>>>>> 7
>>>>> a0008ddc9aff5bf%7C0ae51e1907c84e4bbb6d648ee58410f4%7C0%7C0%7C638888
>>>>> 4
>>>>> 7
>>>>> 9792834143%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIw
>>>>> L
>>>>> j
>>>>> AuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7
>>>>> C
>>>>> %
>>>>> 7C&sdata=XxPfmsX4WsR83ifUfkkup2jIOw4PU%2FX%2BdefEqVfazj4%3D&reserve
>>>>> d
>>>>> =
>>>>> 0
>>>>>
>>>>>>
>>>>>> As per the DPDK mailing list discussions, this warning is
>>>>>> typically benign—often seen on NICs like Intel I225/I210, which do
>>>>>> not report NUMA affinity. Hence, we proceeded with execution.
>>>>>>
>>>>>>
>>>>>> __________________________________________________________________
>>>>>> _
>>>>>> _
>>>>>> __
>>>>>> __________________________________________________________________
>>>>>> _ _ __ ______________________________________________
>>>>>>
>>>>>>
>>>>>> Command Used:
>>>>>>
>>>>>> sudo numactl --cpunodebind=0 --membind=0 ./src/dpdk-replay
>>>>>> Original_MAC.pcap 0000:01:00.1
>>>>>>
>>>>>> Execution Output:
>>>>>>
>>>>>> preloading Original_MAC.pcap file (of size: 143959 bytes)
>>>>>>
>>>>>> file read at 100.00%
>>>>>>
>>>>>> read 675 pkts (for a total of 143959 bytes). max packet length =
>>>>>> 1518 bytes.
>>>>>>
>>>>>> -> Needed MBUF size: 1648
>>>>>>
>>>>>> -> Needed number of MBUFs: 675
>>>>>>
>>>>>> -> Needed Memory = 1.061 MB
>>>>>>
>>>>>> -> Needed Hugepages of 1 GB = 1
>>>>>>
>>>>>> -> Needed CPUs: 1
>>>>>>
>>>>>> -> Create mempool of 675 mbufs of 1648 octets.
>>>>>>
>>>>>> -> Will cache 675 pkts on 1 caches.
>>>>>
>>>>> What does this 'cache' stand for? Does it refer to the mempool
>>>>> per-lcore cache?
>>>>> If so, please note that, according to API [2] documentation, cache
>>>>> size "must be lower or equal to RTE_MEMPOOL_CACHE_MAX_SIZE and n /
>>>>> 1.5", where 'n' stands for the number of mbufs. Also, documentation
>>>>> says it is advised to choose cache_size to have "n modulo
>>>>> cache_size == 0". Does your code meet these requirements?
>>>>>
>>>>> By the looks of it, it doesn't (cache_size = n = 675). Consider to
>>>>> double-check.
>>>>>
>>>>> [2]
>>>>> https://doc/
>>>>> .dpdk.org%2Fapi-25.03%2Frte__mempool_8h.html%23a0b64d611bc140a4d2a0
>>>>> c
>>>>> 9
>>>>> 4911580efd5&data=05%7C02%7CKR.Gokul%40in.bosch.com%7C53a20884cad14b
>>>>> 9
>>>>> 4
>>>>> 7a0008ddc9aff5bf%7C0ae51e1907c84e4bbb6d648ee58410f4%7C0%7C0%7C63888
>>>>> 8
>>>>> 4
>>>>> 79792843977%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiI
>>>>> w
>>>>> L
>>>>> jAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%
>>>>> 7
>>>>> C
>>>>> %7C&sdata=VLPTrAXqY2FNmhA6mwLFEZgc6f4LFc7oa%2BUb8DrmtWs%3D&reserved
>>>>> =
>>>>> 0
>>>>>
>>>>>>
>>>>>>
>>>>>> __________________________________________________________________
>>>>>> _
>>>>>> _
>>>>>> __
>>>>>> __________________________________________________________________
>>>>>> _ _ __ ______________________________________________
>>>>>>
>>>>>>
>>>>>> Issue:
>>>>>> Despite successful parsing of the pcap file and proper
>>>>>> initialization, no frames were transmitted or received on either
>>>>>> the sender or receiver sides.
>>>>>
>>>>> Is this observation based solely on watching APIs [3] and [4]
>>>>> return
>>>>> 0 all the time? If yes, one can consider to introduce invocations
>>>>> of APIs [5], [6] and [7] in order to periodically poll and print
>>>>> statistics (may be with 1-second delay), which may, for example,
>>>>> shed light on mbuf allocation errors (extended stats).
>>>>>
>>>>> Do statistics display any interesting figures to be discussed?
>>>>>
>>>>> [3]
>>>>> https://doc/
>>>>> .dpdk.org%2Fapi-25.03%2Frte__ethdev_8h.html%23a3e7d76a451b46348686e
>>>>> a
>>>>> 9
>>>>> 7d6367f102&data=05%7C02%7CKR.Gokul%40in.bosch.com%7C53a20884cad14b9
>>>>> 4
>>>>> 7
>>>>> a0008ddc9aff5bf%7C0ae51e1907c84e4bbb6d648ee58410f4%7C0%7C0%7C638888
>>>>> 4
>>>>> 7
>>>>> 9792853601%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIw
>>>>> L
>>>>> j
>>>>> AuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7
>>>>> C
>>>>> %
>>>>> 7C&sdata=56BbJeMo6BtewrRGcnIIWBx4gxbvQKl7iATnoUpcTMc%3D&reserved=0
>>>>> [4]
>>>>> https://doc/
>>>>> .dpdk.org%2Fapi-25.03%2Frte__ethdev_8h.html%23a83e56cabbd31637efd64
>>>>> 8
>>>>> e
>>>>> 3fc010392b&data=05%7C02%7CKR.Gokul%40in.bosch.com%7C53a20884cad14b9
>>>>> 4
>>>>> 7
>>>>> a0008ddc9aff5bf%7C0ae51e1907c84e4bbb6d648ee58410f4%7C0%7C0%7C638888
>>>>> 4
>>>>> 7
>>>>> 9792862833%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIw
>>>>> L
>>>>> j
>>>>> AuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7
>>>>> C
>>>>> %
>>>>> 7C&sdata=bDP8uNF03zuftWy%2BRbXKg1sYwv8DruMG53ntffCy%2BOk%3D&reserve
>>>>> d
>>>>> =
>>>>> 0
>>>>>
>>>>> [5]
>>>>> https://doc/
>>>>> .dpdk.org%2Fapi-25.03%2Frte__ethdev_8h.html%23adec226574c53ae413252
>>>>> c
>>>>> 9
>>>>> b15f6f4bab&data=05%7C02%7CKR.Gokul%40in.bosch.com%7C53a20884cad14b9
>>>>> 4
>>>>> 7
>>>>> a0008ddc9aff5bf%7C0ae51e1907c84e4bbb6d648ee58410f4%7C0%7C0%7C638888
>>>>> 4
>>>>> 7
>>>>> 9792872496%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIw
>>>>> L
>>>>> j
>>>>> AuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7
>>>>> C
>>>>> %
>>>>> 7C&sdata=dJ3yB2MTz28n2mQ5ogbYilcj4sr7K2JD723k5zWvlyU%3D&reserved=0
>>>>> [6]
>>>>> https://doc/
>>>>> .dpdk.org%2Fapi-25.03%2Frte__ethdev_8h.html%23a418ad970673eb1716731
>>>>> 8
>>>>> 5
>>>>> e36044fd79&data=05%7C02%7CKR.Gokul%40in.bosch.com%7C53a20884cad14b9
>>>>> 4
>>>>> 7
>>>>> a0008ddc9aff5bf%7C0ae51e1907c84e4bbb6d648ee58410f4%7C0%7C0%7C638888
>>>>> 4
>>>>> 7
>>>>> 9792882662%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIw
>>>>> L
>>>>> j
>>>>> AuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7
>>>>> C
>>>>> %
>>>>> 7C&sdata=aFt%2Fn%2B4FqX6cJDxWVRyWlZrAlVPXOqE6jV7Uymq7WQw%3D&reserve
>>>>> d
>>>>> =
>>>>> 0
>>>>> [7]
>>>>> https://doc/
>>>>> .dpdk.org%2Fapi-25.03%2Frte__ethdev_8h.html%23a300d75b583c1f5acfe5b
>>>>> 1
>>>>> 6
>>>>> 2a5d8c0ac1&data=05%7C02%7CKR.Gokul%40in.bosch.com%7C53a20884cad14b9
>>>>> 4
>>>>> 7
>>>>> a0008ddc9aff5bf%7C0ae51e1907c84e4bbb6d648ee58410f4%7C0%7C0%7C638888
>>>>> 4
>>>>> 7
>>>>> 9792892124%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIw
>>>>> L
>>>>> j
>>>>> AuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7
>>>>> C
>>>>> %
>>>>> 7C&sdata=TlmU3IaIKCzOEvsmFn8if%2BftgQq7ZJCuzcs6x%2B8jaAY%3D&reserve
>>>>> d
>>>>> =
>>>>> 0
>>>>>
>>>>>>
>>>>>>
>>>>>> __________________________________________________________________
>>>>>> _
>>>>>> _
>>>>>> __
>>>>>> __________________________________________________________________
>>>>>> _ _ __ ______________________________________________
>>>>>>
>>>>>>
>>>>>> Environment Details:
>>>>>>
>>>>>>  *  NIC used: Intel I225/I210
>>>>>>  *  Hugepages configured: 1 GB
>>>>>>  *  NUMA binding: --cpunodebind=0 --membind=0
>>>>>>  *  OS: [Your Linux distribution, e.g., Ubuntu 20.04]
>>>>>>  *  DPDK version: [Mention if known]
>>>>>>
>>>>>> __________________________________________________________________
>>>>>> _
>>>>>> _
>>>>>> __
>>>>>> __________________________________________________________________
>>>>>> _ _ __ ______________________________________________
>>>>>>
>>>>>>
>>>>>> Could you please advise if any additional setup, configuration, or
>>>>>> known limitations may be impacting the packet transmission?
>>>>>
>>>>> This may be a wild suggestion from my side, but it pays to check
>>>>> whether link status is "up" upon port start on both ends. One can
>>>>> use API [8] to do that.
>>>>>
>>>>> [8]
>>>>> https://doc/
>>>>> .dpdk.org%2Fapi-25.03%2Frte__ethdev_8h.html%23ac05878578e4fd9ef3551
>>>>> d
>>>>> 2
>>>>> c1c175ebe7&data=05%7C02%7CKR.Gokul%40in.bosch.com%7C53a20884cad14b9
>>>>> 4
>>>>> 7
>>>>> a0008ddc9aff5bf%7C0ae51e1907c84e4bbb6d648ee58410f4%7C0%7C0%7C638888
>>>>> 4
>>>>> 7
>>>>> 9792901138%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIw
>>>>> L
>>>>> j
>>>>> AuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7
>>>>> C
>>>>> %
>>>>> 7C&sdata=kLtuxeh0nYIV7UnU5WGLykXqngpIXzqHNsMlRG%2F89e0%3D&reserved=
>>>>> 0
>>>>>
>>>>> Thank you.
>>>>>
>>>>>
>>>>>>
>>>>>> Thank you in advance for your support!
>>>>>>
>>>>>>
>>>>>> Best regards,
>>>>>> Gokul K R
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>
>>>
>>
>
--8323328-978156084-1753425968=:9407--
