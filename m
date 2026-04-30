Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68809FF886F
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Apr 2026 09:32:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A2C7C40648;
	Thu, 30 Apr 2026 11:32:20 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 3D04640648
 for <dev@dpdk.org>; Thu, 30 Apr 2026 11:32:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777541538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=BDrBrOusdcmO1zYqfnqxAjfS3G0ZhtCaSdo5ge5qjvc=;
 b=dFO2mTQs8f4NS37FwOFjDaMQ+MwSXHwNamOs/ragtel/Hz1dR+yYqeWssSWCcoeXWkMBGZ
 k2blcSmhv2hThyiyaxm6ZZnc6niDJJaqrPmyK0rFhUuCmMYJLvkhKwOvY+1zspGf3JAGPa
 VRBF5cEgWJubv8JKu/4AGudjDKCR3AE=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-zqarQtVvPAm8WDPx5TOpvQ-1; Thu, 30 Apr 2026 05:32:15 -0400
X-MC-Unique: zqarQtVvPAm8WDPx5TOpvQ-1
X-Mimecast-MFC-AGG-ID: zqarQtVvPAm8WDPx5TOpvQ_1777541535
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50f817c3240so7101341cf.1
 for <dev@dpdk.org>; Thu, 30 Apr 2026 02:32:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777541535; x=1778146335;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BDrBrOusdcmO1zYqfnqxAjfS3G0ZhtCaSdo5ge5qjvc=;
 b=ce0naXSLsoy5sEaPoNNvE/x/Gp2Xn64FtCTRWImISMah6KY6rwnFS07fzsFVMEJNje
 2/FK0vwiVS7IZbBXOjKhbwoDemgt6UUifeUGMqQld7FlMy3SaRrD9e4MlBlEOnT/mJuH
 nE3+4wUxcX472tLkyu+EYag1p/HpPLY5HWDSByD8vEqz9SHCUlF6s7BKlniHvdOl5Bu3
 Xa1FuQRU0Z2AXrPO2hO4vDqhCDUvr5UzeBKdJM0UCLWbCs078mllSc4YbbfIOqlygtMP
 75Qg7Wu0ohiiGVE6v5mrMAovrnH14Won35wSFdFGfcK2kaad0ea14uF9xTDrf6Ha6rMD
 eZaA==
X-Gm-Message-State: AOJu0YytkvYLxVpQ9OsHV8yLSZNA8z6zSYx7a/QskAQRWQF9cVVNTGjN
 vpcK/EbD3NIo+y0DKzjXkS4OoGiH4m4lccSXTxoqWg9Abx6YAdTTzZtTpqnd22FeaEmXNBAu1AM
 NdT/2ysfeQFu69mxha+T1xk2sno9b4ZvabrRupX206T63
X-Gm-Gg: AeBDieta8zvVew1ZeDcwnXz+cCDq3+Vcm1xkbN3NQI1AEvI/GDcX73Eoli/QIgwkQZS
 Ae43GNBwmwBveacNaR8mov/AJ1wdbjN5vG0Q9rwz9/7IgCF8CXqugfeVASxXHzOJbu9ANaTSQ+Z
 vQaN7UB7ss0sbxiIO6TtkYo9z2LOKaYtq8hKY1zG74+oamAJybBiFzYzDmuqLfXME0XrDUcOy8l
 FN2nrsaK+EZSTwn13XATnU3lSNhhkLC7Q8cS0VMt1cLFeeS4bxmDvQ9ny09lZkY6Op3Ahn0q2C0
 dM9DF1x4MlYOJXg1qnLjkz5JlbtOM7LOvJzcDEgTi11nERQlKiexD0x9W7xyvxocNapCW5tY9hT
 Tai4nE2urxefrnIKTziDoPz8rFntcJuQC07g=
X-Received: by 2002:a05:622a:2303:b0:50f:ade2:2da with SMTP id
 d75a77b69052e-5102ae15f49mr28912311cf.44.1777541534912; 
 Thu, 30 Apr 2026 02:32:14 -0700 (PDT)
