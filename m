Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 396ABC87FD3
	for <dpdk-dev@archiver.kernel.org>; Mon,  4 Aug 2025 07:23:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 68BFB4025D;
	Mon,  4 Aug 2025 09:23:24 +0200 (CEST)
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
 by mails.dpdk.org (Postfix) with ESMTP id D6F65400D5
 for <dev@dpdk.org>; Mon,  4 Aug 2025 09:23:20 +0200 (CEST)
X-QQ-mid: Yeas4t1754292195t569t34003
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com
 [60.177.96.13])
X-QQ-SSF: 0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 2133954141398947551
To: "'Zaiyu Wang'" <zaiyuwang@trustnetic.com>,
	<dev@dpdk.org>
References: <20250418094131.24136-1-zaiyuwang@trustnetic.com>
 <20250626080221.22488-1-zaiyuwang@trustnetic.com>
 <20250626080221.22488-15-zaiyuwang@trustnetic.com>
In-Reply-To: <20250626080221.22488-15-zaiyuwang@trustnetic.com>
Subject: RE: [PATCH v3 14/15] net/txgbe: add other hardware-related changes
Date: Mon, 4 Aug 2025 15:23:14 +0800
Message-ID: <073801dc0510$a44a9880$ecdfc980$@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQKiC98C7jrCga9wsmi8xZSIVafTeAMcNZ41ArLGEs2yl5EtQA==
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NLbMVdkrQWBM9t3MRjO7hB443YG0mQsmE/CwJ0pxk9bCKpx4iE/7qgRp
 qv7+JXf6S2EDkmQ9mQNYEHWfZ9VAKNLQ6twT998xmiEgewOHeKLKc2drD1Y2od/N7LaPEc1
 WyYK+UP/StHWQKquZGx2LWXnAX22QA/V1arb2TNyrIr0I8Y07r5NUcXv+BBkF0uAKI4JQCX
 efFRDttfNdnm5Ns+ceZJJZycSEeFXrD1hMhCMKofQQkRXwFKuIauqivP0ODFy8q/6tCzSoB
 qnnrFQGbOp+2gSOnhVAw24UURN0LwzK6Gu1r/CaMDUeAZKT47urYlR4nvR6sBDK71jhOvCa
 FZmihfk3zilnHs6cl/zOHHARhkURl3EQC3EQVvJpjA/mvz1BVnYAewFa0tacuHPjVvC49dE
 g8EjrLTOnPz11v7E93VNmddEPuIIWNc59YNoG5x6R7Nm78nfAXNO3brzqY+STYucL45f4am
 hAsvNC43YBtJAFojoqhWvGLPqnFbzPhjpQHLf/uVwdlhaZq8a50SxDPneK+LfUGBN03syMP
 VPfFc04ttzMHw06Iq21OO9ISpkVqnYxVYMXIYFX25uhES+17j7y8qWzIiiuQy3CRPtjp8m0
 ro7QWyJiW9++LHDPIPFEfI9vtTs8VepdQoYRYQPnk25a6p66hmKN22IjFN/BZMimGuDavAg
 pQb9+Ajkefwj2I2jhLP1hA7zXBI6JvAxiAgdlR8STh55nQLQkxeR50RfW1bCpzdxYqXKcSd
 yOnMarjDwjT/8FiE0X1OMEHfQvkR+ZB94FGA/ElWH1vXq3DLP60lkWcJWcKnBlLGvZxCGV7
 Kwzow+6tiNKvHYpQAGXPQEydaAsi+kx6g4Hz7EiKwl8Mam80xPfhWEhYjF0t0Z7QFHFn4Jj
 CBQ5IaC6r5ygDUj6zHGoykE3wnrgN5zXywEviHM6ahN1Z1zY04haKgFePVMrcdNGQ1VMypV
 /OjG5cw7lHulbyCodG6odoj040AB0nvxFh7AClUcDuMCB1s0I84XkHJhhdhn3K/a+2ufOTt
 IMw2UQVN35RLwwxzL4ektUsEKiPFos8SM8n14u/24CyofG2D3dZ81N14XTE8c=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
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

> Subject: [PATCH v3 14/15] net/txgbe: add other hardware-related changes
> 
> Add other hardware-related changes for Amber-Lite NICs, such as PF
> queue rate limit, enable/disable tx laser.

Split patches for different features.
 


