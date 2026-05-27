Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03140CD4F54
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 May 2026 11:07:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6DD7040663;
	Wed, 27 May 2026 13:07:18 +0200 (CEST)
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
 by mails.dpdk.org (Postfix) with ESMTP id 11BFC4026C
 for <dev@dpdk.org>; Wed, 27 May 2026 13:07:16 +0200 (CEST)
X-QQ-mid: Yeas10t1779880032t408t25950
Received: from 0F57A7141CBF4D1588B97A6ED8A17143 (zaiyuwang@trustnetic.com
 [122.231.28.113])
X-QQ-SSF: 0000000000000000000000000000000
From: =?utf-8?b?WmFpeXUgV2FuZw==?= <zaiyuwang@trustnetic.com>
X-BIZMAIL-ID: 3704356600210941654
To: "'Stephen Hemminger'" <stephen@networkplumber.org>
Cc: <dev@dpdk.org>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>	<20260511103604.19724-1-zaiyuwang@trustnetic.com>	<20260511103604.19724-6-zaiyuwang@trustnetic.com>
 <20260517164018.7a58c68c@phoenix.local>
In-Reply-To: <20260517164018.7a58c68c@phoenix.local>
Subject: RE: [PATCH v4 05/20] net/txgbe: fix inaccuracy in Tx rate limiting
Date: Wed, 27 May 2026 19:07:10 +0800
Message-ID: <00bc01dcedc8$f772f2e0$e658d8a0$@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIzGrJ934oa1ka+Tuv/tXGR6pozcwG6Z/2aAtJCOOEB6kodCbU4A8pQ
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NNF5uPB+5DRWnyv+l3KWpulfH7g3YwaAr9P5XB+nLWrNcpaATixTwNmx
 tzb0fAiZ6LZ+J/TpfGKLBImYMMaMDySsSVsSYWnrtf08wDt/sr8GMwSyKPNZ+vyIyGo6kp9
 p/ygIjnU4UuosQJJoR6U9Mcp5qROK8ztMFigfNET80Ap0zX8WEq9G5HEGyBnzsfv2OAm4rK
 rcILE03zCiYlAQam1emiFQUb3+riV6QAl7nIdX86WSeBeuwb1z5n044IMz8uDxhIbgI1zum
 FxLoWzshEaZ58jIHhewgpZOVr07/g2K7QnKnpF0QZf5OKwaINVBqfD81rZSQtm248TBiYT6
 W8PG7OlBJfj8dzYM0pQnFCiKEL7hBQ1t9z7aMrZwYuAUvuQCbezp0zvF25+Vv2fUty1FDej
 3sjsHePkv/PKOvlDhiReqhsnswQdxEzEexthbPuvEVvKfngBmWx7l++ce44NkHjOiLWD2sa
 kw1mBcQ/eKgAM/gdrU32+MophVNX/frWWmzpLIwW1mCvlZ0V3X+CSeAsRnYZcQyD2ndGRGj
 7GyS/OfscWw/JqsfKoj/ITwJNO+IPcQoOSms5Kamrc8RVDAk5VavGmlNanNG0EFv0cIfTqE
 Q5TGdYMHrDS5FCWSTE5111Fx/eTJPZgu/4uyCq8GvNXFJd5spmXH8k9Lz1kJFc/wRyxdqc6
 FPfBv8LeQZ7Gv8+A/0lKnzWLeO+GCQ6SvVHT/nAv+IEp79Zi6pUNmnVYw9jIItSOOMTIMwe
 y61yTvxJOh4k0Fan04WRuDGoRtCP8/f5iIkQzCfcI+mjIx+aph6GUNNUpXCRghiUOUmR2oc
 NBm0jAWm2HWAEtObfCcFJ8am1/WZiigHsamQitRQQ5gTvBPmmLnoE/Oo38+5UcquF4Ga2fM
 PwO+S9ji7M2Gxktp73Kjc1lnMZLpn3hNfAzA24UnyQsTUh810dowqQc1drMR9mnOdG4I27L
 Ow4WFTZTxNHwNncdCjZhivwDvyC9O6hdYGj+KWwNxyJ4x5nNtRz5u9ax45bZvN/o5TXMzoq
 XdogoueNP2txgQJfIxTV1NldVh5QeWwkqKBQ0XMfyPHKXhBsxmHELhclnT3Tzp8xADlt0U3
 AWZLXNjfu4f
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
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

> AI feedback on this one. Looks ok as is but worth looking at.
Thank you for the review. Based on the feedback, I have made the following adjustments:
> # DPDK Patch Review: net/txgbe: fix inaccuracy in Tx rate limiting
> ### **Errors**
> 
> None found.
> 
> ### **Warnings**
> 
> **1. TDM_RL_ADJ write placement causes per-queue reconfiguration**
No code change
`txgbe_set_queue_rate_limit()` is directly exposed as the
`eth_dev_ops.set_queue_rate_limit`  to upper-layer applications. We cannot expect
applications to perform any additional setup before calling this interface, so the driver
must reconfig.
Writing the same value to this register multiple times is harmless. Therefore I prefer to
keep the current approach.

> **2. Magic number 21 lacks explanation**
> 
> The value 21 is documented in the commit message but not in the code. Future
> maintainers will not see the breakdown (7B preamble + 1B SFD + 1B EFD + 12B
> IPG).
> 
> **Suggested fix:** Add a comment or define:
> 
> ```c
> /* Ethernet framing overhead: 7B preamble + 1B SFD + 1B EFD + 12B IPG */
> #define TXGBE_TDM_RL_ADJ_OVERHEAD  21 wr32(hw, TXGBE_TDM_RL_ADJ,
> TXGBE_TDM_RL_ADJ_OVERHEAD); ```
> 
I have added a macro `TXGBE_FRAME_OVERHEAD`.

> **3. Missing release notes update**
> 
> This is a fix that changes hardware behavior and improves accuracy. Users may
> observe different TX rates after upgrading. The change should be documented in
> release notes to inform users of the accuracy improvement.
> 
> **Suggested fix:** Add an entry to `doc/guides/rel_notes/release_26_11.rst` (or
> current release):
> 
> ```rst
> * **net/txgbe: Improved TX rate limiting accuracy for Amber-lite NIC.**
> 
>   Fixed TX rate limiting accuracy for 64-byte packets from ~20% deviation
>   to within ~5% by correcting hardware framing overhead configuration.
> ```
> 
> ### **Info**
> 
> **1. Consider validating tx_rate is non-zero**
> 
> The code computes `factor_int = link_speed / tx_rate`. If `tx_rate` is somehow zero
> (due to caller error or invalid input), this would cause division by zero. The existing
> code may have validation elsewhere, but defensive programming would check
> this.
> 
> ```c
> if (tx_rate == 0) {
>     PMD_DRV_LOG(ERR, "TX rate cannot be zero");
>     return -EINVAL;
> }
> ```
No code change
In this function, `tx_rate == 0` is a valid input meaning "remove rate limiting and
restore unlimited mode". No additional check is needed.> 
> **2. Variable scope: factor_fra could be declared at initialization**
> 
> The variable `factor_fra` is declared but not initialized, then assigned in both
> branches of the conditional. C99 style would allow:
> 
> ```c
> u32 factor_fra = (frac * 16384) / 10000; if (factor_fra >= 8192)
>     factor_fra = 0;
> ```
> 
> This is stylistic only; the existing code is correct.
> 
No code change
Just leave it as is.

