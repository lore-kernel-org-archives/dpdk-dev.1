Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 330B1CC6B1D
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 01:39:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DA1A1402C4;
	Wed, 14 Oct 2026 03:39:49 +0200 (CEST)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
 by mails.dpdk.org (Postfix) with ESMTP id 908F940279
 for <dev@dpdk.org>; Wed, 14 Oct 2026 03:39:46 +0200 (CEST)
X-QQ-mid: tivesync9t1791941977t8d2174c3
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com
 [115.198.217.6])
X-QQ-SSF: 0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 2891596141760781958
To: "'Zhang Tengfei'" <zhtfdev@gmail.com>,
	<dev@dpdk.org>
Cc: <stephen@networkplumber.org>,
	<zaiyuwang@trustnetic.com>
References: <cover.1791898970.git.zhtfdev@gmail.com>
In-Reply-To: <cover.1791898970.git.zhtfdev@gmail.com>
Subject: RE: [PATCH 0/3] net/txgbe: fix FDIR Rx packet buffer handling
Date: Wed, 14 Oct 2026 09:39:36 +0800
Message-ID: <017d01dd5b7c$dedc3a30$9c94ae90$@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIhEhBpsi5gR8a3B/C44cPCswcvpLZ00+xA
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: tivesync:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NHu6THI/J1zcXqndyoJK9l3ArvhQ1NNuBMwORrgY+E5CjnIGlLwmluT4
 bsfEVRNDmb98wNgQ9PuW73twxoMaU/ydavm9nvq6rFHaAg3A0dFyB0G4XJ5r+vOnT1/WpeW
 3OvO2hFRzRsvUGZr3fw5Xs7sTzPYTPL9QY7cBOhlKyxf5ZhWyl+Tnrcnnq1m68YD+gyHVTQ
 bYHWglfm8SW4VEXVx3yRc6o6y/YhaF4hPLOGxpnzIux8hwKsT0nQ2xTWMaIpZUPyUmYOkUk
 U+/aR+4mFu67Y6EoeCQv8RK/AabMcyJ7dOMjlo0aX/BzhXqWC0c1XGPQW/SgWE5+1+FAdvc
 mU7tH02Mb1KfhVIUpTcWEUJauwKdpfX39PpD5Y+BVMcTpequYBpRl5VXaQ+ZgC3FtkVZYPP
 TK6d+co01c8pOIyweAQ5NDfMGcjnrvxhg6g0MC1IeCvgbDBsQ25nqQAOsrG27wtrKNeY7LI
 tBcn8V5tZMUrzPbsentKgUOqJsKaxnA3iYqNXVN/BpueVLijTSp+HvS/U5alEMsqDydt9qI
 Svt4LJ337tbnMzKhtRNo2Tjbw0I0oAckNoYZYp0ocem1hHHeAeOmf64XBX5NABwfDMkF+Pk
 ttulZIQV95eF2GLV/NvhziOyFR71nFlPCOAXiA2+Pj25gnGTZi9rqzA2i82ZAONjxIxRWXX
 0Rn6UdCMgFQoXuFgE1sdbc5LfNtV25CCN3N56IBiNbJkgW1heDJA8QgNuEiGRKYkBix0Pff
 +XvgLwVTrS5I6F9LRX546wQDng3mJnl8XTln2/vkoL84NxTev7TY/9g06IxI02qPORnDAjF
 qpE79PToF5ycS/U2TtMel4rVVIfhoUusLEdTOXj2hQ0pO/kke/+nmNCF3lAL22oq2m3dD1R
 Q1YgdxJnbw1btzHBHu0qswZomCMqjop4txYGDQMs8QlDwc/tFIndI+9fJ9BZLjTrHZ46O1g
 c5mKtD7weDUapx0eoDNKJFsZ+8guI/7ur3UDYOL+unMjWjrTBXidBh2z3P25Z5qqtyrfKmt
 iUB8/vrMuoQNRkN6v7eJlERi/U2iEJZ8Z1cuBD4xh96iRh85M955H9iXOkF5NC3Y6v4Ndce
 A==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
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



> -----Original Message-----
> From: Zhang Tengfei <zhtfdev@gmail.com>
> Sent: Tuesday, October 13, 2026 10:00 PM
> To: dev@dpdk.org; dev@dpdk.org
> Cc: stephen@networkplumber.org; Zhang Tengfei <zhtfdev@gmail.com>; jiawenwu@trustnetic.com; zaiyuwang@trustnetic.com;
> stephen@networkplumber.org; Zhang Tengfei <zhtfdev@gmail.com>; jiawenwu@trustnetic.com; zaiyuwang@trustnetic.com
> Subject: [PATCH 0/3] net/txgbe: fix FDIR Rx packet buffer handling
> 
> Enabling Flow Director reduces the Rx packet buffer 0 to reserve memory
> for the filter table, but the size was computed from the current
> register value and never restored when FDIR was no longer used. Since
> the FDIR mode is reset when the last rule is removed, on flush, or when
> enabling FDIR fails, the next rule enabled FDIR again and shrank the
> buffer once more, until it underflowed. Validating a rule also enabled
> FDIR.
> 
> Patch 1 computes the buffer size from the default packet buffer size,
> which alone stops the repeated reduction.
> Patch 2 stops enabling FDIR from flow validate and rolls back the mode
> when the first rule fails.
> Patch 3 disables FDIR and restores the buffer when no rule is left.
> 
> The same issue was fixed in ixgbe:
> <https://patches.dpdk.org/project/dpdk/patch/20260927042545.45152-1-zhtfdev@gmail.com>
> 
> Compile tested only.

It should to be tested with the actual NICs.

> 
> Zhang Tengfei (3):
>   net/txgbe: fix Rx packet buffer size with flow director
>   net/txgbe: do not enable flow director on flow validate
>   net/txgbe: disable flow director when no rule is left
> 
>  drivers/net/txgbe/txgbe_ethdev.h |  1 +
>  drivers/net/txgbe/txgbe_fdir.c   | 36 +++++++++++++++----
>  drivers/net/txgbe/txgbe_flow.c   | 60 +++++++++++++++++---------------
>  3 files changed, 62 insertions(+), 35 deletions(-)
> 
> --
> 2.53.0
> 
> 