X-Received: by 2002:a05:622a:2303:b0:50f:ade2:2da with SMTP id
 d75a77b69052e-5102ae15f49mr28911791cf.44.1777541534390; 
 Thu, 30 Apr 2026 02:32:14 -0700 (PDT)
Received: from [192.168.0.65] ([78.16.129.234])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b3ff32891csm13676076d6.17.2026.04.30.02.32.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2026 02:32:13 -0700 (PDT)
Message-ID: <73da1ec3-d1cc-4efb-bedf-89b0f951ec5d@redhat.com>
Date: Thu, 30 Apr 2026 10:32:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 23.11.7 patches review and test
To: Shani Peretz <shperetz@nvidia.com>, stable@dpdk.org
Cc: dev@dpdk.org, Abhishek Marathe <Abhishek.Marathe@microsoft.com>,
 Ali Alnubani <alialnu@nvidia.com>, benjamin.walker@intel.com,
 David Christensen <drc@linux.vnet.ibm.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, Jerin Jacob <jerinj@marvell.com>,
 John McNamara <john.mcnamara@intel.com>, Ju-Hyoung Lee
 <juhlee@microsoft.com>, Luca Boccassi <bluca@debian.org>,
 qian.q.xu@intel.com, Raslan Darawsheh <rasland@nvidia.com>,
 Thomas Monjalon <thomas@monjalon.net>, yuan.peng@intel.com,
 zhaoyan.chen@intel.com, Robin Jarry <rjarry@redhat.com>,
 David Marchand <david.marchand@redhat.com>,
 Thomas Monjalon <thomas@monjalon.net>
