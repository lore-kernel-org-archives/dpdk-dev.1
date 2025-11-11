Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D6D6CCF9E3
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Nov 2025 01:46:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 481CA4026D;
	Tue, 11 Nov 2025 02:46:47 +0100 (CET)
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
 by mails.dpdk.org (Postfix) with ESMTP id 153B64026A;
 Tue, 11 Nov 2025 02:46:43 +0100 (CET)
X-QQ-mid: Yeas2t1762825596t125t60520
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com
 [125.120.180.10])
X-QQ-SSF: 0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 3021561705392514155
To: "'Thomas Monjalon'" <thomas@monjalon.net>
Cc: <dev@dpdk.org>, <stable@dpdk.org>, <zaiyuwang@trustnetic.com>,
 "'Stephen Hemminger'" <stephen@networkplumber.org>, <dev@dpdk.org>,
 <stable@dpdk.org>, <zaiyuwang@trustnetic.com>,
 "'Stephen Hemminger'" <stephen@networkplumber.org>
References: <20251027031542.10512-1-jiawenwu@trustnetic.com>
 <20251027031542.10512-9-jiawenwu@trustnetic.com> <4063720.8FI41Ny9JD@thomas>
In-Reply-To: <4063720.8FI41Ny9JD@thomas>
Subject: RE: [PATCH 08/19] net/txgbe: add device arguments for FDIR
Date: Tue, 11 Nov 2025 09:46:35 +0800
Message-ID: <006b01dc52ad$033b4cb0$09b1e610$@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLtdPOLvvCVkFWK70Jhe0nQEI34bgF4CjiAAx2CgpWypcOMAA==
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MJHgWiC2fbPUftaooxFDuWUvKOZNmRBmxEtQyBIgTaNZE/fx4qThEF6a
 0S7rR0pige/SR3+Y1/lAjzdSpDfpJri0/lWyZjCujYpdby1oS2rzjXGRjXKmwfa/8zC/tfV
 ug6piBqiaIv0Ofi1UaVQk4sFqkfY3mIbSz6h+0EV0JvPKVAjkKnL3/J/ss5vnqJVlyJF/Hh
 /Y/fnJpuxckZ+DY49acVczEpDl7++ZAdJ9t/LgwH/9edfuYjz5nTRZREBmtmUmcyG/7mY2V
 TgzRK4UwNXKqqQF2PveMS/yk6h/Acq9H1GMamEm8N8peJm1LN2JH9MuNNFV8vJwHfgRQYsc
 nrw9caKGgA34OKNHnyA7g+NMjXh4qFFwF4sWcOB1nE+JT7O0NatQMkemsCCoooZ2iTlqooL
 vB4zjwvTuRXD0ouSfxkh9IXU4gdkAhTAAQIzMUPeCMNxk4XFjIho3TjnGC4FXZZTh807f7q
 LeylwOIY3jsYHHqq2F4+ttngZiB34i6+3CAYgzwivTekaS79mblzopY5h3IeUhti2LsT/7s
 RPJZtedn3uDf4Z8HAUsQJQu6wNn7AITykoxtkthGNOJ8ywonNffbvNPiRLMx2ZS0LcyqFcK
 Usp4dFqIm1V0uOZYfYbkSJc1efudIlMOcjahNinjjIeMlBIrn4Ux4o9QL84j0oKYBMvWNvv
 75Xq3O9fzremDIXFQe8K21G3HIS4XVZKcK2e7av0eAIp+GgUTb2pNTcAV2XLedFnBdDtNle
 UXY8uiudI/jRD9ayZeS0rn7audFg6Ri+WE9eTq/lTyTXd89JT6JhFP2Xqdo4jiQrb8fx46D
 t7hoZkTkAv7TooFySwZSzEXSqKd6dtMtL505QCZ1gUg8dK06j7zVlk+qOt0z6DE9JBQqo8i
 LZicbPThoOavfcmojzYKpOMKjKJfcVFFfWEjFMU+Au8RMs9IGz2cYJjFvsxgxKzFzLp0Dv4
 eAy2SNRsHK8bW9/0eijtf7V4c4L9uRmqyqQMDUU7lLUW1K4P3PKUKey45b8gXurP2JrzkTf
 gXba6Pu+KWSGHbZ/df
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
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
> From: Thomas Monjalon <thomas@monjalon.net>
> Sent: Monday, November 10, 2025 5:29 PM
> To: Jiawen Wu <jiawenwu@trustnetic.com>; Jiawen Wu <jiawenwu@trustnetic.com>
> Cc: dev@dpdk.org; stable@dpdk.org; zaiyuwang@trustnetic.com; Stephen Hemminger <stephen@networkplumber.org>;
> dev@dpdk.org; stable@dpdk.org; zaiyuwang@trustnetic.com; Stephen Hemminger <stephen@networkplumber.org>
> Subject: Re: [PATCH 08/19] net/txgbe: add device arguments for FDIR
> 
> 27/10/2025 04:15, Jiawen Wu:
> > Since FDIR configuration is deprecated in generic ethdev device
> > configuration and move it into the device private data, there is no way
> > to configure the FDIR parameters.
> >
> > Two device arguments "pkt-filter-size" and "pkt-filter-drop-queue" are
> > added, they just continue to use the previous naming convention.
> >
> > Fixes: 5007ac13189d ("ethdev: remove deprecated Flow Director configuration")
> > Cc: stable@dpdk.org
> > Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> > ---
> >  drivers/net/txgbe/base/txgbe_type.h |  4 ++++
> >  drivers/net/txgbe/txgbe_ethdev.c    | 20 ++++++++++++++++++--
> >  2 files changed, 22 insertions(+), 2 deletions(-)
> 
> You forgot to update the documentation.

I'll add it in v2 set, thanks.

