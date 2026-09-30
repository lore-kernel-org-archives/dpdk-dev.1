Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C86B4CA5FB1
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 10:22:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 21A4142D0C;
	Wed, 30 Sep 2026 12:22:54 +0200 (CEST)
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
 by mails.dpdk.org (Postfix) with ESMTP id BD162427CC
 for <dev@dpdk.org>; Wed, 30 Sep 2026 12:22:51 +0200 (CEST)
X-QQ-mid: tivesync9t1790763765tf06a27e2
Received: from 0F57A7141CBF4D1588B97A6ED8A17143 (zaiyuwang@trustnetic.com
 [60.186.241.247])
X-QQ-SSF: 0000000000000000000000000000000
From: =?utf-8?b?WmFpeXUgV2FuZw==?= <zaiyuwang@trustnetic.com>
X-BIZMAIL-ID: 9404305737478352008
To: "'Stephen Hemminger'" <stephen@networkplumber.org>
Cc: <dev@dpdk.org>,
	<dev@dpdk.org>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>	<EEDC8610526E7CAD+20260929130611.4871-1-zaiyuwang@trustnetic.com>
 <20260929090556.7878a2d0@phoenix.local>
In-Reply-To: <20260929090556.7878a2d0@phoenix.local>
Subject: RE: [PATCH v6 00/15] Wangxun fixes and new features
Date: Wed, 30 Sep 2026 18:22:44 +0800
Message-ID: <000c01dd50c5$a1d31e90$e5795bb0$@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJQoSGLe6Ko7JYK43S1iCPo4FlmCQE2bRDCAkerAzq15Fe4YA==
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: tivesync:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MmGZZGFxOFhUstXtveDBRYuhm8u6BC0ZA/Eq7Z1u4Klrc8l5exsaAT1M
 ylwbkKCcxWsvL3tdLRvROeYxCKyJ4yFNcINmub8fJ9iUOqqJG0k4j+iIWwaKAW5BrI0yczR
 T9woVRUvcmP2F6nKtHDVHyZUNzC3jWXx4s58kfsyM0g3F+WoD71A4QjwHB/qqtGh3ytOAzd
 Wpz9svpqvHd5wH0d/G6PwLg34tx1B/dgou9TIXwMTjENurigGdo48/mxE9jqlOOcV/bEJlL
 ZDOr5LsMN3GzCn1q0Nmzd+90Ilu2Lzh1G0F8CM0Kr4hP55nh/7glFMxIKB8UImA4YGIbGm6
 nl1HBABIf47OqD2xz4T0t8PDf3gQhsgoF3AuhkEe6nbgLqKcrWwkOzVIcBX+oWLudxUEGkJ
 k8WeJw4UjdKi9hkKC4zLJV/254vuOEUo7NnMXn8DK8Hkw3r8a/Ay6pOStByAUVAWrgQhLh8
 AGGAT3XaKQlFaYwMiwYnatC/OVwI9OBC48TEZleqS0iCie3bDNo1LjO1gd8TZyFkqMIHMBR
 pfhGaBggvIYByJhxq70q9/1unZJjbK9mngR7H9J8LS7VfahAak5uq2Re0/OVlN3THrG7TNf
 kuZoU1yL/PevgtM7/5I2un4ydWXwEDwzLxnXCO9BwuHUH+W7YmrRlifqD5uT6+aPenm3AWL
 3k1F6NJXZ1mCKdtY/3oDDDS2NPWf9PPaI0E+3WQhX1WZy/1m3o4M06uMXtQIUN/92pNdtV5
 P4I/G7L/qX5oa3BwgJd4zQzTDllAe5M/5jU0MT9oprh2x8nv64D19NdVRQu1gYjh5QkR/TX
 wPOlkHmkBdhHSYyuCn/Eq3Ozxpj9OChrX9iaaHa5EubAm1b2jxj3uZpWAI8wWDKH/qiNVpD
 RUqKZCJ/ZtAkUzCcaCaLlSOCw4cuDrzjsrVrWlmpjSSXZ6mOflzwdyYWDDNYo6j1Towq0rX
 WYtCpZx/HHgpt/sPjNNRHmSnoyILgkUtBKBrQR5nJyV4z7VR/9b3Zvy8LQEzcOK5u8H2Px0
 aN5lkzgd1ycNP1XzPYUBPsuTz5XHl11nqQRU6Fc4DsWB4+tQbFYSjZHG2LTRoWy6S0D2ygf
 CN0GNNfyX9ChS7Gs7nCX3JSx/fG2patuJtpLwZ8Nq5mCqtG1SLQeeeCumfq+QHWVB091vDd
 anZzoohfRpaRwoc=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
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

> Looks OK to me, AI did find a couple typos that you should fix:
> 
> 
> Reviewed the whole v6 series applied on top of main.  All 15 patches apply cleanly, net/txgbe builds with no new warnings, and I
found no
> correctness bugs.  Three Info-level nits below, all in 14/15.
> 

 
> One design point worth a second opinion rather than a fix: in 10/15,
> txgbe_dev_detect_sfp() re-arms itself at the "rearm:" label, which the two sfp_an_alarm_enabled == 0 early returns deliberately
skip.  That is
> how the poll stops on dev_stop, and it is correct, but it does make that gate the only thing terminating the 2-second poll that
40G hot-plug
> detection now depends on.
>

Hi Stephen,

Thank you for the review.

I have fixed the issues you mentioned and sent v7.

I also confirmed the design of the AML40 module poll. The persistent
2-second poll is intentional for AML40 non-backplane ports. These
devices may not deliver module insertion or removal GPIO events, so
polling must continue whether a module is absent, present, or already
identified. Therefore the poll is intended to run for the lifetime of
a started port and to stop only when the port is stopped.

Best regards,
Zaiyu
 

