Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D69CF649C
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Nov 2025 01:57:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7B7E640267;
	Thu, 20 Nov 2025 02:57:57 +0100 (CET)
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
 by mails.dpdk.org (Postfix) with ESMTP id 6C9C740262
 for <dev@dpdk.org>; Thu, 20 Nov 2025 02:57:54 +0100 (CET)
X-QQ-mid: Yeas8t1763603869t248t09944
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com
 [122.231.28.133])
X-QQ-SSF: 0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 10405319286998602982
To: "'Thomas Monjalon'" <thomas@monjalon.net>,
	<dev@dpdk.org>
Cc: "'Xingui Yang'" <yangxingui@huawei.com>,
 "'Chengwen Feng'" <fengchengwen@huawei.com>,
 "'Zaiyu Wang'" <zaiyuwang@trustnetic.com>,
 "'Christian Koue Muf'" <ckm@napatech.com>,
 "'Serhii Iliushyk'" <sil-plv@napatech.com>,
 "'Cristian Dumitrescu'" <cristian.dumitrescu@intel.com>,
 "'Jian Wang'" <jianwang@trustnetic.com>,
 "'Andrew Rybchenko'" <andrew.rybchenko@oktetlabs.ru>,
 =?UTF-8?Q?'Morten_Br=C3=B8rup'?= <mb@smartsharesystems.com>,
 "'Sunil Kumar Kori'" <skori@marvell.com>,
 "'Xingui Yang'" <yangxingui@huawei.com>,
 "'Chengwen Feng'" <fengchengwen@huawei.com>,
 "'Zaiyu Wang'" <zaiyuwang@trustnetic.com>,
 "'Christian Koue Muf'" <ckm@napatech.com>,
 "'Serhii Iliushyk'" <sil-plv@napatech.com>,
 "'Cristian Dumitrescu'" <cristian.dumitrescu@intel.com>,
 "'Jian Wang'" <jianwang@trustnetic.com>,
 "'Andrew Rybchenko'" <andrew.rybchenko@oktetlabs.ru>,
 =?UTF-8?Q?'Morten_Br=C3=B8rup'?= <mb@smartsharesystems.com>,
 "'Sunil Kumar Kori'" <skori@marvell.com>
References: <20251119130333.2697937-1-thomas@monjalon.net>
In-Reply-To: <20251119130333.2697937-1-thomas@monjalon.net>
Subject: RE: [PATCH] drivers/net: fix Tx packet prepare
Date: Thu, 20 Nov 2025 09:57:48 +0800
Message-ID: <023801dc59c1$122cfa50$3686eef0$@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQJ6GkSCSNiWHDCayPbTfeKe+f9oybO/Sx5w
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NhdiEwnVOUqE3vsNVltN89J8otVuVfktU5IeaWLkp6FkwYIGe22R97C7
 EUxYpmlHn6xHzY6eQWzm4nZ0aWm/VRU2uZiLUFoKWCHDHQLTMolQBGFFIqkYkyBMdS0T6N5
 t10M1Wfj95ZHzkipl7zDwuXyZaT5e+xS+LlgVn8etUtNSt3Z+4E8qSIf90yq/IpOocFPlTN
 VHjDs1BfIPTIHoH4sLAXw/rMOmos42T4zGZW+pSbEimbz5jJ3OrNlg6xs3nG47ANDpqc3+8
 s8HAyFtHi5IG75z/2PEAHriUD1f709tcNbm2dSvojgeitnTV1KJv4L3xOf4HPlXjCWv13rJ
 whO6k5c8QXvR6XZic8xYykkiugmcE6fMsRhbW2b2/umDGhlMHgPhJZy60ZLTgB3gQT1yK+l
 gMbqirektd0XTAoSp+Wt2d8mLcRM+r4p8UHEsehL0aHIkz+cdE+hp66ZLKIcsaK/8/GoVSr
 j3VfQDV5gKYGNGedCtOzw76KvAHhLpLmDz86zBq2nljUOstorbwxn+SWNyLf+ynx/M7ZdYU
 NT3d0ur04D00l29LKeUrsjlV2wOIna40qeOxA69vvQf/n+1w4psGc5OHCSB2n5mbm6dkSsR
 uOQ5s2D0UVUCugvHkSq2IPYgsDpZr15SpPVYmib/wkIScevQVJd1PcVlRrsS1u2Hnajkn0b
 g9+B3V0N0apNu0Bfc7sK8FQ7nWTmwRNoxanLfn54porj7F8bp7XJIBgElRt7Z7+5MVGlZXs
 067cyjiB333OwxpCzhVxwOZ7aFJjT7O9D26o7m09PqR+l4qQOnBTLT5Q2wLH0IHUQnPV7bY
 yCKg8ksjfzlwrVGTSgSbb6S1N+hz4N0wz9Yyt2Tz9N3c6ktuiVYZ6qGc8i1uEXmpdxKrjS6
 fxUGJsqoYkvXIWL6bfd8FwefLzzqRUM/cG+m+ov7rblUwhsExnt5XY4pQOjLoZ8i+0gbNHN
 /MdgZ7fnHNIPpOBWwwLkj6u2lFtLD02bvgtkCXImrrTfC45JgTqaSXQjSWQlfZ5OY6qQXwG
 EiIi1ymyRz/sT/YFXPC1oiUVLtv6ISQ6NbblfdjBOg77OKsg39
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0
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

On Wed, Nov 19, 2025 9:04 PM, Thomas Monjalon wrote:
> After removing callback checks from ethdev fast path,
> some drivers crashed because tx_pkt_prepare was set to NULL.
> 
> Some drivers (hns3, ngbe, txgbe) need to use rte_eth_tx_pkt_prepare_dummy
> when configuring queues.
> Other drivers (ntnic, softnic) does not need to set tx_pkt_prepare
> as it was set by eth_dev_set_dummy_fops() called by rte_eth_dev_allocate().
> 
> Bugzilla ID: 1834
> Fixes: 066f3d9cc21c ("ethdev: remove callback checks from fast path")
> 
> Reported-by: Jiawen Wu <jiawenwu@trustnetic.com>
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
> ---

Tested-by: Jiawen Wu <jiawenwu@trustnetic.com>

