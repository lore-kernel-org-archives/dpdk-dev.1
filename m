Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E2B0C43458
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Jul 2026 14:45:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 21E5440150;
	Fri, 10 Jul 2026 16:45:44 +0200 (CEST)
Received: from fhigh-b3-smtp.messagingengine.com
 (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
 by mails.dpdk.org (Postfix) with ESMTP id 9D0F6400D5;
 Fri, 10 Jul 2026 16:45:42 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.stl.internal (Postfix) with ESMTP id DEAB47A010C;
 Fri, 10 Jul 2026 10:45:41 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Fri, 10 Jul 2026 10:45:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1783694741;
 x=1783781141; bh=3NkmTeSYiMVpQI22WTA+5UxKAiK8FXhHueZdcQWPTog=; b=
 Q+9lDweq85UajdZ75EgK1rdotj38RY8jnkvmA2P673qY3EyYNs8usJop5pUIS0oa
 Rhh9isxxDgWvSAVsYM0Zy/RXwp9C6uY/MzxkgS+Oe2ppov7FwXu3XPQcSrze+vZA
 dQoeZIq/YS+iDHinRZVVBk3tsGoTPwwqgC860xWNUoKhxVYn+DvGeFUBVR/jkBpQ
 uidtNH4nWwmbCmSbhmkIpasTkSutrvTPTYHgdgKXPaaOSY9wEEfsBiRzVaGrjLPh
 NbT6TcAajggHsCpM6YB12d1e8+y0CeLsbs2UtJQppAyfYk4TFWY3/YHl15zKkxFH
 wlmZ03dyYO9G+3ty1ZR10g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783694741; x=
 1783781141; bh=3NkmTeSYiMVpQI22WTA+5UxKAiK8FXhHueZdcQWPTog=; b=R
 SJATWuK/kbGCnE1W7qx8A3m5VhhZd3ISkoi1dHBgGPiPhMAuKZDpghAlsgkj/ox+
 RoRDa+DRIBe2/fjQrYxMoKa9eGi5nIORc8+B0cmc2i/8W5tW7IDpCX86DN1WKO83
 sq8MdfPiIXFv5HVHenPE93W8YOhvYt00faawGClwfkLq7YipYX5rHaisvn1wLOTQ
 DDVIZDj9g8I7uV/3Oi4o9HTi0il2qL2Ci6IvOkVxviM4A+EHCaRiVuWMNybzzxaK
 RyuhCNnO1igKNiPcYrnruCWWuB9cPzZ31FLPtTVueiVWivrj+RzOwwiLDl4bHIN5
 erEiCt0/aycIKNMGSxJiA==
X-ME-Sender: <xms:lQVRatBWPmBOl2zqqthd1JLx3Wk4Itf7iZkOeRMxAD-8tanG0FHXLg>
 <xme:lQVRamf1efOMGdMm7TefK4haH1G7FhVdebGrCEy-vMcANjjw-h4pZiAeQFImV5tyk
 ojpvN5uV_T8sLb1oUJzFZUPZxNtxdVruYcA6V_ga2-2D2IgT41vFCE>
X-ME-Received: <xmr:lQVRanl9ZNi7yFd-dxAIRquYQiA0XaZk_734Ml9sX2yfpPL8jgJnOBWdA1J-_2QX_gN1O-VTRYu4vxQc3vQcsRp8pA>
X-ME-Proxy-Cause: dmFkZTE5zhrpww4QHn7+aNgdDmmTouvv+aD2gtZsG02hwwhZ0IiWLqD0sFTUUeByhrUdcu
 tnYEgtYBzZET/5Twes+wd0idgCUX7nhUvZkaixTHL8nXFWfkzmnHFYuHYuZl512uVPIYDA
 +wJ7g91dOEKw+Hjvlk16syqDXeCxW/a0KmDXATH62Lk5Xyk/dJR7O5WlrUOFcsuZjUyQ+m
 ex3puzdPmn3/L/P1dEbQbnd7eUoeWxti0R5Dd4HJNJLmXtjTKiUHwTHfHNUHC6PXL99nBJ
 +CCdCBdgkkm+QmK9qEbLJxRuBjKXRN11aJMqvhBjYJN1Zdab7whZBY+9BJjXNbQnYKi6O9
 AclIrS6KftUoxbheYtq93vdFMw3VchgFH7/SSGbZmwhE5feLB1dfhgEZUaR5E3YepqH6fv
 EN41uumXG/Cke+hQcOjFvr50y50/s5IlsNC/N5fd6DLUT0nrez5Uw4Sn9W9LaubKmdZfoE
 kQmx5WMY3KLzcJw3hXW2iQQ+qV0Z+NzT6+lHt/ZeyeDA/xZIEWW8+I2XuE9Wgd3gaqTR+c
 QXC7vrdsOUxPftR171zFr0doCVxFhY2WndCYYir0SOzZAU8R0uobHc4aBpiEHWEdHAdYcJ
 ucdKfEM2ibocBdlXN8v5eZIdJAykGm2snVTv6/qFWjZV6+80hTmo0I6Ma9BA
X-ME-Proxy: <xmx:lQVRatEm3gNzXyeW2k_a7rakWSxy8y3K1-j_nOJo3khj_MBy5j_fgg>
 <xmx:lQVRav4oZi7XFLx_8EQ3p2ln3swpyZQey2Q-s6QbRZcYpTwpIuQIcQ>
 <xmx:lQVRalkWKyc8h3-NyWIPNIDl02zLbruYcy_mr6oddt3pc-cE_79BDQ>
 <xmx:lQVRakpOLXNH7xjZkEiywcyaR8TzuEmudKvPcb0i3Urvgpl4BuI-Kg>
 <xmx:lQVRau47XqNnjX26dafRjujuX6Ku4qEPU9QejZz-ID5hEwo3f_GmxfCs>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jul 2026 10:45:40 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Jeroen de Borst <jeroendb@google.com>,
 Joshua Washington <joshwash@google.com>,
 Jasper Tran O'Leary <jtranoleary@google.com>
Cc: Junfeng Guo <junfengg@nvidia.com>, Xiaoyun Li <xiaoyun.li@intel.com>,
 stable@dpdk.org, dev@dpdk.org
Subject: Re: [PATCH v4 2/9] net/gve: delay adding mbuf head to software ring
Date: Fri, 10 Jul 2026 16:45:39 +0200
Message-ID: <l7g2E_cUTtqIHhK0pfFLlQ@monjalon.net>
In-Reply-To: <20260709040739.3184955-3-joshwash@google.com>
References: <20260707164020.2936476-1-joshwash@google.com>
 <20260709040739.3184955-1-joshwash@google.com>
 <20260709040739.3184955-3-joshwash@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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

09/07/2026 06:07, Joshua Washington:
> The GQ TX datapath was set up to write the mbuf head into the sw_ring
> before writing the descriptors. This poses a problem because it's
> possible for the packet to be dropped due to lacking the FIFO space to
> do a proper TX. In such a case, the packet won't be sent, and will lead
> to leaked mbufs in the subsequent segments.
> 
> There is also no real reason that the head mbuf must be set in the
> sw_ring separately from the others; the mbuf chain is not actually
> walked as part of GQ TX.
> 
> Fixes: a46583cf43c8 ("net/gve: support Rx/Tx")
> Cc: stable@dpdk.org
> Signed-off-by: Joshua Washington <joshwash@google.com>
> Reviewed-by: Jasper Tran O'Leary <jtranoleary@google.com>

AI found this issue:

**Error:** Resource leak on early return from `gve_tx_burst_qpl()`.

The patch modifies the loop to store mbufs in `sw_ring` only after checking FIFO availability, but introduces a leak when `goto end_of_tx` is taken after the first segment has been processed. At line 306-307:

```c
if (!is_fifo_avail(txq, hlen)) {
    gve_tx_clean(txq);
    if (!is_fifo_avail(txq, hlen))
        goto end_of_tx;
}
```

If the second `is_fifo_avail()` check fails and we `goto end_of_tx`, the current `tx_pkt` (which is the mbuf chain head) has not been added to `sw_ring` yet (that happens later in the modified loop at lines 346-351). The function will return without freeing `tx_pkt`, and the mbuf chain is lost.

**Suggested fix:** Free the current packet before `goto end_of_tx`:

```c
if (!is_fifo_avail(txq, hlen)) {
    gve_tx_clean(txq);
    if (!is_fifo_avail(txq, hlen)) {
        rte_pktmbuf_free(tx_pkt);
        goto end_of_tx;
    }
}
```

Similarly, for the TSO path at lines 314-316, if the FIFO space check fails, `tx_pkt` should be freed before the goto.