References: <20260421064637.2506152-1-shperetz@nvidia.com>
From: Kevin Traynor <ktraynor@redhat.com>
Autocrypt: addr=ktraynor@redhat.com; keydata=
 xsFNBF2J2awBEADUEPNhgNI+nJNgiTAUcw4YIgVXEoHlsNPyyzG1BEXkWXALy0Y3fNTiw6+r
 ltWDkF9jzL9kfkecgQ67itGfk1OaBXgSGKuw1PUpxAwX2Bi76LAR6M5OsyGM9TSVVQwARalz
 hMwRBIZPzPc7or6Pw7jAOJ8SQGJ1Zlp1YJCjrvpe87V1tH/LY8Wnxn/EuoseFmWILAQZAtYS
 tGjcrAgYn3SPMLR1B0BP5bTBY06vWQjiufH8drenfDnMJAzuBdG1mqjnTqCjULZ3Hunv4xqZ
 aMnkvL/K5Tj1c12Oe4930EE53LrXIBUltRg5mBudSWHnC7twjH0082HH9f963Z/2UI63SFIT
 iUvRvAzJYytgy7XnWLQ0+goZBADKYfolOuC0H8VgCaux8u8KFF28Dy+N6TV2KI58jTlyg1Zu
 l7QwykZpnOkJFiy37Gfbu3YEOzO72cP/S7/A+zvuqkxi63jyEkd+FY99vLt/HN2MUZwRmKDw
 UPbLkmrs8WU01/POVsqDcfvz7vu2St8hqqTiSIdQGS2zyTKB2/DvPSM3jws3udkIYSuhn+X4
 QBiV6lkVZ7DSE6a065gnAauAql+b32Eymy+xnG5jCt1tR+0Cp2VZYCR9OU2gmomUKBDoX/He
 pSgED01CqYPNjN+TddirwmQX7ep4DtXc8FWvv2g/pq9WZFQk2QARAQABzSNLZXZpbiBUcmF5
 bm9yIDxrdHJheW5vckByZWRoYXQuY29tPsLBjgQTAQgAOBYhBAoiOaH51tHF7VYtEI9CINER
 a+yJBQJdidmsAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEI9CINERa+yJoxIP/3VF
 2TIgW4ckxhRFCvFu/606bnvCPie88ake4uWVWMAWwcMc4fKEltRWRCpkSVOwgqoMHnyHxK5r
 kOKzx2CLJMX5TgTMfKzPuaBDHngHLUzl2DStpBzrod0cVg5TShdmmfjY61uxRJKz+DlSkwgJ
 riADdVF5PPosQXTkKSGf2ombpTGpx/pue9ocjnr3x4SDpRLlnooM6Jf/3Y3Ib4jX6HPEyWuY
 b+owIIk9y2nRRGPQ6jbqAhsrXd9V+77UL0QuGWloMuKMZFbNg8hbu7X5aFijAbfxj4YUgojS
 ba7gfGZQan8h32A9KGQWrmsCBc3j2GqEPsX0r05X7cn7WL6IOPgQJ5EiQ7PlazQYVLrvZg9B
 n0GKK0k6895mLG0ZZ5v/qajOPF52etSmvFD1WUPb4OqaHqGA9ZtMpaKFRt7Y6rpXqKNU1xzW
 F5KjbTPtTb9WF3An8dciVv+AYUI7totkZYkWvQtgss8lfaX3NKUvXLVxqK0z3dQyr7rF/tYz
 PneTKypSksjCgaEBLSrsRmM5zKfe7tSNF/fDntfIq/029Jtcw29TcWEP57peNu6TtejewQD9
 sTI+oqiXvW2D5l7LNUDYG8eMJp2oT7I0ZSBRvwcbmjH0DtN/bXCCFfCvk8Yic68F3tV1ctix
 wQARVKDBhT30uCxycRWojCYqTgNJJS71zsFNBF2J2awBEADP57PR2IpSYBeNSrsAjeIcsahE
 N4SQP2C4s50S8QEWAUhqMRI7WNv5cfeef0nDvcl1IUA6oz5SokbcsbMa+mRgaNF4N5KikWTO
 LPYxq2YVJoXwJ+tKmNzyOLFUIfFJ4NBJZple5dTfWzD00Dbb19Mri1hy1mWMqNTPGBee1+hw
 Qcp6n3mmGECvajs8G5A7NyXbwL8ihN7HX9D01ucD62b4G03yKe2g/hvKgcdUVmhCldJlF27I
 2fSR9tDxH9pZqRODY4rjbFZEey/vWKXqjE+DQ8AtMSEaDfFe5D+i4Aw6erWQ3Wr+DwZt1/7G
 dIAElGA/q90T1ENVwJX9y7fsQssawKYYdDqURHCl5JuDXI+VXUypExipUUT5SPycMmbLsx0D
 iKEqPPDQWKxkIDVKqj2+EhamSuJznZUwBLJKn0h4zrIWiXWUy07lRwtVuhaDXhF3GfW+5W/x
 wAg7Qg3w00ASsb/XTHBIhMnenKDfS7ihtQA8SacwX8ySdxb+15XPyiplM979qBQ0mhnilulm
 MIJzEf/JxoYR5huuj4f1PFqqrsP06Dl+YGB7dQZp3IKggS5c3/TAynARRg9N89UsDXNtp7X0
 tgIPFF5k6fnHE0J5O64GYHeTqN/1aE6dAEOV9WrGzQAJxU9ipikb8jKAWXzLewRIKGmoPcRZ
 WdB0NmIjmQARAQABwsF2BBgBCAAgFiEECiI5ofnW0cXtVi0Qj0Ig0RFr7IkFAl2J2awCGwwA
 CgkQj0Ig0RFr7IkkORAAl/NbX93WK5MEoRw7/DaPTo/Lo6Pj1XMeSqGyACigHK/452UDvlEH
 NjNJMzYYrNIjMtEmN9VVCfjT38CSca7mpGQVwchc0mC7QSPAETLCS+UacVf/Kwxz5FfkEUUw
 UT7A+uyVOIgW3d9ldlRzkHA2czonSSgTQU+i2g6DM4ha+BuQb4byAXH6HQHt/Zh1J64z0ohH
 v6iGsCzCY/sMWF8+LEGSnzMGRCLiiwSF0vJBHbzWK68fANaF4gBV0Z/+6tQRFN7YMhj/INmk
 qgvHj1ZzHFNtirjMGPRxoZs51YoLQM/aBPxKrnmXThx1ufH+0L6sGmFTugiDt0XSEkC5reH7
 a+VhQ1VTFFQrClA8NmDSPzFeuhru4ryaaDHO+uEB16cNHxHrQtlP/2hts2JM5lwkZRWJ5A57
 h8eDEIK5be47T85NVHfuTaboNRmgg1HygVejhGUtt69u/0MVRg/roUTa0FyEbNsvz4qAecyW
 yWzMcVrcGJDQLC9JLKEpoyUF6gdTKaiDL2Vao4+XRIA3Y57b6MO35a3HuzAv7+i5Z0mnDEJO
 XxXqTOmKYpMIGexzM/PtuA0712sT1abG9tAJ17ao/B7cqMW5IkKkalemFbWfI2unns4Papvo
 tk9igVqyp6EJDU98z5TJioCVojwK2laDaoIjTJk9YYv3iwCsqPd5feU=
