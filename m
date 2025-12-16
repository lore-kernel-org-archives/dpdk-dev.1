Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3206D5B161
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Dec 2025 06:12:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BEAB24026C;
	Tue, 16 Dec 2025 07:12:41 +0100 (CET)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
 by mails.dpdk.org (Postfix) with ESMTP id 2212A4025F
 for <dev@dpdk.org>; Tue, 16 Dec 2025 07:12:39 +0100 (CET)
X-QQ-mid: Yeas4t1765865551t173t45867
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com
 [115.206.160.202])
X-QQ-SSF: 0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 4054320336177348285
To: "'Stephen Hemminger'" <stephen@networkplumber.org>
Cc: <dev@dpdk.org>,
	<zaiyuwang@trustnetic.com>
References: <19590B42346A2673+20251121061951.466049-1-jiawenwu@trustnetic.com>
 <20251126133925.7cb06815@phoenix.local>
In-Reply-To: <20251126133925.7cb06815@phoenix.local>
Subject: RE: [PATCH] net/txgbe: remove the build dependency on security
Date: Tue, 16 Dec 2025 14:12:30 +0800
Message-ID: <002401dc6e52$f5bfbeb0$e13f3c10$@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQLlOmEE8lhguW28n63n1wB9qLoz1gLpm2lTsvrjqsA=
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: Ms7zrqvpzOE3PKNNC/AZ8O/0pdnIzxRLPHMEv/0xNienR9nWf50bd179
 +yzdCt9MgK+MRx6JRJA49x+2tR8mTCyv0weZOpGmH4haWVusk6ID249IYxejEsS553GXljI
 KhkkPQvo5cvUR+u8v0tkhlAtgVw5sDiMqaUIqhtpxv/A9tZ3rGHlAC4fNpSDFBoNHOyxlwC
 wP/vrItN4Ky/DyfuXj1ZUgKpOdacUI1l/sFnW80YZ9WKTgfs95vzO/Qokfz/N4wohNC1teW
 UNQ/k2caXmb2bGys7WEvRi4bNjQOTetthT19QDSk4t0zGvmShod0ScV/J3Xt/A7sQiiscKf
 PVX96lcmPzl5mhybbQTHEYdqoqO1h1KZ0VS29V+YEeFw6XsSGCVo0VRUwak42FgdW85xOJV
 G53Hy0uVLWd79O+BA5geedXQaIf/1rOry1hVvvx8oBwOmqlMw+W/BxWF1bQxrCDxnGLV12w
 PL4a1M8YAzFgNQADFYS0aAb9QEQYxCyqkWvX822UDal6c9xGmGIPDbBjKWOzaqGZSlNoaob
 YVYT0uuitaL9Da3QfX3ANR6j30veHvoBIf7hPL1R/qUlplyvJTzPRebk4MlQUcdnWKpW9F5
 eK/cxPubw3JWLxFwa+/jnWPA3DNKDBh6UWdtNGbJbIOzGENEW2qK1Id38gXwmcPxdjvVBKl
 ZWnLUf/cZwTBbzVuBU/zj/k3xn69jQlIaWRXNax9IS5n68D8BKl20l+XghQsTXpxPIOnI3A
 YNEEwdFcDqs7et6mS4l7ppQKyWFLoh7rhvcq8aZVK0pFjlSN6Ntc/M/yuIh4cpNXx19m7Hj
 I+mESDCvW6XS4Yoi+oGufKzP4DTPntvqbc3C1oNvBpl4c0gbA2G+7N63fzwEnQI0KdEbt9V
 5kzp0k17/prUMA870oQ6lG7z8VXBkkha7AhnEcDhm4c3gGsg1pV4PhJXbUlfZLWFkf5xSvY
 Ju0pXe1njUqHxIMfN+M/qfUmkyT/o0XKLXjvcaOeJ9OMYCjE/0RGI0Hx1zHOafu65i0Ys5V
 tmTEHWLz/3aXP6SnT2
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
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

On Thu, Nov 27, 2025 5:39 AM, Stephen Hemminger wrote:
> On Fri, 21 Nov 2025 14:19:51 +0800
> Jiawen Wu <jiawenwu@trustnetic.com> wrote:
> 
> > Now lib security is enabled by default, and cannot be disabled if the
> > driver is intended to be used. But there are some functional scenarios
> > where lib security should be disabled, just like to enale Tx descriptor
> > hardware check. See commit 0eabdfcd4af4 ("net/txgbe: enable Tx
> > descriptor error interrupt").
> >
> > So remove the build dependency on lib security for the driver.
> >
> > Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> 
> I would like a review by other maintainers.
> Several other drivers including cn10k, cn20k, ixgbe already have
> similar dependencies. Can't the security library just have stubs
> to always return NULL if not used.

Hi Stephen,

What should we do next for this patch?

