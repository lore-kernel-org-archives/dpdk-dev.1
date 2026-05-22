Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98CBACD5BAC
	for <dpdk-dev@archiver.kernel.org>; Fri, 22 May 2026 08:54:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 75E11402A2;
	Fri, 22 May 2026 10:54:19 +0200 (CEST)
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
 by mails.dpdk.org (Postfix) with ESMTP id 53FA94029F;
 Fri, 22 May 2026 10:54:15 +0200 (CEST)
X-QQ-mid: Yeas7t1779440049t911t23164
Received: from 0F57A7141CBF4D1588B97A6ED8A17143 (zaiyuwang@trustnetic.com
 [60.186.246.224])
X-QQ-SSF: 0000000000000000000000000000000
From: =?utf-8?b?WmFpeXUgV2FuZw==?= <zaiyuwang@trustnetic.com>
X-BIZMAIL-ID: 16804086809272452279
To: "'Stephen Hemminger'" <stephen@networkplumber.org>,
	<dev@dpdk.org>
Cc: <stable@dpdk.org>,
	"'Jiawen Wu'" <jiawenwu@trustnetic.com>
References: <20260522050032.1354427-1-stephen@networkplumber.org>
In-Reply-To: <20260522050032.1354427-1-stephen@networkplumber.org>
Subject: RE: [PATCH] net/txgbe: fix AML mailbox lock acquisition
Date: Fri, 22 May 2026 16:54:08 +0800
Message-ID: <00a001dce9c8$8d5d3860$a817a920$@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGkR9vCiSuBqHt6r20ak1wZhktSUraLAC7Q
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MQZ/dZQlO/THpl1rc6Bix1x9r4WCKlHMKLr24bu4DIOb8Bcs8E/u+qzP
 xbkQHfaIMTtdNiu40ExH+r/+kiJHoa4BUq2JT1u2EDq4+WBbLVyQdNEpwCb1P9CArt9h5Zx
 bbJMzqFIa7AYLi98VTLAEoSg0Kd23JUYnSPnKzOh328t8djZwQe0NSthHwOGxgEIIDKCtZV
 jhhxCJ9SG29IdBqABSkf8W15p+9sNotL0dvW0dbKloTcjn9n/QvmCHmQzDKNiR4SvIM1fmI
 arnUS4WdJU9sAOpqir/yMzcjDodEyFbepUZ2pu0sI2vGqHsYlXnAo2g+83k33xURqS+ytEO
 9SLNW83gpWo+6p0DfgB7sqeWpkTKaN7Zibs1xC8pC7Z/a4hZmbv7Dpkz0oM2L9Y3D68vZ7O
 GM7ZBNeVQTZZd3XsoPa876/VEw87vnE5fzkDKBT0e4Av3+tEInK0dWpNgf9AOH04qUSOdI/
 mqAnQgeFzZ6R5iu3ytQ2Y8ut4VuRo/zj2WljdYP7pqwDe4l0zdnQ2awVRHfOpUtXy/+/njj
 CWVvBuaMbKj/VpjR1vkWSkB23OzlpDnUfV81TYawCtTxcU09zRGiwrcNz9XJyWGprimPJrs
 RPqNQDyYogT7g5XoKHO9+CQ2qCsGlq0wdXaER6KFjVY182qe8kLG988NHJTZ+QaerPHl7mB
 ZGio34VjfVb897dqj2n+qi69l6t7K568OojsdxnwSAd0NY6M6+3Y4H0j7QXY5E4xBlEHoyk
 mITCWUofov8iQjzWEAD4NeRoxYk53iO4mnEJc96+vDOwZaVtTPuX7hY0ZAG9ceYTkeTjayT
 UGDJt78AFGMnxhWMhJZDqVzTcKWFDdMic1MDPoxviVHlHUcmzCMyOh2CWOxOLNN1ywf8FGt
 MylnJmfwfl7G0V0t0n2m858iPcc4rMstx2ubGywEMstZZbu+N0fMPu+XxE39bMxXZNkBEG6
 AAFq0NYWlZ/dOVLb6ZSenZffyZBKng0bLNMLk4eLgLlY/dlLzh5Y2PstGfJb4FEfGJd8FZk
 3AH6/jit7cyVf9fdxuNsRLwgKZV7TMdL2xM6YL6ha1UxTIkdFwlDDCeb4gPRQsjbXJjqgg7
 Wm2WWEkufAj+zB1rbRigu0=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
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
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Friday, May 22, 2026 1:01 PM
> To: dev@dpdk.org; dev@dpdk.org
> Cc: Stephen Hemminger <stephen@networkplumber.org>; stable@dpdk.org;
> Jiawen Wu <jiawenwu@trustnetic.com>; Zaiyu Wang
> <zaiyuwang@trustnetic.com>; Stephen Hemminger
> <stephen@networkplumber.org>; stable@dpdk.org; Jiawen Wu
> <jiawenwu@trustnetic.com>; Zaiyu Wang <zaiyuwang@trustnetic.com>
> Subject: [PATCH] net/txgbe: fix AML mailbox lock acquisition
> 
> The try-lock spin loop in txgbe_host_interface_command_aml() has the
condition
> inverted. rte_atomic32_test_and_set returns non-zero on successful
acquisition (0
> -> 1), zero when the lock was already held. Walk through the two cases:
> 
>   swfw_busy was 0 (free): test_and_set returns 1, sets to 1, loop
>   body runs and sleeps 1ms. Next iteration finds 1, returns 0, loop
>   exits. Lock held, after an unnecessary 1ms sleep.
> 
>   swfw_busy was 1 (busy): test_and_set returns 0, loop exits
>   immediately. The caller proceeds without holding the lock,
>   racing with the in-flight host interface command.
> 
> Invert the condition so the loop spins while the lock remains held and
exits only
> when acquisition succeeds, matching the intent of the surrounding timeout
> machinery.
> 
> Fixes: 6a139ade82e7 ("net/txgbe: add new SW-FW mailbox interface")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  drivers/net/txgbe/base/txgbe_mng.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/txgbe/base/txgbe_mng.c
> b/drivers/net/txgbe/base/txgbe_mng.c
> index a1974820b6..dcd8f58a68 100644
> --- a/drivers/net/txgbe/base/txgbe_mng.c
> +++ b/drivers/net/txgbe/base/txgbe_mng.c
> @@ -185,7 +185,7 @@ txgbe_host_interface_command_aml(struct txgbe_hw
> *hw, u32 *buffer,
>  	}
> 
>  	/* try to get lock */
> -	while (rte_atomic32_test_and_set(&hw->swfw_busy)) {
> +	while (rte_atomic32_test_and_set(&hw->swfw_busy) == 0) {
>  		timeout--;
>  		if (!timeout)
>  			return TXGBE_ERR_TIMEOUT;
> --
> 2.53.0

Thanks for the patch and the detailed analysis.

The fix is correct. This code was originally ported from our out-of-tree
Linux kernel driver, where it used a classic test_and_set_bit() that returns
the old bit value (0 on success). When adapting it for DPDK, we overlooked
that rte_atomic32_test_and_set() returns the opposite semantic.

Acked-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
 