In-Reply-To: <20260421064637.2506152-1-shperetz@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YMq6jQK2qtUiykEaG1Ll_cqEmCSk1M2d4hyiIHQmjMw_1777541535
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On 4/21/26 7:46 AM, Shani Peretz wrote:
> Hi all,
> 
> Here is a list of patches targeted for stable release 23.11.7.
> 
> The planned date for the final release is 30 April 2026.
> 
> Please help with testing and validation of your use cases and report
> any issues/results with reply-all to this mail. For the final release
> the fixes and reported validations will be added to the release notes.
> 
> A release candidate tarball can be found at:
> 
>     https://dpdk.org/browse/dpdk-stable/tag/?id=v23.11.7-rc1
> 
> These patches are located at branch 23.11 of dpdk-stable repo:
>     https://dpdk.org/browse/dpdk-stable/
> 
> Thanks.
> 

Hi Shani,

As discussed on thread [0] there was a quite serious regression caused
by "net: fix packet type for stacked VLAN"

As discussion on the fix is ongoing, I would suggest to just revert this
patch for your release.

It doesn't require a new RC and re-validation as it's an isolated issue
(and there wasn't test cases to catch before Robin's new patch anyway)

thanks,
Kevin.

[0] https://mails.dpdk.org/archives/dev/2026-April/336248.html

