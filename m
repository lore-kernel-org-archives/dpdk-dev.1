Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E26DCD6E56
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Jun 2026 12:21:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B750C4025F;
	Mon,  1 Jun 2026 14:21:08 +0200 (CEST)
Received: from fout-b3-smtp.messagingengine.com
 (fout-b3-smtp.messagingengine.com [202.12.124.146])
 by mails.dpdk.org (Postfix) with ESMTP id 389BF4025A
 for <dev@dpdk.org>; Mon,  1 Jun 2026 14:21:07 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.stl.internal (Postfix) with ESMTP id F3B371D00338;
 Mon,  1 Jun 2026 08:21:05 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Mon, 01 Jun 2026 08:21:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1780316465;
 x=1780402865; bh=VC2d/aSLziCzzG4xkn7QzzjMBiQAQZ5/FkvUt0wvUy8=; b=
 g9+8E+Gy2pcFYKsdnp1fKkgxJteDVh9J87kAGC0bjXVG4g02NaqVMk08feSGxUpl
 xngvuJTNXVSG+QTFJI/UBWpu1daLIMlGGY11S83qgr3nHO+05Y1+p+ZKEIGB1bV3
 TfVCVd0hzSHt4hz/xtox2ymDx1XRGRaqvLrwkKwV3DgfaJVP5maUCITqb/qavj+z
 1tBChDwii3rV9J+bFSfwRSRhSt5szfy4PC9ONpwIgaoBD6hcArDvNjMamwQ33bra
 HDt4LTAovEHwojxQj6DFMBmLyasn94r1gFeUkVXrl+77xB8vMyCKNfkuXWbn9ghc
 NvQWPeRpWuNEONrNuVAfqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780316465; x=
 1780402865; bh=VC2d/aSLziCzzG4xkn7QzzjMBiQAQZ5/FkvUt0wvUy8=; b=O
 i4nCz3i7MWBZE95OktrVpJRbYZUT7k7wg2FxIVwxU0ynhe1UxN8NcL8jPW1MMUW7
 4sddbY7EFjezr99Jmk3oH6DFvUJcUQM8LVyopBHHR3XluNgE/ydRtR8zclhNleJK
 XafXRk/FD7vqbJ0lAFoOfla8a0u7xPJysnVm91brwCj2VNB5g1LVdTZbKfrvGlqC
 cTa6PkSYYVfTe2lpw5/xEp4zft0a8CO8otIjMnjOvMAz0Umntpe0wGh9i/UXnkzo
 kzsE5S0RD7SGQDYQe+M/m0KR5yp0+mhjzIKhVEXRWl7wK40v2hyA/LaqJv4tn4Ed
 m6ug2BL4WsMiCOWfQSK3A==
X-ME-Sender: <xms:MXkdapx-YCi77BJRx4i4WvXQE4G1SHxXKg9caFuSZVAAmOHKZSRjkg>
 <xme:MXkdatn7PYDac8EN0PwW5BRuL_-njvIfqsSXsVQumonIQgHp4UKpGDrKsbMuP4YRp
 ts3SVmZTfKhe5sgdwlFHeALFKsELU0JwwhzewuWX6eDetCC9TDW9g>
X-ME-Received: <xmr:MXkdaifkSYDQOcAqRKD1f8f1V_sEiNiMg0nJlkHtaB9tJyuNLmBU8zCMvwgsrz9bsD2GRPl5SJxUws1KiLEdwqh_4g>
X-ME-Proxy-Cause: dmFkZTFMoBfQdlQCQHwwMIFZBvDIzgxCvR4f60JK/SEelt8OeQmLPQti2tdbc6seK67pNw
 a2Q5s2qxRKC1gfJNVccBYo1yVSuk2FzjgJZPQ587jzX1Qh1/2liwzKichqysL4WYO757WM
 geQd4UAnyX6WljbX4B8ger2+QCL1wRvHGcYeZwVzIieDQz6xBfMY99EyvM9hPODNXOuCjg
 LRCwKzFjvy6HaNQWVKU2zZ/FevBietccvNG+jj4poT3lcUdCA0IJmwyG6yGofjzMfBKRg/
 7NXLTJ4nYNzVZJPkHR4XAMXyYXvwnqGq7TgSgpGSgNtbZyPdTyVTw/ovKPphyvSWun2Lfb
 xm7B/2Fe1MJtfCfCiPt9obXfD9h/lcULRV9L2ASSrsic7lAqFquM6Mj05j06tbKum5nucR
 EiKSSXvyCtDkilM6X+QruYUVFH955Q3maz3Dnm7N+kEMyFjZpt8PIlDsiOl4PH24rd6jQi
 m4eZCPAVwEoWsw/TOTqYT9zb2uih/KI/5kS/snrl4jw5IPPA+W7kokI4bifXreOW6nmHiS
 R7ZQfrGDK5lVv2SR3KCx6Xzelqohe193blEn8H3YMxqiqzqyxqBv6aow6jQdK6xC2EPj2p
 UyDc4MbGRZ+vSonHPaSc+SLBwH0thgFSY0Mc3lqRPyuB1q3BbIVDHxGEStHw