> Shani
> 
> ---
> Aarnav JP (2):
>       examples/packet_ordering: fix format specifier for port ID
>       examples/ptpclient: fix format specifier for port ID
> 
> Anatoly Burakov (12):
>       net/ixgbe: fix memory leak in security flows
>       net/ixgbe: fix potential null dereference with IPsec config
>       net/ixgbe: fix potential null dereference in IPsec flow
>       net/ixgbe: fix pointer handling in IPsec
>       net/i40e: move filter config to flow create
>       net/i40e: fix IPv6 GTPU handling
>       net/iavf: fix memory leak on egress IPsec flows
>       net/iavf: fix memory leak on uninit
>       net/iavf: fix IPv4 flow subscription
>       net/ice: fix memory leak in DCF QoS bandwidth config
>       net/ice: fix memory leak in FDIR flow parsing
>       net/iavf: fix struct size in IPsec status get
> 
> Anurag Mandal (3):
>       app/testpmd: fix function names in logs
>       net/i40e: fix QinQ stripping
>       net/iavf: fix deletion of primary MAC address
> 
> Ashok Kumar Natarajan (5):
>       net/axgbe: fix MAC TCR speed select field width
>       net/axgbe: add 100 Mbps MAC speed select
>       net/axgbe: fix auto-negotiation capabilities
>       net/axgbe: fix SGMII auto-negotiation status bits
>       net/axgbe: fix 100M SGMII mode
> 
> Bruce Richardson (31):
>       net/iavf: revert check for PF Rx timestamp support
>       rcu: fix build with MSVC
>       test/red: fix some undefined behaviour
>       test/timer: fix hang on secondary process failure
>       buildtools/test: suppress empty output
>       eal: fix variable shadowing
>       bbdev: fix variable shadowing
>       ethdev: fix variable shadowing
>       eventdev: fix variable shadowing
>       net: fix variable shadowing
>       pcapng: fix variable shadowing
>       pipeline: fix variable shadowing
>       power: fix variable shadowing
>       table: fix variable shadowing
>       bus/pci: fix variable shadowing
>       net/cpfl: fix variable shadowing
>       net/e1000: fix variable shadowing
>       net/i40e: fix variable shadowing
>       net/ice: fix variable shadowing
>       net/ixgbe: fix variable shadowing
>       app/graph: fix variable shadowing
>       app/pdump: fix variable shadowing
>       app/testpmd: fix variable shadowing
>       config/arm: fix 32-bit build
>       hash: fix maybe-uninitialized warnings on build
>       net/intel: fix memory leak on Tx queue setup failure
>       test: fix dependencies on net null driver
>       hash: fix overflow of 32-bit offsets
>       test/security: skip inline protocol test if no HW support
>       net/bonding: clamp Rx free threshold for small rings
>       usertools/pmdinfo: fix search for PMD info string
> 
> Chengwen Feng (2):
>       net/hns3: fix outer UDP checksum with simple BD
>       eal: introduce more macros for bit definition
> 
> Ciara Loftus (7):
>       doc: fix TSO and checksum offload feature status for ice
>       doc: fix TSO feature status for iavf
>       doc: fix inline crypto feature status for iavf
>       doc: fix TSO feature status for i40e
>       net/i40e: validate raw flow items before dereferencing
>       doc: remove references to obsolete testpmd flag
>       net/i40e: fix raw flow item validation
> 
> Congjie Zhou (1):
>       eal/linux: fix fbarray name collision in containers
> 
> Dariusz Sosnowski (10):
>       app/testpmd: fix flow queue job leaks
>       net/mlx5: fix flow mark reading after reconfigure
>       net/mlx5: fix shared Rx queue limitations
>       common/mlx5: fix bonding check
>       net/mlx5: fix bonding check
>       net/mlx5: fix probing to allow BlueField Socket Direct
>       net/mlx5: fix VLAN strip info for CQE compression
>       net/mlx5: fix flex item capability check
>       common/mlx5: fix error logging for queue modify
>       net/mlx5: report share group and queue ID
> 
> David Marchand (9):
>       bus/ifpga: fix const pointer in device name parsing
>       crypto/caam_jr: fix const pointer in UIO filename parsing
>       net/enetfec: fix const pointer in UIO filename parsing
>       net/memif: fix const pointer in socket check
>       app/procinfo: fix const pointer in collectd format
>       net/tap: remove log when running without multiprocess
>       net/af_xdp: fix external mbuf transmit
>       common/mlx5: fix MAC deletion on Linux
>       examples/vm_power_manager: fix format specifier for port ID
> 
> Emma Finn (1):
>       examples/fips_validation: fix dangling pointers
> 
> Garvit Varshney (1):
>       crypto/cnxk: return decrypted data for RSA verify
> 
> Gregory Etelson (3):
>       net: fix packet type for stacked VLAN
>       net/mlx5: fix MPESW PF probe for any number of ports
>       net/mlx5: fix IPv6 SRH flex node header length
> 
> Itai Sharoni (1):
>       net/mlx5/windows: fix MAC address ownership tracking
> 
> Ivan Malov (4):
>       common/sfc_efx/base: fix flow control on legacy MCDI
>       net/sfc: rework capability check that is done on FEC set
>       net/sfc: drop AUTO from FEC capabilities and fix comment
>       net/sfc: fix reporting status of autonegotiation
> 
> Jacob Keller (1):
>       net/iavf: negotiate PTP before reporting Rx timestamping
> 
> John McNamara (1):
>       net/i40e: fix unused variable
> 
> Kai Ji (1):
>       crypto/openssl: fix SM2 public key buffer overflow
> 
> Kevin Traynor (5):
>       eal/linux: handle interrupt epoll events
>       interrupts: add interrupt event info
>       net/mlx5: check DevX disconnect/error interrupt events
>       examples/ipsec-secgw: fix build with glibc 2.43
>       examples/vm_power: check truncation of socket path
> 
> Liangxing Wang (1):
>       app/dma-perf: fix reversed CPU copy
> 
> Long Li (14):
>       net/netvsc: fix race conditions on VF add/remove events
>       net/netvsc: support multi-process VF device removal
>       net/mana: fix PD resource leak on device close
>       net/netvsc: fix devargs memory leak on hotplug
>       net/mana: fix fast-path ops setup in secondary process
>       net/mlx5: fix fast-path ops setup in secondary process
>       net/mlx4: fix fast-path ops setup in secondary process
>       net/netvsc: fix subchannel leak on device removal
>       net/netvsc: fix double-free of primary Rx queue on uninit
>       net/netvsc: fix resource leak on init failure
>       net/netvsc: fix event callback leak on Rx filter failure
>       net/netvsc: fix resource leaks on MTU change
>       net/mana: fix CQE suppression handling on error completions
>       net/netvsc: switch data path to synthetic on device stop
> 
> Luca Boccassi (1):
>       test/debug: fix IOVA mode on PPC64 without huge pages
> 
> Maayan Kashani (1):
>       net/mlx5: fix redundant control rules in promiscuous mode
> 
> Maciej Paczkowski (1):
>       net/ice/base: fix integer types in comparisons
> 
> Marat Khalili (6):
>       bpf: fix x86 call stack alignment for external calls
>       bpf: disallow empty program
>       bpf: fix add/subtract overflow
>       bpf: fix starting with conditional jump
>       bitops: allow variable as first argument of shift macros
>       bpf: fix signed shift overflows in ARM JIT
> 
> Martin Spinler (5):
>       net/nfb: use constant values for max Rx/Tx queues count
>       net/nfb: fix bad pointer access in queue stats
>       net/nfb: use process private variable for internal
>       net/nfb: fix resources release
>       net/nfb: stop only started queues in fail path
> 
> Maxime Coquelin (3):
>       vhost: fix virtqueue array size for control queue
>       vhost: fix descriptor chain bounds check in control queue
>       vhost: fix mmap error check in VDUSE IOTLB miss handler
> 
> Maxime Leroy (8):
>       net/dpaa2: warn on Rx descriptor limit in high perf mode
>       net/dpaa2: fix resource leak on soft parser failure
>       net/dpaa2: fix link after port stop/start
>       net/dpaa2: fix spurious VLAN insertion on non-VLAN packet
>       net/dpaa2: fix L4 packet type in slow parse path
>       net/dpaa2: fix L3/L4 checksum offload flags
>       net/dpaa2: fix burst mode info
>       net/dpaa2: add SG table walk upper bound in Rx
> 
> Morten Brørup (2):
>       eal: fix cache guard for pedantic compilation
>       mbuf: fix packet data read
> 
> Nithinsen Kaithakadan (1):
>       test/crypto: fix mbuf segment number
> 
> Pavan Nikhilesh (1):
>       event/cnxk: fix Rx offload flags
> 
> Piotr Krzewinski (1):
>       cryptodev: fix memory corruption in secondary process
> 
> Radu Nicolau (1):
>       pdcp: add digest physical address
> 
> Rahul Bhansali (1):
>       event/cnxk: fix crash on CN10K
> 
> Rakesh Kudurumalla (2):
>       common/cnxk: fix engine capabilities fetch logic
>       examples/l2fwd-jobstats: fix stats availability
> 
> Robin Jarry (3):
>       net/iavf: fix reported max Tx and Rx queues
>       telemetry: fix adding dict in container array
>       hash: avoid leaking entries on RCU defer queue failure
> 
> Rongwei Liu (1):
>       net/mlx5: fix job leak on indirect meter creation failure
> 
> Sergei Iashin (1):
>       eventdev/eth_rx: fix crash with telemetry
> 
> Shaiq Wani (1):
>       net/idpf: fix typo in CQ scan threshold macro name
> 
> Shani Peretz (6):
>       examples/ethtool: fix size of mempool name
>       net/mlx5/hws: fix stack alignment for ASan compatibility
>       net/mlx5/hws: fix null dereference in rule skip
>       net/mlx5: allow MTU mismatch for running shared queue
>       app/testpmd: fix memory leak in port flow configure
>       net/mlx5: fix meter ASO action leak on release to pool
> 
> Song Yoong Siang (3):
>       net/e1000: use device timestamp for clock read in igc
>       net/e1000: fix allocation of context desc for launch time
>       net/e1000: fix igc launch time calculation
> 
> Sriram Yagnaraman (2):
>       net/memif: fix descriptor Tx flags corruption
>       net/memif: fix multi-segment Rx corruption
> 
> Stephen Hemminger (26):
>       bus/fslmc: fix const pointer in device name parsing
>       common/cnxk: fix array out-of-bounds
>       examples/fips_validation: fix RSA memcpy
>       net/bnxt: fix build with GCC 16
>       test/table: avoid input line overflow
>       test/crypto: check for vdev args overflow
>       pcapng: document return values
>       pcapng: use malloc instead of fixed buffer size
>       pcapng: chain additional mbuf when comment exceeds tailroom
>       test/pcapng: skip test if null driver missing
>       net/mlx5: fix use-after-free in ASO management init
>       net/tap: use correct length for interface names
>       net/tap: fix resource leaks in secondary process probe
>       net/tap: free IPC reply buffer on queue count mismatch
>       net/tap: fix use-after-free on remote flow creation failure
>       net/tap: free remote flow when implicit rule already exists
>       test/pcapng: fix for Windows
>       test: add pause to synchronization spinloops
>       test/atomic: scale test based on core count
>       test/mcslock: scale test based on core count
>       test/stack: scale test based on core count
>       test/timer: scale test based on core count
>       test/timer: replace volatile with C11 atomics
>       test: add file-prefix for all fast-tests on Linux
>       test/trace: fix parallel execution with traces enabled
>       examples/vmdq_dcb: initialize all configuration structures
> 
> Talluri Chaitanyababu (1):
>       app/testpmd: fix DCB forwarding TC mismatch handling
> 
> Thierry Herbelot (1):
>       net/intel: update key length when getting RSS key
> 
> Thomas Monjalon (4):
>       common/mlx5: fix variable shadowing
>       net/mvpp2: fix variable shadowing
>       eal/x86: fix TSC frequency query
>       examples/ethtool: fix error message about ports limit
> 
> Venkatesh Vemula (1):
>       net/intel: fix comma operator warnings
> 
> Viacheslav Ovsiienko (2):
>       net/mlx5: fix flex parser creation length attribute
>       net/mlx5: fix send skew settings when using wait on time
> 
> Vipin Varghese (1):
>       app/dma-perf: fix buffer overflow with high core count
> 
> Vladimir Medvedkin (1):
>       fib: fix prefix addition handling
> 
> Xavier Guillaume (1):
>       net/af_packet: fix MTU set data size calculation
> 
> Xiaoyu Min (1):
>       net/mlx5: fix HW flow counter query
> 
> Yang Xu (1):
>       net/mlx5: fix port down in link detection failure
> 
> Yunjian Wang (1):
>       net/mlx5: fix memory leak after device spawn failure
> 