X-ME-Proxy: <xmx:MXkdajomN9rQbXopo4Vsd3x3w0WOyDPUcUk2I6BfJOqT78oelRApxQ>
 <xmx:MXkdag5ryTNZKG1dLuLDwcipDMzdhEKMENrABf7sOY127f7GoNMLdw>
 <xmx:MXkdapqso8ApWRXo1ROUHO1vvrNJxT8w2sfizYv2AMptWMm6juf-SQ>
 <xmx:MXkdaihVHCeVqOo5cZKhtLb4N-vAZlQqrqIdnZunFqNeYis2nATBgg>
 <xmx:MXkdavSQXx-XGHtON0eC3Si8QTtrz1ifJaESlWiXxtKtyYgFbs6EQnNo>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 08:21:05 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, Jianfeng Tan <jianfeng.tan@intel.com>
Subject: Re: [PATCH v2 2/5] eal: fix async IPC callback not fired when no peers
Date: Mon, 01 Jun 2026 14:21:03 +0200
Message-ID: <n2qqs3VCRg2oTV_S-0kNSw@monjalon.net>
In-Reply-To: <1ad014dd239fa1e8ea62aab7e56a7bf7264c04ff.1780068382.git.anatoly.burakov@intel.com>
References: <1ad014dd239fa1e8ea62aab7e56a7bf7264c04ff.1780068382.git.anatoly.burakov@intel.com>
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

29/05/2026 17:26, Anatoly Burakov:
> Currently, when rte_mp_request_async() is called and no peer processes
> are connected (nb_sent == 0), the user callback is never invoked.
> 
> The original implementation used a dedicated background thread and
> pthread_cond_signal() to wake it after queuing the dummy request. When
> that thread was replaced with per-message alarms, no alarm was set for
> the dummy request, silently breaking the nb_sent == 0 path.
> 
> This was not noticed because async requests are used while handling
> secondary process requests, where peers are typically already present.
> 
> Fix it by setting a 1us alarm on the dummy request, so the callback path
> immediately triggers and processes it.
> 
> Fixes: daf9bfca717e ("ipc: remove thread for async requests")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>  lib/eal/common/eal_common_proc.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/eal/common/eal_common_proc.c b/lib/eal/common/eal_common_proc.c
> index 799c6e81b0..0ec79336a5 100644
> --- a/lib/eal/common/eal_common_proc.c
> +++ b/lib/eal/common/eal_common_proc.c
> @@ -1187,11 +1187,15 @@ rte_mp_request_async(struct rte_mp_msg *req, const struct timespec *ts,
>  	if (rte_eal_process_type() == RTE_PROC_SECONDARY) {
>  		ret = mp_request_async(eal_mp_socket_path(), copy, param, ts);
>  
> -		/* if we didn't send anything, put dummy request on the queue */
> +		/* if we didn't send anything, put dummy request on the queue
> +		 * and set a minimum-delay alarm so the callback fires immediately.
> +		 */
>  		if (ret == 0 && reply->nb_sent == 0) {
>  			TAILQ_INSERT_TAIL(&pending_requests.requests, dummy,
>  					next);
>  			dummy_used = true;
> +			if (rte_eal_alarm_set(1, async_reply_handle, dummy) < 0)
> +				EAL_LOG(ERR, "Fail to set alarm for dummy request");

Shouldn't we return an error?


